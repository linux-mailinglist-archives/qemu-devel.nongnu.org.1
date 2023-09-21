Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED37A91E8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDoS-0001d5-3S; Thu, 21 Sep 2023 03:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDoP-0001cS-O0
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:09:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDoN-0000mW-LG
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:09:21 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c43b4b02c1so4615405ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695280155; x=1695884955;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TWfyEuvpqz6szBQ4tEp7ybEwfQo8bODU435dIJn/s7w=;
 b=maphkoZ0ds56B8brYWE67CVu3vWohyfOMf9ML5N2xOUsMQXfnFNAQkkBiUHbJuwHuk
 uqCroqCZob5fOdHSICpt+Ligyqp2NDdSv+waWDKfemdFZvx3zeyfistjdjh+Ii/1UiG3
 8P9EWzv3eA3LWCTRYh2N4v+ybYRyCy+fCY4qtINfhP5typL4cI5ZWaGxiVnQ+kLQlnLC
 0wWGhZJkIMTiT8gt9KpWtwuWzgvsWoUq3XycXYiw7IvBtIN3M6fq5U7Tj4/QL3TvVH64
 ek/aBC76K3jnKHXfGhNpIYNqinZ9OqEDQC8kFK4DbnB1Pg87nDhXJhThxbvPkp9n3xoh
 nBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695280155; x=1695884955;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TWfyEuvpqz6szBQ4tEp7ybEwfQo8bODU435dIJn/s7w=;
 b=lpW3xe8Ous4bCt6bfEFCE4+mauacKkjPSDsMPuqIFEmBL7EKFYrJJh51P/gRJrnI5m
 //OTddiBgJRMBj7vTsRTHvWp4sqWKtJYPB8kgl414mHFdSxk+d2YTgamZVNarhy6E5PN
 AtJEd0nAesm5Hz3jQ4rD4C9q7IJf5DFG1fWlugQ2L25Ph3XhAVDEeMlb74ZU4wJ+rd6g
 EWlJqFIEGSeCKz459QzRegJ/LRL+9S58LV0oAGpJrIxbWmIARXBANpHJ1+3QaSH8ajgN
 1zPSEILlmGFxScPuNXKUiVneC4m8tG5DRfLElamxrIPHWHCw2hrW4f8SHCAb83EKreec
 kPMg==
X-Gm-Message-State: AOJu0YzVflNmGEo8aMUxVzMMwcNZfSMEY29l8PrSjfc6/Y0g5b5MN/C7
 BSFC076Kjo1MWn3oz1uK6JAOYw==
X-Google-Smtp-Source: AGHT+IFJXy7x4vcnCIwt7OtySqTei3sTZwdfbrty5O7q7Xa+un34bX8N2dGfEFESsqAnbHW3EDXC6g==
X-Received: by 2002:a17:902:e743:b0:1c3:9544:cf63 with SMTP id
 p3-20020a170902e74300b001c39544cf63mr5992707plf.23.1695280155323; 
 Thu, 21 Sep 2023 00:09:15 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a170902ea8c00b001bde65894c8sm662125plb.268.2023.09.21.00.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:09:15 -0700 (PDT)
Message-ID: <619a188e-aaae-4d45-9aa5-bd9c4eac1a4d@daynix.com>
Date: Thu, 21 Sep 2023 16:09:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Undo incomplete mmap
Content-Language: en-US
Cc: qemu-devel@nongnu.org, joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230903053927.38037-1-akihiko.odaki@daynix.com>
To: Richard Henderson <richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230903053927.38037-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/03 14:39, Akihiko Odaki wrote:
> When the host page size is greater than the target page size and
> MAP_FIXED or MAP_FIXED_NOREPLACE is requested, mmap will be done for
> three parts: start, middle, and end. If a later part of mmap fail,
> mmap done in the earlier parts must be reverted.
> 
> Fixes: 54936004fd ("mmap emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V1 -> V2: Rebased.
> 
>   linux-user/mmap.c | 65 +++++++++++++++++++++++++++++------------------
>   1 file changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 9aab48d4a3..72521f8d27 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -224,13 +224,15 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>   
>   /* map an incomplete host page */
>   static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
> -                      int prot, int flags, int fd, off_t offset)
> +                      int prot, int flags, int fd, off_t offset, bool *mapped)
>   {
>       abi_ulong real_last;
>       void *host_start;
>       int prot_old, prot_new;
>       int host_prot_old, host_prot_new;
>   
> +    *mapped = false;
> +
>       if (!(flags & MAP_ANONYMOUS)
>           && (flags & MAP_TYPE) == MAP_SHARED
>           && (prot & PROT_WRITE)) {
> @@ -271,6 +273,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>               return false;
>           }
>           prot_old = prot;
> +        *mapped = true;
>       }
>       prot_new = prot | prot_old;
>   
> @@ -448,7 +451,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>   abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>                        int flags, int fd, off_t offset)
>   {
> -    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
> +    abi_ulong ret, last, real_start, retaddr, host_len;
>       abi_ulong passthrough_start = -1, passthrough_last = 0;
>       int page_flags;
>       off_t host_offset;
> @@ -577,12 +580,16 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>           passthrough_start = start;
>           passthrough_last = last;
>       } else {
> +        abi_ulong middle_start = HOST_PAGE_ALIGN(start);
> +        abi_ulong middle_last = ((start + len) & qemu_host_page_mask) - 1;
> +        abi_ulong mapped_len = 0;
> +        bool mapped;
> +
>           if (start & ~TARGET_PAGE_MASK) {
>               errno = EINVAL;
>               goto fail;
>           }
>           last = start + len - 1;
> -        real_last = HOST_PAGE_ALIGN(last) - 1;
>   
>           /*
>            * Test if requested memory area fits target address space
> @@ -649,35 +656,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>           }
>   
>           /* handle the start of the mapping */
> -        if (start > real_start) {
> -            if (real_last == real_start + qemu_host_page_size - 1) {
> +        if (start < middle_start) {
> +            if (last < middle_start) {
>                   /* one single host page */
>                   if (!mmap_frag(real_start, start, last,
> -                               target_prot, flags, fd, offset)) {
> +                               target_prot, flags, fd, offset, &mapped)) {
>                       goto fail;
>                   }
>                   goto the_end1;
>               }
> -            if (!mmap_frag(real_start, start,
> -                           real_start + qemu_host_page_size - 1,
> -                           target_prot, flags, fd, offset)) {
> +            if (!mmap_frag(real_start, start, middle_start - 1,
> +                           target_prot, flags, fd, offset, &mapped)) {
>                   goto fail;
>               }
> -            real_start += qemu_host_page_size;
> -        }
> -        /* handle the end of the mapping */
> -        if (last < real_last) {
> -            abi_ulong real_page = real_last - qemu_host_page_size + 1;
> -            if (!mmap_frag(real_page, real_page, last,
> -                           target_prot, flags, fd,
> -                           offset + real_page - start)) {
> -                goto fail;
> +            if (mapped) {
> +                mapped_len = qemu_host_page_size;
>               }
> -            real_last -= qemu_host_page_size;
>           }
>   
>           /* map the middle (easier) */
> -        if (real_start < real_last) {
> +        if (middle_start < middle_last) {
>               void *p, *want_p;
>               off_t offset1;
>               size_t len1;
> @@ -685,10 +683,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>               if (flags & MAP_ANONYMOUS) {
>                   offset1 = 0;
>               } else {
> -                offset1 = offset + real_start - start;
> +                offset1 = offset + middle_start - start;
>               }
> -            len1 = real_last - real_start + 1;
> -            want_p = g2h_untagged(real_start);
> +            len1 = middle_last - middle_start + 1;
> +            want_p = g2h_untagged(middle_start);
>   
>               p = mmap(want_p, len1, target_to_host_prot(target_prot),
>                        flags, fd, offset1);
> @@ -697,10 +695,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>                       munmap(p, len1);
>                       errno = EEXIST;
>                   }
> +                if (mapped_len) {
> +                    munmap(g2h_untagged(middle_start - mapped_len), mapped_len);
> +                }
> +                goto fail;
> +            }
> +            mapped_len += len1;
> +            passthrough_start = middle_start;
> +            passthrough_last = middle_last;
> +        }
> +
> +        /* handle the end of the mapping */
> +        if (last > middle_last) {
> +            abi_ulong real_page = middle_last + 1;
> +            if (!mmap_frag(real_page, real_page, last,
> +                           target_prot, flags, fd,
> +                           offset + real_page - start, &mapped)) {
> +                if (mapped_len) {
> +                    munmap(g2h_untagged(real_page - mapped_len), mapped_len);
> +                }
>                   goto fail;
>               }
> -            passthrough_start = real_start;
> -            passthrough_last = real_last;
>           }
>       }
>    the_end1:

Hi Richard,

Can you have a look at this patch?

Regards,
Akihiko Odaki

