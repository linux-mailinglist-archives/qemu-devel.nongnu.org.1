Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8DACBE36
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 03:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbw-0006TP-Lp; Mon, 02 Jun 2025 21:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbt-0006SG-87
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:37 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbr-0001So-Av
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3483121201;
 Tue,  3 Jun 2025 01:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHnx5M5HxA90aoDKwj6ABbbajp1kkSlJooZkthwqkIY=;
 b=F4CxUiWkg1oKD9yO5xwUYgAMEcJimJAPfnD3j4LqY+R3RGLRk3PYVUkR/ySWwkmza6O2UT
 Mk5b7v+gM4RpaMKEMOs4ophGh11t4fAr5mq5O0MphaIwyP5f85ZzHE3eHvLqAoHRPDZWhQ
 h8twYAoJ8SxYpY5662rl/WxK5V8n1aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHnx5M5HxA90aoDKwj6ABbbajp1kkSlJooZkthwqkIY=;
 b=jb69BCnAO0IPp1HCEwA53sLXWrLf4EbrneiCq1cNhCvTOZCMvHi1AEHkqjdeCB2TZlRlH0
 dSe76+HPXWaNTQAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F4CxUiWk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jb69BCnA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHnx5M5HxA90aoDKwj6ABbbajp1kkSlJooZkthwqkIY=;
 b=F4CxUiWkg1oKD9yO5xwUYgAMEcJimJAPfnD3j4LqY+R3RGLRk3PYVUkR/ySWwkmza6O2UT
 Mk5b7v+gM4RpaMKEMOs4ophGh11t4fAr5mq5O0MphaIwyP5f85ZzHE3eHvLqAoHRPDZWhQ
 h8twYAoJ8SxYpY5662rl/WxK5V8n1aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHnx5M5HxA90aoDKwj6ABbbajp1kkSlJooZkthwqkIY=;
 b=jb69BCnAO0IPp1HCEwA53sLXWrLf4EbrneiCq1cNhCvTOZCMvHi1AEHkqjdeCB2TZlRlH0
 dSe76+HPXWaNTQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6FE713700;
 Tue,  3 Jun 2025 01:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCPSGRdSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/21] migration: Extract code to mark all parameters as
 present
Date: Mon,  2 Jun 2025 22:37:58 -0300
Message-Id: <20250603013810.4772-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3483121201
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01
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

MigrationParameters needs to have all of its has_* fields marked as
true when used as the return of query_migrate_parameters because the
corresponding QMP command has all of its members non-optional by
design, despite them being marked as optional in migration.json.

Extract this code into a function and make it assert if any field is
missing. With this we ensure future changes will not inadvertently
leave any parameters missing.

Also assert that s->parameters _does not_ have any of its has_* fields
set. This structure is internal to the migration code and it should
not rely on the QAPI-generate has_* fields. We might want to store
migration parameters differently in the future.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 74 ++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index e2e3ab717f..dd62e726cb 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -936,6 +936,40 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
     }
 }
 
+static void migrate_mark_all_params_present(MigrationParameters *p)
+{
+    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
+    bool *has_fields[] = {
+        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
+        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
+        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
+        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
+        &p->has_multifd_channels, &p->has_multifd_compression,
+        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
+        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
+        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
+        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
+        &p->has_announce_step, &p->has_block_bitmap_mapping,
+        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
+        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
+    };
+
+    /*
+     * The has_* fields of MigrationParameters are used by QAPI to
+     * inform whether an optional struct member is present. Keep this
+     * decoupled from the internal usage (not QAPI) by leaving the
+     * has_* fields of s->parameters unused.
+     */
+    assert(p != &(migrate_get_current())->parameters);
+
+    len = ARRAY_SIZE(has_fields);
+    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
+
+    for (int i = 0; i < len; i++) {
+        *has_fields[i] = true;
+    }
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationParameters *params;
@@ -943,68 +977,52 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
-    params->has_throttle_trigger_threshold = true;
+
     params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->has_cpu_throttle_initial = true;
     params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->has_cpu_throttle_increment = true;
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
 
     tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
     tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
     tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
 
-    params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
-    params->has_avail_switchover_bandwidth = true;
     params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->has_downtime_limit = true;
     params->downtime_limit = s->parameters.downtime_limit;
-    params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
-    params->has_multifd_compression = true;
     params->multifd_compression = s->parameters.multifd_compression;
-    params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->has_multifd_qatzip_level = true;
     params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->has_max_postcopy_bandwidth = true;
     params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->has_max_cpu_throttle = true;
     params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->has_announce_initial = true;
     params->announce_initial = s->parameters.announce_initial;
-    params->has_announce_max = true;
     params->announce_max = s->parameters.announce_max;
-    params->has_announce_rounds = true;
     params->announce_rounds = s->parameters.announce_rounds;
-    params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
-
-    params->has_block_bitmap_mapping = true;
     params->block_bitmap_mapping =
         QAPI_CLONE(BitmapMigrationNodeAliasList,
                    s->parameters.block_bitmap_mapping);
-
-    params->has_x_vcpu_dirty_limit_period = true;
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->has_mode = true;
     params->mode = s->parameters.mode;
-    params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
-    params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
 
+    /*
+     * query-migrate-parameters expects all members of
+     * MigrationParameters to be present, but we cannot mark them
+     * non-optional in QAPI because the structure is also used for
+     * migrate-set-parameters, which needs the optionality. Force all
+     * parameters to be seen as present now. Note that this depends on
+     * some form of default being set for every member of
+     * MigrationParameters, currently done during qdev init using
+     * migration_properties defined in this file.
+     */
+    migrate_mark_all_params_present(params);
     return params;
 }
 
-- 
2.35.3


