Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F93826BD1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnAp-00069S-Pr; Mon, 08 Jan 2024 05:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnAm-000693-Hz
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:48:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnAj-0001QP-MP
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:47:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d88fff7faso18666055e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704710875; x=1705315675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//7G/KcYPDqPu3BM6ETZwgXDt5E1eHgCl4b/TcDQpW4=;
 b=bSi8XUgpY9bGSEgeqaVUhY+dwLWNBH/9swsGTMRQhiT0wj1Wavdp9Ei61llMRZfPDI
 6E+8pwOEd0KmF7tga3Z5dIgfSBNQ6Yj0Y+np7Zd+xQU/abb120gy+nxS6ePMw3qSct5W
 DbsubXTqQc60Ihnk8T/BFSBkFr3mcuB3GbzxW+uvWeZYADLfb9ikbx3VYnascTQVuLOm
 DWZBX4cCnMRGlZT7mK6fSShrKyFmaGNKCA5fyqKdWfLE8Z1UF6nPdDi18GWxLg+CQ9Kt
 vRGHz7zesAE/uKB9ceIyJzAnYn4fZ/HeftQSoTHNb8TmR2vatL8BzUlhBEmePP2I9rbL
 EvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710875; x=1705315675;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//7G/KcYPDqPu3BM6ETZwgXDt5E1eHgCl4b/TcDQpW4=;
 b=qprt35APxoiWIc2gXlWBVI2TkDSpnAg7G2F2n7dwt/XgMKtXEruQ+ddfM0BHpZlTxC
 XoqyY7CnKGdmn/B6ywvnoTZziEKaLUX1viGC1/+VUw/YIHp3v9KpPm3AIp0JOE/0Dq5w
 A4HEdpTuhzfF8lAEutKXLZax5gsARCYIAqvowA2FgHf9snn9qs/MN4d5s+x9bNPsgen+
 eVUpizT7HHdZYJIdV1cD/VnpRT/Vldhx5TNS9rCs5DCT97cx28PU7kfH6/iC1ruCkXal
 GygKM7iTCkigrSsK86047dbWzikQmzEpmMf86YiWCpWJQJuAYKsZJX426pNNJS3DwsEY
 U7Qg==
X-Gm-Message-State: AOJu0YxHLIfoAtABBLZaPBgjOnC4JZABSn59oTW78ZuwSiTHrB12m5qg
 5oSosS9ojDH7J08dXCzmwql8WCtEumOwJw==
X-Google-Smtp-Source: AGHT+IGxBcnBDCRNTKqh019J4tNj6tdJZWCsdhIBVXaKt+J/2jm9xnEy2BjyVSPOIdbFPF6PVyY9Aw==
X-Received: by 2002:a05:600c:5407:b0:40e:4321:86b6 with SMTP id
 he7-20020a05600c540700b0040e432186b6mr648383wmb.80.1704710875302; 
 Mon, 08 Jan 2024 02:47:55 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b0040d3db8186fsm10671017wmq.5.2024.01.08.02.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 02:47:54 -0800 (PST)
Message-ID: <b29f3c6e-2b6e-4c39-b250-7c9c8276dc08@linaro.org>
Date: Mon, 8 Jan 2024 14:47:51 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/33] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-11-richard.henderson@linaro.org>
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
> This removes a hidden use of qemu_host_page_size, using instead
> the existing host_page_size local within each function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 53e5486cc8..d11f758d07 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -191,7 +191,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>   
>       last = start + len - 1;
>       host_start = start & -host_page_size;
> -    host_last = HOST_PAGE_ALIGN(last) - 1;
> +    host_last = ROUND_UP(last, host_page_size) - 1;
>       nranges = 0;
>   
>       mmap_lock();
> @@ -389,8 +389,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>           start &= -host_page_size;
>       }
>       start = ROUND_UP(start, align);
> -
> -    size = HOST_PAGE_ALIGN(size);
> +    size = ROUND_UP(size, host_page_size);
>   
>       if (reserved_va) {
>           return mmap_find_vma_reserved(start, size, align);
> @@ -550,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>        */
>       if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>           host_len = len + offset - host_offset;
> -        host_len = HOST_PAGE_ALIGN(host_len);
> +        host_len = ROUND_UP(host_len, host_page_size);
>           start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
>           if (start == (abi_ulong)-1) {
>               errno = ENOMEM;
> @@ -595,7 +594,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>           void *p;
>   
>           host_len = len + offset - host_offset;
> -        host_len = HOST_PAGE_ALIGN(host_len);
> +        host_len = ROUND_UP(host_len, host_page_size);
>           host_prot = target_to_host_prot(target_prot);
>   
>           /* Note: we prefer to control the mapping address. */
> @@ -625,7 +624,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>               goto fail;
>           }
>           last = start + len - 1;
> -        real_last = HOST_PAGE_ALIGN(last) - 1;
> +        real_last = ROUND_UP(last, host_page_size) - 1;
>   
>           /*
>            * Test if requested memory area fits target address space
> @@ -794,7 +793,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
>   
>       last = start + len - 1;
>       real_start = start & -host_page_size;
> -    real_last = HOST_PAGE_ALIGN(last) - 1;
> +    real_last = ROUND_UP(last, host_page_size) - 1;
>   
>       /*
>        * If guest pages remain on the first or last host pages,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

