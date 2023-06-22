Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DE73A6D6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:59:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbH-0006qB-A0; Thu, 22 Jun 2023 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbE-0006o7-SC
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbD-0008Mc-78
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/St81kdkZQJj4V+hE6fkLQyP9wya7SS1yQmgWrwVEkY=;
 b=g4/oblAUeQiZjR02RqoSZ5Zjfap7PXRbecM4EVUJ8nRuLiW0MwHToJED42NGGGWaDNKTs6
 DwRhsrf6f5zZuQcw9/rT7No+Jf8XfdjJIbqQoD7FQIJXnJvi86StKvexEb3CMXkmNLTwI9
 kfwu2k3xr27wJwtQwepQ6GdcF629JPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-1Vja24SJOsSaBR_cXmmPwQ-1; Thu, 22 Jun 2023 12:55:54 -0400
X-MC-Unique: 1Vja24SJOsSaBR_cXmmPwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47DED102D002;
 Thu, 22 Jun 2023 16:55:43 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29C6FC00049;
 Thu, 22 Jun 2023 16:55:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PULL 05/30] qapi/migration: Introduce vcpu-dirty-limit parameters
Date: Thu, 22 Jun 2023 18:55:02 +0200
Message-Id: <20230622165527.2417-6-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Introduce "vcpu-dirty-limit" migration parameter used
to limit dirty page rate during live migration.

"vcpu-dirty-limit" and "x-vcpu-dirty-limit-period" are
two dirty-limit-related migration parameters, which can
be set before and during live migration by qmp
migrate-set-parameters.

This two parameters are used to help implement the dirty
page rate limit algo of migration.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <168618975839.6361.17407633874747688653-3@git.sr.ht>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json            | 18 +++++++++++++++---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 67c26d9dea..e7243c0c0d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -783,6 +783,9 @@
 #                             live migration. Should be in the range 1 to 1000ms,
 #                             defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
+#                    Defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -806,7 +809,8 @@
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] } ] }
+           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
+           'vcpu-dirty-limit'] }
 
 ##
 # @MigrateSetParameters:
@@ -945,6 +949,9 @@
 #                             live migration. Should be in the range 1 to 1000ms,
 #                             defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
+#                    Defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -985,7 +992,8 @@
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] } } }
+                                            'features': [ 'unstable' ] },
+            '*vcpu-dirty-limit': 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1144,6 +1152,9 @@
 #                             live migration. Should be in the range 1 to 1000ms,
 #                             defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
+#                    Defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1181,7 +1192,8 @@
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] } } }
+                                            'features': [ 'unstable' ] },
+            '*vcpu-dirty-limit': 'uint64'} }
 
 ##
 # @query-migrate-parameters:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 352e9ec716..35e8020bbf 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -368,6 +368,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
         MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
         params->x_vcpu_dirty_limit_period);
+
+        monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
+            params->vcpu_dirty_limit);
     }
 
     qapi_free_MigrationParameters(params);
@@ -628,6 +632,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_vcpu_dirty_limit_period = true;
         visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
         break;
+    case MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT:
+        p->has_vcpu_dirty_limit = true;
+        visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 9743dea3ab..8acf5f1d2c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -81,6 +81,7 @@
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
+#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
 Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
@@ -168,6 +169,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
                        parameters.x_vcpu_dirty_limit_period,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
+    DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
+                       parameters.vcpu_dirty_limit,
+                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -898,6 +902,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     params->has_x_vcpu_dirty_limit_period = true;
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
+    params->has_vcpu_dirty_limit = true;
+    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
 
     return params;
 }
@@ -932,6 +938,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_rounds = true;
     params->has_announce_step = true;
     params->has_x_vcpu_dirty_limit_period = true;
+    params->has_vcpu_dirty_limit = true;
 }
 
 /*
@@ -1101,6 +1108,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
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
 
@@ -1205,6 +1220,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_vcpu_dirty_limit_period =
             params->x_vcpu_dirty_limit_period;
     }
+    if (params->has_vcpu_dirty_limit) {
+        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1328,6 +1346,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.x_vcpu_dirty_limit_period =
             params->x_vcpu_dirty_limit_period;
     }
+    if (params->has_vcpu_dirty_limit) {
+        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
-- 
2.40.1


