Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A94647106E8
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q263p-0007aa-68; Thu, 25 May 2023 04:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263V-0007Xm-8o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263P-0001pV-JB
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/6hVTanJJCeePDiYYpj7FAlQnkkPLhqWkjlTZACNuU=;
 b=KwdrKm0w2hVu2PakBp8obcUugPiMy0Ez1/9yN42ixAPITzhzaamwZ9GdxlsgaH6SMEdlIn
 gi8YEGQh13oAuuTQyk/F6l5BhpRz+X3hL7FNiojpdPzvA5MK9h03rB0FlAx1tJU338Fht2
 iu6q0itP1KSADSKJd0cBJppn6IUEz74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-y6ZScc86PnWjkRvtoBlo0Q-1; Thu, 25 May 2023 04:10:26 -0400
X-MC-Unique: y6ZScc86PnWjkRvtoBlo0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E060185A78F;
 Thu, 25 May 2023 08:10:26 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEC8B400E118;
 Thu, 25 May 2023 08:10:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 3/4] tests/qtest/rtl8139-test: Check whether the rtl8139
 device is available
Date: Thu, 25 May 2023 10:10:15 +0200
Message-Id: <20230525081016.1870364-4-thuth@redhat.com>
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

Though we are already using CONFIG_RTL8139_PCI in the meson.build file
for testing whether the rtl8139 device is available or not, this is not
enough: The CONFIG switch might have been selected by another target
(e.g. the mips fuloong2e machine has the rtl8139 chip soldered on the
board), so CONFIG_RTL8139_PCI ends up in config_all_devices and the
test then gets executed on x86. We need an additional run-time check
to be on the safe side to make this test also work when configure has
been run with "--without-default-devices".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/rtl8139-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/rtl8139-test.c b/tests/qtest/rtl8139-test.c
index 4bd240e9ee..4dc0a0d22e 100644
--- a/tests/qtest/rtl8139-test.c
+++ b/tests/qtest/rtl8139-test.c
@@ -209,6 +209,10 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
+    if (!qtest_has_device("rtl8139")) {
+        return 0;
+    }
+
     qtest_start("-device rtl8139");
 
     qtest_add_func("/rtl8139/nop", nop);
-- 
2.31.1


