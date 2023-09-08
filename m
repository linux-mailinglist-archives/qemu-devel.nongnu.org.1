Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D637987BA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebQl-0005j2-Ub; Fri, 08 Sep 2023 09:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qebQZ-0005eK-Qd
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:21:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qebQU-00006I-2m
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:21:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-402c1407139so22982745e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694179291; x=1694784091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2GB61ijmkcReDBtPnaiKaOPu0Y+62J1b4/jgsyeX2A=;
 b=tLF8ZPQjk2nlrIqdokTxM+1IPQmiAh9Fm9M9aoA9FK8KYW0yylF1PYaiEaWtLFSu1l
 mXaKX81Zknk0QWH2e/10Yj2msOtKKKP4m1869GfEIRu7u20+C2rkTXhaSdEumPahXQg5
 /5mogJxsS8r3li7A7nsovGmaCG8+aqOYSsOLqOHuZNqbRenxnumfk4hgA/rraBVtWnpr
 jGGUiq1tWrpqFkCTi5m5h7ExeR4pqZYijFUUZRkdkJ261bCeJMTadGXNmJOIMBeceTZ8
 Qk6oqWN9iaXQT4lv8f7lsPzMYOnJ6tDSqd1I0H8npQne7TlvyrfPUru+upNcdyYkI1wF
 +k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694179291; x=1694784091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A2GB61ijmkcReDBtPnaiKaOPu0Y+62J1b4/jgsyeX2A=;
 b=Tt896BqSG3waAzr+kBBSj+Di6/3ewgP2vOxtGHNjB3EfIDUx+2Tlh2DnCQC5SHZp32
 QNq3eWeELJNT5l9Ra+x83hU3cvtuqmR2NBS/6JJ7qB//QWW+fedOZFfKkk5nqBDuaoBq
 hKCR965XgAASjMwV/Fhq7tyynPEdFWEaFTjdNsA8Pj6WxZA+JEU67idTaec0Z9TB6Bt4
 M3iMHRDEbZi6wzgrQnbWL8kmLeD+w0cJrSbKlZHvlde+9rPU1Ll4rRSOcHtNM5Pn2rvy
 Q6PlwmzIITyeG0DMiraIB7oH2PTFhvEwoy220luwpwp4YJINlOVSM66aHqlGk4/LkCO/
 +daA==
X-Gm-Message-State: AOJu0Yw3P2rSO0CtlylVHmGSiyE3o0jKkWt1SEJ6gJWljQ0C2OHngzuy
 4WGDCD/FSPYb6xf77wSFWo4HSA==
X-Google-Smtp-Source: AGHT+IFhak+rJUfR1Nfw4GkGeuqVSPlO3TtlnLZ7vLElHXKVlY8RZPCLwd3ye3+ii55nms1p2quG6g==
X-Received: by 2002:a1c:7211:0:b0:3fe:f45:772d with SMTP id
 n17-20020a1c7211000000b003fe0f45772dmr2067445wmc.28.1694179291343; 
 Fri, 08 Sep 2023 06:21:31 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a7bcd97000000b003fee6f027c7sm5222407wmj.19.2023.09.08.06.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 06:21:30 -0700 (PDT)
Message-ID: <0bdad3e3-bfd6-ffea-a725-46b9e4629756@linaro.org>
Date: Fri, 8 Sep 2023 15:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 48/65] target/riscv/cpu.c: split kvm prop handling to its
 own helper
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Alistair Francis
 <alistair.francis@wdc.com>, Andrew Jones <ajones@ventanamicro.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
 <20230908060431.1903919-49-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230908060431.1903919-49-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 8/9/23 08:04, Alistair Francis wrote:
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Future patches will split the existing Property arrays even further, and
> the existing code in riscv_cpu_add_user_properties() will start to scale
> bad with it because it's dealing with KVM constraints mixed in with TCG
> constraints. We're going to pay a high price to share a couple of common
> lines of code between the two.
> 
> Create a new riscv_cpu_add_kvm_properties() that will be forked from
> riscv_cpu_add_user_properties() if we're running KVM. The helper
> includes all properties that a KVM CPU will add. The rest of
> riscv_cpu_add_user_properties() body will then be relieved from having
> to deal with KVM constraints.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Message-ID: <20230901194627.1214811-4-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index db640e7460..8e6d316500 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1943,6 +1943,46 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
>   }
>   #endif
>   
> +#ifndef CONFIG_USER_ONLY

#ifdef CONFIG_KVM ?

> +static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
> +{
> +    /* Check if KVM created the property already */
> +    if (object_property_find(obj, prop_name)) {
> +        return;
> +    }
> +
> +    /*
> +     * Set the default to disabled for every extension
> +     * unknown to KVM and error out if the user attempts
> +     * to enable any of them.
> +     */
> +    object_property_add(obj, prop_name, "bool",
> +                        NULL, cpu_set_cfg_unavailable,
> +                        NULL, (void *)prop_name);
> +}
> +
> +static void riscv_cpu_add_kvm_properties(Object *obj)
> +{
> +    Property *prop;
> +    DeviceState *dev = DEVICE(obj);
> +
> +    kvm_riscv_init_user_properties(obj);
> +    riscv_cpu_add_misa_properties(obj);
> +
> +    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
> +        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> +    }
> +
> +    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> +        /* Check if KVM created the property already */
> +        if (object_property_find(obj, riscv_cpu_options[i].name)) {
> +            continue;
> +        }
> +        qdev_property_add_static(dev, &riscv_cpu_options[i]);
> +    }
> +}
> +#endif
> +
>   /*
>    * Add CPU properties with user-facing flags.
>    *
> @@ -1958,39 +1998,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
>       riscv_add_satp_mode_properties(obj);
>   
>       if (kvm_enabled()) {
> -        kvm_riscv_init_user_properties(obj);
> +        riscv_cpu_add_kvm_properties(obj);
> +        return;
>       }
>   #endif
>   
>       riscv_cpu_add_misa_properties(obj);
>   
>       for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
> -#ifndef CONFIG_USER_ONLY
> -        if (kvm_enabled()) {
> -            /* Check if KVM created the property already */
> -            if (object_property_find(obj, prop->name)) {
> -                continue;
> -            }
> -
> -            /*
> -             * Set the default to disabled for every extension
> -             * unknown to KVM and error out if the user attempts
> -             * to enable any of them.
> -             */
> -            object_property_add(obj, prop->name, "bool",
> -                                NULL, cpu_set_cfg_unavailable,
> -                                NULL, (void *)prop->name);
> -            continue;
> -        }
> -#endif
>           qdev_property_add_static(dev, prop);
>       }
>   
>       for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> -        /* Check if KVM created the property already */
> -        if (object_property_find(obj, riscv_cpu_options[i].name)) {
> -            continue;
> -        }
>           qdev_property_add_static(dev, &riscv_cpu_options[i]);
>       }
>   }


