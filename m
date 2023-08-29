Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386178D08A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7qE-0006Px-Jb; Tue, 29 Aug 2023 19:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qb7q8-0005cX-S2
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:09:41 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qb7q6-0006yK-Al
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:09:40 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a7d7de894bso3609944b6e.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693350577; x=1693955377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zf+eNCeIA3ysjuL3/tq5n++Maq6yl6IIqyzALC43OUs=;
 b=kBpUROo14XifxDf/jTU3XEJsnTNxmXDgeKch4loiyz6X+Ury4PTMUQ4fd9edJ4atsL
 4v4NDBJPX/hDIc3TdYRtFLENDHnhW26K1FImW44XTy9G4DC2P1pIcWN6yl69v4RG2BSr
 sChGjLp8rZYuIDl0qecspasjWWxHcd+yzFQ3v47FysjF/XO4i5BiJRq00YO/P9Wxgfrt
 CR8A2rAwEzpcP2Tt5MS65NHm+qg47FkIwX9HgHyfWXr7gHnn4ZKGBGCNsHZN870OTavj
 ScvII7mIVod08mdcqqydiqakhMLVxf8TbX61BZm92QF5O7wWf0Kzl/Gbjp3grkne7aw6
 rrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693350577; x=1693955377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zf+eNCeIA3ysjuL3/tq5n++Maq6yl6IIqyzALC43OUs=;
 b=cTaJ2TqhD+FFfd+Ak8jEe31vBMKBc3A8Ezx+DJLEC2bgD0KKSPBgSpDXuZyHmI0rxO
 a7ZTmYEX5kvhW3I+xGb8oAV/5LhE0B2FkmM16bfbuiBtcg9+pu1V5PdfWbgsW1S+j/Wc
 q/8wiGQXX9fxcOhYyiVj7KeEIa/IBQ87/AiLvemtcl/lNdfIRGCcqUJIeQw2lPfyB+7s
 r5p2P7suX2qlY4OVgDJubCJanH1Ef0GbGA9xTGCThxe/dWxRNJr0b3uXWiIDMQx8+9R7
 ic1Y+zsenS412VDENkj06DyRYsuceYaBPWDDFD838Qd0Ap6MkVkCp6dhi1XmQmNYVKPI
 7Qvg==
X-Gm-Message-State: AOJu0YyLb8Q9tdDNjENxlt6E9R9oTy6omjn4D08hcrT54rfo+2HTf/LG
 gNb2bhA/y9MD2PZ4cqMwlw4uCw==
X-Google-Smtp-Source: AGHT+IHI46Jz3Kn2CD8mnrc0Qt8IJ4YTbCrfo/4ilV4K+ZXwTyoPtiJPJ7tTqhtjLtHOh315PI5n4g==
X-Received: by 2002:a05:6808:ce:b0:3a7:8e9a:e984 with SMTP id
 t14-20020a05680800ce00b003a78e9ae984mr397414oic.57.1693350576960; 
 Tue, 29 Aug 2023 16:09:36 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm5012037oij.7.2023.08.29.16.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 16:09:36 -0700 (PDT)
Message-ID: <72de2f6a-5ede-40f4-5edc-a22d89587e4e@ventanamicro.com>
Date: Tue, 29 Aug 2023 20:09:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230829122144.464489-1-dbarboza@ventanamicro.com>
 <20230829122144.464489-3-dbarboza@ventanamicro.com>
 <c0089044-54d2-43ab-6b30-854a4fa3aa4f@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <c0089044-54d2-43ab-6b30-854a4fa3aa4f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22b.google.com
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



On 8/29/23 11:18, Philippe Mathieu-Daudé wrote:
> On 29/8/23 14:21, Daniel Henrique Barboza wrote:
>> A build with --enable-debug and without KVM will fail as follows:
>>
>> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
>> ./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'
>>
>> This happens because the code block with "if virt_use_kvm_aia(s)" isn't
>> being ignored by the debug build, resulting in an undefined reference to
>> a KVM only function.
>>
>> Add a stub for kvm_riscv_aia_create() in kvm_riscv.h when CONFIG_KVM is
>> false. Adding it as an inline instead of using kvm-stubs.c will make it
>> easier in the future to remember to add stubs for kvm functions that are
>> used in multiple accelerator code.
>>
>> Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm_riscv.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
> Similarly:
> 
> -- >8 --
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> @@ -79,7 +79,9 @@
>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
>   static bool virt_use_kvm_aia(RISCVVirtState *s)
>   {
> -    return kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
> +    return kvm_enabled()
> +        && kvm_irqchip_in_kernel()
> +        && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
>   }
> ---

It doesn't work. Same error:

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 388e52a294..ac710006e7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -79,7 +79,8 @@
  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
  static bool virt_use_kvm_aia(RISCVVirtState *s)
  {
-    return kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+    return kvm_enabled() &&
+           kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
  }
  
  static const MemMapEntry virt_memmap[] = {
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index 01be45cc69..7d4b7c60e2 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -22,19 +22,9 @@
  void kvm_riscv_init_user_properties(Object *cpu_obj);
  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
-
-#ifdef CONFIG_KVM
  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                            uint64_t aia_irq_num, uint64_t aia_msi_num,
                            uint64_t aplic_base, uint64_t imsic_base,
                            uint64_t guest_num);
-#else
-static inline void kvm_riscv_aia_create(MachineState *machine,
-                                uint64_t group_shift, uint64_t aia_irq_num,
-                                uint64_t aia_msi_num, uint64_t aplic_base,
-                                uint64_t imsic_base, uint64_t guest_num) {
-    g_assert_not_reached();
-}
-#endif



/usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
/home/danielhb/work/qemu/build/../hw/riscv/virt.c:1466: undefined reference to `kvm_riscv_aia_create'
collect2: error: ld returned 1 exit status


I'm no compiler expert by any means but it seems that the --enable-debug build does not strip things
out like the usual build does, e.g. it won't elide a 'if kvm_enabled()' block out by checking that
kvm_enabled() is always false.


Thanks,

Daniel


> 
> ?

