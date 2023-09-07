Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518E79731C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeGAr-0005AD-GT; Thu, 07 Sep 2023 10:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeGAg-00059r-Tb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeGAe-0005Dr-CE
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694097587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bb3Uqhm9VwBogue/QgyNlF2e+ZocH6J2VpSRvaTUHVU=;
 b=AQkUi6ZxC873AgxY3ze2OGQHAdKUEa6FSy6cpoKwM9j7q6ibxacTFskXe3KTd9PsPFYnnt
 qfcDrbQXG6nYVyqVvJcbwWfb6Y4dXffuA4jCfG6pxsXL7KPWenSVNvSKVyTGigIsq4Gr9/
 FbH1ciD+Hhg5ihw44pCc3L12gugHu4Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-Og2n6qicMASPeg66FfL8Zw-1; Thu, 07 Sep 2023 10:39:45 -0400
X-MC-Unique: Og2n6qicMASPeg66FfL8Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7242C903E02;
 Thu,  7 Sep 2023 14:39:45 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5D5420BAE35;
 Thu,  7 Sep 2023 14:39:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] tests/qtest/usb-hcd: Remove the empty "init" tests
Date: Thu,  7 Sep 2023 16:39:42 +0200
Message-Id: <20230907143942.233219-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

These tests do nothing additional compared to the other test,
so let's remove the empty functions to avoid wasting some few
precious test cycles here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-uhci-test.c | 5 -----
 tests/qtest/usb-hcd-xhci-test.c | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/tests/qtest/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
index 28751f53da..4446555f08 100644
--- a/tests/qtest/usb-hcd-uhci-test.c
+++ b/tests/qtest/usb-hcd-uhci-test.c
@@ -17,10 +17,6 @@
 
 static QOSState *qs;
 
-static void test_uhci_init(void)
-{
-}
-
 static void test_port(int port)
 {
     struct qhc uhci;
@@ -71,7 +67,6 @@ int main(int argc, char **argv)
         return 0;
     }
 
-    qtest_add_func("/uhci/pci/init", test_uhci_init);
     qtest_add_func("/uhci/pci/port1", test_port_1);
     qtest_add_func("/uhci/pci/hotplug", test_uhci_hotplug);
     if (qtest_has_device("usb-storage")) {
diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 80bc039446..0cccfd85a6 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -11,11 +11,6 @@
 #include "libqtest-single.h"
 #include "libqos/usb.h"
 
-
-static void test_xhci_init(void)
-{
-}
-
 static void test_xhci_hotplug(void)
 {
     usb_test_hotplug(global_qtest, "xhci", "1", NULL);
@@ -54,7 +49,6 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/xhci/pci/init", test_xhci_init);
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     if (qtest_has_device("usb-uas")) {
         qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
-- 
2.39.3


