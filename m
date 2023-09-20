Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE67A8B96
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1qE-0003FG-1G; Wed, 20 Sep 2023 14:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1qA-0003Cu-1O
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:22:22 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1q8-0001Hn-Jp
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:22:21 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50307759b65so300060e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695234139; x=1695838939;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TGiV6mgm48lK0yVo7XXVODBbRpVDNWK2mdb/C7wHX7U=;
 b=D/lEysTBVj2XEZvn+OFTPaLyKtGW4YYhKVx5Gxar3RDFxonWjMK8tpESC6KG5/6alN
 YNb7dr83r11bG+49rVGetIOt2F/8ffIpcsEC3qgrfn6t1QtYV5gvtkfkXHQrleSf1ZFp
 KKyboWaPQ/tlCCCFHtY9RMoEino0SRqF/XjdFZO2/EOSY9XjSI63x35dQUqqmjmLhrCI
 Os69sb3kWTHSGhOUQNeAvrAs+BPR2GalNAe0VjCobt8bWenC1QofAkuFwL/tBZ0vj3/J
 76kRakbUM56th4z26M6jpKymboCT8AzoV3vTohHbxM/kzUX3BOgXzVZUFSJzbz8B8861
 WUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695234139; x=1695838939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGiV6mgm48lK0yVo7XXVODBbRpVDNWK2mdb/C7wHX7U=;
 b=B0IWbWFLxT35CdR4HUUfgOl4Lb5Jeu7ABQ0QMoXGetEZdN+4BXKBSZPuFtitsV1gaw
 loRYChPdxahXPnEzK+5wu+/sF++r7bKRpfcSyZVpIOq0HV5/Cf2//aTURd7tHzvRJ8AG
 ElcHg+QtmbyCvj4K4ciqMvb9cNaDctdDvYzSpyJYVp2n/lU/kwOE/JCS5ALx/GYhBeJg
 oJidgnW+HSjcwczlJ4i1EiGmcOP5iflEnfHI+9ZTobjWMoAmEP4Dup60Owo0Z9sZPUAn
 DGuV1D8WY9OdEhxG0Ea5r+F3crK4hfDPofGKqk9OuBm5ffOQ1gYdiDK6pBx9Vogz1NJj
 25Jg==
X-Gm-Message-State: AOJu0Yx22dPUhab4lshfcBke2vsXJQAuaWAB7TWwzVbBiJu4O7QDigax
 pXaxeqKCANo4k2ezZScBTgy9e+SNjCW8x6Tgl/sUg3yrxEFAyd+w81sgobey
X-Google-Smtp-Source: AGHT+IExEtDf71sTHQrwtoyxepgzVJtbdBDGiEvhCNLoInr8gP1nkZ1YFYohDaEMW2c2ieUDpR+kXbVdh98mIJrd4SY=
X-Received: by 2002:ac2:4d93:0:b0:500:a7c8:1847 with SMTP id
 g19-20020ac24d93000000b00500a7c81847mr2604209lfe.66.1695234138690; Wed, 20
 Sep 2023 11:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-12-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-12-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:22:07 +0100
Message-ID: <CANCZdfrROBcsYfxH2RG_TyCrrgX--V+4+viQ=NY04vBtLNJ=fw@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] bsd-user: Implement getgroups(2) and
 setgroups(2) system calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000a5f0fa0605ce749f"
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x133.google.com
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

--000000000000a5f0fa0605ce749f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  9 +++++++
>  2 files changed, 53 insertions(+)
>

Reviewed by: Warner Losh <imp@bsdimp.com>

--000000000000a5f0fa0605ce749f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 44 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 9 +++++++<br>
=C2=A02 files changed, 53 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--000000000000a5f0fa0605ce749f--

