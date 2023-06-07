Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FF72697B
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 21:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6yVu-0002rc-QQ; Wed, 07 Jun 2023 15:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6yVs-0002rR-My
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 15:08:08 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6yVq-0005UD-DU
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 15:08:08 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53482b44007so3969711a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686164885; x=1688756885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JvVKVc2W2hZAAT/bh+nqKvXI0WbWJClD1KA1hZ/ekF0=;
 b=q3V6KRdyqwDwcEY8+N6M5bObAOKTyHxb/NNCNidrKBH22ovxZu7bOjU1Aj+UWUgEN0
 kiBz19cXlYilhTCI1V6srDzT8hebnOfGvjWYctzgNscLt4bxTBgV80oDCIrRoZvpmNav
 GVg2tfh3hZkrsiLxlbKU+S0Q5Z00LIDbzuVObQcvB8958jtVAbTQTCaUrK/oMCIEBYZ/
 Wm6kuWfp8H25bX5B8WUltm5z2dbgUkdIUz/HvFYAXMBJeX8zzf8OUJ6YMK+/h2gatyzO
 yXHgfRV9nIRt5hIN6OvowFI2AkFIUPndTGnnsaJwUVp88jz7r201FdbNJOOAKBqe5YvV
 zXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686164885; x=1688756885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JvVKVc2W2hZAAT/bh+nqKvXI0WbWJClD1KA1hZ/ekF0=;
 b=CzvkgnDiwqrVHogeTKKIR2nHVrH/ZIeGyH9JwTOdl2jf9vFtD3k8CtDAa3jsnM82zy
 CYqXcCH654WO79qdphcN+g/ahT6U6DpD0ztmKAifwrDzQJS1GxXIlMtDE9vNcXOPC9sw
 sfQJWHiWeCX3WMFHwyA6EINkH4TUO0xM22RFyIxcXg23fUUrY/5sm3Nmzza8uPUCrrt3
 9OC6s1R48pRd1nHe2SVMtAkEZ75QShEHh6lL4msTvSAdnDZAsidr4edOJXVmWX4nZIul
 y8asHqLdB5qNQW5FHAp3tAHIiJqFKaRk8KZ9jyn1Iry3rQD4N7abgk+xDZS8sNnjXCox
 iJqA==
X-Gm-Message-State: AC+VfDwY37RrOuezIzQcVV9rfU9ugs/U+zyJFrU53fq1wzLsDncA7Cz9
 exM69vqzwBhRcqzNkePkrVOrgw==
X-Google-Smtp-Source: ACHHUZ5sr4unDgPBsXG2fC33+NcnNI2JZp0mO3na9Gy9XLHCtxvg+3rg+aa+zP0BLRxg2l2FX2P+lA==
X-Received: by 2002:a17:90a:6c23:b0:24b:4e7b:c689 with SMTP id
 x32-20020a17090a6c2300b0024b4e7bc689mr2713644pjj.35.1686164884702; 
 Wed, 07 Jun 2023 12:08:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1f09:2b0b:a56e:7a17?
 ([2602:ae:1598:4c01:1f09:2b0b:a56e:7a17])
 by smtp.gmail.com with ESMTPSA id
 gk8-20020a17090b118800b002508d73f4e8sm1684330pjb.57.2023.06.07.12.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 12:08:04 -0700 (PDT)
Message-ID: <592d1cc2-9e32-4526-f8fe-7595544a7263@linaro.org>
Date: Wed, 7 Jun 2023 12:08:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2 3/6] target/i386: Add native library calls
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-4-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607164750.829586-4-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/7/23 09:47, Yeqi Fu wrote:
> +    arg0 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 4); \
> +    arg1 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 8); \
> +    arg2 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 12);

This is not correct, and will fail on big-endian hosts.

You need to use

     uintptr_t ra = GETPC();
     cpu_ldl_data_ra(env, guest_pointer, ra);

which will (amongst other things) take care of the byte swapping.

> +void helper_native_memcpy(CPUX86State *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    NATIVE_FN_W_3W();
> +    void *ret;
> +    void *dest = g2h(cs, arg0);
> +    void *src = g2h(cs, arg1);
> +    size_t n = (size_t)arg2;
> +    ret = memcpy(dest, src, n);
> +    env->regs[R_EAX] = (target_ulong)h2g(ret);
> +}

You need to do something for the case in which either src or dst is not accessible.

Routines like cpu_ldl_data_ra handle this for you, but you don't want to use that for memcpy.

There are several ways of doing this.  None of the existing helpers are ideal.

(A) void *dest = probe_write(env, arg0, arg2, MMU_USER_IDX, ra);
     void *src = probe_read(env, arg1, arg2, MMU_USER_IDX, ra);

which will raise SIGSEGV in case any byte of either region is not correctly mapped, and 
also perform the guest-to-host address remapping.  However, probe_* are written to expect 
probing of no more than one page.  Which means you'd need a loop, processing remaining 
page fractions.

(B) There is page_check_range(), which can check a large region, but doesn't handle 
address translation.  And you still wind up with a race condition if another thread 
changes page mappings at the same time.

(C) Perform the address translation etc yourself, and then protect the actual host memory 
operation in the same way as exec/cpu_ldst.h functions:

     set_helper_retaddr(ra);
     memcpy(dest, src, n);
     clear_helper_retaddr();

In this case you must also validate that 'n' is representable.  This is only an issue for 
32-bit host and 64-bit guest.  A check like (arg2 > SIZE_MAX) is likely to generate a 
silly warning about always false comparison on 64-bit hosts.  Therefore I suggest

     if (n != arg2) {
         /*
          * Overflow of size_t means that sequential pointer access would wrap.
          * We know that NULL is unmapped, so at least that one byte would fault.
          * There is nothing in the specification of memcpy that requires bytes
          * to be accessed in order, so we are allowed to fault early.
          */
         cpu_loop_exit_sigsegv(env_cpu(env), 0, MMU_DATA_LOAD, true, ra);
     }

Finally, you know the return value from the specification of memcpy: arg0.
There is no need to remap the return value back from host to guest space.


r~

