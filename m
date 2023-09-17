Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3427A354E
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhpbX-0000py-IL; Sun, 17 Sep 2023 07:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpbV-0000nl-Id
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:06:17 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpbU-0006Pk-3s
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:06:17 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50307acd445so1204738e87.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694948774; x=1695553574;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aYVTDQzJOK7C5Cja5XBh2aYv/jpUPyUZICX8M8tek5o=;
 b=1lzc+TclV0Dw9owVaar5bz3CdpF/b2DwsDZ5aNcfhwIAQzajOGr3X6IkEVFYwNNlFj
 ez4hgD8ViBkmcC62k26cnXN6nv3HldFfZVb94sTwVB6crg+z6k7VTrrzXPD6+zAoNULv
 wHa0/jHeio5YEgyzASRYGbxEnFZtMkcvlIV3eoWNmN/pct7kaD2LVxFvjYxfyMSDEnNH
 UO/B8s3h5e/ENBVVg1D0EHpbemCcOjjqQwBEal1yqlqV5lezVSO2AQ3LYIICHDP7cl0C
 wo0SBIn7XmEgjpCW2FSY0/Zw7QIc+0O1x02zyI2FDnV2yf+zuY+WuxPVMYhstf78R5it
 u51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694948774; x=1695553574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYVTDQzJOK7C5Cja5XBh2aYv/jpUPyUZICX8M8tek5o=;
 b=rTSJDJ2IZc7ZTkrw0IVE/j4uawQttJF8bq0/vwxKwlNaJa2dYEL1DAzoSUFBhzjlH1
 7HCLH4tt7DqxpS1s2kVaZGU/CwEVTMNtA+jXfdYslqRm4clclyzQnR9iayZ/ik7IjJZx
 K4cJOpFZQLZyQHN9b9CuAnBatH3oVqxCVVZoW4UWhAqaROFe1KldbSgz3Zl3RLKI+Fmv
 RLahDf4rduaKBiisi9vAXS1UEYXBySQ2w5+I6lp+//vDHvs+YL7djrcLLtu8RAdDJGcQ
 tiIlgHymGn4MMGHVu4T4HTUx/McKTG7+wR/AF+1V3Q46KITrln65ChdlXK3X0FfGfPGx
 5TRQ==
X-Gm-Message-State: AOJu0Yy4KmajzI2F1GG/RGL1kVmRqL9E6KLHc7xKKY4gwD/7y3KFVhSZ
 W6aTWGAxLoevcWglQ+rvHRTGwmzRwLXNk4s6mdqSbA==
X-Google-Smtp-Source: AGHT+IHsnlYpLTmCxbb5aa7y8BR4L9nxfKPN8AgOAHssUCITcIvUFOK9DZDqMdTLVoCc8MegWo934LEomZGmVBf/nEI=
X-Received: by 2002:a05:6512:3d1a:b0:500:a95c:70e with SMTP id
 d26-20020a0565123d1a00b00500a95c070emr7169676lfv.51.1694948774128; Sun, 17
 Sep 2023 04:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-20-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-20-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 12:06:03 +0100
Message-ID: <CANCZdfpby89B8v2pPp5UhJbJee_SdyCNhkCkgvk-_tjRr252QA@mail.gmail.com>
Subject: Re: [PATCH v5 19/23] bsd-user: Implement shm_open(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000098462606058c03b4"
Received-SPF: none client-ip=2a00:1450:4864:20::135;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000098462606058c03b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:42=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-mem.h            | 25 +++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 29 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000098462606058c03b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 14, 2023 at 9:42=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Co-authored-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 25 ++++=
+++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 29 insertions(+)<br></blockquote><div><br></div><div=
><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bs=
dimp.com</a>&gt;</div></div></div></div>

--00000000000098462606058c03b4--

