Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F666772A96
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT324-0001KS-W3; Mon, 07 Aug 2023 12:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT323-0001KC-I6
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:24:35 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT321-0008Nw-NN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:24:35 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so75808661fa.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691425471; x=1692030271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HkWJFcvv7HzX/+P9B1oBKExc219KhaCWc74BdKmMF+g=;
 b=ieavqA94BEAkKOCPX9xusHknIczpnODy8Y2pSgsQR2QX6GNWFQa69iLjchyay9zvdR
 yTxJYcku3t3JuBD41+IMBc/BfI6hNU1knM5vKZ9eyAKhq6QJnbnUECsfG5haweIRSLEF
 8ey10jV+Ztux5OADI9T1l2hvMZhxP6dUMMRfGxsU3RlP2xlz781FG8E2sfpcow+wSAFw
 iGrGGUhk9lw5DxeTDEy8O6ehTAUF1b5uE6wcv3QLy9aVZbs6DrS1nXC14wA026p/yII+
 YhpWsL1iTufkSU1BgUbjXAVW4jZAfvEtzxJXrhri7lorGZdIpZAL8VWRlhhm44xQtnUb
 08Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691425471; x=1692030271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HkWJFcvv7HzX/+P9B1oBKExc219KhaCWc74BdKmMF+g=;
 b=e3Uzp/XXaGdQwCP7MMGrgZXyb3Ja3AccpkjcjZHa0mlOr7LdMzowQ9Bk0Hf6s9U2QU
 pRF8mvEJeTCrOTV1cpmISv2w1lkIC10SWevf309YzXo6p0BGek4KcVABpKLcp9wFz7Ej
 JphtSNQsVq/PfRyrlgkwSAIvegUNALQubqp9ifty+M/mw5a9HjWBJUHB8XeuOq6ObF31
 l7eXxtd39rd7IttKdWRqO77j5L3i08PkMAM9sPoCL1b6AUpgIp1QyeQjE902eCFOR+2Y
 iHZgqZZguyDhBzz5q6z9WrU8GO2ncASRCrn8G0WBKvXwl1kY5t+omsCTuZhtg99zK6Co
 i6Xg==
X-Gm-Message-State: AOJu0YyVlgz5qIqerPeGmtLP99LD+OaRKQUdp9tB2/rgEwMm5yefGRFC
 3n3hgwuyIbV42Bp/41ZDTQMbAddzdpfhIwxYJvcMbA==
X-Google-Smtp-Source: AGHT+IEoGpWXq99kK4SlzSHjR3uSkfo5Uh7Ifecbw8kk7nUKuYMxnzf91lrCAyL1WE+JCWFUtXI2FxIf5WnkObYjEbM=
X-Received: by 2002:ac2:465d:0:b0:4fb:8cd1:1679 with SMTP id
 s29-20020ac2465d000000b004fb8cd11679mr6389696lfo.44.1691425471383; Mon, 07
 Aug 2023 09:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691010283.git.jcd@tribudubois.net>
 <011393f8c5be2d382955dceb7bc5d78a77b99c31.1691010283.git.jcd@tribudubois.net>
In-Reply-To: <011393f8c5be2d382955dceb7bc5d78a77b99c31.1691010283.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 17:24:20 +0100
Message-ID: <CAFEAcA85aDf6+0B=hu12K1+n9w9s_D+MyPHDqVuo8saLETa-SQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Refactor i.MX7 processor code
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Wed, 2 Aug 2023 at 22:09, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> * Add Addr and size definition for all i.MX7 devices in i.MX7 header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>   - SAI
>   - PWM
>   - CAN
> * Add/rework few comments
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---

>      /*
> -     * IOMUXC and IOMUXC_LPSR
> +     * IOMUXC, IOMUXC_GPR and IOMUXC_LPSR
>       */
> -    for (i = 0; i < FSL_IMX7_NUM_IOMUXCS; i++) {
> -        static const hwaddr FSL_IMX7_IOMUXCn_ADDR[FSL_IMX7_NUM_IOMUXCS] = {
> -            FSL_IMX7_IOMUXC_ADDR,
> -            FSL_IMX7_IOMUXC_LPSR_ADDR,
> -        };
> -
> -        snprintf(name, NAME_SIZE, "iomuxc%d", i);
> -        create_unimplemented_device(name, FSL_IMX7_IOMUXCn_ADDR[i],
> -                                    FSL_IMX7_IOMUXCn_SIZE);
> -    }
> +    create_unimplemented_device("iomuxc", FSL_IMX7_IOMUXC_ADDR,
> +                                FSL_IMX7_IOMUXC_SIZE);
> +    create_unimplemented_device("iomuxc_gpr", FSL_IMX7_IOMUXC_GPR_ADDR,
> +                                FSL_IMX7_IOMUXC_GPR_SIZE);
> +    create_unimplemented_device("iomuxc_lspr", FSL_IMX7_IOMUXC_LPSR_ADDR,
> +                                FSL_IMX7_IOMUXC_LPSR_SIZE);

This is a behaviour change -- we used to create 2 stub
iomux devices, and now we create 3. Also, we map the
iomuxc_gpr at FSL_IMX7_IOMUXC_GPR_ADDR here, but we also do

 sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX7_IOMUXC_GPR_ADDR);

below. Which is correct ?


>      create_unimplemented_device("caam", FSL_IMX7_CAAM_ADDR, FSL_IMX7_CAAM_SIZE);
>
>      /*
> -     * PWM
> +     * SAIs (Audio SSI (Synchronous Serial Interface))
>       */
> -    create_unimplemented_device("pwm1", FSL_IMX7_PWM1_ADDR, FSL_IMX7_PWMn_SIZE);
> -    create_unimplemented_device("pwm2", FSL_IMX7_PWM2_ADDR, FSL_IMX7_PWMn_SIZE);
> -    create_unimplemented_device("pwm3", FSL_IMX7_PWM3_ADDR, FSL_IMX7_PWMn_SIZE);
> -    create_unimplemented_device("pwm4", FSL_IMX7_PWM4_ADDR, FSL_IMX7_PWMn_SIZE);
> +    for (i = 0; i < FSL_IMX7_NUM_SAIS; i++) {
> +        static const hwaddr FSL_IMX7_SAIn_ADDR[FSL_IMX7_NUM_SAIS] = {
> +            FSL_IMX7_SAI1_ADDR,
> +            FSL_IMX7_SAI2_ADDR,
> +            FSL_IMX7_SAI3_ADDR,
> +        };
> +
> +        snprintf(name, NAME_SIZE, "sai%d", i);
> +        create_unimplemented_device(name, FSL_IMX7_SAIn_ADDR[i],
> +                                    FSL_IMX7_SAIn_SIZE);
> +    }

Any reason for moving the SAI device creation up like this? It
makes the diff confusing.

>
>      /*
> -     * CAN
> +     * PWMs
>       */
> -    create_unimplemented_device("can1", FSL_IMX7_CAN1_ADDR, FSL_IMX7_CANn_SIZE);
> -    create_unimplemented_device("can2", FSL_IMX7_CAN2_ADDR, FSL_IMX7_CANn_SIZE);
> +    for (i = 0; i < FSL_IMX7_NUM_PWMS; i++) {
> +        static const hwaddr FSL_IMX7_PWMn_ADDR[FSL_IMX7_NUM_PWMS] = {
> +            FSL_IMX7_PWM1_ADDR,
> +            FSL_IMX7_PWM2_ADDR,
> +            FSL_IMX7_PWM3_ADDR,
> +            FSL_IMX7_PWM4_ADDR,
> +        };
> +
> +        snprintf(name, NAME_SIZE, "pwm%d", i);
> +        create_unimplemented_device(name, FSL_IMX7_PWMn_ADDR[i],
> +                                    FSL_IMX7_PWMn_SIZE);
> +    }
>
>      /*
> -     * SAI (Audio SSI (Synchronous Serial Interface))
> +     * CANs
>       */
> -    create_unimplemented_device("sai1", FSL_IMX7_SAI1_ADDR, FSL_IMX7_SAIn_SIZE);
> -    create_unimplemented_device("sai2", FSL_IMX7_SAI2_ADDR, FSL_IMX7_SAIn_SIZE);
> -    create_unimplemented_device("sai2", FSL_IMX7_SAI3_ADDR, FSL_IMX7_SAIn_SIZE);
> +    for (i = 0; i < FSL_IMX7_NUM_CANS; i++) {
> +        static const hwaddr FSL_IMX7_CANn_ADDR[FSL_IMX7_NUM_CANS] = {
> +            FSL_IMX7_CAN1_ADDR,
> +            FSL_IMX7_CAN2_ADDR,
> +        };
> +
> +        snprintf(name, NAME_SIZE, "can%d", i);
> +        create_unimplemented_device(name, FSL_IMX7_CANn_ADDR[i],
> +                                    FSL_IMX7_CANn_SIZE);
> +    }


thanks
-- PMM

