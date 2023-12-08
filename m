Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E08809953
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQgx-0008W4-J7; Thu, 07 Dec 2023 21:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgm-00084y-16; Thu, 07 Dec 2023 21:34:04 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgj-0002lF-Ps; Thu, 07 Dec 2023 21:34:03 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cb21afa6c1so1425041fa.0; 
 Thu, 07 Dec 2023 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002839; x=1702607639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uN6I/0hgCFTTQOiKlRUms5E1PdG9Gf9E46rNDtv+HU=;
 b=EW09TejClzsqXLwGwblfVRs+XN12myQq0PS+NLZ68ak9Elc7hXWUs6Z975HlXqBWI5
 w8fls3Gw/wJnuE76BlpnXKhQkQCtIMfD4wXitg42Lyi5XrK6CsEFuWijmcYj74fIZM91
 NO6O6t8wlgTvzJprsd8rxEi0X9mrvsxAahSzwwapqRo/hkgG2An9bKaCVJbd5HhbAPwS
 FoIKIZSF9t2D1CX4VI0bmyl2bhHfSd4PLyPApUAvil3oXttYyDJ7QAWmjAnRW3lDGqYY
 eqhIVmWhqPIl7M3DY75jBY6jRBXKWfnSXrjxICHhDA/RAN6vjdDOnBrTfgn7k/LVmAYB
 SSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002839; x=1702607639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uN6I/0hgCFTTQOiKlRUms5E1PdG9Gf9E46rNDtv+HU=;
 b=poWYcGIPrJ4JHPVwPumuLzrNEtr4+85i9AM9VgwBvS+HrDU0rcCujMIjC3yTLpm675
 YspkXM8RTxh4pNlDS0rimiR66IrM9RPdSxenZfe9dHQQgr9/tnKmqTxiOnpZu26hRlnE
 5Cxl+pkTJ6B1bF2tIW/+19ZqeJWGNvBT6a2Az+vMuLcOU3Rnni4sqsP1Iwhi1nePIxll
 oCSqZIIxloNSnLZQS75p2QRfwi1A48C5KNSv/cZAEfsp1czOD+R8PGJpjp7HizKVaOo5
 k3FiLJ0erWSAfQqTcmvBovxJfHAUnt0ZDQFY8wz62oAavlK0EhiX5UCzP7G3US79gvFM
 ptwA==
X-Gm-Message-State: AOJu0Yx55XszWMeEHyGUmznwupiN1sOctFyAD9DKHiqyOkIzOY/CiqHT
 UF+xGErBjy84btYumczNM6ZjSO+JHwcviw==
X-Google-Smtp-Source: AGHT+IE3w/Jp3FZQdG6FZLpUjwQRmWsD19UqAvB4Qkb9cvZhRCefp7/xcbXpQ/rOS2TGZ4ccbaLRFg==
X-Received: by 2002:a2e:998c:0:b0:2c9:fc43:2b6c with SMTP id
 w12-20020a2e998c000000b002c9fc432b6cmr2433478lji.104.1702002839106; 
 Thu, 07 Dec 2023 18:33:59 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:33:57 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 35/45] Add mailbox test stub
Date: Thu,  7 Dec 2023 20:31:35 -0600
Message-Id: <20231208023145.1385775-36-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x234.google.com
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
 include/hw/arm/bcm2838_peripherals.h |  2 +
 tests/qtest/bcm2838-mailbox.c        | 71 ++++++++++++++++++++++++++++
 tests/qtest/bcm2838-mailbox.h        | 46 ++++++++++++++++++
 tests/qtest/meson.build              |  1 +
 4 files changed, 120 insertions(+)
 create mode 100644 tests/qtest/bcm2838-mailbox.c
 create mode 100644 tests/qtest/bcm2838-mailbox.h

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index cdeb892f04..2b97e55048 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -56,6 +56,8 @@
 #define BCM2838_MPHI_OFFSET     0xb200
 #define BCM2838_MPHI_SIZE       0x200
 
+#define GENET_OFFSET            0x1580000
+
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
                     BCM2838_PERIPHERALS)
diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
new file mode 100644
index 0000000000..2edc24e15e
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -0,0 +1,71 @@
+/*
+ * Helper functions to work with BCM2838 mailbox via qtest interface.
+ *
+ * Copyright (c) 2023 Auriga LLC
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
+
+static uint32_t qtest_mbox0_read_reg32(QTestState *s, uint32_t offset)
+{
+    return qtest_readl(s, MBOX0_BASE + offset);
+}
+
+static void qtest_mbox1_write_reg32(QTestState *s, uint32_t offset, uint32_t value)
+{
+    return qtest_writel(s, MBOX1_BASE + offset, value);
+}
+
+static void qtest_mbox1_write(QTestState *s, uint8_t channel, uint32_t data)
+{
+    uint32_t reg;
+
+    reg = FIELD_DP32(reg, MBOX_WRITE_REG, CHANNEL, channel);
+    reg = FIELD_DP32(reg, MBOX_WRITE_REG, DATA, data);
+    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, reg);
+}
+
+int qtest_mbox0_has_data(QTestState *s) {
+    return !(qtest_mbox0_read_reg32(s, MBOX_REG_STATUS) & MBOX_READ_EMPTY);
+}
+
+int mbox0_has_data(void) {
+    return qtest_mbox0_has_data(global_qtest);
+}
+
+void qtest_mbox0_read_message(QTestState *s,
+                              uint8_t channel,
+                              void *msgbuf,
+                              size_t msgbuf_size)
+{
+    uint32_t reg;
+    uint32_t msgaddr;
+
+    g_assert(qtest_mbox0_has_data(s));
+    reg = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
+    g_assert_cmphex(FIELD_EX32(reg, MBOX_WRITE_REG, CHANNEL), ==, channel);
+    msgaddr = FIELD_EX32(reg, MBOX_WRITE_REG, DATA) << 4;
+    qtest_memread(s, msgaddr, msgbuf, msgbuf_size);
+}
+
+void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size) {
+    qtest_mbox0_read_message(global_qtest, channel, msgbuf, msgbuf_size);
+}
+
+void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr)
+{
+    qtest_mbox1_write(s, channel, msg_addr >> 4);
+}
+
+
+void mbox1_write_message(uint8_t channel, uint32_t msg_addr)
+{
+    qtest_mbox1_write_message(global_qtest, channel, msg_addr);
+}
diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
new file mode 100644
index 0000000000..1d02ca9c2c
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -0,0 +1,46 @@
+/*
+ * Declarations for BCM2838 mailbox test.
+ *
+ * Copyright (c) 2023 Auriga LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+
+REG32(MBOX_WRITE_REG, 0)
+FIELD(MBOX_WRITE_REG, CHANNEL, 0, 4)
+FIELD(MBOX_WRITE_REG, DATA, 4, 28)
+
+REG32(MBOX_SIZE_STAT, 0)
+FIELD(MBOX_WRITE_REG, SIZE, 0, 30)
+FIELD(MBOX_WRITE_REG, SUCCESS, 30, 1)
+
+typedef struct {
+    uint32_t size;
+    uint32_t req_resp_code;
+} MboxBufHeader;
+
+#define DECLARE_TAG_TYPE(TypeName, RequestValueType, ResponseValueType) \
+typedef struct {                                                        \
+    uint32_t id;                                                        \
+    uint32_t value_buffer_size;                                         \
+    union {                                                             \
+        struct {                                                        \
+            uint32_t zero;                                              \
+            RequestValueType value;                                     \
+        } request;                                                      \
+        struct {                                                        \
+            uint32_t size_stat;                                         \
+            ResponseValueType value;                                    \
+        } response;                                                     \
+    };                                                                  \
+} TypeName
+
+
+int mbox0_has_data(void);
+void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
+void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
+int qtest_mbox0_has_data(QTestState *s);
+void qtest_mbox0_read_message(QTestState *s, uint8_t channel, void *msgbuf, size_t msgbuf_size);
+void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d0..92eba5ac99 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -321,6 +321,7 @@ qtests = {
   'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'bcm2838-mbox-property-test' : files('bcm2838-mailbox.c'),
 }
 
 if vnc.found()
-- 
2.34.1


