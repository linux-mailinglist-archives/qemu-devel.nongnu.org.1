Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8818766FA9
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPORp-0002v7-So; Fri, 28 Jul 2023 10:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORl-0002tm-W7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORk-0006wn-F7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690554479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMtECrFmf0lC7U3IiFxWuYmpCKS2BR0qcY3sUID0KiY=;
 b=NAAWqFLR52SaYWLPLPwZjo8DK6EBfp37/OXeHl6ZDErj6uZIfkr2d2dq89e19Si+VIaDSK
 Zz6PyJGJIjFejdhpl/O4KZ1JoEp7aI9XWVqaCtwv0KWNUKtPiXxjfKdorF/OwJL/CWvxlo
 ZKAxu2ZZ5vBdk2LvU1z6bjnwpPH2PX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-JNu256DoMu2RvKP6Q8NYWw-1; Fri, 28 Jul 2023 10:27:58 -0400
X-MC-Unique: JNu256DoMu2RvKP6Q8NYWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD7FB8022EF;
 Fri, 28 Jul 2023 14:27:57 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20B340C2063;
 Fri, 28 Jul 2023 14:27:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 4/6] hw/i386/intel_iommu: Fix VTD_IR_TableEntry for
 ms_struct layout
Date: Fri, 28 Jul 2023 16:27:46 +0200
Message-Id: <20230728142748.305341-5-thuth@redhat.com>
In-Reply-To: <20230728142748.305341-1-thuth@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

We might want to compile QEMU with Clang on Windows - but it
does not support the __attribute__((gcc_struct)) yet. So we
have to make sure that the structs will stay the same when
the compiler uses the "ms_struct" layout. The VTD_IR_TableEntry
struct is affected - rewrite it a little bit so that it works
fine with both struct layouts.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/intel_iommu.h | 14 ++++++++------
 hw/i386/intel_iommu.c         |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 89dcbc5e1e..08bf220393 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -204,18 +204,20 @@ union VTD_IR_TableEntry {
 #endif
         uint32_t dest_id;            /* Destination ID */
         uint16_t source_id;          /* Source-ID */
+        uint16_t __reserved_2;       /* Reserved 2 */
 #if HOST_BIG_ENDIAN
-        uint64_t __reserved_2:44;    /* Reserved 2 */
-        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
-        uint64_t sid_q:2;            /* Source-ID Qualifier */
+        uint32_t __reserved_3:28;    /* Reserved 3 */
+        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
+        uint32_t sid_q:2;            /* Source-ID Qualifier */
 #else
-        uint64_t sid_q:2;            /* Source-ID Qualifier */
-        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
-        uint64_t __reserved_2:44;    /* Reserved 2 */
+        uint32_t sid_q:2;            /* Source-ID Qualifier */
+        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
+        uint32_t __reserved_3:28;    /* Reserved 3 */
 #endif
     } QEMU_PACKED irte;
     uint64_t data[2];
 };
+QEMU_BUILD_BUG_ON(sizeof(union VTD_IR_TableEntry) != 16);
 
 #define VTD_IR_INT_FORMAT_COMPAT     (0) /* Compatible Interrupt */
 #define VTD_IR_INT_FORMAT_REMAP      (1) /* Remappable Interrupt */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..d5c5ee0751 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3335,7 +3335,7 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     }
 
     if (entry->irte.__reserved_0 || entry->irte.__reserved_1 ||
-        entry->irte.__reserved_2) {
+        entry->irte.__reserved_2 || entry->irte.__reserved_3) {
         error_report_once("%s: detected non-zero reserved IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
                           __func__, index, le64_to_cpu(entry->data[1]),
-- 
2.39.3


