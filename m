Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C979CBF2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 11:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfznF-0008US-O7; Tue, 12 Sep 2023 05:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfznC-0008Sk-5R
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfzn8-0002gJ-F4
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694511281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jYofZaNOC5oXNFd0vQwjdhIjfy9tdfI9tyxF9bi0Rjw=;
 b=HVEq594Si1Iu4CNRTheoTnn7OUur+E002DbgPLdXIDUJm0SjFkYrFrKFm3XLpWoVZoBtlf
 GfkILfUMsLH1hXjL+U4Q+mgnYdt/oSRsbjRNTbuMbPLfeTHDoGtm52Qino9WqY6bRqpyqc
 BMI/tLrbXAtjylwh1z3UHpg3Tfnk2ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-aHkb_n0rNzyUW1ulJzjEmA-1; Tue, 12 Sep 2023 05:34:36 -0400
X-MC-Unique: aHkb_n0rNzyUW1ulJzjEmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94E8A934748;
 Tue, 12 Sep 2023 09:34:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D069710F1BE7;
 Tue, 12 Sep 2023 09:34:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH] linux-headers: Update to Linux v6.6-rc1
Date: Tue, 12 Sep 2023 11:34:32 +0200
Message-ID: <20230912093432.180041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This update contains the required header changes for the
"target/s390x: AP-passthrough for PV guests" patch from
Steffen Eiden.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 See https://lore.kernel.org/qemu-devel/20230823142219.1046522-1-seiden@linux.ibm.com/
 I'll add this patch to my next pull request (unless someone
 complains)

 include/standard-headers/linux/fuse.h        |  63 +++++++-
 include/standard-headers/linux/vhost_types.h |   4 +
 include/standard-headers/linux/virtio_net.h  |  14 ++
 linux-headers/asm-arm64/bitsperlong.h        |  23 +++
 linux-headers/asm-generic/unistd.h           |   5 +-
 linux-headers/asm-mips/unistd_n32.h          |   1 +
 linux-headers/asm-mips/unistd_n64.h          |   1 +
 linux-headers/asm-mips/unistd_o32.h          |   1 +
 linux-headers/asm-powerpc/unistd_32.h        |   1 +
 linux-headers/asm-powerpc/unistd_64.h        |   1 +
 linux-headers/asm-riscv/bitsperlong.h        |  13 ++
 linux-headers/asm-riscv/kvm.h                |  16 ++
 linux-headers/asm-s390/kvm.h                 |  16 ++
 linux-headers/asm-s390/unistd_32.h           |   1 +
 linux-headers/asm-s390/unistd_64.h           |   1 +
 linux-headers/asm-x86/mman.h                 |  10 +-
 linux-headers/asm-x86/unistd_32.h            |   1 +
 linux-headers/asm-x86/unistd_64.h            |   2 +
 linux-headers/asm-x86/unistd_x32.h           |   1 +
 linux-headers/linux/kvm.h                    |  13 +-
 linux-headers/linux/stddef.h                 |   4 +
 linux-headers/linux/userfaultfd.h            |  25 +++-
 linux-headers/linux/vfio.h                   | 150 ++++++++++++++++++-
 23 files changed, 351 insertions(+), 16 deletions(-)

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 35c131a107..6b9793842c 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -206,6 +206,11 @@
  *  - add extension header
  *  - add FUSE_EXT_GROUPS
  *  - add FUSE_CREATE_SUPP_GROUP
+ *  - add FUSE_HAS_EXPIRE_ONLY
+ *
+ *  7.39
+ *  - add FUSE_DIRECT_IO_RELAX
+ *  - add FUSE_STATX and related structures
  */
 
 #ifndef _LINUX_FUSE_H
@@ -237,7 +242,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 38
+#define FUSE_KERNEL_MINOR_VERSION 39
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -264,6 +269,40 @@ struct fuse_attr {
 	uint32_t	flags;
 };
 
+/*
+ * The following structures are bit-for-bit compatible with the statx(2) ABI in
+ * Linux.
+ */
+struct fuse_sx_time {
+	int64_t		tv_sec;
+	uint32_t	tv_nsec;
+	int32_t		__reserved;
+};
+
+struct fuse_statx {
+	uint32_t	mask;
+	uint32_t	blksize;
+	uint64_t	attributes;
+	uint32_t	nlink;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint16_t	mode;
+	uint16_t	__spare0[1];
+	uint64_t	ino;
+	uint64_t	size;
+	uint64_t	blocks;
+	uint64_t	attributes_mask;
+	struct fuse_sx_time	atime;
+	struct fuse_sx_time	btime;
+	struct fuse_sx_time	ctime;
+	struct fuse_sx_time	mtime;
+	uint32_t	rdev_major;
+	uint32_t	rdev_minor;
+	uint32_t	dev_major;
+	uint32_t	dev_minor;
+	uint64_t	__spare2[14];
+};
+
 struct fuse_kstatfs {
 	uint64_t	blocks;
 	uint64_t	bfree;
@@ -365,6 +404,9 @@ struct fuse_file_lock {
  * FUSE_HAS_INODE_DAX:  use per inode DAX
  * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
  *			symlink and mknod (single group that matches parent)
+ * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
+ * FUSE_DIRECT_IO_RELAX: relax restrictions in FOPEN_DIRECT_IO mode, for now
+ *                       allow shared mmap
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -402,6 +444,8 @@ struct fuse_file_lock {
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
+#define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
+#define FUSE_DIRECT_IO_RELAX	(1ULL << 36)
 
 /**
  * CUSE INIT request/reply flags
@@ -568,6 +612,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
+	FUSE_STATX		= 52,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -632,6 +677,22 @@ struct fuse_attr_out {
 	struct fuse_attr attr;
 };
 
+struct fuse_statx_in {
+	uint32_t	getattr_flags;
+	uint32_t	reserved;
+	uint64_t	fh;
+	uint32_t	sx_flags;
+	uint32_t	sx_mask;
+};
+
+struct fuse_statx_out {
+	uint64_t	attr_valid;	/* Cache timeout for the attributes */
+	uint32_t	attr_valid_nsec;
+	uint32_t	flags;
+	uint64_t	spare[2];
+	struct fuse_statx stat;
+};
+
 #define FUSE_COMPAT_MKNOD_IN_SIZE 8
 
 struct fuse_mknod_in {
diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
index 6691a3ce24..5ad07e134a 100644
--- a/include/standard-headers/linux/vhost_types.h
+++ b/include/standard-headers/linux/vhost_types.h
@@ -181,5 +181,9 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_SUSPEND  0x4
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
+/* Device supports the driver enabling virtqueues both before and after
+ * DRIVER_OK
+ */
+#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
 
 #endif
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 2325485f2c..0f88417742 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
 #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
 #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
@@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
 };
 
 #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
+#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET		2
+#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET		3
+
+struct virtio_net_ctrl_coal {
+	uint32_t max_packets;
+	uint32_t max_usecs;
+};
+
+struct  virtio_net_ctrl_coal_vq {
+	uint16_t vqn;
+	uint16_t reserved;
+	struct virtio_net_ctrl_coal coal;
+};
 
 #endif /* _LINUX_VIRTIO_NET_H */
diff --git a/linux-headers/asm-arm64/bitsperlong.h b/linux-headers/asm-arm64/bitsperlong.h
index 6dc0bb0c13..485d60bee2 100644
--- a/linux-headers/asm-arm64/bitsperlong.h
+++ b/linux-headers/asm-arm64/bitsperlong.h
@@ -1 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_BITSPERLONG_H
+#define __ASM_BITSPERLONG_H
+
+#define __BITS_PER_LONG 64
+
 #include <asm-generic/bitsperlong.h>
+
+#endif	/* __ASM_BITSPERLONG_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index fd6c1cb585..abe087c53b 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -820,8 +820,11 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
 
+#define __NR_fchmodat2 452
+__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index 8233f061c4..46d8500654 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -380,5 +380,6 @@
 #define __NR_futex_waitv (__NR_Linux + 449)
 #define __NR_set_mempolicy_home_node (__NR_Linux + 450)
 #define __NR_cachestat (__NR_Linux + 451)
+#define __NR_fchmodat2 (__NR_Linux + 452)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index a174edc768..c2f7ac673b 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -356,5 +356,6 @@
 #define __NR_futex_waitv (__NR_Linux + 449)
 #define __NR_set_mempolicy_home_node (__NR_Linux + 450)
 #define __NR_cachestat (__NR_Linux + 451)
+#define __NR_fchmodat2 (__NR_Linux + 452)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index c1a5351d9b..757c68f2ad 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -426,5 +426,6 @@
 #define __NR_futex_waitv (__NR_Linux + 449)
 #define __NR_set_mempolicy_home_node (__NR_Linux + 450)
 #define __NR_cachestat (__NR_Linux + 451)
+#define __NR_fchmodat2 (__NR_Linux + 452)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 8206758691..8ef94bbac1 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -433,6 +433,7 @@
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
 #define __NR_cachestat 451
+#define __NR_fchmodat2 452
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 7be98c15f0..0e7ee43e88 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -405,6 +405,7 @@
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
 #define __NR_cachestat 451
+#define __NR_fchmodat2 452
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/bitsperlong.h b/linux-headers/asm-riscv/bitsperlong.h
index 6dc0bb0c13..cc5c45a9ce 100644
--- a/linux-headers/asm-riscv/bitsperlong.h
+++ b/linux-headers/asm-riscv/bitsperlong.h
@@ -1 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ */
+
+#ifndef _ASM_RISCV_BITSPERLONG_H
+#define _ASM_RISCV_BITSPERLONG_H
+
+#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
+
 #include <asm-generic/bitsperlong.h>
+
+#endif /* _ASM_RISCV_BITSPERLONG_H */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index 930fdc4101..992c5e4071 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -55,6 +55,7 @@ struct kvm_riscv_config {
 	unsigned long marchid;
 	unsigned long mimpid;
 	unsigned long zicboz_block_size;
+	unsigned long satp_mode;
 };
 
 /* CORE registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
@@ -124,6 +125,12 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_SSAIA,
 	KVM_RISCV_ISA_EXT_V,
 	KVM_RISCV_ISA_EXT_SVNAPOT,
+	KVM_RISCV_ISA_EXT_ZBA,
+	KVM_RISCV_ISA_EXT_ZBS,
+	KVM_RISCV_ISA_EXT_ZICNTR,
+	KVM_RISCV_ISA_EXT_ZICSR,
+	KVM_RISCV_ISA_EXT_ZIFENCEI,
+	KVM_RISCV_ISA_EXT_ZIHPM,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
@@ -193,6 +200,15 @@ enum KVM_RISCV_SBI_EXT_ID {
 
 /* ISA Extension registers are mapped as type 7 */
 #define KVM_REG_RISCV_ISA_EXT		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
+#define KVM_REG_RISCV_ISA_SINGLE	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_ISA_MULTI_EN	(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_ISA_MULTI_DIS	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_ISA_MULTI_REG(__ext_id)	\
+		((__ext_id) / __BITS_PER_LONG)
+#define KVM_REG_RISCV_ISA_MULTI_MASK(__ext_id)	\
+		(1UL << ((__ext_id) % __BITS_PER_LONG))
+#define KVM_REG_RISCV_ISA_MULTI_REG_LAST	\
+		KVM_REG_RISCV_ISA_MULTI_REG(KVM_RISCV_ISA_EXT_MAX - 1)
 
 /* SBI extension registers are mapped as type 8 */
 #define KVM_REG_RISCV_SBI_EXT		(0x08 << KVM_REG_RISCV_TYPE_SHIFT)
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index e2afd95420..023a2763a9 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -159,6 +159,22 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 reserved[1728];
 };
 
+#define KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST	6
+#define KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST	7
+
+#define KVM_S390_VM_CPU_UV_FEAT_NR_BITS	64
+struct kvm_s390_vm_cpu_uv_feat {
+	union {
+		struct {
+			__u64 : 4;
+			__u64 ap : 1;		/* bit 4 */
+			__u64 ap_intr : 1;	/* bit 5 */
+			__u64 : 58;
+		};
+		__u64 feat;
+	};
+};
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index ef772cc5f8..716fa368ca 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -424,5 +424,6 @@
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
 #define __NR_cachestat 451
+#define __NR_fchmodat2 452
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 32354a0459..b2a11b1d13 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -372,5 +372,6 @@
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
 #define __NR_cachestat 451
+#define __NR_fchmodat2 452
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/mman.h b/linux-headers/asm-x86/mman.h
index 775dbd3aff..46cdc941f9 100644
--- a/linux-headers/asm-x86/mman.h
+++ b/linux-headers/asm-x86/mman.h
@@ -3,14 +3,10 @@
 #define _ASM_X86_MMAN_H
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
+#define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-#define arch_calc_vm_prot_bits(prot, key) (		\
-		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
-		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
-		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
-		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
-#endif
+/* Flags for map_shadow_stack(2) */
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
 
 #include <asm-generic/mman.h>
 
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index 37b32d8139..d749ad1c24 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -442,6 +442,7 @@
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
 #define __NR_cachestat 451
+#define __NR_fchmodat2 452
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 5b55d6729a..cea67282eb 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -364,6 +364,8 @@
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
 #define __NR_cachestat 451
+#define __NR_fchmodat2 452
+#define __NR_map_shadow_stack 453
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index e8a007543d..5b2e79bf4c 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -317,6 +317,7 @@
 #define __NR_futex_waitv (__X32_SYSCALL_BIT + 449)
 #define __NR_set_mempolicy_home_node (__X32_SYSCALL_BIT + 450)
 #define __NR_cachestat (__X32_SYSCALL_BIT + 451)
+#define __NR_fchmodat2 (__X32_SYSCALL_BIT + 452)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 1f3f3333a4..0d74ee999a 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1414,9 +1414,16 @@ struct kvm_device_attr {
 	__u64	addr;		/* userspace address of attr data */
 };
 
-#define  KVM_DEV_VFIO_GROUP			1
-#define   KVM_DEV_VFIO_GROUP_ADD			1
-#define   KVM_DEV_VFIO_GROUP_DEL			2
+#define  KVM_DEV_VFIO_FILE			1
+
+#define   KVM_DEV_VFIO_FILE_ADD			1
+#define   KVM_DEV_VFIO_FILE_DEL			2
+
+/* KVM_DEV_VFIO_GROUP aliases are for compile time uapi compatibility */
+#define  KVM_DEV_VFIO_GROUP	KVM_DEV_VFIO_FILE
+
+#define   KVM_DEV_VFIO_GROUP_ADD	KVM_DEV_VFIO_FILE_ADD
+#define   KVM_DEV_VFIO_GROUP_DEL	KVM_DEV_VFIO_FILE_DEL
 #define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
 
 enum kvm_device_type {
diff --git a/linux-headers/linux/stddef.h b/linux-headers/linux/stddef.h
index bb6ea517ef..9bb07083ac 100644
--- a/linux-headers/linux/stddef.h
+++ b/linux-headers/linux/stddef.h
@@ -45,3 +45,7 @@
 		TYPE NAME[]; \
 	}
 #endif
+
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 14e402263a..59978fbaae 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -39,7 +39,8 @@
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
-			   UFFD_FEATURE_WP_UNPOPULATED)
+			   UFFD_FEATURE_WP_UNPOPULATED |	\
+			   UFFD_FEATURE_POISON)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -49,12 +50,14 @@
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
-	 (__u64)1 << _UFFDIO_CONTINUE)
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_POISON)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_WRITEPROTECT)
+	 (__u64)1 << _UFFDIO_POISON)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -71,6 +74,7 @@
 #define _UFFDIO_ZEROPAGE		(0x04)
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
+#define _UFFDIO_POISON			(0x08)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -91,6 +95,8 @@
 				      struct uffdio_writeprotect)
 #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
 				      struct uffdio_continue)
+#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
+				      struct uffdio_poison)
 
 /* read() structure */
 struct uffd_msg {
@@ -225,6 +231,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_POISON			(1<<14)
 	__u64 features;
 
 	__u64 ioctls;
@@ -321,6 +328,18 @@ struct uffdio_continue {
 	__s64 mapped;
 };
 
+struct uffdio_poison {
+	struct uffdio_range range;
+#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * Fields below here are written by the ioctl and must be at the end:
+	 * the copy_from_user will not read past here.
+	 */
+	__s64 updated;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 16db89071e..acf72b4999 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -217,6 +217,7 @@ struct vfio_device_info {
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
+	__u32   pad;
 };
 #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
 
@@ -677,11 +678,60 @@ enum {
  * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
  *
+ * This command is used to query the affected devices in the hot reset for
+ * a given device.
+ *
+ * This command always reports the segment, bus, and devfn information for
+ * each affected device, and selectively reports the group_id or devid per
+ * the way how the calling device is opened.
+ *
+ *	- If the calling device is opened via the traditional group/container
+ *	  API, group_id is reported.  User should check if it has owned all
+ *	  the affected devices and provides a set of group fds to prove the
+ *	  ownership in VFIO_DEVICE_PCI_HOT_RESET ioctl.
+ *
+ *	- If the calling device is opened as a cdev, devid is reported.
+ *	  Flag VFIO_PCI_HOT_RESET_FLAG_DEV_ID is set to indicate this
+ *	  data type.  All the affected devices should be represented in
+ *	  the dev_set, ex. bound to a vfio driver, and also be owned by
+ *	  this interface which is determined by the following conditions:
+ *	  1) Has a valid devid within the iommufd_ctx of the calling device.
+ *	     Ownership cannot be determined across separate iommufd_ctx and
+ *	     the cdev calling conventions do not support a proof-of-ownership
+ *	     model as provided in the legacy group interface.  In this case
+ *	     valid devid with value greater than zero is provided in the return
+ *	     structure.
+ *	  2) Does not have a valid devid within the iommufd_ctx of the calling
+ *	     device, but belongs to the same IOMMU group as the calling device
+ *	     or another opened device that has a valid devid within the
+ *	     iommufd_ctx of the calling device.  This provides implicit ownership
+ *	     for devices within the same DMA isolation context.  In this case
+ *	     the devid value of VFIO_PCI_DEVID_OWNED is provided in the return
+ *	     structure.
+ *
+ *	  A devid value of VFIO_PCI_DEVID_NOT_OWNED is provided in the return
+ *	  structure for affected devices where device is NOT represented in the
+ *	  dev_set or ownership is not available.  Such devices prevent the use
+ *	  of VFIO_DEVICE_PCI_HOT_RESET ioctl outside of the proof-of-ownership
+ *	  calling conventions (ie. via legacy group accessed devices).  Flag
+ *	  VFIO_PCI_HOT_RESET_FLAG_DEV_ID_OWNED would be set when all the
+ *	  affected devices are represented in the dev_set and also owned by
+ *	  the user.  This flag is available only when
+ *	  flag VFIO_PCI_HOT_RESET_FLAG_DEV_ID is set, otherwise reserved.
+ *	  When set, user could invoke VFIO_DEVICE_PCI_HOT_RESET with a zero
+ *	  length fd array on the calling device as the ownership is validated
+ *	  by iommufd_ctx.
+ *
  * Return: 0 on success, -errno on failure:
  *	-enospc = insufficient buffer, -enodev = unsupported for device.
  */
 struct vfio_pci_dependent_device {
-	__u32	group_id;
+	union {
+		__u32   group_id;
+		__u32	devid;
+#define VFIO_PCI_DEVID_OWNED		0
+#define VFIO_PCI_DEVID_NOT_OWNED	-1
+	};
 	__u16	segment;
 	__u8	bus;
 	__u8	devfn; /* Use PCI_SLOT/PCI_FUNC */
@@ -690,6 +740,8 @@ struct vfio_pci_dependent_device {
 struct vfio_pci_hot_reset_info {
 	__u32	argsz;
 	__u32	flags;
+#define VFIO_PCI_HOT_RESET_FLAG_DEV_ID		(1 << 0)
+#define VFIO_PCI_HOT_RESET_FLAG_DEV_ID_OWNED	(1 << 1)
 	__u32	count;
 	struct vfio_pci_dependent_device	devices[];
 };
@@ -700,6 +752,24 @@ struct vfio_pci_hot_reset_info {
  * VFIO_DEVICE_PCI_HOT_RESET - _IOW(VFIO_TYPE, VFIO_BASE + 13,
  *				    struct vfio_pci_hot_reset)
  *
+ * A PCI hot reset results in either a bus or slot reset which may affect
+ * other devices sharing the bus/slot.  The calling user must have
+ * ownership of the full set of affected devices as determined by the
+ * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO ioctl.
+ *
+ * When called on a device file descriptor acquired through the vfio
+ * group interface, the user is required to provide proof of ownership
+ * of those affected devices via the group_fds array in struct
+ * vfio_pci_hot_reset.
+ *
+ * When called on a direct cdev opened vfio device, the flags field of
+ * struct vfio_pci_hot_reset_info reports the ownership status of the
+ * affected devices and this ioctl must be called with an empty group_fds
+ * array.  See above INFO ioctl definition for ownership requirements.
+ *
+ * Mixed usage of legacy groups and cdevs across the set of affected
+ * devices is not supported.
+ *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_pci_hot_reset {
@@ -828,6 +898,83 @@ struct vfio_device_feature {
 
 #define VFIO_DEVICE_FEATURE		_IO(VFIO_TYPE, VFIO_BASE + 17)
 
+/*
+ * VFIO_DEVICE_BIND_IOMMUFD - _IOR(VFIO_TYPE, VFIO_BASE + 18,
+ *				   struct vfio_device_bind_iommufd)
+ * @argsz:	 User filled size of this data.
+ * @flags:	 Must be 0.
+ * @iommufd:	 iommufd to bind.
+ * @out_devid:	 The device id generated by this bind. devid is a handle for
+ *		 this device/iommufd bond and can be used in IOMMUFD commands.
+ *
+ * Bind a vfio_device to the specified iommufd.
+ *
+ * User is restricted from accessing the device before the binding operation
+ * is completed.  Only allowed on cdev fds.
+ *
+ * Unbind is automatically conducted when device fd is closed.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_bind_iommufd {
+	__u32		argsz;
+	__u32		flags;
+	__s32		iommufd;
+	__u32		out_devid;
+};
+
+#define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 18)
+
+/*
+ * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 19,
+ *					struct vfio_device_attach_iommufd_pt)
+ * @argsz:	User filled size of this data.
+ * @flags:	Must be 0.
+ * @pt_id:	Input the target id which can represent an ioas or a hwpt
+ *		allocated via iommufd subsystem.
+ *		Output the input ioas id or the attached hwpt id which could
+ *		be the specified hwpt itself or a hwpt automatically created
+ *		for the specified ioas by kernel during the attachment.
+ *
+ * Associate the device with an address space within the bound iommufd.
+ * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
+ * allowed on cdev fds.
+ *
+ * If a vfio device is currently attached to a valid hw_pagetable, without doing
+ * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
+ * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
+ * as a hw_pagetable replacement, will replace the device's currently attached
+ * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_attach_iommufd_pt {
+	__u32	argsz;
+	__u32	flags;
+	__u32	pt_id;
+};
+
+#define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 19)
+
+/*
+ * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
+ *					struct vfio_device_detach_iommufd_pt)
+ * @argsz:	User filled size of this data.
+ * @flags:	Must be 0.
+ *
+ * Remove the association of the device and its current associated address
+ * space.  After it, the device should be in a blocking DMA state.  This is only
+ * allowed on cdev fds.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_detach_iommufd_pt {
+	__u32	argsz;
+	__u32	flags;
+};
+
+#define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)
+
 /*
  * Provide support for setting a PCI VF Token, which is used as a shared
  * secret between PF and VF drivers.  This feature may only be set on a
@@ -1304,6 +1451,7 @@ struct vfio_iommu_type1_info {
 #define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
 	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
+	__u32   pad;
 };
 
 /*
-- 
2.41.0


