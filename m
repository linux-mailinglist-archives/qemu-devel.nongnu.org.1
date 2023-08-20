Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DC1781C6D
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaKM-0001Y1-Lt; Sun, 20 Aug 2023 00:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaKC-0001RT-FL
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:46:06 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaK8-0003Hf-KT
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:46:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so859075a12.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506759; x=1693111559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Y0dtdHL2ulTHB5kL4b2wAK8q9r/JU2zmlzYv8fZ5kY=;
 b=XgmCcjr+2qs/AI5QwL9uzg528xe2kCWquSCVMftRK1xCmi1BBmc/7vVkZGUaUVNHFP
 7w83dOGLkTkv4iEZIpvAoIhYTYFo53YprAyE2N0i8FRyao/U7cJ9gEldH/whZsQy9Qj3
 1ldRPpXkPP/Nt1PZHFl/sWCgdOLTtm5hxr/LxLnNxNWJSr3vZsdJE4RCb2EfPTM+vliE
 HSRtFuX6F2oKsv6atacSZIxG/kwdP9DLVICV87lb5bLuhw7PjQ4VsEuIuV1Q4WspRQHb
 jiwa8ZPSJf5YQ+6pbWDSTMmoB8QDF/or6O8c8lBYyushYDFyzSWwlVCJa0zME06bdwFq
 wYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506759; x=1693111559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Y0dtdHL2ulTHB5kL4b2wAK8q9r/JU2zmlzYv8fZ5kY=;
 b=e5NAMlzsFscn1mtMVfc0+eFa5wi7gkQvKMBYbfIxPwKm7sV2zhc3q1K5EUkRMcuDCq
 tYkVPHiaaZSCjPNxb+6kFs5Pi2Umd1AYOB/ex8VuW/zfmgLBoFyzzdAaoUEVPE5i8E+1
 vGIJbtyl+lT2HTLs3r26sACe2p5889Kb/QrsC3Ox/dW2aLShKkrFlCUyntaXKHo2hY8o
 CMejOMsgjw5lw5cz7567xObfHnYmEuf9NEXiuCLPpBBafueu1G5+bg9szoOjSxIjJQNL
 +c8fkTKdHL3GP8BNOMM0Nk0Yhx0YCwuQVlKd/gSoQSLjjBSSpEqM6qwFL9FwFkYj0Xvr
 y0bw==
X-Gm-Message-State: AOJu0YwNl4HfM8Lmn/UD8o+j2fyoRf8uYUpQyPxAu++rc/nBYcyJxA/h
 hcAaHS2gSP8eshuM2MBTRWnZwJZNTxWhV9oy136nPw==
X-Google-Smtp-Source: AGHT+IEjLO8KVqM9i/zbIucfujG9TFMo67xLZi0CVymphYm3y5YtxK0DdTrdiazIVoMkqio6zq17WO7kpw9IsAlDk64=
X-Received: by 2002:a17:907:75d7:b0:98e:2b00:c509 with SMTP id
 jl23-20020a17090775d700b0098e2b00c509mr2285804ejc.30.1692506759077; Sat, 19
 Aug 2023 21:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-23-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-23-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:45:52 -0600
Message-ID: <CANCZdfob_JyoD9a-HRgeFVVGDxQC-ta_mg70+F9OmPJ9DET9Gg@mail.gmail.com>
Subject: Re: [PATCH 22/22] Add stubs for vadvise(), sbrk() and sstk()
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000027b0bc06035370c0"
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

--00000000000027b0bc06035370c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> The above system calls are not supported by qemu.
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 21 +++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
>  2 files changed, 33 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000027b0bc06035370c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
The above system calls are not supported by qemu.<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 21 ++++=
+++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 12 ++++++++++++<br>
=C2=A02 files changed, 33 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt; <br></div></div></div>

--00000000000027b0bc06035370c0--

