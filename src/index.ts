import * as ff from '@google-cloud/functions-framework';
import escapeHtml from 'escape-html'
import 'dotenv/config'

interface Body {
  title: string
  secret: string
  fromQuery?: string
}

ff.http('main', (req: ff.Request, res: ff.Response) => {
  res.setHeader('Content-Type', 'application/json');

  const body: Body = {
    title: 'This is a hardcoded content for boilerplate purpose',
    secret: `${process.env.SOME_SECRET}`,
  }

  const fromQuery = req.query.name || req.body.name
  if(fromQuery) {
    body.fromQuery = escapeHtml(fromQuery)
  }

  res.send(JSON.stringify(body))
});
