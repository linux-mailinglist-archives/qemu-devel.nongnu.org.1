Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3FACBE45
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 03:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcG-0006if-6a; Mon, 02 Jun 2025 21:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcE-0006iN-GB
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcC-0001X7-Tm
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 382711F38D;
 Tue,  3 Jun 2025 01:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVPvDwK/cwUWk0r7xb0UxvXzlrJhpqrz5XX83nElAXM=;
 b=jnKjGrGZagbFm+6WYykb7JCftwF8GSvfK3gJw+H4DmiNP/PeHI6X3l+SCyap+Q+v1BROTf
 BSwHhXD4UKQdPDn1VVt3EaOeRNZ8DADwiQOG12xIgvtJFn7Lh/hiBJnWuenmt/CSRYbJg1
 NLBXs2k5xnVCYyEJSkVVxMfNUN0Ndrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVPvDwK/cwUWk0r7xb0UxvXzlrJhpqrz5XX83nElAXM=;
 b=r+0e6nUmC3UvfopI8WjL3JdoUDWXJj08M7+5kFryASZdoAWtM3EfYO93eAfnt4oSjD0xfL
 X/gqTr8BqQLOuZCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jnKjGrGZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r+0e6nUm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVPvDwK/cwUWk0r7xb0UxvXzlrJhpqrz5XX83nElAXM=;
 b=jnKjGrGZagbFm+6WYykb7JCftwF8GSvfK3gJw+H4DmiNP/PeHI6X3l+SCyap+Q+v1BROTf
 BSwHhXD4UKQdPDn1VVt3EaOeRNZ8DADwiQOG12xIgvtJFn7Lh/hiBJnWuenmt/CSRYbJg1
 NLBXs2k5xnVCYyEJSkVVxMfNUN0Ndrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVPvDwK/cwUWk0r7xb0UxvXzlrJhpqrz5XX83nElAXM=;
 b=r+0e6nUmC3UvfopI8WjL3JdoUDWXJj08M7+5kFryASZdoAWtM3EfYO93eAfnt4oSjD0xfL
 X/gqTr8BqQLOuZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9F0E13700;
 Tue,  3 Jun 2025 01:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EMuWGhlSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/21] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
Date: Mon,  2 Jun 2025 22:37:59 -0300
Message-Id: <20250603013810.4772-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 382711F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
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

QAPI_CLONE_MEMBERS is a better option than copying parameters one by
one because it operates on the entire struct and follows pointers. It
also avoids the need to alter this function every time a new parameter
is added.

Note, since this is a deep clone, now we must free the TLS strings
before assignment.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index dd62e726cb..0a2a3050ec 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -918,7 +918,9 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
 {
     StrOrNull *dst = *dstp;
 
-    assert(!dst);
+    if (dst) {
+        qapi_free_StrOrNull(dst);
+    }
 
     dst = *dstp = g_new0(StrOrNull, 1);
     dst->type = QTYPE_QSTRING;
@@ -975,42 +977,17 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     MigrationParameters *params;
     MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
 
-    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
+    QAPI_CLONE_MEMBERS(MigrationParameters, params, &s->parameters);
 
     tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
     tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
     tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
 
-    params->max_bandwidth = s->parameters.max_bandwidth;
-    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->downtime_limit = s->parameters.downtime_limit;
-    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->multifd_channels = s->parameters.multifd_channels;
-    params->multifd_compression = s->parameters.multifd_compression;
-    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->announce_initial = s->parameters.announce_initial;
-    params->announce_max = s->parameters.announce_max;
-    params->announce_rounds = s->parameters.announce_rounds;
-    params->announce_step = s->parameters.announce_step;
     params->block_bitmap_mapping =
         QAPI_CLONE(BitmapMigrationNodeAliasList,
                    s->parameters.block_bitmap_mapping);
-    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->mode = s->parameters.mode;
-    params->zero_page_detection = s->parameters.zero_page_detection;
-    params->direct_io = s->parameters.direct_io;
 
     /*
      * query-migrate-parameters expects all members of
-- 
2.35.3


