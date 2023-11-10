Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C847E7BAC
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:05:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PJX-0006ZR-E4; Fri, 10 Nov 2023 06:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r1PJT-0006ZH-4y
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r1PJQ-0000qo-IL
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699614270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8uixZaHBVd8vS90lOHBBKjfd5ecyIq7YDpA9iWP9aI=;
 b=gTBxrSTCkvHOod/LbTsCHHyn0mwrY0Hzpbubgwc2ZuK6CiJl828MwbCNsKBEZM7xPjGQjc
 I9lMdEjetCXKxQSASReh/Zd6tUNKFWch+ALTXbd6NuhSpEWk3tJHKrjSvT144R2UjP1zkf
 9JV4aHqn0/AbsgFZiI0fY5xAawgTuLM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-vKHegDgUOLKIEhQ4PQdvcw-1; Fri,
 10 Nov 2023 06:04:27 -0500
X-MC-Unique: vKHegDgUOLKIEhQ4PQdvcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8523C1C0518E;
 Fri, 10 Nov 2023 11:04:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 531071C060AE;
 Fri, 10 Nov 2023 11:04:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 07B0D1800D60; Fri, 10 Nov 2023 12:04:24 +0100 (CET)
Date: Fri, 10 Nov 2023 12:04:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Kevin O'Connor <kevin@koconnor.net>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 seabios@seabios.org, qemu-devel@nongnu.org
Subject: Re: [SeaBIOS] [PATCH v5] limit physical address space size
Message-ID: <iqerqemhgokkgemaxnfktoz6ssrk3uqc4bncoghmhhxaaycleo@u5k642niiya3>
References: <20231107130309.3257776-1-kraxel@redhat.com>
 <ZUvVCHWbU29+eDm7@morn>
 <59437ef3-7b94-2aa4-31b4-012412ce160b@suse.de>
 <npmimli5x4vcwxb3csaaut3sobuzsex7pgtf4xbrbnfd22hnyz@ixh5tmn4xkpk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <npmimli5x4vcwxb3csaaut3sobuzsex7pgtf4xbrbnfd22hnyz@ixh5tmn4xkpk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

  Hi,

> This only changes the placement of the PCI bars.  The pci setup code is
> the only consumer of that variable, guess it makes sense to move the
> quirk to the pci code (as suggested by Kevin) to clarify this.

i.e. like this:

From d538dc7d4316e557ae302464252444d09de0681d Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 7 Nov 2023 13:49:31 +0100
Subject: [PATCH] limit physical address space size

For better compatibility with old linux kernels,
see source code comment.

Related (same problem in ovmf):
https://github.com/tianocore/edk2/commit/c1e853769046

Reported-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/fw/pciinit.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index c7084f5e397e..7aeea61bfd05 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -52,6 +52,7 @@ u64 pcimem64_start = BUILD_PCIMEM64_START;
 u64 pcimem64_end   = BUILD_PCIMEM64_END;
 u64 pci_io_low_end = 0xa000;
 u32 pci_use_64bit  = 0;
+u32 pci_phys_bits  = 0;
 
 struct pci_region_entry {
     struct pci_device *dev;
@@ -967,7 +968,7 @@ static int pci_bios_check_devices(struct pci_bus *busses)
             if (hotplug_support == HOTPLUG_PCIE)
                 resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
             if (hotplug_support && pci_use_64bit && is64 && (type == PCI_REGION_TYPE_PREFMEM))
-                align = (u64)1 << (CPUPhysBits - 11);
+                align = (u64)1 << (pci_phys_bits - 11);
             if (align > sum && hotplug_support && !resource_optional)
                 sum = align; /* reserve min size for hot-plug */
             if (size > sum) {
@@ -1131,12 +1132,12 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         r64_mem.base = le64_to_cpu(romfile_loadint("etc/reserved-memory-end", 0));
         if (r64_mem.base < 0x100000000LL + RamSizeOver4G)
             r64_mem.base = 0x100000000LL + RamSizeOver4G;
-        if (CPUPhysBits) {
-            u64 top = 1LL << CPUPhysBits;
+        if (pci_phys_bits) {
+            u64 top = 1LL << pci_phys_bits;
             u64 size = (ALIGN(sum_mem, (1LL<<30)) +
                         ALIGN(sum_pref, (1LL<<30)));
             if (pci_use_64bit)
-                size = ALIGN(size, (1LL<<(CPUPhysBits-3)));
+                size = ALIGN(size, (1LL<<(pci_phys_bits-3)));
             if (r64_mem.base < top - size) {
                 r64_mem.base = top - size;
             }
@@ -1181,8 +1182,16 @@ pci_setup(void)
 
     dprintf(3, "pci setup\n");
 
-    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G)
+    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G) {
         pci_use_64bit = 1;
+        pci_phys_bits = CPUPhysBits;
+        if (pci_phys_bits > 46) {
+            // Old linux kernels have trouble dealing with more than 46
+            // phys-bits, so avoid that for now.  Seems to be a bug in the
+            // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
+            pci_phys_bits = 46;
+        }
+    }
 
     dprintf(1, "=== PCI bus & bridge init ===\n");
     if (pci_probe_host() != 0) {
-- 
2.41.0


