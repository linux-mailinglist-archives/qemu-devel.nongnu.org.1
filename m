Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A4A3D0D4
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 06:35:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkzDQ-0000eo-Rz; Thu, 20 Feb 2025 00:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1tkzDO-0000eb-Fe
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 00:35:14 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1tkzDI-0004gn-IB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 00:35:14 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250220052847epoutp013ffa6f99afee08a936d9d12633aee182~l03RMkRpp2880928809epoutp01W
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:28:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250220052847epoutp013ffa6f99afee08a936d9d12633aee182~l03RMkRpp2880928809epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1740029327;
 bh=9NhaPdm3BDTOK0IhaPe0WxEZpnRK6Icu6IAR630h+CY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A3XS+I5CyfVO99SgTjMXLeGz4tD65f8VpRYDzYJREFpgFRWo+RJ4/WhBburGufP37
 8QES/4etBgg19IaHWlNqew+pqI9bA2HpqETk7PaGbQIFxkL0y+xm2zraGmViSaSQwR
 Y2IytSAKsmwggFJIcEtDFk3utyViUkg41ae0mVnE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20250220052847epcas5p405d0e17209f8ad8c11d7262e2b0cceb2~l03Q5UqTJ1412414124epcas5p4h;
 Thu, 20 Feb 2025 05:28:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Yz1yP15tlz4x9Pr; Thu, 20 Feb
 2025 05:28:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 72.BE.20052.C8DB6B76; Thu, 20 Feb 2025 14:28:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250220052736epcas5p254a601a6710b3fd58a827ca99680d746~l02PHLk2M1855518555epcas5p2b;
 Thu, 20 Feb 2025 05:27:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250220052736epsmtrp288a7c12049f09d7eaa8658b90aa37fd4~l02PGdO-a3134831348epsmtrp2E;
 Thu, 20 Feb 2025 05:27:36 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-39-67b6bd8c218b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 00.CA.23488.84DB6B76; Thu, 20 Feb 2025 14:27:36 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250220052734epsmtip2aea6b1e5abe1ad6084c72ccaf496d5d5~l02NoNXuA1496914969epsmtip2T;
 Thu, 20 Feb 2025 05:27:34 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH v3 2/3] hw/cxl: factor out calculation of sanitize duration
 from cmd_santize_overwrite
Date: Thu, 20 Feb 2025 10:57:23 +0530
Message-Id: <20250220052724.1256642-3-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220052724.1256642-1-vinayak.kh@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpm7v3m3pBms3MFtMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
 VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
 6Xp5qSVWhgYGRqZAhQnZGR9/nmQt6JSvuPK2lbGBcYFYFyMnh4SAicSzpV+Yuhi5OIQEdjNK
 TDvZwA7hfGKUmDS9hQ3C+cYocfH6dXaYlgmf+6Fa9jJKfFswC8ppYJKYeGEZG0gVm4CBxIPm
 42AdIgKSEr+7TjOD2MwCHxglFj3V7WLk4BAWyJC4/zkbxGQRUJW4ctQepIJXwFbizdqvzBC7
 5CX2HzwLZnMK2EnsezqdHaJGUOLkzCcsEBPlJZq3zmYGOUFCoJdDYsbFnVDNLhJTf7xgg7CF
 JV4d3wL1gJTE53d7oeLFEucufmKEsGskXnetgOq1l2g91c8MchuzgKbE+l36EGFZiamn1jFB
 7OWT6P39hAkiziuxYx6IzQFkq0gsfZsJs+nLs2ao6R4Sq240QwN3IqPEzZeH2ScwKsxC8s4s
 JO/MQti8gJF5FaNkakFxbnpqsWmBYV5qOTyOk/NzNzGCU6mW5w7Guw8+6B1iZOJgPMQowcGs
 JMLbVr8lXYg3JbGyKrUoP76oNCe1+BCjKTC4JzJLiSbnA5N5Xkm8oYmlgYmZmZmJpbGZoZI4
 b/POlnQhgfTEktTs1NSC1CKYPiYOTqkGJqEa6eMWnfzn/E2Ef2ec0Vt9rmNWWnLj0i71jQ0n
 5nBftDedqZN+weyZ7yXFnQnPJ243sdniGbD5RdO9kDWz/54UfFUYtK/v6uHO33XhHg4qT87p
 qKi/SN9uEmKk8CczT+fC1gi/u4vO3HzP3uf8J+yk5ryVCif5Nr7y8z7VuU1ysssBhWO/p07d
 F+hrv/u9zvuOVWaGIaWx5Utszp1nWuNrdeGNBvcnr20Rs3krZHRO5Krl8V5v8Wf8FZvSv9po
 k7XyoX2fpi5N5HELdn23UNJ9Yt6tr5rf2OVXTmLcf2C6A7vk/31L5jW1TXq9KXJ9+oRWYWHd
 +ZNjQqaHbtyxeML5h1OXb6pzdA7cVnT3q5ISS3FGoqEWc1FxIgBQh+y/LgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK7H3m3pBu9+i1tMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6Mjz9PshZ0yldcedvK2MC4QKyLkZNDQsBE
 YsLnfqYuRi4OIYHdjBIvemawQySkJI7t/MkGYQtLrPz3HCwuJPCPUeLoeS8Qm03AQOJB83Gw
 uIiApMTvrtPMIIOYBX4xSjzdfR8sISyQJtFy9AFjFyMHB4uAqsSVo/YgYV4BW4k3a78yQ8yX
 l9h/8CyYzSlgJ7Hv6XSoXbYSS/pPs0HUC0qcnPmEBWQMs4C6xPp5QiBhZqDW5q2zmScwCs5C
 UjULoWoWkqoFjMyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCY0NLYwfju29N+ocY
 mTgYDzFKcDArifC21W9JF+JNSaysSi3Kjy8qzUktPsQozcGiJM670jAiXUggPbEkNTs1tSC1
 CCbLxMEp1cBk0NpWmOh0TPfzEkHzlcJLRJbExAi6B98xWC8cuWlyeuIzxrAN746KpHxbLP65
 Me+LSxujDXNtz5uyzfk2ZR91xKtPyyjyz78uHy8/9ytv4xmZTZLPRSsNxWffuFQmfXCH/fEJ
 p0QZLxhcPxn7cXmtwBnVSdkejM+Pa26ujGHL2+vqFhOwdDVfMGfu8s8K1Q2Pz19ldErsq55r
 IhOpZihQY716csMH+cP/lp2dk3BsGYvw85uFXHq1Ycbqcl+WWOcetDw/e26iW5JyxpX0xO8T
 pikeeWQx7+qTxuOu0YYsodevzHnLzOh+qifh77ZbYT9CPr6Zqppt1Hpk2QnPe1f8oxYI+3oq
 Rr6etlqqcLESS3FGoqEWc1FxIgBHsEYr/AIAAA==
X-CMS-MailID: 20250220052736epcas5p254a601a6710b3fd58a827ca99680d746
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220052736epcas5p254a601a6710b3fd58a827ca99680d746
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
 <CGME20250220052736epcas5p254a601a6710b3fd58a827ca99680d746@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=vinayak.kh@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Move the code of calculation of sanitize duration into function
for usability by other sanitize routines

Estimate times based on:
             https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 61 ++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f55a2fe614..2428d85fef 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1656,34 +1656,10 @@ static void __do_sanitization(CXLType3Dev *ct3d)
     cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
-/*
- * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
- *
- * Once the Sanitize command has started successfully, the device shall be
- * placed in the media disabled state. If the command fails or is interrupted
- * by a reset or power failure, it shall remain in the media disabled state
- * until a successful Sanitize command has been completed. During this state:
- *
- * 1. Memory writes to the device will have no effect, and all memory reads
- * will return random values (no user data returned, even for locations that
- * the failed Sanitize operation didn’t sanitize yet).
- *
- * 2. Mailbox commands shall still be processed in the disabled state, except
- * that commands that access Sanitized areas shall fail with the Media Disabled
- * error code.
- */
-static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
-                                         uint8_t *payload_in,
-                                         size_t len_in,
-                                         uint8_t *payload_out,
-                                         size_t *len_out,
-                                         CXLCCI *cci)
+static int get_sanitize_duration(uint64_t total_mem)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-    uint64_t total_mem; /* in Mb */
-    int secs;
+    int secs = 0;
 
-    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
     if (total_mem <= 512) {
         secs = 4;
     } else if (total_mem <= 1024) {
@@ -1712,6 +1688,39 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
         secs = 240 * 60; /* max 4 hrs */
     }
 
+    return secs;
+}
+
+/*
+ * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    secs = get_sanitize_duration(total_mem);
+
     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
     *len_out = 0;
-- 
2.34.1


