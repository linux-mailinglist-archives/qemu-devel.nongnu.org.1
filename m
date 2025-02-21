Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F75A3FDF5
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 18:52:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXAR-00011c-AR; Fri, 21 Feb 2025 12:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAC-0000yO-4t; Fri, 21 Feb 2025 12:50:12 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAA-0001pL-5V; Fri, 21 Feb 2025 12:50:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F00DEFB6D;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 07CD81BB589;
 Fri, 21 Feb 2025 20:49:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E65A153F8D; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 10/14] hw/net/smc91c111: Ignore attempt to pop from
 empty RX fifo
Date: Fri, 21 Feb 2025 20:49:40 +0300
Message-Id: <20250221174949.836197-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
References: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
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

The SMC91C111 includes an MMU Command register which permits
the guest to remove entries from the RX FIFO. The datasheet
does not specify what happens if the guest tries to do this
when the FIFO is already empty; there are no status registers
containing error bits which might be applicable.

Currently we don't guard at all against pop of an empty
RX FIFO, with the result that we allow the guest to drive
the rx_fifo_len index to negative values, which will cause
smc91c111_receive() to write to the rx_fifo[] array out of
bounds when we receive the next packet.

Instead ignore attempts to pop an empty RX FIFO.

Cc: qemu-stable@nongnu.org
Fixes: 80337b66a8e7 ("NIC emulation for qemu arm-softmmu")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2780
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250207151157.3151776-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 937df81af6757638a7f1908747560dd342947213)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 180ba5c791..2a652885c9 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -182,6 +182,15 @@ static void smc91c111_pop_rx_fifo(smc91c111_state *s)
 {
     int i;
 
+    if (s->rx_fifo_len == 0) {
+        /*
+         * The datasheet doesn't document what the behaviour is if the
+         * guest tries to pop an empty RX FIFO, and there's no obvious
+         * error status register to report it. Just ignore the attempt.
+         */
+        return;
+    }
+
     s->rx_fifo_len--;
     if (s->rx_fifo_len) {
         for (i = 0; i < s->rx_fifo_len; i++)
-- 
2.39.5


