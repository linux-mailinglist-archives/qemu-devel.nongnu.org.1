Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732583125E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:27:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKuJ-0006YM-Ck; Thu, 18 Jan 2024 00:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKu4-0006OU-Us; Thu, 18 Jan 2024 00:25:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKu2-0006c2-DY; Thu, 18 Jan 2024 00:25:24 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3DLKr006032; Thu, 18 Jan 2024 05:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tgcx4H8IETF02osGW5XvqgNDS1WoIN1l26Zz/lM50sA=;
 b=oJYrs3MNsLXHGqnAlzKi+q0egt/BahWDteRAz2WHChbWztHq1S50y5QKm+XcFs214tPT
 TTgPyum1IQ1RSWk6F85LY8zzqHSMewCke/rg09D5VZO8LBawe3FHchwwt4J92tzw9YhF
 6HhSURnP9a4mC+ZW0KaqXa8hq7DVi5qux8wpqkebGtsVau6y5t4l9DM+Fn/mirO7cIdT
 T8sW5eMsjWzV6N++pBws46dAzcDmqHhj11H8FyD4j/TRH0jkGabmJbqkaTcX+FGR84tt
 1TGdjT157Z5TFN0IBcv6v7WnmHr+fD6gowXdxSggva2QhQ8g6u02fvWh6zgy68wUCykY 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpuvu26qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:17 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5M609012414;
 Thu, 18 Jan 2024 05:25:17 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpuvu26qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:17 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3KSxC006528; Thu, 18 Jan 2024 05:25:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j210m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5PDnA45220228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:25:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A33DD20043;
 Thu, 18 Jan 2024 05:25:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1017920040;
 Thu, 18 Jan 2024 05:25:12 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:25:11 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 11/15] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
Date: Thu, 18 Jan 2024 10:54:34 +0530
Message-Id: <20240118052438.1475437-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zcTxsCuakXb3b0YD8CZEo7eFc00oRzxZ
X-Proofpoint-ORIG-GUID: GtF_aSRcEeoRZIOpBtYz8NA8_onCDUmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce the nested PAPR hcalls:
    - H_GUEST_GET_STATE which is used to get state of a nested guest or
      a guest VCPU. The value field for each element in the request is
      ignored and on success, will be updated to reflect current state.
    - H_GUEST_SET_STATE which is used to modify the state of a guest or
      a guest VCPU. On success, guest (or its VCPU) state shall be
      updated as per the value field for the requested element(s).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |   3 +
 include/hw/ppc/spapr_nested.h |  23 +++
 hw/ppc/spapr_nested.c         | 267 ++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fb5e8c093d..e83a9272c4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -366,6 +366,7 @@ struct SpaprMachineState {
 #define H_OVERLAP         -68
 #define H_STATE           -75
 #define H_IN_USE          -77
+#define H_INVALID_ELEMENT_VALUE            -81
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -589,6 +590,8 @@ struct SpaprMachineState {
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
 #define H_GUEST_CREATE_VCPU      0x474
+#define H_GUEST_GET_STATE        0x478
+#define H_GUEST_SET_STATE        0x47C
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index a71aa3fada..c124dd1455 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -225,6 +225,10 @@ typedef struct SpaprMachineStateNestedGuest {
 #define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
 #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
 #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
+#define GSB_MAX_BUF_SIZE              (1024 * 1024)
+#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
+#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
+#define GUEST_STATE_REQUEST_SET              0x2
 
 #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
     .id = (i),                                     \
@@ -313,6 +317,25 @@ typedef struct SpaprMachineStateNestedGuest {
 #define GSE_ENV_DWM(i, f, m) \
     GUEST_STATE_ELEMENT_MSK(i, 8, f, copy_state_8to8, m)
 
+struct guest_state_element {
+    uint16_t id;
+    uint16_t size;
+    uint8_t value[];
+} QEMU_PACKED;
+
+struct guest_state_buffer {
+    uint32_t num_elements;
+    struct guest_state_element elements[];
+} QEMU_PACKED;
+
+/* Actual buffer plus some metadata about the request */
+struct guest_state_request {
+    struct guest_state_buffer *gsb;
+    int64_t buf;
+    int64_t len;
+    uint16_t flags;
+};
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 4e8b392144..dba7161563 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -8,6 +8,7 @@
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
+#include "qemu/log.h"
 
 void spapr_nested_init(SpaprMachineState *spapr)
 {
@@ -999,6 +1000,140 @@ void spapr_nested_gsb_init(void)
     }
 }
 
+static struct guest_state_element *guest_state_element_next(
+    struct guest_state_element *element,
+    int64_t *len,
+    int64_t *num_elements)
+{
+    uint16_t size;
+
+    /* size is of element->value[] only. Not whole guest_state_element */
+    size = be16_to_cpu(element->size);
+
+    if (len) {
+        *len -= size + offsetof(struct guest_state_element, value);
+    }
+
+    if (num_elements) {
+        *num_elements -= 1;
+    }
+
+    return (struct guest_state_element *)(element->value + size);
+}
+
+static
+struct guest_state_element_type *guest_state_element_type_find(uint16_t id)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(guest_state_element_types); i++)
+        if (id == guest_state_element_types[i].id) {
+            return &guest_state_element_types[i];
+        }
+
+    return NULL;
+}
+
+static void log_element(struct guest_state_element *element,
+                        struct guest_state_request *gsr)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "h_guest_%s_state id:0x%04x size:0x%04x",
+                  gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get",
+                  be16_to_cpu(element->id), be16_to_cpu(element->size));
+    qemu_log_mask(LOG_GUEST_ERROR, "buf:0x%016lx ...\n",
+                  be64_to_cpu(*(uint64_t *)element->value));
+}
+
+static bool guest_state_request_check(struct guest_state_request *gsr)
+{
+    int64_t num_elements, len = gsr->len;
+    struct guest_state_buffer *gsb = gsr->gsb;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    uint16_t id, size;
+
+    /* gsb->num_elements = 0 == 32 bits long */
+    assert(len >= 4);
+
+    num_elements = be32_to_cpu(gsb->num_elements);
+    element = gsb->elements;
+    len -= sizeof(gsb->num_elements);
+
+    /* Walk the buffer to validate the length */
+    while (num_elements) {
+
+        id = be16_to_cpu(element->id);
+        size = be16_to_cpu(element->size);
+
+        if (false) {
+            log_element(element, gsr);
+        }
+        /* buffer size too small */
+        if (len < 0) {
+            return false;
+        }
+
+        type = guest_state_element_type_find(id);
+        if (!type) {
+            qemu_log_mask(LOG_GUEST_ERROR,"Element ID %04x unknown\n", id);
+            log_element(element, gsr);
+            return false;
+        }
+
+        if (id == GSB_HV_VCPU_IGNORED_ID) {
+            goto next_element;
+        }
+
+        if (size != type->size) {
+            qemu_log_mask(LOG_GUEST_ERROR,"Size mismatch. Element ID:%04x."
+                          "Size Exp:%i Got:%i\n", id, type->size, size);
+            log_element(element, gsr);
+            return false;
+        }
+
+        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
+            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
+            qemu_log_mask(LOG_GUEST_ERROR,"trying to set a read-only Element "
+                          "ID:%04x.\n", id);
+            return false;
+        }
+
+        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
+            /* guest wide element type */
+            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        } else {
+            /* thread wide element type */
+            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        }
+next_element:
+        element = guest_state_element_next(element, &len, &num_elements);
+
+    }
+    return true;
+}
+
+static bool is_gsr_invalid(struct guest_state_request *gsr,
+                                   struct guest_state_element *element,
+                                   struct guest_state_element_type *type)
+{
+    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
+        (*(uint64_t *)(element->value) & ~(type->mask))) {
+        log_element(element, gsr);
+        qemu_log_mask(LOG_GUEST_ERROR, "L1 can't set reserved bits i"
+                      "(allowed mask: 0x%08lx)\n", type->mask);
+        return true;
+    }
+    return false;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -1249,6 +1384,136 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
+                                 uint64_t vcpuid,
+                                 struct guest_state_request *gsr)
+{
+    void *ptr;
+    uint16_t id;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    int64_t lenleft, num_elements;
+
+    lenleft = gsr->len;
+
+    if (!guest_state_request_check(gsr)) {
+        return H_P3;
+    }
+
+    num_elements = be32_to_cpu(gsr->gsb->num_elements);
+    element = gsr->gsb->elements;
+    /* Process the elements */
+    while (num_elements) {
+        type = NULL;
+        /* log_element(element, gsr); */
+
+        id = be16_to_cpu(element->id);
+        if (id == GSB_HV_VCPU_IGNORED_ID) {
+            goto next_element;
+        }
+
+        type = guest_state_element_type_find(id);
+        assert(type);
+
+        /* Get pointer to guest data to get/set */
+        if (type->location && type->copy) {
+            ptr = type->location(guest, vcpuid);
+            assert(ptr);
+            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
+                return H_INVALID_ELEMENT_VALUE;
+            }
+            type->copy(ptr + type->offset, element->value,
+                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : false);
+        }
+
+next_element:
+        element = guest_state_element_next(element, &lenleft, &num_elements);
+    }
+
+    return H_SUCCESS;
+}
+
+static target_ulong map_and_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineStateNestedGuest *guest,
+                                         uint64_t vcpuid,
+                                         struct guest_state_request *gsr)
+{
+    target_ulong rc;
+    int64_t len;
+    bool is_write;
+
+    len = gsr->len;
+    /* only get_state would require write access to the provided buffer */
+    is_write = (gsr->flags & GUEST_STATE_REQUEST_SET) ? false : true;
+    gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
+                                 is_write, MEMTXATTRS_UNSPECIFIED);
+    if (!gsr->gsb) {
+        rc = H_P3;
+        goto out1;
+    }
+
+    if (len != gsr->len) {
+        rc = H_P3;
+        goto out1;
+    }
+
+    rc = getset_state(guest, vcpuid, gsr);
+
+out1:
+    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
+    return rc;
+}
+
+static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
+                                         target_ulong *args,
+                                         bool set)
+{
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    target_ulong vcpuid = args[2];
+    target_ulong buf = args[3];
+    target_ulong buflen = args[4];
+    struct guest_state_request gsr;
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return H_P2;
+    }
+    gsr.buf = buf;
+    assert(buflen <= GSB_MAX_BUF_SIZE);
+    gsr.len = buflen;
+    gsr.flags = 0;
+    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
+    }
+    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+        return H_PARAMETER; /* flag not supported yet */
+    }
+
+    if (set) {
+        gsr.flags |= GUEST_STATE_REQUEST_SET;
+    }
+    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
+}
+
+static target_ulong h_guest_set_state(PowerPCCPU *cpu,
+                                      SpaprMachineState *spapr,
+                                      target_ulong opcode,
+                                      target_ulong *args)
+{
+    return h_guest_getset_state(cpu, spapr, args, true);
+}
+
+static target_ulong h_guest_get_state(PowerPCCPU *cpu,
+                                      SpaprMachineState *spapr,
+                                      target_ulong opcode,
+                                      target_ulong *args)
+{
+    return h_guest_getset_state(cpu, spapr, args, false);
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1264,6 +1529,8 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
     spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
+    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
+    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
 }
 
 #else
-- 
2.39.3


