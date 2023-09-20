Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 432467A8BF2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj29z-0007J8-PB; Wed, 20 Sep 2023 14:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj29y-0007J0-RY
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:42:50 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj29x-00056s-9r
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:42:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-530e721f077so44407a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235367; x=1695840167;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aWDNGj+JL/Xb1F+Pblp46IOXIt8PdD+++6b2Huj7yeY=;
 b=QNySJKMMfTcOxFqItmBzAYryYCOWQg9UvVRL0KGq98FLN2a1zXKXeZ6edGxtcYOchJ
 YGUbOVFfWGUGXS61RStvx/afKHs/Yyk00t/gt4PUWVWLM3UknBt+/5wMGjNoxWYpI/TH
 7TL5Q8GBLBpJtCRfITeNHLO+Y1MsEKlSC2Ze0Q3uARB20W7JnihG12GBak3lNOjlaBqw
 lmnUwzBFYIuR2pH51LX5gC7J+hlVmbbUCPtdFjo795Zrzj5WWrG91NAt7Yctc8zhbyVH
 LVGZ+rq9APuLM1K2kMCZzfXH6Bpv15IlbvucmXBLu1xHNJknPagMawHhlifTQre5G2ah
 pwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235367; x=1695840167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWDNGj+JL/Xb1F+Pblp46IOXIt8PdD+++6b2Huj7yeY=;
 b=K+yCDyU4f1/fHM/n7sgjzD+/BsKkNkN3vpFC3UBfynLF0f/pXjZViAFYG2zwExxAkw
 MuxbhviltHjCxuddpD2GVH+UAPXXvfSbz0fCIMUDHwjzE+js7rmMUe0dd3gAsx5T8AUY
 6IZDn+o9y8bXtYEi7/iWtGFMFf/utORgkN2lNDIXV5opzIJnXna5c2r6ie7tmql8W6zV
 jn0d/ZRsCJNBXySESqwrLtbXLH2eRH/KkqYKFjE350Cnk0B3sI/P5LXdBLsi7UL1QFzG
 1+z9Dhts/vSWHSzGPxQUoy8EIn4XgnIWvVIu9ysX67EoMuZlhP8Sdf65p8fvJZwRjSVo
 AfRw==
X-Gm-Message-State: AOJu0Ywz04eAZfxVgc6J2stO52g0ju3IFfwg9zUtjD/Ca5rMH7tAw2tt
 jsnej82xPx3cVdpB4hyuvYC6e1XP+7Mjwts9Nke2xQ==
X-Google-Smtp-Source: AGHT+IEHBk//NnyijnNhpdTvuLnGb8fSEXMDTiuc81/VmZer89CZxBDGlox2j/q8P6eL29LIZuORacCggh2jOOy9sdo=
X-Received: by 2002:a05:6402:31f4:b0:530:d6e5:9229 with SMTP id
 dy20-20020a05640231f400b00530d6e59229mr3065384edb.10.1695235367621; Wed, 20
 Sep 2023 11:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-15-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-15-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:42:36 +0100
Message-ID: <CANCZdfoEF4R+4-0T005QdTOL5Jz8VZ0HKtBBcDgn=ZkN5Dhm3A@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] bsd-user: Implement getrlimit(2) and setrlimit(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e5eac00605cebdd3"
Received-SPF: none client-ip=2a00:1450:4864:20::529;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x529.google.com
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

--000000000000e5eac00605cebdd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-proc.h           | 59 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 +++++
>  2 files changed, 67 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000e5eac00605cebdd3
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
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 59 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 +++++<br>
=C2=A02 files changed, 67 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--000000000000e5eac00605cebdd3--

