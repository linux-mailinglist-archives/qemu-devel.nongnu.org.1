Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F278931A
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 03:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZiC9-0006Bz-IT; Fri, 25 Aug 2023 21:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZiC7-0006Bq-CA
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 21:34:31 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZiC4-0005T5-UA
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 21:34:31 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a85b9c6ccdso1052649b6e.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693013667; x=1693618467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0w76JrlVJ42SvfN1kPLXvToGhTOK+RcUVlNByr2I300=;
 b=hj0oetRit8MrGlLdUeHmXqinGtPvF6d9/0L7+59RJkZtAQA2qd5vp5C4fSXIh+xjEC
 AcjkprwWEXf0oHdHW0/s3vjUOBEzUIE/JSV/yxpEykD2zq6cFA7ThLcnBFzDhEwS1mM7
 sGQYtg14HQbgeyhBXYE4Se+bQOqr0M3Os5sGMX0hvG7vSEe0BB5dsROFO6cNMSt1DMLn
 3msMN/+SIgLPX1+QjdPvSxGUunX6hvHvSYpxh0JugMwpP3SOl2uD7zUZOyEiCpiJMvzk
 FW3NfA4rBFYdxtopIZWEfrt/FBRPynzkfT4uCTklsWjZ1EOYOhlnSRAGLLVxxVZyAGIM
 8blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693013667; x=1693618467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0w76JrlVJ42SvfN1kPLXvToGhTOK+RcUVlNByr2I300=;
 b=Zr9hPpaiwRE0Y+6qmPFjkJQXNr7h3n7G3WzKaRTmZzYnI264DvtnDZ3rM85B9hOb+k
 5Ssh72dPW1h/SXboBpLSjKwFEh8dH+03R2WYo+ItjT10S5mVUlyuHcpOjwa9n2KcKy8g
 T7ymXQeGgWO09E8UUoSl9o8dc9swNc+8pTcpvjHsukBNfghqZOlncWEpnSnxo/J20ECt
 nJQ6x3lHs3KLd7yh6bJPYX+9Wt3O7z+RIVztLHUqMtrmhOojkx5Q/X6wTO4vrdlJF6Hl
 CdDPpqQT/pkHG7X/YGeRaUFbzujBR+XSB3JCXxncK17EapTBPHsqUZkYhpkwx2hjefym
 gSNg==
X-Gm-Message-State: AOJu0YwMqsYFKnkeyJpjWgl277oiwRNa3V/IGQCdlHGHikNBVt1pBRm7
 DnkLmmCB+r6rJAmofHcUyTjy4g==
X-Google-Smtp-Source: AGHT+IGhw4izVzWp7SReWRV0IAxPUsWXZhh09qcOBw4u2hTd7GgJZAd/xbzTZFKtQGd4FuN04uGjyA==
X-Received: by 2002:a05:6808:1a02:b0:3a7:4b9a:43c2 with SMTP id
 bk2-20020a0568081a0200b003a74b9a43c2mr5653191oib.13.1693013667335; 
 Fri, 25 Aug 2023 18:34:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e6-20020aa78c46000000b0063f0068cf6csm2180394pfd.198.2023.08.25.18.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 18:34:26 -0700 (PDT)
Message-ID: <11a7fa7b-aa2b-65e1-b2b2-25b0eefee012@linaro.org>
Date: Fri, 25 Aug 2023 18:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v5 02/10] build: Implement libnative library and the build
 machinery for libnative
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
 <20230825102009.1754699-3-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230825102009.1754699-3-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 8/25/23 03:20, Yeqi Fu wrote:
> This commit implements a shared library, where native functions are
> rewritten as special instructions. At runtime, user programs load
> the shared library, and special instructions are executed when
> native functions are called.
> 
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
...
> diff --git a/common-user/native/libnative.S b/common-user/native/libnative.S
> new file mode 100644
> index 0000000000..3692eaa3cf
> --- /dev/null
> +++ b/common-user/native/libnative.S
> @@ -0,0 +1,69 @@
> +#if defined(i386) || defined(x86_64)
> +/*
> + * An unused instruction is utilized to mark a native call.
> + */
> +#define __SPECIAL_INSTR .byte 0x0f, 0xff;
> +#define __RET_INSTR ret;
> +#endif
> +
> +#if defined(arm) || defined(aarch64)
> +/*
> + * HLT is an invalid instruction for userspace programs,
> + * and is used to mark a native call.
> + */
> +#define __SPECIAL_INSTR hlt 0xffff;
> +#if defined(aarch64)
> +#define __RET_INSTR ret;
> +#else
> +#define __RET_INSTR bx lr;
> +#endif
> +#endif
> +
> +
> +#if defined(mips) || defined(mips64)
> +/*
> + * The syscall instruction contains 20 unused bits, which are typically
> + * set to 0. These bits can be used to store non-zero data,
> + * distinguishing them from a regular syscall instruction.
> + */
> +#define __SPECIAL_INSTR syscall 0xffff;
> +#define __RET_INSTR jr $ra;
> +#endif
> +
> +/* Symbols of native functions */
> +.section .data
> +sym_memset:  .asciz "memset"
> +sym_memcpy:  .asciz "memcpy"
> +sym_strncpy:  .asciz "strncpy"
> +sym_memcmp:  .asciz "memcmp"
> +sym_strncmp:  .asciz "strncmp"
> +sym_strcpy:  .asciz "strcpy"
> +sym_strcat:  .asciz "strcat"
> +sym_strcmp:  .asciz "strcmp"
> +
> +.macro define_function name
> +\name:
> +#if defined(x86_64) || defined(aarch64)
> +    __SPECIAL_INSTR
> +    .quad sym_\name
> +    __RET_INSTR
> +#elif defined(mips64)
> +.align 4
> +    __SPECIAL_INSTR
> +    .quad sym_\name
> +    __RET_INSTR
> +#elif defined(i386) || defined(mips) || defined(arm)
> +    __SPECIAL_INSTR
> +    .long sym_\name
> +    __RET_INSTR
> +#endif
> +.endm
> +
> +define_function memcpy
> +define_function strncpy
> +define_function memset
> +define_function memcmp
> +define_function strncmp
> +define_function strcpy
> +define_function strcat
> +define_function strcmp

This cannot possibly work, since none of the symbols are marked .globl, and are therefore 
not exported from your libnative.so.

Furthermore, you placed your strings in .data, but then failed to change back to .text, so 
none of the instructions are in an executable load segment.

I conclude that your testing succeeded only because no library calls were replaced.
This is not sufficient testing.

In review of previous versions, I have mentioned that the x86 UD0 instruction has more 
bytes than simply 0x0f 0xff -- at minimum 3 -- and moreover can be used in the assembler 
to produce pc-relative values.

We can clean up the assembly as follows.


r~


-----


.macro special_instr sym
#if defined(__i386__)
         ud0     \sym-1f, %eax; 1:
#elif defined(__x86_64__)
         ud0     \sym(%rip), %eax
#elif defined(__arm__) || defined(__aarch64__)
         hlt     0xffff
1:      .word   \sym - 1b
#elif defined(__mips__)
         syscall 0xffff
1:      .word   \sym - 1b
#else
# error
#endif
.endm

.macro ret_instr
#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
         ret
#elif defined(__arm__)
         bx	lr
#elif defined(__mips__)
         jr	$ra
#else
# error
#endif
.endm

/* Symbols of native functions */

.macro define_function name
         .text
\name:
         special_instr 9f
         ret_instr
         .globl \name
         .type \name, %function
         .size \name, . - \name

         .section .rodata
9:      .asciz  "\name"
.endm

define_function memcmp
define_function memcpy
define_function memset
define_function strcat
define_function strcmp
define_function strcpy
define_function strncmp
define_function strncpy

