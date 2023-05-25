Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D167106ED
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q263p-0007Zk-1k; Thu, 25 May 2023 04:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263I-0007Ps-NQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263G-0001lp-2c
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf0QEysBQmLAUzrcgp/g/w9XEAIZGYggIR7IKiFLMNQ=;
 b=fSlnj+bh8XOPoolS5G4dRKyheDoWsM+dr7IRsaFucPE2j2D1fjivMY+M1B15dTJe/OhgLj
 7ckmp+TNucen0sntHmV+Y7yIo5Ckx2NIXdihqhckvmhObVwZWVFqBLU3Wk6c+x8G3mtgun
 noEPxyUdw88xzZ+IKKG7XDBOQLqN2BU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-QtGDvFfiNDihqvfqAEjPAg-1; Thu, 25 May 2023 04:10:23 -0400
X-MC-Unique: QtGDvFfiNDihqvfqAEjPAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B8B0811E86;
 Thu, 25 May 2023 08:10:23 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB91A40C1258;
 Thu, 25 May 2023 08:10:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 1/4] tests/qtest/usb-hcd-uhci-test: Check whether
 "usb-storage" is available
Date: Thu, 25 May 2023 10:10:13 +0200
Message-Id: <20230525081016.1870364-2-thuth@redhat.com>
In-Reply-To: <20230525081016.1870364-1-thuth@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The "usb-storage" device might not have been compiled into the binary
(e.g. when compiling with "--without-default-devices"), so we have to
check first before using it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-uhci-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
index 84ac2f3c1a..28751f53da 100644
--- a/tests/qtest/usb-hcd-uhci-test.c
+++ b/tests/qtest/usb-hcd-uhci-test.c
@@ -74,7 +74,9 @@ int main(int argc, char **argv)
     qtest_add_func("/uhci/pci/init", test_uhci_init);
     qtest_add_func("/uhci/pci/port1", test_port_1);
     qtest_add_func("/uhci/pci/hotplug", test_uhci_hotplug);
-    qtest_add_func("/uhci/pci/hotplug/usb-storage", test_usb_storage_hotplug);
+    if (qtest_has_device("usb-storage")) {
+        qtest_add_func("/uhci/pci/hotplug/usb-storage", test_usb_storage_hotplug);
+    }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qs = qtest_pc_boot("%s", cmd);
-- 
2.31.1


