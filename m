Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47321712320
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRi-0003JV-RO; Fri, 26 May 2023 05:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRg-0003JI-U9
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRS-0000kr-VH
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6y1zQGFPIYTRlYFZ1m6N9MVEIpi+f+Fj9potENB3HBQ=;
 b=EPUTX5sTZZSrrvjfIYrBGaL3r5ysdEXy8xhMRy1C9PNH6LCU3b/+qgPhJoNMZjPKlJGJXg
 PxxJT1NGO+gsFc63rNYFyBQhpEmnY8TWwtD16u0cjcoetaSQgQwNot7vIWg5RZHhn/K0zb
 ox0yi1Xk5vbJYQURi5tVWd6VJgbUW8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-7exvE7r0N2qUR9tx3QCkZQ-1; Fri, 26 May 2023 05:08:56 -0400
X-MC-Unique: 7exvE7r0N2qUR9tx3QCkZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60A8D85A5AA;
 Fri, 26 May 2023 09:08:56 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82363C154D1;
 Fri, 26 May 2023 09:08:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/15] tests/qtest/ac97-test: add up-/downsampling tests
Date: Fri, 26 May 2023 11:08:37 +0200
Message-Id: <20230526090840.2225958-13-thuth@redhat.com>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
References: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Test if the audio subsystem can handle extreme up- and down-
sampling ratios like 44100/1 and 1/44100. For some time these
used to trigger QEMU aborts. The test was taken from
https://gitlab.com/qemu-project/qemu/-/issues/71 where it was
used to demonstrate a very different issue.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20230520113313.5177-1-vr_qemu@t-online.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/ac97-test.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ac97-test.c b/tests/qtest/ac97-test.c
index 74103efdfa..b71bd60a8a 100644
--- a/tests/qtest/ac97-test.c
+++ b/tests/qtest/ac97-test.c
@@ -42,16 +42,54 @@ static void *ac97_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
     return &ac97->obj;
 }
 
+/*
+ * This is rather a test of the audio subsystem and not an AC97 test. Test if
+ * the audio subsystem can handle a 44100/1 upsample ratio. For some time this
+ * used to trigger QEMU aborts.
+ */
+static void ac97_playback_upsample(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QAC97 *ac97 = obj;
+    QPCIDevice *dev = &ac97->dev;
+    QPCIBar bar0;
+
+    qpci_device_enable(dev);
+    bar0 = qpci_iomap(dev, 0, NULL);
+    /* IOBAR0 offset 0x2c: PCM Front DAC Rate */
+    qpci_io_writew(dev, bar0, 0x2c, 0x1);
+}
+
+/*
+ * This test is similar to the playback upsample test. QEMU shouldn't abort if
+ * asked for a 1/44100 downsample ratio.
+ */
+static void ac97_record_downsample(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QAC97 *ac97 = obj;
+    QPCIDevice *dev = &ac97->dev;
+    QPCIBar bar0;
+
+    qpci_device_enable(dev);
+    bar0 = qpci_iomap(dev, 0, NULL);
+    /* IOBAR0 offset 0x32: PCM L/R ADC Rate */
+    qpci_io_writew(dev, bar0, 0x32, 0x1);
+}
+
 static void ac97_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
-        .extra_device_opts = "addr=04.0",
+        .extra_device_opts = "addr=04.0,audiodev=snd0",
+        .after_cmd_line = "-audiodev none,id=snd0"
+                          ",out.frequency=44100,in.frequency=44100",
     };
     add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("AC97", ac97_create);
     qos_node_produces("AC97", "pci-device");
     qos_node_consumes("AC97", "pci-bus", &opts);
+
+    qos_add_test("playback_upsample", "AC97", ac97_playback_upsample, NULL);
+    qos_add_test("record_downsample", "AC97", ac97_record_downsample, NULL);
 }
 
 libqos_init(ac97_register_nodes);
-- 
2.31.1


