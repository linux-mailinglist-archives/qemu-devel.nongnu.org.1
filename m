Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D350779279
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTl8-0000d7-Km; Fri, 11 Aug 2023 11:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTl6-0000bx-HI
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:09:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTl4-0006LK-Qq
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:09:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A183E21887;
 Fri, 11 Aug 2023 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691766537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfyqSy/vexXZrrfoBllaNADL3zw4+p60HBnsLWD6L18=;
 b=02cG/sgQi2JRH1ek6/a1CqVYu4W8uY/kGuneiFEWrsgyADKcTxBPYkaopyRz+YsUsbV0EC
 U+Zej+x9Gl5h3Vpzzrzi/PSU0Y3i3/FmNjVuFT1qExYkV0jRQefAjQXTwUMOXtodO5fBqD
 l+AIrtCDVXUQyH+ysdxxGTuU4iIpCOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691766537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfyqSy/vexXZrrfoBllaNADL3zw4+p60HBnsLWD6L18=;
 b=Xa0uOBuHA+cikx8xDm4S6HT9irRn3bXRm9kVmBqVYvudE86SoUoc+0OqQgJwPlI8oIiXhE
 XvtEYVf9Egnx2aCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2445913592;
 Fri, 11 Aug 2023 15:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IOfPNwdP1mS7KwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 11 Aug 2023 15:08:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3 09/10] migration: Be consistent about shutdown of source
 shared files
Date: Fri, 11 Aug 2023 12:08:35 -0300
Message-Id: <20230811150836.2895-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811150836.2895-1-farosas@suse.de>
References: <20230811150836.2895-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

When doing cleanup, we currently close() some of the shared migration
files and shutdown() + close() others. Be consistent by always calling
shutdown() before close().

Do this only for the source files for now because the source runs
multiple threads which could cause races between the two calls. Having
them together allows us to move them to a centralized place under the
protection of a lock the next patch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 7fec57ad7f..4df5ca25c1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1175,6 +1175,7 @@ static void migrate_fd_cleanup(MigrationState *s)
          * critical section won't block for long.
          */
         migration_ioc_unregister_yank_from_file(tmp);
+        qemu_file_shutdown(tmp);
         qemu_fclose(tmp);
     }
 
@@ -1844,6 +1845,7 @@ static void migration_release_dst_files(MigrationState *ms)
         ms->postcopy_qemufile_src = NULL;
     }
 
+    qemu_file_shutdown(file);
     qemu_fclose(file);
 }
 
-- 
2.35.3


