Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4B3826A64
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 10:13:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMlfq-0008IE-HU; Mon, 08 Jan 2024 04:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlfo-0008I2-Sj
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:11:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlfn-0008VN-4K
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:11:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e461c1f44so8391415e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704705113; x=1705309913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gPadjRPzUhe5F+wvpTPLh5u1btarH3/mGpQy9Nfohcc=;
 b=ucaNAOPsTlpBhZsCuZImCE/FW0kSNgVVmb0s7NMib5UyS6jn7D9MdvgxAjLbCVWi1P
 uG7gh3eLJEUCVgxyIBh+smgOPwSUg+Wh9wsp+qpD9BxcVM6rzVDBdN7czcETLqYD4ntw
 v0BgEdhCHEdU/o3ElpuI3AqpWXHxhNkWyZzokDpqlUxdolyvLXxGqLOGve8k3XQnoj6W
 FJUBerZMGRJnR1/vipYvTKmDBEo5+kHY/Cxcm8KgXCdvAYJcHaWYNBoRD7O2x71IGzYB
 mFTddyh2WcgvmKawSQTjbM+Tda2kcRARAn3vwzzV1U8z9Id8qd3Y1UFTFjks5wJHqCwA
 1VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704705113; x=1705309913;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPadjRPzUhe5F+wvpTPLh5u1btarH3/mGpQy9Nfohcc=;
 b=A3mg9DHgMizZLrAwxCJ8GV8ZlgTnwCe/nGkGv5EsXFfnEkzbqNWoyWKekb5OM7ZdIQ
 5X/KSVNnVsjm4fXc2A3pniMz0U3Lz//hEvetSKxXTHEPWZNc4sFy7n9qUb/EH9RuSd89
 IsN89MsVNsQzgi0JADMoKtXOLprDRcmmF+RhMYn9e25VWwn9A2G5r7xt2tD2nJ3bD83x
 BE0n4M0+YzpxMcr/5/fkLfQzccMKQAlUhAU0vSIuPIYYr8VvbDB6r3UM+sjBKaHnPRmX
 PURUtKhIktoepSBie2gHQ7tbVoqv/S476Pz0yWecRXVOdmxq/RJOxmlQ6VHuPckCrBvb
 XOUg==
X-Gm-Message-State: AOJu0Yx6XfXAcilxP1Fkg4no7RMhCqG9W9Xh7mMixM7eWXteTxbyk5wg
 mnE9DYrhDtlEjdu3gUV+T6kepvZRMP6a8g==
X-Google-Smtp-Source: AGHT+IGgU+DSI0d/YEgy7DzdJjSC78l+YSum87tsGRO4BhZHqdVdfvDh/jgxhWdtYwiQ7p4C3I5utg==
X-Received: by 2002:a05:600c:358f:b0:40d:5b34:18b4 with SMTP id
 p15-20020a05600c358f00b0040d5b3418b4mr1585466wmq.91.1704705113104; 
 Mon, 08 Jan 2024 01:11:53 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a05600c1c0300b0040e48e4bf8asm1257663wms.10.2024.01.08.01.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 01:11:52 -0800 (PST)
Message-ID: <0915849a-476e-45eb-ba10-cbcb443691a8@linaro.org>
Date: Mon, 8 Jan 2024 13:11:48 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/33] linux-user/nios2: Remove qemu_host_page_size
 from init_guest_commpage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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
> Use qemu_real_host_page_size.
> If !reserved_va, use MAP_FIXED_NOREPLACE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 96d8d4f84c..4fcc490ce6 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1531,10 +1531,14 @@ static bool init_guest_commpage(void)
>                    0x3a, 0x68, 0x3b, 0x00,  /* trap 0 */
>       };
>   
> -    void *want = g2h_untagged(LO_COMMPAGE & -qemu_host_page_size);
> -    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
> -                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +    int host_page_size = qemu_real_host_page_size();
> +    void *want, *addr;
>   
> +    want = g2h_untagged(LO_COMMPAGE & -host_page_size);
> +    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
> +                MAP_ANONYMOUS | MAP_PRIVATE |
> +                (reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
> +                -1, 0);
>       if (addr == MAP_FAILED) {
>           perror("Allocating guest commpage");
>           exit(EXIT_FAILURE);
> @@ -1543,9 +1547,9 @@ static bool init_guest_commpage(void)
>           return false;
>       }
>   
> -    memcpy(addr, kuser_page, sizeof(kuser_page));
> +    memcpy(g2h_untagged(LO_COMMPAGE), kuser_page, sizeof(kuser_page));
>   
> -    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
> +    if (mprotect(addr, host_page_size, PROT_READ)) {
>           perror("Protecting guest commpage");
>           exit(EXIT_FAILURE);
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

