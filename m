Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB97CC9CE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnmv-0001CQ-5y; Tue, 17 Oct 2023 13:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsnmt-0001Ay-C5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsnmr-0005Fq-UP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697563401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wsAGBoZ5qDNnv4hQNa32BIxfSCM3txiOnIejCpwnqiI=;
 b=W4ljmEP9uS/Chg4m4HF5n/XIkQCNFDdaCcylgbkG4ZRj+7guD9Q8Fs4isSv4O2sfyLLnO2
 mLYSKxGTkM7iaXeqnea5MuEluttSmxcUzT/chrAJYSbSKkTKmT/QddJg6WsIACRJYxb8Xt
 TO2YdQhqKORZh8g9l09c/iUtT2ozMa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-ZgRN45iuORqQQeUm8jH8lw-1; Tue, 17 Oct 2023 13:23:13 -0400
X-MC-Unique: ZgRN45iuORqQQeUm8jH8lw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6E0A862F1E;
 Tue, 17 Oct 2023 17:23:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6009492BEE;
 Tue, 17 Oct 2023 17:23:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v6 1/5] migration: Print block status when needed
Date: Tue, 17 Oct 2023 19:23:03 +0200
Message-ID: <20231017172307.22858-2-quintela@redhat.com>
In-Reply-To: <20231017172307.22858-1-quintela@redhat.com>
References: <20231017172307.22858-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

The new line was only printed when command options were used.  When we
used migration parameters and capabilities, it wasn't.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index d206700a43..a82597f18e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -30,6 +30,7 @@
 #include "sysemu/runstate.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/sysemu.h"
+#include "options.h"
 #include "migration.h"
 
 static void migration_global_dump(Monitor *mon)
@@ -696,7 +697,6 @@ void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict)
 typedef struct HMPMigrationStatus {
     QEMUTimer *timer;
     Monitor *mon;
-    bool is_block_migration;
 } HMPMigrationStatus;
 
 static void hmp_migrate_status_cb(void *opaque)
@@ -722,7 +722,7 @@ static void hmp_migrate_status_cb(void *opaque)
 
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 1000);
     } else {
-        if (status->is_block_migration) {
+        if (migrate_block()) {
             monitor_printf(status->mon, "\n");
         }
         if (info->error_desc) {
@@ -762,7 +762,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 
         status = g_malloc0(sizeof(*status));
         status->mon = mon;
-        status->is_block_migration = blk || inc;
         status->timer = timer_new_ms(QEMU_CLOCK_REALTIME, hmp_migrate_status_cb,
                                           status);
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
-- 
2.41.0


