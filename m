Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFE7F3410
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:42:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Tov-0003eZ-OC; Tue, 21 Nov 2023 11:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Tof-0003Zp-Fy
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Toc-00051W-KC
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700584893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=quEOeX9LMCkRFMfi0mgTPCJ4+N0nwkAEcdRMUIMBJHU=;
 b=KUK6zycHuD+LKlFbQK9wa8Y2vYEmIR5DyPej2fRjYmL07PgAo0EnBqFMBzOp1hOmfpltrD
 7CJ1LrZKQB6UQZvvUOtF863VXTdv5AuLGMri3pyKFTdfE+aHD6eu8inyraafOta+nGasYR
 6+r3OE87ig62FKsbe8+smi1KdPpx6n8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-5HpTcQ8cPqSu0DQrVRDIuQ-1; Tue, 21 Nov 2023 11:41:25 -0500
X-MC-Unique: 5HpTcQ8cPqSu0DQrVRDIuQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5bddc607b45so8062549a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 08:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700584884; x=1701189684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=quEOeX9LMCkRFMfi0mgTPCJ4+N0nwkAEcdRMUIMBJHU=;
 b=kRQ4CONmPY6c26G08AK0ytQnn8/24aXwhLINAptmEtDhkrRbrxco4BLRO667np1Blo
 HrGPNmDlq4y3UUI3pO+89Vd/+HLHNXaUszp/BN15oAiclobFA7haGJBIFGmnzn1YddNf
 5oNOYrPQfZOIG3/0ADz1vdUtTFd57xoKq5r59/keoUxlF281GCTPLeCtrJRHaqdsjuGx
 XFRdEBY0kDr1DvPuiOptPWyxUfn/f21xsfiUIeReghqPk5boD7XegTtJBrHL4f40fcv7
 w54bBQW4xZNsD/gtioiu2OHmN8nB05AhYfXF/1RpFPcyX2MpIt6//uaX7HYo51Sx+rH5
 rKuQ==
X-Gm-Message-State: AOJu0YyYJnMyzG4Q+zrBb+02I3utCubpOzcEIRLxMN4utkpujtyVkTX4
 9tn7o/3JviOKri+ucpHgO/8bjpuYwUyOg1LwLOobZnMoTlhVdqBaCAXKS9bRjJiOtTaSIhwWxIu
 fDz6RF+dbDGVqmaW8fUgM2WfPIUT526I=
X-Received: by 2002:a17:90b:1d05:b0:281:5b8:15e with SMTP id
 on5-20020a17090b1d0500b0028105b8015emr11712890pjb.12.1700584884285; 
 Tue, 21 Nov 2023 08:41:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Q6DoJ5ZDq/J7gerwa9iratb1Krn9/KWAHX5ee4g88WKfMOx+LTFD6/V9ALBV/tJBv6GddPZiaqwJjCzdkow=
X-Received: by 2002:a17:90b:1d05:b0:281:5b8:15e with SMTP id
 on5-20020a17090b1d0500b0028105b8015emr11712871pjb.12.1700584884040; Tue, 21
 Nov 2023 08:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-8-jsnow@redhat.com>
 <87pm032nt1.fsf@pond.sub.org>
In-Reply-To: <87pm032nt1.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2023 11:41:12 -0500
Message-ID: <CAFn=p-ZJB6nfeGaaG=YiGrzGmdQnm=PYjfsLVRDQLxW26Ha65w@mail.gmail.com>
Subject: Re: [PATCH 07/19] qapi/introspect: assert schema.lookup_type did not
 fail
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000eca5e4060aac4525"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000eca5e4060aac4525
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 21, 2023, 9:17 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > lookup_type() is capable of returning None, but introspect.py isn't
> > prepared for that. (And rightly so, if these built-in types are absent,
> > something has gone hugely wrong.)
> >
> > RFC: This is slightly cumbersome as-is, but a patch at the end of this
> series
> > tries to address it with some slightly slicker lookup functions that
> > don't need as much hand-holding.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/introspect.py | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > index 67c7d89aae0..42981bce163 100644
> > --- a/scripts/qapi/introspect.py
> > +++ b/scripts/qapi/introspect.py
> > @@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
> >
> >          # Map the various integer types to plain int
> >          if typ.json_type() == 'int':
> > -            typ = self._schema.lookup_type('int')
> > +            tmp = self._schema.lookup_type('int')
> > +            assert tmp is not None
>
> More laconic: assert tmp
>

*looks up "laconic"*

hey, "terse" is even fewer letters!

(but, you're right. I think I adopted the "is not none" out of a habit for
distinguishing false-y values from the None value, but in this case we
really wouldn't want to have either, so the shorter form is fine, though
for mypy's sake we only care about guarding against None here.)


> > +            typ = tmp
> >          elif (isinstance(typ, QAPISchemaArrayType) and
> >                typ.element_type.json_type() == 'int'):
> > -            typ = self._schema.lookup_type('intList')
> > +            tmp = self._schema.lookup_type('intList')
> > +            assert tmp is not None
> > +            typ = tmp
> >          # Add type to work queue if new
> >          if typ not in self._used_types:
> >              self._used_types.append(typ)
>
> Not fond of naming things @tmp, but I don't have a better name to offer.
>
> We could avoid the lookup by having _def_predefineds() set suitable
> attributes, like it serts .the_empty_object_type.  Matter of taste.  Not
> now unless you want to.
>

 Check the end of the series for different lookup methods, too. We can
discuss your preferred solution then, perhaps?

>

--000000000000eca5e4060aac4525
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Nov 21, 2023, 9:17 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; lookup_type() is capable of returning None, but introspect.py isn&#39;=
t<br>
&gt; prepared for that. (And rightly so, if these built-in types are absent=
,<br>
&gt; something has gone hugely wrong.)<br>
&gt;<br>
&gt; RFC: This is slightly cumbersome as-is, but a patch at the end of this=
 series<br>
&gt; tries to address it with some slightly slicker lookup functions that<b=
r>
&gt; don&#39;t need as much hand-holding.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/introspect.py | 8 ++++++--<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py<b=
r>
&gt; index 67c7d89aae0..42981bce163 100644<br>
&gt; --- a/scripts/qapi/introspect.py<br>
&gt; +++ b/scripts/qapi/introspect.py<br>
&gt; @@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -&gt; s=
tr:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Map the various integer types to p=
lain int<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if typ.json_type() =3D=3D &#39;int&#=
39;:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self._schema.lookup=
_type(&#39;int&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D self._schema.lookup=
_type(&#39;int&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert tmp is not None<br>
<br>
More laconic: assert tmp<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">*looks up &quot;laconic&quot;*</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">hey, &quot;terse&quot; is even fewer letters=
!</div><div dir=3D"auto"><br></div><div dir=3D"auto">(but, you&#39;re right=
. I think I adopted the &quot;is not none&quot; out of a habit for distingu=
ishing false-y values from the None value, but in this case we really would=
n&#39;t want to have either, so the shorter form is fine, though for mypy&#=
39;s sake we only care about guarding against None here.)</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D tmp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif (isinstance(typ, QAPISchemaArra=
yType) and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ.element_typ=
e.json_type() =3D=3D &#39;int&#39;):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self._schema.lookup=
_type(&#39;intList&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D self._schema.lookup=
_type(&#39;intList&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert tmp is not None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D tmp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add type to work queue if new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if typ not in self._used_types:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._used_types.appen=
d(typ)<br>
<br>
Not fond of naming things @tmp, but I don&#39;t have a better name to offer=
.<br>
<br>
We could avoid the lookup by having _def_predefineds() set suitable<br>
attributes, like it serts .the_empty_object_type.=C2=A0 Matter of taste.=C2=
=A0 Not<br>
now unless you want to.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">=C2=A0Check the end of the series for different look=
up methods, too. We can discuss your preferred solution then, perhaps?</div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
</blockquote></div></div></div>

--000000000000eca5e4060aac4525--


