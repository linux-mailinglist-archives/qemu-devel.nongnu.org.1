Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1C7C6B95
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtKJ-0003F6-Tj; Thu, 12 Oct 2023 06:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqtKI-0003Ex-G6
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:53:58 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqtKG-0005eF-G9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:53:58 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50337b43ee6so1159639e87.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697108034; x=1697712834; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79GppcGvzoqwiV/Ut8TzwZ31E6X9xmbhekT6eCAOzUI=;
 b=dBsbwQokDFM1jRahEuA1d23O9nLW8BiNhLCG7QR7bjYZySYstgpI+JjBz25MIyHBr6
 RSiDqHBgTcn5Kvivi9QYRbO9P8VpAoIxK55RAB6YC2oEOIhrICgXex7cyhBWk3OhGfP7
 xZ9LalCQ3xvnntQ0qen1R2yzA3w4XHkiSqnJXMZWKjpcW+yaM2WnNvsYiydGyVTWLbhb
 Qw/Er9ezBvZd0VdGe8bUs9Eo6rAoB2CFCQrvM05tOA2C+K7SDqTUxaYASx16zYDrFUws
 HfgZz64+jy6EzN1Scn2AxkuRLqjMI8xpN7FEuilNlNAN1fW/3I25VRDe7MmVwyV3OrU+
 zaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697108034; x=1697712834;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=79GppcGvzoqwiV/Ut8TzwZ31E6X9xmbhekT6eCAOzUI=;
 b=vcWhDu9YwZgeK2YTRATcqnLvSP7GZ6RqMl2ZfkIUW3HOuLzcYS/Ylxr4XjS6QMwhl/
 oRDVv672qpo3QnixFtbFu7l0oEpK6+RJXw0at4zh4S2tDhkott+SzrW8WvKvOvNkfrSD
 2ardgiOw3JtgXHKKk9p/eGdp87o/804RAQya6ENHHXIWxF/+UA2KfghCnBJN1tBlEJWn
 nnMJ/N96JOXAMMOcIYPP5vTO4OCVxLWcZYCx5j/u5mtlAm9hZQ9dBXJxHRlhNeGPoPmu
 mRBpksl+1ZcN+NgWNahVmUQRAAW/MuONumwXp5ClD63azAvUoIQ+QHdb4ePsVap+HfTt
 elRQ==
X-Gm-Message-State: AOJu0Yx4MyTQqX5vRfA3IqCT0BPnqnMhpjZP2SZ/ExwGnq9vxmDq03h1
 pmIG5JgMET0n/ZD0eFYQMpfISw==
X-Google-Smtp-Source: AGHT+IHh5IZYLbIw+vUnUD5n3sG1+DCRHUlIuGi2dmusM7zCKoK9nMFlExoY4bikSiSx3bb1k3UMUA==
X-Received: by 2002:a19:e010:0:b0:500:b74b:e53 with SMTP id
 x16-20020a19e010000000b00500b74b0e53mr18050178lfg.46.1697108034080; 
 Thu, 12 Oct 2023 03:53:54 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 hn32-20020a05600ca3a000b004053e9276easm21533158wmb.32.2023.10.12.03.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 03:53:53 -0700 (PDT)
Message-ID: <bbd3c42b-5069-d5e8-0b97-70ff5135801c@linaro.org>
Date: Thu, 12 Oct 2023 12:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: QOM crash via soundhw_init()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Martin, Paolo, Markus, Marc-André,

With the following changes:

-- >8 --
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 137276bcb9..291495f798 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -245,6 +245,7 @@ static void ibm_40p_init(MachineState *machine)
      uint32_t kernel_base = 0, initrd_base = 0;
      long kernel_size = 0, initrd_size = 0;
      char boot_device;
+    MemoryRegion rom;

      if (kvm_enabled()) {
          error_report("machine %s does not support the KVM accelerator",
@@ -277,6 +278,9 @@ static void ibm_40p_init(MachineState *machine)
          exit(1);
      }

+    memory_region_init_rom_nomigrate(&rom, OBJECT(machine), "test",
+                                     4 * KiB, &error_fatal);
+
      /* PCI -> ISA bridge */
      i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
      qdev_connect_gpio_out(i82378_dev, 0,

---

I'm getting:

$ ./qemu-system-ppc -M 40p -S -nodefaults
==3518191==WARNING: ASan doesn't fully support makecontext/swapcontext 
functions and may produce false positives in some cases!
qom/object.c:935:13: runtime error: member access within null pointer of 
type 'struct TypeImpl'
AddressSanitizer:DEADLYSIGNAL
=================================================================
==3518191==ERROR: AddressSanitizer: SEGV on unknown address 
0x000000000000 (pc 0x55f728f5e179 bp 0x7ffd91999220 sp 0x7ffd919991d0 T0)
==3518191==The signal is caused by a READ memory access.
==3518191==Hint: address points to the zero page.
     #0 0x55f728f5e179 in object_class_dynamic_cast qom/object.c:935
     #1 0x55f728f5d9f4 in object_dynamic_cast qom/object.c:876
     #2 0x55f728f6605a in object_resolve_abs_path qom/object.c:2096
     #3 0x55f728f662f1 in object_resolve_partial_path qom/object.c:2120
     #4 0x55f728f6648a in object_resolve_partial_path qom/object.c:2130
     #5 0x55f728f6648a in object_resolve_partial_path qom/object.c:2130
     #6 0x55f728f668b7 in object_resolve_path_type qom/object.c:2159
     #7 0x55f727ab14c8 in soundhw_init hw/audio/soundhw.c:112
     #8 0x55f72858f27e in qemu_create_cli_devices system/vl.c:2604
     #9 0x55f72858f8c7 in qmp_x_exit_preconfig system/vl.c:2685
     #10 0x55f7285955cd in qemu_init system/vl.c:3734
     #11 0x55f72790620a in main system/main.c:47
     #12 0x7fd5fec57d8f in __libc_start_call_main
     #13 0x7fd5fec57e3f in __libc_start_main_impl libc-start.c:392
     #14 0x55f727906104 in _start (build_asan/qemu-system-ppc+0x2ca4104)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV qom/object.c:935 in 
object_class_dynamic_cast
==3518191==ABORTING

O_o

Any idea what I'm missing?

Unified diff running with '-trace obj\* ':

@@ -1,4 +1,4 @@
-==3534948==WARNING: ASan doesn't fully support makecontext/swapcontext 
functions and may produce false positives in some cases!
+==3533425==WARNING: ASan doesn't fully support makecontext/swapcontext 
functions and may produce false positives in some cases!
  object_class_dynamic_cast_assert authz-pam->user-creatable 
(include/qom/object_interfaces.h:11:USER_CREATABLE_CLASS)
  object_class_dynamic_cast_assert authz-pam->authz 
(include/authz/base.h:30:QAUTHZ_CLASS)
  object_class_dynamic_cast_assert device->device 
(include/hw/qdev-core.h:77:DEVICE_CLASS)
@@ -2481,6 +2481,7 @@
  object_class_dynamic_cast_assert PCI->bus 
(include/hw/qdev-core.h:315:BUS_GET_CLASS)
  object_dynamic_cast_assert PCI->PCI (include/hw/pci/pci.h:270:PCI_BUS)
  object_dynamic_cast_assert PCI->PCI (include/hw/pci/pci.h:270:PCI_BUS)
+object_dynamic_cast_assert memory-region->memory-region 
(include/exec/memory.h:37:MEMORY_REGION)
  object_dynamic_cast_assert i82378->device 
(include/hw/qdev-core.h:77:DEVICE)
  object_dynamic_cast_assert i82378->device 
(include/hw/qdev-core.h:77:DEVICE)
  object_dynamic_cast_assert i82378->device 
(include/hw/qdev-core.h:77:DEVICE)
@@ -3014,355 +3015,28 @@
  object_dynamic_cast_assert memory-region->memory-region 
(include/exec/memory.h:37:MEMORY_REGION)
  object_dynamic_cast_assert memory-region->memory-region 
(include/exec/memory.h:37:MEMORY_REGION)
  object_dynamic_cast_assert memory-region->memory-region 
(include/exec/memory.h:37:MEMORY_REGION)
-object_dynamic_cast_assert fw_cfg_mem->fw_cfg 
(include/hw/nvram/fw_cfg.h:15:FW_CFG)
-object_dynamic_cast_assert 40p-machine->machine 
(include/hw/boards.h:23:MACHINE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert or-irq->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_class_dynamic_cast_assert or-irq->device 
(include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert mc146818rtc->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_class_dynamic_cast_assert mc146818rtc->device 
(include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert isa-i8259->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_class_dynamic_cast_assert isa-i8259->device 
(include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert (null)->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_dynamic_cast_assert rs6000-mc->device 
(include/hw/qdev-core.h:77:DEVICE)
-object_class_dynamic_cast_assert rs6000-mc->device 
(include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
[...]

Thanks,

Phil.

