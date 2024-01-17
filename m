Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E7830205
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:17:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ225-0008SU-Mu; Wed, 17 Jan 2024 04:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ223-0008SI-55
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ221-0006az-OM
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705482980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFdoHAJ+lkGOTCUL+ieZy9Kht+Sp7cO/n/p8tGSPvWM=;
 b=YtDCL0ODgrehggU1KAlm7jFts5r+Y8LB+8FVYjeF3+rAp24dX3XTOELfc19bXKin5pNfA4
 mDFdinxnmWC3L+x+gNtsy+bAzBRBaVWxuBqSHdy+V0JSfUz7cyhJa8TPjrCiV5Y32YtJG5
 5opy1CRfV62nGPZv9VOA9I+6J3ewrPU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-lHz3sYrWNfmgrUBKKdIVrg-1; Wed,
 17 Jan 2024 04:16:19 -0500
X-MC-Unique: lHz3sYrWNfmgrUBKKdIVrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E419F280FEC8
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:16:18 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52AE92166B32;
 Wed, 17 Jan 2024 09:16:15 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com
Subject: [PATCH 3/4] intel_iommu: Tear down address spaces before IOMMU reset
Date: Wed, 17 Jan 2024 17:15:58 +0800
Message-ID: <20240117091559.144730-4-peterx@redhat.com>
In-Reply-To: <20240117091559.144730-1-peterx@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

No bug report for this, but logically tearing down of existing address
space should happen before reset of IOMMU state / registers, because the
current address spaces may still rely on those information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1a07faddb4..8b467cbbd2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4090,8 +4090,8 @@ static void vtd_reset(DeviceState *dev)
 {
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
 
-    vtd_init(s);
     vtd_address_space_refresh_all(s);
+    vtd_init(s);
 }
 
 static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
-- 
2.43.0


