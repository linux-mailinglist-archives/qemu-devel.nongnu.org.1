Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A89A8660A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Apr 2025 21:16:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jrf-0005bE-En; Fri, 11 Apr 2025 15:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jqz-0004qN-Ed
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jqx-0006Kn-JB
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1994E2119A;
 Fri, 11 Apr 2025 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjML+RX+PjFRckNNQBvkO92ypjVOyICOB4cRRLNzFM8=;
 b=Y6wB7KoC25Iz4JkkJ7hNcNv8nY9RTfuKPFD6AE2M9fc1CwkpI/MJqOMemoni/ELBo9ZDZC
 xxGWY9rkA9be3urMLw1l+QZK1OpFBzawcb6fpb4vdw+GbgpWu0EjQTuP7bKzTF2tG+unAo
 bEWWRZn3DnDUrxKw3jO/ks+KQ/QF2wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjML+RX+PjFRckNNQBvkO92ypjVOyICOB4cRRLNzFM8=;
 b=ocQKVrs2UGCGGpYk+/XQ9dDJtWi+xsFvVX3lcaBK7VPTWnH16086uFP6FABCxyfdAPjnry
 9FNFO1NLxm57DVDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjML+RX+PjFRckNNQBvkO92ypjVOyICOB4cRRLNzFM8=;
 b=Y6wB7KoC25Iz4JkkJ7hNcNv8nY9RTfuKPFD6AE2M9fc1CwkpI/MJqOMemoni/ELBo9ZDZC
 xxGWY9rkA9be3urMLw1l+QZK1OpFBzawcb6fpb4vdw+GbgpWu0EjQTuP7bKzTF2tG+unAo
 bEWWRZn3DnDUrxKw3jO/ks+KQ/QF2wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjML+RX+PjFRckNNQBvkO92ypjVOyICOB4cRRLNzFM8=;
 b=ocQKVrs2UGCGGpYk+/XQ9dDJtWi+xsFvVX3lcaBK7VPTWnH16086uFP6FABCxyfdAPjnry
 9FNFO1NLxm57DVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FB0A13886;
 Fri, 11 Apr 2025 19:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8N4DFD5q+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:15:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 12/13] [PoC] migration: Add query/set commands for
 MigrationConfig
Date: Fri, 11 Apr 2025 16:14:42 -0300
Message-Id: <20250411191443.22565-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
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

Add the QMP commands query-migrate-config and migrate-set-config to
read and write the migration configuration options.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 24 ++++++++++++++++++++++++
 migration/options.h |  2 +-
 qapi/migration.json | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 4e3792dec3..c85ee2e506 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1441,3 +1441,27 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
     migrate_config_apply(&tmp);
     migrate_post_update_config(&tmp, errp);
 }
+
+void qmp_migrate_set_config(MigrationConfig *config, Error **errp)
+{
+    if (!migrate_config_check(config, errp)) {
+        /* Invalid parameter */
+        return;
+    }
+
+    migrate_config_apply(config);
+    migrate_post_update_config(config, errp);
+}
+
+MigrationConfig *qmp_query_migrate_config(Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    MigrationConfig *config = g_new0(MigrationConfig, 1);
+
+    QAPI_CLONE_MEMBERS(MigrationConfig, config, &s->config);
+
+    /* set the has_* fields for every option */
+    migrate_config_init(config);
+
+    return config;
+}
diff --git a/migration/options.h b/migration/options.h
index 61ee854bb0..0e36dafe80 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -72,7 +72,7 @@ uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_config_check(MigrationConfig *params, Error **errp);
-void migrate_config_init(MigrationConfig *params);
+void migrate_config_init(MigrationConfig *config);
 bool migrate_config_get_cap_compat(MigrationConfig *config, int i);
 bool migrate_caps_check(MigrationConfig *new, Error **errp);
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index 5e39f21adc..bb2487dbc6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2552,3 +2552,45 @@
   'data': { '*tls-creds': 'str',
             '*tls-hostname': 'str',
             '*tls-authz': 'str' } }
+
+##
+# @query-migrate-config:
+#
+# Returns information about the current migration configuration
+# options
+#
+# Returns: @MigrationConfig
+#
+# Since: 10.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-migrate-config" }
+#     <- { "return": {
+#              "multifd-channels": 2,
+#              "cpu-throttle-increment": 10,
+#              "cpu-throttle-initial": 20,
+#              "max-bandwidth": 33554432,
+#              "downtime-limit": 300
+#           }
+#        }
+##
+{ 'command': 'query-migrate-config',
+  'returns': 'MigrationConfig' }
+
+##
+# @migrate-set-config:
+#
+# Set various migration configuration options.
+#
+# Since: 10.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "migrate-set-config" ,
+#          "arguments": { "max-bandwidth": 33554432,
+#                         "downtime-limit": 300 } }
+#     <- { "return": {} }
+##
+{ 'command': 'migrate-set-config', 'boxed': true,
+  'data': 'MigrationConfig' }
-- 
2.35.3


