Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB47CBD9E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUS-0006m4-Ar; Tue, 17 Oct 2023 04:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUJ-0006Bt-6D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUH-0005TC-Qi
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3yJFUYdqFQJsQYkBBr/IRkNfZqFDLAMp8HLpfQdXiI=;
 b=UDR2ug3N7RsFEw1HY4QrxCZfgNRQTsx6qgDCzk/hhv1NamyWchjjm9sNLt+ZNCJAsq6v4R
 x83bG36uPHRagSijc7qkuqnSPYUi78nR16O/6nTmfh1KiefsS/x1SsDKLnWFuGpvubatMo
 hJxwb4BlRyQ1OglQFkf6A0n2+NbsK/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-USYYMvoPMJysEcDXI3xFWA-1; Tue, 17 Oct 2023 04:31:31 -0400
X-MC-Unique: USYYMvoPMJysEcDXI3xFWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D50F858280;
 Tue, 17 Oct 2023 08:31:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 995C21C060B0;
 Tue, 17 Oct 2023 08:31:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PULL 28/38] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
Date: Tue, 17 Oct 2023 10:29:53 +0200
Message-ID: <20231017083003.15951-29-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
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


