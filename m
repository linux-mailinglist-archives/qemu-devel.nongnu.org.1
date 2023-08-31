Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0AA78F2C4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 20:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbmaC-0002Q0-0h; Thu, 31 Aug 2023 14:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qbmZn-0001fH-Ht
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:39:35 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qbmZl-0002G8-FL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:39:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66B1D2185F;
 Thu, 31 Aug 2023 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693507168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmbFysED0AHDJV1mZ+g/WSZUPpQFtPzNFvXjvePLOVI=;
 b=X1iVnvNjJPuB7anH5lKLjcqh0zYMpq0kNE+RptB2RJyRVqsGfT5THX//z7wmiPpQmRDmjI
 Dtzsnr9oMSGLq0E/y/e+nPiogfClmKAN0pwUlRCj8KZmvJoK+i0zWtae17PH4DK5Ej1fEi
 a+qBEI2T74BffH/1wfXkwhMHn/KTbV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693507168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmbFysED0AHDJV1mZ+g/WSZUPpQFtPzNFvXjvePLOVI=;
 b=NJ0HUlVnYW3APbknPicX6hKl0Uj45Yzfd3fgwTcMNtYWhulw12OIP/IlUmg/cIWtvDO6CF
 iZTc3RUA1Dfpm3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E038B13583;
 Thu, 31 Aug 2023 18:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qP5MKl7e8GQhPgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 31 Aug 2023 18:39:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v5 4/8] migration: Remove redundant cleanup of
 postcopy_qemufile_src
Date: Thu, 31 Aug 2023 15:39:12 -0300
Message-Id: <20230831183916.13203-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230831183916.13203-1-farosas@suse.de>
References: <20230831183916.13203-1-farosas@suse.de>
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

This file is owned by the return path thread which is already doing
cleanup.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5e6a766235..195726eb4a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1177,12 +1177,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
-    if (s->postcopy_qemufile_src) {
-        migration_ioc_unregister_yank_from_file(s->postcopy_qemufile_src);
-        qemu_fclose(s->postcopy_qemufile_src);
-        s->postcopy_qemufile_src = NULL;
-    }
-
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
-- 
2.35.3


