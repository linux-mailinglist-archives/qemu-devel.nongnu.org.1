Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 699229A1811
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 03:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Fd4-0004Zt-6S; Wed, 16 Oct 2024 21:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1Fcy-0004YM-Um; Wed, 16 Oct 2024 21:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1Fcw-00032c-DV; Wed, 16 Oct 2024 21:48:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H1OC3x002874;
 Thu, 17 Oct 2024 01:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A8mVz4WQU0cf5pNgS
 CR84vEO6nxoMAlGT4+hsDwJHCs=; b=IJTAsVLKfhg4P182Z2+Of3m4w7cGWIHmB
 8ust1qst74uyagSuvhUmREOXve2QWiEuz5BNh5tmaEDxlP/yErrNFJEVkBQBjin4
 8eCXjRfx/3I27AGCIZQK1uyWbpqzeiZc7Oyaax/XChQ5sda5ieYCceORcWlZWoeF
 Dira1ku6lHNde50IkNz2lQyVsj+iyNCSbyAggzybs1ldwXD/aXriEmyznsjat5C8
 rdq89X0DkXT7DgegaLQOUOZL6N0Fyyu4iBZSCrgZywhArLjFj6iFbYBru/Obc8kX
 kYVwUAbxMkjCy3ZySpXxswYpClFOZ36hfHBsUby6DXWuo1h6H+ZeQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42arvc02jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H1hdTr005310;
 Thu, 17 Oct 2024 01:48:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42arvc02jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49H0hlte002408;
 Thu, 17 Oct 2024 01:48:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emvd5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49H1m8NH42402192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 01:48:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A43F58052;
 Thu, 17 Oct 2024 01:48:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7E475805A;
 Thu, 17 Oct 2024 01:48:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.153.16])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 01:48:07 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v4 12/19] pc-bios/s390-ccw: Enable failed IPL to return after
 error
Date: Wed, 16 Oct 2024 21:47:41 -0400
Message-ID: <20241017014748.829029-13-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017014748.829029-1-jrossi@linux.ibm.com>
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vo2JmIMjjOWdrMNnRMUIgyDvmyWa74t5
X-Proofpoint-ORIG-GUID: p9bToZsTSRAra4U8oLbA-iLVtIigLeRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Jared Rossi <jrossi@linux.ibm.com>

Remove panic-on-error from IPL functions such that a return code is propagated
back to the main IPL calling function (rather than terminating immediately),
which facilitates possible error recovery in the future.

A select few panics remain, which indicate fatal non-devices errors that must
result in termination.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h      |  2 +-
 pc-bios/s390-ccw/virtio.h        |  2 +-
 pc-bios/s390-ccw/bootmap.c       | 53 ++++++++++++++++++--------
 pc-bios/s390-ccw/cio.c           |  3 +-
 pc-bios/s390-ccw/jump2ipl.c      |  5 ++-
 pc-bios/s390-ccw/main.c          | 32 +++++++++-------
 pc-bios/s390-ccw/virtio-blkdev.c |  4 +-
 pc-bios/s390-ccw/virtio.c        | 65 +++++++++++++++++++++-----------
 8 files changed, 109 insertions(+), 57 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 344ad15655..6cdce3e5e5 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -78,7 +78,7 @@ void zipl_load(void);
 
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
-void jump_to_IPL_code(uint64_t address);
+int jump_to_IPL_code(uint64_t address);
 void jump_to_low_kernel(void);
 
 /* menu.c */
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 6f9a558ff5..9faf3986b1 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -274,7 +274,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
-void virtio_setup_ccw(VDev *vdev);
+int virtio_setup_ccw(VDev *vdev);
 
 int virtio_net_init(void *mac_addr);
 
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index f1cfb7aaa8..255d21c72f 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -62,15 +62,34 @@ static void *s2_prev_blk = _s2;
 static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
 static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
 
-static inline void verify_boot_info(BootInfo *bip)
+static inline int verify_boot_info(BootInfo *bip)
 {
-    IPL_assert(magic_match(bip->magic, ZIPL_MAGIC), "No zIPL sig in BootInfo");
-    IPL_assert(bip->version == BOOT_INFO_VERSION, "Wrong zIPL version");
-    IPL_assert(bip->bp_type == BOOT_INFO_BP_TYPE_IPL, "DASD is not for IPL");
-    IPL_assert(bip->dev_type == BOOT_INFO_DEV_TYPE_ECKD, "DASD is not ECKD");
-    IPL_assert(bip->flags == BOOT_INFO_FLAGS_ARCH, "Not for this arch");
-    IPL_assert(block_size_ok(bip->bp.ipl.bm_ptr.eckd.bptr.size),
-               "Bad block size in zIPL section of the 1st record.");
+    if (!magic_match(bip->magic, ZIPL_MAGIC)) {
+        puts("No zIPL sig in BootInfo");
+        return -EINVAL;
+    }
+    if (bip->version != BOOT_INFO_VERSION) {
+        puts("Wrong zIPL version");
+        return -EINVAL;
+    }
+    if (bip->bp_type != BOOT_INFO_BP_TYPE_IPL) {
+        puts("DASD is not for IPL");
+        return -ENODEV;
+    }
+    if (bip->dev_type != BOOT_INFO_DEV_TYPE_ECKD) {
+        puts("DASD is not ECKD");
+        return -ENODEV;
+    }
+    if (bip->flags != BOOT_INFO_FLAGS_ARCH) {
+        puts("Not for this arch");
+        return -EINVAL;
+    }
+    if (!block_size_ok(bip->bp.ipl.bm_ptr.eckd.bptr.size)) {
+        puts("Bad block size in zIPL section of 1st record");
+        return -EINVAL;
+    }
+
+    return 0;
 }
 
 static void eckd_format_chs(ExtEckdBlockPtr *ptr,  bool ldipl,
@@ -368,8 +387,8 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
         puts("Unknown script entry type");
         return -EINVAL;
     }
-    write_reset_psw(bms->entry[i].address.load_address); /* no return */
-    jump_to_IPL_code(0); /* no return */
+    write_reset_psw(bms->entry[i].address.load_address);
+    jump_to_IPL_code(0);
     return 1;
 }
 
@@ -1068,16 +1087,19 @@ void zipl_load(void)
 
     if (vdev->is_cdrom) {
         ipl_iso_el_torito();
-        panic("\n! Cannot IPL this ISO image !\n");
+        puts("Failed to IPL this ISO image!");
+        return;
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         netmain();
-        panic("\n! Cannot IPL from this network !\n");
+        puts("Failed to IPL from this network!");
+        return;
     }
 
     if (ipl_scsi()) {
-        panic("\n! Cannot IPL this SCSI device !\n");
+        puts("Failed to IPL from this SCSI device!");
+        return;
     }
 
     switch (virtio_get_device_type()) {
@@ -1088,8 +1110,9 @@ void zipl_load(void)
         zipl_load_vscsi();
         break;
     default:
-        panic("\n! Unknown IPL device type !\n");
+        puts("Unknown IPL device type!");
+        return;
     }
 
-    puts("zIPL load failed.");
+    puts("zIPL load failed!");
 }
diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 7b09a38c96..5d543da73f 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -59,7 +59,8 @@ uint16_t cu_type(SubChannelId schid)
     };
 
     if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
-        panic("Failed to run SenseID CCw\n");
+        puts("Failed to run SenseID CCW");
+        return CU_TYPE_UNKNOWN;
     }
 
     return sense_data.cu_type;
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 0826c16787..68fae4447f 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -34,7 +34,7 @@ static void jump_to_IPL_addr(void)
     /* should not return */
 }
 
-void jump_to_IPL_code(uint64_t address)
+int jump_to_IPL_code(uint64_t address)
 {
     /* store the subsystem information _after_ the bootmap was loaded */
     write_subsystem_identification();
@@ -69,7 +69,8 @@ void jump_to_IPL_code(uint64_t address)
     asm volatile("lghi %%r1,1\n\t"
                  "diag %%r1,%%r1,0x308\n\t"
                  : : : "1", "memory");
-    panic("\n! IPL returns !\n");
+    puts("IPL code jump failed");
+    return 1;
 }
 
 void jump_to_low_kernel(void)
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index ed72f87962..6674a2a2b3 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -77,6 +77,9 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
 
     enable_subchannel(blk_schid);
     cutype = cu_type(blk_schid);
+    if (cutype == CU_TYPE_UNKNOWN) {
+        return -EIO;
+    }
 
     /*
      * Note: we always have to run virtio_is_supported() here to make
@@ -194,10 +197,10 @@ static void boot_setup(void)
     have_iplb = store_iplb(&iplb);
 }
 
-static void find_boot_device(void)
+static bool find_boot_device(void)
 {
     VDev *vdev = virtio_get_device();
-    bool found;
+    bool found = false;
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
@@ -215,10 +218,10 @@ static void find_boot_device(void)
         found = find_subch(iplb.scsi.devno);
         break;
     default:
-        panic("List-directed IPL not supported yet!\n");
+        puts("Unsupported IPLB");
     }
 
-    IPL_assert(found, "Boot device not found\n");
+    return found;
 }
 
 static int virtio_setup(void)
@@ -244,11 +247,13 @@ static int virtio_setup(void)
         ret = virtio_scsi_setup_device(blk_schid);
         break;
     default:
-        panic("\n! No IPL device available !\n");
+        puts("\n! No IPL device available !\n");
+        return 1;
     }
 
-    if (!ret) {
-        IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
+    if (!ret && !virtio_ipl_disk_is_valid()) {
+        puts("No valid IPL device detected");
+        return -ENODEV;
     }
 
     return ret;
@@ -259,16 +264,16 @@ static void ipl_boot_device(void)
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        dasd_ipl(blk_schid, cutype); /* no return */
+        dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
-        if (virtio_setup() == 0) {
-            zipl_load();             /* Only returns in case of errors */
+        if (virtio_setup()) {
+            return;    /* Only returns in case of errors */
         }
+        zipl_load();
         break;
     default:
         printf("Attempting to boot from unexpected device type 0x%X\n", cutype);
-        panic("\nBoot failed.\n");
     }
 }
 
@@ -301,12 +306,11 @@ void main(void)
     sclp_setup();
     css_setup();
     boot_setup();
-    if (have_iplb) {
-        find_boot_device();
+    if (have_iplb && find_boot_device()) {
         ipl_boot_device();
     } else {
         probe_boot_device();
     }
 
-    panic("Failed to load OS from hard disk\n");
+    panic("Failed to IPL. Halting...");
 }
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 1c585f034b..5ef273bdc0 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -59,8 +59,8 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
     case VIRTIO_ID_SCSI:
         return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
     }
-    panic("\n! No readable IPL device !\n");
-    return -1;
+
+    return 1;
 }
 
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 8c6b0a8a92..8b5a370bb3 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -217,16 +217,19 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     return 0;
 }
 
-void virtio_setup_ccw(VDev *vdev)
+int virtio_setup_ccw(VDev *vdev)
 {
-    int i, rc, cfg_size = 0;
+    int i, cfg_size = 0;
     uint8_t status;
     struct VirtioFeatureDesc {
         uint32_t features;
         uint8_t index;
     } __attribute__((packed)) feats;
 
-    IPL_assert(virtio_is_supported(vdev->schid), "PE");
+    if (!virtio_is_supported(vdev->schid)) {
+        puts("Virtio unsupported for this device ID");
+        return -ENODEV;
+    }
     /* device ID has been established now */
 
     vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
@@ -235,8 +238,10 @@ void virtio_setup_ccw(VDev *vdev)
     run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
 
     status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
-    rc = run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false);
-    IPL_assert(rc == 0, "Could not write ACKNOWLEDGE status to host");
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write ACKNOWLEDGE status to host");
+        return -EIO;
+    }
 
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
@@ -255,27 +260,37 @@ void virtio_setup_ccw(VDev *vdev)
         cfg_size = sizeof(vdev->config.scsi);
         break;
     default:
-        panic("Unsupported virtio device\n");
+        puts("Unsupported virtio device");
+        return -ENODEV;
     }
 
     status |= VIRTIO_CONFIG_S_DRIVER;
-    rc = run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false);
-    IPL_assert(rc == 0, "Could not write DRIVER status to host");
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write DRIVER status to host");
+        return -EIO;
+    }
 
     /* Feature negotiation */
     for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
         feats.features = 0;
         feats.index = i;
-        rc = run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false);
-        IPL_assert(rc == 0, "Could not get features bits");
+        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false)) {
+            puts("Could not get features bits");
+            return -EIO;
+        }
+
         vdev->guest_features[i] &= bswap32(feats.features);
         feats.features = bswap32(vdev->guest_features[i]);
-        rc = run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false);
-        IPL_assert(rc == 0, "Could not set features bits");
+        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false)) {
+            puts("Could not set features bits");
+            return -EIO;
+        }
     }
 
-    rc = run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false);
-    IPL_assert(rc == 0, "Could not get virtio device configuration");
+    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)) {
+        puts("Could not get virtio device configuration");
+        return -EIO;
+    }
 
     for (i = 0; i < vdev->nr_vqs; i++) {
         VqInfo info = {
@@ -289,19 +304,27 @@ void virtio_setup_ccw(VDev *vdev)
             .num = 0,
         };
 
-        rc = run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config), false);
-        IPL_assert(rc == 0, "Could not get virtio device VQ configuration");
+        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
+                false)) {
+            puts("Could not get virtio device VQ config");
+            return -EIO;
+        }
         info.num = config.num;
         vring_init(&vdev->vrings[i], &info);
         vdev->vrings[i].schid = vdev->schid;
-        IPL_assert(
-            run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false) == 0,
-            "Cannot set VQ info");
+        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
+            puts("Cannot set VQ info");
+            return -EIO;
+        }
     }
 
     status |= VIRTIO_CONFIG_S_DRIVER_OK;
-    rc = run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false);
-    IPL_assert(rc == 0, "Could not write DRIVER_OK status to host");
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write DRIVER_OK status to host");
+        return -EIO;
+    }
+
+    return 0;
 }
 
 bool virtio_is_supported(SubChannelId schid)
-- 
2.45.1


