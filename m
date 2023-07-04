Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9687476DF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1F-0001KC-2L; Tue, 04 Jul 2023 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1C-0001IG-SW
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj16-0001og-IW
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e09a5b19so4920852f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488599; x=1691080599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eZRfw+Y+qoCHkLPcJJixub5r6MA4gHrUcY1/kPyyLV8=;
 b=SL8Nrpcw5kNmqXkEYA6axmI+XtxoWUkl7qvZZDQ5XBUsVmZlTEXmbcXs8fZKIFFmzF
 ejSVO7dDT9M442Uk1Ln7WR2kBMNZq2Lmy3FdPOvBaSgwaoNjeHN4PnS0kU4DKnx0pgGo
 +eLRlfrBoWT2PC7YgmHUCOZNq587IAh9K2TwARDnh2JzwG/pV8AzsMpT2RcwNzvziyUx
 oE5CmQXjfRH48zqxtWtBMMsb/yhIlCYg2ZAOz5tp2uKKZY3JSnk+pVcenwQXQMjT8Q+Y
 RNc7lVCtReZwUlPvEcUv1br5BpmY871zZyk6lyTHZzBPEKdSpAoMVEMxWElUdsgXlVXn
 /qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488599; x=1691080599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZRfw+Y+qoCHkLPcJJixub5r6MA4gHrUcY1/kPyyLV8=;
 b=dfD1xpDQ04djsFRet3EIrW+rnUKR3L8bj3dXvlJ7+ebYSf4UnJXNLIDsybgdgY17rz
 QSnxoo39XgP/+c0QrMEA+WKljfyX+A0h2CyIg+MX9AgUQ7u3jql3P0v2Z6LP2Gs2y3dA
 lBfZtTNiKNEKJxcHHmfd9k2a1td/84reUS6Q+f7T53B0tw28IeNN1GcSNR5gPKVfLHVu
 hGcgss8BRa+M+/ReZX98yYd35eBNxPncMTlXb27l5aDdVy6DdMaGUrRvIt6gDGJdbX+V
 mxPRs/6k5uOWrF1hUjs0RbmnOE3ubm/LpYNU3Hjnr8FqvOu89e5u3ODniDP+Xq6xilBk
 HqdA==
X-Gm-Message-State: AC+VfDwA5YdfsMADilC6f1/Gm04IZ+JIAaQH0kH6KeO8RyxcBKtCnPTU
 UXzSZ8C0bF2+KQTI75sgcHKislTnq7g4cjhSP1I=
X-Google-Smtp-Source: ACHHUZ7l4n+R9CcWMjga2lSG9GPDCWpmP9XmYWz5aO9SVIknbAu9LTDcwmwXrDJxV0BUKf0P3oYnqw==
X-Received: by 2002:a5d:6308:0:b0:30f:c050:88dd with SMTP id
 i8-20020a5d6308000000b0030fc05088ddmr16419155wru.8.1688488599139; 
 Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] tests/qtest: xlnx-canfd-test: Fix code coverity issues
Date: Tue,  4 Jul 2023 17:36:31 +0100
Message-Id: <20230704163634.3188465-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vikram Garhwal <vikram.garhwal@amd.com>

Following are done to fix the coverity issues:
1. Change read_data to fix the CID 1512899: Out-of-bounds access (OVERRUN)
2. Fix match_rx_tx_data to fix CID 1512900: Logically dead code (DEADCODE)
3. Replace rand() in generate_random_data() with g_rand_int()

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Message-id: 20230628202758.16398-1-vikram.garhwal@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/xlnx-canfd-test.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/tests/qtest/xlnx-canfd-test.c b/tests/qtest/xlnx-canfd-test.c
index 76ee106d4f4..78ec9ef2a76 100644
--- a/tests/qtest/xlnx-canfd-test.c
+++ b/tests/qtest/xlnx-canfd-test.c
@@ -170,23 +170,23 @@ static void generate_random_data(uint32_t *buf_tx, bool is_canfd_frame)
     /* Generate random TX data for CANFD frame. */
     if (is_canfd_frame) {
         for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
-            buf_tx[2 + i] = rand();
+            buf_tx[2 + i] = g_random_int();
         }
     } else {
         /* Generate random TX data for CAN frame. */
         for (int i = 0; i < CAN_FRAME_SIZE - 2; i++) {
-            buf_tx[2 + i] = rand();
+            buf_tx[2 + i] = g_random_int();
         }
     }
 }
 
-static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
+static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx,
+                      uint32_t frame_size)
 {
     uint32_t int_status;
     uint32_t fifo_status_reg_value;
     /* At which RX FIFO the received data is stored. */
     uint8_t store_ind = 0;
-    bool is_canfd_frame = false;
 
     /* Read the interrupt on CANFD rx. */
     int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
@@ -207,16 +207,9 @@ static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
     buf_rx[0] = qtest_readl(qts, can_base_addr + R_RX0_ID_OFFSET);
     buf_rx[1] = qtest_readl(qts, can_base_addr + R_RX0_DLC_OFFSET);
 
-    is_canfd_frame = (buf_rx[1] >> DLC_FD_BIT_SHIFT) & 1;
-
-    if (is_canfd_frame) {
-        for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
-            buf_rx[i + 2] = qtest_readl(qts,
-                                    can_base_addr + R_RX0_DATA1_OFFSET + 4 * i);
-        }
-    } else {
-        buf_rx[2] = qtest_readl(qts, can_base_addr + R_RX0_DATA1_OFFSET);
-        buf_rx[3] = qtest_readl(qts, can_base_addr + R_RX0_DATA2_OFFSET);
+    for (int i = 0; i < frame_size - 2; i++) {
+        buf_rx[i + 2] = qtest_readl(qts,
+                                can_base_addr + R_RX0_DATA1_OFFSET + 4 * i);
     }
 
     /* Clear the RX interrupt. */
@@ -272,10 +265,6 @@ static void match_rx_tx_data(const uint32_t *buf_tx, const uint32_t *buf_rx,
             g_assert_cmpint((buf_rx[size] & DLC_FD_BIT_MASK), ==,
                             (buf_tx[size] & DLC_FD_BIT_MASK));
         } else {
-            if (!is_canfd_frame && size == 4) {
-                break;
-            }
-
             g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
         }
 
@@ -318,7 +307,7 @@ static void test_can_data_transfer(void)
     write_data(qts, CANFD0_BASE_ADDR, buf_tx, false);
 
     send_data(qts, CANFD0_BASE_ADDR);
-    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx, CAN_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, false);
 
     qtest_quit(qts);
@@ -358,7 +347,7 @@ static void test_canfd_data_transfer(void)
     write_data(qts, CANFD0_BASE_ADDR, buf_tx, true);
 
     send_data(qts, CANFD0_BASE_ADDR);
-    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx, CANFD_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, true);
 
     qtest_quit(qts);
@@ -397,7 +386,7 @@ static void test_can_loopback(void)
     write_data(qts, CANFD0_BASE_ADDR, buf_tx, true);
 
     send_data(qts, CANFD0_BASE_ADDR);
-    read_data(qts, CANFD0_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD0_BASE_ADDR, buf_rx, CANFD_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, true);
 
     generate_random_data(buf_tx, true);
@@ -405,7 +394,7 @@ static void test_can_loopback(void)
     write_data(qts, CANFD1_BASE_ADDR, buf_tx, true);
 
     send_data(qts, CANFD1_BASE_ADDR);
-    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx, CANFD_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, true);
 
     qtest_quit(qts);
-- 
2.34.1


