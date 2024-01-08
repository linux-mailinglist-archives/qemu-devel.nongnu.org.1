Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC65E826B15
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 10:48:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMmEN-0007ZH-FM; Mon, 08 Jan 2024 04:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMmED-0007Y9-3z
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:47:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMmEA-00077W-TR
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:47:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e485c49acso4500555e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704707245; x=1705312045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=spnOjLm89RZwx1uB6u0obnJwzkFs9TCdvWgM4Pn1EAU=;
 b=ky3R8ydhD3MQr3RcRnZkenexi2Hb26t4+uerMHaBXerjlONOLx4VvUoKc8eBIANXFL
 Sfm3hYG3Vs3WnV4AHYs7T0ETK03N97rdM9TQXrG4LEZ6sSajjQoViEcB3FuHQjEmn0Cz
 8AFcb4F2HFflKunZROgqLcg7Kgo6DQGHerndB/stwh5cdKA18KLuRWJ9+eeyzQ7IMbII
 98RhdsvzqowNALqCa9EZ/V2oOWN36FXiDXVXL9rTRVCKIpKxojsN0Cwp5aF4Hmfs2Q+R
 1NP59Abkzxq6K7o3smH33HlBnqlQ2YYoj2ZZusA5amVRhllxOnrDhiw9aNhZBiMYy9iw
 sRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704707245; x=1705312045;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spnOjLm89RZwx1uB6u0obnJwzkFs9TCdvWgM4Pn1EAU=;
 b=mkc4kdEvHQqVSEv2qDaby3JGzUfP5+bgj6iXKNoOS1y5OZpWWleSnNFgz2EzDM/KEs
 PBqQxqIX3dzE/FPaPp74LRm/d/iZMoUCQGJ7LbM7OqOngx/BZFUayTqOh8hbr80Foi8S
 R2BE9KmFevdFvhnaGaM4zFZO8+X0r9z8Q95IDogHY0szTZjD+geinZ3VW6JEWEoTHcwP
 AgqsYfXf15pIGkLrhwZT3bMKAfNf+uypQPrD/tSBhNxHUIrPinzGA3Wq46ceKG/9Bxc1
 hMNE5NeDIgaraFJZXFciFWe9iBRkTDVMPs7iUqYY3xWGlvAQTWom7bCfLC7S5c1F6/hJ
 PCwA==
X-Gm-Message-State: AOJu0YwI1YsnrHrGopqrkXJ6NGo0YnMYM4sxQIWCakfykmL/9GXJSqOz
 8GbieRVrF7dXJxOvNko52xGLsKy5+sAhxQ==
X-Google-Smtp-Source: AGHT+IE+5kKGzU4yGouGv23yo8wykBA3msqSP0xBCTgn6TLv1q/HaTXwog1hEkaW13OjQSKsAPz4YQ==
X-Received: by 2002:a05:600c:4504:b0:40e:3edf:106f with SMTP id
 t4-20020a05600c450400b0040e3edf106fmr1590536wmo.35.1704707245112; 
 Mon, 08 Jan 2024 01:47:25 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a05600c1c8500b0040e418494absm6423193wms.46.2024.01.08.01.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 01:47:24 -0800 (PST)
Message-ID: <eb59bc7a-ecad-472f-a808-146c2e12e275@linaro.org>
Date: Mon, 8 Jan 2024 13:47:21 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/33] linux-user: Remove qemu_host_page_{size, mask}
 from mmap.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/2/24 05:57, Richard Henderson wrote:
> Use qemu_real_host_page_size instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 66 +++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 96c9433e27..4d3c8717b9 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -165,6 +165,7 @@ static int target_to_host_prot(int prot)
>   /* NOTE: all the constants are the HOST ones, but addresses are target. */
>   int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>   {
> +    int host_page_size = qemu_real_host_page_size();
>       abi_ulong starts[3];
>       abi_ulong lens[3];
>       int prots[3];
> @@ -189,13 +190,13 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>       }
>   
>       last = start + len - 1;
> -    host_start = start & qemu_host_page_mask;
> +    host_start = start & -host_page_size;
>       host_last = HOST_PAGE_ALIGN(last) - 1;
>       nranges = 0;
>   
>       mmap_lock();
>   
> -    if (host_last - host_start < qemu_host_page_size) {
> +    if (host_last - host_start < host_page_size) {
>           /* Single host page contains all guest pages: sum the prot. */
>           prot1 = target_prot;
>           for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
> @@ -205,7 +206,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>               prot1 |= page_get_flags(a + 1);
>           }
>           starts[nranges] = host_start;
> -        lens[nranges] = qemu_host_page_size;
> +        lens[nranges] = host_page_size;
>           prots[nranges] = prot1;
>           nranges++;
>       } else {
> @@ -218,10 +219,10 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>               /* If the resulting sum differs, create a new range. */
>               if (prot1 != target_prot) {
>                   starts[nranges] = host_start;
> -                lens[nranges] = qemu_host_page_size;
> +                lens[nranges] = host_page_size;
>                   prots[nranges] = prot1;
>                   nranges++;
> -                host_start += qemu_host_page_size;
> +                host_start += host_page_size;
>               }
>           }
>   
> @@ -233,9 +234,9 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>               }
>               /* If the resulting sum differs, create a new range. */
>               if (prot1 != target_prot) {
> -                host_last -= qemu_host_page_size;
> +                host_last -= host_page_size;
>                   starts[nranges] = host_last + 1;
> -                lens[nranges] = qemu_host_page_size;
> +                lens[nranges] = host_page_size;
>                   prots[nranges] = prot1;
>                   nranges++;
>               }
> @@ -270,6 +271,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>   static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>                         int prot, int flags, int fd, off_t offset)
>   {
> +    int host_page_size = qemu_real_host_page_size();
>       abi_ulong real_last;
>       void *host_start;
>       int prot_old, prot_new;
> @@ -286,7 +288,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>           return false;
>       }
>   
> -    real_last = real_start + qemu_host_page_size - 1;
> +    real_last = real_start + host_page_size - 1;
>       host_start = g2h_untagged(real_start);
>   
>       /* Get the protection of the target pages outside the mapping. */
> @@ -304,12 +306,12 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>            * outside of the fragment we need to map.  Allocate a new host
>            * page to cover, discarding whatever else may have been present.
>            */
> -        void *p = mmap(host_start, qemu_host_page_size,
> +        void *p = mmap(host_start, host_page_size,
>                          target_to_host_prot(prot),
>                          flags | MAP_ANONYMOUS, -1, 0);
>           if (p != host_start) {
>               if (p != MAP_FAILED) {
> -                munmap(p, qemu_host_page_size);
> +                munmap(p, host_page_size);
>                   errno = EEXIST;
>               }
>               return false;
> @@ -324,7 +326,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>       /* Adjust protection to be able to write. */
>       if (!(host_prot_old & PROT_WRITE)) {
>           host_prot_old |= PROT_WRITE;
> -        mprotect(host_start, qemu_host_page_size, host_prot_old);
> +        mprotect(host_start, host_page_size, host_prot_old);
>       }
>   
>       /* Read or zero the new guest pages. */
> @@ -338,7 +340,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>   
>       /* Put final protection */
>       if (host_prot_new != host_prot_old) {
> -        mprotect(host_start, qemu_host_page_size, host_prot_new);
> +        mprotect(host_start, host_page_size, host_prot_new);
>       }
>       return true;
>   }
> @@ -373,17 +375,18 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
>    */
>   abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>   {
> +    int host_page_size = qemu_real_host_page_size();
>       void *ptr, *prev;
>       abi_ulong addr;
>       int wrapped, repeat;
>   
> -    align = MAX(align, qemu_host_page_size);
> +    align = MAX(align, host_page_size);
>   
>       /* If 'start' == 0, then a default start address is used. */
>       if (start == 0) {
>           start = mmap_next_start;
>       } else {
> -        start &= qemu_host_page_mask;
> +        start &= -host_page_size;
>       }
>       start = ROUND_UP(start, align);
>   
> @@ -492,6 +495,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>   abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>                        int flags, int fd, off_t offset)
>   {
> +    int host_page_size = qemu_real_host_page_size();
>       abi_ulong ret, last, real_start, real_last, retaddr, host_len;
>       abi_ulong passthrough_start = -1, passthrough_last = 0;
>       int page_flags;
> @@ -537,8 +541,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>           }
>       }
>   
> -    real_start = start & qemu_host_page_mask;
> -    host_offset = offset & qemu_host_page_mask;
> +    real_start = start & -host_page_size;
> +    host_offset = offset & -host_page_size;
>   
>       /*
>        * If the user is asking for the kernel to find a location, do that
> @@ -567,8 +571,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>        * may need to truncate file maps at EOF and add extra anonymous pages
>        * up to the targets page boundary.
>        */
> -    if ((qemu_real_host_page_size() < qemu_host_page_size) &&
> -        !(flags & MAP_ANONYMOUS)) {
> +    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
>           struct stat sb;
>   
>           if (fstat(fd, &sb) == -1) {
> @@ -595,11 +598,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>           host_len = HOST_PAGE_ALIGN(host_len);
>           host_prot = target_to_host_prot(target_prot);
>   
> -        /*
> -         * Note: we prefer to control the mapping address. It is
> -         * especially important if qemu_host_page_size >
> -         * qemu_real_host_page_size.
> -         */
> +        /* Note: we prefer to control the mapping address. */
>           p = mmap(g2h_untagged(start), host_len, host_prot,
>                    flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
>           if (p == MAP_FAILED) {
> @@ -665,7 +664,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>            * aligned, so we read it
>            */
>           if (!(flags & MAP_ANONYMOUS) &&
> -            (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
> +            (offset & (host_page_size - 1)) != (start & (host_page_size - 1))) {
>               /*
>                * msync() won't work here, so we return an error if write is
>                * possible while it is a shared mapping
> @@ -694,7 +693,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>   
>           /* handle the start of the mapping */
>           if (start > real_start) {
> -            if (real_last == real_start + qemu_host_page_size - 1) {
> +            if (real_last == real_start + host_page_size - 1) {
>                   /* one single host page */
>                   if (!mmap_frag(real_start, start, last,
>                                  target_prot, flags, fd, offset)) {
> @@ -703,21 +702,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>                   goto the_end1;
>               }
>               if (!mmap_frag(real_start, start,
> -                           real_start + qemu_host_page_size - 1,
> +                           real_start + host_page_size - 1,
>                              target_prot, flags, fd, offset)) {
>                   goto fail;
>               }
> -            real_start += qemu_host_page_size;
> +            real_start += host_page_size;
>           }
>           /* handle the end of the mapping */
>           if (last < real_last) {
> -            abi_ulong real_page = real_last - qemu_host_page_size + 1;
> +            abi_ulong real_page = real_last - host_page_size + 1;
>               if (!mmap_frag(real_page, real_page, last,
>                              target_prot, flags, fd,
>                              offset + real_page - start)) {
>                   goto fail;
>               }
> -            real_last -= qemu_host_page_size;
> +            real_last -= host_page_size;
>           }
>   
>           /* map the middle (easier) */
> @@ -784,6 +783,7 @@ fail:
>   
>   static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
>   {
> +    int host_page_size = qemu_real_host_page_size();
>       abi_ulong real_start;
>       abi_ulong real_last;
>       abi_ulong real_len;
> @@ -793,7 +793,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
>       int prot;
>   
>       last = start + len - 1;
> -    real_start = start & qemu_host_page_mask;
> +    real_start = start & -host_page_size;
>       real_last = HOST_PAGE_ALIGN(last) - 1;
>   
>       /*
> @@ -802,7 +802,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
>        * The single page special case is required for the last page,
>        * lest real_start overflow to zero.
>        */
> -    if (real_last - real_start < qemu_host_page_size) {
> +    if (real_last - real_start < host_page_size) {
>           prot = 0;
>           for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
>               prot |= page_get_flags(a);
> @@ -818,14 +818,14 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
>               prot |= page_get_flags(a);
>           }
>           if (prot != 0) {
> -            real_start += qemu_host_page_size;
> +            real_start += host_page_size;
>           }
>   
>           for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
>               prot |= page_get_flags(a + 1);
>           }
>           if (prot != 0) {
> -            real_last -= qemu_host_page_size;
> +            real_last -= host_page_size;
>           }
>   
>           if (real_last < real_start) {

For me, the transformation ~page_mask == page_size - 1 and page_mask == 
-page_size was not so intuitive, until I tried it on paper.

Could it be useful to have macros PAGE_BITS(page_size), and 
PAGE_MASK(page_size) for this?. All would be defined from page_sz, so 
there is no duplicated data, and it would avoid a subtle error when 
forgetting an operator, while helping to read the code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

