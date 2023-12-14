Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D684E813CE6
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 22:47:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDtX5-0000Bn-GB; Thu, 14 Dec 2023 16:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rDtWh-0000AU-Cb; Thu, 14 Dec 2023 16:46:00 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rDtWF-0007wV-18; Thu, 14 Dec 2023 16:45:28 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e25d1d189eso9977137b3.0; 
 Thu, 14 Dec 2023 13:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702590321; x=1703195121; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SMshgoAxqF79OIgnLbQM869eDwMcKZy7gXmQrxVH0ac=;
 b=jX5km07hjbxba+WwOzIlz9K/eIlBgN99K5VeKnA9pa1PgmhQOcYqKdmfeuCRfPOZVp
 DQZ7HZuKv6k3ETbgqpsFSvUnnOiRaOoTzoapVYyxVOz4LG1LNuSgca1nsxPdcHCij43L
 QOgoSZS9HbYUxoWQbz/mfxugcvAtspyVhPPWLD6RwttdSa06HHU0MyXOhxEjnG6+vec9
 Z0bRbeZeSNykhxAzLU0ma9DhlIbyZJuqrcozEMDthoQqKo1tHas0zG4ztxtGchge7VXl
 1G/LXeXhEvfb/DmolsB44Z94KXXAQbzSj3g25RiOgUECDPjoAfGLV2Y/PNLYtci4D52s
 bs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702590321; x=1703195121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SMshgoAxqF79OIgnLbQM869eDwMcKZy7gXmQrxVH0ac=;
 b=A9lF7m9NGzWEA8SBqCmDJbPb+KFSzP9gskYseyQNjt4nS8Yg4DEo9tzQzmHvYbVxCi
 wi69QUw0HJG9sox4h1fqrLrl5QUUJolR9K6yY71FVw+C2tXRZ1eisjzvq14OCl2g+TPO
 MOnoXVvQOzBHWD+PftbsRVn/C+okTS+R4nXz5J8jtdnVNXrOKCTaiSB9v7VCw2ObX2am
 Cn5o7N0GdiwIqcaQDATdL0ZePJjKsACHlr3sob4iLYHHrrmSbajbVhy2RVIwVWgkRFPC
 qp6ZdArB1weNv+098l4JQxMDlwv1JNHft29S2pjrsOtUVZwCHxN4GXhLyxQWjr/MaX/u
 wlSg==
X-Gm-Message-State: AOJu0Yx8+/7nlfzxuP9nVSKwNAe3nuHHEl1hBxikQCpw4md/0en9Aezr
 txNut0/nFInt7YGhHFEH+JpdMifkqNlIuKIEkWc=
X-Google-Smtp-Source: AGHT+IGzQKi6sX9zYE76QV0hgmNEtojS5MzuHMFwZZJPNrYKaunwEbRrRN/97x+xL3l8oiEZNrWtYvWwbT6/yWAaglY=
X-Received: by 2002:a05:690c:c02:b0:5e1:21b2:ba9b with SMTP id
 cl2-20020a05690c0c0200b005e121b2ba9bmr5927780ywb.28.1702590321234; Thu, 14
 Dec 2023 13:45:21 -0800 (PST)
MIME-Version: 1.0
References: <CAC8KSA16N+DsCzPVE64NvqxQZZfst67prPbu=nzPTfHiFCEgdw@mail.gmail.com>
 <CAFEAcA_1+-AkM3Pt75CM4WVorDrN2btij_Cn2n_aYvKk++PORA@mail.gmail.com>
In-Reply-To: <CAFEAcA_1+-AkM3Pt75CM4WVorDrN2btij_Cn2n_aYvKk++PORA@mail.gmail.com>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Fri, 15 Dec 2023 00:45:09 +0300
Message-ID: <CAC8KSA3+Z32v055kjiQ9dK7LgQfcGPuSXvPhZ=sN8tJmZue-Jw@mail.gmail.com>
Subject: Re: [PATCH v3] fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
 boards
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004b95cc060c7f337c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000004b95cc060c7f337c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry again. Honestly, I was in a hurry.

Unfortunately, I'm currently using a different PC, and git publish doesn't
work on it (some issues with SSL certificates). I sent the first and second
versions of the patch from my main home PC through this way, but,
regrettably, I had to manually send the third version via the Gmail web
client.

You're right. I tested the patch on qemu v8.1.3. However, I made the
changes on the master branch.

Tomorrow, I will definitely test the patch on the master branch and try to
resolve the issues with git publish. I'll send the fourth version of the
patch.

Thanks!

=D1=87=D1=82, 14 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3., 20:23 Peter Mayd=
ell <peter.maydell@linaro.org>:

> On Thu, 14 Dec 2023 at 11:49, Nikita Ostrenkov <n.ostrenkov@gmail.com>
> wrote:
> >
> > Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> > ---
> >  hw/misc/imx7_snvs.c         | 91 ++++++++++++++++++++++++++++++++++---
> >  hw/misc/trace-events        |  4 +-
> >  include/hw/misc/imx7_snvs.h |  7 ++-
> >  3 files changed, 92 insertions(+), 10 deletions(-)
>
> Hi; this doesn't compile for me:
> ../../hw/misc/imx7_snvs.c:139:5: error: implicit declaration of
> function 'qemu_get_timedate' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>     qemu_get_timedate(&tm, 0);
>     ^
> ../../hw/misc/imx7_snvs.c:140:22: error: implicit declaration of
> function 'mktimegm' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>     s->tick_offset =3D mktimegm(&tm) -
>                      ^
>
> How have you been testing it? This looks like a missing
> include line, so I'm wondering if you've been testing it
> against an older version of QEMU rather than the current
> head-of-git? (If I fix that error then there's another
> one after it because the include line to get mktimegm() is
> missing too.)
>
> Also, your email client has unfortunately mangled the patch in
> a couple of ways:
>  * it's sent it as combined HTML/text, not as plain text only
>  * it has wrapped some long lines
>  * it has sent it base64 encoded
>
> If you're planning to submit more QEMU patches in future,
> it would be worth looking at the notes in
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting=
-your-patches
> about 'git send-email'. For a single patch, I can fix stuff
> up by hand at this end, but it's a bit awkward.
>
> Other than that, the patch looks good to me.
>
> thanks
> -- PMM
>

--0000000000004b95cc060c7f337c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Sorry again. Honestly, I was in a hurry=
.<div dir=3D"auto"><br></div><div dir=3D"auto">Unfortunately, I&#39;m curre=
ntly using a different PC, and git publish doesn&#39;t work on it (some iss=
ues with SSL certificates). I sent the first and second versions of the pat=
ch from my main home PC through this way, but, regrettably, I had to manual=
ly send the third version via the Gmail web client.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">You&#39;re right. I tested the patch on qemu v8=
.1.3. However, I made the changes on the master branch.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Tomorrow, I will definitely test the patch =
on the master branch and try to resolve the issues with git publish. I&#39;=
ll send the fourth version of the patch.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Thanks!</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 14 =D0=B4=D0=B5=D0=BA. 2023=E2=
=80=AF=D0=B3., 20:23 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&g=
t;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Thu, 14 Dec 2023 at 11:49, N=
ikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmail.com" rel=3D"norefer=
rer noreferrer" target=3D"_blank">n.ostrenkov@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmai=
l.com" rel=3D"noreferrer noreferrer" target=3D"_blank">n.ostrenkov@gmail.co=
m</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/misc/imx7_snvs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 91 ++++++=
++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +-<br>
&gt;=C2=A0 include/hw/misc/imx7_snvs.h |=C2=A0 7 ++-<br>
&gt;=C2=A0 3 files changed, 92 insertions(+), 10 deletions(-)<br>
<br>
Hi; this doesn&#39;t compile for me:<br>
../../hw/misc/imx7_snvs.c:139:5: error: implicit declaration of<br>
function &#39;qemu_get_timedate&#39; is invalid in C99<br>
[-Werror,-Wimplicit-function-declaration]<br>
=C2=A0 =C2=A0 qemu_get_timedate(&amp;tm, 0);<br>
=C2=A0 =C2=A0 ^<br>
../../hw/misc/imx7_snvs.c:140:22: error: implicit declaration of<br>
function &#39;mktimegm&#39; is invalid in C99<br>
[-Werror,-Wimplicit-function-declaration]<br>
=C2=A0 =C2=A0 s-&gt;tick_offset =3D mktimegm(&amp;tm) -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^<br>
<br>
How have you been testing it? This looks like a missing<br>
include line, so I&#39;m wondering if you&#39;ve been testing it<br>
against an older version of QEMU rather than the current<br>
head-of-git? (If I fix that error then there&#39;s another<br>
one after it because the include line to get mktimegm() is<br>
missing too.)<br>
<br>
Also, your email client has unfortunately mangled the patch in<br>
a couple of ways:<br>
=C2=A0* it&#39;s sent it as combined HTML/text, not as plain text only<br>
=C2=A0* it has wrapped some long lines<br>
=C2=A0* it has sent it base64 encoded<br>
<br>
If you&#39;re planning to submit more QEMU patches in future,<br>
it would be worth looking at the notes in<br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html#s=
ubmitting-your-patches" rel=3D"noreferrer noreferrer noreferrer" target=3D"=
_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch.html#subm=
itting-your-patches</a><br>
about &#39;git send-email&#39;. For a single patch, I can fix stuff<br>
up by hand at this end, but it&#39;s a bit awkward.<br>
<br>
Other than that, the patch looks good to me.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--0000000000004b95cc060c7f337c--

