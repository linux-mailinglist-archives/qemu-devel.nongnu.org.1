Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3737EA694
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 00:04:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2fwv-0001ST-7j; Mon, 13 Nov 2023 18:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r2fws-0001SF-DO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 18:02:30 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r2fwq-0006zg-JS
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 18:02:30 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2e72fe47fso3300182b6e.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699916546; x=1700521346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+tuKBpT3I4kfy1G+UfvPrkWVAQowwC4Vp1i+ccIq9h4=;
 b=PNiBMPx7d3Pj3V03M2a6vP/c+79vr4SM8sBmAqgCwCrHD5Z1xoHXhW948Q67lafj2s
 OLrM/iF8r9TOc+WfzPVl70wlMAOj2TlBuA9Xj71O1sg3YyY5D5szVMygFhzS87euupg5
 anj972AKYI7oRgk6mUjq1zM6UJnzHI2n2qN1NeEqunR0L8B+I0/CIKQ1L3vyL/75dU4p
 QDtvOt0wNHWF5Zf4SovVcEdmBL/naAoj7oOcc5I4RLylTkxrm1g9u0xCI6V7raMCnA5c
 Y0Gmq1po1qeo4VuWlD1Irn0eK17c5DNiG1Ft6TReNHSn0t0iRhaWZ2ggOd4v24lormJk
 xPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699916546; x=1700521346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tuKBpT3I4kfy1G+UfvPrkWVAQowwC4Vp1i+ccIq9h4=;
 b=kTEXCulOyKIQp2y03xIdJsZTWQLC8iM5XaM/IC7PJhqmzjcqnsbJSKjioODISI0y59
 UcP2BVIeb9i0h3zvAYf+Rw7sdv8V5soYM22M8OAbvHNKUoRG41uC2RBbuunjGPdu4BOy
 ieaI2dtAGVN9AYeBYSHxVt9Z3BmhLRF/V/OrLvWy3ichZIdAh12KuTR3pGdXa8KHdhck
 MZ1VGgpu8nvSIP5rofCyGCDYjx4qcnLVDkxxuqCKmK8yaxseJhZkHT7v0goa3Um9jWw7
 OZyuWVo8QWSaoy1CDFungNWUMOVP5UeAQXPeoWxOwvYY9Rcmp9ETX5DkWOcFp2aDo4TH
 3jhQ==
X-Gm-Message-State: AOJu0YzneZQXvK7sxqg6W9gPLOhCPARIAW2qwnQidajmbFejH+FtzDMX
 DSkel/KFNkDrKvNJ3LSUkvwRtYgtbGaQEhdY9D6wQ2Zi
X-Google-Smtp-Source: AGHT+IFwPIH9GhD48JbY27u5QrIS0o4TM+QlTiRWjTP25YvRpTpoy+mai7qMCK1HDwgfAWX9R5YouQ==
X-Received: by 2002:aca:f07:0:b0:3b6:cc01:aba2 with SMTP id
 7-20020aca0f07000000b003b6cc01aba2mr9015073oip.55.1699916546633; 
 Mon, 13 Nov 2023 15:02:26 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:308c:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a63e04e000000b0058d26647e45sm4566215pgj.54.2023.11.13.15.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 15:02:26 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	thuth@redhat.com,
	philmd@linaro.org
Cc: lvivier@redhat.com,
	pbonzini@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2] test/qtest: Add API functions to capture IRQ toggling
Date: Mon, 13 Nov 2023 23:01:49 +0000
Message-Id: <20231113230149.321304-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Currently, the QTest API does not provide a function to capture when an
IRQ line is raised or lowered, although the QTest Protocol already
reports such IRQ transitions. As a consequence, it is also not possible
to capture when an IRQ line is toggled. Functions like qtest_get_irq()
only read the current state of the intercepted IRQ lines, which is
already high (or low) when the function is called if the IRQ line is
toggled. Therefore, these functions miss the IRQ line state transitions.

This commit introduces two new API functions:
qtest_get_irq_raised_counter() and qtest_get_irq_lowered_counter().
These functions allow capturing the number of times an observed IRQ line
transitioned from low to high state or from high to low state,
respectively.

When used together, these new API functions then allow checking if one
or more pulses were generated (indicating if the IRQ line was toggled).

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
 tests/qtest/libqtest.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f33a210861..6ada4cae6e 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -82,6 +82,8 @@ struct QTestState
     int expected_status;
     bool big_endian;
     bool irq_level[MAX_IRQ];
+    uint64_t irq_raised_counter[MAX_IRQ];
+    uint64_t irq_lowered_counter[MAX_IRQ];
     GString *rx;
     QTestTransportOps ops;
     GList *pending_events;
@@ -498,6 +500,8 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     s->rx = g_string_new("");
     for (i = 0; i < MAX_IRQ; i++) {
         s->irq_level[i] = false;
+        s->irq_raised_counter[i] = 0;
+        s->irq_lowered_counter[i] = 0;
     }
 
     /*
@@ -689,8 +693,10 @@ redo:
         g_assert_cmpint(irq, <, MAX_IRQ);
 
         if (strcmp(words[1], "raise") == 0) {
+            s->irq_raised_counter[irq]++;
             s->irq_level[irq] = true;
         } else {
+            s->irq_lowered_counter[irq]++;
             s->irq_level[irq] = false;
         }
 
@@ -980,6 +986,22 @@ bool qtest_get_irq(QTestState *s, int num)
     return s->irq_level[num];
 }
 
+uint64_t qtest_get_irq_raised_counter(QTestState *s, int num)
+{
+    /* dummy operation in order to make sure irq is up to date */
+    qtest_inb(s, 0);
+
+    return s->irq_raised_counter[num];
+}
+
+uint64_t qtest_get_irq_lowered_counter(QTestState *s, int num)
+{
+    /* dummy operation in order to make sure irq is up to date */
+    qtest_inb(s, 0);
+
+    return s->irq_lowered_counter[num];
+}
+
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
 {
     qtest_sendf(s, "module_load %s %s\n", prefix, libname);
@@ -1799,6 +1821,8 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
     qts->wstatus = 0;
     for (int i = 0; i < MAX_IRQ; i++) {
         qts->irq_level[i] = false;
+        qts->irq_raised_counter[i] = 0;
+        qts->irq_lowered_counter[i] = 0;
     }
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 6e3d3525bf..a2a16914dc 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -364,6 +364,34 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
  */
 bool qtest_get_irq(QTestState *s, int num);
 
+/**
+ * qtest_get_irq_raised_counter:
+ * @s: #QTestState instance to operate on.
+ * @num: Interrupt to observe.
+ *
+ * This function can be used in conjunction with the
+ * qtest_get_irq_lowered_counter() to check if one or more pulses where
+ * generated on the observed interrupt.
+ *
+ * Returns: The number of times IRQ @num was raised, i.e., transitioned from
+ * a low state (false) to a high state (true).
+ */
+uint64_t qtest_get_irq_raised_counter(QTestState *s, int num);
+
+/**
+ * qtest_get_irq_lowered_counter:
+ * @s: #QTestState instance to operate on.
+ * @num: Interrupt to observe.
+ *
+ * This function can be used in conjunction with the
+ * qtest_get_irq_raised_counter() to check if one or more pulses where
+ * generated on the observed interrupt.
+ *
+ * Returns: The number of times IRQ @num was lowered, i.e., transitioned from
+ * a high state (true) to a low state (false).
+ */
+uint64_t qtest_get_irq_lowered_counter(QTestState *s, int num);
+
 /**
  * qtest_irq_intercept_in:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


