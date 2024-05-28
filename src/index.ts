import * as ff from '@google-cloud/functions-framework';
import escapeHtml from 'escape-html'
import 'dotenv/config'

ff.http('main', (req: ff.Request, res: ff.Response) => {
  res.send(`Hello ${escapeHtml(req.query.name || req.body.name || 'World')}! - This is secret: ${process.env.SOME_SECRET}\n`);
});
