Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023D7BC03C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorJr-0008Er-Uw; Fri, 06 Oct 2023 16:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorJo-0008DE-Oy; Fri, 06 Oct 2023 16:21:04 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorJm-0005mQ-PL; Fri, 06 Oct 2023 16:21:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 5F4E660EFC;
 Fri,  6 Oct 2023 23:21:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b403::1:3c])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kKgI6e5OrCg0-nsKsNsQQ; Fri, 06 Oct 2023 23:20:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696623659;
 bh=dAy7l69Vys7V3wlSX1d6pN71zQIe0P3DoLfLqC49yLc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=bkRHgiPjX4+V6M4BcIH8EXB+5ho+jILkI61RJ0JhSzIo8y8D40oX8c510wTtWlfuU
 cuaMErKY+MZ41d1qwBq+fz8efVBBnsbIvMiWLkpIV6lSm7OBQjnFL3WBB19+9keQLf
 UaCmE5XXtPskLIji4aUaRa7Kq4CIlKXMfvZJoHKQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, dave@treblig.org,
 armbru@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, mst@redhat.com, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru, den-plotnikov@yandex-team.ru,
 daniil.tatianin@yandex.ru
Subject: [PATCH 3/4] qapi: device-sync-config: check runstate
Date: Fri,  6 Oct 2023 23:20:44 +0300
Message-Id: <20231006202045.1161543-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Command result is racy if allow it during migration. Let's allow the
sync only in RUNNING state.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/sysemu/runstate.h |  1 +
 softmmu/qdev-monitor.c    | 27 ++++++++++++++++++++++++++-
 softmmu/runstate.c        |  5 +++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 08afb97695..1fc14c8122 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -5,6 +5,7 @@
 #include "qemu/notify.h"
 
 bool runstate_check(RunState state);
+const char *current_run_state_str(void);
 void runstate_set(RunState new_state);
 RunState runstate_get(void);
 bool runstate_is_running(void);
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index b6da24389f..b485375049 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -23,6 +23,7 @@
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-events-qdev.h"
@@ -1002,7 +1003,31 @@ int qdev_sync_config(DeviceState *dev, Error **errp)
 
 void qmp_x_device_sync_config(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    MigrationState *s = migrate_get_current();
+    DeviceState *dev;
+
+    /*
+     * During migration there is a race between syncing`config and migrating it,
+     * so let's just not allow it.
+     *
+     * Moreover, let's not rely on setting up interrupts in paused state, which
+     * may be a part of migration process.
+     */
+
+    if (migration_is_running(s->state)) {
+        error_setg(errp, "Config synchronization is not allowed "
+                   "during migration.");
+        return;
+    }
+
+    if (!runstate_is_running()) {
+        error_setg(errp, "Config synchronization allowed only in '%s' state, "
+                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
+                   current_run_state_str());
+        return;
+    }
+
+    dev = find_device_state(id, errp);
     if (!dev) {
         return;
     }
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 1652ed0439..3a8211474e 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -181,6 +181,11 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
+const char *current_run_state_str(void)
+{
+    return RunState_str(current_run_state);
+}
+
 static void runstate_init(void)
 {
     const RunStateTransition *p;
-- 
2.34.1


