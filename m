Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D3786BD7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eP-0005gZ-B9; Thu, 24 Aug 2023 05:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e1-00044Y-K8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6du-0004xW-1c
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso1964745e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869319; x=1693474119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UyC6pkxktpI+U9x2+x+ifLYzV9VlMFeTgo38T5/icxQ=;
 b=Wx8gdMfW30eA1RrycIVlqqkVSDqoSwdi7EKm2NHAXwk3tPCnNfZRFQZmiJ0X41puE8
 8IHizylLf2XXdM9K6C8V8x1HDjjfYlDLXQCLw+noCVchnsPkZZqJ2Kc55lMyAf+yEdGU
 cnJA4iTKrMl24fEGQYUkaEFvlhiqJsKH/nwqhtFunDxJ4ZHPUWHw3APeRfYdPS/OiOn5
 um8oR7lihGFE8s73wiZLCEBhcmThpvgUt+pLFqeGeihKWjpurrrYHjHAitObuNrn8RXo
 8n1AkTQaYlLirdVDLbMVCjzK7OQn04mBv5bjPoNAU01J4gUMFllc0C9rJ70NhIbO5JGm
 zQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869319; x=1693474119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyC6pkxktpI+U9x2+x+ifLYzV9VlMFeTgo38T5/icxQ=;
 b=NoivfNdf0QWuPcumfDf8h9S5e4L2v44Td6Ffghy1XnfRqdG0imYNtdizRFYqllM0wQ
 UEPvspHjr63kNOszawxnzRDYMcy77wS6paAgB9TL95MEenRILljh04NRkl01zyA+w4s3
 6UQPFb3tvvinMgUzFH6CtQR8g0OizUi2iIR7BI75xNcFpTCgStbmxvLg40cUET+f4DBm
 f9UUlbTbT924VX7IEeoZ1EDVEI3luS0A50IvYvFYIV9B/v8JzredRBWLxzz+K2SuqDMx
 fjr9sxnJCTZ/zBfWAapA8HB3SjZX6WSU3Pryk61RnfAbp/fv0bBG7oJsBmcFi1P6cQzW
 GFAQ==
X-Gm-Message-State: AOJu0YxbAU6/Ar+ltWnNYTCh5wmf8mHiJaXZcOuPWjgbd5dDOAlGPHDg
 7ck3ZoG3V/Sxtr3Go2QYefOIzaB4Kezj73VauN4=
X-Google-Smtp-Source: AGHT+IGrsEVi8QxnH1j0+3SDr5B4ko3+MI7BkmFfTY3UuL7D/CShqI8mxyqE5xfOSD6579yczvl3NQ==
X-Received: by 2002:a05:600c:210e:b0:3ff:516b:5c4c with SMTP id
 u14-20020a05600c210e00b003ff516b5c4cmr3722808wml.18.1692869319116; 
 Thu, 24 Aug 2023 02:28:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/35] qtest: implement named interception of out-GPIO
Date: Thu, 24 Aug 2023 10:28:04 +0100
Message-Id: <20230824092836.2239644-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chris Laplante <chris@laplante.io>

Adds qtest_irq_intercept_out_named method, which utilizes a new optional
name parameter to the irq_intercept_out qtest command.

Signed-off-by: Chris Laplante <chris@laplante.io>
Message-id: 20230728160324.1159090-4-chris@laplante.io
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/libqtest.h | 11 +++++++++++
 softmmu/qtest.c        | 18 ++++++++++--------
 tests/qtest/libqtest.c |  6 ++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 3a71bc45fcf..e53e350e3a6 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -371,6 +371,17 @@ void qtest_irq_intercept_in(QTestState *s, const char *string);
  */
 void qtest_irq_intercept_out(QTestState *s, const char *string);
 
+/**
+ * qtest_irq_intercept_out_named:
+ * @s: #QTestState instance to operate on.
+ * @qom_path: QOM path of a device.
+ * @name: Name of the GPIO out pin
+ *
+ * Associate a qtest irq with the named GPIO-out pin of the device
+ * whose path is specified by @string and whose name is @name.
+ */
+void qtest_irq_intercept_out_named(QTestState *s, const char *qom_path, const char *name);
+
 /**
  * qtest_set_irq_in:
  * @s: QTestState instance to operate on.
diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 1b864891629..0f1d478bda5 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -397,8 +397,10 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         || strcmp(words[0], "irq_intercept_in") == 0) {
         DeviceState *dev;
         NamedGPIOList *ngl;
+        bool is_outbound;
 
         g_assert(words[1]);
+        is_outbound = words[0][14] == 'o';
         dev = DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
             qtest_send_prefix(chr);
@@ -417,14 +419,14 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         }
 
         QLIST_FOREACH(ngl, &dev->gpios, node) {
-            /* We don't support intercept of named GPIOs yet */
-            if (ngl->name) {
-                continue;
-            }
-            if (words[0][14] == 'o') {
-                int i;
-                for (i = 0; i < ngl->num_out; ++i) {
-                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
+            /* We don't support inbound interception of named GPIOs yet */
+            if (is_outbound) {
+                /* NULL is valid and matchable, for "unnamed GPIO" */
+                if (g_strcmp0(ngl->name, words[2]) == 0) {
+                    int i;
+                    for (i = 0; i < ngl->num_out; ++i) {
+                        qtest_install_gpio_out_intercept(dev, ngl->name, i);
+                    }
                 }
             } else {
                 qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c22dfc30d3d..471529e6cc3 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -993,6 +993,12 @@ void qtest_irq_intercept_out(QTestState *s, const char *qom_path)
     qtest_rsp(s);
 }
 
+void qtest_irq_intercept_out_named(QTestState *s, const char *qom_path, const char *name)
+{
+    qtest_sendf(s, "irq_intercept_out %s %s\n", qom_path, name);
+    qtest_rsp(s);
+}
+
 void qtest_irq_intercept_in(QTestState *s, const char *qom_path)
 {
     qtest_sendf(s, "irq_intercept_in %s\n", qom_path);
-- 
2.34.1


