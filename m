Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AB170BC65
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144N-0005iL-8T; Mon, 22 May 2023 07:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143i-0005DH-Cg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143g-0007ba-CQ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KtyVBFc1fHyqJE7iYbiDrEuQQX0YRCX1xDBYjW/HC88=;
 b=QsKSuQmjbtaWdL/xzdJNxWPtFxlgc1tXyELT1Adobf50LPgO14PrCLU3ZLVFQ6xt2776n7
 T7bWgbl8eiJ2v6Bxovx4WzrIhwLTcFJfzgPxJfg09+biFNHQJEH0SQXuUw7cqstdORSvt1
 Pg1rK7RJdUpYhyQmxcN7+3mmOfXmSog=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-BAaVnvRaMjaMNLk2NH-XCg-1; Mon, 22 May 2023 07:50:32 -0400
X-MC-Unique: BAaVnvRaMjaMNLk2NH-XCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C71D381D1E8;
 Mon, 22 May 2023 11:50:32 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 478562166B26;
 Mon, 22 May 2023 11:50:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/20] tests/qtest/cdrom-test: Fix the test to also work
 without optional devices
Date: Mon, 22 May 2023 13:50:07 +0200
Message-Id: <20230522115014.1110840-14-thuth@redhat.com>
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

It's possible to disable virtio-scsi and virtio-blk in the binaries,
so we must not run the corresponding tests if these devices are missing.

Message-Id: <20230512124033.502654-14-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cdrom-test.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 2b7e10d920..d1cc375849 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -136,9 +136,12 @@ static void add_x86_tests(void)
     }
 
     qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
-    qtest_add_data_func("cdrom/boot/virtio-scsi",
-                        "-device virtio-scsi -device scsi-cd,drive=cdr "
-                        "-blockdev file,node-name=cdr,filename=", test_cdboot);
+    if (qtest_has_device("virtio-scsi-ccw")) {
+        qtest_add_data_func("cdrom/boot/virtio-scsi",
+                            "-device virtio-scsi -device scsi-cd,drive=cdr "
+                            "-blockdev file,node-name=cdr,filename=",
+                            test_cdboot);
+    }
     /*
      * Unstable CI test under load
      * See https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05509.html
@@ -183,10 +186,17 @@ static void add_s390x_tests(void)
 {
     if (!qtest_has_accel("tcg") && !qtest_has_accel("kvm")) {
         g_test_skip("No KVM or TCG accelerator available, skipping boot tests");
+    }
+    if (!qtest_has_device("virtio-blk-ccw")) {
         return;
     }
 
     qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
+
+    if (!qtest_has_device("virtio-scsi-ccw")) {
+        return;
+    }
+
     qtest_add_data_func("cdrom/boot/virtio-scsi",
                         "-device virtio-scsi -device scsi-cd,drive=cdr "
                         "-blockdev file,node-name=cdr,filename=", test_cdboot);
-- 
2.31.1


