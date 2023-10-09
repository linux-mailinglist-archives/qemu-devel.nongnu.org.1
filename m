Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D50AC7BE9FC
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:44:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvEC-0007dx-M8; Mon, 09 Oct 2023 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvE9-0007dA-W5
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:38 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvE8-0000ld-EQ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52FF821862;
 Mon,  9 Oct 2023 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wr358kdeh3X8Vk57IvELFdc/+EGO0eqkPtOdSkDbE+g=;
 b=RBWMSLM/cGMvnSnSIoQ/w9liRcHQgmjVBUev4s5p5w1ugMAEsingbQ6PybVv+8e3oVgd3P
 i78rTEQX9B4iuxl7xo/xW8FIaQMg3UGSsW1nJ4fIqts0ex3wClVPkr9E/H86JTYdYZU6kp
 RwNWU/vqmORj/dMXlt1QJ3+DIYp1yZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wr358kdeh3X8Vk57IvELFdc/+EGO0eqkPtOdSkDbE+g=;
 b=zvgLpYFVkWthH2naR4aKyVRfzliEPEVNteVaEDvdhayVncacHsrKRwOfX/A61hprb2FtDM
 MS5TQGxH9wjluxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6501513586;
 Mon,  9 Oct 2023 18:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mKwoC9NJJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/6] migration: Add the configuration vmstate to the json
 writer
Date: Mon,  9 Oct 2023 15:43:21 -0300
Message-Id: <20231009184326.15777-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009184326.15777-1-farosas@suse.de>
References: <20231009184326.15777-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Nikolay Borisov <nborisov@suse.com>

Make the migration json writer part of MigrationState struct, allowing
the 'configuration' object be serialized to json.

This will facilitate the parsing of the 'configuration' object in the
next patch that fixes analyze-migration.py for arm.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
farosas: rewrote the commit message. The previous one was tied to
fixed-ram.
---
 migration/migration.c |  1 +
 migration/savevm.c    | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..dde8471f83 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1430,6 +1430,7 @@ int migrate_init(MigrationState *s, Error **errp)
     error_free(s->error);
     s->error = NULL;
     s->hostname = NULL;
+    s->vmdesc = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 60eec7c31f..5343cbc234 100644
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
2.35.3


