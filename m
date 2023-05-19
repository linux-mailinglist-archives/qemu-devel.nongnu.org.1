Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D5709AB2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TN-0006LC-16; Fri, 19 May 2023 10:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TK-00067m-7t
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TG-0003n9-4X
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7l9eaKw0wAoGbx++cmrYeMJ6/PfackXU4qxbeWVb6I=;
 b=LXrPrASFyN9xAarH6rCXPhF6Ub3pBPi66IuiHTRDcFUBFmuAvOwkrciCxhdfI+BG4B7HUD
 CfUsTSLbPQhdsCg8eGqLfa5zRkyAuB1ie5Heq2iiJIPlaiPFLlYADEokcp8yw6Kigzpv/5
 VwZ6Mf9/sLjpjn/5o9odmVTINBoy/Ro=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-fVxKquxzMlCgTFIlDJO5Cw-1; Fri, 19 May 2023 10:52:39 -0400
X-MC-Unique: fVxKquxzMlCgTFIlDJO5Cw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ad9ee492c7so19332371fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507958; x=1687099958;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7l9eaKw0wAoGbx++cmrYeMJ6/PfackXU4qxbeWVb6I=;
 b=VgEAIbHot90IfZlNh6AdjE1JXB/AeU2NjZt9ePCaxvi2RnRz9NEQHozic3egZS1bvv
 Wexht55HCVQNAf+G3CCmNW9F5bGPPwqDiT4KyS3A/pWZFFbRvSYhpq7/cg6L/6i57M+3
 eCz1psnJob1UUB19UP19a9QwOdDfQe6kFfKZIq+xaJ/r45hDtGpXPo9xDBxNzvvWSDtv
 JBghqUWAJR5U49YrZ28f+2OYeXbHmjllj8IQ5VH8+2kGX/14mO9Y+fm49atbp5x37z7x
 ipybo3QRhiwv3lb0kho8zi0nQRtw55lni5++YfVcweCJetk00Nj+e3bQTFqNEC9EGsvU
 I60g==
X-Gm-Message-State: AC+VfDz8AKbsWxZGfn9vSRwNQtI2khMm2OZTU0JyW2LMVGoTBRWFmVKO
 iKe5UXJ3fHfXFITuSrvNLnV3puns3paodj3/HJYvoutC0QncwC2eobP0IUmb52SshpwY7syJvbg
 fCatLmb4Fegb7FNdIYpI4WaaPpANLUghnUQfWsAcqWMPjBLi+LdydT9lLhrrTTdDLvNsW
X-Received: by 2002:a05:6512:49e:b0:4ef:ff42:b13 with SMTP id
 v30-20020a056512049e00b004efff420b13mr803756lfq.65.1684507957841; 
 Fri, 19 May 2023 07:52:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BuclpEfxdgyMOez7idGWRvwuJ5C47rw8aB2+3wb/rRNNrmGlevgV0ZqfNyW4anhtgoohEfA==
X-Received: by 2002:a05:6512:49e:b0:4ef:ff42:b13 with SMTP id
 v30-20020a056512049e00b004efff420b13mr803744lfq.65.1684507957543; 
 Fri, 19 May 2023 07:52:37 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 f26-20020ac2533a000000b004f3a1033078sm626368lfh.52.2023.05.19.07.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:37 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 33/40] hw/i386/pc: Initialize ram_memory variable directly
Message-ID: <f9fddaf7ce26acc48fc899673affe957103862a5.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Going through pc_memory_init() seems quite complicated for a simple
assignment.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230213162004.2797-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 2 --
 hw/i386/pc_piix.c    | 4 ++--
 hw/i386/pc_q35.c     | 6 ++----
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 84935fc958..4e638564ca 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -162,7 +162,6 @@ void xen_load_linux(PCMachineState *pcms);
 void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
-                    MemoryRegion **ram_memory,
                     uint64_t pci_hole64_size);
 uint64_t pc_pci_hole64_start(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7802dc21d9..03da571bda 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -952,7 +952,6 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
-                    MemoryRegion **ram_memory,
                     uint64_t pci_hole64_size)
 {
     int linux_boot, i;
@@ -1010,7 +1009,6 @@ void pc_memory_init(PCMachineState *pcms,
      * Split single memory region and use aliases to address portions of it,
      * done for backwards compatibility with older qemus.
      */
-    *ram_memory = machine->ram;
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
     memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
                              0, x86ms->below_4g_mem_size);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ac7b1a9194..1acf02e711 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -144,6 +144,7 @@ static void pc_init1(MachineState *machine,
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
+        ram_memory = machine->ram;
         if (!pcms->max_ram_below_4g) {
             pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
         }
@@ -206,8 +207,7 @@ static void pc_init1(MachineState *machine,
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory,
-                       rom_memory, &ram_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
     } else {
         pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1490f87adb..c1535af739 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -130,7 +130,6 @@ static void pc_q35_init(MachineState *machine)
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory;
     MemoryRegion *rom_memory;
-    MemoryRegion *ram_memory;
     GSIState *gsi_state;
     ISABus *isa_bus;
     int i;
@@ -216,12 +215,11 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* allocate ram and load rom/bios */
-    pc_memory_init(pcms, system_memory, rom_memory, &ram_memory,
-                   pci_hole64_size);
+    pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
 
     object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
-                             OBJECT(ram_memory), NULL);
+                             OBJECT(machine->ram), NULL);
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_SYSTEM_MEM,
-- 
MST


