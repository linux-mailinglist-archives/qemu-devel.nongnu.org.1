Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B34EAEE7E2
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Jun 2025 22:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKgP-00057g-54; Mon, 30 Jun 2025 16:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg8-0004vR-TD
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg6-0007lz-SB
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D18021164;
 Mon, 30 Jun 2025 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UizGjpaAFRQHuVHPt7zudRmh6GJ7tNvItuwzxtxuTqA=;
 b=yiBfLuPG+9biXdk9rY2BSt4+qt06CMSCGRBtJnihzoRh2RxkmExz29H7dcf84xSLDFQSUd
 P4HSkDjJJHgb9EMSASi/XqlHL2zcMeyedPkyY3Aiw9nTbfGrEiBxLVqwqX4g6BOCWUZswq
 ibPivNSk5CTps7VyI/h9YISwbP+15kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UizGjpaAFRQHuVHPt7zudRmh6GJ7tNvItuwzxtxuTqA=;
 b=llOy9g1ap/Oq7hZO3c1jUvPR4d2BphjEh5H0zCl0qxm5nH5OhagudSLtlDQ2ZlR73Z3YdF
 Tusw43RJMN+B58Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UizGjpaAFRQHuVHPt7zudRmh6GJ7tNvItuwzxtxuTqA=;
 b=yiBfLuPG+9biXdk9rY2BSt4+qt06CMSCGRBtJnihzoRh2RxkmExz29H7dcf84xSLDFQSUd
 P4HSkDjJJHgb9EMSASi/XqlHL2zcMeyedPkyY3Aiw9nTbfGrEiBxLVqwqX4g6BOCWUZswq
 ibPivNSk5CTps7VyI/h9YISwbP+15kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UizGjpaAFRQHuVHPt7zudRmh6GJ7tNvItuwzxtxuTqA=;
 b=llOy9g1ap/Oq7hZO3c1jUvPR4d2BphjEh5H0zCl0qxm5nH5OhagudSLtlDQ2ZlR73Z3YdF
 Tusw43RJMN+B58Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE5961399F;
 Mon, 30 Jun 2025 19:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yM92I73sYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 19/24] migration: Store the initial values used for
 s->parameters
Date: Mon, 30 Jun 2025 16:59:08 -0300
Message-Id: <20250630195913.28033-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Each migration parameters has a default value, store them for later
use in resetting s->parameters. Values overridden via the command line
with the debugging option -global migration.<param> will be included.

Make the structure const and change the appropriate signatures to make
sure its values are not changed by accident. Some functions take two
MigrationParameters pointers and it's easy to confuse them.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  3 +++
 migration/migration.h |  6 ++++++
 migration/options.c   | 21 +++++++++++++++++----
 migration/options.h   |  7 ++++---
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index aa954f5fc7..13b70dbb94 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -335,6 +335,7 @@ void migration_object_init(void)
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
     migration_object_check(current_migration, &error_fatal);
+    migrate_params_store_defaults(current_migration);
 
     ram_mig_init();
     dirty_bitmap_mig_init();
@@ -4051,6 +4052,8 @@ static void migration_instance_finalize(Object *obj)
     MigrationState *ms = MIGRATION_OBJ(obj);
 
     qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
+    /* drop const */
+    qapi_free_MigrationParameters((MigrationParameters *)ms->initial_params);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
diff --git a/migration/migration.h b/migration/migration.h
index 7d3a607029..b1107b4e30 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -319,6 +319,12 @@ struct MigrationState {
 
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
+    /*
+     * This holds the values initially set in the 'parameters' struct
+     * above. Any values overriden by -global migration.<parameter>
+     * will be reflected here as well.
+     */
+    const MigrationParameters *initial_params;
 
     MigrationStatus state;
 
diff --git a/migration/options.c b/migration/options.c
index 90440731d0..2f6ccefa21 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -472,7 +472,7 @@ static bool migrate_incoming_started(void)
     return !!migration_incoming_get_current()->transport_data;
 }
 
-bool migrate_rdma_caps_check(MigrationParameters *params, Error **errp)
+bool migrate_rdma_caps_check(const MigrationParameters *params, Error **errp)
 {
     if (params->xbzrle) {
         error_setg(errp, "RDMA and XBZRLE can't be used together");
@@ -490,7 +490,7 @@ bool migrate_rdma_caps_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-bool migrate_caps_check(MigrationParameters *new, Error **errp)
+bool migrate_caps_check(const MigrationParameters *new, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -1161,7 +1161,7 @@ static void migrate_post_update_params(MigrationParameters *new, Error **errp)
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
  */
-bool migrate_params_check(MigrationParameters *params, Error **errp)
+bool migrate_params_check(const MigrationParameters *params, Error **errp)
 {
     ERRP_GUARD();
 
@@ -1373,7 +1373,7 @@ out:
     return ok;
 }
 
-static void migrate_params_apply(MigrationParameters *params)
+static void migrate_params_apply(const MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
     MigrationParameters *cur = &s->parameters;
@@ -1385,6 +1385,19 @@ static void migrate_params_apply(MigrationParameters *params)
     QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
 }
 
+void migrate_params_store_defaults(MigrationState *s)
+{
+    assert(!s->initial_params);
+
+    /*
+     * The defaults set for each qdev property in migration_properties
+     * will be stored as the default values for each migration
+     * parameter. For debugging, using -global can override the
+     * defaults.
+     */
+    s->initial_params = QAPI_CLONE(MigrationParameters, &s->parameters);
+}
+
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 1ce38c30fb..91154c4322 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -46,7 +46,7 @@ bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
 
-bool migrate_rdma_caps_check(MigrationParameters *config, Error **errp);
+bool migrate_rdma_caps_check(const MigrationParameters *config, Error **errp);
 
 /* parameters */
 
@@ -75,7 +75,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
-bool migrate_params_check(MigrationParameters *params, Error **errp);
+bool migrate_params_check(const MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
 void migrate_tls_opts_free(MigrationParameters *params);
 bool migrate_capability_get_compat(MigrationParameters *params, int i);
@@ -83,5 +83,6 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
                                    bool val);
 void migrate_capabilities_set_compat(MigrationParameters *params,
                                      MigrationCapabilityStatusList *caps);
-bool migrate_caps_check(MigrationParameters *new, Error **errp);
+bool migrate_caps_check(const MigrationParameters *const new, Error **errp);
+void migrate_params_store_defaults(MigrationState *s);
 #endif
-- 
2.35.3


