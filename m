Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8970F087
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jjo-0006XS-F6; Wed, 24 May 2023 04:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1jjk-0006X1-4U
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1jji-0005i3-IG
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684916445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tKoJGBYIgfApa6z6v9N/YjXhD95adNm6Ki5W9wz0M50=;
 b=Jwmb3/Z0jduNST48tgS/R1twwscCFSwBbvokAsB6oYy5R6fb7a6baGYbLSNz8cRNJrRNUp
 0PV2S/BqKtv0vxsTKPtu4F3J0S42lopzEDm3buLSxuxwifotCFNlBK6LtZlop+opHA86tj
 KHDDO1X4erzUCHL+zeArsT42C/TPais=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-vQKVsVF5N7W2CRucLPEOWA-1; Wed, 24 May 2023 04:20:40 -0400
X-MC-Unique: vQKVsVF5N7W2CRucLPEOWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC5ED8007D9;
 Wed, 24 May 2023 08:20:39 +0000 (UTC)
Received: from thuth.com (unknown [10.39.194.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3FF37AE4;
 Wed, 24 May 2023 08:20:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH] hw/arm: Use MachineClass->default_nic in the sbsa-ref machine
Date: Wed, 24 May 2023 10:20:37 +0200
Message-Id: <20230524082037.1620952-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/sbsa-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 792371fdce..9c3e670ec6 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -596,6 +596,7 @@ static void create_pcie(SBSAMachineState *sms)
     hwaddr size_mmio_high = sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size;
     hwaddr base_pio = sbsa_ref_memmap[SBSA_PCIE_PIO].base;
     int irq = sbsa_ref_irqmap[SBSA_PCIE];
+    MachineClass *mc = MACHINE_GET_CLASS(sms);
     MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
     MemoryRegion *ecam_alias, *ecam_reg;
     DeviceState *dev;
@@ -641,7 +642,7 @@ static void create_pcie(SBSAMachineState *sms)
             NICInfo *nd = &nd_table[i];
 
             if (!nd->model) {
-                nd->model = g_strdup("e1000e");
+                nd->model = g_strdup(mc->default_nic);
             }
 
             pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
@@ -858,6 +859,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
+    mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
     mc->default_cpus = 4;
-- 
2.31.1


