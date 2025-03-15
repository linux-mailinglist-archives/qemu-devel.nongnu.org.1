Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D85A629F6
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Mar 2025 10:24:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttNfV-0007T2-A8; Sat, 15 Mar 2025 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNdB-000461-Fb; Sat, 15 Mar 2025 05:16:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNd9-000877-FW; Sat, 15 Mar 2025 05:16:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 06114FFBC8;
 Sat, 15 Mar 2025 12:13:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0EAE61CAD61;
 Sat, 15 Mar 2025 12:14:40 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CA65755A58; Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 23/27] hw/net/smc91c111: Sanitize packet numbers
Date: Sat, 15 Mar 2025 12:14:34 +0300
Message-Id: <20250315091439.657371-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
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

The smc91c111 uses packet numbers as an index into its internal
s->data[][] array. Valid packet numbers are between 0 and 3, but
the code does not generally check this, and there are various
places where the guest can hand us an arbitrary packet number
and cause an out-of-bounds access to the data array.

Add validation of packet numbers. The datasheet is not very
helpful about how guest errors like this should be handled:
it says nothing on the subject, and none of the documented
error conditions are relevant. We choose to log the situation
with LOG_GUEST_ERROR and silently ignore the attempted operation.

In the places where we are about to access the data[][] array
using a packet number and we know the number is valid because
we got it from somewhere that has already validated, we add
an assert() to document that belief.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228174802.1945417-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2fa3a5b9469615d06091cf473d172794148e1248)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 6ce610cb23..efb15d5fe2 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -119,6 +119,11 @@ static const VMStateDescription vmstate_smc91c111 = {
 #define RS_TOOSHORT     0x0400
 #define RS_MULTICAST    0x0001
 
+static inline bool packetnum_valid(int packet_num)
+{
+    return packet_num >= 0 && packet_num < NUM_PACKETS;
+}
+
 /* Update interrupt status.  */
 static void smc91c111_update(smc91c111_state *s)
 {
@@ -219,6 +224,17 @@ static void smc91c111_pop_tx_fifo_done(smc91c111_state *s)
 /* Release the memory allocated to a packet.  */
 static void smc91c111_release_packet(smc91c111_state *s, int packet)
 {
+    if (!packetnum_valid(packet)) {
+        /*
+         * Data sheet doesn't document behaviour in this guest error
+         * case, and there is no error status register to report it.
+         * Log and ignore the attempt.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "smc91c111: attempt to release invalid packet %d\n",
+                      packet);
+        return;
+    }
     s->allocated &= ~(1 << packet);
     if (s->tx_alloc == 0x80)
         smc91c111_tx_alloc(s);
@@ -240,6 +256,8 @@ static void smc91c111_do_tx(smc91c111_state *s)
         return;
     for (i = 0; i < s->tx_fifo_len; i++) {
         packetnum = s->tx_fifo[i];
+        /* queue_tx checked the packet number was valid */
+        assert(packetnum_valid(packetnum));
         p = &s->data[packetnum][0];
         /* Set status word.  */
         *(p++) = 0x01;
@@ -288,6 +306,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
 /* Add a packet to the TX FIFO.  */
 static void smc91c111_queue_tx(smc91c111_state *s, int packet)
 {
+    if (!packetnum_valid(packet)) {
+        /*
+         * Datasheet doesn't document behaviour in this error case, and
+         * there's no error status register we could report it in.
+         * Log and ignore.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "smc91c111: attempt to queue invalid packet %d\n",
+                      packet);
+        return;
+    }
     if (s->tx_fifo_len == NUM_PACKETS)
         return;
     s->tx_fifo[s->tx_fifo_len++] = packet;
@@ -458,6 +487,13 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
                     n = s->rx_fifo[0];
                 else
                     n = s->packet_num;
+                if (!packetnum_valid(n)) {
+                    /* Datasheet doesn't document what to do here */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "smc91c111: attempt to write data to invalid packet %d\n",
+                                  n);
+                    return;
+                }
                 p = s->ptr & 0x07ff;
                 if (s->ptr & 0x4000) {
                     s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x7ff);
@@ -606,6 +642,13 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
                     n = s->rx_fifo[0];
                 else
                     n = s->packet_num;
+                if (!packetnum_valid(n)) {
+                    /* Datasheet doesn't document what to do here */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "smc91c111: attempt to read data from invalid packet %d\n",
+                                  n);
+                    return 0;
+                }
                 p = s->ptr & 0x07ff;
                 if (s->ptr & 0x4000) {
                     s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x07ff);
@@ -714,6 +757,8 @@ static ssize_t smc91c111_receive(NetClientState *nc, const uint8_t *buf, size_t
         return -1;
     s->rx_fifo[s->rx_fifo_len++] = packetnum;
 
+    /* allocate_packet() will not hand us back an invalid packet number */
+    assert(packetnum_valid(packetnum));
     p = &s->data[packetnum][0];
     /* ??? Multicast packets?  */
     status = 0;
-- 
2.39.5


