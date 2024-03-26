# Frenet-Cartesian Converter
import numpy as np
from scipy.interpolate import CubicSpline
from scipy.spatial.distance import cdist

"""
waypoints: list of (x, y) coordinates of the path
"""
class FrenetCartesianConverter:
    def __init__(self, waypoints):
        self.x_spline = None
        self.y_spline = None
        self._fit_cubic_spline(waypoints)

    def get_frenet(self, cartesian_pose):
        """
        INPUT:
        cartesian_pose: [x(m), y(m), yaw(rad)]
        RETURNS:
        frenet_pose: [s(m), d(m), alpha(rad)]
        """
        x, y, yaw = cartesian_pose
        
        # Find closest point along the path
        num_points = 1000  # Number of points to sample along the path for finding the closest point
        s_vals = np.linspace(0, self.x_spline.x[-1], num_points)
        path_points = np.column_stack((self.x_spline(s_vals), self.y_spline(s_vals)))
        distances = cdist(path_points, [[x, y]])
        closest_index = np.argmin(distances)
        closest_point = path_points[closest_index]
        closest_s = s_vals[closest_index]
        
        # Calculate the d coordinate (perpendicular distance to the path)
        d = np.linalg.norm([x - closest_point[0], y - closest_point[1]])
        
        # Determine the sign of d (left or right of the path)
        path_dx = self.x_spline.derivative()(closest_s)
        path_dy = self.y_spline.derivative()(closest_s)
        normal = np.array([-path_dy, path_dx])
        point_vector = np.array([x - closest_point[0], y - closest_point[1]])
        d *= np.sign(np.dot(point_vector, normal))  # Adjust sign based on the side of the path
        
        # Calculate the alpha coordinate (angle difference)
        alpha = self._get_frenet_orientation(closest_s, yaw)
        
        return [closest_s, d, alpha]
    
    def get_cartesian(self, frenet_pose):
        """
        INPUT:
        frenet_pose: [s(m), d(m), alpha(rad)]
        RETURNS:
        cartesian_pose: [x(m), y(m), yaw(rad)]
        """
        s, d, alpha = frenet_pose
        
        # Calculate the Cartesian position of the point on the path corresponding to Frenet s
        x_path = self.x_spline(s)
        y_path = self.y_spline(s)
        
        # Get the path's direction (tangent) at that point
        dx = self.x_spline.derivative()(s)
        dy = self.y_spline.derivative()(s)
        path_yaw = np.arctan2(dy, dx)
        
        # Calculate the perpendicular direction (normal to the path)
        norm_direction = np.array([-dy, dx]) / np.sqrt(dx**2 + dy**2)
        
        # Calculate the Cartesian position offset by Frenet d
        x = x_path + d * norm_direction[0]
        y = y_path + d * norm_direction[1]
        
        # Convert Frenet orientation (alpha) to Cartesian yaw
        # Alpha is the angle between the vehicle direction and the path tangent
        # In Cartesian, yaw = path's direction (path_yaw) + alpha
        yaw = path_yaw + alpha
        
        return [x, y, yaw]

    def _get_frenet_orientation(self, s, yaw):
        dx = self.x_spline.derivative()
        dy = self.y_spline.derivative()
        path_angle = np.arctan2(dy(s), dx(s))
        alpha = yaw - path_angle
        return alpha
    
    
    def _fit_cubic_spline(self, waypoints):
        # sparsify the waypoints
        waypoints = waypoints[::5]
        x = [point[0] for point in waypoints]
        y = [point[1] for point in waypoints]
        # print("x:", x)
        # print("y:", y)
        dx = np.diff(x)
        dy = np.diff(y)
        s = np.zeros(len(x))
        s[1:] = np.cumsum(np.sqrt(dx**2+dy**2))
        self.x_spline = CubicSpline(s, x)
        self.y_spline = CubicSpline(s, y)
    
    # #converting a list of x,y waypoints to s-d cordiantes
    # def _get_s_d_cordinates(waypoints):
    #     x = [point[0] for point in waypoints]
    #     y = [point[1] for point in waypoints]
    #     dx = np.diff(x)
    #     dy = np.diff(y)
    #     s = np.zeros(len(x))
    #     s[1:] = np.cumsum(np.sqrt(dx**2+dy**2))
    #     print(s)
    #     return s, x, y



if __name__ == "__main__":
    x = [0, 0, 0, 0, 0, 0, 19, 29, 38, 9, 1, -39, 3, 0, 50]
    y = [0, 10, 20, 30, 40, 50, 50, 50, 50, 50, 50, 50, 50, 10, 19]
    waypoints = list(zip(x, y))
    f2c = FrenetCartesianConverter(waypoints)
    cartesian_pose = [-46, 50, 0]
    frenet_pose = f2c.get_frenet(cartesian_pose)
    print("Frenet pose:", frenet_pose)
    cartesian_pose = f2c.get_cartesian(frenet_pose)
    print("Cartesian pose:", cartesian_pose)





