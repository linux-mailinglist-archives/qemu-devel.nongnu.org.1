Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B726A1A3A6
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Jan 2025 12:57:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tavog-0002EW-OI; Thu, 23 Jan 2025 06:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1tavoY-0002E6-Ir; Thu, 23 Jan 2025 06:56:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1tavoU-0000L2-Io; Thu, 23 Jan 2025 06:56:02 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N5OTit026990;
 Thu, 23 Jan 2025 11:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QSasE6uMcVJWZc6jLuNmWokxnH9xNhwa454V2UMAv
 Qg=; b=aK1QaI/HFUAaEpdeQ4szW5vo+1hu1ZICm/Mb26OekL14VF+PkMM80TQe3
 PqubgigLmN0Dsz9vFFS4EJWotgtAz20mBE8GmDKf0hJG4QZ5tP2IoQ1a3Bolr25C
 qM3bC++Qgym2eNfYgPi0+Fi/OK0V6g7K/wMIZYHAJ7AGM6s3hrseeP4qHaqe5Dmy
 6VoIT09ERaiC+A1DMtThn8nWIbnPt3n7K6zKdb1Bp5I3aruaTfjHl6TWhybzO75l
 UGF9DT6uraTAT1uwCY6BQXv5gTA/oKUfrudW4N1TS0e3p/oWcZOEDjK6wJUfG1yJ
 Yx9TOz9krsla37U9PVEZFMc4Qc4Sw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7sras-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 11:55:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50NBlfkQ008689;
 Thu, 23 Jan 2025 11:55:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7sraq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 11:55:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NAosr4029610;
 Thu, 23 Jan 2025 11:55:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnnceh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 11:55:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NBtn5K64946650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 11:55:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 172E120040;
 Thu, 23 Jan 2025 11:55:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E7E82004B;
 Thu, 23 Jan 2025 11:55:46 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.210.34])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 23 Jan 2025 11:55:46 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Thu, 23 Jan 2025 17:25:45 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: qemu-devel@nongnu.org, kvm-ppc@vger.kernel.org, qemu-ppc@nongnu.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, shivaprasadbhat@gmail.com
Subject: [PATCH v2] spapr: nested: Add support for reporting Hostwide state
 counter
Date: Thu, 23 Jan 2025 17:25:37 +0530
Message-ID: <20250123115538.86821-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JCVfv5_MfLi8Kv1vHH2uUcdz6iazI0Es
X-Proofpoint-ORIG-GUID: Opj3IBuxjWAr7YvUkXETJOViVYfH6c_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vaibhav@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add support for reporting Hostwide state counters for nested KVM pseries
guests running with 'cap-nested-papr' on Qemu-TCG acting as
L0-hypervisor. sPAPR supports reporting various stats counters for
Guest-Management-Area(GMA) thats owned by L0-Hypervisor and are documented
at [1]. These stats counters are exposed via a new bit-flag named
'getHostWideState' for the H_GUEST_GET_STATE hcall. Once this flag is set
the hcall should populate the Guest-State-Elements in the requested GSB
with the stat counter values. Currently following five counters are
supported:

* host_heap		: The currently used bytes in the
			  Hypervisor's Guest Management Space
			  associated with the Host Partition.
* host_heap_max		: The maximum bytes available in the
			  Hypervisor's Guest Management Space
			  associated with the Host Partition.
* host_pagetable	: The currently used bytes in the
			  Hypervisor's Guest Page Table Management
			  Space associated with the Host Partition.
* host_pagetable_max	: The maximum bytes available in the
			  Hypervisor's Guest Page Table Management
			  Space associated with the Host Partition.
* host_pagetable_reclaim: The amount of space in bytes that has
			  been reclaimed due to overcommit in the
			  Hypervisor's Guest Page Table Management
			  Space associated with the Host Partition.

At the moment '0' is being reported for all these counters as these
counters doesnt align with how L0-Qemu manages Guest memory.

The patch implements support for these counters by adding new members to
the 'struct SpaprMachineStateNested'. These new members are then plugged
into the existing 'guest_state_element_types[]' with the help of a new
macro 'GSBE_NESTED_MACHINE_DW' together with a new helper
'get_machine_ptr()'. guest_state_request_check() is updated to ensure
correctness of the requested GSB and finally h_guest_getset_state() is
updated to handle the newly introduced flag
'GUEST_STATE_REQUEST_HOST_WIDE'.

This patch is tested with the proposed linux-kernel implementation to
expose these stat-counter as perf-events at [2].

[1]
https://lore.kernel.org/all/20241222140247.174998-2-vaibhav@linux.ibm.com

[2]
https://lore.kernel.org/all/20241222140247.174998-1-vaibhav@linux.ibm.com

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v1->v2:
* Introduced new flags to correctly compare hcall flags
  for H_GUEST_{GET,SET}_STATE [Harsh]
* Fixed ordering of new GSB elements in spapr_nested.h [Harsh]
* s/GSBE_MACHINE_NESTED_DW/GSBE_NESTED_MACHINE_DW/
* Minor tweaks to patch description
* Updated recipients list
---
 hw/ppc/spapr_nested.c         | 82 ++++++++++++++++++++++++++---------
 include/hw/ppc/spapr_nested.h | 39 ++++++++++++++---
 2 files changed, 96 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 7def8eb73b..7f484bb3e7 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -64,10 +64,9 @@ static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
-    SpaprMachineStateNestedGuest *guest;
-
-    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
-    return guest;
+    return spapr->nested.guests ?
+        g_hash_table_lookup(spapr->nested.guests,
+                            GINT_TO_POINTER(guestid)) : NULL;
 }
 
 bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
@@ -613,6 +612,13 @@ static void *get_guest_ptr(SpaprMachineStateNestedGuest *guest,
     return guest; /* for GSBE_NESTED */
 }
 
+static void *get_machine_ptr(SpaprMachineStateNestedGuest *guest,
+                             target_ulong vcpuid)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    return &spapr->nested;
+}
+
 /*
  * set=1 means the L1 is trying to set some state
  * set=0 means the L1 is trying to get some state
@@ -1012,7 +1018,12 @@ struct guest_state_element_type guest_state_element_types[] = {
     GSBE_NESTED_VCPU(GSB_VCPU_OUT_BUFFER, 0x10, runbufout,   copy_state_runbuf),
     GSBE_NESTED_VCPU(GSB_VCPU_OUT_BUF_MIN_SZ, 0x8, runbufout, out_buf_min_size),
     GSBE_NESTED_VCPU(GSB_VCPU_HDEC_EXPIRY_TB, 0x8, hdecr_expiry_tb,
-                     copy_state_hdecr)
+                     copy_state_hdecr),
+    GSBE_NESTED_MACHINE_DW(GSB_GUEST_HEAP, current_guest_heap),
+    GSBE_NESTED_MACHINE_DW(GSB_GUEST_HEAP_MAX, max_guest_heap),
+    GSBE_NESTED_MACHINE_DW(GSB_GUEST_PGTABLE_SIZE, current_pgtable_size),
+    GSBE_NESTED_MACHINE_DW(GSB_GUEST_PGTABLE_SIZE_MAX, max_pgtable_size),
+    GSBE_NESTED_MACHINE_DW(GSB_GUEST_PGTABLE_RECLAIM, pgtable_reclaim_size),
 };
 
 void spapr_nested_gsb_init(void)
@@ -1030,8 +1041,12 @@ void spapr_nested_gsb_init(void)
         else if (type->id >= GSB_VCPU_IN_BUFFER)
             /* 0x0c00 - 0xf000 Thread + RW */
             type->flags = 0;
+        else if (type->id >= GSB_GUEST_HEAP)
+            /*0x0800 - 0x0804 Hostwide Counters + RO */
+            type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE |
+                          GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY;
         else if (type->id >= GSB_VCPU_LPVR)
-            /* 0x0003 - 0x0bff Guest + RW */
+            /* 0x0003 - 0x07ff Guest + RW */
             type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE;
         else if (type->id >= GSB_HV_VCPU_STATE_SIZE)
             /* 0x0001 - 0x0002 Guest + RO */
@@ -1138,18 +1153,26 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
             return false;
         }
 
-        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
+        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE) {
+            /* Hostwide elements cant be clubbed with other types */
+            if (!(gsr->flags & GUEST_STATE_REQUEST_HOST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to get/set a host wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        } else  if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
             /* guest wide element type */
             if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wide "
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to get/set a guest wide "
                               "Element ID:%04x.\n", id);
                 return false;
             }
         } else {
             /* thread wide element type */
-            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
-                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread wide "
-                              "Element ID:%04x.\n", id);
+            if (gsr->flags & (GUEST_STATE_REQUEST_GUEST_WIDE |
+                              GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to get/set a thread wide"
+                            " Element ID:%04x.\n", id);
                 return false;
             }
         }
@@ -1509,25 +1532,44 @@ static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
     target_ulong buf = args[3];
     target_ulong buflen = args[4];
     struct guest_state_request gsr;
-    SpaprMachineStateNestedGuest *guest;
+    SpaprMachineStateNestedGuest *guest = NULL;
 
-    guest = spapr_get_nested_guest(spapr, lpid);
-    if (!guest) {
-        return H_P2;
-    }
     gsr.buf = buf;
     assert(buflen <= GSB_MAX_BUF_SIZE);
     gsr.len = buflen;
     gsr.flags = 0;
-    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+
+    /* Works for both get/set state */
+    if ((flags & H_GUEST_GET_STATE_FLAGS_GUEST_WIDE) ||
+        (flags & H_GUEST_SET_STATE_FLAGS_GUEST_WIDE)) {
         gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
     }
-    if (flags & ~H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
-        return H_PARAMETER; /* flag not supported yet */
-    }
 
     if (set) {
+        if (flags & ~H_GUEST_SET_STATE_FLAGS_MASK) {
+            return H_PARAMETER;
+        }
         gsr.flags |= GUEST_STATE_REQUEST_SET;
+    } else {
+        /*
+         * No reserved fields to be set in flags nor both
+         * GUEST/HOST wide bits
+         */
+        if ((flags == H_GUEST_GET_STATE_FLAGS_MASK) ||
+            (flags & ~H_GUEST_GET_STATE_FLAGS_MASK)) {
+            return H_PARAMETER;
+        }
+
+        if (flags & H_GUEST_GET_STATE_FLAGS_HOST_WIDE) {
+            gsr.flags |= GUEST_STATE_REQUEST_HOST_WIDE;
+        }
+    }
+
+    if (!(gsr.flags & GUEST_STATE_REQUEST_HOST_WIDE)) {
+        guest = spapr_get_nested_guest(spapr, lpid);
+        if (!guest) {
+            return H_P2;
+        }
     }
     return map_and_getset_state(cpu, guest, vcpuid, &gsr);
 }
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index e420220484..a6d10a1fba 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -11,7 +11,13 @@
 #define GSB_TB_OFFSET           0x0004 /* Timebase Offset */
 #define GSB_PART_SCOPED_PAGETBL 0x0005 /* Partition Scoped Page Table */
 #define GSB_PROCESS_TBL         0x0006 /* Process Table */
-                    /* RESERVED 0x0007 - 0x0BFF */
+                   /* RESERVED 0x0007 - 0x07FF */
+#define GSB_GUEST_HEAP          0x0800 /* Guest Management Heap Size */
+#define GSB_GUEST_HEAP_MAX      0x0801 /* Guest Management Heap Max Size */
+#define GSB_GUEST_PGTABLE_SIZE  0x0802 /* Guest Pagetable Size */
+#define GSB_GUEST_PGTABLE_SIZE_MAX   0x0803 /* Guest Pagetable Max Size */
+#define GSB_GUEST_PGTABLE_RECLAIM    0x0804 /* Pagetable Reclaim in bytes */
+                  /* RESERVED 0x0805 - 0xBFF */
 #define GSB_VCPU_IN_BUFFER      0x0C00 /* Run VCPU Input Buffer */
 #define GSB_VCPU_OUT_BUFFER     0x0C01 /* Run VCPU Out Buffer */
 #define GSB_VCPU_VPA            0x0C02 /* HRA to Guest VCPU VPA */
@@ -196,6 +202,13 @@ typedef struct SpaprMachineStateNested {
 #define NESTED_API_PAPR    2
     bool capabilities_set;
     uint32_t pvr_base;
+    /* Hostwide counters */
+    uint64_t current_guest_heap;
+    uint64_t max_guest_heap;
+    uint64_t current_pgtable_size;
+    uint64_t max_pgtable_size;
+    uint64_t pgtable_reclaim_size;
+
     GHashTable *guests;
 } SpaprMachineStateNested;
 
@@ -229,9 +242,15 @@ typedef struct SpaprMachineStateNestedGuest {
 #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
 #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
 #define GSB_MAX_BUF_SIZE              (1024 * 1024)
-#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
-#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
-#define GUEST_STATE_REQUEST_SET              0x2
+#define H_GUEST_GET_STATE_FLAGS_MASK   0xC000000000000000ULL
+#define H_GUEST_SET_STATE_FLAGS_MASK   0x8000000000000000ULL
+#define H_GUEST_SET_STATE_FLAGS_GUEST_WIDE 0x8000000000000000ULL
+#define H_GUEST_GET_STATE_FLAGS_GUEST_WIDE 0x8000000000000000ULL
+#define H_GUEST_GET_STATE_FLAGS_HOST_WIDE  0x4000000000000000ULL
+
+#define GUEST_STATE_REQUEST_GUEST_WIDE     0x1
+#define GUEST_STATE_REQUEST_HOST_WIDE      0x2
+#define GUEST_STATE_REQUEST_SET            0x4
 
 /*
  * As per ISA v3.1B, following bits are reserved:
@@ -251,6 +270,15 @@ typedef struct SpaprMachineStateNestedGuest {
     .copy = (c)                                    \
 }
 
+#define GSBE_NESTED_MACHINE_DW(i, f)  {                             \
+        .id = (i),                                                  \
+        .size = 8,                                                  \
+        .location = get_machine_ptr,                                \
+        .offset = offsetof(struct SpaprMachineStateNested, f),     \
+        .copy = copy_state_8to8,                                    \
+        .mask = HVMASK_DEFAULT                                      \
+}
+
 #define GSBE_NESTED(i, sz, f, c) {                             \
     .id = (i),                                                 \
     .size = (sz),                                              \
@@ -509,7 +537,8 @@ struct guest_state_element_type {
     uint16_t id;
     int size;
 #define GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE 0x1
-#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY  0x2
+#define GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE 0x2
+#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY 0x4
    uint16_t flags;
     void *(*location)(SpaprMachineStateNestedGuest *, target_ulong);
     size_t offset;
-- 
2.48.1


