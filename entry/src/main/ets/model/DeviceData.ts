interface Shadow {
  service_id: string;
  desired: {
    properties: null;
    event_time: null;
  };
  reported: {
    properties: {
      illumination: string;
      temperature: string;
      humidity: string;
      motorStatus: string;
      lightStatus: string;
      autoStatus: string;
    };
    event_time: string;
  };
  version: number;
}

interface DeviceResponse {
  device_id: string;
  shadow: Shadow[];
}
interface ApiData{
  data:DeviceResponse
}

export  default ApiData
