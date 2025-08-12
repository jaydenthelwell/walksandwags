import React, { useEffect } from 'react';
import { documentToReactComponents } from '@contentful/rich-text-react-renderer';

const RichTextRenderer = ({ richTextDocument }) => {
  if (!richTextDocument) return null;

  const options = {
    renderNode: {
      'embedded-asset-block': (node) => {
        const { file, title } = node.data.target.fields;
        return <img src={file.url} alt={title} />;
      },
      'heading-1': (node, children) => <h1>{children}</h1>,
      'heading-2': (node, children) => <h2>{children}</h2>,
    },
  };

  useEffect(() => {
    console.log('RichTextRenderer mounted', richTextDocument);
  }, [richTextDocument]); // Only re-run if `richTextDocument` changes.

  return <div>{documentToReactComponents(richTextDocument, options)}</div>;
};

export default RichTextRenderer;
