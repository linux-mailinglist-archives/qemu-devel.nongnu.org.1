Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC77C599B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcT0-0000nb-VM; Wed, 11 Oct 2023 12:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSu-0000mU-DZ; Wed, 11 Oct 2023 12:53:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSr-0001CS-GM; Wed, 11 Oct 2023 12:53:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BFRv30025175; Wed, 11 Oct 2023 16:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gxTPe4ZLnmFoG/qiRs43qjCVYHKakkRyEADD4TrcpAs=;
 b=QDUm7EQMRCL1FrtbHX5897/oslVo3Py8E8bi4MhW7z63Eu/r1UYPvocZ7ucKJOMJdKbP
 IiQJXvaHiWG1xPadF30CM9WpsALvGzy/hLk+j43DGCB9E62RfnXbtFQKOMyoCZGAQ9ui
 a4MFI27Lf71HE/1AwzJB6JBZ+qq8PFWDURLOwJt7bQY1TZng4hZq8zNeRxoYRqq8uHAk
 6vEthprwTRRLitwQbtblL92BPCOPxB4upLxj02351/Q8PZiWgw1CtrAmk/xfmBNufKK8
 RNpk8cvLvo2lzrP8gKw7fcK206KQgqDLdNS6htc7vCTT0NuRlWEr2SQFhJ7svbgkNw+l 4Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnqh1hbd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGrZsK008718
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:35 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 09:53:31 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v0 11/12] gunyah: Workarounds (NOT FOR MERGE)
Date: Wed, 11 Oct 2023 16:52:33 +0000
Message-ID: <20231011165234.1323725-12-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Cl2TGlX5l3MEg-uHm7A_p_fRACtbhyRo
X-Proofpoint-ORIG-GUID: Cl2TGlX5l3MEg-uHm7A_p_fRACtbhyRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110148
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These are some work-arounds required temporarily until some limitations
with Gunyah hypervisor are addressed.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 accel/gunyah/gunyah-all.c   | 18 ++++++++++++++++++
 hw/arm/boot.c               |  3 ++-
 hw/arm/virt.c               |  3 ++-
 include/sysemu/gunyah_int.h |  1 +
 target/arm/gunyah.c         |  7 +++++++
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
index edc61e542b..67372a3a82 100644
--- a/accel/gunyah/gunyah-all.c
+++ b/accel/gunyah/gunyah-all.c
@@ -145,6 +145,24 @@ static gunyah_slot *gunyah_find_overlap_slot(GUNYAHState *s,
     return NULL;
 }
 
+gunyah_slot *gunyah_find_slot_by_addr(uint64_t addr)
+{
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+    int i;
+    gunyah_slot *slot = NULL;
+
+    gunyah_slots_lock(s);
+    for (i = 0; i < s->nr_slots; ++i) {
+        slot = &s->slots[i];
+        if (slot->size &&
+            (addr >= slot->start && addr <= slot->start + slot->size))
+                break;
+    }
+    gunyah_slots_unlock(s);
+
+    return slot;
+}
+
 /* Called with s->slots_lock held */
 static gunyah_slot *gunyah_get_free_slot(GUNYAHState *s)
 {
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 720f22531a..72a22c191f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -413,7 +413,8 @@ static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
     char *nodename;
     int ret;
 
-    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+    /* Workaround until RM can parse memory nodes of type memory@XYZ. */
+    nodename = g_strdup_printf("/memory");
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
     ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 15fdf7be05..ab4811a785 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -164,7 +164,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
     /* Actual RAM size depends on initial RAM and device memory settings */
-    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
+    /* Workaround until Gunyah can accept mapping that starts from GiB */
+    [VIRT_MEM] =                { 2 * GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
 /*
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index 92ba0bc9f0..1880a578b3 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -56,5 +56,6 @@ int gunyah_add_irqfd(int irqfd, int label, Error **errp);
 GUNYAHState *get_gunyah_state(void);
 int gunyah_arch_put_registers(CPUState *cs, int level);
 void gunyah_cpu_synchronize_post_reset(CPUState *cpu);
+gunyah_slot *gunyah_find_slot_by_addr(uint64_t addr);
 
 #endif    /* GUNYAH_INT_H */
diff --git a/target/arm/gunyah.c b/target/arm/gunyah.c
index 06600dbdb7..55d5ccc2a4 100644
--- a/target/arm/gunyah.c
+++ b/target/arm/gunyah.c
@@ -34,6 +34,13 @@ int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
 {
     int ret;
     struct gh_vm_dtb_config dtb;
+    gunyah_slot *slot = gunyah_find_slot_by_addr(dtb_start);
+
+    /*
+     * RM should consider 'totalsize' field to be inclusive of free space. Use
+     * this workaround until RM is fixed.
+     */
+    dtb_size = slot->start + slot->size - dtb_start;
 
     dtb.guest_phys_addr = dtb_start;
     dtb.size = dtb_size;
-- 
2.25.1


