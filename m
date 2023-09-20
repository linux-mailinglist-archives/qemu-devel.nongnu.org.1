Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9857A8BF7
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2Bx-0007y9-HJ; Wed, 20 Sep 2023 14:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2Bv-0007xw-Rw
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:44:51 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2Bu-0005Ji-0W
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:44:51 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5310aec4121so42088a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235488; x=1695840288;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sDn0UmupLzS8JVs85rxD7Zb1zynXA9xdUhSUBoVrk3Q=;
 b=BCpOsfpRVSHVEtS78+PMeLIRtarxidTodkEjRarZkjKV7aOM3JXSWrmCtFV7A2C7jJ
 ryuNQF5RRMpPYjbspJjNrpCTKdr/YsYvyAit6QUlCtcRcFsOO53ZjU4Ja6hIcd4l5dFf
 ZKd2+rpNC6HNh8MMHGHN6IQmbJfeMj6KvFFuvMjyYp7wQecaRruey92wdlA8ujMKr0Ad
 hDHxUBxoQoV3XYdXbO5GXR2xOfwt9prJwwZcgGhu1MyVJTBAT0CeFI6ucz+h91CpVaFE
 /3PvRuqbgTlyBFuM107J3YT2U6lassjpnckq7rVcu/GlUJ4q7FZsUsjoHPBYdaxgOZV/
 PAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235488; x=1695840288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDn0UmupLzS8JVs85rxD7Zb1zynXA9xdUhSUBoVrk3Q=;
 b=NMnmDw66suv9QV5ZgqYVf9HIh6q+mAJ8osLAouwiBUeNp9fbV027wsRjsA1uAiPZJl
 TrQv7Kk6eVslFcSv7g+oZfWeTSivi3+qYYGtefyILjKfScg/gGE+yKwtxByVGRcejBRP
 MobhsRIO4vOd0FrpfxsNBTkZ7iQ5mBvFqTQf1NuVKNzglVcTkV3GdIvmdWeF8VPO07ko
 K2W6TenNSR1HgrvVCFNUjj5Y2h7gJtNn3HoCjUxiSNe3acQxlwTQA9bp7+jH04+S3E+k
 3yy0UEGKLDCegeqrRtRYkXwh65JzBsr5rIukGQS3l8gzswrtOuGziKmPR7MEAT0XEuAT
 uJRA==
X-Gm-Message-State: AOJu0YwMe96TEDycmuwkziSBCakFSyreEnX30ePgH3D7nl+1GQbUqkmn
 vP+uiU2zGTUam6dYH9aPsoT+VA+9pD2oEWkz6qJZ8Q==
X-Google-Smtp-Source: AGHT+IEoUnG5gdnsHVD+GCN1/S9v+GBnZrOyA7hOsb8QDvhKx+nwXstBd3x3OH32am/X/Cqm2+77IisPTVeaxq9Mk6Q=
X-Received: by 2002:aa7:ca46:0:b0:523:2e30:aaee with SMTP id
 j6-20020aa7ca46000000b005232e30aaeemr2682402edt.32.1695235488542; Wed, 20 Sep
 2023 11:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-16-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-16-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:44:37 +0100
Message-ID: <CANCZdfqr0Ftr3TkXHrJSsdmm=0KOm1OwXELVXZHwD7dPqf5ogQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/28] bsd-user: Implement several get/set system calls:
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000001b07930605cec5bc"
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

--0000000000001b07930605cec5bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> getpid(2), getppid(2), getpgrp(2)
> setreuid(2), setregid(2)
> getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)
> setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-proc.h           | 90 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000001b07930605cec5bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
getpid(2), getppid(2), getpgrp(2)<br>
setreuid(2), setregid(2)<br>
getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)<br>
setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 90 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++<br>
=C2=A02 files changed, 150 insertions(+)<br></blockquote><div><br></div><di=
v>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp=
.com</a>&gt;<br></div><div><br></div></div></div>

--0000000000001b07930605cec5bc--

