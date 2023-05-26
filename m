Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 768AB713045
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gfP-0004fa-2n; Fri, 26 May 2023 19:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfM-0004ei-J9
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfK-00082L-UV
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685142970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppsSqBFmd85MY/HWcySwkiiUV0ay/ybg6reH9NMFing=;
 b=Hh+Hjq3RKgjel8nIvcTmpkq5At7MxNNRuML4QEit+eV8eML5A0dHAOUC+FV4P4jxYGWcVX
 9g555qD/tkKVWu+UBMZpemP7+kUaDLQ+b7s1T/RIv/B8FU2X/GkE5Ch+BncS9kJB9+w1NI
 3PREdGSysLFY4tst6vh9ZIUiYxmxgtQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-1svPI7B4MU-_RFXXAGRaeQ-1; Fri, 26 May 2023 19:16:06 -0400
X-MC-Unique: 1svPI7B4MU-_RFXXAGRaeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 704BB2A2AD44;
 Fri, 26 May 2023 23:16:06 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0191140C1438;
 Fri, 26 May 2023 23:16:05 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 clg@redhat.com
Subject: [RFC PATCH v2 3/4] pcie: Add a PCIe capability version helper
Date: Fri, 26 May 2023 17:15:57 -0600
Message-Id: <20230526231558.1660396-4-alex.williamson@redhat.com>
In-Reply-To: <20230526231558.1660396-1-alex.williamson@redhat.com>
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

Report the PCIe capability version for a device

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pcie.c         | 7 +++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b8c24cf45f7e..b7f107ed8dd4 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -274,6 +274,13 @@ uint8_t pcie_cap_get_type(const PCIDevice *dev)
             PCI_EXP_FLAGS_TYPE) >> PCI_EXP_FLAGS_TYPE_SHIFT;
 }
 
+uint8_t pcie_cap_get_version(const PCIDevice *dev)
+{
+    uint32_t pos = dev->exp.exp_cap;
+    assert(pos > 0);
+    return pci_get_word(dev->config + pos + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_VERS;
+}
+
 /* MSI/MSI-X */
 /* pci express interrupt message number */
 /* 7.8.2 PCI Express Capabilities Register: Interrupt Message Number */
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 3cc2b159570f..51ab57bc3c50 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -93,6 +93,7 @@ void pcie_cap_exit(PCIDevice *dev);
 int pcie_endpoint_cap_v1_init(PCIDevice *dev, uint8_t offset);
 void pcie_cap_v1_exit(PCIDevice *dev);
 uint8_t pcie_cap_get_type(const PCIDevice *dev);
+uint8_t pcie_cap_get_version(const PCIDevice *dev);
 void pcie_cap_flags_set_vector(PCIDevice *dev, uint8_t vector);
 uint8_t pcie_cap_flags_get_vector(PCIDevice *dev);
 
-- 
2.39.2


