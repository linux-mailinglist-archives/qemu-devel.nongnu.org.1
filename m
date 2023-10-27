Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E807D93F6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHQ-0002MM-OL; Fri, 27 Oct 2023 05:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHP-0002Lp-3p
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHN-0002kU-Ha
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHFVGbN3Z5J3QkZ+IMc8CUg9xV8BBIbMridlp9wflug=;
 b=UGvBHPbxUswiQIKwcc8NQkhDlGLnbI0euZGb5mO7+NQ/btZO2YUCmEUFn1kr1Nugk3LV8A
 JwyGRDmZUA9IihtpuF0oetdf0q0V0fOm3MKf/vRv3UpTaw0RYNUmNpmniPRt3yBtwaIqWc
 VhZ08fz5FcPd7djXoVUYRmAK//jkTn8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-BVhm_uibNY6tOtLMnTWTlg-1; Fri,
 27 Oct 2023 05:37:19 -0400
X-MC-Unique: BVhm_uibNY6tOtLMnTWTlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F32673813BC6;
 Fri, 27 Oct 2023 09:37:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA7DA1121319;
 Fri, 27 Oct 2023 09:37:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/11] tests/rtl8139: Clean up global variable shadowing
Date: Fri, 27 Oct 2023 11:37:04 +0200
Message-ID: <20231027093710.273558-6-thuth@redhat.com>
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

Rename the variable to fix:

  tests/qtest/rtl8139-test.c:28:33: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void save_fn(QPCIDevice *dev, int devfn, void *data)
                                  ^
  tests/qtest/rtl8139-test.c:37:17: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      QPCIDevice *dev;
                  ^
  tests/qtest/rtl8139-test.c:25:20: note: previous declaration is here
  static QPCIDevice *dev;
                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231009100251.56019-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/rtl8139-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/rtl8139-test.c b/tests/qtest/rtl8139-test.c
index 4dc0a0d22e..eedf90f65a 100644
--- a/tests/qtest/rtl8139-test.c
+++ b/tests/qtest/rtl8139-test.c
@@ -22,7 +22,7 @@ static void nop(void)
 #define CLK 33333333
 
 static QPCIBus *pcibus;
-static QPCIDevice *dev;
+static QPCIDevice *pcidev;
 static QPCIBar dev_bar;
 
 static void save_fn(QPCIDevice *dev, int devfn, void *data)
@@ -46,7 +46,7 @@ static QPCIDevice *get_device(void)
 #define PORT(name, len, val) \
 static unsigned __attribute__((unused)) in_##name(void) \
 { \
-    unsigned res = qpci_io_read##len(dev, dev_bar, (val));     \
+    unsigned res = qpci_io_read##len(pcidev, dev_bar, (val));     \
     if (verbosity_level >= 2) { \
         g_test_message("*%s -> %x", #name, res); \
     } \
@@ -57,7 +57,7 @@ static void out_##name(unsigned v) \
     if (verbosity_level >= 2) { \
         g_test_message("%x -> *%s", v, #name); \
     } \
-    qpci_io_write##len(dev, dev_bar, (val), v);        \
+    qpci_io_write##len(pcidev, dev_bar, (val), v);        \
 }
 
 PORT(Timer, l, 0x48)
@@ -189,11 +189,11 @@ static void test_init(void)
 {
     uint64_t barsize;
 
-    dev = get_device();
+    pcidev = get_device();
 
-    dev_bar = qpci_iomap(dev, 0, &barsize);
+    dev_bar = qpci_iomap(pcidev, 0, &barsize);
 
-    qpci_device_enable(dev);
+    qpci_device_enable(pcidev);
 
     test_timer();
 }
-- 
2.41.0


