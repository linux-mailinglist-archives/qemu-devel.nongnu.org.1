Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0C7CBD84
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfU9-0005dk-Ji; Tue, 17 Oct 2023 04:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTX-0004qg-75
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTS-0005Fo-RR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAk3oiumVyieypmTNNycCFwFd2DBmAvPFPTiFRln4pE=;
 b=GHLLGKkMj7hUsapZ/rcR0Jqs+6+YtyvvgzfziokOFUk84PT84D5MLetIG+XKzKDlPit0QN
 QzEGGKTBQI2aW8VRbLnogstaZaYAycTnUYlc6eH/JxrA+geqafZo1yuHG9eTK2LiSdrEBX
 d9wF4Yr/Tr5xUJ8dQenZZSrkDgHrSS0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-b_DDfWDPM8OE97FbbEwYgQ-1; Tue, 17 Oct 2023 04:30:24 -0400
X-MC-Unique: b_DDfWDPM8OE97FbbEwYgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76855185A797;
 Tue, 17 Oct 2023 08:30:23 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B81A21C060AE;
 Tue, 17 Oct 2023 08:30:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Nikolay Borisov <nborisov@suse.com>
Subject: [PULL 05/38] migration: Add the configuration vmstate to the json
 writer
Date: Tue, 17 Oct 2023 10:29:30 +0200
Message-ID: <20231017083003.15951-6-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Nikolay Borisov <nborisov@suse.com>

Make the migration json writer part of MigrationState struct, allowing
the 'configuration' object be serialized to json.

This will facilitate the parsing of the 'configuration' object in the
next patch that fixes analyze-migration.py for arm.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-2-farosas@suse.de>
---
 migration/migration.c |  1 +
 migration/savevm.c    | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ed04ca3b1c..98151b1424 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1442,6 +1442,7 @@ int migrate_init(MigrationState *s, Error **errp)
     error_free(s->error);
     s->error = NULL;
     s->hostname = NULL;
+    s->vmdesc = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 497ce02bd7..bce698b0af 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1217,13 +1217,27 @@ void qemu_savevm_non_migratable_list(strList **reasons)
 
 void qemu_savevm_state_header(QEMUFile *f)
 {
+    MigrationState *s = migrate_get_current();
+
+    s->vmdesc = json_writer_new(false);
+
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
 
-    if (migrate_get_current()->send_configuration) {
+    if (s->send_configuration) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
+
+        /*
+         * This starts the main json object and is paired with the
+         * json_writer_end_object in
+         * qemu_savevm_state_complete_precopy_non_iterable
+         */
+        json_writer_start_object(s->vmdesc, NULL);
+
+        json_writer_start_object(s->vmdesc, "configuration");
+        vmstate_save_state(f, &vmstate_configuration, &savevm_state, s->vmdesc);
+        json_writer_end_object(s->vmdesc);
     }
 }
 
@@ -1272,8 +1286,6 @@ void qemu_savevm_state_setup(QEMUFile *f)
     Error *local_err = NULL;
     int ret;
 
-    ms->vmdesc = json_writer_new(false);
-    json_writer_start_object(ms->vmdesc, NULL);
     json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
     json_writer_start_array(ms->vmdesc, "devices");
 
-- 
2.41.0


