Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A37D5155
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:20:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHFj-0007I8-U7; Tue, 24 Oct 2023 09:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHFG-0005yI-A3
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHF0-0001Gw-N8
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v07XEObK+8HRkY6PIJKRF8OCoGMMogRwRKEZtGkEDCc=;
 b=LE3ENPQnE8fGarfeMahg/UYjEWS2RfBK2hdBkYwKPTnxRYwdsa7xyn9HMSrq+BD8w/yPsb
 HqQCBSLjyzV+4lxCRbgmTVk5gao7sAE+h6vYV3OHD4XrtPL455pO1CGyyeKVq/zi6oh6Ni
 0LVJMKKmUqZHDi41or3u/wXfw95lLfw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-nZAzMYCaPfWnk0UUY_Q8AQ-1; Tue, 24 Oct 2023 09:14:29 -0400
X-MC-Unique: nZAzMYCaPfWnk0UUY_Q8AQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0E983C1ACD6;
 Tue, 24 Oct 2023 13:14:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 653D31C060AE;
 Tue, 24 Oct 2023 13:14:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 11/39] migration: Simplify compress_page_with_multithread()
Date: Tue, 24 Oct 2023 15:12:37 +0200
Message-ID: <20231024131305.87468-12-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-6-quintela@redhat.com>
---
 migration/ram-compress.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index ef03d60a6d..a991b15b7a 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -271,35 +271,35 @@ bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
 
     thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
-retry:
-    for (int i = 0; i < thread_count; i++) {
-        if (comp_param[i].done) {
-            CompressParam *param = &comp_param[i];
-            qemu_mutex_lock(&param->mutex);
-            param->done = false;
-            send_queued_data(param);
-            assert(qemu_file_buffer_empty(param->file));
-            compress_reset_result(param);
-            set_compress_params(param, block, offset);
 
-            qemu_cond_signal(&param->cond);
-            qemu_mutex_unlock(&param->mutex);
+    while (true) {
+        for (int i = 0; i < thread_count; i++) {
+            if (comp_param[i].done) {
+                CompressParam *param = &comp_param[i];
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
2.41.0


