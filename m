Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752A70F052
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jZu-0002H0-MC; Wed, 24 May 2023 04:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1jZp-0002Eb-LT
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1jZo-0002d1-91
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684915831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PuZ58S5AOi77T8cZKaaWDXvqyBaIpwEm7YYkRxtvZbI=;
 b=ZpM+fHYXPQvrIIgE70r4Oo/PwQAhCoyEQOzjevJlcxFasZUSOOwBFuf5ef6MT7JjOKJSjk
 0RuOJHnoSNwdg52YXEhUEWIDX8tm597iKwqmBIY+oAo+zk9adi0vbjkelvGptc5+F/7w8+
 bmcxQTQYoF9dIdJUxSV3is0gA2snAls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-Q7XdHpHTNCyQOZPrzKLVpQ-1; Wed, 24 May 2023 04:10:27 -0400
X-MC-Unique: Q7XdHpHTNCyQOZPrzKLVpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D266880231B;
 Wed, 24 May 2023 08:10:26 +0000 (UTC)
Received: from thuth.com (unknown [10.39.194.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2C4940CFD45;
 Wed, 24 May 2023 08:10:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Corey Minyard <minyard@acm.org>
Subject: [PATCH] tests/qtest: Run ipmi-bt-test only if CONFIG_IPMI_EXTERN is
 set
Date: Wed, 24 May 2023 10:10:24 +0200
Message-Id: <20230524081024.1619273-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The ipmi-bt-test uses "-device ipmi-bmc-extern", thus it should
only be run if this device has been enabled in the configuration.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 087f2dc9d7..1d8a53a669 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -49,7 +49,8 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
   (config_host.has_key('CONFIG_LINUX') and                                                  \
-   config_all_devices.has_key('CONFIG_ISA_IPMI_BT') ? ['ipmi-bt-test'] : []) +              \
+   config_all_devices.has_key('CONFIG_ISA_IPMI_BT') and
+   config_all_devices.has_key('CONFIG_IPMI_EXTERN') ? ['ipmi-bt-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_WDT_IB700') ? ['wdt_ib700-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PVPANIC_ISA') ? ['pvpanic-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PVPANIC_PCI') ? ['pvpanic-pci-test'] : []) +          \
-- 
2.31.1


