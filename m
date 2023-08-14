Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0A577C35A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 00:20:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVfvK-0003S1-IV; Mon, 14 Aug 2023 18:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfuo-0003Bt-KS
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVful-0005kO-QF
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692051595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOmDDwiqX7/2CN1wshjObAob2rHWWjlzdpdy7eZZMZ8=;
 b=HoZT4gNMc+5bQFsvi0yKU6NzvC9O5ZkVIhQha7Xf7CJISWbIQNlUkIgcp8tS6PEAK7WgU4
 kch5rIZnLgCSqdt/JQCBJg2xcWBLKiQIvCenMdgHSpiOBEMLvElEci6aPXwGh0PBWTD98R
 u0lMWUc6+6vpn9wJkDaNV/zZdowKIC8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8KrEKbnUMJea32sxe9muPA-1; Mon, 14 Aug 2023 18:19:53 -0400
X-MC-Unique: 8KrEKbnUMJea32sxe9muPA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4059b5c3dd0so15030801cf.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 15:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692051593; x=1692656393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOmDDwiqX7/2CN1wshjObAob2rHWWjlzdpdy7eZZMZ8=;
 b=FfFKdfawUrBxdy93P7WhLlbawL7hSK/TSJIASl1amBGxBoothawnrDCr5gkCop/3j9
 GgmBdR+4wpyxLjarNImiqyx5rZ2D2/13IKKVy03Fs0MrBMgc4SsWOhAyUDJHRhyhn+df
 BAsq7Wp9kTL7tnbRjbuxvo38LVKuRwtDaTmrY6ELAAhCdpTBPqtxUcWE0pOiNLxSOAUx
 Ad6J2HrVi0cnUVIlNiO7YI8CLEaST6tIlTOUamykMcfIw8JZRNFgm8VLnGv9xKxbU3Wy
 jLEX0l34mrVd5E/bf+SxnWWebjSGoIPy8K47N8y+cFcRgMbB6OxPJVEwer3V0oWcFfIG
 rJBg==
X-Gm-Message-State: AOJu0YzTcUUPci3wMvgpg3VMFndjmBfM9zRirFQHfkzjlIjJ4frL5SHX
 0XVMUmSVUJwooM+61n4rywR7hifQS+KeYY9LZsamjPZQi0UMiOVhudR1uYTxq+pBSHJ4HYG65v8
 2fNgl7RE0+wn9CBONAou9uIo5h6oSdipDl835CDDXwP1GEbwnjC8x8r3QF1nqdIH7wpqpH+7e
X-Received: by 2002:a05:6214:508d:b0:635:e528:521a with SMTP id
 kk13-20020a056214508d00b00635e528521amr16116507qvb.5.1692051592973; 
 Mon, 14 Aug 2023 15:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/evOGKsIYZbCwGebdqpSgKuFa8SlvZ5wszzaIdqBF0rtLyBBjgRlHG8ooiEQ8Ll1xaPx9QQ==
X-Received: by 2002:a05:6214:508d:b0:635:e528:521a with SMTP id
 kk13-20020a056214508d00b00635e528521amr16116468qvb.5.1692051592418; 
 Mon, 14 Aug 2023 15:19:52 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a05620a16b600b0076ca401d8c7sm3324978qkj.111.2023.08.14.15.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:19:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH for-8.2 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
Date: Mon, 14 Aug 2023 18:19:46 -0400
Message-ID: <20230814221947.353093-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814221947.353093-1-peterx@redhat.com>
References: <20230814221947.353093-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These two structs are mostly identical besides some fields (quote from
Daniel P. Berrangé in his reply):

  1c1
  < { 'struct': 'MigrationParameters',
  ---
  > { 'struct': 'MigrateSetParameters',
  14,16c14,16
  <             '*tls-creds': 'str',
  <             '*tls-hostname': 'str',
  <             '*tls-authz': 'str',
  ---
  >             '*tls-creds': 'StrOrNull',
  >             '*tls-hostname': 'StrOrNull',
  >             '*tls-authz': 'StrOrNull',

Here the difference is @MigrateSetParameters object would allow 'null'
values for any tls-* fields passed in.

Markus used to describe why it happened to be StrOrNull, and also his
concern on having a pure "str" type to be problematic as the reset
indicator in the commit 01fa559826 ("migration: Use JSON null instead of ""
to reset parameter to default").  There, "null" is introduced for the tls
fields even though being treated as "" (empty string) internally to match
the code.

Here to deduplicate the two objects, logically it'll be safe only if we use
"StrOrNull" to replace "str" type, not vice versa.  However we may face
difficulty using StrOrNull as part of MigrationState.parameters [1] when
replacing existing @MigrationParameters to use StrOrNull.  With the fact
that nobody seems to be using "null" for tls-* fields (see the long
standing qemu crash bug on tls-authz when "null" was passed in), let's use
"str" to represent both objects.

This greatly deduplicates the code not only in qapi/migration.json, but
also in the generic migration code on handling transitions between
StrOrNull <-> str types.

[1] https://lore.kernel.org/all/ZNKfoqM0V6pcvrz%2F@x1n/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 185 +--------------------------------
 migration/migration-hmp-cmds.c |  16 +--
 migration/options.c            | 145 ++------------------------
 3 files changed, 12 insertions(+), 334 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..0416da65b5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -851,189 +851,6 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit'] }
 
-##
-# @MigrateSetParameters:
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
-# @compress-level: compression level
-#
-# @compress-threads: compression thread count
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: decompression thread count
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
-#     credentials must be for a 'server' endpoint.  Setting this to a
-#     non-empty string enables TLS for all migrations.  An empty
-#     string means that QEMU will use plain text mode for migration,
-#     rather than TLS (Since 2.9) Previously (since 2.7), this was
-#     reported by omitting tls-creds instead.
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7) An empty string means that QEMU will use
-#     the hostname associated with the migration URI, if any.  (Since
-#     2.9) Previously (since 2.7), this was reported by omitting
-#     tls-hostname instead.
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: the delay time between two COLO checkpoints.
-#     (Since 2.8)
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
-# @max-cpu-throttle: maximum cpu throttle percentage.  The default
-#     value is 99. (Since 3.1)
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
-# TODO: either fuse back into MigrationParameters, or make
-#     MigrationParameters members mandatory
-#
-# Since: 2.4
-##
-{ 'struct': 'MigrateSetParameters',
-  'data': { '*announce-initial': 'size',
-            '*announce-max': 'size',
-            '*announce-rounds': 'size',
-            '*announce-step': 'size',
-            '*compress-level': 'uint8',
-            '*compress-threads': 'uint8',
-            '*compress-wait-thread': 'bool',
-            '*decompress-threads': 'uint8',
-            '*throttle-trigger-threshold': 'uint8',
-            '*cpu-throttle-initial': 'uint8',
-            '*cpu-throttle-increment': 'uint8',
-            '*cpu-throttle-tailslow': 'bool',
-            '*tls-creds': 'StrOrNull',
-            '*tls-hostname': 'StrOrNull',
-            '*tls-authz': 'StrOrNull',
-            '*max-bandwidth': 'size',
-            '*downtime-limit': 'uint64',
-            '*x-checkpoint-delay': { 'type': 'uint32',
-                                     'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
-            '*multifd-channels': 'uint8',
-            '*xbzrle-cache-size': 'size',
-            '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle': 'uint8',
-            '*multifd-compression': 'MultiFDCompression',
-            '*multifd-zlib-level': 'uint8',
-            '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
-            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
-
 ##
 # @migrate-set-parameters:
 #
@@ -1048,7 +865,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
-  'data': 'MigrateSetParameters' }
+  'data': 'MigrationParameters' }
 
 ##
 # @MigrationParameters:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..a64672f640 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -497,7 +497,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
-    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
+    MigrationParameters *p = g_new0(MigrationParameters, 1);
     uint64_t valuebw = 0;
     uint64_t cache_size;
     Error *err = NULL;
@@ -546,19 +546,13 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
         break;
     case MIGRATION_PARAMETER_TLS_CREDS:
-        p->tls_creds = g_new0(StrOrNull, 1);
-        p->tls_creds->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_creds->u.s, &err);
+        visit_type_str(v, param, &p->tls_creds, &err);
         break;
     case MIGRATION_PARAMETER_TLS_HOSTNAME:
-        p->tls_hostname = g_new0(StrOrNull, 1);
-        p->tls_hostname->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_hostname->u.s, &err);
+        visit_type_str(v, param, &p->tls_hostname, &err);
         break;
     case MIGRATION_PARAMETER_TLS_AUTHZ:
-        p->tls_authz = g_new0(StrOrNull, 1);
-        p->tls_authz->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_authz->u.s, &err);
+        visit_type_str(v, param, &p->tls_authz, &err);
         break;
     case MIGRATION_PARAMETER_MAX_BANDWIDTH:
         p->has_max_bandwidth = true;
@@ -657,7 +651,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     qmp_migrate_set_parameters(p, &err);
 
  cleanup:
-    qapi_free_MigrateSetParameters(p);
+    qapi_free_MigrationParameters(p);
     visit_free(v);
     hmp_handle_error(mon, err);
 }
diff --git a/migration/options.c b/migration/options.c
index 6bbfd4853d..7967c572fc 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1172,113 +1172,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrateSetParameters *params,
-                                      MigrationParameters *dest)
-{
-    *dest = migrate_get_current()->parameters;
-
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-
-    if (params->has_compress_level) {
-        dest->compress_level = params->compress_level;
-    }
-
-    if (params->has_compress_threads) {
-        dest->compress_threads = params->compress_threads;
-    }
-
-    if (params->has_compress_wait_thread) {
-        dest->compress_wait_thread = params->compress_wait_thread;
-    }
-
-    if (params->has_decompress_threads) {
-        dest->decompress_threads = params->decompress_threads;
-    }
-
-    if (params->has_throttle_trigger_threshold) {
-        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
-    }
-
-    if (params->has_cpu_throttle_initial) {
-        dest->cpu_throttle_initial = params->cpu_throttle_initial;
-    }
-
-    if (params->has_cpu_throttle_increment) {
-        dest->cpu_throttle_increment = params->cpu_throttle_increment;
-    }
-
-    if (params->has_cpu_throttle_tailslow) {
-        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
-    }
-
-    if (params->tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = params->tls_creds->u.s;
-    }
-
-    if (params->tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = params->tls_hostname->u.s;
-    }
-
-    if (params->has_max_bandwidth) {
-        dest->max_bandwidth = params->max_bandwidth;
-    }
-
-    if (params->has_downtime_limit) {
-        dest->downtime_limit = params->downtime_limit;
-    }
-
-    if (params->has_x_checkpoint_delay) {
-        dest->x_checkpoint_delay = params->x_checkpoint_delay;
-    }
-
-    if (params->has_block_incremental) {
-        dest->block_incremental = params->block_incremental;
-    }
-    if (params->has_multifd_channels) {
-        dest->multifd_channels = params->multifd_channels;
-    }
-    if (params->has_multifd_compression) {
-        dest->multifd_compression = params->multifd_compression;
-    }
-    if (params->has_xbzrle_cache_size) {
-        dest->xbzrle_cache_size = params->xbzrle_cache_size;
-    }
-    if (params->has_max_postcopy_bandwidth) {
-        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-    }
-    if (params->has_max_cpu_throttle) {
-        dest->max_cpu_throttle = params->max_cpu_throttle;
-    }
-    if (params->has_announce_initial) {
-        dest->announce_initial = params->announce_initial;
-    }
-    if (params->has_announce_max) {
-        dest->announce_max = params->announce_max;
-    }
-    if (params->has_announce_rounds) {
-        dest->announce_rounds = params->announce_rounds;
-    }
-    if (params->has_announce_step) {
-        dest->announce_step = params->announce_step;
-    }
-
-    if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
-    }
-
-    if (params->has_x_vcpu_dirty_limit_period) {
-        dest->x_vcpu_dirty_limit_period =
-            params->x_vcpu_dirty_limit_period;
-    }
-    if (params->has_vcpu_dirty_limit) {
-        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
-    }
-}
-
-static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1318,20 +1212,17 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+        s->parameters.tls_creds = g_strdup(params->tls_creds);
     }
 
     if (params->tls_hostname) {
         g_free(s->parameters.tls_hostname);
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+        s->parameters.tls_hostname = g_strdup(params->tls_hostname);
     }
 
     if (params->tls_authz) {
         g_free(s->parameters.tls_authz);
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+        s->parameters.tls_authz = g_strdup(params->tls_authz);
     }
 
     if (params->has_max_bandwidth) {
@@ -1404,33 +1295,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 }
 
-void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
+void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
-
-    /* TODO Rewrite "" to null instead for all three tls_* parameters */
-    if (params->tls_creds
-        && params->tls_creds->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_creds->u.n);
-        params->tls_creds->type = QTYPE_QSTRING;
-        params->tls_creds->u.s = strdup("");
-    }
-    if (params->tls_hostname
-        && params->tls_hostname->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_hostname->u.n);
-        params->tls_hostname->type = QTYPE_QSTRING;
-        params->tls_hostname->u.s = strdup("");
-    }
-    if (params->tls_authz
-        && params->tls_authz->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_authz->u.n);
-        params->tls_authz->type = QTYPE_QSTRING;
-        params->tls_authz->u.s = strdup("");
-    }
-
-    migrate_params_test_apply(params, &tmp);
-
-    if (!migrate_params_check(&tmp, errp)) {
+    if (!migrate_params_check(params, errp)) {
         /* Invalid parameter */
         return;
     }
-- 
2.41.0


