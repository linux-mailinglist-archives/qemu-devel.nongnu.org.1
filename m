Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 766089E6E19
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 13:29:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRl-000680-8C; Fri, 06 Dec 2024 07:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRP-0005zA-Jt; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRI-00042I-HV; Fri, 06 Dec 2024 07:28:15 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67UhIJ000924;
 Fri, 6 Dec 2024 12:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GdgFJzIUlkw2tMuWA
 wWfyBbYEN3p0NV5SSWFu7HcBbY=; b=amY+3nAuvvOOX/0qzFTqLAb8qsvgjb05r
 pWMrNanOsPnu/+iHmLwkpsWhIifU8RZK5knS7wJDhDjhPzJxDI+FhaKYqE4FMuMQ
 mUyb5YXEjXsUCWhZllsE4FGPPsUYJ3oA7EJW2kq2Sg5eRdm5WNBmLHITHeBfdNrh
 0N7HTmLnlDjrynzEPVL83iEZi9afOv1B2M0pMROfDx7WkO5HFedkSx3WcAWKCB6z
 3NNnS4GOmKIGTBTXYPJiF16AiFgp3yB0PzSO0SG9Zj2rNucWz9of81KgVZddBxhE
 WCKzvdsMrdDaxMf6r06YJtcrmStnI8R8P2z7mX513i6uv4OXGelqA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxks5r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6CQ26n020536;
 Fri, 6 Dec 2024 12:28:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1spns4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CS1nO34799954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:28:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E10020043;
 Fri,  6 Dec 2024 12:28:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C79B92004D;
 Fri,  6 Dec 2024 12:28:00 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:28:00 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 06/15] linux-headers: Update to Linux 6.13-rc1
Date: Fri,  6 Dec 2024 13:27:42 +0100
Message-ID: <20241206122751.189721-7-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kR5UmAAc3FQQQ3PwhsRixUZ9mNH3dqVo
X-Proofpoint-ORIG-GUID: kR5UmAAc3FQQQ3PwhsRixUZ9mNH3dqVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060089
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

This linux headers update includes required changes for
the gen17 CPU model.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 include/standard-headers/drm/drm_fourcc.h     |   1 +
 include/standard-headers/linux/ethtool.h      |   5 +
 include/standard-headers/linux/pci_regs.h     |  38 ++-
 .../standard-headers/linux/virtio_crypto.h    |   1 +
 include/standard-headers/linux/virtio_pci.h   | 131 ++++++++++
 linux-headers/asm-arm64/kvm.h                 |   6 +
 linux-headers/asm-arm64/unistd_64.h           |   4 +
 linux-headers/asm-generic/mman-common.h       |   3 +
 linux-headers/asm-generic/mman.h              |   4 +
 linux-headers/asm-generic/unistd.h            |  11 +-
 linux-headers/asm-loongarch/kvm.h             |  20 ++
 linux-headers/asm-loongarch/unistd_64.h       |   4 +
 linux-headers/asm-mips/mman.h                 |   3 +
 linux-headers/asm-mips/unistd_n32.h           |   4 +
 linux-headers/asm-mips/unistd_n64.h           |   4 +
 linux-headers/asm-mips/unistd_o32.h           |   4 +
 linux-headers/asm-powerpc/unistd_32.h         |   4 +
 linux-headers/asm-powerpc/unistd_64.h         |   4 +
 linux-headers/asm-riscv/kvm.h                 |   4 +
 linux-headers/asm-riscv/unistd_32.h           |   4 +
 linux-headers/asm-riscv/unistd_64.h           |   4 +
 linux-headers/asm-s390/kvm.h                  |   3 +-
 linux-headers/asm-s390/unistd_32.h            |   4 +
 linux-headers/asm-s390/unistd_64.h            |   4 +
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/mman.h                  |   3 -
 linux-headers/asm-x86/unistd_32.h             |   4 +
 linux-headers/asm-x86/unistd_64.h             |   4 +
 linux-headers/asm-x86/unistd_x32.h            |   4 +
 linux-headers/linux/iommufd.h                 | 224 +++++++++++++++++-
 linux-headers/linux/kvm.h                     |   8 +
 linux-headers/linux/psci.h                    |   5 +
 linux-headers/linux/vfio.h                    |   2 +-
 33 files changed, 506 insertions(+), 23 deletions(-)

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index d4a2231306..708647776f 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -1515,6 +1515,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
  * 64K_D_2D on GFX12 is identical to 64K_D on GFX11.
  */
 #define AMD_FMT_MOD_TILE_GFX9_64K_D 10
+#define AMD_FMT_MOD_TILE_GFX9_4K_D_X 22
 #define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25
 #define AMD_FMT_MOD_TILE_GFX9_64K_D_X 26
 #define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index b05e84825b..67c47912e5 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2526,6 +2526,11 @@ struct ethtool_link_settings {
 	uint8_t	master_slave_state;
 	uint8_t	rate_matching;
 	uint32_t	reserved[7];
+	/* Linux builds with -Wflex-array-member-not-at-end but does
+	 * not use the "link_mode_masks" member. Leave it defined for
+	 * userspace for now, and when userspace wants to start using
+	 * -Wfamnae, we'll need a new solution.
+	 */
 	uint32_t	link_mode_masks[];
 	/* layout of link_mode_masks fields:
 	 * uint32_t map_supported[link_mode_masks_nwords];
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 12323b3334..1601c7ed5f 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -340,7 +340,8 @@
 #define PCI_MSIX_ENTRY_UPPER_ADDR	0x4  /* Message Upper Address */
 #define PCI_MSIX_ENTRY_DATA		0x8  /* Message Data */
 #define PCI_MSIX_ENTRY_VECTOR_CTRL	0xc  /* Vector Control */
-#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001  /* Mask Bit */
+#define  PCI_MSIX_ENTRY_CTRL_ST		0xffff0000  /* Steering Tag */
 
 /* CompactPCI Hotswap Register */
 
@@ -659,6 +660,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -678,6 +680,7 @@
 #define PCI_EXP_DEVSTA2		0x2a	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2 0x2c	/* end of v2 EPs w/o link */
 #define PCI_EXP_LNKCAP2		0x2c	/* Link Capabilities 2 */
+#define  PCI_EXP_LNKCAP2_SLS		0x000000fe /* Supported Link Speeds Vector */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
@@ -1023,15 +1026,34 @@
 #define  PCI_DPA_CAP_SUBSTATE_MASK	0x1F	/* # substates - 1 */
 #define PCI_DPA_BASE_SIZEOF	16	/* size with 0 substates */
 
+/* TPH Completer Support */
+#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
+#define PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH	0x3 /* TPH and Extended TPH */
+
 /* TPH Requester */
 #define PCI_TPH_CAP		4	/* capability register */
-#define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
-#define   PCI_TPH_LOC_NONE	0x000	/* no location */
-#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
-#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
-#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
-#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
-#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
+#define  PCI_TPH_CAP_ST_NS	0x00000001 /* No ST Mode Supported */
+#define  PCI_TPH_CAP_ST_IV	0x00000002 /* Interrupt Vector Mode Supported */
+#define  PCI_TPH_CAP_ST_DS	0x00000004 /* Device Specific Mode Supported */
+#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* Ext TPH Requester Supported */
+#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
+#define   PCI_TPH_LOC_NONE	0x00000000 /* Not present */
+#define   PCI_TPH_LOC_CAP	0x00000200 /* In capability */
+#define   PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */
+#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
+#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
+#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
+
+#define PCI_TPH_CTRL		8	/* control register */
+#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
+#define   PCI_TPH_ST_NS_MODE		0x0 /* No ST Mode */
+#define   PCI_TPH_ST_IV_MODE		0x1 /* Interrupt Vector Mode */
+#define   PCI_TPH_ST_DS_MODE		0x2 /* Device Specific Mode */
+#define  PCI_TPH_CTRL_REQ_EN_MASK	0x00000300 /* TPH Requester Enable */
+#define   PCI_TPH_REQ_DISABLE		0x0 /* No TPH requests allowed */
+#define   PCI_TPH_REQ_TPH_ONLY		0x1 /* TPH only requests allowed */
+#define   PCI_TPH_REQ_EXT_TPH		0x3 /* Extended TPH requests allowed */
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 68066dafb6..4d350ae595 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -329,6 +329,7 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
 #define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+	/* akcipher sign/verify opcodes are deprecated */
 #define VIRTIO_CRYPTO_AKCIPHER_SIGN \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
 #define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 4010216103..b177ed8972 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -40,6 +40,7 @@
 #define _LINUX_VIRTIO_PCI_H
 
 #include "standard-headers/linux/types.h"
+#include "standard-headers/linux/kernel.h"
 
 #ifndef VIRTIO_PCI_NO_LEGACY
 
@@ -240,6 +241,17 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ		0x5
 #define VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO		0x6
 
+/* Device parts access commands. */
+#define VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY		0x7
+#define VIRTIO_ADMIN_CMD_DEVICE_CAP_GET			0x8
+#define VIRTIO_ADMIN_CMD_DRIVER_CAP_SET			0x9
+#define VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE		0xa
+#define VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY		0xd
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_METADATA_GET		0xe
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_GET			0xf
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_SET			0x10
+#define VIRTIO_ADMIN_CMD_DEV_MODE_SET			0x11
+
 struct virtio_admin_cmd_hdr {
 	uint16_t opcode;
 	/*
@@ -286,4 +298,123 @@ struct virtio_admin_cmd_notify_info_result {
 	struct virtio_admin_cmd_notify_info_data entries[VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO];
 };
 
+#define VIRTIO_DEV_PARTS_CAP 0x0000
+
+struct virtio_dev_parts_cap {
+	uint8_t get_parts_resource_objects_limit;
+	uint8_t set_parts_resource_objects_limit;
+};
+
+#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+
+struct virtio_admin_cmd_query_cap_id_result {
+	uint64_t supported_caps[MAX_CAP_ID];
+};
+
+struct virtio_admin_cmd_cap_get_data {
+	uint16_t id;
+	uint8_t reserved[6];
+};
+
+struct virtio_admin_cmd_cap_set_data {
+	uint16_t id;
+	uint8_t reserved[6];
+	uint8_t cap_specific_data[];
+};
+
+struct virtio_admin_cmd_resource_obj_cmd_hdr {
+	uint16_t type;
+	uint8_t reserved[2];
+	uint32_t id; /* Indicates unique resource object id per resource object type */
+};
+
+struct virtio_admin_cmd_resource_obj_create_data {
+	struct virtio_admin_cmd_resource_obj_cmd_hdr hdr;
+	uint64_t flags;
+	uint8_t resource_obj_specific_data[];
+};
+
+#define VIRTIO_RESOURCE_OBJ_DEV_PARTS 0
+
+#define VIRTIO_RESOURCE_OBJ_DEV_PARTS_TYPE_GET 0
+#define VIRTIO_RESOURCE_OBJ_DEV_PARTS_TYPE_SET 1
+
+struct virtio_resource_obj_dev_parts {
+	uint8_t type;
+	uint8_t reserved[7];
+};
+
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_METADATA_TYPE_SIZE 0
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_METADATA_TYPE_COUNT 1
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_METADATA_TYPE_LIST 2
+
+struct virtio_admin_cmd_dev_parts_metadata_data {
+	struct virtio_admin_cmd_resource_obj_cmd_hdr hdr;
+	uint8_t type;
+	uint8_t reserved[7];
+};
+
+#define VIRTIO_DEV_PART_F_OPTIONAL 0
+
+struct virtio_dev_part_hdr {
+	uint16_t part_type;
+	uint8_t flags;
+	uint8_t reserved;
+	union {
+		struct {
+			uint32_t offset;
+			uint32_t reserved;
+		} pci_common_cfg;
+		struct {
+			uint16_t index;
+			uint8_t reserved[6];
+		} vq_index;
+	} selector;
+	uint32_t length;
+};
+
+struct virtio_dev_part {
+	struct virtio_dev_part_hdr hdr;
+	uint8_t value[];
+};
+
+struct virtio_admin_cmd_dev_parts_metadata_result {
+	union {
+		struct {
+			uint32_t size;
+			uint32_t reserved;
+		} parts_size;
+		struct {
+			uint32_t count;
+			uint32_t reserved;
+		} hdr_list_count;
+		struct {
+			uint32_t count;
+			uint32_t reserved;
+			struct virtio_dev_part_hdr hdrs[];
+		} hdr_list;
+	};
+};
+
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_GET_TYPE_SELECTED 0
+#define VIRTIO_ADMIN_CMD_DEV_PARTS_GET_TYPE_ALL 1
+
+struct virtio_admin_cmd_dev_parts_get_data {
+	struct virtio_admin_cmd_resource_obj_cmd_hdr hdr;
+	uint8_t type;
+	uint8_t reserved[7];
+	struct virtio_dev_part_hdr hdr_list[];
+};
+
+struct virtio_admin_cmd_dev_parts_set_data {
+	struct virtio_admin_cmd_resource_obj_cmd_hdr hdr;
+	struct virtio_dev_part parts[];
+};
+
+#define VIRTIO_ADMIN_CMD_DEV_MODE_F_STOPPED 0
+
+struct virtio_admin_cmd_dev_mode_set_data {
+	uint8_t flags;
+};
+
 #endif
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 2af9931ae9..dccd5d965f 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -473,6 +473,12 @@ enum {
  */
 #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2	(1ULL << 0)
 
+/*
+ * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
+ * Valid only when the system event has a type of KVM_SYSTEM_EVENT_SHUTDOWN.
+ */
+#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2	(1ULL << 0)
+
 /* run->fail_entry.hardware_entry_failure_reason codes. */
 #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED	(1ULL << 0)
 
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index 99a1d70459..d4e90fff76 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -319,6 +319,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-generic/mman-common.h
index 6ce1f1ceb4..1ea2c4c33b 100644
--- a/linux-headers/asm-generic/mman-common.h
+++ b/linux-headers/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/linux-headers/asm-generic/mman.h b/linux-headers/asm-generic/mman.h
index 57e8195d0b..5e3d61ddbd 100644
--- a/linux-headers/asm-generic/mman.h
+++ b/linux-headers/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack marker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 5bf6148cac..88dc393c2b 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -841,8 +841,17 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
+#define __NR_setxattrat 463
+__SYSCALL(__NR_setxattrat, sys_setxattrat)
+#define __NR_getxattrat 464
+__SYSCALL(__NR_getxattrat, sys_getxattrat)
+#define __NR_listxattrat 465
+__SYSCALL(__NR_listxattrat, sys_listxattrat)
+#define __NR_removexattrat 466
+__SYSCALL(__NR_removexattrat, sys_removexattrat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 467
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index 70d89070bf..5f354f5c68 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -8,6 +8,8 @@
 
 #include <linux/types.h>
 
+#define __KVM_HAVE_IRQ_LINE
+
 /*
  * KVM LoongArch specific structures and definitions.
  *
@@ -132,4 +134,22 @@ struct kvm_iocsr_entry {
 #define KVM_IRQCHIP_NUM_PINS	64
 #define KVM_MAX_CORES		256
 
+#define KVM_DEV_LOONGARCH_IPI_GRP_REGS			0x40000001
+
+#define KVM_DEV_LOONGARCH_EXTIOI_GRP_REGS		0x40000002
+
+#define KVM_DEV_LOONGARCH_EXTIOI_GRP_SW_STATUS		0x40000003
+#define KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_NUM_CPU	0x0
+#define KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_FEATURE	0x1
+#define KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE	0x2
+
+#define KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL		0x40000004
+#define KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU	0x0
+#define KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_FEATURE	0x1
+#define KVM_DEV_LOONGARCH_EXTIOI_CTRL_LOAD_FINISHED	0x3
+
+#define KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS	        0x40000005
+#define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL	        0x40000006
+#define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT	        0
+
 #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index 887ea50cca..23fb96a8a7 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -315,6 +315,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/mman.h b/linux-headers/asm-mips/mman.h
index 9c48d9a21a..b700dae28c 100644
--- a/linux-headers/asm-mips/mman.h
+++ b/linux-headers/asm-mips/mman.h
@@ -105,6 +105,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index fc93b3be30..9a75719644 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -391,5 +391,9 @@
 #define __NR_lsm_set_self_attr (__NR_Linux + 460)
 #define __NR_lsm_list_modules (__NR_Linux + 461)
 #define __NR_mseal (__NR_Linux + 462)
+#define __NR_setxattrat (__NR_Linux + 463)
+#define __NR_getxattrat (__NR_Linux + 464)
+#define __NR_listxattrat (__NR_Linux + 465)
+#define __NR_removexattrat (__NR_Linux + 466)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index e72a3eb2c9..7086783b0c 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -367,5 +367,9 @@
 #define __NR_lsm_set_self_attr (__NR_Linux + 460)
 #define __NR_lsm_list_modules (__NR_Linux + 461)
 #define __NR_mseal (__NR_Linux + 462)
+#define __NR_setxattrat (__NR_Linux + 463)
+#define __NR_getxattrat (__NR_Linux + 464)
+#define __NR_listxattrat (__NR_Linux + 465)
+#define __NR_removexattrat (__NR_Linux + 466)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index b86eb0786c..b3825823e4 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -437,5 +437,9 @@
 #define __NR_lsm_set_self_attr (__NR_Linux + 460)
 #define __NR_lsm_list_modules (__NR_Linux + 461)
 #define __NR_mseal (__NR_Linux + 462)
+#define __NR_setxattrat (__NR_Linux + 463)
+#define __NR_getxattrat (__NR_Linux + 464)
+#define __NR_listxattrat (__NR_Linux + 465)
+#define __NR_removexattrat (__NR_Linux + 466)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 28627b6546..38ee4dc35d 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -444,6 +444,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 1fc42a8300..5e5f156834 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -416,6 +416,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index e97db32964..3482c9a73d 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -175,6 +175,10 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_ZAWRS,
+	KVM_RISCV_ISA_EXT_SMNPM,
+	KVM_RISCV_ISA_EXT_SSNPM,
+	KVM_RISCV_ISA_EXT_SVADE,
+	KVM_RISCV_ISA_EXT_SVADU,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 9625743dfd..74f6127aed 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -310,6 +310,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index 95bca8ae81..bb6a15a2ec 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -320,6 +320,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 684c4e1205..ab5a6bce59 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -469,7 +469,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 kdsa[16];		/* with MSA9 */
 	__u8 sortl[32];		/* with STFLE.150 */
 	__u8 dfltcc[32];	/* with STFLE.151 */
-	__u8 reserved[1728];
+	__u8 pfcr[16];		/* with STFLE.201 */
+	__u8 reserved[1712];
 };
 
 #define KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST	6
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index 7706c21b87..620201cb36 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -435,5 +435,9 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 62082d592d..e7e4a10aaf 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -383,5 +383,9 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 4711ef2c3d..96589490c4 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -438,6 +438,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_FIX_HYPERCALL_INSN	(1 << 5)
 #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
+#define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
diff --git a/linux-headers/asm-x86/mman.h b/linux-headers/asm-x86/mman.h
index 46cdc941f9..ac1e627721 100644
--- a/linux-headers/asm-x86/mman.h
+++ b/linux-headers/asm-x86/mman.h
@@ -5,9 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-/* Flags for map_shadow_stack(2) */
-#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
-
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index fb7b8b169b..a2eb492a75 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -453,6 +453,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 24c979be54..2f5fc400f5 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -376,6 +376,10 @@
 #define __NR_lsm_set_self_attr 460
 #define __NR_lsm_list_modules 461
 #define __NR_mseal 462
+#define __NR_setxattrat 463
+#define __NR_getxattrat 464
+#define __NR_listxattrat 465
+#define __NR_removexattrat 466
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index c23dd21a2d..fecd832e7f 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -329,6 +329,10 @@
 #define __NR_lsm_set_self_attr (__X32_SYSCALL_BIT + 460)
 #define __NR_lsm_list_modules (__X32_SYSCALL_BIT + 461)
 #define __NR_mseal (__X32_SYSCALL_BIT + 462)
+#define __NR_setxattrat (__X32_SYSCALL_BIT + 463)
+#define __NR_getxattrat (__X32_SYSCALL_BIT + 464)
+#define __NR_listxattrat (__X32_SYSCALL_BIT + 465)
+#define __NR_removexattrat (__X32_SYSCALL_BIT + 466)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 782baf477f..37aae16502 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -51,6 +51,10 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
+	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
+	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 };
 
 /**
@@ -213,6 +217,30 @@ struct iommu_ioas_map {
 };
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
+/**
+ * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
+ * @size: sizeof(struct iommu_ioas_map_file)
+ * @flags: same as for iommu_ioas_map
+ * @ioas_id: same as for iommu_ioas_map
+ * @fd: the memfd to map
+ * @start: byte offset from start of file to map from
+ * @length: same as for iommu_ioas_map
+ * @iova: same as for iommu_ioas_map
+ *
+ * Set an IOVA mapping from a memfd file.  All other arguments and semantics
+ * match those of IOMMU_IOAS_MAP.
+ */
+struct iommu_ioas_map_file {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__s32 fd;
+	__aligned_u64 start;
+	__aligned_u64 length;
+	__aligned_u64 iova;
+};
+#define IOMMU_IOAS_MAP_FILE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP_FILE)
+
 /**
  * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
  * @size: sizeof(struct iommu_ioas_copy)
@@ -359,11 +387,19 @@ struct iommu_vfio_ioas {
  *                                   enforced on device attachment
  * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
  *                             valid.
+ * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
+ *                          domain can be attached to any PASID on the device.
+ *                          Any domain attached to the non-PASID part of the
+ *                          device must also be flaged, otherwise attaching a
+ *                          PASID will blocked.
+ *                          If IOMMU does not support PASID it will return
+ *                          error (-EOPNOTSUPP).
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
 	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
+	IOMMU_HWPT_ALLOC_PASID = 1 << 3,
 };
 
 /**
@@ -394,14 +430,36 @@ struct iommu_hwpt_vtd_s1 {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 nested STE
+ *                                (IOMMU_HWPT_DATA_ARM_SMMUV3)
+ *
+ * @ste: The first two double words of the user space Stream Table Entry for
+ *       the translation. Must be little-endian.
+ *       Allowed fields: (Refer to "5.2 Stream Table Entry" in SMMUv3 HW Spec)
+ *       - word-0: V, Cfg, S1Fmt, S1ContextPtr, S1CDMax
+ *       - word-1: EATS, S1DSS, S1CIR, S1COR, S1CSH, S1STALLD
+ *
+ * -EIO will be returned if @ste is not legal or contains any non-allowed field.
+ * Cfg can be used to select a S1, Bypass or Abort configuration. A Bypass
+ * nested domain will translate the same as the nesting parent. The S1 will
+ * install a Context Descriptor Table pointing at userspace memory translated
+ * by the nesting parent.
+ */
+struct iommu_hwpt_arm_smmuv3 {
+	__aligned_le64 ste[2];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
+ * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
+	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
 };
 
 /**
@@ -409,7 +467,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or vIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -428,11 +486,13 @@ enum iommu_hwpt_data_type {
  * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
  * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
  *
- * A user-managed nested HWPT will be created from a given parent HWPT via
- * @pt_id, in which the parent HWPT must be allocated previously via the
- * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
- * must be set to a pre-defined type corresponding to an I/O page table
- * type supported by the underlying IOMMU hardware.
+ * A user-managed nested HWPT will be created from a given vIOMMU (wrapping a
+ * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
+ * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
+ * case, the @data_type must be set to a pre-defined type corresponding to an
+ * I/O page table type supported by the underlying IOMMU hardware. The device
+ * via @dev_id and the vIOMMU via @pt_id must be associated to the same IOMMU
+ * instance.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
@@ -484,15 +544,50 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
+ *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
+ *
+ * @flags: Must be set to 0
+ * @__reserved: Must be 0
+ * @idr: Implemented features for ARM SMMU Non-secure programming interface
+ * @iidr: Information about the implementation and implementer of ARM SMMU,
+ *        and architecture version supported
+ * @aidr: ARM SMMU architecture version
+ *
+ * For the details of @idr, @iidr and @aidr, please refer to the chapters
+ * from 6.3.1 to 6.3.6 in the SMMUv3 Spec.
+ *
+ * User space should read the underlying ARM SMMUv3 hardware information for
+ * the list of supported features.
+ *
+ * Note that these values reflect the raw HW capability, without any insight if
+ * any required kernel driver support is present. Bits may be set indicating the
+ * HW has functionality that is lacking kernel software support, such as BTM. If
+ * a VMM is using this information to construct emulated copies of these
+ * registers it should only forward bits that it knows it can support.
+ *
+ * In future, presence of required kernel support will be indicated in flags.
+ */
+struct iommu_hw_info_arm_smmuv3 {
+	__u32 flags;
+	__u32 __reserved;
+	__u32 idr[6];
+	__u32 iidr;
+	__u32 aidr;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
  *                           info
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
+ * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
+	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 };
 
 /**
@@ -627,9 +722,11 @@ struct iommu_hwpt_get_dirty_bitmap {
  * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
+	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 = 1,
 };
 
 /**
@@ -668,10 +765,32 @@ struct iommu_hwpt_vtd_s1_invalidate {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
+ * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
+ *       Must be little-endian.
+ *
+ * Supported command list only when passing in a vIOMMU via @hwpt_id:
+ *     CMDQ_OP_TLBI_NSNH_ALL
+ *     CMDQ_OP_TLBI_NH_VA
+ *     CMDQ_OP_TLBI_NH_VAA
+ *     CMDQ_OP_TLBI_NH_ALL
+ *     CMDQ_OP_TLBI_NH_ASID
+ *     CMDQ_OP_ATC_INV
+ *     CMDQ_OP_CFGI_CD
+ *     CMDQ_OP_CFGI_CD_ALL
+ *
+ * -EIO will be returned if the command is not supported.
+ */
+struct iommu_viommu_arm_smmuv3_invalidate {
+	__aligned_le64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
- * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @hwpt_id: ID of a nested HWPT or a vIOMMU, for cache invalidation
  * @data_uptr: User pointer to an array of driver-specific cache invalidation
  *             data.
  * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
@@ -682,8 +801,11 @@ struct iommu_hwpt_vtd_s1_invalidate {
  *             Output the number of requests successfully handled by kernel.
  * @__reserved: Must be 0.
  *
- * Invalidate the iommu cache for user-managed page table. Modifications on a
- * user-managed page table should be followed by this operation to sync cache.
+ * Invalidate iommu cache for user-managed page table or vIOMMU. Modifications
+ * on a user-managed page table should be followed by this operation, if a HWPT
+ * is passed in via @hwpt_id. Other caches, such as device cache or descriptor
+ * cache can be flushed if a vIOMMU is passed in via the @hwpt_id field.
+ *
  * Each ioctl can support one or more cache invalidation requests in the array
  * that has a total size of @entry_len * @entry_num.
  *
@@ -797,4 +919,88 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * enum iommu_viommu_type - Virtual IOMMU Type
+ * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
+	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+};
+
+/**
+ * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
+ * @size: sizeof(struct iommu_viommu_alloc)
+ * @flags: Must be 0
+ * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
+ * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
+ * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ *
+ * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
+ * virtualization support that is a security-isolated slice of the real IOMMU HW
+ * that is unique to a specific VM. Operations global to the IOMMU are connected
+ * to the vIOMMU, such as:
+ * - Security namespace for guest owned ID, e.g. guest-controlled cache tags
+ * - Non-device-affiliated event reporting, e.g. invalidation queue errors
+ * - Access to a sharable nesting parent pagetable across physical IOMMUs
+ * - Virtualization of various platforms IDs, e.g. RIDs and others
+ * - Delivery of paravirtualized invalidation
+ * - Direct assigned invalidation queues
+ * - Direct assigned interrupts
+ */
+struct iommu_viommu_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 type;
+	__u32 dev_id;
+	__u32 hwpt_id;
+	__u32 out_viommu_id;
+};
+#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
+ * @size: sizeof(struct iommu_vdevice_alloc)
+ * @viommu_id: vIOMMU ID to associate with the virtual device
+ * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
+ * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
+ * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
+ *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+ *
+ * Allocate a virtual device instance (for a physical device) against a vIOMMU.
+ * This instance holds the device's information (related to its vIOMMU) in a VM.
+ */
+struct iommu_vdevice_alloc {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 out_vdevice_id;
+	__aligned_u64 virt_id;
+};
+#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
+
+/**
+ * struct iommu_ioas_change_process - ioctl(VFIO_IOAS_CHANGE_PROCESS)
+ * @size: sizeof(struct iommu_ioas_change_process)
+ * @__reserved: Must be 0
+ *
+ * This transfers pinned memory counts for every memory map in every IOAS
+ * in the context to the current process.  This only supports maps created
+ * with IOMMU_IOAS_MAP_FILE, and returns EINVAL if other maps are present.
+ * If the ioctl returns a failure status, then nothing is changed.
+ *
+ * This API is useful for transferring operation of a device from one process
+ * to another, such as during userland live update.
+ */
+struct iommu_ioas_change_process {
+	__u32 size;
+	__u32 __reserved;
+};
+
+#define IOMMU_IOAS_CHANGE_PROCESS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
+
 #endif
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 49dd1b30ce..3bcd4eabe3 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1150,7 +1150,15 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_RISCV_AIA,
 #define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
+	KVM_DEV_TYPE_LOONGARCH_IPI,
+#define KVM_DEV_TYPE_LOONGARCH_IPI	KVM_DEV_TYPE_LOONGARCH_IPI
+	KVM_DEV_TYPE_LOONGARCH_EIOINTC,
+#define KVM_DEV_TYPE_LOONGARCH_EIOINTC	KVM_DEV_TYPE_LOONGARCH_EIOINTC
+	KVM_DEV_TYPE_LOONGARCH_PCHPIC,
+#define KVM_DEV_TYPE_LOONGARCH_PCHPIC	KVM_DEV_TYPE_LOONGARCH_PCHPIC
+
 	KVM_DEV_TYPE_MAX,
+
 };
 
 struct kvm_vfio_spapr_tce {
diff --git a/linux-headers/linux/psci.h b/linux-headers/linux/psci.h
index 74f3cb5007..a982afd498 100644
--- a/linux-headers/linux/psci.h
+++ b/linux-headers/linux/psci.h
@@ -59,6 +59,7 @@
 #define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
 #define PSCI_1_1_FN_MEM_PROTECT			PSCI_0_2_FN(19)
 #define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN(20)
+#define PSCI_1_3_FN_SYSTEM_OFF2			PSCI_0_2_FN(21)
 
 #define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND	PSCI_0_2_FN64(12)
 #define PSCI_1_0_FN64_NODE_HW_STATE		PSCI_0_2_FN64(13)
@@ -68,6 +69,7 @@
 
 #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 #define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN64(20)
+#define PSCI_1_3_FN64_SYSTEM_OFF2		PSCI_0_2_FN64(21)
 
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
@@ -100,6 +102,9 @@
 #define PSCI_1_1_RESET_TYPE_SYSTEM_WARM_RESET	0
 #define PSCI_1_1_RESET_TYPE_VENDOR_START	0x80000000U
 
+/* PSCI v1.3 hibernate type for SYSTEM_OFF2 */
+#define PSCI_1_3_OFF_TYPE_HIBERNATE_OFF		BIT(0)
+
 /* PSCI version decoding (independent of PSCI version) */
 #define PSCI_VERSION_MAJOR_SHIFT		16
 #define PSCI_VERSION_MINOR_MASK			\
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index b4be37b225..1b5e254d6a 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -35,7 +35,7 @@
 #define VFIO_EEH			5
 
 /* Two-stage IOMMU */
-#define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
+#define __VFIO_RESERVED_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
 
 #define VFIO_SPAPR_TCE_v2_IOMMU		7
 
-- 
2.43.5


