Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 731837637E1
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWs-00035U-Fs; Wed, 26 Jul 2023 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWp-000314-5c; Wed, 26 Jul 2023 09:26:11 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWk-0003SJ-IH; Wed, 26 Jul 2023 09:26:10 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe04882c66so3275798e87.3; 
 Wed, 26 Jul 2023 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377961; x=1690982761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKsd7ns4JY0/y57vLM39lY4ahxp4dq6Mt0ef2kJRQYw=;
 b=HqkTnD5ZJ5u5UZWXZqEqWjENdFgQN/FK90fe/i6GJBhmYx2zD6KpDjJQslsjb0Yf6T
 yMKhPL3FjO/95/aI/K+M79XxWRsj0JHzEhSYBmmgeR+fjH/IWnm1EHrnA1pINdHvQFpU
 4jmHXFg4no66Ozra2Iisk0G3zLt93pMAfaNdE6lvY8dGtHXpe18PqkahB000TfIFsFi2
 h8jCDLdrQUTW6WEAsS66DpR/GD7eab7bNhAQWrg1wN12srK/6Y46CMwF4l4+ynODAW2m
 bFNstSdm0CoHoFbOfwl+D4ytn4N0EaKpoKHAjMlROhN1Jv7cjoY456QOmx8LJswhaHVq
 rJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377961; x=1690982761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKsd7ns4JY0/y57vLM39lY4ahxp4dq6Mt0ef2kJRQYw=;
 b=VrdyIbyKYoGH2upAtUdc8mNkLRzEcqCDYUeeikCJ5sCguSP1erBWAg2Ukpgh4a+XvZ
 enQVuIXmqmk171qSjqgWpLjEUbzjTcqG0QVUFASRNtLxATbQ4q48r/h0K9ruwJ5X61sf
 VA1OCCW3KZtEp385IqT1wrQbWdIaxaF75rliolCJzIC6VJbensYa6v/FzO1S6QUH2d0Q
 N/ypKHisyKWHadH3B6BAn0mPoRgg9wMidE+YiN5gH9DmWUd8Z/VLLN4lCnyzUdF8TIL1
 qbXDKAp0TmT363BrvKya6HzeERsMZjkdYr/Gr0fsWjC1AR6ROlWnCef+KeJQtZvFEFgQ
 Bb4w==
X-Gm-Message-State: ABy/qLbmGTgjTt9QrUsb4I896gkROtCJ9WJHJbjjygkzfm+sR2pDh6rY
 kAoYGxo7M4RiO4ubHgbGD10XXM3AKos=
X-Google-Smtp-Source: APBJJlGpcra89N/BO5Ba5WpOeMjanokzQlWDfwAa1/9AGEQAPG//jYynjQybJJGa0BgkoJrX+9HoEQ==
X-Received: by 2002:a05:6512:2346:b0:4fb:957b:4b20 with SMTP id
 p6-20020a056512234600b004fb957b4b20mr1700467lfu.59.1690377961556; 
 Wed, 26 Jul 2023 06:26:01 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:26:01 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 35/44] Add mailbox test stub
Date: Wed, 26 Jul 2023 16:25:03 +0300
Message-Id: <20230726132512.149618-36-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x131.google.com
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
 tests/qtest/bcm2838-mailbox.c | 70 +++++++++++++++++++++++++++++++++++
 tests/qtest/bcm2838-mailbox.h | 48 ++++++++++++++++++++++++
 tests/qtest/meson.build       |  1 +
 3 files changed, 119 insertions(+)
 create mode 100644 tests/qtest/bcm2838-mailbox.c
 create mode 100644 tests/qtest/bcm2838-mailbox.h

diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
new file mode 100644
index 0000000000..211d167ff8
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -0,0 +1,70 @@
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
+    MboxRegWrite reg;
+
+    reg.fields.channel = channel;
+    reg.fields.data = data;
+    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, reg.value);
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
+    MboxRegRead reg;
+    uint32_t msgaddr;
+
+    g_assert(qtest_mbox0_has_data(s));
+    reg.value = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
+    g_assert_cmphex(reg.fields.channel, ==, channel);
+    msgaddr = reg.fields.data << 4;
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
index 0000000000..a81b325af9
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -0,0 +1,48 @@
+/*
+ * Declarations for BCM2838 mailbox test.
+ *
+ * Copyright (c) 2023 Auriga LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t channel: 4;
+        uint32_t data   : 28;
+    } fields;
+} MboxRegWrite;
+
+typedef MboxRegWrite MboxRegRead;
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
+            RequestValueType __attribute__((packed)) value;             \
+        } request;                                                      \
+        struct {                                                        \
+            uint32_t size   : 31;                                       \
+            uint32_t success: 1;                                        \
+            ResponseValueType __attribute__((packed)) value;            \
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
index b071d400b3..61e9aab835 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -318,6 +318,7 @@ qtests = {
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'bcm2838-mbox-property-test' : files('bcm2838-mailbox.c'),
 }
 
 if vnc.found()
-- 
2.34.1


