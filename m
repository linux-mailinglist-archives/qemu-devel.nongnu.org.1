Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAA7D88B4
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 21:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw5cP-0004mh-4V; Thu, 26 Oct 2023 15:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw5cN-0004mY-Io
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw5cL-0000gt-MA
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698346924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFL1F7ghi7vCyEKRRGn2YTu0nWfrog5RK84AmBwWchE=;
 b=OJxoro74aXNYvCtMlEDXEKYOHDaz4wtWSROjZY7CWmlD6wOjCCXf5HGJHwHAfbG43U+UzV
 bgTaJaibiqvEhr5NWT5Cy59NUuUUDnmZGlzdcZ+0ZQuhYFi7He+gTuRqPbvulGe8u6lHwp
 AS9zNg4r7Ae5Il4H/TZjrcoUABKeJZI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-5AQYCzSJMX6GT-ZQ9eY9xg-1; Thu, 26 Oct 2023 15:02:03 -0400
X-MC-Unique: 5AQYCzSJMX6GT-ZQ9eY9xg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65623d0075aso3841496d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 12:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346922; x=1698951722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFL1F7ghi7vCyEKRRGn2YTu0nWfrog5RK84AmBwWchE=;
 b=A0YM/U55LZmReRZgkaBqRKcHNv30AhgoGpsP7fuBYMIfMBjSyrXTbDGZWPkUgsj2EB
 /ra9cT2aZGPftMKEkf4/vEx3J7brlcNn9m6B64z9e95U1vnqP5n9XmJjI5sq/zSxf0lw
 bV2X2U9QbigSpPBedOY18XK+ibvzx7rprZiLVmHj7kzWup4W562xja/YUAV4aIkxPeSI
 YGhgf5LC3W5s1dMdEZEHU2osZmZe0dqdTgozQcYtJ0vh/BmZRFX7o7Cswdv/mJTTFVlW
 Q7Fy41mmfyqABVwMv9Lw9UmAHdT/+S/UNXMcI2dLh9kiB+nnP4yLxcHBMfHi1A0pTuud
 oUig==
X-Gm-Message-State: AOJu0Yz1vpc2Xq/vLZbukCKdIOfC6AxBvdnu7i3vkKej6DFA3cw7my21
 NaTTeTkugCyVLtj2sZzaD+RH/7jCHClLI+oDi98Tqub+EDPhAL6L5428muwGFBnYT73BYgyNWeR
 90beYRESsY3U039f//CxG0Du5C9/wvrUNofbZZTiQxv4vvR0tEEJZz9jMBqnep0ur0NfvYwhp
X-Received: by 2002:a05:6214:5346:b0:66d:4994:b79a with SMTP id
 kv6-20020a056214534600b0066d4994b79amr488308qvb.5.1698346922131; 
 Thu, 26 Oct 2023 12:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhX/kZ1LDxh7gXGJ9/wnBuNyvFyZUrbpYDOe0GVFXvT1FrMLK9Uuf8PevcIS/xsotm7drC5A==
X-Received: by 2002:a05:6214:5346:b0:66d:4994:b79a with SMTP id
 kv6-20020a056214534600b0066d4994b79amr488248qvb.5.1698346921100; 
 Thu, 26 Oct 2023 12:02:01 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a0cf98b000000b006655cc8f872sm16257qvn.99.2023.10.26.12.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 12:02:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, quintela@redhat.com,
 joao.m.martins@oracle.com
Subject: [PATCH 4/3] migration: Add tracepoints for downtime checkpoints
Date: Thu, 26 Oct 2023 15:01:59 -0400
Message-ID: <20231026190159.608025-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026155337.596281-1-peterx@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
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

Add tracepoints for major downtime checkpoints on both src and dst.  They
share the same tracepoint with a string showing its stage.

On src, we have these checkpoints added:

  - downtime-start: right before vm stops on src
  - vm-stopped: after vm is fully stopped
  - iterable-saved: after all iterables saved (END sections)
  - non-iterable-saved: after all non-iterable saved (FULL sections)
  - downtime-stop: migration fully completed

On dst, we have these checkpoints added:

  - precopy-loadvm-completes: after loadvm all done for precopy
  - precopy-bh-*: record BH steps to resume VM for precopy
  - postcopy-bh-*: record BH steps to resume VM for postcopy

On dst side, we don't have a good way to trace total time consumed by
iterable or non-iterable for now.  We can mark it by 1st time receiving a
FULL / END section, but rather than that let's just rely on the other
tracepoints added for vmstates to back up the information.

Until this patch, one can enable "vmstate_downtime*" and it'll enable all
tracepoints for downtime measurements.

Since the downtime timestamp tracepoints will cover postcopy too, drop
loadvm_postcopy_handle_run_bh() tracepoint alongside, because they service
the same purpose, but that only for postcopy.  We then have unified prefix
for all downtime relevant tracepoints.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 16 +++++++++++++++-
 migration/savevm.c     | 14 +++++++++-----
 migration/trace-events |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9013c1b500..f1f1d2ae2b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -103,6 +103,7 @@ static int close_return_path_on_source(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
+    trace_vmstate_downtime_timestamp("downtime-start");
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 }
 
@@ -117,6 +118,8 @@ static void migration_downtime_end(MigrationState *s)
     if (!s->downtime) {
         s->downtime = now - s->downtime_start;
     }
+
+    trace_vmstate_downtime_timestamp("downtime-end");
 }
 
 static bool migration_needs_multiple_sockets(void)
@@ -151,7 +154,11 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
 
 int migration_stop_vm(RunState state)
 {
-    return vm_stop_force_state(state);
+    int ret = vm_stop_force_state(state);
+
+    trace_vmstate_downtime_timestamp("vm-stopped");
+
+    return ret;
 }
 
 void migration_object_init(void)
@@ -500,6 +507,8 @@ static void process_incoming_migration_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
+    trace_vmstate_downtime_timestamp("precopy-bh-enter");
+
     /* If capability late_block_activate is set:
      * Only fire up the block code now if we're going to restart the
      * VM, else 'cont' will do it.
@@ -525,6 +534,8 @@ static void process_incoming_migration_bh(void *opaque)
      */
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
+    trace_vmstate_downtime_timestamp("precopy-bh-announced");
+
     multifd_load_shutdown();
 
     dirty_bitmap_mig_before_vm_start();
@@ -542,6 +553,7 @@ static void process_incoming_migration_bh(void *opaque)
     } else {
         runstate_set(global_state_get_runstate());
     }
+    trace_vmstate_downtime_timestamp("precopy-bh-vm-started");
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -576,6 +588,8 @@ process_incoming_migration_co(void *opaque)
     ret = qemu_loadvm_state(mis->from_src_file);
     mis->loadvm_co = NULL;
 
+    trace_vmstate_downtime_timestamp("precopy-loadvm-completed");
+
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
     if (ps != POSTCOPY_INCOMING_NONE) {
diff --git a/migration/savevm.c b/migration/savevm.c
index cd6d6ba493..49cbbd151c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1494,6 +1494,8 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                                     end_ts_each - start_ts_each);
     }
 
+    trace_vmstate_downtime_timestamp("iterable-saved");
+
     return 0;
 }
 
@@ -1560,6 +1562,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     json_writer_free(vmdesc);
     ms->vmdesc = NULL;
 
+    trace_vmstate_downtime_timestamp("non-iterable-saved");
+
     return 0;
 }
 
@@ -2102,18 +2106,18 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
-    trace_loadvm_postcopy_handle_run_bh("enter");
+    trace_vmstate_downtime_timestamp("postcopy-bh-enter");
 
     /* TODO we should move all of this lot into postcopy_ram.c or a shared code
      * in migration.c
      */
     cpu_synchronize_all_post_init();
 
-    trace_loadvm_postcopy_handle_run_bh("after cpu sync");
+    trace_vmstate_downtime_timestamp("postcopy-bh-cpu-synced");
 
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
-    trace_loadvm_postcopy_handle_run_bh("after announce");
+    trace_vmstate_downtime_timestamp("postcopy-bh-announced");
 
     /* Make sure all file formats throw away their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
@@ -2124,7 +2128,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         autostart = false;
     }
 
-    trace_loadvm_postcopy_handle_run_bh("after invalidate cache");
+    trace_vmstate_downtime_timestamp("postcopy-bh-cache-invalidated");
 
     dirty_bitmap_mig_before_vm_start();
 
@@ -2138,7 +2142,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     qemu_bh_delete(mis->bh);
 
-    trace_loadvm_postcopy_handle_run_bh("return");
+    trace_vmstate_downtime_timestamp("postcopy-bh-vm-started");
 }
 
 /* After all discards we can start running and asking for pages */
diff --git a/migration/trace-events b/migration/trace-events
index 5820add1f3..aebdd939b7 100644
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
+vmstate_downtime_timestamp(const char *checkpoint) "%s"
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
-- 
2.41.0


