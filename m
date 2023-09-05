Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9F7925B0
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYqG-0005C0-VX; Tue, 05 Sep 2023 12:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYqE-0005BP-K7
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYqA-00066B-JE
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:49 -0400
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-wzQkGgSUNDGsihf808mT3Q-1; Tue, 05 Sep 2023 12:23:43 -0400
X-MC-Unique: wzQkGgSUNDGsihf808mT3Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-64726969c8bso3986416d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693931022; x=1694535822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B17zXPGoK4sB4OfBqgrVVRRtVE/q5bKYAQr0v4BLlzI=;
 b=cthLzBECaPJNOvaGakjrsjxvn0JD1LyLgkDSr9Tci1Ozl6AsGOOk5ifmZvf4FoyYeP
 yOXUPk3e6g3c98cWhQC0bDzBky6mUlWBj7bTMFUkWXvql3EPiqs+z3kt5zaLoBR8PXlI
 87F9dcVuJOFLovdzr+EIhWlueqbv3aITWEehdpDFy1AMigzq0LVe1s15NT7FrfBHYnKL
 TwxOsYEn7q2nMSBjt0+WmG1NFD0G5aIZNtfv3oRd28WtzLbDPNOtroXXnlHC4oo2doyh
 /vxrrc8Wxb3xMQO+XvK1IoXJuvG8vXmenF/FVDwEFm6iHtPhVnwn3d9ijL9KA7xAeOv6
 IC6A==
X-Gm-Message-State: AOJu0Ywcs4oyGsZYYMlMiK8E8WICAtDVCgeg2I7LdZZhJNwHAbUQtyDM
 lEBS2mvPl2NUVwXlnWF1P6BBjjmAFs4dblfV7iC/MSIJZIhNSguCyZdLlCO/cJrJiBwPsvmt01Z
 tKbFghgwyqdD2GlcBG3Vpy04zDxRp4t1J6YRexYfUEg+Co4Cb9dQTrENF/rnbSboPG2Ch/Rkr
X-Received: by 2002:a05:6214:f69:b0:649:5f43:245f with SMTP id
 iy9-20020a0562140f6900b006495f43245fmr15200518qvb.6.1693931021663; 
 Tue, 05 Sep 2023 09:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbu3Z5UW/xOhHf8E6nNHjNvOXKQIOvqlNHvDo2pReZUliF5jzkIESluh9v8zaSliQGfzvWDw==
X-Received: by 2002:a05:6214:f69:b0:649:5f43:245f with SMTP id
 iy9-20020a0562140f6900b006495f43245fmr15200487qvb.6.1693931021113; 
 Tue, 05 Sep 2023 09:23:41 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a0cf1d0000000b0063d281e22f1sm4581675qvl.17.2023.09.05.09.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:23:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Date: Tue,  5 Sep 2023 12:23:35 -0400
Message-ID: <20230905162335.235619-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905162335.235619-1-peterx@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Drop the enum in qapi because it is never used in QMP APIs.  Instead making
it an internal definition for QEMU so that we can decouple it from QAPI,
and also we can deduplicate the QAPI documentations.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 179 ---------------------------------
 migration/options.h            |  47 +++++++++
 migration/migration-hmp-cmds.c |   3 +-
 migration/options.c            |  51 ++++++++++
 4 files changed, 100 insertions(+), 180 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 45d69787ae..eeb1878c4f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -672,185 +672,6 @@
       'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
   } }
 
-##
-# @MigrationParameter:
-#
-# Migration parameters enumeration
-#
-# @announce-initial: Initial delay (in milliseconds) before sending
-#     the first announce (Since 4.0)
-#
-# @announce-max: Maximum delay (in milliseconds) between packets in
-#     the announcement (Since 4.0)
-#
-# @announce-rounds: Number of self-announce packets sent after
-#     migration (Since 4.0)
-#
-# @announce-step: Increase in delay (in milliseconds) between
-#     subsequent packets in the announcement (Since 4.0)
-#
-# @compress-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU.
-#
-# @compress-threads: Set compression thread count to be used in live
-#     migration, the compression thread count is an integer between 1
-#     and 255.
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: Set decompression thread count to be used in
-#     live migration, the decompression thread count is an integer
-#     between 1 and 255. Usually, decompression is at least 4 times as
-#     fast as compression, so set the decompress-threads to the number
-#     about 1/4 of compress-threads is adequate.
-#
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  The
-#     default value is 20. (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     The default value is 10. (Since 2.7)
-#
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
-#     usually at tail stage.  If this parameter is true, we will
-#     compute the ideal CPU percentage used by the Guest, which may
-#     exactly make the dirty rate match the dirty rate threshold.
-#     Then we will choose a smaller throttle increment between the one
-#     specified by @cpu-throttle-increment and the one generated by
-#     ideal CPU percentage.  Therefore, it is compatible to
-#     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
-#
-# @tls-creds: ID of the 'tls-creds' object that provides credentials
-#     for establishing a TLS connection over the migration data
-#     channel.  On the outgoing side of the migration, the credentials
-#     must be for a 'client' endpoint, while for the incoming side the
-#     credentials must be for a 'server' endpoint.  Setting this will
-#     enable TLS for all migrations.  The default is unset, resulting
-#     in unsecured migration at the QEMU level.  (Since 2.7)
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7)
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     This object is only resolved at time of use, so can be deleted
-#     and recreated on the fly while the migration server is active.
-#     If missing, it will default to denying access (Since 4.0)
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: The delay time (in ms) between two COLO
-#     checkpoints in periodic mode.  (Since 2.8)
-#
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
-# @multifd-channels: Number of channels used to migrate data in
-#     parallel.  This is the same number that the number of sockets
-#     used for migration.  The default value is 2 (since 4.0)
-#
-# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
-#     needs to be a multiple of the target page size and a power of 2
-#     (Since 2.11)
-#
-# @max-postcopy-bandwidth: Background transfer bandwidth during
-#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
-#     (Since 3.0)
-#
-# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
-#     (Since 3.1)
-#
-# @multifd-compression: Which compression method to use.  Defaults to
-#     none.  (Since 5.0)
-#
-# @multifd-zlib-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @multifd-zstd-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 20,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#     aliases for the purpose of dirty bitmap migration.  Such aliases
-#     may for example be the corresponding names on the opposite site.
-#     The mapping must be one-to-one, but not necessarily complete: On
-#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
-#     will be ignored.  On the destination, encountering an unmapped
-#     alias in the incoming migration stream will result in a report,
-#     and all further bitmap migration data will then be discarded.
-#     Note that the destination does not know about bitmaps it does
-#     not receive, so there is no limitation or requirement regarding
-#     the number of bitmaps received, or how they are named, or on
-#     which nodes they are placed.  By default (when this parameter
-#     has never been set), bitmap names are mapped to themselves.
-#     Nodes are mapped to their block device name if there is one, and
-#     to their node name otherwise.  (Since 5.2)
-#
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
-#
-# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#     Defaults to 1.  (Since 8.1)
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
-#
-# Since: 2.4
-##
-{ 'enum': 'MigrationParameter',
-  'data': ['announce-initial', 'announce-max',
-           'announce-rounds', 'announce-step',
-           'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread', 'throttle-trigger-threshold',
-           'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
-           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'downtime-limit',
-           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'block-incremental',
-           'multifd-channels',
-           'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
-           'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit'] }
-
 ##
 # @migrate-set-parameters:
 #
diff --git a/migration/options.h b/migration/options.h
index 124a5d450f..4591545c62 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -66,6 +66,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
 
 /* parameters */
 
+typedef enum {
+    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
+    MIGRATION_PARAMETER_ANNOUNCE_MAX,
+    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
+    MIGRATION_PARAMETER_ANNOUNCE_STEP,
+    MIGRATION_PARAMETER_COMPRESS_LEVEL,
+    MIGRATION_PARAMETER_COMPRESS_THREADS,
+    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
+    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
+    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
+    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
+    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
+    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
+    MIGRATION_PARAMETER_TLS_CREDS,
+    MIGRATION_PARAMETER_TLS_HOSTNAME,
+    MIGRATION_PARAMETER_TLS_AUTHZ,
+    MIGRATION_PARAMETER_MAX_BANDWIDTH,
+    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
+    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
+    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
+    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
+    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
+    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
+    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
+    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
+    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
+    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
+    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
+    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
+    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
+    MIGRATION_PARAMETER__MAX,
+} MigrationParameter;
+
+extern const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX];
+#define  MigrationParameter_str(p)  MigrationParameter_string[p]
+
+/**
+ * @MigrationParameter_from_str(): Parse string into a MigrationParameter
+ *
+ * @param: input string
+ * @errp: error message if failed to parse the string
+ *
+ * Returns MigrationParameter enum (>=0) if succeed, or negative otherwise
+ * which will always setup @errp.
+ */
+int MigrationParameter_from_str(const char *param, Error **errp);
+
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 88a8ccb475..0a35a87b7e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -31,6 +31,7 @@
 #include "ui/qemu-spice.h"
 #include "sysemu/sysemu.h"
 #include "migration.h"
+#include "migration/options.h"
 
 static void migration_global_dump(Monitor *mon)
 {
@@ -505,7 +506,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     int val, ret;
 
-    val = qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
+    val = MigrationParameter_from_str(param, &err);
     if (val < 0) {
         goto cleanup;
     }
diff --git a/migration/options.c b/migration/options.c
index 12e392f68c..c9b90d932d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -84,6 +84,57 @@
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
+const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX] = {
+    [MIGRATION_PARAMETER_ANNOUNCE_INITIAL] = "announce-initial",
+    [MIGRATION_PARAMETER_ANNOUNCE_MAX] = "announce-max",
+    [MIGRATION_PARAMETER_ANNOUNCE_ROUNDS] = "announce-rounds",
+    [MIGRATION_PARAMETER_ANNOUNCE_STEP] = "announce-step",
+    [MIGRATION_PARAMETER_COMPRESS_LEVEL] = "compress-level",
+    [MIGRATION_PARAMETER_COMPRESS_THREADS] = "compress-threads",
+    [MIGRATION_PARAMETER_DECOMPRESS_THREADS] = "decompress-threads",
+    [MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD] = "compress-wait-thread",
+    [MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD] = "throttle-trigger-threshold",
+    [MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL] = "cpu-throttle-initial",
+    [MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT] = "cpu-throttle-increment",
+    [MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW] = "cpu-throttle-tailslow",
+    [MIGRATION_PARAMETER_TLS_CREDS] = "tls-creds",
+    [MIGRATION_PARAMETER_TLS_HOSTNAME] = "tls-hostname",
+    [MIGRATION_PARAMETER_TLS_AUTHZ] = "tls-authz",
+    [MIGRATION_PARAMETER_MAX_BANDWIDTH] = "max-bandwidth",
+    [MIGRATION_PARAMETER_DOWNTIME_LIMIT] = "downtime-limit",
+    [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] = "x-checkpoint-delay",
+    [MIGRATION_PARAMETER_BLOCK_INCREMENTAL] = "block-incremental",
+    [MIGRATION_PARAMETER_MULTIFD_CHANNELS] = "multifd-channels",
+    [MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE] = "xbzrle-cache-size",
+    [MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH] = "max-postcopy-bandwidth",
+    [MIGRATION_PARAMETER_MAX_CPU_THROTTLE] = "max-cpu-throttle",
+    [MIGRATION_PARAMETER_MULTIFD_COMPRESSION] = "multifd-compression",
+    [MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL] = "multifd-zlib-level",
+    [MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL] = "multifd-zstd-level",
+    [MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING] = "block-bitmap-mapping",
+    [MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD] = "x-vcpu-dirty-limit-period",
+    [MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT] = "vcpu-dirty-limit",
+};
+
+int MigrationParameter_from_str(const char *param, Error **errp)
+{
+    int i;
+
+    if (!param) {
+        error_setg(errp, "Missing parameter value");
+        return -1;
+    }
+
+    for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
+        if (!strcmp(param, MigrationParameter_string[i])) {
+            return i;
+        }
+    }
+
+    error_setg(errp, "Invalid parameter value: %s", param);
+    return -1;
+}
+
 Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
-- 
2.41.0


