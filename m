Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64E76C894
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7Sr-0004ey-7y; Wed, 02 Aug 2023 04:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR7Sp-0004dr-Ml
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:44:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR7Sn-0004g9-Dp
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:44:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so52211045ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690965852; x=1691570652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s0SzmlBXtFQO0nRfUmQ/X7m786JjVxpL29DonCamCyA=;
 b=n7jDHg/9H+L181g/1Kj0syBv4rwzYmIPPXyONgkGr+oXfwXBs4bLZX2HYpZQ8qTtx1
 /RdVGS/kH9d1tloFWxMNolfbbNQaSXA792iymgaJ4xOxt0UfK7yUY+o8kLqiXsK15Myo
 EUA7P9Wm9YQgokmTrHiEOuSkeGZLgM7kw3ayYEzlL3fNptW5Y4goW8YkAZWKu24XybsO
 aH71WQ+y9Jd5LHXTIx4tVJtUJyeztu7AYxEbQ5EvHoEKQJ4DaJ9uPlmZqeZrvcw2xQ3A
 p4KGbbaUTSypZjbgmjOAGsJArGyyea0JjZMSQbhHgF6NyR6fxw9G3vMKuGbBkfNEKy39
 nI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690965852; x=1691570652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0SzmlBXtFQO0nRfUmQ/X7m786JjVxpL29DonCamCyA=;
 b=G1YXmZ0fMXesCQCYfpWu4zwHm7mGK5L4Zt6AM1s8+FRuVijddRjAsTZnIlb0+9TIS3
 IOG4ql/c/imQCfAsNTH10TFuQhcZCj6bxHEIL3iHOgWT0DIR5QWYuAsc70FOoddSZDTY
 x1yvL19ZRCt5GrcOTi07Wb2NRfrsNRb3mIE+qwx2adLKT9WAdlHtD2w5EhKmFqcK1q52
 rG/Ro8f05jihOTmd4I0gdnDfA+jYWGIqYKUuVgFYVR1b4l6TntrIs0d32a/1rHMeLh5p
 1mRuPreFi+jEfFnPwoCALexJBn7IeO3GzrjXHuWDWABFj5py3gTRTjxJ/lf5P/jzhqWA
 dtNw==
X-Gm-Message-State: ABy/qLYtimIX5iK2ivVUjISzdGiRcfLcz3QDz40FLnBQgXhdBARQSky3
 7UuEspiHcC0eBNSV8CGXPR8E1A==
X-Google-Smtp-Source: APBJJlELvHxT8YizPEfWFdhugtgNRUAGnuvqS4A/JVvuh2RrVQB4lQlOY4+PzlfNjG1/pNGl1Vk3KA==
X-Received: by 2002:a17:903:18f:b0:1b8:10a:d925 with SMTP id
 z15-20020a170903018f00b001b8010ad925mr17689303plg.5.1690965851923; 
 Wed, 02 Aug 2023 01:44:11 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a170902a40900b001bbaf09ce15sm11765570plq.152.2023.08.02.01.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 01:44:11 -0700 (PDT)
Message-ID: <6f73b04e-7c85-0dfb-c3cc-7a43b4663593@daynix.com>
Date: Wed, 2 Aug 2023 17:44:09 +0900
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
 <6126807c-2390-27d9-315d-de67c31a8f60@daynix.com>
 <c1e68eb1-6d26-22fd-8c51-c1ba1e472187@gmx.de>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <c1e68eb1-6d26-22fd-8c51-c1ba1e472187@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

On 2023/08/02 17:42, Helge Deller wrote:
> On 8/2/23 09:49, Akihiko Odaki wrote:
>> On 2023/08/02 8:27, Helge Deller wrote:
>>> Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address 
>>> for all
>>> 32-bit architectures, based on the GUEST_ADDR_MAX constant.
>>>
>>> Additionally modify the elf loader to load dynamic pie executables at
>>> around:
>>> ~ 0x5500000000  for 64-bit guest binaries on 64-bit host,
>>> - 0x00300000    for 32-bit guest binaries on 64-bit host, and
>>> - 0x00000000    for 32-bit guest binaries on 32-bit host.
>>
>> Why do you change guest addresses depending on the host?
> 
> The addresses are guest-addresses.
> A 32-bit guest PIE can't be loaded at e.g. 0x5500000000,
> while a 64-bit guest PIE needs to be loaded at 0x5500000000.

I mean, why do you use address 0x00000000 for 32-bit guest binaries on 
32-bit host while you use address 0x00300000 on 64-bit host?

> 
>>> With this patch the Thread Sanitizer (TSan) application will work again,
>>> as in commit aab613fb9597 ("linux-user: Update TASK_UNMAPPED_BASE for
>>> aarch64").
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>   linux-user/elfload.c |  6 ++++--
>>>   linux-user/loader.h  | 12 ++++++++++++
>>>   linux-user/mmap.c    | 35 ++++++++++++++++++-----------------
>>>   3 files changed, 34 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index 47a118e430..8f5a79b537 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -3021,6 +3021,7 @@ static void load_elf_image(const char 
>>> *image_name, int image_fd,
>>>       struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
>>>       struct elf_phdr *phdr;
>>>       abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
>>> +    unsigned long load_offset = 0;
>>>       int i, retval, prot_exec;
>>>       Error *err = NULL;
>>>       bool is_main_executable;
>>> @@ -3121,6 +3122,7 @@ static void load_elf_image(const char 
>>> *image_name, int image_fd,
>>>                * select guest_base.  In this case we pass a size.
>>>                */
>>>               probe_guest_base(image_name, 0, hiaddr - loaddr);
>>> +            load_offset = TASK_UNMAPPED_BASE_PIE;
>>>           }
>>>       }
>>>
>>> @@ -3138,7 +3140,7 @@ static void load_elf_image(const char 
>>> *image_name, int image_fd,
>>>        * In both cases, we will overwrite pages in this range with 
>>> mappings
>>>        * from the executable.
>>>        */
>>> -    load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, 
>>> PROT_NONE,
>>> +    load_addr = target_mmap(loaddr + load_offset, (size_t)hiaddr - 
>>> loaddr + 1, PROT_NONE,
>>>                               MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>>>                               (is_main_executable ? MAP_FIXED : 0),
>>>                               -1, 0);
>>> @@ -3176,7 +3178,7 @@ static void load_elf_image(const char 
>>> *image_name, int image_fd,
>>>       info->start_data = -1;
>>>       info->end_data = 0;
>>>       /* possible start for brk is behind all sections of this ELF 
>>> file. */
>>> -    info->brk = TARGET_PAGE_ALIGN(hiaddr);
>>> +    info->brk = TARGET_PAGE_ALIGN(load_offset + hiaddr);
>>>       info->elf_flags = ehdr->e_flags;
>>>
>>>       prot_exec = PROT_EXEC;
>>> diff --git a/linux-user/loader.h b/linux-user/loader.h
>>> index 59cbeacf24..3bbfc108eb 100644
>>> --- a/linux-user/loader.h
>>> +++ b/linux-user/loader.h
>>> @@ -18,6 +18,18 @@
>>>   #ifndef LINUX_USER_LOADER_H
>>>   #define LINUX_USER_LOADER_H
>>>
>>> +/* where to map binaries? */
>>> +#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
>>> +# define TASK_UNMAPPED_BASE_PIE 0x5500000000
>>> +# define TASK_UNMAPPED_BASE    0x7000000000
>>> +#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
>>> +# define TASK_UNMAPPED_BASE_PIE    0x00300000
>>> +# define TASK_UNMAPPED_BASE    (GUEST_ADDR_MAX - 0x20000000 + 1)
>>> +#else /* HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32 */
>>> +# define TASK_UNMAPPED_BASE_PIE    0x00000000
>>> +# define TASK_UNMAPPED_BASE    0x40000000
>>> +#endif
>>> +
>>>   /*
>>>    * Read a good amount of data initially, to hopefully get all the
>>>    * program headers loaded.
>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>> index c624feead0..3441198e21 100644
>>> --- a/linux-user/mmap.c
>>> +++ b/linux-user/mmap.c
>>> @@ -23,6 +23,7 @@
>>>   #include "user-internals.h"
>>>   #include "user-mmap.h"
>>>   #include "target_mman.h"
>>> +#include "loader.h"
>>>
>>>   static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
>>>   static __thread int mmap_lock_count;
>>> @@ -295,23 +296,6 @@ static bool mmap_frag(abi_ulong real_start, 
>>> abi_ulong start, abi_ulong last,
>>>       return true;
>>>   }
>>>
>>> -#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
>>> -#ifdef TARGET_AARCH64
>>> -# define TASK_UNMAPPED_BASE  0x5500000000
>>> -#else
>>> -# define TASK_UNMAPPED_BASE  0x4000000000
>>> -#endif
>>> -#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
>>> -#ifdef TARGET_HPPA
>>> -# define TASK_UNMAPPED_BASE  0xfa000000
>>> -#else
>>> -# define TASK_UNMAPPED_BASE  0xe0000000
>>> -#endif
>>> -#else /* HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32 */
>>> -# define TASK_UNMAPPED_BASE  0x40000000
>>> -#endif
>>> -abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
>>> -
>>>   unsigned long last_brk;
>>>
>>>   /*
>>> @@ -344,6 +328,23 @@ abi_ulong mmap_find_vma(abi_ulong start, 
>>> abi_ulong size, abi_ulong align)
>>>       abi_ulong addr;
>>>       int wrapped, repeat;
>>>
>>> +    static abi_ulong mmap_next_start;
>>> +
>>> +    /* initialize mmap_next_start if necessary */
>>> +    if (!mmap_next_start) {
>>> +        mmap_next_start = TASK_UNMAPPED_BASE;
>>> +
>>> +        /* do sanity checks on guest memory layout */
>>> +        if (mmap_next_start >= GUEST_ADDR_MAX) {
>>> +            mmap_next_start = GUEST_ADDR_MAX - 0x1000000000 + 1;
>>
>> What if GUEST_ADDR_MAX < 0x1000000000?
> 
> this check affects 64-bit executables only where GUEST_ADDR_MAX is bigger
> than that number. But I agree it's not directly visible from the code.
> 32-bit ones are taken care of where TASK_UNMAPPED_BASE is defined.
> 
>> I think you can just return a hard error when mmap_next_start >= 
>> GUEST_ADDR_MAX.
> 
> Can't happen, but I will rewrite it.
> 
>>> +        }
>>> +
>>> +        if (TASK_UNMAPPED_BASE_PIE >= mmap_next_start) {
>>> +            fprintf(stderr, "Memory too small for PIE executables.\n");
>>
>> Perhaps it's better to use error_report() for new code.
> 
> Ok.
> 
> Helge

