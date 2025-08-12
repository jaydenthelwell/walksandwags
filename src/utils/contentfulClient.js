import { createClient } from 'contentful';

const client = createClient({
  space: 'qvwo3s6zz3y2',
  accessToken: 'gf2Pskk-4gfnzt2T54F1LZSwD52uLnckrm1IrMcHXfM', // Move to an environment variable in production
});

export default client;
