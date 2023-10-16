Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7D7CA4F4
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKWm-0003Sh-Ei; Mon, 16 Oct 2023 06:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWf-0003Dk-AA
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWd-0007hS-Lv
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3yJFUYdqFQJsQYkBBr/IRkNfZqFDLAMp8HLpfQdXiI=;
 b=fQjjmdVBWdcsNcQojZlQ1m8RsR1egktN1Zq9TdioyG9CPV5NtLH9YME/jWqw5wE0zmrQeY
 WF21r4fPMolIX6ft4QM5txDzQSGhMPTdYjJ+lrk3fY1ob0Fb/B3qfm6ZJSu3GXcNyen+5z
 AjkG8nM1wFsVDDD2IlMcW9izcHA5M7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-INNP8MauPWWmbxz49dBRSQ-1; Mon, 16 Oct 2023 06:08:34 -0400
X-MC-Unique: INNP8MauPWWmbxz49dBRSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DBF5862F1B;
 Mon, 16 Oct 2023 10:08:34 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9252E63F21;
 Mon, 16 Oct 2023 10:08:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PULL 28/38] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
Date: Mon, 16 Oct 2023 12:06:56 +0200
Message-ID: <20231016100706.2551-29-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

In migration rate limiting atomic operations are used
to read the rate limit variables and transferred bytes and
they are expensive. Check first if rate_limit_max is equal
to RATE_LIMIT_DISABLED and return false immediately if so.

Note that with this patch we will also will stop flushing
by not calling qemu_fflush() from migration_transferred_bytes()
if the migration rate is not exceeded.
This should be fine since migration thread calls in the loop
migration_update_counters from migration_rate_limit() that
calls the migration_transferred_bytes() and flushes there.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011184358.97349-2-elena.ufimtseva@oracle.com>
---
 migration/migration-stats.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 84e11e6dd8..4cc989d975 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -24,14 +24,15 @@ bool migration_rate_exceeded(QEMUFile *f)
         return true;
     }
 
+    uint64_t rate_limit_max = migration_rate_get();
+    if (rate_limit_max == RATE_LIMIT_DISABLED) {
+        return false;
+    }
+
     uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
     uint64_t rate_limit_current = migration_transferred_bytes(f);
     uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
-    uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
 
-    if (rate_limit_max == RATE_LIMIT_DISABLED) {
-        return false;
-    }
     if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
         return true;
     }
-- 
2.41.0


