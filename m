Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528BAB14CA
	for <lists+qemu-devel@lfdr.de>; Fri,  9 May 2025 15:21:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNa2-0003NW-0C; Fri, 09 May 2025 09:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYR-0001ov-Tl
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYN-00076e-JL
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+VV9mdhzUFXz8/oku0cMhAXqawWy2YfiJIwHZhSDo0=;
 b=N1NH91+yLKaOvO5DgGSOw79F0cORNobwm1YU0HGtYybj85J2YnbhvuGen7kZXdDUB/psOD
 fWaB8Rw8dhoYAX+porHg5viXWZ/15dRCK/j8+rhpQIbuxtESqDuj16TCwYzlJyT5N2N8sE
 pltr3hSPnn3qZN8cNsoGqyKvkaHm+nw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-movlG60bM8WwCy2ADRiUfg-1; Fri,
 09 May 2025 09:14:11 -0400
X-MC-Unique: movlG60bM8WwCy2ADRiUfg-1
X-Mimecast-MFC-AGG-ID: movlG60bM8WwCy2ADRiUfg_1746796450
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B916C1800258; Fri,  9 May 2025 13:14:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AAAD180045B; Fri,  9 May 2025 13:14:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Rorie Reyes <rreyes@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/28] linux-headers: Update to Linux v6.15-rc3
Date: Fri,  9 May 2025 15:13:03 +0200
Message-ID: <20250509131317.164235-15-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Rorie Reyes <rreyes@linux.ibm.com>

Update headers to retrieve uapi information for vfio-ap

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250425052401.8287-3-rreyes@linux.ibm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/standard-headers/asm-x86/setup_data.h |   4 +-
 include/standard-headers/drm/drm_fourcc.h     |  41 ++++++
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/ethtool.h      |  22 +++
 include/standard-headers/linux/fuse.h         |  12 +-
 include/standard-headers/linux/pci_regs.h     |  13 +-
 include/standard-headers/linux/virtio_net.h   |  13 ++
 include/standard-headers/linux/virtio_snd.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |  11 ++
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/mman-common.h       |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   2 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   8 +-
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/iommufd.h                 | 129 +++++++++++++++++-
 linux-headers/linux/kvm.h                     |   1 +
 linux-headers/linux/psp-sev.h                 |  21 ++-
 linux-headers/linux/stddef.h                  |   2 +
 linux-headers/linux/vfio.h                    |  30 ++--
 34 files changed, 301 insertions(+), 36 deletions(-)

diff --git a/include/standard-headers/asm-x86/setup_data.h b/include/standard-headers/asm-x86/setup_data.h
index 09355f54c55ff41a27d8669aa7768d0198a7c035..a483d72f42863b6b841eb21ffa916c3b6b97bf5b 100644
--- a/include/standard-headers/asm-x86/setup_data.h
+++ b/include/standard-headers/asm-x86/setup_data.h
@@ -18,7 +18,7 @@
 #define SETUP_INDIRECT			(1<<31)
 #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include "standard-headers/linux/types.h"
 
@@ -78,6 +78,6 @@ struct ima_setup_data {
 	uint64_t size;
 } QEMU_PACKED;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SETUP_DATA_H */
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 708647776f9a1d48ef4a81597b1eb96315c6cfe8..a8b759dcbc8b00e871f5ee22f8eb77d3041e25bd 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -420,6 +420,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
 #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
+#define DRM_FORMAT_MOD_VENDOR_MTK     0x0b
 
 /* add more to the end as needed */
 
@@ -1452,6 +1453,46 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
  */
 #define AMLOGIC_FBC_OPTION_MEM_SAVING		(1ULL << 0)
 
+/* MediaTek modifiers
+ * Bits  Parameter                Notes
+ * ----- ------------------------ ---------------------------------------------
+ *   7: 0 TILE LAYOUT              Values are MTK_FMT_MOD_TILE_*
+ *  15: 8 COMPRESSION              Values are MTK_FMT_MOD_COMPRESS_*
+ *  23:16 10 BIT LAYOUT            Values are MTK_FMT_MOD_10BIT_LAYOUT_*
+ *
+ */
+
+#define DRM_FORMAT_MOD_MTK(__flags)		fourcc_mod_code(MTK, __flags)
+
+/*
+ * MediaTek Tiled Modifier
+ * The lowest 8 bits of the modifier is used to specify the tiling
+ * layout. Only the 16L_32S tiling is used for now, but we define an
+ * "untiled" version and leave room for future expansion.
+ */
+#define MTK_FMT_MOD_TILE_MASK     0xf
+#define MTK_FMT_MOD_TILE_NONE     0x0
+#define MTK_FMT_MOD_TILE_16L32S   0x1
+
+/*
+ * Bits 8-15 specify compression options
+ */
+#define MTK_FMT_MOD_COMPRESS_MASK (0xf << 8)
+#define MTK_FMT_MOD_COMPRESS_NONE (0x0 << 8)
+#define MTK_FMT_MOD_COMPRESS_V1   (0x1 << 8)
+
+/*
+ * Bits 16-23 specify how the bits of 10 bit formats are
+ * stored out in memory
+ */
+#define MTK_FMT_MOD_10BIT_LAYOUT_MASK      (0xf << 16)
+#define MTK_FMT_MOD_10BIT_LAYOUT_PACKED    (0x0 << 16)
+#define MTK_FMT_MOD_10BIT_LAYOUT_LSBTILED  (0x1 << 16)
+#define MTK_FMT_MOD_10BIT_LAYOUT_LSBRASTER (0x2 << 16)
+
+/* alias for the most common tiling format */
+#define DRM_FORMAT_MOD_MTK_16L_32S_TILE  DRM_FORMAT_MOD_MTK(MTK_FMT_MOD_TILE_16L32S)
+
 /*
  * AMD modifiers
  *
diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
index 2122610de7f97a8f0129bbd3e6d6f72e4b405414..95ede2334204048d49b228284e9fbc1561337a16 100644
--- a/include/standard-headers/linux/const.h
+++ b/include/standard-headers/linux/const.h
@@ -33,7 +33,7 @@
  * Missing __asm__ support
  *
  * __BIT128() would not work in the __asm__ code, as it shifts an
- * 'unsigned __init128' data type as direct representation of
+ * 'unsigned __int128' data type as direct representation of
  * 128 bit constants is not supported in the gcc compiler, as
  * they get silently truncated.
  *
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index e83382531cd1c6e909bf2f3fc852aabeff1d861d..5d1ad5fdeab66979d7f996b272b84493043a1ee9 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2059,6 +2059,24 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
 	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
+	ETHTOOL_LINK_MODE_200000baseCR_Full_BIT		 = 103,
+	ETHTOOL_LINK_MODE_200000baseKR_Full_BIT		 = 104,
+	ETHTOOL_LINK_MODE_200000baseDR_Full_BIT		 = 105,
+	ETHTOOL_LINK_MODE_200000baseDR_2_Full_BIT	 = 106,
+	ETHTOOL_LINK_MODE_200000baseSR_Full_BIT		 = 107,
+	ETHTOOL_LINK_MODE_200000baseVR_Full_BIT		 = 108,
+	ETHTOOL_LINK_MODE_400000baseCR2_Full_BIT	 = 109,
+	ETHTOOL_LINK_MODE_400000baseKR2_Full_BIT	 = 110,
+	ETHTOOL_LINK_MODE_400000baseDR2_Full_BIT	 = 111,
+	ETHTOOL_LINK_MODE_400000baseDR2_2_Full_BIT	 = 112,
+	ETHTOOL_LINK_MODE_400000baseSR2_Full_BIT	 = 113,
+	ETHTOOL_LINK_MODE_400000baseVR2_Full_BIT	 = 114,
+	ETHTOOL_LINK_MODE_800000baseCR4_Full_BIT	 = 115,
+	ETHTOOL_LINK_MODE_800000baseKR4_Full_BIT	 = 116,
+	ETHTOOL_LINK_MODE_800000baseDR4_Full_BIT	 = 117,
+	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
+	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
+	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -2271,6 +2289,10 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
  * be exploited to reduce the RSS queue spread.
  */
 #define	RXH_XFRM_SYM_XOR	(1 << 0)
+/* Similar to SYM_XOR, except that one copy of the XOR'ed fields is replaced by
+ * an OR of the same fields
+ */
+#define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
 #define	RXH_XFRM_NO_CHANGE	0xff
 
 /* L2-L4 network traffic flow types */
diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index d303effb2a0d232a344051997dadbddbb3273a8d..a2b5815d890871d83a1e6d5f2b56437b6efbaba7 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -229,6 +229,9 @@
  *    - FUSE_URING_IN_OUT_HEADER_SZ
  *    - FUSE_URING_OP_IN_OUT_SZ
  *    - enum fuse_uring_cmd
+ *
+ *  7.43
+ *  - add FUSE_REQUEST_TIMEOUT
  */
 
 #ifndef _LINUX_FUSE_H
@@ -260,7 +263,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 42
+#define FUSE_KERNEL_MINOR_VERSION 43
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -431,6 +434,8 @@ struct fuse_file_lock {
  *		    of the request ID indicates resend requests
  * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
+ * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
+ *			 init_out.request_timeout contains the timeout (in secs)
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -473,11 +478,11 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
-
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
+#define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 
 /**
  * CUSE INIT request/reply flags
@@ -905,7 +910,8 @@ struct fuse_init_out {
 	uint16_t	map_alignment;
 	uint32_t	flags2;
 	uint32_t	max_stack_depth;
-	uint32_t	unused[6];
+	uint16_t	request_timeout;
+	uint16_t	unused[11];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 3445c4970e4d8e72f426071032adf82799aedbf7..ba326710f9c8b626645a77a7fecd31f1b481f3d4 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -486,6 +486,7 @@
 #define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
 #define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
 #define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
+#define  PCI_EXP_FLAGS_FLIT	0x8000	/* Flit Mode Supported */
 #define PCI_EXP_DEVCAP		0x04	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
 #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
@@ -795,6 +796,8 @@
 #define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
 #define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
 #define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
+#define  PCI_ERR_CAP_TLP_LOG_FLIT	0x00040000 /* TLP was logged in Flit Mode */
+#define  PCI_ERR_CAP_TLP_LOG_SIZE	0x00f80000 /* Logged TLP Size (only in Flit mode) */
 #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	0x2c	/* Root Error Command */
 #define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
@@ -1013,7 +1016,7 @@
 
 /* Resizable BARs */
 #define PCI_REBAR_CAP		4	/* capability register */
-#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
+#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
@@ -1061,8 +1064,9 @@
 #define  PCI_EXP_DPC_CAP_RP_EXT		0x0020	/* Root Port Extensions */
 #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x0040	/* Poisoned TLP Egress Blocking Supported */
 #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x0080	/* Software Triggering Supported */
-#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size */
+#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size [3:0] */
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
+#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE4	0x2000	/* RP PIO Log Size [4] */
 
 #define PCI_EXP_DPC_CTL			0x06	/* DPC control */
 #define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
@@ -1205,9 +1209,12 @@
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
-#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index fc594fe5fcbe3a750d835aa9003d966da26d53a0..982e854f14e49e3a7d2637f151c0c622aa84dcaa 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -327,6 +327,19 @@ struct virtio_net_rss_config {
 	uint8_t hash_key_data[/* hash_key_length */];
 };
 
+struct virtio_net_rss_config_hdr {
+	uint32_t hash_types;
+	uint16_t indirection_table_mask;
+	uint16_t unclassified_queue;
+	uint16_t indirection_table[/* 1 + indirection_table_mask */];
+};
+
+struct virtio_net_rss_config_trailer {
+	uint16_t max_tx_vq;
+	uint8_t hash_key_length;
+	uint8_t hash_key_data[/* hash_key_length */];
+};
+
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
 /*
diff --git a/include/standard-headers/linux/virtio_snd.h b/include/standard-headers/linux/virtio_snd.h
index 860f12e0a4e196b6469fc7f4ee44545c4130b380..160d57899f83550a6d2ee20cf65723366b9d7fb0 100644
--- a/include/standard-headers/linux/virtio_snd.h
+++ b/include/standard-headers/linux/virtio_snd.h
@@ -25,7 +25,7 @@ struct virtio_snd_config {
 	uint32_t streams;
 	/* # of available channel maps */
 	uint32_t chmaps;
-	/* # of available control elements */
+	/* # of available control elements (if VIRTIO_SND_F_CTLS) */
 	uint32_t controls;
 };
 
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index ec1e82bdc8882da5be677d91e91713e123c1ccb4..4e6aff08df8b05d04483b2e18844de3eabb362ea 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -105,6 +105,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
+#define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -365,6 +366,7 @@ enum {
 	KVM_REG_ARM_STD_HYP_BIT_PV_TIME	= 0,
 };
 
+/* Vendor hyper call function numbers 0-63 */
 #define KVM_REG_ARM_VENDOR_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(2)
 
 enum {
@@ -372,6 +374,14 @@ enum {
 	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
 };
 
+/* Vendor hyper call function numbers 64-127 */
+#define KVM_REG_ARM_VENDOR_HYP_BMAP_2		KVM_REG_ARM_FW_FEAT_BMAP_REG(3)
+
+enum {
+	KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_VER	= 0,
+	KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_CPUS	= 1,
+};
+
 /* Device Control API on vm fd */
 #define KVM_ARM_VM_SMCCC_CTRL		0
 #define   KVM_ARM_VM_SMCCC_FILTER	0
@@ -394,6 +404,7 @@ enum {
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
 #define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
+#define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ  9
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index d4e90fff76057b7944c9b0d41306380238dcf4f0..ee9aaebdf325243c588834674d1b963ebb3070b5 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -323,6 +323,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-generic/mman-common.h
index 1ea2c4c33b86a2638b03335ad5bfcfd1691cef3e..ef1c27fa3c570fa4ff06fc6f742914925f8b02c8 100644
--- a/linux-headers/asm-generic/mman-common.h
+++ b/linux-headers/asm-generic/mman-common.h
@@ -85,6 +85,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_UNRESTRICTED	0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..2892a45023af6d3eb941623d4fed04841ab07e02 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -849,9 +849,11 @@ __SYSCALL(__NR_getxattrat, sys_getxattrat)
 __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
+#define __NR_open_tree_attr 467
+__SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 468
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index 23fb96a8a77f011e59d0b0789b6df2509155df07..50d22df8f7ce85b01f991ef5fd81724866aaa8ac 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -319,6 +319,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index 9a757196448c5706236635186fc5811d0dd75a08..bdcc2f460babac1da7ad95aa1804883bd7fbfc0f 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -395,5 +395,6 @@
 #define __NR_getxattrat (__NR_Linux + 464)
 #define __NR_listxattrat (__NR_Linux + 465)
 #define __NR_removexattrat (__NR_Linux + 466)
+#define __NR_open_tree_attr (__NR_Linux + 467)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index 7086783b0cf2199f7e4b3831e1380240132f7b61..3b6b0193b69055194f7d025044616cc41fc40ef4 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -371,5 +371,6 @@
 #define __NR_getxattrat (__NR_Linux + 464)
 #define __NR_listxattrat (__NR_Linux + 465)
 #define __NR_removexattrat (__NR_Linux + 466)
+#define __NR_open_tree_attr (__NR_Linux + 467)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index b3825823e486240ecaa4f42077015fd23843cdb8..4609a4b4d38b425647b8c740975a0856e344af45 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -441,5 +441,6 @@
 #define __NR_getxattrat (__NR_Linux + 464)
 #define __NR_listxattrat (__NR_Linux + 465)
 #define __NR_removexattrat (__NR_Linux + 466)
+#define __NR_open_tree_attr (__NR_Linux + 467)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 38ee4dc35d757ce0474cf51acd75c53ec34c3c8c..5d38a427e0af76192f8ec6a9b8542a2fb81262c0 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -448,6 +448,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 5e5f156834698e79e61d42d04b35cbc717a48aac..860a488e4d1a17bb553ab68a97439995be0c9488 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -420,6 +420,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index f06bc5efcd79a24fcfa656c49b0ee2526f455cd1..5f59fd226cc57af811706c4705fee12eafcc7d08 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -182,6 +182,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_SVVPTC,
 	KVM_RISCV_ISA_EXT_ZABHA,
 	KVM_RISCV_ISA_EXT_ZICCRSE,
+	KVM_RISCV_ISA_EXT_ZAAMO,
+	KVM_RISCV_ISA_EXT_ZALRSC,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 74f6127aedaa5e5fbd521d1f1f6a078ba6f3e9c4..a5e769f1d996721840ea40ea949529b69e4ad282 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -314,6 +314,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index bb6a15a2ec407509862123bd806b07d9d556159b..8df4d64841c2ab8ad73af78305348e89f32d62d2 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -324,6 +324,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index 620201cb36534b06b7e884bb8dcdb57b774724d0..85eedbd18e31feba19d3741a9e89694fa7bc3dde 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -439,5 +439,6 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index e7e4a10aaf0b3f8ae25da665fbe5e6f0a332ad74..c03b1b9701024db8cef8ee34ce3359cc39bcbf8d 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -387,5 +387,6 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 86f2c34e7afa27e3271eec0f6fd2585e98e97522..dc591fb17e59d40c9a36ec0f74c2c519dfb968be 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -557,6 +557,9 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
 
+#define KVM_XEN_MSR_MIN_INDEX			0x40000000u
+#define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
+
 struct kvm_xen_hvm_config {
 	__u32 flags;
 	__u32 msr;
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index a2eb492a75ec0246a0195ab4eef9aaf55a8b006b..491d6b4eb68eefafd78a902f468407dce8333fdc 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -457,6 +457,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 2f5fc400f5922a6ac3e1faef89a5f9689c82ffd0..7cf88bf9bdac6a6381063376f6673faaf29b393c 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -380,6 +380,7 @@
 #define __NR_getxattrat 464
 #define __NR_listxattrat 465
 #define __NR_removexattrat 466
+#define __NR_open_tree_attr 467
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index fecd832e7fcc806507a9f965178456a784980cda..82959111e6a5e8cad2e8fb28b8e5431c19b313d5 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -333,6 +333,7 @@
 #define __NR_getxattrat (__X32_SYSCALL_BIT + 464)
 #define __NR_listxattrat (__X32_SYSCALL_BIT + 465)
 #define __NR_removexattrat (__X32_SYSCALL_BIT + 466)
+#define __NR_open_tree_attr (__X32_SYSCALL_BIT + 467)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/bits.h b/linux-headers/linux/bits.h
index c0d00c0a9868beffb660d6070df70c5b6e3ad8a2..58596d18f43b4f6107f833b2636adbbc0cdf3ce4 100644
--- a/linux-headers/linux/bits.h
+++ b/linux-headers/linux/bits.h
@@ -4,13 +4,9 @@
 #ifndef _LINUX_BITS_H
 #define _LINUX_BITS_H
 
-#define __GENMASK(h, l) \
-        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
-         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
+#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
 
-#define __GENMASK_ULL(h, l) \
-        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
-         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
+#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 #define __GENMASK_U128(h, l) \
 	((_BIT128((h)) << 1) - (_BIT128(l)))
diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
index 2122610de7f97a8f0129bbd3e6d6f72e4b405414..95ede2334204048d49b228284e9fbc1561337a16 100644
--- a/linux-headers/linux/const.h
+++ b/linux-headers/linux/const.h
@@ -33,7 +33,7 @@
  * Missing __asm__ support
  *
  * __BIT128() would not work in the __asm__ code, as it shifts an
- * 'unsigned __init128' data type as direct representation of
+ * 'unsigned __int128' data type as direct representation of
  * 128 bit constants is not supported in the gcc compiler, as
  * they get silently truncated.
  *
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index ccbdca5e1138d50d45ea3c33e4300345a86edc21..cb0f7d6b4dec916a4d74b743b1ae2cfb1291233c 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -55,6 +55,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 };
 
 /**
@@ -392,6 +393,9 @@ struct iommu_vfio_ioas {
  *                          Any domain attached to the non-PASID part of the
  *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
+ *                          For the user that wants to attach PASID, ioas is
+ *                          not recommended for both the non-PASID part
+ *                          and PASID part of the device.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
  */
@@ -608,9 +612,17 @@ enum iommu_hw_info_type {
  *                                   IOMMU_HWPT_GET_DIRTY_BITMAP
  *                                   IOMMU_HWPT_SET_DIRTY_TRACKING
  *
+ * @IOMMU_HW_CAP_PCI_PASID_EXEC: Execute Permission Supported, user ignores it
+ *                               when the struct
+ *                               iommu_hw_info::out_max_pasid_log2 is zero.
+ * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
+ *                               when the struct
+ *                               iommu_hw_info::out_max_pasid_log2 is zero.
  */
 enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
+	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
+	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
 };
 
 /**
@@ -626,6 +638,9 @@ enum iommufd_hw_capabilities {
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
  *                    in the enum iommu_hw_capabilities.
+ * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
+ *                      PCI devices turn to out_capabilities to check if the
+ *                      specific capabilities is supported or not.
  * @__reserved: Must be 0
  *
  * Query an iommu type specific hardware information data from an iommu behind
@@ -649,7 +664,8 @@ struct iommu_hw_info {
 	__u32 data_len;
 	__aligned_u64 data_uptr;
 	__u32 out_data_type;
-	__u32 __reserved;
+	__u8 out_max_pasid_log2;
+	__u8 __reserved[3];
 	__aligned_u64 out_capabilities;
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
@@ -1014,4 +1030,115 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+/**
+ * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
+ * @IOMMU_VEVENTQ_FLAG_LOST_EVENTS: vEVENTQ has lost vEVENTs
+ */
+enum iommu_veventq_flag {
+	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
+};
+
+/**
+ * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
+ * @flags: Combination of enum iommu_veventq_flag
+ * @sequence: The sequence index of a vEVENT in the vEVENTQ, with a range of
+ *            [0, INT_MAX] where the following index of INT_MAX is 0
+ *
+ * Each iommufd_vevent_header reports a sequence index of the following vEVENT:
+ *
+ * +----------------------+-------+----------------------+-------+---+-------+
+ * | header0 {sequence=0} | data0 | header1 {sequence=1} | data1 |...| dataN |
+ * +----------------------+-------+----------------------+-------+---+-------+
+ *
+ * And this sequence index is expected to be monotonic to the sequence index of
+ * the previous vEVENT. If two adjacent sequence indexes has a delta larger than
+ * 1, it means that delta - 1 number of vEVENTs has lost, e.g. two lost vEVENTs:
+ *
+ * +-----+----------------------+-------+----------------------+-------+-----+
+ * | ... | header3 {sequence=3} | data3 | header6 {sequence=6} | data6 | ... |
+ * +-----+----------------------+-------+----------------------+-------+-----+
+ *
+ * If a vEVENT lost at the tail of the vEVENTQ and there is no following vEVENT
+ * providing the next sequence index, an IOMMU_VEVENTQ_FLAG_LOST_EVENTS header
+ * would be added to the tail, and no data would follow this header:
+ *
+ * +--+----------------------+-------+-----------------------------------------+
+ * |..| header3 {sequence=3} | data3 | header4 {flags=LOST_EVENTS, sequence=4} |
+ * +--+----------------------+-------+-----------------------------------------+
+ */
+struct iommufd_vevent_header {
+	__u32 flags;
+	__u32 sequence;
+};
+
+/**
+ * enum iommu_veventq_type - Virtual Event Queue Type
+ * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
+ */
+enum iommu_veventq_type {
+	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+};
+
+/**
+ * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
+ *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
+ * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
+ *       Reported event records: (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *       - 0x04 C_BAD_STE
+ *       - 0x06 F_STREAM_DISABLED
+ *       - 0x08 C_BAD_SUBSTREAMID
+ *       - 0x0a C_BAD_CD
+ *       - 0x10 F_TRANSLATION
+ *       - 0x11 F_ADDR_SIZE
+ *       - 0x12 F_ACCESS
+ *       - 0x13 F_PERMISSION
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual event for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_vevent_arm_smmuv3 {
+	__aligned_le64 evt[4];
+};
+
+/**
+ * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
+ * @size: sizeof(struct iommu_veventq_alloc)
+ * @flags: Must be 0
+ * @viommu_id: virtual IOMMU ID to associate the vEVENTQ with
+ * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
+ * @veventq_depth: Maximum number of events in the vEVENTQ
+ * @out_veventq_id: The ID of the new vEVENTQ
+ * @out_veventq_fd: The fd of the new vEVENTQ. User space must close the
+ *                  successfully returned fd after using it
+ * @__reserved: Must be 0
+ *
+ * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
+ * can have multiple FDs for different types, but is confined to one per @type.
+ * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
+ * if there are vEVENTs available. A vEVENTQ will lose events due to overflow,
+ * if the number of the vEVENTs hits @veventq_depth.
+ *
+ * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
+ * a type-specific data structure, in a normal case:
+ *
+ * +-+---------+-------+---------+-------+-----+---------+-------+-+
+ * | | header0 | data0 | header1 | data1 | ... | headerN | dataN | |
+ * +-+---------+-------+---------+-------+-----+---------+-------+-+
+ *
+ * unless a tailing IOMMU_VEVENTQ_FLAG_LOST_EVENTS header is logged (refer to
+ * struct iommufd_vevent_header).
+ */
+struct iommu_veventq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 veventq_depth;
+	__u32 out_veventq_id;
+	__u32 out_veventq_fd;
+	__u32 __reserved;
+};
+#define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
 #endif
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 27181b3dd8fb2aa81e859ff052a9d5df35c15938..e5f3e8b5a02a8e07dc3edb206d1873ed8cfb474b 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -921,6 +921,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index 17bf19157329de9be248954d4279c557b586dcb6..113c4ceb78407ed46e8863ac2f3e108266eefd3c 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -73,13 +73,20 @@ typedef enum {
 	SEV_RET_INVALID_PARAM,
 	SEV_RET_RESOURCE_LIMIT,
 	SEV_RET_SECURE_DATA_INVALID,
-	SEV_RET_INVALID_KEY = 0x27,
-	SEV_RET_INVALID_PAGE_SIZE,
-	SEV_RET_INVALID_PAGE_STATE,
-	SEV_RET_INVALID_MDATA_ENTRY,
-	SEV_RET_INVALID_PAGE_OWNER,
-	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
-	SEV_RET_RMP_INIT_REQUIRED,
+	SEV_RET_INVALID_PAGE_SIZE          = 0x0019,
+	SEV_RET_INVALID_PAGE_STATE         = 0x001A,
+	SEV_RET_INVALID_MDATA_ENTRY        = 0x001B,
+	SEV_RET_INVALID_PAGE_OWNER         = 0x001C,
+	SEV_RET_AEAD_OFLOW                 = 0x001D,
+	SEV_RET_EXIT_RING_BUFFER           = 0x001F,
+	SEV_RET_RMP_INIT_REQUIRED          = 0x0020,
+	SEV_RET_BAD_SVN                    = 0x0021,
+	SEV_RET_BAD_VERSION                = 0x0022,
+	SEV_RET_SHUTDOWN_REQUIRED          = 0x0023,
+	SEV_RET_UPDATE_FAILED              = 0x0024,
+	SEV_RET_RESTORE_REQUIRED           = 0x0025,
+	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
+	SEV_RET_INVALID_KEY                = 0x0027,
 	SEV_RET_MAX,
 } sev_ret_code;
 
diff --git a/linux-headers/linux/stddef.h b/linux-headers/linux/stddef.h
index e1416f793738f56beb5b47447f1c422eb103da72..e1fcfcf3b33261939797d79f4e29a28fa1da6e10 100644
--- a/linux-headers/linux/stddef.h
+++ b/linux-headers/linux/stddef.h
@@ -70,4 +70,6 @@
 #define __counted_by_be(m)
 #endif
 
+#define __kernel_nonstring
+
 #endif /* _LINUX_STDDEF_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 1b5e254d6a7d77a6baff58c55bc3bf4f12387159..79bf8c0cc5e405bcbca1e92c82468ce39665ab5f 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -671,6 +671,7 @@ enum {
  */
 enum {
 	VFIO_AP_REQ_IRQ_INDEX,
+	VFIO_AP_CFG_CHG_IRQ_INDEX,
 	VFIO_AP_NUM_IRQS
 };
 
@@ -931,29 +932,34 @@ struct vfio_device_bind_iommufd {
  * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 19,
  *					struct vfio_device_attach_iommufd_pt)
  * @argsz:	User filled size of this data.
- * @flags:	Must be 0.
+ * @flags:	Flags for attach.
  * @pt_id:	Input the target id which can represent an ioas or a hwpt
  *		allocated via iommufd subsystem.
  *		Output the input ioas id or the attached hwpt id which could
  *		be the specified hwpt itself or a hwpt automatically created
  *		for the specified ioas by kernel during the attachment.
+ * @pasid:	The pasid to be attached, only meaningful when
+ *		VFIO_DEVICE_ATTACH_PASID is set in @flags
  *
  * Associate the device with an address space within the bound iommufd.
  * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
  * allowed on cdev fds.
  *
- * If a vfio device is currently attached to a valid hw_pagetable, without doing
- * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
- * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
- * as a hw_pagetable replacement, will replace the device's currently attached
- * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ * If a vfio device or a pasid of this device is currently attached to a valid
+ * hw_pagetable (hwpt), without doing a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second
+ * VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is allowed.
+ * This action, also known as a hw_pagetable replacement, will replace the
+ * currently attached hwpt of the device or the pasid of this device with a new
+ * hwpt corresponding to the given pt_id.
  *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_device_attach_iommufd_pt {
 	__u32	argsz;
 	__u32	flags;
+#define VFIO_DEVICE_ATTACH_PASID	(1 << 0)
 	__u32	pt_id;
+	__u32	pasid;
 };
 
 #define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 19)
@@ -962,17 +968,21 @@ struct vfio_device_attach_iommufd_pt {
  * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
  *					struct vfio_device_detach_iommufd_pt)
  * @argsz:	User filled size of this data.
- * @flags:	Must be 0.
+ * @flags:	Flags for detach.
+ * @pasid:	The pasid to be detached, only meaningful when
+ *		VFIO_DEVICE_DETACH_PASID is set in @flags
  *
- * Remove the association of the device and its current associated address
- * space.  After it, the device should be in a blocking DMA state.  This is only
- * allowed on cdev fds.
+ * Remove the association of the device or a pasid of the device and its current
+ * associated address space.  After it, the device or the pasid should be in a
+ * blocking DMA state.  This is only allowed on cdev fds.
  *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_device_detach_iommufd_pt {
 	__u32	argsz;
 	__u32	flags;
+#define VFIO_DEVICE_DETACH_PASID	(1 << 0)
+	__u32	pasid;
 };
 
 #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)
-- 
2.49.0


