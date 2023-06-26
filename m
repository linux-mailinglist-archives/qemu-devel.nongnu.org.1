Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2973EAE7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:09:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrTj-00027j-LN; Mon, 26 Jun 2023 15:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTH-0000WP-4U; Mon, 26 Jun 2023 15:01:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTF-0007rP-97; Mon, 26 Jun 2023 15:01:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48C60EFC3;
 Mon, 26 Jun 2023 21:59:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B82F4F7FF;
 Mon, 26 Jun 2023 21:59:12 +0300 (MSK)
Received: (nullmailer pid 1575379 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 34/43] hw/timer/nrf51_timer: Don't lose time when timer
 is queried in tight loop
Date: Mon, 26 Jun 2023 21:58:52 +0300
Message-Id: <20230626185902.1575177-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

The nrf51_timer has a free-running counter which we implement using
the pattern of using two fields (update_counter_ns, counter) to track
the last point at which we calculated the counter value, and the
counter value at that time.  Then we can find the current counter
value by converting the difference in wall-clock time between then
and now to a tick count that we need to add to the counter value.

Unfortunately the nrf51_timer's implementation of this has a bug
which means it loses time every time update_counter() is called.
After updating s->counter it always sets s->update_counter_ns to
'now', even though the actual point when s->counter hit the new value
will be some point in the past (half a tick, say).  In the worst case
(guest code in a tight loop reading the counter, icount mode) the
counter is continually queried less than a tick after it was last
read, so s->counter never advances but s->update_counter_ns does, and
the guest never makes forward progress.

The fix for this is to only advance update_counter_ns to the
timestamp of the last tick, not all the way to 'now'.  (This is the
pattern used in hw/misc/mps2-fpgaio.c's counter.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20230606134917.3782215-1-peter.maydell@linaro.org
(cherry picked from commit d2f9a79a8cf6ab992e1d0f27ad05b3e582d2b18a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 42be79c736..50c6772383 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -45,7 +45,12 @@ static uint32_t update_counter(NRF51TimerState *s, int64_t now)
     uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
 
     s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
-    s->update_counter_ns = now;
+    /*
+     * Only advance the sync time to the timestamp of the last tick,
+     * not all the way to 'now', so we don't lose time if we do
+     * multiple resyncs in a single tick.
+     */
+    s->update_counter_ns += ticks_to_ns(s, ticks);
     return ticks;
 }
 
-- 
2.39.2


