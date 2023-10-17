Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8E7CB7F4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 03:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsYqw-0001Tw-0o; Mon, 16 Oct 2023 21:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qsYqt-0001Tl-Mp
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 21:26:31 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qsYqr-0000kX-LG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 21:26:31 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so8497647a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697505986; x=1698110786; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4te3KuQOJmUsyYrku841akAUB/u8DN0JlDTssfoUbDE=;
 b=a+5MlU7fqpe8e3S+/z6aXY1Xx06SZWZmXKaV78BBRwXxQkwOTYQ2J8NuLPSZalAOC5
 u2xb4zakFvbmmVpxaRaj3BNcs6JfmFbPmeTHI68mcDlVP0ha5w+DDuQw4y9FlNLc3OSY
 z3CJK+cHLvFQxTWMmO8UDIYykZSyiyyxk3ok0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697505986; x=1698110786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4te3KuQOJmUsyYrku841akAUB/u8DN0JlDTssfoUbDE=;
 b=IMY7Fm4KTck2W2nTszeKO7An5VDumW3wZw9swJUHQE2bfOEWydAwfg8rliNZ74Bh/j
 YcVxeYTfPfo9YGJ0MrSX3Pihb5HDGShJVOL43HA4MuBV/1WllISdme1d24KO7WcSiqB/
 xnnPxYDvUVfbNxvXltUHmKYe3LNiihGvY+BIo+YriTdWEyUYCmmxizlDQWCxR0inrOAM
 LbmS/A47LuQhqQjTEgHZGreeTWtxCFFdpF9LtpWB1M+bLEycrV3yZPr6TkEZ/lnxRkUT
 kzXrNe2gIC8ilAPoaiIXH3g2eQYWqBdjEVwHGFBHBR2lAF9ocH1mTMY61JOEyJDGJ4ul
 ZcJQ==
X-Gm-Message-State: AOJu0Yxkt4OwI2Z7S+lWVQKUrQiRsXvvlFNef+0UO81CMvC/FxaQTvSF
 BKyY3+fZtGY6JnOJH3P5o9WCsXMv9n6hkWEO1qKfisyw
X-Google-Smtp-Source: AGHT+IGTAmmJtyToDC+k3xDxlz5fTYo/K1o1eZe4Pocfru/xCS+fV/X6dtBPkqrj66PgK6SJaKel6A==
X-Received: by 2002:aa7:c90c:0:b0:53e:2e74:7e0c with SMTP id
 b12-20020aa7c90c000000b0053e2e747e0cmr633873edt.24.1697505986206; 
 Mon, 16 Oct 2023 18:26:26 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 u15-20020a50c04f000000b0053eb69ca1bcsm276803edd.92.2023.10.16.18.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 18:26:25 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-536ef8a7dcdso3977a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 18:26:25 -0700 (PDT)
X-Received: by 2002:a50:d0d1:0:b0:525:573c:643b with SMTP id
 g17-20020a50d0d1000000b00525573c643bmr36625edf.7.1697505985029; Mon, 16 Oct
 2023 18:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231006010835.444-1-gurchetansingh@chromium.org>
 <CAMxuvay04ZF7awEG0Hv9mhPvUTnjMmQ+TL4a=hMEkFwrgcR5Vw@mail.gmail.com>
In-Reply-To: <CAMxuvay04ZF7awEG0Hv9mhPvUTnjMmQ+TL4a=hMEkFwrgcR5Vw@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 16 Oct 2023 18:26:13 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkaU7NRwbkgC3tuf5R4U5vVX2rvj-1=0AE5wyQjT0-=Rw@mail.gmail.com>
Message-ID: <CAAfnVBkaU7NRwbkgC3tuf5R4U5vVX2rvj-1=0AE5wyQjT0-=Rw@mail.gmail.com>
Subject: Re: [PATCH v17 0/9] gfxstream + rutabaga_gfx
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 akihiko.odaki@gmail.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: multipart/alternative; boundary="0000000000003ea83d0607df69ce"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003ea83d0607df69ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 9, 2023 at 12:15=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Fri, Oct 6, 2023 at 5:08=E2=80=AFAM Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> >
> > From: Gurchetan Singh <gurchetansingh@google.com>
> >
> > Branch containing changes:
> >
> > https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v17
> >
> > Changes since v16:
> >
> > - Fixed typo mentioned here:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01407.html
> >
> > Antonio Caggiano (2):
> >   virtio-gpu: CONTEXT_INIT feature
> >   virtio-gpu: blob prep
> >
> > Dr. David Alan Gilbert (1):
> >   virtio: Add shared memory capability
> >
> > Gerd Hoffmann (1):
> >   virtio-gpu: hostmem
> >
> > Gurchetan Singh (5):
> >   gfxstream + rutabaga prep: added need defintions, fields, and options
> >   gfxstream + rutabaga: add initial support for gfxstream
> >   gfxstream + rutabaga: meson support
> >   gfxstream + rutabaga: enable rutabaga
> >   docs/system: add basic virtio-gpu documentation
> >
>
> Except for a few misc style issues, the series looks good to me.
>
> Gerd, as the virtio-gpu "odd fixes" maintainer, any chance you take a
> quick look and ack the series? Even better if you send a PR :)
>

Ping.  Branch containing latest series with the minor fixes Marc suggested
is here:

https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v18


>
> thanks
>
>

--0000000000003ea83d0607df69ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 9, 2023 at 12:15=E2=80=AF=
AM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
">marcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi<br>
<br>
On Fri, Oct 6, 2023 at 5:08=E2=80=AFAM Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@google.com"=
 target=3D"_blank">gurchetansingh@google.com</a>&gt;<br>
&gt;<br>
&gt; Branch containing changes:<br>
&gt;<br>
&gt; <a href=3D"https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxst=
ream-v17" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/gurchetan=
singh/qemu/-/commits/qemu-gfxstream-v17</a><br>
&gt;<br>
&gt; Changes since v16:<br>
&gt;<br>
&gt; - Fixed typo mentioned here:<br>
&gt;<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01=
407.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2023-10/msg01407.html</a><br>
&gt;<br>
&gt; Antonio Caggiano (2):<br>
&gt;=C2=A0 =C2=A0virtio-gpu: CONTEXT_INIT feature<br>
&gt;=C2=A0 =C2=A0virtio-gpu: blob prep<br>
&gt;<br>
&gt; Dr. David Alan Gilbert (1):<br>
&gt;=C2=A0 =C2=A0virtio: Add shared memory capability<br>
&gt;<br>
&gt; Gerd Hoffmann (1):<br>
&gt;=C2=A0 =C2=A0virtio-gpu: hostmem<br>
&gt;<br>
&gt; Gurchetan Singh (5):<br>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga prep: added need defintions, fields, =
and options<br>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga: add initial support for gfxstream<br=
>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga: meson support<br>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga: enable rutabaga<br>
&gt;=C2=A0 =C2=A0docs/system: add basic virtio-gpu documentation<br>
&gt;<br>
<br>
Except for a few misc style issues, the series looks good to me.<br>
<br>
Gerd, as the virtio-gpu &quot;odd fixes&quot; maintainer, any chance you ta=
ke a<br>
quick look and ack the series? Even better if you send a PR :)<br></blockqu=
ote><div><br></div><div>Ping.=C2=A0 Branch containing latest series with th=
e minor fixes Marc suggested is here:</div><div><br></div><div><a href=3D"h=
ttps://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v18">https:/=
/gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v18</a><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
<br>
</blockquote></div></div>

--0000000000003ea83d0607df69ce--

