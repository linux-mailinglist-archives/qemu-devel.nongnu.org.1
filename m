Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C0F774C7A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx2-0007jE-Mg; Tue, 08 Aug 2023 17:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx0-0007ia-T1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:10 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwy-0005x6-Hr
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:10 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-564b8e60ce9so2885600a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528947; x=1692133747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=62eS3zAvxSE4Zm7HV6kd3RVw1vjOHnDGUE6VLCjXmBI=;
 b=MKqVdguXvGKG2SwHzvS9xXJG7KUd+xhRNwgXGALsP0jE+fr3EeDs483Y8x6P4C196W
 cPjDjVCTtm91TyjASvkouuU2Zpu/aKX2/v+zenNTwk5xNN/ZYYkDkWmXyOHTSCz37VIe
 XfnTdcuy493nzujkPqY2CD7Flx6kfSKVFI8lHjtFAd/P8Xup+PeED8zDhlKyzxBrQz3q
 xuTlwEKwGgximjvUsWrt9L3zxkjCo3tVGsvaIyVAQyoeuzn6/bC2Rh4fVXsxTTKE+x2T
 uxN64mk+cmekAI4CVbC6+0wxa5ZufqBPLur2jxu51yQGVVURrVvfSRDb44XoQGlB4AYO
 WHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528947; x=1692133747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62eS3zAvxSE4Zm7HV6kd3RVw1vjOHnDGUE6VLCjXmBI=;
 b=HJq3NZsUWY/e5Ucr5zvJUR2J/vJA9fUCopni4FPv3QT8eqHAeA47Rm63muPnHTBIyA
 pTBtqFcWrdez/TKxLhYGeta3yPeYxi06GrGH+jyTO6t06Lvrklk3FuEf5/zHbbaPs/s/
 3fViAsCXh0mg4bAaXAUP/IlSX6eiR2/3oiZkAjn+zVhaNHH+jl36GmsI9UeYlSUF7K7F
 1XhYRI7PfO0FoToFjS+NWAHk4SMnHnL4SnpsgistRCkyEl878/yf3fph/eoMQ5prz1P2
 Wzq1YQQ1t6t5J+Pw5W0LXfgUIUwtze3PsM9WsWeF+0xXiATGxfZvsE5eb2SRW7ggb2LY
 4lWA==
X-Gm-Message-State: AOJu0YxdLwIcZ7eDu500NDgj1QSXfb/0pEDNvqHzOJPheIB8eZX4GFdU
 DiDKJzOMmfpKzD0yt8L83SDiEYfEScTiVdMEKaA=
X-Google-Smtp-Source: AGHT+IFsms5hmUNsojXj7LQTxqyHkfeCPv6Lw864WTGytdD5OvN2HShcjGQebH6nQ+7ufaCp5i7kZQ==
X-Received: by 2002:a17:90b:1647:b0:259:10a8:2389 with SMTP id
 il7-20020a17090b164700b0025910a82389mr588192pjb.35.1691528947048; 
 Tue, 08 Aug 2023 14:09:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] util/selfmap: Rewrite using qemu/interval-tree.h
Date: Tue,  8 Aug 2023 14:08:52 -0700
Message-Id: <20230808210856.95568-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We will want to be able to search the set of mappings.
For this patch, the two users iterate the tree in order.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/selfmap.h |  22 ++++----
 linux-user/elfload.c   |  14 +++--
 linux-user/syscall.c   |  15 +++---
 util/selfmap.c         | 114 +++++++++++++++++++++++++----------------
 4 files changed, 97 insertions(+), 68 deletions(-)

diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h
index 3479a2a618..7d938945cb 100644
--- a/include/qemu/selfmap.h
+++ b/include/qemu/selfmap.h
@@ -9,9 +9,10 @@
 #ifndef SELFMAP_H
 #define SELFMAP_H
 
+#include "qemu/interval-tree.h"
+
 typedef struct {
-    unsigned long start;
-    unsigned long end;
+    IntervalTreeNode itree;
 
     /* flags */
     bool is_read;
@@ -19,26 +20,25 @@ typedef struct {
     bool is_exec;
     bool is_priv;
 
-    unsigned long offset;
-    gchar *dev;
+    uint64_t offset;
     uint64_t inode;
-    gchar *path;
+    const char *path;
+    char dev[];
 } MapInfo;
 
-
 /**
  * read_self_maps:
  *
- * Read /proc/self/maps and return a list of MapInfo structures.
+ * Read /proc/self/maps and return a tree of MapInfo structures.
  */
-GSList *read_self_maps(void);
+IntervalTreeRoot *read_self_maps(void);
 
 /**
  * free_self_maps:
- * @info: a GSlist
+ * @info: an interval tree
  *
- * Free a list of MapInfo structures.
+ * Free a tree of MapInfo structures.
  */
-void free_self_maps(GSList *info);
+void free_self_maps(IntervalTreeRoot *root);
 
 #endif /* SELFMAP_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e72497c4b4..fb137345f6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2620,7 +2620,8 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
                                long align, uintptr_t offset)
 {
-    GSList *maps, *iter;
+    IntervalTreeRoot *maps;
+    IntervalTreeNode *iter;
     uintptr_t this_start, this_end, next_start, brk;
     intptr_t ret = -1;
 
@@ -2638,12 +2639,15 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
     /* The first hole is before the first map entry. */
     this_start = mmap_min_addr;
 
-    for (iter = maps; iter;
-         this_start = next_start, iter = g_slist_next(iter)) {
+    for (iter = interval_tree_iter_first(maps, 0, -1);
+         iter;
+         this_start = next_start,
+         iter = interval_tree_iter_next(iter, 0, -1)) {
+        MapInfo *info = container_of(iter, MapInfo, itree);
         uintptr_t align_start, hole_size;
 
-        this_end = ((MapInfo *)iter->data)->start;
-        next_start = ((MapInfo *)iter->data)->end;
+        this_end = info->itree.start;
+        next_start = info->itree.last + 1;
         align_start = ROUND_UP(this_start + offset, align);
 
         /* Skip holes that are too small. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7c2c2f6e2f..a15bce2be2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8070,16 +8070,17 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
 {
     CPUState *cpu = env_cpu(cpu_env);
     TaskState *ts = cpu->opaque;
-    GSList *map_info = read_self_maps();
-    GSList *s;
+    IntervalTreeRoot *map_info = read_self_maps();
+    IntervalTreeNode *s;
     int count;
 
-    for (s = map_info; s; s = g_slist_next(s)) {
-        MapInfo *e = (MapInfo *) s->data;
+    for (s = interval_tree_iter_first(map_info, 0, -1); s;
+         s = interval_tree_iter_next(s, 0, -1)) {
+        MapInfo *e = container_of(s, MapInfo, itree);
 
-        if (h2g_valid(e->start)) {
-            unsigned long min = e->start;
-            unsigned long max = e->end;
+        if (h2g_valid(e->itree.start)) {
+            unsigned long min = e->itree.start;
+            unsigned long max = e->itree.last + 1;
             int flags = page_get_flags(h2g(min));
             const char *path;
 
diff --git a/util/selfmap.c b/util/selfmap.c
index 2c14f019ce..4db5b42651 100644
--- a/util/selfmap.c
+++ b/util/selfmap.c
@@ -10,74 +10,98 @@
 #include "qemu/cutils.h"
 #include "qemu/selfmap.h"
 
-GSList *read_self_maps(void)
+IntervalTreeRoot *read_self_maps(void)
 {
-    gchar *maps;
-    GSList *map_info = NULL;
+    IntervalTreeRoot *root;
+    gchar *maps, **lines;
+    guint i, nlines;
 
-    if (g_file_get_contents("/proc/self/maps", &maps, NULL, NULL)) {
-        gchar **lines = g_strsplit(maps, "\n", 0);
-        int i, entries = g_strv_length(lines);
+    if (!g_file_get_contents("/proc/self/maps", &maps, NULL, NULL)) {
+        return NULL;
+    }
 
-        for (i = 0; i < entries; i++) {
-            gchar **fields = g_strsplit(lines[i], " ", 6);
-            if (g_strv_length(fields) > 4) {
-                MapInfo *e = g_new0(MapInfo, 1);
-                int errors = 0;
-                const char *end;
+    root = g_new0(IntervalTreeRoot, 1);
+    lines = g_strsplit(maps, "\n", 0);
+    nlines = g_strv_length(lines);
 
-                errors |= qemu_strtoul(fields[0], &end, 16, &e->start);
-                errors |= qemu_strtoul(end + 1, NULL, 16, &e->end);
+    for (i = 0; i < nlines; i++) {
+        gchar **fields = g_strsplit(lines[i], " ", 6);
+        guint nfields = g_strv_length(fields);
+
+        if (nfields > 4) {
+            uint64_t start, end, offset, inode;
+            int errors = 0;
+            const char *p;
+
+            errors |= qemu_strtou64(fields[0], &p, 16, &start);
+            errors |= qemu_strtou64(p + 1, NULL, 16, &end);
+            errors |= qemu_strtou64(fields[2], NULL, 16, &offset);
+            errors |= qemu_strtou64(fields[4], NULL, 10, &inode);
+
+            if (!errors) {
+                size_t dev_len, path_len;
+                MapInfo *e;
+
+                dev_len = strlen(fields[3]) + 1;
+                if (nfields == 6) {
+                    p = fields[5];
+                    p += strspn(p, " ");
+                    path_len = strlen(p) + 1;
+                } else {
+                    p = NULL;
+                    path_len = 0;
+                }
+
+                e = g_malloc0(sizeof(*e) + dev_len + path_len);
+
+                e->itree.start = start;
+                e->itree.last = end - 1;
+                e->offset = offset;
+                e->inode = inode;
 
                 e->is_read  = fields[1][0] == 'r';
                 e->is_write = fields[1][1] == 'w';
                 e->is_exec  = fields[1][2] == 'x';
                 e->is_priv  = fields[1][3] == 'p';
 
-                errors |= qemu_strtoul(fields[2], NULL, 16, &e->offset);
-                e->dev = g_strdup(fields[3]);
-                errors |= qemu_strtou64(fields[4], NULL, 10, &e->inode);
-
-                if (!errors) {
-                    /*
-                     * The last field may have leading spaces which we
-                     * need to strip.
-                     */
-                    if (g_strv_length(fields) == 6) {
-                        e->path = g_strdup(g_strchug(fields[5]));
-                    }
-                    map_info = g_slist_prepend(map_info, e);
-                } else {
-                    g_free(e->dev);
-                    g_free(e);
+                memcpy(e->dev, fields[3], dev_len);
+                if (path_len) {
+                    e->path = memcpy(e->dev + dev_len, p, path_len);
                 }
+
+                interval_tree_insert(&e->itree, root);
             }
-
-            g_strfreev(fields);
         }
-        g_strfreev(lines);
-        g_free(maps);
+        g_strfreev(fields);
     }
+    g_strfreev(lines);
+    g_free(maps);
 
-    /* ensure the map data is in the same order we collected it */
-    return g_slist_reverse(map_info);
+    return root;
 }
 
 /**
  * free_self_maps:
- * @info: a GSlist
+ * @root: an interval tree
  *
- * Free a list of MapInfo structures.
+ * Free a tree of MapInfo structures.
+ * Since we allocated each MapInfo in one chunk, we need not consider the
+ * contents and can simply free each RBNode.
  */
-static void free_info(gpointer data)
+
+static void free_rbnode(RBNode *n)
 {
-    MapInfo *e = (MapInfo *) data;
-    g_free(e->dev);
-    g_free(e->path);
-    g_free(e);
+    if (n) {
+        free_rbnode(n->rb_left);
+        free_rbnode(n->rb_right);
+        g_free(n);
+    }
 }
 
-void free_self_maps(GSList *info)
+void free_self_maps(IntervalTreeRoot *root)
 {
-    g_slist_free_full(info, &free_info);
+    if (root) {
+        free_rbnode(root->rb_root.rb_node);
+        g_free(root);
+    }
 }
-- 
2.34.1


