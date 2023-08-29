Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521B78C733
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazXA-0007sL-Lq; Tue, 29 Aug 2023 10:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazX7-0007rs-VK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:17:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazX3-00013Y-O5
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:17:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so42033765e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693318634; x=1693923434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o34Lj+FJgL6L1XBRPJvbECpQDqbYroMYp6RnXsQcZ0w=;
 b=YqEMTFoMHh4OoagoQjl1DYFH0PaMV6JslP3L92NaJnKJ6n12qMzFQfE+j8GKSf1ZyT
 /C86xjx1kiNbastEwExW7MmW8jOPk3qhqcCB+Hok6VwuHbHOv790/JFMEhbUqhBWFrTj
 DpR3taxbwK77Df8dSg4kw+qeKcFO/FFYzoeyJ+ZUfqeTDAd/7Q8nk3nbUabZUZJc63n1
 54OM7tRymfOMvURtrciwL1c4BrgmiojkZtLkAthZwS237tn2C8kBJV+/e+QUUxcqy48X
 HyLMmPeqEPTjYFE6JAOF5jVzGYQSchKactrrlbnGa4q5xD78XGExSZxXv00O0Lc8ILYz
 FElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318634; x=1693923434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o34Lj+FJgL6L1XBRPJvbECpQDqbYroMYp6RnXsQcZ0w=;
 b=jftjGp7marrAwgnmt1Kv99WNKbciUsxxVu3NYFwKaiR5s8cKhiQ4xiXtaIZ3kr5dZt
 kCJPhfEIilxArhRaDMHjKcjxzFP06a991Qq+JVvqUB0gX+UZzVoxB6w5P3Z6SReAGYi1
 4can7k/dEBp0e3aOgHJgC2diMrnZCvsoduUADy97wBGg3bnHEO9gqOHzoMAAjJBs+JA/
 nP1thYIlEv06IUUCdNgJ4zS8oMeDBw9hLckH4/TbZhtomEsO+5WY8/JXmm5Ds/UuLHK0
 tZXNPWeEOKLoCKFEZPDw4nR6nCDGxTrQAOvVPQaA2RpGNdRHdOpgod4DcJACct8RyCze
 zxiA==
X-Gm-Message-State: AOJu0YyP9cnL3sO9QBRrr99Ua+Bpd9Chpfz8u+hJBG93F8xBbjq6YQiz
 yE8Pef8cWZzCaNjSuL2cX3iWnA==
X-Google-Smtp-Source: AGHT+IEZrK6lAx2zX/71jHHy294dOn42oDyTWxUvmJKfJH0l8o/aUZdDvSwwXMkXuDuyxFHpZQZLSw==
X-Received: by 2002:a1c:790e:0:b0:3fe:1232:93fa with SMTP id
 l14-20020a1c790e000000b003fe123293famr22387550wme.22.1693318633788; 
 Tue, 29 Aug 2023 07:17:13 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 l7-20020a1c7907000000b003fe4ca8decdsm17284602wme.31.2023.08.29.07.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:17:13 -0700 (PDT)
Message-ID: <19b33c0d-fe00-a108-81cf-eed4b0b238f5@linaro.org>
Date: Tue, 29 Aug 2023 16:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230829122144.464489-1-dbarboza@ventanamicro.com>
 <20230829122144.464489-2-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829122144.464489-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/8/23 14:21, Daniel Henrique Barboza wrote:
> Commit 6df0b37e2ab breaks a --enable-debug build in a non-KVM
> environment with the following error:
> 
> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_intc_riscv_aplic.c.o: in function `riscv_kvm_aplic_request':
> ./qemu/build/../hw/intc/riscv_aplic.c:486: undefined reference to `kvm_set_irq'
> collect2: error: ld returned 1 exit status
> 
> This happens because the debug build will poke into the
> 'if (is_kvm_aia(aplic->msimode))' block and fail to find a reference to
> the KVM only function riscv_kvm_aplic_request().
> 
> Make riscv_kvm_aplic_request() a no-op if we're not building KVM.
> 
> Fixes: 6df0b37e2ab ("target/riscv: update APLIC and IMSIC to support KVM AIA")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/intc/riscv_aplic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 592c3ce768..b634738bda 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -483,7 +483,9 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
>   
>   static void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>   {
> +#ifdef CONFIG_KVM
>       kvm_set_irq(kvm_state, irq, !!level);
> +#endif
>   }

Can we use kvm_enabled() to let the compiler elide KVM code
when !CONFIG_KVM?

-- >8 --
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 592c3ce768..f28d0d3237 100644
@@ -155,7 +155,7 @@
   */
  static bool is_kvm_aia(bool msimode)
  {
-    return kvm_irqchip_in_kernel() && msimode;
+    return kvm_enabled() && kvm_irqchip_in_kernel() && msimode;
  }
---


