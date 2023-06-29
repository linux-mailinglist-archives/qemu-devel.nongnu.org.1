Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F15742438
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpCZ-000262-AG; Thu, 29 Jun 2023 06:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpCR-0001z8-UA
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpCP-00043o-DK
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688035708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPK+9VBRaR3tQSO4dsTV4cxtAEbws9+N/PJZwhmlU7E=;
 b=LaIi3NnNPJFeU54Z1BahRiJmOdD++tu5jWP9gvmKOBib7zPgKf/Gey9mQaoU5eRr/dNy4U
 y/pKQKvptnqhcpuWkEInPZhYOC0vuIZRV9KGu/BKvz52kIIgIzTx6m1KlDEbW51SgR5Vmw
 6pbwBAYLSyXObRaZqVSnH+vKPFPSxTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-F5xI40VVPQyXvOHlO_JhUQ-1; Thu, 29 Jun 2023 06:48:25 -0400
X-MC-Unique: F5xI40VVPQyXvOHlO_JhUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 913DF8E46AC;
 Thu, 29 Jun 2023 10:48:24 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2D3C4067A00;
 Thu, 29 Jun 2023 10:48:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 1/7] s390-ccw: Getting rid of ulong
Date: Thu, 29 Jun 2023 12:48:15 +0200
Message-Id: <20230629104821.194859-2-thuth@redhat.com>
In-Reply-To: <20230629104821.194859-1-thuth@redhat.com>
References: <20230629104821.194859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Juan Quintela <quintela@redhat.com>

Any good reason why this still exist?
I can understand u* and __u* to be linux kernel like, but ulong?

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230510143925.4094-4-quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/helper.h        |  2 +-
 pc-bios/s390-ccw/s390-ccw.h      |  7 +++----
 pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
 pc-bios/s390-ccw/virtio.h        |  4 ++--
 pc-bios/s390-ccw/virtio-blkdev.c | 12 ++++++------
 pc-bios/s390-ccw/virtio-scsi.c   |  4 ++--
 pc-bios/s390-ccw/virtio.c        | 12 ++++++------
 7 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
index 3d0731c4c6..8e3dfcb6d6 100644
--- a/pc-bios/s390-ccw/helper.h
+++ b/pc-bios/s390-ccw/helper.h
@@ -38,7 +38,7 @@ static inline void yield(void)
 
 static inline void sleep(unsigned int seconds)
 {
-    ulong target = get_time_seconds() + seconds;
+    unsigned long target = get_time_seconds() + seconds;
 
     while (get_time_seconds() < target) {
         yield();
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b88e0550ab..f849fba74b 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -17,7 +17,6 @@ typedef unsigned char      u8;
 typedef unsigned short     u16;
 typedef unsigned int       u32;
 typedef unsigned long long u64;
-typedef unsigned long      ulong;
 typedef unsigned char      __u8;
 typedef unsigned short     __u16;
 typedef unsigned int       __u32;
@@ -67,11 +66,11 @@ void sclp_get_loadparm_ascii(char *loadparm);
 int sclp_read(char *str, size_t count);
 
 /* virtio.c */
-unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
-                                 ulong subchan_id, void *load_addr);
+unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
+                                 unsigned long subchan_id, void *load_addr);
 bool virtio_is_supported(SubChannelId schid);
 int virtio_blk_setup_device(SubChannelId schid);
-int virtio_read(ulong sector, void *load_addr);
+int virtio_read(unsigned long sector, void *load_addr);
 
 /* bootmap.c */
 void zipl_load(void);
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scsi.h
index e6b6cd4815..c5612e16a2 100644
--- a/pc-bios/s390-ccw/virtio-scsi.h
+++ b/pc-bios/s390-ccw/virtio-scsi.h
@@ -68,7 +68,7 @@ static inline bool virtio_scsi_response_ok(const VirtioScsiCmdResp *r)
 }
 
 int virtio_scsi_read_many(VDev *vdev,
-                          ulong sector, void *load_addr, int sec_num);
+                          unsigned long sector, void *load_addr, int sec_num);
 int virtio_scsi_setup_device(SubChannelId schid);
 
 #endif /* VIRTIO_SCSI_H */
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index e657d381ec..85bd9d1695 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -190,14 +190,14 @@ int virtio_get_block_size(void);
 uint8_t virtio_get_heads(void);
 uint8_t virtio_get_sectors(void);
 uint64_t virtio_get_blocks(void);
-int virtio_read_many(ulong sector, void *load_addr, int sec_num);
+int virtio_read_many(unsigned long sector, void *load_addr, int sec_num);
 
 #define VIRTIO_SECTOR_SIZE 512
 #define VIRTIO_ISO_BLOCK_SIZE 2048
 #define VIRTIO_SCSI_BLOCK_SIZE 512
 #define VIRTIO_DASD_DEFAULT_BLOCK_SIZE 4096
 
-static inline ulong virtio_sector_adjust(ulong sector)
+static inline unsigned long virtio_sector_adjust(unsigned long sector)
 {
     return sector * (virtio_get_block_size() / VIRTIO_SECTOR_SIZE);
 }
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 794f99b42c..a81207b52e 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -16,7 +16,7 @@
 #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
 #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
 
-static int virtio_blk_read_many(VDev *vdev, ulong sector, void *load_addr,
+static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_addr,
                                 int sec_num)
 {
     VirtioBlkOuthdr out_hdr;
@@ -49,7 +49,7 @@ static int virtio_blk_read_many(VDev *vdev, ulong sector, void *load_addr,
     return status;
 }
 
-int virtio_read_many(ulong sector, void *load_addr, int sec_num)
+int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
 {
     VDev *vdev = virtio_get_device();
 
@@ -63,14 +63,14 @@ int virtio_read_many(ulong sector, void *load_addr, int sec_num)
     return -1;
 }
 
-unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
-                                 ulong subchan_id, void *load_addr)
+unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
+                                 unsigned long subchan_id, void *load_addr)
 {
     u8 status;
     int sec = rec_list1;
     int sec_num = ((rec_list2 >> 32) & 0xffff) + 1;
     int sec_len = rec_list2 >> 48;
-    ulong addr = (ulong)load_addr;
+    unsigned long addr = (unsigned long)load_addr;
 
     if (sec_len != virtio_get_block_size()) {
         return -1;
@@ -86,7 +86,7 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
     return addr;
 }
 
-int virtio_read(ulong sector, void *load_addr)
+int virtio_read(unsigned long sector, void *load_addr)
 {
     return virtio_read_many(sector, load_addr, 1);
 }
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index dcce696a33..d1a84b937c 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -150,7 +150,7 @@ static bool scsi_report_luns(VDev *vdev, void *data, uint32_t data_size)
 }
 
 static bool scsi_read_10(VDev *vdev,
-                         ulong sector, int sectors, void *data,
+                         unsigned long sector, int sectors, void *data,
                          unsigned int data_size)
 {
     ScsiCdbRead10 cdb = {
@@ -269,7 +269,7 @@ static int virtio_scsi_locate_device(VDev *vdev)
 }
 
 int virtio_scsi_read_many(VDev *vdev,
-                          ulong sector, void *load_addr, int sec_num)
+                          unsigned long sector, void *load_addr, int sec_num)
 {
     int sector_count;
     int f = vdev->blk_factor;
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index f37510f312..5edd058d88 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -48,10 +48,10 @@ VirtioDevType virtio_get_device_type(void)
 static long kvm_hypercall(unsigned long nr, unsigned long param1,
                           unsigned long param2, unsigned long param3)
 {
-    register ulong r_nr asm("1") = nr;
-    register ulong r_param1 asm("2") = param1;
-    register ulong r_param2 asm("3") = param2;
-    register ulong r_param3 asm("4") = param3;
+    register unsigned long r_nr asm("1") = nr;
+    register unsigned long r_param1 asm("2") = param1;
+    register unsigned long r_param2 asm("3") = param2;
+    register unsigned long r_param3 asm("4") = param3;
     register long retval asm("2");
 
     asm volatile ("diag %%r2,%%r4,0x500"
@@ -145,7 +145,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
         vr->avail->ring[vr->avail->idx % vr->num] = vr->next_idx;
     }
 
-    vr->desc[vr->next_idx].addr = (ulong)p;
+    vr->desc[vr->next_idx].addr = (unsigned long)p;
     vr->desc[vr->next_idx].len = len;
     vr->desc[vr->next_idx].flags = flags & ~VRING_HIDDEN_IS_CHAIN;
     vr->desc[vr->next_idx].next = vr->next_idx;
@@ -182,7 +182,7 @@ int vr_poll(VRing *vr)
  */
 int vring_wait_reply(void)
 {
-    ulong target_second = get_time_seconds() + vdev.wait_reply_timeout;
+    unsigned long target_second = get_time_seconds() + vdev.wait_reply_timeout;
 
     /* Wait for any queue to be updated by the host */
     do {
-- 
2.39.3


