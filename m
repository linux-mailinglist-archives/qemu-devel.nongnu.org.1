Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7E7DBDFD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:34:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVDJ-0003ZO-A6; Mon, 30 Oct 2023 12:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDG-0003Yp-Fx
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDE-0002eR-RP
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSHyWtkUKU/y1HHFJ9tbynjlp9Czisd65damm2Zn+wQ=;
 b=FXlX7gNpi57jL8Jeb0OcoKt9oh9kCRAgwtlJGSTMRVpopF4PQaQ75RysB94J+n/R1TMtbV
 u/pJXnb7vrLmiVD5ruMrrBiZkhZT664nNLmUdMnO7m8+ATr98WnaFK1i5e59vbck0MU7+2
 5dH/8ZCZ5Ue25y79qp9a39u/HL0TN6E=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-PNloeZQdPHyH7xTJ2mUz1g-1; Mon, 30 Oct 2023 12:33:58 -0400
X-MC-Unique: PNloeZQdPHyH7xTJ2mUz1g-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6cd01bd39a3so732996a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683637; x=1699288437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSHyWtkUKU/y1HHFJ9tbynjlp9Czisd65damm2Zn+wQ=;
 b=FM2vgfZyvUPxmVC+cXxVekN9DuhAQ0R3MY3K7/6Jx+l41NrUglnhb7k6T+h0D6YGKJ
 8Ky9QlvnmzpLgo5f2x4KSJaKxVIkLVUWEuzbWCgAXvKzWIxt5cJChyc/5AkUjr1p6JKm
 I3amwK2x6SPmBNUHupiweBLC3Cjscrt1ltSORWP0urKqulTWiScAPgZe6P2MwLjRBlM7
 AikbK7Lnwh9Z4THPYqLLiVINP/fK8FVnHeJqH476ddCjxld420BsYdIgc6XTHavK+Zx7
 2lQyArehvBpb+G5zsQIBXdsNROrRF7mEuu8jR6dFfLVyxW7kvJw1LdJvgVrzQ2pH7YII
 DCeQ==
X-Gm-Message-State: AOJu0YzG26fj8TcL8MBPBcpYYsRD/kBkrIcoOlWegHNs2WkJ/OtIJcdK
 CVvr9aJZpTFTI/SemmErPvmvyx6sguZFPZMGMHu0fE5i89zsVLmh5UnOzHeh8FP4fzyZFbJK0L3
 IcnLV+OdISQaflEY/wkGiAtiZptaGm1GJijnonodMC6qSvSWvsal/6bOuBdiiK9ebg6rpLX07
X-Received: by 2002:a9d:7445:0:b0:6bf:500f:b570 with SMTP id
 p5-20020a9d7445000000b006bf500fb570mr10633354otk.3.1698683637381; 
 Mon, 30 Oct 2023 09:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyjoANxGj/zT43GiSr7q/8oDR4PwXA08T8ixjNi+aqzjhRpxhx5FZHE5eabifWPteJfOUVzQ==
X-Received: by 2002:a9d:7445:0:b0:6bf:500f:b570 with SMTP id
 p5-20020a9d7445000000b006bf500fb570mr10633333otk.3.1698683637003; 
 Mon, 30 Oct 2023 09:33:57 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ac84ccf000000b004198ae7f841sm3531111qtv.90.2023.10.30.09.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:33:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 2/5] migration: Add migration_downtime_start|end() helpers
Date: Mon, 30 Oct 2023 12:33:43 -0400
Message-ID: <20231030163346.765724-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030163346.765724-1-peterx@redhat.com>
References: <20231030163346.765724-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Unify the three users on recording downtimes with the same pair of helpers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f8a54ff4d1..70d775942a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -101,6 +101,24 @@ static int migration_maybe_pause(MigrationState *s,
 static void migrate_fd_cancel(MigrationState *s);
 static int close_return_path_on_source(MigrationState *s);
 
+static void migration_downtime_start(MigrationState *s)
+{
+    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+}
+
+static void migration_downtime_end(MigrationState *s)
+{
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    /*
+     * If downtime already set, should mean that postcopy already set it,
+     * then that should be the real downtime already.
+     */
+    if (!s->downtime) {
+        s->downtime = now - s->downtime_start;
+    }
+}
+
 static bool migration_needs_multiple_sockets(void)
 {
     return migrate_multifd() || migrate_postcopy_preempt();
@@ -2142,7 +2160,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
-    ms->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    migration_downtime_start(ms);
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
@@ -2246,7 +2264,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     ms->postcopy_after_devices = true;
     migration_call_notifiers(ms);
 
-    ms->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - ms->downtime_start;
+    migration_downtime_end(ms);
 
     qemu_mutex_unlock_iothread();
 
@@ -2342,7 +2360,7 @@ static int migration_completion_precopy(MigrationState *s,
     int ret;
 
     qemu_mutex_lock_iothread();
-    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    migration_downtime_start(s);
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
     s->vm_old_state = runstate_get();
@@ -2699,15 +2717,8 @@ static void migration_calculate_complete(MigrationState *s)
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
+    migration_downtime_end(s);
     s->total_time = end_time - s->start_time;
-    if (!s->downtime) {
-        /*
-         * It's still not set, so we are precopy migration.  For
-         * postcopy, downtime is calculated during postcopy_start().
-         */
-        s->downtime = end_time - s->downtime_start;
-    }
-
     transfer_time = s->total_time - s->setup_time;
     if (transfer_time) {
         s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
@@ -3126,7 +3137,7 @@ static void bg_migration_vm_start_bh(void *opaque)
     s->vm_start_bh = NULL;
 
     vm_start();
-    s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - s->downtime_start;
+    migration_downtime_end(s);
 }
 
 /**
@@ -3193,7 +3204,7 @@ static void *bg_migration_thread(void *opaque)
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
-    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    migration_downtime_start(s);
 
     qemu_mutex_lock_iothread();
 
-- 
2.41.0


