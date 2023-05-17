Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE4F706858
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGQY-0006fG-Rl; Wed, 17 May 2023 08:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQW-0006dz-AF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:44 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQT-0001AJ-VU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:44 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 4B48B5F121;
 Wed, 17 May 2023 15:38:36 +0300 (MSK)
Received: from vsementsov-nix.yandex.net (unknown
 [2a02:6b8:8f:4:7a31:c1ff:fef2:bf07])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KcbvG13OqeA0-154XgN5u; Wed, 17 May 2023 15:38:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684327115; bh=ViHCCEuzBqPFruSUxRv3sDA4dNpVzVufT2ps8lQXDjg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aB0zv8oCKmwYASz7Lr31oAfQriwFstfV6x3DNc1r+WklaI4hbc8qCDwtc+/4O7agz
 +oZ7bO7DTAllWsipVDzAItUQrp8DDqrKRqJVMzhIB0Rzjd6AcI9+xvrKK1VrUAxOht
 O8ov4ZTlwBTS+RJjOHfd2pIFk06MNfoDApstQnkA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, leobras@redhat.com, peterx@redhat.com,
 quintela@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH 5/5] migration: restore vmstate on migration failure
Date: Wed, 17 May 2023 15:37:52 +0300
Message-Id: <20230517123752.21615-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517123752.21615-1-vsementsov@yandex-team.ru>
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

1. Otherwise failed migration just drops guest-panicked state, which is
   not good for management software.

2. We do keep different paused states like guest-panicked during
   migration with help of global_state state.

3. We do restore running state on source when migration is cancelled or
   failed.

4. "postmigrate" state is documented as "guest is paused following a
   successful 'migrate'", so originally it's only for successful path
   and we never documented current behavior.

Let's restore paused states like guest-panicked in case of cancel or
fail too. Allow same transitions like for inmigrate state.

This commit changes the behavior that was introduced by commit
42da5550d6 "migration: set state to post-migrate on failure" and
provides a bit different fix on related
  https://bugzilla.redhat.com/show_bug.cgi?id=1355683

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/migration.c | 2 +-
 softmmu/runstate.c    | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4ccb9f9f3b..951897554f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2804,7 +2804,7 @@ static void migration_iteration_finish(MigrationState *s)
             }
         } else {
             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
-                runstate_set(RUN_STATE_POSTMIGRATE);
+                runstate_set(s->vm_old_state);
             }
         }
         break;
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 0370230a5e..1957caf73f 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -121,7 +121,13 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PRELAUNCH },
-    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_COLO},
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_COLO },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_INTERNAL_ERROR },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_IO_ERROR },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_SHUTDOWN },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_SUSPENDED },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_WATCHDOG },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_GUEST_PANICKED },
 
     { RUN_STATE_RESTORE_VM, RUN_STATE_RUNNING },
     { RUN_STATE_RESTORE_VM, RUN_STATE_PRELAUNCH },
-- 
2.34.1


