Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CBF70BC6B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144J-0005gj-PY; Mon, 22 May 2023 07:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143n-0005GE-21
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143k-0007d7-EV
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4XsKwUfXPmKnBfzMNnH3bQnQVKi8Pv/O1wySE7Ga+4=;
 b=Mpps9daw6L8CV9BGq23VbHuMd/HUln/pVBPQdljqG8J0/OHYGlSRQu6kVfj/X3UnAx7Ch5
 /BCbW3DXX9fVYXaHpMuTNLNDKWL6YGtLUNot+u3CpQKfIa/nZqVlU4+O8N48Mzc4XbC0uT
 ibBuXQjeounSXn5R3OSC2XGefQed9Io=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-Isw2-MHIOb-JPDxLVqscvw-1; Mon, 22 May 2023 07:50:33 -0400
X-MC-Unique: Isw2-MHIOb-JPDxLVqscvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FD2B1C00046;
 Mon, 22 May 2023 11:50:33 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DE712166B26;
 Mon, 22 May 2023 11:50:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/20] tests/qtest/virtio-ccw-test: Remove superfluous tests
Date: Mon, 22 May 2023 13:50:08 +0200
Message-Id: <20230522115014.1110840-15-thuth@redhat.com>
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

virtio-balloon-ccw is already tested in the device-plug-test,
virtio-blk-ccw is already tested in cdrom-test, and virtio-net-ccw
is already tested in the pxe-test, so there is not much point
in doing "nop" tests here again.

Message-Id: <20230512124033.502654-15-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/virtio-ccw-test.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/tests/qtest/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
index 2de77bb6fe..c0790e3ba2 100644
--- a/tests/qtest/virtio-ccw-test.c
+++ b/tests/qtest/virtio-ccw-test.c
@@ -17,12 +17,6 @@
 #include "libqtest-single.h"
 #include "libqos/virtio.h"
 
-static void virtio_balloon_nop(void)
-{
-    global_qtest = qtest_initf("-device virtio-balloon-ccw");
-    qtest_end();
-}
-
 static void virtconsole_nop(void)
 {
     global_qtest = qtest_initf("-device virtio-serial-ccw,id=vser0 "
@@ -53,20 +47,6 @@ static void virtio_serial_hotplug(void)
     qtest_quit(qts);
 }
 
-static void virtio_blk_nop(void)
-{
-    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,"
-                               "file.read-zeroes=on,format=raw "
-                                "-device virtio-blk-ccw,drive=drv0");
-    qtest_end();
-}
-
-static void virtio_net_nop(void)
-{
-    global_qtest = qtest_initf("-device virtio-net-ccw");
-    qtest_end();
-}
-
 static void virtio_rng_nop(void)
 {
     global_qtest = qtest_initf("-device virtio-rng-ccw");
@@ -96,13 +76,10 @@ static void virtio_scsi_hotplug(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/balloon/nop", virtio_balloon_nop);
     qtest_add_func("/virtio/console/nop", virtconsole_nop);
     qtest_add_func("/virtio/serialport/nop", virtserialport_nop);
     qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
     qtest_add_func("/virtio/serial/hotplug", virtio_serial_hotplug);
-    qtest_add_func("/virtio/block/nop", virtio_blk_nop);
-    qtest_add_func("/virtio/net/nop", virtio_net_nop);
     qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
     qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
     qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
-- 
2.31.1


