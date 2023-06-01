Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A2871F6CC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ryJ-00069c-5c; Thu, 01 Jun 2023 19:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryF-00068e-F4
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryB-0000ws-GI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4gJ60Ealycyn+5Tv6j+hmZj9B87IXvu+mOtep4AFto=;
 b=ZBHqECPz+y8HFBVfasty6it0H9wkQ44qgsyYBMUmRpLBIG+Kk52rgDVcC+f0qcCuQIEh1t
 tFs9u3s7nDm3i1Zu/JPK92uJbu54gk9nHXksBl9RaPM7FpSbyOlXylH/pi22dcCEsLC5y/
 FbvYTgeyhlyL8drTg+kXE3a5/ii8pMo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-3MFlIKD3MuybpL27u8QnSg-1; Thu, 01 Jun 2023 19:44:35 -0400
X-MC-Unique: 3MFlIKD3MuybpL27u8QnSg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 639D11C08DA7;
 Thu,  1 Jun 2023 23:44:35 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 623A6492B00;
 Thu,  1 Jun 2023 23:44:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 5/6] migration: restore vmstate on migration failure
Date: Fri,  2 Jun 2023 01:44:25 +0200
Message-Id: <20230601234426.29984-6-quintela@redhat.com>
In-Reply-To: <20230601234426.29984-1-quintela@redhat.com>
References: <20230601234426.29984-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230517123752.21615-6-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 +-
 softmmu/runstate.c    | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 033162cda0..7c3425c6fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2772,7 +2772,7 @@ static void migration_iteration_finish(MigrationState *s)
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
2.40.1


