Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E772E698
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TY-0006El-1d; Tue, 13 Jun 2023 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TN-0006AC-D6
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TL-0007YC-6y
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QaxHG+LmfAB5VqZ9Nwjn2fcIfi43u55saowATej41Q=;
 b=gGcAlaM+9GsqPuXo2VjJ9HkhDYn43Eec/fY6HGEsVWE0MLgXilz7RgbzIsTrNb6JXNRD+A
 iaXbvtyBd9wwtloZdWOO68iHCcmpcHn39Tg6AsOQf+pUCmFqDhquyN4Do6+zf2UeA15/Zi
 KemWuWINox3hJqG2A+c3qChpcNi0OVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-iEnqKrlHMbiKq9Ffol3Yhw-1; Tue, 13 Jun 2023 10:58:13 -0400
X-MC-Unique: iEnqKrlHMbiKq9Ffol3Yhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1352D101A531;
 Tue, 13 Jun 2023 14:58:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 278BB40C6F5E;
 Tue, 13 Jun 2023 14:58:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 10/18] migration: Simplify compress_page_with_multithread()
Date: Tue, 13 Jun 2023 16:57:49 +0200
Message-Id: <20230613145757.10131-11-quintela@redhat.com>
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

Move the goto to a while true.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 8ce9519f3d..3c44803132 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -273,35 +273,35 @@ bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
 
     thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
-retry:
-    for (idx = 0; idx < thread_count; idx++) {
-        if (comp_param[idx].done) {
-            CompressParam *param = &comp_param[idx];
-            qemu_mutex_lock(&param->mutex);
-            param->done = false;
-            send_queued_data(param);
-            assert(qemu_file_buffer_empty(param->file));
-            compress_reset_result(param);
-            set_compress_params(param, block, offset);
 
-            qemu_cond_signal(&param->cond);
-            qemu_mutex_unlock(&param->mutex);
+    while (true) {
+        for (idx = 0; idx < thread_count; idx++) {
+            if (comp_param[idx].done) {
+                CompressParam *param = &comp_param[idx];
+                qemu_mutex_lock(&param->mutex);
+                param->done = false;
+                send_queued_data(param);
+                assert(qemu_file_buffer_empty(param->file));
+                compress_reset_result(param);
+                set_compress_params(param, block, offset);
+
+                qemu_cond_signal(&param->cond);
+                qemu_mutex_unlock(&param->mutex);
+                qemu_mutex_unlock(&comp_done_lock);
+                return true;
+            }
+        }
+        if (!wait) {
             qemu_mutex_unlock(&comp_done_lock);
-            return true;
+            return false;
         }
-    }
-
-    /*
-     * wait for the free thread if the user specifies 'compress-wait-thread',
-     * otherwise we will post the page out in the main thread as normal page.
-     */
-    if (wait) {
+        /*
+         * wait for a free thread if the user specifies
+         * 'compress-wait-thread', otherwise we will post the page out
+         * in the main thread as normal page.
+         */
         qemu_cond_wait(&comp_done_cond, &comp_done_lock);
-        goto retry;
     }
-    qemu_mutex_unlock(&comp_done_lock);
-
-    return false;
 }
 
 /* return the size after decompression, or negative value on error */
-- 
2.40.1


