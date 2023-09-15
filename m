Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441D7A2375
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:21:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYe-0005Mx-4S; Fri, 15 Sep 2023 12:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYT-0005Ef-FP; Fri, 15 Sep 2023 12:20:31 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYN-0000Ry-6O; Fri, 15 Sep 2023 12:20:27 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qhBUx-00Ezdu-11;
 Fri, 15 Sep 2023 18:20:15 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 3/8] qemu-img: rebase: use backing files' BlockBackend for
 buffer alignment
Date: Fri, 15 Sep 2023 19:20:11 +0300
Message-Id: <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
the data read from the old and new backing files are aligned using
BlockDriverState (or BlockBackend later on) referring to the target image.
However, this isn't quite right, because buf_new is only being used for
reading from the new backing, while buf_old is being used for both reading
from the old backing and writing to the target.  Let's take that into account
and use more appropriate values as alignments.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qemu-img.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 50660ba920..d12e4a4753 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3750,8 +3750,13 @@ static int img_rebase(int argc, char **argv)
         int64_t n;
         float local_progress = 0;
 
-        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
-        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
+        if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
+            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
+            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
+        } else {
+            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
+        }
+        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
 
         size = blk_getlength(blk);
         if (size < 0) {
-- 
2.39.3


