Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860477DBDFF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:34:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVDK-0003Zp-Vf; Mon, 30 Oct 2023 12:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDJ-0003Zd-2H
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDH-0002f7-6L
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7LWaJqNMU4MMH18+1IMpyA0GlKWGvM59R3vPm4Tplc=;
 b=Jqre0NyuEp63j0e/Ji1Q38yZlgRvw+sJ5HTl487WvrTsn+OyfjzPnp9GLBS10aH9LKsByk
 kPK+Ecu4PqcpteYfvnc57sRcHe5PSxtmTWS/RsJPZ9yDe+iK9Js4aplwowNFSK0BHaz/nc
 fB934LKm8xGukSYTa2NOeA/EpHzajqc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-aEzSSJuNNbeeSMFUs69s4g-1; Mon, 30 Oct 2023 12:34:01 -0400
X-MC-Unique: aEzSSJuNNbeeSMFUs69s4g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66fd88c39f6so7053256d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683640; x=1699288440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7LWaJqNMU4MMH18+1IMpyA0GlKWGvM59R3vPm4Tplc=;
 b=QlvBkO/IbOiT0Smdvi3SDxzXCD0uxC3Sopu3fQW91DX/JBJ+R8GbaiguhKsaXiUj9E
 0vrgjczXesG1ocxeSrVbhgwDaJu35skKlz4uu4Q2iYZN9yQq2Gaw4A2OSA6hAg76N4sc
 we0rdfUT8242r0X+RHyD33ib8Hjw3+3cG5lK77RARVT6G2NAnTqOFTodANHmfat2ZaEc
 RE73jq6cD/2BLmiVet+F2kuw18GqJ/Cq6FyYO8/fICZzHmoi0ueERrqZRK1ay1TG/nI7
 Bm5gkINSu2TeQG4XGQMGiTDDzxVWy4oFY7QJqgBDUsRUhRtox6YuzEAwyb5S1FwNeJNL
 bcNQ==
X-Gm-Message-State: AOJu0YzTcTEcqhcUhpF4mjiShW2IwajkMNhzwQlZ72tQJStslSp2pIVE
 4pWRr0D1DfXwxelXxfGEYZK6IiYtqrGZFr9Ks8k6ZCThJM/aeC88S6SsX5QuM8lBP/HAs9BlqcM
 N0Kw/85r6WF9QJnMs0Ur3a1BHIsEfOPryHkUWP822T4km1fj0xMiT7v/eAa4I2jsqZvJEAhpl
X-Received: by 2002:a05:622a:1a14:b0:412:2dac:acb7 with SMTP id
 f20-20020a05622a1a1400b004122dacacb7mr12559512qtb.1.1698683640512; 
 Mon, 30 Oct 2023 09:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9udNJfRKJwSAW1NpSYIPG3+xYNUlui17fjafoigBh2mVPyKhKXRgFYSBMsMSPOjdftYjNgA==
X-Received: by 2002:a05:622a:1a14:b0:412:2dac:acb7 with SMTP id
 f20-20020a05622a1a1400b004122dacacb7mr12559482qtb.1.1698683640094; 
 Mon, 30 Oct 2023 09:34:00 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ac84ccf000000b004198ae7f841sm3531111qtv.90.2023.10.30.09.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:33:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 5/5] migration: Add tracepoints for downtime checkpoints
Date: Mon, 30 Oct 2023 12:33:46 -0400
Message-ID: <20231030163346.765724-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030163346.765724-1-peterx@redhat.com>
References: <20231030163346.765724-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

This patch is inspired by Joao Martin's patch here:

https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com

Add tracepoints for major downtime checkpoints on both src and dst.  They
share the same tracepoint with a string showing its stage.

Besides the checkpoints in the previous patch, this patch also added
destination checkpoints.

On src, we have these checkpoints added:

  - src-downtime-start: right before vm stops on src
  - src-vm-stopped: after vm is fully stopped
  - src-iterable-saved: after all iterables saved (END sections)
  - src-non-iterable-saved: after all non-iterable saved (FULL sections)
  - src-downtime-stop: migration fully completed

On dst, we have these checkpoints added:

  - dst-precopy-loadvm-completes: after loadvm all done for precopy
  - dst-precopy-bh-*: record BH steps to resume VM for precopy
  - dst-postcopy-bh-*: record BH steps to resume VM for postcopy

On dst side, we don't have a good way to trace total time consumed by
iterable or non-iterable for now.  We can mark it by 1st time receiving a
FULL / END section, but rather than that let's just rely on the other
tracepoints added for vmstates to back up the information.

With this patch, one can enable "vmstate_downtime*" tracepoints and it'll
enable all tracepoints for downtime measurements necessary.

Drop loadvm_postcopy_handle_run_bh() tracepoint alongside, because they
service the same purpose, which was only for postcopy.  We then have
unified prefix for all downtime relevant tracepoints.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 16 +++++++++++++++-
 migration/savevm.c     | 14 +++++++++-----
 migration/trace-events |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9013c1b500..52f4ed41b2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -103,6 +103,7 @@ static int close_return_path_on_source(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
+    trace_vmstate_downtime_checkpoint("src-downtime-start");
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 }
 
@@ -117,6 +118,8 @@ static void migration_downtime_end(MigrationState *s)
     if (!s->downtime) {
         s->downtime = now - s->downtime_start;
     }
+
+    trace_vmstate_downtime_checkpoint("src-downtime-end");
 }
 
 static bool migration_needs_multiple_sockets(void)
@@ -151,7 +154,11 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
 
 int migration_stop_vm(RunState state)
 {
-    return vm_stop_force_state(state);
+    int ret = vm_stop_force_state(state);
+
+    trace_vmstate_downtime_checkpoint("src-vm-stopped");
+
+    return ret;
 }
 
 void migration_object_init(void)
@@ -500,6 +507,8 @@ static void process_incoming_migration_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
+    trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
+
     /* If capability late_block_activate is set:
      * Only fire up the block code now if we're going to restart the
      * VM, else 'cont' will do it.
@@ -525,6 +534,8 @@ static void process_incoming_migration_bh(void *opaque)
      */
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
+    trace_vmstate_downtime_checkpoint("dst-precopy-bh-announced");
+
     multifd_load_shutdown();
 
     dirty_bitmap_mig_before_vm_start();
@@ -542,6 +553,7 @@ static void process_incoming_migration_bh(void *opaque)
     } else {
         runstate_set(global_state_get_runstate());
     }
+    trace_vmstate_downtime_checkpoint("dst-precopy-bh-vm-started");
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -576,6 +588,8 @@ process_incoming_migration_co(void *opaque)
     ret = qemu_loadvm_state(mis->from_src_file);
     mis->loadvm_co = NULL;
 
+    trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
+
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
     if (ps != POSTCOPY_INCOMING_NONE) {
diff --git a/migration/savevm.c b/migration/savevm.c
index cd6d6ba493..2578137ee7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1494,6 +1494,8 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                                     end_ts_each - start_ts_each);
     }
 
+    trace_vmstate_downtime_checkpoint("src-iterable-saved");
+
     return 0;
 }
 
@@ -1560,6 +1562,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     json_writer_free(vmdesc);
     ms->vmdesc = NULL;
 
+    trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
+
     return 0;
 }
 
@@ -2102,18 +2106,18 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
-    trace_loadvm_postcopy_handle_run_bh("enter");
+    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-enter");
 
     /* TODO we should move all of this lot into postcopy_ram.c or a shared code
      * in migration.c
      */
     cpu_synchronize_all_post_init();
 
-    trace_loadvm_postcopy_handle_run_bh("after cpu sync");
+    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cpu-synced");
 
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
-    trace_loadvm_postcopy_handle_run_bh("after announce");
+    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-announced");
 
     /* Make sure all file formats throw away their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
@@ -2124,7 +2128,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         autostart = false;
     }
 
-    trace_loadvm_postcopy_handle_run_bh("after invalidate cache");
+    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
 
     dirty_bitmap_mig_before_vm_start();
 
@@ -2138,7 +2142,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     qemu_bh_delete(mis->bh);
 
-    trace_loadvm_postcopy_handle_run_bh("return");
+    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
 }
 
 /* After all discards we can start running and asking for pages */
diff --git a/migration/trace-events b/migration/trace-events
index 5820add1f3..e54f317e3b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -17,7 +17,6 @@ loadvm_handle_recv_bitmap(char *s) "%s"
 loadvm_postcopy_handle_advise(void) ""
 loadvm_postcopy_handle_listen(const char *str) "%s"
 loadvm_postcopy_handle_run(void) ""
-loadvm_postcopy_handle_run_bh(const char *str) "%s"
 loadvm_postcopy_handle_resume(void) ""
 loadvm_postcopy_ram_handle_discard(void) ""
 loadvm_postcopy_ram_handle_discard_end(void) ""
@@ -50,6 +49,7 @@ vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_downtime_save(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
 vmstate_downtime_load(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
+vmstate_downtime_checkpoint(const char *checkpoint) "%s"
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
-- 
2.41.0


