Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE3927E5C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 23:01:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTZo-0006hV-NC; Thu, 04 Jul 2024 17:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZl-0006dt-4o; Thu, 04 Jul 2024 17:01:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZj-0004Js-DI; Thu, 04 Jul 2024 17:01:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 90C8877561;
 Fri,  5 Jul 2024 00:00:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A7A9AFEC9B;
 Fri,  5 Jul 2024 00:00:55 +0300 (MSK)
Received: (nullmailer pid 1507724 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 04/22] Revert "monitor: use aio_co_reschedule_self()"
Date: Fri,  5 Jul 2024 00:00:34 +0300
Message-Id: <20240704210055.1507652-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 1f25c172f837 ("monitor: use aio_co_reschedule_self()") was a code
cleanup that uses aio_co_reschedule_self() instead of open coding
coroutine rescheduling.

Bug RHEL-34618 was reported and Kevin Wolf <kwolf@redhat.com> identified
the root cause. I missed that aio_co_reschedule_self() ->
qemu_get_current_aio_context() only knows about
qemu_aio_context/IOThread AioContexts and not about iohandler_ctx. It
does not function correctly when going back from the iohandler_ctx to
qemu_aio_context.

Go back to open coding the AioContext transitions to avoid this bug.

This reverts commit 1f25c172f83704e350c0829438d832384084a74d.

Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-34618
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240506190622.56095-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 719c6819ed9a9838520fa732f9861918dc693bda)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f3488afeef..176b549473 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -212,7 +212,8 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
              * executing the command handler so that it can make progress if it
              * involves an AIO_WAIT_WHILE().
              */
-            aio_co_reschedule_self(qemu_get_aio_context());
+            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
+            qemu_coroutine_yield();
         }
 
         monitor_set_cur(qemu_coroutine_self(), cur_mon);
@@ -226,7 +227,9 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
              * Move back to iohandler_ctx so that nested event loops for
              * qemu_aio_context don't start new monitor commands.
              */
-            aio_co_reschedule_self(iohandler_get_aio_context());
+            aio_co_schedule(iohandler_get_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
         }
     } else {
        /*
-- 
2.39.2


