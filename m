Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6BA2057F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:03:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgVK-0004W8-7U; Tue, 28 Jan 2025 02:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgV8-0003gR-FZ; Tue, 28 Jan 2025 02:59:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgV6-0001Bb-5r; Tue, 28 Jan 2025 02:59:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DBD1CE1B02;
 Tue, 28 Jan 2025 10:54:25 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 56E211A62E9;
 Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 05A6552069; Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 33/45] s390x/s390-virtio-ccw: don't crash on weird RAM
 sizes
Date: Mon, 27 Jan 2025 23:26:14 +0300
Message-Id: <20250127202630.3724367-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
References: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

KVM is not happy when starting a VM with weird RAM sizes:

  # qemu-system-s390x --enable-kvm --nographic -m 1234K
  qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION
    failed, slot=0, start=0x0, size=0x244000: Invalid argument
  kvm_set_phys_mem: error registering slot: Invalid argument
  Aborted (core dumped)

Let's handle that in a better way by rejecting such weird RAM sizes
right from the start:

  # qemu-system-s390x --enable-kvm --nographic -m 1234K
  qemu-system-s390x: ram size must be multiples of 1 MiB

Message-ID: <20241219144115.2820241-2-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
(cherry picked from commit 14e568ab4836347481af2e334009c385f456a734)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2d6b86624f..d31686e105 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -184,6 +184,17 @@ static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem = get_system_memory();
 
+    if (!QEMU_IS_ALIGNED(memory_region_size(ram), 1 * MiB)) {
+        /*
+         * SCLP cannot possibly expose smaller granularity right now and KVM
+         * cannot handle smaller granularity. As we don't support NUMA, the
+         * region size directly corresponds to machine->ram_size, and the region
+         * is a single RAM memory region.
+         */
+        error_report("ram size must be multiples of 1 MiB");
+        exit(EXIT_FAILURE);
+    }
+
     /* allocate RAM for core */
     memory_region_add_subregion(sysmem, 0, ram);
 
-- 
2.39.5


