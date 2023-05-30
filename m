Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E6715B87
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wTH-0000sd-0D; Tue, 30 May 2023 06:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3wTE-0000sF-JK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3wTC-0002HP-F6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685442049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qmBujEjmM2MihTQbd7uIC006lq83YbPQtfLtBcpWXPQ=;
 b=Onuda+xPk4YHnOnl0qZUz/anGQfvzDD6rjP1LIBuwsUQKh2PO2jLFJcmR+IPZCamBdgnRM
 ZgByrvhlKM0hjKvdEivEmMH1Rk5mqzrJ0oVRmY3vpccQqVnmNbO3Q7t6zcOtpHE51xvZCg
 lGKlo55S4c6thY/wj9I0X9CUxTiWvdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-bXCfvCMMOz-I1adyNr1-IA-1; Tue, 30 May 2023 06:20:45 -0400
X-MC-Unique: bXCfvCMMOz-I1adyNr1-IA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 431F785A5A8;
 Tue, 30 May 2023 10:20:44 +0000 (UTC)
Received: from thuth.com (unknown [10.39.194.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43F0E40C6EC4;
 Tue, 30 May 2023 10:20:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH] hw/ppc/Kconfig: MAC_NEWWORLD should always select USB_OHCI_PCI
Date: Tue, 30 May 2023 12:20:41 +0200
Message-Id: <20230530102041.55527-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The PowerMacs have an OHCI controller soldered on the motherboard,
so this should always be enabled for the "mac99" machine.
This fixes the problem that QEMU aborts when the user tries to run
the "mac99" machine with a build that has been compiled with the
"--without-default-devices" configure switch.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index a689d9b219..5dfbf47ef5 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -115,6 +115,7 @@ config MAC_NEWWORLD
     select MAC_PMU
     select UNIN_PCI
     select FW_CFG_PPC
+    select USB_OHCI_PCI
 
 config E500
     bool
-- 
2.31.1


