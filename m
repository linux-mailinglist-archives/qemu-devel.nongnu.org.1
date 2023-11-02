Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA507DF377
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:16:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXYc-0006lg-DW; Thu, 02 Nov 2023 09:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyXYY-0006lU-73
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:16:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyXYW-0005vM-L4
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:16:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso7241935e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698930974; x=1699535774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NHHmrHZWTpsfN0yGjjha0yJjQ2QbYwe+WP0MTPEWdk0=;
 b=K7HRb6yw/ROKf0LSbJ2vI2xkP5kg3j4rgOtOp52mQcQwAi1CDaek3HlNTb9AGfQUmK
 9sRERmaU5jFdXvFqmGcKFiqa886d1A0lnOccyYLGkTnDtPF1H0nFW0N3uR3CFkIJGKJe
 lXEDTGnFiqnzhhezKaZenbims7wisHxp16ca06iw3RJ0r3cMpqcAyp4UQ5EIl0WkGQ2H
 FGsACt5vR5vWVaQ+vvn+igNryXbCjYcR6dY9TLTRGbOFguwZL3bcr0uWFcwlbQq0Ep85
 kJGcZdrM3XV8zCtNy+mMsnsw9fCP07h9iYFtULYLGEIdwDsONxLwsSHxhZvxTg+PNxah
 f57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698930974; x=1699535774;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHHmrHZWTpsfN0yGjjha0yJjQ2QbYwe+WP0MTPEWdk0=;
 b=kw72+3s0erkUbWFIuxwtFYmqWujZ3JkBX0PtDDFIZJSkIV/msAMAd8Y6NQ13wdhykD
 yuLWc78UFQlUcBnW+QyxP8CQym3l2uv9b2PV7d5k0dx3cy4/CQVYWVKr48wmxtq/QAr7
 1Hq8Jsy9Um+hvdeop1V/LYIvxMVQ42UX7o2dMrreJY6iDySnFDD4G/QRGs8pDeB91FYG
 bZUHDNLDc2iMdRHudrnsBSedm744QPlXK7EARr7kngYj8MOiM50+VOPoqMRoaYqn21VD
 LLOpeyqSKl0oVHv/k3aeZCRm50yvIzQP7TQJBw9tMESntLn/UynSEie9dQQMKbOUbptC
 a8lQ==
X-Gm-Message-State: AOJu0YxjflFl8jXwUjhuPjzZEa30N3E7dln9xBVvpsGCLS7zz7OMWsL3
 iz4OZTKBNZYDHu0T6YO+bhnJJhnMxZOW/NFuCQI=
X-Google-Smtp-Source: AGHT+IHh496tBQIkcKz2dQN0yA+yQP+qLWX1URTZ1vHeA9hdHDhwvlDeZOZTBfuvYpBmZllM6PIbzg==
X-Received: by 2002:a05:6000:401f:b0:32d:9718:b32a with SMTP id
 cp31-20020a056000401f00b0032d9718b32amr15665707wrb.0.1698930974310; 
 Thu, 02 Nov 2023 06:16:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z2-20020adff1c2000000b0032d9a1f2ec3sm2456179wro.27.2023.11.02.06.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:16:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 894C05F781;
 Thu,  2 Nov 2023 13:16:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,   Fabiano Rosas <farosas@suse.de>,   Peter Xu
 <peterx@redhat.com>,   Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] migration: Unlock mutex in error case
In-Reply-To: <20231102091245.42045-1-quintela@redhat.com> (Juan Quintela's
 message of "Thu, 2 Nov 2023 10:12:45 +0100")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 13:16:13 +0000
Message-ID: <87ttq447oi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> We were not unlocking bitmap mutex on the error case.
> Coverity discovered the problem.
>
> Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error p=
aths")
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 34724e8fe8..8c4df60f29 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3040,6 +3040,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
>          ret =3D rdma_registration_start(f, RAM_CONTROL_ROUND);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> +            qemu_mutex_unlock(&rs->bitmap_mutex);

I see the function uses the WITH_RCU_READ_LOCK_GUARD() macro to autofree
the RCU lock so why not use WITH_QEMU_LOCK_GUARD() instead of manually
checking the error cases?

>              goto out;
>          }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

