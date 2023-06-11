Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037372B15F
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IOw-0006Ps-DM; Sun, 11 Jun 2023 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOv-0006Pi-5K
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOt-0008Hc-IW
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:24 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5169f920a9dso6933817a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479661; x=1689071661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hD9TOazhJkhd4pwOyDYDJodwNlYelsc5vKvw/KbQM0U=;
 b=ZP3bFh5cJNhBrpU4wOANNlCp0IZp4ae9dFtTEK7ZwiQYiqy8pwPOFtwNCbXLxeeZQS
 1+3YKQKZkZ91FC3jcZesHxBqgfxeQdaQp5AfoHcrbObNBAYZL0nFcHQGH9kjndBKn8oc
 ervKh/yIYGWCFjkulCBXI+y1mKh0o+IKx/AAg4OUk1g4ijfjy5WLVFupAQz+ycpVNLuw
 BHZeYaxCWSjSGcO9R6fQzFD/FfwDuxRgt+PJm2n+tDQYSejcidYVuVmlqu+eYfdGE3np
 eLuv8E22L5Bf9l2psAXU4ZuPDDZGEP4ceHkZ82uO+tdPYnwUjR6ByBHz+Wf1jRhrum8g
 J+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479661; x=1689071661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD9TOazhJkhd4pwOyDYDJodwNlYelsc5vKvw/KbQM0U=;
 b=RCG/UkZUghRe37fxBBuK9YeBNww78CFPScAUtxK116frMK+shmuwMUS4n+3WR5Q441
 vfs1RqBEHpmanpVvO5ez8sl6TnLnJ3hbyFCvxik7GAY2Ayvfih6rzH9ipmfduQYWUXt1
 rgG8KLG8802K9wy6UWAjm13kHZL6WEprGZ3AbN6ubvmwaS5BM+ZLENnSulEp70B+On4p
 6U+rtrGhr6g1cfcShvwigOJ4oP54jprZn8tOnLSImgaK5op9ben1PqdXs7ulJsjdAdda
 3aeWLnA6ZpV0qOFtmxr81OIcyIN/luh7BWI3vagJ1ywe4i/g3yyhqfCCD2hw60megAT7
 mjTg==
X-Gm-Message-State: AC+VfDxTMRJ+FhNP4R8uFyq4VjmpU9jcyjnu4PiyzrcmywfCzp4zKdtP
 fckunXGCmrEPBZdjwuG/JITXghqOngE=
X-Google-Smtp-Source: ACHHUZ6cbT0t6Fa+lKUG0AuZEqapmPfWIUEVoMqa6YPE34caLhLH3MZdJNxxQNzhIoQ0+r4JzrwqoQ==
X-Received: by 2002:a05:6402:456:b0:514:224b:a48c with SMTP id
 p22-20020a056402045600b00514224ba48cmr3531660edw.0.1686479661267; 
 Sun, 11 Jun 2023 03:34:21 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 01/15] hw/i386/pc_q35: Resolve redundant q35_host variable
Date: Sun, 11 Jun 2023 12:33:58 +0200
Message-ID: <20230611103412.12109-2-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The variable is redundant to "phb" and is never used by its real type.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_q35.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6155427e48..62c5d652b7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -120,8 +120,7 @@ static void pc_q35_init(MachineState *machine)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
-    Q35PCIHost *q35_host;
-    PCIHostState *phb;
+    Object *phb;
     PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
@@ -207,10 +206,10 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* create pci host bus */
-    q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
+    phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
 
     if (pcmc->pci_enabled) {
-        pci_hole64_size = object_property_get_uint(OBJECT(q35_host),
+        pci_hole64_size = object_property_get_uint(phb,
                                                    PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                    &error_abort);
     }
@@ -218,23 +217,23 @@ static void pc_q35_init(MachineState *machine)
     /* allocate ram and load rom/bios */
     pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
 
-    object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
+    object_property_add_child(OBJECT(machine), "q35", phb);
+    object_property_set_link(phb, MCH_HOST_PROP_RAM_MEM,
                              OBJECT(machine->ram), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_SYSTEM_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_SYSTEM_MEM,
                              OBJECT(system_memory), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_IO_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_IO_MEM,
                              OBJECT(system_io), NULL);
-    object_property_set_int(OBJECT(q35_host), PCI_HOST_BELOW_4G_MEM_SIZE,
+    object_property_set_int(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
                             x86ms->below_4g_mem_size, NULL);
-    object_property_set_int(OBJECT(q35_host), PCI_HOST_ABOVE_4G_MEM_SIZE,
+    object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+
     /* pci */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(q35_host), &error_fatal);
-    phb = PCI_HOST_BRIDGE(q35_host);
-    host_bus = phb->bus;
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
                                 TYPE_ICH9_LPC_DEVICE);
-- 
2.41.0


