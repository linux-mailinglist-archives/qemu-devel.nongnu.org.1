Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DFE76C76C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6cG-0002oj-8v; Wed, 02 Aug 2023 03:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR6cE-0002nw-8v
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:49:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR6cC-0008Qk-7u
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:49:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc34b32785so1896205ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690962591; x=1691567391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FC/IqXqLAMtSpIR3kn0P3CAh5iOFM86gxzwQRpTi+4Q=;
 b=U1wK9LldyV/xpiidDF5BkOctNMqnE71lgvLh/Gn4oj2nXCxATH67Aoberqgnwvas5u
 G6niU3HC1C1IqMrWEW07WH5WVuMeOLYnv/7mhsUfEEbZUcRs6Dy95d37fe7hD+QaQRCL
 8l3tdoVg4RSY4MGXkGrnRfCtgMqoxVnOZ5QfJB3+Ene0927EY/hFYjPAdnm0wmDYhE36
 NET9dT8MEuZybXZiU3w3AD6Xf83Ah5cmlqA9MjnJoWwi2/hTLqtcxkM3SPhaLyYk4zQ9
 P7RiAQLBUjoK3muq9CS8H/i412DLsyfPafuQA13oBnI0GyfuStzvY+4YtU6NRhSk0lcs
 iFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690962591; x=1691567391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FC/IqXqLAMtSpIR3kn0P3CAh5iOFM86gxzwQRpTi+4Q=;
 b=BpUEhsecz20q57xa1UlEm7XheAE0oPAXLKSJV2kakWrnEZ48Vw5CkyAaekgnaAVgmz
 3vomoLiYwhfPTG6l8rGX3igs7Wf1/hfddQHc6IqwCLYsRXMI1yW1osaLUCfXc7E4BZ4R
 nHdQq/zCPJXvRzMAt/V4k8zch7mLDL9f1YNdt+wQ0yR5hNDhj4Tf2lZllmRIVhfrRzfA
 EW+o8aGgjAJAklrGItcJJEPJBZ/H+lI8du5nIXSKXUAlzysW8w2hVD0xQrPjAyY/rASE
 ZKESwqDpcnhrePcqi8VxwOgr1aifXIkydEBUZeot6Ya4WFT1xD+uB9M5ih4cYL5JgQdH
 QFpg==
X-Gm-Message-State: ABy/qLZaHR4GbZWeC6eED6EvYuVmy0UkX6YNYQnBoWfFDP2c/X65nog1
 Uk4wQsqZyG+UdN6bQ72znbvEJw==
X-Google-Smtp-Source: APBJJlHbCDWFJxMjEVZFYVB96eNbKBtx74mOt6s+cdf5xE7B1ZrHh2yePZeIvfRSv6ltYANSAVLYMA==
X-Received: by 2002:a17:902:bc88:b0:1b9:f7f4:5687 with SMTP id
 bb8-20020a170902bc8800b001b9f7f45687mr11112145plb.24.1690962590762; 
 Wed, 02 Aug 2023 00:49:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a170902eb4500b001ae0a4b1d3fsm11704336pli.153.2023.08.02.00.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 00:49:50 -0700 (PDT)
Message-ID: <6126807c-2390-27d9-315d-de67c31a8f60@daynix.com>
Date: Wed, 2 Aug 2023 16:49:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-9-deller@gmx.de>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230801232745.4125-9-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/02 8:27, Helge Deller wrote:
> Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address for all
> 32-bit architectures, based on the GUEST_ADDR_MAX constant.
> 
> Additionally modify the elf loader to load dynamic pie executables at
> around:
> ~ 0x5500000000  for 64-bit guest binaries on 64-bit host,
> - 0x00300000    for 32-bit guest binaries on 64-bit host, and
> - 0x00000000    for 32-bit guest binaries on 32-bit host.

Why do you change guest addresses depending on the host?

> 
> With this patch the Thread Sanitizer (TSan) application will work again,
> as in commit aab613fb9597 ("linux-user: Update TASK_UNMAPPED_BASE for
> aarch64").
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/elfload.c |  6 ++++--
>   linux-user/loader.h  | 12 ++++++++++++
>   linux-user/mmap.c    | 35 ++++++++++++++++++-----------------
>   3 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 47a118e430..8f5a79b537 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3021,6 +3021,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>       struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
>       struct elf_phdr *phdr;
>       abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
> +    unsigned long load_offset = 0;
>       int i, retval, prot_exec;
>       Error *err = NULL;
>       bool is_main_executable;
> @@ -3121,6 +3122,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>                * select guest_base.  In this case we pass a size.
>                */
>               probe_guest_base(image_name, 0, hiaddr - loaddr);
> +            load_offset = TASK_UNMAPPED_BASE_PIE;
>           }
>       }
> 
> @@ -3138,7 +3140,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>        * In both cases, we will overwrite pages in this range with mappings
>        * from the executable.
>        */
> -    load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
> +    load_addr = target_mmap(loaddr + load_offset, (size_t)hiaddr - loaddr + 1, PROT_NONE,
>                               MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>                               (is_main_executable ? MAP_FIXED : 0),
>                               -1, 0);
> @@ -3176,7 +3178,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>       info->start_data = -1;
>       info->end_data = 0;
>       /* possible start for brk is behind all sections of this ELF file. */
> -    info->brk = TARGET_PAGE_ALIGN(hiaddr);
> +    info->brk = TARGET_PAGE_ALIGN(load_offset + hiaddr);
>       info->elf_flags = ehdr->e_flags;
> 
>       prot_exec = PROT_EXEC;
> diff --git a/linux-user/loader.h b/linux-user/loader.h
> index 59cbeacf24..3bbfc108eb 100644
> --- a/linux-user/loader.h
> +++ b/linux-user/loader.h
> @@ -18,6 +18,18 @@
>   #ifndef LINUX_USER_LOADER_H
>   #define LINUX_USER_LOADER_H
> 
> +/* where to map binaries? */
> +#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
> +# define TASK_UNMAPPED_BASE_PIE 0x5500000000
> +# define TASK_UNMAPPED_BASE	0x7000000000
> +#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
> +# define TASK_UNMAPPED_BASE_PIE	0x00300000
> +# define TASK_UNMAPPED_BASE	(GUEST_ADDR_MAX - 0x20000000 + 1)
> +#else /* HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32 */
> +# define TASK_UNMAPPED_BASE_PIE	0x00000000
> +# define TASK_UNMAPPED_BASE	0x40000000
> +#endif
> +
>   /*
>    * Read a good amount of data initially, to hopefully get all the
>    * program headers loaded.
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index c624feead0..3441198e21 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -23,6 +23,7 @@
>   #include "user-internals.h"
>   #include "user-mmap.h"
>   #include "target_mman.h"
> +#include "loader.h"
> 
>   static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
>   static __thread int mmap_lock_count;
> @@ -295,23 +296,6 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>       return true;
>   }
> 
> -#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
> -#ifdef TARGET_AARCH64
> -# define TASK_UNMAPPED_BASE  0x5500000000
> -#else
> -# define TASK_UNMAPPED_BASE  0x4000000000
> -#endif
> -#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
> -#ifdef TARGET_HPPA
> -# define TASK_UNMAPPED_BASE  0xfa000000
> -#else
> -# define TASK_UNMAPPED_BASE  0xe0000000
> -#endif
> -#else /* HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32 */
> -# define TASK_UNMAPPED_BASE  0x40000000
> -#endif
> -abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
> -
>   unsigned long last_brk;
> 
>   /*
> @@ -344,6 +328,23 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>       abi_ulong addr;
>       int wrapped, repeat;
> 
> +    static abi_ulong mmap_next_start;
> +
> +    /* initialize mmap_next_start if necessary */
> +    if (!mmap_next_start) {
> +        mmap_next_start = TASK_UNMAPPED_BASE;
> +
> +        /* do sanity checks on guest memory layout */
> +        if (mmap_next_start >= GUEST_ADDR_MAX) {
> +            mmap_next_start = GUEST_ADDR_MAX - 0x1000000000 + 1;

What if GUEST_ADDR_MAX < 0x1000000000? I think you can just return a 
hard error when mmap_next_start >= GUEST_ADDR_MAX.

> +        }
> +
> +        if (TASK_UNMAPPED_BASE_PIE >= mmap_next_start) {
> +            fprintf(stderr, "Memory too small for PIE executables.\n");

Perhaps it's better to use error_report() for new code.

> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>       align = MAX(align, qemu_host_page_size);
> 
>       /* If 'start' == 0, then a default start address is used. */
> --
> 2.41.0
> 

