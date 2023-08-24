Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A3786ADB
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6AN-0007Mj-Hj; Thu, 24 Aug 2023 04:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AJ-0007J5-9F
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AF-0003i6-Nn
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFoz8pFygAnd8HjNAOMgarx4ONt0soHWY8cYtfArawE=;
 b=AnPG0jIkkr1+3Lhsr6UNK96ORmSWJbgXCoRFlW57j9hAkcB0Ul2MVQl9EQqBSyWndUAt2C
 VN9k+jBjH4DaUY0TvgvB1aATXfSq1jVzJdC4fHsP4tG69eVM3OQoRxFM0v2GG+4z0cFw9d
 VzU0iH6DM4VpbdqEIjEAKD8SBynVleo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-OsqQBBlNPWmS3S9ngnxBjQ-1; Thu, 24 Aug 2023 04:58:01 -0400
X-MC-Unique: OsqQBBlNPWmS3S9ngnxBjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D52978D40A1;
 Thu, 24 Aug 2023 08:58:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A10492026D68;
 Thu, 24 Aug 2023 08:58:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BE864180063D; Thu, 24 Aug 2023 10:57:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 4/6] be less conservative with the 64bit pci io window
Date: Thu, 24 Aug 2023 10:57:54 +0200
Message-ID: <20230824085756.66732-5-kraxel@redhat.com>
In-Reply-To: <20230824085756.66732-1-kraxel@redhat.com>
References: <20230824085756.66732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

Current seabios code will only enable and use the 64bit pci io window in
case it runs out of space in the 32bit pci mmio window below 4G.

This patch will also enable the 64bit pci io window when
  (a) RAM above 4G is present, and
  (b) the physical address space size is known, and
  (c) seabios is running on a 64bit capable processor.

This operates with the assumption that guests which are ok with memory
above 4G most likely can handle mmio above 4G too.

In case the 64bit pci io window is enabled also assign more memory to
prefetchable pci bridge windows and the complete 64bit pci io window.

The total mmio window size is 1/8 of the physical address space.
Minimum bridge windows size is 1/256 of the total mmio window size.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/fw/pciinit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index 0fcd2be598a2..b52bd1d5054b 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -51,6 +51,7 @@ u64 pcimem_end     = BUILD_PCIMEM_END;
 u64 pcimem64_start = BUILD_PCIMEM64_START;
 u64 pcimem64_end   = BUILD_PCIMEM64_END;
 u64 pci_io_low_end = 0xa000;
+u32 pci_use_64bit  = 0;
 
 struct pci_region_entry {
     struct pci_device *dev;
@@ -960,10 +961,14 @@ static int pci_bios_check_devices(struct pci_bus *busses)
             if (pci_region_align(&s->r[type]) > align)
                  align = pci_region_align(&s->r[type]);
             u64 sum = pci_region_sum(&s->r[type]);
+            int is64 = pci_bios_bridge_region_is64(&s->r[type],
+                                                   s->bus_dev, type);
             int resource_optional = 0;
             if (hotplug_support == HOTPLUG_PCIE)
                 resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
-            if (!sum && hotplug_support && !resource_optional)
+            if (hotplug_support && pci_use_64bit && is64 && (type == PCI_REGION_TYPE_PREFMEM))
+                align = (u64)1 << (CPUPhysBits - 11);
+            if (align > sum && hotplug_support && !resource_optional)
                 sum = align; /* reserve min size for hot-plug */
             if (size > sum) {
                 dprintf(1, "PCI: QEMU resource reserve cap: "
@@ -975,8 +980,6 @@ static int pci_bios_check_devices(struct pci_bus *busses)
             } else {
                 size = ALIGN(sum, align);
             }
-            int is64 = pci_bios_bridge_region_is64(&s->r[type],
-                                            s->bus_dev, type);
             // entry->bar is -1 if the entry represents a bridge region
             struct pci_region_entry *entry = pci_region_create_entry(
                 parent, s->bus_dev, -1, size, align, type, is64);
@@ -1108,7 +1111,7 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         panic("PCI: out of I/O address space\n");
 
     dprintf(1, "PCI: 32: %016llx - %016llx\n", pcimem_start, pcimem_end);
-    if (pci_bios_init_root_regions_mem(busses)) {
+    if (pci_use_64bit || pci_bios_init_root_regions_mem(busses)) {
         struct pci_region r64_mem, r64_pref;
         r64_mem.list.first = NULL;
         r64_pref.list.first = NULL;
@@ -1132,6 +1135,8 @@ static void pci_bios_map_devices(struct pci_bus *busses)
             u64 top = 1LL << CPUPhysBits;
             u64 size = (ALIGN(sum_mem, (1LL<<30)) +
                         ALIGN(sum_pref, (1LL<<30)));
+            if (pci_use_64bit)
+                size = ALIGN(size, (1LL<<(CPUPhysBits-3)));
             if (r64_mem.base < top - size) {
                 r64_mem.base = top - size;
             }
@@ -1174,6 +1179,9 @@ pci_setup(void)
 
     dprintf(3, "pci setup\n");
 
+    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G)
+        pci_use_64bit = 1;
+
     dprintf(1, "=== PCI bus & bridge init ===\n");
     if (pci_probe_host() != 0) {
         return;
-- 
2.41.0


