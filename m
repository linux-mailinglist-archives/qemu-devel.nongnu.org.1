Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C781386E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 18:25:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDpR7-0000dp-6s; Thu, 14 Dec 2023 12:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDpR5-0000cm-2z
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:23:47 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDpR3-0004Vp-1m
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:23:46 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bf4f97752so10838915e87.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702574622; x=1703179422; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UKra64iSaSeFV3LQpsosShbMK65VZiJ0KZyiYrlx1b0=;
 b=MxDV3NCEcwzb6BktywdJLNA0HKugMOs3FoaS47ygK/J7eiVj45FYM4PhAsGPtRf5Ei
 v1reNj37T/es7U1JLNB//a6+/7+4sPgXO9oe8fwQ5u2cAWy61Tvzyc9Wunw5YWiKBMAH
 wEVhgAJDSz78yBR19cih+SEivL+jQgwfC5nPyHqVitT6PyXjKOE1Qo9wI8hMa3OrypG4
 3RgB326xL/1fGQohf6QAXPhM1xA7sw5g+rV7F+x2dkmVCvFmqLwOFiuJJVe+bp9FTVAH
 Q00O2NzNOKnYHPZoffdPpiHDFz9DAOud7Py8PQEjbA/krctJIzB5aFOejy/hHp1/F5F7
 mC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702574622; x=1703179422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UKra64iSaSeFV3LQpsosShbMK65VZiJ0KZyiYrlx1b0=;
 b=WOr1kw/ZuyVVU9llejyz86kMCEfZC2Adub8gzSjKxvO3SFHEt3dSy9dmebk0FaCS/1
 hsTxUMvt5+vOmMOYJY2vXjAHVsHYB5J4h5ofa4/F5zTTOYIc+xj36saU6z9YvSa9BQ8v
 I6zoTZQ7IOkKrKKJuL4FBrJEcHTduMcjCtSPuMmP1unvgQ5bhCPiSD161PwF4WDP7Px0
 xQwznDPHVaiHQdFlZk98PP1wEyzt1ZAJaqrVmNh4lq2FyX9UB+zlY8L6UUaHXOuZrrDe
 WQJNDq49HD8koXXMRlHwKRHJaOSJCb+xqJ0PZ6TdLU7w2QLVmU4OxKI5mjST99EHQWVz
 s+RQ==
X-Gm-Message-State: AOJu0YwyoGXuXNS7CHz/HyDkOPv1gnZoFcTtW/WdAOYWlyQX2oKC7Lvb
 P7wz9+Vn/WFUe2cIG7/A9FC9HGQaOOffgh2RKpse7g==
X-Google-Smtp-Source: AGHT+IGzVvw9ywImZkoaTXWB20HIYSvHQNWIXhev9TNiZeD436465BNSzA/PDsG7DN4einunfl6SCcsyBxHjyVQXEFE=
X-Received: by 2002:ac2:5489:0:b0:50b:e454:17b9 with SMTP id
 t9-20020ac25489000000b0050be45417b9mr4957007lfk.84.1702574622124; Thu, 14 Dec
 2023 09:23:42 -0800 (PST)
MIME-Version: 1.0
References: <CAC8KSA16N+DsCzPVE64NvqxQZZfst67prPbu=nzPTfHiFCEgdw@mail.gmail.com>
In-Reply-To: <CAC8KSA16N+DsCzPVE64NvqxQZZfst67prPbu=nzPTfHiFCEgdw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 17:23:30 +0000
Message-ID: <CAFEAcA_1+-AkM3Pt75CM4WVorDrN2btij_Cn2n_aYvKk++PORA@mail.gmail.com>
Subject: Re: [PATCH v3] fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
 boards
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Thu, 14 Dec 2023 at 11:49, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  hw/misc/imx7_snvs.c         | 91 ++++++++++++++++++++++++++++++++++---
>  hw/misc/trace-events        |  4 +-
>  include/hw/misc/imx7_snvs.h |  7 ++-
>  3 files changed, 92 insertions(+), 10 deletions(-)

Hi; this doesn't compile for me:
../../hw/misc/imx7_snvs.c:139:5: error: implicit declaration of
function 'qemu_get_timedate' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qemu_get_timedate(&tm, 0);
    ^
../../hw/misc/imx7_snvs.c:140:22: error: implicit declaration of
function 'mktimegm' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    s->tick_offset = mktimegm(&tm) -
                     ^

How have you been testing it? This looks like a missing
include line, so I'm wondering if you've been testing it
against an older version of QEMU rather than the current
head-of-git? (If I fix that error then there's another
one after it because the include line to get mktimegm() is
missing too.)

Also, your email client has unfortunately mangled the patch in
a couple of ways:
 * it's sent it as combined HTML/text, not as plain text only
 * it has wrapped some long lines
 * it has sent it base64 encoded

If you're planning to submit more QEMU patches in future,
it would be worth looking at the notes in
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches
about 'git send-email'. For a single patch, I can fix stuff
up by hand at this end, but it's a bit awkward.

Other than that, the patch looks good to me.

thanks
-- PMM

