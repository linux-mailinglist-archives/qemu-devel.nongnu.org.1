Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE017776EF2
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 06:13:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTx1K-0004Af-JK; Thu, 10 Aug 2023 00:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTx17-0004AA-8c
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 00:11:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTx15-0006l6-OB
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 00:11:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bd99c7b3e2so2772565ad.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 21:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691640678; x=1692245478;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zg1JHm/9miEGOdGkVJFDsHjJYtAiCkEEYl51auw6z6w=;
 b=FoBbovVBmo/k048fr0dPFg5Yyb3izt5g1eY36p4pPJ/Al9NwYQVGmHiRVtClCgky4Q
 seM3d65xnf0SUr4ydhDMW3F3yBOHBClvwhxy7O0GveakJyFLLuE2oMvNcigJnn5zZ5VC
 V9uANQfmaa4t/KdY5OkREOkej74eyk1SSmd63Gx9QWVsFFmPHFP6vQSZKVHQFusc1lV9
 bu4zLL2HeZN1D49Fbfw6yB9ZxNcyGSObmql/E63Lln36AWVZ9/RNb8nl5j47+bVwj4F+
 Q6mBeh/bfIkyxPsnLqAkzkmrHHujQQ2rSIpvBNdmU501HoD3FldzNdd2HB1oDWC0g8+O
 RPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691640678; x=1692245478;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zg1JHm/9miEGOdGkVJFDsHjJYtAiCkEEYl51auw6z6w=;
 b=XIDKyisVqLKPUp8TvoYw0GOj63BysqUcR9p4bfsimyxphmFzxCrypFTl8d4Of1A4TB
 IsrAPd1pmGseWAV+TqFHOx2Ir84QC2vM+F7LNdN62o0nmoV0SIIgQGzhBOfhMzKqBBHT
 Vwa880YOtUAik7cw4Qiecr8HaloCOjRWr9CyFyY7gUCzX6+iN2JRmbj/2+AkLdKo8PtV
 TxiKF+Y+Bya5vBxHTJSRFtYabLMSMOwDQhEEtTELHRbUiWKJIpya+a14xdZmpmtOOxco
 kbTodSUO9BKoBebO4K29OSNY3wBnNhIpZ+cJMFkML7sQqfILc03S8h/ItASn5bjjElHq
 69yQ==
X-Gm-Message-State: AOJu0YxK11MQApjoqZazGeUVNlXxRdReaSQCL4BuCPZxMYQT1ug1ru2k
 EXBugut8wtT+TaCpFkhjPM5OHIwXMp9VbjgvlcQ=
X-Google-Smtp-Source: AGHT+IHkkyeeA0UO+UtPfnevbcFpWKccNKoLWACPCtAo+J7so6cs4YSPlSZ6FerqcfJKYLLrsdERyQ==
X-Received: by 2002:a17:902:e5c8:b0:1b8:3590:358a with SMTP id
 u8-20020a170902e5c800b001b83590358amr1212937plf.19.1691640677571; 
 Wed, 09 Aug 2023 21:11:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902c1cd00b001bba1188c8esm404557plc.271.2023.08.09.21.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 21:11:16 -0700 (PDT)
Message-ID: <9ac45ec4-3011-abb0-305e-a5c266a41100@linaro.org>
Date: Wed, 9 Aug 2023 21:11:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] target/arm: Implement cortex-a710
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-6-richard.henderson@linaro.org>
In-Reply-To: <20230810023548.412310-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 19:35, Richard Henderson wrote:
> +static const ARMCPRegInfo cortex_a710_cp_reginfo[] = {
> +    /* TODO: trapped by HCR_EL2.TIDCP */
> +    { .name = "CPUACTLR4_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 3,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUECTLR2_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 5,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },

Oops, duplicate CPUECTLR2_EL1.


r~

