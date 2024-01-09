Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41488282A7
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN801-0008BZ-DR; Tue, 09 Jan 2024 04:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zT-0007wj-Fp; Tue, 09 Jan 2024 04:01:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zR-0003dh-HQ; Tue, 09 Jan 2024 04:01:43 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4098QA51025170; Tue, 9 Jan 2024 09:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=KI+BJ9lr8SvU0FpMJLFqLEVxC7u2XFjeSpfmV9DdH0A=; b=eR
 dV8ROEtitDx9zY94tkA8JoIOvZmCuwI3SP8xis8icSiIkUDmSzz7y0CxPm7PwjGO
 MO3Vru7cmY2M56albxhCIOxIu/Npc5Hsr/anvrKT+SeVGjcw3fddzkx3rHPM9KFP
 kf1RrpWVHk2lo/DEqlS8zqI+p1iPaIN1QzeskNk57TkPFVEYwzY8QIJi3rUIgqNc
 ENUA/ZgeABiMam6uu0f2euow5QkkQYl1mBJF848DyvrMQgU+sCXTjQqX27nSXxFr
 2b/+ngM04BDL1h6ErDnaEV97M3xEXddZncl3L277FJqQQeIa6+vf3WIboqgb1c7y
 QXg55vcmttf+Y1kv+fIg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgxxbgfvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40991bSJ027001
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:37 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:33 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 10/11] gunyah: Workarounds (NOT FOR MERGE)
Date: Tue, 9 Jan 2024 09:00:38 +0000
Message-ID: <20240109090039.1636383-11-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: LRijOoScGZSwRUoYqEKAVQEVMP9kv4rL
X-Proofpoint-GUID: LRijOoScGZSwRUoYqEKAVQEVMP9kv4rL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 3eeecfd286..7d300a16bd 100644
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
index 84ea6a807a..77aa16ee8c 100644
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
index 1aaadc1e1d..798eb70af2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -165,7 +165,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
     /* Actual RAM size depends on initial RAM and device memory settings */
-    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
+    /* Workaround until Gunyah can accept mapping that starts from GiB */
+    [VIRT_MEM] =                { 2 * GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
 /*
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index 72b3027e4e..2534c8883f 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -62,5 +62,6 @@ int gunyah_add_irqfd(int irqfd, int label, Error **errp);
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


