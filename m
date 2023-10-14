Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6237C94DA
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 16:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrfbA-0003on-TR; Sat, 14 Oct 2023 10:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qrfb9-0003oW-GC
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 10:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qrfb7-00034p-8c
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 10:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697293591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ecCvWWxu97PV+5/7yCR07QgHTDriTUu1ZiuvbahrqG4=;
 b=KC7q8o4ngF8vvkbdwxbDTAQYqoHOh0HgpC+Yc3okgFSta4cAkk1lCEGajH/7sSiNYkTcGe
 mBFDdUQp2PRomb7hjsElNRePai3RwDy8xW4EfvWTjsknufG1dffAUoAJFl0pIUW5DkNjUW
 sOUXGvtIXJZ6bAiuO5lMUtvHc4bsufw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-sQSf-n72MROJLS-udhgMLA-1; Sat, 14 Oct 2023 10:26:29 -0400
X-MC-Unique: sQSf-n72MROJLS-udhgMLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EE9C3C025C7
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 14:26:29 +0000 (UTC)
Received: from localhost (unknown [10.45.224.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CF16C15BB8;
 Sat, 14 Oct 2023 14:26:27 +0000 (UTC)
Date: Sat, 14 Oct 2023 16:26:26 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 7/9] qapi: golang: Generate qapi's command types in Go
Message-ID: <fflixikrtdmqgp6npwyedlp6ianmfbfl6b25zfdnbascoa3aup@muwpnxnfv4as>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-8-victortoso@redhat.com>
 <ZRWOlrwq5tS3oh9W@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hnn33otz6ymzf3cj"
Content-Disposition: inline
In-Reply-To: <ZRWOlrwq5tS3oh9W@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


--hnn33otz6ymzf3cj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 03:32:54PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:42PM +0200, Victor Toso wrote:
> > This patch handles QAPI command types and generates data structures in
> > Go that decodes from QMP JSON Object to Go data structure and vice
> > versa.
> >=20
> > Similar to Event, this patch adds a Command interface and two helper
> > functions MarshalCommand and UnmarshalCommand.
> >=20
> > Example:
> > qapi:
> >  | { 'command': 'set_password',
> >  |   'boxed': true,
> >  |   'data': 'SetPasswordOptions' }
> >=20
> > go:
> >  | type SetPasswordCommand struct {
> >  |     SetPasswordOptions
> >  |     CommandId string `json:"-"`
>=20
> IIUC, you renamed that to MessageId in the code now.
>=20
> >  | }
>=20
> Overall, I'm not entirely convinced that we will want to
> have the SetPasswordCommand struct wrappers, byut it is
> hard to say,

I was playing with removing these embed structs now, similar to
how we did for all other base types. The extra complexity might
not be worthy to remove it, IMHO.

Actually, the SetPasswordCommand can be used as example.

No embed (proposed):
  type SetPasswordCommand struct {
      CommandId string `json:"-"`

      Password  string             `json:"password"`
      Connected *SetPasswordAction `json:"connected,omitempty"`

      Protocol  DisplayProtocol    `json:"protocol"`
      Password  string             `json:"password"`
      Connected *SetPasswordAction `json:"connected,omitempty"`

      // Variants fields
      Vnc *SetPasswordOptionsVnc `json:"-"`

      // Unbranched enum fields
      Spice bool `json:"-"`
  }

As SetPasswordOptions is a union, now we have to treat
SetPasswordCommand as union too, for Marshal/Unmarshal.

The data type could also be an Alternate, which has different
logic for Marshal/Unmarshal.

So, doing embed would add quite a bit of complexity to handling
Commands and Events too although no Event use boxed=3Dtrue at the
moment in QEMU.

> as what we're missing still is the eventual application facing
> API.
>=20
> eg something that ultimately looks more like this:
>=20
>     qemu =3D qemu.QMPConnection()
>     qemu.Dial("/path/to/unix/socket.sock")
>=20
>     qemu.VncConnectedEvent(func(ev *VncConnectedEvent) {
>          fmt.Printf("VNC client %s connected\n", ev.Client.Host)
>     })
>=20
>     resp, err :=3D qemu.SetPassword(SetPasswordArguments{
>         protocol: "vnc",
>         password: "123456",
>     })
>=20
>     if err !=3D nil {
>         fmt.Fprintf(os.Stderr, "Cannot set passwd: %s", err)
>     }
>=20
>     ..do something wit resp....   (well SetPassword has no response, but =
other cmmands do)
>=20
> It isn't clear that the SetPasswordCommand struct will be
> needed internally for the impl if QMPCommand.

Yes. Let's get this in so we can work on the next layer. We don't
need to declare this Go module as stable for now, till we get the
next few bits figure out.

Cheers,
Victor
=20
> > usage:
> >  | input :=3D `{"execute":"set_password",` +
> >  |          `"arguments":{"protocol":"vnc",` +
> >  |          `"password":"secret"}}`
> >  |
> >  | c, err :=3D UnmarshalCommand([]byte(input))
> >  | if err !=3D nil {
> >  |     panic(err)
> >  | }
> >  |
> >  | if c.GetName() =3D=3D `set_password` {
> >  |         m :=3D c.(*SetPasswordCommand)
> >  |         // m.Password =3D=3D "secret"
> >  | }
> >=20
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 97 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 94 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > index ff3b1dd020..52a9124641 100644
> > --- a/scripts/qapi/golang.py
> > +++ b/scripts/qapi/golang.py
> > @@ -246,6 +246,51 @@
> >  }}
> >  '''
> > =20
> > +TEMPLATE_COMMAND_METHODS =3D '''
> > +func (c *{type_name}) GetName() string {{
> > +    return "{name}"
> > +}}
> > +
> > +func (s *{type_name}) GetId() string {{
> > +    return s.MessageId
> > +}}
> > +'''
> > +
> > +TEMPLATE_COMMAND =3D '''
> > +type Command interface {{
> > +    GetId()         string
> > +    GetName()       string
> > +}}
> > +
> > +func MarshalCommand(c Command) ([]byte, error) {{
> > +    m :=3D make(map[string]any)
> > +    m["execute"] =3D c.GetName()
> > +    if id :=3D c.GetId(); len(id) > 0 {{
> > +        m["id"] =3D id
> > +    }}
> > +    if bytes, err :=3D json.Marshal(c); err !=3D nil {{
> > +        return []byte{{}}, err
> > +    }} else if len(bytes) > 2 {{
> > +        m["arguments"] =3D c
> > +    }}
> > +    return json.Marshal(m)
> > +}}
> > +
> > +func UnmarshalCommand(data []byte) (Command, error) {{
> > +    base :=3D struct {{
> > +        MessageId string `json:"id,omitempty"`
> > +        Name      string `json:"execute"`
> > +    }}{{}}
> > +    if err :=3D json.Unmarshal(data, &base); err !=3D nil {{
> > +        return nil, fmt.Errorf("Failed to decode command: %s", string(=
data))
> > +    }}
> > +
> > +    switch base.Name {{
> > +    {cases}
> > +    }}
> > +    return nil, errors.New("Failed to recognize command")
> > +}}
> > +'''
> > =20
> >  def gen_golang(schema: QAPISchema,
> >                 output_dir: str,
> > @@ -282,7 +327,7 @@ def qapi_to_go_type_name(name: str,
> > =20
> >      name +=3D ''.join(word.title() for word in words[1:])
> > =20
> > -    types =3D ["event"]
> > +    types =3D ["event", "command"]
> >      if meta in types:
> >          name =3D name[:-3] if name.endswith("Arg") else name
> >          name +=3D meta.title().replace(" ", "")
> > @@ -521,6 +566,8 @@ def qapi_to_golang_struct(self: QAPISchemaGenGolang=
Visitor,
> >      fields, with_nullable =3D recursive_base(self, base)
> >      if info.defn_meta =3D=3D "event":
> >          fields +=3D f'''\tMessageTimestamp Timestamp `json:"-"`\n{fiel=
ds}'''
> > +    elif info.defn_meta =3D=3D "command":
> > +        fields +=3D f'''\tMessageId string `json:"-"`\n{fields}'''
> > =20
> >      if members:
> >          for member in members:
> > @@ -719,16 +766,36 @@ def generate_template_event(events: dict[str, str=
]) -> str:
> >  '''
> >      return TEMPLATE_EVENT.format(cases=3Dcases)
> > =20
> > +def generate_template_command(commands: dict[str, str]) -> str:
> > +    cases =3D ""
> > +    for name in sorted(commands):
> > +        case_type =3D commands[name]
> > +        cases +=3D f'''
> > +case "{name}":
> > +    command :=3D struct {{
> > +        Args {case_type} `json:"arguments"`
> > +    }}{{}}
> > +
> > +    if err :=3D json.Unmarshal(data, &command); err !=3D nil {{
> > +        return nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
> > +    }}
> > +    command.Args.MessageId =3D base.MessageId
> > +    return &command.Args, nil
> > +'''
> > +    content =3D TEMPLATE_COMMAND.format(cases=3Dcases)
> > +    return content
> > +
> > =20
> >  class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> > =20
> >      def __init__(self, _: str):
> >          super().__init__()
> > -        types =3D ["alternate", "enum", "event", "helper", "struct", "=
union"]
> > +        types =3D ["alternate", "command", "enum", "event", "helper", =
"struct", "union"]
> >          self.target =3D {name: "" for name in types}
> >          self.objects_seen =3D {}
> >          self.schema =3D None
> >          self.events =3D {}
> > +        self.commands =3D {}
> >          self.golang_package_name =3D "qapi"
> >          self.accept_null_types =3D []
> > =20
> > @@ -756,6 +823,7 @@ def visit_begin(self, schema):
> >      def visit_end(self):
> >          self.schema =3D None
> >          self.target["event"] +=3D generate_template_event(self.events)
> > +        self.target["command"] +=3D generate_template_command(self.com=
mands)
> > =20
> >      def visit_object_type(self: QAPISchemaGenGolangVisitor,
> >                            name: str,
> > @@ -853,7 +921,30 @@ def visit_command(self,
> >                        allow_oob: bool,
> >                        allow_preconfig: bool,
> >                        coroutine: bool) -> None:
> > -        pass
> > +        assert name =3D=3D info.defn_name
> > +
> > +        type_name =3D qapi_to_go_type_name(name, info.defn_meta)
> > +        self.commands[name] =3D type_name
> > +
> > +        content =3D ""
> > +        if boxed or not arg_type or not qapi_name_is_object(arg_type.n=
ame):
> > +            args =3D "" if not arg_type else "\n" + arg_type.name
> > +            args +=3D '''\n\tMessageId   string `json:"-"`'''
> > +            content =3D generate_struct_type(type_name, args)
> > +        else:
> > +            assert isinstance(arg_type, QAPISchemaObjectType)
> > +            content =3D qapi_to_golang_struct(self,
> > +                                            name,
> > +                                            arg_type.info,
> > +                                            arg_type.ifcond,
> > +                                            arg_type.features,
> > +                                            arg_type.base,
> > +                                            arg_type.members,
> > +                                            arg_type.variants)
> > +
> > +        content +=3D TEMPLATE_COMMAND_METHODS.format(name=3Dname,
> > +                                                   type_name=3Dtype_na=
me)
> > +        self.target["command"] +=3D content
> > =20
> >      def visit_event(self, name, info, ifcond, features, arg_type, boxe=
d):
> >          assert name =3D=3D info.defn_name
> > --=20
> > 2.41.0
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--hnn33otz6ymzf3cj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUqpRIACgkQl9kSPeN6
SE9FqBAAwNXx3bQfwZel/w3O3ZOwpPJUKSAWaAQhG6xBOZcC7mLXT0neA25z92Ko
NvHXe1uzAUMIJ7GZ0w6Lw6lSNlPfI0MoOCQny0GHeJ6U3RCCHramcnn52RrUL2FU
g2V7ZZkYYJrGrfEohB3J7g/04TgeZybqT+wCgcMr9QhqHVZmpLr76pMKNioRU+P2
VMiWi4bj+QPu63SBJu1gdlGiUh2Wv+X8IVU8lUCfQs7G5CRvhW4COwQc0da76TS+
2T7ou0ZnzsuZ0KxPutFGjHG7Nr1j6lCDQSb+QiSoC20YDopMkc3WwKBN6QtedpUM
/H7y4PYHpftHLvpNgaB3zvc8QphJQWH1iLIgqlcoXPbaNTk3N7Ro6BFzAjUn/puU
Vc8sVGSMHfciA4KhnEOXSwQhXqqKYyIKaBhsUr+c4KC1jKJ8O3Y1wjM81zBtUCon
f4egzEaFsjMfbCjSfWbuFoXiotjpk28R9a4d0SHb8Hr0YGCmOdaA+2LI1BKUIKIa
9i6X5izKSCoUqqPcQ4ktXCVG3C7sd8wblqzZsFWZfj03jK44ouetcqWldEkoz8Cs
h1OB9vgx0f72WSJuAM+drKvUCM0XB9sHIOgU9J+yEBYMibV0EmU68VDcU0525/PO
3nwuJ4gCb5NhLXvPL0Y7uMBZkwVYxFh9SHto+2iT6XZDYGj0TDc=
=4/BD
-----END PGP SIGNATURE-----

--hnn33otz6ymzf3cj--


