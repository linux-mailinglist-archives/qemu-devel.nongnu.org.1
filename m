Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7F7D51CD
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:30:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHFq-00007x-0P; Tue, 24 Oct 2023 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHFf-0007aG-V8
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHFU-0001V0-J1
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0x7e3xlK2kWrRG/MI826k6pyKhvtiFg3nKIHazDXcTY=;
 b=Qbz800DNONZpguCXgcQ72byU6sm5GSvkVrn9FuP+j9emMwx3KHhDZyz+3u25DAouf2LG3f
 5nrg7YjT2Zd+C//WzRZrfY6DniMJltRLWn8PK8OhGoZC9b70dbyoy4xB24kdJNb7T/IKhS
 vWqtlJS0MMhhNmYrrVYrAt61moOfl9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-jbLHcMOoMzqLs3QyJnHMPw-1; Tue, 24 Oct 2023 09:15:03 -0400
X-MC-Unique: jbLHcMOoMzqLs3QyJnHMPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15AE688FC71;
 Tue, 24 Oct 2023 13:15:01 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E25C31C060AE;
 Tue, 24 Oct 2023 13:14:54 +0000 (UTC)
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 16/39] migration: Merge flush_compressed_data() and
 compress_flush_data()
Date: Tue, 24 Oct 2023 15:12:42 +0200
Message-ID: <20231024131305.87468-17-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-11-quintela@redhat.com>
---
 migration/ram-compress.h |  1 -
 migration/ram-compress.c | 17 ++++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 7ba01e2882..e222887fb7 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -59,7 +59,6 @@ typedef struct CompressParam CompressParam;
 void compress_threads_save_cleanup(void);
 int compress_threads_save_setup(void);
 
-void flush_compressed_data(int (send_queued_data(CompressParam *)));
 bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
                                       int (send_queued_data(CompressParam *)));
 
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 1443a1cb45..036e44085b 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -241,10 +241,14 @@ static inline void compress_reset_result(CompressParam *param)
     param->offset = 0;
 }
 
-void flush_compressed_data(int (send_queued_data(CompressParam *)))
+void compress_flush_data(void)
 {
     int thread_count = migrate_compress_threads();
 
+    if (!migrate_compress()) {
+        return;
+    }
+
     qemu_mutex_lock(&comp_done_lock);
     for (int i = 0; i < thread_count; i++) {
         while (!comp_param[i].done) {
@@ -257,7 +261,7 @@ void flush_compressed_data(int (send_queued_data(CompressParam *)))
         qemu_mutex_lock(&comp_param[i].mutex);
         if (!comp_param[i].quit) {
             CompressParam *param = &comp_param[i];
-            send_queued_data(param);
+            compress_send_queued_data(param);
             assert(qemu_file_buffer_empty(param->file));
             compress_reset_result(param);
         }
@@ -558,12 +562,3 @@ void compress_update_rates(uint64_t page_count)
             compression_counters.compressed_size;
     }
 }
-
-void compress_flush_data(void)
-{
-    if (!migrate_compress()) {
-        return;
-    }
-
-    flush_compressed_data(compress_send_queued_data);
-}
-- 
2.41.0


