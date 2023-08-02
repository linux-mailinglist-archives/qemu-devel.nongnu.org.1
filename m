Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF976CF56
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCM9-0006Nl-9s; Wed, 02 Aug 2023 09:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCM8-0006NA-10
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCM5-000741-6I
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690984656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tC+DnvIXXhc061pn81v7KyxaCnhw0iKUBiHRIit2C4c=;
 b=W73t3NwIrN1wQvhMpFqa4YKnWCGuNvBmmB5VA6qfCk1Mbv/kpkZTFLhYkGNgVV0Bc3w0i/
 TI5KD708gGA7j0qFrlsJgwmQFz3ukIDac8xGfCwRPC9E37FLLdwnqSq6qfeyGTe5nmdQi5
 IAXmhSaWGlP9sA7prqo6ZF/F4ZEgXyU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157--vtkqXBINx-hD5mVaArmvA-1; Wed, 02 Aug 2023 09:57:33 -0400
X-MC-Unique: -vtkqXBINx-hD5mVaArmvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BD002834764;
 Wed,  2 Aug 2023 13:57:32 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0C002166B25;
 Wed,  2 Aug 2023 13:57:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/6] hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big
 endian hosts
Date: Wed,  2 Aug 2023 15:57:20 +0200
Message-Id: <20230802135723.178083-4-thuth@redhat.com>
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

On big endian hosts, we need to reverse the bitfield order in the
struct VTDInvDescIEC, just like it is already done for the other
bitfields in the various structs of the intel-iommu device.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2e61eec2f5..e1450c5cfe 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -321,12 +321,21 @@ typedef enum VTDFaultReason {
 
 /* Interrupt Entry Cache Invalidation Descriptor: VT-d 6.5.2.7. */
 struct VTDInvDescIEC {
+#if HOST_BIG_ENDIAN
+    uint64_t reserved_2:16;
+    uint64_t index:16;          /* Start index to invalidate */
+    uint64_t index_mask:5;      /* 2^N for continuous int invalidation */
+    uint64_t resved_1:22;
+    uint64_t granularity:1;     /* If set, it's global IR invalidation */
+    uint64_t type:4;            /* Should always be 0x4 */
+#else
     uint32_t type:4;            /* Should always be 0x4 */
     uint32_t granularity:1;     /* If set, it's global IR invalidation */
     uint32_t resved_1:22;
     uint32_t index_mask:5;      /* 2^N for continuous int invalidation */
     uint32_t index:16;          /* Start index to invalidate */
     uint32_t reserved_2:16;
+#endif
 };
 typedef struct VTDInvDescIEC VTDInvDescIEC;
 
-- 
2.39.3


