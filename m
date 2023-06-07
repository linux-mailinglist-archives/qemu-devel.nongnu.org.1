Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5B747CAC
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:50:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvOT-0005SY-Aw; Wed, 05 Jul 2023 01:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOF-0005Rq-I6
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:23 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOD-00084l-85
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:22 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 4DDF311F0A8;
 Wed,  5 Jul 2023 05:49:20 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Wed, 07 Jun 2023 21:32:59 +0800
Subject: [PATCH QEMU v7 2/9] qapi/migration: Introduce
 x-vcpu-dirty-limit-period parameter
MIME-Version: 1.0
Message-ID: <168853615963.17240.15832775267134683267-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168853615963.17240.15832775267134683267-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Introduce "x-vcpu-dirty-limit-period" migration experimental
parameter, which is in the range of 1 to 1000ms and used to
make dirtyrate calculation period configurable.

Currently with the "x-vcpu-dirty-limit-period" varies, the
total time of live migration changes, test results show the
optimal value of "x-vcpu-dirty-limit-period" ranges from
500ms to 1000 ms. "x-vcpu-dirty-limit-period" should be made
stable once it proves best value can not be determined with
developer's experiments.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 qapi/migration.json            | 34 +++++++++++++++++++++++++++-------
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..352e9ec716 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -364,6 +364,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDi=
ct *qdict)
                 }
             }
         }
+
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD=
),
+        params->x_vcpu_dirty_limit_period);
     }
=20
     qapi_free_MigrationParameters(params);
@@ -620,6 +624,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict=
 *qdict)
         error_setg(&err, "The block-bitmap-mapping parameter can only be set=
 "
                    "through QMP");
         break;
+    case MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD:
+        p->has_x_vcpu_dirty_limit_period =3D true;
+        visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 5a9505adf7..1de63ba775 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -80,6 +80,8 @@
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
=20
+#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds =
*/
+
 Property migration_properties[] =3D {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
@@ -163,6 +165,9 @@ Property migration_properties[] =3D {
     DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
     DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostna=
me),
     DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
+                       parameters.x_vcpu_dirty_limit_period,
+                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
=20
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -908,6 +913,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error *=
*errp)
                        s->parameters.block_bitmap_mapping);
     }
=20
+    params->has_x_vcpu_dirty_limit_period =3D true;
+    params->x_vcpu_dirty_limit_period =3D s->parameters.x_vcpu_dirty_limit_p=
eriod;
+
     return params;
 }
=20
@@ -940,6 +948,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_max =3D true;
     params->has_announce_rounds =3D true;
     params->has_announce_step =3D true;
+    params->has_x_vcpu_dirty_limit_period =3D true;
 }
=20
 /*
@@ -1100,6 +1109,15 @@ bool migrate_params_check(MigrationParameters *params,=
 Error **errp)
     }
 #endif
=20
+    if (params->has_x_vcpu_dirty_limit_period &&
+        (params->x_vcpu_dirty_limit_period < 1 ||
+         params->x_vcpu_dirty_limit_period > 1000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "x-vcpu-dirty-limit-period",
+                   "a value between 1 and 1000");
+        return false;
+    }
+
     return true;
 }
=20
@@ -1199,6 +1217,11 @@ static void migrate_params_test_apply(MigrateSetParame=
ters *params,
         dest->has_block_bitmap_mapping =3D true;
         dest->block_bitmap_mapping =3D params->block_bitmap_mapping;
     }
+
+    if (params->has_x_vcpu_dirty_limit_period) {
+        dest->x_vcpu_dirty_limit_period =3D
+            params->x_vcpu_dirty_limit_period;
+    }
 }
=20
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1317,6 +1340,11 @@ static void migrate_params_apply(MigrateSetParameters =
*params, Error **errp)
             QAPI_CLONE(BitmapMigrationNodeAliasList,
                        params->block_bitmap_mapping);
     }
+
+    if (params->has_x_vcpu_dirty_limit_period) {
+        s->parameters.x_vcpu_dirty_limit_period =3D
+            params->x_vcpu_dirty_limit_period;
+    }
 }
=20
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 47dfef0278..384b768e03 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -789,9 +789,14 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
+#                             live migration. Should be in the range 1 to 10=
00ms,
+#                             defaults to 1000ms. (Since 8.1)
+#
 # Features:
 #
-# @unstable: Member @x-checkpoint-delay is experimental.
+# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
+#            are experimental.
 #
 # Since: 2.4
 ##
@@ -809,8 +814,9 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level' ,'multifd-zstd-level',
-           'block-bitmap-mapping' ] }
+           'multifd-zlib-level', 'multifd-zstd-level',
+           'block-bitmap-mapping',
+           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] }=
 ] }
=20
 ##
 # @MigrateSetParameters:
@@ -945,9 +951,14 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
+#                             live migration. Should be in the range 1 to 10=
00ms,
+#                             defaults to 1000ms. (Since 8.1)
+#
 # Features:
 #
-# @unstable: Member @x-checkpoint-delay is experimental.
+# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
+#            are experimental.
 #
 # TODO: either fuse back into MigrationParameters, or make
 #     MigrationParameters members mandatory
@@ -982,7 +993,9 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
+                                            'features': [ 'unstable' ] } } }
=20
 ##
 # @migrate-set-parameters:
@@ -1137,9 +1150,14 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
+#                             live migration. Should be in the range 1 to 10=
00ms,
+#                             defaults to 1000ms. (Since 8.1)
+#
 # Features:
 #
-# @unstable: Member @x-checkpoint-delay is experimental.
+# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
+#            are experimental.
 #
 # Since: 2.4
 ##
@@ -1171,7 +1189,9 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
+                                            'features': [ 'unstable' ] } } }
=20
 ##
 # @query-migrate-parameters:
--=20
2.38.5


