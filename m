Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1537B75F7E2
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvHD-000433-Vs; Mon, 24 Jul 2023 09:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHA-00041x-3E
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvH7-0002YZ-Cm
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTTb5Z5kDvfeeCH5cQxHKTrfMaQpbET73zReScb//bg=;
 b=KlC7/4Pdh7KuEFDMCQ+CnPkCBnBBaFGAY2lEROfibBF4iH6H5KwQBFoXoptIB60DBsZHI/
 19cvzlh+SZY3Fw+iH7YaUo/nkYDuXTWuQ9byC5BHjwH7nF/Ml7bi7jU9rW6uay/Ps1zJBj
 ZYtBqPS60M12EFuWKx16QyQpPKYBfP0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-8AEyakZHP_iRQTOb01cwEA-1; Mon, 24 Jul 2023 09:06:55 -0400
X-MC-Unique: 8AEyakZHP_iRQTOb01cwEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 749C33C0ED5C;
 Mon, 24 Jul 2023 13:06:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80115F7839;
 Mon, 24 Jul 2023 13:06:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PATCH 05/26] qapi/migration: Introduce vcpu-dirty-limit parameters
Date: Mon, 24 Jul 2023 15:06:18 +0200
Message-Id: <20230724130639.93135-6-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
index 384b768e03..aa590dbf0e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -793,6 +793,9 @@
 #                             live migration. Should be in the range 1 to 1000ms,
 #                             defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
+#                    Defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -816,7 +819,8 @@
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] } ] }
+           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
+           'vcpu-dirty-limit'] }
 
 ##
 # @MigrateSetParameters:
@@ -955,6 +959,9 @@
 #                             live migration. Should be in the range 1 to 1000ms,
 #                             defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
+#                    Defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -995,7 +1002,8 @@
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] } } }
+                                            'features': [ 'unstable' ] },
+            '*vcpu-dirty-limit': 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1154,6 +1162,9 @@
 #                             live migration. Should be in the range 1 to 1000ms,
 #                             defaults to 1000ms. (Since 8.1)
 #
+# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
+#                    Defaults to 1. (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1191,7 +1202,8 @@
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
index 1de63ba775..7d2d98830e 100644
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
@@ -915,6 +919,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     params->has_x_vcpu_dirty_limit_period = true;
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
+    params->has_vcpu_dirty_limit = true;
+    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
 
     return params;
 }
@@ -949,6 +955,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_rounds = true;
     params->has_announce_step = true;
     params->has_x_vcpu_dirty_limit_period = true;
+    params->has_vcpu_dirty_limit = true;
 }
 
 /*
@@ -1118,6 +1125,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 
@@ -1222,6 +1237,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_vcpu_dirty_limit_period =
             params->x_vcpu_dirty_limit_period;
     }
+    if (params->has_vcpu_dirty_limit) {
+        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1345,6 +1363,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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


