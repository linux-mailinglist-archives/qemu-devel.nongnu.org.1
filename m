Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A4A62760
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Mar 2025 07:30:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKxc-0007Jr-Mx; Sat, 15 Mar 2025 02:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKuS-0001Qk-RC; Sat, 15 Mar 2025 02:22:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKuQ-0003mR-FW; Sat, 15 Mar 2025 02:22:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13119FF9F5;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DEA421CAC5E;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8DC2955901; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 41/51] util/qemu-timer.c: Don't warp timer from
 timerlist_rearm()
Date: Sat, 15 Mar 2025 09:17:47 +0300
Message-Id: <20250315061801.622606-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently we call icount_start_warp_timer() from timerlist_rearm().
This produces incorrect behaviour, because timerlist_rearm() is
called, for instance, when a timer callback modifies its timer.  We
cannot decide here to warp the timer forwards to the next timer
deadline merely because all_cpu_threads_idle() is true, because the
timer callback we were called from (or some other callback later in
the list of callbacks being invoked) may be about to raise a CPU
interrupt and move a CPU from idle to ready.

The only valid place to choose to warp the timer forward is from the
main loop, when we know we have no outstanding IO or timer callbacks
that might be about to wake up a CPU.

For Arm guests, this bug was mostly latent until the refactoring
commit f6fc36deef6abc ("target/arm/helper: Implement
CNTHCTL_EL2.CNT[VP]MASK"), which exposed it because it refactored a
timer callback so that it happened to call timer_mod() first and
raise the interrupt second, when it had previously raised the
interrupt first and called timer_mod() afterwards.

This call seems to have originally derived from the
pre-record-and-replay icount code, which (as of e.g.  commit
db1a49726c3c in 2010) in this location did a call to
qemu_notify_event(), necessary to get the icount code in the vCPU
round-robin thread to stop and recalculate the icount deadline when a
timer was reprogrammed from the IO thread.  In current QEMU,
everything is done on the vCPU thread when we are in icount mode, so
there's no need to try to notify another thread here.

I suspect that the other reason why this call was doing icount timer
warping is that it pre-dates commit efab87cf79077a from 2015, which
added a call to icount_start_warp_timer() to main_loop_wait().  Once
the call in timerlist_rearm() has been removed, if the timer
callbacks don't cause any CPU to be woken up then we will end up
calling icount_start_warp_timer() from main_loop_wait() when the rr
main loop code calls rr_wait_io_event().

Remove the incorrect call from timerlist_rearm().

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2703
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250210135804.3526943-1-peter.maydell@linaro.org
(cherry picked from commit 02ae315467cee589d02dfb89e13a2a6a8de09fc5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index ffe9a3c5c1..dfa444b132 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -409,10 +409,6 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
 
 static void timerlist_rearm(QEMUTimerList *timer_list)
 {
-    /* Interrupt execution to force deadline recalculation.  */
-    if (icount_enabled() && timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
-        icount_start_warp_timer();
-    }
     timerlist_notify(timer_list);
 }
 
-- 
2.39.5


