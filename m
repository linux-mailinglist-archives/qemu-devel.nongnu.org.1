Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CC77F4F03
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:13:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5riX-00068R-UH; Wed, 22 Nov 2023 13:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5riU-00067C-10
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:12:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5riN-0000w9-N5
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700676762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lml3/NFQQyOul5JCWlS6lp6o7lDbwvhFu9g7Ag3g3FA=;
 b=PfGsGcLx4Yi8mzPaz7MrJFQCHb2RvUsk/9N0VhjHQYQY3ciSunuexdQV6IVDAgRdy3EOlS
 uYx5JjIX7ehD5+VctyhCE74LNfOOU6mumJFSAsc7We91mP2caHzy5tEw31eRBbI0P/b9+3
 kxYnMe6PaFlZESnO4fVku6AOzf02cRM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-er5IY2t7O2WEhjYL4m4mCg-1; Wed, 22 Nov 2023 13:12:39 -0500
X-MC-Unique: er5IY2t7O2WEhjYL4m4mCg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28515f4cd74so97810a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700676758; x=1701281558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lml3/NFQQyOul5JCWlS6lp6o7lDbwvhFu9g7Ag3g3FA=;
 b=n3dq/WM9eFMv5e+KEkCT1LJCtg42j4gE4JS7TPNyrHKz9E9duYuQ3co2zpbCHI4Ntk
 SDaAQHkrKYvNuevy+iGAByHLDgOcxc8IYRqWWx38dVYISEADfAAfJSL7j1b6OblQpMmL
 5JOIO1jDLZEnW1IemSn/4NPjGGYwNB5thbkqBRnSCWx3u4keQc7PqmtAUsaN1uuDgc8A
 Le5ScvfBWjqLV9rql88MeR8+hj2Il1e5dr/UQLiM1bgFAlNFxJrnZuDDO/akJz2o9YYc
 RxkWxUScFqmbFWTtRPJJBrOfQVRiI6TZIoYosBJOkH1ZsnZdCwBmG1miq0P1bLaTzhKO
 jhlw==
X-Gm-Message-State: AOJu0Yy8h+eaEolAegB+hddjbACIH36tYG5GaqR9hPmkO/A3YpWtHjLo
 ogbtAhn2jd0t0Q/XQJgQDhiTq/xVNPDVAWEN5bn6RCS4kIZcnCfjEgK/C1ohQ+wvBTRHxtWmNxz
 5e3PtNrCp8mTOWUMnzWGLHCqQ3fBvaiNUCrLnwgM=
X-Received: by 2002:a17:90b:3584:b0:280:24a:9141 with SMTP id
 mm4-20020a17090b358400b00280024a9141mr3182740pjb.28.1700676758330; 
 Wed, 22 Nov 2023 10:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNGVPd6GMAoOh38FkL6LBK8Xg+TeSJ6q59CXAqxEezLCUYjdNOwHtwhkmi3gCHz3WYLoUH2ZKVlr2fIo9qtUY=
X-Received: by 2002:a17:90b:3584:b0:280:24a:9141 with SMTP id
 mm4-20020a17090b358400b00280024a9141mr3182720pjb.28.1700676757972; Wed, 22
 Nov 2023 10:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-7-jsnow@redhat.com>
 <87ttpf2o6t.fsf@pond.sub.org>
 <CAFn=p-bd6E0kYJXyzjU=BR8BzEAXvdiQbsMT+_E1O7COaXNfJA@mail.gmail.com>
 <87cyw2uhee.fsf@pond.sub.org>
In-Reply-To: <87cyw2uhee.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 22 Nov 2023 13:12:27 -0500
Message-ID: <CAFn=p-ZjcbDtw2kBSFAeM5=T-MijJh_xifjsE0x3ubOjjK4TtQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] qapi/schema: adjust type narrowing for mypy's
 benefit
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000097d35060ac1aa60"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000097d35060ac1aa60
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 22, 2023, 7:00 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Nov 21, 2023, 9:09 AM Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > We already take care to perform some type narrowing for arg_type and
> >> > ret_type, but not in a way where mypy can utilize the result. A simple
> >> > change to use a temporary variable helps the medicine go down.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/schema.py | 17 +++++++++--------
> >> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> > index 4600a566005..a1094283828 100644
> >> > --- a/scripts/qapi/schema.py
> >> > +++ b/scripts/qapi/schema.py
> >> > @@ -825,13 +825,14 @@ def __init__(self, name, info, doc, ifcond,
> features,
> >> >      def check(self, schema):
> >> >          super().check(schema)
> >> >          if self._arg_type_name:
> >> > -            self.arg_type = schema.resolve_type(
> >> > +            arg_type = schema.resolve_type(
> >> >                  self._arg_type_name, self.info, "command's 'data'")
> >> > -            if not isinstance(self.arg_type, QAPISchemaObjectType):
> >> > +            if not isinstance(arg_type, QAPISchemaObjectType):
> >> >                  raise QAPISemError(
> >> >                      self.info,
> >> >                      "command's 'data' cannot take %s"
> >> > -                    % self.arg_type.describe())
> >> > +                    % arg_type.describe())
> >> > +            self.arg_type = arg_type
> >> >              if self.arg_type.variants and not self.boxed:
> >> >                  raise QAPISemError(
> >> >                      self.info,
>
> Same story as for QAPISchemaEvent.check() below.  Correct?
>

Yep.


> >> > @@ -848,8 +849,7 @@ def check(self, schema):
> >> >              if self.name not in
> self.info.pragma.command_returns_exceptions:
> >> >                  typ = self.ret_type
> >> >                  if isinstance(typ, QAPISchemaArrayType):
> >> > -                    typ = self.ret_type.element_type
> >> > -                    assert typ
> >> > +                    typ = typ.element_type
> >>
> >
> > In this case, we've narrowed typ but not self.ret_type and mypy is not
> sure
> > they're synonymous here (lack of power in mypy's model, maybe?). Work in
> > terms of the temporary type we've already narrowed so mypy knows we have
> an
> > element_type field.
>
> The conditional ensures @typ is QAPISchemaArrayType.
>
> In mypy's view, @typ is QAPISchemaArrayType, but self.ret_type is only
> Optional[QAPISchemaType].
>
> Therefore, it chokes on self.ret_type.element_type, but is happy with
> typ.element_type.
>
> Correct?
>

I think so, yes. In this conditional block, we need to work in terms of
typ, which has been narrowed. The broader type doesn't have .element_type.


> Why delete the assertion?  Oh!  Hmm, should the deletion go into PATCH
> 10?
>

Yeah, just a patch-splitting goof. I'll repair that.


> >>                  if not isinstance(typ, QAPISchemaObjectType):
> >> >                      raise QAPISemError(
> >> >                          self.info,
> >> > @@ -885,13 +885,14 @@ def __init__(self, name, info, doc, ifcond,
> features, arg_type, boxed):
> >> >      def check(self, schema):
> >> >          super().check(schema)
> >> >          if self._arg_type_name:
> >> > -            self.arg_type = schema.resolve_type(
> >> > +            typ = schema.resolve_type(
> >> >                  self._arg_type_name, self.info, "event's 'data'")
> >> > -            if not isinstance(self.arg_type, QAPISchemaObjectType):
> >> > +            if not isinstance(typ, QAPISchemaObjectType):
> >> >                  raise QAPISemError(
> >> >                      self.info,
> >> >                      "event's 'data' cannot take %s"
> >> > -                    % self.arg_type.describe())
> >> > +                    % typ.describe())
> >> > +            self.arg_type = typ
> >> >              if self.arg_type.variants and not self.boxed:
> >> >                  raise QAPISemError(
> >> >                      self.info,
> >>
> >> Harmless enough.  I can't quite see the mypy problem, though.  Care to
> >> elaborate a bit?
> >>
> >
> > self.arg_type has a narrower type- or, it WILL at the end of this series
> -
> > so we need to narrow a temporary variable first before assigning it to
> the
> > object state.
> >
> > We already perform the necessary check/narrowing, so this is really just
> > pointing out that it's a bad idea to assign the state before the type
> > check. Now we type check before assigning state.
>
> After PATCH 16, .resolve_type() will return QAPISchemaType, and
> self.arg_type will be Optional[QAPISchemaObjectType].  Correct?
>

Sounds right. Sometimes it's a little hard to see what the error is before
the rest of the types go in, a hazard of needing all patches to bisect
without regression.

Do you want a more elaborate commit message?

--js

--000000000000097d35060ac1aa60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Nov 22, 2023, 7:00 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; On Tue, Nov 21, 2023, 9:09 AM Markus Armbruster &lt;<a href=3D"mailto:=
armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</=
a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; We already take care to perform some type narrowing for arg_t=
ype and<br>
&gt;&gt; &gt; ret_type, but not in a way where mypy can utilize the result.=
 A simple<br>
&gt;&gt; &gt; change to use a temporary variable helps the medicine go down=
.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/schema.py | 17 +++++++++--------<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 9 insertions(+), 8 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<=
br>
&gt;&gt; &gt; index 4600a566005..a1094283828 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/schema.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/schema.py<br>
&gt;&gt; &gt; @@ -825,13 +825,14 @@ def __init__(self, name, info, doc, ifc=
ond, features,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._arg_type_name:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D =
schema.resolve_type(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg_type =3D schem=
a.resolve_type(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 self._arg_type_name, <a href=3D"http://self.info" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">self.info</a>, &quot;command&#39;s &#39;data&#39;&q=
uot;)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(=
self.arg_type, QAPISchemaObjectType):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(=
arg_type, QAPISchemaObjectType):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise QAPISemError(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">self.info</a>,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;command&#39;s &#39;data&#39; cannot take %s&quot;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 % self.arg_type.describe())<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 % arg_type.describe())<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D =
arg_type<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.arg_t=
ype.variants and not self.boxed:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise QAPISemError(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">self.info</a>,<br>
<br>
Same story as for QAPISchemaEvent.check() below.=C2=A0 Correct?<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yep.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt;&gt; &gt; @@ -848,8 +849,7 @@ def check(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D=
"http://self.name" rel=3D"noreferrer noreferrer" target=3D"_blank">self.nam=
e</a> not in self.info.pragma.command_returns_exceptions:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 typ =3D self.ret_type<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if isinstance(typ, QAPISchemaArrayType):<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 typ =3D self.ret_type.element_type<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 assert typ<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 typ =3D typ.element_type<br>
&gt;&gt;<br>
&gt;<br>
&gt; In this case, we&#39;ve narrowed typ but not self.ret_type and mypy is=
 not sure<br>
&gt; they&#39;re synonymous here (lack of power in mypy&#39;s model, maybe?=
). Work in<br>
&gt; terms of the temporary type we&#39;ve already narrowed so mypy knows w=
e have an<br>
&gt; element_type field.<br>
<br>
The conditional ensures @typ is QAPISchemaArrayType.<br>
<br>
In mypy&#39;s view, @typ is QAPISchemaArrayType, but self.ret_type is only<=
br>
Optional[QAPISchemaType].<br>
<br>
Therefore, it chokes on self.ret_type.element_type, but is happy with<br>
typ.element_type.<br>
<br>
Correct?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I think so, yes. In this conditional block, we need to work in te=
rms of typ, which has been narrowed. The broader type doesn&#39;t have .ele=
ment_type.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
Why delete the assertion?=C2=A0 Oh!=C2=A0 Hmm, should the deletion go into =
PATCH<br>
10?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Yeah, just a patch-splitting goof. I&#39;ll repair that.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot isinstance(typ, QAPISchemaObjectType):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 raise QAPISemError(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">self.info</a>,<br>
&gt;&gt; &gt; @@ -885,13 +885,14 @@ def __init__(self, name, info, doc, ifc=
ond, features, arg_type, boxed):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._arg_type_name:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D =
schema.resolve_type(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D schema.res=
olve_type(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 self._arg_type_name, <a href=3D"http://self.info" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">self.info</a>, &quot;event&#39;s &#39;data&#39;&quo=
t;)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(=
self.arg_type, QAPISchemaObjectType):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(=
typ, QAPISchemaObjectType):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise QAPISemError(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">self.info</a>,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;event&#39;s &#39;data&#39; cannot take %s&quot;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 % self.arg_type.describe())<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 % typ.describe())<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg_type =3D =
typ<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.arg_t=
ype.variants and not self.boxed:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise QAPISemError(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">self.info</a>,<br>
&gt;&gt;<br>
&gt;&gt; Harmless enough.=C2=A0 I can&#39;t quite see the mypy problem, tho=
ugh.=C2=A0 Care to<br>
&gt;&gt; elaborate a bit?<br>
&gt;&gt;<br>
&gt;<br>
&gt; self.arg_type has a narrower type- or, it WILL at the end of this seri=
es -<br>
&gt; so we need to narrow a temporary variable first before assigning it to=
 the<br>
&gt; object state.<br>
&gt;<br>
&gt; We already perform the necessary check/narrowing, so this is really ju=
st<br>
&gt; pointing out that it&#39;s a bad idea to assign the state before the t=
ype<br>
&gt; check. Now we type check before assigning state.<br>
<br>
After PATCH 16, .resolve_type() will return QAPISchemaType, and<br>
self.arg_type will be Optional[QAPISchemaObjectType].=C2=A0 Correct?<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sounds =
right. Sometimes it&#39;s a little hard to see what the error is before the=
 rest of the types go in, a hazard of needing all patches to bisect without=
 regression.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Do you want=
 a more elaborate commit message?</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">--js</div></div>

--000000000000097d35060ac1aa60--


