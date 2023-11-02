Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8D47DF188
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:44:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW7S-0000tS-EG; Thu, 02 Nov 2023 07:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW70-0005dz-7p
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW6x-0005x0-Mv
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HmJEQt2xd3Vrd5xaVOxontA23tK9m5eqT86vJ3+YcNQ=;
 b=Sc+gn50p/H7Q17LhsfzV7VUO4SW4ZuLydLepUXKfdZ9pc3qpuSIiAojQTLzOO5SidL5aC9
 +3uaRconQyDJPmwKv5RDXLYVsy54D+QdjxZ07Ba/ClONknGH0i/TVtSWaBOY7l9B9k4mL/
 QNlz0Bp3HgzFcD6bzm5b0h2agfHtVKQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-CwlJpAPCO-26joc8qMqtow-1; Thu,
 02 Nov 2023 07:43:38 -0400
X-MC-Unique: CwlJpAPCO-26joc8qMqtow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C02992808FC9;
 Thu,  2 Nov 2023 11:43:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E714F2026D4C;
 Thu,  2 Nov 2023 11:43:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 20/40] migration: mode parameter
Date: Thu,  2 Nov 2023 12:40:34 +0100
Message-ID: <20231102114054.44360-21-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Create a mode migration parameter that can be used to select alternate
migration algorithms.  The default mode is normal, representing the
current migration algorithm, and does not need to be explicitly set.

No functional change until a new mode is added, except that the mode is
shown by the 'info migrate' command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <1698263069-406971-2-git-send-email-steven.sistare@oracle.com>
---
 qapi/migration.json                 | 27 ++++++++++++++++++++++++---
 include/hw/qdev-properties-system.h |  4 ++++
 include/migration/misc.h            |  1 +
 migration/options.h                 |  1 +
 hw/core/qdev-properties-system.c    | 14 ++++++++++++++
 migration/migration-hmp-cmds.c      |  9 +++++++++
 migration/options.c                 | 21 +++++++++++++++++++++
 7 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index e6610af428..47c02a9346 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -631,6 +631,15 @@
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
+##
+# @MigMode:
+#
+# @normal: the original form of migration. (since 8.2)
+#
+##
+{ 'enum': 'MigMode',
+  'data': [ 'normal' ] }
+
 ##
 # @BitmapMigrationBitmapAliasTransform:
 #
@@ -849,6 +858,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -881,7 +893,8 @@
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit'] }
+           'vcpu-dirty-limit',
+           'mode'] }
 
 ##
 # @MigrateSetParameters:
@@ -1033,6 +1046,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1085,7 +1101,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*mode': 'MigMode'} }
 
 ##
 # @migrate-set-parameters:
@@ -1257,6 +1274,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1306,7 +1326,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*mode': 'MigMode'} }
 
 ##
 # @query-migrate-parameters:
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index e4f8a13afc..91f7a2452d 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -7,6 +7,7 @@ extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
+extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -42,6 +43,9 @@ extern const PropertyInfo qdev_prop_cpus390entitlement;
 #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
                        MultiFDCompression)
+#define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
+                       MigMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 673ac490fb..1bc8902e6d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -15,6 +15,7 @@
 #define MIGRATION_MISC_H
 
 #include "qemu/notify.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-types-net.h"
 
 /* migration/ram.c */
diff --git a/migration/options.h b/migration/options.h
index 237f2d6b4a..246c160aee 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -83,6 +83,7 @@ uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
 uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
+MigMode migrate_mode(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 7c6dfab128..b9179e8917 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -673,6 +673,20 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- MigMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_mig_mode = {
+    .name = "MigMode",
+    .description = "mig_mode values, "
+                   "normal",
+    .enum_table = &MigMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index dfe98da355..a170440991 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -387,6 +387,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
             params->vcpu_dirty_limit);
+
+        assert(params->has_mode);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
+            qapi_enum_lookup(&MigMode_lookup, params->mode));
     }
 
     qapi_free_MigrationParameters(params);
@@ -661,6 +666,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_vcpu_dirty_limit = true;
         visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
         break;
+    case MIGRATION_PARAMETER_MODE:
+        p->has_mode = true;
+        visit_type_MigMode(v, param, &p->mode, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 9a39826ca5..8d8ec73ad9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -176,6 +176,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
                        parameters.vcpu_dirty_limit,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
+    DEFINE_PROP_MIG_MODE("mode", MigrationState,
+                      parameters.mode,
+                      MIG_MODE_NORMAL),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -827,6 +830,13 @@ uint64_t migrate_max_postcopy_bandwidth(void)
     return s->parameters.max_postcopy_bandwidth;
 }
 
+MigMode migrate_mode(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.mode;
+}
+
 int migrate_multifd_channels(void)
 {
     MigrationState *s = migrate_get_current();
@@ -999,6 +1009,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
     params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
+    params->has_mode = true;
+    params->mode = s->parameters.mode;
 
     return params;
 }
@@ -1034,6 +1046,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_step = true;
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
+    params->has_mode = true;
 }
 
 /*
@@ -1331,6 +1344,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_vcpu_dirty_limit) {
         dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->has_mode) {
+        dest->mode = params->mode;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1471,6 +1488,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_vcpu_dirty_limit) {
         s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->has_mode) {
+        s->parameters.mode = params->mode;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
-- 
2.41.0


