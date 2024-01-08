Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B06826C14
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:06:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnRu-0008RR-5y; Mon, 08 Jan 2024 06:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnRq-0008Qt-GL
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:05:38 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnRl-0002Pv-20
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:05:38 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-783234dd689so64712685a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704711932; x=1705316732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMJS3FUYgeq0tN/94YGY7H+PUnw+pcyJL83oeew0uoM=;
 b=Ro7I7kde0LAIyp8+urrF6Ca30o2wb/0eKs9gmfsXzkBOslYIxlXpHaibYcCIC4Ee0B
 AXsqJVe3GnBHF0aWP0L3U9TRLdJhDUMAhDvrAwbV1bMevFer828kfZ1SdXyH2SHGtpNw
 ElFyZZC3bOHN6melyl1NLcIgUAFl6JGcO0vgJ74V9r7w9Nr0TKmTlGGuIjDvZ/y2E9FF
 6noRxr8kvZiBw1IWlQPk/gp4IURlhIqj1ldvjvxalKZMF/4wUbZKgeRkg4se5la1LcwQ
 wDjY6p4AFoc79TUFaFTGXPQrwa6rAU7fF72yCUc8jfyg4l0XXwvLO1DnrNwZQH7dEV85
 k9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711932; x=1705316732;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMJS3FUYgeq0tN/94YGY7H+PUnw+pcyJL83oeew0uoM=;
 b=ne6ZKoKJGLVRZNj1iCemyAmWkPsWvZ5rE8fdpX8UUXU3ZLyAWwtpLS988SEN5V44s5
 7PDV4OgeILroWqkS7koDLoqJ6WOvp06XhOtvQuQQrcZIxS9hmQ+OZOEzgzZs+LHrdgIN
 bGV5GFBPfsLXA90pfNXlaJdFiHAFhuH3y5IaFAi9ywWAt8Qj86AqMjawQXOp1I8WlQ4C
 vbOeG3GaeAP+zn7voR7jH2dv4reOMHbaB8CjViOkZ+4AImKF8dBu1DZ7UnLr5gWbqi59
 HWLJDKG/7FdnI4EmuKCUn1GsxqJgt12Hu3Hk2iJgZ061CnmsU4yJS2M5apvMuXCwGTpH
 yIYQ==
X-Gm-Message-State: AOJu0Yz0N4a+19rniqwyFIy8CLbg+d9n7CC3kEty20S0aBCR3goo0ZPf
 hGOJ2xTDab9bPoy5715oWS2QnZFn7EnhRA==
X-Google-Smtp-Source: AGHT+IGwpSgoGMcsukGH1Dvmakqe5yzfNHmtJhxOQTB4xWXhSZ6b7LGzLNPU8zY3ywvNG/0f5HvQPA==
X-Received: by 2002:a05:620a:27c4:b0:783:18c9:8302 with SMTP id
 i4-20020a05620a27c400b0078318c98302mr3514963qkp.153.1704711931961; 
 Mon, 08 Jan 2024 03:05:31 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05620a164a00b00781663f3161sm2592930qko.85.2024.01.08.03.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:05:31 -0800 (PST)
Message-ID: <bbb6360c-f35e-4061-a066-66c1dc088fee@linaro.org>
Date: Mon, 8 Jan 2024 15:05:29 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/33] linux-user: Do early mmap placement only for
 reserved_va
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x736.google.com
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
> For reserved_va, place all non-fixed maps then proceed
> as for MAP_FIXED.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index cc983bedbd..42eb3eb2b4 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -540,17 +540,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>       host_offset = offset & -host_page_size;
>   
>       /*
> -     * If the user is asking for the kernel to find a location, do that
> -     * before we truncate the length for mapping files below.
> +     * For reserved_va, we are in full control of the allocation.
> +     * Find a suitible hole and convert to MAP_FIXED.
>        */
> -    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
> +    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>           host_len = len + offset - host_offset;
> -        host_len = ROUND_UP(host_len, host_page_size);
> -        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
> +        start = mmap_find_vma(real_start, host_len,
> +                              MAX(host_page_size, TARGET_PAGE_SIZE));
>           if (start == (abi_ulong)-1) {
>               errno = ENOMEM;
>               return -1;
>           }
> +        start += offset - host_offset;
> +        flags |= MAP_FIXED;
>       }
>   
>       /*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

