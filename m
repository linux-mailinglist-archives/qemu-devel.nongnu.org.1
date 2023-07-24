Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754875F81C
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvV0-0008QZ-Np; Mon, 24 Jul 2023 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvUw-0008Q9-CJ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:21:14 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvUt-0006Vf-MV
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:21:14 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso6597156e87.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690204869; x=1690809669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dK7waTjuWFHh8P51bJcv1/b8UG+vXey9SiZAFKsNIu4=;
 b=yry0XYGZezMN7pnmHNibdr2YngmkI8SR/2jKvN4rTwVLI8/hQgizLEcDPhtYnNgTRi
 AoyvHc6a+FMTa2dAW1cpvsCqnQSWqpUkpYhjh3hOYmyMdczAb+c+sWAqYIoCA+d/I6OZ
 vpdxuulE2nFkWHAWpBQQdhL6ujjJxlKvu/OvXYTZiX3grDWU46ELzK888v7NxUs2FRVr
 BchsT99R/Cu+RygeLGH4qSri28N71zwLEnHdhLTM2zb3LDyHJCHaUNzQXrgz+M1REjZ6
 c+osfZNJxJHCkTJkDi60ouHiuy3UGVusBR9+SCEw+GZZq5xN0Lc90oZTkVuKEbYQEmoi
 4/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690204869; x=1690809669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK7waTjuWFHh8P51bJcv1/b8UG+vXey9SiZAFKsNIu4=;
 b=NxqqBeoz6d0yLRT0uO9UafWlckULDMPRNSM1eV2Zs3h2bS8hHOjba9c1NZHzc5OWMM
 JTiPfkASdJlsf9493Mz/ocRbcQ0JJIw5a1YXijTaVmB+t25vbjvq31Znv6hxo2fSFomn
 MeNyclHaNUS1A3aKPIrb892Gxx9l2I5XC5R1Ji0hQyP52lTYjAauFBbRQ2WE3Ffxm1O2
 EwTa8r1MQiZmQY0KypAbBQwhVFu6d2elznHJoNiJZr1KiO4Jqbd7jzYRoPIj9EliyPE0
 0XHih+GSz+nbjI7Vo4qNiWC3z436ah5MrZAzkB8+IApto2u+pa5vSno8zRRbZ22tvf23
 TdMg==
X-Gm-Message-State: ABy/qLbydmEYGAh0XRQYr3DqWwaG8HHgbcwp7bdud1wz6Y8Fe4Iqfujh
 e9ZiU/KQx59NDjmZSMopPRprUAlGurgQnHNBnCXSyw==
X-Google-Smtp-Source: APBJJlGRkHmbFTbIfenhRzcFx/cqCbCILzlmlQLVW05mH0ykE1/zQPQZBBzxwLblLe2j2+7lIMlVC/jhKAzjWAyD844=
X-Received: by 2002:a05:6512:32cf:b0:4fb:7626:31a8 with SMTP id
 f15-20020a05651232cf00b004fb762631a8mr6363913lfg.27.1690204869495; Mon, 24
 Jul 2023 06:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690045088.git.mjt@tls.msk.ru>
In-Reply-To: <cover.1690045088.git.mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 14:20:58 +0100
Message-ID: <CAFEAcA9jt0p6t1=TA1zK-nmQOSi27yaw7-r5Fg+fOp9n=nn89Q@mail.gmail.com>
Subject: Re: [PULL for-8.1 0/1] revert "linux-user: Fix qemu-arm to run static
 armhf binaries"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Andreas Schwab <schwab@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Sat, 22 Jul 2023 at 17:59, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit 4ea3fa99bebe8f153e74cf625980183cfd2238f6:
>
>   Revert "linux-user: Fix qemu-arm to run static armhf binaries" (2023-07-22 19:54:22 +0300)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git/ tags/pull-revert-armhf-brk-fix
>
> for you to fetch changes up to 4ea3fa99bebe8f153e74cf625980183cfd2238f6:
>
>   Revert "linux-user: Fix qemu-arm to run static armhf binaries" (2023-07-22 19:54:22 +0300)
>
> ----------------------------------------------------------------
> Revert "linux-user: Fix qemu-arm to run static armhf binaries"
> ----------------------------------------------------------------
>
> Michael Tokarev (1):
>   Revert "linux-user: Fix qemu-arm to run static armhf binaries"
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

