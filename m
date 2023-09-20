Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B37A8B4E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1gW-0006zH-Lo; Wed, 20 Sep 2023 14:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1gL-0006yx-6x
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:12:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1gJ-0008Dk-N4
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:12:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52f3ba561d9so69680a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233530; x=1695838330;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bs4k3QkUuMwPUUh0q14VaXYYFakAOpr+mKwXVo1q3XA=;
 b=QRf9k1GuE9WaYBRZflMoVIkvDRYROYZmtdTefZFDGqxqNROABJLJAM+iAMOoJXKek8
 o7zlaEvXtuS2Q9SvESRookBwsyHyKNoDbJ9lZAkzVRU+ttBk+tnT9q01PYjEXMFxUKId
 UpRX6U2TH747qo1yEZ5aCsgVoOZlab0ylzeGQOFuescSLn2OdIp0rE3UZk5IapVzsftO
 Bs9ahKheT7LcrG0NaTCinWHJIHRPpMNql6x8EMkaeph2z6pmwH6xm52o5yxpMlB04lrr
 eCQL3VDAuhwDSg1yJQbkNdEMwjYOepORj8r80a/t+ejWkaadNBk2xkdFnRZTG7gAYYNM
 2ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233530; x=1695838330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bs4k3QkUuMwPUUh0q14VaXYYFakAOpr+mKwXVo1q3XA=;
 b=f4U1HzSAG6hbPG5CJ7dEE/IltnC5iovTPOATnDfCKiHMYqHgPNaJBfjG7dr1OE+FO0
 cw2/Bu4BJ9YV/U3EfqQSY3hXDvD1BFuS4mmkxtRCbj+tr8Un2p3PS/VuPLKRNGzXyy3n
 IsmFZoG50W4Qh/tdzGLlOH9Gho9L+P+rd1op/+H7h8XujIj/+Sr2ZqLnZv9YY+Iv4twH
 WSijL/GGO0CnbmlAAbt8MkL6IX4FUK92t8NRIiQmcZ0uxQMyfZccl+loHOyXPpxDOZab
 TWR5s0phGXiZJJc1KGNaDAxZBzUrHFnn18PJfGfG9wMxHQ+cIQ0vnMoy9v3KT8dEfAtA
 gMiA==
X-Gm-Message-State: AOJu0Yw5hHc1RKYDOKEnS0M7WZEu+9tUHNkWgoElPcjb+XeX3xmm9zon
 /8qCLuq1YOk6xYqEOOorTyPTPHrLxkvkHsP76aMIXQ==
X-Google-Smtp-Source: AGHT+IER1kKr53Z3GkZrRfukd2+AvAlmPSOD7js21IpRBLkp0Oz0Rwu+Cfe/6guSbHe3MyjpYB55e0lD1PVq5J1cxlE=
X-Received: by 2002:aa7:d6c1:0:b0:52f:8ca7:f267 with SMTP id
 x1-20020aa7d6c1000000b0052f8ca7f267mr4925863edr.1.1695233529727; Wed, 20 Sep
 2023 11:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-9-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-9-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:11:58 +0100
Message-ID: <CANCZdfoOsY05i0qMwKTHD0UtTDbbbSCUZwUMO5uVe0+LLkYEoQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/28] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000059ec7a0605ce50c9"
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x536.google.com
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

--00000000000059ec7a0605ce50c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-proc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000059ec7a0605ce50c9
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
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.c | 54 ++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 54 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;=C2=A0<br></div><div>=C2=A0</div></div></div>

--00000000000059ec7a0605ce50c9--

