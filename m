Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEA78D0A2
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nv-0001tL-R9; Tue, 29 Aug 2023 19:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5sF-0005dk-1Y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:03:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5sC-00020s-JH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:03:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so3870610b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693343019; x=1693947819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUBYDfeffd8w/OzIb2alHZzc9ZHNtW1AXt2YRq5/ccA=;
 b=X8C/Pm2vt1pG8H+fdy3aTXqCpvn9FLR4FqwDhBeIbS407eRizKZolxDwJuK87jBrVr
 gLBzA7eqC66o6kZDiSTKgnc7bdNtLha13Ff30Jvru5QDhLbI1wHsG3rzejp7OfdTyAB8
 cSyp+1r+tz8QWZdhz1Fg16KsBiOFAB5ApSuWe9xA2n6kVRklJgSPYzXf72qZyArq21TG
 k4QmjxTembT2SuaB5rIC3Aa9PQZfCRVFB1AVeqbAvO5pGN7trnGYTaiYTPtYiv5AIB8u
 9koo4mbR62fip087LjuuwwcCZRZTM4nl0KJFJbzQX0MPfIEPGLX4/6JFEx7UVDJtTxnK
 yVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693343019; x=1693947819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUBYDfeffd8w/OzIb2alHZzc9ZHNtW1AXt2YRq5/ccA=;
 b=cTLYA9gj3CqqassQGHzymwhJatKNdf4VQLlWcrk9fRAOY6fSjtFlTZN5GoOh5Bufa7
 aG0KKc4tXeKGVKngFFucGQIf6d1t+MhZ6fT+YsnWWn2lPIXT22esyngdUAg9Hb+YhK3d
 P8FY88fWwnuW7/2W2L5j0gRIvRYU/KnJK01yxcpwfDIAFInrtmROaCFVGYlcQ0rafeCD
 tpuTv3Gh/6Q66p0fA1ssU0jsuhMrONc+eUpREo2DLqxGzoQmdOR27FJosAS2Qds14xch
 8/346rcKlwVA+ksc19EnkUr7D8M3ID4aeTzvE8I1H7nMfPRGiece71SgzK8M9hqTEnQq
 Aw+A==
X-Gm-Message-State: AOJu0YycsVhbgdUBanJk/awuFW9mSN/rLTqsI+FsJwaMsCcfo4bSldhT
 MkIrpu168IBskVtrHwD/nwYR+g==
X-Google-Smtp-Source: AGHT+IE/aOwoCL16669vvupOP8IEcqDWMHQtooBgSKtvXQvcauvFWjxk8FP9DnmOSOSu7I4REZot9A==
X-Received: by 2002:a05:6a20:12ca:b0:138:2fb8:6a14 with SMTP id
 v10-20020a056a2012ca00b001382fb86a14mr510854pzg.3.1693343019019; 
 Tue, 29 Aug 2023 14:03:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a17090322ca00b001bb9bc8d232sm9829043plg.61.2023.08.29.14.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 14:03:38 -0700 (PDT)
Message-ID: <d6851f26-c241-15b5-39b0-59025380445d@linaro.org>
Date: Tue, 29 Aug 2023 14:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] linux-user/aarch64: Add ESR signal frame for SIGSEGV, 
 SIGBUS
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
 <20230822170209.1130173-2-richard.henderson@linaro.org>
 <CAFEAcA8vCKZetufuysbsvSPo8xZaVHMa5n-mNrc2wUztD+Mfyg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8vCKZetufuysbsvSPo8xZaVHMa5n-mNrc2wUztD+Mfyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/29/23 07:35, Peter Maydell wrote:
>> +    /* See arch/arm64/mm/fault.c, set_thread_esr. */
>> +    if (sig == TARGET_SIGSEGV || sig == TARGET_SIGBUS) {
>> +        return true;
>> +    }
> 
> It's possible to get here without env->exception.syndrome
> being set correctly, I think, if we take a host
> SIGSEGV or SIGBUS and host_signal_handler() calls either
> cpu_loop_exit_sigsegv() or cpu_loop_exit_sigbus(). Can also
> happen for other places that call one of those two functions,
> like allocation_tag_mem(). At least, I can't see where we
> would be setting syndrome in that code path.

cpu_loop_exit_sig* go through arm_cpu_record_sigsegv and arm_cpu_record_sigbus, which use 
the normal fault processing paths to populate FAR_EL1 and ESR_EL1.

> Maybe we should do the "sanitize ESR for fault addresses in
> the upper half of guest address space" logic that the kernel
> set_thread_esr() does?

I guess we could, though I'm not sure how such an address could occur.


r~

