Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF07E9C6E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 13:51:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2WOx-0007gI-EV; Mon, 13 Nov 2023 07:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r2WOw-0007fS-3J
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r2WOu-0005Du-9A
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699879846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Onk9QxmyyaXrupbRmx0M+aIO5AGYsMNFSXnY/RPkB2M=;
 b=i7iiJPWqX6RX6p0418Rqjx02hcjYe8uilqnxjev7Ft0tqyuZ51lyJr2KjI9SMD15mN3tpy
 +i3R3Fn8s+HMGMJZjjD5zHfmD9hF/AYxROn6vsmXpGCh/2gCh//gi6pkMunQweOFPoXRp5
 mRom39/YwIw7SuYJKNqOmJTOr7LAp4M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-0ZtkwhRDPvi-sEqN8aOC7A-1; Mon,
 13 Nov 2023 07:50:41 -0500
X-MC-Unique: 0ZtkwhRDPvi-sEqN8aOC7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DFB13C1AC94;
 Mon, 13 Nov 2023 12:50:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA8D85031;
 Mon, 13 Nov 2023 12:50:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8AB061804A63; Mon, 13 Nov 2023 13:50:39 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin O'Connor <kevin@koconnor.net>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6] limit address space used for pci devices.
Date: Mon, 13 Nov 2023 13:50:39 +0100
Message-ID: <20231113125039.57200-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For better compatibility with old linux kernels,
see source code comment.

Also rename some variables to make the code more
readable, following suggestions by Kevin.

Related (same problem in ovmf):
https://github.com/tianocore/edk2/commit/c1e853769046

Cc: Kevin O'Connor <kevin@koconnor.net>
Reported-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/fw/pciinit.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index c7084f5e397e..6b13cd5b7d1c 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -46,12 +46,16 @@ static const char *region_type_name[] = {
     [ PCI_REGION_TYPE_PREFMEM ] = "prefmem",
 };
 
+// Memory ranges exported to legacy ACPI type table generation
 u64 pcimem_start   = BUILD_PCIMEM_START;
 u64 pcimem_end     = BUILD_PCIMEM_END;
 u64 pcimem64_start = BUILD_PCIMEM64_START;
 u64 pcimem64_end   = BUILD_PCIMEM64_END;
-u64 pci_io_low_end = 0xa000;
-u32 pci_use_64bit  = 0;
+
+// Resource allocation limits
+static u64 pci_io_low_end = 0xa000;
+static u64 pci_mem64_top  = 0;
+static u32 pci_pad_mem64  = 0;
 
 struct pci_region_entry {
     struct pci_device *dev;
@@ -966,8 +970,9 @@ static int pci_bios_check_devices(struct pci_bus *busses)
             int resource_optional = 0;
             if (hotplug_support == HOTPLUG_PCIE)
                 resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
-            if (hotplug_support && pci_use_64bit && is64 && (type == PCI_REGION_TYPE_PREFMEM))
-                align = (u64)1 << (CPUPhysBits - 11);
+            if (hotplug_support && pci_pad_mem64 && is64
+                && (type == PCI_REGION_TYPE_PREFMEM))
+                align = pci_mem64_top >> 11;
             if (align > sum && hotplug_support && !resource_optional)
                 sum = align; /* reserve min size for hot-plug */
             if (size > sum) {
@@ -1111,7 +1116,7 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         panic("PCI: out of I/O address space\n");
 
     dprintf(1, "PCI: 32: %016llx - %016llx\n", pcimem_start, pcimem_end);
-    if (pci_use_64bit || pci_bios_init_root_regions_mem(busses)) {
+    if (pci_pad_mem64 || pci_bios_init_root_regions_mem(busses)) {
         struct pci_region r64_mem, r64_pref;
         r64_mem.list.first = NULL;
         r64_pref.list.first = NULL;
@@ -1131,14 +1136,13 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         r64_mem.base = le64_to_cpu(romfile_loadint("etc/reserved-memory-end", 0));
         if (r64_mem.base < 0x100000000LL + RamSizeOver4G)
             r64_mem.base = 0x100000000LL + RamSizeOver4G;
-        if (CPUPhysBits) {
-            u64 top = 1LL << CPUPhysBits;
+        if (pci_mem64_top) {
             u64 size = (ALIGN(sum_mem, (1LL<<30)) +
                         ALIGN(sum_pref, (1LL<<30)));
-            if (pci_use_64bit)
-                size = ALIGN(size, (1LL<<(CPUPhysBits-3)));
-            if (r64_mem.base < top - size) {
-                r64_mem.base = top - size;
+            if (pci_pad_mem64)
+                size = ALIGN(size, pci_mem64_top >> 3);
+            if (r64_mem.base < pci_mem64_top - size) {
+                r64_mem.base = pci_mem64_top - size;
             }
             if (e820_is_used(r64_mem.base, size))
                 r64_mem.base -= size;
@@ -1181,8 +1185,18 @@ pci_setup(void)
 
     dprintf(3, "pci setup\n");
 
+    if (CPUPhysBits) {
+        pci_mem64_top = 1LL << CPUPhysBits;
+        if (CPUPhysBits > 46) {
+            // Old linux kernels have trouble dealing with more than 46
+            // phys-bits, so avoid that for now.  Seems to be a bug in the
+            // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
+            pci_mem64_top = 1LL << 46;
+        }
+    }
+
     if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G)
-        pci_use_64bit = 1;
+        pci_pad_mem64 = 1;
 
     dprintf(1, "=== PCI bus & bridge init ===\n");
     if (pci_probe_host() != 0) {
-- 
2.41.0


