Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A1AEE7DA
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Jun 2025 22:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKfa-0002ne-Se; Mon, 30 Jun 2025 16:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfY-0002m2-Gs
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfV-0007VH-KB
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B4341F444;
 Mon, 30 Jun 2025 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7uVUSYK8YrLey5ZAtySSapN50WkNS6lNhMOsBxmN/w=;
 b=bpCBoKRP6gU+1RGXz60ybORx34spwCF6l7Vc1jKQAZ5CxhIdZuDaoa68EAFhnADoPfIv+o
 k8bu1sqmd2VFbMntbAcEoHzvjqWffW2bbsJjvXt4cv4LUUbfxumxg10OfObmbtpLsoSP5B
 nBdcD0YB2d8f9IdT4JOWTxA8Kg5t/eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7uVUSYK8YrLey5ZAtySSapN50WkNS6lNhMOsBxmN/w=;
 b=9jDH+pfOQPy3aUsQDPbyTMFtcADOrvdZOXonx3lS8yht4ZbXdOq94FYROWP1BYBuZlRNSJ
 MN9EFLzd6aekrRCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7uVUSYK8YrLey5ZAtySSapN50WkNS6lNhMOsBxmN/w=;
 b=bpCBoKRP6gU+1RGXz60ybORx34spwCF6l7Vc1jKQAZ5CxhIdZuDaoa68EAFhnADoPfIv+o
 k8bu1sqmd2VFbMntbAcEoHzvjqWffW2bbsJjvXt4cv4LUUbfxumxg10OfObmbtpLsoSP5B
 nBdcD0YB2d8f9IdT4JOWTxA8Kg5t/eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7uVUSYK8YrLey5ZAtySSapN50WkNS6lNhMOsBxmN/w=;
 b=9jDH+pfOQPy3aUsQDPbyTMFtcADOrvdZOXonx3lS8yht4ZbXdOq94FYROWP1BYBuZlRNSJ
 MN9EFLzd6aekrRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11BBB1399F;
 Mon, 30 Jun 2025 19:59:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GKYLMafsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 09/24] migration: Do away with usage of
 QERR_INVALID_PARAMETER_VALUE
Date: Mon, 30 Jun 2025 16:58:58 -0300
Message-Id: <20250630195913.28033-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

The QERR_INVALID_PARAMETER_VALUE macro is documented as not to be used
in new code. Remove the usage from migration/options.c.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  |  3 +--
 migration/options.c    | 56 +++++++++++++++---------------------------
 migration/page_cache.c |  6 ++---
 migration/ram.c        |  3 +--
 4 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7ec60d97f9..487019dc69 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2302,8 +2302,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         file_start_outgoing_migration(s, &addr->u.file, &local_err);
     } else {
-        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
-                   "a valid migration protocol");
+        error_setg(&local_err, "uri is not a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
     }
diff --git a/migration/options.c b/migration/options.c
index af19c8f2e0..7a6a7d4ee5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1093,120 +1093,105 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->throttle_trigger_threshold < 1 ||
         params->throttle_trigger_threshold > 100) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "throttle_trigger_threshold",
+        error_setg(errp, "Option throttle_trigger_threshold expects "
                    "an integer in the range of 1 to 100");
         return false;
     }
 
     if (params->cpu_throttle_initial < 1 ||
         params->cpu_throttle_initial > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "cpu_throttle_initial",
+        error_setg(errp, "Option cpu_throttle_initial expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->cpu_throttle_increment < 1 ||
         params->cpu_throttle_increment > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "cpu_throttle_increment",
+        error_setg(errp, "Option cpu_throttle_increment expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->max_bandwidth > SIZE_MAX) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "max_bandwidth",
+        error_setg(errp, "Option max_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->avail_switchover_bandwidth > SIZE_MAX) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "avail_switchover_bandwidth",
+        error_setg(errp, "Option avail_switchover_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "downtime_limit",
+        error_setg(errp, "Option downtime_limit expects "
                    "an integer in the range of 0 to "
                     stringify(MAX_MIGRATE_DOWNTIME)" ms");
         return false;
     }
 
-    /* x_checkpoint_delay is now always positive */
-
     if (params->multifd_channels < 1) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "multifd_channels",
+        error_setg(errp, "Option multifd_channels expects "
                    "a value between 1 and 255");
         return false;
     }
 
     if (params->multifd_zlib_level > 9) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level",
+        error_setg(errp, "Option multifd_zlib_level expects "
                    "a value between 0 and 9");
         return false;
     }
 
     if (params->multifd_qatzip_level > 9 ||
         params->multifd_qatzip_level < 1) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
+        error_setg(errp, "Option multifd_qatzip_level expects "
                    "a value between 1 and 9");
         return false;
     }
 
     if (params->multifd_zstd_level > 20) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
+        error_setg(errp, "Option multifd_zstd_level expects "
                    "a value between 0 and 20");
         return false;
     }
 
     if (params->xbzrle_cache_size < qemu_target_page_size() ||
         !is_power_of_2(params->xbzrle_cache_size)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "xbzrle_cache_size",
+        error_setg(errp, "Option xbzrle_cache_size expects "
                    "a power of two no less than the target page size");
         return false;
     }
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "max_cpu_throttle",
+        error_setg(errp, "max_Option cpu_throttle expects "
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
 
     if (params->announce_initial > 100000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_initial",
+        error_setg(errp, "Option announce_initial expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_max > 100000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_max",
+        error_setg(errp, "Option announce_max expects "
                    "a value between 0 and 100000");
-       return false;
+        return false;
     }
     if (params->announce_rounds > 1000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_rounds",
+        error_setg(errp, "Option announce_rounds expects "
                    "a value between 0 and 1000");
-       return false;
+        return false;
     }
     if (params->announce_step < 1 ||
         params->announce_step > 10000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_step",
+        error_setg(errp, "Option announce_step expects "
                    "a value between 0 and 10000");
-       return false;
+        return false;
     }
 
     if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
@@ -1232,8 +1217,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->x_vcpu_dirty_limit_period < 1 ||
         params->x_vcpu_dirty_limit_period > 1000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "x-vcpu-dirty-limit-period",
+        error_setg(errp, "Option x-vcpu-dirty-limit-period expects "
                    "a value between 1 and 1000");
         return false;
     }
diff --git a/migration/page_cache.c b/migration/page_cache.c
index 6d4f7a9bbc..650b15e48c 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -45,15 +45,13 @@ PageCache *cache_init(uint64_t new_size, size_t page_size, Error **errp)
     PageCache *cache;
 
     if (new_size < page_size) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is smaller than one target page size");
+        error_setg(errp, "cache size is smaller than target page size");
         return NULL;
     }
 
     /* round down to the nearest power of 2 */
     if (!is_power_of_2(num_pages)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is not a power of two number of pages");
+        error_setg(errp, "number of pages is not a power of two");
         return NULL;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 7432f82bdd..bb86a91db1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -191,8 +191,7 @@ int xbzrle_cache_resize(uint64_t new_size, Error **errp)
 
     /* Check for truncation */
     if (new_size != (size_t)new_size) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "exceeding address space");
+        error_setg(errp, "xbzrle cache size integer overflow");
         return -1;
     }
 
-- 
2.35.3


