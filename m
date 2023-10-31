Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A5A7DC910
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdx-0000Sv-Eh; Tue, 31 Oct 2023 05:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdr-0000LM-M2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdq-0006tD-5R
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N9eMhXSGAX5ioZRsrn869KMrCb4AUfc/pU+hNfVZPk=;
 b=GTyYDkdhQBIugGAE1Qi5D/x2XQrGkn1k/Wynbz5rwzolOzP/Fz0RD4wlWYeDfVa7HuT8wf
 Gkhb/ghBQiusgqu5XsJawyx4PTRhoA0jC9irNJQmaTem+OjPeLV7glfIRx3GoKn2cJE7P1
 NlcXXzMupqk15LzoervWP3Z36HiwSTI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-avwqIWeLP32wDgxj6sFxNQ-1; Tue,
 31 Oct 2023 05:02:26 -0400
X-MC-Unique: avwqIWeLP32wDgxj6sFxNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF9A91C060CC;
 Tue, 31 Oct 2023 09:02:25 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 526C11C060AE;
 Tue, 31 Oct 2023 09:02:23 +0000 (UTC)
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
Subject: [PULL 14/38] migration: Export send_queued_data()
Date: Tue, 31 Oct 2023 10:01:18 +0100
Message-ID: <20231031090142.13122-15-quintela@redhat.com>
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

This function is only used for compression.  So we rename it as
compress_send_queued_data().  We put it on ram-compress.h because we
are moving it later to ram-compress.c.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-9-quintela@redhat.com>
---
 migration/ram-compress.h | 1 +
 migration/ram.c          | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 76dacd3ec7..636281ed97 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -72,5 +72,6 @@ void populate_compress(MigrationInfo *info);
 uint64_t ram_compressed_pages(void);
 void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
 void compress_update_rates(uint64_t page_count);
+int compress_send_queued_data(CompressParam *param);
 
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index f7daf2226e..b6d485358e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1264,7 +1264,7 @@ static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
     return 1;
 }
 
-static int send_queued_data(CompressParam *param)
+int compress_send_queued_data(CompressParam *param)
 {
     PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_PRECOPY];
     MigrationState *ms = migrate_get_current();
@@ -1306,7 +1306,7 @@ static void ram_flush_compressed_data(void)
         return;
     }
 
-    flush_compressed_data(send_queued_data);
+    flush_compressed_data(compress_send_queued_data);
 }
 
 #define PAGE_ALL_CLEAN 0
@@ -2041,7 +2041,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
     }
 
     return compress_page_with_multi_thread(pss->block, offset,
-                                           send_queued_data);
+                                           compress_send_queued_data);
 }
 
 /**
-- 
2.41.0


