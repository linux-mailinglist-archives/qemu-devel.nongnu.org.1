Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1875FCEE
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNz2U-0005Tg-8S; Mon, 24 Jul 2023 13:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qNz2S-0005TQ-Kv
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qNz2Q-0001dV-FV
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690218480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SA6tmAx0h2egU25MTetYT9YHvxI7Gy/nL9LdMw+zDv4=;
 b=Kr0QVQ8Okj80u6GQCd1QNxWTJDsKRPDcsn3/WY8vR6xtjkV3T7dVTjBGUyotO61R39zW6e
 O6Oir5fQJVDcaLptlCqHheVU7o3yR+15pSviL6xU2nrhAzbITGIyjfa0AMczavWioXAA5L
 dx99aG7fT5JH0Tdq//DoO0l0NTmPfyE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-jet6PhHjP4qgtiKEazS5Ng-1; Mon, 24 Jul 2023 13:07:58 -0400
X-MC-Unique: jet6PhHjP4qgtiKEazS5Ng-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63c9463c116so12350896d6.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 10:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690218478; x=1690823278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SA6tmAx0h2egU25MTetYT9YHvxI7Gy/nL9LdMw+zDv4=;
 b=SiovlC4dY9IeDj/wN7Gglvx3M6p2FC7lIpjyXbNoWHFKqoZcjKwraYpOMhp/y/Hf2m
 UFfvAGmGOUkoScoj0FKXC8Osjk217lj/xQln+6mO4AzHsE8DECJeUdfH0c4uduGZiDPm
 cPQdGmiGZNseWXULbWjAgVBjTtEysCgKd+kWyu69iISOkGFgyO92wyrxJXOJezjN90dI
 rglsbozJpDvFi5G2jcq6jvampboZ8uJg/npSzB7dO93I8+LjC0ZNIV2gI2MmtAJPTaev
 JWIiy8+C0GzSHHg25Ro0We8juqur4+aFNm43EWl0ujqH1DS5/YebRKA0Md1E14JxDSfe
 4KiQ==
X-Gm-Message-State: ABy/qLaKEJJ+lwlHsS1z/3xWuDqvktiVCgDDYurYfqzD/N68JeuxUGf3
 GIUyrLMI4xsjSpgCWi9IfCxD8vmzoJHP/SeHvGVkHuswy76eMAsENAOKkNLfRc5+ZH1wFOz5TfD
 8E4Jy5iSk2qz4eB/COsnsAO3G6qFir3FQpIG+CBC3jBkKYhYFzfaRvAMLTT7IRVXkgFKg4tZQ
X-Received: by 2002:a05:6214:508c:b0:63c:f495:b8d6 with SMTP id
 kk12-20020a056214508c00b0063cf495b8d6mr7160543qvb.5.1690218477944; 
 Mon, 24 Jul 2023 10:07:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5vl4tGIY+qmjg3ygkb9PMNXGe+P5rb1Q9sCJKnQMI5rXGs+uM5Svngm50l5IQhUMefDanOg==
X-Received: by 2002:a05:6214:508c:b0:63c:f495:b8d6 with SMTP id
 kk12-20020a056214508c00b0063cf495b8d6mr7160506qvb.5.1690218477519; 
 Mon, 24 Jul 2023 10:07:57 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a0c9702000000b0063612e03433sm3667223qvd.101.2023.07.24.10.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 10:07:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: Allow user to specify migration available bandwidth
Date: Mon, 24 Jul 2023 13:07:55 -0400
Message-ID: <20230724170755.1114519-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Migration bandwidth is a very important value to live migration.  It's
because it's one of the major factors that we'll make decision on when to
switchover to destination in a precopy process.

This value is currently estimated by QEMU during the whole live migration
process by monitoring how fast we were sending the data.  This can be the
most accurate bandwidth if in the ideal world, where we're always feeding
unlimited data to the migration channel, and then it'll be limited to the
bandwidth that is available.

However in reality it may be very different, e.g., over a 10Gbps network we
can see query-migrate showing migration bandwidth of only a few tens of
MB/s just because there are plenty of other things the migration thread
might be doing.  For example, the migration thread can be busy scanning
zero pages, or it can be fetching dirty bitmap from other external dirty
sources (like vhost or KVM).  It means we may not be pushing data as much
as possible to migration channel, so the bandwidth estimated from "how many
data we sent in the channel" can be dramatically inaccurate sometimes,
e.g., that a few tens of MB/s even if 10Gbps available, and then the
decision to switchover will be further affected by this.

The migration may not even converge at all with the downtime specified,
with that wrong estimation of bandwidth.

The issue is QEMU itself may not be able to avoid those uncertainties on
measuing the real "available migration bandwidth".  At least not something
I can think of so far.

One way to fix this is when the user is fully aware of the available
bandwidth, then we can allow the user to help providing an accurate value.

For example, if the user has a dedicated channel of 10Gbps for migration
for this specific VM, the user can specify this bandwidth so QEMU can
always do the calculation based on this fact, trusting the user as long as
specified.

When the user wants to have migration only use 5Gbps out of that 10Gbps,
one can set max-bandwidth to 5Gbps, along with available-bandwidth to 5Gbps
so it'll never use over 5Gbps too (so the user can have the rest 5Gbps for
other things).  So it can be useful even if the network is not dedicated,
but as long as the user can know a solid value.

A new parameter "available-bandwidth" is introduced just for this. So when
the user specified this parameter, instead of trusting the estimated value
from QEMU itself (based on the QEMUFile send speed), let's trust the user
more.

This can resolve issues like "unconvergence migration" which is caused by
hilarious low "migration bandwidth" detected for whatever reason.

Reported-by: Zhiyi Guo <zhguo@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 20 +++++++++++++++++++-
 migration/migration.h          |  2 +-
 migration/options.h            |  1 +
 migration/migration-hmp-cmds.c | 14 ++++++++++++++
 migration/migration.c          | 19 +++++++++++++++----
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 migration/trace-events         |  2 +-
 7 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 47dfef0278..fdc269e0a1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -730,6 +730,16 @@
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
+# @available-bandwidth: to set available bandwidth for migration.  By
+#     default, this value is zero, means the user is not aware of the
+#     available bandwidth that can be used by QEMU migration, so QEMU will
+#     estimate the bandwidth automatically.  This can be set when the
+#     estimated value is not accurate, while the user is able to guarantee
+#     such bandwidth is available for migration purpose during the
+#     migration procedure.  When specified correctly, this can make the
+#     switchover decision much more accurate, which will also be based on
+#     the max downtime specified.  (Since 8.2)
+#
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
@@ -803,7 +813,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'downtime-limit',
+           'available-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            'block-incremental',
            'multifd-channels',
@@ -886,6 +896,9 @@
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
+# @available-bandwidth: to set available migration bandwidth.  Please refer
+#     to comments in MigrationParameter for more information. (Since 8.2)
+#
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
@@ -971,6 +984,7 @@
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'size',
+            '*available-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
@@ -1078,6 +1092,9 @@
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
+# @available-bandwidth: to set available migration bandwidth.  Please refer
+#     to comments in MigrationParameter for more information. (Since 8.2)
+#
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
@@ -1160,6 +1177,7 @@
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
             '*max-bandwidth': 'size',
+            '*available-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
diff --git a/migration/migration.h b/migration/migration.h
index b7c8b67542..fadbf64d9d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -283,7 +283,7 @@ struct MigrationState {
     /*
      * The final stage happens when the remaining data is smaller than
      * this threshold; it's calculated from the requested downtime and
-     * measured bandwidth
+     * measured bandwidth, or available-bandwidth if user specified.
      */
     int64_t threshold_size;
 
diff --git a/migration/options.h b/migration/options.h
index 9aaf363322..ed2d9c92e7 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -79,6 +79,7 @@ int migrate_decompress_threads(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
+uint64_t migrate_available_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..53fbe1b1af 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -311,6 +311,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
+        assert(params->has_available_bandwidth);
+        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_AVAILABLE_BANDWIDTH),
+            params->available_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
@@ -556,6 +560,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         }
         p->max_bandwidth = valuebw;
         break;
+    case MIGRATION_PARAMETER_AVAILABLE_BANDWIDTH:
+        p->has_available_bandwidth = true;
+        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
+        if (ret < 0 || valuebw > INT64_MAX
+            || (size_t)valuebw != valuebw) {
+            error_setg(&err, "Invalid size %s", valuestr);
+            break;
+        }
+        p->available_bandwidth = valuebw;
+        break;
     case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
         p->has_downtime_limit = true;
         visit_type_size(v, param, &p->downtime_limit, &err);
diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..391ddfd8ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2671,7 +2671,7 @@ static void migration_update_counters(MigrationState *s,
 {
     uint64_t transferred, transferred_pages, time_spent;
     uint64_t current_bytes; /* bytes transferred since the beginning */
-    double bandwidth;
+    double bandwidth, avail_bw;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
         return;
@@ -2681,7 +2681,17 @@ static void migration_update_counters(MigrationState *s,
     transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-    s->threshold_size = bandwidth * migrate_downtime_limit();
+    if (migrate_available_bandwidth()) {
+        /*
+         * If the user specified an available bandwidth, let's trust the
+         * user so that can be more accurate than what we estimated.
+         */
+        avail_bw = migrate_available_bandwidth();
+    } else {
+        /* If the user doesn't specify bandwidth, we use the estimated */
+        avail_bw = bandwidth;
+    }
+    s->threshold_size = avail_bw * migrate_downtime_limit();
 
     s->mbps = (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
@@ -2698,7 +2708,7 @@ static void migration_update_counters(MigrationState *s,
     if (stat64_get(&mig_stats.dirty_pages_rate) &&
         transferred > 10000) {
         s->expected_downtime =
-            stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
+            stat64_get(&mig_stats.dirty_bytes_last_sync) / avail_bw;
     }
 
     migration_rate_reset(s->to_dst_file);
@@ -2706,7 +2716,8 @@ static void migration_update_counters(MigrationState *s,
     update_iteration_initial_status(s);
 
     trace_migrate_transferred(transferred, time_spent,
-                              bandwidth, s->threshold_size);
+                              bandwidth, migrate_available_bandwidth(),
+                              s->threshold_size);
 }
 
 static bool migration_can_switchover(MigrationState *s)
diff --git a/migration/options.c b/migration/options.c
index 5a9505adf7..160faca71a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -121,6 +121,8 @@ Property migration_properties[] = {
                       parameters.cpu_throttle_tailslow, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
+    DEFINE_PROP_SIZE("available-bandwidth", MigrationState,
+                      parameters.available_bandwidth, 0),
     DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
                       parameters.downtime_limit,
                       DEFAULT_MIGRATE_SET_DOWNTIME),
@@ -735,6 +737,13 @@ uint64_t migrate_max_bandwidth(void)
     return s->parameters.max_bandwidth;
 }
 
+uint64_t migrate_available_bandwidth(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.available_bandwidth;
+}
+
 uint64_t migrate_max_postcopy_bandwidth(void)
 {
     MigrationState *s = migrate_get_current();
@@ -872,6 +881,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
                                  s->parameters.tls_authz : "");
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
+    params->has_available_bandwidth = true;
+    params->available_bandwidth = s->parameters.available_bandwidth;
     params->has_downtime_limit = true;
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
@@ -1004,6 +1015,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_available_bandwidth &&
+        (params->available_bandwidth > SIZE_MAX)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "available_bandwidth",
+                   "an integer in the range of 0 to "stringify(SIZE_MAX)
+                   " bytes/second");
+        return false;
+    }
+
     if (params->has_downtime_limit &&
         (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
@@ -1156,6 +1176,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->max_bandwidth = params->max_bandwidth;
     }
 
+    if (params->has_available_bandwidth) {
+        dest->available_bandwidth = params->available_bandwidth;
+    }
+
     if (params->has_downtime_limit) {
         dest->downtime_limit = params->downtime_limit;
     }
@@ -1264,6 +1288,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         }
     }
 
+    if (params->has_available_bandwidth) {
+        s->parameters.available_bandwidth = params->available_bandwidth;
+    }
+
     if (params->has_downtime_limit) {
         s->parameters.downtime_limit = params->downtime_limit;
     }
diff --git a/migration/trace-events b/migration/trace-events
index 5259c1044b..fffed1f995 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -184,7 +184,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
-migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
+migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " avail_bw %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
-- 
2.41.0


