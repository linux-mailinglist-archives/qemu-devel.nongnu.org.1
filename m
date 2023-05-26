Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D551712317
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRR-0002yB-69; Fri, 26 May 2023 05:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRP-0002wZ-Mi
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRO-0000iQ-6M
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHAj5Sdtzp9c1CV+g4uL/M86MOEDCpQItDSUIgjkW6s=;
 b=LCnsFLlEJdiCOqhFzM4mkL2P/SfrlTMUuTJE3/ch4LerH2Zp8kPMssw2Y0A++vcleEPTeK
 o0iT0HSxaQWxcB30RQvtu0KOOA6R291RCrQpQ4qmOoXQLYbyH5KW7bsiCJ13ZewEu71HAt
 481GvA9YMCpu5xm5SpFKpgmS5oyXojY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-H0ummxZFM9eJCI-eGireuw-1; Fri, 26 May 2023 05:08:49 -0400
X-MC-Unique: H0ummxZFM9eJCI-eGireuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B6C9101A531;
 Fri, 26 May 2023 09:08:49 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65161C15612;
 Fri, 26 May 2023 09:08:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PULL 06/15] hw/arm: Use MachineClass->default_nic in the sbsa-ref
 machine
Date: Fri, 26 May 2023 11:08:31 +0200
Message-Id: <20230526090840.2225958-7-thuth@redhat.com>
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Message-Id: <20230524082037.1620952-1-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
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


