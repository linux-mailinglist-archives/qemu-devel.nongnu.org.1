Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED77A3527
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 12:36:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhp8J-0005RQ-IY; Sun, 17 Sep 2023 06:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhp8H-0005Qv-6S
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:36:05 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhp8F-0000gW-EE
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:36:04 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so5967586e87.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694946961; x=1695551761;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emA1XaUx5aT41G94MNd+ejCP14CKISKMwqtAy5t9h3c=;
 b=uRYOncvhlFWYSQRG3rwFmbWyyW1Y7DZdjnRDyTFDmhirBRaRJde5b27FGEMBAL+qGw
 wigASP0gNKFduut7hJtmm2RlUAqvadd/2GHrNawvpMte/iuAlrqIzZofpkYHiDCI4jDZ
 9csm+dERX0imkWapnJRx5X6AyRbdoFMamjvIqlqqACfpa7XKnkYzY315WskuunfWKNHL
 ol9qRtcnoApmBP66XMOAtEvBHV6K3WaT7QvLs9kkwreQUJyk7qJuBKl169pVJ5TUQt8u
 G/OZy/VBlLppTi60vMFndHxgOrxLWJFf3IlMUyChmHAuBQSHNdMSdzA444Y4VNoV9Bq8
 O63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694946961; x=1695551761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emA1XaUx5aT41G94MNd+ejCP14CKISKMwqtAy5t9h3c=;
 b=PDSrdUUSoODRc9tFps2zWMjOPFY/kyySMB15RVBDEVzLS9Xgg5yMGjOEBmKb/xg3sC
 pz3dSnB0yVZmLv9exbvI/AlHmdgOUl1H0pkhsRTAC944AUACZeKPMAHvE6imPsc4GnKG
 IKp2+F+BCBkCVRsOQ4ast/DxR350J8Ojz4KoAk9DiwOckHR9qBT8B2eq0XpTr3mmK/M3
 3e2cIAX1TIHS0LjYPL8nmrFuicGwALJsk1nyZuYEN9RbYUJKzfawStMQchCp5hKp1djl
 c0km0dCP/pGFJEOXPSGdaJiBoVCNMo7wnnbJyQgmqpMBwf6hUJZwf71Xod5JdwLXZy48
 jQvQ==
X-Gm-Message-State: AOJu0Yw+6bGelZqTwlNCTU4SwmGq0TcvmZ9SMqEcUHzpiet8J71qpLvR
 8fWVMI5EPsk7v6twA0CLhAJeZ++8KGNvXiPjZHds+w==
X-Google-Smtp-Source: AGHT+IEtYNHO4OWXDa2Eb8xUDJNLxLf/YIkQa0uEiGf7WgZnNOUy68TqdFBYaBDu7vuRI0VgMRdnLvc3QMtEJGoJ394=
X-Received: by 2002:a05:6512:3b27:b0:502:ff3b:766f with SMTP id
 f39-20020a0565123b2700b00502ff3b766fmr4098607lfv.6.1694946960882; Sun, 17 Sep
 2023 03:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-11-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-11-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 11:35:50 +0100
Message-ID: <CANCZdfpVc1oAJzrpdXSeEPEP9Bt4Ld=K_jO+yWbZyZqSenvMtQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/23] bsd-user: Implement shmid_ds conversion between
 host and target.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000008455cd06058b97d3"
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x131.google.com
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

--0000000000008455cd06058b97d3
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
>  bsd-user/bsd-mem.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000008455cd06058b97d3
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
=C2=A0bsd-user/bsd-mem.c | 47 +++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 47 insertions(+)<br></blockquote><div><br></div><div>=
<div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsd=
imp.com</a>&gt;</div></div></div></div>

--0000000000008455cd06058b97d3--

