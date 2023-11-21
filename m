Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCE7F342D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:48:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Tto-00057r-Hf; Tue, 21 Nov 2023 11:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Ttm-000571-Pm
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Ttl-0005wB-4v
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700585212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPorKzkbPSpgPfnJs88MrI60T1hnX3m3p1HOaW/47RA=;
 b=ePuabFnh7EwlMmlkFTH3SVFjcw8N3Ezjmwekos+wRL6w/9nFQ0k/rL1bTnHQ3E2jssITuB
 ABZf1z09Sh6IuvgtFjhit63TBsysjTTMJiPOO5DgNZdC9qTi9ANMuC0yPulXyVRYMen0yW
 WXQQ8Jvad62kf7ZX9xUbVpb0M+qDXBw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-V5WfGgJ_NU-0gZfGkB_BOg-1; Tue, 21 Nov 2023 11:46:50 -0500
X-MC-Unique: V5WfGgJ_NU-0gZfGkB_BOg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6bd00edc63fso8818385b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 08:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700585209; x=1701190009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPorKzkbPSpgPfnJs88MrI60T1hnX3m3p1HOaW/47RA=;
 b=J/aIYSp9VngIbmOHd1rAjQWOlYZ4GSv74Fz2RsawZXoEefMjQrTrq3lntw3NqV8pCJ
 wpwUtIN962Y6VFoDlAj8qhyGkZXJJlBoaVAvQvqk0DHQbogqGIClUZuXGmAn/ItgEPTl
 sG4SakI0y4RrbdmzaL10oJkVf1FMRkhHZMm76nA0gwv2h+oNNpHje8nwZvjFOoOtjAi4
 twX7DBlNCGJkjrgGYooRpEw4B57o+IBL8pJR8LgfkWS1dqIPCOPi7TrNHzNbnQ/ZG7Lt
 PO4s5RwoGSSlGzjO0Xu0gfs1PkJfznWN39ILv2Vm9brcm4eAaJdXH2wl9bg6/3MbiPVb
 au5g==
X-Gm-Message-State: AOJu0YwKVH2xVVzA+xe+o58diXoI4gWwZjYg5c1mQeWFODB/ItX0fKuD
 2ActNBNRQfRHe3xDwTS3kx1sKQdK+w9PtrQ9Hd8vT/9YNqOTGM2y09/E9aJ8Zo5uHidjmSycdRc
 eKHmnYI2M1EknJV4008hfUbU1qQ38Rr8=
X-Received: by 2002:a05:6a00:4c81:b0:6bb:aaf:d7db with SMTP id
 eb1-20020a056a004c8100b006bb0aafd7dbmr14180504pfb.29.1700585208996; 
 Tue, 21 Nov 2023 08:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9qpxkJh6Ykua8Hanf/2HYv6WYhACauNebS0e78NrIGv7s++oDWTIGLYxm2BM8aXQH6JUCJ785LMMkbGIYpRA=
X-Received: by 2002:a05:6a00:4c81:b0:6bb:aaf:d7db with SMTP id
 eb1-20020a056a004c8100b006bb0aafd7dbmr14180475pfb.29.1700585208520; Tue, 21
 Nov 2023 08:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-9-jsnow@redhat.com>
 <87jzqb2nmp.fsf@pond.sub.org>
In-Reply-To: <87jzqb2nmp.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2023 11:46:37 -0500
Message-ID: <CAFn=p-bHuJsMG=HOdw8kxGwgAFQpvUWeHHD0xXtOV3+ytQfJQw@mail.gmail.com>
Subject: Re: [PATCH 08/19] qapi/schema: add static typing and assertions to
 lookup_type()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000043b20a060aac5996"
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

--00000000000043b20a060aac5996
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 21, 2023, 9:21 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This function is a bit hard to type as-is; mypy needs some assertions to
> > assist with the type narrowing.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index a1094283828..3308f334872 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -968,8 +968,12 @@ def lookup_entity(self, name, typ=None):
> >              return None
> >          return ent
> >
> > -    def lookup_type(self, name):
> > -        return self.lookup_entity(name, QAPISchemaType)
> > +    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
>
> Any particular reason not to delay the type hints until PATCH 16?
>

I forget. In some cases I did things a little differently so that the type
checking would pass for each patch in the series, which sometimes required
some concessions.

Is this one of those cases? Uh, I forget.

If it isn't, its almost certainly the case that I just figured I'd type
this one function in one place instead of splitting it apart into two
patches.

I can try to shift the typing later and see what happens if you prefer it
that way.


> > +        typ = self.lookup_entity(name, QAPISchemaType)
> > +        if typ is None:
> > +            return None
> > +        assert isinstance(typ, QAPISchemaType)
> > +        return typ
>
> Would
>
>            typ = self.lookup_entity(name, QAPISchemaType)
>            assert isinstance(typ, Optional[QAPISchemaType])
>            return typ
>
> work?
>

I don't *think* so, Optional isn't a runtime construct. We can combine it
into "assert x is None or isinstance(x, foo)" though - I believe that's
used elsewhere in the qapi generator.


> >
> >      def resolve_type(self, name, info, what):
> >          typ = self.lookup_type(name)
>
>

--00000000000043b20a060aac5996
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Nov 21, 2023, 9:21 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; This function is a bit hard to type as-is; mypy needs some assertions =
to<br>
&gt; assist with the type narrowing.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 8 ++++++--<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index a1094283828..3308f334872 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -968,8 +968,12 @@ def lookup_entity(self, name, typ=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ent<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def lookup_type(self, name):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.lookup_entity(name, QAPISchem=
aType)<br>
&gt; +=C2=A0 =C2=A0 def lookup_type(self, name: str) -&gt; Optional[QAPISch=
emaType]:<br>
<br>
Any particular reason not to delay the type hints until PATCH 16?<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I forget. =
In some cases I did things a little differently so that the type checking w=
ould pass for each patch in the series, which sometimes required some conce=
ssions.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Is this one of t=
hose cases? Uh, I forget.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">If it isn&#39;t, its almost certainly the case that I just figured I&#39;=
d type this one function in one place instead of splitting it apart into tw=
o patches.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I can try to =
shift the typing later and see what happens if you prefer it that way.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name, QAPISche=
maType)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if typ is None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(typ, QAPISchemaType)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return typ<br>
<br>
Would<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0typ =3D self.lookup_entity(name, Q=
APISchemaType)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert isinstance(typ, Optional[QA=
PISchemaType])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return typ<br>
<br>
work?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I don&#39;t *think* so, Optional isn&#39;t a runtime construct. We can=
 combine it into &quot;assert x is None or isinstance(x, foo)&quot; though =
- I believe that&#39;s used elsewhere in the qapi generator.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def resolve_type(self, name, info, what):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_type(name)<br>
<br>
</blockquote></div></div></div>

--00000000000043b20a060aac5996--


