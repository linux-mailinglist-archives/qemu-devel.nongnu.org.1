Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82E74B026
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiS-0006R1-UK; Fri, 07 Jul 2023 07:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiQ-00069S-5a; Fri, 07 Jul 2023 07:33:34 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiO-0006wJ-Dk; Fri, 07 Jul 2023 07:33:33 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b7474b0501so1632537a34.1; 
 Fri, 07 Jul 2023 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729611; x=1691321611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gmn37gxv2SzvBfqbi+VS7fh6apL5R/NleDuDc6XKW4Y=;
 b=rkmmcNNT1FEMGfKkrcUHKrIXOGemHoBjgm4vaU0Q+32ZQbFkfki5essbDMeR9f99G8
 ueoXOE+iXrfu9D7np1LeRQbNVu88uJqZ7OjpzdGmQ+zFM2o5K16SCqLXxaKaFUGWYias
 5SLcnTq9X6+RjpZUgsoAIYnpei50SQ97tCMadG4Ied0g7f9aBre1OaQdKTwoGSylcsrP
 zSAiptppV0ptHT0IRbv/lecz0ol3ptvJDGve1EIk8IvxUUXfWIMNB4v9x6ZphwUr8wvz
 NWjG9eHjoynZqvuLwhWBIGYGK+8DbiTJ6lxBnjSnilKj+MSoPHs+2QDVJPqG6y1M7H/8
 H4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729611; x=1691321611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gmn37gxv2SzvBfqbi+VS7fh6apL5R/NleDuDc6XKW4Y=;
 b=GF+xw/HunkIbz58F6uI0CmBxj4bgHfaZgvz3HWSz6jGfhg/j0dGJBk48QEEBGwo08S
 40j8H6eraNN51QPopFMaqcrebgy83HTFth6Ov0B+dArid4p1WA8D+8z8KTa37Gp8JeuI
 80W4MXQqLAFd1lJpHkFTbGMtlP1R6QCAgYEFSWckzOH5CL+N/oE12HingUdGHHTWJepO
 pb9ZSUT4hcpyVgiE0hAqMicPIDBR4FQAbQrU1h2nWpA4lTRkPdax7uONwF3SFHIXkHTR
 78nbQM1gUzqP2wb7RT5VsPf+5Kt9DZUacMJTXliJSlZ5G0XUYbhER7CjOshn1fmfko/H
 q8AA==
X-Gm-Message-State: ABy/qLZrJJwNwMzy4zDUu3T4KekNYj+N2QYTE0FgJBJ1ixcehjydZGPF
 2Lg/9WyQgfECQovasBQBJlDH5+GOgBE=
X-Google-Smtp-Source: APBJJlFC8aDQYZXn0fWUbRVcCiBYFnhj6LCBsv1u/2k8CM35nN+KEjNHaHYqGr5EaxSIbvB+hqS28Q==
X-Received: by 2002:a9d:7394:0:b0:6b8:778f:d67 with SMTP id
 j20-20020a9d7394000000b006b8778f0d67mr3542707otk.27.1688729610961; 
 Fri, 07 Jul 2023 04:33:30 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:30 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 51/60] tests/qtest: Add xscom tests for powernv10 machine
Date: Fri,  7 Jul 2023 08:30:59 -0300
Message-ID: <20230707113108.7145-52-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Add basic chip and core xscom tests for powernv10 machine, equivalent
to tests for powernv8 and 9.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230706053923.115003-3-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/qtest/pnv-xscom-test.c | 45 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index 2c46d5cf6d..8a5ac11037 100644
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
@@ -96,23 +108,36 @@ static void test_cfam_id(const void *data)
     (PNV_XSCOM_EX_CORE_BASE | ((uint64_t)(core) << 24))
 #define PNV_XSCOM_P9_EC_BASE(core) \
     ((uint64_t)(((core) & 0x1F) + 0x20) << 24)
+#define PNV_XSCOM_P10_EC_BASE(core) \
+    ((uint64_t)((((core) & ~0x3) + 0x20) << 24) + 0x20000 + \
+     (0x1000 << (3 - (core & 0x3))))
 
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
@@ -123,6 +148,8 @@ static void test_core(const void *data)
 
     if (chip->chip_type == PNV_CHIP_POWER9) {
         machine = "powernv9";
+    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+        machine = "powernv10";
     }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
-- 
2.41.0


