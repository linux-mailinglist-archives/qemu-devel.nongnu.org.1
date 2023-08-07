Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8D4772AC4
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT35M-0003At-LM; Mon, 07 Aug 2023 12:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT35J-0003AU-5L
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:27:57 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT35G-0000g3-PZ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:27:56 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso653550066b.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691425673; x=1692030473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LfNDcKRuOI+hL1JSklbZy6mFmwyJGqRAyiMRERzAUPM=;
 b=vv2/XwURNxoLRMaV6ALFUARru+PlUxu5NVBeVRIggdJeft5O6eMtH/mbP8pKx1IXvs
 fEVGgoqw52WP9pnGzJ23n4+FVsW+ougYx/HluLGBke65iUCow/fihFE6AAwuPPb7Oli8
 5YDZERX6svg9bZQa0U915pXVlWg9r2RlQ4BJUm+nSHim35So5xgC2K5BcYtdPfxQjnCe
 8kpbENjcNtfZpsL1hvpnWaqHvrbqvHCbmyWnZ+Pix4/H94QEdZadixUVqHVUYEQKtHl4
 pGythOEqsrmX1rv+jHKEfYe+e9V0R8jwro5pd2bpwn9piC5ivJ7vxBQI7kP2geZaQuxb
 Qupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691425673; x=1692030473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LfNDcKRuOI+hL1JSklbZy6mFmwyJGqRAyiMRERzAUPM=;
 b=PtxXpANwJYErLjz+5YWgeSLW9M9b6bTtIRYwXUe2XtK/xCsYaLmYsaIDCwFW2kdOBM
 TZ0M2/9PeVYdFKGlKQ3S/px0jXHE9+2sV8rFiI/TDF0670tQfZwuC2zxQz6MVGpRLNuP
 iI5rGNaQLkkPszhk4Etxm1RW5y44QTVrXe2Xx4PPVRboB2kQ2gR6zDFYl3BfnS45qxaB
 zChMPGxLdRm9BNy+Qcsa7Oy+pseXvjLRDDteW2bVpiJSUioayBG2lJ/9wpu4GNG50I9l
 poSalPmiitBYbrsNNAryG9NYz+Nr/Wvn3U9HDzA89+Wiu9G8lcxEzmateon4U5KvI4qd
 9K/Q==
X-Gm-Message-State: AOJu0YyZHw6qdaf+NdkgH1Uk214dIChBYjwvnUjqpMrUk7pVEfhns4xP
 94xnTNWSPoueDzyZj2HMBMtAe2TBCTZYw+YHKCyO6QZ4fqGUU/+m
X-Google-Smtp-Source: AGHT+IGyG0gB+wqh3ymzZKz82r7OP8SRRTIo8ar9cKzgoTdAjTXT9R9XSR22S040v0w+bWtxzS5/Ucd05ZAhXO9O8HU=
X-Received: by 2002:aa7:d049:0:b0:522:1f09:dde3 with SMTP id
 n9-20020aa7d049000000b005221f09dde3mr8423786edo.3.1691425672801; Mon, 07 Aug
 2023 09:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691010283.git.jcd@tribudubois.net>
 <649a1160b36c58ea89daf02a11b12f2dff164fee.1691010283.git.jcd@tribudubois.net>
In-Reply-To: <649a1160b36c58ea89daf02a11b12f2dff164fee.1691010283.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 17:27:41 +0100
Message-ID: <CAFEAcA_ZS81+0b6tsFxmNNaRCXgUC3HGFSfmyjF-1BnAv6gphw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] Refactor i.MX6UL processor code
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Aug 2023 at 22:09, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> * Add Addr and size definition for all i.MX6UL devices in i.MX6UL header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>   - SAI
>   - PWM (add missing PWM instances)
>   - CAN
> * Add/rework few comments
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

>
>      /*
> -     * PWM
> +     * PWMs
>       */
> -    create_unimplemented_device("pwm1", FSL_IMX6UL_PWM1_ADDR, 0x4000);
> -    create_unimplemented_device("pwm2", FSL_IMX6UL_PWM2_ADDR, 0x4000);
> -    create_unimplemented_device("pwm3", FSL_IMX6UL_PWM3_ADDR, 0x4000);
> -    create_unimplemented_device("pwm4", FSL_IMX6UL_PWM4_ADDR, 0x4000);
> +    for (i = 0; i < FSL_IMX6UL_NUM_PWMS; i++) {
> +        static const hwaddr FSL_IMX6UL_PWMn_ADDR[FSL_IMX6UL_NUM_PWMS] = {
> +            FSL_IMX6UL_PWM1_ADDR,
> +            FSL_IMX6UL_PWM2_ADDR,
> +            FSL_IMX6UL_PWM3_ADDR,
> +            FSL_IMX6UL_PWM4_ADDR,
> +            FSL_IMX6UL_PWM5_ADDR,
> +            FSL_IMX6UL_PWM6_ADDR,
> +            FSL_IMX6UL_PWM7_ADDR,
> +            FSL_IMX6UL_PWM8_ADDR,
> +        };
> +
> +        snprintf(name, NAME_SIZE, "pwm%d", i);
> +        create_unimplemented_device(name, FSL_IMX6UL_PWMn_ADDR[i],
> +                                    FSL_IMX6UL_PWMn_SIZE);
> +    }

This looks like a behaviour change -- we used to create 4
pwm devices, and now we create 8.

thanks
-- PMM

