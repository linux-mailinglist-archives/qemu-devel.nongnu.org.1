Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071D8269E8
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:56:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMlQ7-0003Ep-GW; Mon, 08 Jan 2024 03:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlQ4-0003ER-JA
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:55:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlQ2-0000rD-L7
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:55:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e4a611182so743855e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704704136; x=1705308936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wNPKS6ZsSHnjI+U11qtnYjaFamsrtzwUInX4Yw2Eftw=;
 b=E3ecKnbv+ahxrlHKSkvxqEEcC3FvtPBSBU2qQrrjniUhdR6P2v5RWv4z4XjC6WhEiO
 /gU/d5Mwgi6Rz49C4EPIENL+1wc0puWHi4t1CRj3RTg4onqRRAN414ICboeWBII4heUY
 nILS7Wj654g6QvMx04VkfcAOrLahFrEXveNyRcc95RAXRTrdub4eX994NwiyWYa2UwzB
 D7mbWhGmwYGBKBjSWqXOtjkF/dknazssN/d3SOFNNGL4isXkcjUi7laIgteJnQt/hRsb
 a0ULceGV35a627aKBh2V3qLK7iTvVwaH4J2BirJHMS931qox9gb8zVGlAxglcbyhgGUW
 Xfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704704136; x=1705308936;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wNPKS6ZsSHnjI+U11qtnYjaFamsrtzwUInX4Yw2Eftw=;
 b=ptM5QJ/fop0xtd6SUkJnB/D0ymLAQH3WTS1noXrqCq8V/oNT3muKICMifAD19oJk77
 IfEArqlqB5wlY3nBbqrbDlUVN4FvZ/vKpBqKF721t4mbobU0F+bap2gcXFXHS9kJLOgW
 OM2sKgk+q30BVXusmwz13u71G4cYVgLa9L5lTZi4J5L4JANASA7+BBWnzO7Oc3+TNKph
 F8dOZV2TZlWnZb8OxzM5jyHw9g2opm3jpv+mmj75X6l7dmzdvCqF6yMbGYSXZP6lYWhn
 RF4kYayBlDa2qtDwOQGEDhbLw0UAG8a/fSqB4Zgoca2zWkcUFl96nxakzCIkRqb97eDv
 nukA==
X-Gm-Message-State: AOJu0YwOlyOK9+M1aX4bKNunnLB+ki+GS4cRImM/3uLWuPdMVZm4y0z/
 JFHASxiTzyvru6WkgxOOlugeAJmdLf04Vw==
X-Google-Smtp-Source: AGHT+IHFJY/ht93WILv1kiA6uNkTFy4PrysQhbilsLyyp4jQ294YXtLd8h9VUe4OYX+teRvwJftqgg==
X-Received: by 2002:a05:600c:4f4a:b0:40d:3864:a2a7 with SMTP id
 m10-20020a05600c4f4a00b0040d3864a2a7mr1730144wmq.111.1704704136323; 
 Mon, 08 Jan 2024 00:55:36 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a05600c4e4900b0040e38859c47sm10272245wmq.16.2024.01.08.00.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:55:36 -0800 (PST)
Message-ID: <5f0ae0b7-9d27-4e36-abe5-612394c1d86e@linaro.org>
Date: Mon, 8 Jan 2024 12:55:33 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/33] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x336.google.com
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
> AT_PAGESZ is supposed to advertise the guest page size.
> The random adjustment made here using qemu_host_page_size
> does not match anything else within linux-user.
> 
> The idea here is good, but should be done more systemically
> via adjustment to TARGET_PAGE_SIZE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4df565d64b..c166faabab 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2678,13 +2678,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>       NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
>       NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>       NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
> -    if ((info->alignment & ~qemu_host_page_mask) != 0) {
> -        /* Target doesn't support host page size alignment */
> -        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
> -    } else {
> -        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE,
> -                                               qemu_host_page_size)));
> -    }
> +    NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
>       NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_info ? interp_info->load_addr : 0));
>       NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
>       NEW_AUX_ENT(AT_ENTRY, info->entry);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

