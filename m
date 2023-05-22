Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814870BC5C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:52:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144s-0006iK-H7; Mon, 22 May 2023 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143k-0005Fs-OM
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143i-0007cB-Pg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faucVfx02BhDgLQUqzpM5sp6Fe5MkDIVCztJjr7LOEU=;
 b=ekR0g2rO1eqySxqHxNaAMnG0TblECrpHrBpVOlCbvKzjGZeqsba35I9FQBuN9qg8/YJfvU
 CCkFR5H9gZjVxPcDzi3V+LNQo7p3hctWFeDGMB0MgGa41AbU0tkJLM/77g66+RtO6SIEHW
 rEPbTWkmvs235/hcAEySJnWHm91DASw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-as-pKJB4N5u6wkm4SQEFQQ-1; Mon, 22 May 2023 07:50:34 -0400
X-MC-Unique: as-pKJB4N5u6wkm4SQEFQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 368E6381D1E8;
 Mon, 22 May 2023 11:50:34 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4252166B26;
 Mon, 22 May 2023 11:50:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/20] tests/qtest: Check for the availability of virtio-ccw
 devices before using them
Date: Mon, 22 May 2023 13:50:09 +0200
Message-Id: <20230522115014.1110840-16-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The devices might not have been compiled into the QEMU binary, so we
have to check before we can use them.

Message-Id: <20230512124033.502654-16-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/device-plug-test.c |  9 ++++++++-
 tests/qtest/virtio-ccw-test.c  | 20 +++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index 01cecd6e20..abd544b70c 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -156,7 +156,14 @@ static void test_q35_pci_unplug_json_request(void)
 
 static void test_ccw_unplug(void)
 {
-    QTestState *qtest = qtest_initf("-device virtio-balloon-ccw,id=dev0");
+    QTestState *qtest;
+
+    if (!qtest_has_device("virtio-balloon-ccw")) {
+        g_test_skip("Device virtio-balloon-ccw not available");
+        return;
+    }
+
+    qtest = qtest_initf("-device virtio-balloon-ccw,id=dev0");
 
     qtest_qmp_device_del_send(qtest, "dev0");
     wait_device_deleted_event(qtest, "dev0");
diff --git a/tests/qtest/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
index c0790e3ba2..f4f5858b84 100644
--- a/tests/qtest/virtio-ccw-test.c
+++ b/tests/qtest/virtio-ccw-test.c
@@ -76,13 +76,19 @@ static void virtio_scsi_hotplug(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/console/nop", virtconsole_nop);
-    qtest_add_func("/virtio/serialport/nop", virtserialport_nop);
-    qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
-    qtest_add_func("/virtio/serial/hotplug", virtio_serial_hotplug);
-    qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
-    qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
-    qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
+    if (qtest_has_device("virtio-serial-ccw")) {
+        qtest_add_func("/virtio/console/nop", virtconsole_nop);
+        qtest_add_func("/virtio/serialport/nop", virtserialport_nop);
+        qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
+        qtest_add_func("/virtio/serial/hotplug", virtio_serial_hotplug);
+    }
+    if (qtest_has_device("virtio-rng-ccw")) {
+        qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
+    }
+    if (qtest_has_device("virtio-rng-ccw")) {
+        qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
+        qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
+    }
 
     return g_test_run();
 }
-- 
2.31.1


