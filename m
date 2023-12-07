Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45173808B3A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 15:59:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBFpq-0003Ea-2P; Thu, 07 Dec 2023 09:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aziztlili2222@gmail.com>)
 id 1rBEOj-0002O2-1T
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:26:37 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aziztlili2222@gmail.com>)
 id 1rBEOh-0001gq-Cx
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:26:36 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9f9db9567so8072031fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 05:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701955593; x=1702560393; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Meg9AyBn2vmnW8bsUq2FWNQpZANf5/Enrxr3j/GlV9A=;
 b=FMBmrz+CE0OI67DMUJ8/SKYVcU4yeVjx2AvaJF4c4ngk5ejuzq9MF19nFYnwm8cP3q
 xB4mMHmjfsPyicbfx99+1zuv9y6vtuvJerM5eLJ4vlZ3LKieVig9G5Z/ytR10wY4T84s
 knUJaUo0rjONwjBtgpfoVre2swgyXIMJ8L+T2FwdxZOdrnNhuL6HInusFuPbdRl5IJ/w
 v7EHe2OBONhP1Bmtj0nq+8792ApF5US+FPo7QHpfpQqrK5kW83a/Sqmezu3eTH68sGdS
 HW6UlqT0WNCVtACNikjAUAIvwBtFHt1gM1eRx/UAGB481OLNSWT+TFHZlovIBanjjdhN
 ZshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701955593; x=1702560393;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Meg9AyBn2vmnW8bsUq2FWNQpZANf5/Enrxr3j/GlV9A=;
 b=LS9yAdl+ngJi098m4YLnS/f1TfwJyTgzpL+OXGYMki21TcGTWfNdwvDsIe2mnrla8N
 YbL+wSlQqZlLLNzDy7NmwXR3zFUOn2U9kamEpwCnBZ/B/zPhDHg0MWgV0WxzHcWMESCr
 2Vx0bsZYWin2LIAEBL09DG/nEViRCKt+mSE9rTHlz/2/MOxO/lJG8HwItrLta5BpYn2T
 ymFWXmHlYRcz9b0cRPi1s19O3eo8wgSBT+iUKObfuiUkBs5GxlQdzCVmAD11uONHgPt/
 pAI/mIbIZlOdJkLC5w2t2PsOX21/SlzmWqArnkKPQ3B8S8MCmpvyVBYg3q/3DHymdCkq
 OMvA==
X-Gm-Message-State: AOJu0YwXlsSNtMOFwdOa2jMW9NExTMWPCwZKFwWoUwT0r/kN2qt49UCA
 yuNb3UcMWTdAXQeYxl9S0ZgI6j/Nf4oLQZj/hVI1qsV1
X-Google-Smtp-Source: AGHT+IF65U/UD5Ptjt5mCJoFMiExQvvuZY/mfBgyqPq7ZDUrw+gNOLkwosaUIR7tsaECJ5mbPMGLsUi7AvrPYVAQODw=
X-Received: by 2002:a2e:80c4:0:b0:2ca:1593:6ede with SMTP id
 r4-20020a2e80c4000000b002ca15936edemr1595652ljg.6.1701955592851; Thu, 07 Dec
 2023 05:26:32 -0800 (PST)
MIME-Version: 1.0
From: aziz tlili <aziztlili2222@gmail.com>
Date: Thu, 7 Dec 2023 14:26:21 +0100
Message-ID: <CAHwHw5A6g428uTpMEQ=NCkXP7sXVfCWv5QSUw3pHfncmG-2gPA@mail.gmail.com>
Subject: Request for New PPC Machine Supporting Multiple SMP Cores
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000891865060beb6a6f"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=aziztlili2222@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Dec 2023 09:58:37 -0500
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

--000000000000891865060beb6a6f
Content-Type: text/plain; charset="UTF-8"

Dear QEMU Team,

I hope this message finds you well. I've been a user of QEMU for well over
a year.

I wanted to share an idea for a potential enhancement that I believe could
benefit many users, including myself. It would be fantastic to have a new
PPC machine model similar to the existing mac99, but with support for
multiple SMP cores for both qemu-system-ppc and qemu-system-ppc64.

The ability to simulate multiple SMP cores within a PPC machine environment
would significantly enhance the capabilities of QEMU for various
applications, testing scenarios, and development purposes. This addition
could greatly benefit the community working on PowerPC architecture.

I understand the complexities involved in such developments but wanted to
express the potential advantages and how this enhancement could contribute
to expanding QEMU's capabilities.

Thank you for considering my suggestion. I would be more than happy to
provide further details or collaborate in any way that could assist in
making this idea a reality.

Best regards,
Aziz Tlili

--000000000000891865060beb6a6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Dear QEMU Team,<div dir=3D"auto"><br></div><div dir=3D"au=
to">I hope this message finds you well. I&#39;ve been a user of QEMU for we=
ll over a year.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I wanted=
 to share an idea for a potential enhancement that I believe could benefit =
many users, including myself. It would be fantastic to have a new PPC machi=
ne model similar to the existing mac99, but with support for multiple SMP c=
ores for both qemu-system-ppc and qemu-system-ppc64.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">The ability to simulate multiple SMP cores wit=
hin a PPC machine environment would significantly enhance the capabilities =
of QEMU for various applications, testing scenarios, and development purpos=
es. This addition could greatly benefit the community working on PowerPC ar=
chitecture.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I understand=
 the complexities involved in such developments but wanted to express the p=
otential advantages and how this enhancement could contribute to expanding =
QEMU&#39;s capabilities.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Thank you for considering my suggestion. I would be more than happy to pro=
vide further details or collaborate in any way that could assist in making =
this idea a reality.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Bes=
t regards,</div><div dir=3D"auto">Aziz Tlili</div><div dir=3D"auto"><br></d=
iv></div>

--000000000000891865060beb6a6f--

