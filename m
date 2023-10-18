Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C925C7CD659
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1rH-00078O-2q; Wed, 18 Oct 2023 04:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qt1rF-000781-KQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:24:49 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qt1rE-00034K-5k
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:24:49 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="124902764"
X-IronPort-AV: E=Sophos;i="6.03,234,1694703600"; d="scan'208";a="124902764"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 17:24:40 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A02D2D29E9
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 17:24:38 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DBF07BD9AF
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 17:24:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B83D20050181
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 17:24:37 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 056321A0071;
 Wed, 18 Oct 2023 16:24:36 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 2/2] hw/cxl: Pass NULL for a NULL MemoryRegionOps
Date: Wed, 18 Oct 2023 16:24:08 +0800
Message-ID: <20231018082408.888098-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082408.888098-1-lizhijian@fujitsu.com>
References: <20231018082408.888098-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27942.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27942.006
X-TMASE-Result: 10-0.932300-10.000000
X-TMASE-MatchedRID: A9PO4OC4jbws8AejW2/5AU7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOMTr
 /G24o7Rr/AYmuPoHlH41hvF/jmI7sx8TzIzimOwP0C1sQRfQzEHEQdG7H66TyHEqm8QYBtMOrNz
 Vxk5P0Wfy+wrogeTdzEvCQNGwN23tBn9HRZKNlCfOmt0T1qrGFtLeuT62NtczRpluRT/bdcaXC0
 xJ+CBWwnsjn/fEGAWtW4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=lizhijian@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

a NULL parameter is enough for a NULL MemoryRegionOps

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/cxl/cxl-component-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 6214dcdcc12..010ed82edab 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -177,7 +177,7 @@ void cxl_component_register_block_init(Object *obj,
                        CXL2_COMPONENT_BLOCK_SIZE);
 
     /* io registers controls link which we don't care about in QEMU */
-    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
+    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
                           CXL2_COMPONENT_IO_REGION_SIZE);
     memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
-- 
2.41.0


