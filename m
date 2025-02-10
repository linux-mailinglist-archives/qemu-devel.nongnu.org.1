Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C159A2ECA5
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 13:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thT1X-00035D-V2; Mon, 10 Feb 2025 07:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jansef.jian@hj-micro.com>)
 id 1thP18-00044a-8t
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:19:46 -0500
Received: from mail-m49251.qiye.163.com ([45.254.49.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jansef.jian@hj-micro.com>)
 id 1thP15-0000gv-Pu
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:19:45 -0500
Received: from localhost.localdomain (unknown [122.224.147.158])
 by smtp.qiye.163.com (Hmail) with ESMTP id a9ba6660;
 Mon, 10 Feb 2025 15:44:09 +0800 (GMT+08:00)
From: JianChunfu <jansef.jian@hj-micro.com>
To: eric.auger@redhat.com,
	peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	JianChunfu <jansef.jian@hj-micro.com>
Subject: [PATCH] hw/arm/smmuv3: Rename smmuv3_invalidate_ste to
 smmuv3_hash_remove_by_sid_range
Date: Mon, 10 Feb 2025 15:44:07 +0800
Message-ID: <20250210074407.90041-1-jansef.jian@hj-micro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBoZVhhKTU8eGUhOGRlITFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a94eed0cf7d09d2kunma9ba6660
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTo6Pxw*GjITGks4FiMdTQJI
 S0kwFEtVSlVKTEhCSkxIT05LTkpMVTMWGhIXVREaFQgeHVUREhoVOxMRVhYSGAkUVRgUFkVZV1kS
 C1lBWUpJSVVJSU9VSk9MVUpOQ1lXWQgBWUFKSEhDNwY+
Received-SPF: pass client-ip=45.254.49.251;
 envelope-from=jansef.jian@hj-micro.com; helo=mail-m49251.qiye.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 10 Feb 2025 07:36:22 -0500
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

Uniform the removal judgement of g_hash_table_foreach_remove(), previous name
seems to perform the actual action while it just returns a Boolean.

Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
---
 hw/arm/smmuv3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4c49b5a88..4ee0b49ac 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1278,7 +1278,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 }
 
 static gboolean
-smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
+smmuv3_hash_remove_by_sid_range(gpointer key, gpointer value,
+                                gpointer user_data)
 {
     SMMUDevice *sdev = (SMMUDevice *)key;
     uint32_t sid = smmu_get_sid(sdev);
@@ -1373,7 +1374,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
-            g_hash_table_foreach_remove(bs->configs, smmuv3_invalidate_ste,
+            g_hash_table_foreach_remove(bs->configs,
+                                        smmuv3_hash_remove_by_sid_range,
                                         &sid_range);
             break;
         }
-- 
2.43.0


