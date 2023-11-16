Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD737EDBB6
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:00:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WLD-0003fM-Bf; Thu, 16 Nov 2023 01:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WL7-0003ew-AP
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 01:59:01 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WKy-0000YU-Gk
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 01:59:01 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50a938dda08so627116e87.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 22:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700117930; x=1700722730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N0gh0Gim2L6ccpsDSEDXTDgGYU603L2xoWhf1WgVWk8=;
 b=gIaX79+2eA1a54T6hreU3+cgPhJmqSXQCGDCgXVrHWTxPSUev5c9Ab1FDOYZK22EU3
 MHkAc49H/EmoQ/OjWjjKlRuL28djGNtsIY9aKSxRj+YYCx1Dufi+ux2DtX8HV3vskRo+
 Xnodisc0BsJKhDrAOtJEq7qtd6hudSXkfmin/rU3dSpJniE9sw1LJahH5T+dcn8wJsmm
 gQ9osKF26h8PIETyMTRWyS9anbj4NpKJrcYdhgzYQI27HvjJjIukVch7H6r60vVV87R/
 5GBKmfvK8J+YJbqyBaJsp+Ni8CJ95V63AhB8fg/gVDmRawGzRBLOw8p7mXkJwmU6360W
 wFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700117930; x=1700722730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N0gh0Gim2L6ccpsDSEDXTDgGYU603L2xoWhf1WgVWk8=;
 b=wWwXJ5SPSbnjR1775bINe1Ne6VrZV3fuWQhqawdu2S+Lu00VGSC8f2oaZeHcRLX9GP
 d/F5ObI62GuvOZW0IU1QnWtDN8uVWgIkgyVuTDpt578P1bbCWwYTS66Pa7aziEulNepM
 p5e1kcOCOZYKq0nXQOY/UNtsyyo+hgfXR86grm7WuEwQ1aQQoZsRSQ0VP+Llk3zcnhUo
 2SoxT5mSWWH7P3bDpPpo2UflM+CLKe5EyBW5BUDTVk1RF+uDJMRL0LhH22fJ6xFrPWmB
 dtl4c7tvAILBlp8eQnr4By8xRvRQzpY5SQk82mS93fanPqMWx+3UqkqeI8tvRMq1SLOl
 6dAg==
X-Gm-Message-State: AOJu0Yw7IWp1YaGLk5CWxSfLiwyqTKOdCUPUTGTFqv2W6HS7T1kGre+m
 U/dotEpWqzOPR1VqwQOOfds/rMM7xjW7t2129o8=
X-Google-Smtp-Source: AGHT+IFLYPSurTMpJDLpjcm/zmXxT8giT0CE5DimXdYgR7BpsPJiuKT9t96fGwUt5E9o/O+IN3tgsg==
X-Received: by 2002:a05:6512:6d5:b0:507:b19e:90cc with SMTP id
 u21-20020a05651206d500b00507b19e90ccmr12979132lff.40.1700117930269; 
 Wed, 15 Nov 2023 22:58:50 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a1709067e1100b009ca522853ecsm7889681ejr.58.2023.11.15.22.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 22:58:49 -0800 (PST)
Message-ID: <c147e3c7-3913-4e7b-9532-136d3fa516ef@linaro.org>
Date: Thu, 16 Nov 2023 07:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/31] target/alpha: Remove 'ev67' CPU class
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-2-gshan@redhat.com>
 <55804c4c-2274-4b21-a27c-186c0999c859@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <55804c4c-2274-4b21-a27c-186c0999c859@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/11/23 01:22, Richard Henderson wrote:
> On 11/14/23 15:55, Gavin Shan wrote:
>> 'ev67' CPU class will be returned to match everything, which makes
>> no sense as mentioned in the comments. Remove the logic to fall
>> back to 'ev67' CPU class to match everything.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   target/alpha/cpu.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> The subject is wrong -- ev67 cpu class is still present.
> Better as
> 
>    target/alpha: Remove fallback to ev67 cpu class
> 
> with that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Also:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


