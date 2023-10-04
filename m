Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3517B7998
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsN-0001WK-HH; Wed, 04 Oct 2023 04:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrt-0007qk-Fe; Wed, 04 Oct 2023 04:04:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrf-0000D8-SE; Wed, 04 Oct 2023 04:04:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D3C5D275A0;
 Wed,  4 Oct 2023 11:02:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 159332CBDC;
 Wed,  4 Oct 2023 11:02:26 +0300 (MSK)
Received: (nullmailer pid 2702816 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Ivan Warren <ivan@vmfacility.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 22/45] accel/tcg: mttcg remove false-negative halted
 assertion
Date: Wed,  4 Oct 2023 11:01:43 +0300
Message-Id: <20231004080221.2702636-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Nicholas Piggin <npiggin@gmail.com>

mttcg asserts that an execution ending with EXCP_HALTED must have
cpu->halted. However between the event or instruction that sets
cpu->halted and requests exit and the assertion here, an
asynchronous event could clear cpu->halted.

This leads to crashes running AIX on ppc/pseries because it uses
H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted = 1 and
H_PROD sets other cpu->halted = 0 and kicks it.

H_PROD could be turned into an interrupt to wake, but several other
places in ppc, sparc, and semihosting follow what looks like a similar
pattern setting halted = 0 directly. So remove this assertion.

Reported-by: Ivan Warren <ivan@vmfacility.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
[rth: Keep the case label and adjust the comment.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 0e5903436de712844b0e6cdd862b499c767e09e9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b276262007..4b0dfb4be7 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -100,14 +100,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
                 break;
             case EXCP_HALTED:
                 /*
-                 * during start-up the vCPU is reset and the thread is
-                 * kicked several times. If we don't ensure we go back
-                 * to sleep in the halted state we won't cleanly
-                 * start-up when the vCPU is enabled.
-                 *
-                 * cpu->halted should ensure we sleep in wait_io_event
+                 * Usually cpu->halted is set, but may have already been
+                 * reset by another thread by the time we arrive here.
                  */
-                g_assert(cpu->halted);
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
-- 
2.39.2


