Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05E76CF59
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCM5-0006MU-Sb; Wed, 02 Aug 2023 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCM4-0006Lh-C3
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCM3-00073U-1o
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690984654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+QED4Tq4XnPioa13QRpxi8srcldyyizEwfC5kFPupI=;
 b=gqEH63B+I2G1yAwIIVFypiODL4yM68Pyt+z+LnqbZPuCTjcGdk9751k25GZr2LZdZ2nckS
 hNiozWwn9JtDAdnnmfFB1xXo5keYBS9+KDXQqh948v5/XwIX7IXRraMWmW8p4N9t6v1ny+
 alg8bdIx/4hzB3M4sFFFjxpX3melyiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-F-RsgOHiNZuHduEslF6xWQ-1; Wed, 02 Aug 2023 09:57:29 -0400
X-MC-Unique: F-RsgOHiNZuHduEslF6xWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C21F5900824;
 Wed,  2 Aug 2023 13:57:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A6CE2166B26;
 Wed,  2 Aug 2023 13:57:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/6] hw/i386/intel_iommu: Fix trivial endianness problems
Date: Wed,  2 Aug 2023 15:57:18 +0200
Message-Id: <20230802135723.178083-2-thuth@redhat.com>
In-Reply-To: <20230802135723.178083-1-thuth@redhat.com>
References: <20230802135723.178083-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

After reading the guest memory with dma_memory_read(), we have
to make sure that we byteswap the little endian data to the host's
byte order.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/intel_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..13fcde8e91 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -756,6 +756,8 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
         return -VTD_FR_PASID_TABLE_INV;
     }
 
+    pdire->val = le64_to_cpu(pdire->val);
+
     return 0;
 }
 
@@ -780,6 +782,9 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
                         pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
         return -VTD_FR_PASID_TABLE_INV;
     }
+    for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
+        pe->val[i] = le64_to_cpu(pe->val[i]);
+    }
 
     /* Do translation type check */
     if (!vtd_pe_type_check(x86_iommu, pe)) {
-- 
2.39.3


