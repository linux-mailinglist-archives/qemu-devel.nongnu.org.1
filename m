Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D37FAB74
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:28:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCS-0003So-RK; Mon, 27 Nov 2023 15:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCG-0003J0-Id
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCE-0002pl-Tw
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A053D21B32;
 Mon, 27 Nov 2023 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/O9z9Oa8tQPzYvTNemCX5g6I1I9k4l3WV4T6reynhQ=;
 b=1JT63DT/31w0ZHhkho+ATn78qCBnQMWv/uP+XOuwBkEEvnFwKcKMFBz4S4gKKt4FfHgsoI
 /YQHgyVOG1If8KyR26kSgw5NAp6XnS+pDDn2Mj7XmB9OCKXcZwXkEKialMeMVHovOCOmlQ
 1Dyz6bA9HWFtcjoyy+KZC+CFhqpbl+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/O9z9Oa8tQPzYvTNemCX5g6I1I9k4l3WV4T6reynhQ=;
 b=HAjy/4CzFpadodsMaFIWjo8U/BCIDyMzbSiBscMfCmqsem0EO+J5H1CHl8+DJjPlJ2nX9V
 1NgURZJwAFPmysBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F0391379A;
 Mon, 27 Nov 2023 20:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WOdaFZr7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 19/30] migration/ram: Ignore multifd flush when doing
 fixed-ram migration
Date: Mon, 27 Nov 2023 17:26:01 -0300
Message-Id: <20231127202612.23012-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.39
X-Spamd-Result: default: False [3.39 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.51)[80.04%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some functionalities of multifd are incompatible with the 'fixed-ram'
migration format.

The MULTIFD_FLUSH flag in particular is not used because in fixed-ram
there is no sinchronicity between migration source and destination so
there is not need for a sync packet. In fact, fixed-ram disables
packets in multifd as a whole.

However, we still need to sync the migration thread with the multifd
channels at key moments:

- between iterations, to avoid a slow channel being overrun by a fast
channel in the subsequent iteration;

- at ram_save_complete, to make sure all data has been transferred
  before finishing migration;

Make sure RAM_SAVE_FLAG_MULTIFD_FLUSH is only emitted for fixed-ram at
those key moments.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 08604222f2..ad6abd1761 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1363,7 +1363,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
+            if (migrate_multifd() && !migrate_fixed_ram() &&
                 !migrate_multifd_flush_after_each_section()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_send_sync_main(f);
@@ -3112,7 +3112,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
+        && !migrate_fixed_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -3242,8 +3243,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
-            ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
+        if (migrate_multifd() &&
+            (migrate_multifd_flush_after_each_section() ||
+             migrate_fixed_ram())) {
+            ret = multifd_send_sync_main(
+                rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
             if (ret < 0) {
                 return ret;
             }
-- 
2.35.3


