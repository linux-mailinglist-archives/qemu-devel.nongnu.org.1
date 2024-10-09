Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E0995E28
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Oct 2024 05:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNNw-00058N-Si; Tue, 08 Oct 2024 23:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNNs-0004zI-8Q; Tue, 08 Oct 2024 23:29:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNNq-0005CH-HJ; Tue, 08 Oct 2024 23:29:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNddq72fNz6K98k;
 Wed,  9 Oct 2024 11:28:47 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 9FFE9140A90;
 Wed,  9 Oct 2024 11:29:04 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:28:45 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 29/33] hw/intc/arm_gicv3_common: Add GICv3CPUState
 'accessible' flag migration handling
Date: Wed, 9 Oct 2024 04:18:11 +0100
Message-ID: <20241009031815.250096-30-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The QOM `GICv3CPUState` (and consequently the corresponding KVM VGIC `ICC_*_EL1`
registers) can be either 'accessible' or 'inaccessible', depending on the state
of the associated QOM vCPUs. This `gicc_accessible` state should be saved during
migration at the source and restored at the destination.

Ideally, the number of possible and enabled QOM vCPUs should match between the
source and destination. Ensuring this consistency is the responsibility of the
administrator. However, if the destination QEMU has more enabled vCPUs than the
source, we can either fail the migration or override the destination QEMU’s vCPU
configuration to match the source. We have adopted the latter approach as a
mitigation for the mismatch. Nonetheless, the administrator should still ensure
that the number of possible QOM vCPUs is consistent at both ends.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/intc/arm_gicv3_common.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e7b2d04358..5dda14ce1c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -126,6 +126,29 @@ static int vmstate_gicv3_cpu_pre_load(void *opaque)
     return 0;
 }
 
+static int vmstate_gicv3_cpu_post_load(void *opaque, int version_id)
+{
+    GICv3CPUState *cs = opaque;
+
+    /*
+     * If the destination QEMU has more *enabled* vCPUs than the source, we can
+     * either *fail* the migration or override the destination QEMU’s vCPU
+     * configuration to match the source. Since it is safe to override the
+     * `CPUState` of the extra *enabled* vCPUs at the destination, we have
+     * adopted the latter approach as a mitigation for the mismatch.
+     * RFC: Question: any suggestions on this are welcome?
+     */
+    if (!gicv3_cpu_accessible((cs)) && qemu_enabled_cpu(cs->cpu)) {
+        warn_report("Found CPU %d enabled for incoming *disabled* GICC State\n",
+                    cs->cpu->cpu_index);
+        warn_report("Disabling CPU %d to match the incoming migrated state",
+                    cs->cpu->cpu_index);
+        qdev_unrealize(DEVICE(cs->cpu));
+    }
+
+    return 0;
+}
+
 static bool icc_sre_el1_reg_needed(void *opaque)
 {
     GICv3CPUState *cs = opaque;
@@ -186,6 +209,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_load = vmstate_gicv3_cpu_pre_load,
+    .post_load = vmstate_gicv3_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, GICv3CPUState),
         VMSTATE_UINT32(gicr_ctlr, GICv3CPUState),
@@ -207,6 +231,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
         VMSTATE_UINT64_2DARRAY(icc_apr, GICv3CPUState, 3, 4),
         VMSTATE_UINT64_ARRAY(icc_igrpen, GICv3CPUState, 3),
         VMSTATE_UINT64(icc_ctlr_el3, GICv3CPUState),
+        VMSTATE_BOOL(gicc_accessible, GICv3CPUState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-- 
2.34.1


