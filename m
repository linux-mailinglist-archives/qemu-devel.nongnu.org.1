Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A667EB8B6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 22:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3183-0007tG-6m; Tue, 14 Nov 2023 16:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3181-0007t2-FX
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 16:39:25 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r317z-0005n1-Kd
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 16:39:25 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54744e66d27so4669a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699997961; x=1700602761; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+SOaKVfuDrxk9TjPdAdZVozr+Sase/JqG9Si3lVJOw=;
 b=UKzb0+POfNVBeq/4U3vLAdmm1XSeDdpuT6tE3CntVpetM9fiUlrcwsCROlNB7nhmfu
 z0NyeWN75JzBh9WJq0qdAhKOmjRyIaShdWoNgQB65AY/TPD9QLPXgcVqE1fT7K5iLn33
 tsEJU2tv9auv4nc2jEfwc13tdL9PPzBGqtkxjtGstaxhtsqniiN9nUI06TF2APdm4Z7d
 UT6GuZMHkSoxzPXqJ07P33Ku0Thyvp926B6mcleR40B14lqhfQuZMJxSu1r2Wie2GPfC
 DwmZFCBOMNNyeD8itKVJruCj/+nc8vB5PVdD+Hk3vs6sqRxsuTPRIW3l3gZQXHh9V0/S
 6XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699997961; x=1700602761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T+SOaKVfuDrxk9TjPdAdZVozr+Sase/JqG9Si3lVJOw=;
 b=md/oNhwKmTW5isf9RuOQIsshbnCrz/ALbcaBx13vBgmc7hazF2Y3YrPvo6I0wtLbh9
 9L71dvvkmg4o9NYd+sd5dmuBo/g8mCSSY1Nl+tjtq/RBbPdaOB0hBwK1oQLPqXIcd45m
 if+KLJmJ7Qh2AvO3foWF5l9iU5L92EQR6ykFVqJPXXv72sckSLnIvtIix9yQV5ShoBMO
 5R6bECYvSsVuMq1VP+fOXyTnGtuJ6flqXRbDwceMETKB4IFFKdSxqH84QIidMxlojhJY
 eBdR/bYKaH8s4CZemnji2n7B2s0XMI7v0/oiVuw1X83EzHnIaiwaxZfw88/pv6IN/MZ6
 5LIg==
X-Gm-Message-State: AOJu0YwnznCx3bd21cFAlN483kMmFNhXwyqbEpym8FMZoLAurx3bygax
 UL2kcvmPLlQhfFtfzxYcl9YM0ZHWbhzEwEHslZivWw==
X-Google-Smtp-Source: AGHT+IG4cTIgcITnnAlh+ojtsKrsGJNfhl5r4qhvQkpMlCSGviOxy708hmmilmo6rLp1jqCtV15la6xhlla1JjrXHgA=
X-Received: by 2002:a05:6402:268d:b0:544:e2b8:ba6a with SMTP id
 w13-20020a056402268d00b00544e2b8ba6amr9048edd.3.1699997960502; Tue, 14 Nov
 2023 13:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
 <bc43ecb5-f93b-4288-a6e1-624aebfcffcc@linaro.org>
In-Reply-To: <bc43ecb5-f93b-4288-a6e1-624aebfcffcc@linaro.org>
From: Patrick Venture <venture@google.com>
Date: Tue, 14 Nov 2023 13:39:08 -0800
Message-ID: <CAO=notwC4PY9Kqfg_22_b-XD6i6oAh6eNGYfvdjWdWCPMLJP_A@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="0000000000008eb4f3060a239eca"
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

--0000000000008eb4f3060a239eca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 1:18=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 11/14/23 12:55, Patrick Venture wrote:
> > Avoids unaligned pointer issues.
> >
> > Reviewed-by: Chris Rauer <crauer@google.com>
> > Reviewed-by: Peter Foley <pefoley@google.com>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   system/memory.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index 304fa843ea..02c97d5187 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -1343,16 +1343,16 @@ static uint64_t
> memory_region_ram_device_read(void *opaque,
> >
> >       switch (size) {
> >       case 1:
> > -        data =3D *(uint8_t *)(mr->ram_block->host + addr);
> > +        memcpy(&data, mr->ram_block->host + addr, sizeof(uint8_t));
>
>
> This is incorrect, especially for big-endian hosts.
>
> You want to use "qemu/bswap.h", ld*_he_p(), st*_he_p().
>

Thanks, I'll take a look.


>
>
> r~
>

--0000000000008eb4f3060a239eca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 14, 2023 at 1:18=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 11/14/23 12:55, Patrick Venture wrote:<br>
&gt; Avoids unaligned pointer issues.<br>
&gt; <br>
&gt; Reviewed-by: Chris Rauer &lt;<a href=3D"mailto:crauer@google.com" targ=
et=3D"_blank">crauer@google.com</a>&gt;<br>
&gt; Reviewed-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" tar=
get=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0system/memory.c | 16 ++++++++--------<br>
&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/system/memory.c b/system/memory.c<br>
&gt; index 304fa843ea..02c97d5187 100644<br>
&gt; --- a/system/memory.c<br>
&gt; +++ b/system/memory.c<br>
&gt; @@ -1343,16 +1343,16 @@ static uint64_t memory_region_ram_device_read(=
void *opaque,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (size) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D *(uint8_t *)(mr-&gt;ram_block-&g=
t;host + addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;data, mr-&gt;ram_block-&gt;ho=
st + addr, sizeof(uint8_t));<br>
<br>
<br>
This is incorrect, especially for big-endian hosts.<br>
<br>
You want to use &quot;qemu/bswap.h&quot;, ld*_he_p(), st*_he_p().<br></bloc=
kquote><div><br></div><div>Thanks, I&#39;ll take a look.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000008eb4f3060a239eca--

