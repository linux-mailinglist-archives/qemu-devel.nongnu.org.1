Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC4173A780
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:42:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOJK-0003Ie-0k; Thu, 22 Jun 2023 13:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCOJI-0003IC-8b
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:41:32 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCOJF-00017m-2x
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:41:32 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1aa291b3fc7so4380545fac.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687455687; x=1690047687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5auePfU2reJg2xD4JzocZz3c/cYy3Pi3+DxTXNu0T8M=;
 b=AZTTa03YPgH9w5l0jySwjX7rxx4hOVDfDof0uX+0jK2Wxc9aez6xlxBTQ7voTAAK2v
 Q4NZfNUAhhoMJKSPQoMgTu5CpraLP9h4Vha5hMKR70N4Zot2D1vJ1vRjbKHVYfPoKF+c
 wVGCDPDD2W4tgn65rsMffMH4tfarAIiq50OhOVhmxpwtybOiRBv5JGL3XPdEWzICZfeT
 5ChrdUuj9sVvQqk7+jJGxqVML62F64CAxrU1VA2SJoI7hAJpTHVdfiL4+xkjNnLKrxjW
 19AVTD/qG8/ZcZ7eX/T0ShpOXkSfBdl4dB1UuCm/9dGVHnHGbAebGTJhwbtPGyj6pnMk
 J8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687455687; x=1690047687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5auePfU2reJg2xD4JzocZz3c/cYy3Pi3+DxTXNu0T8M=;
 b=jnJxD/Tjian+nGQ8Op7n/4j6kLzT/nOZGrLZWRdAr90FGFmZaJechtcqeyPR/BtJWX
 PaWEdI+QqXuc4QWfSNCtqv8pMh/50tZspe3/oQ2U9XyP/dWPWvqiFJfSNEE9uNcZCgYb
 xFQAWtEs4v2hOMQiAuOg9A1fGImEaDdUODC85oGVBHKjGmeXF86g2Pxxgl1u4Jq9IxDK
 ov19VrzSIMqY161IJvtBDWleC04/WNZ8fk0kY1TRUq704eA1U7+SYYU5Gv8Y7yRqNuUf
 JZLQXYcRhxC2ZnO+hrHd5HdllaMTAADb27xKssJteJQJP/rvSA1StzAblHksZ+bzUST3
 m0ng==
X-Gm-Message-State: AC+VfDxXMCBGtwIUy2HGCHoO97C0FcIvRfpiwmr+KTyOCweH6jU2inZc
 W5rzmC0DZP8GbIIn8cbOlkbjzg==
X-Google-Smtp-Source: ACHHUZ4p2FA+fEu/5tWNa2ScDd0V7hsipFM/A/vZ0MvTHSg4gysa6CV8ynDffBXnzQYzYqDwI9V2Mw==
X-Received: by 2002:a05:6871:c18a:b0:19f:6af1:87f8 with SMTP id
 yr10-20020a056871c18a00b0019f6af187f8mr13999095oab.41.1687455687660; 
 Thu, 22 Jun 2023 10:41:27 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 y19-20020a9d6353000000b006b5d40bd738sm1337744otk.70.2023.06.22.10.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:41:27 -0700 (PDT)
Message-ID: <12f82e04-7379-0d8c-c54b-348cd30c31b2@ventanamicro.com>
Date: Thu, 22 Jun 2023 14:41:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 17/17] target/riscv: Expose Zvk* and Zvb[b,c] cpu
 properties
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230622161646.32005-1-max.chou@sifive.com>
 <20230622161646.32005-18-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230622161646.32005-18-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 6/22/23 13:16, Max Chou wrote:
> From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> 
> Exposes earlier CPU flags allowing the use of the vector cryptography extensions.
> 
> Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c1956dc29b..48d584ab0d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1714,6 +1714,16 @@ static Property riscv_cpu_extensions[] = {
>       DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
>       DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
>   
> +    /* Vector cryptography extensions */
> +    DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
> +    DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
> +    DEFINE_PROP_BOOL("x-zvkg", RISCVCPU, cfg.ext_zvkg, false),
> +    DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
> +    DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
> +    DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
> +    DEFINE_PROP_BOOL("x-zvksed", RISCVCPU, cfg.ext_zvksed, false),
> +    DEFINE_PROP_BOOL("x-zvksh", RISCVCPU, cfg.ext_zvksh, false),
> +

We usually add the cpu properties in the same commit that the extension was
added, e.g. "x-zvbb" would be added by patch 9. This is no hard rule though.

Let's leave this as is and, if a v5 is required for any other reason, you can
put each property into its own patch. For now:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>       DEFINE_PROP_END_OF_LIST(),
>   };
>   

