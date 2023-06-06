Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9608723E70
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIt-0007mz-HS; Tue, 06 Jun 2023 05:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIh-0007b8-Eu
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIb-0004jX-U0
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f7a8089709so22177885e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044900; x=1688636900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fCTad6nrqU7gDGvgejjQ5Ir/YutXgh/fRbK5TvcwaGA=;
 b=OnwaGA2lfwCDDQc3fdEwZwE+0Ew7H1M5csljnLA7PJ6ArhX5/83lINCHa80raNURmw
 qrBLAvfz/YE6ILtEexLEvPTQR4KH+Vqq0zPSQPZMRR8IjFDO1n2yq/i0KeIxjcMtblGi
 Nrk9jAAH0UnQuz+E9gdrXKZcOMNI4etwgvRuIG6SZTyYsRw7Hhm7E2V1eb/Wb49SEEHt
 7OZHkkRh5p0ukOfmxlSJZAFMyOibar5E2O4fnWkmUW4YiXwVIZJSueaGrhjWbCZ1O40u
 4ullkptXs2FIC00CAW7jPkZYrNI40aAKx+aS2PB0fG8Q2ZigbTBOs1uYkSffSxMN2ovg
 StQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044900; x=1688636900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCTad6nrqU7gDGvgejjQ5Ir/YutXgh/fRbK5TvcwaGA=;
 b=ALDvPPAtc61494uJ4Qm1rdqDpGUxYxHJpPzyY2DbIzTicum1lLY3MEDshBhoUKDt6u
 mU+RdZngbnT1aIdpq/dvS2keiO4wpEISsvAIbUgUToYhmulBv8iJYYAck1WV+DSViGYu
 W5Wvz5LE+0qm8eIrD4ICd1DT2Lsn40ic3NZyqPyklTt9dTPzSttdgOvm+P/SN/Jk9Xj3
 OnmitIRXjGh979/V9NiLWnldnV9EpiBmZos/a/Ii9UEACMVbWLF+MYDAy1mISSxzKZ30
 utVyRquhnrX24Mv7lUPKXwtoUWLVM95W94a2/81MrRIdbTjRC8D3pGpK/9i+wahi/ZqB
 BylA==
X-Gm-Message-State: AC+VfDwJQxP3z68SSDYKd7xZu1YD6wzW97TYzSp++5OMU2XnDAo1PTBX
 p5w89GuCAbyi0OetPXGb9EyABZjRFQRfeTRoZXU=
X-Google-Smtp-Source: ACHHUZ6TTE8Eb7NxFdgFjU52aXYE6Q8ZydhsfuMT9VlR5fr3PPYpZjqt6wRrWZJAtkAeOL2lwbUPKg==
X-Received: by 2002:a05:600c:210:b0:3f5:f83:4d84 with SMTP id
 16-20020a05600c021000b003f50f834d84mr1566364wmi.31.1686044900138; 
 Tue, 06 Jun 2023 02:48:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/42] tests/qtest: Introduce tests for Xilinx VERSAL CANFD
 controller
Date: Tue,  6 Jun 2023 10:47:40 +0100
Message-Id: <20230606094814.3581397-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The QTests perform three tests on the Xilinx VERSAL CANFD controller:
    Tests the CANFD controllers in loopback.
    Tests the CANFD controllers in normal mode with CAN frame.
    Tests the CANFD controllers in normal mode with CANFD frame.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/xlnx-canfd-test.c | 423 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 2 files changed, 424 insertions(+)
 create mode 100644 tests/qtest/xlnx-canfd-test.c

diff --git a/tests/qtest/xlnx-canfd-test.c b/tests/qtest/xlnx-canfd-test.c
new file mode 100644
index 00000000000..76ee106d4f4
--- /dev/null
+++ b/tests/qtest/xlnx-canfd-test.c
@@ -0,0 +1,423 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * QTests for the Xilinx Versal CANFD controller.
+ *
+ * Copyright (c) 2022 AMD Inc.
+ *
+ * Written-by: Vikram Garhwal<vikram.garhwal@amd.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/* Base address. */
+#define CANFD0_BASE_ADDR                0xff060000
+#define CANFD1_BASE_ADDR                0xff070000
+
+/* Register addresses. */
+#define R_SRR_OFFSET                    0x00
+#define R_MSR_OFFSET                    0x04
+#define R_FILTER_CONTROL_REGISTER       0xe0
+#define R_SR_OFFSET                     0x18
+#define R_ISR_OFFSET                    0x1c
+#define R_IER_OFFSET                    0x20
+#define R_ICR_OFFSET                    0x24
+#define R_TX_READY_REQ_REGISTER         0x90
+#define RX_FIFO_STATUS_REGISTER         0xe8
+#define R_TXID_OFFSET                   0x100
+#define R_TXDLC_OFFSET                  0x104
+#define R_TXDATA1_OFFSET                0x108
+#define R_TXDATA2_OFFSET                0x10c
+#define R_AFMR_REGISTER0                0xa00
+#define R_AFIR_REGISTER0                0xa04
+#define R_RX0_ID_OFFSET                 0x2100
+#define R_RX0_DLC_OFFSET                0x2104
+#define R_RX0_DATA1_OFFSET              0x2108
+#define R_RX0_DATA2_OFFSET              0x210c
+
+/* CANFD modes. */
+#define SRR_CONFIG_MODE                 0x00
+#define MSR_NORMAL_MODE                 0x00
+#define MSR_LOOPBACK_MODE               (1 << 1)
+#define ENABLE_CANFD                    (1 << 1)
+
+/* CANFD status. */
+#define STATUS_CONFIG_MODE              (1 << 0)
+#define STATUS_NORMAL_MODE              (1 << 3)
+#define STATUS_LOOPBACK_MODE            (1 << 1)
+#define ISR_TXOK                        (1 << 1)
+#define ISR_RXOK                        (1 << 4)
+
+#define ENABLE_ALL_FILTERS              0xffffffff
+#define ENABLE_ALL_INTERRUPTS           0xffffffff
+
+/* We are sending one canfd message. */
+#define TX_READY_REG_VAL                0x1
+
+#define FIRST_RX_STORE_INDEX            0x1
+#define STATUS_REG_MASK                 0xf
+#define DLC_FD_BIT_SHIFT                0x1b
+#define DLC_FD_BIT_MASK                 0xf8000000
+#define FIFO_STATUS_READ_INDEX_MASK     0x3f
+#define FIFO_STATUS_FILL_LEVEL_MASK     0x7f00
+#define FILL_LEVEL_SHIFT                0x8
+
+/* CANFD frame size ID, DLC and 16 DATA word. */
+#define CANFD_FRAME_SIZE        18
+/* CAN frame size ID, DLC and 2 DATA word. */
+#define CAN_FRAME_SIZE          4
+
+/* Set the filters for CANFD controller. */
+static void enable_filters(QTestState *qts)
+{
+     const uint32_t arr_afmr[32] = { 0xb423deaa, 0xa2a40bdc, 0x1b64f486,
+                                     0x95c0d4ee, 0xe0c44528, 0x4b407904,
+                                     0xd2673f46, 0x9fc638d6, 0x8844f3d8,
+                                     0xa607d1e8, 0x67871bf4, 0xc2557dc,
+                                     0x9ea5b53e, 0x3643c0cc, 0x5a05ea8e,
+                                     0x83a46d84, 0x4a25c2b8, 0x93a66008,
+                                     0x2e467470, 0xedc66118, 0x9086f9f2,
+                                     0xfa23dd36, 0xb6654b90, 0xb221b8ca,
+                                     0x3467d1e2, 0xa3a55542, 0x5b26a012,
+                                     0x2281ea7e, 0xcea0ece8, 0xdc61e588,
+                                     0x2e5676a,  0x16821320 };
+
+    const uint32_t arr_afir[32] = { 0xa833dfa1, 0x255a477e, 0x3a4bb1c5,
+                                    0x8f560a6c, 0x27f38903, 0x2fecec4d,
+                                    0xa014c66d, 0xec289b8,  0x7e52dead,
+                                    0x82e94f3c, 0xcf3e3c5c, 0x66059871,
+                                    0x3f213df4, 0x25ac3959, 0xa12e9bef,
+                                    0xa3ad3af,  0xbafd7fe,  0xb3cb40fd,
+                                    0x5d9caa81, 0x2ed61902, 0x7cd64a0,
+                                    0x4b1fa538, 0x9b5ced8c, 0x150de059,
+                                    0xd2794227, 0x635e820a, 0xbb6b02cf,
+                                    0xbb58176,  0x570025bb, 0xa78d9658,
+                                    0x49d735df, 0xe5399d2f };
+
+    /* Passing the respective array values to all the AFMR and AFIR pairs. */
+    for (int i = 0; i < 32; i++) {
+        /* For CANFD0. */
+       qtest_writel(qts, CANFD0_BASE_ADDR + R_AFMR_REGISTER0 + 8 * i,
+                    arr_afmr[i]);
+       qtest_writel(qts, CANFD0_BASE_ADDR + R_AFIR_REGISTER0 + 8 * i,
+                    arr_afir[i]);
+
+        /* For CANFD1. */
+       qtest_writel(qts, CANFD1_BASE_ADDR + R_AFMR_REGISTER0 + 8 * i,
+                    arr_afmr[i]);
+       qtest_writel(qts, CANFD1_BASE_ADDR + R_AFIR_REGISTER0 + 8 * i,
+                    arr_afir[i]);
+    }
+
+    /* Enable all the pairs from AFR register. */
+    qtest_writel(qts, CANFD0_BASE_ADDR + R_FILTER_CONTROL_REGISTER,
+                 ENABLE_ALL_FILTERS);
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_FILTER_CONTROL_REGISTER,
+                 ENABLE_ALL_FILTERS);
+}
+
+static void configure_canfd(QTestState *qts, uint8_t mode)
+{
+    uint32_t status = 0;
+
+    /* Put CANFD0 and CANFD1 in config mode. */
+    qtest_writel(qts, CANFD0_BASE_ADDR + R_SRR_OFFSET, SRR_CONFIG_MODE);
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_SRR_OFFSET, SRR_CONFIG_MODE);
+
+    /* Write mode of operation in Mode select register. */
+    qtest_writel(qts, CANFD0_BASE_ADDR + R_MSR_OFFSET, mode);
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_MSR_OFFSET, mode);
+
+    enable_filters(qts);
+
+    /* Check here if CANFD0 and CANFD1 are in config mode. */
+    status = qtest_readl(qts, CANFD0_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_CONFIG_MODE);
+
+    status = qtest_readl(qts, CANFD1_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_CONFIG_MODE);
+
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_IER_OFFSET, ENABLE_ALL_INTERRUPTS);
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_IER_OFFSET, ENABLE_ALL_INTERRUPTS);
+
+    qtest_writel(qts, CANFD0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CANFD);
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CANFD);
+}
+
+static void generate_random_data(uint32_t *buf_tx, bool is_canfd_frame)
+{
+    /* Generate random TX data for CANFD frame. */
+    if (is_canfd_frame) {
+        for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
+            buf_tx[2 + i] = rand();
+        }
+    } else {
+        /* Generate random TX data for CAN frame. */
+        for (int i = 0; i < CAN_FRAME_SIZE - 2; i++) {
+            buf_tx[2 + i] = rand();
+        }
+    }
+}
+
+static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
+{
+    uint32_t int_status;
+    uint32_t fifo_status_reg_value;
+    /* At which RX FIFO the received data is stored. */
+    uint8_t store_ind = 0;
+    bool is_canfd_frame = false;
+
+    /* Read the interrupt on CANFD rx. */
+    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
+
+    g_assert_cmpint(int_status, ==, ISR_RXOK);
+
+    /* Find the fill level and read index. */
+    fifo_status_reg_value = qtest_readl(qts, can_base_addr +
+                                        RX_FIFO_STATUS_REGISTER);
+
+    store_ind = (fifo_status_reg_value & FIFO_STATUS_READ_INDEX_MASK) +
+                ((fifo_status_reg_value & FIFO_STATUS_FILL_LEVEL_MASK) >>
+                  FILL_LEVEL_SHIFT);
+
+    g_assert_cmpint(store_ind, ==, FIRST_RX_STORE_INDEX);
+
+    /* Read the RX register data for CANFD. */
+    buf_rx[0] = qtest_readl(qts, can_base_addr + R_RX0_ID_OFFSET);
+    buf_rx[1] = qtest_readl(qts, can_base_addr + R_RX0_DLC_OFFSET);
+
+    is_canfd_frame = (buf_rx[1] >> DLC_FD_BIT_SHIFT) & 1;
+
+    if (is_canfd_frame) {
+        for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
+            buf_rx[i + 2] = qtest_readl(qts,
+                                    can_base_addr + R_RX0_DATA1_OFFSET + 4 * i);
+        }
+    } else {
+        buf_rx[2] = qtest_readl(qts, can_base_addr + R_RX0_DATA1_OFFSET);
+        buf_rx[3] = qtest_readl(qts, can_base_addr + R_RX0_DATA2_OFFSET);
+    }
+
+    /* Clear the RX interrupt. */
+    qtest_writel(qts, CANFD1_BASE_ADDR + R_ICR_OFFSET, ISR_RXOK);
+}
+
+static void write_data(QTestState *qts, uint64_t can_base_addr,
+                       const uint32_t *buf_tx, bool is_canfd_frame)
+{
+    /* Write the TX register data for CANFD. */
+    qtest_writel(qts, can_base_addr + R_TXID_OFFSET, buf_tx[0]);
+    qtest_writel(qts, can_base_addr + R_TXDLC_OFFSET, buf_tx[1]);
+
+    if (is_canfd_frame) {
+        for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
+            qtest_writel(qts, can_base_addr + R_TXDATA1_OFFSET + 4 * i,
+                         buf_tx[2 + i]);
+        }
+    } else {
+        qtest_writel(qts, can_base_addr + R_TXDATA1_OFFSET, buf_tx[2]);
+        qtest_writel(qts, can_base_addr + R_TXDATA2_OFFSET, buf_tx[3]);
+    }
+}
+
+static void send_data(QTestState *qts, uint64_t can_base_addr)
+{
+    uint32_t int_status;
+
+    qtest_writel(qts, can_base_addr + R_TX_READY_REQ_REGISTER,
+                 TX_READY_REG_VAL);
+
+    /* Read the interrupt on CANFD for tx. */
+    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_TXOK;
+
+    g_assert_cmpint(int_status, ==, ISR_TXOK);
+
+    /* Clear the interrupt for tx. */
+    qtest_writel(qts, CANFD0_BASE_ADDR + R_ICR_OFFSET, ISR_TXOK);
+}
+
+static void match_rx_tx_data(const uint32_t *buf_tx, const uint32_t *buf_rx,
+                             bool is_canfd_frame)
+{
+    uint16_t size = 0;
+    uint8_t len = CAN_FRAME_SIZE;
+
+    if (is_canfd_frame) {
+        len = CANFD_FRAME_SIZE;
+    }
+
+    while (size < len) {
+        if (R_RX0_ID_OFFSET + 4 * size == R_RX0_DLC_OFFSET)  {
+            g_assert_cmpint((buf_rx[size] & DLC_FD_BIT_MASK), ==,
+                            (buf_tx[size] & DLC_FD_BIT_MASK));
+        } else {
+            if (!is_canfd_frame && size == 4) {
+                break;
+            }
+
+            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
+        }
+
+        size++;
+    }
+}
+/*
+ * Xilinx CANFD supports both CAN and CANFD frames. This test will be
+ * transferring CAN frame i.e. 8 bytes of data from CANFD0 and CANFD1 through
+ * canbus. CANFD0 initiate the data transfer to can-bus, CANFD1 receives the
+ * data. Test compares the can frame data sent from CANFD0 and received on
+ * CANFD1.
+ */
+static void test_can_data_transfer(void)
+{
+    uint32_t buf_tx[CAN_FRAME_SIZE] = { 0x5a5bb9a4, 0x80000000,
+                                        0x12345678, 0x87654321 };
+    uint32_t buf_rx[CAN_FRAME_SIZE] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+
+    generate_random_data(buf_tx, false);
+
+    QTestState *qts = qtest_init("-machine xlnx-versal-virt"
+                " -object can-bus,id=canbus"
+                " -machine canbus0=canbus"
+                " -machine canbus1=canbus"
+                );
+
+    configure_canfd(qts, MSR_NORMAL_MODE);
+
+    /* Check if CANFD0 and CANFD1 are in Normal mode. */
+    status = qtest_readl(qts, CANFD0_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    status = qtest_readl(qts, CANFD1_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    write_data(qts, CANFD0_BASE_ADDR, buf_tx, false);
+
+    send_data(qts, CANFD0_BASE_ADDR);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, false);
+
+    qtest_quit(qts);
+}
+
+/*
+ * This test will be transferring CANFD frame i.e. 64 bytes of data from CANFD0
+ * and CANFD1 through canbus. CANFD0 initiate the data transfer to can-bus,
+ * CANFD1 receives the data. Test compares the CANFD frame data sent from CANFD0
+ * with received on CANFD1.
+ */
+static void test_canfd_data_transfer(void)
+{
+    uint32_t buf_tx[CANFD_FRAME_SIZE] = { 0x5a5bb9a4, 0xf8000000 };
+    uint32_t buf_rx[CANFD_FRAME_SIZE] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+
+    generate_random_data(buf_tx, true);
+
+    QTestState *qts = qtest_init("-machine xlnx-versal-virt"
+                " -object can-bus,id=canbus"
+                " -machine canbus0=canbus"
+                " -machine canbus1=canbus"
+                );
+
+    configure_canfd(qts, MSR_NORMAL_MODE);
+
+    /* Check if CANFD0 and CANFD1 are in Normal mode. */
+    status = qtest_readl(qts, CANFD0_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    status = qtest_readl(qts, CANFD1_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    write_data(qts, CANFD0_BASE_ADDR, buf_tx, true);
+
+    send_data(qts, CANFD0_BASE_ADDR);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, true);
+
+    qtest_quit(qts);
+}
+
+/*
+ * This test is performing loopback mode on CANFD0 and CANFD1. Data sent from
+ * TX of each CANFD0 and CANFD1 are compared with RX register data for
+ * respective CANFD Controller.
+ */
+static void test_can_loopback(void)
+{
+    uint32_t buf_tx[CANFD_FRAME_SIZE] = { 0x5a5bb9a4, 0xf8000000 };
+    uint32_t buf_rx[CANFD_FRAME_SIZE] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+
+    generate_random_data(buf_tx, true);
+
+    QTestState *qts = qtest_init("-machine xlnx-versal-virt"
+                " -object can-bus,id=canbus"
+                " -machine canbus0=canbus"
+                " -machine canbus1=canbus"
+                );
+
+    configure_canfd(qts, MSR_LOOPBACK_MODE);
+
+    /* Check if CANFD0 and CANFD1 are set in correct loopback mode. */
+    status = qtest_readl(qts, CANFD0_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
+
+    status = qtest_readl(qts, CANFD1_BASE_ADDR + R_SR_OFFSET);
+    status = status & STATUS_REG_MASK;
+    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
+
+    write_data(qts, CANFD0_BASE_ADDR, buf_tx, true);
+
+    send_data(qts, CANFD0_BASE_ADDR);
+    read_data(qts, CANFD0_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, true);
+
+    generate_random_data(buf_tx, true);
+
+    write_data(qts, CANFD1_BASE_ADDR, buf_tx, true);
+
+    send_data(qts, CANFD1_BASE_ADDR);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, true);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/net/canfd/can_data_transfer", test_can_data_transfer);
+    qtest_add_func("/net/canfd/canfd_data_transfer", test_canfd_data_transfer);
+    qtest_add_func("/net/canfd/can_loopback", test_can_loopback);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 087f2dc9d7c..fd434069b78 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -215,6 +215,7 @@ qtests_aarch64 = \
   (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
-- 
2.34.1


