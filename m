Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF4ACBE3A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 03:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbz-0006W4-Jb; Mon, 02 Jun 2025 21:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbw-0006Vk-DA
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbt-0001TC-SK
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED231F394;
 Tue,  3 Jun 2025 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50koTDEu3SbHwfE5G0Yi9mfEqL36JaorNyta18sQiX0=;
 b=azV5RHIl+/EJD0Dbc6bFmFbv6Q6bqelN+mvATvQeuimU1psJb0af5J9LyzInJ951ucTaqD
 At+daiirBykexQg5v+ZKpQhfM78oaHJMn9ayCpJZcqHcFr9UsdzrVLAfkzPO0/09xo8XwM
 Iz3273b9x6bZNBaua9iIaQLK4WTYypM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50koTDEu3SbHwfE5G0Yi9mfEqL36JaorNyta18sQiX0=;
 b=RqqsfM6HTV+xW9rbYheg51lRs1b1uB/lC3s25cZ5i2cKM3TiqrbtXcv3ogXixTwKudLyf8
 BjB6L3MPblS+QWAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50koTDEu3SbHwfE5G0Yi9mfEqL36JaorNyta18sQiX0=;
 b=azV5RHIl+/EJD0Dbc6bFmFbv6Q6bqelN+mvATvQeuimU1psJb0af5J9LyzInJ951ucTaqD
 At+daiirBykexQg5v+ZKpQhfM78oaHJMn9ayCpJZcqHcFr9UsdzrVLAfkzPO0/09xo8XwM
 Iz3273b9x6bZNBaua9iIaQLK4WTYypM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50koTDEu3SbHwfE5G0Yi9mfEqL36JaorNyta18sQiX0=;
 b=RqqsfM6HTV+xW9rbYheg51lRs1b1uB/lC3s25cZ5i2cKM3TiqrbtXcv3ogXixTwKudLyf8
 BjB6L3MPblS+QWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9152813700;
 Tue,  3 Jun 2025 01:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cOuyFBFSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/21] migration: Remove checks for s->parameters has_* fields
Date: Mon,  2 Jun 2025 22:37:55 -0300
Message-Id: <20250603013810.4772-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The migration parameters validation produces a temporary structure
which is the merge of the current parameter values (s->parameters,
MigrationParameters) with the new parameters set by the user
(MigrateSetParameters).

When copying the values from s->parameters into the temporary
structure, the has_* fields are copied along, but when merging the
user-input values (MigrateSetParameters) they are not.

During migrate_params_check(), only the parameters that have the
corresponding has_* field will be checked, so only the parameters that
were initialized in migrate_params_init() will be validated.

This causes (almost) all of the migration parameters to be validated
every time a parameter is set, regardless of which fields the user
touched, but it also skips validation of any values that are not set
in migrate_params_init().

It's not clear what was the intention of the original code, whether to
validate all fields always, or only validate what the user input
changed. Since the current situation is closer to the former option,
make the choice of validating all parameters by removing the checks
for the has_* fields when validating.

Note that bringing the user input into the temporary structure for
validation still needs to look at the has_* fields, otherwise any
parameters not set by the user (i.e. 0) would override the
corresponding value in s->parameters.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |   2 -
 migration/options.c   | 104 ++++++++++++------------------------------
 2 files changed, 29 insertions(+), 77 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f65cb81b6d..45e15ffeb6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4077,8 +4077,6 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
 
-    migrate_params_init(&ms->parameters);
-
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
diff --git a/migration/options.c b/migration/options.c
index cf77826204..d4021bc520 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1010,35 +1010,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     return params;
 }
 
-void migrate_params_init(MigrationParameters *params)
-{
-    /* Set has_* up only for parameter checks */
-    params->has_throttle_trigger_threshold = true;
-    params->has_cpu_throttle_initial = true;
-    params->has_cpu_throttle_increment = true;
-    params->has_cpu_throttle_tailslow = true;
-    params->has_max_bandwidth = true;
-    params->has_downtime_limit = true;
-    params->has_x_checkpoint_delay = true;
-    params->has_multifd_channels = true;
-    params->has_multifd_compression = true;
-    params->has_multifd_zlib_level = true;
-    params->has_multifd_qatzip_level = true;
-    params->has_multifd_zstd_level = true;
-    params->has_xbzrle_cache_size = true;
-    params->has_max_postcopy_bandwidth = true;
-    params->has_max_cpu_throttle = true;
-    params->has_announce_initial = true;
-    params->has_announce_max = true;
-    params->has_announce_rounds = true;
-    params->has_announce_step = true;
-    params->has_x_vcpu_dirty_limit_period = true;
-    params->has_vcpu_dirty_limit = true;
-    params->has_mode = true;
-    params->has_zero_page_detection = true;
-    params->has_direct_io = true;
-}
-
 static void migrate_post_update_params(MigrationParameters *new, Error **errp)
 {
     MigrationState *s = migrate_get_current();
@@ -1072,34 +1043,31 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
     ERRP_GUARD();
 
-    if (params->has_throttle_trigger_threshold &&
-        (params->throttle_trigger_threshold < 1 ||
-         params->throttle_trigger_threshold > 100)) {
+    if (params->throttle_trigger_threshold < 1 ||
+        params->throttle_trigger_threshold > 100) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "throttle_trigger_threshold",
                    "an integer in the range of 1 to 100");
         return false;
     }
 
-    if (params->has_cpu_throttle_initial &&
-        (params->cpu_throttle_initial < 1 ||
-         params->cpu_throttle_initial > 99)) {
+    if (params->cpu_throttle_initial < 1 ||
+        params->cpu_throttle_initial > 99) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "cpu_throttle_initial",
                    "an integer in the range of 1 to 99");
         return false;
     }
 
-    if (params->has_cpu_throttle_increment &&
-        (params->cpu_throttle_increment < 1 ||
-         params->cpu_throttle_increment > 99)) {
+    if (params->cpu_throttle_increment < 1 ||
+        params->cpu_throttle_increment > 99) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "cpu_throttle_increment",
                    "an integer in the range of 1 to 99");
         return false;
     }
 
-    if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
+    if (params->max_bandwidth > SIZE_MAX) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "max_bandwidth",
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
@@ -1107,8 +1075,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_avail_switchover_bandwidth &&
-        (params->avail_switchover_bandwidth > SIZE_MAX)) {
+    if (params->avail_switchover_bandwidth > SIZE_MAX) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "avail_switchover_bandwidth",
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
@@ -1116,8 +1083,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_downtime_limit &&
-        (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
+    if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "downtime_limit",
                    "an integer in the range of 0 to "
@@ -1127,92 +1093,82 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
-    if (params->has_multifd_channels && (params->multifd_channels < 1)) {
+    if (params->multifd_channels < 1) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
                    "a value between 1 and 255");
         return false;
     }
 
-    if (params->has_multifd_zlib_level &&
-        (params->multifd_zlib_level > 9)) {
+    if (params->multifd_zlib_level > 9) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level",
                    "a value between 0 and 9");
         return false;
     }
 
-    if (params->has_multifd_qatzip_level &&
-        ((params->multifd_qatzip_level > 9) ||
-        (params->multifd_qatzip_level < 1))) {
+    if (params->multifd_qatzip_level > 9 ||
+        params->multifd_qatzip_level < 1) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
                    "a value between 1 and 9");
         return false;
     }
 
-    if (params->has_multifd_zstd_level &&
-        (params->multifd_zstd_level > 20)) {
+    if (params->multifd_zstd_level > 20) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
                    "a value between 0 and 20");
         return false;
     }
 
-    if (params->has_xbzrle_cache_size &&
-        (params->xbzrle_cache_size < qemu_target_page_size() ||
-         !is_power_of_2(params->xbzrle_cache_size))) {
+    if (params->xbzrle_cache_size < qemu_target_page_size() ||
+        !is_power_of_2(params->xbzrle_cache_size)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "xbzrle_cache_size",
                    "a power of two no less than the target page size");
         return false;
     }
 
-    if (params->has_max_cpu_throttle &&
-        (params->max_cpu_throttle < params->cpu_throttle_initial ||
-         params->max_cpu_throttle > 99)) {
+    if (params->max_cpu_throttle < params->cpu_throttle_initial ||
+        params->max_cpu_throttle > 99) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "max_cpu_throttle",
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
 
-    if (params->has_announce_initial &&
-        params->announce_initial > 100000) {
+    if (params->announce_initial > 100000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_initial",
                    "a value between 0 and 100000");
         return false;
     }
-    if (params->has_announce_max &&
-        params->announce_max > 100000) {
+    if (params->announce_max > 100000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_max",
                    "a value between 0 and 100000");
        return false;
     }
-    if (params->has_announce_rounds &&
-        params->announce_rounds > 1000) {
+    if (params->announce_rounds > 1000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_rounds",
                    "a value between 0 and 1000");
        return false;
     }
-    if (params->has_announce_step &&
-        (params->announce_step < 1 ||
-        params->announce_step > 10000)) {
+    if (params->announce_step < 1 ||
+        params->announce_step > 10000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_step",
                    "a value between 0 and 10000");
        return false;
     }
 
-    if (params->has_block_bitmap_mapping &&
-        !check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
+    if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
         error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
         return false;
     }
 
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
-        ((params->has_multifd_compression && params->multifd_compression) ||
+        (params->multifd_compression ||
          (params->tls_creds && params->tls_creds->type == QTYPE_QSTRING &&
           *params->tls_creds->u.s))) {
         error_setg(errp,
@@ -1228,23 +1184,21 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_x_vcpu_dirty_limit_period &&
-        (params->x_vcpu_dirty_limit_period < 1 ||
-         params->x_vcpu_dirty_limit_period > 1000)) {
+    if (params->x_vcpu_dirty_limit_period < 1 ||
+        params->x_vcpu_dirty_limit_period > 1000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "x-vcpu-dirty-limit-period",
                    "a value between 1 and 1000");
         return false;
     }
 
-    if (params->has_vcpu_dirty_limit &&
-        (params->vcpu_dirty_limit < 1)) {
+    if (params->vcpu_dirty_limit < 1) {
         error_setg(errp,
                    "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s");
         return false;
     }
 
-    if (params->has_direct_io && params->direct_io && !qemu_has_direct_io()) {
+    if (params->direct_io && !qemu_has_direct_io()) {
         error_setg(errp, "No build-time support for direct-io");
         return false;
     }
-- 
2.35.3


