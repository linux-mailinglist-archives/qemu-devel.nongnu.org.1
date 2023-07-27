Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32431765A54
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP43d-0008Gu-GC; Thu, 27 Jul 2023 12:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP43b-0008Ef-Fg
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:41:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP43a-0004bv-0i
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:41:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fd2f298712so12506035e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690476100; x=1691080900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMtpyiyPv3+t5Uvcv4Tv2aBXS8NdLCmOXzk4TsZHVBU=;
 b=nYs6nI7zVA1JckfJ+7cB0+sGRuS0zl82mJgutdvTjdvYO8BqJycwmX1KXQTgbSOkTi
 dCQhBWKPixG/VjPCGvT1SxNxH5aZf7ai+/RnzT6g7B+kytb3ZNGyL+brm67N7HynknDX
 B3fMgUsl8o3Jxn6I3vJHpxm/EkZAbQOlvaTUQ2VjM3kVykfGrEHHgrD5yA64k8HKb+GM
 jyTKeVPXjUvRw54u37fp9Ecm7jRQ4E8mOWneURvzPDIbSLs8EQ3FLU/DK7Gmxy9DJ+n0
 sqlm/LtaFa1SHTY82M1G2J0Sg6tn+dPbpB/NRtzYKN/4AxhtKbhp2WPFJUBu8LksK96n
 cuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690476100; x=1691080900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMtpyiyPv3+t5Uvcv4Tv2aBXS8NdLCmOXzk4TsZHVBU=;
 b=dRDgPmXlAiKmkwRhBd8ioDBbDcP5HhrvFDDqp+zxAx/2F7ops4IrCoHXx/SjMxeOck
 OkuZyf8sFnjrEZNpUj90NzaZ5p0QmuAv0OSFrBpjKgop3nmmPIOg31+UofPVCPz2FTgZ
 YWsTLWvLdOxiHXtzutUUk93IGcrvX6cebOBd0AD0mVT9hb9qtek12gC4WM+KB9vyPD6M
 7bqE4RhpGrk05+hr+umrEK2e4h4aGyO7XE0rMPQ64OFdffltw8m7Sq+WdPAN6FNw/80z
 nyF7l1g6zU+3DAmo5ym5T3A5bvShjfkpMZL8xMwGytiQsx0oorJN0G3/oS+TV0l+VJZN
 L3IQ==
X-Gm-Message-State: ABy/qLYWCYp1FHdjozmTqNSliryBE2nkItoFbw/J/OuOcW52pHIQ+rev
 xq+zmyWy5+rQjH3itNPAESIVOFl7V6MDMTE7fwQk/ftb5MugZX83
X-Google-Smtp-Source: APBJJlHWA5SXjqNmo4Dq5qW9RcpsXHKVXe/wZl59B/L6M4MlMn6vVMk1dMN8QedgRmVdwnP98etoxxgbDcNaC4grlBo=
X-Received: by 2002:a1c:ed16:0:b0:3fc:9e:eead with SMTP id
 l22-20020a1ced16000000b003fc009eeeadmr1969200wmh.20.1690476099832; 
 Thu, 27 Jul 2023 09:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690385928.git.jcd@tribudubois.net>
 <84ace91e6076ed4460fb6c1f9fe699660dda30d5.1690385928.git.jcd@tribudubois.net>
In-Reply-To: <84ace91e6076ed4460fb6c1f9fe699660dda30d5.1690385928.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:41:28 +0100
Message-ID: <CAFEAcA-sjHQK=VmQ4TYEY73C5vpxQBME1j8eF=ZXUkWTb4naTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Rework i.MX6UL device implementation/instantiation
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

On Wed, 26 Jul 2023 at 16:55, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> From: jcdubois <jcd@tribudubois.net>
>
> * Add Addr and size definition for all i.MX6UL devices in i.MX6UL header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>   - SAI
>   - PWM (add missing PWM instances)
>   - CAN
> * Add TZASC as unimplemented device.
>   - Allow bare metal application to access this (unimplemented) device
> * Add CSU as unimplemented device.
>   - Allow bare metal application to access this (unimplemented) device
> * Change CAAM specific memory from ROM to RAM.
> * Add/rework few comments

This generally looks OK, but please can you split
out "refactoring, no behaviour change" changes into
separate patches from "change the behaviour" changes ?
The refactoring bits can all stay in one patch, but these
changes:

> * Add TZASC as unimplemented device.
>   - Allow bare metal application to access this (unimplemented) device
> * Add CSU as unimplemented device.
>   - Allow bare metal application to access this (unimplemented) device
> * Change CAAM specific memory from ROM to RAM.

should not be in the same patch with them.

It would also be handy for the commit message for the CAAM
patch to say why we want to change it to RAM.

thanks
-- PMM

