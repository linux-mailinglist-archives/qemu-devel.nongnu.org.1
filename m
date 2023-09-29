Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3FE7B3402
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDwT-0004bI-0Z; Fri, 29 Sep 2023 09:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDwG-0004ZN-Va
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmDwE-0005ei-Fd
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695995629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNa7Lh7PNQefaJeNBIfJaDrjs+9B58pXn18dk1InXME=;
 b=ZKdjstJiCiUQGL8UX58jwOjaKHdqLU0jAFklIa0VrZI7B5I0/lDL6DuiZhfPUgbJfChWvZ
 WqjHsHWupRO5MGvh+lpKdGtkvOlzZ/i1xM9TxSGToA0qCz+pPIxefUTTjJxgFcmpnfAsTW
 McnB+OlaS/nfdMY/Smpk6ZHPG3SqIcE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-ilr6DqNiMJuTS6zf5Bbicw-1; Fri, 29 Sep 2023 09:53:47 -0400
X-MC-Unique: ilr6DqNiMJuTS6zf5Bbicw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1A3138210A3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:53:46 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B54514171B6;
 Fri, 29 Sep 2023 13:53:46 +0000 (UTC)
Date: Fri, 29 Sep 2023 15:53:45 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 7/9] qapi: golang: Generate qapi's command types in Go
Message-ID: <xzmzmlu6uvtgstmptokclu7dvroaswugdajlscsoopkdgdw6v4@cgkhpxbqkoyf>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-8-victortoso@redhat.com>
 <ZRWOlrwq5tS3oh9W@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2f6kbrp2dt7andzy"
Content-Disposition: inline
In-Reply-To: <ZRWOlrwq5tS3oh9W@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--2f6kbrp2dt7andzy
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

Thanks!

>=20
> >  | }
>=20
> Overall, I'm not entirely convinced that we will want to
> have the SetPasswordCommand struct wrappers, byut it is
> hard to say, as what we're missing still is the eventual
> application facing API.
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
> 	password: "123456",
>     })

For the other structs, I've removed these embed struct (base).
For the commands, I wasn't sure so I left them. I think it is
worth to give another look as I do agree with you.

In the Go application is unlikely that the embed structs are
needed, the important part is to have all the fields in the
command struct.

My prior concern, if I recall correctly was:

 1. This would leave generated but unused quite a few structs.
    Should I remove them? Should I leave them?

 2. The struct might be something we might use elsewhere, so it
    would make sense to, for example:

    qemu.SetPassword.SetPasswordArguments =3D myArgs

    Instead of having to assign field by field, from myArgs to
    qemu.SetPassword as they would be different types.

Overall, I would prefer not having embed types so I'll give
another look to this.

Cheers,
Victor

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
>=20
> >=20
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

--2f6kbrp2dt7andzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUW1ukACgkQl9kSPeN6
SE/3zQ//ToGW0M3BXjTKLhRrv6EWaaU+PkGKvN8gj37k4ibxnofCXqeuRY/RQNRv
QC9gR0OMEe6oo4ZjGC6Oekely/aGcx7NxIgRjwmBn46TWhD3/fF8B8A+35Sl042Q
L824ZOK3E6oKej0ObuldzAAqM+0hRvVA66SMCjKAB50pS5s5S/suNDAdBXB3jZOP
ycu8gNoWjo9YTUokiw3uzPRrSyW5GJC9TrIUZ9TdKX1NxKcelVqydAnGj4PqoBZr
2uZr0QsVIlSQV12gaE0/YcZ0meI8UqJnj5trmbX/bCy/M1fPC5dH1u8ZGHWstmO6
8FcX81+zRYD6gv68RkwjcHZMxHxfZ1WQrM1b6xfvG7fVOalP8/bF9zeH4lRi4wSE
ATzZursnc6OoBUhWdYoSPmLXhifLsMIy8Y9r7b412OjUQPea2h3oL4OXnM4mlL+d
KdAPKrGqFx6g4jDG46Fp1+cblmvpyh8oeo5mijd7n99dP44+yISCL4/mkXA6QyVk
cTiRHFu3I3GVbFsmGYdowv06hHC+ZC2msCuePYiILzp0XVBGIBBGbcIcV+6+4K1g
TBxzBfy6ARNiBrTrTRgDowVW6Zas6Ce2ZgihwP9KReC2xZiqsmr35yZIepahuD6a
XLOGivExf7SkLotWn1atE7mUPQkcJDu+wTWqFtgm4q7dOZz5uWQ=
=yksj
-----END PGP SIGNATURE-----

--2f6kbrp2dt7andzy--


