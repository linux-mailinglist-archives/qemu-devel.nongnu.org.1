Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACE79EF75
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgT9n-0000ib-K7; Wed, 13 Sep 2023 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgT9m-0000hX-AP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:56:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgT9j-0004OK-J5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:56:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so52917025ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694624158; x=1695228958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1KRCjUOxyzReqnQBZmjiPDgFqMCswZgDzYqJUA6afw8=;
 b=l+dlCtlD7Gvt594sBp6d82bnhNJjCgLRi5LDfEQaVl7FLyDuOWeCFShUsxP3o0a2zZ
 RjTD0uWu60YL+Xb9MrLQfS4ZFPr/yCcmP4A7qCmBuruIHAmUv9841l2yR71qXxlN2rJ7
 ms1FFBOauIn4Q7EwYX8fOA6pJiGlUWprK3zylpIZvgP3vx3T+G7KqCcXsSX2FlsiKHnR
 xGjAxh8y47DD1HtPWTBUhaVdpN/fTp9pHGIwd0IK+n7nN+CV4aI2evTdombooMErMbv0
 TqzzNAkNZpaoAzlQcW4FD3Apy2qMaTbAEySFB7S8xqLC03e4TyuSSZFkCEhst7gNm3x4
 ymyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694624158; x=1695228958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1KRCjUOxyzReqnQBZmjiPDgFqMCswZgDzYqJUA6afw8=;
 b=qqs4lO5bGdnS7w17vxUnkFbf2DSPWmdZ1dNS1lIsslFWlppIvEMIjBpfjj+LSGVrvQ
 0QcmPkP/tk+yPcNiBeI1XJmY+zzVxKbo4W/4Loq9sxj3wTeGRTbG8Kc/yrTyju2rD0l8
 kUB7dbI8JkuVsXJ8SKl4PZ0XpTJePQMF1MEGdu9QoY7jQ+8ab/MPgvEeLLv1qIb7YzFH
 MCzwx93fDtsMxTkLkCzPeZ4Pcrb3fjywKUpfSZxnIRkylCFyIxmoJ9fd4XZigv1vdpiO
 DfshTUTtQketytqenNLgcdbdwwsFfHvriFkI4OFfg96YWYm4ZgQTTZ9ioIKOFt0YGWwQ
 YlGQ==
X-Gm-Message-State: AOJu0YwrpDwEgTu8oozSwQQZ/3iXh4fEap/KpKvZPca1PuGPxr/CVE4B
 iPPXwPfpSTXHdtki8byVs7LhVQ==
X-Google-Smtp-Source: AGHT+IGBYHqSCZPgWpS6wHaIx5pxkJRlA41vhQUH+7gk8e8rzcSW2rOLBa3ldnhd0tcPP34afntM+w==
X-Received: by 2002:a17:902:c244:b0:1c3:94a4:34bd with SMTP id
 4-20020a170902c24400b001c394a434bdmr3327556plg.40.1694624157654; 
 Wed, 13 Sep 2023 09:55:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902a40c00b001b891259eddsm10637946plq.197.2023.09.13.09.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 09:55:57 -0700 (PDT)
Message-ID: <ba047867-db8b-8bb6-d2e7-563516c5afb6@linaro.org>
Date: Wed, 13 Sep 2023 09:55:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] target/hppa: Optimize ldcw/ldcd instruction translation
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <ZQHLcL6E5uNvjkaN@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZQHLcL6E5uNvjkaN@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/13/23 07:47, Helge Deller wrote:
> +        haddr = (uint32_t *)((uintptr_t)vaddr);
> +        old = *haddr;

This is horribly incorrect, both for user-only and system mode.

> +        /* if already zero, do not write 0 again to reduce memory presssure */
> +        if (old == 0) {
> +            return 0;
> +        }
> +        old = qatomic_xchg(haddr, (uint32_t) 0);

You're also dropping the required host memory barrier.

Frankly, the current tcg_gen_atomic_xchg_reg is as optimized as you'll be able to do.  I 
really doubt the "avoid write 0" is measurable at all.


r~

