import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-snap-camera' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type SnapCameraProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'SnapCameraView';

export const SnapCameraView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<SnapCameraProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
