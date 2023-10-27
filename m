Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C77D93EE
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:38:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHV-0002Os-Hv; Fri, 27 Oct 2023 05:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHT-0002O7-7b
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHR-0002lZ-6f
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxWl9KC5kTvsQct/HyKKr/qVl12ZnY8mw3Eg5JythuE=;
 b=YPZHyz9hZnoup5fd0KrYOF/BoiKwvCoJLFA9fk417KU8ICFnobg+mYXP5gxvF/NDyPbMyS
 KJ42xAcDoZcxksAn/CNomCxKjhOi6tU3PWu9GHpcpc+Kq70CISj5RQoWytZW6RlZklU4Mv
 xt9VsG6bvH1eWDI29CF2zCDZNG9FxZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jFgwyM0HMeyr9RMnxkQzxg-1; Fri, 27 Oct 2023 05:37:21 -0400
X-MC-Unique: jFgwyM0HMeyr9RMnxkQzxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3689101A529;
 Fri, 27 Oct 2023 09:37:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 758111121320;
 Fri, 27 Oct 2023 09:37:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/11] tests/npcm7xx_adc: Clean up global variable shadowing
Date: Fri, 27 Oct 2023 11:37:05 +0200
Message-ID: <20231027093710.273558-7-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231009100251.56019-8-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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


