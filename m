Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5C710B53
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29Nw-00044h-IU; Thu, 25 May 2023 07:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q29Ni-00043f-K3
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:43:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q29Ng-0004CV-6R
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:43:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PBfk9q032184; Thu, 25 May 2023 11:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=P1XsyKiZ5ZEqmUPvt5++7/gCIgwR2DeCXUIGGwE8CAA=;
 b=r0+qX8PQ6tCTZEbOAHrQE5telOncqZ0XHHweqXdkoPTW0g1XMKkDZHkApqMZzl2drrra
 oGfetzszK8Bo8q7aX9dxl4W0YNHthNnGU8NcLgI5FVKtR42/0r1k89c7/iRhOuFY+F+5
 rmKVVtRCK3OX7md7jaOst3CfVPWPQH9SNF+2d1/8M9b9Qzag4UIkxQkkciPAFMVxjUKc
 SumZHgDfmlhpBzXxnmdLq/q+PGw+89U6bRILTeJqVralsXmFz3zkLZHlmqet6AZXltE5
 HJ2QXtUvm63A//IP+zFkihZz4pLHo75wpDUVlAM1MDesq9Ns/sU02lXlSLhGpocNByg+ ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt712804m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 11:43:38 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34P9mNYo027232; Thu, 25 May 2023 11:43:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2g84kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 11:43:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBe13F020951;
 Thu, 25 May 2023 11:43:37 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-196-224.vpn.oracle.com
 [10.175.196.224])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qqk2g84e8-2; Thu, 25 May 2023 11:43:36 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Date: Thu, 25 May 2023 12:43:20 +0100
Message-Id: <20230525114321.71066-2-joao.m.martins@oracle.com>
In-Reply-To: <20230525114321.71066-1-joao.m.martins@oracle.com>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250098
X-Proofpoint-ORIG-GUID: h5dxXfJIU5leBFfncT3RtoXYU-sjyom_
X-Proofpoint-GUID: h5dxXfJIU5leBFfncT3RtoXYU-sjyom_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In preparation for including the number of dirty pages in the
vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
cpu_physical_memory_set_dirty_lebitmap() similar to
cpu_physical_memory_sync_dirty_bitmap().

To avoid counting twice when GLOBAL_DIRTY_RATE is enabled, stash the
number of bits set per bitmap quad in a variable (@nbits) and reuse it
there.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/exec/ram_addr.h | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f4fb6a211175..8b8f271d0731 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -333,14 +333,16 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
 }
 
 #if !defined(_WIN32)
-static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
-                                                          ram_addr_t start,
-                                                          ram_addr_t pages)
+static inline
+uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+                                                ram_addr_t start,
+                                                ram_addr_t pages)
 {
     unsigned long i, j;
-    unsigned long page_number, c;
+    unsigned long page_number, c, nbits;
     hwaddr addr;
     ram_addr_t ram_addr;
+    uint64_t num_dirty = 0;
     unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
     unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
@@ -368,6 +370,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                 if (bitmap[k]) {
                     unsigned long temp = leul_to_cpu(bitmap[k]);
 
+                    nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
 
                     if (global_dirty_tracking) {
@@ -376,10 +379,12 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                 temp);
                         if (unlikely(
                             global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                            total_dirty_pages += ctpopl(temp);
+                            total_dirty_pages += nbits;
                         }
                     }
 
+                    num_dirty += nbits;
+
                     if (tcg_enabled()) {
                         qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
                                    temp);
@@ -408,9 +413,11 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
         for (i = 0; i < len; i++) {
             if (bitmap[i] != 0) {
                 c = leul_to_cpu(bitmap[i]);
+                nbits = ctpopl(c);
                 if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                    total_dirty_pages += ctpopl(c);
+                    total_dirty_pages += nbits;
                 }
+                num_dirty += nbits;
                 do {
                     j = ctzl(c);
                     c &= ~(1ul << j);
@@ -423,6 +430,8 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
     }
+
+    return num_dirty;
 }
 #endif /* not _WIN32 */
 
-- 
2.31.1


