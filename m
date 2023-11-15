Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA87EC8FC
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:58:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JDE-0005dS-Cd; Wed, 15 Nov 2023 11:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3JDA-0005bP-0h
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:57:56 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3JD8-0000Vy-6X
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:57:55 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54366bb1c02so14637a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700067472; x=1700672272; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dd8Pzd4s8C8dTh04xb7JPR6gzuwTPEqVE1cLUDo4Btg=;
 b=2oyZSeiI6lFqzMsnrRJILnVLBqk3Gvi9pzfGPteXei2QfkeP3Vn57Vuwyevl2Np+1g
 1ddboFppGEfDvzwTz50M8zlaTGEexaVMdtRZ6/llMnaPyfBEE7VXa+7XfRrfkXc35iQ2
 dSKqiUUv0loutwX4/zs2IChvab9RtzGPu92EW/Zh6MhRgXfTnPbzz8333BC5+AgZzwyd
 u3Mqh7Gx6XD3X//p0m3HYwBjT9XSaDNBXtEeB99PNeArtB9JVKGkobCu16ZA68rQNbry
 sTn7CrdDq+GS4BAdzsoPjODmDx8XRTf9kil2+Y4aRqOohogRldP9R4wNTc5uT48rNtJo
 rmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700067472; x=1700672272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dd8Pzd4s8C8dTh04xb7JPR6gzuwTPEqVE1cLUDo4Btg=;
 b=KV2+0s1crs8FoUuTTpyfSroYYswRvjLtlzPX2ht+x7FlPbxDnDSZw0GhHMVKqmcPqM
 f2vSKp+2gyO/qrbk0ToGBHX9N7TqWDqDVhBeOF0lYV1MdJrAMhdD7EY7bQJozlwbMjAo
 Hijp6F99/X0byDfWCdaSAiVWklnOABZiUP8bK7cZPH93OdCP7zz6hzsiVR51nQJ7yEqk
 aDlNqeVNwPU5EFLFc0YG2la4cXK3j+32vMaj75XQmZsZ3wxWZNPmlhfUmVJneU6D3tjz
 TQzeOuqq7yIBrVeI4C6jNPMIpv3blkhsULZ1cz/qbOiceOm5Id8o7NoZmlhCcdmtUw4v
 Xuig==
X-Gm-Message-State: AOJu0YxCmMIo25fkjz+/HBNNglTjIW3OIZt6A3+vD9/suo5cYtjq18n8
 SV93Hur0clBW1xA+UXdXhJ8z8h/8iZ9tOUx1U4A1LA==
X-Google-Smtp-Source: AGHT+IFnZOp6r7a6uc24iELwFFo+buQfBZf8kxZapkZyHl8nlTda2P7mEdlLZ2TNtAB90++Qi/t4Moy3mU8X84lXlI0=
X-Received: by 2002:a05:6402:3712:b0:544:24a8:ebd with SMTP id
 ek18-20020a056402371200b0054424a80ebdmr172878edb.4.1700067472283; Wed, 15 Nov
 2023 08:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
 <bc43ecb5-f93b-4288-a6e1-624aebfcffcc@linaro.org>
 <CAFEAcA89CADp4FhwHd2O_7F07OfwpFZCb534jOjSK4uUt+sqfA@mail.gmail.com>
In-Reply-To: <CAFEAcA89CADp4FhwHd2O_7F07OfwpFZCb534jOjSK4uUt+sqfA@mail.gmail.com>
From: Patrick Venture <venture@google.com>
Date: Wed, 15 Nov 2023 08:57:39 -0800
Message-ID: <CAO=notyJr6g8v5MmNBM8h3AvYx8sH5Z6tMwfFMdiK3aSY0-4pg@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="000000000000c834a4060a33cdd5"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=venture@google.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000c834a4060a33cdd5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 2:30=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 14 Nov 2023 at 21:18, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 11/14/23 12:55, Patrick Venture wrote:
> > > Avoids unaligned pointer issues.
> > >
> > > Reviewed-by: Chris Rauer <crauer@google.com>
> > > Reviewed-by: Peter Foley <pefoley@google.com>
> > > Signed-off-by: Patrick Venture <venture@google.com>
> > > ---
> > >   system/memory.c | 16 ++++++++--------
> > >   1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 304fa843ea..02c97d5187 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -1343,16 +1343,16 @@ static uint64_t
> memory_region_ram_device_read(void *opaque,
> > >
> > >       switch (size) {
> > >       case 1:
> > > -        data =3D *(uint8_t *)(mr->ram_block->host + addr);
> > > +        memcpy(&data, mr->ram_block->host + addr, sizeof(uint8_t));
> >
> >
> > This is incorrect, especially for big-endian hosts.
> >
> > You want to use "qemu/bswap.h", ld*_he_p(), st*_he_p().
>
> More specifically, we have a ldn_he_p() and stn_he_p() that
> take the size in bytes of the data to read, so we should be
> able to replace the switch-on-size in these functions with
> a single call to the appropriate one of those.
>

Thanks!


>
> thanks
> -- PMM
>

--000000000000c834a4060a33cdd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 15, 2023 at 2:30=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, 14 Nov 2023 at 21:18, Richard Henderson<br>
&lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richa=
rd.henderson@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 11/14/23 12:55, Patrick Venture wrote:<br>
&gt; &gt; Avoids unaligned pointer issues.<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Chris Rauer &lt;<a href=3D"mailto:crauer@google.com"=
 target=3D"_blank">crauer@google.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com=
" target=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@goog=
le.com" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0system/memory.c | 16 ++++++++--------<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 8 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/system/memory.c b/system/memory.c<br>
&gt; &gt; index 304fa843ea..02c97d5187 100644<br>
&gt; &gt; --- a/system/memory.c<br>
&gt; &gt; +++ b/system/memory.c<br>
&gt; &gt; @@ -1343,16 +1343,16 @@ static uint64_t memory_region_ram_device_=
read(void *opaque,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (size) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D *(uint8_t *)(mr-&gt;ram_blo=
ck-&gt;host + addr);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;data, mr-&gt;ram_block-&=
gt;host + addr, sizeof(uint8_t));<br>
&gt;<br>
&gt;<br>
&gt; This is incorrect, especially for big-endian hosts.<br>
&gt;<br>
&gt; You want to use &quot;qemu/bswap.h&quot;, ld*_he_p(), st*_he_p().<br>
<br>
More specifically, we have a ldn_he_p() and stn_he_p() that<br>
take the size in bytes of the data to read, so we should be<br>
able to replace the switch-on-size in these functions with<br>
a single call to the appropriate one of those.<br></blockquote><div><br></d=
iv><div>Thanks!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000c834a4060a33cdd5--

