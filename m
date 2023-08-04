Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E597708E4
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0Jp-00022l-5p; Fri, 04 Aug 2023 15:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0JF-0001FC-Uk; Fri, 04 Aug 2023 15:18:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0JE-00071k-07; Fri, 04 Aug 2023 15:18:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7202D18462;
 Fri,  4 Aug 2023 22:17:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0B1E31B8A5;
 Fri,  4 Aug 2023 22:16:53 +0300 (MSK)
Received: (nullmailer pid 1875735 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 48/63] hw/xen: fix off-by-one in xen_evtchn_set_gsi()
Date: Fri,  4 Aug 2023 22:16:31 +0300
Message-Id: <20230804191647.1875608-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity points out (CID 1508128) a bounds checking error. We need to check
for gsi >= IOAPIC_NUM_PINS, not just greater-than.

Also fix up an assert() that has the same problem, that Coverity didn't see.

Fixes: 4f81baa33ed6 ("hw/xen: Support GSI mapping to PIRQ")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230801175747.145906-2-dwmw2@infradead.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit cf885b19579646d6a085470658bc83432d6786d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3048329474..8c86c91a9e 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1587,7 +1587,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
  found:
     pirq_inuse_word(s, pirq) |= pirq_inuse_bit(pirq);
     if (gsi >= 0) {
-        assert(gsi <= IOAPIC_NUM_PINS);
+        assert(gsi < IOAPIC_NUM_PINS);
         s->gsi_pirq[gsi] = pirq;
     }
     s->pirq[pirq].gsi = gsi;
@@ -1601,7 +1601,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
 
     assert(qemu_mutex_iothread_locked());
 
-    if (!s || gsi < 0 || gsi > IOAPIC_NUM_PINS) {
+    if (!s || gsi < 0 || gsi >= IOAPIC_NUM_PINS) {
         return false;
     }
 
-- 
2.39.2


