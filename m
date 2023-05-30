Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC7716BE8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43jk-00072B-Mz; Tue, 30 May 2023 14:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43jh-0006za-JB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:06:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43jf-0004CB-Te
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:06:21 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4jt9021696; Tue, 30 May 2023 18:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=c4EMlyKJPBOtAcZ5+JqLAnApeDExZ/BT3pKqIDShAME=;
 b=nUgb6ieqd4bImMy3s6O9Jjy7Rr0kbvYWpWWFZmskmwLG1l9mTiIjDTqGLesu5ZFKDGIf
 2OG1jsJThQ37bHrn0saLhn06GLoHAyPq9gav9htste5sC/aDqC+h2nSuciWkIbg260Nl
 VhJPqOTvhI/cChVcwkJ5pKr3WML8Cku6ixcKiFzW4Nje7aUBcWzoVNjc006yBB7a1v3S
 LsjD6liNKdg0pVWrm6SvhAwAI8206pPJAdeZaqaIksBxuONR+vuRtXS5qEqktEERLLs4
 0GrKD9ay2qRRQNu+/93QpgPamwU0Jx0DhQ+n1WUIZrgs8j5e99Ce2oYO46ueFUqCImVq rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh3f0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:06:16 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHfg8o014618; Tue, 30 May 2023 18:06:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a494vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:06:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UI6CbE036891;
 Tue, 30 May 2023 18:06:15 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a494ny-2; Tue, 30 May 2023 18:06:14 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 1/2] exec/ram_addr: return number of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Date: Tue, 30 May 2023 19:05:55 +0100
Message-Id: <20230530180556.24441-2-joao.m.martins@oracle.com>
In-Reply-To: <20230530180556.24441-1-joao.m.martins@oracle.com>
References: <20230530180556.24441-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-GUID: 9sf1ODgmekss8rtVRZhuI7YAlVWVEzn1
X-Proofpoint-ORIG-GUID: 9sf1ODgmekss8rtVRZhuI7YAlVWVEzn1
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90a82692904f..9f2e3893f562 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -334,14 +334,23 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
 }
 
 #if !defined(_WIN32)
-static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
-                                                          ram_addr_t start,
-                                                          ram_addr_t pages)
+
+/*
+ * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
+ * the number of dirty pages in @bitmap passed as argument. On the other hand,
+ * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * weren't set in the global migration bitmap.
+ */
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
@@ -369,6 +378,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                 if (bitmap[k]) {
                     unsigned long temp = leul_to_cpu(bitmap[k]);
 
+                    nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
 
                     if (global_dirty_tracking) {
@@ -377,10 +387,12 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
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
@@ -409,9 +421,11 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
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
@@ -424,6 +438,8 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
     }
+
+    return num_dirty;
 }
 #endif /* not _WIN32 */
 
-- 
2.39.3


