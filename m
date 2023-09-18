Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCB7A4AF4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:59:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEir-0002Zy-FE; Mon, 18 Sep 2023 09:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiEiY-0002Fe-BP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiEiW-0001Oa-Gk
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695045311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Koj/WFFcI8wd9taQ9rm4o1b9fZP8flquxTX+ZbRVfg4=;
 b=J79H0QqYUqHv23dsn9vwzxCxtf3IloIOE8/p5VY7w0lerTOzWZJJlYXOn0Y78GivcDgkSJ
 4m9ngEv81pINv/cZxoiekBPNoNvUFQn6wkYnL4LfzTb+972IRZWxowsagA7XblMB03Eoxa
 Aza55fueozWGh9NsWRcMHMyHqy6u8SQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-ArxrYUJQNsWFFUZeOSwWNQ-1; Mon, 18 Sep 2023 09:55:09 -0400
X-MC-Unique: ArxrYUJQNsWFFUZeOSwWNQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-271bb60d8a8so4748754a91.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 06:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695045308; x=1695650108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Koj/WFFcI8wd9taQ9rm4o1b9fZP8flquxTX+ZbRVfg4=;
 b=okDEZglluGS3NsBGgFFOeDfeES7rLMVXhnuiuyoctFTqF+nrM+3uwWHjzh+vfHlDKx
 cZ4wGbfovE800DyUn0/7MClkLXKeNt2xO6AysIebuiJXOLKvzCzzKTpwBcCi2XRgC0Ae
 /FZ1gfMNhIkeftsRKzE4rH4zQdapYm1TXErU0WBRsL7QUKNt3hk20KtUs085xqDVuQV+
 47upfZn94ircrhj9nl0Bdh90N95MzcipAx6Dg702qP54HYiBEaZpVQTG70th1jyXnkeA
 zmJNj13PVURW5Mp84xjfX+HYCEaHKnlxxltEZvvxI3Y8Llv7E3lV0dDt8WtjV26sm8qu
 1Rgw==
X-Gm-Message-State: AOJu0YzwU3bquQ6/DmNtW+W15o0Q/lJL76E4S6WCUJELEaHvniuDdQhx
 5B494BTg21GWSSTii7ihKI8CQyTE6Vp3mW4ylSj9nfejKuHaVprVQuQX1OAqX58U3N4OS5uCBHG
 vUy7FA5vo4JiOv/k=
X-Received: by 2002:a17:90a:69e5:b0:270:b961:1c3d with SMTP id
 s92-20020a17090a69e500b00270b9611c3dmr8100945pjj.22.1695045308615; 
 Mon, 18 Sep 2023 06:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8+0sqwq+EO3R/pD9FpFbr6J43ofgfLrptCGnq9C2VbGpBmtxZFVzclBbGTQ4JDs7x6EWJqg==
X-Received: by 2002:a17:90a:69e5:b0:270:b961:1c3d with SMTP id
 s92-20020a17090a69e500b00270b9611c3dmr8100932pjj.22.1695045308273; 
 Mon, 18 Sep 2023 06:55:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.204.151])
 by smtp.googlemail.com with ESMTPSA id
 nb2-20020a17090b35c200b00274b035246esm3825396pjb.1.2023.09.18.06.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 06:55:07 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: philmd@linaro.org, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
Date: Mon, 18 Sep 2023 19:24:48 +0530
Message-Id: <20230918135448.90963-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

32-bit systems do not have a reserved memory for hole64 but they may have a
reserved memory space for memory hotplug. Since, hole64 starts after the
reserved hotplug memory, the unaligned hole64 start address gives us the
end address for this memory hotplug region that the processor may use.
Fix this. This ensures that the physical address space bound checking works
correctly for 32-bit systems as well.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc.c | 60 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c41..c8abcabd53 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -904,13 +904,43 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
     return start;
 }
 
+/*
+ * The 64bit pci hole starts after "above 4G RAM" and
+ * potentially the space reserved for memory hotplug.
+ * This function returns unaligned start address.
+ */
+static uint64_t pc_pci_hole64_start_unaligned(void)
+{
+    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
+    uint64_t hole64_start = 0;
+    ram_addr_t size = 0;
+
+    if (pcms->cxl_devices_state.is_enabled) {
+        hole64_start = pc_get_cxl_range_end(pcms);
+    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
+        pc_get_device_memory_range(pcms, &hole64_start, &size);
+        if (!pcmc->broken_reserved_end) {
+            hole64_start += size;
+        }
+    } else {
+        hole64_start = pc_above_4g_end(pcms);
+    }
+
+    return hole64_start;
+}
+
 static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
 
-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
-        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    /*
+     * 32-bit systems don't have hole64, but we might have a region for
+     * memory hotplug.
+     */
+    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
+        return pc_pci_hole64_start_unaligned() - 1;
     }
 
     return pc_pci_hole64_start() + pci_hole64_size - 1;
@@ -1147,30 +1177,10 @@ void pc_memory_init(PCMachineState *pcms,
     pcms->memhp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
 }
 
-/*
- * The 64bit pci hole starts after "above 4G RAM" and
- * potentially the space reserved for memory hotplug.
- */
+/* returns 1 GiB aligned hole64 start address */
 uint64_t pc_pci_hole64_start(void)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    MachineState *ms = MACHINE(pcms);
-    uint64_t hole64_start = 0;
-    ram_addr_t size = 0;
-
-    if (pcms->cxl_devices_state.is_enabled) {
-        hole64_start = pc_get_cxl_range_end(pcms);
-    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
-        pc_get_device_memory_range(pcms, &hole64_start, &size);
-        if (!pcmc->broken_reserved_end) {
-            hole64_start += size;
-        }
-    } else {
-        hole64_start = pc_above_4g_end(pcms);
-    }
-
-    return ROUND_UP(hole64_start, 1 * GiB);
+    return ROUND_UP(pc_pci_hole64_start_unaligned(), 1 * GiB);
 }
 
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
-- 
2.39.1


