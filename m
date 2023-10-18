Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAA7CD8D6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SS-0007Oi-Tf; Wed, 18 Oct 2023 06:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SI-0007KE-5o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SG-0007hr-KN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCGJQvOCu7A2qX3UOqMVZfOl937f9UXrXJsie5U+qEI=;
 b=OWjgGBbUXmxxQNpcJ1X5eL0zT6k96KWHP1FSh1PpnigBhYJ2Cldlizx5uDD+gH3sdCQHlL
 cyjxc+7tDQvUqDPQovW6j6JDoTpfbNKOu9abJEOkWVt9nA+WHfGDIt9YngEvtICU+wMoDU
 aXyxEONSR4J5ZrI7HUubZmG96vKbvUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-A0dKqo4rOU6wyCFi-2HfaQ-1; Wed, 18 Oct 2023 06:07:02 -0400
X-MC-Unique: A0dKqo4rOU6wyCFi-2HfaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A7F787A9F4;
 Wed, 18 Oct 2023 10:07:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81A632026D68;
 Wed, 18 Oct 2023 10:07:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 07/11] migration: Use "i" as an for index in ram-compress.c
Date: Wed, 18 Oct 2023 12:06:47 +0200
Message-ID: <20231018100651.32674-8-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

It is used everywhere else in C.  Once there, make sure that we don't
use the index outside of the for declaring the variable there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20230613145757.10131-15-quintela@redhat.com>
---
 migration/ram-compress.c | 56 ++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 95a8d6b906..d037dfe6cf 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -230,27 +230,25 @@ static inline void compress_reset_result(CompressParam *param)
 
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
 
@@ -265,15 +263,15 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
 int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
                                 int (send_queued_data(CompressParam *)))
 {
-    int idx, thread_count, pages = -1;
+    int  thread_count, pages = -1;
     bool wait = migrate_compress_wait_thread();
 
     thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
 retry:
-    for (idx = 0; idx < thread_count; idx++) {
-        if (comp_param[idx].done) {
-            CompressParam *param = &comp_param[idx];
+    for (int i = 0; i < thread_count; i++) {
+        if (comp_param[i].done) {
+            CompressParam *param = &comp_param[i];
             qemu_mutex_lock(&param->mutex);
             param->done = false;
             send_queued_data(param);
@@ -367,16 +365,14 @@ static void *do_data_decompress(void *opaque)
 
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
@@ -467,20 +463,18 @@ exit:
 
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
2.41.0


