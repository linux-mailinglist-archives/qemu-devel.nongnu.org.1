Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B174A9C7
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 06:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHcoG-0000wF-8j; Fri, 07 Jul 2023 00:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qHcoC-0000uI-Ae
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 00:11:04 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qHco8-0006lB-NI
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 00:11:03 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 7191C11F0FB;
 Fri,  7 Jul 2023 04:10:59 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Wed, 07 Jun 2023 22:58:32 +0800
Subject: [PATCH QEMU v8 3/9] qapi/migration: Introduce vcpu-dirty-limit
 parameters
MIME-Version: 1.0
Message-ID: <168870305868.29142.5121604177475325995-3@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168870305868.29142.5121604177475325995-0@git.sr.ht>
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

Introduce "vcpu-dirty-limit" migration parameter used
to limit dirty page rate during live migration.

"vcpu-dirty-limit" and "x-vcpu-dirty-limit-period" are
two dirty-limit-related migration parameters, which can
be set before and during live migration by qmp
migrate-set-parameters.

This two parameters are used to help implement the dirty
page rate limit algo of migration.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 21 +++++++++++++++++++++
 qapi/migration.json            | 18 +++++++++++++++---
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 352e9ec716..35e8020bbf 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -368,6 +368,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDi=
ct *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
         MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD=
),
         params->x_vcpu_dirty_limit_period);
+
+        monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
+            params->vcpu_dirty_limit);
     }
=20
     qapi_free_MigrationParameters(params);
@@ -628,6 +632,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict=
 *qdict)
         p->has_x_vcpu_dirty_limit_period =3D true;
         visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
         break;
+    case MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT:
+        p->has_vcpu_dirty_limit =3D true;
+        visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 1de63ba775..7d2d98830e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -81,6 +81,7 @@
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
=20
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds =
*/
+#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
=20
 Property migration_properties[] =3D {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
@@ -168,6 +169,9 @@ Property migration_properties[] =3D {
     DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
                        parameters.x_vcpu_dirty_limit_period,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
+    DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
+                       parameters.vcpu_dirty_limit,
+                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
=20
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -915,6 +919,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error *=
*errp)
=20
     params->has_x_vcpu_dirty_limit_period =3D true;
     params->x_vcpu_dirty_limit_period =3D s->parameters.x_vcpu_dirty_limit_p=
eriod;
+    params->has_vcpu_dirty_limit =3D true;
+    params->vcpu_dirty_limit =3D s->parameters.vcpu_dirty_limit;
=20
     return params;
 }
@@ -949,6 +955,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_rounds =3D true;
     params->has_announce_step =3D true;
     params->has_x_vcpu_dirty_limit_period =3D true;
+    params->has_vcpu_dirty_limit =3D true;
 }
=20
 /*
@@ -1118,6 +1125,14 @@ bool migrate_params_check(MigrationParameters *params,=
 Error **errp)
         return false;
     }
=20
+    if (params->has_vcpu_dirty_limit &&
+        (params->vcpu_dirty_limit < 1)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "vcpu_dirty_limit",
+                   "is invalid, it must greater then 1 MB/s");
+        return false;
+    }
+
     return true;
 }
=20
@@ -1222,6 +1237,9 @@ static void migrate_params_test_apply(MigrateSetParamet=
ers *params,
         dest->x_vcpu_dirty_limit_period =3D
             params->x_vcpu_dirty_limit_period;
     }
+    if (params->has_vcpu_dirty_limit) {
+        dest->vcpu_dirty_limit =3D params->vcpu_dirty_limit;
+    }
 }
=20
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1345,6 +1363,9 @@ static void migrate_params_apply(MigrateSetParameters *=
params, Error **errp)
         s->parameters.x_vcpu_dirty_limit_period =3D
             params->x_vcpu_dirty_limit_period;
     }
+    if (params->has_vcpu_dirty_limit) {
+        s->parameters.vcpu_dirty_limit =3D params->vcpu_dirty_limit;
+    }
 }
=20
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 2041d336d5..e43371955a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -793,6 +793,9 @@
 #     limit during live migration. Should be in the range 1 to 1000ms,
 #     defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirty page rate limit (MB/s) during live
+#     migration, defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -817,7 +820,8 @@
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period',
-             'features': ['unstable'] } ] }
+             'features': ['unstable'] },
+           'vcpu-dirty-limit'] }
=20
 ##
 # @MigrateSetParameters:
@@ -956,6 +960,9 @@
 #     limit during live migration. Should be in the range 1 to 1000ms,
 #     defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirty page rate limit (MB/s) during live
+#     migration, defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -996,7 +1003,8 @@
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] } } }
+                                            'features': [ 'unstable' ] },
+            '*vcpu-dirty-limit': 'uint64'} }
=20
 ##
 # @migrate-set-parameters:
@@ -1155,6 +1163,9 @@
 #     limit during live migration. Should be in the range 1 to 1000ms,
 #     defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirty page rate limit (MB/s) during live
+#     migration, defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1192,7 +1203,8 @@
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] } } }
+                                            'features': [ 'unstable' ] },
+            '*vcpu-dirty-limit': 'uint64'} }
=20
 ##
 # @query-migrate-parameters:
--=20
2.38.5


