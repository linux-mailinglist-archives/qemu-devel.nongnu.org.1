Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356C826C37
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:09:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnVE-0002we-LM; Mon, 08 Jan 2024 06:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnVB-0002wW-H1
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:09:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnV9-0003ha-51
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:09:04 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso18989945e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704712140; x=1705316940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYsD72qvVwC++D6GX18pmh6hcI29VSQVyawlFyZF7Tw=;
 b=Mai4FdE3T6iyKOdg9Z1987IvYAWiOtI4+WPOnv3Ci6u16nRV2Uhm9yssaZekZlLiXU
 Krj05OWutW4VhoN6rKPVH30r2uzZDdKZqoMaqHCVALvFZe2+5nQEEaEnJ2uk0NuKzo/L
 fG2Pm8gjqS1BIlaAedfv3E9mWm+BQ8OLKOS5Jgo+j2FoLBPY+SDsiBHV960aPwdIXhdh
 vHGFIOIM48uxNAsIs9cLb8Pr5Br3s7PglUBjWRIaUhihUBVnkZsrhuQgGPfbFZziWrV2
 AURjXSdfmyTA7N4PY2KxiT73c7SEk7Z4ybA5sya5W56H9B26zsEFITxHitWOTgWeu/oI
 zkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704712140; x=1705316940;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mYsD72qvVwC++D6GX18pmh6hcI29VSQVyawlFyZF7Tw=;
 b=N6nfJLp3YjeBpWZw8J+Bc3n8MpU1O75oIQacqYFcLH3TlrOguvdDLiELtlmksi1s1F
 9+BrPQN4f1d8E1gEl09Tp9ww3oJgItQSpJF4u+t1t06fxG50GeBaTHlYkVjiwOuUMD2z
 kCqpiKtzLLEhpuXOkfcCG+gKGPZJOVaNz4QL3j/1kYyCVNcrYaOiB8paWz+Yelg4BEE3
 Mm7+AdWHncSUW6mvp1o3bl61BbKc47bwdlk0RCZicEQCvG5jsIF4w3DV2uqCva/XnXhv
 XGAqtWAZGADhQsLHzaQAxOtmK7oxyAd9Vvj9dIYsoN2IIX50ZupJ4khluH1Hl232lDXB
 YA3Q==
X-Gm-Message-State: AOJu0YxseQDYctVFQSGyB3XcdPFMkvkBeUgcg4prByplhuQo9YkNDV5Q
 syKOZY3r82aqELOPotOwDbnQ5ziqKrwDDUKsBeHkX8NsNcU=
X-Google-Smtp-Source: AGHT+IHg8CA92lMydpm05+Ape8JisJ5EWbgfeTzvctGlMSdFD827nO1dQhALPXE4o2nM1BIwCXAKrQ==
X-Received: by 2002:a05:600c:4704:b0:40e:490d:2967 with SMTP id
 v4-20020a05600c470400b0040e490d2967mr174485wmo.26.1704712140474; 
 Mon, 08 Jan 2024 03:09:00 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c351100b0040d839e7bb3sm10576834wmq.19.2024.01.08.03.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:09:00 -0800 (PST)
Message-ID: <b41db9b3-850d-4b15-8e79-b18f19aa4acf@linaro.org>
Date: Mon, 8 Jan 2024 15:08:57 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/33] softmmu/physmem: Remove HOST_PAGE_ALIGN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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
> Align allocation sizes to the maximum of host and target page sizes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/physmem.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index c09953270f..c1e48dfb6a 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1680,7 +1680,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>   
>       assert(block);
>   
> -    newsize = HOST_PAGE_ALIGN(newsize);
> +    newsize = TARGET_PAGE_ALIGN(newsize);
> +    newsize = REAL_HOST_PAGE_ALIGN(newsize);
>   
>       if (block->used_length == newsize) {
>           /*
> @@ -1916,7 +1917,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>           return NULL;
>       }
>   
> -    size = HOST_PAGE_ALIGN(size);
> +    size = TARGET_PAGE_ALIGN(size);
> +    size = REAL_HOST_PAGE_ALIGN(size);
> +
>       file_size = get_file_size(fd);
>       if (file_size > offset && file_size < (offset + size)) {
>           error_setg(errp, "backing store size 0x%" PRIx64
> @@ -2014,13 +2017,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>   {
>       RAMBlock *new_block;
>       Error *local_err = NULL;
> +    int align;
>   
>       assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
>                             RAM_NORESERVE)) == 0);
>       assert(!host ^ (ram_flags & RAM_PREALLOC));
>   
> -    size = HOST_PAGE_ALIGN(size);
> -    max_size = HOST_PAGE_ALIGN(max_size);
> +    align = qemu_real_host_page_size();
> +    align = MAX(align, TARGET_PAGE_SIZE);
> +    size = ROUND_UP(size, align);
> +    max_size = ROUND_UP(max_size, align);
> +
>       new_block = g_malloc0(sizeof(*new_block));
>       new_block->mr = mr;
>       new_block->resized = resized;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

