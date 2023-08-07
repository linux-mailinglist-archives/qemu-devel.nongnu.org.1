Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DC7729E8
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2bE-0005le-Lv; Mon, 07 Aug 2023 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2bB-0005lS-Vp
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:56:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2bA-0002Q4-DF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:56:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686b643df5dso3117018b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691423806; x=1692028606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSMIr5pqr+kGoAfUi8IM7Hi6ZBzUpKQgMnor2fuh3s4=;
 b=t4UXOESOTeuEfrDLBEc49COWSOMo3ngLsinF0hYXlG74+yQB8tDNk9Umac1X0JlRcP
 u6qrI4ICwUlFnqQs+cddI7wSHYWVU/dqfT3i/n0lF3+jEnPAML/vdwUflV+qEZ8CNorK
 pu81bG9a5NehpUEBBXSV9jQR0vqRAYJNYG9zejMVXFnE5Ln7sfaYexY4VvidzE7uOl0h
 GN++6xdBc7ulurfCqdYQP7ji6/MrIRGgIZOgBNPhfDxsMu/pCpQp5FKEAkgZWVkWJED4
 onCO4ruGGA5cHVDBfuhqDh5S0ujQUWLvmhV1naYxmsDJZ+p4fmtK87ggoYKaMRHzI86e
 /5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691423806; x=1692028606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSMIr5pqr+kGoAfUi8IM7Hi6ZBzUpKQgMnor2fuh3s4=;
 b=NJpt1R8ZZs8F+/LwyjyuCZamFrlQwlP8eyAMThyJFPpFQCmMvCBoP2QjfmVHcgV54N
 c8iprULvCzoM5HvdNKAmvZ2VPZ7aiYlA/G6zXKUzkpblM5JWdY5MJBqYn7bMOzm9VLOi
 q+nbPb0OkpChALLNQr8T1xw4SlB4pa21J8k6YPnOenq3Hz7ZzUf6sEX8/kzQ6DTaSRrw
 ZyPkFcKHXoscasm6x3HJ7s7Tpm3RQ8qEMbjtDAq3ZWjgSoaXehDNaWzcLBmFwv0TLE3p
 85wsg1RZz57MTu0oQPeIvfGJfwGy3vXUPaAGX+pCpb9776PDGTj1UvrHzFWtAPAWAN8X
 BWHQ==
X-Gm-Message-State: AOJu0Yxqw7dlVn84K1FNz+K9FBAXQic5aLp1/rqciop6vO7ewuK5fZQ2
 j47mLTzNv+qobDvuJt+FUY88hA==
X-Google-Smtp-Source: AGHT+IEKerrF/r7DDKDo9TwCZXq0zuPESPqWYSKc0ZKtPvSnD+qjb3RBWrZUGKXY+pri6ADticcmPQ==
X-Received: by 2002:a17:90b:390b:b0:268:5bed:708e with SMTP id
 ob11-20020a17090b390b00b002685bed708emr6490182pjb.24.1691423806486; 
 Mon, 07 Aug 2023 08:56:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a17090add9300b0026596b8f33asm8889704pjv.40.2023.08.07.08.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:56:46 -0700 (PDT)
Message-ID: <0d03142e-3546-9cc9-e0c3-37ead0e63717@linaro.org>
Date: Mon, 7 Aug 2023 08:56:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/6] Add loongarch32 mode for loongarch64-softmmu
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230807094505.2030603-1-c@jia.je>
 <29e320c8-b95b-2188-a250-0eb5a19708da@linaro.org>
 <f9dc0f47-ab22-0227-7ecb-ba7530609888@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f9dc0f47-ab22-0227-7ecb-ba7530609888@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 08:43, Jiajie Chen wrote:
>> There are changes missing for the translator.
>>
>> All of the doubleword (D) instructions must be rejected in LA32 mode.
> I was trying to do this, but I failed to figure out how to read the current cpucfg when 
> translating instructions to TCP ops. This problem applies to the mode-specific behavior 
> below: VA32L1, BL, JIRL, PCADD*, PWCH etc.

Because the CPUCFG values are constant, you may read them in 
loongarch_tr_init_disas_context and save the value in DisasContext.  This is sufficient 
for LA32 vs LA64.

But virtual address width should be in HW_FLAGS and may be read from ctx->base.tb->flags. 
You may wish to simplify usage throughout the translation routines by extracting a 'bool 
va32' in loongarch_tr_init_disas_context.


r~

