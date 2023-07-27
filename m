Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEABC765A5E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP44V-0000BK-TE; Thu, 27 Jul 2023 12:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP44T-0000Al-S6
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:42:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP44S-0004oT-Cl
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:42:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fd18b1d924so11941655e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690476155; x=1691080955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TIyxuEBMmrQuRgDOalt0BNUhwLpABLdvgEFEdTgqM/Q=;
 b=YCqOaomLOhpYB3HjvcUzWmuzTfo0LhQ8SalXIwPzOB2OF6xKV6riQ59TGfBoDfqWyf
 7rYbG28a/vB+GCrg1OJYRAxadaahT5HmEcOiMJnybkiNeeO37qjtyO6BWC6z9ILI04NX
 S0Lyc1EuuXCrcdTwu5W7NqkSP1PGiZLZb/+F0Gez68VLlcRsiAJy/gyu+oj0kAse+4gI
 vt78PJDh/bFeVlyVThwhc9/lBpnuJ6Zo7XS+jtmTkLuWpQTUjVGWXvTaIspKHUpcpBlo
 AEH7SVwPcrBytjb8zGm+R2lnYi52ie3IPsruxs9QE+SorgXC4+GajUSPKa6E/CaTeGLb
 b22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690476155; x=1691080955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TIyxuEBMmrQuRgDOalt0BNUhwLpABLdvgEFEdTgqM/Q=;
 b=Ay1AvjcsNHUwFykwXd6gROHNP9+LEqmmB0hMN1qM0dgiSRubriFf4yx/GfOEd8uF15
 GkomlDAzR2BKRr06dBeyL3fqVU3cqVilU6yUsO48YagB574u/rrA80Qay9+miemfDKOA
 ihqCwPFq+/Er2m8W2oc4AoIzyI4nL4ezEcpgc15Me6ZFc7jDJmi6PEKoWkthBRxlXGmZ
 utkRrJsWSDK6DlDnnlWVXjJ/qtCJECu4ojoDuE+QypbBZVGbqMecmlNsgzYEuNSzS9CD
 Q4IlGBOn9zaI9ka9+ou3sBIUcRPJEb5UBDxMjDAolB7hjb9wqwwJRyotGKjKzCdnHfYK
 RBhA==
X-Gm-Message-State: ABy/qLYRtGIl5dWDO0nviWe+H+tk7Fh6ftCLXHBpYCl7vJHL8JUjJU90
 A5KiMPgrIW+g+Z7EiE3EOdFzdE+pkhyZ7e59nsH4Zg==
X-Google-Smtp-Source: APBJJlG/VeW3n98YwL7YK/mMLtl8kKeWnzlrnTxPAW6hqoD3JgmBoE2RoNa77uZYixHJFrUC22yv6tUAPAbEbgy5y7Q=
X-Received: by 2002:a5d:6e42:0:b0:317:71bb:7ccd with SMTP id
 j2-20020a5d6e42000000b0031771bb7ccdmr2130008wrz.52.1690476155026; Thu, 27 Jul
 2023 09:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690385928.git.jcd@tribudubois.net>
 <9c780f2b9893a550565725e1523885ee80835bd3.1690385928.git.jcd@tribudubois.net>
In-Reply-To: <9c780f2b9893a550565725e1523885ee80835bd3.1690385928.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:42:23 +0100
Message-ID: <CAFEAcA8T=jrR0RMvTdKSqZ-aSRe=aZvsBGgKrbnr5yr-+VU-Qg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Rework i.MX7 device implementation/instantiation
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

On Wed, 26 Jul 2023 at 16:52, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> From: jcdubois <jcd@tribudubois.net>
>
> * Add Addr and size definition for all i.MX7 devices in i.MX7 header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>   - SAI
>   - PWM
>   - CAN
> * Add TZASC as unimplemented device.
>   - Allow bare metal application to access this (unimplemented) device
> * Add CSU as unimplemented device.
>   - Allow bare metal application to access this (unimplemented) device
> * Add various memory segments
>   - OCRAM
>   - OCRAM EPDC
>   - OCRAM PXP
>   - OCRAM S
>   - ROM
>   - CAAM
> * Add/rework few comments

This patch should have the functional changes split out from
the refactoring changes too, please.

thanks
-- PMM

