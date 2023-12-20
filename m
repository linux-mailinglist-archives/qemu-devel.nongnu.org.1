Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E869A81967C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 02:47:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFlf3-0001cE-Jj; Tue, 19 Dec 2023 20:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rFlf0-0001bY-Ip
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 20:46:10 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rFley-0005zd-BX
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 20:46:10 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67ab5e015aaso38569086d6.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 17:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703036766; x=1703641566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqn3KMJ5g/VK+CZXLjmrErjc7rLMnYIMFlq297CCPAM=;
 b=hD4Y/+Wi38SgJrX/MQlyBMdRwKv25UdWqWnRZaULB6mOHM0Z5H0Z+awn7jAB0iH6bJ
 0ISR1l6AQOX1ZjxEO6nNbldiNA1KhZlXxrXrF/bvQloSF0KD0PPNDd1cLMAKa45plE+L
 WFsYHXEFQ+npLzAhV3SvFIRJJiMqlmUfgND6C1mUyIfpg4g9Sh+6gTrk+AYrFQAU9Rgd
 IlChozXuaupgte9/0Wt54zaWY1TIM2ul9E4ca9BhAlFsDbOKwpXgkPsOWrWZy0UCzzrC
 xS312iyZ9WvSnrEIFlxkqgsIlL3nKUgPlSXSIkDVKYpuIm2FfedNZOrQQ1OBI/8pBvO1
 3oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703036767; x=1703641567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqn3KMJ5g/VK+CZXLjmrErjc7rLMnYIMFlq297CCPAM=;
 b=AR41npLTemaQzBJ8+6xb2gyxiOxLZqlGhTgZdPMCpa9I/NoB2QAElhTfmIzM47qb+r
 ja3jUl9Ek+/znr7TQ8TG9yz6W4L++VhL2MzNuim/V/TQQzru0L9R/aWiu+hW1yZbUTS4
 NYBbAeBFwXs5WvI0UqLvhGo76ZzNYkdT7q7DcmVVswUhFnxVGrwf44V9YhZ3lOTO5GD8
 M6pnDSRZzIHfhfhv7SKzr9WCgmWgRiJEnF/hWTHWOwdTe7A3aZER1pIkG6H49jQ63Mau
 e/upxzRFyx9UL6ThJ91Sxf5ZGKMQFp1lcDlIR9NOqOKYj3touLjxFv6QrGqFxapXvdzV
 cmWw==
X-Gm-Message-State: AOJu0YztWdQ0Met6iy8xCyhJlD+QT2Moe4Eh3f3K0iOImDg//wC9HHps
 2Sa/gX7voGA5Yotd0CtVej7V6w==
X-Google-Smtp-Source: AGHT+IHlgBpPcwiizwD2l5zncernGUmljdLJcxnwmopKyCq41nlbCQnUyzFY+Dthlix4Qs3JMg95DA==
X-Received: by 2002:a05:6214:2686:b0:67f:38c0:e97c with SMTP id
 gm6-20020a056214268600b0067f38c0e97cmr7515004qvb.72.1703036766684; 
 Tue, 19 Dec 2023 17:46:06 -0800 (PST)
Received: from [192.168.44.231] ([172.58.160.19])
 by smtp.gmail.com with ESMTPSA id
 jx13-20020a0562142b0d00b0067f4f07587csm1725740qvb.69.2023.12.19.17.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 17:46:05 -0800 (PST)
Message-ID: <1c5f886a-821e-46ff-bcea-045b07ebf809@linaro.org>
Date: Tue, 19 Dec 2023 17:45:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: Fix ubsan warning with unaligned pointer access
To: Daniel Hoffman <dhoff749@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:Virtual Open Firm..." <qemu-ppc@nongnu.org>
References: <20231217001441.146344-1-dhoff749@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231217001441.146344-1-dhoff749@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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

On 12/16/23 16:14, Daniel Hoffman wrote:
> Found while running QTest with UBsan. Unaligned pointers appear to be
> valid, so moving the read to an explicit memcpy to an intermediate.
> ---
>   hw/ppc/vof.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index e3b430a81f4..609a51c645d 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -646,7 +646,10 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>       if (sc == 2) {
> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
> +        /* Pointer may be unaligned */
> +        uint64_t mem0_end_copy;
> +        memcpy(&mem0_end_copy, mem0_reg + sizeof(uint32_t) * ac, sizeof(mem0_end_copy));
> +        mem0_end = be64_to_cpu(mem0_end_copy);

mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);


r~

