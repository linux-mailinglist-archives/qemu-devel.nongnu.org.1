Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8157E9AC7
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:10:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UnI-0006N2-Dv; Mon, 13 Nov 2023 06:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnG-0006Mo-2S
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnD-0001GS-Mj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7059P8v7D4DePdrXVTyWl9zAInk7m0mgqId+EYcbsaU=;
 b=R+XJN3C3WqLVdfz+vV6xD0TlT6LZH/BGApEcXTMRbpWy79esmN+JZK7Sq+9FKr+oqPi3nV
 UIlrEGrJJlMGI5R8MfcxFl8UmqZxPQKdYKnKWP9kGgRvPETeaE4ONabXdem57WN7BwKtyk
 DttDVTZGcIbnxZBA1t79ryHxH6csDkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-l5g_P6XaOZidAVBTIFmnfw-1; Mon, 13 Nov 2023 06:07:45 -0500
X-MC-Unique: l5g_P6XaOZidAVBTIFmnfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08E69185A780;
 Mon, 13 Nov 2023 11:07:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BEC42166B26;
 Mon, 13 Nov 2023 11:07:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 02/12] s390x/pci: bypass vfio DMA counting when using cdev
Date: Mon, 13 Nov 2023 12:07:30 +0100
Message-ID: <20231113110740.38270-3-thuth@redhat.com>
In-Reply-To: <20231113110740.38270-1-thuth@redhat.com>
References: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The current code assumes that there is always a vfio group, but
that's no longer guaranteed with the iommufd backend when using
cdev.  In this case, we don't need to track the vfio dma limit
anyway.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20231110175108.465851-2-mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-vfio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 59a2e03873..e28573b593 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -66,6 +66,10 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 
     assert(vpdev);
 
+    if (!vpdev->vbasedev.group) {
+        return NULL;
+    }
+
     id = vpdev->vbasedev.group->container->fd;
 
     if (!s390_pci_update_dma_avail(id, &avail)) {
-- 
2.41.0


