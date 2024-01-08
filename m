Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6C826C55
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:14:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnZd-0005U8-Mi; Mon, 08 Jan 2024 06:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnZb-0005Tn-RP
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:13:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnZQ-0005u8-3b
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:13:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3375a236525so1633305f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704712406; x=1705317206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=va8c+InUhascOpnczOYKH80/dQ2VreW1F7lCKCBq8FI=;
 b=wnyIvaEc/UR7V0TSlfxGWJ0p6GDfA2h7Z0Umu4bfjOV4q5LB8qn0xbHhM+2B/EjOdA
 Fgg9jJlFM2AomztZ1WgOCv58brfYDjvgu8Fd/HbpVzZJt0Lc6EgbnggVGrHq5eBTuQR9
 /CozmOhPUQHpLh3NPw85omp+aMYGGiH4Z2d8/Y96Ojx5o6Z3yHW/iJ+nXdGFdXcoOrpi
 i5IWjbLNhQw3ovBN0VaZ/v7P8kRAFGTNDJB7uG+GOcmQPOP2IOn+UaHuI7NxW90O8cYl
 q6qRffi9j5UH1sfbR5Ou/fFUcdVpv2kjI9+eW/7Qwpv1F1vcPDPM2Zet4lAO40BtCcQH
 FzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704712406; x=1705317206;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=va8c+InUhascOpnczOYKH80/dQ2VreW1F7lCKCBq8FI=;
 b=ihRLKdUT4lTY+jK6k0bz1UGng61QYWdTVJr0egSUSBdLKdx7xYKU+QUFZOGuOVj7sD
 QTRBdXvB7715xDtGRXnXhTNruN78iPuulMDeQozo2sWevNhtJUjoND4LT9C2bkrW5PvM
 6dLD2q6kn/IKD+x4qn9JZAcb8kVr6Xj3cpquRkpvMMcw2945X6mWNFuxc5WdU1xT4Pvt
 yUbrHRNf6D0jgKjHUkiVsXVuaVsavgquotv5ers2Xm3nE+8iYklVu+CLLFV6ZRd+5evS
 KRAtfPykjLc5Iq4y+gE/eZlGBOSEONMgg4ZbxbtUywjnQlNo6D+BS5HwhptCmkdWDYFd
 1slw==
X-Gm-Message-State: AOJu0YzMeuUZ6XOUve2a3w13bo5/WizYQ85JQwM16J2cIQjKKdz6r2fr
 6uEst8KP0yMvxay1vzshzzlewMqj6Hxllg==
X-Google-Smtp-Source: AGHT+IEHU0D3wm66s8mwG4YZB1VMK4tgPRoPv7l/+qRN+GsLc//JgEKfjPSoQevbI7xXm+fZx5X//Q==
X-Received: by 2002:adf:e90b:0:b0:337:476f:9966 with SMTP id
 f11-20020adfe90b000000b00337476f9966mr1651480wrm.104.1704712405852; 
 Mon, 08 Jan 2024 03:13:25 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 a22-20020a5d4576000000b0033671314440sm7534347wrc.3.2024.01.08.03.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:13:25 -0800 (PST)
Message-ID: <ad0ac71a-20ab-4825-a98b-55ae62b40cf3@linaro.org>
Date: Mon, 8 Jan 2024 15:13:22 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/33] linux-user: Split out mmap_h_eq_g
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Move the MAX_FIXED_NOREPLACE check for reserved_va earlier.
> Move the computation of host_prot earlier.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 66 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 42eb3eb2b4..00003b8329 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -527,6 +527,31 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
>       return start;
>   }
>   
> +/*
> + * Special case host page size == target page size,
> + * where there are no edge conditions.
> + */
> +static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
> +                            int host_prot, int flags, int page_flags,
> +                            int fd, off_t offset)
> +{
> +    void *p, *want_p = g2h_untagged(start);
> +    abi_ulong last;
> +
> +    p = mmap(want_p, len, host_prot, flags, fd, offset);
> +    if (p == MAP_FAILED) {
> +        return -1;
> +    }
> +    if ((flags & MAP_FIXED_NOREPLACE) && p != want_p) {
> +        errno = EEXIST;
> +        return -1;
> +    }
> +
> +    start = h2g(p);
> +    last = start + len - 1;
> +    return mmap_end(start, last, start, last, flags, page_flags);
> +}
> +
>   static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>                                       int target_prot, int flags, int page_flags,
>                                       int fd, off_t offset)
> @@ -535,6 +560,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>       abi_ulong ret, last, real_start, real_last, retaddr, host_len;
>       abi_ulong passthrough_start = -1, passthrough_last = 0;
>       off_t host_offset;
> +    int host_prot;
>   
>       real_start = start & -host_page_size;
>       host_offset = offset & -host_page_size;
> @@ -543,16 +569,33 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>        * For reserved_va, we are in full control of the allocation.
>        * Find a suitible hole and convert to MAP_FIXED.
>        */
> -    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
> -        host_len = len + offset - host_offset;
> -        start = mmap_find_vma(real_start, host_len,
> -                              MAX(host_page_size, TARGET_PAGE_SIZE));
> -        if (start == (abi_ulong)-1) {
> -            errno = ENOMEM;
> -            return -1;
> +    if (reserved_va) {
> +        if (flags & MAP_FIXED_NOREPLACE) {
> +            /* Validate that the chosen range is empty. */
> +            if (!page_check_range_empty(start, start + len - 1)) {
> +                errno = EEXIST;
> +                return -1;
> +            }
> +            flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
> +        } else if (!(flags & MAP_FIXED)) {
> +            size_t real_len = len + offset - host_offset;
> +            abi_ulong align = MAX(host_page_size, TARGET_PAGE_SIZE);
> +
> +            start = mmap_find_vma(real_start, real_len, align);
> +            if (start == (abi_ulong)-1) {
> +                errno = ENOMEM;
> +                return -1;
> +            }
> +            start += offset - host_offset;
> +            flags |= MAP_FIXED;
>           }
> -        start += offset - host_offset;
> -        flags |= MAP_FIXED;
> +    }
> +
> +    host_prot = target_to_host_prot(target_prot);
> +
> +    if (host_page_size == TARGET_PAGE_SIZE) {
> +        return mmap_h_eq_g(start, len, host_prot, flags,
> +                           page_flags, fd, offset);
>       }
>   
>       /*
> @@ -588,12 +631,10 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>   
>       if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>           uintptr_t host_start;
> -        int host_prot;
>           void *p;
>   
>           host_len = len + offset - host_offset;
>           host_len = ROUND_UP(host_len, host_page_size);
> -        host_prot = target_to_host_prot(target_prot);
>   
>           /* Note: we prefer to control the mapping address. */
>           p = mmap(g2h_untagged(start), host_len, host_prot,
> @@ -716,8 +757,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>               len1 = real_last - real_start + 1;
>               want_p = g2h_untagged(real_start);
>   
> -            p = mmap(want_p, len1, target_to_host_prot(target_prot),
> -                     flags, fd, offset1);
> +            p = mmap(want_p, len1, host_prot, flags, fd, offset1);
>               if (p != want_p) {
>                   if (p != MAP_FAILED) {
>                       munmap(p, len1);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

