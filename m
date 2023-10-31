Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4517DC909
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxke0-0000hn-L8; Tue, 31 Oct 2023 05:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdx-0000Vo-8R
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdv-0006tw-6u
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0x7e3xlK2kWrRG/MI826k6pyKhvtiFg3nKIHazDXcTY=;
 b=hY4uy2yqOsaXfLSpdw4nnWIigpB7utQqW7NhYaAnEn3l+mA2pMoK+rCsOciuqlZqSqH1sf
 lAwCyFGQG0/nsZg155yBfBTa4k1JyLTRztAn/4XnZ2ywF15G4TmAkuj+0k0kzpnlSh254K
 KihCYqHQ0+vMr4U5MM1hjeja+Di0F1A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-zJYS-2f8PhqjVimWiD5W9w-1; Tue,
 31 Oct 2023 05:02:31 -0400
X-MC-Unique: zJYS-2f8PhqjVimWiD5W9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C11B29AB3E9;
 Tue, 31 Oct 2023 09:02:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4C0E1C060AE;
 Tue, 31 Oct 2023 09:02:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 16/38] migration: Merge flush_compressed_data() and
 compress_flush_data()
Date: Tue, 31 Oct 2023 10:01:20 +0100
Message-ID: <20231031090142.13122-17-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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


