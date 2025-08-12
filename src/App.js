// src/App.js
import React, { useEffect, useState } from 'react';
import client from './utils/contentfulClient'; // Import your client
import RichTextRenderer from './components/RichTextRenderer'; // Import the rich text renderer
import Hello from './components/Hello';

// Custom hook for fetching content from Contentful
const useContentfulData = (entryId) => {
  const [data, setData] = useState(null);

  useEffect(() => {
    const fetchContent = async () => {
      try {
        const entry = await client.getEntry(entryId);
        setData(entry.fields.richTextField); // Replace with your actual field name
      } catch (error) {
        console.error('Error fetching content:', error);
      }
    };

    fetchContent();
  }, [entryId]); // Fetch only when entryId changes

  return data;
};

const App = () => {
  const entryId = 'your-entry-id'; // Replace with actual entry ID from Contentful
  const richTextDocument = useContentfulData(entryId);

  return (
    <div>
      <Hello name="React" />
      {richTextDocument && <RichTextRenderer richTextDocument={richTextDocument} />}
    </div>
  );
};

export default App;
