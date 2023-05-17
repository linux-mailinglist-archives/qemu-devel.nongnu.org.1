Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42C7063C0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDC1-0001Hb-MR; Wed, 17 May 2023 05:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBi-0000uW-Gz; Wed, 17 May 2023 05:11:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBg-0006Oc-FQ; Wed, 17 May 2023 05:11:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 23A9F6834;
 Wed, 17 May 2023 12:10:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 873935F05;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: (nullmailer pid 3626708 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7.2.3 14/30] hw/net/allwinner-sun8i-emac: Correctly byteswap
 descriptor fields
Date: Wed, 17 May 2023 12:10:26 +0300
Message-Id: <20230517091042.3626593-14-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In allwinner-sun8i-emac we just read directly from guest memory into
a host FrameDescriptor struct and back.  This only works on
little-endian hosts.  Reading and writing of descriptors is already
abstracted into functions; make those functions also handle the
byte-swapping so that TransferDescriptor structs as seen by the rest
of the code are always in host-order, and fix two places that were
doing ad-hoc descriptor reading without using the functions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230424165053.1428857-3-peter.maydell@linaro.org
(cherry picked from commit a4ae17e5ec512862bf73e40dfbb1e7db71f2c1e7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/allwinner-sun8i-emac.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index ecc0245fe8..c3fed5fcbe 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -350,8 +350,13 @@ static void allwinner_sun8i_emac_get_desc(AwSun8iEmacState *s,
                                           FrameDescriptor *desc,
                                           uint32_t phys_addr)
 {
-    dma_memory_read(&s->dma_as, phys_addr, desc, sizeof(*desc),
+    uint32_t desc_words[4];
+    dma_memory_read(&s->dma_as, phys_addr, &desc_words, sizeof(desc_words),
                     MEMTXATTRS_UNSPECIFIED);
+    desc->status = le32_to_cpu(desc_words[0]);
+    desc->status2 = le32_to_cpu(desc_words[1]);
+    desc->addr = le32_to_cpu(desc_words[2]);
+    desc->next = le32_to_cpu(desc_words[3]);
 }
 
 static uint32_t allwinner_sun8i_emac_next_desc(AwSun8iEmacState *s,
@@ -400,10 +405,15 @@ static uint32_t allwinner_sun8i_emac_tx_desc(AwSun8iEmacState *s,
 }
 
 static void allwinner_sun8i_emac_flush_desc(AwSun8iEmacState *s,
-                                            FrameDescriptor *desc,
+                                            const FrameDescriptor *desc,
                                             uint32_t phys_addr)
 {
-    dma_memory_write(&s->dma_as, phys_addr, desc, sizeof(*desc),
+    uint32_t desc_words[4];
+    desc_words[0] = cpu_to_le32(desc->status);
+    desc_words[1] = cpu_to_le32(desc->status2);
+    desc_words[2] = cpu_to_le32(desc->addr);
+    desc_words[3] = cpu_to_le32(desc->next);
+    dma_memory_write(&s->dma_as, phys_addr, &desc_words, sizeof(desc_words),
                      MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -638,8 +648,7 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         break;
     case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
         if (s->tx_desc_curr != 0) {
-            dma_memory_read(&s->dma_as, s->tx_desc_curr, &desc, sizeof(desc),
-                            MEMTXATTRS_UNSPECIFIED);
+            allwinner_sun8i_emac_get_desc(s, &desc, s->tx_desc_curr);
             value = desc.addr;
         } else {
             value = 0;
@@ -652,8 +661,7 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         break;
     case REG_RX_CUR_BUF:        /* Receive Current Buffer */
         if (s->rx_desc_curr != 0) {
-            dma_memory_read(&s->dma_as, s->rx_desc_curr, &desc, sizeof(desc),
-                            MEMTXATTRS_UNSPECIFIED);
+            allwinner_sun8i_emac_get_desc(s, &desc, s->rx_desc_curr);
             value = desc.addr;
         } else {
             value = 0;
-- 
2.39.2


