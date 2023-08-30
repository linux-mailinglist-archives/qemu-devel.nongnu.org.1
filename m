Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742E78D496
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHbL-0003Xj-7v; Wed, 30 Aug 2023 05:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbHbJ-0003S6-Fs
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:35:01 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbHbE-00008f-ML
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:35:01 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso4068104a34.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693388095; x=1693992895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7z2VhinNCiprwvDFYHJ3K2xxfMGBZ2v2G9mtN8m0xE=;
 b=Xryc7pKySXz8vhzHHgjbrfp7fVeYSbkHSL+9hc084jir40NvcPLkQS0JurXskecA13
 xn5Yiui66Oigcdofn3Uv+Zjq+njnIBGYav11sKyD+OOfOHe2V3BCxoXmKxfGoOjkmeGo
 ByCmq/5C9oN9lb5Md2ewFkt7ULzpTu9E+3heuRFzDmhNCLzM37FxGAtFXFDA9Tj/MVQX
 vlkYO3huZklFgb0y67RSDmqIv/aTjX+Acr9urnTbOLurjXxBIKqPJu8SMg6A3d3ADYZd
 x7sehfvPH0BsPtSZ6ASr3Ya0cvGtCYv8q+non+x3HI3pTKGpOD2BDtQ04jxUz7PEsP1p
 ACWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693388095; x=1693992895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7z2VhinNCiprwvDFYHJ3K2xxfMGBZ2v2G9mtN8m0xE=;
 b=XyeE2IoIDvcHlBgLA9Kj/vdKtEQcj65TI6mJj/WmoVUM3lDhBA7k9D8Ul7f0vKfof/
 I/zqL7JSx5lYIe9TfZD0lYGaUMdXocx77NCFYfl3PcSOSFO8u6tp9GxKDGAjjt8QoUG6
 QVE613Vbj6wNH8kpHUr0J6wGtTxv9zOl4i/el3BkjaaBYhydfe8mtfiER86kNwkPQ4Tk
 TDms4g+iL572FOIuZpTR0Ivm/loExoWjbLhtQH13kuHK1BaVqlAXEnEfbYA85MNEC7cv
 M4Fwww6KhZYt9sg4eymtV55lFVK26T7rA7GhRt5wf0gzYe9EfUT9/lAiS5VoSPDFjgOe
 JkoQ==
X-Gm-Message-State: AOJu0YxYpcQOdrCiTNqUkLEXhW8hpjShXPPcTR3Kr3bhOzol5d4mXV1f
 iCE+BWwgCPo7DD5RfallgaVAgw==
X-Google-Smtp-Source: AGHT+IH4iTtbArfHzVwGZ7uXT4hB4k7Z+J7IR/Ae8aFTFQhhe6hB2uNdeYPkI35JdPeT14udAyJgQg==
X-Received: by 2002:a05:6808:14c7:b0:3a7:44da:d5e4 with SMTP id
 f7-20020a05680814c700b003a744dad5e4mr1955358oiw.51.1693388095281; 
 Wed, 30 Aug 2023 02:34:55 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 j3-20020aca6543000000b003a40b3fce01sm5375296oiw.10.2023.08.30.02.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 02:34:55 -0700 (PDT)
Message-ID: <7a309a5c-c88e-4cfc-7811-5643a53def81@ventanamicro.com>
Date: Wed, 30 Aug 2023 06:34:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230829122144.464489-1-dbarboza@ventanamicro.com>
 <20230829122144.464489-3-dbarboza@ventanamicro.com>
 <c0089044-54d2-43ab-6b30-854a4fa3aa4f@linaro.org>
 <72de2f6a-5ede-40f4-5edc-a22d89587e4e@ventanamicro.com>
 <63d099a2-ac5e-1ce9-3663-10e317d7dc5a@linaro.org>
 <40938464-2008-aff3-ffb7-37fbb16615d3@ventanamicro.com>
 <d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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



On 8/29/23 22:26, Richard Henderson wrote:
> On 8/29/23 16:51, Daniel Henrique Barboza wrote:
>>> The compiler certainly does eliminate 0 && foo(), even at -O0.
>>>
>>> There must be something else going on.
>>> Pointer to your tree?
>>
>> It's this tree:
>>
>> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> 
> 
> Ok, so while -O0 will eliminate 0 && foo(), it doesn't eliminate with bar() && foo(), where bar must be inlined (multiple times in this case) to find the 0.
> 
> Moreover in the case of
> 
>> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_intc_riscv_aplic.c.o: in function `riscv_kvm_aplic_request':
>> /home/danielhb/work/qemu/build/../hw/intc/riscv_aplic.c:486: undefined reference to `kvm_set_irq'
> 
> this one, where foo (aka riscv_kvm_aplic_request) would have to be eliminated as well. But the compiler won't eliminate entire unused functions with -O0.
> 
> This seems to do the trick.  Whether it is aesthetically better than what you had with your patches, I will leave to someone else.
> 
> 
> r~
> 
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 592c3ce768..0e22dcaf8a 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -481,10 +481,14 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
>       return topi;
>   }
> 
> +#ifdef CONFIG_KVM
>   static void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>   {
>       kvm_set_irq(kvm_state, irq, !!level);
>   }
> +#else
> +#define riscv_kvm_aplic_request  ({ qemu_build_not_reached(); NULL; })
> +#endif
> 
>   static void riscv_aplic_request(void *opaque, int irq, int level)
>   {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 388e52a294..b787ae38c2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -782,7 +782,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
>       }
> 
>       /* KVM AIA only has one APLIC instance */
> -    if (virt_use_kvm_aia(s)) {
> +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>           create_fdt_socket_aplic(s, memmap, 0,
>                                   msi_m_phandle, msi_s_phandle, phandle,
>                                   &intc_phandles[0], xplic_phandles,
> @@ -1461,7 +1461,7 @@ static void virt_machine_init(MachineState *machine)
>           }
>       }
> 
> -    if (virt_use_kvm_aia(s)) {
> +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>           kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
>                                VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
>                                memmap[VIRT_APLIC_S].base,
> 

I'll leave to Alistair to decide, both seems good to me.


TBH I'm bothered why this doesn't work:


diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 592c3ce768..251e08ddc4 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -839,12 +839,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
       * Only root APLICs have hardware IRQ lines. All non-root APLICs
       * have IRQ lines delegated by their parent APLIC.
       */
-    if (!aplic->parent) {
-        if (is_kvm_aia(aplic->msimode)) {
-            qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
-        } else {
-            qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
+    if (kvm_enabled()) {
+        if (!aplic->parent) {
+            if (is_kvm_aia(aplic->msimode)) {
+                qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
+            } else {
+                qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
+            }
          }
+    } else if (!aplic->parent) {
+        qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
      }

Why is the compiler refusing to crop an "if kvm_enabled()" block? There's no other
conditionals to handle, and it is able to crop "if (kvm_enabled() && virt_use_kvm_aia(s))".

Is this solely because riscv_kvm_aplic_request() will be an unused function if the crop
happens and, as you said above, "the compiler won't eliminate entire unused functions with
-O0"?



Thanks,

Daniel

