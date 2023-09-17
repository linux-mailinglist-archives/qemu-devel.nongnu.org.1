Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539287A354A
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:05:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhpZE-0007EK-JY; Sun, 17 Sep 2023 07:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpZB-0007DI-Td
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:03:53 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpZ9-0005T3-Hn
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:03:53 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so4411987a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694948629; x=1695553429;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wAmjTbvoInQNMs//cAAOELgT9qBGcW1dL3il82kAKVs=;
 b=UqMz64FPVNG14Dn8DvP2myOvfhe+CLnfU8ATLVGz7sceWm/XK4r6anR/6uG/CKf7iU
 YRgCK63JT9DnEW7x4Mv+7sTWBs1ORDSenvPVarHUaSzdEMvrKOR6UffWtHaZS83uZQar
 O7CkpTHX7F8yNKowdG13aWNP0trJs6mh88Tj1LqlhuKvj2Lw0cmB3eZ8m8o/0MoSSaai
 DLI6fMkbiNuYHFLm2SWwrARu39qrNnVc/99DkOJ89weNB6KKkeT7PJfzomeIUywGotLr
 0QETPTm18Pg3YtD2+YcY44sGg2E3fG6x+CNsub27ldV+uBgFkAeBS0RUF6WaLWXKHVQF
 0eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694948629; x=1695553429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAmjTbvoInQNMs//cAAOELgT9qBGcW1dL3il82kAKVs=;
 b=ELEIxTo9qDIaeJOE3iWFRsVsJ+oKZwQ4caXpZiC+z7Y91H9S/ZBR/5++mEiAm51pi3
 8KmsAeBhUnlOpaX3XNEP/uXd8LOReHtYs0jNgjn9c03xVwNU6lGi+9vlfUaxL8SMBwEw
 p4VEwxD1uii1iWYRCP5MbMiIgVsEk4ICvUvs850+z+k2OFqCDc7faNp3af1HsfwtvP3g
 wdb9J0vEsHNmlKWKnuXjAw2Xd05B62GfsfqWLvXvStU3UEd7e3mXn2aHIjA3/BCPmSbD
 TEuUPwvXSiLBvJVb+NzxFbyJAf870nUtTrSLYAcA5HyrjRBntEh0W2t0EyftbKxwB7Tw
 YzgA==
X-Gm-Message-State: AOJu0YxVChAJXCqI+lvNDyEqwYutSrlYtbX526mmZzzVZL/NabTmbrL+
 1ZhcOmkVPyjMbmSa7SHYQ95IS8tafnxc3F8OIg4B2w==
X-Google-Smtp-Source: AGHT+IEclTsVar1QZ1475dUrA8F9eKluQLoz327p0AMeRrQv47lR5eZho/yVVo0l7QRjGpXdcgZBb+xyPqdVWIRFNCA=
X-Received: by 2002:a05:6402:8cc:b0:528:88e2:7ff2 with SMTP id
 d12-20020a05640208cc00b0052888e27ff2mr5735088edz.1.1694948628388; Sun, 17 Sep
 2023 04:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-18-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-18-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 12:03:37 +0100
Message-ID: <CANCZdfpG4krhQr9FB5ZLXcL4twn3bjWf4aYQw+7HkYb7WejbBQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/23] bsd-user: Implement mincore(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e8768e06058bfab7"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
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

--000000000000e8768e06058bfab7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:42=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 27 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000e8768e06058bfab7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 14, 2023 at 9:42=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 ++++=
+++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 27 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div><br></div><div>=C2=A0</div></div></div>

--000000000000e8768e06058bfab7--

