Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663C974F0AE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 15:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJDlE-0000AO-6F; Tue, 11 Jul 2023 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1qJDlA-0000AB-0s
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 09:50:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1qJDl4-00059C-S0
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 09:50:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36BDdhRZ028548; Tue, 11 Jul 2023 13:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fZ4/EHOzd83JqpRzESur7ec3Q2pGbJNTIt2YcRTPq50=;
 b=RzTWHLgCjFNwlXIuxmh9PbCLSiSrI24qT1k3ezWcVTlIKmZ7q/cVMWCiEcRITpOFaQMz
 FYfAHdvCOMxahIVAP7RqvWJj3GLq+Qvwh/jZQjBEKew7eCUKXio+bF/T65xyFOLV01rL
 u/l5YfeBUFziAT0a+8ZMdhDQXFl9TQnF8JRJ4OKBSkQf6ikm2g/s7t+bsH5K/gpPSMLn
 HnHiCJEk0OIHZxpS0E4SdRCys7ulN8EUU7+ally6s01N9waxu4/eYMPhZgnFVGxmb9Qb
 1ZEDDMV0GaYiquELJIeSvjJcjQhMV/hmqnJN0jsPyqpgYxD60Hbf7PDdq+fYgKGM9I7L tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs7w518wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jul 2023 13:49:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BDeWtC001344;
 Tue, 11 Jul 2023 13:49:19 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs7w518w3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jul 2023 13:49:19 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BCeZK0017144;
 Tue, 11 Jul 2023 13:49:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3rpye6ya8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jul 2023 13:49:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36BDnGUx27591044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jul 2023 13:49:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3CB35803F;
 Tue, 11 Jul 2023 13:49:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 257545805A;
 Tue, 11 Jul 2023 13:49:16 +0000 (GMT)
Received: from [9.61.158.95] (unknown [9.61.158.95])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Jul 2023 13:49:16 +0000 (GMT)
Message-ID: <cd071889-5ec2-a4e3-af26-a9bfcbccffd4@linux.ibm.com>
Date: Tue, 11 Jul 2023 09:49:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] linux-headers: update to v6.5-rc1
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20230709212308.370699-1-clg@redhat.com>
 <20230709212308.370699-2-clg@redhat.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20230709212308.370699-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pioAJRk2msuqlAn_2ZBDq478zYu2rDlI
X-Proofpoint-GUID: zu_SyZOZwFiSj572loRjb_oQDBejeQch
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110123
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For the vfio-ap bus driver IRQ index mapping:
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>



On 7/9/23 5:23 PM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/standard-headers/drm/drm_fourcc.h     |  43 ++++++
>   include/standard-headers/linux/const.h        |   2 +-
>   include/standard-headers/linux/pci_regs.h     |   1 +
>   include/standard-headers/linux/vhost_types.h  |  16 +++
>   include/standard-headers/linux/virtio_blk.h   |  18 +--
>   .../standard-headers/linux/virtio_config.h    |   6 +
>   include/standard-headers/linux/virtio_net.h   |   1 +
>   linux-headers/asm-arm64/bitsperlong.h         |  23 ---
>   linux-headers/asm-arm64/kvm.h                 |  33 +++++
>   linux-headers/asm-generic/bitsperlong.h       |  13 +-
>   linux-headers/asm-generic/unistd.h            | 134 +++++-------------
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/bitsperlong.h         |  13 --
>   linux-headers/asm-riscv/kvm.h                 | 134 +++++++++++++++++-
>   linux-headers/asm-riscv/unistd.h              |   9 ++
>   linux-headers/asm-s390/unistd_32.h            |   2 +
>   linux-headers/asm-s390/unistd_64.h            |   2 +
>   linux-headers/asm-x86/kvm.h                   |   3 +
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/const.h                   |   2 +-
>   linux-headers/linux/kvm.h                     |  18 ++-
>   linux-headers/linux/mman.h                    |  14 ++
>   linux-headers/linux/psp-sev.h                 |   7 +
>   linux-headers/linux/userfaultfd.h             |  17 ++-
>   linux-headers/linux/vfio.h                    |  27 ++++
>   linux-headers/linux/vhost.h                   |  31 ++++
>   32 files changed, 423 insertions(+), 154 deletions(-)
> 
> diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
> index dc3e6112c11c..72279f4d25d4 100644
> --- a/include/standard-headers/drm/drm_fourcc.h
> +++ b/include/standard-headers/drm/drm_fourcc.h
> @@ -656,6 +656,49 @@ extern "C" {
>    */
>   #define I915_FORMAT_MOD_4_TILED_DG2_RC_CCS_CC fourcc_mod_code(INTEL, 12)
>   
> +/*
> + * Intel Color Control Surfaces (CCS) for display ver. 14 render compression.
> + *
> + * The main surface is tile4 and at plane index 0, the CCS is linear and
> + * at index 1. A 64B CCS cache line corresponds to an area of 4x1 tiles in
> + * main surface. In other words, 4 bits in CCS map to a main surface cache
> + * line pair. The main surface pitch is required to be a multiple of four
> + * tile4 widths.
> + */
> +#define I915_FORMAT_MOD_4_TILED_MTL_RC_CCS fourcc_mod_code(INTEL, 13)
> +
> +/*
> + * Intel Color Control Surfaces (CCS) for display ver. 14 media compression
> + *
> + * The main surface is tile4 and at plane index 0, the CCS is linear and
> + * at index 1. A 64B CCS cache line corresponds to an area of 4x1 tiles in
> + * main surface. In other words, 4 bits in CCS map to a main surface cache
> + * line pair. The main surface pitch is required to be a multiple of four
> + * tile4 widths. For semi-planar formats like NV12, CCS planes follow the
> + * Y and UV planes i.e., planes 0 and 1 are used for Y and UV surfaces,
> + * planes 2 and 3 for the respective CCS.
> + */
> +#define I915_FORMAT_MOD_4_TILED_MTL_MC_CCS fourcc_mod_code(INTEL, 14)
> +
> +/*
> + * Intel Color Control Surface with Clear Color (CCS) for display ver. 14 render
> + * compression.
> + *
> + * The main surface is tile4 and is at plane index 0 whereas CCS is linear
> + * and at index 1. The clear color is stored at index 2, and the pitch should
> + * be ignored. The clear color structure is 256 bits. The first 128 bits
> + * represents Raw Clear Color Red, Green, Blue and Alpha color each represented
> + * by 32 bits. The raw clear color is consumed by the 3d engine and generates
> + * the converted clear color of size 64 bits. The first 32 bits store the Lower
> + * Converted Clear Color value and the next 32 bits store the Higher Converted
> + * Clear Color value when applicable. The Converted Clear Color values are
> + * consumed by the DE. The last 64 bits are used to store Color Discard Enable
> + * and Depth Clear Value Valid which are ignored by the DE. A CCS cache line
> + * corresponds to an area of 4x1 tiles in the main surface. The main surface
> + * pitch is required to be a multiple of 4 tile widths.
> + */
> +#define I915_FORMAT_MOD_4_TILED_MTL_RC_CCS_CC fourcc_mod_code(INTEL, 15)
> +
>   /*
>    * Tiled, NV12MT, grouped in 64 (pixels) x 32 (lines) -sized macroblocks
>    *
> diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
> index 5e4898725168..1eb84b5087f8 100644
> --- a/include/standard-headers/linux/const.h
> +++ b/include/standard-headers/linux/const.h
> @@ -28,7 +28,7 @@
>   #define _BITUL(x)	(_UL(1) << (x))
>   #define _BITULL(x)	(_ULL(1) << (x))
>   
> -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>   #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>   
>   #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index dc2000e0fe3a..e5f558d96493 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -738,6 +738,7 @@
>   #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>   #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>   #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>   #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>   
> diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
> index 88600e2d9f19..6691a3ce24d6 100644
> --- a/include/standard-headers/linux/vhost_types.h
> +++ b/include/standard-headers/linux/vhost_types.h
> @@ -47,6 +47,22 @@ struct vhost_vring_addr {
>   	uint64_t log_guest_addr;
>   };
>   
> +struct vhost_worker_state {
> +	/*
> +	 * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
> +	 * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
> +	 * to free.
> +	 */
> +	unsigned int worker_id;
> +};
> +
> +struct vhost_vring_worker {
> +	/* vring index */
> +	unsigned int index;
> +	/* The id of the vhost_worker returned from VHOST_NEW_WORKER */
> +	unsigned int worker_id;
> +};
> +
>   /* no alignment requirement */
>   struct vhost_iotlb_msg {
>   	uint64_t iova;
> diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
> index 7155b1a4701b..d7be3cf5e42f 100644
> --- a/include/standard-headers/linux/virtio_blk.h
> +++ b/include/standard-headers/linux/virtio_blk.h
> @@ -138,11 +138,11 @@ struct virtio_blk_config {
>   
>   	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
>   	struct virtio_blk_zoned_characteristics {
> -		uint32_t zone_sectors;
> -		uint32_t max_open_zones;
> -		uint32_t max_active_zones;
> -		uint32_t max_append_sectors;
> -		uint32_t write_granularity;
> +		__virtio32 zone_sectors;
> +		__virtio32 max_open_zones;
> +		__virtio32 max_active_zones;
> +		__virtio32 max_append_sectors;
> +		__virtio32 write_granularity;
>   		uint8_t model;
>   		uint8_t unused2[3];
>   	} zoned;
> @@ -239,11 +239,11 @@ struct virtio_blk_outhdr {
>    */
>   struct virtio_blk_zone_descriptor {
>   	/* Zone capacity */
> -	uint64_t z_cap;
> +	__virtio64 z_cap;
>   	/* The starting sector of the zone */
> -	uint64_t z_start;
> +	__virtio64 z_start;
>   	/* Zone write pointer position in sectors */
> -	uint64_t z_wp;
> +	__virtio64 z_wp;
>   	/* Zone type */
>   	uint8_t z_type;
>   	/* Zone state */
> @@ -252,7 +252,7 @@ struct virtio_blk_zone_descriptor {
>   };
>   
>   struct virtio_blk_zone_report {
> -	uint64_t nr_zones;
> +	__virtio64 nr_zones;
>   	uint8_t reserved[56];
>   	struct virtio_blk_zone_descriptor zones[];
>   };
> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
> index 965ee6ae237e..8a7d0dc8b007 100644
> --- a/include/standard-headers/linux/virtio_config.h
> +++ b/include/standard-headers/linux/virtio_config.h
> @@ -97,6 +97,12 @@
>    */
>   #define VIRTIO_F_SR_IOV			37
>   
> +/*
> + * This feature indicates that the driver passes extra data (besides
> + * identifying the virtqueue) in its device notifications.
> + */
> +#define VIRTIO_F_NOTIFICATION_DATA	38
> +
>   /*
>    * This feature indicates that the driver can reset a queue individually.
>    */
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index c0e797067aae..2325485f2ca8 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -61,6 +61,7 @@
>   #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>   #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
>   #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
>   #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>   #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>   #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> diff --git a/linux-headers/asm-arm64/bitsperlong.h b/linux-headers/asm-arm64/bitsperlong.h
> index 485d60bee26c..6dc0bb0c13b2 100644
> --- a/linux-headers/asm-arm64/bitsperlong.h
> +++ b/linux-headers/asm-arm64/bitsperlong.h
> @@ -1,24 +1 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -#ifndef __ASM_BITSPERLONG_H
> -#define __ASM_BITSPERLONG_H
> -
> -#define __BITS_PER_LONG 64
> -
>   #include <asm-generic/bitsperlong.h>
> -
> -#endif	/* __ASM_BITSPERLONG_H */
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index d7e7bb885e20..38e5957526c2 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -198,6 +198,15 @@ struct kvm_arm_copy_mte_tags {
>   	__u64 reserved[2];
>   };
>   
> +/*
> + * Counter/Timer offset structure. Describe the virtual/physical offset.
> + * To be used with KVM_ARM_SET_COUNTER_OFFSET.
> + */
> +struct kvm_arm_counter_offset {
> +	__u64 counter_offset;
> +	__u64 reserved;
> +};
> +
>   #define KVM_ARM_TAGS_TO_GUEST		0
>   #define KVM_ARM_TAGS_FROM_GUEST		1
>   
> @@ -363,6 +372,10 @@ enum {
>   	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
>   };
>   
> +/* Device Control API on vm fd */
> +#define KVM_ARM_VM_SMCCC_CTRL		0
> +#define   KVM_ARM_VM_SMCCC_FILTER	0
> +
>   /* Device Control API: ARM VGIC */
>   #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
>   #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> @@ -402,6 +415,8 @@ enum {
>   #define KVM_ARM_VCPU_TIMER_CTRL		1
>   #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
>   #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
> +#define   KVM_ARM_VCPU_TIMER_IRQ_HVTIMER	2
> +#define   KVM_ARM_VCPU_TIMER_IRQ_HPTIMER	3
>   #define KVM_ARM_VCPU_PVTIME_CTRL	2
>   #define   KVM_ARM_VCPU_PVTIME_IPA	0
>   
> @@ -458,6 +473,24 @@ enum {
>   /* run->fail_entry.hardware_entry_failure_reason codes. */
>   #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED	(1ULL << 0)
>   
> +enum kvm_smccc_filter_action {
> +	KVM_SMCCC_FILTER_HANDLE = 0,
> +	KVM_SMCCC_FILTER_DENY,
> +	KVM_SMCCC_FILTER_FWD_TO_USER,
> +
> +};
> +
> +struct kvm_smccc_filter {
> +	__u32 base;
> +	__u32 nr_functions;
> +	__u8 action;
> +	__u8 pad[15];
> +};
> +
> +/* arm64-specific KVM_EXIT_HYPERCALL flags */
> +#define KVM_HYPERCALL_EXIT_SMC		(1U << 0)
> +#define KVM_HYPERCALL_EXIT_16BIT	(1U << 1)
> +
>   #endif
>   
>   #endif /* __ARM_KVM_H__ */
> diff --git a/linux-headers/asm-generic/bitsperlong.h b/linux-headers/asm-generic/bitsperlong.h
> index 0aac245b6bd7..75f320fa91e5 100644
> --- a/linux-headers/asm-generic/bitsperlong.h
> +++ b/linux-headers/asm-generic/bitsperlong.h
> @@ -2,6 +2,17 @@
>   #ifndef __ASM_GENERIC_BITS_PER_LONG
>   #define __ASM_GENERIC_BITS_PER_LONG
>   
> +#ifndef __BITS_PER_LONG
> +/*
> + * In order to keep safe and avoid regression, only unify uapi
> + * bitsperlong.h for some archs which are using newer toolchains
> + * that have the definitions of __CHAR_BIT__ and __SIZEOF_LONG__.
> + * See the following link for more info:
> + * https://lore.kernel.org/linux-arch/b9624545-2c80-49a1-ac3c-39264a591f7b@app.fastmail.com/
> + */
> +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> +#define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
> +#else
>   /*
>    * There seems to be no way of detecting this automatically from user
>    * space, so 64 bit architectures should override this in their
> @@ -9,8 +20,8 @@
>    * both 32 and 64 bit user space must not rely on CONFIG_64BIT
>    * to decide it, but rather check a compiler provided macro.
>    */
> -#ifndef __BITS_PER_LONG
>   #define __BITS_PER_LONG 32
>   #endif
> +#endif
>   
>   #endif /* __ASM_GENERIC_BITS_PER_LONG */
> diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
> index 45fa180cc56a..fd6c1cb585db 100644
> --- a/linux-headers/asm-generic/unistd.h
> +++ b/linux-headers/asm-generic/unistd.h
> @@ -38,12 +38,12 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
>   __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
>   #define __NR_io_cancel 3
>   __SYSCALL(__NR_io_cancel, sys_io_cancel)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_io_getevents 4
>   __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
>   #endif
>   
> -/* fs/xattr.c */
>   #define __NR_setxattr 5
>   __SYSCALL(__NR_setxattr, sys_setxattr)
>   #define __NR_lsetxattr 6
> @@ -68,58 +68,38 @@ __SYSCALL(__NR_removexattr, sys_removexattr)
>   __SYSCALL(__NR_lremovexattr, sys_lremovexattr)
>   #define __NR_fremovexattr 16
>   __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
> -
> -/* fs/dcache.c */
>   #define __NR_getcwd 17
>   __SYSCALL(__NR_getcwd, sys_getcwd)
> -
> -/* fs/cookies.c */
>   #define __NR_lookup_dcookie 18
>   __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
> -
> -/* fs/eventfd.c */
>   #define __NR_eventfd2 19
>   __SYSCALL(__NR_eventfd2, sys_eventfd2)
> -
> -/* fs/eventpoll.c */
>   #define __NR_epoll_create1 20
>   __SYSCALL(__NR_epoll_create1, sys_epoll_create1)
>   #define __NR_epoll_ctl 21
>   __SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
>   #define __NR_epoll_pwait 22
>   __SC_COMP(__NR_epoll_pwait, sys_epoll_pwait, compat_sys_epoll_pwait)
> -
> -/* fs/fcntl.c */
>   #define __NR_dup 23
>   __SYSCALL(__NR_dup, sys_dup)
>   #define __NR_dup3 24
>   __SYSCALL(__NR_dup3, sys_dup3)
>   #define __NR3264_fcntl 25
>   __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
> -
> -/* fs/inotify_user.c */
>   #define __NR_inotify_init1 26
>   __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
>   #define __NR_inotify_add_watch 27
>   __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
>   #define __NR_inotify_rm_watch 28
>   __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
> -
> -/* fs/ioctl.c */
>   #define __NR_ioctl 29
>   __SC_COMP(__NR_ioctl, sys_ioctl, compat_sys_ioctl)
> -
> -/* fs/ioprio.c */
>   #define __NR_ioprio_set 30
>   __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
>   #define __NR_ioprio_get 31
>   __SYSCALL(__NR_ioprio_get, sys_ioprio_get)
> -
> -/* fs/locks.c */
>   #define __NR_flock 32
>   __SYSCALL(__NR_flock, sys_flock)
> -
> -/* fs/namei.c */
>   #define __NR_mknodat 33
>   __SYSCALL(__NR_mknodat, sys_mknodat)
>   #define __NR_mkdirat 34
> @@ -130,25 +110,21 @@ __SYSCALL(__NR_unlinkat, sys_unlinkat)
>   __SYSCALL(__NR_symlinkat, sys_symlinkat)
>   #define __NR_linkat 37
>   __SYSCALL(__NR_linkat, sys_linkat)
> +
>   #ifdef __ARCH_WANT_RENAMEAT
>   /* renameat is superseded with flags by renameat2 */
>   #define __NR_renameat 38
>   __SYSCALL(__NR_renameat, sys_renameat)
>   #endif /* __ARCH_WANT_RENAMEAT */
>   
> -/* fs/namespace.c */
>   #define __NR_umount2 39
>   __SYSCALL(__NR_umount2, sys_umount)
>   #define __NR_mount 40
>   __SYSCALL(__NR_mount, sys_mount)
>   #define __NR_pivot_root 41
>   __SYSCALL(__NR_pivot_root, sys_pivot_root)
> -
> -/* fs/nfsctl.c */
>   #define __NR_nfsservctl 42
>   __SYSCALL(__NR_nfsservctl, sys_ni_syscall)
> -
> -/* fs/open.c */
>   #define __NR3264_statfs 43
>   __SC_COMP_3264(__NR3264_statfs, sys_statfs64, sys_statfs, \
>   	       compat_sys_statfs64)
> @@ -161,7 +137,6 @@ __SC_COMP_3264(__NR3264_truncate, sys_truncate64, sys_truncate, \
>   #define __NR3264_ftruncate 46
>   __SC_COMP_3264(__NR3264_ftruncate, sys_ftruncate64, sys_ftruncate, \
>   	       compat_sys_ftruncate64)
> -
>   #define __NR_fallocate 47
>   __SC_COMP(__NR_fallocate, sys_fallocate, compat_sys_fallocate)
>   #define __NR_faccessat 48
> @@ -186,20 +161,12 @@ __SYSCALL(__NR_openat, sys_openat)
>   __SYSCALL(__NR_close, sys_close)
>   #define __NR_vhangup 58
>   __SYSCALL(__NR_vhangup, sys_vhangup)
> -
> -/* fs/pipe.c */
>   #define __NR_pipe2 59
>   __SYSCALL(__NR_pipe2, sys_pipe2)
> -
> -/* fs/quota.c */
>   #define __NR_quotactl 60
>   __SYSCALL(__NR_quotactl, sys_quotactl)
> -
> -/* fs/readdir.c */
>   #define __NR_getdents64 61
>   __SYSCALL(__NR_getdents64, sys_getdents64)
> -
> -/* fs/read_write.c */
>   #define __NR3264_lseek 62
>   __SC_3264(__NR3264_lseek, sys_llseek, sys_lseek)
>   #define __NR_read 63
> @@ -218,12 +185,9 @@ __SC_COMP(__NR_pwrite64, sys_pwrite64, compat_sys_pwrite64)
>   __SC_COMP(__NR_preadv, sys_preadv, compat_sys_preadv)
>   #define __NR_pwritev 70
>   __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
> -
> -/* fs/sendfile.c */
>   #define __NR3264_sendfile 71
>   __SYSCALL(__NR3264_sendfile, sys_sendfile64)
>   
> -/* fs/select.c */
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_pselect6 72
>   __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
> @@ -231,21 +195,17 @@ __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_psel
>   __SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
>   #endif
>   
> -/* fs/signalfd.c */
>   #define __NR_signalfd4 74
>   __SC_COMP(__NR_signalfd4, sys_signalfd4, compat_sys_signalfd4)
> -
> -/* fs/splice.c */
>   #define __NR_vmsplice 75
>   __SYSCALL(__NR_vmsplice, sys_vmsplice)
>   #define __NR_splice 76
>   __SYSCALL(__NR_splice, sys_splice)
>   #define __NR_tee 77
>   __SYSCALL(__NR_tee, sys_tee)
> -
> -/* fs/stat.c */
>   #define __NR_readlinkat 78
>   __SYSCALL(__NR_readlinkat, sys_readlinkat)
> +
>   #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>   #define __NR3264_fstatat 79
>   __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
> @@ -253,13 +213,13 @@ __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
>   __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
>   #endif
>   
> -/* fs/sync.c */
>   #define __NR_sync 81
>   __SYSCALL(__NR_sync, sys_sync)
>   #define __NR_fsync 82
>   __SYSCALL(__NR_fsync, sys_fsync)
>   #define __NR_fdatasync 83
>   __SYSCALL(__NR_fdatasync, sys_fdatasync)
> +
>   #ifdef __ARCH_WANT_SYNC_FILE_RANGE2
>   #define __NR_sync_file_range2 84
>   __SC_COMP(__NR_sync_file_range2, sys_sync_file_range2, \
> @@ -270,9 +230,9 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
>   	  compat_sys_sync_file_range)
>   #endif
>   
> -/* fs/timerfd.c */
>   #define __NR_timerfd_create 85
>   __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_timerfd_settime 86
>   __SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
> @@ -282,45 +242,35 @@ __SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
>   	  sys_timerfd_gettime)
>   #endif
>   
> -/* fs/utimes.c */
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_utimensat 88
>   __SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
>   #endif
>   
> -/* kernel/acct.c */
>   #define __NR_acct 89
>   __SYSCALL(__NR_acct, sys_acct)
> -
> -/* kernel/capability.c */
>   #define __NR_capget 90
>   __SYSCALL(__NR_capget, sys_capget)
>   #define __NR_capset 91
>   __SYSCALL(__NR_capset, sys_capset)
> -
> -/* kernel/exec_domain.c */
>   #define __NR_personality 92
>   __SYSCALL(__NR_personality, sys_personality)
> -
> -/* kernel/exit.c */
>   #define __NR_exit 93
>   __SYSCALL(__NR_exit, sys_exit)
>   #define __NR_exit_group 94
>   __SYSCALL(__NR_exit_group, sys_exit_group)
>   #define __NR_waitid 95
>   __SC_COMP(__NR_waitid, sys_waitid, compat_sys_waitid)
> -
> -/* kernel/fork.c */
>   #define __NR_set_tid_address 96
>   __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
>   #define __NR_unshare 97
>   __SYSCALL(__NR_unshare, sys_unshare)
>   
> -/* kernel/futex.c */
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_futex 98
>   __SC_3264(__NR_futex, sys_futex_time32, sys_futex)
>   #endif
> +
>   #define __NR_set_robust_list 99
>   __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
>   	  compat_sys_set_robust_list)
> @@ -328,43 +278,40 @@ __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
>   __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
>   	  compat_sys_get_robust_list)
>   
> -/* kernel/hrtimer.c */
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_nanosleep 101
>   __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
>   #endif
>   
> -/* kernel/itimer.c */
>   #define __NR_getitimer 102
>   __SC_COMP(__NR_getitimer, sys_getitimer, compat_sys_getitimer)
>   #define __NR_setitimer 103
>   __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
> -
> -/* kernel/kexec.c */
>   #define __NR_kexec_load 104
>   __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
> -
> -/* kernel/module.c */
>   #define __NR_init_module 105
>   __SYSCALL(__NR_init_module, sys_init_module)
>   #define __NR_delete_module 106
>   __SYSCALL(__NR_delete_module, sys_delete_module)
> -
> -/* kernel/posix-timers.c */
>   #define __NR_timer_create 107
>   __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_timer_gettime 108
>   __SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
>   #endif
> +
>   #define __NR_timer_getoverrun 109
>   __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_timer_settime 110
>   __SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
>   #endif
> +
>   #define __NR_timer_delete 111
>   __SYSCALL(__NR_timer_delete, sys_timer_delete)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_clock_settime 112
>   __SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
> @@ -377,15 +324,10 @@ __SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
>   	  sys_clock_nanosleep)
>   #endif
>   
> -/* kernel/printk.c */
>   #define __NR_syslog 116
>   __SYSCALL(__NR_syslog, sys_syslog)
> -
> -/* kernel/ptrace.c */
>   #define __NR_ptrace 117
>   __SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
> -
> -/* kernel/sched/core.c */
>   #define __NR_sched_setparam 118
>   __SYSCALL(__NR_sched_setparam, sys_sched_setparam)
>   #define __NR_sched_setscheduler 119
> @@ -406,13 +348,13 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
>   __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
>   #define __NR_sched_get_priority_min 126
>   __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_sched_rr_get_interval 127
>   __SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
>   	  sys_sched_rr_get_interval)
>   #endif
>   
> -/* kernel/signal.c */
>   #define __NR_restart_syscall 128
>   __SYSCALL(__NR_restart_syscall, sys_restart_syscall)
>   #define __NR_kill 129
> @@ -431,18 +373,18 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
>   __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
>   #define __NR_rt_sigpending 136
>   __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_rt_sigtimedwait 137
>   __SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
>   	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
>   #endif
> +
>   #define __NR_rt_sigqueueinfo 138
>   __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
>   	  compat_sys_rt_sigqueueinfo)
>   #define __NR_rt_sigreturn 139
>   __SC_COMP(__NR_rt_sigreturn, sys_rt_sigreturn, compat_sys_rt_sigreturn)
> -
> -/* kernel/sys.c */
>   #define __NR_setpriority 140
>   __SYSCALL(__NR_setpriority, sys_setpriority)
>   #define __NR_getpriority 141
> @@ -507,7 +449,6 @@ __SYSCALL(__NR_prctl, sys_prctl)
>   #define __NR_getcpu 168
>   __SYSCALL(__NR_getcpu, sys_getcpu)
>   
> -/* kernel/time.c */
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_gettimeofday 169
>   __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
> @@ -517,7 +458,6 @@ __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
>   __SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
>   #endif
>   
> -/* kernel/sys.c */
>   #define __NR_getpid 172
>   __SYSCALL(__NR_getpid, sys_getpid)
>   #define __NR_getppid 173
> @@ -534,12 +474,11 @@ __SYSCALL(__NR_getegid, sys_getegid)
>   __SYSCALL(__NR_gettid, sys_gettid)
>   #define __NR_sysinfo 179
>   __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
> -
> -/* ipc/mqueue.c */
>   #define __NR_mq_open 180
>   __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
>   #define __NR_mq_unlink 181
>   __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_mq_timedsend 182
>   __SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
> @@ -547,12 +486,11 @@ __SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
>   __SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
>   	  sys_mq_timedreceive)
>   #endif
> +
>   #define __NR_mq_notify 184
>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
>   #define __NR_mq_getsetattr 185
>   __SC_COMP(__NR_mq_getsetattr, sys_mq_getsetattr, compat_sys_mq_getsetattr)
> -
> -/* ipc/msg.c */
>   #define __NR_msgget 186
>   __SYSCALL(__NR_msgget, sys_msgget)
>   #define __NR_msgctl 187
> @@ -561,20 +499,18 @@ __SC_COMP(__NR_msgctl, sys_msgctl, compat_sys_msgctl)
>   __SC_COMP(__NR_msgrcv, sys_msgrcv, compat_sys_msgrcv)
>   #define __NR_msgsnd 189
>   __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
> -
> -/* ipc/sem.c */
>   #define __NR_semget 190
>   __SYSCALL(__NR_semget, sys_semget)
>   #define __NR_semctl 191
>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_semtimedop 192
>   __SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
>   #endif
> +
>   #define __NR_semop 193
>   __SYSCALL(__NR_semop, sys_semop)
> -
> -/* ipc/shm.c */
>   #define __NR_shmget 194
>   __SYSCALL(__NR_shmget, sys_shmget)
>   #define __NR_shmctl 195
> @@ -583,8 +519,6 @@ __SC_COMP(__NR_shmctl, sys_shmctl, compat_sys_shmctl)
>   __SC_COMP(__NR_shmat, sys_shmat, compat_sys_shmat)
>   #define __NR_shmdt 197
>   __SYSCALL(__NR_shmdt, sys_shmdt)
> -
> -/* net/socket.c */
>   #define __NR_socket 198
>   __SYSCALL(__NR_socket, sys_socket)
>   #define __NR_socketpair 199
> @@ -615,40 +549,30 @@ __SYSCALL(__NR_shutdown, sys_shutdown)
>   __SC_COMP(__NR_sendmsg, sys_sendmsg, compat_sys_sendmsg)
>   #define __NR_recvmsg 212
>   __SC_COMP(__NR_recvmsg, sys_recvmsg, compat_sys_recvmsg)
> -
> -/* mm/filemap.c */
>   #define __NR_readahead 213
>   __SC_COMP(__NR_readahead, sys_readahead, compat_sys_readahead)
> -
> -/* mm/nommu.c, also with MMU */
>   #define __NR_brk 214
>   __SYSCALL(__NR_brk, sys_brk)
>   #define __NR_munmap 215
>   __SYSCALL(__NR_munmap, sys_munmap)
>   #define __NR_mremap 216
>   __SYSCALL(__NR_mremap, sys_mremap)
> -
> -/* security/keys/keyctl.c */
>   #define __NR_add_key 217
>   __SYSCALL(__NR_add_key, sys_add_key)
>   #define __NR_request_key 218
>   __SYSCALL(__NR_request_key, sys_request_key)
>   #define __NR_keyctl 219
>   __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
> -
> -/* arch/example/kernel/sys_example.c */
>   #define __NR_clone 220
>   __SYSCALL(__NR_clone, sys_clone)
>   #define __NR_execve 221
>   __SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
> -
>   #define __NR3264_mmap 222
>   __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
> -/* mm/fadvise.c */
>   #define __NR3264_fadvise64 223
>   __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
>   
> -/* mm/, CONFIG_MMU only */
> +/* CONFIG_MMU only */
>   #ifndef __ARCH_NOMMU
>   #define __NR_swapon 224
>   __SYSCALL(__NR_swapon, sys_swapon)
> @@ -691,6 +615,7 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
>   __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
>   #define __NR_accept4 242
>   __SYSCALL(__NR_accept4, sys_accept4)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_recvmmsg 243
>   __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
> @@ -706,6 +631,7 @@ __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recv
>   #define __NR_wait4 260
>   __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
>   #endif
> +
>   #define __NR_prlimit64 261
>   __SYSCALL(__NR_prlimit64, sys_prlimit64)
>   #define __NR_fanotify_init 262
> @@ -716,10 +642,12 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
>   __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
>   #define __NR_open_by_handle_at         265
>   __SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_clock_adjtime 266
>   __SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
>   #endif
> +
>   #define __NR_syncfs 267
>   __SYSCALL(__NR_syncfs, sys_syncfs)
>   #define __NR_setns 268
> @@ -770,15 +698,19 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
>   __SYSCALL(__NR_pkey_free,     sys_pkey_free)
>   #define __NR_statx 291
>   __SYSCALL(__NR_statx,     sys_statx)
> +
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_io_pgetevents 292
>   __SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
>   #endif
> +
>   #define __NR_rseq 293
>   __SYSCALL(__NR_rseq, sys_rseq)
>   #define __NR_kexec_file_load 294
>   __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> +
>   /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
> +
>   #if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
>   #define __NR_clock_gettime64 403
>   __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
> @@ -844,13 +776,14 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
>   __SYSCALL(__NR_fspick, sys_fspick)
>   #define __NR_pidfd_open 434
>   __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
> +
>   #ifdef __ARCH_WANT_SYS_CLONE3
>   #define __NR_clone3 435
>   __SYSCALL(__NR_clone3, sys_clone3)
>   #endif
> +
>   #define __NR_close_range 436
>   __SYSCALL(__NR_close_range, sys_close_range)
> -
>   #define __NR_openat2 437
>   __SYSCALL(__NR_openat2, sys_openat2)
>   #define __NR_pidfd_getfd 438
> @@ -865,7 +798,6 @@ __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
>   __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
>   #define __NR_quotactl_fd 443
>   __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
> -
>   #define __NR_landlock_create_ruleset 444
>   __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
>   #define __NR_landlock_add_rule 445
> @@ -877,17 +809,19 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
>   #define __NR_memfd_secret 447
>   __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
>   #endif
> +
>   #define __NR_process_mrelease 448
>   __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
> -
>   #define __NR_futex_waitv 449
>   __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
> -
>   #define __NR_set_mempolicy_home_node 450
>   __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>   
> +#define __NR_cachestat 451
> +__SYSCALL(__NR_cachestat, sys_cachestat)
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
> index 1f14a6fad338..8233f061c4c8 100644
> --- a/linux-headers/asm-mips/unistd_n32.h
> +++ b/linux-headers/asm-mips/unistd_n32.h
> @@ -379,5 +379,6 @@
>   #define __NR_process_mrelease (__NR_Linux + 448)
>   #define __NR_futex_waitv (__NR_Linux + 449)
>   #define __NR_set_mempolicy_home_node (__NR_Linux + 450)
> +#define __NR_cachestat (__NR_Linux + 451)
>   
>   #endif /* _ASM_UNISTD_N32_H */
> diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
> index e5a8ebec7896..a174edc768b6 100644
> --- a/linux-headers/asm-mips/unistd_n64.h
> +++ b/linux-headers/asm-mips/unistd_n64.h
> @@ -355,5 +355,6 @@
>   #define __NR_process_mrelease (__NR_Linux + 448)
>   #define __NR_futex_waitv (__NR_Linux + 449)
>   #define __NR_set_mempolicy_home_node (__NR_Linux + 450)
> +#define __NR_cachestat (__NR_Linux + 451)
>   
>   #endif /* _ASM_UNISTD_N64_H */
> diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
> index 871d57168fed..c1a5351d9bab 100644
> --- a/linux-headers/asm-mips/unistd_o32.h
> +++ b/linux-headers/asm-mips/unistd_o32.h
> @@ -425,5 +425,6 @@
>   #define __NR_process_mrelease (__NR_Linux + 448)
>   #define __NR_futex_waitv (__NR_Linux + 449)
>   #define __NR_set_mempolicy_home_node (__NR_Linux + 450)
> +#define __NR_cachestat (__NR_Linux + 451)
>   
>   #endif /* _ASM_UNISTD_O32_H */
> diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
> index 585c7fefbc2f..82067586917b 100644
> --- a/linux-headers/asm-powerpc/unistd_32.h
> +++ b/linux-headers/asm-powerpc/unistd_32.h
> @@ -432,6 +432,7 @@
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> +#define __NR_cachestat 451
>   
>   
>   #endif /* _ASM_UNISTD_32_H */
> diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
> index 350f7ec0ac38..7be98c15f019 100644
> --- a/linux-headers/asm-powerpc/unistd_64.h
> +++ b/linux-headers/asm-powerpc/unistd_64.h
> @@ -404,6 +404,7 @@
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> +#define __NR_cachestat 451
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-riscv/bitsperlong.h b/linux-headers/asm-riscv/bitsperlong.h
> index cc5c45a9ce9f..6dc0bb0c13b2 100644
> --- a/linux-headers/asm-riscv/bitsperlong.h
> +++ b/linux-headers/asm-riscv/bitsperlong.h
> @@ -1,14 +1 @@
> -/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - * Copyright (C) 2015 Regents of the University of California
> - */
> -
> -#ifndef _ASM_RISCV_BITSPERLONG_H
> -#define _ASM_RISCV_BITSPERLONG_H
> -
> -#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
> -
>   #include <asm-generic/bitsperlong.h>
> -
> -#endif /* _ASM_RISCV_BITSPERLONG_H */
> diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
> index 92af6f3f057c..930fdc4101cd 100644
> --- a/linux-headers/asm-riscv/kvm.h
> +++ b/linux-headers/asm-riscv/kvm.h
> @@ -12,8 +12,10 @@
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/types.h>
> +#include <asm/bitsperlong.h>
>   #include <asm/ptrace.h>
>   
> +#define __KVM_HAVE_IRQ_LINE
>   #define __KVM_HAVE_READONLY_MEM
>   
>   #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> @@ -52,6 +54,7 @@ struct kvm_riscv_config {
>   	unsigned long mvendorid;
>   	unsigned long marchid;
>   	unsigned long mimpid;
> +	unsigned long zicboz_block_size;
>   };
>   
>   /* CORE registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> @@ -64,7 +67,7 @@ struct kvm_riscv_core {
>   #define KVM_RISCV_MODE_S	1
>   #define KVM_RISCV_MODE_U	0
>   
> -/* CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> +/* General CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
>   struct kvm_riscv_csr {
>   	unsigned long sstatus;
>   	unsigned long sie;
> @@ -78,6 +81,17 @@ struct kvm_riscv_csr {
>   	unsigned long scounteren;
>   };
>   
> +/* AIA CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> +struct kvm_riscv_aia_csr {
> +	unsigned long siselect;
> +	unsigned long iprio1;
> +	unsigned long iprio2;
> +	unsigned long sieh;
> +	unsigned long siph;
> +	unsigned long iprio1h;
> +	unsigned long iprio2h;
> +};
> +
>   /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
>   struct kvm_riscv_timer {
>   	__u64 frequency;
> @@ -105,9 +119,31 @@ enum KVM_RISCV_ISA_EXT_ID {
>   	KVM_RISCV_ISA_EXT_SVINVAL,
>   	KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
>   	KVM_RISCV_ISA_EXT_ZICBOM,
> +	KVM_RISCV_ISA_EXT_ZICBOZ,
> +	KVM_RISCV_ISA_EXT_ZBB,
> +	KVM_RISCV_ISA_EXT_SSAIA,
> +	KVM_RISCV_ISA_EXT_V,
> +	KVM_RISCV_ISA_EXT_SVNAPOT,
>   	KVM_RISCV_ISA_EXT_MAX,
>   };
>   
> +/*
> + * SBI extension IDs specific to KVM. This is not the same as the SBI
> + * extension IDs defined by the RISC-V SBI specification.
> + */
> +enum KVM_RISCV_SBI_EXT_ID {
> +	KVM_RISCV_SBI_EXT_V01 = 0,
> +	KVM_RISCV_SBI_EXT_TIME,
> +	KVM_RISCV_SBI_EXT_IPI,
> +	KVM_RISCV_SBI_EXT_RFENCE,
> +	KVM_RISCV_SBI_EXT_SRST,
> +	KVM_RISCV_SBI_EXT_HSM,
> +	KVM_RISCV_SBI_EXT_PMU,
> +	KVM_RISCV_SBI_EXT_EXPERIMENTAL,
> +	KVM_RISCV_SBI_EXT_VENDOR,
> +	KVM_RISCV_SBI_EXT_MAX,
> +};
> +
>   /* Possible states for kvm_riscv_timer */
>   #define KVM_RISCV_TIMER_STATE_OFF	0
>   #define KVM_RISCV_TIMER_STATE_ON	1
> @@ -118,6 +154,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>   /* If you need to interpret the index values, here is the key: */
>   #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
>   #define KVM_REG_RISCV_TYPE_SHIFT	24
> +#define KVM_REG_RISCV_SUBTYPE_MASK	0x0000000000FF0000
> +#define KVM_REG_RISCV_SUBTYPE_SHIFT	16
>   
>   /* Config registers are mapped as type 1 */
>   #define KVM_REG_RISCV_CONFIG		(0x01 << KVM_REG_RISCV_TYPE_SHIFT)
> @@ -131,8 +169,12 @@ enum KVM_RISCV_ISA_EXT_ID {
>   
>   /* Control and status registers are mapped as type 3 */
>   #define KVM_REG_RISCV_CSR		(0x03 << KVM_REG_RISCV_TYPE_SHIFT)
> +#define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>   #define KVM_REG_RISCV_CSR_REG(name)	\
>   		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
> +#define KVM_REG_RISCV_CSR_AIA_REG(name)	\
> +	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
>   
>   /* Timer registers are mapped as type 4 */
>   #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
> @@ -152,6 +194,96 @@ enum KVM_RISCV_ISA_EXT_ID {
>   /* ISA Extension registers are mapped as type 7 */
>   #define KVM_REG_RISCV_ISA_EXT		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
>   
> +/* SBI extension registers are mapped as type 8 */
> +#define KVM_REG_RISCV_SBI_EXT		(0x08 << KVM_REG_RISCV_TYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_SINGLE	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_MULTI_EN	(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_MULTI_DIS	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_MULTI_REG(__ext_id)	\
> +		((__ext_id) / __BITS_PER_LONG)
> +#define KVM_REG_RISCV_SBI_MULTI_MASK(__ext_id)	\
> +		(1UL << ((__ext_id) % __BITS_PER_LONG))
> +#define KVM_REG_RISCV_SBI_MULTI_REG_LAST	\
> +		KVM_REG_RISCV_SBI_MULTI_REG(KVM_RISCV_SBI_EXT_MAX - 1)
> +
> +/* V extension registers are mapped as type 9 */
> +#define KVM_REG_RISCV_VECTOR		(0x09 << KVM_REG_RISCV_TYPE_SHIFT)
> +#define KVM_REG_RISCV_VECTOR_CSR_REG(name)	\
> +		(offsetof(struct __riscv_v_ext_state, name) / sizeof(unsigned long))
> +#define KVM_REG_RISCV_VECTOR_REG(n)	\
> +		((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
> +
> +/* Device Control API: RISC-V AIA */
> +#define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
> +#define KVM_DEV_RISCV_APLIC_SIZE		0x4000
> +#define KVM_DEV_RISCV_APLIC_MAX_HARTS		0x4000
> +#define KVM_DEV_RISCV_IMSIC_ALIGN		0x1000
> +#define KVM_DEV_RISCV_IMSIC_SIZE		0x1000
> +
> +#define KVM_DEV_RISCV_AIA_GRP_CONFIG		0
> +#define KVM_DEV_RISCV_AIA_CONFIG_MODE		0
> +#define KVM_DEV_RISCV_AIA_CONFIG_IDS		1
> +#define KVM_DEV_RISCV_AIA_CONFIG_SRCS		2
> +#define KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS	3
> +#define KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT	4
> +#define KVM_DEV_RISCV_AIA_CONFIG_HART_BITS	5
> +#define KVM_DEV_RISCV_AIA_CONFIG_GUEST_BITS	6
> +
> +/*
> + * Modes of RISC-V AIA device:
> + * 1) EMUL (aka Emulation): Trap-n-emulate IMSIC
> + * 2) HWACCEL (aka HW Acceleration): Virtualize IMSIC using IMSIC guest files
> + * 3) AUTO (aka Automatic): Virtualize IMSIC using IMSIC guest files whenever
> + *    available otherwise fallback to trap-n-emulation
> + */
> +#define KVM_DEV_RISCV_AIA_MODE_EMUL		0
> +#define KVM_DEV_RISCV_AIA_MODE_HWACCEL		1
> +#define KVM_DEV_RISCV_AIA_MODE_AUTO		2
> +
> +#define KVM_DEV_RISCV_AIA_IDS_MIN		63
> +#define KVM_DEV_RISCV_AIA_IDS_MAX		2048
> +#define KVM_DEV_RISCV_AIA_SRCS_MAX		1024
> +#define KVM_DEV_RISCV_AIA_GROUP_BITS_MAX	8
> +#define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MIN	24
> +#define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MAX	56
> +#define KVM_DEV_RISCV_AIA_HART_BITS_MAX		16
> +#define KVM_DEV_RISCV_AIA_GUEST_BITS_MAX	8
> +
> +#define KVM_DEV_RISCV_AIA_GRP_ADDR		1
> +#define KVM_DEV_RISCV_AIA_ADDR_APLIC		0
> +#define KVM_DEV_RISCV_AIA_ADDR_IMSIC(__vcpu)	(1 + (__vcpu))
> +#define KVM_DEV_RISCV_AIA_ADDR_MAX		\
> +		(1 + KVM_DEV_RISCV_APLIC_MAX_HARTS)
> +
> +#define KVM_DEV_RISCV_AIA_GRP_CTRL		2
> +#define KVM_DEV_RISCV_AIA_CTRL_INIT		0
> +
> +/*
> + * The device attribute type contains the memory mapped offset of the
> + * APLIC register (range 0x0000-0x3FFF) and it must be 4-byte aligned.
> + */
> +#define KVM_DEV_RISCV_AIA_GRP_APLIC		3
> +
> +/*
> + * The lower 12-bits of the device attribute type contains the iselect
> + * value of the IMSIC register (range 0x70-0xFF) whereas the higher order
> + * bits contains the VCPU id.
> + */
> +#define KVM_DEV_RISCV_AIA_GRP_IMSIC		4
> +#define KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS	12
> +#define KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK	\
> +		((1U << KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS) - 1)
> +#define KVM_DEV_RISCV_AIA_IMSIC_MKATTR(__vcpu, __isel)	\
> +		(((__vcpu) << KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS) | \
> +		 ((__isel) & KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK))
> +#define KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(__attr)	\
> +		((__attr) & KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK)
> +#define KVM_DEV_RISCV_AIA_IMSIC_GET_VCPU(__attr)	\
> +		((__attr) >> KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS)
> +
> +/* One single KVM irqchip, ie. the AIA */
> +#define KVM_NR_IRQCHIPS			1
> +
>   #endif
>   
>   #endif /* __LINUX_KVM_RISCV_H */
> diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv/unistd.h
> index 73d7cdd2ec49..950ab3fd4409 100644
> --- a/linux-headers/asm-riscv/unistd.h
> +++ b/linux-headers/asm-riscv/unistd.h
> @@ -43,3 +43,12 @@
>   #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
>   #endif
>   __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> +
> +/*
> + * Allows userspace to query the kernel for CPU architecture and
> + * microarchitecture details across a given set of CPUs.
> + */
> +#ifndef __NR_riscv_hwprobe
> +#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
> +#endif
> +__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
> diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
> index 8e644d65f571..ef772cc5f81d 100644
> --- a/linux-headers/asm-s390/unistd_32.h
> +++ b/linux-headers/asm-s390/unistd_32.h
> @@ -419,8 +419,10 @@
>   #define __NR_landlock_create_ruleset 444
>   #define __NR_landlock_add_rule 445
>   #define __NR_landlock_restrict_self 446
> +#define __NR_memfd_secret 447
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> +#define __NR_cachestat 451
>   
>   #endif /* _ASM_S390_UNISTD_32_H */
> diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
> index 51da542fec10..32354a04591c 100644
> --- a/linux-headers/asm-s390/unistd_64.h
> +++ b/linux-headers/asm-s390/unistd_64.h
> @@ -367,8 +367,10 @@
>   #define __NR_landlock_create_ruleset 444
>   #define __NR_landlock_add_rule 445
>   #define __NR_landlock_restrict_self 446
> +#define __NR_memfd_secret 447
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> +#define __NR_cachestat 451
>   
>   #endif /* _ASM_S390_UNISTD_64_H */
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 2937e7bf6982..2b3a8f7bd2c0 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -557,4 +557,7 @@ struct kvm_pmu_event_filter {
>   #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
>   #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
>   
> +/* x86-specific KVM_EXIT_HYPERCALL flags. */
> +#define KVM_EXIT_HYPERCALL_LONG_MODE	BIT(0)
> +
>   #endif /* _ASM_X86_KVM_H */
> diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
> index 87e1e977afd3..37b32d8139c2 100644
> --- a/linux-headers/asm-x86/unistd_32.h
> +++ b/linux-headers/asm-x86/unistd_32.h
> @@ -441,6 +441,7 @@
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> +#define __NR_cachestat 451
>   
>   
>   #endif /* _ASM_UNISTD_32_H */
> diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
> index 147a78d623e5..5b55d6729a5b 100644
> --- a/linux-headers/asm-x86/unistd_64.h
> +++ b/linux-headers/asm-x86/unistd_64.h
> @@ -363,6 +363,7 @@
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> +#define __NR_cachestat 451
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
> index 27098db7fbeb..e8a007543d72 100644
> --- a/linux-headers/asm-x86/unistd_x32.h
> +++ b/linux-headers/asm-x86/unistd_x32.h
> @@ -316,6 +316,7 @@
>   #define __NR_process_mrelease (__X32_SYSCALL_BIT + 448)
>   #define __NR_futex_waitv (__X32_SYSCALL_BIT + 449)
>   #define __NR_set_mempolicy_home_node (__X32_SYSCALL_BIT + 450)
> +#define __NR_cachestat (__X32_SYSCALL_BIT + 451)
>   #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
>   #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
>   #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
> diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
> index 5e4898725168..1eb84b5087f8 100644
> --- a/linux-headers/linux/const.h
> +++ b/linux-headers/linux/const.h
> @@ -28,7 +28,7 @@
>   #define _BITUL(x)	(_UL(1) << (x))
>   #define _BITULL(x)	(_ULL(1) << (x))
>   
> -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>   #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>   
>   #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 599de3c6e3aa..1f3f3333a4d8 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -341,8 +341,11 @@ struct kvm_run {
>   			__u64 nr;
>   			__u64 args[6];
>   			__u64 ret;
> -			__u32 longmode;
> -			__u32 pad;
> +
> +			union {
> +				__u32 longmode;
> +				__u64 flags;
> +			};
>   		} hypercall;
>   		/* KVM_EXIT_TPR_ACCESS */
>   		struct {
> @@ -1182,6 +1185,9 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
>   #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
>   #define KVM_CAP_PMU_EVENT_MASKED_EVENTS 226
> +#define KVM_CAP_COUNTER_OFFSET 227
> +#define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
> +#define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> @@ -1434,6 +1440,8 @@ enum kvm_device_type {
>   #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
>   	KVM_DEV_TYPE_ARM_PV_TIME,
>   #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
> +	KVM_DEV_TYPE_RISCV_AIA,
> +#define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
>   	KVM_DEV_TYPE_MAX,
>   };
>   
> @@ -1449,7 +1457,7 @@ struct kvm_vfio_spapr_tce {
>   #define KVM_CREATE_VCPU           _IO(KVMIO,   0x41)
>   #define KVM_GET_DIRTY_LOG         _IOW(KVMIO,  0x42, struct kvm_dirty_log)
>   #define KVM_SET_NR_MMU_PAGES      _IO(KVMIO,   0x44)
> -#define KVM_GET_NR_MMU_PAGES      _IO(KVMIO,   0x45)
> +#define KVM_GET_NR_MMU_PAGES      _IO(KVMIO,   0x45)  /* deprecated */
>   #define KVM_SET_USER_MEMORY_REGION _IOW(KVMIO, 0x46, \
>   					struct kvm_userspace_memory_region)
>   #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
> @@ -1541,6 +1549,8 @@ struct kvm_s390_ucas_mapping {
>   #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
>   #define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
>   #define KVM_ARM_MTE_COPY_TAGS	  _IOR(KVMIO,  0xb4, struct kvm_arm_copy_mte_tags)
> +/* Available with KVM_CAP_COUNTER_OFFSET */
> +#define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
>   
>   /* ioctl for vm fd */
>   #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> @@ -1603,7 +1613,7 @@ struct kvm_s390_ucas_mapping {
>   #define KVM_GET_DEBUGREGS         _IOR(KVMIO,  0xa1, struct kvm_debugregs)
>   #define KVM_SET_DEBUGREGS         _IOW(KVMIO,  0xa2, struct kvm_debugregs)
>   /*
> - * vcpu version available with KVM_ENABLE_CAP
> + * vcpu version available with KVM_CAP_ENABLE_CAP
>    * vm version available with KVM_CAP_ENABLE_CAP_VM
>    */
>   #define KVM_ENABLE_CAP            _IOW(KVMIO,  0xa3, struct kvm_enable_cap)
> diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
> index 434986fbe307..4e8cb6078058 100644
> --- a/linux-headers/linux/mman.h
> +++ b/linux-headers/linux/mman.h
> @@ -4,6 +4,7 @@
>   
>   #include <asm/mman.h>
>   #include <asm-generic/hugetlb_encode.h>
> +#include <linux/types.h>
>   
>   #define MREMAP_MAYMOVE		1
>   #define MREMAP_FIXED		2
> @@ -41,4 +42,17 @@
>   #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>   #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>   
> +struct cachestat_range {
> +	__u64 off;
> +	__u64 len;
> +};
> +
> +struct cachestat {
> +	__u64 nr_cache;
> +	__u64 nr_dirty;
> +	__u64 nr_writeback;
> +	__u64 nr_evicted;
> +	__u64 nr_recently_evicted;
> +};
> +
>   #endif /* _LINUX_MMAN_H */
> diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
> index 51d8b3940e14..12ccb70099d4 100644
> --- a/linux-headers/linux/psp-sev.h
> +++ b/linux-headers/linux/psp-sev.h
> @@ -36,6 +36,13 @@ enum {
>    * SEV Firmware status code
>    */
>   typedef enum {
> +	/*
> +	 * This error code is not in the SEV spec. Its purpose is to convey that
> +	 * there was an error that prevented the SEV firmware from being called.
> +	 * The SEV API error codes are 16 bits, so the -1 value will not overlap
> +	 * with possible values from the specification.
> +	 */
> +	SEV_RET_NO_FW_CALL = -1,
>   	SEV_RET_SUCCESS = 0,
>   	SEV_RET_INVALID_PLATFORM_STATE,
>   	SEV_RET_INVALID_GUEST_STATE,
> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
> index ba5d0df52fb8..14e402263a8a 100644
> --- a/linux-headers/linux/userfaultfd.h
> +++ b/linux-headers/linux/userfaultfd.h
> @@ -38,7 +38,8 @@
>   			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
>   			   UFFD_FEATURE_MINOR_SHMEM |		\
>   			   UFFD_FEATURE_EXACT_ADDRESS |		\
> -			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
> +			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
> +			   UFFD_FEATURE_WP_UNPOPULATED)
>   #define UFFD_API_IOCTLS				\
>   	((__u64)1 << _UFFDIO_REGISTER |		\
>   	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -203,6 +204,12 @@ struct uffdio_api {
>   	 *
>   	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
>   	 * write-protection mode is supported on both shmem and hugetlbfs.
> +	 *
> +	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
> +	 * write-protection mode will always apply to unpopulated pages
> +	 * (i.e. empty ptes).  This will be the default behavior for shmem
> +	 * & hugetlbfs, so this flag only affects anonymous memory behavior
> +	 * when userfault write-protection mode is registered.
>   	 */
>   #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>   #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -217,6 +224,7 @@ struct uffdio_api {
>   #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>   #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>   #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
> +#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
>   	__u64 features;
>   
>   	__u64 ioctls;
> @@ -297,6 +305,13 @@ struct uffdio_writeprotect {
>   struct uffdio_continue {
>   	struct uffdio_range range;
>   #define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
> +	/*
> +	 * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
> +	 * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
> +	 * write protected ioctl is implemented for the range
> +	 * according to the uffdio_register.ioctls.
> +	 */
> +#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
>   	__u64 mode;
>   
>   	/*
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4a534edbdcba..16db89071eab 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -213,6 +213,7 @@ struct vfio_device_info {
>   #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
>   #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
>   #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
> +#define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
>   	__u32	num_regions;	/* Max region index + 1 */
>   	__u32	num_irqs;	/* Max IRQ index + 1 */
>   	__u32   cap_offset;	/* Offset within info struct of first cap */
> @@ -240,6 +241,20 @@ struct vfio_device_info {
>   #define VFIO_DEVICE_INFO_CAP_ZPCI_UTIL		3
>   #define VFIO_DEVICE_INFO_CAP_ZPCI_PFIP		4
>   
> +/*
> + * The following VFIO_DEVICE_INFO capability reports support for PCIe AtomicOp
> + * completion to the root bus with supported widths provided via flags.
> + */
> +#define VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP	5
> +struct vfio_device_info_cap_pci_atomic_comp {
> +	struct vfio_info_cap_header header;
> +	__u32 flags;
> +#define VFIO_PCI_ATOMIC_COMP32	(1 << 0)
> +#define VFIO_PCI_ATOMIC_COMP64	(1 << 1)
> +#define VFIO_PCI_ATOMIC_COMP128	(1 << 2)
> +	__u32 reserved;
> +};
> +
>   /**
>    * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
>    *				       struct vfio_region_info)
> @@ -511,6 +526,9 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
>    * then add and unmask vectors, it's up to userspace to make the decision
>    * whether to allocate the maximum supported number of vectors or tear
>    * down setup and incrementally increase the vectors as each is enabled.
> + * Absence of the NORESIZE flag indicates that vectors can be enabled
> + * and disabled dynamically without impacting other vectors within the
> + * index.
>    */
>   struct vfio_irq_info {
>   	__u32	argsz;
> @@ -646,6 +664,15 @@ enum {
>   	VFIO_CCW_NUM_IRQS
>   };
>   
> +/*
> + * The vfio-ap bus driver makes use of the following IRQ index mapping.
> + * Unimplemented IRQ types return a count of zero.
> + */
> +enum {
> +	VFIO_AP_REQ_IRQ_INDEX,
> +	VFIO_AP_NUM_IRQS
> +};
> +
>   /**
>    * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>    *					      struct vfio_pci_hot_reset_info)
> diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
> index 92e1b700b51c..f5c48b61ab62 100644
> --- a/linux-headers/linux/vhost.h
> +++ b/linux-headers/linux/vhost.h
> @@ -45,6 +45,25 @@
>   #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
>   /* Specify an eventfd file descriptor to signal on log write. */
>   #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
> +/* By default, a device gets one vhost_worker that its virtqueues share. This
> + * command allows the owner of the device to create an additional vhost_worker
> + * for the device. It can later be bound to 1 or more of its virtqueues using
> + * the VHOST_ATTACH_VRING_WORKER command.
> + *
> + * This must be called after VHOST_SET_OWNER and the caller must be the owner
> + * of the device. The new thread will inherit caller's cgroups and namespaces,
> + * and will share the caller's memory space. The new thread will also be
> + * counted against the caller's RLIMIT_NPROC value.
> + *
> + * The worker's ID used in other commands will be returned in
> + * vhost_worker_state.
> + */
> +#define VHOST_NEW_WORKER _IOR(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
> +/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
> + * virtqueue. If userspace is not able to call this for workers its created,
> + * the kernel will free all the device's workers when the device is closed.
> + */
> +#define VHOST_FREE_WORKER _IOW(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
>   
>   /* Ring setup. */
>   /* Set number of descriptors in ring. This parameter can not
> @@ -70,6 +89,18 @@
>   #define VHOST_VRING_BIG_ENDIAN 1
>   #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
>   #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> +/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
> + * virtqueues.
> + *
> + * This will replace the virtqueue's existing worker. If the replaced worker
> + * is no longer attached to any virtqueues, it can be freed with
> + * VHOST_FREE_WORKER.
> + */
> +#define VHOST_ATTACH_VRING_WORKER _IOW(VHOST_VIRTIO, 0x15,		\
> +				       struct vhost_vring_worker)
> +/* Return the vring worker's ID */
> +#define VHOST_GET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x16,		\
> +				     struct vhost_vring_worker)
>   
>   /* The following ioctls use eventfd file descriptors to signal and poll
>    * for events. */

