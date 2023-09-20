Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0C7A8C00
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2ET-0001A9-8i; Wed, 20 Sep 2023 14:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2ER-000198-AA
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:47:27 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2EP-0005mR-Q4
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:47:27 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53136a13cd4so59331a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235644; x=1695840444;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lr02oCqBNAuGc08bNS92etXNXlQuhn20LJxqz9O7+2U=;
 b=T+1OKjowMfZqxQN1z0rEbHKCV5m4pQdAye8QhqjXKjIh/uB3Y/pAmEz4cijLAzbeXd
 aMb5+jCdxKx2ZKN9i6S8ukHdO6KAaQfXqpXb/ji1t+5141WGmI7LJIJ3nYfZPmue5haJ
 tuxoWeMJ8RXoDk7X7GXR54oZ82mCbVeLnot1/Q6WXCK4tZHXL5OlDJdyVqDvBGhCJZbu
 dq09arMg8zq/FlTzIO2C9SUBjl1vXvhb8aaxgX65C5AGAvSpDcgBPGgtaoFm2D9YemLp
 JcZMwAENhbhiMK38L4NK+jC+IElDVVrak5/91P/QmM/QbY8PFWMSqqpCdrWqR+mvgPGu
 UkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235644; x=1695840444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lr02oCqBNAuGc08bNS92etXNXlQuhn20LJxqz9O7+2U=;
 b=s2b7cPIim99i67h1snq28nVtoEK0MfiYPtd2nG8285FySl6ZCZssOknoOoSzzcpsPz
 z072+o3a607gCXOFTi5X3P7aQQvaqKIhwWavFdat79fKVUlhcRjbp49MXt5bHJF16/uj
 kv340gJFWIiJbsmRqXkogi5WECjMzY8PkGH0Ck7PIZDKhRBQFqe7smglELxky26bQt52
 cF9S/23wn730vE9/ppSAImQDO2SR/PQz8GEwqdt1LMq8vGowerTaTcOXkoh5H54Vh2ZT
 Z8DxJYsyj+1dkpzgfSjM2lUIt0IfQUIbdRpO9RYFmfpBYFHTwoaWCZSn8K3XmOJzK1KH
 hdOg==
X-Gm-Message-State: AOJu0Yzh29IM3mTGW4M5EdHXZKgjzvyVHwFoeBNZUtnmKWWkFKBUV47X
 g1WIqrfZgFd4yF9Hw08EL+DzZycJZ5U95Oymaszz3g==
X-Google-Smtp-Source: AGHT+IGRr5XE9wT9sjCkvGP9W0PtILtaNzZussFJMYLKD+cVmOJjHxBfrMcoj712zuscw56RJxW7mIp8q/dyG2FNmOE=
X-Received: by 2002:aa7:c414:0:b0:52f:a5d4:1f5b with SMTP id
 j20-20020aa7c414000000b0052fa5d41f5bmr2791601edq.9.1695235644113; Wed, 20 Sep
 2023 11:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-18-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-18-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:47:13 +0100
Message-ID: <CANCZdfpWobffr_q2kOofESFdzaruSJrnqNexNhZJJKS0Y5C5kQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/28] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000060d7d30605cece93"
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x530.google.com
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

--00000000000060d7d30605cece93
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
>  bsd-user/bsd-proc.h           | 28 ++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
>  2 files changed, 44 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000060d7d30605cece93
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
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 28 ++++=
++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++<br>
=C2=A02 files changed, 44 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;=C2=A0</div></div></div>

--00000000000060d7d30605cece93--

