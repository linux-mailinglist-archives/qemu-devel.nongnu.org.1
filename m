Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8787510F8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:08:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfBy-0007w9-4K; Wed, 12 Jul 2023 15:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBw-0007po-2E
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:08:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBu-00084p-KE
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:07:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25B1B220CD;
 Wed, 12 Jul 2023 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689188877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28Nw9cqhw+7ReLxdF3f5tixKPVVafMUIgHkCzzd37sg=;
 b=cDiD1IwA3RICvTi2krOTF+PQILxj30pkq4Yntfu65dCC+OU+W96Irml1Gw1sCLLQn9Qpn/
 eEOoSikyvXqoceGCrqfTiFCcoIaU+7DakhraEsmbKWY4UtOAEoJWZynebRuYdaOni7f1Bl
 /W5EX616bRm3Mcs211GOgKMX+pKYKJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689188877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28Nw9cqhw+7ReLxdF3f5tixKPVVafMUIgHkCzzd37sg=;
 b=ryMByPW0t42X4BILFPZyIEgQiwooG2zJHEEcg3Np3e8ijq2RZ9vvae9EILXMo9dfevsapn
 fDrrt5T3MnQMZ/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6666713336;
 Wed, 12 Jul 2023 19:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gNJGDAv6rmROOgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 12 Jul 2023 19:07:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v5 4/6] migration: Set migration status early in incoming side
Date: Wed, 12 Jul 2023 16:07:40 -0300
Message-Id: <20230712190742.22294-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230712190742.22294-1-farosas@suse.de>
References: <20230712190742.22294-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

This introduces a change in behavior, any QMP client waiting for the
SETUP event will hang, unless it has previously enabled the 'events'
capability. Having the capability enabled is sufficient to continue to
receive the event.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ea020c8335..5c8e82f82b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -425,13 +425,16 @@ void migrate_add_address(SocketAddress *address)
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
+
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
         strstart(uri, "vsock:", NULL)) {
@@ -525,7 +528,7 @@ process_incoming_migration_co(void *opaque)
 
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
+    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
-- 
2.35.3


