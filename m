Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C7AA51E3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 18:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAXx-0000a7-3v; Wed, 30 Apr 2025 12:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uAAXk-0000Uj-S7
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:44:21 -0400
Received: from out28-49.mail.aliyun.com ([115.124.28.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uAAXf-0001Lr-4S
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:44:19 -0400
Received: from localhost.localdomain(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.ccBcTfA_1746031447 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 01 May 2025 00:44:07 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, armbru@redhat.com, balaton@eik.bme.hu
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, lc00631@tecorigin.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 1/1] system: improve visual representation of node hierarchy
Date: Thu,  1 May 2025 00:43:46 +0800
Message-ID: <da49dd02e3aedb6ef4a0be5e8686abdd58d8df24.1746031192.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <cover.1746031192.git.lc00631@tecorigin.com>
References: <cover.1746031192.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.49; envelope-from=lc00631@tecorigin.com;
 helo=out28-49.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Make the hierarchical relationship between nodes clearer by adding characters.

e.g.

```
$ qemu-system-riscv64 -M virt -monitor stdio -display none

(qemu) info mtree

...
address-space: memory
`-- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
    |-- 0000000000001000-000000000000ffff (prio 0, rom): riscv_virt_board.mrom
...
    |-- 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
    |   `-- 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
    |-- 0000000004000000-0000000005ffffff (prio 0, i/o): platform bus
...
    |-- 0000000080000000-0000000087ffffff (prio 0, ram): riscv_virt_board.ram
    `-- 0000000400000000-00000007ffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio_window
```

Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
---
 system/memory.c | 122 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 11 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 71434e7ad0..ec40ef09aa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3283,10 +3283,20 @@ static const char *memory_region_type(MemoryRegion *mr)
     }
 }
 
+typedef struct PrintCol PrintCol;
+
+struct PrintCol {
+    bool print_col;
+    QTAILQ_ENTRY(PrintCol) queue;
+};
+
+typedef QTAILQ_HEAD(, PrintCol) PrintColHead;
+
 typedef struct MemoryRegionList MemoryRegionList;
 
 struct MemoryRegionList {
     const MemoryRegion *mr;
+    PrintColHead *col_string;
     QTAILQ_ENTRY(MemoryRegionList) mrqueue;
 };
 
@@ -3296,6 +3306,94 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
+static void mtree_print_col(PrintColHead *col_string, unsigned int level)
+{
+    PrintCol *col = NULL;
+    int i = 0;
+
+    /* Level 0 always has not a col. */
+    if (level == 0 || col_string == NULL) {
+        return;
+    }
+
+    /*
+     * If the parent node is not a tail node,
+     * print a column at the corresponding level.
+     */
+    if (col_string != NULL) {
+        QTAILQ_FOREACH(col, col_string, queue) {
+            if (i++ == level) {
+                break;
+            }
+        }
+    }
+
+    if (col != NULL && col->print_col) {
+        qemu_printf("|");
+    } else {
+        qemu_printf(" ");
+    }
+
+    /* Align with the first character of the parent node. */
+    qemu_printf("   ");
+}
+
+static void mtree_print_node(bool is_tail)
+{
+    if (is_tail) {
+        qemu_printf("`-- ");
+    } else {
+        qemu_printf("|-- ");
+    }
+}
+
+static void mtree_print_head(PrintColHead *col_string, unsigned int level,
+                             bool is_tail)
+{
+    for (int i = 0; i < level; i++) {
+        mtree_print_col(col_string, i);
+    }
+    mtree_print_node(is_tail);
+}
+
+static PrintColHead *mtree_col_string_new(PrintColHead *col_string, int level,
+                                          bool is_tail)
+{
+    PrintColHead *new_col_string = g_new(PrintColHead, 1);
+    PrintCol *col, *new_col;
+    int i = 0;
+
+    QTAILQ_INIT(new_col_string);
+    if (col_string != NULL) {
+        QTAILQ_FOREACH(col, col_string, queue) {
+            new_col = g_new(PrintCol, 1);
+            new_col->print_col = col->print_col;
+            QTAILQ_INSERT_TAIL(new_col_string, new_col, queue);
+            i++;
+        }
+    } else {
+        new_col = g_new(PrintCol, 1);
+        new_col->print_col = true;
+        QTAILQ_INSERT_TAIL(new_col_string, new_col, queue);
+        i++;
+    }
+    for (; i < level; i++) {
+        new_col = g_new(PrintCol, 1);
+        new_col->print_col = ((i == (level - 1)) && is_tail) ? false : true;
+        QTAILQ_INSERT_TAIL(new_col_string, new_col, queue);
+    }
+    return new_col_string;
+}
+
+static void mtree_col_string_free(PrintColHead *col_string)
+{
+    PrintCol *col, *next_col;
+    QTAILQ_FOREACH_SAFE(col, col_string, queue, next_col) {
+        g_free(col);
+    }
+    g_free(col_string);
+}
+
 static void mtree_expand_owner(const char *label, Object *obj)
 {
     DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
@@ -3335,12 +3433,13 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
-                           bool owner, bool display_disabled)
+                           bool owner, bool display_disabled,
+                           PrintColHead *col_string,
+                           bool is_tail)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
     const MemoryRegion *submr;
-    unsigned int i;
     hwaddr cur_start, cur_end;
 
     if (!mr) {
@@ -3375,9 +3474,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
         }
         if (mr->enabled || display_disabled) {
-            for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
-            }
+            mtree_print_head(col_string, level, is_tail);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
                         "-" HWADDR_FMT_plx "%s",
@@ -3397,9 +3494,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         }
     } else {
         if (mr->enabled || display_disabled) {
-            for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
-            }
+            mtree_print_head(col_string, level, is_tail);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): %s%s",
                         cur_start, cur_end,
@@ -3420,6 +3515,8 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
         new_ml = g_new(MemoryRegionList, 1);
         new_ml->mr = submr;
+        new_ml->col_string = mtree_col_string_new(col_string,
+                                                  level + 1, is_tail);
         QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
             if (new_ml->mr->addr < ml->mr->addr ||
                 (new_ml->mr->addr == ml->mr->addr &&
@@ -3436,10 +3533,12 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(ml->mr, level + 1, cur_start,
-                       alias_print_queue, owner, display_disabled);
+                       alias_print_queue, owner, display_disabled,
+                       ml->col_string, ml == QTAILQ_LAST(&submr_print_queue));
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
+        mtree_col_string_free(ml->col_string);
         g_free(ml);
     }
 }
@@ -3614,7 +3713,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     struct AddressSpaceInfo *asi = user_data;
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
+    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
+                   NULL, true);
     qemu_printf("\n");
 }
 
@@ -3659,7 +3759,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled, NULL, true);
         qemu_printf("\n");
     }
 
-- 
2.48.1


