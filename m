Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6636DA2058F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:06:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgY6-0004fU-Th; Tue, 28 Jan 2025 03:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgX9-0000wA-2G; Tue, 28 Jan 2025 03:01:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgX7-0001qT-DI; Tue, 28 Jan 2025 03:01:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 98D2AE1B4E;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 149B81A6301;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id E85C552093; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jakub Jelen <jjelen@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 07/58] ssh: Do not switch session to non-blocking mode
Date: Mon, 27 Jan 2025 23:24:53 +0300
Message-Id: <20250127202547.3723716-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The libssh does not handle non-blocking mode in SFTP correctly. The
driver code already changes the mode to blocking for the SFTP
initialization, but for some reason changes to non-blocking mode.
This used to work accidentally until libssh in 0.11 branch merged
the patch to avoid infinite looping in case of network errors:

https://gitlab.com/libssh/libssh-mirror/-/merge_requests/498

Since then, the ssh driver in qemu fails to read files over SFTP
as the first SFTP messages exchanged after switching the session
to non-blocking mode return SSH_AGAIN, but that message is lost
int the SFTP internals and interpretted as SSH_ERROR, which is
returned to the caller:

https://gitlab.com/libssh/libssh-mirror/-/issues/280

This is indeed an issue in libssh that we should address in the
long term, but it will require more work on the internals. For
now, the SFTP is not supported in non-blocking mode.

Fixes: https://gitlab.com/libssh/libssh-mirror/-/issues/280
Signed-off-by: Jakub Jelen <jjelen@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20241113125526.2495731-1-rjones@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit fbdea3d6c13d5a75895c287a004c6f1a6bf6c164)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/ssh.c b/block/ssh.c
index 27d582e0e3..5c16ff4fb6 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -865,9 +865,6 @@ static int ssh_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
         goto err;
     }
 
-    /* Go non-blocking. */
-    ssh_set_blocking(s->session, 0);
-
     if (s->attrs->type == SSH_FILEXFER_TYPE_REGULAR) {
         bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
     }
-- 
2.39.5


