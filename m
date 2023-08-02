Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F876CF5A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCMS-0006Rr-84; Wed, 02 Aug 2023 09:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCMO-0006Rf-ER
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCM9-00074x-E7
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690984660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y58QJ+HM5AUg9VJaPlDysLRwUH90Md2RzqdmDtVUpOY=;
 b=NNLV+JrJ5cYgQicOBb5+5Z+i4ih0AYKmLbR0bOc+s9kx0s7CJh6ZbN696X+x7dghGtGvAz
 aKZLs2pER1qhuEJ1yKWFU8+l1Hovy5x7g1rbhxfTQlFlWzbWET7Ng5hSfqPpsszzkjWzdt
 e+qmnxfSZjpEqhW1o9KNowLKiBYG5Ig=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-oDdnLQx_Mn-jzFhcnFZx3Q-1; Wed, 02 Aug 2023 09:57:37 -0400
X-MC-Unique: oDdnLQx_Mn-jzFhcnFZx3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2092D29AA3B7;
 Wed,  2 Aug 2023 13:57:37 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA2CC2166B25;
 Wed,  2 Aug 2023 13:57:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/6] include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage
 for big endian hosts
Date: Wed,  2 Aug 2023 15:57:23 +0200
Message-Id: <20230802135723.178083-7-thuth@redhat.com>
In-Reply-To: <20230802135723.178083-1-thuth@redhat.com>
References: <20230802135723.178083-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The first bitfield here is supposed to be used as a 64-bit equivalent
to the "uint64_t msi_addr" in the union. To make this work correctly
on big endian hosts, too, the __addr_hi field has to be part of the
bitfield, and the the bitfield members must be declared with "uint64_t"
instead of "uint32_t" - otherwise the values are placed in the wrong
bytes on big endian hosts.

Same applies to the 32-bit "msi_data" field: __resved1 must be part
of the bitfield, and the members must be declared with "uint32_t"
instead of "uint16_t".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/x86-iommu.h | 50 +++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 8d8d53b18b..bfd21649d0 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -87,40 +87,42 @@ struct X86IOMMU_MSIMessage {
     union {
         struct {
 #if HOST_BIG_ENDIAN
-            uint32_t __addr_head:12; /* 0xfee */
-            uint32_t dest:8;
-            uint32_t __reserved:8;
-            uint32_t redir_hint:1;
-            uint32_t dest_mode:1;
-            uint32_t __not_used:2;
+            uint64_t __addr_hi:32;
+            uint64_t __addr_head:12; /* 0xfee */
+            uint64_t dest:8;
+            uint64_t __reserved:8;
+            uint64_t redir_hint:1;
+            uint64_t dest_mode:1;
+            uint64_t __not_used:2;
 #else
-            uint32_t __not_used:2;
-            uint32_t dest_mode:1;
-            uint32_t redir_hint:1;
-            uint32_t __reserved:8;
-            uint32_t dest:8;
-            uint32_t __addr_head:12; /* 0xfee */
+            uint64_t __not_used:2;
+            uint64_t dest_mode:1;
+            uint64_t redir_hint:1;
+            uint64_t __reserved:8;
+            uint64_t dest:8;
+            uint64_t __addr_head:12; /* 0xfee */
+            uint64_t __addr_hi:32;
 #endif
-            uint32_t __addr_hi;
         } QEMU_PACKED;
         uint64_t msi_addr;
     };
     union {
         struct {
 #if HOST_BIG_ENDIAN
-            uint16_t trigger_mode:1;
-            uint16_t level:1;
-            uint16_t __resved:3;
-            uint16_t delivery_mode:3;
-            uint16_t vector:8;
+            uint32_t __resved1:16;
+            uint32_t trigger_mode:1;
+            uint32_t level:1;
+            uint32_t __resved:3;
+            uint32_t delivery_mode:3;
+            uint32_t vector:8;
 #else
-            uint16_t vector:8;
-            uint16_t delivery_mode:3;
-            uint16_t __resved:3;
-            uint16_t level:1;
-            uint16_t trigger_mode:1;
+            uint32_t vector:8;
+            uint32_t delivery_mode:3;
+            uint32_t __resved:3;
+            uint32_t level:1;
+            uint32_t trigger_mode:1;
+            uint32_t __resved1:16;
 #endif
-            uint16_t __resved1;
         } QEMU_PACKED;
         uint32_t msi_data;
     };
-- 
2.39.3


