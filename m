Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31292807E11
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 02:43:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB3P0-0005Y0-Dz; Wed, 06 Dec 2023 20:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rB3Ow-0005Xs-L7
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 20:42:06 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rB3Ou-0005Kn-SE
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 20:42:06 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b9d029b9bbso240962b6e.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 17:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701913324; x=1702518124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxB4u6iXyAjHiZmyMCxouWpcKxw7TMoA0aLedTAWAQA=;
 b=hhd0T+ANW5n4vrEOdJdYlSk3PxIlO57dkiQKmz43dtZEKZTiafssBxN49PZp5oJjPX
 5TuMCdXrYv6TEBwqHO9JXsb5FWK89HOyDj1tYT8EYU+7G1y4HDLAlVLZDrszUMq7fway
 /40fl+A0NCE1gqdz3nglfrMBFFt5wlKas6f2ikeZi9p2vhYXz4tOYZUO5oR0kVXGS5LB
 05hv91Nl1YeGOET8nqBKCWOLEMZwm0xrJK4GnCWbT+ysjNdwNlkM4ygcw064yYc6IZHN
 LwmXO6v1/vdb1vHiaelCFR9Z4CxNqCQ2WEQ8XgCiH/ps2nUgNkwCXpmdxb9EZVU1rSqW
 AErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701913324; x=1702518124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hxB4u6iXyAjHiZmyMCxouWpcKxw7TMoA0aLedTAWAQA=;
 b=Dp4H2ZpWmj5KdgjocGLP38snQ/BlwjdfcN5D8bpNtK9ChFfiozfIPE6t41c7stgYOF
 AS/G1qhIK/NT7EVzXRXeB4H0NNa3RF92wUCC6wkGVvje7ZSa1YGa/xU0xx+h+FG+Kkkb
 hCpC7tBfr4Fi8hKxcmh8IfUKsFDCFcsNbmzSFQyJb7l7r7oYrcP8BxqGT0flTm3aJYkD
 RNg5iUA7TYFpxStv3pxFEV+wxOzbCmsqlJy9K3UTxc2KEwMPqjiiSliT05i9rSBPlXJc
 gKREk9FanW9OUpUk7d42KoSOZfa1chyLguFKQT1ym4//qRh2yBjrzJ7/GevcgLXx22Sd
 PiAg==
X-Gm-Message-State: AOJu0Yw4muV6bc3VAM/Yt7Wr6ZLKLtD3EIZX2/RScB2+XKdxqRKGRc/d
 /aqdEwWP/ozihwxQJNkdfA==
X-Google-Smtp-Source: AGHT+IFLgEPNRJG6QWb+mxoeSUKILu/jNVQ+rd8T80r+YrgewqnfwhuGDMxyqNBNjCR5g4l6Drh5mg==
X-Received: by 2002:a05:6808:1208:b0:3b8:98f0:3c6 with SMTP id
 a8-20020a056808120800b003b898f003c6mr1037003oil.14.1701913323758; 
 Wed, 06 Dec 2023 17:42:03 -0800 (PST)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 8-20020aca1008000000b003ae3768ba4csm54652oiq.58.2023.12.06.17.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 17:42:02 -0800 (PST)
Received: from dell1.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8ff4:f8fd:ca3:53c6])
 by serve.minyard.net (Postfix) with ESMTPA id 674CB1800C1;
 Thu,  7 Dec 2023 01:42:02 +0000 (UTC)
From: minyard@acm.org
To: qemu-devel@nongnu.org
Cc: Potin Lai <potin.lai.pt@gmail.com>, Patrick Venture <venture@google.com>,
 Hao Wu <wuhaotsh@google.com>, Titus Rwantare <titusr@google.com>,
 Chris Rauer <crauer@google.com>, Corey Minyard <cminyard@mvista.com>
Subject: [PULL 1/2] hw/sensor: enable setting adm1272 temperature with qmp
Date: Wed,  6 Dec 2023 19:41:47 -0600
Message-Id: <20231207014148.3116889-2-minyard@acm.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207014148.3116889-1-minyard@acm.org>
References: <20231207014148.3116889-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Titus Rwantare <titusr@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Chris Rauer <crauer@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
Message-Id: <20220106173814.3580141-1-venture@google.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/sensor/adm1272.c        | 27 ++++++++++++++++++++++++++-
 tests/qtest/adm1272-test.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 8f4a1c2cd4..6e5ae6e63b 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -65,6 +65,7 @@
 #define ADM1272_VOLTAGE_COEFF_DEFAULT   1
 #define ADM1272_CURRENT_COEFF_DEFAULT   3
 #define ADM1272_PWR_COEFF_DEFAULT       7
+#define ADM1272_TEMP_COEFF_DEFAULT      8
 #define ADM1272_IOUT_OFFSET             0x5000
 #define ADM1272_IOUT_OFFSET             0x5000
 
@@ -185,6 +186,22 @@ static uint32_t adm1272_direct_to_watts(uint16_t value)
     return pmbus_direct_mode2data(c, value);
 }
 
+static uint16_t adm1272_millidegrees_to_direct(uint32_t value)
+{
+    PMBusCoefficients c = adm1272_coefficients[ADM1272_TEMP_COEFF_DEFAULT];
+    c.b = c.b * 1000;
+    c.R = c.R - 3;
+    return pmbus_data2direct_mode(c, value);
+}
+
+static uint32_t adm1272_direct_to_millidegrees(uint16_t value)
+{
+    PMBusCoefficients c = adm1272_coefficients[ADM1272_TEMP_COEFF_DEFAULT];
+    c.b = c.b * 1000;
+    c.R = c.R - 3;
+    return pmbus_direct_mode2data(c, value);
+}
+
 static void adm1272_exit_reset(Object *obj)
 {
     ADM1272State *s = ADM1272(obj);
@@ -219,7 +236,7 @@ static void adm1272_exit_reset(Object *obj)
         = adm1272_millivolts_to_direct(ADM1272_VOLT_DEFAULT);
     pmdev->pages[0].read_iout
         = adm1272_milliamps_to_direct(ADM1272_IOUT_DEFAULT);
-    pmdev->pages[0].read_temperature_1 = 0;
+    pmdev->pages[0].read_temperature_1 = adm1272_millidegrees_to_direct(30000);
     pmdev->pages[0].read_pin = adm1272_watts_to_direct(ADM1272_PWR_DEFAULT);
     pmdev->pages[0].revision = ADM1272_PMBUS_REVISION_DEFAULT;
     pmdev->pages[0].mfr_id = ADM1272_MFR_ID_DEFAULT;
@@ -422,6 +439,8 @@ static void adm1272_get(Object *obj, Visitor *v, const char *name, void *opaque,
         value = adm1272_direct_to_milliamps(*(uint16_t *)opaque);
     } else if (strcmp(name, "pin") == 0) {
         value = adm1272_direct_to_watts(*(uint16_t *)opaque);
+    } else if (strcmp(name, "temperature") == 0) {
+        value = adm1272_direct_to_millidegrees(*(uint16_t *)opaque);
     } else {
         value = *(uint16_t *)opaque;
     }
@@ -446,6 +465,8 @@ static void adm1272_set(Object *obj, Visitor *v, const char *name, void *opaque,
         *internal = adm1272_milliamps_to_direct(value);
     } else if (strcmp(name, "pin") == 0) {
         *internal = adm1272_watts_to_direct(value);
+    } else if (strcmp(name, "temperature") == 0) {
+        *internal = adm1272_millidegrees_to_direct(value);
     } else {
         *internal = value;
     }
@@ -509,6 +530,10 @@ static void adm1272_init(Object *obj)
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_pin);
 
+    object_property_add(obj, "temperature", "uint16",
+                        adm1272_get,
+                        adm1272_set, NULL, &pmdev->pages[0].read_temperature_1);
+
 }
 
 static void adm1272_class_init(ObjectClass *klass, void *data)
diff --git a/tests/qtest/adm1272-test.c b/tests/qtest/adm1272-test.c
index 63f8514801..98134aabd2 100644
--- a/tests/qtest/adm1272-test.c
+++ b/tests/qtest/adm1272-test.c
@@ -65,6 +65,7 @@
 #define ADM1272_VOLTAGE_COEFF_DEFAULT   1
 #define ADM1272_CURRENT_COEFF_DEFAULT   3
 #define ADM1272_PWR_COEFF_DEFAULT       7
+#define ADM1272_TEMP_COEFF_DEFAULT      8
 #define ADM1272_IOUT_OFFSET             0x5000
 #define ADM1272_IOUT_OFFSET             0x5000
 
@@ -144,6 +145,22 @@ static uint32_t adm1272_direct_to_watts(uint16_t value)
     return pmbus_direct_mode2data(c, value);
 }
 
+static uint16_t adm1272_millidegrees_to_direct(uint32_t value)
+{
+    PMBusCoefficients c = adm1272_coefficients[ADM1272_TEMP_COEFF_DEFAULT];
+    c.b = c.b * 1000;
+    c.R = c.R - 3;
+    return pmbus_data2direct_mode(c, value);
+}
+
+static uint32_t adm1272_direct_to_millidegrees(uint16_t value)
+{
+    PMBusCoefficients c = adm1272_coefficients[ADM1272_TEMP_COEFF_DEFAULT];
+    c.b = c.b * 1000;
+    c.R = c.R - 3;
+    return pmbus_direct_mode2data(c, value);
+}
+
 static uint16_t qmp_adm1272_get(const char *id, const char *property)
 {
     QDict *response;
@@ -248,7 +265,7 @@ static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 /* test qmp access */
 static void test_tx_rx(void *obj, void *data, QGuestAllocator *alloc)
 {
-    uint16_t i2c_value, value, i2c_voltage, i2c_pwr, lossy_value;
+    uint16_t i2c_value, value, i2c_voltage, i2c_pwr, i2c_temp, lossy_value;
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
 
     /* converting to direct mode is lossy - we generate the same loss here */
@@ -287,6 +304,15 @@ static void test_tx_rx(void *obj, void *data, QGuestAllocator *alloc)
     i2c_pwr = adm1272_direct_to_watts(i2c_value);
     g_assert_cmphex(value, ==, i2c_pwr);
     g_assert_cmphex(i2c_pwr, ==, lossy_value);
+
+    lossy_value =
+        adm1272_direct_to_millidegrees(adm1272_millidegrees_to_direct(25000));
+    qmp_adm1272_set(TEST_ID, "temperature", 25000);
+    value = qmp_adm1272_get(TEST_ID, "temperature");
+    i2c_value = adm1272_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE_1);
+    i2c_temp = adm1272_direct_to_millidegrees(i2c_value);
+    g_assert_cmphex(value, ==, i2c_temp);
+    g_assert_cmphex(i2c_temp, ==, lossy_value);
 }
 
 /* test r/w registers */
-- 
2.34.1


