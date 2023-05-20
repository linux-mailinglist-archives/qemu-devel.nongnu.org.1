Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5853A70A790
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 13:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Kpz-0007ra-75; Sat, 20 May 2023 07:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1q0Kpw-0007qd-SD
 for qemu-devel@nongnu.org; Sat, 20 May 2023 07:33:24 -0400
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1q0Kpu-0007qk-DM
 for qemu-devel@nongnu.org; Sat, 20 May 2023 07:33:24 -0400
Received: from fwd79.dcpf.telekom.de (fwd79.aul.t-online.de [10.223.144.105])
 by mailout12.t-online.de (Postfix) with SMTP id D6BDF17546;
 Sat, 20 May 2023 13:33:16 +0200 (CEST)
Received: from linpower.localnet ([79.208.24.239]) by fwd79.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1q0Kpl-22SIRl0; Sat, 20 May 2023 13:33:14 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 94566200242; Sat, 20 May 2023 13:33:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2] tests/qtest/ac97-test: add up-/downsampling tests
Date: Sat, 20 May 2023 13:33:13 +0200
Message-Id: <20230520113313.5177-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1684582394-49620266-9DEBCD5B/0/0 CLEAN NORMAL
X-TOI-MSGID: 196e5f56-4ee0-44aa-82a2-0f35700fad17
Received-SPF: none client-ip=194.25.134.22;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout12.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Test if the audio subsystem can handle extreme up- and down-
sampling ratios like 44100/1 and 1/44100. For some time these
used to trigger QEMU aborts. The test was taken from
https://gitlab.com/qemu-project/qemu/-/issues/71 where it was
used to demonstrate a very different issue.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
v2:
Cosmetic changes to the comments. The promised improved commit
message appeared in commit b9ae74e2e4 ("audio: log unimplemented
audio device sample rates").

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
2.35.3


