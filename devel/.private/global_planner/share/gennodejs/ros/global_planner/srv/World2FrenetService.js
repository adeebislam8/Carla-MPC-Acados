// Auto-generated. Do not edit!

// (in-package global_planner.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let WorldPose = require('../msg/WorldPose.js');

//-----------------------------------------------------------

let FrenetPose = require('../msg/FrenetPose.js');

//-----------------------------------------------------------

class World2FrenetServiceRequest {
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
    // Serializes a message object of type World2FrenetServiceRequest
    // Serialize message field [world_pose]
    bufferOffset = WorldPose.serialize(obj.world_pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type World2FrenetServiceRequest
    let len;
    let data = new World2FrenetServiceRequest(null);
    // Deserialize message field [world_pose]
    data.world_pose = WorldPose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'global_planner/World2FrenetServiceRequest';
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
    const resolved = new World2FrenetServiceRequest(null);
    if (msg.world_pose !== undefined) {
      resolved.world_pose = WorldPose.Resolve(msg.world_pose)
    }
    else {
      resolved.world_pose = new WorldPose()
    }

    return resolved;
    }
};

class World2FrenetServiceResponse {
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
    // Serializes a message object of type World2FrenetServiceResponse
    // Serialize message field [frenet_pose]
    bufferOffset = FrenetPose.serialize(obj.frenet_pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type World2FrenetServiceResponse
    let len;
    let data = new World2FrenetServiceResponse(null);
    // Deserialize message field [frenet_pose]
    data.frenet_pose = FrenetPose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 56;
  }

  static datatype() {
    // Returns string type for a service object
    return 'global_planner/World2FrenetServiceResponse';
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
    const resolved = new World2FrenetServiceResponse(null);
    if (msg.frenet_pose !== undefined) {
      resolved.frenet_pose = FrenetPose.Resolve(msg.frenet_pose)
    }
    else {
      resolved.frenet_pose = new FrenetPose()
    }

    return resolved;
    }
};

module.exports = {
  Request: World2FrenetServiceRequest,
  Response: World2FrenetServiceResponse,
  md5sum() { return '530f2b7503e3482b362b155805927d68'; },
  datatype() { return 'global_planner/World2FrenetService'; }
};
