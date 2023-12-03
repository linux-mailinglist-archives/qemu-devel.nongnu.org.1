Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BF802927
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:47:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w80-0000JE-RM; Sun, 03 Dec 2023 18:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w77-0007Tb-Jf; Sun, 03 Dec 2023 18:43:06 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w74-0002rH-TC; Sun, 03 Dec 2023 18:43:04 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d81c24cef2so6716937b3.2; 
 Sun, 03 Dec 2023 15:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646981; x=1702251781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEcoat7SC4jN+C9La2rhXqQ9NFVHbLoJsMPiUtjdyFI=;
 b=gYDDUB8inRZODRXDfQDX9ugIVv7oMBTuUjjlRlS+fpncZNvssJrms9agdb6PEWWUrg
 7hh86fd+hYa8jdi7hwjcaox73HFVEm65+4SDhp0SEH73nx08azU3eCbq7BxbUX4mrlSQ
 VOrXZzDXPxAXra5dtir6TeE7Ax2KBeaYlsMICVYexz19Yt9JIZ+pZLkT1AZhBqqiMLC0
 XPzzPgKrLA4/OKxGgovy9/zqf+lh0Ngvbd7+pI4T5DlFXG9WzIU9gUs5M/Kz2lQxVEGw
 tDwTp7DdlGtiVjBi8NX+tbFeCRqTgdqiTSeFjNKpxK8WPfwkBX3q0tSYh9RFBs5zxom+
 I9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646981; x=1702251781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEcoat7SC4jN+C9La2rhXqQ9NFVHbLoJsMPiUtjdyFI=;
 b=fzUjqqRFFpDIiTWiWZDWVgVGzg01fCPfuZirmPbahXEZJdBzJFJNzdCcxBwZiVBQCj
 con7Dvg/myWU95iHTCEqCWQ2yIUbiEXyAKd8tUKzmMhENOiWW95F2qDpxNFrEMLNn2KL
 nRF+nM5YZpbe2gdnsoMp2LCw8nTNvOle/mS31dB/uaAP18+p2FivZWPydFBKbbrh2MTd
 oglsVGZUj7SnvuVQpolg4e+vU5/nhfgaGUor2n0ZSWuohokIBdTRIE1fVXTlczGGMald
 IkXpjwLy6I3YdgHkHX9z+CS9pao2ct7odqsNU4S16xin9SSd19uImJsX56ZfYImYMv0S
 4exQ==
X-Gm-Message-State: AOJu0YxSMd+eOeoh7SxH3uhKEQLJ72DVVy1j7QwG9IYsEDNzBf2YZdYL
 s0T6zhs2hEbUiBNAtxfFKyKi5/S2Bf+3bQ==
X-Google-Smtp-Source: AGHT+IEjsfg1XwMFLc8ACdi927vJFU4WLGXkPPhBBSPUXuMUce7/lUmQrzY7ulUddzv5b2gj1SsyVw==
X-Received: by 2002:a81:4e10:0:b0:5d8:b575:96a5 with SMTP id
 c16-20020a814e10000000b005d8b57596a5mr332360ywb.79.1701646981308; 
 Sun, 03 Dec 2023 15:43:01 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:43:01 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 40/45] Add mailbox property tests. Part 1
Date: Sun,  3 Dec 2023 17:42:08 -0600
Message-Id: <20231203234213.1366214-41-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.c            |  34 ++--
 tests/qtest/bcm2838-mailbox.h            |  18 +-
 tests/qtest/bcm2838-mbox-property-test.c | 206 +++++++++++++++++++++++
 tests/qtest/meson.build                  |   2 +-
 4 files changed, 220 insertions(+), 40 deletions(-)
 create mode 100644 tests/qtest/bcm2838-mbox-property-test.c

diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
index 2edc24e15e..4b160cd56c 100644
--- a/tests/qtest/bcm2838-mailbox.c
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -12,6 +12,10 @@
 #include "libqtest-single.h"
 #include "bcm2838-mailbox.h"
 
+REG32(MBOX_EXCHNG_REG,          0)
+FIELD(MBOX_EXCHNG_REG, CHANNEL, 0, 4)
+FIELD(MBOX_EXCHNG_REG, DATA,    4, 28)
+
 
 static uint32_t qtest_mbox0_read_reg32(QTestState *s, uint32_t offset)
 {
@@ -25,47 +29,33 @@ static void qtest_mbox1_write_reg32(QTestState *s, uint32_t offset, uint32_t val
 
 static void qtest_mbox1_write(QTestState *s, uint8_t channel, uint32_t data)
 {
-    uint32_t reg;
+    uint32_t mbox_reg = 0;
 
-    reg = FIELD_DP32(reg, MBOX_WRITE_REG, CHANNEL, channel);
-    reg = FIELD_DP32(reg, MBOX_WRITE_REG, DATA, data);
-    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, reg);
+    mbox_reg = FIELD_DP32(mbox_reg, MBOX_EXCHNG_REG, CHANNEL, channel);
+    mbox_reg = FIELD_DP32(mbox_reg, MBOX_EXCHNG_REG, DATA, data);
+    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, mbox_reg);
 }
 
 int qtest_mbox0_has_data(QTestState *s) {
     return !(qtest_mbox0_read_reg32(s, MBOX_REG_STATUS) & MBOX_READ_EMPTY);
 }
 
-int mbox0_has_data(void) {
-    return qtest_mbox0_has_data(global_qtest);
-}
-
 void qtest_mbox0_read_message(QTestState *s,
                               uint8_t channel,
                               void *msgbuf,
                               size_t msgbuf_size)
 {
-    uint32_t reg;
+    uint32_t mbox_reg;
     uint32_t msgaddr;
 
     g_assert(qtest_mbox0_has_data(s));
-    reg = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
-    g_assert_cmphex(FIELD_EX32(reg, MBOX_WRITE_REG, CHANNEL), ==, channel);
-    msgaddr = FIELD_EX32(reg, MBOX_WRITE_REG, DATA) << 4;
+    mbox_reg = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
+    g_assert_cmphex(FIELD_EX32(mbox_reg, MBOX_EXCHNG_REG, CHANNEL), ==, channel);
+    msgaddr = FIELD_EX32(mbox_reg, MBOX_EXCHNG_REG, DATA) << 4;
     qtest_memread(s, msgaddr, msgbuf, msgbuf_size);
 }
 
-void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size) {
-    qtest_mbox0_read_message(global_qtest, channel, msgbuf, msgbuf_size);
-}
-
 void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr)
 {
     qtest_mbox1_write(s, channel, msg_addr >> 4);
 }
-
-
-void mbox1_write_message(uint8_t channel, uint32_t msg_addr)
-{
-    qtest_mbox1_write_message(global_qtest, channel, msg_addr);
-}
diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 2b140a5d32..7e660e65a7 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -77,7 +77,7 @@
 #define TAG_SET_GPIO_STATE         0x00038041
 #define TAG_INITIALIZE_VCHIQ       0x00048010
 
-#define BOARD_REVISION    11546898
+#define BOARD_REVISION    0xB03115
 #define FIRMWARE_REVISION 346337
 #define FIRMWARE_VARIANT  0x77777777 /* TODO: Find the real value */
 
@@ -147,22 +147,6 @@
 /* Used to test stubs that don't perform actual work */
 #define DUMMY_VALUE 0x12345678
 
-REG32(MBOX_WRITE_REG,          0)
-FIELD(MBOX_WRITE_REG, CHANNEL, 0, 4)
-FIELD(MBOX_WRITE_REG, DATA,    4, 28)
-
-REG32(MBOX_SIZE_STAT,          0)
-FIELD(MBOX_SIZE_STAT, SIZE,    0, 30)
-FIELD(MBOX_SIZE_STAT, SUCCESS, 30, 1)
-
-REG32(SET_DEVICE_POWER_STATE_CMD,        0)
-FIELD(SET_DEVICE_POWER_STATE_CMD, EN,    0, 1)
-FIELD(SET_DEVICE_POWER_STATE_CMD, WAIT,  1, 1)
-
-REG32(GET_CLOCK_STATE_CMD,        0)
-FIELD(GET_CLOCK_STATE_CMD, EN,    0, 1)
-FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)
-
 typedef struct {
     uint32_t size;
     uint32_t req_resp_code;
diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
new file mode 100644
index 0000000000..80746dbb95
--- /dev/null
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -0,0 +1,206 @@
+/*
+ * Tests set for BCM2838 mailbox property interface.
+ *
+ * Copyright (c) 2022 Auriga
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/registerfields.h"
+#include "libqtest-single.h"
+#include "bcm2838-mailbox.h"
+
+REG32(MBOX_SIZE_STAT,          0)
+FIELD(MBOX_SIZE_STAT, SIZE,    0, 31)
+FIELD(MBOX_SIZE_STAT, SUCCESS, 31, 1)
+
+REG32(SET_DEVICE_POWER_STATE_CMD,        0)
+FIELD(SET_DEVICE_POWER_STATE_CMD, EN,    0, 1)
+FIELD(SET_DEVICE_POWER_STATE_CMD, WAIT,  1, 1)
+
+REG32(GET_CLOCK_STATE_CMD,        0)
+FIELD(GET_CLOCK_STATE_CMD, EN,    0, 1)
+FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)
+
+#define MBOX_TEST_MESSAGE_ADDRESS 0x10000000
+
+#define TEST_TAG(x) TAG_ ## x
+#define TEST_TAG_TYPE(x) TAG_##x##_t
+
+#define TEST_FN_NAME(test, subtest) \
+    test ## _ ## subtest ## _test
+
+#define SETUP_FN_NAME(test, subtest) \
+    test ## _ ## subtest ## _setup
+
+#define CHECK_FN_NAME(test, subtest) \
+    test ## _ ## subtest ## _spec_check
+
+#define DECLARE_TEST_CASE_SETUP(testname, ...)              \
+    void SETUP_FN_NAME(testname, __VA_ARGS__)               \
+                             (TEST_TAG_TYPE(testname) * tag)
+
+/*----------------------------------------------------------------------------*/
+#define DECLARE_TEST_CASE(testname, ...)                                       \
+    __attribute__((weak))                                                      \
+    void SETUP_FN_NAME(testname, __VA_ARGS__)                                  \
+                      (TEST_TAG_TYPE(testname) * tag);                         \
+    static void CHECK_FN_NAME(testname, __VA_ARGS__)                           \
+                             (TEST_TAG_TYPE(testname) *tag);                   \
+    static void TEST_FN_NAME(testname, __VA_ARGS__)(void) {                    \
+        struct {                                                               \
+            MboxBufHeader header;                                              \
+            TEST_TAG_TYPE(testname) tag;                                       \
+            uint32_t end_tag;                                                  \
+        } mailbox_buffer = { 0 };                                              \
+                                                                               \
+        QTestState *qts = qtest_init("-machine raspi4b-2g");                   \
+                                                                               \
+        mailbox_buffer.header.size = sizeof(mailbox_buffer);                   \
+        mailbox_buffer.header.req_resp_code = MBOX_PROCESS_REQUEST;            \
+                                                                               \
+        mailbox_buffer.tag.id = TEST_TAG(testname);                            \
+        mailbox_buffer.tag.value_buffer_size = MAX(                            \
+            sizeof(mailbox_buffer.tag.request.value),                          \
+            sizeof(mailbox_buffer.tag.response.value));                        \
+        mailbox_buffer.tag.request.zero = 0;                                   \
+                                                                               \
+        mailbox_buffer.end_tag = TAG_END;                                      \
+                                                                               \
+        if (SETUP_FN_NAME(testname, __VA_ARGS__)) {                            \
+            SETUP_FN_NAME(testname, __VA_ARGS__)(&mailbox_buffer.tag);         \
+        }                                                                      \
+                                                                               \
+        qtest_memwrite(qts, MBOX_TEST_MESSAGE_ADDRESS,                         \
+                    &mailbox_buffer, sizeof(mailbox_buffer));                  \
+        qtest_mbox1_write_message(qts, MBOX_CHANNEL_ID_PROPERTY,               \
+                            MBOX_TEST_MESSAGE_ADDRESS);                        \
+                                                                               \
+        qtest_mbox0_read_message(qts, MBOX_CHANNEL_ID_PROPERTY,                \
+                            &mailbox_buffer, sizeof(mailbox_buffer));          \
+                                                                               \
+        g_assert_cmphex(mailbox_buffer.header.req_resp_code, ==, MBOX_SUCCESS);\
+                                                                               \
+        g_assert_cmphex(mailbox_buffer.tag.id, ==, TEST_TAG(testname));        \
+                                                                               \
+        uint32_t size = FIELD_EX32(mailbox_buffer.tag.response.size_stat,      \
+                                   MBOX_SIZE_STAT, SIZE);                      \
+        uint32_t success = FIELD_EX32(mailbox_buffer.tag.response.size_stat,   \
+                                      MBOX_SIZE_STAT, SUCCESS);                \
+        g_assert_cmpint(size, ==, sizeof(mailbox_buffer.tag.response.value));  \
+        g_assert_cmpint(success, ==, 1);                                       \
+                                                                               \
+        CHECK_FN_NAME(testname, __VA_ARGS__)(&mailbox_buffer.tag);             \
+                                                                               \
+        qtest_quit(qts);                                                       \
+    }                                                                          \
+    static void CHECK_FN_NAME(testname, __VA_ARGS__)                           \
+                             (TEST_TAG_TYPE(testname) * tag)
+
+/*----------------------------------------------------------------------------*/
+
+#define QTEST_ADD_TEST_CASE(testname, ...)                                     \
+    qtest_add_func(stringify(/bcm2838/mbox/property/                           \
+                   TEST_FN_NAME(testname, __VA_ARGS__)-test),                  \
+                   TEST_FN_NAME(testname, __VA_ARGS__))
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FIRMWARE_REVISION) {
+    g_assert_cmpint(tag->response.value.revision, ==, FIRMWARE_REVISION);
+}
+
+// /*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_BOARD_REVISION) {
+    g_assert_cmpint(tag->response.value.revision, ==, BOARD_REVISION);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_ARM_MEMORY) {
+    g_assert_cmphex(tag->response.value.base, ==, ARM_MEMORY_BASE);
+    g_assert_cmphex(tag->response.value.size, ==, ARM_MEMORY_SIZE);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_VC_MEMORY) {
+    g_assert_cmphex(tag->response.value.base, ==, VC_MEMORY_BASE);
+    g_assert_cmphex(tag->response.value.size, ==, VC_MEMORY_SIZE);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_DEVICE_POWER_STATE) {
+    uint32_t enabled =
+        FIELD_EX32(tag->response.value.cmd, SET_DEVICE_POWER_STATE_CMD, EN);
+    uint32_t wait =
+        FIELD_EX32(tag->response.value.cmd, SET_DEVICE_POWER_STATE_CMD, WAIT);
+    g_assert_cmphex(tag->response.value.device_id, ==, DEVICE_ID_UART0);
+    g_assert_cmpint(enabled, ==, 1);
+    g_assert_cmpint(wait, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_DEVICE_POWER_STATE) {
+    tag->request.value.device_id = DEVICE_ID_UART0;
+    tag->response.value.cmd =
+        FIELD_DP32(tag->response.value.cmd, SET_DEVICE_POWER_STATE_CMD, EN, 1);
+    tag->response.value.cmd =
+        FIELD_DP32(tag->response.value.cmd, SET_DEVICE_POWER_STATE_CMD, WAIT, 1);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_STATE) {
+    uint32_t enabled =
+        FIELD_EX32(tag->response.value.cmd, GET_CLOCK_STATE_CMD, EN);
+    uint32_t not_present =
+        FIELD_EX32(tag->response.value.cmd, GET_CLOCK_STATE_CMD, NPRES);
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(enabled, ==, 1);
+    g_assert_cmphex(not_present, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_STATE) {
+   tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, EMMC) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_EMMC);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_EMMC);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, EMMC) {
+    tag->request.value.clock_id = CLOCK_ID_EMMC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, EMMC) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_EMMC);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_EMMC);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, EMMC) {
+    tag->request.value.clock_id = CLOCK_ID_EMMC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, EMMC) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_EMMC);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_EMMC);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, EMMC) {
+    tag->request.value.clock_id = CLOCK_ID_EMMC;
+}
+
+/*----------------------------------------------------------------------------*/
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    QTEST_ADD_TEST_CASE(GET_FIRMWARE_REVISION);
+    QTEST_ADD_TEST_CASE(GET_BOARD_REVISION);
+    QTEST_ADD_TEST_CASE(GET_ARM_MEMORY);
+    QTEST_ADD_TEST_CASE(GET_VC_MEMORY);
+    QTEST_ADD_TEST_CASE(SET_DEVICE_POWER_STATE);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_STATE);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, EMMC);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, EMMC);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, EMMC);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 92eba5ac99..2351e99fd5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -217,7 +217,7 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2838-mbox-property-test'] : []) +  \
   (config_all.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   ['arm-cpu-features',
-- 
2.34.1


