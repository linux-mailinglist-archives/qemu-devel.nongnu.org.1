Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF47D4376
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:48:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4dZ-0002tB-2X; Mon, 23 Oct 2023 19:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39wU3ZQYKChA9y9A87w44w1u.s426u2A-tuBu1343w3A.47w@flex--titusr.bounces.google.com>)
 id 1qv4dX-0002sU-2L
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:07 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39wU3ZQYKChA9y9A87w44w1u.s426u2A-tuBu1343w3A.47w@flex--titusr.bounces.google.com>)
 id 1qv4dV-0002ob-9Z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:06 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5abfa4c10c4so18806587b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698104823; x=1698709623; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=57kge/OAmHbKAwBdnvGQrFdCdcxs8q+3+0ck+IJJcuA=;
 b=gtvZ5onV9KpTHCG6lVIo0/lmHP2pa7FtBir0RUHjuJyNuh6Y+CDdo5KoUSVib1UWHo
 nFLLMlWccnKwvfx0Xpz2ftBh5O0HkelauiMulmT1YsxjGpM7MVwAPyJrxPeUTTrwDDwN
 7mm86OJ86CLRzKPCkLr/m4fcR+lixTsuPnAt+F6Q3zTkyA8CEDcZuePwOnXM4zNnuVIy
 B2M9bgs03p3/NOpLyJzLOt9OVE0Ds7RIsrtIYFfoEMPs4+8cLk089Vhd33+gVPi8nOSJ
 FzdgcJBrNAsU9gyj+SJZWhyK3w3PRCoEnApfVDljXS1k22L9mzhM6f26UvtFmPgPXpNU
 v6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104823; x=1698709623;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=57kge/OAmHbKAwBdnvGQrFdCdcxs8q+3+0ck+IJJcuA=;
 b=SA8DJ7ZUWa6bBYKL1Up5xUFDTXirCdIW7rG3Gmr8UWKmpk5298Ghiv0P0wND7vzL6d
 9cHIk7jptiOup4HwHdYDLpb0wOfVRdG7v1ZLuv3wbm1lm9fwRdCFQ+DDdgNwWr+uMqLO
 fSCkyXKQAcAFbKYLKT2BtfsaKXkK8nvDUiHJTF/dfRrty2thEMteUXk6IV+w+t//pm1J
 X3AmMa02J6wGWAJD/VvCOe4bJIFgZ1bWAIbKVp0LlNw2gu2DhAd/lvQrXdYh+cvslJrs
 KvGhBjEHFUNGvt+KBaxmBQ6Xp/mgcv+N1fs7aI1mxq8YOO7C1izWgMXuMenHK9XrOEx+
 KkaA==
X-Gm-Message-State: AOJu0YzalBDzjzqzw2wA+c2If0M5o5620db7nQiGO+p2rs1RmG7go4IZ
 mJI0XG5vWU+pBWHi+5oJBNwgB1rpdC4=
X-Google-Smtp-Source: AGHT+IGGoIFvDVK9amsstFW7sBHao9wiqaM0KtVi8dIvqpDa6XS9Vs3aOEfjCLZKcMYSLmO8DpQpLkiNrQo=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a0d:d486:0:b0:5a8:6162:b69 with SMTP id
 w128-20020a0dd486000000b005a861620b69mr239049ywd.3.1698104823542; Mon, 23 Oct
 2023 16:47:03 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:46:45 +0000
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Mime-Version: 1.0
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
X-Developer-Key: i=titusr@google.com; a=openpgp;
 fpr=228BD42BAD6A2BCD3865AEA6C41200175CD21E30
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=titusr@google.com;
 h=from:subject:message-id; bh=BnRnug81IWlhfXo1CDxHzzk6FRAPzK5+qz/WkzSPoe0=;
 b=owEB7QES/pANAwAKAcQSABdc0h4wAcsmYgBlNwXvuSFuqGcnlaTaTfBFDvySr3LmDWMp115W4
 fdzK3mqpYmJAbMEAAEKAB0WIQQii9QrrWorzThlrqbEEgAXXNIeMAUCZTcF7wAKCRDEEgAXXNIe
 MA+4C/kBS8SL7b7POdCA5lf94RC4aejgVt9daAZoEIGtuljrmRfswoT2yxlog3olz6AlVqAK7dl
 woeJxMwm0noxEp+t+4kcUWG4g4wakzPFxQ+s9xTdY9Y7LAXZQjTON4Y56N2kkY9zc2nAh9pr+Bt
 2RVIKRtFYvS030wfGyc7tTqtY6qg5hRJaejJx8RqG/PnFCIb6Q68xIQjek1S30eqVI2AYpRWRvU
 CQ8+xilT85sbrysCFGs38C6uw/aXugwtq2eVMmR1LMKYV/BMAHQkMhrOEauytakNS+jvnwSPT6m
 euYwdBY7LW8DRq3PysT6DaaMVHhpqO+eouqZBNqVl5kgpIsom8nGaM/i+cmn0Ar/XVCOwa0v4TJ
 XtLvwAVI06pOLgyT5tOi36XncrEPlew+eRKEJyo5vhUKK7EoF1uZnmDP6BGgOjDZWsv1kGZp2XL
 Sug3G+NwJ5TXGcb+UO7viHPqPVMdaPhhPIliKaVwzjinm1Gkcb/xDETXhN0uR6LQDZNPA=
X-Mailer: b4 0.12.2
Message-ID: <20231023-staging-pmbus-v3-v4-6-07a8cb7cd20a@google.com>
Subject: [PATCH v4 6/8] tests/qtest: add tests for ADM1266
From: titusr@google.com
To: philmd@linaro.org, minyard@acm.org
Cc: Titus Rwantare <titusr@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=39wU3ZQYKChA9y9A87w44w1u.s426u2A-tuBu1343w3A.47w@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

  The ADM1266 can have string fields written by the driver, so
  it's worth specifically testing.

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 tests/qtest/adm1266-test.c | 123 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build    |   1 +
 2 files changed, 124 insertions(+)

diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
new file mode 100644
index 0000000000..6431a21de6
--- /dev/null
+++ b/tests/qtest/adm1266-test.c
@@ -0,0 +1,123 @@
+/*
+ * Analog Devices ADM1266 Cascadable Super Sequencer with Margin Control and
+ * Fault Recording with PMBus
+ *
+ * Copyright 2022 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <math.h>
+#include "hw/i2c/pmbus_device.h"
+#include "libqtest-single.h"
+#include "libqos/qgraph.h"
+#include "libqos/i2c.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
+#include "qemu/bitops.h"
+
+#define TEST_ID "adm1266-test"
+#define TEST_ADDR (0x12)
+
+#define ADM1266_BLACKBOX_CONFIG                 0xD3
+#define ADM1266_PDIO_CONFIG                     0xD4
+#define ADM1266_READ_STATE                      0xD9
+#define ADM1266_READ_BLACKBOX                   0xDE
+#define ADM1266_SET_RTC                         0xDF
+#define ADM1266_GPIO_SYNC_CONFIGURATION         0xE1
+#define ADM1266_BLACKBOX_INFORMATION            0xE6
+#define ADM1266_PDIO_STATUS                     0xE9
+#define ADM1266_GPIO_STATUS                     0xEA
+
+/* Defaults */
+#define ADM1266_OPERATION_DEFAULT               0x80
+#define ADM1266_CAPABILITY_DEFAULT              0xA0
+#define ADM1266_CAPABILITY_NO_PEC               0x20
+#define ADM1266_PMBUS_REVISION_DEFAULT          0x22
+#define ADM1266_MFR_ID_DEFAULT                  "ADI"
+#define ADM1266_MFR_ID_DEFAULT_LEN              32
+#define ADM1266_MFR_MODEL_DEFAULT               "ADM1266-A1"
+#define ADM1266_MFR_MODEL_DEFAULT_LEN           32
+#define ADM1266_MFR_REVISION_DEFAULT            "25"
+#define ADM1266_MFR_REVISION_DEFAULT_LEN        8
+#define TEST_STRING_A                           "a sample"
+#define TEST_STRING_B                           "b sample"
+#define TEST_STRING_C                           "rev c"
+
+static void compare_string(QI2CDevice *i2cdev, uint8_t reg,
+                           const char *test_str)
+{
+    uint8_t len = i2c_get8(i2cdev, reg);
+    char i2c_str[SMBUS_DATA_MAX_LEN] = {0};
+
+    i2c_read_block(i2cdev, reg, (uint8_t *)i2c_str, len);
+    g_assert_cmpstr(i2c_str, ==, test_str);
+}
+
+static void write_and_compare_string(QI2CDevice *i2cdev, uint8_t reg,
+                                     const char *test_str, uint8_t len)
+{
+    char buf[SMBUS_DATA_MAX_LEN] = {0};
+    buf[0] = len;
+    strncpy(buf + 1, test_str, len);
+    i2c_write_block(i2cdev, reg, (uint8_t *)buf, len + 1);
+    compare_string(i2cdev, reg, test_str);
+}
+
+static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t i2c_value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_value = i2c_get8(i2cdev, PMBUS_OPERATION);
+    g_assert_cmphex(i2c_value, ==, ADM1266_OPERATION_DEFAULT);
+
+    i2c_value = i2c_get8(i2cdev, PMBUS_REVISION);
+    g_assert_cmphex(i2c_value, ==, ADM1266_PMBUS_REVISION_DEFAULT);
+
+    compare_string(i2cdev, PMBUS_MFR_ID, ADM1266_MFR_ID_DEFAULT);
+    compare_string(i2cdev, PMBUS_MFR_MODEL, ADM1266_MFR_MODEL_DEFAULT);
+    compare_string(i2cdev, PMBUS_MFR_REVISION, ADM1266_MFR_REVISION_DEFAULT);
+}
+
+/* test r/w registers */
+static void test_rw_regs(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    /* empty strings */
+    i2c_set8(i2cdev, PMBUS_MFR_ID, 0);
+    compare_string(i2cdev, PMBUS_MFR_ID, "");
+
+    i2c_set8(i2cdev, PMBUS_MFR_MODEL, 0);
+    compare_string(i2cdev, PMBUS_MFR_MODEL, "");
+
+    i2c_set8(i2cdev, PMBUS_MFR_REVISION, 0);
+    compare_string(i2cdev, PMBUS_MFR_REVISION, "");
+
+    /* test strings */
+    write_and_compare_string(i2cdev, PMBUS_MFR_ID, TEST_STRING_A,
+                             sizeof(TEST_STRING_A));
+    write_and_compare_string(i2cdev, PMBUS_MFR_ID, TEST_STRING_B,
+                             sizeof(TEST_STRING_B));
+    write_and_compare_string(i2cdev, PMBUS_MFR_ID, TEST_STRING_C,
+                             sizeof(TEST_STRING_C));
+}
+
+static void adm1266_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" TEST_ID ",address=0x12"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { TEST_ADDR });
+
+    qos_node_create_driver("adm1266", i2c_device_create);
+    qos_node_consumes("adm1266", "i2c-bus", &opts);
+
+    qos_add_test("test_defaults", "adm1266", test_defaults, NULL);
+    qos_add_test("test_rw_regs", "adm1266", test_rw_regs, NULL);
+}
+
+libqos_init(adm1266_register_nodes);
+
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d6022ebd64..7899537e78 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -241,6 +241,7 @@ qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
   'adm1272-test.c',
+  'adm1266-test.c',
   'ds1338-test.c',
   'e1000-test.c',
   'eepro100-test.c',

-- 
2.42.0.758.gaed0368e0e-goog


