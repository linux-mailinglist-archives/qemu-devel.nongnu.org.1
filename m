Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C78749D89
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzK-0004qc-D2; Thu, 06 Jul 2023 09:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzF-0004n7-4t
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOz4-0000rz-HB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso7474075e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649917; x=1691241917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eZRfw+Y+qoCHkLPcJJixub5r6MA4gHrUcY1/kPyyLV8=;
 b=vQL2mmkt0V9P85K07yJe+oAEm/uVBF0ilHYfXzS5msprzOnQIFCq7Kn9hKbxu5OfH0
 oi5l8pZ7Z7LHb5LpgrkO6ZO2gOr9/nv+Z5k0WjnvR57isukE23F5kX4MNXvrE7XuvH6N
 HhIW+oxHm3Bh9pmX5givrrBG8FgnSW9DNJd1ttLC4dmYLw5N68+bpP2pSJhIPX9Rhia3
 e8BNTo9KmVEanzJ4ZYIFrqpG2UE9SlkBa59Ik2nQSYfBrgXD4mYADn2gMb3vq5LP/TR2
 FbxkNI0w7hCuBOOOPYy837NczgBB3r9SdLu85DHG+xln4ElxsYs8P3VCZRoG+h14QdJa
 ECHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649917; x=1691241917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZRfw+Y+qoCHkLPcJJixub5r6MA4gHrUcY1/kPyyLV8=;
 b=OdQ+pq43FbheGghqhj6+UwLJaGb5s9JAbSKpYi+VIzS07ue8d/gY9vb5q1xTWNdMeo
 vOVMzr2r7BFy8ZfQl7nl8HhF3B0gfbcLebz/3RV8zzOh5cLaelJV+3rVXzMge6v6Wvof
 ufPcHPcIiZqUog94WiVXsBtgXXPogA+kIoIk91XCfzAQIDOjyYgF/qzMagrmCFaNXHY3
 gniJsjnfa9ExRdbMXEeFG7QihPW/cdCCdAodo6yQDG4N5LVqbMzCneJ3/E5AVm8dtobM
 bngdUqI+uQX8wsgcTO4/YLEVygxrrq2vy/sfv9Bh8dQk5b0e6G/SrCPoSSznCrvJyS2U
 ioWA==
X-Gm-Message-State: ABy/qLY6ZN69L2opyb5oUqPitNVAP8yIrG+M4R+q93K+viIBOtfXpmfb
 XmvJH8P6eG2wBgqSTBc53k3HZbExMsuwu8Pcj3w=
X-Google-Smtp-Source: APBJJlFHmPtmIG6av4MOGR47m1B2s6Q6ria5/WgQW4l7IypLDh9v/tdiwwPT/DGoGiL2I2UrPqpP+A==
X-Received: by 2002:a1c:ed14:0:b0:3fb:4149:b816 with SMTP id
 l20-20020a1ced14000000b003fb4149b816mr1409609wmh.8.1688649917730; 
 Thu, 06 Jul 2023 06:25:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] tests/qtest: xlnx-canfd-test: Fix code coverity issues
Date: Thu,  6 Jul 2023 14:25:06 +0100
Message-Id: <20230706132512.3534397-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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


