Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE049706226
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:03:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC70-0003SA-NJ; Wed, 17 May 2023 04:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6i-0002jy-GU; Wed, 17 May 2023 04:02:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6f-0000lh-Eo; Wed, 17 May 2023 04:02:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3AA736769;
 Wed, 17 May 2023 11:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BA5565E21;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: (nullmailer pid 3624175 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v8.0.1 32/36] async: Suppress GCC13 false positive in
 aio_bh_poll()
Date: Wed, 17 May 2023 11:00:52 +0300
Message-Id: <20230517080056.3623993-32-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cédric Le Goater <clg@redhat.com>

GCC13 reports an error :

../util/async.c: In function ‘aio_bh_poll’:
include/qemu/queue.h:303:22: error: storing the address of local variable ‘slice’ in ‘*ctx.bh_slice_list.sqh_last’ [-Werror=dangling-pointer=]
  303 |     (head)->sqh_last = &(elm)->field.sqe_next;                          \
      |     ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
../util/async.c:169:5: note: in expansion of macro ‘QSIMPLEQ_INSERT_TAIL’
  169 |     QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
      |     ^~~~~~~~~~~~~~~~~~~~
../util/async.c:161:17: note: ‘slice’ declared here
  161 |     BHListSlice slice;
      |                 ^~~~~
../util/async.c:161:17: note: ‘ctx’ declared here

But the local variable 'slice' is removed from the global context list
in following loop of the same routine. Add a pragma to silent GCC.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230420202939.1982044-1-clg@kaod.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d66ba6dc1cce914673bd8a89fca30a7715ea70d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: cherry-picked to stable-8.0 to eliminate CI failures on win*)
---
 util/async.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/util/async.c b/util/async.c
index 21016a1ac7..856e1a8a33 100644
--- a/util/async.c
+++ b/util/async.c
@@ -164,7 +164,21 @@ int aio_bh_poll(AioContext *ctx)
 
     /* Synchronizes with QSLIST_INSERT_HEAD_ATOMIC in aio_bh_enqueue().  */
     QSLIST_MOVE_ATOMIC(&slice.bh_list, &ctx->bh_list);
+
+    /*
+     * GCC13 [-Werror=dangling-pointer=] complains that the local variable
+     * 'slice' is being stored in the global 'ctx->bh_slice_list' but the
+     * list is emptied before this function returns.
+     */
+#if !defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpragmas"
+#pragma GCC diagnostic ignored "-Wdangling-pointer="
+#endif
     QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
+#if !defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
     while ((s = QSIMPLEQ_FIRST(&ctx->bh_slice_list))) {
         QEMUBH *bh;
-- 
2.39.2


