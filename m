Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A51780F7C
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1ee-0000MD-Pl; Fri, 18 Aug 2023 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1ec-0000LT-QY
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:44:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1ea-0001mA-H5
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:44:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf0b24d925so7922225ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692373487; x=1692978287;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doeutOUn44L8jw+lOHBD199GqBXSr/S9eSHYvvWRDkQ=;
 b=FeqZ2bUJ2lVPkxT/QMq9hzvfHsfIkdMQVmBMlNTzjlpDia+k0ob5i/VzPej7PsMiMg
 BulzMhd/GMiJ3HAa3v8psEK0y7zfsFCw+STdgQT/IMGfNHuwVEtN1jlqqIhlOUFy37gF
 TKmxocol599khHGriSKSxt0Oo9ufd0ZMD90E60X37lnhLWkzlACH1hG1ECJe26DyHY/W
 yZGlvZQ+M9vaWkxlzY7zBYOmkoodyrmd3H4qnS4x4aVCPOMD1K0fgi4IHvDY73kMM/fk
 UPQ9CZP76L7AaS6z15yYMzFpK1Tt23F2U/Uzmq97gcCq2Xw007B19XpkZV0V0hDv4Tlh
 KhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692373487; x=1692978287;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doeutOUn44L8jw+lOHBD199GqBXSr/S9eSHYvvWRDkQ=;
 b=J7Y7ox3JIUce+S905AUKq1G3zgTOHsl/goCQDodLpLcPPys9viNBAOSnDGhsRM1jMn
 DLlOsXRZ+GkWLvf83/FNcdv/Jmp3Pgl5/E4kUgvvxBVykmVL//S/6uRFtRbR4j3wAjDP
 RVSsPWBQC4rD9KWe1NS7zUDc+xMpdIurvIzaCGIf2xCMYVw46JjEsaSbVzK029nlPA8p
 yUlWcY1YUqVvw5qoDFCUYBQEx9ivt2trc0wA99DXl5jaDk+tvAgxccjJyzN5HSHgWUi5
 7vnMN56NDYa27bxnvPgrMd7p8PvR6OqclLDLMZHumU3VXFcOYc4MSoz0m7ldk0Ycpizb
 46HQ==
X-Gm-Message-State: AOJu0YwOA6LM5H9wMy7D5XOklIV/pavPccy4CKbZuRRrbqOlJsV28bDX
 Fx3fxXH5l4MV3pFRRWqZGTGMyA==
X-Google-Smtp-Source: AGHT+IHHO5EAsiupE0NvOPIVJT7PPzJV11vBKeetiktm4Gd+42sVl+xJiIIj0+aA7fEqpngkm0Uq/g==
X-Received: by 2002:a17:902:d3cc:b0:1b6:649b:92cc with SMTP id
 w12-20020a170902d3cc00b001b6649b92ccmr2604267plb.69.1692373487001; 
 Fri, 18 Aug 2023 08:44:47 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bb8895848bsm1946055plb.71.2023.08.18.08.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:44:46 -0700 (PDT)
Message-ID: <d6d4d4ae-6514-760b-e13c-6652ca4ae103@linaro.org>
Date: Fri, 18 Aug 2023 08:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Remove unused allocation_tag_mem() argument
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230818123834.1370818-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230818123834.1370818-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 05:38, Peter Maydell wrote:
> The allocation_tag_mem() function takes an argument tag_size,
> but it never uses it. Remove the argument. In mte_probe_int()
> in particular this also lets us delete the code computing
> the value we were passing in.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I was looking at this function to see what argument I needed to pass it
> for the FEAT_MOPS stuff, and it turns out the answer was "it doesn't
> matter because it never uses the argument anyway" :-)
> 
>   target/arm/tcg/mte_helper.c | 42 +++++++++++++------------------------
>   1 file changed, 14 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

