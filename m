Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F0572A504
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7j5W-00088G-3E; Fri, 09 Jun 2023 16:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7j5U-00087l-9E
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 16:52:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7j5S-0008BW-Hh
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 16:51:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b04706c85fso11939915ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686343917; x=1688935917;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5LkCJbpSOakdaFx7ULhYJYv/yhnAQhR93g029V+P75k=;
 b=punUdi3dj7o5AhgM7n7auqIGFqjaQXyQFBFUhij+DeusTdjF8otsEuTuysqa9/FiSp
 UDjcMNCMXSSUwLLD1lSQgLOxDIv4+x/nzDRyanJtqf6MoU1Irhf4EytptxyePOCmQJab
 F/8VPjRrJo/EmORStPWqZmqk00+YGhAgqfwPJxzEx5FjUtTX3OtE3HpyMHdWBN9dA//F
 VcbuA74e18mVjq7TEe/vmmuBqAJhpOCYs1DNaWSgnDXIorhJ0QPOCexXNJOjqLVi0DHg
 KTW2tI4jm9ViYuRh6gykyJVmPpEGicpTYUNzku3KJsPyXxQSHbsoZXFxhOajAvtKjlwW
 +Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686343917; x=1688935917;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LkCJbpSOakdaFx7ULhYJYv/yhnAQhR93g029V+P75k=;
 b=GheuT3mAsBYG7P/yiT5W830IE+dWY0/j7h9YNM1rboCsYlP7ixxSFuem4c7mf5Z3UL
 6EyMUKHjd1QIx3BT6AxZ38LFfYm9QpZ+tjKJ4P1aXdd5OT137YjOFPsrAwOOy6hOXxbM
 e//AQFA+wj4z4CGJyUlgTrY+Ga+gvYt9TyekaWI/GxK8Ko9iqdJArKn3vr4/mXW1Q2/B
 1HbdAV9Gm7TuDndJ54PCUdPfETonIjoC237nqbG+qW4hgZlOV1G/+O8UVYZFWnNxcS/A
 gUMUenBiRDgN/WqZQJpFCnMaR8mtX6SVrA2IGKQZfFk+lDMdeaNIH5C6SAyKLFqBueP/
 k1CQ==
X-Gm-Message-State: AC+VfDx5QwJtANE8bZu0qFfCwtDG2fJHynfT4EFgNzCCLB/L9OfuCEYQ
 KYyyJ2bNeAR7iloCSo+2ooQskA==
X-Google-Smtp-Source: ACHHUZ4BRdqvJf7t41ocDavO2eyzeYpwvAnQL+apFtxDyHHN8PT4d07iS2FAeRE8Hr5UOf0c9emIvA==
X-Received: by 2002:a17:903:24c:b0:1a6:82ac:f277 with SMTP id
 j12-20020a170903024c00b001a682acf277mr2672069plh.14.1686343916869; 
 Fri, 09 Jun 2023 13:51:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a1709027d8b00b001aadd0d7364sm3662918plm.83.2023.06.09.13.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 13:51:56 -0700 (PDT)
Message-ID: <351b3a2a-6676-ea4a-d345-3ff3a5cf0d88@linaro.org>
Date: Fri, 9 Jun 2023 13:51:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/8] target/arm: v8.3 PAC ID_AA64ISAR[12]
 feature-detection
Content-Language: en-US
To: Aaron Lindsay <aaron@os.amperecomputing.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-3-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609172324.982888-3-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> +static inline int isar_feature_pauth_get_features(const ARMISARegisters *id)
> +{
> +    if (isar_feature_aa64_pauth_arch_qarma5(id)) {
> +        return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA);
> +    } else if (isar_feature_aa64_pauth_arch_qarma3(id)) {
> +        return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3);
> +    } else {
> +        return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API);
> +    }
> +}

As I mentioned in previous review, exactly one of these fields will be non-zero, so you 
can just OR them all together without the conditionals.


r~

