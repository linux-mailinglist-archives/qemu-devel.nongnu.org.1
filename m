Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC2839072
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 14:52:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSHBm-0000H6-VH; Tue, 23 Jan 2024 08:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSHBj-0000G7-R3; Tue, 23 Jan 2024 08:51:39 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSHBi-0002I6-9R; Tue, 23 Jan 2024 08:51:39 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8CB0D45D5C;
 Tue, 23 Jan 2024 14:51:35 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com, jusual@redhat.com,
 mehta.aaru20@gmail.com
Subject: [PATCH] block/io_uring: improve error message when init fails
Date: Tue, 23 Jan 2024 14:50:44 +0100
Message-Id: <20240123135044.204985-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The man page for io_uring_queue_init states:

> io_uring_queue_init(3) returns 0 on success and -errno on failure.

and the man page for io_uring_setup (which is one of the functions
where the return value of io_uring_queue_init() can come from) states:

> On error, a negative error code is returned. The caller should not
> rely on errno variable.

Tested using 'sysctl kernel.io_uring_disabled=2'. Output before this
change:

> failed to init linux io_uring ring

Output after this change:

> failed to init linux io_uring ring: Operation not permitted

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index d77ae55745..d11b2051ab 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -432,7 +432,7 @@ LuringState *luring_init(Error **errp)
 
     rc = io_uring_queue_init(MAX_ENTRIES, ring, 0);
     if (rc < 0) {
-        error_setg_errno(errp, errno, "failed to init linux io_uring ring");
+        error_setg_errno(errp, -rc, "failed to init linux io_uring ring");
         g_free(s);
         return NULL;
     }
-- 
2.39.2



