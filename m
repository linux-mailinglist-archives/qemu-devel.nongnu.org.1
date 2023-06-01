Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71371A344
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kFz-0003pp-67; Thu, 01 Jun 2023 11:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q4kFw-0003m3-HA
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:30:28 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q4kFu-0004wz-PK
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:30:28 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-96fbe7fbdd4so136925766b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685633422; x=1688225422;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5o15EwaqP9wRg49cit4Rwy8RwUKqd+TTHLoBgusXj0o=;
 b=feaZISbx6PFuWAygz52GrdKkEmi2vGs8QKj7CY8lFGTIuJa7C+akznhfdjpT4IwWqy
 i+EM2Ke7xQVA41+RedaJJ9qe8kTCascDzDB0PNrWmxAyfnkbBwFz1TMldWgfvqFe7EOb
 riVXPhzzM1+IrtAi48x+Xrer02GMHAVWGcVmdrgwdwT2vRHg5JbcJTNXznBPii5JoyJH
 XSlF8YNP1ynUu8Nuvf21awfThQXiqQeViLlOMtGvpLAU1+qCplIAcb/MniBAf1ZOGdmn
 ryW1dnoOKtuG0u9hnmHPhfgu7GU1GRJ0To8n++LBq+QpGd5q9SwuIivUh1fjymyf9uYf
 Y2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685633422; x=1688225422;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5o15EwaqP9wRg49cit4Rwy8RwUKqd+TTHLoBgusXj0o=;
 b=PwX5cRuU3kQitkenoCbCYB7D28XGbNUThgk1hwWMXcsctMiGJfqhjI5doS7rFaDI0S
 BY43sRjebKoPjHKN8ocSHE9TQXk4gUaLTSmEboetOHGesS3WZia0wvD9Jtqud0a/YPSC
 xAz6YdMPnJ45Ys+x0nIM1kF0r+Xr1/Y29F2ZCToHsHvVpSQHwQ/qjXxyd514YVOGVtBh
 K80GelWVwnFUVbYoGCATLRkJYbWV1crWMCkvJfs8n09XL1OjpfWNe7zK/gvhdtj3Nkew
 iVZiCbkW5eqz8Lb3ZIQ/WjoHo9HbJSzdEbKsFWcB7iSGK1EYYJPoF8MZK4NuPrNHE5sJ
 5KVQ==
X-Gm-Message-State: AC+VfDzuR5q+LieXzTEj4byBHNWf6l971IvvxK6Y85UZOltyaZ3Vgggk
 IPNp8Dxct5osdHSDF210WHok/Q==
X-Google-Smtp-Source: ACHHUZ6se29ACOdjXvfyrXSfUl+5swUDzk7gMcyEVPLwqJbb9pcCQmCo0eRcNZpxawiiLoD13gjSnA==
X-Received: by 2002:a17:907:3f1c:b0:970:d85:59e9 with SMTP id
 hq28-20020a1709073f1c00b009700d8559e9mr8113618ejc.5.1685633422525; 
 Thu, 01 Jun 2023 08:30:22 -0700 (PDT)
Received: from [192.168.200.206] (83.21.93.182.ipv4.supernova.orange.pl.
 [83.21.93.182]) by smtp.gmail.com with ESMTPSA id
 j11-20020a170906410b00b0096f689848desm10650997ejk.195.2023.06.01.08.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 08:30:22 -0700 (PDT)
Message-ID: <da42c1fc-4adc-5eaa-2d72-6747b74f8ae8@linaro.org>
Date: Thu, 1 Jun 2023 17:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Graeme Gregory <graeme@xora.org.uk>, wangyuquan1236@phytium.com.cn,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
 <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

W dniu 1.06.2023 o 17:01, Peter Maydell pisze:
> On Wed, 31 May 2023 at 17:37, Leif Lindholm <quic_llindhol@quicinc.com> wrote:

>> Ah, thanks! That explains why we did the thing that made no sense :)
>>
>> To skip the migration hazard, my prefernece is we just leave the EHCI
>> device in for now, and add a separate XHCI on PCIe. We can drop the
>> EHCI device at some point in the future.
> 
> Why PCIe for the XHCI and not sysbus? At the time the board
> was originally added the argument was in favour of using
> a sysbus USB controller (you can see Ard making that point
> in the linked archive thread).

So something like below? I only tested does system boot into Debian.
To make it work also changes to EDK2 would be needed to list XHCI
controller in DSDT.

"info qtree" in QEMU monitor lists controller with usb devices
attached (added them by cli arguments).

 From 8f5af99a670be226a1dfc5b06cbdd3eff4841d27 Mon Sep 17 00:00:00 2001
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Thu, 1 Jun 2023 17:27:24 +0200
Subject: [PATCH] WIP: arm/sbsa-ref: add XHCI on sysbus

EHCI controller is not working as it requires 32-bit memory.
XHCI one should work fine.
---
  hw/arm/sbsa-ref.c | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index de21200ff9..0bc87abbf4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -83,6 +83,7 @@ enum {
      SBSA_SECURE_MEM,
      SBSA_AHCI,
      SBSA_EHCI,
+    SBSA_XHCI,
  };
  
  struct SBSAMachineState {
@@ -120,6 +121,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
      /* Space here reserved for more SMMUs */
      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
      [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
+    [SBSA_XHCI] =               { 0x60120000, 0x00010000 },
      /* Space here reserved for other devices */
      [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
      /* 32-bit address PCIE MMIO space */
@@ -142,6 +144,7 @@ static const int sbsa_ref_irqmap[] = {
      [SBSA_EHCI] = 11,
      [SBSA_SMMU] = 12, /* ... to 15 */
      [SBSA_GWDT_WS0] = 16,
+    [SBSA_XHCI] = 17,
  };
  
  static const char * const valid_cpus[] = {
@@ -575,6 +578,15 @@ static void create_ahci(const SBSAMachineState *sms)
      }
  }
  
+static void create_xhci(const SBSAMachineState *sms)
+{
+    hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
+    int irq = sbsa_ref_irqmap[SBSA_XHCI];
+
+    sysbus_create_simple("sysbus-xhci", base,
+                         qdev_get_gpio_in(sms->gic, irq));
+}
+
  static void create_ehci(const SBSAMachineState *sms)
  {
      hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
@@ -804,6 +816,7 @@ static void sbsa_ref_init(MachineState *machine)
      create_ahci(sms);
  
      create_ehci(sms);
+    create_xhci(sms);
  
      create_pcie(sms);
  
-- 
2.40.1



