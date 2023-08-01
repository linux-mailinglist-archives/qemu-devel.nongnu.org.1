Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3C76AED0
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlsG-0003FO-R4; Tue, 01 Aug 2023 05:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQlsA-0003A5-9b
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:58 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls8-0005Bq-Fm
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1690882856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ng+PjkahWZzJhonoLMhtC6+8FiFwsYdx9/qF63/vowA=;
 b=EFc0HQ1Azs0myZjnL6cT3+L3mKnK8jIS5h/Co0zYr5tg43UTaobqHFeE
 sZUc/NWvEZzOkawWKMexYSrfavIcVKHgcTbSwm/oNEF30vWA1FajZeBLP
 lpsanoYN1QGFXVZK2A2YuHqK2LFIFIeR2Vx3H2lgT2b53zkay9HRyiJe9 M=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 117971007
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:PA4hk6riomnVT93LuQthJd8WbXdeBmJKZRIvgKrLsJaIsI4StFCzt
 garIBmAOqvZYDamKdx1OY+3p0pQ6peAmIM1HlE5qSgxFCgRo5uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GpwUmAWP6gR5weBzCBNV/rzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXACEWY1OHp96Z/L6UcLZSj956C5blJ7pK7xmMzRmBZRonaZXKQqGM7t5ExjYgwMtJGJ4yZ
 eJAN2ApNk6ZJUQSZBFOUslWcOSA3xETdxVRrk6VoqwmpXDe1gVr3JDmMcbPe8zMTsJQ9qqdj
 jufoDWmW0lCa7RzzxLVwi+RivHjlhnpXYMdHo+VrMd7oli6kzl75Bo+CgLg/KjRZlSFc8tSL
 lFR9icwoKwa8kutQd/gGRqirxa5UgU0AoQKVbdgsUfUl/SSulzCboQZctJfQM09uYwyZQAF6
 lOmpYzXDCY2l+KbUkvIo994sgiO1TgpwX4qPHFVFVtavIO6+OnfnTqUEI89TffdYsndXGipn
 mvU9HVWa6A715Zj6kmtwbzQb9tATLDtRxV92AjYV3nNAuhRNN/8PNzABbQ2AJ99wGelorqp5
 iJsdzC2trxmMH10vHXlrB8xNL+o/e2ZFzbXnERiGZIsnxz0pS/7LdoAvG4ieB02WirhRdMOS
 BaC0T69GbcJZCf6BUOJS9zZ5zsWIVjISo2+C6G8gitmaZltbg6XlByClmbJt10BZHMEyPllU
 b/CKJbEMJrvIfg/pNZAb7tHgOBDK+FX7T+7eK0XODz9gebHPiPEFu1cWLZMB8hghJ65TMzu2
 443H6O3J993AYUSvgG/HVYvEG03
IronPort-HdrOrdr: A9a23:x8W2Hq8XruQwcj5epq9uk+C7I+orL9Y04lQ7vn2ZKCY0TiX8ra
 uTdZsguCMc5Ax6ZJhCo7G90de7Lk80nKQdibX5Vo3PYOCJggWVEL0=
X-Talos-CUID: =?us-ascii?q?9a23=3Au228cmqVQPMCVPGfo/Ke6XnmUdE+fz7Z7Ev/H0O?=
 =?us-ascii?q?XMzlXQafMbgCe45oxxg=3D=3D?=
X-Talos-MUID: 9a23:PxY1rwaecddNCOBT5w+xuT18GMxS8aGvB0o/vM8/quuBHHkl
X-IronPort-AV: E=Sophos;i="6.01,246,1684814400"; d="scan'208";a="117971007"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 3/5] thread-pool: signal "request_cond" while locked
Date: Tue, 1 Aug 2023 10:40:36 +0100
Message-ID: <20230801094038.11026-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=prvs=570bccec8=anthony.perard@citrix.com;
 helo=esa2.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

thread_pool_free() might have been called on the `pool`, which would
be a reason for worker_thread() to quit. In this case,
`pool->request_cond` is been destroyed.

If worker_thread() didn't managed to signal `request_cond` before it
been destroyed by thread_pool_free(), we got:
    util/qemu-thread-posix.c:198: qemu_cond_signal: Assertion `cond->initialized' failed.

One backtrace:
    __GI___assert_fail (assertion=0x55555614abcb "cond->initialized", file=0x55555614ab88 "util/qemu-thread-posix.c", line=198,
	function=0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal") at assert.c:101
    qemu_cond_signal (cond=0x7fffb800db30) at util/qemu-thread-posix.c:198
    worker_thread (opaque=0x7fffb800dab0) at util/thread-pool.c:129
    qemu_thread_start (args=0x7fffb8000b20) at util/qemu-thread-posix.c:505
    start_thread (arg=<optimized out>) at pthread_create.c:486

Reported here:
    https://lore.kernel.org/all/ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local/T/#u

To avoid issue, keep lock while sending a signal to `request_cond`.

Fixes: 900fa208f506 ("thread-pool: replace semaphore with condition variable")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230714152720.5077-1-anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 util/thread-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 0d97888df0..e3d8292d14 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -120,13 +120,13 @@ static void *worker_thread(void *opaque)
 
     pool->cur_threads--;
     qemu_cond_signal(&pool->worker_stopped);
-    qemu_mutex_unlock(&pool->lock);
 
     /*
      * Wake up another thread, in case we got a wakeup but decided
      * to exit due to pool->cur_threads > pool->max_threads.
      */
     qemu_cond_signal(&pool->request_cond);
+    qemu_mutex_unlock(&pool->lock);
     return NULL;
 }
 
-- 
Anthony PERARD


