Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F270BC6D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144q-0006Ux-Nv; Mon, 22 May 2023 07:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143g-0005CE-BJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143e-0007au-Ca
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWN+12IWf/zj5AbaionYtYGdyUfi2QktvaTO4E1KFAM=;
 b=ik0eUKDyjzoKhc+kvwUrL9vcr6eAoIwQEgz9YlTD0F/iB+fOLaZviJU83zWbYql4Aud6Bq
 jL+sQkrONmou2CWh9IEGRIFl2IyxhxYFEqpflk/UPF/1auNkYWQQ+IVrayvaPAoj/kelKI
 ZDUMH3s/ytljTMFTf+kEvBhV23ZJxZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-ZB9O5LwSOFGCoqjnxdOaIA-1; Mon, 22 May 2023 07:50:31 -0400
X-MC-Unique: ZB9O5LwSOFGCoqjnxdOaIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0704485A5BA;
 Mon, 22 May 2023 11:50:31 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6AAA2166B26;
 Mon, 22 May 2023 11:50:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/20] tests/qtest/usb-hcd-uhci-test: Skip test if UHCI
 controller is not available
Date: Mon, 22 May 2023 13:50:06 +0200
Message-Id: <20230522115014.1110840-13-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
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

The test is already fenced with CONFIG_USB_UHCI in meson.build, but in
case we build the ppc or mips targets in parallel, this config switch
is still set in "config_all_devices" and thus the test is still run.
Thus we need an explicit additional check here before adding the tests
to the test plan.

Message-Id: <20230512124033.502654-13-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-uhci-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
index f264d2bf73..84ac2f3c1a 100644
--- a/tests/qtest/usb-hcd-uhci-test.c
+++ b/tests/qtest/usb-hcd-uhci-test.c
@@ -66,6 +66,11 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
+    if (!qtest_has_device("piix3-usb-uhci")) {
+        g_debug("piix3-usb-uhci not available");
+        return 0;
+    }
+
     qtest_add_func("/uhci/pci/init", test_uhci_init);
     qtest_add_func("/uhci/pci/port1", test_port_1);
     qtest_add_func("/uhci/pci/hotplug", test_uhci_hotplug);
-- 
2.31.1


