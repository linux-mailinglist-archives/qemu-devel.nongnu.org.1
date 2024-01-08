Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01989826AD0
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 10:36:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMm2T-0003kV-5X; Mon, 08 Jan 2024 04:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMm2R-0003kI-7j
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:35:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMm2P-0001mT-M7
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:35:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e43e4890cso12339055e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 01:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704706515; x=1705311315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G4rTDylFChqa0HgmRGUXVBLg4pMxUtHCdFzWSYuYVfk=;
 b=P9VGb/cZNKcrkwIKwDtkDWnaqwvNWozSOEe6QcrsZRaXE0JEe6vIDu1nGOCKKdLV/D
 YI23+1ThJiRIppI3aMMGC4vHXoBHZZNzLnuuWhvxCBLNK/2vbarVKCeoZQdbGGQ08+oO
 t01c49MEfOZPGeRsN8an9xHBv7BkMixv49BMeH9aBkoj4LJvHdwYRXS2kxuD8IZ2Xups
 0wQgIsrLEVz2f+A0YDm0cUTB+3MrlfeoXfIWlEcg1NMXkLzxpsNG9hYVgHuv0BtJBMEg
 Au9P4tbkI0PqzjEvebOU/B2lRSHneiOvJZVhVw1pyPORrMu7Msfbh6onZUFcoa+fYQkv
 IKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704706515; x=1705311315;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4rTDylFChqa0HgmRGUXVBLg4pMxUtHCdFzWSYuYVfk=;
 b=PHGf/stt3/1kTQS1VL1PERjs+EaB0Yt78+blGIirCCuUvmDhEflzdI0yWvRfYn95sg
 BWpo8aSUU+GSqIiqWJx9KgH1xy1K/GBG5TEaOoFIqIIHUYGqxoa9yX+yfjjtQI1d7gNe
 3GnOM6NE15ciR1kPsuEytfVzVDmSESFbceSOVGRo53e/1ryQpcBwfgrWq4fzubVxhLXF
 6WlXoceu38UjhD1Lqu2EgY7BXYvPJLmQEKCguzRMyPMvytG4YKGGZyK2XZhr24VpBKiW
 5g3gjCT27oPSNrsvDvKAUr3qC2lmDHoRKB0TU+NNAq66E6k4OpR8hQdvhQ7YrRNRqIFv
 zw2w==
X-Gm-Message-State: AOJu0YxMBHtDO2WJb/bpnHHqUUIoRRld+0yBec+LVRvZXt7Vq/MgAxEy
 YyY2ZOu8WqVOnMJ2ig/3gWNYUdZQQhukyA==
X-Google-Smtp-Source: AGHT+IHCUzRtKzQtlC0123sjoSZzXkz1Zn4d69DXK0xT8cPQkN1f69t89Oxqv5dgSmvfgG7Dmhznow==
X-Received: by 2002:a7b:ce92:0:b0:40e:43cf:bbe2 with SMTP id
 q18-20020a7bce92000000b0040e43cfbbe2mr704017wmj.175.1704706515452; 
 Mon, 08 Jan 2024 01:35:15 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a05600c190a00b0040d8eca092esm10323627wmq.47.2024.01.08.01.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 01:35:15 -0800 (PST)
Message-ID: <5f18bff0-ac80-4062-9160-622b4f787bbd@linaro.org>
Date: Mon, 8 Jan 2024 13:35:11 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/33] linux-user: Remove qemu_host_page_{size, mask}
 in probe_guest_base
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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
> The host SHMLBA is by definition a multiple of the host page size.
> Thus the remaining component of qemu_host_page_size is the
> target page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3c1e0fb64..4df565d64b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2892,7 +2892,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
>   
>       /* Add any HI_COMMPAGE not covered by reserved_va. */
>       if (reserved_va < HI_COMMPAGE) {
> -        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
> +        ga->bounds[n][0] = HI_COMMPAGE & -qemu_real_host_page_size();
>           ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
>           n++;
>       }
> @@ -3074,7 +3074,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
>                         abi_ulong guest_hiaddr)
>   {
>       /* In order to use host shmat, we must be able to honor SHMLBA.  */
> -    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
> +    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
>   
>       /* Sanity check the guest binary. */
>       if (reserved_va) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

