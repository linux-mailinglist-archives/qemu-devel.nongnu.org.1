Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9016572818E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:39:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FqW-0002Gk-ES; Thu, 08 Jun 2023 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7FqC-0002CZ-EI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:38:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Fq5-0007xv-Cu
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:38:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5148e4a2f17so1099202a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231483; x=1688823483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JWPM0coYAwF+P1JPUn1ZunbnoWAEakvKFYNJSePMiSM=;
 b=jTX7NOsweJLfZEvLkQpC1XK9RYp23LI/rC8nOTnH0SVJI6Ul7gcIE0oUFuYdTR1hZw
 5gBqGl5HPBEy4XZJZSRyoEalB26j8QwgyWaq5+cpfvEQu4L0peMikgj85NiGX7qQQCZC
 HYpE97q2IQWdq9fYr7ejvWYRQuQeo51PW1wCRlkGhjAmVoG5Is9XDCopQgkPEz6RAvKe
 7pFZdwJt1RqH4UQzupdNrmaOZLFNdk+WEdKOyCt6Gkuco8EbZh/yBWqf8tDODkZ2PZDJ
 UWE60x+d4xXoFy0eSfSXjGrCO+Vp+UvP77Siu12/8aZysqUuvVpTjenPk0ZEx4JhAJ5Z
 a5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231483; x=1688823483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWPM0coYAwF+P1JPUn1ZunbnoWAEakvKFYNJSePMiSM=;
 b=HdWSriGOLUrxS9+6Oq/P8BH7RXt3d5g+B+/+7dqG3g26gyXUq44sv+qNm59Pnv64EX
 eaOQ+tCrwzmgLgQ8plDtL03R5mTo5JR7jFZOgxMeD2YT+HYNq8hvb0xFjybx3zNeODGf
 cfJikCGLWNRnECM3HFqszPzEvB1c5eJeXJWqncOvrQMc9ZMMbhitiKWrE3qQ3xK+RxVO
 186Ttzbm/0ipYZQTHCtTnLhXvafAmpgmKpP1xk9PVgchwJovsZ+UnR8svq4lPP3bVcLz
 7MTLJ6JcdUPLL1FVvc8K/04/RpChjiV3AF5vKz0Naq38mkDxHwek/Smp/u6cV3T9OK7j
 sf+w==
X-Gm-Message-State: AC+VfDz9jAxjjrVB/9zdLuZAv9/mHla9tg1VhOJ8zKDaZIfTHnSiIoH+
 NSjC3d6t70cVGtTbCafpX1m2u0VMDCbuMTixc/hOfg==
X-Google-Smtp-Source: ACHHUZ6++x9po3f6kDrKzvtjaSur3CcadKeCFWE/psSvVLverSqTNU0Uo2cL1+7reP4fUtCOdjffQDa4tlYFkdYZtBc=
X-Received: by 2002:a17:907:2cc2:b0:974:e767:e1db with SMTP id
 hg2-20020a1709072cc200b00974e767e1dbmr10918035ejc.46.1686231483581; Thu, 08
 Jun 2023 06:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-4-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-4-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 14:37:52 +0100
Message-ID: <CAFEAcA_go63+_J3BKNtnXTkF1uy4351njkejGWY+R+WyFLwvOA@mail.gmail.com>
Subject: Re: [PATCH 3/8] tiva c gpio implementation
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 17 May 2023 at 09:14, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  hw/gpio/tm4c123_gpio.c         | 372 +++++++++++++++++++++++++++++++++
>  hw/gpio/trace-events           |   4 +
>  include/hw/gpio/tm4c123_gpio.h | 127 +++++++++++
>  3 files changed, 503 insertions(+)
>  create mode 100644 hw/gpio/tm4c123_gpio.c
>  create mode 100644 include/hw/gpio/tm4c123_gpio.h

Again, TI are quietly reusing the PL061 GPIO controller here, so
we should add support for this variant to hw/gpio/pl061.c rather
than defining a completely separate implementation for it.

thanks
-- PMM

