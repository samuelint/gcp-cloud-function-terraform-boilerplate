import * as ff from '@google-cloud/functions-framework';
import escapeHtml from 'escape-html'

ff.http('main', (req: ff.Request, res: ff.Response) => {
  res.send(`Hello ${escapeHtml(req.query.name || req.body.name || 'World')}!`);
});
