Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3797DC920
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:09:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkeu-0002mY-Kl; Tue, 31 Oct 2023 05:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxken-0002KD-0r
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkek-0007By-Nx
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698743006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8I8b00ywXtgCefxVuG8Ld+7VEOyo7QAMJMHTl3NboQ=;
 b=DVrx989Lqx8lhgq4Fvn2yk2Hvhax0JEMsGz+fx6d/DFK0+Ok4pijN8BuEUXE8Utj+9clAk
 dSQUXaTwu5GWGX+b4nU+LT0NP8Y1tRDwf3JYDVk3A/wrkvqNMoPGH52BWAYZ5QVjMKOFvH
 ri1cA5+M79m8s3cqSD2zTp3qOqkyaLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-LWWYnzg7Oz6rjp8UryLpOQ-1; Tue, 31 Oct 2023 05:03:22 -0400
X-MC-Unique: LWWYnzg7Oz6rjp8UryLpOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BF0D101A54C;
 Tue, 31 Oct 2023 09:03:21 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF1EA1C060AE;
 Tue, 31 Oct 2023 09:03:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/38] migration: migration_rate_limit_reset() don't need the
 QEMUFile
Date: Tue, 31 Oct 2023 10:01:38 +0100
Message-ID: <20231031090142.13122-35-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231025091117.6342-9-quintela@redhat.com>
---
 migration/migration-stats.h | 4 +---
 migration/migration-stats.c | 2 +-
 migration/migration.c       | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index e3863bf9bb..68f3939188 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -120,10 +120,8 @@ uint64_t migration_rate_get(void);
  * migration_rate_reset: Reset the rate limit counter.
  *
  * This is called when we know we start a new transfer cycle.
- *
- * @f: QEMUFile used for main migration channel
  */
-void migration_rate_reset(QEMUFile *f);
+void migration_rate_reset(void);
 
 /**
  * migration_rate_set: Set the maximum amount that can be transferred.
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 4ae8c0c722..f690b98a03 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -54,7 +54,7 @@ void migration_rate_set(uint64_t limit)
     stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
 }
 
-void migration_rate_reset(QEMUFile *f)
+void migration_rate_reset(void)
 {
     stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes());
 }
diff --git a/migration/migration.c b/migration/migration.c
index 04d4546150..a25a2f3c54 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2785,7 +2785,7 @@ static void migration_update_counters(MigrationState *s,
             stat64_get(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
     }
 
-    migration_rate_reset(s->to_dst_file);
+    migration_rate_reset();
 
     update_iteration_initial_status(s);
 
-- 
2.41.0


