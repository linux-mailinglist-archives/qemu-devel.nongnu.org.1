Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8437E9ABE
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UnM-0006Oa-1Y; Mon, 13 Nov 2023 06:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnI-0006Nc-Jn
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnG-0001Gh-5t
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQtG9NtTnHgyTIqAeLRJ1Cqt+R0FDQoDmBEkUZJB2A0=;
 b=Et5lT3xOOEeGmTn9AspRIxILfmkcmIp6f3vMClPbfF0oQndHt3bQmls3cBaj8cm9ZjTt2B
 +DDQ6AaeT/lxwZDkXE+EwKNYfrxByM7UiLawT4Dp7sB8barASmffmiS6FUZlwp3YTxYEXS
 dzdm2AF/spFY+0dEWTt0CS1MK+JIT88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-0WabfnXrNQ6joIN-zMwgIg-1; Mon, 13 Nov 2023 06:07:46 -0500
X-MC-Unique: 0WabfnXrNQ6joIN-zMwgIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B6AF811E7E;
 Mon, 13 Nov 2023 11:07:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4BE2166B26;
 Mon, 13 Nov 2023 11:07:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 03/12] s390x/pci: only limit DMA aperture if vfio DMA limit
 reported
Date: Mon, 13 Nov 2023 12:07:31 +0100
Message-ID: <20231113110740.38270-4-thuth@redhat.com>
In-Reply-To: <20231113110740.38270-1-thuth@redhat.com>
References: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

If the host kernel lacks vfio DMA limit reporting, do not attempt
to shrink the guest DMA aperture.

Fixes: df202e3ff3 ("s390x/pci: shrink DMA aperture to be bound by vfio DMA limit")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20231110175108.465851-3-mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index e28573b593..7dbbc76823 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -136,7 +136,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
      * to the guest based upon the vfio DMA limit.
      */
     vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
-    if (vfio_size < (cap->end_dma - cap->start_dma + 1)) {
+    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
         pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
     }
 }
-- 
2.41.0


