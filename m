Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4613A78D1BC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 03:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb9z8-0006EK-UO; Tue, 29 Aug 2023 21:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb9z7-0006Da-5G
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 21:27:05 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb9z4-0007n7-JJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 21:27:04 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1ccb58b0099so3315106fac.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693358821; x=1693963621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1nE+CfxcJdZd/pGWeao0xf2/fTExkGSoAXPdRHsR1Vg=;
 b=jjiJSiy/RCg+0XMqLZII1fPdV1o3E072sf/8o1lW8miQeb1lnLOUzlcmJzdtS39W+M
 FrADaYItpGdLzZFZigZO5Wf7HWFR3VS4qrgQKZoNffZZXI0Tr4WSTkhI/mIyeKAGUokC
 AEIIHWCjjfP3T+x01yk8Ds0yqKubOQ5mpQfjP9F8W9m/itcokS9nCXkGrzav4SWciPPA
 p5Tn/3yQKYOF5KUtgbKJUDxmn3Fnfmxhvbr1bBQdtBbHitTVdeM50gzMMcSYw/sB10zc
 1FNLzPuYoAk5WcwluAkIRO4G494XTC3Gv6ozUlRus44NVyYCVMDbzF9uyS/nSCVcQpk+
 KEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693358821; x=1693963621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1nE+CfxcJdZd/pGWeao0xf2/fTExkGSoAXPdRHsR1Vg=;
 b=NdnwYVMRmrR/9RnriBDISGvQtvCdMIOdJe/jjRIAHJfpHMubimbtOoyLWW0qhHKRb+
 ysHGSDlxS/3EzPUYOgNs1fnEDustQOn0cgHNDcTTaqA13o37iv5Q9OjOrjuBG+ieSSxc
 Zcf2EWUHiguT+WtcjeOUUK2YdH3R9cJr/0vS9aqFL58HXYXzyRIA7k/NR0kFcflLWhBK
 buzFHsxfEeluNRJ5zvThcIkWB/IJ3P+TGwAejUgiaP15X9AZxqdp22GKn2b5MFNrqpLe
 W4QcCg5YTugPp1c87148tQsBl0WxtCc7MxwwjJM8RdEZTrsnZxl6hIAGI0o0nMgK1wc+
 wHyw==
X-Gm-Message-State: AOJu0YzsigMg5lRms6R5fxuJZrE1Ac/SvWrfVUPBrK8e4Kv1D23TkTdN
 EWL92ZJl6a8gGQi26uJjnPgSiQ==
X-Google-Smtp-Source: AGHT+IHBqCWusJiXAKMM1o0En9jWkfiItaTi9QGRbhlVm/XDuVpWp65YrK+3aW2RChYo4yxRSAVVEA==
X-Received: by 2002:a05:6870:171a:b0:1c3:c43d:838 with SMTP id
 h26-20020a056870171a00b001c3c43d0838mr941671oae.39.1693358820977; 
 Tue, 29 Aug 2023 18:27:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a17090abf0d00b0026b4d215627sm195466pjs.21.2023.08.29.18.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 18:26:59 -0700 (PDT)
Message-ID: <d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org>
Date: Tue, 29 Aug 2023 18:26:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
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
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <40938464-2008-aff3-ffb7-37fbb16615d3@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 8/29/23 16:51, Daniel Henrique Barboza wrote:
>> The compiler certainly does eliminate 0 && foo(), even at -O0.
>>
>> There must be something else going on.
>> Pointer to your tree?
> 
> It's this tree:
> 
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next


Ok, so while -O0 will eliminate 0 && foo(), it doesn't eliminate with bar() && foo(), 
where bar must be inlined (multiple times in this case) to find the 0.

Moreover in the case of

> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_intc_riscv_aplic.c.o: in function 
> `riscv_kvm_aplic_request':
> /home/danielhb/work/qemu/build/../hw/intc/riscv_aplic.c:486: undefined reference to 
> `kvm_set_irq'

this one, where foo (aka riscv_kvm_aplic_request) would have to be eliminated as well. 
But the compiler won't eliminate entire unused functions with -O0.

This seems to do the trick.  Whether it is aesthetically better than what you had with 
your patches, I will leave to someone else.


r~


diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 592c3ce768..0e22dcaf8a 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -481,10 +481,14 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, 
uint32_t idc)
      return topi;
  }

+#ifdef CONFIG_KVM
  static void riscv_kvm_aplic_request(void *opaque, int irq, int level)
  {
      kvm_set_irq(kvm_state, irq, !!level);
  }
+#else
+#define riscv_kvm_aplic_request  ({ qemu_build_not_reached(); NULL; })
+#endif

  static void riscv_aplic_request(void *opaque, int irq, int level)
  {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 388e52a294..b787ae38c2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -782,7 +782,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry 
*memmap,
      }

      /* KVM AIA only has one APLIC instance */
-    if (virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia(s)) {
          create_fdt_socket_aplic(s, memmap, 0,
                                  msi_m_phandle, msi_s_phandle, phandle,
                                  &intc_phandles[0], xplic_phandles,
@@ -1461,7 +1461,7 @@ static void virt_machine_init(MachineState *machine)
          }
      }

-    if (virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia(s)) {
          kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                               VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                               memmap[VIRT_APLIC_S].base,


