Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1E769B01
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQV3u-0006Cc-F2; Mon, 31 Jul 2023 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQV3i-00067W-KD
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:43:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQV3g-0008N1-U1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:43:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso2536901b3a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690818223; x=1691423023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f8cJcC4RbArnAGiE69w8pWMyV6bnKyyviouduxDBX3k=;
 b=OJoAQDVABCLz+Mka1FKlspKkwBIlzPOXTVpxHYiWLkl7vXrRyJ4hJGXIG5odHGcf2X
 sv9icfmCkmqK5D8jpLXrdCHvjVM3Q93vF03FRcyCkkypRU5uFSn1AB8hOhZSsxrYb9aL
 wEj4AoyCCBbYwZFgMCYhoUMIGnLh5WyCnzMh36bYTkg6XklDj1KkhlXDpk/zEzOK6y0y
 ZgyUu3FRF7ZK1XPaqGMegqLjpm6zGBMInzgFsfi9/r1j+L0ikLPjQy6X9BdwoSuFSKfU
 MpfTgX0ET8qCz+uyBXnwdqDIf55t5Ss/47Ieo1CQ1eceaSCmbkaH74+oqbgkTwlCB35E
 PXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690818223; x=1691423023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f8cJcC4RbArnAGiE69w8pWMyV6bnKyyviouduxDBX3k=;
 b=IK7PQaFu/H3H875sQduPrVtUld8bpGmdvTTfJa0iwTGP/eIDICCJnXGq5gVvwkHleG
 SEqJ0kwoIsxpghQZCsTV3SrrvvHo8AM0TFiCv49+ohO01cNFQHeTwUJEUIyao6unOxZI
 6Lx6/CK3o2tlRrL7WERpM6C3Be7Y0IHMiUNc6GtwIFvNbnkvpBkw20bKENH3xxQWoxef
 wzThDxyNkzXhpDXv1QnN2JE2fo/h2L46Ak6QqZgJ6Vu2HiidjUUizaEkcG57/lWaauSW
 BkT5b/m9vC0DOZpO7D78QnBh/Ei0x/EnBR09lOuRoz/cCish1mLCoxTmAHH9vaWxz7i+
 YpXw==
X-Gm-Message-State: ABy/qLbWlDqLReeNJD3XEBcc2lnkIE+ROg4rtfCID+Ae+KHH/KxK5mwH
 RWHicDx+3kQufCa1mTuP0CxJ6w==
X-Google-Smtp-Source: APBJJlEz5V4/9BeenkoCRjgz8jzaw8Csld8g+AY+5G276iAF6feifWJeO2i/V6OD9jN6ahH3h1fxnw==
X-Received: by 2002:a05:6a00:2314:b0:67b:a681:4ab2 with SMTP id
 h20-20020a056a00231400b0067ba6814ab2mr11410807pfh.25.1690818223374; 
 Mon, 31 Jul 2023 08:43:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 i22-20020aa787d6000000b00682669dc19bsm7808289pfo.201.2023.07.31.08.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 08:43:42 -0700 (PDT)
Message-ID: <7112be79-071a-fd59-e4c0-c4cf21953d45@linaro.org>
Date: Mon, 31 Jul 2023 08:43:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] linux-user: Unset MAP_FIXED_NOREPLACE for host
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-2-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230731080317.112658-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/31/23 01:03, Akihiko Odaki wrote:
> Passing MAP_FIXED_NOREPLACE to host will fail if the virtual
> address space is reserved with mmap. Replace it with MAP_FIXED.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   linux-user/mmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index a5dfb56545..2f26cbaf5d 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -610,6 +610,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>               goto fail;
>           }
>   
> +        flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;

This is wrong for 64-bit guests, when reserved_va is not in effect.


r~


