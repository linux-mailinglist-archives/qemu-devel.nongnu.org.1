Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB1749509
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHib-0003I3-JP; Thu, 06 Jul 2023 01:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHHiP-0003H3-D1; Thu, 06 Jul 2023 01:39:41 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHHiN-000406-LV; Thu, 06 Jul 2023 01:39:41 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-55767141512so180094a12.3; 
 Wed, 05 Jul 2023 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688621978; x=1691213978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGgC20QkcCf3g1w9sY8uAZa7WxFWNeCwEnhLGxQ6p/o=;
 b=JAOOsEgE1LyuZ205y6VFpZ+diCi1eJfzZqXnON7ork6ZVzORT0Sjmwk8qWVqaSv3R9
 OnKbHLibVzqoqUn2cMdlGw6dqg+iZO8N+bT8DsqdNEPwIeRYCXDKSLEqjUinJpHTFCzZ
 aY4dfJL7WX/DU3qpSkIgeiB4KRybevQ0Pk+q1ArvAPZJ7uYfdxCVeG05edi2kpHf1nKY
 K8wXxH9neS5YKmNUtgeIqP/X5nHp9HVu+v30w6sXTG6/o4JH5KIfIDtWd+0t6BpCWgk0
 gaeouXAQSy+W7sRWPl774afpE6WDNSflCNeWp8LGj2ovBI7sGxaHUf9Ugdsegi4f8CJc
 SZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688621978; x=1691213978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGgC20QkcCf3g1w9sY8uAZa7WxFWNeCwEnhLGxQ6p/o=;
 b=jECvwXO4vmQiNUI3DrwltOEZiTt5h+ehw2k0Uz3rmNXbQMAaGD8rpxSfHqTkvwp167
 zwoeKSLdy2p11YyFbQgRvZQtTT0Wg6FcUBYogJ1sM/eP0al0ZEZ4AWnqTAJVrwLaOV4m
 TFrUiRqLzj5ZhcRRyaN03G2rZT6+Nz1nN748fBWc+gs19J/BvvcJMxeZpFt04YO4jcTw
 s0fhTdhkcjRYLBk0Y8qK3N3QQnIJ/nXWoVba/i094vHN/lOd408IIlT0vJGDAOIVpDFg
 LbDC94QX6ChON2fhaN3DV01xiZSsQzTFuimZDzi2/EJpmy5cT/0xbWDH45k2jWGwMik4
 NLpQ==
X-Gm-Message-State: ABy/qLa6eywTAPadaJN/czeaGrC6wdah0Pb71XiPX+HDUKaH4mFZPr3p
 zN2L9Fhm8kdjRKTz6p/enBg=
X-Google-Smtp-Source: APBJJlGcDFmbS5F+d26+08R0P2IiPdXaDNT+gp5gsNxuo7YQ9VMox328Ztys789UamhBkz4VA0fqzQ==
X-Received: by 2002:a05:6a20:6598:b0:123:c3dc:2052 with SMTP id
 p24-20020a056a20659800b00123c3dc2052mr521192pzh.35.1688621977753; 
 Wed, 05 Jul 2023 22:39:37 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 ix10-20020a170902f80a00b001b3d8ac1b6bsm427764plb.212.2023.07.05.22.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 22:39:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 2/2] tests/qtest: Add xscom tests for powernv10 machine
Date: Thu,  6 Jul 2023 15:39:23 +1000
Message-Id: <20230706053923.115003-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706053923.115003-1-npiggin@gmail.com>
References: <20230706053923.115003-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

Add basic chip and core xscom tests for powernv10 machine, equivalent
to tests for powernv8 and 9.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/pnv-xscom-test.c | 44 ++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index 2c46d5cf6d..80903fa782 100644
--- a/tests/qtest/pnv-xscom-test.c
+++ b/tests/qtest/pnv-xscom-test.c
@@ -15,6 +15,7 @@ typedef enum PnvChipType {
     PNV_CHIP_POWER8,      /* AKA Venice */
     PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
+    PNV_CHIP_POWER10,
 } PnvChipType;
 
 typedef struct PnvChip {
@@ -46,13 +47,22 @@ static const PnvChip pnv_chips[] = {
         .cfam_id    = 0x220d104900008000ull,
         .first_core = 0x0,
     },
+    {
+        .chip_type  = PNV_CHIP_POWER10,
+        .cpu_model  = "POWER10",
+        .xscom_base = 0x000603fc00000000ull,
+        .cfam_id    = 0x120da04900008000ull,
+        .first_core = 0x0,
+    },
 };
 
 static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
 {
     uint64_t addr = chip->xscom_base;
 
-    if (chip->chip_type == PNV_CHIP_POWER9) {
+    if (chip->chip_type == PNV_CHIP_POWER10) {
+        addr |= ((uint64_t) pcba << 3);
+    } else if (chip->chip_type == PNV_CHIP_POWER9) {
         addr |= ((uint64_t) pcba << 3);
     } else {
         addr |= (((uint64_t) pcba << 4) & ~0xffull) |
@@ -82,6 +92,8 @@ static void test_cfam_id(const void *data)
 
     if (chip->chip_type == PNV_CHIP_POWER9) {
         machine = "powernv9";
+    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+        machine = "powernv10";
     }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
@@ -96,23 +108,35 @@ static void test_cfam_id(const void *data)
     (PNV_XSCOM_EX_CORE_BASE | ((uint64_t)(core) << 24))
 #define PNV_XSCOM_P9_EC_BASE(core) \
     ((uint64_t)(((core) & 0x1F) + 0x20) << 24)
+#define PNV_XSCOM_P10_EC_BASE(core) \
+    ((uint64_t)((((core) & ~0x3) + 0x20) << 24) + 0x20000 + (0x1000 << (3 - (core & 0x3))))
 
 #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
 
 static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 {
-    uint32_t first_core_dts0 = PNV_XSCOM_EX_DTS_RESULT0;
-    uint64_t dts0;
+    if (chip->chip_type == PNV_CHIP_POWER10) {
+        uint32_t first_core_thread_state =
+                 PNV_XSCOM_P10_EC_BASE(chip->first_core) + 0x412;
+        uint64_t thread_state;
+
+        thread_state = pnv_xscom_read(qts, chip, first_core_thread_state);
 
-    if (chip->chip_type != PNV_CHIP_POWER9) {
-        first_core_dts0 |= PNV_XSCOM_EX_BASE(chip->first_core);
+        g_assert_cmphex(thread_state, ==, 0);
     } else {
-        first_core_dts0 |= PNV_XSCOM_P9_EC_BASE(chip->first_core);
-    }
+        uint32_t first_core_dts0 = PNV_XSCOM_EX_DTS_RESULT0;
+        uint64_t dts0;
 
-    dts0 = pnv_xscom_read(qts, chip, first_core_dts0);
+        if (chip->chip_type == PNV_CHIP_POWER9) {
+            first_core_dts0 |= PNV_XSCOM_P9_EC_BASE(chip->first_core);
+        } else { /* POWER8 */
+            first_core_dts0 |= PNV_XSCOM_EX_BASE(chip->first_core);
+        }
 
-    g_assert_cmphex(dts0, ==, 0x26f024f023f0000ull);
+        dts0 = pnv_xscom_read(qts, chip, first_core_dts0);
+
+        g_assert_cmphex(dts0, ==, 0x26f024f023f0000ull);
+    }
 }
 
 static void test_core(const void *data)
@@ -123,6 +147,8 @@ static void test_core(const void *data)
 
     if (chip->chip_type == PNV_CHIP_POWER9) {
         machine = "powernv9";
+    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+        machine = "powernv10";
     }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
-- 
2.40.1


