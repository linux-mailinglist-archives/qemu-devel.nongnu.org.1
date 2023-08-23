Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671D785030
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgn2-0001IS-Dt; Wed, 23 Aug 2023 01:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgms-0001G5-Kb
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgmp-0007Ia-7p
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E2CF01C38C;
 Wed, 23 Aug 2023 08:52:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8CAF721234;
 Wed, 23 Aug 2023 08:52:00 +0300 (MSK)
Received: (nullmailer pid 1917450 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial for-8.1 1/3] hw/i2c: Fix bitbang_i2c_data trace event
Date: Wed, 23 Aug 2023 08:51:30 +0300
Message-Id: <8ada214a902225c90583b644cabd85bc89bf188c.1691405748.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The clock and data values were logged swapped. Correct the trace event
text to match what is logged. Also fix a typo in a comment nearby.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i2c/bitbang_i2c.c | 2 +-
 hw/i2c/trace-events  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index bb18954765..de5f5aacf5 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -70,7 +70,7 @@ static int bitbang_i2c_ret(bitbang_i2c_interface *i2c, int level)
     return level & i2c->last_data;
 }
 
-/* Leave device data pin unodified.  */
+/* Leave device data pin unmodified.  */
 static int bitbang_i2c_nop(bitbang_i2c_interface *i2c)
 {
     return bitbang_i2c_ret(i2c, i2c->device_out);
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 8e88aa24c1..d7b1e25858 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -5,7 +5,7 @@ bitbang_i2c_state(const char *old_state, const char *new_state) "state %s -> %s"
 bitbang_i2c_addr(uint8_t addr) "Address 0x%02x"
 bitbang_i2c_send(uint8_t byte) "TX byte 0x%02x"
 bitbang_i2c_recv(uint8_t byte) "RX byte 0x%02x"
-bitbang_i2c_data(unsigned dat, unsigned clk, unsigned old_out, unsigned new_out) "dat %u clk %u out %u -> %u"
+bitbang_i2c_data(unsigned clk, unsigned dat, unsigned old_out, unsigned new_out) "clk %u dat %u out %u -> %u"
 
 # core.c
 
-- 
2.39.2


