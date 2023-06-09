Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172372A4FE
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7j3Q-0007Ci-5I; Fri, 09 Jun 2023 16:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7j3O-0007CN-7M
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 16:49:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7j3M-0007Mq-My
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 16:49:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-652d76be8c2so2331185b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686343787; x=1688935787;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hV+JsGhirEW8FdVQGSUv1SQIoavraJHJWFX9dxpTag=;
 b=B7qnNMyKmGWljqjDOw8XctGJoOzKxkebk1+qEfW+D+oVNwaYlxCM7Fd/3SfLy1U2Q+
 l8Op8JEcfOajkzRgHaAWcGNBTg3pKpP0SqK1j8oIc340C0yZ6XaIj/7ul1B8YZRI6vZP
 KiU1F8cgf33xSNhw29Q7Cpj0OcfbWtu2sehQPm9OEuc5ji9q71sna1+okzPWRDanyYxI
 QQF1Aef9FJr0vvlwTdvdVj4uzIfvmS9h23zmVkW7TToaNANzvl4EqIEfhueuyaw3S6yM
 ob/W77YdNCNeNJ5xM9NScKAAo86nls3228kOiCxndVTrKa+MsTAmdbRUNWJljTWkw2SU
 gp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686343787; x=1688935787;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hV+JsGhirEW8FdVQGSUv1SQIoavraJHJWFX9dxpTag=;
 b=GsJvBiDPVfAzPgNUrD7q73/AaEt/1GYcLKOq4wc406c1RopSLrptWmhH3y3vojjQNT
 HCg01WFkl8DPgO7cKsoZZwMFSANZHZAph3TuTn0ASIYn20373Vy3PtLZKgz4/WW5v5al
 McYluWrIw3OnQDJ1DI6CTrHBezdNAy0OrOoBkEIqFGVhSCQjsqIctxdMmDfP/emTG3kc
 JwiPlS2kA4JDV1+WBnXbZWClrFu42fmqbMd9omLNENKmgG8IKvXhPmbCetiNfEszLE+C
 kDleY4DQjLBpA/8MtxcQa4Q2rXd+YAGmQJTa+FMGYbxY65hsXufIultUykzZ+u60p1KX
 TKmA==
X-Gm-Message-State: AC+VfDw5TTVAKIGzMkzkAsVHG+hQ4/RPn1hwx/COGaIl/wRCgENsd9Gr
 sYCm0P1RO+9MGisSvPIsaDglcQ==
X-Google-Smtp-Source: ACHHUZ7X9zRqf7jIQ/gWhbbR4zvEJ4Zh4DYdqWddwCAcsy9TOUbXGpAVV6+HGPrqzWyPVG2PuN4UMw==
X-Received: by 2002:a05:6a00:138f:b0:663:716e:e752 with SMTP id
 t15-20020a056a00138f00b00663716ee752mr2824969pfg.26.1686343787161; 
 Fri, 09 Jun 2023 13:49:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a62e114000000b005d22639b577sm3009775pfh.165.2023.06.09.13.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 13:49:46 -0700 (PDT)
Message-ID: <a8db353d-b258-c856-d5ce-1236b0893a53@linaro.org>
Date: Fri, 9 Jun 2023 13:49:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] target/arm: Add ID_AA64ISAR2_EL1
Content-Language: en-US
To: Aaron Lindsay <aaron@os.amperecomputing.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-2-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609172324.982888-2-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 10:23, Aaron Lindsay wrote:
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -847,6 +847,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>           { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
>           { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
>           { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
> +        { HV_SYS_REG_ID_AA64ISAR2_EL1, &host_isar.id_aa64isar2 },

Sadly not defined for MacOSX13.1.sdk, and it's an enum so you can't #ifdef it either.

You'll need a meson probe for it.

Otherwise, looks good.


r~

