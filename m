Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0099D886A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Nov 2024 15:48:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaMZ-0007Xh-W0; Mon, 25 Nov 2024 09:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaME-0007UC-9h; Mon, 25 Nov 2024 09:46:35 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaMA-0004AK-Sn; Mon, 25 Nov 2024 09:46:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6192A21163;
 Mon, 25 Nov 2024 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/93mDPxem6+NfGJYyFudSYBKJqBjcb7LZRNx6NFOQE=;
 b=yT/QE/tVRS6uJ5Si8GP86xAy17jAnEpgZnjXFti9oBj2j3eTF0RBibth974uhOJl0K0ge6
 YQIwlPiEV+ij1Z5p33IBYYT2/ux3Ryrt7GFGDUVBQ2vSgCKuPr2Sng41EtRK66cdZ5/l7o
 3+r0/qM4bheBRk72ANQDZOGhB58eh5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/93mDPxem6+NfGJYyFudSYBKJqBjcb7LZRNx6NFOQE=;
 b=ZH0PYA6z7L0zG/dBWm8rs9aDNLdp0ZDd8tnGxO9fC+o15WVOwkcekLETViZCwan7J/LFm3
 IofOKCJuCNl6QbDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yT/QE/tV";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZH0PYA6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/93mDPxem6+NfGJYyFudSYBKJqBjcb7LZRNx6NFOQE=;
 b=yT/QE/tVRS6uJ5Si8GP86xAy17jAnEpgZnjXFti9oBj2j3eTF0RBibth974uhOJl0K0ge6
 YQIwlPiEV+ij1Z5p33IBYYT2/ux3Ryrt7GFGDUVBQ2vSgCKuPr2Sng41EtRK66cdZ5/l7o
 3+r0/qM4bheBRk72ANQDZOGhB58eh5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/93mDPxem6+NfGJYyFudSYBKJqBjcb7LZRNx6NFOQE=;
 b=ZH0PYA6z7L0zG/dBWm8rs9aDNLdp0ZDd8tnGxO9fC+o15WVOwkcekLETViZCwan7J/LFm3
 IofOKCJuCNl6QbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C8E613A73;
 Mon, 25 Nov 2024 14:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SPwzBcKNRGdRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 14:46:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/5] migration: Activate block devices if VM is paused when
 migrating
Date: Mon, 25 Nov 2024 11:46:11 -0300
Message-Id: <20241125144612.16194-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241125144612.16194-1-farosas@suse.de>
References: <20241125144612.16194-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6192A21163
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently a VM that has been target of a migration using
late-block-activate will crash at the end of a new migration (with it
as source) when releasing ownership of the disks due to the VM having
never taken ownership of the disks in the first place.

The issue is that late-block-activate expects a qmp_continue command
to be issued at some point on the destination VM after the migration
finishes. If the user decides to never continue the VM, but instead
issue a new migration, then bdrv_activate_all() will never be called
and the assert will be reached:

bdrv_inactivate_recurse: Assertion `!(bs->open_flags &
BDRV_O_INACTIVE)' failed.

Fix the issue by checking at the start of migration if the VM is
paused and call bdrv_activate_all() before migrating. Even if the
late-block-activate capability is not in play or if the VM has been
paused manually, there is no harm calling that function again.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index aedf7f0751..26af30137b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2029,6 +2029,25 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         return false;
     }
 
+    /*
+     * The VM might have been target of a previous migration. If it
+     * was in the paused state then nothing will have required the
+     * block layer to be activated. Do it now to ensure this QEMU
+     * instance owns the disk locks.
+     */
+    if (!resume && runstate_check(RUN_STATE_PAUSED)) {
+        Error *local_err = NULL;
+
+        g_assert(bql_locked());
+
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return false;
+        }
+        s->block_inactive = false;
+    }
+
     return true;
 }
 
-- 
2.35.3


