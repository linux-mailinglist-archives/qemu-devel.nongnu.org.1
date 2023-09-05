Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBA7925C9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:24:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYqh-0005tG-Lq; Tue, 05 Sep 2023 12:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYqY-0005lX-P4
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYqR-00068S-Kb
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693931039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWT2Wd72y8c45b1p337YG5hrJzJxWo9jLgOa/JW8rkA=;
 b=I2f/toil+CQOx4JubBUAiYhj9MVuXgjWRM55nbFoG4Z41eUGHgqEjG+kAl88iANkPPFU0D
 9rKiBWWt1338aM9P8d+Ho9sTfhb1vbzIHKCvrv5WUSvVEAx5NEkoLAMvQ2+/BQQ3xhxtEu
 1ZSXCmoWte3fWSnsTKzJ7CEfXpeZSpA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-bgkcP2ccP8Sqrm3nwNtlPw-1; Tue, 05 Sep 2023 12:23:46 -0400
X-MC-Unique: bgkcP2ccP8Sqrm3nwNtlPw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65174aca002so4395906d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693931021; x=1694535821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWT2Wd72y8c45b1p337YG5hrJzJxWo9jLgOa/JW8rkA=;
 b=el1iWDQHTFQBEyS0jrmIWqFiGIWl+WeFd3cj0lqoG2exUTJ3Ihp5qnJ6Es3+hB+cZs
 vcD6eMTJVc7hIZrFE9tZ0wdWwVd+UB+1HMT+DaOR1vfvTPKbtM6jnwy3Xr6JqM3RTFw9
 5YjrORkMDKN5cvFPgngEfO0ACZRQfz9Qjy+F82ogm8EcI19KK3eCscIDB7y2kqNd42tG
 gIxx4UuQcTtBJZ/n6sfoXxJAjN5p/O8RrWyLfgZce7SqRsa9oOmHHAEnwlSczXmBGD2Q
 BI+S515UTcBa9TPvIwO2apQLfHZM7kfUfJxqBgmkFHd+3cBxoqvGzOja0bzSCwURcfsY
 O/TA==
X-Gm-Message-State: AOJu0YyClvvDkkyUooAra5JqIlNDq+WwVWI1hvAdsCsO8vmfj7UxWk9N
 ZJSu9qmzTA65x10dGf5X99XK+3QDvTeinjTNUokovfYMlzMWdaO0mp8av8b1gJABRHJl2LfvfGu
 o7eaHTY9S7ahndwtiAbsfVhQxtpNgiHpMxMOW39viMFGlSYEe+Ng597IuU4KjKR5BiQ2gvAIE
X-Received: by 2002:a05:6214:1249:b0:651:5f21:92aa with SMTP id
 r9-20020a056214124900b006515f2192aamr15244682qvv.5.1693931020858; 
 Tue, 05 Sep 2023 09:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnUh6ocepma100acmmHGDd+860NDeqR9n1U4MAyCEa8je7OzHwGQRkeOBGbjzDT80uUUFesA==
X-Received: by 2002:a05:6214:1249:b0:651:5f21:92aa with SMTP id
 r9-20020a056214124900b006515f2192aamr15244640qvv.5.1693931020220; 
 Tue, 05 Sep 2023 09:23:40 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a0cf1d0000000b0063d281e22f1sm4581675qvl.17.2023.09.05.09.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:23:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters with
 @MigrationParameters
Date: Tue,  5 Sep 2023 12:23:34 -0400
Message-ID: <20230905162335.235619-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905162335.235619-1-peterx@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Quotting from Markus in his replies:

  migrate-set-parameters sets migration parameters, and
  query-migrate-parameters gets them.  Unsurprisingly, the former's
  argument type MigrateSetParameters is quite close to the latter's
  return type MigrationParameters.  The differences are subtle:

  1. Since migrate-set-parameters supports setting selected parameters,
     its arguments must all be optional (so you can omit the ones you
     don't want to change).  query-migrate-parameters results are also
     all optional, but almost all of them are in fact always present.

  2. For parameters @tls_creds, @tls_hostname, @tls_authz,
     migrate-set-parameters interprets special value "" as "reset to
     default".  Works, because "" is semantically invalid.  Not a
     general solution, because a semantically invalid value need not
     exist.  Markus added a general solution in commit 01fa559826
     ("migration: Use JSON null instead of "" to reset parameter to
     default").  This involved changing the type from 'str' to
     'StrOrNull'.

  3. When parameter @block-bitmap-mapping has not been set,
     query-migrate-parameters does not return it (absent optional
     member).  Clean (but undocumented).  When parameters @tls_creds,
     @tls_hostname, @tls_authz have not been set, it returns the
     semantically invalid value "".  Not so clean (and just as
     undocumented).

Here to deduplicate the two objects: keep @MigrationParameters as the name
of object to use in both places, drop @MigrateSetParameters, at the
meantime switch types of @tls* fields from "str" to "StrOrNull" types.

I found that the TLS code wasn't so much relying on tls_* fields being
non-NULL at all.  Actually on the other way round: if we set tls_authz to
an empty string (NOTE: currently, migrate_init() missed initializing
tls_authz; also touched it up in this patch), we can already fail one of
the migration-test (tls/x509/default-host), as qauthz_is_allowed_by_id()
will assume tls_authz set even if tls_auths is an empty string.

It means we're actually relying on tls_* fields being NULL even if it's the
empty string.

Let's just make it a rule to return NULL for empty string on these fields
internally.  For that, when converting a StrOrNull into a char* (where we
introduced a helper here in this patch) we'll also make the empty string to
be NULL, to make it always work.  And it doesn't show any issue either when
applying that logic to both tls_creds and tls_hostname.

With above, we can safely change both migration_tls_client_create() and
migrate_tls() to not check the empty string too finally.. not needed
anymore.

Also, we can drop the hackish conversions in qmp_migrate_set_parameters()
where we want to make sure it's a QSTRING; it's not needed now.

This greatly deduplicates the code not only in qapi/migration.json, but
also in the generic migration code.

Markus helped greatly with this patch.  Besides a better commit
message (where I just "stole" from the reply), debugged and resolved a
double free, but also provided the StrOrNull property implementation to be
used in MigrationState object when switching tls_* fields to StrOrNull.

Co-developed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 191 +---------------------------
 include/hw/qdev-properties.h   |   3 +
 migration/options.h            |   3 +
 hw/core/qdev-properties.c      |  40 ++++++
 migration/migration-hmp-cmds.c |  20 +--
 migration/options.c            | 220 ++++++++++-----------------------
 migration/tls.c                |   3 +-
 7 files changed, 125 insertions(+), 355 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..45d69787ae 100644
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
@@ -1214,9 +1031,9 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
-            '*tls-creds': 'str',
-            '*tls-hostname': 'str',
-            '*tls-authz': 'str',
+            '*tls-creds': 'StrOrNull',
+            '*tls-hostname': 'StrOrNull',
+            '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e1df08876c..3ae83d8390 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -59,6 +59,7 @@ extern const PropertyInfo qdev_prop_uint64_checkmask;
 extern const PropertyInfo qdev_prop_int64;
 extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
+extern const PropertyInfo qdev_prop_str_or_null;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
 extern const PropertyInfo qdev_prop_arraylen;
@@ -171,6 +172,8 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
+#define DEFINE_PROP_STR_OR_NULL(_n, _s, _f)             \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_str_or_null, StrOrNull *)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..124a5d450f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -56,6 +56,7 @@ bool migrate_zero_copy_send(void);
 
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
+/* Check whether TLS is enabled for migration */
 bool migrate_tls(void);
 
 /* capabilities helpers */
@@ -90,6 +91,8 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+StrOrNull *StrOrNull_from_str(const char *str);
+const char *str_from_StrOrNull(StrOrNull *obj);
 
 /* parameters setters */
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 357b8761b5..b4bbb52ae9 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,6 +2,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-visit-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
@@ -490,6 +491,45 @@ const PropertyInfo qdev_prop_string = {
     .set   = set_string,
 };
 
+/* --- StrOrNull --- */
+
+static void release_str_or_null(Object *obj, const char *name, void *opaque)
+{
+    Property *prop = opaque;
+
+    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
+}
+
+static void get_str_or_null(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+
+    visit_type_StrOrNull(v, name, ptr, errp);
+}
+
+static void set_str_or_null(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+    StrOrNull *son;
+
+    if (!visit_type_StrOrNull(v, name, &son, errp)) {
+        return;
+    }
+    qapi_free_StrOrNull(*ptr);
+    *ptr = son;
+}
+
+const PropertyInfo qdev_prop_str_or_null = {
+    .name  = "StrOrNull",
+    .release = release_str_or_null,
+    .get   = get_str_or_null,
+    .set   = set_str_or_null,
+};
+
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..88a8ccb475 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -257,6 +257,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
+    const char *str;
 
     params = qmp_query_migrate_parameters(NULL);
 
@@ -309,14 +310,18 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
             params->max_cpu_throttle);
-        assert(params->tls_creds);
+        str = str_from_StrOrNull(params->tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
-            params->tls_creds);
-        assert(params->tls_hostname);
+            str ? str : "");
+        str = str_from_StrOrNull(params->tls_hostname);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
-            params->tls_hostname);
+            str ? str : "");
+        str = str_from_StrOrNull(params->tls_authz);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
+            str ? str : "");
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
@@ -345,9 +350,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->tls_authz);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -497,7 +499,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
-    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
+    MigrationParameters *p = g_new0(MigrationParameters, 1);
     uint64_t valuebw = 0;
     uint64_t cache_size;
     Error *err = NULL;
@@ -657,7 +659,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     qmp_migrate_set_parameters(p, &err);
 
  cleanup:
-    qapi_free_MigrateSetParameters(p);
+    qapi_free_MigrationParameters(p);
     visit_free(v);
     hmp_handle_error(mon, err);
 }
diff --git a/migration/options.c b/migration/options.c
index 6bbfd4853d..12e392f68c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -164,9 +164,12 @@ Property migration_properties[] = {
     DEFINE_PROP_SIZE("announce-step", MigrationState,
                       parameters.announce_step,
                       DEFAULT_MIGRATE_ANNOUNCE_STEP),
-    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
-    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
-    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    DEFINE_PROP_STR_OR_NULL("tls-creds", MigrationState,
+                            parameters.tls_creds),
+    DEFINE_PROP_STR_OR_NULL("tls-hostname", MigrationState,
+                            parameters.tls_hostname),
+    DEFINE_PROP_STR_OR_NULL("tls-authz", MigrationState,
+                            parameters.tls_authz),
     DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
                        parameters.x_vcpu_dirty_limit_period,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
@@ -201,6 +204,38 @@ Property migration_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/*
+ * NOTE: here we have a trick when converting the empty string (""): we
+ * need to make sure the empty string ("") will be converted to NULL, as
+ * some TLS code may rely on that to detect whether something is enabled
+ * (e.g., the tls_authz field).
+ */
+const char *str_from_StrOrNull(StrOrNull *obj)
+{
+    if (!obj || obj->type == QTYPE_QNULL) {
+        return NULL;
+    } else if (obj->type == QTYPE_QSTRING) {
+        if (obj->u.s[0] == '\0') {
+            return NULL;
+        } else {
+            return obj->u.s;
+        }
+    } else {
+        abort();
+    }
+}
+
+StrOrNull *StrOrNull_from_str(const char *str)
+{
+    StrOrNull *obj = g_new0(StrOrNull, 1);
+
+    assert(str);
+    obj->type = QTYPE_QSTRING;
+    obj->u.s = g_strdup(str);
+
+    return obj;
+}
+
 bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
@@ -378,9 +413,11 @@ bool migrate_postcopy(void)
 
 bool migrate_tls(void)
 {
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.tls_creds && *s->parameters.tls_creds;
+    /*
+     * The whole TLS feature relies on a non-empty tls-creds set first.
+     * It's disabled otherwise.
+     */
+    return migrate_tls_creds();
 }
 
 typedef enum WriteTrackingSupport {
@@ -827,21 +864,21 @@ const char *migrate_tls_authz(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_authz;
+    return str_from_StrOrNull(s->parameters.tls_authz);
 }
 
 const char *migrate_tls_creds(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_creds;
+    return str_from_StrOrNull(s->parameters.tls_creds);
 }
 
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_hostname;
+    return str_from_StrOrNull(s->parameters.tls_hostname);
 }
 
 uint64_t migrate_xbzrle_cache_size(void)
@@ -911,10 +948,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = g_strdup(s->parameters.tls_creds);
-    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
-    params->tls_authz = g_strdup(s->parameters.tls_authz ?
-                                 s->parameters.tls_authz : "");
+    params->tls_creds = QAPI_CLONE(StrOrNull, s->parameters.tls_creds);
+    params->tls_hostname = QAPI_CLONE(StrOrNull, s->parameters.tls_hostname);
+    params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_downtime_limit = true;
@@ -963,8 +999,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    params->tls_hostname = g_strdup("");
-    params->tls_creds = g_strdup("");
+    params->tls_hostname = StrOrNull_from_str("");
+    params->tls_creds = StrOrNull_from_str("");
+    params->tls_authz = StrOrNull_from_str("");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
@@ -1145,7 +1182,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
         ((params->has_multifd_compression && params->multifd_compression) ||
-         (params->tls_creds && *params->tls_creds))) {
+         migrate_tls())) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1172,113 +1209,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 
@@ -1317,21 +1248,18 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->tls_creds) {
-        g_free(s->parameters.tls_creds);
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_creds);
+        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
     }
 
     if (params->tls_hostname) {
-        g_free(s->parameters.tls_hostname);
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_hostname);
+        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
     }
 
     if (params->tls_authz) {
-        g_free(s->parameters.tls_authz);
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_authz);
+        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
     }
 
     if (params->has_max_bandwidth) {
@@ -1404,33 +1332,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
diff --git a/migration/tls.c b/migration/tls.c
index fa03d9136c..c2ed4ff557 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -126,7 +126,8 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     }
 
     const char *tls_hostname = migrate_tls_hostname();
-    if (tls_hostname && *tls_hostname) {
+    /* If tls_hostname, then it must be non-empty string already */
+    if (tls_hostname) {
         hostname = tls_hostname;
     }
 
-- 
2.41.0


