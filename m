Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B077599319D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Oct 2024 17:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxppN-0002eT-Ur; Mon, 07 Oct 2024 11:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxpp9-0002HW-VT; Mon, 07 Oct 2024 11:39:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxpp7-0001Vl-Ek; Mon, 07 Oct 2024 11:39:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497DL7UY009797;
 Mon, 7 Oct 2024 15:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 klsbzDwxIcIrjxk7el8UEnNVRvGgudfv/cN9XOSCJu4=; b=lVCpkkIPYTNWiUwf
 KN2ZvY8qPw3JHT3KCAV7lRzd0MJlJIiogtgAglLzeFfYXDm2EH8HLozvK0XkLWJr
 u2eFphG6VOV563AZKuGcGsMec1DNLSKaNZVjGM+IBD0578Tk29caE6sIQHeyMAIP
 SStkUurrcHBrD7U01qt2G8MqApnqvZ+v2GfFdZT2qeIOegFq9BPOeoMDMp6/yR2V
 6uCZO1CyJeRW73LZuVv8qH3QyPk3Qs/b2KutswcZyZ29Q+7Rj70LeB8M61KaLXF5
 9pZhmwQAFjwoS/ouaYqdrjRjF5E20IE1gMl/ivZ6v2NTqtCMDSYgQ3qu4hKelz1A
 IzmbTA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424gerrruj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497FcqTo015180;
 Mon, 7 Oct 2024 15:38:52 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424gerrrub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497DexPC013833;
 Mon, 7 Oct 2024 15:38:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsrymbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 497FcoXE46137722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2024 15:38:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AF252004B;
 Mon,  7 Oct 2024 15:38:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2142920040;
 Mon,  7 Oct 2024 15:38:49 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2024 15:38:48 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v3 04/14] ppc/spapr: remove deprecated machine pseries-2.4
Date: Mon,  7 Oct 2024 21:08:28 +0530
Message-ID: <20241007153838.1085522-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007153838.1085522-1-harshpb@linux.ibm.com>
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: irVeGKP5aF1PwBPXgX5uLMJO67lGJvmZ
X-Proofpoint-GUID: cmDYxc_-vGFbx1YdtKsqUOr1luboRfkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.4 specific code with this patch for now.

While at it, also remove SpaprMachineClass::dr_lmb_enabled which is
now turned useless.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 38 ++++----------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f6de3e9972..1821ef96c7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,7 +141,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 599a59910c..4d7705c89f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -682,7 +682,6 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
 static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr mem_start, node_size;
     int i, nb_nodes = machine->numa_state->num_nodes;
     NodeInfo *nodes = machine->numa_state->nodes;
@@ -724,7 +723,6 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
     if (spapr_ovec_test(spapr->ov5_cas, OV5_DRCONF_MEMORY)) {
         int ret;
 
-        g_assert(smc->dr_lmb_enabled);
         ret = spapr_dt_dynamic_reconfiguration_memory(spapr, fdt);
         if (ret) {
             return ret;
@@ -1307,9 +1305,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     spapr_dt_cpus(fdt, spapr);
 
     /* ibm,drc-indexes and friends */
-    if (smc->dr_lmb_enabled) {
-        root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
-    }
+    root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
     if (smc->dr_phb_enabled) {
         root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
     }
@@ -2929,10 +2925,8 @@ static void spapr_machine_init(MachineState *machine)
     spapr->ov5 = spapr_ovec_new();
     spapr->ov5_cas = spapr_ovec_new();
 
-    if (smc->dr_lmb_enabled) {
-        spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
-        spapr_validate_node_memory(machine, &error_fatal);
-    }
+    spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
+    spapr_validate_node_memory(machine, &error_fatal);
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
 
@@ -3016,9 +3010,7 @@ static void spapr_machine_init(MachineState *machine)
         machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
-    if (smc->dr_lmb_enabled) {
-        spapr_create_lmb_dr_connectors(spapr);
-    }
+    spapr_create_lmb_dr_connectors(spapr);
 
     if (mc->nvdimm_supported) {
         spapr_create_nvdimm_dr_connectors(spapr);
@@ -3662,7 +3654,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
-    const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
@@ -3671,11 +3662,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Object *memdev;
     hwaddr pagesize;
 
-    if (!smc->dr_lmb_enabled) {
-        error_setg(errp, "Memory hotplug not supported for this machine");
-        return;
-    }
-
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -4713,7 +4699,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
@@ -5334,21 +5319,6 @@ static void spapr_machine_2_5_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 5);
 
-/*
- * pseries-2.4
- */
-
-static void spapr_machine_2_4_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_2_5_class_options(mc);
-    smc->dr_lmb_enabled = false;
-    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-}
-
-DEFINE_SPAPR_MACHINE(2, 4);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


