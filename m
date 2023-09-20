Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C47A8B1C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1aE-0004Eg-Dq; Wed, 20 Sep 2023 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1a7-00041k-5F
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:05:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1a4-0006om-PO
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:05:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so28627a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233143; x=1695837943;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J91QEboFiMen/1pvw4Ee7loewVwJNSJ+cbXbuBjm22s=;
 b=xJS2CX9xv0139Wn0qy2x4zsSjpUroM3g/bdCa+v3UAQPdSSstI5nelLPHQIKqMwhKl
 1O87vMKGaNXc/PBCqUIjNwZUjJ288K7258Mq+Uh4dr2EYga0dnkcpG/GJzEtdC5d2DvH
 4vNR5gICXyTr/1UTiRjcrYxbeVr1NxO/38ZVUKZf4v7imOYgkDJ2dxLlLVPQuZ1YtkfT
 +8S24H7RfyxNklPAxChPLsGncTBzlOZ3XqGDilDL0lhehJfkXVvz8O4j3Diccqso/tL+
 02j3ImvjngYBJv/dtqWH3L/YWmoUlhmjA4sevM5YOfN1cBjdbT6t6XVX6lhptyBUV1T6
 gZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233143; x=1695837943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J91QEboFiMen/1pvw4Ee7loewVwJNSJ+cbXbuBjm22s=;
 b=uvO6O1mmGrnT2M6gzMk5IdAJw8BsDzkUYSHby2w5QaRdwH1g9kZRRJWla1WoMdLKzv
 LttAw+rhWMGdoU28T1D0mZQdqdLIh5+WjWvjeSzUraX85VWLnLIYxyNzjk8IUeJ0psaz
 VR0zN6VCf1pyY/wMjN7Yx2Vh9bjykePItMFM/RarA68xrxPGANqaEgox3KEylpM3LJ62
 oqY4N4YdDK3gpg3hGQcE5hsf1jKaWuZ0OWbvPZ8p8o2r+tnihnIjUJoy3uE5V1llncgH
 6ttusYcO0Fp/WNuiAionU1ZxVyHbVv8TRvou5Lt9FQJZHLiYWyj04wEcuKHQ5e6Qwtm3
 RXug==
X-Gm-Message-State: AOJu0YzWYTEySGXvyFTMIRH3s/BhNHSthChudhsB9yJCjOJ8cYDhfKfA
 0S47iXjNCm+Kj/x8/farPHIwqPEcgT36iTCzy1mqXw==
X-Google-Smtp-Source: AGHT+IHQTug30E3C0ORNLq9L5idLIwse6UOPS85VmALMEe5Elj+pn+VHIq0wevwt1FhOMevFUyMm9cJzRlbfWuhpJkQ=
X-Received: by 2002:aa7:c54c:0:b0:523:47b0:9077 with SMTP id
 s12-20020aa7c54c000000b0052347b09077mr2932833edr.38.1695233143075; Wed, 20
 Sep 2023 11:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-6-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-6-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:05:31 +0100
Message-ID: <CANCZdfocbkCL69mKOrHhPWtrH60Vf42Kt2SxKjsW4agBJDVAiw@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000004e0d8f0605ce398a"
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

--0000000000004e0d8f0605ce398a
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
>  bsd-user/qemu-bsd.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 bsd-user/qemu-bsd.h
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000004e0d8f0605ce398a
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
=C2=A0bsd-user/qemu-bsd.h | 38 ++++++++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 38 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/qemu-bsd.h<br></blockquote><div><br></div=
><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bs=
dimp.com</a>&gt;=C2=A0=C2=A0</div></div></div>

--0000000000004e0d8f0605ce398a--

