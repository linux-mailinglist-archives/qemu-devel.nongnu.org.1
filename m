Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BC73A6A7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNb9-0006jU-1j; Thu, 22 Jun 2023 12:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNb7-0006j4-9G
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNb5-0008Kp-E0
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SFhrjM7lUKDquypfaK4yDGZL8ex0kV3B/YXIxLQaoVU=;
 b=Nz5N2IGWhLTJt6MkGuTXs3WSxWxCaCwlsIxBqIpkrj5vtdFlHcWwbHgCT1yvDMAnwYrsFq
 II5ep94uMHeAhRQwPXdee+oG4gY5Xl0GxC9ZvvdaQizrvwEqSTbN8lVBbm1k4yz8afQyC/
 qPuvAbNw+jiezTKk1fLIMcOjOd4duGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-FQ04DkEENiO-qZar7Jb3fw-1; Thu, 22 Jun 2023 12:55:47 -0400
X-MC-Unique: FQ04DkEENiO-qZar7Jb3fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4195185A7A8;
 Thu, 22 Jun 2023 16:55:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91BD5C00049;
 Thu, 22 Jun 2023 16:55:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PULL 04/30] qapi/migration: Introduce x-vcpu-dirty-limit-period
 parameter
Date: Thu, 22 Jun 2023 18:55:01 +0200
Message-Id: <20230622165527.2417-5-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

Introduce "x-vcpu-dirty-limit-period" migration experimental
parameter, which is in the range of 1 to 1000ms and used to
make dirtyrate calculation period configurable.

Currently with the "x-vcpu-dirty-limit-period" varies, the
total time of live migration changes, test results show the
optimal value of "x-vcpu-dirty-limit-period" ranges from
500ms to 1000 ms. "x-vcpu-dirty-limit-period" should be made
stable once it proves best value can not be determined with
developer's experiments.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <168618975839.6361.17407633874747688653-2@git.sr.ht>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json            | 34 +++++++++++++++++++++++++++-------
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5bb5ab82a0..67c26d9dea 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -779,9 +779,14 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
+#                             live migration. Should be in the range 1 to 1000ms,
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
@@ -799,8 +804,9 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level' ,'multifd-zstd-level',
-           'block-bitmap-mapping' ] }
+           'multifd-zlib-level', 'multifd-zstd-level',
+           'block-bitmap-mapping',
+           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] } ] }
 
 ##
 # @MigrateSetParameters:
@@ -935,9 +941,14 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
+#                             live migration. Should be in the range 1 to 1000ms,
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
@@ -972,7 +983,9 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
+                                            'features': [ 'unstable' ] } } }
 
 ##
 # @migrate-set-parameters:
@@ -1127,9 +1140,14 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
+#                             live migration. Should be in the range 1 to 1000ms,
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
@@ -1161,7 +1179,9 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
+                                            'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..352e9ec716 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -364,6 +364,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                 }
             }
         }
+
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
+        params->x_vcpu_dirty_limit_period);
     }
 
     qapi_free_MigrationParameters(params);
@@ -620,6 +624,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         error_setg(&err, "The block-bitmap-mapping parameter can only be set "
                    "through QMP");
         break;
+    case MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD:
+        p->has_x_vcpu_dirty_limit_period = true;
+        visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..9743dea3ab 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -80,6 +80,8 @@
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
+#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
+
 Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
@@ -163,6 +165,9 @@ Property migration_properties[] = {
     DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
     DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
     DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
+                       parameters.x_vcpu_dirty_limit_period,
+                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -891,6 +896,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
                        s->parameters.block_bitmap_mapping);
     }
 
+    params->has_x_vcpu_dirty_limit_period = true;
+    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
+
     return params;
 }
 
@@ -923,6 +931,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_max = true;
     params->has_announce_rounds = true;
     params->has_announce_step = true;
+    params->has_x_vcpu_dirty_limit_period = true;
 }
 
 /*
@@ -1083,6 +1092,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     }
 #endif
 
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
 
@@ -1182,6 +1200,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->has_block_bitmap_mapping = true;
         dest->block_bitmap_mapping = params->block_bitmap_mapping;
     }
+
+    if (params->has_x_vcpu_dirty_limit_period) {
+        dest->x_vcpu_dirty_limit_period =
+            params->x_vcpu_dirty_limit_period;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1300,6 +1323,11 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
             QAPI_CLONE(BitmapMigrationNodeAliasList,
                        params->block_bitmap_mapping);
     }
+
+    if (params->has_x_vcpu_dirty_limit_period) {
+        s->parameters.x_vcpu_dirty_limit_period =
+            params->x_vcpu_dirty_limit_period;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
-- 
2.40.1


