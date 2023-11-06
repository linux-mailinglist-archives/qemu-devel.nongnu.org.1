Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FB7E27D1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:56:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0117-0001DX-6f; Mon, 06 Nov 2023 09:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r0115-0001Cy-6h
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:55:51 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r0113-00057T-Jc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:55:50 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d0ea3e5b8so30007646d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699282548; x=1699887348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YBrtcxk9Aq0MlzXldrwkcgyEcYRbn/MOspQjLzWeMWE=;
 b=f2no2AGBTAWNlA+7QQeYnNAkruENwrj07r4Zr4bjqIoghnuzKXQdSm0mg5p6MtfRQm
 vX+dF1HuJPQpwSqaykx75cDmnFH6cEsApqdWZLrWWLKNXzRfp6lvG0xYc1KUbdUPHfzE
 B97IsWXJJ2L0nQVEAHySWRnEsdAPKCzmeGV+3LA9Omv/jHE0b5/9Kwx+j/LrLvrlx/3K
 bbwfXrCi3DZV+LSb7xxKImQT1tZiwp1Tos9w9Yvw4afXTmyl94WYNhYqS37mj50ueX+f
 AFqinyTC5DCZ/SSZ5a7FY6/mXM5ROTOwSXaa4wh8DVcynkVSiM+qxU0VloqDZtChXBq3
 yISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282548; x=1699887348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YBrtcxk9Aq0MlzXldrwkcgyEcYRbn/MOspQjLzWeMWE=;
 b=RPcrhrgbdVzDY/PpqEBLcf5Ni3j6dgfqpL94geE1aihUDn6T0CKxhW9kDUGW3OUuK9
 jXRr20rsPRu/JZyNaO7DyWkkAzie34hLB7vfIygYiuo0IfedEWhl4dUHm8ucv1GNYqu3
 /ILgDhDKCPJO/Le1ZI/61lgQPyaeRMT/AXbapS5lHDUVT7cdDFohazASE1D6Pfq40vgc
 K/Begr6aA1HYXYK7P9j/bmTQByYEYiVzwaFxjjQZEo3tmv8xJf9CDSkOGVPymAXmGke0
 Ud5gwo3Sgwuqd/9skEOaEhbfzOX1kemvqYV6g440oGFmsaqwKYfTLyxm8z4vKYHu493k
 hpQg==
X-Gm-Message-State: AOJu0YzAqsFEsNOigM0kj18/e9J74sT+q7YHQ5LDUqTtmhZrl0tku+z+
 R4ycsV2OBIh+0C9tz932IZ+kng==
X-Google-Smtp-Source: AGHT+IE4jmAN4SlUfxWxGPHrlWecRDimoO/jN4AWxWYJi5TxdIxAHSKzigZgtztnRJVwbl51D/9olw==
X-Received: by 2002:a05:6214:29ef:b0:66c:fe0f:7cdd with SMTP id
 jv15-20020a05621429ef00b0066cfe0f7cddmr34453702qvb.14.1699282547992; 
 Mon, 06 Nov 2023 06:55:47 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 qb5-20020ad44705000000b0067266b7b903sm3496240qvb.5.2023.11.06.06.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:55:47 -0800 (PST)
Message-ID: <c2901c07-9eef-449c-857a-6d2553aeb170@ventanamicro.com>
Date: Mon, 6 Nov 2023 11:55:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: don't enable Zfa by default
To: Jerry Zhang Jian <jerry.zhangjian@sifive.com>, alistair.francis@wdc.com,
 palmer@dabbelt.com, frank.chang@sifive.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20231106111440.59995-1-jerry.zhangjian@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231106111440.59995-1-jerry.zhangjian@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf32.google.com
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



On 11/6/23 08:14, Jerry Zhang Jian wrote:
> - Zfa requires F, we should not assume all CPUs have F extension
>    support.

We do not have a case where this happen, do we? The default CPUs have F
enabled (see misa_ext_cfgs[] in target/riscv/tcg/tcg-cpu.c), so zfa being
enable isn't a problem for them. Vendor CPUs might not have F enabled, but
they don't use the default values for extensions, so they're not affected.
Having zfa enabled by default does not hurt the default CPU setups we have.

I am not a fan of these defaults for rv64 and so on, but once we set them to
'true' people can complain if we set them to 'false' because it might break
existing configs in the wild. We need a strong case (i.e. a bug) to do so.


Thanks,

Daniel


> 
> Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> ---
>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ac4a6c7eec..c9f11509c8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1247,7 +1247,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>       MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> -    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> +    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, false),
>       MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
>       MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
>       MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),

