Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D047478190C
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 12:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXJQ9-0007EE-8F; Sat, 19 Aug 2023 06:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXJQ7-0007E6-GS
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 06:43:03 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXJQ3-0006s5-Bz
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 06:43:03 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so228825866b.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692441777; x=1693046577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0Kz/ckJ0a2Pbv94nIm28KP31XHv2oTiqzWjS7OL91U=;
 b=DFdXrZH7semUSEGVDVF9lNJ9KCkwhIF4Bc1U2uvFLOXZuSreWT+M/JzeOXsFAwjFCk
 ZdHINFoELo3691tUjJG4SIc3w4hHvuM11TPpewZB/nqDOWM8DdZObTsU0Jn5xWw9Hxme
 yxMbsWtUii2dIiUh6IeuhzDDa1k+OHpJU+1JwY98hg2TDq2VWkQT0pyLx3nMqVqHE7rt
 Lsd725GGYUUSBb972BgQv8aCK+BI4A1BXWihHK2KO56Q5BLpwAVQpew3VtfaQ37SfeYN
 SVSxpsQp0x0CwaUZotYTXlfAlFDx0MdFv+lkdB4fff94lyMgm2rTSpncFPEwtP2Hi9xy
 qtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692441777; x=1693046577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0Kz/ckJ0a2Pbv94nIm28KP31XHv2oTiqzWjS7OL91U=;
 b=J13PxZmF9g3ISGBBnJ5TsHFpIy36aPylMGEr8pThvIp6e7LFoIcBN4sIUxlF2YgoLi
 dK/gsdS2Mtlw7jzHt8nhBA+hOi2RN6SvUnmw3qZbF0zAyx1IHSOg6Pw4+vlwDASVTAx/
 lbdfHYmJP84kytkwd/QhG+hB8FwLp7eDIQ2ACV+3yJKaKS9VEAL72eEqK4tJo5Bu6FNr
 4bd60JhwtdkWMRXzDExLo5RDZNOSWkVTr9U6h7JC6KP3zIl0J22yiRtN2xNTWNLByFKy
 9ZER5lApzb/RlBM7cu40ZQV4NMVkIvjkRpO1KhaUjGtA+NWFLKE7lZfBi02YDXDpl15/
 IcXA==
X-Gm-Message-State: AOJu0Yy6VK3pN82B9udbPpD6Z5herreNOrQqlmBCN7Wb6SMX7nPRpbhE
 t4s4+4mfVeSfsJBb3UUXssqZIA==
X-Google-Smtp-Source: AGHT+IE7APHzkPVNXZZ4RUwAbrmEnwGw7y3lafQkEh9Yjh79MliEHgcEKNPTFiLtMZs5Oid4J02gpQ==
X-Received: by 2002:a17:906:1090:b0:99b:c8db:d92f with SMTP id
 u16-20020a170906109000b0099bc8dbd92fmr1444214eju.69.1692441776970; 
 Sat, 19 Aug 2023 03:42:56 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-220.dsl.sta.abo.bbox.fr.
 [176.184.27.220]) by smtp.gmail.com with ESMTPSA id
 o15-20020a1709061b0f00b00985ed2f1584sm2486701ejg.187.2023.08.19.03.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 03:42:56 -0700 (PDT)
Message-ID: <dbefcd7b-82b0-9601-c188-19ec68082b7f@linaro.org>
Date: Sat, 19 Aug 2023 12:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/arm: Fix SME ST1Q
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20230818214255.146905-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818214255.146905-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 18/8/23 23:42, Richard Henderson wrote:
> A typo, noted in the bug report, resulting in an
> incorrect write offset.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7390e0e9ab8 ("target/arm: Implement SME LD1, ST1")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1833
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sme_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



