Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07F7BD80B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn75-0003Vx-5b; Mon, 09 Oct 2023 06:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn70-0003P4-Jp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6v-0000F0-9k
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso39821925e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845815; x=1697450615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Csk84OALb8Q47k8SHL9RxynHS9qNYD6xloMNS+mez1Q=;
 b=zN6Cr1B4PBnB8FvTSS1rtyEe2t/72GT18eWWuem3OErfj9/xw+WoDeuGwOHyOOexgx
 /y+xIz8SpZV9AuUb+O+OKyllmz1QyI/2oAaOVcSxugFr2ev+Jb1lS2NP6IP1VDv8V4GF
 EsbrctDLssFhxNDmCiG+lzkoR2yeAzZqLyqoLWF2EiPnci8GjpWJLLmTneW7J9/D70No
 o9AURB2MmcJ1Yirx9a32evQCLpWxpZfz+uCtAhi2uU2yh9JXz2JZeaVpSCrqOtUVF2eO
 8v/74vb0fVO65GP0p0EcWhpniCMFC1gPWqH+7JHxCZgIBtBzSswNG3NEYxaLqO7Vsq0U
 nmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845815; x=1697450615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Csk84OALb8Q47k8SHL9RxynHS9qNYD6xloMNS+mez1Q=;
 b=Uus9iHdavPpZei+obSbBKzxX+7f+1hBTwIg+yUTEoHuuig2XhrRuTmA0VGqBHYzdAN
 N9VbfRIGSTn8HTzBbVOhYfVP2GVggrRJXsMiHQ700+1+TTKF3sfacpr29k+v552GxdAZ
 PrNZsOd+9rtIw9zykjUt99AQH3BEzvgLifaHs3eTHPzlEqPtRVepyoC3opkSaEEj8cZ+
 7piBcWc0qYuCFmcXabNGhpnKyY02EoolUwdINGPQ4iOwBseszcfrYj6iD21XKYlPYAAF
 0mXqpTyPMSehe0dqlRtQQsLL3EbOh7eChyF0+jrJwnLT2mHbW5WT/Mvm5SbjbTx1xP0c
 ONRw==
X-Gm-Message-State: AOJu0YzMtZiojqdZ9+mDzdF6wz6qhcYJgLSTo7+zIRSSskWIhay5x8BE
 51fl6sLl85JNDwvD3NHoAgIlyX7KAdABk/CebG8=
X-Google-Smtp-Source: AGHT+IE5G/wk7T/I/eVYvZehGYGbz6kLhTjEtW25Bn6+z38D0ZNSRefxCdlZyvFHmxJ4TEyihaYP4Q==
X-Received: by 2002:a05:6000:186c:b0:321:6779:944d with SMTP id
 d12-20020a056000186c00b003216779944dmr19359600wri.47.1696845815218; 
 Mon, 09 Oct 2023 03:03:35 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d4c4a000000b00323287186aasm9142230wrt.32.2023.10.09.03.03.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/10] tests/npcm7xx_adc: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 12:02:48 +0200
Message-ID: <20231009100251.56019-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename the global 'adc' variable in order to avoid:

  tests/qtest/npcm7xx_adc-test.c:98:58: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static uint32_t adc_read_con(QTestState *qts, const ADC *adc)
                                                           ^
  tests/qtest/npcm7xx_adc-test.c:103:55: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void adc_write_con(QTestState *qts, const ADC *adc, uint32_t value)
                                                        ^
  tests/qtest/npcm7xx_adc-test.c:108:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static uint32_t adc_read_data(QTestState *qts, const ADC *adc)
                                                            ^
  tests/qtest/npcm7xx_adc-test.c:119:53: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void adc_qom_set(QTestState *qts, const ADC *adc,
                                                      ^
  tests/qtest/npcm7xx_adc-test.c:135:57: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void adc_write_input(QTestState *qts, const ADC *adc,
                                                          ^
  tests/qtest/npcm7xx_adc-test.c:144:56: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void adc_write_vref(QTestState *qts, const ADC *adc, uint32_t value)
                                                         ^
  tests/qtest/npcm7xx_adc-test.c:162:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static uint32_t adc_prescaler(QTestState *qts, const ADC *adc)
                                                            ^
  tests/qtest/npcm7xx_adc-test.c:175:64: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void adc_wait_conv_finished(QTestState *qts, const ADC *adc,
                                                                 ^
  tests/qtest/npcm7xx_adc-test.c:196:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
    const ADC *adc = adc_p;
               ^
  tests/qtest/npcm7xx_adc-test.c:207:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
    const ADC *adc = adc_p;
               ^
  tests/qtest/npcm7xx_adc-test.c:235:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
    const ADC *adc = adc_p;
               ^
  tests/qtest/npcm7xx_adc-test.c:267:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
    const ADC *adc = adc_p;
               ^
  tests/qtest/npcm7xx_adc-test.c:293:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
    const ADC *adc = adc_p;
               ^
  tests/qtest/npcm7xx_adc-test.c:311:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
    const ADC *adc = adc_p;
               ^
  tests/qtest/npcm7xx_adc-test.c:93:5: note: previous declaration is here
  ADC adc = {
      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/npcm7xx_adc-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/npcm7xx_adc-test.c b/tests/qtest/npcm7xx_adc-test.c
index 8048044d28..e751a72e36 100644
--- a/tests/qtest/npcm7xx_adc-test.c
+++ b/tests/qtest/npcm7xx_adc-test.c
@@ -90,7 +90,7 @@ typedef struct ADC {
     uint64_t base_addr;
 } ADC;
 
-ADC adc = {
+ADC adc_defs = {
     .irq        = 0,
     .base_addr  = 0xf000c000
 };
@@ -367,12 +367,12 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    add_test(init, &adc);
-    add_test(convert_internal, &adc);
-    add_test(convert_external, &adc);
-    add_test(interrupt, &adc);
-    add_test(reset, &adc);
-    add_test(calibrate, &adc);
+    add_test(init, &adc_defs);
+    add_test(convert_internal, &adc_defs);
+    add_test(convert_external, &adc_defs);
+    add_test(interrupt, &adc_defs);
+    add_test(reset, &adc_defs);
+    add_test(calibrate, &adc_defs);
 
     return g_test_run();
 }
-- 
2.41.0


