Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA0E763B25
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWy-0003Az-KS; Wed, 26 Jul 2023 09:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWu-00037X-6D; Wed, 26 Jul 2023 09:26:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWs-0003ZE-C6; Wed, 26 Jul 2023 09:26:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso10769931e87.1; 
 Wed, 26 Jul 2023 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377972; x=1690982772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRrMRV+CFBigMwjTTTsXu/HTvU2Dt2LGhRrw9yVZ8yI=;
 b=hPxBGb99+soQ6itx5+K5jQv7rhbUnIvyhor5naoy53gKCa3220bXrNqdzNj2tCfxng
 WnoR0nq/jNJGLq4+88wNRAjyNhJXz0zy3vzEDXTfumWpbYqrJMFrZ4fvflmtT73ppZhU
 sueCp4C6QmCF5sICFoxlT/m0bY6uwa6E9hbTOxR5GaFkG8sx2hiQdc8NqBi9iHmF0ze9
 SMFcTVDgiv7Z4tXfDWiPRrR0A6a7MQIKruEhmnxijxq0zaVMOdMZsbOEJxpZGhcqKAwZ
 dewPkCaPxJlEsCvbevhe2+aMFw29APvqtQ/qukOF3lB5L8ge0Vc/7Kdc0zztICiVyLLk
 9l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377972; x=1690982772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRrMRV+CFBigMwjTTTsXu/HTvU2Dt2LGhRrw9yVZ8yI=;
 b=Rt+afPxK7iqihf09I6xSdIQThQsTA6vjlmxJxykV8fDntG7YdTAJVbAVm1iL30R1rJ
 gdUnY5AEk6KuiauYVy2TFdBS9B1kcAKsCXTK0FdSeKnvcW+Yj3+MTf3SPhCKiZG6oePt
 wlqcYO5TH0R1/u50Gk7joyFblcxKnM1MXip7yeYSa7VdaJgXPKu5GEfMZlB1y3aX/SI3
 1lEwU841ZlZB05yt2H/ytclReZx4HZsmqPf9lBZuzf34yNBh77UklcpJ7SA5+vlIKq+8
 lFO4+E3BvFjafT7PlhmuezvJEJMjYSwf/xKuGlShsTlk3nS/IVSTOpl8fW70vTLC1UdB
 oVYg==
X-Gm-Message-State: ABy/qLbMl1vrUH6NaPYjh8YrDnuRCl2/NesAOyymwvA0IRz5hyADQXob
 D4vUCWXX+OAiijzTsO7IdDtYUc0FTVM=
X-Google-Smtp-Source: APBJJlHy2FgWW6RefU0YT/0cH68epV8O1t7TXRdTlUJ0qVBtdpu3i4JXdwLhBOFvSOB8L5qrQyQIrQ==
X-Received: by 2002:a05:6512:114b:b0:4f8:65ef:afcd with SMTP id
 m11-20020a056512114b00b004f865efafcdmr1540559lfg.17.1690377971928; 
 Wed, 26 Jul 2023 06:26:11 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:26:11 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 44/44] Append added properties to mailbox test
Date: Wed, 26 Jul 2023 16:25:12 +0300
Message-Id: <20230726132512.149618-45-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x129.google.com
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
 tests/qtest/bcm2838-mbox-property-test.c | 82 ++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index e833529a00..68e2b11db6 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -242,6 +242,12 @@ DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, ANY) {
     tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCKS) {
+    g_assert_cmphex(tag->response.value.root_clock, ==, CLOCK_ID_ROOT);
+    g_assert_cmphex(tag->response.value.arm_clock, ==, CLOCK_ID_ARM);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(GET_TEMPERATURE) {
     g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
@@ -508,11 +514,31 @@ DECLARE_TEST_CASE(GET_COMMANDLINE) {
     /* No special checks are needed for this test case */
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_THROTTLED) {
+    g_assert_cmpint(tag->response.value.throttled, ==, 0);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(GET_NUM_DISPLAYS) {
     g_assert_cmpint(tag->response.value.num_displays, ==, 1);
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_DISPLAY_SETTINGS) {
+    g_assert_cmpint(tag->response.value.display_num, ==, 0);
+    g_assert_cmpint(tag->response.value.phys_width, ==, 800);
+    g_assert_cmpint(tag->response.value.phys_height, ==, 600);
+    g_assert_cmpint(tag->response.value.bpp, ==, 32);
+    g_assert_cmpint(tag->response.value.pitch, ==, 32);
+    g_assert_cmpint(tag->response.value.virt_width, ==, 0);
+    g_assert_cmpint(tag->response.value.virt_height, ==, 0);
+    g_assert_cmpint(tag->response.value.virt_width_offset, ==, 0);
+    g_assert_cmpint(tag->response.value.virt_height_offset, ==, 0);
+    g_assert_cmphex(tag->response.value.fb_bus_address_lo, ==, 0x00000000);
+    g_assert_cmphex(tag->response.value.fb_bus_address_hi, ==, 0x00000000);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(SET_PITCH) {
     /* No special checks are needed for this test case */
@@ -521,6 +547,54 @@ DECLARE_TEST_CASE_SETUP(SET_PITCH) {
     tag->request.value.pitch = DUMMY_VALUE;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_GPIO_CONFIG) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+    g_assert_cmphex(tag->response.value.direction, ==, GPIO_DIRECTION_IN);
+    g_assert_cmphex(tag->response.value.polarity, ==, GPIO_POLARITY_LOW);
+    g_assert_cmphex(tag->response.value.term_en, ==, GPIO_TERMINATION_DISABLED);
+    g_assert_cmphex(tag->response.value.term_pull_up, ==, GPIO_TERMINATION_PULLUP_DISABLED);
+}
+DECLARE_TEST_CASE_SETUP(GET_GPIO_CONFIG) {
+    tag->request.value.gpio_num = GPIO_0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_GPIO_CONFIG) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_GPIO_CONFIG) {
+    tag->request.value.gpio_num = GPIO_0;
+    tag->request.value.direction = DUMMY_VALUE;
+    tag->request.value.polarity = DUMMY_VALUE;
+    tag->request.value.term_en = DUMMY_VALUE;
+    tag->request.value.term_pull_up = DUMMY_VALUE;
+    tag->request.value.state = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_GPIO_STATE) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+    g_assert_cmphex(tag->response.value.state, ==, GPIO_STATE_DOWN);
+}
+DECLARE_TEST_CASE_SETUP(GET_GPIO_STATE) {
+    tag->request.value.gpio_num = GPIO_0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_GPIO_STATE) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_GPIO_STATE) {
+    tag->request.value.gpio_num = GPIO_0;
+    tag->request.value.state = GPIO_STATE_DOWN;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(INITIALIZE_VCHIQ) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+
 /*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
@@ -544,6 +618,7 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, ANY);
     QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, ANY);
     QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_CLOCKS);
     QTEST_ADD_TEST_CASE(GET_TEMPERATURE);
     QTEST_ADD_TEST_CASE(GET_MAX_TEMPERATURE);
     QTEST_ADD_TEST_CASE(ALLOCATE_BUFFER);
@@ -577,8 +652,15 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(SET_OVERSCAN);
     QTEST_ADD_TEST_CASE(GET_DMA_CHANNELS);
     QTEST_ADD_TEST_CASE(GET_COMMANDLINE);
+    QTEST_ADD_TEST_CASE(GET_THROTTLED);
     QTEST_ADD_TEST_CASE(GET_NUM_DISPLAYS);
+    QTEST_ADD_TEST_CASE(GET_DISPLAY_SETTINGS);
     QTEST_ADD_TEST_CASE(SET_PITCH);
+    QTEST_ADD_TEST_CASE(GET_GPIO_CONFIG);
+    QTEST_ADD_TEST_CASE(SET_GPIO_CONFIG);
+    QTEST_ADD_TEST_CASE(GET_GPIO_STATE);
+    QTEST_ADD_TEST_CASE(SET_GPIO_STATE);
+    QTEST_ADD_TEST_CASE(INITIALIZE_VCHIQ);
 
     return g_test_run();
 }
-- 
2.34.1


