Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A67C43A3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 00:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqL4l-0006QE-8d; Tue, 10 Oct 2023 18:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqL4j-0006Pg-6V
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 18:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqL4g-0002M6-KV
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 18:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696976372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nfgpIn9CMgy05/adUXMRAOEGRz4csPqjLFFOXlE5SsQ=;
 b=Bd/Pdf6v2ft/n1zQSSTjewp0ihcV3F6mDtVyvSfxi6g6x5qkDPjsFJaRRytOjfouWGye0Y
 aDgt9KRo4OvoKs5fQZYqmdPrMKPHxfnWMCFBSEXOfS91UyeqYH7zgz4IhWYYI2/BwM58Rg
 J/8XkjxTzd7hJREfi4mXo4lfgkZDFd0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-mFVEkVffMPmPXflk3fabEg-1; Tue, 10 Oct 2023 18:19:30 -0400
X-MC-Unique: mFVEkVffMPmPXflk3fabEg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1dd069c6112so1521214fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 15:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696976370; x=1697581170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfgpIn9CMgy05/adUXMRAOEGRz4csPqjLFFOXlE5SsQ=;
 b=veQ/cPXzn42/oQHuEnAIZucoBFX1OZ2PlmI5rc8boOFM3NICg+ZRiJmFxGzOucpdDa
 J3ka4kc/bV5v3vtZ01970i8QfZ6wj94WoneWsaWZ52xLBRw9ktlquM9BMyqB2N2rjTmX
 BPxrgM01mt9Y8k4hB/r5Zj3L36xdP22GAe73bFxlNCM2kOBQDBCe/mdejdr1oO3JKNhP
 5GenzufYJK4m2rX4XN8QTwOQwsbMikrcpZ34queOucCoD1p04+DPRLbfdomsl1dv4GQZ
 RzGrS0eLQyol9UD3VGki9C0pEcCZCG0pER0czKZJczz2m9Zr5oytxUTqhvtKTvgYRyYZ
 F1MQ==
X-Gm-Message-State: AOJu0YyGhq/ak7h4YE5rz5v+wYdOTDhudGdWWevUc61K4bCYknLW6SHg
 dGqQzSadcLVUtCs5SZKVDCgqrLHkTbr8VO6fvAggrCFARNfHce+A9HrxqCZvPyW+mKJUbSZh7hq
 2SUVQ1fTlKZeH9LZrTI/CS5BWYL9orc51p/Pi13rFrgaywK8yw5Bws0HsE7AS7QANJjS/vItY
X-Received: by 2002:a05:6870:798c:b0:1e9:83d5:9227 with SMTP id
 he12-20020a056870798c00b001e983d59227mr1487723oab.3.1696976369630; 
 Tue, 10 Oct 2023 15:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLOAuGqSoF7xlkiffuT4gB4Yq5+mk8zKq5EJf0UdNxM8uzSeQ6Pg7jN1JSNFjq7+uXCtPW9Q==
X-Received: by 2002:a05:6870:798c:b0:1e9:83d5:9227 with SMTP id
 he12-20020a056870798c00b001e983d59227mr1487694oab.3.1696976369068; 
 Tue, 10 Oct 2023 15:19:29 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a05620a074f00b0076c96e571f3sm4713601qki.26.2023.10.10.15.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 15:19:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Chensheng Dong <chdong@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Eric Blake <eblake@redhat.com>, Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4] migration: Allow user to specify available switchover
 bandwidth
Date: Tue, 10 Oct 2023 18:19:22 -0400
Message-ID: <20231010221922.40638-1-peterx@redhat.com>
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
data we sent in the channel" can be dramatically inaccurate sometimes.

With that, the decision to switchover will be affected, by assuming that we
may not be able to switchover at all with such a low bandwidth, but in
reality we can.

The migration may not even converge at all with the downtime specified,
with that wrong estimation of bandwidth, keeping iterations forever with a
low estimation of bandwidth.

The issue is QEMU itself may not be able to avoid those uncertainties on
measuing the real "available migration bandwidth".  At least not something
I can think of so far.

One way to fix this is when the user is fully aware of the available
bandwidth, then we can allow the user to help providing an accurate value.

For example, if the user has a dedicated channel of 10Gbps for migration
for this specific VM, the user can specify this bandwidth so QEMU can
always do the calculation based on this fact, trusting the user as long as
specified.  It may not be the exact bandwidth when switching over (in which
case qemu will push migration data as fast as possible), but much better
than QEMU trying to wildly guess, especially when very wrong.

A new parameter "avail-switchover-bandwidth" is introduced just for this.
So when the user specified this parameter, instead of trusting the
estimated value from QEMU itself (based on the QEMUFile send speed), it
trusts the user more by using this value to decide when to switchover,
assuming that we'll have such bandwidth available then.

Note that specifying this value will not throttle the bandwidth for
switchover yet, so QEMU will always use the full bandwidth possible for
sending switchover data, assuming that should always be the most important
way to use the network at that time.

This can resolve issues like "unconvergence migration" which is caused by
hilarious low "migration bandwidth" detected for whatever reason.

Reported-by: Zhiyi Guo <zhguo@redhat.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v4:
- Rebase to master, with duplicated documentations
---
 qapi/migration.json            | 34 +++++++++++++++++++++++++++++++++-
 migration/migration.h          |  2 +-
 migration/options.h            |  1 +
 migration/migration-hmp-cmds.c | 14 ++++++++++++++
 migration/migration.c          | 24 +++++++++++++++++++++---
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 migration/trace-events         |  2 +-
 7 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..0c897a99b1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -759,6 +759,16 @@
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
+# @avail-switchover-bandwidth: to set the available bandwidth that
+#     migration can use during switchover phase.  NOTE!  This does not
+#     limit the bandwidth during switchover, but only for calculations when
+#     making decisions to switchover.  By default, this value is zero,
+#     which means QEMU will estimate the bandwidth automatically.  This can
+#     be set when the estimated value is not accurate, while the user is
+#     able to guarantee such bandwidth is available when switching over.
+#     When specified correctly, this can make the switchover decision much
+#     more accurate.  (Since 8.2)
+#
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
@@ -840,7 +850,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'downtime-limit',
+           'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            'block-incremental',
            'multifd-channels',
@@ -925,6 +935,16 @@
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
+# @avail-switchover-bandwidth: to set the available bandwidth that
+#     migration can use during switchover phase.  NOTE!  This does not
+#     limit the bandwidth during switchover, but only for calculations when
+#     making decisions to switchover.  By default, this value is zero,
+#     which means QEMU will estimate the bandwidth automatically.  This can
+#     be set when the estimated value is not accurate, while the user is
+#     able to guarantee such bandwidth is available when switching over.
+#     When specified correctly, this can make the switchover decision much
+#     more accurate.  (Since 8.2)
+#
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
@@ -1018,6 +1038,7 @@
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'size',
+            '*avail-switchover-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
@@ -1128,6 +1149,16 @@
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
+# @avail-switchover-bandwidth: to set the available bandwidth that
+#     migration can use during switchover phase.  NOTE!  This does not
+#     limit the bandwidth during switchover, but only for calculations when
+#     making decisions to switchover.  By default, this value is zero,
+#     which means QEMU will estimate the bandwidth automatically.  This can
+#     be set when the estimated value is not accurate, while the user is
+#     able to guarantee such bandwidth is available when switching over.
+#     When specified correctly, this can make the switchover decision much
+#     more accurate.  (Since 8.2)
+#
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
@@ -1218,6 +1249,7 @@
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
             '*max-bandwidth': 'size',
+            '*avail-switchover-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
diff --git a/migration/migration.h b/migration/migration.h
index 972597f4de..475f442fe6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -294,7 +294,7 @@ struct MigrationState {
     /*
      * The final stage happens when the remaining data is smaller than
      * this threshold; it's calculated from the requested downtime and
-     * measured bandwidth
+     * measured bandwidth, or avail-switchover-bandwidth if specified.
      */
     int64_t threshold_size;
 
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..93ee938ab8 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -80,6 +80,7 @@ int migrate_decompress_threads(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
+uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..2291b1b9b1 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -321,6 +321,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
+        assert(params->has_avail_switchover_bandwidth);
+        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
+            params->avail_switchover_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
@@ -574,6 +578,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         }
         p->max_bandwidth = valuebw;
         break;
+    case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
+        p->has_avail_switchover_bandwidth = true;
+        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
+        if (ret < 0 || valuebw > INT64_MAX
+            || (size_t)valuebw != valuebw) {
+            error_setg(&err, "Invalid size %s", valuestr);
+            break;
+        }
+        p->avail_switchover_bandwidth = valuebw;
+        break;
     case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
         p->has_downtime_limit = true;
         visit_type_size(v, param, &p->downtime_limit, &err);
diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..2ec4a761cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2667,17 +2667,33 @@ static void migration_update_counters(MigrationState *s,
 {
     uint64_t transferred, transferred_pages, time_spent;
     uint64_t current_bytes; /* bytes transferred since the beginning */
+    uint64_t switchover_bw;
+    /* Expected bandwidth when switching over to destination QEMU */
+    double expected_bw_per_ms;
     double bandwidth;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
         return;
     }
 
+    switchover_bw = migrate_avail_switchover_bandwidth();
     current_bytes = migration_transferred_bytes(s->to_dst_file);
     transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-    s->threshold_size = bandwidth * migrate_downtime_limit();
+
+    if (switchover_bw) {
+        /*
+         * If the user specified a switchover bandwidth, let's trust the
+         * user so that can be more accurate than what we estimated.
+         */
+        expected_bw_per_ms = switchover_bw / 1000;
+    } else {
+        /* If the user doesn't specify bandwidth, we use the estimated */
+        expected_bw_per_ms = bandwidth;
+    }
+
+    s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
 
     s->mbps = (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
@@ -2694,7 +2710,7 @@ static void migration_update_counters(MigrationState *s,
     if (stat64_get(&mig_stats.dirty_pages_rate) &&
         transferred > 10000) {
         s->expected_downtime =
-            stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
+            stat64_get(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
     }
 
     migration_rate_reset(s->to_dst_file);
@@ -2702,7 +2718,9 @@ static void migration_update_counters(MigrationState *s,
     update_iteration_initial_status(s);
 
     trace_migrate_transferred(transferred, time_spent,
-                              bandwidth, s->threshold_size);
+                              /* Both in unit bytes/ms */
+                              bandwidth, switchover_bw / 1000,
+                              s->threshold_size);
 }
 
 static bool migration_can_switchover(MigrationState *s)
diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..da87652791 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -125,6 +125,8 @@ Property migration_properties[] = {
                       parameters.cpu_throttle_tailslow, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
+    DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
+                      parameters.avail_switchover_bandwidth, 0),
     DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
                       parameters.downtime_limit,
                       DEFAULT_MIGRATE_SET_DOWNTIME),
@@ -780,6 +782,13 @@ uint64_t migrate_max_bandwidth(void)
     return s->parameters.max_bandwidth;
 }
 
+uint64_t migrate_avail_switchover_bandwidth(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.avail_switchover_bandwidth;
+}
+
 uint64_t migrate_max_postcopy_bandwidth(void)
 {
     MigrationState *s = migrate_get_current();
@@ -917,6 +926,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
                                  s->parameters.tls_authz : "");
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
+    params->has_avail_switchover_bandwidth = true;
+    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
     params->has_downtime_limit = true;
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
@@ -1056,6 +1067,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_avail_switchover_bandwidth &&
+        (params->avail_switchover_bandwidth > SIZE_MAX)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "avail_switchover_bandwidth",
+                   "an integer in the range of 0 to "stringify(SIZE_MAX)
+                   " bytes/second");
+        return false;
+    }
+
     if (params->has_downtime_limit &&
         (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
@@ -1225,6 +1245,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->max_bandwidth = params->max_bandwidth;
     }
 
+    if (params->has_avail_switchover_bandwidth) {
+        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
+    }
+
     if (params->has_downtime_limit) {
         dest->downtime_limit = params->downtime_limit;
     }
@@ -1341,6 +1365,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         }
     }
 
+    if (params->has_avail_switchover_bandwidth) {
+        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
+    }
+
     if (params->has_downtime_limit) {
         s->parameters.downtime_limit = params->downtime_limit;
     }
diff --git a/migration/trace-events b/migration/trace-events
index 002abe3a4e..2d266bf087 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -186,7 +186,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
-migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
+migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
-- 
2.41.0


