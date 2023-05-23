Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410B70E4DB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:43:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WxJ-0003Sw-0g; Tue, 23 May 2023 14:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WxG-0003SZ-U2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WxF-00077Y-GD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684867312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XaOSRmRG4UWXvpzQWNqCUYDwzqHlmfd4KiTEhK843A=;
 b=hz7xmSFstIH7qNDCm6KKsiXj61HxR6HtMoH1bchV1jZ2mL5sK9dveekOCcTzqlYzeJRY/a
 H99jlbFIEyH/qSYrwYAUF85m1DIWTsZcg6XyZlCBaGdSiBB1DszRwrJySNgdqBhPussQXX
 iovB1LC6C7VxZ8I7EL4iMcg6wvmvz7E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-OvA1guT6NpyTlsMPYTAQdA-1; Tue, 23 May 2023 14:41:48 -0400
X-MC-Unique: OvA1guT6NpyTlsMPYTAQdA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30a8f6d7bbdso1032656f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684867307; x=1687459307;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XaOSRmRG4UWXvpzQWNqCUYDwzqHlmfd4KiTEhK843A=;
 b=aqwneEpNJGGfQkbGjYnFoZTRLlhbSB7gJ0slL4acKIlQKzI+kaKTo2BOqOqzJDI5xe
 NvPwY6CMtG8mjilu+IThhdUwkDVRI4IofaTatRHMhcfbLEzdnQSZu12PLOepPaQcNby2
 xhOilGsQqBaNerGS9YTy40Rl+ruv+VXkSSUtQG+o1P2NN1NxIwwuEDQQtMwXTbIwsqLm
 QR8gKm8ymy/c7m1+Je5dnBvCtFHgNHwrfRoKbXfpFqHvAh+EQnzr51KkvoINC53yyrwY
 y0wEmZInoMFuk24ETBZz+pvPJvFg/0BXVVjSDceXLErBm19JAvbgI+5Fj+jrtACKv45c
 zjKA==
X-Gm-Message-State: AC+VfDyjQR0L95HDeI0MSPmfB7wz5wEcvSLpidrk6wImQu5QDi3zIUI7
 kRQJb+GtCRiMy/t65lxJWwhEXYQd9/a7KdRbl49/zz+sLNiktxjC4VGNvl9BVackCxaPhBL/2U4
 PlyCGz/OxLW87w44=
X-Received: by 2002:adf:e8ce:0:b0:309:50e7:7d0 with SMTP id
 k14-20020adfe8ce000000b0030950e707d0mr10241181wrn.31.1684867307336; 
 Tue, 23 May 2023 11:41:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OkUzeZokAnR61rWPwYdDHWm0uuVzigKpBUKFnV+xSgx6McKeqLKzoTE0ln5y2uVplNghqiA==
X-Received: by 2002:adf:e8ce:0:b0:309:50e7:7d0 with SMTP id
 k14-20020adfe8ce000000b0030950e707d0mr10241170wrn.31.1684867307066; 
 Tue, 23 May 2023 11:41:47 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 c11-20020a5d4ccb000000b0030631dcbea6sm11843839wrt.77.2023.05.23.11.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:41:46 -0700 (PDT)
Message-ID: <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
Date: Tue, 23 May 2023 20:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
In-Reply-To: <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/05/2023 19.30, Marcin Juszkiewicz wrote:
...
>> (is there a reason why it can't be disabled with "-vga none" or 
>> "-nodefaults"?)
> 
> That's something I need to check how it should be done.

Other boards set mc->default_display in their ...class_init
function and then use pci_vga_init() (or vga_interface_type)
to instantiate their default display adapter ... however, that
does not seem to support the bochs adapter yet (see
vga_interfaces[] in softmmu/vl.c).

Not sure whether it's worth the effort to extend vga_interfaces[]
in vl.c, but you could at least check whether vga_interface_type
is VGA_NONE and skip the creation of the bochs adapter in that
case?

> Should it also drop default_nic?

Seems like sbsa-ref already uses nd_table[], so "-net none" should
already work. For "configure --without-default-devices" builds, we
still need a patch like this on top, though:

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -596,6 +596,7 @@ static void create_pcie(SBSAMachineState *sms)
      hwaddr size_mmio_high = sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size;
      hwaddr base_pio = sbsa_ref_memmap[SBSA_PCIE_PIO].base;
      int irq = sbsa_ref_irqmap[SBSA_PCIE];
+    MachineClass *mc = MACHINE_GET_CLASS(sms);
      MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
      MemoryRegion *ecam_alias, *ecam_reg;
      DeviceState *dev;
@@ -641,7 +642,7 @@ static void create_pcie(SBSAMachineState *sms)
              NICInfo *nd = &nd_table[i];
  
              if (!nd->model) {
-                nd->model = g_strdup("e1000e");
+                nd->model = g_strdup(mc->default_nic);
              }
  
              pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
@@ -858,6 +859,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
      mc->minimum_page_bits = 12;
      mc->block_default_type = IF_IDE;
      mc->no_cdrom = 1;
+    mc->default_nic = "e1000e";
      mc->default_ram_size = 1 * GiB;
      mc->default_ram_id = "sbsa-ref.ram";
      mc->default_cpus = 4;

(I'm doing that default_nic change for a lot of other boards
currently, so I can send a proper patch for this later)

  Thomas


