Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792D7660F1
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPBlc-0006ek-Up; Thu, 27 Jul 2023 20:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qPBla-0006eU-In; Thu, 27 Jul 2023 20:55:38 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qPBlY-0001zv-Fw; Thu, 27 Jul 2023 20:55:38 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0445B745958;
 Fri, 28 Jul 2023 02:55:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C43417456CE; Fri, 28 Jul 2023 02:55:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/i2c: Fix bitbang_i2c_data trace event
Date: Fri, 28 Jul 2023 02:45:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
Message-Id: <20230728005526.C43417456CE@zero.eik.bme.hu>
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The clock and data values were logged swapped. Correct the trace event
text to match what is logged. Also fix a typo in a comment nearby.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
By the way, get_maintainer.pl does not find a maintainer for
bitbang_i2c.c, should it be added somewhere with the rest of hw/i2c?

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
2.30.9


