Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B407246C0
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xzb-0003az-1C; Tue, 06 Jun 2023 10:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6XzJ-0003Zg-SR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:48:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6XzF-0004j6-J8
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:48:45 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-53fbb3a013dso5697662a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686062919; x=1688654919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ojb1cND76xpAWDunP5fQnUJZtmpC4/7Q0Xlav9BCelI=;
 b=Zv6X3IEyqx525/THajyMn3tYezXTjrUTs8wNR8wR38QwQc/zXAq/h/ROY3j5cznFHB
 nrhLXQi1Da0GQLiRGEeqoknDXYpd+ZE8R0XoSMcSlT9wnJg5U5pkGXmFQtZ2X5pcFmNi
 B1qxYIHghsh8RIExYvR9wsR+qVoIJlehp0yYZAiGEyKx5CHrhe7+9L8whG4amd8CI334
 1MSWAayZFBwcKl+G6YBJDtSJpHa3zls3MEe6uXNGbIZ9mbNgzwuNwJyTSzz5bpaoWE69
 23NQwVqsDPc8SUw/ULOcvUVyHC71kgjioPSgQk0+Ngu6iM4VrETNYtnWueRWFA0zIOQS
 sdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686062919; x=1688654919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ojb1cND76xpAWDunP5fQnUJZtmpC4/7Q0Xlav9BCelI=;
 b=MrA09siu3cQYrAJGjd+t8aTsuuG6m+kEEPBB6sWWe/jyq9EMVDvPStH8CrN73dM7wH
 VT/9ag9cWaEqFibPL+6VFHBAOH5Y26l1faYsPcY3snAqKLNhabXXZL95OlqOsC1XCnNc
 jP/KtcGw1jQClow///OhyI6GnhfcvmhT0kyx0ZATLt3XYXlyXCRctoE4jRon34WHRFjS
 FVcAwY8zPFtwhyuauBRy449my1ZqXLBIqOBADZiKXORGmZIIKs6hdVg9aIRtfADz4Aib
 KfdDqU+gapQTB9scZdGkRSGqx3hFwgPAbhDE9LWcO3vSk8A3+ld/SKss+Au+VVfN6wVU
 8iKg==
X-Gm-Message-State: AC+VfDxaWIJ74b02EgRafmxyOCG3TQcLxTa4f4wtptwGhySTNf7Qf+Iv
 QpK790aGAd7/nk/LNZQss+NZhw==
X-Google-Smtp-Source: ACHHUZ7kKqJeMf0x2XVVuBQCccN3Kp0NO0C2suL73UasP7twCXOnbv9fFQdZc2pMyNGRGJ7QRlCErA==
X-Received: by 2002:a17:903:22c3:b0:1b0:3df1:c293 with SMTP id
 y3-20020a17090322c300b001b03df1c293mr2592900plg.45.1686062919143; 
 Tue, 06 Jun 2023 07:48:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902ed4400b001ab0a30c895sm8627647plb.202.2023.06.06.07.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:48:38 -0700 (PDT)
Message-ID: <16c75f6a-7621-213f-5786-d0ea34e02478@linaro.org>
Date: Tue, 6 Jun 2023 07:48:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/9] target/m68k: Check for USER_ONLY definition
 instead of SOFTMMU one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
References: <20230605222420.14776-1-philmd@linaro.org>
 <20230605222420.14776-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605222420.14776-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/23 15:24, Philippe Mathieu-Daudé wrote:
> Since we*might*  have user emulation with softmmu,
> replace the system emulation check by !user emulation one.
> 
> Invert some if() ladders for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/helper.h    |  2 +-
>   target/m68k/cpu.c       | 14 ++++++--------
>   target/m68k/helper.c    |  4 ++--
>   target/m68k/translate.c | 28 ++++++++++++++--------------
>   4 files changed, 23 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

