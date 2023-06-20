Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9E73755D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:50:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIq-0000Ss-Qr; Tue, 20 Jun 2023 15:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7r-0004dI-62
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:43 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7p-0006jz-PC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:42 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5704fce0f23so53462007b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687282000; x=1689874000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHEGkyOo3g328yI4EZ3HNLd3iLQ0+Je/nXJDB9lwhnA=;
 b=PncSRyYVOr1irJvi8xv5ztgmlBOKslZTl/vWuvDYGeUw9bKzdPsgyhgiKnoflKZRLK
 2qF+5lArQ7Pmbvs2YTcTkhPX6MvBD6Ea0LkyVddD4RcP+RRJCMT5mVrKzm+g1N6LBRSi
 TaaxhjvlJz9nSiWFKVtp9OyfxWyi1b0bM5GfDau//83zfat0m3vRsZ/1IqEUtMcMynty
 b2VHImsKUgkAEyx51nJTBbUjOg6h7MQXi4sGPGHGRxAgzjkZKacrUOCDdLLgcoNpp6Qh
 K7147oySAHB6YONRdlL0UjdfabL6vFsii/ULNVzwuP5WwNBvSQhQUfce86v1DAYYk3po
 GG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687282000; x=1689874000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHEGkyOo3g328yI4EZ3HNLd3iLQ0+Je/nXJDB9lwhnA=;
 b=LKNccaduIq3u3SNgujTR/CTOfAAfomtOr/iHPm9JENpZNfDRMSkUkS6qh1NMkOoFz4
 s9Pfs4LM5ireTrjLNQBNY6x6SUQykcV+QYZ3tGm6GEyjeJS9JxXJLO2WgWN/LnaKi8Dh
 PdF/KkEpWh9QUSb2VWahm0NTwYsZ4d6Ukevo+E+mWVPRBg1wjSmoyG5/QjCkhO/QvNZm
 MZ9TCzEQKhMV1M+NEaLUuF7VSQ+n3OSumGq4KEOzaNM7F4zoZDy/cxwQzJI/USpjFffp
 2Hof3MznDm1ToWr9yBzWAqQRFwz4Yl7KCOtGvb/dJ92NDiX2jY+uLbP0p966nvv7vOuf
 XRjg==
X-Gm-Message-State: AC+VfDzfCy0zRoglKZWMV/krRFOcXuIIiMCIJxkHPxQAodhYtNtxNvRR
 pPv7IpzCCsZPMH6xG+oJdoeO6H+hTkR6lg==
X-Google-Smtp-Source: ACHHUZ4NwX44H0JT1dIoz/zXnTzdrbv3YTqXTObzKaLCJvFmq9q7ZHw7D1SorkgchJscfmKTUz4Lhw==
X-Received: by 2002:a81:9185:0:b0:56d:3f2:35a3 with SMTP id
 i127-20020a819185000000b0056d03f235a3mr14171600ywg.44.1687281995648; 
 Tue, 20 Jun 2023 10:26:35 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:35 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 21/23] pc/q35: setup q35 for xen
Date: Tue, 20 Jun 2023 13:24:55 -0400
Message-Id: <5008557c44c16e0d7bb4187bd3284a72cac191cc.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

Mirrored the init done for piix devices when xen is being used.
This is needed for xen memory to be initialized and used with q35.

Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/i386/pc_q35.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 789a23ce6b..0b53a86dd2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -145,6 +145,7 @@ static void pc_q35_init(MachineState *machine)
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory;
     MemoryRegion *rom_memory;
+    MemoryRegion *ram_memory;
     GSIState *gsi_state;
     ISABus *isa_bus;
     int i;
@@ -196,8 +197,12 @@ static void pc_q35_init(MachineState *machine)
     }
 
     pc_machine_init_sgx_epc(pcms);
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+        machine->ram = ram_memory;
+    }
     kvmclock_create(pcmc->kvmclock_create_always);
 
     /* pci enabled */
@@ -230,7 +235,15 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* allocate ram and load rom/bios */
-    pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
+    if (!xen_enabled()) 
+        pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
+     else {
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
 
     object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
@@ -307,7 +320,7 @@ static void pc_q35_init(MachineState *machine)
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
-        pcms->vmport = ON_OFF_AUTO_ON;
+        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
     }
 
     /* init basic PC hardware */
-- 
2.34.1


