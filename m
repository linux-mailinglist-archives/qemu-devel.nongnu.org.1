Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398F1802917
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w86-0000w5-Dq; Sun, 03 Dec 2023 18:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w7G-0007Xi-S0; Sun, 03 Dec 2023 18:43:15 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w7D-0002tt-Dn; Sun, 03 Dec 2023 18:43:13 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d3758fdd2eso34253827b3.0; 
 Sun, 03 Dec 2023 15:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646989; x=1702251789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIUscvz7pf1VFtRN5hHqsbtj5B7mCmCi2M+oBvF9ZJ8=;
 b=FyzCs/HXPxKB4yWFNBqH5cd14Z3fkw+DvRYn+m10/rpXzOcGVANS0Hm74URE5sEPMc
 1qOBRpBhw55DYxXPEwv8M5oKwn3dM1/9yQn+6Ilkq9cvBzQZ9d5Z37MZVXjMEan0FUQ3
 PJn6i92eySGA064Ai4HG/w605F7ntD39rlhZSkMaW2JBOCukexCDb1zwFb/QIsxha1K+
 VYul4ta6YOexIXFs2F23sOMLcXGvOHk5YiYJAT9GMm63c7ebtL95pqRNohNkpPJm386F
 PhBiKUXDfiK3YQr00D1tMc9Uj9y9EZcfR6782fLaMAeMphX0IeCjoiEk8LJyPI2YdAor
 O3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646989; x=1702251789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIUscvz7pf1VFtRN5hHqsbtj5B7mCmCi2M+oBvF9ZJ8=;
 b=EWnIkF4drId4RkfF6r7eD0Nfym4OpBG0loCd6BFnNGdZx923eL3S1ku4lbd/mYSH1j
 3bF3voTwiAPzwi+0PHX82Xv9R09j+zWUJvcEBr5R0LAddPulNqBpJhx9rFh6sZyL2UeL
 3XYJU447jGQu1f5yyq7AZS3ELg1RLQPPIgyct7F6j9xNFLFcQnLxSsiufufXfTzf0OnR
 wIt8qtf1ReiJG4Dv/el3qfcfRM6+6cz02W5T9uVpP6JopdBrzl6+xdhP2gXz2DJVuAje
 OcPJ+2IZI3QjCFSVH37fw+/+YeKPpFTuNWCNemdv9ROXqAH1Zm0v0DHuXZZYnEi8H2rk
 FHTg==
X-Gm-Message-State: AOJu0YxxYYBIsbh0Q6B3exVvoSGkC/rR13Z/N5yRti3XLB04dzhgUajV
 hqCIOtTQU0FS31dd7Lwe+by68jFDYme+7g==
X-Google-Smtp-Source: AGHT+IGZ7Y9qznJTtNQjV240djIjIGQ4lV0VQHFEp6w5fyh8adwqxhj/RM5jk41epKdpVrVNHPTyBw==
X-Received: by 2002:a81:b70c:0:b0:5d5:429d:bc73 with SMTP id
 v12-20020a81b70c000000b005d5429dbc73mr1585688ywh.8.1701646988743; 
 Sun, 03 Dec 2023 15:43:08 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:43:08 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 42/45] Add mailbox property tests. Part 3
Date: Sun,  3 Dec 2023 17:42:10 -0600
Message-Id: <20231203234213.1366214-43-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01, T_SCC_BODY_TEXT_LINE=-0.01,
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
 tests/qtest/bcm2838-mbox-property-test.c | 213 ++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index 5322c563a0..1b4a2ed9cb 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -361,7 +361,194 @@ DECLARE_TEST_CASE_SETUP(SET_FB_VIRT_WIDTH) {
     tag->request.value.height = 600;
 }
 
-//==============================================================================
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_DEPTH) {
+    tag->request.value.bpp = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, 16);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, 24);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_DEPTH) {
+    tag->request.value.bpp = 24;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_PIXEL_ORDER) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_PIXEL_ORDER) {
+    tag->request.value.pixel_order = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_PIXEL_ORDER) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_RGB);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_PIXEL_ORDER, BGR) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_BGR);
+}
+DECLARE_TEST_CASE_SETUP(SET_PIXEL_ORDER, BGR) {
+    tag->request.value.pixel_order = PIXEL_ORDER_BGR;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_PIXEL_ORDER, RGB) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_BGR);
+}
+DECLARE_TEST_CASE_SETUP(SET_PIXEL_ORDER, RGB) {
+    tag->request.value.pixel_order = PIXEL_ORDER_BGR;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_ALPHA_MODE) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_ALPHA_MODE) {
+    tag->request.value.alpha_mode = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_ALPHA_MODE) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_IGNORED);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_ALPHA_MODE, ENABLED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_ENABLED);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_ALPHA_MODE, ENABLED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_ENABLED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_ALPHA_MODE, REVERSED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_REVERSED);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_ALPHA_MODE, REVERSED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_REVERSED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_ALPHA_MODE, IGNORED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_IGNORED);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_ALPHA_MODE, IGNORED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_IGNORED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_PITCH) {
+    g_assert_cmpint(tag->response.value.pitch, ==, 1280);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_VIRTUAL_OFFSET) {
+    g_assert_cmpint(tag->response.value.x, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.y, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_VIRTUAL_OFFSET) {
+    tag->request.value.x = DUMMY_VALUE;
+    tag->request.value.y = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_VIRTUAL_OFFSET) {
+    g_assert_cmpint(tag->response.value.x, ==, 0);
+    g_assert_cmpint(tag->response.value.y, ==, 0);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_VIRTUAL_OFFSET, _0_) {
+    g_assert_cmpint(tag->response.value.x, ==, 0);
+    g_assert_cmpint(tag->response.value.y, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_VIRTUAL_OFFSET, _0_) {
+    tag->request.value.x = 0;
+    tag->request.value.y = 0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_VIRTUAL_OFFSET, _42_) {
+    g_assert_cmpint(tag->response.value.x, ==, 42);
+    g_assert_cmpint(tag->response.value.y, ==, 42);
+}
+DECLARE_TEST_CASE_SETUP(SET_VIRTUAL_OFFSET, _42_) {
+    tag->request.value.x = 42;
+    tag->request.value.y = 42;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(TEST_OVERSCAN) {
+    tag->request.value.top = DUMMY_VALUE;
+    tag->request.value.bottom = DUMMY_VALUE;
+    tag->request.value.left = DUMMY_VALUE;
+    tag->request.value.right = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_OVERSCAN) {
+    tag->request.value.top = DUMMY_VALUE;
+    tag->request.value.bottom = DUMMY_VALUE;
+    tag->request.value.left = DUMMY_VALUE;
+    tag->request.value.right = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_DMA_CHANNELS) {
+    g_assert_cmphex(tag->response.value.mask, ==, GPIO_MASK);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_COMMANDLINE) {
+    /* No special checks are needed for this test case */
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_NUM_DISPLAYS) {
+    g_assert_cmpint(tag->response.value.num_displays, ==, 1);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_PITCH) {
+    /* No special checks are needed for this test case */
+}
+DECLARE_TEST_CASE_SETUP(SET_PITCH) {
+    tag->request.value.pitch = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -395,6 +582,30 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(TEST_FB_VIRT_WIDTH);
     QTEST_ADD_TEST_CASE(GET_FB_VIRT_WIDTH, INITIAL);
     QTEST_ADD_TEST_CASE(SET_FB_VIRT_WIDTH);
+    QTEST_ADD_TEST_CASE(TEST_FB_DEPTH);
+    QTEST_ADD_TEST_CASE(GET_FB_DEPTH);
+    QTEST_ADD_TEST_CASE(SET_FB_DEPTH);
+    QTEST_ADD_TEST_CASE(TEST_PIXEL_ORDER);
+    QTEST_ADD_TEST_CASE(GET_PIXEL_ORDER);
+    QTEST_ADD_TEST_CASE(SET_PIXEL_ORDER, BGR);
+    QTEST_ADD_TEST_CASE(SET_PIXEL_ORDER, RGB);
+    QTEST_ADD_TEST_CASE(TEST_FB_ALPHA_MODE);
+    QTEST_ADD_TEST_CASE(GET_FB_ALPHA_MODE);
+    QTEST_ADD_TEST_CASE(SET_FB_ALPHA_MODE, ENABLED);
+    QTEST_ADD_TEST_CASE(SET_FB_ALPHA_MODE, REVERSED);
+    QTEST_ADD_TEST_CASE(SET_FB_ALPHA_MODE, IGNORED);
+    QTEST_ADD_TEST_CASE(GET_PITCH);
+    QTEST_ADD_TEST_CASE(TEST_VIRTUAL_OFFSET);
+    QTEST_ADD_TEST_CASE(GET_VIRTUAL_OFFSET);
+    QTEST_ADD_TEST_CASE(SET_VIRTUAL_OFFSET, _0_);
+    QTEST_ADD_TEST_CASE(SET_VIRTUAL_OFFSET, _42_);
+    QTEST_ADD_TEST_CASE(GET_OVERSCAN);
+    QTEST_ADD_TEST_CASE(TEST_OVERSCAN);
+    QTEST_ADD_TEST_CASE(SET_OVERSCAN);
+    QTEST_ADD_TEST_CASE(GET_DMA_CHANNELS);
+    QTEST_ADD_TEST_CASE(GET_COMMANDLINE);
+    QTEST_ADD_TEST_CASE(GET_NUM_DISPLAYS);
+    QTEST_ADD_TEST_CASE(SET_PITCH);
 
     return g_test_run();
 }
-- 
2.34.1


