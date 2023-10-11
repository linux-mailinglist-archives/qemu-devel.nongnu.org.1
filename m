Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC587C4F03
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVS6-0005EU-CB; Wed, 11 Oct 2023 05:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVS1-000517-Bz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRz-0005E5-SL
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBYCAbiI8Mo0auPbEzdaZww1TzKLgGWShjQuj+jWTDQ=;
 b=epPcQS9MGCytiR8tRgl1+/VcLrU6Lbfh7mBwDbf+2YCMB3E5IliuigsKEcQH8lrIZhDpWD
 BRffEPVc12wL6C4X6mcyfFBCmZhx7b/KX/y7aXYgYbeu/g75zj70TThHjlor9kpscY+QsD
 GbTYY4sOV0uzytmcXMvCpwaXfzwq24E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-CbZqyyoQOb2I-VMCUVcU8A-1; Wed, 11 Oct 2023 05:24:12 -0400
X-MC-Unique: CbZqyyoQOb2I-VMCUVcU8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394F5887E40;
 Wed, 11 Oct 2023 09:24:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3641C060AE;
 Wed, 11 Oct 2023 09:24:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 62/65] migration: Introduce migrate_has_error()
Date: Wed, 11 Oct 2023 11:22:00 +0200
Message-ID: <20231011092203.1266-63-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
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

From: Peter Xu <peterx@redhat.com>

Introduce a helper to detect whether MigrationState.error is set for
whatever reason.

This is preparation work for any thread (e.g. source return path thread) to
setup errors in an unified way to MigrationState, rather than relying on
its own way to set errors (mark_source_rp_bad()).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231004220240.167175-3-peterx@redhat.com>
---
 migration/migration.h | 1 +
 migration/migration.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 972597f4de..4106a1dc54 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -476,6 +476,7 @@ bool  migration_has_all_channels(void);
 uint64_t migrate_max_downtime(void);
 
 void migrate_set_error(MigrationState *s, const Error *error);
+bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
diff --git a/migration/migration.c b/migration/migration.c
index 57f9e9ed0c..409eb3e916 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1234,6 +1234,13 @@ void migrate_set_error(MigrationState *s, const Error *error)
     }
 }
 
+bool migrate_has_error(MigrationState *s)
+{
+    /* The lock is not helpful here, but still follow the rule */
+    QEMU_LOCK_GUARD(&s->error_mutex);
+    return qatomic_read(&s->error);
+}
+
 static void migrate_error_free(MigrationState *s)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
-- 
2.41.0


