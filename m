Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BDE70D53A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWR-0000Fg-1o; Tue, 23 May 2023 03:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWO-00008X-VJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWN-0004E1-GQ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUsckqu04NeAp+FM00z+EbAu5al3WPnvC+vd+OAYN5k=;
 b=LVHowA+EGE1grkSAa1DCsgSXw94nPxWnKgnk80BpxmKvbxHEOj6MepsxOIy6rJAnfrS6CB
 cEWnoWyEcG21uRBaVxxtFcoDIv02/DmoxmUVgZ5lvhLBJDwFNyOQM41JeYJU/M9dT2d4Xf
 1+6LV5YMk2WFPjp/0nhS6qxrvfAcY0Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-912oNpsnPtO1w2UCFmyFeQ-1; Tue, 23 May 2023 03:33:22 -0400
X-MC-Unique: 912oNpsnPtO1w2UCFmyFeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 605E929DD98F;
 Tue, 23 May 2023 07:33:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC3AD2166B25;
 Tue, 23 May 2023 07:33:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 13/50] tests/avocado: Remove test_igb_nomsi_kvm
Date: Tue, 23 May 2023 15:32:01 +0800
Message-Id: <20230523073238.54236-14-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It is unlikely to find more bugs with KVM so remove test_igb_nomsi_kvm
to save time to run it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/avocado/netdev-ethtool.py | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/avocado/netdev-ethtool.py b/tests/avocado/netdev-ethtool.py
index 8de118e..6da800f 100644
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/avocado/netdev-ethtool.py
@@ -29,7 +29,7 @@ def get_asset(self, name, sha1):
         # URL into a unique one
         return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
 
-    def common_test_code(self, netdev, extra_args=None, kvm=False):
+    def common_test_code(self, netdev, extra_args=None):
 
         # This custom kernel has drivers for all the supported network
         # devices we can emulate in QEMU
@@ -57,9 +57,6 @@ def common_test_code(self, netdev, extra_args=None, kvm=False):
                          '-drive', drive,
                          '-device', netdev)
 
-        if kvm:
-            self.vm.add_args('-accel', 'kvm')
-
         self.vm.set_console(console_index=0)
         self.vm.launch()
 
@@ -86,13 +83,6 @@ def test_igb_nomsi(self):
         """
         self.common_test_code("igb", "pci=nomsi")
 
-    def test_igb_nomsi_kvm(self):
-        """
-        :avocado: tags=device:igb
-        """
-        self.require_accelerator('kvm')
-        self.common_test_code("igb", "pci=nomsi", True)
-
     # It seems the other popular cards we model in QEMU currently fail
     # the pattern test with:
     #
-- 
2.7.4


