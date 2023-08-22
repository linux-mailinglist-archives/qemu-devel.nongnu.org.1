Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FB7847A0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:31:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUHU-0002GN-P0; Tue, 22 Aug 2023 12:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYUH7-0002Ec-UV
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYUH4-0003o2-5S
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692721832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rr1n7B3MlvcrdGLG6dgtsyVZYtZjkwyk6kXzDXGa68M=;
 b=UWOdPseUjs+lnUO7TDKYYMPijyEwAx1nAkgBu7WiqShtk0ESshbZM7z91A0l3nsyX9BFMW
 psGcUHBF/uGW0+Tsz9LKez1cW4vKm8piPh2lQUgGbk2CItVurSU+efqzRN1BoeQciXxBMo
 pOQt5poLZdjKYgsi6K+f6bZpDYoIlOg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-Cipn30zNO1WHfJRHDwjKow-1; Tue, 22 Aug 2023 12:30:28 -0400
X-MC-Unique: Cipn30zNO1WHfJRHDwjKow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763BC3C0FC8B;
 Tue, 22 Aug 2023 16:30:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 510DA64661;
 Tue, 22 Aug 2023 16:30:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] tests/qtest/usb-hcd-xhci-test: Check availability of devices
 before using them
Date: Tue, 22 Aug 2023 18:30:24 +0200
Message-Id: <20230822163024.61529-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The "usb-uas" and "usb-ccid" might not be compiled into the QEMU binary,
so let's better check first whether they are available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 10ef9d2a91..80bc039446 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -56,8 +56,12 @@ int main(int argc, char **argv)
 
     qtest_add_func("/xhci/pci/init", test_xhci_init);
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
-    qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
-    qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
+    if (qtest_has_device("usb-uas")) {
+        qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
+    }
+    if (qtest_has_device("usb-ccid")) {
+        qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
+    }
 
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,"
-- 
2.39.3


