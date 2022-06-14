import {
  NativeModules,
  Platform,
  requireNativeComponent,
  UIManager,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-snap-camera' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

export interface SnapCameraProps {
  style: ViewStyle;
}

const ComponentName = 'CameraView';
const { SnapCameraManager: CameraManager } = NativeModules;

export const SnapCameraView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<SnapCameraProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };

export interface Lense {
  templateCode?: string;
  lensUUID?: string;
  lensId?: string;
}

export interface SnapCameraManagerProps {
  getLenses: (cb: (lenses: Lense[]) => void) => void;
  applyLens: (
    lensId: string,
    base64: string,
    height: number,
    width: number,
    recordingEnabled: boolean,
    watermarkAlpha: number,
    watermarkBase64: string,
    watermarkHeight: number,
    watermarkWidth: number,
    watermarkTop: number,
    watermarkRight: number,
    watermarkBottom: number,
    watermarkLeft: number
  ) => void;
  startRecording: () => void;
  finishRecording: (cb: (path: string) => void) => void;
  takePhoto: (cb: (path: string) => void) => void;
}

export const SnapCameraManager: SnapCameraManagerProps = CameraManager;
