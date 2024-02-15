Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E58565F7
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Feb 2024 15:29:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racjP-0003Kt-MZ; Thu, 15 Feb 2024 09:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1racjL-0003KQ-Pu
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:28:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1racjJ-0001l1-QV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:28:51 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbHQ54Qrbz67g6l;
 Thu, 15 Feb 2024 22:24:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F1CC1424E9;
 Thu, 15 Feb 2024 22:28:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 14:28:47 +0000
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 1/3] physmem: Reduce local variable scope in
 flatview_read/write_continue()
Date: Thu, 15 Feb 2024 14:28:15 +0000
Message-ID: <20240215142817.1904-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Precursor to factoring out the inner loops for reuse.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 system/physmem.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 6a3c9de512..39b5ac751e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2684,10 +2684,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
-    uint8_t *ram_ptr;
-    uint64_t val;
     MemTxResult result = MEMTX_OK;
-    bool release_lock = false;
     const uint8_t *buf = ptr;
 
     for (;;) {
@@ -2695,7 +2692,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             result |= MEMTX_ACCESS_ERROR;
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, true)) {
-            release_lock |= prepare_mmio_access(mr);
+            uint64_t val;
+            bool release_lock = prepare_mmio_access(mr);
+
             l = memory_access_size(mr, l, addr1);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
@@ -2713,18 +2712,19 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             val = ldn_he_p(buf, l);
             result |= memory_region_dispatch_write(mr, addr1, val,
                                                    size_memop(l), attrs);
+            if (release_lock) {
+                bql_unlock();
+            }
+
+
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l,
+                                                   false);
             memmove(ram_ptr, buf, l);
             invalidate_and_set_dirty(mr, addr1, l);
         }
 
-        if (release_lock) {
-            bql_unlock();
-            release_lock = false;
-        }
-
         len -= l;
         buf += l;
         addr += l;
@@ -2763,10 +2763,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
-    uint8_t *ram_ptr;
-    uint64_t val;
     MemTxResult result = MEMTX_OK;
-    bool release_lock = false;
     uint8_t *buf = ptr;
 
     fuzz_dma_read_cb(addr, len, mr);
@@ -2776,7 +2773,9 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, false)) {
             /* I/O case */
-            release_lock |= prepare_mmio_access(mr);
+            uint64_t val;
+            bool release_lock = prepare_mmio_access(mr);
+
             l = memory_access_size(mr, l, addr1);
             result |= memory_region_dispatch_read(mr, addr1, &val,
                                                   size_memop(l), attrs);
@@ -2792,17 +2791,16 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                    (l == 8 && len >= 8));
 #endif
             stn_he_p(buf, l, val);
+            if (release_lock) {
+                bql_unlock();
+            }
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l,
+                                                   false);
             memcpy(buf, ram_ptr, l);
         }
 
-        if (release_lock) {
-            bql_unlock();
-            release_lock = false;
-        }
-
         len -= l;
         buf += l;
         addr += l;
-- 
2.39.2


