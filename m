Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A567CC49F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:20:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjyP-0006Pk-0I; Tue, 17 Oct 2023 09:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjyH-0006KZ-CR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:18:58 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjyF-0007Zf-I9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:18:53 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so4729533a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697548729; x=1698153529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TV3do35AYxXbSAgiBkVm5/JXEuDeVl43xHLj4t+2gX4=;
 b=X6l3hUFq8mzRQRYWXziK0hl7dw+hXyGLSwKY+ZYgx4cAwWM5wGBsHloulcUctyioBE
 qTt8XqlMSqn/SRRv/E2gjqzL1eHGLdTc4Xhk35Yh9Ekv93ZDjNNpmQ5lThbiJQaANxhJ
 ZOvu7fN7UrmeSYBwgQkrFznWz8blYd5+SOE0xQdnYzwM10VborYYMW36roEXqxAq8eK7
 LYsnKR1yLGxm0PEmOiRcrkLT/bt/Skx4lUJwiTPo2VG+nsTZXKUxxOmhXCP+o5xbNZiL
 ICIMK/Ps+rK8uZKc2WG1Mm8eUEVXCA9kcfSjXG8GB7WUQF7XEjg+Z9rGB6kf/4ztiOeb
 siZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697548729; x=1698153529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TV3do35AYxXbSAgiBkVm5/JXEuDeVl43xHLj4t+2gX4=;
 b=SNOgyNBq99Em+tnYsD0CtAMHOvh3YTVp2wdqdKH2QosI8e5X2h5gwijs/Z0qya/R/j
 olAtGqbcXD00mlrA15hmQrOjp2j/M537SbCAfy7WOQWUc9oCS32lfJeDkhs/8q/9VHBe
 Kem/hW2nVMcLcSwKXmmTwqJPQRN3JGOxChBVPyqxREUbxVrQqnGWSJDZtSIkx7z8l2j2
 10w11Wzw+P4wBhOxjWGhQPznnqonMmkJpV/at1bfdVafDtw/VEOwJoNt66i1YxCNsC58
 InQV5/UbcnRr2MpPMAcz9zNKg/7RHrroywAXLfQFlOm1Pm88okfcETkjQsBLNHD+Ud2a
 FBEw==
X-Gm-Message-State: AOJu0YwFfJZkuk3Fu4xa6tMHIIvbxijk7Mt+UOiTlY6mmkl7GDp3uvxF
 8cLAOvZ8ZWdNv5t5Y2At9eUiaE3ZFAHClQaNvSP33w==
X-Google-Smtp-Source: AGHT+IGWCIkkRvDsucn1VV5dbdbyf6hVSXB/SJe/n9YNGHCAfDSFtMRsep2O8w7Jl6mUnQGuiVQoH3MKsVyjl32/32k=
X-Received: by 2002:a05:6402:26c9:b0:53d:a3ff:460a with SMTP id
 x9-20020a05640226c900b0053da3ff460amr1863833edd.27.1697548729393; Tue, 17 Oct
 2023 06:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230922181411.2697135-1-crauer@google.com>
In-Reply-To: <20230922181411.2697135-1-crauer@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 14:18:38 +0100
Message-ID: <CAFEAcA8XY1_W9YPtg1NOPYmEyL1H8AS9nT-BTXZGrNkjFBW_dg@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/npcm7xx_timer: Prevent timer from counting down
 past zero
To: Chris Rauer <crauer@google.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 22 Sept 2023 at 19:14, Chris Rauer <crauer@google.com> wrote:
>
> The counter register is only 24-bits and counts down.  If the timer is
> running but the qtimer to reset it hasn't fired off yet, there is a chance
> the regster read can return an invalid result.
>
> Signed-off-by: Chris Rauer <crauer@google.com>

Applied to target-arm.next, thanks.

(As a side note, if you'd used the ptimer countdown-timer functions
to implement this timer, this is one of the corner cases that it
would have got right for you ;-))

-- PMM

