Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE82993C31
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Oct 2024 03:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyq4-0004Eg-7d; Mon, 07 Oct 2024 21:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypv-0004AJ-1q; Mon, 07 Oct 2024 21:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypr-0008MF-3c; Mon, 07 Oct 2024 21:16:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980OvVv002125;
 Tue, 8 Oct 2024 01:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=M/5O55L4D9xLC
 32wTkb064/Yo3FwLmQOtumJQJUqbXo=; b=DmjG9nQAQmyaDVkwy/J4YdDDldZyV
 LJGBh6zsozVcxVFvAHSlMacgER7S+qqRkliNdv4vNmNJ8lL6dqTjpD0ffYBY5us1
 EdjTYIUKdW7UoT5Bwfs32EP/XygWzigxI3dtJOX3UcsqFXKuoFPEaBGRyukBsM+a
 4wqoCKjeSJIoH5gV6Ys2h8kCtBZCaJt22tymJXzc+Gacc9obamg1I6bRAFzknK/2
 sj5zr2hgt4gqJaPr4SCZYp6BpCOf2s1snNXqhDfdR8I2KwJgGqkdZnehjkB+M/+I
 9Mq08Zvpqq4K5GC6vk9zxa5iLevoy4wwhUrrH2KK5DhntUrv+POpmeGqg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GK49001040;
 Tue, 8 Oct 2024 01:16:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497LU5a2022671;
 Tue, 8 Oct 2024 01:16:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jsfjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981GHes19727096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4D9358055;
 Tue,  8 Oct 2024 01:16:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4582C58043;
 Tue,  8 Oct 2024 01:16:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:17 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 16/19] s390x: Rebuild IPLB for SCSI device directly from
 DIAG308
Date: Mon,  7 Oct 2024 21:15:49 -0400
Message-ID: <20241008011552.2645520-17-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wt_j9CsqOrungpBblkIk2QiXHORF3hed
X-Proofpoint-GUID: CkLm7p3iuTjp1H40OInxvUdO3aX_Fd_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Jared Rossi <jrossi@linux.ibm.com>

Because virtio-scsi type devices use a non-architected IPLB pbt code they cannot
be set and stored normally. Instead, the IPLB must be rebuilt during re-ipl.

As s390x does not natively support multiple boot devices, the devno field is
used to store the position in the boot order for the device.

Handling the rebuild as part of DIAG308 removes the need to check the devices
for invalid IPLBs later in the IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h              | 11 ++++--
 include/hw/s390x/ipl/qipl.h |  3 +-
 hw/s390x/ipl.c              | 75 +++++++------------------------------
 pc-bios/s390-ccw/jump2ipl.c | 11 ++++--
 target/s390x/diag.c         |  9 ++++-
 5 files changed, 39 insertions(+), 70 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 54eb48fd6e..aead1d6ae5 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -24,6 +24,7 @@
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
+void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 int s390_ipl_prepare_pv_header(Error **errp);
 int s390_ipl_pv_unpack(void);
@@ -65,7 +66,8 @@ struct S390IPLState {
     bool enforce_bios;
     bool iplb_valid;
     bool iplb_valid_pv;
-    bool netboot;
+    bool rebuilt_iplb;
+    uint16_t iplb_index;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
     int reset_cpu_index;
@@ -172,11 +174,14 @@ static inline bool iplb_valid_pv(IplParameterBlock *iplb)
 
 static inline bool iplb_valid(IplParameterBlock *iplb)
 {
+    uint32_t len = be32_to_cpu(iplb->len);
+
     switch (iplb->pbt) {
     case S390_IPL_TYPE_FCP:
-        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
+        return len >= S390_IPLB_MIN_FCP_LEN;
     case S390_IPL_TYPE_CCW:
-        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
+        return (len >= S390_IPLB_MIN_CCW_LEN);
+    case S390_IPL_TYPE_QEMU_SCSI:
     default:
         return false;
     }
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index e56b181298..451f3b1684 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -28,7 +28,8 @@
  */
 struct QemuIplParameters {
     uint8_t  qipl_flags;
-    uint8_t  reserved1[3];
+    uint8_t  index;
+    uint8_t  reserved1[2];
     uint64_t reserved2;
     uint32_t boot_menu_timeout;
     uint8_t  reserved3[2];
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index aec79f41a8..50fde05b67 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -448,7 +448,6 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
 
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
-    S390IPLState *ipl = get_ipl_device();
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
@@ -481,9 +480,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
-            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
-            ipl->netboot = true;
-            /* Fall through to CCW_DEVTYPE_VIRTIO case */
         case CCW_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             iplb->blk0_len =
@@ -508,6 +504,17 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     return false;
 }
 
+
+void s390_rebuild_iplb(uint16_t dev_index, IplParameterBlock *iplb)
+{
+    S390IPLState *ipl = get_ipl_device();
+    uint16_t index;
+    index = ipl->rebuilt_iplb ? ipl->iplb_index : dev_index;
+
+    ipl->rebuilt_iplb = s390_build_iplb(get_boot_device(index), iplb);
+    ipl->iplb_index = index;
+}
+
 static bool s390_init_all_iplbs(S390IPLState *ipl)
 {
     int iplb_num = 0;
@@ -558,44 +565,6 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
     return iplb_num;
 }
 
-static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
-                                         int virtio_id)
-{
-    uint8_t cssid;
-    uint8_t ssid;
-    uint16_t devno;
-    uint16_t schid;
-    SubchDev *sch = NULL;
-
-    if (iplb->pbt != S390_IPL_TYPE_CCW) {
-        return false;
-    }
-
-    devno = be16_to_cpu(iplb->ccw.devno);
-    ssid = iplb->ccw.ssid & 3;
-
-    for (schid = 0; schid < MAX_SCHID; schid++) {
-        for (cssid = 0; cssid < MAX_CSSID; cssid++) {
-            sch = css_find_subch(1, cssid, ssid, schid);
-
-            if (sch && sch->devno == devno) {
-                return sch->id.cu_model == virtio_id;
-            }
-        }
-    }
-    return false;
-}
-
-static bool is_virtio_net_device(IplParameterBlock *iplb)
-{
-    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_NET);
-}
-
-static bool is_virtio_scsi_device(IplParameterBlock *iplb)
-{
-    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
-}
-
 static void update_machine_ipl_properties(IplParameterBlock *iplb)
 {
     Object *machine = qdev_get_machine();
@@ -635,7 +604,7 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
         ipl->iplb = *iplb;
         ipl->iplb_valid = true;
     }
-    ipl->netboot = is_virtio_net_device(iplb);
+
     update_machine_ipl_properties(iplb);
 }
 
@@ -662,32 +631,14 @@ IplParameterBlock *s390_ipl_get_iplb(void)
 void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
 {
     S390IPLState *ipl = get_ipl_device();
-
     if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
         /* use CPU 0 for full resets */
         ipl->reset_cpu_index = 0;
     } else {
         ipl->reset_cpu_index = cs->cpu_index;
     }
-    ipl->reset_type = reset_type;
 
-    if (reset_type == S390_RESET_REIPL &&
-        ipl->iplb_valid &&
-        !ipl->netboot &&
-        ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
-        is_virtio_scsi_device(&ipl->iplb)) {
-        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), NULL);
-
-        if (ccw_dev &&
-            cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
-            (ccw_dev->sch->ssid & 3) == ipl->iplb.ccw.ssid) {
-            /*
-             * this is the original boot device's SCSI
-             * so restore IPL parameter info from it
-             */
-            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
-        }
-    }
+    ipl->reset_type = reset_type;
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
         reset_type == S390_RESET_LOAD_NORMAL ||
         reset_type == S390_RESET_PV) {
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 92627b56c6..711a69a206 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -40,10 +40,15 @@ int jump_to_IPL_code(uint64_t address)
     write_subsystem_identification();
     write_iplb_location();
 
-    /* prevent unknown IPL types in the guest */
+    /*
+     * The IPLB for QEMU SCSI type devices must be rebuilt during re-ipl. The
+     * iplb.devno is set to the boot position of the target SCSI device.
+     */
     if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
-        iplb.pbt = S390_IPL_TYPE_CCW;
-        set_iplb(&iplb);
+        iplb.devno = qipl.index;
+        if (!set_iplb(&iplb)) {
+            panic("Failed to set IPLB");
+        }
     }
 
     /*
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 27ffd48576..a1fd54ddac 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -133,7 +133,14 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
-            env->regs[r1 + 1] = DIAG_308_RC_INVALID;
+            if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {
+                s390_rebuild_iplb(iplb->devno, iplb);
+                s390_ipl_update_diag308(iplb);
+                env->regs[r1 + 1] = DIAG_308_RC_OK;
+            } else {
+                env->regs[r1 + 1] = DIAG_308_RC_INVALID;
+            }
+
             goto out;
         }
 
-- 
2.45.1


