Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68239A75D41
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Mar 2025 00:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz1FE-0003oE-0x; Sun, 30 Mar 2025 18:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tz1Ex-0003nq-4r; Sun, 30 Mar 2025 18:34:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tz1Ev-0002Jh-4v; Sun, 30 Mar 2025 18:34:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9BA9E4E6041;
 Mon, 31 Mar 2025 00:34:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rA3qO74CbdBC; Mon, 31 Mar 2025 00:34:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 930724E6036; Mon, 31 Mar 2025 00:34:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ppc/vof: Make nextprop behave more like Open Firmware
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20250330223442.930724E6036@zero.eik.bme.hu>
Date: Mon, 31 Mar 2025 00:34:42 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The FDT does not normally store name properties but reconsrtucts it
from path but each node in Open Firmware should at least have this
property. This is correctly handled in getprop but nextprop should
also return it even if not present as a property. This patch fixes
that and also skips phandle which does not appear in Open Firmware
and only added for internal use by VOF.

Explicit name properties are still allowed because they are needed
e.g. on the root node that guests expect to have specific names as
seen on real machines instead of being empty so sometimes the node
name may need to be overriden.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
I've tested this with pegasos2 but don't know how to test spapr.

 hw/ppc/vof.c | 56 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 09cb77de93..2c00d11521 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -353,34 +353,60 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
 {
     int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
     char prev[OF_PROPNAME_LEN_MAX + 1];
-    const char *tmp;
+    const char *tmp = NULL;
 
     if (readstr(prevaddr, prev, sizeof(prev))) {
         return PROM_ERROR;
     }
-
-    fdt_for_each_property_offset(offset, fdt, nodeoff) {
-        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
-            return 0;
+    /*
+     * "name" may or may not be present in fdt but we should still return it.
+     * Do that first and then skip it if seen later. Also skip phandle which is
+     * an internal value we added in vof_build_dt but should not appear here.
+     */
+    if (prev[0] == '\0') {
+        tmp = "name";
+    } else {
+        if (strcmp(prev, "name") == 0) {
+            prev[0] = '\0';
         }
-        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
-            if (prev[0] != '\0') {
+        fdt_for_each_property_offset(offset, fdt, nodeoff) {
+            if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
+                return 0;
+            }
+            if (strcmp(tmp, "name") == 0 || strcmp(tmp, "phandle") == 0) {
+                continue;
+            }
+            if (prev[0] == '\0') {
+                break;
+            }
+            if (strcmp(prev, tmp) == 0) {
                 offset = fdt_next_property_offset(fdt, offset);
-                if (offset < 0) {
-                    return 0;
-                }
+                break;
             }
+        }
+        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
+            return 0;
+        }
+        if (strcmp(tmp, "name") == 0 || strcmp(tmp, "phandle") == 0) {
+            offset = fdt_next_property_offset(fdt, offset);
             if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
                 return 0;
             }
-
-            if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
-                return PROM_ERROR;
+        }
+        /* name and phandle can follow each other so check again */
+        if (strcmp(tmp, "name") == 0 || strcmp(tmp, "phandle") == 0) {
+            offset = fdt_next_property_offset(fdt, offset);
+            if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
+                return 0;
             }
-            return 1;
         }
     }
-
+    if (tmp) {
+        if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
+            return PROM_ERROR;
+        }
+        return 1;
+    }
     return 0;
 }
 
-- 
2.41.3


