Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FF70A243
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 23:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q086o-0005yv-2U; Fri, 19 May 2023 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086l-0005x7-Lr
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086k-0004FL-4Q
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684533473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppsSqBFmd85MY/HWcySwkiiUV0ay/ybg6reH9NMFing=;
 b=a0wjkSifUsoj7Cntn9saJkZrDlmzM3BmKyKjnQeO1+zE9WpdvXuC1R0/1rNVLHIU8VXkv6
 Mn5gbHS1t8+QnWPfq2pFXtRWOwgT8eTER3ucPmvrZOOocV+YAZWK87q4Tm2Y5XPwtQN6ea
 hLpnuFrMtWr3WpRem9Fy+xG08DqdEv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-QJ1nuUh6M9Cj3u7yf_XYhg-1; Fri, 19 May 2023 17:57:50 -0400
X-MC-Unique: QJ1nuUh6M9Cj3u7yf_XYhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE58A101A531;
 Fri, 19 May 2023 21:57:49 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52CA6C0004B;
 Fri, 19 May 2023 21:57:49 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 3/4] pcie: Add a PCIe capability version helper
Date: Fri, 19 May 2023 15:57:38 -0600
Message-Id: <20230519215739.402729-4-alex.williamson@redhat.com>
In-Reply-To: <20230519215739.402729-1-alex.williamson@redhat.com>
References: <20230519215739.402729-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


