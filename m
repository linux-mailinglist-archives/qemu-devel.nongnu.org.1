Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C1E76D6D9
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 20:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRGXM-0004wz-Jp; Wed, 02 Aug 2023 14:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRGXK-0004uj-Jw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:25:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRGXI-0008MO-Fx
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:25:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b8b4749013so1422965ad.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691000727; x=1691605527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g1/Cz1I9pv5fDvK5AxMy9YAVQEeL0VzRtoCYMF4CnW4=;
 b=JbrFhsHY5hzTPxjyQQZRumcSub0OMBvSBXBZ2zZf/60p58Um+KyXVg8vO4SSlOVVsP
 3pOXLRiwyRgDNttmcTg2aHwOugooLeB+JE4wgZwHy+2NFZl9Ooi7c5CULtE3P2ig5dJZ
 I1z+otIiqTYGFWO/OpBVch/NNNrLmVm4dg9s2eGox3FKIHuJDVdIi5FLMpDQbxonRq9s
 VTOl2yRw9m3G4ytHKGhyPbyAiHkTqNiVaOgWM7T/SvR7TAn6iHskBdYJrTu+VhtVcoRg
 wdqTCXsxq0E4o1ABEQedgyDe7FbNzspFZSJcXb7OxeJ+KudGQsyZCz29jwzH4J9pclwo
 zuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691000727; x=1691605527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g1/Cz1I9pv5fDvK5AxMy9YAVQEeL0VzRtoCYMF4CnW4=;
 b=dHoz0LOQy3plsYwmpYlSTkO2Tie65TCpHeZk3rYLuo6HLyoFw+rp7kRjqChHGV6ZBg
 BYc3N2BdLNMQhb6fna8j1a6cX09UPMCs+rFzM9fQNY5fVbngnvozFm1QqOKNCFC1af6D
 PrBG/o8eKEeh2SDdlKOjwbkZ+uWoNwSIOLj8xuyeEwd1QnpUs6lgIFcY0darSApiTJkN
 zreMTcC2TX8xX8ldAy5kZKLWxDiZEXaFhcDTBRq84QKjGfGaUKeK4t6ASzRD0tB9W5Rs
 m4Nc3/OFanDyYQwPcr7G72ECAlmtpI62Mhac0Vnk3ulgHnblFkx1NJrNfQFMjtU+zFwy
 obuA==
X-Gm-Message-State: ABy/qLYFePzqOEWLSuIfRmlPRYcP+u3RgWafq7QAkw1wWZEPmsNYLUGg
 NdEhbsZ7x6o97e5g8zrXvoMnZw==
X-Google-Smtp-Source: APBJJlFQmCqtHNZR1Sx1azODLWeuUxPwcaj9jarobn+OU1bK/XdEaTZ5cqDXMebDprKny4Gp3bprqQ==
X-Received: by 2002:a17:902:ce81:b0:1b9:e23a:f761 with SMTP id
 f1-20020a170902ce8100b001b9e23af761mr18774880plg.63.1691000726719; 
 Wed, 02 Aug 2023 11:25:26 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a17090341c900b001b9da8b4eb7sm12720139ple.35.2023.08.02.11.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 11:25:26 -0700 (PDT)
Message-ID: <bdf9ebc2-ef7a-7dd4-a742-8bbf5e836aea@linaro.org>
Date: Wed, 2 Aug 2023 11:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 7/8] linux-user: Optimize memory layout for static and
 dynamic executables
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-8-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801232745.4125-8-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/1/23 16:27, Helge Deller wrote:
> Reorganize the guest memory layout to get as much memory as possible for
> heap for the guest application.
> 
> This patch optimizes the memory layout by loading pie executables
> into lower memory and shared libs into higher memory (at
> TASK_UNMAPPED_BASE). This leaves a bigger memory area usable for heap
> space which will be located directly after the executable.
> Up to now, pie executable and shared libs were loaded directly behind
> each other in the area at TASK_UNMAPPED_BASE, which leaves very little
> space for heap.
> 
> I tested this patchset with chroots of alpha, arm, armel, arm64, hppa, m68k,
> mips64el, mipsel, powerpc, ppc64, ppc64el, s390x, sh4 and sparc64 on a x86-64
> host, and with a static armhf binary (which fails to run without this patch).
> 
> This patch temporarily breaks the Thread Sanitizer (TSan) application
> which expects specific boundary definitions for memory mappings on
> different platforms [1], see commit aab613fb9597 ("linux-user: Update
> TASK_UNMAPPED_BASE for aarch64") for aarch64. The follow-up patch fixes it
> again.
> 
> [1] https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/elfload.c | 55 +++++++++++++-------------------------------
>   linux-user/mmap.c    |  8 ++++---
>   2 files changed, 21 insertions(+), 42 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 2aee2298ec..47a118e430 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3023,6 +3023,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>       abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
>       int i, retval, prot_exec;
>       Error *err = NULL;
> +    bool is_main_executable;
> 
>       /* First of all, some simple consistency checks */
>       if (!elf_check_ident(ehdr)) {
> @@ -3106,28 +3107,8 @@ static void load_elf_image(const char *image_name, int image_fd,
>           }
>       }
> 
> -    if (pinterp_name != NULL) {
> -        /*
> -         * This is the main executable.
> -         *
> -         * Reserve extra space for brk.
> -         * We hold on to this space while placing the interpreter
> -         * and the stack, lest they be placed immediately after
> -         * the data segment and block allocation from the brk.
> -         *
> -         * 16MB is chosen as "large enough" without being so large as
> -         * to allow the result to not fit with a 32-bit guest on a
> -         * 32-bit host. However some 64 bit guests (e.g. s390x)
> -         * attempt to place their heap further ahead and currently
> -         * nothing stops them smashing into QEMUs address space.
> -         */
> -#if TARGET_LONG_BITS == 64
> -        info->reserve_brk = 32 * MiB;
> -#else
> -        info->reserve_brk = 16 * MiB;
> -#endif
> -        hiaddr += info->reserve_brk;
> -
> +    is_main_executable = (pinterp_name != NULL);

This will be false for static main executables.


> +    if (is_main_executable) {
>           if (ehdr->e_type == ET_EXEC) {
>               /*
>                * Make sure that the low address does not conflict with
> @@ -3136,7 +3117,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>               probe_guest_base(image_name, loaddr, hiaddr);
>           } else {
>               /*
> -             * The binary is dynamic, but we still need to
> +             * The binary is dynamic (pie-executabe), but we still need to
>                * select guest_base.  In this case we pass a size.
>                */
>               probe_guest_base(image_name, 0, hiaddr - loaddr);
> @@ -3159,7 +3140,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>        */
>       load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
>                               MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
> -                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
> +                            (is_main_executable ? MAP_FIXED : 0),

This is definitely wrong, as all ET_EXEC require FIXED.
(In addition to static, it is possible to write an ET_EXEC interpreter.)

> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -299,14 +299,16 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>   #ifdef TARGET_AARCH64
>   # define TASK_UNMAPPED_BASE  0x5500000000
>   #else
> -# define TASK_UNMAPPED_BASE  (1ul << 38)
> +# define TASK_UNMAPPED_BASE  0x4000000000
>   #endif
> -#else
> +#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
>   #ifdef TARGET_HPPA
>   # define TASK_UNMAPPED_BASE  0xfa000000
>   #else
> -# define TASK_UNMAPPED_BASE  0x40000000
> +# define TASK_UNMAPPED_BASE  0xe0000000
>   #endif
> +#else /* HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32 */
> +# define TASK_UNMAPPED_BASE  0x40000000
>   #endif
>   abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;

This should be a separate change.

While we're at it, we should move this to e.g. linux-user/$GUEST/target_mman.h, and make 
this match each guest kernel's TASK_UNMAPPED_BASE.  It really shouldn't depend on the host 
at all.


r~


