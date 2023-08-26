Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9498789357
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 04:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZiyi-0007wN-8T; Fri, 25 Aug 2023 22:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZiye-0007wE-Jw
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 22:24:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZiyb-0005sW-Hl
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 22:24:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so12726905ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693016676; x=1693621476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3klIvItkouXvCqwAUdp14yzl5GkcP+HApkxxt973ICI=;
 b=axm4h5PfI/4WuWrc9HJd/LPI4IpRBHXdl99IHC92qSg+eedA1Tgt3NGLsf/+5p0frk
 Olj31e5Goh7iWu/fBNfIiT80JIl9GV3vgAJTmrUldL85oayh+dundbjcAXADkzL1dDw/
 J4BSq0k+fJ354OrhRkp8NvYvd3hE8oH1pw3zUTI8McfEADZrOb2sCL7F1l8mM2be2A5r
 C6qfR/ENidYX1VwgOFL2MsVhwztMgT5YrPuWS57EPasc8y/DePxQNkWJko0bNOZh3C7a
 Unv7cyJ2pOW0VsfeY2lHwvFMvF6zKyccpatNcj9/YMLi5yP3n2e4pwPAynT0u2rjS0ru
 9pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693016676; x=1693621476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3klIvItkouXvCqwAUdp14yzl5GkcP+HApkxxt973ICI=;
 b=cgPdm4KkgFhcuf1EUCRKJ21tdHp24TXqGCil5EWXogmd1kgIXYt8LdVVFojAn4eHoZ
 le9r0DIe1jEWHDg6ZZGJfPwJAUJS+mHPkCQUosBb7pNm7DlccweGa/zdyC8cLdiwVRGb
 MIJTYmuwyyzh2lVwxjKrwR+rHSxT4aJTrNdDBoQQbEFqFIGnUnn2qKuwYJOL6dnv3KCd
 pRkViy8gJcFTmIP0thgC3RFQX4VN9pkc+AFCTgZ75/5Y4DFOyr+i8qmFyY7UPcUkaGjF
 YtW4T/WZnmbwUz0X2mNHfs8h3jaOpJm2p45GxBO/yQCzGdxRr49bUc3bvbBuu5Wy/yBz
 srrA==
X-Gm-Message-State: AOJu0Yw+xcjiqBQmnSjRoJ3RlojR5QmuG1i6gyHPFxlBnB6yltQ4Z4RP
 08VIQG6bl+rVg+ItA6Fv8xNQjg==
X-Google-Smtp-Source: AGHT+IHmubNWp/wgmb59iaSLelBGemsNF+UXPboSnMB5FTFCPjyvh5i2t8K9NLgvAURGcru24pUw4A==
X-Received: by 2002:a17:903:2450:b0:1c0:ec66:f2b2 with SMTP id
 l16-20020a170903245000b001c0ec66f2b2mr267759pls.27.1693016676058; 
 Fri, 25 Aug 2023 19:24:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a17090341cf00b001b87bedcc6fsm2469349ple.93.2023.08.25.19.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 19:24:35 -0700 (PDT)
Message-ID: <272f2ff1-45de-8cc6-552e-6769ba5a16f8@linaro.org>
Date: Fri, 25 Aug 2023 19:24:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v5 05/10] tcg: Add tcg opcodes and helpers for native
 library calls
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/25/23 03:45, Yeqi Fu wrote:
> This commit implements tcg opcodes and helpers for native library
> calls. A table is used to store the parameter types and return value
> types for each native library function. In terms of types, only three
> types are of real concern: the two base sizes int and intptr_t, and
> if the value is a pointer, tcg_gen_g2h and tcg_gen_h2g are used for
> address conversion.
> 
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>   accel/tcg/tcg-runtime.h      |  22 ++++
>   include/native/native-defs.h |  42 ++++++++
>   include/tcg/tcg-op-common.h  |  11 ++
>   include/tcg/tcg.h            |   9 ++
>   tcg/tcg-op.c                 | 193 ++++++++++++++++++++++++++++++++++-
>   5 files changed, 276 insertions(+), 1 deletion(-)
>   create mode 100644 include/native/native-defs.h
> 
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 39e68007f9..bda78b4489 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -37,6 +37,28 @@ DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>    */
>   #define helper_memset memset
>   DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
> +
> +#define helper_memcpy memcpy
> +DEF_HELPER_FLAGS_3(memcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
> +
> +#define helper_strncpy strncpy
> +DEF_HELPER_FLAGS_3(strncpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
> +
> +#define helper_memcmp memcmp
> +DEF_HELPER_FLAGS_3(memcmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
> +
> +#define helper_strncmp strncmp
> +DEF_HELPER_FLAGS_3(strncmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
> +
> +#define helper_strcpy strcpy
> +DEF_HELPER_FLAGS_2(strcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr)
> +
> +#define helper_strcat strcat
> +DEF_HELPER_FLAGS_2(strcat, TCG_CALL_NO_RWG, ptr, ptr, ptr)
> +
> +#define helper_strcmp strcmp
> +DEF_HELPER_FLAGS_2(strcmp, TCG_CALL_NO_RWG, int, ptr, ptr)

You cannot just call these directly.  This will fail immediately whenever the guest does 
something silly like

	memcpy(NULL, "foo", 4);

This must raise SIGSEGV to the guest.

If we leave the bulk transform to tcg, the absolute minimum is

void * HELPER(memcpy)(void *dst, void *src, target_ulong len)
{
     set_helper_retaddr(GETPC());
     void *r = memcpy(dst, src, len);
     clear_helper_retaddr();
     return r;
}

There is no way to do this thread-local storage update from TCG.

But if we need to have a helper at all, we might as well do more and *not* leave the 
transform to tcg.  Something akin to

target_ulong HELPER(memcpy)(target_ulong dst, target_ulong src, target_ulong len)
{
     uintptr_t ra = GETPC();
     CPUState *cpu = thread_cpu;
     void *h_dst, *h_src;

     if (!h2g_valid(src)) {
        cpu_loop_exit_sigsegv(cpu, src, MMU_DATA_LOAD, 1, ra);
     }
     if (!h2g_valid(dst)) {
        cpu_loop_exit_sigsegv(cpu, dst, MMU_DATA_STORE, 1, ra);
     }

     set_helper_retaddr(ra);
     memcpy(g2h(cpu, dst), g2h(cpu, src), len);
     clear_helper_retaddr(ra);

     /* memcpy always returns its first argument */
     return dst;
}


> --- /dev/null
> +++ b/include/native/native-defs.h
> @@ -0,0 +1,42 @@
> +/*
> + * Argument encoding. We only really care about 3 types. The two base
> + * sizes (int and intptr_t) and if the value is a pointer (in which
> + * case we need to adjust it g2h before passing to the native
> + * function).
> + */
> +#define TYPE_NO_ARG 0x0
> +#define TYPE_INT_ARG 0x1
> +#define TYPE_IPTR_ARG 0x2
> +#define TYPE_PTR_ARG 0x3
> +
> +#define ENCODE_TYPE(ret_value, arg1, arg2, arg3) \
> +    ((ret_value) | (arg1 << 4) | (arg2 << 8) | (arg3 << 12))

Supposing we do the transform in tcg, this duplicates include/exec/helper-head.h, and 
dh_typemask().

> +static const FuncHelper func_helper_table[] = {
> +    { .func = "memset",
> +      .helper = (helper_func)gen_helper_memset,
> +      .type = TYPE_AAIP },
> +    { .func = "memcpy",
> +      .helper = (helper_func)gen_helper_memcpy,
> +      .type = TYPE_AAAP },
> +    { .func = "strncpy",
> +      .helper = (helper_func)gen_helper_strncpy,
> +      .type = TYPE_AAAP },
> +    { .func = "memcmp",
> +      .helper = (helper_func)gen_helper_memcmp,
> +      .type = TYPE_IAAP },
> +    { .func = "strncmp",
> +      .helper = (helper_func)gen_helper_strncmp,
> +      .type = TYPE_IAAP },
> +    { .func = "strcpy",
> +      .helper = (helper_func)gen_helper_strcpy,
> +      .type = TYPE_AAA },
> +    { .func = "strcat",
> +      .helper = (helper_func)gen_helper_strcat,
> +      .type = TYPE_AAA },
> +    { .func = "strcmp",
> +      .helper = (helper_func)gen_helper_strcmp,
> +      .type = TYPE_IAA },
> +};
> +/* p: iptr ; i: i32 ; a: ptr(address) */
> +void gen_native_call_i32(const char *func_name, TCGv_i32 ret, TCGv_i32 arg1,
> +                         TCGv_i32 arg2, TCGv_i32 arg3)
> +{
> +    TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
> +    TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
> +    TCGv_ptr arg3_ptr = tcg_temp_new_ptr();
> +    TCGv_ptr ret_ptr = tcg_temp_new_ptr();
> +    unsigned int i;
> +    for (i = 0; i < sizeof(func_helper_table) / sizeof(FuncHelper); i++) {
> +        if (strcmp(func_name, func_helper_table[i].func) == 0) {
> +            break;
> +        }
> +    }
> +    g_assert(i < sizeof(func_helper_table) / sizeof(FuncHelper));

So you assert() if libnative.so gives you something that doesn't match?

Surely returning false here, and allowing the translator to fail the transformation is 
better.  This would generate SIGILL at runtime, which still kills the guest program, but 
it feels cleaner.  You could also do

   qemu_log_mask(LOG_GUEST_ERROR, "Unimplemented libnative call to \"%s\"\n", func_name);


r~

