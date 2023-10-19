Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865FF7CF638
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQsq-0001vW-9h; Thu, 19 Oct 2023 07:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsV-0001Zz-Rd
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsS-0000er-SI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697713659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYMJDbOgdjA3oi9QzUh16drfKdEhythpDflUwlvEkPs=;
 b=VVjxuCLRREbZfY6n6MF4aNreOFGOVh/BGFX/vBEuJq3uwRwqItB+l0GXvM0b4NCb7oZUvf
 27QtM6GtuPdwyhZ5+fyiQvf/TTFE8Q7Jhiv6fx+W7ed4Hk91b/KWLpyHKalDoNVKf86nag
 Lhz7vaTuDLflo/uBLac52ajuG1P7v6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-seRrDuapOu-oGQ6doNvq0g-1; Thu, 19 Oct 2023 07:07:37 -0400
X-MC-Unique: seRrDuapOu-oGQ6doNvq0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DB37185A790;
 Thu, 19 Oct 2023 11:07:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3F125C8;
 Thu, 19 Oct 2023 11:07:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 08/11] migration: Export send_queued_data()
Date: Thu, 19 Oct 2023 13:07:21 +0200
Message-ID: <20231019110724.15324-9-quintela@redhat.com>
In-Reply-To: <20231019110724.15324-1-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
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
index bfb2f02351..d8b38ed999 100644
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


