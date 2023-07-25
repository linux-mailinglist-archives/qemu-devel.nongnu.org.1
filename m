Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8E7621B8
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMxD-0000VQ-9d; Tue, 25 Jul 2023 14:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qOMx1-0000Ta-Ln
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:40:05 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qOMwx-0000hU-Nt
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:40:03 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230725183957usoutp026402224fe014bd2558dcb703be77d9f2~1MFnGVPaO1493014930usoutp025;
 Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230725183957usoutp026402224fe014bd2558dcb703be77d9f2~1MFnGVPaO1493014930usoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1690310397;
 bh=4zHhiX+VKvsm4sZJl9tl93+G8ban/i2aXGty2+poNFg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=iVAx0/9RcpLhBXX+yfLPsDR5hbgcwVTBfCeDQw8InbD5RD0Qelkdgr+AvVe72F7TA
 NCXPOdABavQBm8U0OHYnLar+DUShPyei528+GXqQq/FOvS7K+XfOUHhFzmIAiISbwL
 gsow8v63EAXEII83HHtBoJXin/LSgjXVt9FMbJhM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230725183957uscas1p16fd7936ec77be6b2ccc8b60bc1f08eef~1MFm4GIwg0903709037uscas1p1X;
 Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id A1.11.42611.CF610C46; Tue,
 25 Jul 2023 14:39:56 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4~1MFmiu1U-1453314533uscas1p14;
 Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-41-64c016fcb123
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B3.83.44215.CF610C46; Tue,
 25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 25 Jul 2023 11:39:55 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 25 Jul 2023 11:39:55 -0700
From: Fan Ni <fan.ni@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "cbrowy@avery-design.com" <cbrowy@avery-design.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, "nifan@outlook.com" <nifan@outlook.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: [Qemu PATCH v2 3/9] include/hw/cxl/cxl_device: Rename mem_size as
 static_mem_size for type3 memory devices
Thread-Topic: [Qemu PATCH v2 3/9] include/hw/cxl/cxl_device: Rename mem_size
 as static_mem_size for type3 memory devices
Thread-Index: AQHZvydogN6RnRodckK9r+0ZvWb2uQ==
Date: Tue, 25 Jul 2023 18:39:55 +0000
Message-ID: <20230725183939.2741025-4-fan.ni@samsung.com>
In-Reply-To: <20230725183939.2741025-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djX87p/xA6kGExqt7ToPr+B0WL61AuM
 FqtvrmG0aGh6xGLRsvs9k8X+p89ZLFYtvMZmcX7WKRaL5xOfM1ksXfKI2eJ47w4WB26PC5Mn
 sHosbnD12DnrLrtHy5G3QN6el0weGz/+Z/d4cm0zk8fm1y+YPabOrvf4vEkugCuKyyYlNSez
 LLVI3y6BK2NjXztzQbNMxbsHp1kaGDeJdTFycEgImEjMe6XXxcjFISSwklFi+/QNrF2MnEBO
 K5PE+WnKIDZIzfWXP9kgitYySvSu3cUEUfSJUWLRdDOIxDJGidbW02DdbAKKEvu6trOB2CIC
 xhLHDi9hBiliFnjLIvFxzRsWkISwQKnE/Bm7WSCKqiQurFsP1aAn8XfXBbA4i4CqRMfKHWDb
 eAUsJRYeWs0IYnMKWEk8+zIbbBmjgJjE91NrwGqYBcQlbj2ZzwRxtqDEotl7mCFsMYl/ux6y
 QdjyEpN/zICyFSXuf3/JDtGrJ3Fj6hQ2CFtbYtnC18wQewUlTs58wgJRLylxcMUNFpBnJAQm
 c0q0XzgNlXCRmLJ8MSOELS3x9+4yJkj4Jkus+sgFEc6RmL9kC1S5tcTCP+uZJjCqzEJy9iwk
 Z8xCcsYsJGcsYGRZxSheWlycm55abJSXWq5XnJhbXJqXrpecn7uJEZjaTv87nL+D8fqtj3qH
 GJk4GA8xSnAwK4nwGsbsSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOa2h7MllIID2xJDU7NbUg
 tQgmy8TBKdXAtOLTFusnLayvHBzceEwvKv/nnROs/C32gKteZPGbPaxT+l6n7Tleuyvp6yTW
 A9evs688eHH6jXDvLrkTWVqR1+U0mXx1D/l8mNvLnGZkqvLgYGa+BHvzgjdvBVy8HK41NO8R
 3bM0h1P4/78HbhatgdZm3K4uT0JX9TJ/mLwxgY119obYgx0Nk9jW3VphoFMU564b2tihEFit
 Hmpvu/6tf5bN3AfHLlz0LNxt07ho5e+Lfkl8McLpL27fcfK7ckL+tpqMyTqxQmUjsRX6TL5q
 516vM/9/86V/lMv/T45xB56ZMXjOWyt3h7nQr7Xzo+/8iYtXOGS67WD8PIste9aX2dOWVziH
 TgjMvqnDdlRaiaU4I9FQi7moOBEApGarQdwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWS2cA0SfeP2IEUgy0TlSy6z29gtJg+9QKj
 xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
 rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
 Sy3St0vgytjY185c0CxT8e7BaZYGxk1iXYycHBICJhLXX/5k62Lk4hASWM0osezORjaQhJDA
 J0aJ7W0uEIlljBKLDy9gB0mwCShK7OvaDlYkImAscezwEmYQm1ngNYvEt4vcILawQKnE/Bm7
 WSBqqiRWdZ1jhrD1JP7uugAWZxFQlehYuYMJxOYVsJRYeGg1YxcjB9AyS4mtE+NAwpwCVhLP
 vsxmBbEZBcQkvp9awwSxSlzi1pP5TBAPCEgs2XOeGcIWlXj5+B8rhC0vMfnHDDYIW1Hi/veX
 7BC9ehI3pk5hg7C1JZYtfM0McYKgxMmZT1gg6iUlDq64wTKBUWIWknWzkLTPQtI+C0n7AkaW
 VYzipcXFuekVxUZ5qeV6xYm5xaV56XrJ+bmbGIFp4fS/w9E7GG/f+qh3iJGJg/EQowQHs5II
 r2HMvhQh3pTEyqrUovz4otKc1OJDjNIcLErivC+jJsYLCaQnlqRmp6YWpBbBZJk4OKUamKZ9
 Y3e5fdm9uTK/PHaeoOhLppwDU/2c74fMEf1h1XvdpHeFRIDT5RmT8rdrh21fukg399QP7flf
 7N7yScYtVL+5OvDSLc/X952UQxn7nlT52l4O7bdIlzumJymzcvmdwqLdpUF3A84uC11+s1W8
 3mJtY+1W52thdz/4GwVu33GkmHluY1n1DEUfmRPxacdSeebNUvRpu8qwy7Vgx6FinSkrFoXG
 BbCvfZWTsJtFTvWcnIpS03PO6HXrnPa/vrDX8Po95g27dr4UqRS6e49ZmPPRstqk1e3HbuUF
 +R3WaVv3q8OMbw2Xw1758vzySk41620Wi6PjTv4uUXlwtFgn38BRs3b+ss98Wb6eETFRSizF
 GYmGWsxFxYkA1BosnnoDAAA=
X-CMS-MailID: 20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4@uscas1p1.samsung.com>
Received-SPF: pass client-ip=211.189.100.12; envelope-from=fan.ni@samsung.com;
 helo=mailout2.w2.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Fan Ni <nifan@outlook.com>

Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
pmem capacity, preparing for the introduction of dynamic capacity to suppor=
t
dynamic capacity devices.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 5 +++--
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0fe9f3eb5d..dd5ea95af8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -540,7 +540,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
=20
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
=20
-    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULT=
IPLIER);
+    stq_le_p(&id->total_capacity,
+            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACIT=
Y_MULTIPLIER);
     stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_=
MULTIPLIER);
     stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
@@ -879,7 +880,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd=
 *cmd,
     struct clear_poison_pl *in =3D (void *)cmd->payload;
=20
     dpa =3D ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
=20
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4d68824dfe..3d7acffcb7 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -748,7 +748,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size =3D memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size +=3D memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size +=3D memory_region_size(vmr);
         g_free(v_name);
     }
=20
@@ -771,7 +771,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size =3D memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size +=3D memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size +=3D memory_region_size(pmr);
         g_free(p_name);
     }
=20
@@ -984,7 +984,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3=
d,
         return -EINVAL;
     }
=20
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
=20
@@ -1148,7 +1148,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t=
 dpa_offset, uint8_t *data)
         return false;
     }
=20
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_siz=
e) {
         return false;
     }
=20
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index dae39da438..503c344326 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -209,7 +209,7 @@ typedef struct cxl_device_state {
     } timestamp;
=20
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
     bool is_dcd;
--=20
2.25.1

