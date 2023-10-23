Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8DF7D4374
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4db-0002v6-1e; Mon, 23 Oct 2023 19:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-QU3ZQYKChIB0BCA9y66y3w.u648w4C-vwDw3565y5C.69y@flex--titusr.bounces.google.com>)
 id 1qv4dZ-0002tv-Bt
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:09 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-QU3ZQYKChIB0BCA9y66y3w.u648w4C-vwDw3565y5C.69y@flex--titusr.bounces.google.com>)
 id 1qv4dX-0002pI-7G
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:09 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a818c1d2c7so55549857b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698104826; x=1698709626; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xq4TevC7P2TtGIT4OtRznC6qcO/COLeRy1+0zTFpX8g=;
 b=QSinNoxCcad1UFJtGBut1CFkz8mjJSy0c8UyB5VLh1O3Ej53ojcNsv7L7YRYtSqibL
 PDQrq7WiH6jx4rvJqcf84hslv4Fb1QYb48BimncRymoHY5UembjyttExB+ioxNw8oY2e
 US3js6e4wdXGQESjongGKoWWyaETrhUYXfeD4tgE4xwG9W77NdW9idxJFpVHgU5Il+FS
 OG24cSj1RkJ2y2XyZVp0X5aSVkkW/23A+eE0gUWAVR8IH9KR69M7lqiNuaYdOeUjfp4f
 E8ztBesQUHrz5lO98fnb3thTQSxpaLSxUBne8Lp6v4I/zAgsn2vJiPILWcV95pd7h1F8
 e7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104826; x=1698709626;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xq4TevC7P2TtGIT4OtRznC6qcO/COLeRy1+0zTFpX8g=;
 b=uIWo12BAl/zYiU4k2Fe44Dxmb3prPw4bxGwbfNYlWuKeHGb2TSfmSncRj2QW2sW37Z
 ktgPLOyzGcoENw1TokB/cMn+LmisXPWMRtfQuw2QzvOTGj20wxhfHowoV/Iu5xjEgI5g
 Utjb68FEELug7V7gOPIolQzOZ7BzKyC96/jlBMiQUxIIt45k/CkIe8VS+2aAZNqsTtfA
 pqx2W3Z4X85VLckTaJt3vmmiACT7nYWjo9AUrf3h6F6gYeE7zXgLRxn/kddBLoq31sb/
 9qtKI8BhGuNCnfx2esvKaCvBZ5xKq2wmf2M/lXaxeYmXjhyluDcolS2fpO//z8X0SNS5
 7Yuw==
X-Gm-Message-State: AOJu0YyD/wIQsjyEP5Bzrn1OpMTCiPJf0fb/xKMuzB770BOYw26aOpgl
 KzF4+VdfmFPZgzEbCRgytwy4NgPekhU=
X-Google-Smtp-Source: AGHT+IE5Qoy4GD6iSUUJIIoBZW66Km80SNORck09iqaqDKqvgncSvWU3fsQSoltdV7IvI6VIhnj9mzyRk9k=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a0d:dd10:0:b0:577:619e:d3c9 with SMTP id
 g16-20020a0ddd10000000b00577619ed3c9mr240924ywe.10.1698104825871; Mon, 23 Oct
 2023 16:47:05 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:46:47 +0000
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Mime-Version: 1.0
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
X-Developer-Key: i=titusr@google.com; a=openpgp;
 fpr=228BD42BAD6A2BCD3865AEA6C41200175CD21E30
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=titusr@google.com;
 h=from:subject:message-id; bh=QTYQxWNArHaP0YRgSOq+vqlTWsFPGoLjnzRsYLythkQ=;
 b=owEB7QES/pANAwAKAcQSABdc0h4wAcsmYgBlNwXvtpqY/8wjwqIskWGObaX37DnLW9ZJyUO0U
 V0gAfTzKjiJAbMEAAEKAB0WIQQii9QrrWorzThlrqbEEgAXXNIeMAUCZTcF7wAKCRDEEgAXXNIe
 MDpxC/9BC7/rJztqqTG/tbhYlyeH5h3j3AsvCP7aViP7S0rlOs30LSqs16KW7rY4YVePkyBaUOK
 HKVTPLu88k6ygeDyMnYbJA2iECJLSRddCUdPFZ8peChF4kuBx+12/wQgGaMtOO1MpCqse2OfvoC
 K9ZVsYX4o3AIeFLFe5Kxch6rGSMNwb/cwP2F9BtcWQqzDsN0b7KPX9DLzJkNn7KI1OgeyVhtl11
 mZqwSU7BTJc2mCKb/olsYCLTOd7fkV59Hs7PcW9GJvUNQSI0otmireZTSWn34eEN4ZLNY9yuDIO
 3Dp7oDpEiFH3VVoqXV+zk7DpyaQ5sPTA2zWo1VFNn/pr/L/kjM4qJJYSPBe+/JososQmp2PrIM1
 KuLCUIQpjUl6rtKSj6yhihEXCoZ1rfNNaqxmK3slnPgm3k430RV+TB04kUcU1gLOsy3BPts5nzA
 vsXqMRLAb2U9Pfelbzihly47VwR8d5CWxAPqiEY6mUO84leKFrHGZWE+BT8tc2jwyhR/s=
X-Mailer: b4 0.12.2
Message-ID: <20231023-staging-pmbus-v3-v4-8-07a8cb7cd20a@google.com>
Subject: [PATCH v4 8/8] hw/i2c: pmbus: reset page register for out of range
 reads
From: titusr@google.com
To: philmd@linaro.org, minyard@acm.org
Cc: Titus Rwantare <titusr@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3-QU3ZQYKChIB0BCA9y66y3w.u648w4C-vwDw3565y5C.69y@flex--titusr.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
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


