Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8183A62883
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Mar 2025 08:52:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMDs-0002dj-E3; Sat, 15 Mar 2025 03:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMDd-00024B-3a; Sat, 15 Mar 2025 03:46:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMDZ-0005LN-Jh; Sat, 15 Mar 2025 03:46:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1EEDFFFB19;
 Sat, 15 Mar 2025 10:41:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0DB171CACE3;
 Sat, 15 Mar 2025 10:42:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B0FB855A1E; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 37/42] hw/net/smc91c111: Sanitize packet length on tx
Date: Sat, 15 Mar 2025 10:42:39 +0300
Message-Id: <20250315074249.634718-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
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

When the smc91c111 transmits a packet, it must read a control byte
which is at the end of the data area and CRC.  However, we don't
sanitize the length field in the packet buffer, so if the guest sets
the length field to something large we will try to read past the end
of the packet data buffer when we access the control byte.

As usual, the datasheet says nothing about the behaviour of the
hardware if the guest misprograms it in this way.  It says only that
the maximum valid length is 2048 bytes.  We choose to log the guest
error and silently drop the packet.

This requires us to factor out the "mark the tx packet as complete"
logic, so we can call it for this "drop packet" case as well as at
the end of the loop when we send a valid packet.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2742
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228174802.1945417-3-peter.maydell@linaro.org>
[PMD: Update smc91c111_do_tx() as len > MAX_PACKET_SIZE]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit aad6f264add3f2be72acb660816588fe09110069)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3a3cfa1f6a..36415425db 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -23,6 +23,13 @@
 
 /* Number of 2k memory pages available.  */
 #define NUM_PACKETS 4
+/*
+ * Maximum size of a data frame, including the leading status word
+ * and byte count fields and the trailing CRC, last data byte
+ * and control byte (per figure 8-1 in the Microchip Technology
+ * LAN91C111 datasheet).
+ */
+#define MAX_PACKET_SIZE 2048
 
 #define TYPE_SMC91C111 "smc91c111"
 OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
@@ -241,6 +248,16 @@ static void smc91c111_release_packet(smc91c111_state *s, int packet)
     smc91c111_flush_queued_packets(s);
 }
 
+static void smc91c111_complete_tx_packet(smc91c111_state *s, int packetnum)
+{
+    if (s->ctr & CTR_AUTO_RELEASE) {
+        /* Race?  */
+        smc91c111_release_packet(s, packetnum);
+    } else if (s->tx_fifo_done_len < NUM_PACKETS) {
+        s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
+    }
+}
+
 /* Flush the TX FIFO.  */
 static void smc91c111_do_tx(smc91c111_state *s)
 {
@@ -264,6 +281,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
         *(p++) = 0x40;
         len = *(p++);
         len |= ((int)*(p++)) << 8;
+        if (len > MAX_PACKET_SIZE) {
+            /*
+             * Datasheet doesn't say what to do here, and there is no
+             * relevant tx error condition listed. Log, and drop the packet.
+             */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "smc91c111: tx packet with bad length %d, dropping\n",
+                          len);
+            smc91c111_complete_tx_packet(s, packetnum);
+            continue;
+        }
         len -= 6;
         control = p[len + 1];
         if (control & 0x20)
@@ -292,11 +320,7 @@ static void smc91c111_do_tx(smc91c111_state *s)
             }
         }
 #endif
-        if (s->ctr & CTR_AUTO_RELEASE)
-            /* Race?  */
-            smc91c111_release_packet(s, packetnum);
-        else if (s->tx_fifo_done_len < NUM_PACKETS)
-            s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
+        smc91c111_complete_tx_packet(s, packetnum);
         qemu_send_packet(qemu_get_queue(s->nic), p, len);
     }
     s->tx_fifo_len = 0;
-- 
2.39.5


