Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80780D422
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:39:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkEu-00044C-9k; Mon, 11 Dec 2023 12:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCkEr-00043n-O4
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:38:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCkEp-0006Qv-1g
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:38:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so9628235e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702316317; x=1702921117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Efg90nfIz5HsjxpVdK2HUAEa3LirRfLxzxVaejEfW40=;
 b=eHdNbvWNQtEtwbGiej/WcCABwt87yBa/MCPOU1LBxb/cygPVgld9tlWXuQmP/GfbRb
 4w+JILpJAGl1GGMCpL8vuWg7LeTOvl/kqe3ouP8C8Xgk1uO1S/4/ptl7TADOEa6MhkSP
 4ElralbOiFwEF0qIMqzQ8NOcxp60t+/4Us7lnJgyqo1mdtuOjU5JZYkd7gRRl6BBu9Id
 WXIUNk5zbOeViehRaPG5nLBy44hJIMozNG88S2QgL8TT4EOvKayqrT/8ZK3+gaVmXV8G
 kV4lw+FmjsfzMRXOLnHsU3QMcJw2B21CeotmDcG52okDN/JkQqAJ4u9jlcIsG1Lt9oXW
 Ldkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316317; x=1702921117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Efg90nfIz5HsjxpVdK2HUAEa3LirRfLxzxVaejEfW40=;
 b=IhrBIbenZ2LbI/XzVy7ep9KJjhbCNLwJ7OyVp21b5p3NfRAjB7ecYjC45XpZlUA/vB
 t8gTPtnJkC84NjlIgdXQfDtuzs26vNDGCj2ZP31NdcOd7B15pae54cT+rg8vR/1mIAeW
 CiO6n/x1N3Z40GWzpXfhc3zatvY59CJwS00WVj+CQzPbiodGCNj1MRrmtJ13YYRnBxvP
 h008LzkosQypQLClVN3B7jV6WulfHGDw9xDEEm0N+Wi7SOUnnheRztpd3YgOXaHb/IF2
 qolgVLdzWMaI2F0loftfGInlGWckOxWPRAuDQUkVp9+PEUnOAxChdbTsFbo6Q2l9xuRC
 QdIw==
X-Gm-Message-State: AOJu0YwuqRrwpiD8PaDGQKVvmAiD7vo0sCqJQUo7baqGIr5jgfW4zK1w
 xdzTBkax+MCPjVjTqLmWiHYfig==
X-Google-Smtp-Source: AGHT+IHIQbtXrX/GAfE6v35qYpeOOwy47K6Mdg2yo96tjWbIbqjSTWmnt67xb1D1VUcv7DBAcjMcNg==
X-Received: by 2002:a05:600c:1715:b0:40c:2822:958f with SMTP id
 c21-20020a05600c171500b0040c2822958fmr2536637wmn.73.1702316317388; 
 Mon, 11 Dec 2023 09:38:37 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 bh15-20020a05600c3d0f00b0040b4ccdcffbsm13895051wmb.2.2023.12.11.09.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:38:37 -0800 (PST)
Message-ID: <42c587c3-37f9-4c2a-81f8-28c7aeb9a034@linaro.org>
Date: Mon, 11 Dec 2023 18:38:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv/cpu.c: fix machine IDs getters
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Markus Armbruster <armbru@redhat.com>
References: <20231211170732.2541368-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231211170732.2541368-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/12/23 18:07, Daniel Henrique Barboza wrote:
> mvendorid is an uint32 property, mimpid/marchid are uint64 properties.
> But their getters are returning bools. The reason this went under the
> radar for this long is because we have no code using the getters.
> 
> The problem can be seem via the 'qom-get' API though. Launching QEMU
> with the 'veyron-v1' CPU, a model with:
> 
> VEYRON_V1_MVENDORID: 0x61f (1567)
> VEYRON_V1_MIMPID: 0x111 (273)
> VEYRON_V1_MARCHID: 0x8000000000010000 (9223372036854841344)
> 
> This is what the API returns when retrieving these properties:
> 
> (qemu) qom-get /machine/soc0/harts[0] mvendorid
> true
> (qemu) qom-get /machine/soc0/harts[0] mimpid
> true
> (qemu) qom-get /machine/soc0/harts[0] marchid
> true
> 
> After this patch:
> 
> (qemu) qom-get /machine/soc0/harts[0] mvendorid
> 1567
> (qemu) qom-get /machine/soc0/harts[0] mimpid
> 273
> (qemu) qom-get /machine/soc0/harts[0] marchid
> 9223372036854841344
> 
> Fixes: 1e34150045 ("target/riscv/cpu.c: restrict 'mvendorid' value")
> Fixes: a1863ad368 ("target/riscv/cpu.c: restrict 'mimpid' value")
> Fixes: d6a427e2c0 ("target/riscv/cpu.c: restrict 'marchid' value")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   target/riscv/cpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 83c7c0cf07..70bf10aa7c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1573,9 +1573,9 @@ static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
>   static void cpu_get_mvendorid(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>   {
> -    bool value = RISCV_CPU(obj)->cfg.mvendorid;
> +    uint32_t value = RISCV_CPU(obj)->cfg.mvendorid;
>   
> -    visit_type_bool(v, name, &value, errp);
> +    visit_type_uint32(v, name, &value, errp);
>   }
>   
>   static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
> @@ -1602,9 +1602,9 @@ static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
>   static void cpu_get_mimpid(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>   {
> -    bool value = RISCV_CPU(obj)->cfg.mimpid;
> +    uint64_t value = RISCV_CPU(obj)->cfg.mimpid;
>   
> -    visit_type_bool(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>   }
>   
>   static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
> @@ -1652,9 +1652,9 @@ static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
>   static void cpu_get_marchid(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>   {
> -    bool value = RISCV_CPU(obj)->cfg.marchid;
> +    uint64_t value = RISCV_CPU(obj)->cfg.marchid;
>   
> -    visit_type_bool(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>   }
>   
>   static void riscv_cpu_class_init(ObjectClass *c, void *data)


