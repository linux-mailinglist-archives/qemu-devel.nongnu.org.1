Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680417246D3
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Y23-0007TC-4E; Tue, 06 Jun 2023 10:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Y1y-0007Bv-SP
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:51:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Y1w-0005J6-6Q
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:51:29 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-656923b7c81so1735991b3a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686063071; x=1688655071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DGs9MG6POpCj8Mmx5gPvpejl0YSDiO6EkHrcF3a7Pm4=;
 b=e5fpot3Au7om+gyQTmDQfBjAJfwXxqfUWqw0dFqchi/JgyifMNX8qK+ZRiajJ9Taq0
 0HrwFss3oaeH3gQ9OKhvGijij43kip+bn4BFllv1OHCNZfOnO3yGjd0veIitNTrlyCbR
 kVm99m9Zwt8YkvXmo6vfMdP/+GmLTxsyUHhvjDJtuZe39Adv3ekkpA9r0rrZPd+f0rDq
 jatLYA0pshFqntPxaCe4dgjN3CFtiouHRcih2cgzMFB0z/jSLlbQWD2qD8tpSmgBGSTe
 pUwFNxbJmOYESG4cSJ+Ee7s9LwCLjgu7BMohUqyPyoAxVo0EyKNoIUjj0jhEiIGBD5nx
 9hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686063071; x=1688655071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGs9MG6POpCj8Mmx5gPvpejl0YSDiO6EkHrcF3a7Pm4=;
 b=CgckjqWXc8lw1SZccwDKqJPF1EmrvbN/pfzSRI/5f6+s75Utxhj6E9VkvsC+nBP2Rf
 gEK/ASejcfQO+i3sD5ai2MvHRF8R1akQ+VOSX4tTNSJKXjvxkocOfATOWu6x7Uq/CKAg
 1L5bTvxqpwpKOQajoJwjlF4O2KRGJpUuY3R2WXLipsPHEleXSTcE7AUzDNBCl6ZWjREH
 CtJDmvL6FfXK+9/ho+lUlMmiZgzywhilWT222R0iVJ7DRAF5D1/3orQNHrymm3bptGKg
 Z4NqkJlwsjpCLIX4uvX/TJe0YDTRiYWhBfmm3a1dzkWzbpkmkVpFEjE2V5uy43JGEpsO
 BaTA==
X-Gm-Message-State: AC+VfDzr3B4rJdV4FD2LN/4nv3OkoGaPVJCfu/fIP1eixQovLMnqxi9z
 JxTsPm4ZyNJRv8uaSOWgDECnJg==
X-Google-Smtp-Source: ACHHUZ6uD2/hyYSGAk1ds5oRaTkLHwg4s/7MKmaMv55Jj9yOEAyTVTM4dfTIVPb9dI5GrjkOMkplSA==
X-Received: by 2002:a05:6a20:8403:b0:111:346c:3445 with SMTP id
 c3-20020a056a20840300b00111346c3445mr1320998pzd.38.1686063071413; 
 Tue, 06 Jun 2023 07:51:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170903244400b001a96a6877fdsm8721208pls.3.2023.06.06.07.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:51:11 -0700 (PDT)
Message-ID: <e7af2c5b-cb5d-c6aa-73d8-d8acf3216256@linaro.org>
Date: Tue, 6 Jun 2023 07:51:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 6/9] accel/tcg: Check for USER_ONLY definition
 instead of SOFTMMU one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
References: <20230605222420.14776-1-philmd@linaro.org>
 <20230605222420.14776-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605222420.14776-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
>   accel/tcg/internal.h | 6 +++---
>   accel/tcg/cpu-exec.c | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

