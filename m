Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99171270D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Wwv-0007c7-Cn; Fri, 26 May 2023 08:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2Wws-0007bp-9l
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2Wwq-0002Ue-R8
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685105615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n3YKF/Hj9H3sDpQFXnzsqSBOt1jg+VStRQh4NGmBkLU=;
 b=dVlM14seP92oWQg6cghFpeVJJFwVeY6VVHRrPBPHMb+N82rwAMtEmAZf5dsq+HjMgw1Vho
 e+OUSM7YvBnLF0cYbZvYrJeJ7NrSUZ61eA5qgA3X3nHEZ1TETeZrjotXmY018Ae1L4Lf/u
 Z7zEgM+yiY0Boog0UCuB5v7ce2l04k4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-aSu8wXGHP7CDClD6D1BI5Q-1; Fri, 26 May 2023 08:53:33 -0400
X-MC-Unique: aSu8wXGHP7CDClD6D1BI5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88D9E811E85;
 Fri, 26 May 2023 12:53:33 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9CAA492B00;
 Fri, 26 May 2023 12:53:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/ppc/mac_newworld: Check for the availability of pci-ohci
 before using it
Date: Fri, 26 May 2023 14:53:23 +0200
Message-Id: <20230526125323.2386324-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

pci-ohci might habe been disabled in the QEMU binary (e.g. when "configure"
has been run with "--without-default-devices"). Thus we should check
for its availability before blindly using it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/mac_newworld.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 535710314a..c7cca430e1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -349,7 +349,8 @@ static void ppc_core99_init(MachineState *machine)
                                     sysbus_mmio_get_region(s, 3));
     }
 
-    machine->usb |= defaults_enabled() && !machine->usb_disabled;
+    machine->usb |= defaults_enabled() && !machine->usb_disabled &&
+                    module_object_class_by_name("pci-ohci") != 0;
     has_pmu = (core99_machine->via_config != CORE99_VIA_CONFIG_CUDA);
     has_adb = (core99_machine->via_config == CORE99_VIA_CONFIG_CUDA ||
                core99_machine->via_config == CORE99_VIA_CONFIG_PMU_ADB);
-- 
2.31.1


