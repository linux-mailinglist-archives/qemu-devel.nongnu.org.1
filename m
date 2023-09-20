Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BF7A8BF0
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj25N-00056P-Dt; Wed, 20 Sep 2023 14:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj25K-00053T-Gy
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:38:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj25I-0004Af-Ms
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:38:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-532bf1943ebso65770a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235078; x=1695839878;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+BC1lks7auCQPAOJGu31Lfa4f6/+J16WMBHcPQ5n4+g=;
 b=jWPPJL9UKykdUtTpaVMbjOkcrLnUMz7JErHzphEC7PVbKGKDQmjijBInfreQLuE8H0
 yyZnPM2DlIfJxkWpxHX+sk29q7eckNtQUBKWPycQIjMODi7AGXoxD9zX0vZ3emUsxI6Y
 qQnz0z9sRpUa2vIj3I0B9xVuQAZ6gmb8NpXf17gPxFOpVxpSzc4ZyxN3H+3jD5R5ziqR
 +CPiNJ/NcuHlicGhhHn+SNtsh3cb5FDPDcCSRKEe01c2u9kn2Zp4I0CyfXpbvmDWiVnA
 D4gOXB5wRVDAFjxdTGnFlw6qXVJRuzXVYKfctIWHJJ5iDXZxx4uA9FlXYdKTzH+aN0GJ
 aOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235078; x=1695839878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BC1lks7auCQPAOJGu31Lfa4f6/+J16WMBHcPQ5n4+g=;
 b=EgfBcwkRlv4DEL38HRtMAMu/dShAk4gE6KChv/9uBaysb7TeEEhbIpfbAPBgmQwb8P
 fVYoGQScM+XOQvO6aHlmN00LT5z0bUnSu86jyNzBaccKGSwTlKwCFEHgZPYwLsmMgstX
 hadeuqCWuor9GUITQRVkeYNAauEn4kUFeBGQ1dWbHwiiB3FxPpVupuhbycu5RnqPxRfO
 UKfC+1ApimRfKzqkaedG0AsHU8cUCc6Y0PJGjfM3IxPZmpnzv4sq7gDgPMrigMU+Pfbl
 kKMY8/35e7S6O3Kkh/gwl6xdtdb6pnePil3+77QH8v1Ghm94Yolzaa6u0+C1w94nUh3r
 oa6g==
X-Gm-Message-State: AOJu0YyQsdIBxJGlbtBq4bleREeHIafmV0+0voqx+oth5v2WaqNpCRGi
 Z/uViHeU9MP1dGRJPOlOSWbQudQsa87pirrznzmxwA==
X-Google-Smtp-Source: AGHT+IERrO7xb2CJx3d8SOPf42NUgeRYZSrQ2+3mu48qnBjT0bqwzx1wau+8bQp6WI7KJywtJsP/Bz8hKb4VoVOnZHE=
X-Received: by 2002:aa7:cf03:0:b0:51d:95f2:ee76 with SMTP id
 a3-20020aa7cf03000000b0051d95f2ee76mr3201287edy.27.1695235078497; Wed, 20 Sep
 2023 11:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-14-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-14-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:37:47 +0100
Message-ID: <CANCZdfpWxDkdJ5GJsxhnEGGhhp2z-M1n+8zEyasx8vhVJeQTOA@mail.gmail.com>
Subject: Re: [PATCH v2 13/28] bsd-user: Implement getrusage(2).
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000aa44ae0605ceacfe"
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

--000000000000aa44ae0605ceacfe
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
>  bsd-user/bsd-proc.h           | 13 +++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 17 insertions(+)
>

Reviewed by: Warner Losh <imp@bsdimp.com>

--000000000000aa44ae0605ceacfe
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
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++++=
+++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 17 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--000000000000aa44ae0605ceacfe--

