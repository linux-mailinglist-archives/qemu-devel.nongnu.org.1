Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E197EB4797F
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Sep 2025 10:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9Ra-0000ai-B4; Sun, 07 Sep 2025 03:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9RX-0000Yr-CD; Sun, 07 Sep 2025 03:04:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9RH-0004TA-JL; Sun, 07 Sep 2025 03:04:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E568151058;
 Sun, 07 Sep 2025 10:02:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0CEBB2793C5;
 Sun,  7 Sep 2025 10:02:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 74/81] e1000e: Prevent crash from legacy interrupt
 firing after MSI-X enable
Date: Sun,  7 Sep 2025 10:01:53 +0300
Message-ID: <20250907070205.135289-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

A race condition between guest driver actions and QEMU timers can lead
to an assertion failure when the guest switches the e1000e from legacy
interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
RDTR) is active, but the guest enables MSI-X before the timer fires,
the pending interrupt cause can trigger an assert in
e1000e_intmgr_collect_delayed_causes().

This patch removes the assertion and executes the code that clears the
pending legacy causes. This change is safe and introduces no unintended
behavioral side effects, as it only alters a state that previously led
to termination.

- when core->delayed_causes == 0 the function was already a no-op and
  remains so.

- when core->delayed_causes != 0 the function would previously
  crash due to the assertion failure. The patch now defines a safe
  outcome by clearing the cause and returning. Since behavior after
  the assertion never existed, this simply corrects the crash.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20250807110806.409065-1-lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 8e4649cac9bcddc050d2df07908075e9e69bccc7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2413858790..06657bb3ac 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -341,11 +341,6 @@ e1000e_intmgr_collect_delayed_causes(E1000ECore *core)
 {
     uint32_t res;
 
-    if (msix_enabled(core->owner)) {
-        assert(core->delayed_causes == 0);
-        return 0;
-    }
-
     res = core->delayed_causes;
     core->delayed_causes = 0;
 
-- 
2.47.3


