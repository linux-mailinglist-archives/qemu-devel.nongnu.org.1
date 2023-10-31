Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C27DC8F2
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:04:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxke4-0000lp-2i; Tue, 31 Oct 2023 05:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxke1-0000jA-I7
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdz-0006wZ-61
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65HtqjEgp5Bqh3Qad91zv3o+mLXRJbK00jYVKDpCWLY=;
 b=ixQKO9njPu+ZFrVak8sWeI1pvHRGKgFGvfPwPmH8a610k3oKv9iT+OAhk0YOIIexaxHfpJ
 7PmL/kS/JrAFTuR6+DcaEOEvJOM1oIjRZK8hXHiFLHz+qCK7PKzmSt8ZmflVNhvRLgzgju
 uvQII1RVF3NeIM8Q0/RPv2KPPXTAnZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-xavfIDNkOzevx3MXse27kw-1; Tue,
 31 Oct 2023 05:02:34 -0400
X-MC-Unique: xavfIDNkOzevx3MXse27kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC8151C060CD;
 Tue, 31 Oct 2023 09:02:33 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9FE1C060AE;
 Tue, 31 Oct 2023 09:02:31 +0000 (UTC)
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
Subject: [PULL 17/38] migration: Rename ram_compressed_pages() to
 compress_ram_pages()
Date: Tue, 31 Oct 2023 10:01:21 +0100
Message-ID: <20231031090142.13122-18-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

We are moving to have all functions exported from ram-compress.c to
start with compress_.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-12-quintela@redhat.com>
---
 migration/ram-compress.h | 2 +-
 migration/ram-compress.c | 2 +-
 migration/ram.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index e222887fb7..0d89a2f55e 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -68,7 +68,7 @@ int compress_threads_load_setup(QEMUFile *f);
 void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
 
 void populate_compress(MigrationInfo *info);
-uint64_t ram_compressed_pages(void);
+uint64_t compress_ram_pages(void);
 void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
 void compress_update_rates(uint64_t page_count);
 int compress_send_queued_data(CompressParam *param);
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 036e44085b..fa4388f6a6 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -516,7 +516,7 @@ void populate_compress(MigrationInfo *info)
     info->compression->compression_rate = compression_counters.compression_rate;
 }
 
-uint64_t ram_compressed_pages(void)
+uint64_t compress_ram_pages(void)
 {
     return compression_counters.pages;
 }
diff --git a/migration/ram.c b/migration/ram.c
index 849752ef29..6335564035 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -932,7 +932,7 @@ uint64_t ram_get_total_transferred_pages(void)
 {
     return stat64_get(&mig_stats.normal_pages) +
         stat64_get(&mig_stats.zero_pages) +
-        ram_compressed_pages() + xbzrle_counters.pages;
+        compress_ram_pages() + xbzrle_counters.pages;
 }
 
 static void migration_update_rates(RAMState *rs, int64_t end_time)
-- 
2.41.0


