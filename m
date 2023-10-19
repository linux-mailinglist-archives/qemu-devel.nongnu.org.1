Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940957CF43C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPZe-00078N-D8; Thu, 19 Oct 2023 05:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPZb-00070V-IO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:44:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPZY-00007R-E5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:44:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso13150375e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697708647; x=1698313447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fVsrLNNrMLmal3GISehH7MK6KiEqFcas4TO1/zgF/5Y=;
 b=SsR2kyJ9Ex9i0scFGx5vKSngUELSqxvNZAX9EA1T3UnETumEywWJZnGErvWwXp35bG
 ZyeC9hVrmWwkW9iHaWD+i8PrFcVslHl+LF5yXDn2x5ZAPBOn9t44i7kTLsHTGaNFJDk0
 q5SOQjLmK6WCZC8ZaEe57UWyDI9f+1x3eQNjp75ilYYjGD+UJkvMMK5bfTxdYi96mMLd
 a+7kD5054y58trRBNYojcPSybYP7AouhtPzYpqLmGzT9ZAUACmREVbGNhngEdBRVDj+w
 h/s8KxtpTPzGl6Z0QuZBJU8583ATaRQkg+AiAza8k0xv2M4ebpAFNoDgfQj8wFluggLM
 ZKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708647; x=1698313447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fVsrLNNrMLmal3GISehH7MK6KiEqFcas4TO1/zgF/5Y=;
 b=i4DkUrAuvK+ix5KqBukBHQEFgEQB3FWIAZlG6piBf7UQC1Rz2L8iEMswTFkZnTuuA1
 VLgVepOyRad1zT5VYhWlxyFaiIfqixFKz7WX+tjdrMopzUgSg1SHv21EoKouUaxEbv8k
 L1NOvFbZBDDBG82QA4/9a19czzOcaZJyd7n9EgE3xY6NeZS0fsEZd/gQU3W8P3IuzbOc
 jZ96yM4uGgcybjjztjSXWxiUxPWh6Q3+gI7o5s9I91XoJnTgSRv57ma7OU5AWot/d9Q1
 4B45NOw03gIfkClP/BqjCtZ/jt5UCnlq8IZp6zcWxuo1cZyeUhtrfxSTnzWxsf/jMtsN
 NTkw==
X-Gm-Message-State: AOJu0Yy7KzgZj8SnZueUTybrnOoKmjwI1Z48zYSA3cCAlKWx9PQmHgHt
 eOZRZsshNr0AwScsmY3uTm0JBUJ1ykOFl/JPn8NOLg==
X-Google-Smtp-Source: AGHT+IGosE8F75wGt1Lg4OlGqX6AsKazQl5IPUiZzcI7h01Bvk7MBrQRRB/aMmD3bqzPxavWHVMduw==
X-Received: by 2002:a05:600c:1c21:b0:402:8c7e:ba5 with SMTP id
 j33-20020a05600c1c2100b004028c7e0ba5mr1373324wms.18.1697708647049; 
 Thu, 19 Oct 2023 02:44:07 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 z4-20020a05600c0a0400b0040775501256sm4028456wmp.16.2023.10.19.02.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:44:06 -0700 (PDT)
Message-ID: <413e33a5-e076-a747-9b76-d7d8399d8967@linaro.org>
Date: Thu, 19 Oct 2023 11:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 12/61] target/hppa: Introduce TYPE_HPPA64_CPU
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
 <20231018215135.1561375-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018215135.1561375-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/10/23 23:50, Richard Henderson wrote:
> Prepare for the qemu binary supporting both pa10 and pa20
> at the same time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu-qom.h   |  1 +
>   target/hppa/cpu.h       |  7 +++++++
>   target/hppa/cpu.c       | 17 +++++++++++++++++
>   target/hppa/translate.c |  3 +++
>   4 files changed, 28 insertions(+)


> +#ifdef TARGET_HPPA64
> +static void hppa64_cpu_initfn(Object *obj)
> +{
> +    HPPACPU *cpu = HPPA_CPU(obj);
> +    cpu->is_pa20 = true;
> +}
> +
> +static const TypeInfo hppa64_cpu_type_info = {
> +    .name = TYPE_HPPA64_CPU,
> +    .parent = TYPE_HPPA_CPU,
> +    .instance_init = hppa64_cpu_initfn,
> +};
> +#endif
> +
>   static void hppa_cpu_register_types(void)
>   {
>       type_register_static(&hppa_cpu_type_info);
> +#ifdef TARGET_HPPA64
> +    type_register_static(&hppa64_cpu_type_info);
> +#endif
>   }

Preferably switching to DEFINE_TYPES(),

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


