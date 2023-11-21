Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F110A7F33EA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:37:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Tjy-0008Dp-RR; Tue, 21 Nov 2023 11:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Tjr-0008BB-IS
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:36:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Tjp-0003u8-Kb
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700584595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYCApJRNTQOlK30w4zH+GsNXoQOcM9jqw/eS1fatw5I=;
 b=RPP7ouMsgac84ZMP0j4QYo3EeKBVhVzssPddvaxV0/G37BNyj5FwyhYWGK9exrwt6h3kgy
 TvR8VoT0dbtfLmnVjRCzcM5woQOAmm4sY18W9tZM79C+5zoFeMU0mi4CZo54RDyD4BtDBI
 JQHF+vdVpGyG2FLhLF8t2pxz6YpaZo4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-HHFyzIhUNdm49suedFDkBw-1; Tue, 21 Nov 2023 11:36:31 -0500
X-MC-Unique: HHFyzIhUNdm49suedFDkBw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28525981a55so2810923a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 08:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700584590; x=1701189390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYCApJRNTQOlK30w4zH+GsNXoQOcM9jqw/eS1fatw5I=;
 b=nBvoRwT2bj8nphyIzbmwTi5IS1/JOD47W26aOaUrgcUFRR6vo9rxvYYCwwEhTkrLFe
 7yNLgJxmmELiHNSGoylN9DBbYO8I6mPsGJUhZbNGDqmuNJ3dCYE+mkXHbNSbPDX567iT
 iEGgKysSgb4ZE+6tNFUozoAG2YH0T9uGfJMviF7NLk8jsNp5Af6vbcFfo2PAozdR/dk0
 6S4hG4j96fnHuOTaam7ELa6EXbgUJvZp5zobGPkCM5GjzlMxcvIuyVAzMqaBB9Ie52Ld
 wuQWFznpK51vT/HlVbcd6/yibzf4Svcgi+C86V4Z5/wfH0zXwB0mFC0jVE8uIJ9fYlnq
 jmMw==
X-Gm-Message-State: AOJu0YyKGsSjYlQqtJD3tdlTRUinRNrkjSAQsUeWTxS4AMxw/EYFLl2L
 ptabAY4mjfyBgAQZ5vrTsGqmME62bEIkZVEcXZkywF+axCxbyLZaCBQjKw+1WM6i09HwBtBhAnq
 KXwS3sh4SA0YhgwRXDsdnFoD1btVCuio=
X-Received: by 2002:a17:90b:1b10:b0:274:7db1:f50f with SMTP id
 nu16-20020a17090b1b1000b002747db1f50fmr4839903pjb.15.1700584590615; 
 Tue, 21 Nov 2023 08:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdC4ZEGdXmqo+3W3xxxdXm909F0sV18vMFGNe8D3drBplSo6kPcKC1uUSqE9VCThKVhdkl4mN+mkn414S0vHQ=
X-Received: by 2002:a17:90b:1b10:b0:274:7db1:f50f with SMTP id
 nu16-20020a17090b1b1000b002747db1f50fmr4839872pjb.15.1700584590192; Tue, 21
 Nov 2023 08:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-7-jsnow@redhat.com>
 <87ttpf2o6t.fsf@pond.sub.org>
In-Reply-To: <87ttpf2o6t.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2023 11:36:19 -0500
Message-ID: <CAFn=p-bd6E0kYJXyzjU=BR8BzEAXvdiQbsMT+_E1O7COaXNfJA@mail.gmail.com>
Subject: Re: [PATCH 06/19] qapi/schema: adjust type narrowing for mypy's
 benefit
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000068cbca060aac343a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000068cbca060aac343a
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 21, 2023, 9:09 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > We already take care to perform some type narrowing for arg_type and
> > ret_type, but not in a way where mypy can utilize the result. A simple
> > change to use a temporary variable helps the medicine go down.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 4600a566005..a1094283828 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -825,13 +825,14 @@ def __init__(self, name, info, doc, ifcond,
> features,
> >      def check(self, schema):
> >          super().check(schema)
> >          if self._arg_type_name:
> > -            self.arg_type = schema.resolve_type(
> > +            arg_type = schema.resolve_type(
> >                  self._arg_type_name, self.info, "command's 'data'")
> > -            if not isinstance(self.arg_type, QAPISchemaObjectType):
> > +            if not isinstance(arg_type, QAPISchemaObjectType):
> >                  raise QAPISemError(
> >                      self.info,
> >                      "command's 'data' cannot take %s"
> > -                    % self.arg_type.describe())
> > +                    % arg_type.describe())
> > +            self.arg_type = arg_type
> >              if self.arg_type.variants and not self.boxed:
> >                  raise QAPISemError(
> >                      self.info,
> > @@ -848,8 +849,7 @@ def check(self, schema):
> >              if self.name not in
> self.info.pragma.command_returns_exceptions:
> >                  typ = self.ret_type
> >                  if isinstance(typ, QAPISchemaArrayType):
> > -                    typ = self.ret_type.element_type
> > -                    assert typ
> > +                    typ = typ.element_type
>

In this case, we've narrowed typ but not self.ret_type and mypy is not sure
they're synonymous here (lack of power in mypy's model, maybe?). Work in
terms of the temporary type we've already narrowed so mypy knows we have an
element_type field.

>                  if not isinstance(typ, QAPISchemaObjectType):
> >                      raise QAPISemError(
> >                          self.info,
> > @@ -885,13 +885,14 @@ def __init__(self, name, info, doc, ifcond,
> features, arg_type, boxed):
> >      def check(self, schema):
> >          super().check(schema)
> >          if self._arg_type_name:
> > -            self.arg_type = schema.resolve_type(
> > +            typ = schema.resolve_type(
> >                  self._arg_type_name, self.info, "event's 'data'")
> > -            if not isinstance(self.arg_type, QAPISchemaObjectType):
> > +            if not isinstance(typ, QAPISchemaObjectType):
> >                  raise QAPISemError(
> >                      self.info,
> >                      "event's 'data' cannot take %s"
> > -                    % self.arg_type.describe())
> > +                    % typ.describe())
> > +            self.arg_type = typ
> >              if self.arg_type.variants and not self.boxed:
> >                  raise QAPISemError(
> >                      self.info,
>
> Harmless enough.  I can't quite see the mypy problem, though.  Care to
> elaborate a bit?
>

self.arg_type has a narrower type- or, it WILL at the end of this series -
so we need to narrow a temporary variable first before assigning it to the
object state.

We already perform the necessary check/narrowing, so this is really just
pointing out that it's a bad idea to assign the state before the type
check. Now we type check before assigning state.

--js

--00000000000068cbca060aac343a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Nov 21, 2023, 9:09 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; We already take care to perform some type narrowing for arg_type and<b=
r>
&gt; ret_type, but not in a way where mypy can utilize the result. A simple=
<br>
&gt; change to use a temporary variable helps the medicine go down.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 17 +++++++++--------<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index 4600a566005..a1094283828 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -825,13 +825,14 @@ def __init__(self, name, info, doc, ifcond, feat=
ures,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._arg_type_name:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D schema.re=
solve_type(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg_type =3D schema.resolve=
_type(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ar=
g_type_name, <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">self.info</a>, &quot;command&#39;s &#39;data&#39;&quot;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(self.arg_=
type, QAPISchemaObjectType):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(arg_type,=
 QAPISchemaObjectType):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D=
"_blank">self.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;command&#39;s &#39;data&#39; cannot take %s&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 % self.arg_type.describe())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 % arg_type.describe())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D arg_type<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.arg_type.varia=
nts and not self.boxed:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D=
"_blank">self.info</a>,<br>
&gt; @@ -848,8 +849,7 @@ def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://s=
elf.name" rel=3D"noreferrer noreferrer" target=3D"_blank">self.name</a> not=
 in self.info.pragma.command_returns_exceptions:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D =
self.ret_type<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isins=
tance(typ, QAPISchemaArrayType):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 typ =3D self.ret_type.element_type<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 assert typ<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 typ =3D typ.element_type<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">In this case, we&#39;ve narrowed typ but not self.=
ret_type and mypy is not sure they&#39;re synonymous here (lack of power in=
 mypy&#39;s model, maybe?). Work in terms of the temporary type we&#39;ve a=
lready narrowed so mypy knows we have an element_type field.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not i=
sinstance(typ, QAPISchemaObjectType):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 raise QAPISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer norefer=
rer" target=3D"_blank">self.info</a>,<br>
&gt; @@ -885,13 +885,14 @@ def __init__(self, name, info, doc, ifcond, feat=
ures, arg_type, boxed):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._arg_type_name:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D schema.re=
solve_type(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D schema.resolve_type=
(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ar=
g_type_name, <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">self.info</a>, &quot;event&#39;s &#39;data&#39;&quot;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(self.arg_=
type, QAPISchemaObjectType):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(typ, QAPI=
SchemaObjectType):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D=
"_blank">self.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;event&#39;s &#39;data&#39; cannot take %s&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 % self.arg_type.describe())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 % typ.describe())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D typ<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.arg_type.varia=
nts and not self.boxed:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D=
"_blank">self.info</a>,<br>
<br>
Harmless enough.=C2=A0 I can&#39;t quite see the mypy problem, though.=C2=
=A0 Care to<br>
elaborate a bit?<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">self.arg_type has a narrower type- or, it WILL at the end o=
f this series - so we need to narrow a temporary variable first before assi=
gning it to the object state.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">We already perform the necessary check/narrowing, so this is really j=
ust pointing out that it&#39;s a bad idea to assign the state before the ty=
pe check. Now we type check before assigning state.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">--js</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
</blockquote></div></div></div>

--00000000000068cbca060aac343a--


