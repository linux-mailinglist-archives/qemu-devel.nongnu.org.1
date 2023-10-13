Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FEB7C83A6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFhx-0003Za-Vf; Fri, 13 Oct 2023 06:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFhw-0003VO-7c
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFhu-00070u-Ok
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=og5HLKBVNDCzBOJuvHPjrC8FyHbbNNhZZtiN/Ov0+8Q=;
 b=Aox/C1xgFDDe+DXeGns3aEa+3dca3CoPno8h6GKIueHOJqGsdZaEV4WXtO17lbVbOzG/PM
 i90UNft1gwA3FIGT1ECYYQJ6XDHHMtSpSclm8byDLk1OQw+4eHHCu+F+KyJKDgK4eNsgj/
 vUfMm9arKUYetbjw2bTSXw2wRPIIs10=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-WR3MUBgGOlmDYMJh1NLmbw-1; Fri, 13 Oct 2023 06:47:48 -0400
X-MC-Unique: WR3MUBgGOlmDYMJh1NLmbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 673282810D4B;
 Fri, 13 Oct 2023 10:47:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A54052156701;
 Fri, 13 Oct 2023 10:47:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 02/10] migration: Print block status when needed
Date: Fri, 13 Oct 2023 12:47:28 +0200
Message-ID: <20231013104736.31722-3-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

The new line was only printed when command options were used.  When we
used migration parameters and capabilities, it wasn't.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-hmp-cmds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..e0e16afa34 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -30,6 +30,7 @@
 #include "sysemu/runstate.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/sysemu.h"
+#include "options.h"
 #include "migration.h"
 
 static void migration_global_dump(Monitor *mon)
@@ -682,7 +683,6 @@ void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict)
 typedef struct HMPMigrationStatus {
     QEMUTimer *timer;
     Monitor *mon;
-    bool is_block_migration;
 } HMPMigrationStatus;
 
 static void hmp_migrate_status_cb(void *opaque)
@@ -708,7 +708,7 @@ static void hmp_migrate_status_cb(void *opaque)
 
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 1000);
     } else {
-        if (status->is_block_migration) {
+        if (migrate_block()) {
             monitor_printf(status->mon, "\n");
         }
         if (info->error_desc) {
@@ -748,7 +748,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 
         status = g_malloc0(sizeof(*status));
         status->mon = mon;
-        status->is_block_migration = blk || inc;
         status->timer = timer_new_ms(QEMU_CLOCK_REALTIME, hmp_migrate_status_cb,
                                           status);
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
-- 
2.41.0


