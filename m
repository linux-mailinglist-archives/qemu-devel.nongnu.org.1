Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2AA8027C5
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:30:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u2c-0002ZN-Fi; Sun, 03 Dec 2023 16:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u2E-00022k-Nh; Sun, 03 Dec 2023 16:29:54 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u2C-0005Z8-NM; Sun, 03 Dec 2023 16:29:54 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-da41acaea52so2056899276.3; 
 Sun, 03 Dec 2023 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638991; x=1702243791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOsDq4GO7J9Ybd/9mWWm7M2ltcuRdDgkXqPddf6YrXg=;
 b=lYBEQqR3l4pjxsG2J64fjEopJAhTIPleFFskn6Mr/JySU7UhLI3hzMghc+CAvMqQ0r
 GVBCHMcAuKtCOmcT1qwoSYDUwEsj98e3zg3i+6OfBrQY0kLg4J/N1WdHqRsgE96UlzsV
 DI50hwLw48KFgA0Cv7Ocf4GFJiWIfOU+BtpFft7Eb34KTo6hdCS2Ez22/l9f0aVSxfX3
 hVp01pISQ93wLmX/hnXjpOa9zb966LSs5In0Un7NZrBUJWgqIwUju6armn5KA7KiJVBq
 eI0lDeIKIyUONYou2Annt1oWwgGMKW/KxgAtziKHPBWCRNhAOJxBpILlF+z0oUrIFowq
 brCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638991; x=1702243791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOsDq4GO7J9Ybd/9mWWm7M2ltcuRdDgkXqPddf6YrXg=;
 b=p35yPrNvZU0za8uN0N5ZG5kLkony67D4R4x9YWRuHoG+u8EEZvGdOK1oSXl6ZhG156
 acPyt3dg3eEsehPnPaa6hw4EKzjKZqLF3HuOKTHFGGBadgFuu5RO72fQDaJBXFKrND0l
 0nIVf6O2LFAy2og2ijuCo5HQAbjax6AUqmqj6kL/xwGmnRKpfLfSfq04J+gF+XW+wulj
 FNM3BXYYRhRk+hjdo1JKn4/l6PEHkX3213VF4XhZLoRtrkT1RcFFyHpUsdovBS8snakF
 wCjpUzrLLGMrjgoF7GJn5aQ5Zn1DdwYrlRfsQFb9z+BH4mDB9K/diOXmfytqhdn/9wRm
 D9Gg==
X-Gm-Message-State: AOJu0YzTplDYTU1xnAVngtB6c884ecetJGe/8g4Td5kU0lgJgUuVFXUQ
 jnRABquP3rUQSFwy2aTylBMUeCYO+VBnxg==
X-Google-Smtp-Source: AGHT+IG7ccyxIKHqD1GjV6GC3WexbZjwydWQtlFDruc4WMBnSTV3yYj4wgYAWfSdqSi/7/eRmizo1A==
X-Received: by 2002:a25:2f87:0:b0:db9:5b19:4852 with SMTP id
 v129-20020a252f87000000b00db95b194852mr799064ybv.50.1701638991232; 
 Sun, 03 Dec 2023 13:29:51 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:51 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 41/45] Add mailbox property tests. Part 2
Date: Sun,  3 Dec 2023 15:29:01 -0600
Message-Id: <20231203212905.1364036-42-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-41-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-2-sergey.kambalin@auriga.com>
 <20231203212905.1364036-3-sergey.kambalin@auriga.com>
 <20231203212905.1364036-4-sergey.kambalin@auriga.com>
 <20231203212905.1364036-5-sergey.kambalin@auriga.com>
 <20231203212905.1364036-6-sergey.kambalin@auriga.com>
 <20231203212905.1364036-7-sergey.kambalin@auriga.com>
 <20231203212905.1364036-8-sergey.kambalin@auriga.com>
 <20231203212905.1364036-9-sergey.kambalin@auriga.com>
 <20231203212905.1364036-10-sergey.kambalin@auriga.com>
 <20231203212905.1364036-11-sergey.kambalin@auriga.com>
 <20231203212905.1364036-12-sergey.kambalin@auriga.com>
 <20231203212905.1364036-13-sergey.kambalin@auriga.com>
 <20231203212905.1364036-14-sergey.kambalin@auriga.com>
 <20231203212905.1364036-15-sergey.kambalin@auriga.com>
 <20231203212905.1364036-16-sergey.kambalin@auriga.com>
 <20231203212905.1364036-17-sergey.kambalin@auriga.com>
 <20231203212905.1364036-18-sergey.kambalin@auriga.com>
 <20231203212905.1364036-19-sergey.kambalin@auriga.com>
 <20231203212905.1364036-20-sergey.kambalin@auriga.com>
 <20231203212905.1364036-21-sergey.kambalin@auriga.com>
 <20231203212905.1364036-22-sergey.kambalin@auriga.com>
 <20231203212905.1364036-23-sergey.kambalin@auriga.com>
 <20231203212905.1364036-24-sergey.kambalin@auriga.com>
 <20231203212905.1364036-25-sergey.kambalin@auriga.com>
 <20231203212905.1364036-26-sergey.kambalin@auriga.com>
 <20231203212905.1364036-27-sergey.kambalin@auriga.com>
 <20231203212905.1364036-28-sergey.kambalin@auriga.com>
 <20231203212905.1364036-29-sergey.kambalin@auriga.com>
 <20231203212905.1364036-30-sergey.kambalin@auriga.com>
 <20231203212905.1364036-31-sergey.kambalin@auriga.com>
 <20231203212905.1364036-32-sergey.kambalin@auriga.com>
 <20231203212905.1364036-33-sergey.kambalin@auriga.com>
 <20231203212905.1364036-34-sergey.kambalin@auriga.com>
 <20231203212905.1364036-35-sergey.kambalin@auriga.com>
 <20231203212905.1364036-36-sergey.kambalin@auriga.com>
 <20231203212905.1364036-37-sergey.kambalin@auriga.com>
 <20231203212905.1364036-38-sergey.kambalin@auriga.com>
 <20231203212905.1364036-39-sergey.kambalin@auriga.com>
 <20231203212905.1364036-40-sergey.kambalin@auriga.com>
 <20231203212905.1364036-41-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
 tests/qtest/bcm2838-mbox-property-test.c | 196 ++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index 80746dbb95..5322c563a0 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -49,7 +49,8 @@ FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)
                       (TEST_TAG_TYPE(testname) * tag);                         \
     static void CHECK_FN_NAME(testname, __VA_ARGS__)                           \
                              (TEST_TAG_TYPE(testname) *tag);                   \
-    static void TEST_FN_NAME(testname, __VA_ARGS__)(void) {                    \
+    static void TEST_FN_NAME(testname, __VA_ARGS__)(void)                      \
+    {                                                                          \
         struct {                                                               \
             MboxBufHeader header;                                              \
             TEST_TAG_TYPE(testname) tag;                                       \
@@ -188,6 +189,179 @@ DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, EMMC) {
 }
 
 /*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, UART) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UART);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_UART);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, UART) {
+    tag->request.value.clock_id = CLOCK_ID_UART;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, UART) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UART);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_UART);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, UART) {
+    tag->request.value.clock_id = CLOCK_ID_UART;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, UART) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UART);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_UART);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, UART) {
+    tag->request.value.clock_id = CLOCK_ID_UART;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, CORE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_CORE);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, CORE) {
+    tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, CORE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_CORE);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, CORE) {
+    tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, CORE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_CORE);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, CORE) {
+    tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, ANY) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UNDEFINED);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_ANY);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, ANY) {
+    tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, ANY) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UNDEFINED);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_ANY);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, ANY) {
+    tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, ANY) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UNDEFINED);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_ANY);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, ANY) {
+    tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_TEMPERATURE) {
+    g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
+    g_assert_cmpint(tag->response.value.temperature, ==, TEMPERATURE_SOC);
+}
+DECLARE_TEST_CASE_SETUP(GET_TEMPERATURE) {
+    tag->request.value.temperature_id = TEMPERATURE_ID_SOC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_TEMPERATURE) {
+    g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
+    g_assert_cmpint(tag->response.value.temperature, ==, TEMPERATURE_SOC_MAX);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_TEMPERATURE) {
+    tag->request.value.temperature_id = TEMPERATURE_ID_SOC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(ALLOCATE_BUFFER) {
+    g_assert_cmphex(tag->response.value.base, ==, VC_FB_BASE);
+    g_assert_cmphex(tag->response.value.size, ==, VC_FB_SIZE);
+}
+DECLARE_TEST_CASE_SETUP(ALLOCATE_BUFFER) {
+    tag->request.value.alignment = ALIGN_4K;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(RELEASE_FRAMEBUFFER) { 
+    /* No special checks are needed for this test */
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(BLANK_FRAMEBUFFER) {
+    g_assert_cmphex(tag->response.value.on, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(BLANK_FRAMEBUFFER) {
+    tag->request.value.on = 0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_PHYS_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.height, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_PHYS_WIDTH) {
+    tag->request.value.width = DUMMY_VALUE;
+    tag->request.value.height = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_PHYS_WIDTH, INITIAL) {
+    g_assert_cmpint(tag->response.value.width, ==, 640);
+    g_assert_cmpint(tag->response.value.height, ==, 480);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_PHYS_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, 800);
+    g_assert_cmpint(tag->response.value.height, ==, 600);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_PHYS_WIDTH) {
+    tag->request.value.width = 800;
+    tag->request.value.height = 600;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_VIRT_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.height, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_VIRT_WIDTH) {
+    tag->request.value.width = DUMMY_VALUE;
+    tag->request.value.height = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_VIRT_WIDTH, INITIAL) {
+    g_assert_cmpint(tag->response.value.width, ==, 640);
+    g_assert_cmpint(tag->response.value.height, ==, 480);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_VIRT_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, 800);
+    g_assert_cmpint(tag->response.value.height, ==, 600);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_VIRT_WIDTH) {
+    tag->request.value.width = 800;
+    tag->request.value.height = 600;
+}
+
+//==============================================================================
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -201,6 +375,26 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, EMMC);
     QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, EMMC);
     QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, EMMC);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, UART);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, UART);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, UART);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, CORE);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, CORE);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, CORE);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_TEMPERATURE);
+    QTEST_ADD_TEST_CASE(GET_MAX_TEMPERATURE);
+    QTEST_ADD_TEST_CASE(ALLOCATE_BUFFER);
+    QTEST_ADD_TEST_CASE(RELEASE_FRAMEBUFFER);
+    QTEST_ADD_TEST_CASE(BLANK_FRAMEBUFFER);
+    QTEST_ADD_TEST_CASE(TEST_FB_PHYS_WIDTH);
+    QTEST_ADD_TEST_CASE(GET_FB_PHYS_WIDTH, INITIAL);
+    QTEST_ADD_TEST_CASE(SET_FB_PHYS_WIDTH);
+    QTEST_ADD_TEST_CASE(TEST_FB_VIRT_WIDTH);
+    QTEST_ADD_TEST_CASE(GET_FB_VIRT_WIDTH, INITIAL);
+    QTEST_ADD_TEST_CASE(SET_FB_VIRT_WIDTH);
 
     return g_test_run();
 }
-- 
2.34.1


