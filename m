Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1951987721D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Mar 2024 17:00:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz5O-0007Q8-4V; Sat, 09 Mar 2024 10:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5G-0007NC-Gb; Sat, 09 Mar 2024 10:58:03 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5D-0004JJ-6A; Sat, 09 Mar 2024 10:58:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5577654532;
 Sat,  9 Mar 2024 18:58:39 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ECE42944C4;
 Sat,  9 Mar 2024 18:57:42 +0300 (MSK)
Received: (nullmailer pid 1694674 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 10/11] hw/mem/cxl_type3: Fix problem with g_steal_pointer()
Date: Sat,  9 Mar 2024 18:57:28 +0300
Message-Id: <20240309155729.1694607-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309155729.1694607-1-mjt@tls.msk.ru>
References: <20240309155729.1694607-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Thomas Huth <thuth@redhat.com>

When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher,
glib adds type safety checks to the g_steal_pointer() macro. This
triggers errors in the ct3_build_cdat_entries_for_mr() function which
uses the g_steal_pointer() for type-casting from one pointer type to
the other (which also looks quite weird since the local pointers have
all been declared with g_autofree though they are never freed here).
Fix it by using a proper typecast instead. For making this possible, we
have to remove the QEMU_PACKED attribute from some structs since GCC
otherwise complains that the source and destination pointer might
have different alignment restrictions. Removing the QEMU_PACKED should
be fine here since the structs are already naturally aligned. Anyway,
add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
the right sizes (without padding in the structs).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/mem/cxl_type3.c        | 24 ++++++++++++------------
 include/hw/cxl/cxl_cdat.h |  9 ++++++---
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e8801805b9..b679dfae1c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -46,12 +46,12 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
                                           int dsmad_handle, MemoryRegion *mr,
                                           bool is_pmem, uint64_t dpa_base)
 {
-    g_autofree CDATDsmas *dsmas = NULL;
-    g_autofree CDATDslbis *dslbis0 = NULL;
-    g_autofree CDATDslbis *dslbis1 = NULL;
-    g_autofree CDATDslbis *dslbis2 = NULL;
-    g_autofree CDATDslbis *dslbis3 = NULL;
-    g_autofree CDATDsemts *dsemts = NULL;
+    CDATDsmas *dsmas;
+    CDATDslbis *dslbis0;
+    CDATDslbis *dslbis1;
+    CDATDslbis *dslbis2;
+    CDATDslbis *dslbis3;
+    CDATDsemts *dsemts;
 
     dsmas = g_malloc(sizeof(*dsmas));
     *dsmas = (CDATDsmas) {
@@ -135,12 +135,12 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     /* Header always at start of structure */
-    cdat_table[CT3_CDAT_DSMAS] = g_steal_pointer(&dsmas);
-    cdat_table[CT3_CDAT_DSLBIS0] = g_steal_pointer(&dslbis0);
-    cdat_table[CT3_CDAT_DSLBIS1] = g_steal_pointer(&dslbis1);
-    cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
-    cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
-    cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
+    cdat_table[CT3_CDAT_DSMAS] = (CDATSubHeader *)dsmas;
+    cdat_table[CT3_CDAT_DSLBIS0] = (CDATSubHeader *)dslbis0;
+    cdat_table[CT3_CDAT_DSLBIS1] = (CDATSubHeader *)dslbis1;
+    cdat_table[CT3_CDAT_DSLBIS2] = (CDATSubHeader *)dslbis2;
+    cdat_table[CT3_CDAT_DSLBIS3] = (CDATSubHeader *)dslbis3;
+    cdat_table[CT3_CDAT_DSEMTS] = (CDATSubHeader *)dsemts;
 }
 
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
index b44cefaad6..17a09066dc 100644
--- a/include/hw/cxl/cxl_cdat.h
+++ b/include/hw/cxl/cxl_cdat.h
@@ -82,7 +82,8 @@ typedef struct CDATDsmas {
     uint16_t reserved;
     uint64_t DPA_base;
     uint64_t DPA_length;
-} QEMU_PACKED CDATDsmas;
+} CDATDsmas;
+QEMU_BUILD_BUG_ON(sizeof(CDATDsmas) != 24);
 
 /* Device Scoped Latency and Bandwidth Information Structure - CDAT Table 5 */
 typedef struct CDATDslbis {
@@ -95,7 +96,8 @@ typedef struct CDATDslbis {
     uint64_t entry_base_unit;
     uint16_t entry[3];
     uint16_t reserved2;
-} QEMU_PACKED CDATDslbis;
+} CDATDslbis;
+QEMU_BUILD_BUG_ON(sizeof(CDATDslbis) != 24);
 
 /* Device Scoped Memory Side Cache Information Structure - CDAT Table 6 */
 typedef struct CDATDsmscis {
@@ -122,7 +124,8 @@ typedef struct CDATDsemts {
     uint16_t reserved;
     uint64_t DPA_offset;
     uint64_t DPA_length;
-} QEMU_PACKED CDATDsemts;
+} CDATDsemts;
+QEMU_BUILD_BUG_ON(sizeof(CDATDsemts) != 24);
 
 /* Switch Scoped Latency and Bandwidth Information Structure - CDAT Table 9 */
 typedef struct CDATSslbisHeader {
-- 
2.39.2


