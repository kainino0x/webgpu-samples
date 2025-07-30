export default {
  name: 'Compressed Texture Format Explorer',
  description: 'Allows exploring the components of compressed texture formats to understand how decompression works.',
  filename: __DIRNAME__,
  sources: [
    { path: 'main.ts' },
    { path: '../../shaders/fullScreenTexturedQuad.wgsl' },
  ],
};
