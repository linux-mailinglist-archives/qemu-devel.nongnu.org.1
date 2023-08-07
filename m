Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EB772B24
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:38:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EW-0007GK-BB; Mon, 07 Aug 2023 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EM-00075n-R0
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EK-0002hn-Te
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso41463835ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426235; x=1692031035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIhYglDsXCnrxRsjPebomm6uEmgGkuEHTNX79IYUpQ8=;
 b=CFSdv7OTnz6coMmJysSXHW+L9LcNUwG2eheyvoGpLwP075NWHsocWBP+TxlPNmRfND
 fH2OfoF8A69NuALMyoJpysW0ihECO1W9r4TEsqR4qjDDHEgdGvZNfJdqCImnoqmClzKU
 +agwVrCBcO8SkVp8f/QQUNDMUvB8ZAVoXoAyBcJRXHdIdk4ezLxDbsRWLjpOwZUefSTL
 E9xLD+x14EOI87/TQqqhCXQqxNsTjcKiNES2o0Y/BrWX56IcIS0QmAg8EM/HC2Bc+Luy
 Cz0jnerKquRW/7iGd8lXOTrjGNgr5GXEfzT4TfgMfcghR4rQHqUqJzB5ShCxWRFO319U
 5wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426235; x=1692031035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIhYglDsXCnrxRsjPebomm6uEmgGkuEHTNX79IYUpQ8=;
 b=JM4h7FSONMYLbUhw4G91BHBgNrllEhFVj0LEz5meVYeb1kRK7yQpMBAKr1U6mgGMZP
 4/NY70/RS5jJ9Pv/hH7G3p7MR8JJ2vmBh5i1QhTtPx9EWWOR+snEsOBHU+uLtRS/B4qB
 spX4ZrbV5nW6H5oD5bCNhurQDd8CqsaPHd+42lxo41gHo9ppt6EXmBMZiMhEZj54pAI8
 ZddPbQYVEln2zEo9VyjLbWCYjWLsoktn6aBUrwfzXj67zbIRYGv5UR2naJCunSubj/H2
 WuDarzhI+wchgN0tPwdv216E63QsdCTCRjucR9iteuDPWRH3cTDdDcDuHcTYzjPTfOLI
 uxrw==
X-Gm-Message-State: AOJu0Yy0uQTuyFmK53YY8cr5KfZUGNhd3LQ5Z6frjnyqKndpkzM0bxnI
 YnqU6qytgcbnu772mi4pDfZCKmOHjKg15knqGWY=
X-Google-Smtp-Source: AGHT+IHgcfqBp7ctiTPmappux3fvYME83ZCT9v/S1E9iMI72P4lQzZtOJ2ztoLCAGsS6DfBAaSaiTQ==
X-Received: by 2002:a17:902:f545:b0:1bc:c82:9368 with SMTP id
 h5-20020a170902f54500b001bc0c829368mr11947086plf.32.1691426235629; 
 Mon, 07 Aug 2023 09:37:15 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 10/14] util/selfmap: Rewrite using
 qemu/interval-tree.h
Date: Mon,  7 Aug 2023 09:37:01 -0700
Message-Id: <20230807163705.9848-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 include/qemu/selfmap.h |  20 ++++----
 linux-user/elfload.c   |  14 +++--
 linux-user/syscall.c   |  15 +++---
 util/selfmap.c         | 114 +++++++++++++++++++++++++----------------
 4 files changed, 96 insertions(+), 67 deletions(-)

diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h
index 3479a2a618..aacd6ae0a0 100644
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
  * Read /proc/self/maps and return a list of MapInfo structures.
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
index c9e176a9f6..f497286abe 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2622,7 +2622,8 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
                                long align, uintptr_t offset)
 {
-    GSList *maps, *iter;
+    IntervalTreeRoot *maps;
+    IntervalTreeNode *iter;
     uintptr_t this_start, this_end, next_start, brk;
     intptr_t ret = -1;
 
@@ -2640,12 +2641,15 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
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


