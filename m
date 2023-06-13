Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B0672E68F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TX-0006Ea-Jf; Tue, 13 Jun 2023 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TR-0006Av-1S
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TP-0007Zb-C8
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulfFLbOBAIT59r7Ub4yug/+2xRy7DXVbPJWIbgsules=;
 b=CF0HhMP4wDZk8I0oS1yF7nYZILvEp9r2HClRih7Q5LIkNcgciuPTnhPLNolavAPseNg9ew
 KbAvVdln297Ont92eFl4UZALc0cFzpz1+9cbJ7sNaVrhKWzc9yu3KwRbdmfCHWRWnrJNGp
 mdYIYKaMNuBq9DjmLpxWIyJYEuME8JE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-mtmIHWMxNmWKhxC9xjcQNw-1; Tue, 13 Jun 2023 10:58:17 -0400
X-MC-Unique: mtmIHWMxNmWKhxC9xjcQNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E64F23855561;
 Tue, 13 Jun 2023 14:58:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 042DA40C6F5C;
 Tue, 13 Jun 2023 14:58:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 14/18] migration: Use "i" as an for index in ram-compress.c
Date: Tue, 13 Jun 2023 16:57:53 +0200
Message-Id: <20230613145757.10131-15-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is used everywhere else in C.  Once there, make sure that we don't
use the index outside of the for declaring the variable there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.c | 57 ++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index cf3a6c238d..a23531606e 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -243,27 +243,25 @@ static inline void compress_reset_result(CompressParam *param)
 
 void flush_compressed_data(int (send_queued_data(CompressParam *)))
 {
-    int idx, thread_count;
-
-    thread_count = migrate_compress_threads();
+    int thread_count = migrate_compress_threads();
 
     qemu_mutex_lock(&comp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        while (!comp_param[idx].done) {
+    for (int i = 0; i < thread_count; i++) {
+        while (!comp_param[i].done) {
             qemu_cond_wait(&comp_done_cond, &comp_done_lock);
         }
     }
     qemu_mutex_unlock(&comp_done_lock);
 
-    for (idx = 0; idx < thread_count; idx++) {
-        qemu_mutex_lock(&comp_param[idx].mutex);
-        if (!comp_param[idx].quit) {
-            CompressParam *param = &comp_param[idx];
+    for (int i = 0; i < thread_count; i++) {
+        qemu_mutex_lock(&comp_param[i].mutex);
+        if (!comp_param[i].quit) {
+            CompressParam *param = &comp_param[i];
             send_queued_data(param);
             assert(qemu_file_buffer_empty(param->file));
             compress_reset_result(param);
         }
-        qemu_mutex_unlock(&comp_param[idx].mutex);
+        qemu_mutex_unlock(&comp_param[i].mutex);
     }
 }
 
@@ -281,16 +279,15 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
 bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
                                      int (send_queued_data(CompressParam *)))
 {
-    int idx, thread_count;
     bool wait = migrate_compress_wait_thread();
 
-    thread_count = migrate_compress_threads();
+    int thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
 
     while (true) {
-        for (idx = 0; idx < thread_count; idx++) {
-            if (comp_param[idx].done) {
-                CompressParam *param = &comp_param[idx];
+        for (int i = 0; i < thread_count; i++) {
+            if (comp_param[i].done) {
+                CompressParam *param = &comp_param[i];
                 qemu_mutex_lock(&param->mutex);
                 param->done = false;
                 send_queued_data(param);
@@ -384,16 +381,14 @@ static void *do_data_decompress(void *opaque)
 
 int wait_for_decompress_done(void)
 {
-    int idx, thread_count;
-
     if (!migrate_compress()) {
         return 0;
     }
 
-    thread_count = migrate_decompress_threads();
+    int thread_count = migrate_decompress_threads();
     qemu_mutex_lock(&decomp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        while (!decomp_param[idx].done) {
+    for (int i = 0; i < thread_count; i++) {
+        while (!decomp_param[i].done) {
             qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
         }
     }
@@ -484,20 +479,18 @@ exit:
 
 void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
 {
-    int idx, thread_count;
-
-    thread_count = migrate_decompress_threads();
+    int thread_count = migrate_decompress_threads();
     QEMU_LOCK_GUARD(&decomp_done_lock);
     while (true) {
-        for (idx = 0; idx < thread_count; idx++) {
-            if (decomp_param[idx].done) {
-                decomp_param[idx].done = false;
-                qemu_mutex_lock(&decomp_param[idx].mutex);
-                qemu_get_buffer(f, decomp_param[idx].compbuf, len);
-                decomp_param[idx].des = host;
-                decomp_param[idx].len = len;
-                qemu_cond_signal(&decomp_param[idx].cond);
-                qemu_mutex_unlock(&decomp_param[idx].mutex);
+        for (int i = 0; i < thread_count; i++) {
+            if (decomp_param[i].done) {
+                decomp_param[i].done = false;
+                qemu_mutex_lock(&decomp_param[i].mutex);
+                qemu_get_buffer(f, decomp_param[i].compbuf, len);
+                decomp_param[i].des = host;
+                decomp_param[i].len = len;
+                qemu_cond_signal(&decomp_param[i].cond);
+                qemu_mutex_unlock(&decomp_param[i].mutex);
                 return;
             }
         }
-- 
2.40.1


