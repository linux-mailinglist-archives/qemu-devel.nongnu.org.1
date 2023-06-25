Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2FD73CE4A
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 05:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDGZK-0008DQ-Mq; Sat, 24 Jun 2023 23:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qDGZI-0008Cg-MX
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 23:37:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qDGZG-0003Uo-T1
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 23:37:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6748a616e17so65439b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osdyne.com; s=google; t=1687664257; x=1690256257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7FozYAD3aRQmMOwHSSeMHzLrKnhT1EalMpVjn2MIhRI=;
 b=RZWgW44hOvIm6hLpvygl7krHADr2jBdA8rOxm16ZlRP/GQpWbIvaTOm+t/02XTrXht
 46CzIQIcGltKZ/Nl3WGAyWOheGY0GPRai9Y/ZCxA+ElZnFqB8VNQaXY1fh5ob39MemcR
 VwvmR9VkWSWo7WvX0zQRN7nDWN0DRZusrqjv/JBAZgiH9sASs6bvr/z7dmUvY6h8sZFl
 Rc/RYqlGOrQbtU3Lq0BXTFdxlQtDaznpVMz1M96/zhIVrYf+S1gPW7TPbwHpT45pBrtR
 aNd+tQKv+5/gsfnefBjTvpXAhtZbJSfZt+CdxcfrwRE7B4mZHEhxq/2yOlH1IV1G7yPa
 k/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687664257; x=1690256257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FozYAD3aRQmMOwHSSeMHzLrKnhT1EalMpVjn2MIhRI=;
 b=Xn76iAiYqaBuFmma1Rh1XnDf3pAWiEsL+5zc98KSKvS5voIVh5d6H9/ZfBK5Nm/i9i
 jPI58aK+cFb6FzXLD3jA2smIMWSzQ9/RV6gM/XdaKrqw3kyNVDvs0mzF/CUcIWySlrO2
 aq2Jdm417IIuVFsHJAVcPmvO56hSQBGUaNMkppHLwTDsY/HDN1dq2X5DcurLnliI5XBT
 XVG/fyklhNLEBlD1H5gjNHi3BmbPSR0RHnuN3HG4szx7XM6UYG9KGz/j3z27Lf1k8QLL
 NL4pm1BQ4EKjZ5LBmv4pCmYh9jGN6nXSpVbZlYpw+OkYrvVZJ7L6UDBqXleSQLY6KDn8
 oUAA==
X-Gm-Message-State: AC+VfDzGhqTp6cHlsSEjMl4iMZzhwDK8jousXhzfNmQqaol1C57JMsWX
 /3Uk9KnX0ZrpN3ZtFIQqsqg3RaSaPkMFmgMVqihazQ==
X-Google-Smtp-Source: ACHHUZ4blLpxXqlGeYC1JdPQvKHC8KxQR/Wq6pjEmW3dgjzcyJ0qgfa/zaXl2GNWnU4jrUk2GNqFz5p8DuojiET7y5o=
X-Received: by 2002:a17:90a:6bc2:b0:262:dc59:ee64 with SMTP id
 w60-20020a17090a6bc200b00262dc59ee64mr2049617pjj.4.1687664256975; Sat, 24 Jun
 2023 20:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221819.6882-1-lucas@osdyne.com>
 <20230620194317.45772-1-lucas@osdyne.com>
 <CAKmqyKM1T6n3pKQV3ZuxDTHXurOOLE4W_33mk8cc9hM3cuGNpA@mail.gmail.com>
In-Reply-To: <CAKmqyKM1T6n3pKQV3ZuxDTHXurOOLE4W_33mk8cc9hM3cuGNpA@mail.gmail.com>
From: "Lucas C. Villa Real" <lucas@osdyne.com>
Date: Sun, 25 Jun 2023 00:37:25 -0300
Message-ID: <CAL+Dfo5=Zg=zvCZjTMTeU0L5kHfju8t9arOs6avURWvLYq=WFA@mail.gmail.com>
Subject: Re: [PATCH] STM32F100: add support for external memory via FSMC
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, erdnaxe@crans.org, 
 "Lucas C . Villa Real" <lucas@odsyne.com>
Content-Type: multipart/alternative; boundary="0000000000008997e705feebf421"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=lucas@osdyne.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000008997e705feebf421
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 10:37=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com>
wrote:

> On Wed, Jun 21, 2023 at 5:44=E2=80=AFAM Lucas Villa Real <lucas@osdyne.co=
m> wrote:
> >
> > Add support for FSMC on high-density STM32F100 devices and enable
> > mapping of additional memory via the `-m SIZE` command-line option.
> > FSMC Bank1 can address up to 4x64MB of PSRAM memory at 0x60000000.
>
> Thanks for the patches!
>

You're welcome!


> >
> > RCC is needed to enable peripheral clock for FSMC; this commit
> > implements support for RCC through the MMIO interface.
>
> This should be a separate commit. The idea is to break commits up as
> small as possible and send a patch series, this makes review much
> easier. Each new feature should be its own commit.
>

Thanks, I'll submit a new patchset as recommended.


> >
> > Last, high-density devices support up to 32KB of static SRAM, so
> > adjust SRAM_SIZE accordingly.
>
> Also, can you include a link to the documentation in the commit message?
>

Absolutely.


> > +static const MemoryRegionOps stm32f100_rcc_ops =3D {
> > +    .read =3D stm32f100_rcc_read,
> > +    .write =3D stm32f100_rcc_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
>
> This should be its own file and device that is included
>

Sounds good, thanks for the guidance. I'll work on this next week.

Best regards,
Lucas

--0000000000008997e705feebf421
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jun 22, 2023 at 10:37=E2=80=AFPM =
Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gma=
il.com</a>&gt; wrote:</div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Wed, Jun 21, 2023 at 5:44=E2=80=AFAM Lucas =
Villa Real &lt;<a href=3D"mailto:lucas@osdyne.com" target=3D"_blank">lucas@=
osdyne.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add support for FSMC on high-density STM32F100 devices and enable<br>
&gt; mapping of additional memory via the `-m SIZE` command-line option.<br=
>
&gt; FSMC Bank1 can address up to 4x64MB of PSRAM memory at 0x60000000.<br>
<br>
Thanks for the patches!<br></blockquote><div><br></div><div>You&#39;re welc=
ome!<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt;<br>
&gt; RCC is needed to enable peripheral clock for FSMC; this commit<br>
&gt; implements support for RCC through the MMIO interface.<br>
<br>
This should be a separate commit. The idea is to break commits up as<br>
small as possible and send a patch series, this makes review much<br>
easier. Each new feature should be its own commit.<br></blockquote><div>=C2=
=A0</div><div>Thanks, I&#39;ll submit a new patchset as recommended.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Last, high-density devices support up to 32KB of static SRAM, so<br>
&gt; adjust SRAM_SIZE accordingly.<br>
<br>
Also, can you include a link to the documentation in the commit message?<br=
></blockquote><div><br></div><div>Absolutely.<br></div><div>=C2=A0<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +static const MemoryRegionOps stm32f100_rcc_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D stm32f100_rcc_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D stm32f100_rcc_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +};<br>
<br>
This should be its own file and device that is included<br></blockquote><di=
v>=C2=A0</div><div>Sounds good, thanks for the guidance. I&#39;ll work on t=
his next week.<br></div></div><div class=3D"gmail_quote"><br></div><div cla=
ss=3D"gmail_quote">Best regards,<br></div><div class=3D"gmail_quote">Lucas<=
br></div></div>

--0000000000008997e705feebf421--

