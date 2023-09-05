Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C5792F17
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdbsL-0007k9-Ck; Tue, 05 Sep 2023 15:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdbsJ-0007im-6f
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdbsG-0004ek-FY
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693942688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcbHiXE35RdmKC0uG+xgF+5iLpnAvqPrtfhNonGZXto=;
 b=CMCW14kzqD61V0zBak4serAqN2DUYFLktkMtu2ZG3ZiDdKX68mihN4JkaiVQi4Y9AxFk3N
 FMHthswdmhUGS26dHs02Wb+p4swyX0gr2eLzyz9B8l2Xv1EJ22KSewgaW0DXeYCBWLISD/
 phYKKPF7763zz7tnXCfydy5BTG+NENI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-9iXv5cuvMJqsKLZt7B-K1g-1; Tue, 05 Sep 2023 15:38:06 -0400
X-MC-Unique: 9iXv5cuvMJqsKLZt7B-K1g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6515b44388fso4321826d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 12:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693942686; x=1694547486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcbHiXE35RdmKC0uG+xgF+5iLpnAvqPrtfhNonGZXto=;
 b=es9GmfSshp44WTjjwaaEcfZ5o42cX/noh4rsBHX1HF516v5TTsFOyn99IN54pWZ3to
 6R9Ra5sNYfJ5uN6H/RbIionn0qz2rWALGyJTtT4+A9Bl3j8aQEQJuZcfvIkCtddRtWAd
 D8G32dIC8/KYg7iMhZP8bSmvPqUqqUi9AecJxkHpP42vps3ND24g9djN2FC4I8aqXJOJ
 0HxV21zhPd5Nhncjg/adUinOzkPQjHd5ZjjT6PbszMo9r1vgiDD/2oevOkbIUJOmP1aF
 hqCrsUoGFzVNwD81Ei6x+qVZg55DUWdLMiGno+Fbg7DXIBjLoRpvGNPfhvsodJMWD/Ty
 JdvQ==
X-Gm-Message-State: AOJu0YwpaCynZNUQIvmuusOqil8+lGewJFq44YmxQM+ll3VT4/PrBblV
 gtECPDd0Pq3LqK6qN08eXv6Qs9i5PDYwEW8QLy4NLV23QlH2RNfPzI/QUrHUP6on3yd0KhEWszp
 iunHR8DAd6QPCMgiXXCkElYbDtZVdqFfpJE9LOa7bOtbMyviBDNjnlpx4sOFfJXzkQNBpxn13
X-Received: by 2002:a05:6214:262b:b0:63c:f852:aa30 with SMTP id
 gv11-20020a056214262b00b0063cf852aa30mr15781664qvb.0.1693942685937; 
 Tue, 05 Sep 2023 12:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmYoudMGgr6fAaeusCbg3gTmg5Bo/o8XW2vTNjiIg7R3WWoZhjso0m/NR0iaM+WB9P2+2IfA==
X-Received: by 2002:a05:6214:262b:b0:63c:f852:aa30 with SMTP id
 gv11-20020a056214262b00b0063cf852aa30mr15781623qvb.0.1693942685422; 
 Tue, 05 Sep 2023 12:38:05 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a05620a074200b007676f3859fasm4332780qki.30.2023.09.05.12.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 12:38:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Fabiano Rosas <farosas@suse.de>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, lei4.wang@intel.com
Subject: [PATCH v3 1/1] migration: Allow user to specify available switchover
 bandwidth
Date: Tue,  5 Sep 2023 15:38:02 -0400
Message-ID: <20230905193802.250440-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905193802.250440-1-peterx@redhat.com>
References: <20230905193802.250440-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 11 +++++++++++
 migration/migration.h          |  2 +-
 migration/options.h            |  2 ++
 migration/migration-hmp-cmds.c | 14 ++++++++++++++
 migration/migration.c          | 24 +++++++++++++++++++++---
 migration/options.c            | 25 +++++++++++++++++++++++++
 migration/trace-events         |  2 +-
 7 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index eeb1878c4f..49c36ec9c0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -766,6 +766,16 @@
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
@@ -856,6 +866,7 @@
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'size',
+            '*avail-switchover-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db36..ce910c1db2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -283,7 +283,7 @@ struct MigrationState {
     /*
      * The final stage happens when the remaining data is smaller than
      * this threshold; it's calculated from the requested downtime and
-     * measured bandwidth
+     * measured bandwidth, or avail-switchover-bandwidth if specified.
      */
     int64_t threshold_size;
 
diff --git a/migration/options.h b/migration/options.h
index 4591545c62..d78b437e82 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -83,6 +83,7 @@ typedef enum {
     MIGRATION_PARAMETER_TLS_HOSTNAME,
     MIGRATION_PARAMETER_TLS_AUTHZ,
     MIGRATION_PARAMETER_MAX_BANDWIDTH,
+    MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH,
     MIGRATION_PARAMETER_DOWNTIME_LIMIT,
     MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
     MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
@@ -128,6 +129,7 @@ int migrate_decompress_threads(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
+uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a35a87b7e..07a98a4636 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -327,6 +327,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
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
@@ -577,6 +581,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 5528acb65e..85be4f019b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2684,17 +2684,33 @@ static void migration_update_counters(MigrationState *s,
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
@@ -2711,7 +2727,7 @@ static void migration_update_counters(MigrationState *s,
     if (stat64_get(&mig_stats.dirty_pages_rate) &&
         transferred > 10000) {
         s->expected_downtime =
-            stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
+            stat64_get(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
     }
 
     migration_rate_reset(s->to_dst_file);
@@ -2719,7 +2735,9 @@ static void migration_update_counters(MigrationState *s,
     update_iteration_initial_status(s);
 
     trace_migrate_transferred(transferred, time_spent,
-                              bandwidth, s->threshold_size);
+                              /* Both in unit bytes/ms */
+                              bandwidth, switchover_bw / 1000,
+                              s->threshold_size);
 }
 
 static bool migration_can_switchover(MigrationState *s)
diff --git a/migration/options.c b/migration/options.c
index c9b90d932d..65d0b58fa9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -101,6 +101,7 @@ const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX] = {
     [MIGRATION_PARAMETER_TLS_HOSTNAME] = "tls-hostname",
     [MIGRATION_PARAMETER_TLS_AUTHZ] = "tls-authz",
     [MIGRATION_PARAMETER_MAX_BANDWIDTH] = "max-bandwidth",
+    [MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH] = "avail-switchover-bandwidth",
     [MIGRATION_PARAMETER_DOWNTIME_LIMIT] = "downtime-limit",
     [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] = "x-checkpoint-delay",
     [MIGRATION_PARAMETER_BLOCK_INCREMENTAL] = "block-incremental",
@@ -176,6 +177,8 @@ Property migration_properties[] = {
                       parameters.cpu_throttle_tailslow, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
+    DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
+                      parameters.avail_switchover_bandwidth, 0),
     DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
                       parameters.downtime_limit,
                       DEFAULT_MIGRATE_SET_DOWNTIME),
@@ -868,6 +871,13 @@ uint64_t migrate_max_bandwidth(void)
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
@@ -1004,6 +1014,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
+    params->has_avail_switchover_bandwidth = true;
+    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
     params->has_downtime_limit = true;
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
@@ -1144,6 +1156,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
@@ -1320,6 +1341,10 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
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
index 4666f19325..ebd88de3d0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -185,7 +185,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
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


