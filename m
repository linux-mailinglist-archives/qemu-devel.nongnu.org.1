Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9559C72A3E4
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7iDc-00072I-5l; Fri, 09 Jun 2023 15:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7iDa-00071y-A5
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:56:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7iDL-000352-OY
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:56:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-65131e85be4so2254483b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686340562; x=1688932562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Gg23vZroQxETI6pay6anvqx8zAzvFM1fFWvUKvVTHs=;
 b=hqEUl3Qkg/8XlWhKUt2qh9SzMuY1sTbS+aGEDR3o8zWrt8QI3jlrC9lqzFqYwCuf7k
 Lu6g36tRymK4gCMGH93nxngTFBlB5de3jSgtAQcN6inhZotNwUyguUWU9o9qb3Hp/Bv/
 IDN7IXNmjwGIDneERKt5595UdmJktgSCCo27wQ+GVurA3tdfL4iY9bI+W81azohXuipR
 1k3rLFLuf3G/NrXn2CRBG87vbV8UwlpOQMQPE6jQB2gFWMrA5u6QpovDXX4pWfOVeHv4
 1slPW6BrTqCcGSdXetD4zlH9AyzwvdeTeuVHrNm32F9JEnUtEFjtQUqZBgBg5AmqeNE4
 Pojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686340562; x=1688932562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Gg23vZroQxETI6pay6anvqx8zAzvFM1fFWvUKvVTHs=;
 b=JAzjcyj0RNakST3rpjDxG/R4ArIqA9ZvmYuFrmANCdCSjZaPXYsiHzD2ZwKLv5A1eW
 ucP0D8FVhVuVT6R2/tKtTL3vJnZ+3IwKibx4bVXm8e6u+BlN3cIvUgwQKpOmpCJUtO6Y
 576I49ZBulo/Vcgy940VUkFMZONO6ZlJPzBYfnQ4UQIeDYT9o65poTa/8Jge5igZViqA
 QTBCKZKNo9w1aaksVs+IWhTr9YV507NKpHnSYNtZEcZVxNve7b0W0VcwV4Z8AYWYD4X6
 DL0QrVSmX1+NqlYAYaxxkBrSSEaU51Qv55CIWKq2V9dD9xZTg8PTlcQN91jC94vuEFJZ
 ZDQA==
X-Gm-Message-State: AC+VfDwu7t8Z556jgVLLyBSoOvWPFeoKygAXeG0Q6xVpqa1dn2A2wwe2
 COG6ILruhD0ZF3wDUDetmrQIpw==
X-Google-Smtp-Source: ACHHUZ7YKiHGHCtzggDwyQ13e1iYFcAvYGJdjxhKihP1K6EXC/1uHG7Y3IYBCCejtFR/+kqZMo/5MQ==
X-Received: by 2002:a05:6a00:3a17:b0:64c:4f2f:a235 with SMTP id
 fj23-20020a056a003a1700b0064c4f2fa235mr2697966pfb.30.1686340562188; 
 Fri, 09 Jun 2023 12:56:02 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a62aa15000000b0065014c15a57sm3028211pff.35.2023.06.09.12.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:56:01 -0700 (PDT)
Message-ID: <35d7f33d-5dc1-b6a7-b40a-409c2b8ebacc@linaro.org>
Date: Fri, 9 Jun 2023 12:55:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 18/22] target/arm/tcg: Define SME set_svcr() helper in
 common 'helper.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> SME set_svcr() is called by handle_msr_i() in translate-a64.c.
> To be able to restrict helper-sme.h.inc to SME-specific files,
> move the set_svcr() helper definition into the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 1 +
>   target/arm/tcg/helper-sme.h.inc | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

