Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B72417416D7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYSx-0003XW-DO; Wed, 28 Jun 2023 12:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEYSV-0003Ss-0z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:55:59 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEYSN-0001ms-T3
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:55:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76B8721860;
 Wed, 28 Jun 2023 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687971348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRBEbrVsvSG4EHJvlPYfoyMOVzjxhl87vVvZi4PMh74=;
 b=LcQwihvs6eZaO2Xsg7ZIMscDtwTJAJTz/F3CB+T+Kzvk9bcOY6aBziRwvkcMCf8l03n+iD
 a6UGIg0/JFOBq0+LmdydP7njRR1WM45TC8bgtoS3QrK3bGwKCO9KjlHL5GsODxeLRc6ArM
 6MqOKn3XyHIAVxc1TjjFnpBvUnzcJdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687971348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRBEbrVsvSG4EHJvlPYfoyMOVzjxhl87vVvZi4PMh74=;
 b=kZcPYg0hQyjLlFnj8Auu3QXMgLF7W/yAjX6WJxh39vhegeoqQ0SUUfPum+sNcxXRbVBqfx
 o3eSKXIXETwA62Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4D7C138EF;
 Wed, 28 Jun 2023 16:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yN1iHxJmnGRIZwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 28 Jun 2023 16:55:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 1/6] migration: Set migration status early in incoming side
Date: Wed, 28 Jun 2023 13:55:37 -0300
Message-Id: <20230628165542.17214-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230628165542.17214-1-farosas@suse.de>
References: <20230628165542.17214-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We are sending a migration event of MIGRATION_STATUS_SETUP at
qemu_start_incoming_migration but never actually setting the state.

This creates a window between qmp_migrate_incoming and
process_incoming_migration_co where the migration status is still
MIGRATION_STATUS_NONE. Calling query-migrate during this time will
return an empty response even though the incoming migration command
has already been issued.

Commit 7cf1fe6d68 ("migration: Add migration events on target side")
has added support to the 'events' capability to the incoming part of
migration, but chose to send the SETUP event without setting the
state. I'm assuming this was a mistake.

To avoid introducing a change in behavior, we need to keep sending the
SETUP event, even if the 'events' capability is not set. Add the
force-emit-setup-event migration property to enable it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 17 +++++++++++++++--
 migration/migration.h | 11 +++++++++++
 migration/options.c   | 13 +++++++++++++
 migration/options.h   |  1 +
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7c8292d4d4..6da1865e80 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -424,13 +424,26 @@ void migrate_add_address(SocketAddress *address)
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
-    qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
+                      MIGRATION_STATUS_SETUP);
+    /*
+     * QMP clients should have set the 'events' migration capability
+     * if they want to receive this event, in which case the
+     * migrate_set_state() call above will have already sent the
+     * event. We still need to send the event for compatibility even
+     * if migration events are disabled.
+     */
+    if (migrate_emit_setup_event()) {
+        qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    }
+
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
         strstart(uri, "vsock:", NULL)) {
@@ -524,7 +537,7 @@ process_incoming_migration_co(void *opaque)
 
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
+    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
diff --git a/migration/migration.h b/migration/migration.h
index 30c3e97635..05e1e19e4f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -433,6 +433,17 @@ struct MigrationState {
      */
     uint8_t clear_bitmap_shift;
 
+    /*
+     * Always emit the incoming migration's SETUP event, even when the
+     * 'events' capability is not enabled.
+     *
+     * QMP clients that wish to receive migration events should always
+     * enable the 'events' capability. This property is for
+     * compatibility with clients that rely on the older QEMU behavior
+     * of unconditionally emitting the SETUP event.
+     */
+    bool force_emit_setup_event;
+
     /*
      * This save hostname when out-going migration starts
      */
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..b0eda7cb05 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -95,6 +95,8 @@ Property migration_properties[] = {
                       clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
     DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
                      preempt_pre_7_2, false),
+    DEFINE_PROP_BOOL("force-emit-setup-event", MigrationState,
+                      force_emit_setup_event, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
@@ -338,6 +340,17 @@ bool migrate_zero_copy_send(void)
 
 /* pseudo capabilities */
 
+bool migrate_emit_setup_event(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    /*
+     * If migration events are enabled the setup event will have
+     * already been sent.
+     */
+    return !migrate_events() && s->force_emit_setup_event;
+}
+
 bool migrate_multifd_flush_after_each_section(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 45991af3c2..5c9785e455 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -52,6 +52,7 @@ bool migrate_zero_copy_send(void);
  * check, but they are not a capability.
  */
 
+bool migrate_emit_setup_event(void);
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
 bool migrate_tls(void);
-- 
2.35.3


