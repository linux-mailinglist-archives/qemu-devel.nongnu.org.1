Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8AD72A1EE
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:15:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7gdj-0000ii-Pm; Fri, 09 Jun 2023 14:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gdh-0000hr-Dx
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:15:09 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gdf-0001P5-PT
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:15:09 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-543b17343baso829739a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686334506; x=1688926506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w36AbASTiRSHNc2Te2Cr673sMI9eEa6Xoi32f/Ol4UU=;
 b=pC6wJGxxka02oHsT08zuToJ3QVpkrg6E9ysQ3IVAEmPGR3MPYlXQDI0k7ei3DnO5xm
 IF5u59Oh5DYWAfn5lH5Iec/kcetmxsGWdQ0xUNIe27aAy7bKRFZXys03RQCPZBQ5OAWb
 hejhiP4bZrTA8NmLnKlK4MoD1qy2FMdO6DX+NVn5UAv7bbefDxV9SUnAk3FlAJZxz2z4
 5zXuGDEJgMvIS5c4R9ZoClIho+YNdQRS07jZfiA4CyIbCXdLP5tdPVHMyhP8xtb7nAuL
 hkndZt4LNyR4fbti4tgAYt+G0cXpYL0Pr4Abta0EojEqvrBb5P/zv/ibhRVwBze3XlJt
 iVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686334506; x=1688926506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w36AbASTiRSHNc2Te2Cr673sMI9eEa6Xoi32f/Ol4UU=;
 b=OO2oBuxfHh820cJl6dPVsZPIk+qliaLZr0FMIpLgaPnfBpjgKnRqXFrVmINxVckol4
 UZRBQHEUNYw8qEG0TJHbWETC+JOVBYcMUrVDtAI9tqq4qBVdXyXkWvjASEHmHT6iWtYB
 iFHtksFpLWSC3wOh1QNxwM2OIciUx1oRxMw7WHk01SekrPCMg03kRP4T9llyU1ISxoh0
 Z0u489umnG1E72BN7LfJ04mZgIgPIwk6LCtrweTmgKlFi/39MRyrlgB/TdQgSb+kJe6Y
 wC2bx3pHsMiASz2a9/P5SITdg9r0nyQq4FV+AVCwPBk7s3V5M1y3EcDlBOef9xcECfTs
 dsMQ==
X-Gm-Message-State: AC+VfDxtxWql7PBwR5L8lcWxYS66grxhp8CHYs2RSA0lF0gvs/fD6A6q
 fR578Z6zU/TId7+IsObKP9sLhw==
X-Google-Smtp-Source: ACHHUZ5FmRk944I97oYrpEKjFkOOKPvNJWcxQeEjO10VY9sJifu8TWMCFzHRGgzZel7evrU63wc1og==
X-Received: by 2002:a17:90b:17c3:b0:250:acb7:21da with SMTP id
 me3-20020a17090b17c300b00250acb721damr1504308pjb.38.1686334506232; 
 Fri, 09 Jun 2023 11:15:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 3-20020a17090a194300b0025b83c6227asm2227560pjh.3.2023.06.09.11.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:15:05 -0700 (PDT)
Message-ID: <045021a9-c318-fd46-d00b-94b124f10b34@linaro.org>
Date: Fri, 9 Jun 2023 11:15:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/22] target/arm/tcg: Remove CONFIG_TCG #ifdef'ry check
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 03:46, Philippe Mathieu-Daudé wrote:
> CONFIG_TCG is always defined within target/arm/tcg/.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/cpu32.c    | 4 +---
>   target/arm/tcg/m_helper.c | 6 ------
>   2 files changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

