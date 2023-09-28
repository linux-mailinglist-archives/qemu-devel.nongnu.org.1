Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 818787B1FA5
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qls4e-0000Ao-Pu; Thu, 28 Sep 2023 10:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qls4c-0000AS-U9
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qls4a-0001PN-GP
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695911579;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vd95LgEdNT37tJcXGmYRfIfmiwqIVoQE8LzCnsQD+VY=;
 b=Ld+b0O8uXt80umtQ2tyQhGIDCXmGm3/ZYgTvmvgDzv4Ulr20aPTy9PlDlqpt95VyCg2w+B
 fpq/++oqWf7PO8pJVhn0Mvo/qkJOdtneIDetJB8AkUifMv+duYLDn/7sOTnysE2a2LR6ub
 qe3gobQOCgEQ0yx9MHxOt7AEMFU6aCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-tmz-oo6_NoOB0uQwyDzkvA-1; Thu, 28 Sep 2023 10:32:57 -0400
X-MC-Unique: tmz-oo6_NoOB0uQwyDzkvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26DA88061F1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:32:57 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DE0A215670B;
 Thu, 28 Sep 2023 14:32:56 +0000 (UTC)
Date: Thu, 28 Sep 2023 15:32:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 7/9] qapi: golang: Generate qapi's command types in Go
Message-ID: <ZRWOlrwq5tS3oh9W@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-8-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-8-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 01:25:42PM +0200, Victor Toso wrote:
> This patch handles QAPI command types and generates data structures in
> Go that decodes from QMP JSON Object to Go data structure and vice
> versa.
> 
> Similar to Event, this patch adds a Command interface and two helper
> functions MarshalCommand and UnmarshalCommand.
> 
> Example:
> qapi:
>  | { 'command': 'set_password',
>  |   'boxed': true,
>  |   'data': 'SetPasswordOptions' }
> 
> go:
>  | type SetPasswordCommand struct {
>  |     SetPasswordOptions
>  |     CommandId string `json:"-"`

IIUC, you renamed that to MessageId in the code now.

>  | }

Overall, I'm not entirely convinced that we will want to
have the SetPasswordCommand struct wrappers, byut it is
hard to say, as what we're missing still is the eventual
application facing API.

eg something that ultimately looks more like this:

    qemu = qemu.QMPConnection()
    qemu.Dial("/path/to/unix/socket.sock")

    qemu.VncConnectedEvent(func(ev *VncConnectedEvent) {
         fmt.Printf("VNC client %s connected\n", ev.Client.Host)
    })

    resp, err := qemu.SetPassword(SetPasswordArguments{
        protocol: "vnc",
	password: "123456",
    })

    if err != nil {
        fmt.Fprintf(os.Stderr, "Cannot set passwd: %s", err)
    }

    ..do something wit resp....   (well SetPassword has no response, but other cmmands do)

It isn't clear that the SetPasswordCommand struct will be
needed internally for the impl if QMPCommand.

> 
> usage:
>  | input := `{"execute":"set_password",` +
>  |          `"arguments":{"protocol":"vnc",` +
>  |          `"password":"secret"}}`
>  |
>  | c, err := UnmarshalCommand([]byte(input))
>  | if err != nil {
>  |     panic(err)
>  | }
>  |
>  | if c.GetName() == `set_password` {
>  |         m := c.(*SetPasswordCommand)
>  |         // m.Password == "secret"
>  | }
> 
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/golang.py | 97 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> index ff3b1dd020..52a9124641 100644
> --- a/scripts/qapi/golang.py
> +++ b/scripts/qapi/golang.py
> @@ -246,6 +246,51 @@
>  }}
>  '''
>  
> +TEMPLATE_COMMAND_METHODS = '''
> +func (c *{type_name}) GetName() string {{
> +    return "{name}"
> +}}
> +
> +func (s *{type_name}) GetId() string {{
> +    return s.MessageId
> +}}
> +'''
> +
> +TEMPLATE_COMMAND = '''
> +type Command interface {{
> +    GetId()         string
> +    GetName()       string
> +}}
> +
> +func MarshalCommand(c Command) ([]byte, error) {{
> +    m := make(map[string]any)
> +    m["execute"] = c.GetName()
> +    if id := c.GetId(); len(id) > 0 {{
> +        m["id"] = id
> +    }}
> +    if bytes, err := json.Marshal(c); err != nil {{
> +        return []byte{{}}, err
> +    }} else if len(bytes) > 2 {{
> +        m["arguments"] = c
> +    }}
> +    return json.Marshal(m)
> +}}
> +
> +func UnmarshalCommand(data []byte) (Command, error) {{
> +    base := struct {{
> +        MessageId string `json:"id,omitempty"`
> +        Name      string `json:"execute"`
> +    }}{{}}
> +    if err := json.Unmarshal(data, &base); err != nil {{
> +        return nil, fmt.Errorf("Failed to decode command: %s", string(data))
> +    }}
> +
> +    switch base.Name {{
> +    {cases}
> +    }}
> +    return nil, errors.New("Failed to recognize command")
> +}}
> +'''
>  
>  def gen_golang(schema: QAPISchema,
>                 output_dir: str,
> @@ -282,7 +327,7 @@ def qapi_to_go_type_name(name: str,
>  
>      name += ''.join(word.title() for word in words[1:])
>  
> -    types = ["event"]
> +    types = ["event", "command"]
>      if meta in types:
>          name = name[:-3] if name.endswith("Arg") else name
>          name += meta.title().replace(" ", "")
> @@ -521,6 +566,8 @@ def qapi_to_golang_struct(self: QAPISchemaGenGolangVisitor,
>      fields, with_nullable = recursive_base(self, base)
>      if info.defn_meta == "event":
>          fields += f'''\tMessageTimestamp Timestamp `json:"-"`\n{fields}'''
> +    elif info.defn_meta == "command":
> +        fields += f'''\tMessageId string `json:"-"`\n{fields}'''
>  
>      if members:
>          for member in members:
> @@ -719,16 +766,36 @@ def generate_template_event(events: dict[str, str]) -> str:
>  '''
>      return TEMPLATE_EVENT.format(cases=cases)
>  
> +def generate_template_command(commands: dict[str, str]) -> str:
> +    cases = ""
> +    for name in sorted(commands):
> +        case_type = commands[name]
> +        cases += f'''
> +case "{name}":
> +    command := struct {{
> +        Args {case_type} `json:"arguments"`
> +    }}{{}}
> +
> +    if err := json.Unmarshal(data, &command); err != nil {{
> +        return nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
> +    }}
> +    command.Args.MessageId = base.MessageId
> +    return &command.Args, nil
> +'''
> +    content = TEMPLATE_COMMAND.format(cases=cases)
> +    return content
> +
>  
>  class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
>  
>      def __init__(self, _: str):
>          super().__init__()
> -        types = ["alternate", "enum", "event", "helper", "struct", "union"]
> +        types = ["alternate", "command", "enum", "event", "helper", "struct", "union"]
>          self.target = {name: "" for name in types}
>          self.objects_seen = {}
>          self.schema = None
>          self.events = {}
> +        self.commands = {}
>          self.golang_package_name = "qapi"
>          self.accept_null_types = []
>  
> @@ -756,6 +823,7 @@ def visit_begin(self, schema):
>      def visit_end(self):
>          self.schema = None
>          self.target["event"] += generate_template_event(self.events)
> +        self.target["command"] += generate_template_command(self.commands)
>  
>      def visit_object_type(self: QAPISchemaGenGolangVisitor,
>                            name: str,
> @@ -853,7 +921,30 @@ def visit_command(self,
>                        allow_oob: bool,
>                        allow_preconfig: bool,
>                        coroutine: bool) -> None:
> -        pass
> +        assert name == info.defn_name
> +
> +        type_name = qapi_to_go_type_name(name, info.defn_meta)
> +        self.commands[name] = type_name
> +
> +        content = ""
> +        if boxed or not arg_type or not qapi_name_is_object(arg_type.name):
> +            args = "" if not arg_type else "\n" + arg_type.name
> +            args += '''\n\tMessageId   string `json:"-"`'''
> +            content = generate_struct_type(type_name, args)
> +        else:
> +            assert isinstance(arg_type, QAPISchemaObjectType)
> +            content = qapi_to_golang_struct(self,
> +                                            name,
> +                                            arg_type.info,
> +                                            arg_type.ifcond,
> +                                            arg_type.features,
> +                                            arg_type.base,
> +                                            arg_type.members,
> +                                            arg_type.variants)
> +
> +        content += TEMPLATE_COMMAND_METHODS.format(name=name,
> +                                                   type_name=type_name)
> +        self.target["command"] += content
>  
>      def visit_event(self, name, info, ifcond, features, arg_type, boxed):
>          assert name == info.defn_name
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


