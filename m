Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E070D533
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MXR-0003a6-62; Tue, 23 May 2023 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MX8-0003Dg-Ez
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MX5-0004Kq-Vv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsQEtFu86qtpZCVr4RgPVdKC4o3UgE51RQeohV4V0i8=;
 b=LKqHUMtd6+p1VQ8cmtA+61wCZN1G1N1V9gbtlWIqcuWFVf1hbNs3E3ODN764iB9ndxX19E
 Jp1vQMY0zeAJdPmSWWXmWLzof0oQQpGhjohOK4ZvoDllBwuOGvE7w2hMnpkpIXwENKbtm3
 X723ZuOAF4naKMZMco3EMKedhp6b2qs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-ZgVubTBSPGK2guBEWvahSg-1; Tue, 23 May 2023 03:34:06 -0400
X-MC-Unique: ZgVubTBSPGK2guBEWvahSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60EBF811E8D;
 Tue, 23 May 2023 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C24E2166B26;
 Tue, 23 May 2023 07:34:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 28/50] igb: Clear EICR bits for delayed MSI-X interrupts
Date: Tue, 23 May 2023 15:32:16 +0800
Message-Id: <20230523073238.54236-29-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

Section 7.3.4.1 says:
> When auto-clear is enabled for an interrupt cause, the EICR bit is
> set when a cause event mapped to this vector occurs. When the EITR
> Counter reaches zero, the MSI-X message is sent on PCIe. Then the
> EICR bit is cleared and enabled to be set by a new cause event

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 20645c4..edda07e 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -97,23 +97,31 @@ igb_lower_legacy_irq(IGBCore *core)
     pci_set_irq(core->owner, 0);
 }
 
-static void igb_msix_notify(IGBCore *core, unsigned int vector)
+static void igb_msix_notify(IGBCore *core, unsigned int cause)
 {
     PCIDevice *dev = core->owner;
     uint16_t vfn;
+    uint32_t effective_eiac;
+    unsigned int vector;
 
-    vfn = 8 - (vector + 2) / IGBVF_MSIX_VEC_NUM;
+    vfn = 8 - (cause + 2) / IGBVF_MSIX_VEC_NUM;
     if (vfn < pcie_sriov_num_vfs(core->owner)) {
         dev = pcie_sriov_get_vf_at_index(core->owner, vfn);
         assert(dev);
-        vector = (vector + 2) % IGBVF_MSIX_VEC_NUM;
-    } else if (vector >= IGB_MSIX_VEC_NUM) {
+        vector = (cause + 2) % IGBVF_MSIX_VEC_NUM;
+    } else if (cause >= IGB_MSIX_VEC_NUM) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "igb: Tried to use vector unavailable for PF");
         return;
+    } else {
+        vector = cause;
     }
 
     msix_notify(dev, vector);
+
+    trace_e1000e_irq_icr_clear_eiac(core->mac[EICR], core->mac[EIAC]);
+    effective_eiac = core->mac[EIAC] & BIT(cause);
+    core->mac[EICR] &= ~effective_eiac;
 }
 
 static inline void
@@ -1834,7 +1842,6 @@ igb_eitr_should_postpone(IGBCore *core, int idx)
 static void igb_send_msix(IGBCore *core)
 {
     uint32_t causes = core->mac[EICR] & core->mac[EIMS];
-    uint32_t effective_eiac;
     int vector;
 
     for (vector = 0; vector < IGB_INTR_NUM; ++vector) {
@@ -1842,10 +1849,6 @@ static void igb_send_msix(IGBCore *core)
 
             trace_e1000e_irq_msix_notify_vec(vector);
             igb_msix_notify(core, vector);
-
-            trace_e1000e_irq_icr_clear_eiac(core->mac[EICR], core->mac[EIAC]);
-            effective_eiac = core->mac[EIAC] & BIT(vector);
-            core->mac[EICR] &= ~effective_eiac;
         }
     }
 }
-- 
2.7.4


