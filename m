Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4C8B7968
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Apr 2024 16:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oT9-0007HR-WC; Tue, 30 Apr 2024 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oT1-0007BJ-23
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:23 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oSx-0000Ap-Hj
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E52ED340D4;
 Tue, 30 Apr 2024 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOcY4XbffrATiitPUr/GIRNJ3Kv7WferCavM7elNhmg=;
 b=PvbjikIYORuAsTrjTwkqooxAGW8NrcyRwHQtwhEVNPAY4IDeHFs0DQo1N2PfB98nutP0Pu
 lUxJCQEM6aI8DeieBvj1Lg5n9pym+97DYs7NE6X5yQdDBQhZI9e2yPhpMSPZBvEfmfj8F5
 C0+8ajvnQ+z/3fc5NR9QHKPMuEeS/uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOcY4XbffrATiitPUr/GIRNJ3Kv7WferCavM7elNhmg=;
 b=RhCgRXGlxisnYZpiiEVzXpgQVWA6R8tqnDwpn3LxwvmHoy0aY0ct2+Lt+UvVVR1j/4VnHn
 DkS4iKaVwBs9eaAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T3mEVKS3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yoab41pI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOcY4XbffrATiitPUr/GIRNJ3Kv7WferCavM7elNhmg=;
 b=T3mEVKS3edfyJ1b2kG3UvTzzpDfMHuGpbwKYQoFSWg77lcCjoVA4cDnGOmormBcwUdUmwm
 NBbv9PsLAEEcynSQix95+bUIMnhgxBzBpK0PpbJTF1Cj9ssBAUoLOPMmIN+8lbbMmphErV
 2PGyy5E3R2gY044MhUXDp3nxxCB4PyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOcY4XbffrATiitPUr/GIRNJ3Kv7WferCavM7elNhmg=;
 b=Yoab41pIwZMVVzvP7CuyUt9LViMVf66a324rnmZsAScF7DEviqgghdW9Ia3RfgyPDB4UdL
 LOQmVClja9LuF7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE196133A7;
 Tue, 30 Apr 2024 14:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wAsAJf//MGZjSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Apr 2024 14:28:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 2/6] migration: Remove 'inc' option from migrate command
Date: Tue, 30 Apr 2024 11:27:33 -0300
Message-Id: <20240430142737.29066-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430142737.29066-1-farosas@suse.de>
References: <20240430142737.29066-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E52ED340D4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -5.01
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

The block incremental option for block migration has been deprecated
in 8.2 in favor of using the block-mirror feature. Remove it now.

Deprecation commit 40101f320d ("migration: migrate 'inc' command
option is deprecated.").

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst       |  9 ------
 docs/about/removed-features.rst | 14 +++++++++
 hmp-commands.hx                 | 13 +++-----
 migration/block.c               |  1 -
 migration/migration-hmp-cmds.c  | 18 ++---------
 migration/migration.c           | 24 +++++----------
 migration/options.c             | 30 +-----------------
 migration/options.h             |  5 ---
 qapi/migration.json             | 54 +++++++--------------------------
 9 files changed, 39 insertions(+), 129 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1c03a358d1..ebe53821ed 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -468,15 +468,6 @@ option).
 Migration
 ---------
 
-``inc`` migrate command option (since 8.2)
-''''''''''''''''''''''''''''''''''''''''''
-
-Use blockdev-mirror with NBD instead.
-
-As an intermediate step the ``inc`` functionality can be achieved by
-setting the ``block-incremental`` migration parameter to ``true``.
-But this parameter is also deprecated.
-
 ``blk`` migrate command option (since 8.2)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c4cb2692d0..7da4b3df14 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -620,6 +620,13 @@ was superseded by ``sections``.
 Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
 for more than 10 years. Removed with no replacement.
 
+``migrate`` command option ``inc`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use blockdev-mirror with NBD instead. See "QMP invocation for live
+storage migration with ``blockdev-mirror`` + NBD" in
+docs/interop/live-block-operations.rst for a detailed explanation.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -680,6 +687,13 @@ This command didn't produce any output already. Removed with no replacement.
 The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
 command, which has the same behaviour but a less misleading name.
 
+``migrate`` command ``-i`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use blockdev-mirror with NBD instead. See "QMP invocation for live
+storage migration with ``blockdev-mirror`` + NBD" in
+docs/interop/live-block-operations.rst for a detailed explanation.
+
 Host Architectures
 ------------------
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2e2a3bcf98..7978302949 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -909,26 +909,21 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
-        .params     = "[-d] [-b] [-i] [-r] uri",
+        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
+        .params     = "[-d] [-b] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
 		      "\n\t\t\t -b for migration without shared storage with"
-		      " full copy of disk\n\t\t\t -i for migration without "
-		      "shared storage with incremental copy of disk "
-		      "(base image shared between src and destination)"
-                      "\n\t\t\t -r to resume a paused migration",
+		      " full copy of disk\n\t\t\t -r to resume a paused migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-b] [-i]`` *uri*
+``migrate [-d] [-b]`` *uri*
   Migrate to *uri* (using -d to not wait for completion).
 
   ``-b``
     for migration with full copy of disk
-  ``-i``
-    for migration with incremental copy of disk (base image is shared)
 ERST
 
     {
diff --git a/migration/block.c b/migration/block.c
index bae6e94891..87ec1a7e68 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -419,7 +419,6 @@ static int init_blk_migration(QEMUFile *f, Error **errp)
         bmds->bulk_completed = 0;
         bmds->total_sectors = sectors;
         bmds->completed_sectors = 0;
-        bmds->shared_base = migrate_block_incremental();
 
         assert(i < num_bs);
         bmds_bs[i].bmds = bmds;
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 28f776d06d..f49f061be1 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -332,10 +332,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
-        assert(params->has_block_incremental);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
-            params->block_incremental ? "on" : "off");
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -616,10 +612,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_checkpoint_delay = true;
         visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
         break;
-    case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
-        p->has_block_incremental = true;
-        visit_type_bool(v, param, &p->block_incremental, &err);
-        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
@@ -767,18 +759,12 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 {
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool blk = qdict_get_try_bool(qdict, "blk", false);
-    bool inc = qdict_get_try_bool(qdict, "inc", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
     g_autoptr(MigrationChannelList) caps = NULL;
     g_autoptr(MigrationChannel) channel = NULL;
 
-    if (inc) {
-        warn_report("option '-i' is deprecated;"
-                    " use blockdev-mirror with NBD instead");
-    }
-
     if (blk) {
         warn_report("option '-b' is deprecated;"
                     " use blockdev-mirror with NBD instead");
@@ -790,8 +776,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
-                 false, false, true, resume, &err);
+    qmp_migrate(NULL, true, caps, !!blk, blk, false, false,
+                true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 266652668d..ee28c26676 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1911,14 +1911,9 @@ bool migration_is_blocked(Error **errp)
 }
 
 /* Returns true if continue to migrate, or false if error detected */
-static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
-                            bool resume, Error **errp)
+static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
+                            Error **errp)
 {
-    if (blk_inc) {
-        warn_report("parameter 'inc' is deprecated;"
-                    " use blockdev-mirror with NBD instead");
-    }
-
     if (blk) {
         warn_report("parameter 'blk' is deprecated;"
                     " use blockdev-mirror with NBD instead");
@@ -2008,12 +2003,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         }
     }
 
-    if (blk || blk_inc) {
+    if (blk) {
         if (migrate_colo()) {
             error_setg(errp, "No disk migration is required in COLO mode");
             return false;
         }
-        if (migrate_block() || migrate_block_incremental()) {
+        if (migrate_block()) {
             error_setg(errp, "Command options are incompatible with "
                        "current migration capabilities");
             return false;
@@ -2024,10 +2019,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         s->must_remove_block_options = true;
     }
 
-    if (blk_inc) {
-        migrate_set_block_incremental(true);
-    }
-
     if (migrate_init(s, errp)) {
         return false;
     }
@@ -2037,8 +2028,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
 
 void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_blk, bool blk,
-                 bool has_inc, bool inc, bool has_detach, bool detach,
-                 bool has_resume, bool resume, Error **errp)
+                 bool has_detach, bool detach, bool has_resume, bool resume,
+                 Error **errp)
 {
     bool resume_requested;
     Error *local_err = NULL;
@@ -2077,8 +2068,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     resume_requested = has_resume && resume;
-    if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
-                         resume_requested, errp)) {
+    if (!migrate_prepare(s, has_blk && blk, resume_requested, errp)) {
         /* Error detected, put into errp */
         return;
     }
diff --git a/migration/options.c b/migration/options.c
index 239f5ecfb4..5b16d99bd9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -486,7 +486,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
 
 #ifndef CONFIG_LIVE_BLOCK_MIGRATION
     if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
-        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+        error_setg(errp, "QEMU compiled without old-style (blk/-b) "
                    "block migration");
         error_append_hint(errp, "Use blockdev-mirror with NBD instead.\n");
         return false;
@@ -763,13 +763,6 @@ bool migrate_has_block_bitmap_mapping(void)
     return s->parameters.has_block_bitmap_mapping;
 }
 
-bool migrate_block_incremental(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.block_incremental;
-}
-
 uint32_t migrate_checkpoint_delay(void)
 {
     MigrationState *s = migrate_get_current();
@@ -948,15 +941,6 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
-/* parameter setters */
-
-void migrate_set_block_incremental(bool value)
-{
-    MigrationState *s = migrate_get_current();
-
-    s->parameters.block_incremental = value;
-}
-
 /* parameters helpers */
 
 void block_cleanup_parameters(void)
@@ -966,7 +950,6 @@ void block_cleanup_parameters(void)
     if (s->must_remove_block_options) {
         /* setting to false can never fail */
         migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, false, &error_abort);
-        migrate_set_block_incremental(false);
         s->must_remove_block_options = false;
     }
 }
@@ -1020,8 +1003,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->has_block_incremental = true;
-    params->block_incremental = s->parameters.block_incremental;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -1081,7 +1062,6 @@ void migrate_params_init(MigrationParameters *params)
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
-    params->has_block_incremental = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1359,9 +1339,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_checkpoint_delay = params->x_checkpoint_delay;
     }
 
-    if (params->has_block_incremental) {
-        dest->block_incremental = params->block_incremental;
-    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1502,11 +1479,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         colo_checkpoint_delay_set();
     }
 
-    if (params->has_block_incremental) {
-        warn_report("block migration is deprecated;"
-                    " use blockdev-mirror with NBD instead");
-        s->parameters.block_incremental = params->block_incremental;
-    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/migration/options.h b/migration/options.h
index ab8199e207..fa5eb177df 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -67,7 +67,6 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
-bool migrate_block_incremental(void);
 uint32_t migrate_checkpoint_delay(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
@@ -92,10 +91,6 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
-/* parameters setters */
-
-void migrate_set_block_incremental(bool value);
-
 /* parameters helpers */
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
diff --git a/qapi/migration.json b/qapi/migration.json
index 401b8e24ac..a23c162ad8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -839,13 +839,6 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO
 #     checkpoints in periodic mode.  (Since 2.8)
 #
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
 # @multifd-channels: Number of channels used to migrate data in
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
@@ -908,10 +901,9 @@
 #
 # Features:
 #
-# @deprecated: Member @block-incremental is deprecated.  Use
-#     blockdev-mirror with NBD instead.  Members @compress-level,
-#     @compress-threads, @decompress-threads and @compress-wait-thread
-#     are deprecated because @compression is deprecated.
+# @deprecated: Members @compress-level, @compress-threads,
+#     @decompress-threads and @compress-wait-thread are deprecated
+#     because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
@@ -931,7 +923,6 @@
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -1047,13 +1038,6 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO
 #     checkpoints in periodic mode.  (Since 2.8)
 #
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
 # @multifd-channels: Number of channels used to migrate data in
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
@@ -1116,10 +1100,9 @@
 #
 # Features:
 #
-# @deprecated: Member @block-incremental is deprecated.  Use
-#     blockdev-mirror with NBD instead.  Members @compress-level,
-#     @compress-threads, @decompress-threads and @compress-wait-thread
-#     are deprecated because @compression is deprecated.
+# @deprecated: Members @compress-level, @compress-threads,
+#     @decompress-threads and @compress-wait-thread are deprecated
+#     because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
@@ -1154,8 +1137,6 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': { 'type': 'bool',
-                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1279,13 +1260,6 @@
 # @x-checkpoint-delay: the delay time between two COLO checkpoints.
 #     (Since 2.8)
 #
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
 # @multifd-channels: Number of channels used to migrate data in
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
@@ -1348,10 +1322,9 @@
 #
 # Features:
 #
-# @deprecated: Member @block-incremental is deprecated.  Use
-#     blockdev-mirror with NBD instead.  Members @compress-level,
-#     @compress-threads, @decompress-threads and @compress-wait-thread
-#     are deprecated because @compression is deprecated.
+# @deprecated: Members @compress-level, @compress-threads,
+#     @decompress-threads and @compress-wait-thread are deprecated
+#     because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
@@ -1383,8 +1356,6 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': { 'type': 'bool',
-                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1736,8 +1707,6 @@
 #
 # @blk: do block migration (full disk copy)
 #
-# @inc: incremental disk copy migration
-#
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
@@ -1745,8 +1714,8 @@
 #
 # Features:
 #
-# @deprecated: Members @inc and @blk are deprecated.  Use
-#     blockdev-mirror with NBD instead.
+# @deprecated: Member @blk is deprecated.  Use blockdev-mirror with
+#     NBD instead.
 #
 # Since: 0.14
 #
@@ -1814,7 +1783,6 @@
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
-           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
-- 
2.35.3


