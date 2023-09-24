Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B27AC72F
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 10:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkKsW-0003HY-BP; Sun, 24 Sep 2023 04:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkKsU-0003HC-HR
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 04:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkKsS-0005ih-Vh
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 04:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695545648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZdN2YK6gzm+TUq7On1bGMod7NZo69+jt3gr7iJ2aGE=;
 b=WWHr9wU4XooOuWKoGSsKOgK7h+KaxqR6SqWhUBetqhxRMKlOI6Q4ObndVqAUKNed7jqh19
 DaD6Vl/z1JbLM4snnabqt5H3tBIKIGSf0uOmuX3//cmAtNGbwtyOSseRItsQo8AfOF6mcZ
 19eag1Y78p5XFEA94o782vMjmHyUrQg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-F0MQzWtiMYOhbz3sEaCGAg-1; Sun, 24 Sep 2023 04:54:06 -0400
X-MC-Unique: F0MQzWtiMYOhbz3sEaCGAg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77405179afdso694078985a.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695545645; x=1696150445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ZdN2YK6gzm+TUq7On1bGMod7NZo69+jt3gr7iJ2aGE=;
 b=qH6lYhv3MiO0V/TEFBOF2PSWL/1Ig1EvOhNo6IMFdENV2pRrTgu83yZemR2QWDLjST
 EFWdjZ5oINnmCd5UsPOTNdCq0RVvcc4blM6tjb85T7O1bbauMaUNyf+LIkiqfZFy0htJ
 NbFxX4XrUqiLDq7ZLKO5Ovy1DIjPMKmtq6lerPGNHRx6oB5EczkKdNqxs+ygMDdY4BlX
 udJ3zHmMP6mgBASMMa49etDjPnP2uH/+munNZ6Edbj660tK+a9Sq7lzIwcBSnDQBN9am
 y9Mf8j/5tdzT7m0i44MR2vXLR1HL4HQKj9WK2gy1yGl1wVARixLjZtgIc1Uy44nC4Jn3
 rCBw==
X-Gm-Message-State: AOJu0YxjOjxH/ySvqesqtHd1uOYIHK3Iqxi3+MD4aFr3hIq2qPBaqu2I
 FUZ001VeqjtjYTW6/qx6q39RX1dH0gYAwCo+rVVBKseGa5cTvb6ALuGFcj1f+YlxwUb5nIozrk2
 s/9TwKrum4uOCAyB39zCZxuqofMaFcrM=
X-Received: by 2002:a05:620a:2f2:b0:770:fc39:25e4 with SMTP id
 a18-20020a05620a02f200b00770fc3925e4mr3807860qko.45.1695545645631; 
 Sun, 24 Sep 2023 01:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiwsOPHGlW2s5oBA+CNV6qW51xsaXB0Goh63L2bLeJ/lgopHf7rKdY75V6qUmkVJb9rTdxt/2XyAALLWXvBuM=
X-Received: by 2002:a05:620a:2f2:b0:770:fc39:25e4 with SMTP id
 a18-20020a05620a02f200b00770fc3925e4mr3807853qko.45.1695545645418; Sun, 24
 Sep 2023 01:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-3-pbonzini@redhat.com>
 <af692de9-1bde-6af1-2d10-c6398d489673@eik.bme.hu>
In-Reply-To: <af692de9-1bde-6af1-2d10-c6398d489673@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 24 Sep 2023 10:53:53 +0200
Message-ID: <CABgObfaL21umuC0D-QiMJRVRVtOokGo006N=fnPh3e1qkR+T_w@mail.gmail.com>
Subject: Re: [PATCH 02/13] audio: Require AudioState in AUD_add_capture
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e561a5060616fb50"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e561a5060616fb50
Content-Type: text/plain; charset="UTF-8"

Il sab 23 set 2023, 13:49 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> On Sat, 23 Sep 2023, Paolo Bonzini wrote:
> > From: Martin Kletzander <mkletzan@redhat.com>
> >
> > Since all callers require a valid audiodev this function can now safely
> > abort in case of missing AudioState.
> >
> > Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> > Message-ID: <
> c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.com
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > audio/audio.c | 7 +++----
> > 1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index 90c7c49d116..42bfa330146 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -1876,10 +1876,9 @@ CaptureVoiceOut *AUD_add_capture(
> >     struct capture_callback *cb;
> >
> >     if (!s) {
> > -        if (!legacy_config) {
> > -            dolog("Capturing without setting an audiodev is
> deprecated\n");
> > -        }
> > -        s = audio_init(NULL, NULL);
> > +        error_setg(&error_abort,
> > +                   "Capturing without setting an audiodev is not
> supported");
> > +        abort();
>
> This looks suspicious to me but I don't know if you can do this. Probably
> Markus can advise. I would use error_report and abort() or error_setg if
> you have an errp then return but this func doesn't seem to have errp.
>

Sure, I will change that.

Paolo


> Regards,
> BALATON Zoltan
>
> >     }
> >
> >     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
> >
>
>

--000000000000e561a5060616fb50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 23 set 2023, 13:49 BALATON Zoltan &lt;<a href=
=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Sat, 23 Sep 2023, Paolo Bonzini wrote=
:<br>
&gt; From: Martin Kletzander &lt;<a href=3D"mailto:mkletzan@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">mkletzan@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Since all callers require a valid audiodev this function can now safel=
y<br>
&gt; abort in case of missing AudioState.<br>
&gt;<br>
&gt; Signed-off-by: Martin Kletzander &lt;<a href=3D"mailto:mkletzan@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">mkletzan@redhat.com</a>&gt;<br>
&gt; Message-ID: &lt;<a href=3D"mailto:c6e87e678e914df0f59da2145c2753cdb4a1=
6f63.1650874791.git.mkletzan@redhat.com" target=3D"_blank" rel=3D"noreferre=
r">c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.=
com</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; audio/audio.c | 7 +++----<br>
&gt; 1 file changed, 3 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/audio/audio.c b/audio/audio.c<br>
&gt; index 90c7c49d116..42bfa330146 100644<br>
&gt; --- a/audio/audio.c<br>
&gt; +++ b/audio/audio.c<br>
&gt; @@ -1876,10 +1876,9 @@ CaptureVoiceOut *AUD_add_capture(<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct capture_callback *cb;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!s) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!legacy_config) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dolog(&quot;Capturing witho=
ut setting an audiodev is deprecated\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s =3D audio_init(NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;error_abort,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;Capturing without setting an audiodev is not supported&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
<br>
This looks suspicious to me but I don&#39;t know if you can do this. Probab=
ly <br>
Markus can advise. I would use error_report and abort() or error_setg if <b=
r>
you have an errp then return but this func doesn&#39;t seem to have errp.<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Su=
re, I will change that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!audio_get_pdo_out(s-&gt;dev)-&gt;mixing_engine=
) {<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000e561a5060616fb50--


