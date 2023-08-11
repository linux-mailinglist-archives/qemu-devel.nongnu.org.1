Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96222779289
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTl7-0000br-1f; Fri, 11 Aug 2023 11:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTkz-0000Zt-BC
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:08:53 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTkv-0006Ha-1j
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:08:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E35C821887;
 Fri, 11 Aug 2023 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691766525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdig4Xam+KaxFnZLj6qvoskpEIm5WZWhu/1QE/MF7bM=;
 b=fRAAbpFjVM1AauZWTUvg+MOX/+6px2YjBz3p1rpROVJArPXAn7hPSDSvLGEYYCHSF5ZoHr
 dxwvn6kZxdmlRP+fXtfuTVIAgQGcZJT3Esppx1YY+pemzFonim8R0iVimw92riiPswl9pZ
 ejGN5fWwJDrPaOGBFXHtyufeZbOj66E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691766525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdig4Xam+KaxFnZLj6qvoskpEIm5WZWhu/1QE/MF7bM=;
 b=vOVmr/n5X2isJoRzkhBUD5CTaXnIqd/s7L903QRDfKQxHFKwySyHrsJ/wOGjc00Kd1hGFi
 SCbobTNg7abN+eCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5772E13592;
 Fri, 11 Aug 2023 15:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AG2jCPxO1mS7KwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 11 Aug 2023 15:08:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3 03/10] migration: Fix possible race when checking
 to_dst_file for errors
Date: Fri, 11 Aug 2023 12:08:29 -0300
Message-Id: <20230811150836.2895-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811150836.2895-1-farosas@suse.de>
References: <20230811150836.2895-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Checking ms->to_dst_file for errors when cleaning up the return path
could race with migrate_fd_cleanup() which clears the pointer.

Since migrate_fd_cleanup() is reachable via qmp_migrate(), which is
issued by the user, it is safer if we take the lock when reading
ms->to_dst_file.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0067c927fa..85c171f32c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2057,11 +2057,10 @@ static int await_return_path_close_on_source(MigrationState *ms)
      * need to cause it to exit. shutdown(2), if we have it, will
      * cause it to unblock if it's stuck waiting for the destination.
      */
-    if (qemu_file_get_error(ms->to_dst_file)) {
-        WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-            if (ms->rp_state.from_dst_file) {
-                qemu_file_shutdown(ms->rp_state.from_dst_file);
-            }
+    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
+        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
+            qemu_file_get_error(ms->to_dst_file)) {
+            qemu_file_shutdown(ms->rp_state.from_dst_file);
         }
     }
 
-- 
2.35.3


