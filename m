Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8193B41A70
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 11:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2Z-000698-Ve; Wed, 03 Sep 2025 05:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2V-00067F-Qr; Wed, 03 Sep 2025 05:44:27 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2U-0007ww-AG; Wed, 03 Sep 2025 05:44:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9DDE78078F;
 Wed, 03 Sep 2025 12:44:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-pbBdHC6g; Wed, 03 Sep 2025 12:44:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892664;
 bh=rpWIJmcNN5lupFdb4weg79+iSwld3z32WBQckX84HH0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=W1qer5mvyh2vyNqBPyb1fFDrnv4Y+ZmQijVPWbsovY3Fgd8MW9QZ048xPrZCnUFI0
 /FGwDF8c/zbttm6PNASFLLloTLw5lXcEdZMbdodxcfxD30qwS9qgSgafWctlwkneNq
 3eCGs72DrRo7qjB++5xhTSkiyvxvwjh95AusmGnI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 10/10] migration/qemu-file: don't make incoming fds blocking
 again
Date: Wed,  3 Sep 2025 12:44:10 +0300
Message-ID: <20250903094411.1029449-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

In migration we want to pass fd "as is", not changing its
blocking status.

The only current user of these fds is CPR state (through VMSTATE_FD),
which of-course doesn't want to modify fds on target when source is
still running and use these fds.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/qemu-file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b1d042e298..b6ac190034 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -361,12 +361,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         qemu_file_set_error_obj(f, len, local_error);
     }
 
-    /*
-     * NOTE: don't worry about error_abort, it will be removed
-     * in the next commit
-     */
-    qemu_fds_set_blockinging(fds, nfd, true, &error_abort);
-
     for (int i = 0; i < nfd; i++) {
         FdEntry *fde = g_new0(FdEntry, 1);
         fde->fd = fds[i];
-- 
2.48.1


