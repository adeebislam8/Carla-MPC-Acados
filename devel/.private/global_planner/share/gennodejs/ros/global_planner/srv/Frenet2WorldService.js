// Auto-generated. Do not edit!

// (in-package global_planner.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let FrenetPose = require('../msg/FrenetPose.js');

//-----------------------------------------------------------

let WorldPose = require('../msg/WorldPose.js');

//-----------------------------------------------------------

class Frenet2WorldServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.frenet_pose = null;
    }
    else {
      if (initObj.hasOwnProperty('frenet_pose')) {
        this.frenet_pose = initObj.frenet_pose
      }
      else {
        this.frenet_pose = new FrenetPose();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Frenet2WorldServiceRequest
    // Serialize message field [frenet_pose]
    bufferOffset = FrenetPose.serialize(obj.frenet_pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Frenet2WorldServiceRequest
    let len;
    let data = new Frenet2WorldServiceRequest(null);
    // Deserialize message field [frenet_pose]
    data.frenet_pose = FrenetPose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 56;
  }

  static datatype() {
    // Returns string type for a service object
    return 'global_planner/Frenet2WorldServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '22a20e11335e0f0eaca685a045ac2b3b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    FrenetPose frenet_pose
    
    ================================================================================
    MSG: global_planner/FrenetPose
    float64 s
    float64 s_dot
    float64 s_ddot
    float64 d
    float64 d_dot
    float64 d_ddot
    float64 yaw_s
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Frenet2WorldServiceRequest(null);
    if (msg.frenet_pose !== undefined) {
      resolved.frenet_pose = FrenetPose.Resolve(msg.frenet_pose)
    }
    else {
      resolved.frenet_pose = new FrenetPose()
    }

    return resolved;
    }
};

class Frenet2WorldServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.world_pose = null;
    }
    else {
      if (initObj.hasOwnProperty('world_pose')) {
        this.world_pose = initObj.world_pose
      }
      else {
        this.world_pose = new WorldPose();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Frenet2WorldServiceResponse
    // Serialize message field [world_pose]
    bufferOffset = WorldPose.serialize(obj.world_pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Frenet2WorldServiceResponse
    let len;
    let data = new Frenet2WorldServiceResponse(null);
    // Deserialize message field [world_pose]
    data.world_pose = WorldPose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'global_planner/Frenet2WorldServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a89febe28dc7b8596bb180ba9404e6a5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    WorldPose world_pose
    
    ================================================================================
    MSG: global_planner/WorldPose
    float64 x
    float64 y
    float64 yaw
    float64 v
    float64 acc
    float64 target_v
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Frenet2WorldServiceResponse(null);
    if (msg.world_pose !== undefined) {
      resolved.world_pose = WorldPose.Resolve(msg.world_pose)
    }
    else {
      resolved.world_pose = new WorldPose()
    }

    return resolved;
    }
};

module.exports = {
  Request: Frenet2WorldServiceRequest,
  Response: Frenet2WorldServiceResponse,
  md5sum() { return '7c3d04499a34679df3b3eaae1ccad4b8'; },
  datatype() { return 'global_planner/Frenet2WorldService'; }
};
