Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8847ADB0C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknEU-0008H7-DK; Mon, 25 Sep 2023 11:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEM-0008Dm-0C
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEJ-0005L8-T4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:37 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MsI8Y-1reHCH2iHC-00tlIJ; Mon, 25
 Sep 2023 17:10:31 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/5] linux-user/mmap.c:  clean up local variable shadowing
Date: Mon, 25 Sep 2023 17:10:26 +0200
Message-ID: <20230925151029.461358-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151029.461358-1-laurent@vivier.eu>
References: <20230925151029.461358-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:erE6zJTlpjDiXfdnlwGTTJmuFc+uYzYlwxb8zhNpZV4gG0dAQFu
 UVFb5ybU3oZaHZGgz00VRxCg6l2EUlrNt8tI4jBs4bV6EdVa5zYJbGFt0ry1qoAsf0EyJrs
 oMsUPknOUOnJhvSU3qmpXtu93uDpcQ/vy7myzJ0fQH+eCQc2LDFlD6DqDlCoBsuC3Upe5HB
 pbb5JIq45n5f2I6WkJPMg==
UI-OutboundReport: notjunk:1;M01:P0:FwU6Yv6eCvU=;dUVJsjEc52eVjict1HnRZuIzvuR
 bf3h2jMO5rCwN6FzEvA3Z4C/5+vgXy2HPDFEg91cG1IRflYSBb+c5/t+PXztKtUG2kw1RPiJa
 MkH26YAx5RYVBSl2pVWm0n99t2AL0Vbm1cymgeQcvyupwbyUuq01f9Fe5AwCRaJE9WA7i6c/K
 JNElwi0YVYL8O1D1D1PBmQqnlYi/KUmfRZb8Yaw6+TZz/H8XNDA+7tOZIEURSJPbtXEBuLHxR
 eZJhIT+6chVAgfnOzCYxCySGMz+A68Al9U4SmB6X1nby4SCkjweoab8qkVVFTGP+nUuqV4ZK8
 cRILX/mcWVOeWzSjHTiukYOuM7ZGVTjyqm9o7D2gXsmP+10GP07TAYN4ZwDkxi3m4xprFJhM2
 hHcnWUBxE0Nl1xoErAA6B9zMv8bp0W2cREhulkLloTZCSBOEyqOtwFRmf+9rt73BTsZCRDle7
 HK0OUPAt1WzzrPAiQ/nDnzklPzFl4txzoXUMOj1bXM1H3wrUoNIqQO/iPRBMto08lcBmmbqVN
 pWC9CtX/dQKYB9nzocWJjDb1Z8TECtqXvwuNpqHfhSYHpsxEkg43ZMMnpq+sEA2WAHraUwHLi
 KFUmMp0TGRIF+t7L7Rc/fF2TmcrrIpCtknvqxUvGipNgus0F0qdTXrYboqCJTckWX2z6N3FTB
 L6fBGS9uHWQ5Bzu5K6N5g8CqYV1Qm48kgDq6EKW9/Wx8oi0oSBQAlkUzqCYkA28/UhZuRpoq+
 m1K/yDIjAkCd1VJGS2w5U3VK0mMWoTK6UxA3rQ25Chxl00q9NEWk1bVqtjR+uIX1ugONruL4D
 bjEAXA85gBXnFIB1EUEhgk4URTm9MokFLBA+uvMvNsjTSKL3Ot8flZaMl9agvGmAdMAaLaMYU
 +zCL06PLCsZIw2w==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Fix following warnings:

.../linux-user/mmap.c: In function 'target_mremap':
.../linux-user/mmap.c:913:13: warning: declaration of 'prot' shadows a previous local [-Wshadow=compatible-local]
  913 |         int prot = 0;
      |             ^~~~
../../../Projects/qemu/linux-user/mmap.c:871:9: note: shadowed declaration is here
  871 |     int prot;
      |         ^~~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8eaf57b208b0..8ccaab78590f 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -910,16 +910,16 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
             }
         }
     } else {
-        int prot = 0;
+        int page_flags = 0;
         if (reserved_va && old_size < new_size) {
             abi_ulong addr;
             for (addr = old_addr + old_size;
                  addr < old_addr + new_size;
                  addr++) {
-                prot |= page_get_flags(addr);
+                page_flags |= page_get_flags(addr);
             }
         }
-        if (prot == 0) {
+        if (page_flags == 0) {
             host_addr = mremap(g2h_untagged(old_addr),
                                old_size, new_size, flags);
 
-- 
2.41.0


