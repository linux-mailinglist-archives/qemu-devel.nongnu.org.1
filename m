Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 573587C6B89
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHN-0001KD-Dd; Thu, 12 Oct 2023 06:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHA-0001A6-82; Thu, 12 Oct 2023 06:50:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtH5-00052y-1P; Thu, 12 Oct 2023 06:50:43 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAlL8N003498; Thu, 12 Oct 2023 10:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qZRdJSe6jQW8x9UaZOHijiKMWfhpej88oHDQkwlRGVI=;
 b=Ukss9RbmGZjcdHoBGBpPPi76WbuLWDQ1Kdd+FdESURfYZFlD2/07wJCklutDbowivlWV
 TLAR3o/Stn0HTFkrCPsZdgnxf6U2P6jf7F7/dHJTldyb7HfhwtRVJFei622TLRXZkQEu
 mx1jwA/h1SzO4NTt5KZ5Qr4iTXFWzyywF49QYcgIDN9lYrjS8bQuQZjrmhcAx6bf0LAd
 qbRvYBLRVZqt2n8T/TvfPpMxFX8jF59XpW4LnQ4vaN7ON8rDUN89NdXPVhLshy9KeIP8
 mNUJOCuYLCjPIxV2uI/2EKUB0TviLUPdsY+o/r7AM4T2Mi+IszKoEb+4gPvcutM1wXz0 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbqr2r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAm1nn006018;
 Thu, 12 Oct 2023 10:50:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbqr2qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C9aQi2025863; Thu, 12 Oct 2023 10:50:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnpx9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoTLx16450096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F08C120040;
 Thu, 12 Oct 2023 10:50:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBB2A20043;
 Thu, 12 Oct 2023 10:50:26 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:26 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 10/14] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
Date: Thu, 12 Oct 2023 16:19:47 +0530
Message-Id: <20231012104951.194876-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qsgKll8hUo_skM36QSLDAzvfkbkBAMdj
X-Proofpoint-ORIG-GUID: y1vG153bcudtiZ-mDGU52fC9SYRYIgeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 hw/ppc/spapr_nested.c         | 270 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   3 +
 include/hw/ppc/spapr_nested.h |  23 +++
 3 files changed, 296 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 8f4152bd54..f41b0c0944 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -8,6 +8,7 @@
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
+#include "qemu/log.h"
 
 void spapr_nested_init(SpaprMachineState *spapr)
 {
@@ -934,6 +935,140 @@ void spapr_nested_gsb_init(void)
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
@@ -1163,6 +1298,139 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
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
+        /* Debug print before doing anything */
+        if (false) {
+            log_element(element, gsr);
+        }
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
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1179,6 +1447,8 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
     spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
+    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
+    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
 }
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 25aa8c5ffe..b9a67895bb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -368,6 +368,7 @@ struct SpaprMachineState {
 #define H_OVERLAP         -68
 #define H_STATE           -75
 #define H_IN_USE          -77
+#define H_INVALID_ELEMENT_VALUE            -81
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -591,6 +592,8 @@ struct SpaprMachineState {
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
 #define H_GUEST_CREATE_VCPU      0x474
+#define H_GUEST_GET_STATE        0x478
+#define H_GUEST_SET_STATE        0x47C
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 9b647c0389..d27688b1b8 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -250,6 +250,10 @@ struct guest_state_element_type {
 #define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
 #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
 #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
+#define GSB_MAX_BUF_SIZE              (1024 * 1024)
+#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
+#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
+#define GUEST_STATE_REQUEST_SET              0x2
 
 #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
     .id = (i),                                     \
@@ -334,6 +338,25 @@ struct guest_state_element_type {
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
-- 
2.39.3


