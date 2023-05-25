Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A87106F6
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q263p-0007ap-8h; Thu, 25 May 2023 04:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263S-0007XV-5U
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263K-0001pF-Bs
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpVT2fqNfBa4t7Ps3X2ZKsZiOwgmV+Yrf6yLOJS3RyI=;
 b=Y/jKVyYy2cQGgX+xWx1cxrJqIsgyrus9MbnPzv+DpgySUhkJhDv0HnThW7ZX7eBYuQu+/w
 ZVzRmoHs25f6BW+q3SoYg4s5x73HU9+Y1dBMXWowwtM8UiaTxsUp3xSct1VLXaGZbikpj4
 JU9CScsLvnqXu95wtZiCcU+fQrcJ8ls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-133edVTDPX-XzAj37wAIdA-1; Thu, 25 May 2023 04:10:28 -0400
X-MC-Unique: 133edVTDPX-XzAj37wAIdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C530D80231B;
 Thu, 25 May 2023 08:10:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB4B40C1438;
 Thu, 25 May 2023 08:10:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 4/4] tests/qtest/usb-hcd-ehci-test: Check for EHCI and UHCI
 HCDs before using them
Date: Thu, 25 May 2023 10:10:16 +0200
Message-Id: <20230525081016.1870364-5-thuth@redhat.com>
In-Reply-To: <20230525081016.1870364-1-thuth@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The devices might not be available in the binary (e.g. when compiling
with "--without-default-devices"), so we have to check before we can
use them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-ehci-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
index c51e8bb223..87e37cdd7c 100644
--- a/tests/qtest/usb-hcd-ehci-test.c
+++ b/tests/qtest/usb-hcd-ehci-test.c
@@ -149,6 +149,11 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
+    if (!qtest_has_device("ich9-usb-ehci1") ||
+        !qtest_has_device("ich9-usb-uhci1")) {
+        return 0;
+    }
+
     qtest_add_func("/ehci/pci/uhci-port-1", pci_uhci_port_1);
     qtest_add_func("/ehci/pci/ehci-port-1", pci_ehci_port_1);
     qtest_add_func("/ehci/pci/ehci-config", pci_ehci_config);
-- 
2.31.1


