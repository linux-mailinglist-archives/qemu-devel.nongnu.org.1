Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAB71231F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRV-00035P-11; Fri, 26 May 2023 05:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRS-0002zT-3f
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRQ-0000iw-Kg
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZZx3B25Wj3YuEZ2HOnTvDgUDAEPRVELYqzbvcmGB8E=;
 b=XdsH5h/3UFFCIOCZkWzoG5O5iifBGeNKS8k+VJ0iudSrtuapI4GY5xZ7EL9FoTrloSMv8h
 wDs6O/8b/B9kSpmLSrv5Xx/Rfgcr7agTMPpplpF4v3VY+Ds9/Ipvme561zHyOxQdAjbH7t
 8buyhiL4oCpMVaBry1JXvJvIt7E/tnM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-orIIUjMjOcyryx6K4j0C4w-1; Fri, 26 May 2023 05:08:54 -0400
X-MC-Unique: orIIUjMjOcyryx6K4j0C4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4384D3C0D185;
 Fri, 26 May 2023 09:08:54 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC40C154D1;
 Fri, 26 May 2023 09:08:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PULL 10/15] tests/qtest/rtl8139-test: Check whether the rtl8139
 device is available
Date: Fri, 26 May 2023 11:08:35 +0200
Message-Id: <20230526090840.2225958-11-thuth@redhat.com>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
References: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Though we are already using CONFIG_RTL8139_PCI in the meson.build file
for testing whether the rtl8139 device is available or not, this is not
enough: The CONFIG switch might have been selected by another target
(e.g. the mips fuloong2e machine has the rtl8139 chip soldered on the
board), so CONFIG_RTL8139_PCI ends up in config_all_devices and the
test then gets executed on x86. We need an additional run-time check
to be on the safe side to make this test also work when configure has
been run with "--without-default-devices".

Message-Id: <20230525081016.1870364-4-thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


