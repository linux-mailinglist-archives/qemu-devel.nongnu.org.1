Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AD78E118
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 23:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbSIz-0004AK-V6; Wed, 30 Aug 2023 17:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbSIv-00047S-IX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:00:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbSIt-00061Z-9y
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:00:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso865835e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693429241; x=1694034041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WEasHA9x5ckdzKEDn/khyAnC38czjFZ2E0Sy43CpAgI=;
 b=T2C59z8mgaEzURty9VdSihONdv/L/GPFnYXILpJLWXL/zmrT0301R/Ab6YX+ek9n1n
 FJFbS+XFh8wY5pqVCXterodfwbCHsu0liycVjSZVbxJBS5SY3EXwWuXqgFIV7leLZpyK
 VVL65TM/dZamJ9o1jSTZBTFIlXRDvR1Jyb0RzpdRpjGxaBChCs0aE3wXrljjFlsI7Lr9
 JPuMwidGW9Omoy7Bee6hkOU0yGv9uujzHIaIctl1UmENi4zttwAPec09RKjmQliv9mHs
 IB8JHNcknD4lGZCcm82RGQanFAOqcSjfw/SDdjCkM2MjvtAiCA5BOM8gpiyAXcgMBeHk
 gmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693429241; x=1694034041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEasHA9x5ckdzKEDn/khyAnC38czjFZ2E0Sy43CpAgI=;
 b=bViqAFlWGaleFtdlOx/nQ7Y0QBqMw54OyQexmf7e17Zw59chUlC8AeiE3p+pTIWU3H
 VRFVn8VveYCK7NxH9lTjPvFoZ4oWIwoLby91QMsWrrbM/opc/ztqnbyEjavvsDuvxlD1
 q4w/igXEzgzUoTHqlNqfTKZhPxof7LL7+zPoYhQj6OC5ocHRzyXahptsb/q5p8E1hHsg
 +iuwHgGSI9lgHtqpz7xaKsS65G0m5kL5ENm7z9cfsUcBXntT0h8mCTpm3gOlzDAu8GKF
 NZAbA1DrEZWrvQJqLsFb1n3wiOu4+xWEqbfVY8t6CLFA35niaHJ8budNAwwicFIpW4KS
 goTQ==
X-Gm-Message-State: AOJu0YzL1j5/7XFSlnE384prfZ/dmrdvbTlvkADNGKgUq8wciUaGjCOy
 NumkR59cMkoy+3P5gte28MExzg==
X-Google-Smtp-Source: AGHT+IHDYoU74Eby+72mW4QhSXE/1HpbEHbpVHXWZ99qEXJm7vYTLy+Ccr6A0HflDZLBuhLtgyVvuA==
X-Received: by 2002:a7b:cc8c:0:b0:401:dccc:a137 with SMTP id
 p12-20020a7bcc8c000000b00401dccca137mr3054048wma.34.1693429240783; 
 Wed, 30 Aug 2023 14:00:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4c48000000b003140f47224csm17541577wrt.15.2023.08.30.14.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 14:00:40 -0700 (PDT)
Message-ID: <725eccdb-54c4-20bc-1eed-ac081208ad36@linaro.org>
Date: Wed, 30 Aug 2023 23:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 03/10] accel/tcg: Use CPUTLBEntryFull.phys_addr in
 io_failed
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230828185550.573653-1-richard.henderson@linaro.org>
 <20230828185550.573653-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828185550.573653-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 28/8/23 20:55, Richard Henderson wrote:
> Since the introduction of CPUTLBEntryFull, we can recover
> the full cpu address space physical address without having
> to examine the MemoryRegionSection.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 17987f74e5..fd6c956214 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1385,13 +1385,9 @@ io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
>   
>   static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
>                         unsigned size, MMUAccessType access_type, int mmu_idx,
> -                      MemTxResult response, uintptr_t retaddr,
> -                      MemoryRegionSection *section, hwaddr mr_offset)
> +                      MemTxResult response, uintptr_t retaddr)
>   {
> -    hwaddr physaddr = (mr_offset +
> -                       section->offset_within_address_space -
> -                       section->offset_within_region);
> -
> +    hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);

To the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


