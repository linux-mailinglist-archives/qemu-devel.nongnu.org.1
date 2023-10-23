Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A27D3EA7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMZ-0005TK-4a; Mon, 23 Oct 2023 14:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xbY2ZQYKCj4ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1quzMW-0005QB-Dr
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:12 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xbY2ZQYKCj4ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1quzMU-00071E-Ec
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:12 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a8ebc70d33so45190887b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084549; x=1698689349; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tr6BqDILaxbn7Hhg/79zBHPldU+oVgC3RO+BYZpqcOE=;
 b=VTlrvUwXsUqvjPovrdpyyAJqSJKOI924WMtT0EDqGwHARrneLIXcxJ85AwESAmHnp5
 d88It1kRr17K2NcT5td2+8PEFpygeHjVrrB6u7qE2Be6amZiwl0Q/d8b3mqEH4RmUe8/
 wx8XQ346fnWA3nWugDjPb1ayAFGDFB+mtu2f3A+U15jL8enTvgzQpBI7oWI2GaCWfKp7
 tfWOunO8yzZfXTF58L5iLvGu7cFPK/yPdHtLJ6Rjlvo4t+4vg8blqbkFr/77t/1mo7oU
 wjvuC1EDvul9s2Asg7BQVZ2cN2dZBmGrnWC9EQbMVcZQB9cCEUww4FKfP42MAcBPalOG
 CKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084549; x=1698689349;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tr6BqDILaxbn7Hhg/79zBHPldU+oVgC3RO+BYZpqcOE=;
 b=hRgSIXac0PZWIxTaTCUwYq7FzKiBjhZnEb+X2qt1+9M+06V4tEueonvHYlgbA5e05G
 /VotsToTYc4D1+okaWtQCK8tm4IstoAyjhMq4Ul/OST3vKspGFpX5NG5ANJRo5qakSWB
 p9sJTfIMfGnX8e+VQ4BmK3YjVkIDuaH9YOOZyiV1W1hWGcLmKLVTuJFRu74c2w0Huo8b
 9dTesElc8S86wpoPMYlwdo+YGUsITYERHl3mGsv3o+Tf0InEjdbIlvcEXStMKHNWxn6P
 XlyHfemjDUVzWbjpwVfMpEDCsg9aubgTvzyAeIZaip5Bmaapwr4tiJl62TJiwr24f5Hu
 GxzQ==
X-Gm-Message-State: AOJu0Yy7KGOi4CJGRT73cYdN9jxIg83I7Ts1dzcqaEfr0EYBLV9eA5Uh
 aYDOrohF77RD+vY2VpQJG19q0oP19hw=
X-Google-Smtp-Source: AGHT+IFTGU2ylOZsJJs271UfERTgOcZotBMTZymeHbxZZpAw1sHjeo841WrsvwlBnAL0rw2GCjKpNHXGQYY=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a0d:d50f:0:b0:5a7:ba09:44b6 with SMTP id
 x15-20020a0dd50f000000b005a7ba0944b6mr213630ywd.0.1698084549313; Mon, 23 Oct
 2023 11:09:09 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:37 +0000
In-Reply-To: <20231023180837.91785-1-titusr@google.com>
Mime-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-9-titusr@google.com>
Subject: [PATCH v3 8/8] hw/i2c: pmbus: reset page register for out of range
 reads
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3xbY2ZQYKCj4ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The linux pmbus driver scans all possible pages and does not reset the
current page after the scan, making all future page reads fail as out of range
on devices with a single page.

This change resets out of range pages immediately on write.

Also added a qtest for simultaneous writes to all pages.

Signed-off-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 hw/i2c/pmbus_device.c       | 18 +++++++++---------
 tests/qtest/max34451-test.c | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 481e158380..1b978e588f 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1255,6 +1255,15 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
 
     if (pmdev->code == PMBUS_PAGE) {
         pmdev->page = pmbus_receive8(pmdev);
+
+        if (pmdev->page > pmdev->num_pages - 1 && pmdev->page != PB_ALL_PAGES) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: page %u is out of range\n",
+                          __func__, pmdev->page);
+            pmdev->page = 0; /* undefined behaviour - reset to page 0 */
+            pmbus_cml_error(pmdev);
+            return PMBUS_ERR_BYTE;
+        }
         return 0;
     }
 
@@ -1268,15 +1277,6 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
         return 0;
     }
 
-    if (pmdev->page > pmdev->num_pages - 1) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                        "%s: page %u is out of range\n",
-                        __func__, pmdev->page);
-        pmdev->page = 0; /* undefined behaviour - reset to page 0 */
-        pmbus_cml_error(pmdev);
-        return PMBUS_ERR_BYTE;
-    }
-
     index = pmdev->page;
 
     switch (pmdev->code) {
diff --git a/tests/qtest/max34451-test.c b/tests/qtest/max34451-test.c
index 0c98d0764c..dbf6ddc829 100644
--- a/tests/qtest/max34451-test.c
+++ b/tests/qtest/max34451-test.c
@@ -18,6 +18,7 @@
 #define TEST_ID "max34451-test"
 #define TEST_ADDR (0x4e)
 
+#define MAX34451_MFR_MODE               0xD1
 #define MAX34451_MFR_VOUT_PEAK          0xD4
 #define MAX34451_MFR_IOUT_PEAK          0xD5
 #define MAX34451_MFR_TEMPERATURE_PEAK   0xD6
@@ -315,6 +316,28 @@ static void test_ot_faults(void *obj, void *data, QGuestAllocator *alloc)
     }
 }
 
+#define RAND_ON_OFF_CONFIG  0x12
+#define RAND_MFR_MODE       0x3456
+
+/* test writes to all pages */
+static void test_all_pages(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t i2c_value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, PMBUS_PAGE, PB_ALL_PAGES);
+    i2c_set8(i2cdev, PMBUS_ON_OFF_CONFIG, RAND_ON_OFF_CONFIG);
+    max34451_i2c_set16(i2cdev, MAX34451_MFR_MODE, RAND_MFR_MODE);
+
+    for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES + MAX34451_NUM_PWR_DEVICES;
+         i++) {
+        i2c_value = i2c_get8(i2cdev, PMBUS_ON_OFF_CONFIG);
+        g_assert_cmphex(i2c_value, ==, RAND_ON_OFF_CONFIG);
+        i2c_value = max34451_i2c_get16(i2cdev, MAX34451_MFR_MODE);
+        g_assert_cmphex(i2c_value, ==, RAND_MFR_MODE);
+    }
+}
+
 static void max34451_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -332,5 +355,6 @@ static void max34451_register_nodes(void)
     qos_add_test("test_ro_regs", "max34451", test_ro_regs, NULL);
     qos_add_test("test_ov_faults", "max34451", test_ov_faults, NULL);
     qos_add_test("test_ot_faults", "max34451", test_ot_faults, NULL);
+    qos_add_test("test_all_pages", "max34451", test_all_pages, NULL);
 }
 libqos_init(max34451_register_nodes);
-- 
2.42.0.758.gaed0368e0e-goog


