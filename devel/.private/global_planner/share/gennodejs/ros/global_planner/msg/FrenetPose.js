// Auto-generated. Do not edit!

// (in-package global_planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class FrenetPose {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.s = null;
      this.s_dot = null;
      this.s_ddot = null;
      this.d = null;
      this.d_dot = null;
      this.d_ddot = null;
      this.yaw_s = null;
    }
    else {
      if (initObj.hasOwnProperty('s')) {
        this.s = initObj.s
      }
      else {
        this.s = 0.0;
      }
      if (initObj.hasOwnProperty('s_dot')) {
        this.s_dot = initObj.s_dot
      }
      else {
        this.s_dot = 0.0;
      }
      if (initObj.hasOwnProperty('s_ddot')) {
        this.s_ddot = initObj.s_ddot
      }
      else {
        this.s_ddot = 0.0;
      }
      if (initObj.hasOwnProperty('d')) {
        this.d = initObj.d
      }
      else {
        this.d = 0.0;
      }
      if (initObj.hasOwnProperty('d_dot')) {
        this.d_dot = initObj.d_dot
      }
      else {
        this.d_dot = 0.0;
      }
      if (initObj.hasOwnProperty('d_ddot')) {
        this.d_ddot = initObj.d_ddot
      }
      else {
        this.d_ddot = 0.0;
      }
      if (initObj.hasOwnProperty('yaw_s')) {
        this.yaw_s = initObj.yaw_s
      }
      else {
        this.yaw_s = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FrenetPose
    // Serialize message field [s]
    bufferOffset = _serializer.float64(obj.s, buffer, bufferOffset);
    // Serialize message field [s_dot]
    bufferOffset = _serializer.float64(obj.s_dot, buffer, bufferOffset);
    // Serialize message field [s_ddot]
    bufferOffset = _serializer.float64(obj.s_ddot, buffer, bufferOffset);
    // Serialize message field [d]
    bufferOffset = _serializer.float64(obj.d, buffer, bufferOffset);
    // Serialize message field [d_dot]
    bufferOffset = _serializer.float64(obj.d_dot, buffer, bufferOffset);
    // Serialize message field [d_ddot]
    bufferOffset = _serializer.float64(obj.d_ddot, buffer, bufferOffset);
    // Serialize message field [yaw_s]
    bufferOffset = _serializer.float64(obj.yaw_s, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FrenetPose
    let len;
    let data = new FrenetPose(null);
    // Deserialize message field [s]
    data.s = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [s_dot]
    data.s_dot = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [s_ddot]
    data.s_ddot = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [d]
    data.d = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [d_dot]
    data.d_dot = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [d_ddot]
    data.d_ddot = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [yaw_s]
    data.yaw_s = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 56;
  }

  static datatype() {
    // Returns string type for a message object
    return 'global_planner/FrenetPose';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '57d70fe50479087b497ed2a9bcbc0f43';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new FrenetPose(null);
    if (msg.s !== undefined) {
      resolved.s = msg.s;
    }
    else {
      resolved.s = 0.0
    }

    if (msg.s_dot !== undefined) {
      resolved.s_dot = msg.s_dot;
    }
    else {
      resolved.s_dot = 0.0
    }

    if (msg.s_ddot !== undefined) {
      resolved.s_ddot = msg.s_ddot;
    }
    else {
      resolved.s_ddot = 0.0
    }

    if (msg.d !== undefined) {
      resolved.d = msg.d;
    }
    else {
      resolved.d = 0.0
    }

    if (msg.d_dot !== undefined) {
      resolved.d_dot = msg.d_dot;
    }
    else {
      resolved.d_dot = 0.0
    }

    if (msg.d_ddot !== undefined) {
      resolved.d_ddot = msg.d_ddot;
    }
    else {
      resolved.d_ddot = 0.0
    }

    if (msg.yaw_s !== undefined) {
      resolved.yaw_s = msg.yaw_s;
    }
    else {
      resolved.yaw_s = 0.0
    }

    return resolved;
    }
};

module.exports = FrenetPose;
