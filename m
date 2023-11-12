Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF37E8DE6
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 02:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1zQu-0005MT-7F; Sat, 11 Nov 2023 20:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r1zQr-0005M8-KR
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 20:38:37 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r1zQp-0005Mv-O9
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 20:38:37 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5844bc378feso1894639eaf.0
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699753113; x=1700357913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5iTBJRyOtbbI2Xeif97v+vFr7FkDa6oay4Q1ew9vL9c=;
 b=a9stK5iJguUtuLOeXngWEHdu2fDVNe6fbnAz09shOMVlYvH2h9T862a/uPkOPnW/1N
 cOA2QJpCpxE23vt+Nv3NUkXwSjMs49QE0BG6dSF20p8eYhTQavtHlQVFNzEr6JvIv0cr
 uBhU1bpCe9NJ3BUNPvcj3fEnJiQDWyR9a749AB/9mdHoXAlotfZddVUuHBiHlk9c/c6+
 zQvf3ecayyh3NYR2JHxZBT3DS+CKxLECm15UCVm1dnhFBpw3AjP0byq1jelylnHKX/6E
 yFuj72+0oRMLDmCI/b3Z/Oo+ROy+g5XOjZ7RF4gyCkt5Q4FKBNsHth31h6bpJb1tXN31
 xiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699753113; x=1700357913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5iTBJRyOtbbI2Xeif97v+vFr7FkDa6oay4Q1ew9vL9c=;
 b=YuHg6fmkdxOaxURxSVfYsNn5AiHkFMWgPMHxq8rl+MKXl60cXs2JWCtSk6AqIeMPJv
 0sqQ47lV3txDSNQ25YybSv1fR5Zdn3rnPFyBq7BiXoS+fYahTCgWVYRReItqbDSVXawS
 178l6NLWzTnLPItq7kZYqI1APBbbmGNasSwvVmBI8ljiqu7Tr9BhV2lZhew+fo/cnoWT
 pcUVCUfb+pZUMG3aSX1h+W0XXzl76r0+TCTAhcP/RGkGl7ulI2xS8Lczsq0/zRnid7N7
 ylxB+K2HIKWOpzT0twRxfeYEPNXsHBlPowRe6g0xquJnBCqwe63thWkVj28gpRpz3EgK
 3sgg==
X-Gm-Message-State: AOJu0Yyr5dMe9ChTpccjQr7qrpR3H10ao0kdaZDaNJDREsPaJV9jJKnN
 3eX63n9EjSvgbx8jMLq1PUnPGCOGSMpTyndTSln/JsnR
X-Google-Smtp-Source: AGHT+IGllvZ9C9DdmUr5g2c1OGWOGWsIOspQTJGFDEFe58fAIRobfDmGcAZVtEYmQIndzJ2rXO/8+Q==
X-Received: by 2002:a05:6358:7f1e:b0:169:81cc:d7f9 with SMTP id
 p30-20020a0563587f1e00b0016981ccd7f9mr5425425rwn.0.1699753113159; 
 Sat, 11 Nov 2023 17:38:33 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:308c:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a63f50c000000b005b8ebef9fa0sm1869393pgh.83.2023.11.11.17.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 17:38:32 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	thuth@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] test/qtest: Add an API function to capture IRQ toggling
Date: Sun, 12 Nov 2023 01:38:01 +0000
Message-Id: <20231112013801.293970-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc30.google.com
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

Currently the QTest API does not provide a function to allow capturing
when an IRQ line is toggled (raised then lowered). Functions like
qtest_get_irq() read the current state of the intercepted IRQ lines,
which is already low when the function is called, since the line is
toggled.

This commit introduces a new function, qtest_get_irq_trigger_counter(),
which returns the number of times a given intercepted IRQ line was
triggered (raised), hence allowing to capture when an IRQ line was
toggled.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/libqtest.c | 12 ++++++++++++
 tests/qtest/libqtest.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f33a210861..21891b52f1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -82,6 +82,7 @@ struct QTestState
     int expected_status;
     bool big_endian;
     bool irq_level[MAX_IRQ];
+    uint64_t irq_trigger_counter[MAX_IRQ];
     GString *rx;
     QTestTransportOps ops;
     GList *pending_events;
@@ -498,6 +499,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     s->rx = g_string_new("");
     for (i = 0; i < MAX_IRQ; i++) {
         s->irq_level[i] = false;
+        s->irq_trigger_counter[i] = 0;
     }
 
     /*
@@ -690,6 +692,7 @@ redo:
 
         if (strcmp(words[1], "raise") == 0) {
             s->irq_level[irq] = true;
+            s->irq_trigger_counter[irq]++;
         } else {
             s->irq_level[irq] = false;
         }
@@ -980,6 +983,14 @@ bool qtest_get_irq(QTestState *s, int num)
     return s->irq_level[num];
 }
 
+uint64_t qtest_get_irq_trigger_counter(QTestState *s, int irq_num)
+{
+    /* dummy operation in order to make sure irq is up to date */
+    qtest_inb(s, 0);
+
+    return s->irq_trigger_counter[irq_num];
+}
+
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
 {
     qtest_sendf(s, "module_load %s %s\n", prefix, libname);
@@ -1799,6 +1810,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
     qts->wstatus = 0;
     for (int i = 0; i < MAX_IRQ; i++) {
         qts->irq_level[i] = false;
+        qts->irq_trigger_counter[i] = 0;
     }
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 6e3d3525bf..d1c525aea0 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -364,6 +364,15 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
  */
 bool qtest_get_irq(QTestState *s, int num);
 
+/**
+ * qtest_get_irq_counter:
+ * @s: #QTestState instance to operate on.
+ * @num: Interrupt to observe.
+ *
+ * Returns: The number of times IRQ @num got triggered (raised).
+ */
+uint64_t qtest_get_irq_trigger_counter(QTestState *s, int num);
+
 /**
  * qtest_irq_intercept_in:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


