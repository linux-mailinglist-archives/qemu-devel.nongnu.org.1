Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E17CD8D1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SS-0007Nm-6w; Wed, 18 Oct 2023 06:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SD-0007Jc-Im
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SC-0007hK-3b
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W++ajcK7fgiPCIGUAuQd8IzWsfP7zvy+tx3A9hVeJu8=;
 b=FN9uXgHmoVXxS0svi5A4gAqajVSExm/DyJmsIbaPD6H2teHH8JYiJ8qkO+NWvO1cBy/NE4
 klf5bZIdH9ZIYegSpbbqhKvGq3H0+r7d5AcncoqoQ4wpvqZ5KcrY8UdTdUDMx6SQScCIB5
 LwS6FzGlJIiXsebYDY35TwyIGJv3TCo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-ebSyCnInPXabouYSxQTHhQ-1; Wed, 18 Oct 2023 06:06:58 -0400
X-MC-Unique: ebSyCnInPXabouYSxQTHhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ADB61C05AB2;
 Wed, 18 Oct 2023 10:06:58 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 831B32026D4C;
 Wed, 18 Oct 2023 10:06:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 04/11] migration: Create ram_compressed_pages()
Date: Wed, 18 Oct 2023 12:06:44 +0200
Message-ID: <20231018100651.32674-5-quintela@redhat.com>
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20230613145757.10131-8-quintela@redhat.com>
---
 migration/ram-compress.h | 1 +
 migration/ram-compress.c | 6 ++++++
 migration/ram.c          | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 43ff44c0ba..77465dad4b 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -69,5 +69,6 @@ int compress_threads_load_setup(QEMUFile *f);
 void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
 
 void populate_compress(MigrationInfo *info);
+uint64_t ram_compressed_pages(void);
 
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index bbf78a02d4..d54345d0c1 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -501,3 +501,9 @@ void populate_compress(MigrationInfo *info)
     info->compression->compressed_size = compression_counters.compressed_size;
     info->compression->compression_rate = compression_counters.compression_rate;
 }
+
+uint64_t ram_compressed_pages(void)
+{
+    return compression_counters.pages;
+}
+
diff --git a/migration/ram.c b/migration/ram.c
index c844151ee9..2a9c899cb0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -939,7 +939,7 @@ uint64_t ram_get_total_transferred_pages(void)
 {
     return stat64_get(&mig_stats.normal_pages) +
         stat64_get(&mig_stats.zero_pages) +
-        compression_counters.pages + xbzrle_counters.pages;
+        ram_compressed_pages() + xbzrle_counters.pages;
 }
 
 static void migration_update_rates(RAMState *rs, int64_t end_time)
-- 
2.41.0


