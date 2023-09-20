Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FEC7A8B10
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1Xz-000224-D1; Wed, 20 Sep 2023 14:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1Xx-00021t-4M
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:03:33 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1Xv-0006H4-8z
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:03:32 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50308217223so228302e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233008; x=1695837808;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ahFkf4ITStHBpaGbO8vMVxK0oJx9W9dbPHrvSwcO8bk=;
 b=eEPKD8qOaVxCeKcdL3EdmpiPBE1Wvvpv3Wal/IJie6DXLiqoThNnbZXWz8P6JEdhBs
 CwmfY8ROWhjGGAil6lFs1xSkzV5Df4jdx9AmKh9fFAHpDECb7/sCN2jvxc6iUDy3m6Am
 8FmDC6Ast4NTpzGxvh0QQJmi+QneLKRP3yxfem1uIkrak7cR19TqarXD4SpDBPQFx+j7
 v5a1r9cq/l7rwjrXf7c6hNVV+jjb2qZM0zzND15aGMvF9HyZc7MRjOWNfmEeHWnGe+Pj
 ElsbqYsCxwcr73PX/e3NHHUR0VaUeu4Y2cX4NKjCaUqk7CsIoY4c3GQAoKxkAeE/vzvs
 17AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233008; x=1695837808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahFkf4ITStHBpaGbO8vMVxK0oJx9W9dbPHrvSwcO8bk=;
 b=gwMtcCiFIcJSQo1W/520wQCoVKb8fIuy4F5VfU1z4hNEDGiCjqjMv24DcLppo+dwEL
 MATRl7tnIJJfuY2KKqTlphhdlizDTsRIKcHo+onMNJWbqW/OGB/G7CQxJ/2rttz6Wbpl
 G9q4v+AaLFDqCglIjaUFRcbXO0tU0DALhWMPHbwtj8871y1iyo218s9kP15SBjqHEJmM
 uqRJqbzLun5N/3G+ipdo67bGmHMLxpiVKw7/CFxcH64hppJd2Szkgarc54UHRneEaydD
 Y4BnD9TjNLqyBg47v+4T4ocC1Wowbr7ydfPW75uVDIGKKHm2LTXIvvqEQdklAwLgLix5
 ITyw==
X-Gm-Message-State: AOJu0YxAPPbBM0i5kQZh5a0OfihjmCt0fOoCVAAJ74N8xVPR1/1HMePY
 x6qIx1pj3jsXAyWOmnvAfz4f3rcoPFtClhnVUWXq2Q==
X-Google-Smtp-Source: AGHT+IE74KBIBzfP3V+PqOBN/3A4NmIFBAnw44dcpEBn5k1yd5I7Rgpe7HHVEQeUGlP8WUZsxJ2lRro8QkPY+f3TP4M=
X-Received: by 2002:a19:6556:0:b0:500:7efe:313c with SMTP id
 c22-20020a196556000000b005007efe313cmr2668429lfj.24.1695233007861; Wed, 20
 Sep 2023 11:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-2-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-2-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:03:16 +0100
Message-ID: <CANCZdfqDf_ZvMQYW-t0_Ep3GS_UH5a2tVgL7B367jVbVQ8q5xg@mail.gmail.com>
Subject: Re: [PATCH v2 01/28] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics, and fix RLIM_INFINITY
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000003edb180605ce31e7"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x129.google.com
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

--0000000000003edb180605ce31e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> RLIM_INFINITY on FreeBSD, OpenBSD and NetBSD has value of ~(1<<63),
> caculated
> one way or another.
>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>.
> ---
>  bsd-user/syscall_defs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000003edb180605ce31e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">RLIM_INFINITY on FreeBSD, OpenBSD and NetBSD has value of ~(1=
&lt;&lt;63), caculated<br>
one way or another.<br>
<br>
Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;.<br>
---<br>
=C2=A0bsd-user/syscall_defs.h | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt;=C2=A0</div></div></div>

--0000000000003edb180605ce31e7--

