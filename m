Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF5D7C7B59
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 03:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr7Or-00067h-2I; Thu, 12 Oct 2023 21:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qr7Ok-00066U-6Q
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 21:55:30 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qr7Oi-0001uf-BG
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 21:55:29 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="123971444"
X-IronPort-AV: E=Sophos;i="6.03,219,1694703600"; d="scan'208";a="123971444"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 10:55:23 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A9FC9C68E8
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:55:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D52B4D9692
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:55:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6037220050193
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:55:17 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D9E691A0072;
 Fri, 13 Oct 2023 09:55:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] hw/cxl: Fix opaque type interpret wrongly
Date: Fri, 13 Oct 2023 09:55:15 +0800
Message-ID: <20231013015515.23647-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27932.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27932.003
X-TMASE-Result: 10-0.382300-10.000000
X-TMASE-MatchedRID: aulLGGssQIMQQGM6WcQD/Auw+MVcHJpKjlRp8uau9oar1gUu9f1F/78F
 Hrw7frluQTnfsHRv3fu5ijSzmdr97EpCFcNebto2hjlBjwpom1OlLADMASK8x+QdHK70O9a9o8W
 MkQWv6iXBcIE78YqRWo6HM5rqDwqtXa6Q+cpEixFT8ZSuXf2MpwpUcLjvAYi9cHatKK4wXuB5NG
 1kI1mciP8ZtxI75jgcajBUwUX02ojf4idpFWUFkhBoZd+vstEyFcG3+ZRETICP9kUX1Z+buE3Lu
 mkbQiNwVCqTSPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

void cxl_component_register_block_init(Object *obj,
                                       CXLComponentState *cxl_cstate,
                                       const char *type)
{
    ComponentRegisters *cregs = &cxl_cstate->crb;
...
    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
                          ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);

Obviously, opaque should be pointer to ComponentRegisters.
Fortunately, cregs is the first member of cxl_state, so their values are
the same.

Fixes: 9e58f52d3f8 ("hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/cxl/cxl-component-utils.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f3bbf0fd131..f27a9d3cf60 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -64,8 +64,7 @@ hwaddr cxl_decode_ig(int ig)
 static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
                                        unsigned size)
 {
-    CXLComponentState *cxl_cstate = opaque;
-    ComponentRegisters *cregs = &cxl_cstate->crb;
+    ComponentRegisters *cregs = opaque;
 
     if (size == 8) {
         qemu_log_mask(LOG_UNIMP,
@@ -113,8 +112,7 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
                                     unsigned size)
 {
-    CXLComponentState *cxl_cstate = opaque;
-    ComponentRegisters *cregs = &cxl_cstate->crb;
+    ComponentRegisters *cregs = opaque;
     uint32_t mask;
 
     if (size == 8) {
-- 
2.41.0


