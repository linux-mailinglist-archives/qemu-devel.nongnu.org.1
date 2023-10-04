Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54F7B9719
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xP-0004OZ-0x; Wed, 04 Oct 2023 18:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xJ-0004HG-8v
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xG-0003v7-Of
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7vF4oampnVew52zhwRc8UGlegpzHZt7lFld7Xo897I=;
 b=LLeXYvYT2L67Vqk6ssTJ48rNI1uC9l+9dR9PY9X1Rk4bWODInAImhTz0Pfcr2HjUoYfya5
 /3CWyPs+f5QPLdRP6AaHkR092v3dwP+/jAXUYkPSEjtlRcADKbngzADFcD2ONuSA9oHHhm
 g9G8Tp8wJRc2uRTDgjI0IE6RH++09pY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-_GCTfS_MP-KgaCFLGwMXHw-1; Wed, 04 Oct 2023 18:02:52 -0400
X-MC-Unique: _GCTfS_MP-KgaCFLGwMXHw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66011f0d521so370686d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456972; x=1697061772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7vF4oampnVew52zhwRc8UGlegpzHZt7lFld7Xo897I=;
 b=jFVPhcEWyPJmI7yVuHNA8OQakXgmQ3CnmHT969A+l4MKW/BmSnRJWfVADNqEOaiwqN
 USxlUkauoTUs5BrFkrNqPYUvPyqENkXmjtnUF2LK6WcBlfc2fsWa/zSdMOTtNLTmEQHH
 MJOzmJETh4cuHVrLxSErzMXsqC5RQ/WJDaiqWo0LYLct3ZsbV2eREXoNF26P8hp61EvT
 ZaN30Kf8mulY2kihRytaLgeOVW4/XFCfNShCcHNYfhaxX/X2MWkBMxnd/Z1vfB5JICjb
 gWGboEHJf2TLhuVOwqWe3tffmUY+/GfZ/00DFuH5zhkzF8A5tn7EUqBylQL6TGdoD91F
 UTvQ==
X-Gm-Message-State: AOJu0Yzat/jM3oaUifShpL673H4T6PcpkxoiI7+t6ror6DQTiWjhr8MJ
 Ns5VS7QRJ8NkPcjgI26/A4m92LeT2xQ09mV7MfXNDeU12ohSeDHbcqAzPoafVNlEAyoiK3KeGjC
 lB8EEo2etKx0xp88JIjcbtRE4ohslUj+xBNBPSKe5SDDK6GIpt+L1/gF1BZ/dfia65T6b3a6E
X-Received: by 2002:a05:6214:4003:b0:656:308b:98d1 with SMTP id
 kd3-20020a056214400300b00656308b98d1mr3774512qvb.2.1696456971796; 
 Wed, 04 Oct 2023 15:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmoc1qoM3LUgC4A8YdcF5p+Q/xBmqZ4gFv6RpoIwqPca0JtI5Z5uo2FUVI3dVfRcB0xsqEsw==
X-Received: by 2002:a05:6214:4003:b0:656:308b:98d1 with SMTP id
 kd3-20020a056214400300b00656308b98d1mr3774486qvb.2.1696456971405; 
 Wed, 04 Oct 2023 15:02:51 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Xiaohui Li <xiaohli@redhat.com>
Subject: [PATCH v3 08/10] migration: Allow network to fail even during recovery
Date: Wed,  4 Oct 2023 18:02:38 -0400
Message-ID: <20231004220240.167175-9-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Normally the postcopy recover phase should only exist for a super short
period, that's the duration when QEMU is trying to recover from an
interrupted postcopy migration, during which handshake will be carried out
for continuing the procedure with state changes from PAUSED -> RECOVER ->
POSTCOPY_ACTIVE again.

Here RECOVER phase should be super small, that happens right after the
admin specified a new but working network link for QEMU to reconnect to
dest QEMU.

However there can still be case where the channel is broken in this small
RECOVER window.

If it happens, with current code there's no way the src QEMU can got kicked
out of RECOVER stage. No way either to retry the recover in another channel
when established.

This patch allows the RECOVER phase to fail itself too - we're mostly
ready, just some small things missing, e.g. properly kick the main
migration thread out when sleeping on rp_sem when we found that we're at
RECOVER stage.  When this happens, it fails the RECOVER itself, and
rollback to PAUSED stage.  Then the user can retry another round of
recovery.

To make it even stronger, teach QMP command migrate-pause to explicitly
kick src/dst QEMU out when needed, so even if for some reason the migration
thread didn't got kicked out already by a failing rethrn-path thread, the
admin can also kick it out.

This will be an super, super corner case, but still try to cover that.

One can try to test this with two proxy channels for migration:

  (a) socat unix-listen:/tmp/src.sock,reuseaddr,fork tcp:localhost:10000
  (b) socat tcp-listen:10000,reuseaddr,fork unix:/tmp/dst.sock

So the migration channel will be:

                      (a)          (b)
  src -> /tmp/src.sock -> tcp:10000 -> /tmp/dst.sock -> dst

Then to make QEMU hang at RECOVER stage, one can do below:

  (1) stop the postcopy using QMP command postcopy-pause
  (2) kill the 2nd proxy (b)
  (3) try to recover the postcopy using /tmp/src.sock on src
  (4) src QEMU will go into RECOVER stage but won't be able to continue
      from there, because the channel is actually broken at (b)

Before this patch, step (4) will make src QEMU stuck in RECOVER stage,
without a way to kick the QEMU out or continue the postcopy again.  After
this patch, (4) will quickly fail qemu and bounce back to PAUSED stage.

Admin can also kick QEMU from (4) into PAUSED when needed using
migrate-pause when needed.

After bouncing back to PAUSED stage, one can recover again.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2111332
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  8 ++++--
 migration/migration.c | 63 +++++++++++++++++++++++++++++++++++++++----
 migration/ram.c       |  4 ++-
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 573aa69f19..f985d3dedb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -492,6 +492,7 @@ int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
+bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
 
 uint64_t ram_get_total_transferred_pages(void);
@@ -532,8 +533,11 @@ void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
-/* Migration thread waiting for return path thread. */
-void migration_rp_wait(MigrationState *s);
+/*
+ * Migration thread waiting for return path thread.  Return non-zero if an
+ * error is detected.
+ */
+int migration_rp_wait(MigrationState *s);
 /*
  * Kick the migration thread waiting for return path messages.  NOTE: the
  * name can be slightly confusing (when read as "kick the rp thread"), just
diff --git a/migration/migration.c b/migration/migration.c
index 1b7ed2d35a..1a7f214fcf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1345,6 +1345,17 @@ bool migration_in_postcopy(void)
     }
 }
 
+bool migration_postcopy_is_alive(int state)
+{
+    switch (state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool migration_in_postcopy_after_devices(MigrationState *s)
 {
     return migration_in_postcopy() && s->postcopy_after_devices;
@@ -1552,8 +1563,15 @@ void qmp_migrate_pause(Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret = 0;
 
-    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive(ms->state)) {
         /* Source side, during postcopy */
+        Error *error = NULL;
+
+        /* Tell the core migration that we're pausing */
+        error_setg(&error, "Postcopy migration is paused by the user");
+        migrate_set_error(ms, error);
+        error_free(error);
+
         qemu_mutex_lock(&ms->qemu_file_lock);
         if (ms->to_dst_file) {
             ret = qemu_file_shutdown(ms->to_dst_file);
@@ -1562,10 +1580,17 @@ void qmp_migrate_pause(Error **errp)
         if (ret) {
             error_setg(errp, "Failed to pause source migration");
         }
+
+        /*
+         * Kick the migration thread out of any waiting windows (on behalf
+         * of the rp thread).
+         */
+        migration_rp_kick(ms);
+
         return;
     }
 
-    if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive(mis->state)) {
         ret = qemu_file_shutdown(mis->from_src_file);
         if (ret) {
             error_setg(errp, "Failed to pause destination migration");
@@ -1574,7 +1599,7 @@ void qmp_migrate_pause(Error **errp)
     }
 
     error_setg(errp, "migrate-pause is currently only supported "
-               "during postcopy-active state");
+               "during postcopy-active or postcopy-recover state");
 }
 
 bool migration_is_blocked(Error **errp)
@@ -1749,9 +1774,21 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
     qemu_sem_post(&s->pause_sem);
 }
 
-void migration_rp_wait(MigrationState *s)
+int migration_rp_wait(MigrationState *s)
 {
+    /* If migration has failure already, ignore the wait */
+    if (migrate_has_error(s)) {
+        return -1;
+    }
+
     qemu_sem_wait(&s->rp_state.rp_sem);
+
+    /* After wait, double check that there's no failure */
+    if (migrate_has_error(s)) {
+        return -1;
+    }
+
+    return 0;
 }
 
 void migration_rp_kick(MigrationState *s)
@@ -2017,6 +2054,20 @@ out:
         trace_source_return_path_thread_bad_end();
     }
 
+    if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        /*
+         * this will be extremely unlikely: that we got yet another network
+         * issue during recovering of the 1st network failure.. during this
+         * period the main migration thread can be waiting on rp_sem for
+         * this thread to sync with the other side.
+         *
+         * When this happens, explicitly kick the migration thread out of
+         * RECOVER stage and back to PAUSED, so the admin can try
+         * everything again.
+         */
+        migration_rp_kick(ms);
+    }
+
     trace_source_return_path_thread_end();
     rcu_unregister_thread();
     return NULL;
@@ -2457,7 +2508,9 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index 43ba62be83..2565f53f5c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4143,7 +4143,9 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     /* Wait until all the ramblocks' dirty bitmap synced */
     while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     trace_ram_dirty_bitmap_sync_complete();
-- 
2.41.0


