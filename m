Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73A7E782E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 04:42:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1INl-0004y7-0f; Thu, 09 Nov 2023 22:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r1INi-0004xc-Mc
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 22:40:30 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r1INh-0005uO-1w
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 22:40:30 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6c33ab26dddso1504117b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699587627; x=1700192427; darn=nongnu.org;
 h=content-transfer-encoding:content-language:mime-version:user-agent
 :date:message-id:subject:from:cc:to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z81K35OO2eUCpve25H5Tuz7piXHa8fecDSrxoQEOC68=;
 b=qFur74qoRLm8j7aOFFNBEjHfyqqmI9ttik02A5ldk8otKkhZtDjcEepiKYPilK3OG3
 MjXq04RNFnBrJTi2Sxh5vW+AlSDa3xPG9VgysVYSnIaeMpPSVnjeO9Ea4txAXVGQPiXf
 mTfrsYnSdf55+U3GhAQNu84QhmPVNxKIuJgYsjnow9icpeybxFcICqDLnE9wj4BiuOO4
 EHHbM6gLC4ciJgq8pVFYkoUVoYP5Nsv4uZxlPS+CisxP3kf+bA5Crn0tJzG31TjfgOBQ
 2+iVmYN8JoGtc+Shgoq8361VhI0KlAFi/QMF6RsimRdM29YD3NKsD/TtWmr8HvotpdsK
 XcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699587627; x=1700192427;
 h=content-transfer-encoding:content-language:mime-version:user-agent
 :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z81K35OO2eUCpve25H5Tuz7piXHa8fecDSrxoQEOC68=;
 b=N7D5R/0dVL23ybVuLfgXb+aDWSkE8tL0AOvLZJObx/70/KpGHy/EDcUWo03TGWR6sa
 V70fZ9ldbvYCu8M49WMtV9qjQOG2TlAN0jg5PVqfQ7GGr50Rxn3lIUT9VP2fY7jGuN/5
 HDoNO4ym5HfNUbv5px8TE0x9NPYqtx4lEL2cuLyLKmWQUHSywUZf30QQefEazGnbR53Y
 4ppqm+CqWRM3XjXy2K4wKmNi+sr+2pW4nkv4/dATUb+Ev8G/VvPaJLVSoafswFaW5vRn
 lnJX2ir50OmsqXqyAWDaVspNVEG844z21Dw3M9KwnQ/PPGJME4TJfQ4nclcbj9fUwyan
 Jdxw==
X-Gm-Message-State: AOJu0YwThH59koCZb9k8E2EiXEm0WzWWR/s/Qi3Zl+CWpm2+wBkNuRLe
 e9nZefl0LxWfz6lrTDNIjcLvcg==
X-Google-Smtp-Source: AGHT+IECGrD27NT8BeH7YXanjFvn6iGbFT2Us1HPRMizn6mP+WSbl3r4SVrrHAxQl43cjjbW4cwa2Q==
X-Received: by 2002:a05:6a00:b92:b0:68b:bf33:2957 with SMTP id
 g18-20020a056a000b9200b0068bbf332957mr7188066pfj.22.1699587627268; 
 Thu, 09 Nov 2023 19:40:27 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:308c:fa40:2f92:19ee:4ba?
 ([2804:7f0:b401:308c:fa40:2f92:19ee:4ba])
 by smtp.gmail.com with ESMTPSA id
 h15-20020aa786cf000000b006bd26bdc909sm11503708pfo.72.2023.11.09.19.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 19:40:26 -0800 (PST)
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: QTest framework does not capture toggled irq line
Message-ID: <4daf0424-b767-b5d9-bacb-0fe879c92963@linaro.org>
Date: Fri, 10 Nov 2023 00:40:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
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

Hi folks,

I'm writing a test for a device that has one IRQ output line
that is toggled (raised then lowered) by the device to trigger
a CPU interrupt.

Afaics the QTest framework does not provide a way to capture
when an output line is raised because the API functions, e.g.
qtest_get_irq(), read the current state of the intercepted
IRQ lines, which is already low when the function is called,
since the line is toggled by the device.

I'd like to introduce a new API function to address this case,
called qtest_get_irq_trigger_counter():

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 471529e6cc..9ed2a43155 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -79,6 +79,7 @@ struct QTestState
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 471529e6cc..9ed2a43155 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -79,6 +79,7 @@ struct QTestState
      int expected_status;
      bool big_endian;
      bool irq_level[MAX_IRQ];
+    uint64_t irq_trigger_counter[MAX_IRQ];
      GString *rx;
      QTestTransportOps ops;
      GList *pending_events;
@@ -481,6 +482,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
      s->rx = g_string_new("");
      for (i = 0; i < MAX_IRQ; i++) {
          s->irq_level[i] = false;
+        s->irq_trigger_counter[i] = 0;
      }
  
      /*
@@ -663,6 +665,7 @@ redo:
  
          if (strcmp(words[1], "raise") == 0) {
              s->irq_level[irq] = true;
+            s->irq_trigger_counter[irq]++;
          } else {
              s->irq_level[irq] = false;
          }
@@ -953,6 +956,14 @@ bool qtest_get_irq(QTestState *s, int num)
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
@@ -1693,6 +1704,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
      qts->wstatus = 0;
      for (int i = 0; i < MAX_IRQ; i++) {
          qts->irq_level[i] = false;
+        qts->irq_trigger_counter[i] = 0;
      }
  
      qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index e53e350e3a..0e763a4507 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -351,6 +351,16 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
   */
  bool qtest_get_irq(QTestState *s, int num);
  
+
+/**
+ * qtest_get_irq_counter:
+ * @s: #QTestState instance to operate on.
+ * @irq_num: Interrupt to observe.
+ *
+ * Returns: The number of times @irq_num got triggered (raised).
+ */
+uint64_t qtest_get_irq_trigger_counter(QTestState *s, int irq_num);
+
  /**
   * qtest_irq_intercept_in:
   * @s: #QTestState instance to operate on.


This change addresses the current QTest limitation. Is it acceptable?


Cheers,
Gustavo

