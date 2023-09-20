Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6E07A8B16
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1Z5-00030M-Lp; Wed, 20 Sep 2023 14:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1Z4-0002zb-AC
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:04:42 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1Z2-0006Tl-Mk
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:04:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-532addba879so104556a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233079; x=1695837879;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EAqYYYfu0MjYdXcfqWjQM0dsyREPlICzMC82cFJH67c=;
 b=I8apbeXOHjC6pS5xVGKzaTqdv2Mam1RrkGsCzDuX2y3ZcY7HjxbKkbFmJ3dkuKKen2
 yGN0jEZ2MkW3kmn3u0itoHaGamWqr4t1VOhw49qDpTp92i7jrRYhE3YrEtviE5M8NIvU
 pvXcjK5Zh+RKFBBJzM6SL/XZSd9ziP6uOzN+cDEycPyeSRFPoirP95Ss+RU732Np89Re
 0Ce4UGj3s8pqrYPGUcH/8EBsHe84hKNhQTKK2+QQsinvzlHWCq3vtPzhl7yYuDByOr7+
 1VEfwtWIjZHoLmX9fLk4pQzA7UG7zXwLrt4YkdR8COZALmCwrVvob4s66tCZ6uyjWQRx
 8qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233079; x=1695837879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EAqYYYfu0MjYdXcfqWjQM0dsyREPlICzMC82cFJH67c=;
 b=oVW04yrRx6FbDN0eToUBmZgvo+VjIBHRhrg5MKp1ffur+fwZSz7e/MKMdzjOWdc9Au
 sN2yJhYM2uT7b9qEvYa43RZY6YYY6zoTes/inexe6tIOqUNbugEi8RnoMHHXyssQE55/
 siVW3BdirfwFZRR0Pt8vrccj/ghpxqVJPjMpn87VhqIQ30R1VNITsT92Izizw9nnmu+v
 +12AiY0sLUbudALiItDjBO128yoALURsoYpH+KInOsY+v9ISKjV0vDKSgkqebIPltw3z
 s+kuM3uGCblouANyAOS+fAG/3uEDIQ3jWPIS5AlVyVthOtADabZjckfjFOyYFs/7FxbX
 Fk+g==
X-Gm-Message-State: AOJu0YxkAwWJSZDFMwX1+lYr4mqlkQbD58pFZzbPCQ+UvpBs6LvqrMLh
 2NQD9EFExfE/jiws98tuf1WpIDot3wg9Fo6GmiR2cQ==
X-Google-Smtp-Source: AGHT+IGf6NKlCOIOXhqvjRjnEMH/JkNXLZfFawpP7TJstWMcOX1sWKeltfftUakIBt50fqNEKWm85tpLfRxL3InSNSg=
X-Received: by 2002:a05:6402:42c7:b0:522:405f:a7 with SMTP id
 i7-20020a05640242c700b00522405f00a7mr9529162edc.16.1695233078740; Wed, 20 Sep
 2023 11:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-4-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-4-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:04:27 +0100
Message-ID: <CANCZdfrP3mKmPruAV7EoVYiybvp4nhpavDqoJaiANcgwTr_mPQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] bsd-user: Implement host_to_target_siginfo.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000785eed0605ce3515"
Received-SPF: none client-ip=2a00:1450:4864:20::52a;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52a.google.com
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

--000000000000785eed0605ce3515
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Used in wait6 system call
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/signal-common.h | 1 +
>  bsd-user/signal.c        | 6 ++++++
>  2 files changed, 7 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000785eed0605ce3515
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Used in wait6 system call<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/signal-common.h | 1 +<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 ++++++<br>
=C2=A02 files changed, 7 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;=C2=A0=C2=A0</div></div></div>

--000000000000785eed0605ce3515--

