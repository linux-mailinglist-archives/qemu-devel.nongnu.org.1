Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2141CA9B21B
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 17:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yPG-0002wQ-HL; Thu, 24 Apr 2025 11:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yP7-0002sp-PR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yP1-0000wu-P7
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745508133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HlSgXCw+bFWsGNPZYf7R9ee84IJfYQxfm4xg0SHygVA=;
 b=AZ009m2M3734MzQZgHWQPoyZ+fDl5cw188axuDmxQOjXq+AeJOi5iLlHepgxa+GN+79ryJ
 SgCcmLlqSnho1hKnk6OOwARYedq1bmfrcPHHmUE5Nm8HjqccQ4a2tsi/baW1Tkmf+46YVu
 lqh5Njfu21V+m8lWW5wn9YfuC+Bl+VA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-vxkNCbe0MUe8R099IFPIDw-1; Thu, 24 Apr 2025 11:22:12 -0400
X-MC-Unique: vxkNCbe0MUe8R099IFPIDw-1
X-Mimecast-MFC-AGG-ID: vxkNCbe0MUe8R099IFPIDw_1745508130
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so6245995e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 08:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745508130; x=1746112930;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlSgXCw+bFWsGNPZYf7R9ee84IJfYQxfm4xg0SHygVA=;
 b=vXa11uEQWJRZl+3RNKosCO7ZCYQ8oP3/4fAgz8zM6ybwNi7kUd2a1g3E6lf2w+PI3v
 DYgCyGL6/Mis2dI39gROw4YSZkG5NxjdBV9/omYPFMKl9/qDMSHQwAovRr2A+29WwB4p
 zs4DALjCbEOy0xHH2Wwh6HkpaMhoil03t68J1r6I91Vog2mBXLNi+QLfjxExH9f7VNTM
 9j1vi89fCjl3k8yXbT39RcF1AaP2vQksbLNvYnz+Wl2jqO4vF/O7VxvvDV+Suwu1aysc
 bLtmx8dPbeCdZbrd1GDPv1XMGe9WQyWje/wMUcpm5buct0dsGUefko/dsELjLUxn2fsu
 cmhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYakMEZcO3xgGnTLmFuCOHmqyNS4UKf7Qn6vfDVmebfFfp5KZW4O6bnvrXq931SsB8l8PvDNBFXPs@nongnu.org
X-Gm-Message-State: AOJu0YzQD0sKJHijh06YSHoiLX88VYK2s3ewK9JxeHebwvV91WOQpWDS
 2Om94I+goV/0wpIKdLuRrJf4LI8saoVEHU+ZuD9lV75RQKWU8UJx2Gmc409Ud7tBalIeGBal13o
 BCgl5i/QICCyqDrVB/zA8zhNx1hNK66gCY74RlyBIyrqQC7kO+d5v
X-Gm-Gg: ASbGncsIIROCPlFjTA0YVQBZkbmlXsJk3GYmTev2Czzk9Ikw8ERLENCM8VfJGOv+dmO
 h7uUMaiMwyEMHiHvoIe8iq2Nxf17ukljrv1mNMuIypWCbutlnUu+H/QWraoAD1UIofBNF5BCZYT
 arVWYTxZxqwqTXr1YklFiFLohcCqjOhKZuA3L0Bk7hR/Ub6BG/o9DUm6UHKzXXEAWGj66AjHjF6
 LHwDq6Yb+ijb93TsX+qXnVeqy1nBuK14JlGq4j8Rpe/k4YpYEFVwvaqs52TenF6DHnVbTYOG5UT
 93OgDWOcxy0mGO4w4/+Hs+cck2EjJ9TOpD1XlretPAKFdpk=
X-Received: by 2002:a05:600c:524d:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-4409bd1f461mr27867245e9.14.1745508129523; 
 Thu, 24 Apr 2025 08:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLaKlgPtU6G/mYVpRucwZhm+j4Ht7JcXT3yPX2W4gbdgsMMBbZA33K4YXfSCsnfif57olpqQ==
X-Received: by 2002:a05:600c:524d:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-4409bd1f461mr27866775e9.14.1745508128813; 
 Thu, 24 Apr 2025 08:22:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5328ecsm2413302f8f.71.2025.04.24.08.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 08:22:08 -0700 (PDT)
Message-ID: <0f1e4f98-cbbc-4269-aadd-76b32628218b@redhat.com>
Date: Thu, 24 Apr 2025 17:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] linux-headers: Update to Linux v6.15-rc1
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250423214506.72728-1-rreyes@linux.ibm.com>
 <20250423214506.72728-8-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250423214506.72728-8-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

Hello Rorie

On 4/23/25 23:45, Rorie Reyes wrote:
> Update headers to retrieve uapi information for vfio-ap

So patch 1 becomes useless ?

I would move patch 6 and 7 at the beginning of the series and
drop patch 1.

Also, you could do the linux-headers resync on the latest v6.15-rc3.


Thanks,

C.




> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   include/standard-headers/asm-x86/setup_data.h |   4 +-
>   include/standard-headers/drm/drm_fourcc.h     |  41 ++++++
>   include/standard-headers/linux/const.h        |   2 +-
>   include/standard-headers/linux/ethtool.h      |  22 +++
>   include/standard-headers/linux/fuse.h         |  12 +-
>   include/standard-headers/linux/pci_regs.h     |  13 +-
>   include/standard-headers/linux/virtio_net.h   |  13 ++
>   include/standard-headers/linux/virtio_snd.h   |   2 +-
>   linux-headers/asm-arm64/kvm.h                 |  11 ++
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/mman-common.h       |   1 +
>   linux-headers/asm-generic/unistd.h            |   4 +-
>   linux-headers/asm-loongarch/unistd_64.h       |   1 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |   2 +
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            |   1 +
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |   3 +
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/bits.h                    |   8 +-
>   linux-headers/linux/const.h                   |   2 +-
>   linux-headers/linux/iommufd.h                 | 129 +++++++++++++++++-
>   linux-headers/linux/kvm.h                     |   1 +
>   linux-headers/linux/psp-sev.h                 |  21 ++-
>   linux-headers/linux/stddef.h                  |   2 +
>   linux-headers/linux/vfio.h                    |  29 ++--
>   34 files changed, 300 insertions(+), 36 deletions(-)
> 
> diff --git a/include/standard-headers/asm-x86/setup_data.h b/include/standard-headers/asm-x86/setup_data.h
> index 09355f54c5..a483d72f42 100644
> --- a/include/standard-headers/asm-x86/setup_data.h
> +++ b/include/standard-headers/asm-x86/setup_data.h
> @@ -18,7 +18,7 @@
>   #define SETUP_INDIRECT			(1<<31)
>   #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include "standard-headers/linux/types.h"
>   
> @@ -78,6 +78,6 @@ struct ima_setup_data {
>   	uint64_t size;
>   } QEMU_PACKED;
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* _ASM_X86_SETUP_DATA_H */
> diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
> index 708647776f..a8b759dcbc 100644
> --- a/include/standard-headers/drm/drm_fourcc.h
> +++ b/include/standard-headers/drm/drm_fourcc.h
> @@ -420,6 +420,7 @@ extern "C" {
>   #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>   #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
>   #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> +#define DRM_FORMAT_MOD_VENDOR_MTK     0x0b
>   
>   /* add more to the end as needed */
>   
> @@ -1452,6 +1453,46 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
>    */
>   #define AMLOGIC_FBC_OPTION_MEM_SAVING		(1ULL << 0)
>   
> +/* MediaTek modifiers
> + * Bits  Parameter                Notes
> + * ----- ------------------------ ---------------------------------------------
> + *   7: 0 TILE LAYOUT              Values are MTK_FMT_MOD_TILE_*
> + *  15: 8 COMPRESSION              Values are MTK_FMT_MOD_COMPRESS_*
> + *  23:16 10 BIT LAYOUT            Values are MTK_FMT_MOD_10BIT_LAYOUT_*
> + *
> + */
> +
> +#define DRM_FORMAT_MOD_MTK(__flags)		fourcc_mod_code(MTK, __flags)
> +
> +/*
> + * MediaTek Tiled Modifier
> + * The lowest 8 bits of the modifier is used to specify the tiling
> + * layout. Only the 16L_32S tiling is used for now, but we define an
> + * "untiled" version and leave room for future expansion.
> + */
> +#define MTK_FMT_MOD_TILE_MASK     0xf
> +#define MTK_FMT_MOD_TILE_NONE     0x0
> +#define MTK_FMT_MOD_TILE_16L32S   0x1
> +
> +/*
> + * Bits 8-15 specify compression options
> + */
> +#define MTK_FMT_MOD_COMPRESS_MASK (0xf << 8)
> +#define MTK_FMT_MOD_COMPRESS_NONE (0x0 << 8)
> +#define MTK_FMT_MOD_COMPRESS_V1   (0x1 << 8)
> +
> +/*
> + * Bits 16-23 specify how the bits of 10 bit formats are
> + * stored out in memory
> + */
> +#define MTK_FMT_MOD_10BIT_LAYOUT_MASK      (0xf << 16)
> +#define MTK_FMT_MOD_10BIT_LAYOUT_PACKED    (0x0 << 16)
> +#define MTK_FMT_MOD_10BIT_LAYOUT_LSBTILED  (0x1 << 16)
> +#define MTK_FMT_MOD_10BIT_LAYOUT_LSBRASTER (0x2 << 16)
> +
> +/* alias for the most common tiling format */
> +#define DRM_FORMAT_MOD_MTK_16L_32S_TILE  DRM_FORMAT_MOD_MTK(MTK_FMT_MOD_TILE_16L32S)
> +
>   /*
>    * AMD modifiers
>    *
> diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
> index 2122610de7..95ede23342 100644
> --- a/include/standard-headers/linux/const.h
> +++ b/include/standard-headers/linux/const.h
> @@ -33,7 +33,7 @@
>    * Missing __asm__ support
>    *
>    * __BIT128() would not work in the __asm__ code, as it shifts an
> - * 'unsigned __init128' data type as direct representation of
> + * 'unsigned __int128' data type as direct representation of
>    * 128 bit constants is not supported in the gcc compiler, as
>    * they get silently truncated.
>    *
> diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
> index e83382531c..5d1ad5fdea 100644
> --- a/include/standard-headers/linux/ethtool.h
> +++ b/include/standard-headers/linux/ethtool.h
> @@ -2059,6 +2059,24 @@ enum ethtool_link_mode_bit_indices {
>   	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
>   	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
>   	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
> +	ETHTOOL_LINK_MODE_200000baseCR_Full_BIT		 = 103,
> +	ETHTOOL_LINK_MODE_200000baseKR_Full_BIT		 = 104,
> +	ETHTOOL_LINK_MODE_200000baseDR_Full_BIT		 = 105,
> +	ETHTOOL_LINK_MODE_200000baseDR_2_Full_BIT	 = 106,
> +	ETHTOOL_LINK_MODE_200000baseSR_Full_BIT		 = 107,
> +	ETHTOOL_LINK_MODE_200000baseVR_Full_BIT		 = 108,
> +	ETHTOOL_LINK_MODE_400000baseCR2_Full_BIT	 = 109,
> +	ETHTOOL_LINK_MODE_400000baseKR2_Full_BIT	 = 110,
> +	ETHTOOL_LINK_MODE_400000baseDR2_Full_BIT	 = 111,
> +	ETHTOOL_LINK_MODE_400000baseDR2_2_Full_BIT	 = 112,
> +	ETHTOOL_LINK_MODE_400000baseSR2_Full_BIT	 = 113,
> +	ETHTOOL_LINK_MODE_400000baseVR2_Full_BIT	 = 114,
> +	ETHTOOL_LINK_MODE_800000baseCR4_Full_BIT	 = 115,
> +	ETHTOOL_LINK_MODE_800000baseKR4_Full_BIT	 = 116,
> +	ETHTOOL_LINK_MODE_800000baseDR4_Full_BIT	 = 117,
> +	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
> +	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
> +	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
>   
>   	/* must be last entry */
>   	__ETHTOOL_LINK_MODE_MASK_NBITS
> @@ -2271,6 +2289,10 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
>    * be exploited to reduce the RSS queue spread.
>    */
>   #define	RXH_XFRM_SYM_XOR	(1 << 0)
> +/* Similar to SYM_XOR, except that one copy of the XOR'ed fields is replaced by
> + * an OR of the same fields
> + */
> +#define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
>   #define	RXH_XFRM_NO_CHANGE	0xff
>   
>   /* L2-L4 network traffic flow types */
> diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
> index d303effb2a..a2b5815d89 100644
> --- a/include/standard-headers/linux/fuse.h
> +++ b/include/standard-headers/linux/fuse.h
> @@ -229,6 +229,9 @@
>    *    - FUSE_URING_IN_OUT_HEADER_SZ
>    *    - FUSE_URING_OP_IN_OUT_SZ
>    *    - enum fuse_uring_cmd
> + *
> + *  7.43
> + *  - add FUSE_REQUEST_TIMEOUT
>    */
>   
>   #ifndef _LINUX_FUSE_H
> @@ -260,7 +263,7 @@
>   #define FUSE_KERNEL_VERSION 7
>   
>   /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 42
> +#define FUSE_KERNEL_MINOR_VERSION 43
>   
>   /** The node ID of the root inode */
>   #define FUSE_ROOT_ID 1
> @@ -431,6 +434,8 @@ struct fuse_file_lock {
>    *		    of the request ID indicates resend requests
>    * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
>    * FUSE_OVER_IO_URING: Indicate that client supports io-uring
> + * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
> + *			 init_out.request_timeout contains the timeout (in secs)
>    */
>   #define FUSE_ASYNC_READ		(1 << 0)
>   #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -473,11 +478,11 @@ struct fuse_file_lock {
>   #define FUSE_PASSTHROUGH	(1ULL << 37)
>   #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
>   #define FUSE_HAS_RESEND		(1ULL << 39)
> -
>   /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
>   #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
>   #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>   #define FUSE_OVER_IO_URING	(1ULL << 41)
> +#define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
>   
>   /**
>    * CUSE INIT request/reply flags
> @@ -905,7 +910,8 @@ struct fuse_init_out {
>   	uint16_t	map_alignment;
>   	uint32_t	flags2;
>   	uint32_t	max_stack_depth;
> -	uint32_t	unused[6];
> +	uint16_t	request_timeout;
> +	uint16_t	unused[11];
>   };
>   
>   #define CUSE_INIT_INFO_MAX 4096
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index 3445c4970e..ba326710f9 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -486,6 +486,7 @@
>   #define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
>   #define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
>   #define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
> +#define  PCI_EXP_FLAGS_FLIT	0x8000	/* Flit Mode Supported */
>   #define PCI_EXP_DEVCAP		0x04	/* Device capabilities */
>   #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
>   #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
> @@ -795,6 +796,8 @@
>   #define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
>   #define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
>   #define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
> +#define  PCI_ERR_CAP_TLP_LOG_FLIT	0x00040000 /* TLP was logged in Flit Mode */
> +#define  PCI_ERR_CAP_TLP_LOG_SIZE	0x00f80000 /* Logged TLP Size (only in Flit mode) */
>   #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
>   #define PCI_ERR_ROOT_COMMAND	0x2c	/* Root Error Command */
>   #define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
> @@ -1013,7 +1016,7 @@
>   
>   /* Resizable BARs */
>   #define PCI_REBAR_CAP		4	/* capability register */
> -#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
> +#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
>   #define PCI_REBAR_CTRL		8	/* control register */
>   #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
>   #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
> @@ -1061,8 +1064,9 @@
>   #define  PCI_EXP_DPC_CAP_RP_EXT		0x0020	/* Root Port Extensions */
>   #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x0040	/* Poisoned TLP Egress Blocking Supported */
>   #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x0080	/* Software Triggering Supported */
> -#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size */
> +#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size [3:0] */
>   #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
> +#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE4	0x2000	/* RP PIO Log Size [4] */
>   
>   #define PCI_EXP_DPC_CTL			0x06	/* DPC control */
>   #define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
> @@ -1205,9 +1209,12 @@
>   #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
>   #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000
>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>   
> +/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
> +
>   /* Compute Express Link (CXL r3.1, sec 8.1.5) */
>   #define PCI_DVSEC_CXL_PORT				3
>   #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index fc594fe5fc..982e854f14 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -327,6 +327,19 @@ struct virtio_net_rss_config {
>   	uint8_t hash_key_data[/* hash_key_length */];
>   };
>   
> +struct virtio_net_rss_config_hdr {
> +	uint32_t hash_types;
> +	uint16_t indirection_table_mask;
> +	uint16_t unclassified_queue;
> +	uint16_t indirection_table[/* 1 + indirection_table_mask */];
> +};
> +
> +struct virtio_net_rss_config_trailer {
> +	uint16_t max_tx_vq;
> +	uint8_t hash_key_length;
> +	uint8_t hash_key_data[/* hash_key_length */];
> +};
> +
>    #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
>   
>   /*
> diff --git a/include/standard-headers/linux/virtio_snd.h b/include/standard-headers/linux/virtio_snd.h
> index 860f12e0a4..160d57899f 100644
> --- a/include/standard-headers/linux/virtio_snd.h
> +++ b/include/standard-headers/linux/virtio_snd.h
> @@ -25,7 +25,7 @@ struct virtio_snd_config {
>   	uint32_t streams;
>   	/* # of available channel maps */
>   	uint32_t chmaps;
> -	/* # of available control elements */
> +	/* # of available control elements (if VIRTIO_SND_F_CTLS) */
>   	uint32_t controls;
>   };
>   
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index ec1e82bdc8..4e6aff08df 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -105,6 +105,7 @@ struct kvm_regs {
>   #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
>   #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
>   #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
> +#define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
>   
>   struct kvm_vcpu_init {
>   	__u32 target;
> @@ -365,6 +366,7 @@ enum {
>   	KVM_REG_ARM_STD_HYP_BIT_PV_TIME	= 0,
>   };
>   
> +/* Vendor hyper call function numbers 0-63 */
>   #define KVM_REG_ARM_VENDOR_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(2)
>   
>   enum {
> @@ -372,6 +374,14 @@ enum {
>   	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
>   };
>   
> +/* Vendor hyper call function numbers 64-127 */
> +#define KVM_REG_ARM_VENDOR_HYP_BMAP_2		KVM_REG_ARM_FW_FEAT_BMAP_REG(3)
> +
> +enum {
> +	KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_VER	= 0,
> +	KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_CPUS	= 1,
> +};
> +
>   /* Device Control API on vm fd */
>   #define KVM_ARM_VM_SMCCC_CTRL		0
>   #define   KVM_ARM_VM_SMCCC_FILTER	0
> @@ -394,6 +404,7 @@ enum {
>   #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
>   #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
>   #define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
> +#define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ  9
>   #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
>   #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
>   			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
> diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
> index d4e90fff76..ee9aaebdf3 100644
> --- a/linux-headers/asm-arm64/unistd_64.h
> +++ b/linux-headers/asm-arm64/unistd_64.h
> @@ -323,6 +323,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-generic/mman-common.h
> index 1ea2c4c33b..ef1c27fa3c 100644
> --- a/linux-headers/asm-generic/mman-common.h
> +++ b/linux-headers/asm-generic/mman-common.h
> @@ -85,6 +85,7 @@
>   /* compatibility flags */
>   #define MAP_FILE	0
>   
> +#define PKEY_UNRESTRICTED	0x0
>   #define PKEY_DISABLE_ACCESS	0x1
>   #define PKEY_DISABLE_WRITE	0x2
>   #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
> index 88dc393c2b..2892a45023 100644
> --- a/linux-headers/asm-generic/unistd.h
> +++ b/linux-headers/asm-generic/unistd.h
> @@ -849,9 +849,11 @@ __SYSCALL(__NR_getxattrat, sys_getxattrat)
>   __SYSCALL(__NR_listxattrat, sys_listxattrat)
>   #define __NR_removexattrat 466
>   __SYSCALL(__NR_removexattrat, sys_removexattrat)
> +#define __NR_open_tree_attr 467
> +__SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
>   
>   #undef __NR_syscalls
> -#define __NR_syscalls 467
> +#define __NR_syscalls 468
>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
> index 23fb96a8a7..50d22df8f7 100644
> --- a/linux-headers/asm-loongarch/unistd_64.h
> +++ b/linux-headers/asm-loongarch/unistd_64.h
> @@ -319,6 +319,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
> index 9a75719644..bdcc2f460b 100644
> --- a/linux-headers/asm-mips/unistd_n32.h
> +++ b/linux-headers/asm-mips/unistd_n32.h
> @@ -395,5 +395,6 @@
>   #define __NR_getxattrat (__NR_Linux + 464)
>   #define __NR_listxattrat (__NR_Linux + 465)
>   #define __NR_removexattrat (__NR_Linux + 466)
> +#define __NR_open_tree_attr (__NR_Linux + 467)
>   
>   #endif /* _ASM_UNISTD_N32_H */
> diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
> index 7086783b0c..3b6b0193b6 100644
> --- a/linux-headers/asm-mips/unistd_n64.h
> +++ b/linux-headers/asm-mips/unistd_n64.h
> @@ -371,5 +371,6 @@
>   #define __NR_getxattrat (__NR_Linux + 464)
>   #define __NR_listxattrat (__NR_Linux + 465)
>   #define __NR_removexattrat (__NR_Linux + 466)
> +#define __NR_open_tree_attr (__NR_Linux + 467)
>   
>   #endif /* _ASM_UNISTD_N64_H */
> diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
> index b3825823e4..4609a4b4d3 100644
> --- a/linux-headers/asm-mips/unistd_o32.h
> +++ b/linux-headers/asm-mips/unistd_o32.h
> @@ -441,5 +441,6 @@
>   #define __NR_getxattrat (__NR_Linux + 464)
>   #define __NR_listxattrat (__NR_Linux + 465)
>   #define __NR_removexattrat (__NR_Linux + 466)
> +#define __NR_open_tree_attr (__NR_Linux + 467)
>   
>   #endif /* _ASM_UNISTD_O32_H */
> diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
> index 38ee4dc35d..5d38a427e0 100644
> --- a/linux-headers/asm-powerpc/unistd_32.h
> +++ b/linux-headers/asm-powerpc/unistd_32.h
> @@ -448,6 +448,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_32_H */
> diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
> index 5e5f156834..860a488e4d 100644
> --- a/linux-headers/asm-powerpc/unistd_64.h
> +++ b/linux-headers/asm-powerpc/unistd_64.h
> @@ -420,6 +420,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
> index f06bc5efcd..5f59fd226c 100644
> --- a/linux-headers/asm-riscv/kvm.h
> +++ b/linux-headers/asm-riscv/kvm.h
> @@ -182,6 +182,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>   	KVM_RISCV_ISA_EXT_SVVPTC,
>   	KVM_RISCV_ISA_EXT_ZABHA,
>   	KVM_RISCV_ISA_EXT_ZICCRSE,
> +	KVM_RISCV_ISA_EXT_ZAAMO,
> +	KVM_RISCV_ISA_EXT_ZALRSC,
>   	KVM_RISCV_ISA_EXT_MAX,
>   };
>   
> diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
> index 74f6127aed..a5e769f1d9 100644
> --- a/linux-headers/asm-riscv/unistd_32.h
> +++ b/linux-headers/asm-riscv/unistd_32.h
> @@ -314,6 +314,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_32_H */
> diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
> index bb6a15a2ec..8df4d64841 100644
> --- a/linux-headers/asm-riscv/unistd_64.h
> +++ b/linux-headers/asm-riscv/unistd_64.h
> @@ -324,6 +324,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
> index 620201cb36..85eedbd18e 100644
> --- a/linux-headers/asm-s390/unistd_32.h
> +++ b/linux-headers/asm-s390/unistd_32.h
> @@ -439,5 +439,6 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   #endif /* _ASM_S390_UNISTD_32_H */
> diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
> index e7e4a10aaf..c03b1b9701 100644
> --- a/linux-headers/asm-s390/unistd_64.h
> +++ b/linux-headers/asm-s390/unistd_64.h
> @@ -387,5 +387,6 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   #endif /* _ASM_S390_UNISTD_64_H */
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 86f2c34e7a..dc591fb17e 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -557,6 +557,9 @@ struct kvm_x86_mce {
>   #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
>   #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
>   
> +#define KVM_XEN_MSR_MIN_INDEX			0x40000000u
> +#define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
> +
>   struct kvm_xen_hvm_config {
>   	__u32 flags;
>   	__u32 msr;
> diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
> index a2eb492a75..491d6b4eb6 100644
> --- a/linux-headers/asm-x86/unistd_32.h
> +++ b/linux-headers/asm-x86/unistd_32.h
> @@ -457,6 +457,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_32_H */
> diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
> index 2f5fc400f5..7cf88bf9bd 100644
> --- a/linux-headers/asm-x86/unistd_64.h
> +++ b/linux-headers/asm-x86/unistd_64.h
> @@ -380,6 +380,7 @@
>   #define __NR_getxattrat 464
>   #define __NR_listxattrat 465
>   #define __NR_removexattrat 466
> +#define __NR_open_tree_attr 467
>   
>   
>   #endif /* _ASM_UNISTD_64_H */
> diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
> index fecd832e7f..82959111e6 100644
> --- a/linux-headers/asm-x86/unistd_x32.h
> +++ b/linux-headers/asm-x86/unistd_x32.h
> @@ -333,6 +333,7 @@
>   #define __NR_getxattrat (__X32_SYSCALL_BIT + 464)
>   #define __NR_listxattrat (__X32_SYSCALL_BIT + 465)
>   #define __NR_removexattrat (__X32_SYSCALL_BIT + 466)
> +#define __NR_open_tree_attr (__X32_SYSCALL_BIT + 467)
>   #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
>   #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
>   #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
> diff --git a/linux-headers/linux/bits.h b/linux-headers/linux/bits.h
> index c0d00c0a98..58596d18f4 100644
> --- a/linux-headers/linux/bits.h
> +++ b/linux-headers/linux/bits.h
> @@ -4,13 +4,9 @@
>   #ifndef _LINUX_BITS_H
>   #define _LINUX_BITS_H
>   
> -#define __GENMASK(h, l) \
> -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> -         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> +#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
>   
> -#define __GENMASK_ULL(h, l) \
> -        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> -         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> +#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
>   
>   #define __GENMASK_U128(h, l) \
>   	((_BIT128((h)) << 1) - (_BIT128(l)))
> diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
> index 2122610de7..95ede23342 100644
> --- a/linux-headers/linux/const.h
> +++ b/linux-headers/linux/const.h
> @@ -33,7 +33,7 @@
>    * Missing __asm__ support
>    *
>    * __BIT128() would not work in the __asm__ code, as it shifts an
> - * 'unsigned __init128' data type as direct representation of
> + * 'unsigned __int128' data type as direct representation of
>    * 128 bit constants is not supported in the gcc compiler, as
>    * they get silently truncated.
>    *
> diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
> index ccbdca5e11..cb0f7d6b4d 100644
> --- a/linux-headers/linux/iommufd.h
> +++ b/linux-headers/linux/iommufd.h
> @@ -55,6 +55,7 @@ enum {
>   	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
>   	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
>   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
> +	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   };
>   
>   /**
> @@ -392,6 +393,9 @@ struct iommu_vfio_ioas {
>    *                          Any domain attached to the non-PASID part of the
>    *                          device must also be flagged, otherwise attaching a
>    *                          PASID will blocked.
> + *                          For the user that wants to attach PASID, ioas is
> + *                          not recommended for both the non-PASID part
> + *                          and PASID part of the device.
>    *                          If IOMMU does not support PASID it will return
>    *                          error (-EOPNOTSUPP).
>    */
> @@ -608,9 +612,17 @@ enum iommu_hw_info_type {
>    *                                   IOMMU_HWPT_GET_DIRTY_BITMAP
>    *                                   IOMMU_HWPT_SET_DIRTY_TRACKING
>    *
> + * @IOMMU_HW_CAP_PCI_PASID_EXEC: Execute Permission Supported, user ignores it
> + *                               when the struct
> + *                               iommu_hw_info::out_max_pasid_log2 is zero.
> + * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
> + *                               when the struct
> + *                               iommu_hw_info::out_max_pasid_log2 is zero.
>    */
>   enum iommufd_hw_capabilities {
>   	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
> +	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
> +	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
>   };
>   
>   /**
> @@ -626,6 +638,9 @@ enum iommufd_hw_capabilities {
>    *                 iommu_hw_info_type.
>    * @out_capabilities: Output the generic iommu capability info type as defined
>    *                    in the enum iommu_hw_capabilities.
> + * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
> + *                      PCI devices turn to out_capabilities to check if the
> + *                      specific capabilities is supported or not.
>    * @__reserved: Must be 0
>    *
>    * Query an iommu type specific hardware information data from an iommu behind
> @@ -649,7 +664,8 @@ struct iommu_hw_info {
>   	__u32 data_len;
>   	__aligned_u64 data_uptr;
>   	__u32 out_data_type;
> -	__u32 __reserved;
> +	__u8 out_max_pasid_log2;
> +	__u8 __reserved[3];
>   	__aligned_u64 out_capabilities;
>   };
>   #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
> @@ -1014,4 +1030,115 @@ struct iommu_ioas_change_process {
>   #define IOMMU_IOAS_CHANGE_PROCESS \
>   	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
>   
> +/**
> + * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
> + * @IOMMU_VEVENTQ_FLAG_LOST_EVENTS: vEVENTQ has lost vEVENTs
> + */
> +enum iommu_veventq_flag {
> +	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
> +};
> +
> +/**
> + * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
> + * @flags: Combination of enum iommu_veventq_flag
> + * @sequence: The sequence index of a vEVENT in the vEVENTQ, with a range of
> + *            [0, INT_MAX] where the following index of INT_MAX is 0
> + *
> + * Each iommufd_vevent_header reports a sequence index of the following vEVENT:
> + *
> + * +----------------------+-------+----------------------+-------+---+-------+
> + * | header0 {sequence=0} | data0 | header1 {sequence=1} | data1 |...| dataN |
> + * +----------------------+-------+----------------------+-------+---+-------+
> + *
> + * And this sequence index is expected to be monotonic to the sequence index of
> + * the previous vEVENT. If two adjacent sequence indexes has a delta larger than
> + * 1, it means that delta - 1 number of vEVENTs has lost, e.g. two lost vEVENTs:
> + *
> + * +-----+----------------------+-------+----------------------+-------+-----+
> + * | ... | header3 {sequence=3} | data3 | header6 {sequence=6} | data6 | ... |
> + * +-----+----------------------+-------+----------------------+-------+-----+
> + *
> + * If a vEVENT lost at the tail of the vEVENTQ and there is no following vEVENT
> + * providing the next sequence index, an IOMMU_VEVENTQ_FLAG_LOST_EVENTS header
> + * would be added to the tail, and no data would follow this header:
> + *
> + * +--+----------------------+-------+-----------------------------------------+
> + * |..| header3 {sequence=3} | data3 | header4 {flags=LOST_EVENTS, sequence=4} |
> + * +--+----------------------+-------+-----------------------------------------+
> + */
> +struct iommufd_vevent_header {
> +	__u32 flags;
> +	__u32 sequence;
> +};
> +
> +/**
> + * enum iommu_veventq_type - Virtual Event Queue Type
> + * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
> + * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
> + */
> +enum iommu_veventq_type {
> +	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
> +	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
> +};
> +
> +/**
> + * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
> + *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
> + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> + *       Reported event records: (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> + *       - 0x04 C_BAD_STE
> + *       - 0x06 F_STREAM_DISABLED
> + *       - 0x08 C_BAD_SUBSTREAMID
> + *       - 0x0a C_BAD_CD
> + *       - 0x10 F_TRANSLATION
> + *       - 0x11 F_ADDR_SIZE
> + *       - 0x12 F_ACCESS
> + *       - 0x13 F_PERMISSION
> + *
> + * StreamID field reports a virtual device ID. To receive a virtual event for a
> + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> + */
> +struct iommu_vevent_arm_smmuv3 {
> +	__aligned_le64 evt[4];
> +};
> +
> +/**
> + * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
> + * @size: sizeof(struct iommu_veventq_alloc)
> + * @flags: Must be 0
> + * @viommu_id: virtual IOMMU ID to associate the vEVENTQ with
> + * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
> + * @veventq_depth: Maximum number of events in the vEVENTQ
> + * @out_veventq_id: The ID of the new vEVENTQ
> + * @out_veventq_fd: The fd of the new vEVENTQ. User space must close the
> + *                  successfully returned fd after using it
> + * @__reserved: Must be 0
> + *
> + * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
> + * can have multiple FDs for different types, but is confined to one per @type.
> + * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
> + * if there are vEVENTs available. A vEVENTQ will lose events due to overflow,
> + * if the number of the vEVENTs hits @veventq_depth.
> + *
> + * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
> + * a type-specific data structure, in a normal case:
> + *
> + * +-+---------+-------+---------+-------+-----+---------+-------+-+
> + * | | header0 | data0 | header1 | data1 | ... | headerN | dataN | |
> + * +-+---------+-------+---------+-------+-----+---------+-------+-+
> + *
> + * unless a tailing IOMMU_VEVENTQ_FLAG_LOST_EVENTS header is logged (refer to
> + * struct iommufd_vevent_header).
> + */
> +struct iommu_veventq_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 viommu_id;
> +	__u32 type;
> +	__u32 veventq_depth;
> +	__u32 out_veventq_id;
> +	__u32 out_veventq_fd;
> +	__u32 __reserved;
> +};
> +#define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
>   #endif
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 27181b3dd8..e5f3e8b5a0 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -921,6 +921,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_PRE_FAULT_MEMORY 236
>   #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
>   #define KVM_CAP_X86_GUEST_MODE 238
> +#define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
>   
>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;
> diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
> index 17bf191573..113c4ceb78 100644
> --- a/linux-headers/linux/psp-sev.h
> +++ b/linux-headers/linux/psp-sev.h
> @@ -73,13 +73,20 @@ typedef enum {
>   	SEV_RET_INVALID_PARAM,
>   	SEV_RET_RESOURCE_LIMIT,
>   	SEV_RET_SECURE_DATA_INVALID,
> -	SEV_RET_INVALID_KEY = 0x27,
> -	SEV_RET_INVALID_PAGE_SIZE,
> -	SEV_RET_INVALID_PAGE_STATE,
> -	SEV_RET_INVALID_MDATA_ENTRY,
> -	SEV_RET_INVALID_PAGE_OWNER,
> -	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
> -	SEV_RET_RMP_INIT_REQUIRED,
> +	SEV_RET_INVALID_PAGE_SIZE          = 0x0019,
> +	SEV_RET_INVALID_PAGE_STATE         = 0x001A,
> +	SEV_RET_INVALID_MDATA_ENTRY        = 0x001B,
> +	SEV_RET_INVALID_PAGE_OWNER         = 0x001C,
> +	SEV_RET_AEAD_OFLOW                 = 0x001D,
> +	SEV_RET_EXIT_RING_BUFFER           = 0x001F,
> +	SEV_RET_RMP_INIT_REQUIRED          = 0x0020,
> +	SEV_RET_BAD_SVN                    = 0x0021,
> +	SEV_RET_BAD_VERSION                = 0x0022,
> +	SEV_RET_SHUTDOWN_REQUIRED          = 0x0023,
> +	SEV_RET_UPDATE_FAILED              = 0x0024,
> +	SEV_RET_RESTORE_REQUIRED           = 0x0025,
> +	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
> +	SEV_RET_INVALID_KEY                = 0x0027,
>   	SEV_RET_MAX,
>   } sev_ret_code;
>   
> diff --git a/linux-headers/linux/stddef.h b/linux-headers/linux/stddef.h
> index e1416f7937..e1fcfcf3b3 100644
> --- a/linux-headers/linux/stddef.h
> +++ b/linux-headers/linux/stddef.h
> @@ -70,4 +70,6 @@
>   #define __counted_by_be(m)
>   #endif
>   
> +#define __kernel_nonstring
> +
>   #endif /* _LINUX_STDDEF_H */
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index d0426b5ec0..79bf8c0cc5 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -932,29 +932,34 @@ struct vfio_device_bind_iommufd {
>    * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 19,
>    *					struct vfio_device_attach_iommufd_pt)
>    * @argsz:	User filled size of this data.
> - * @flags:	Must be 0.
> + * @flags:	Flags for attach.
>    * @pt_id:	Input the target id which can represent an ioas or a hwpt
>    *		allocated via iommufd subsystem.
>    *		Output the input ioas id or the attached hwpt id which could
>    *		be the specified hwpt itself or a hwpt automatically created
>    *		for the specified ioas by kernel during the attachment.
> + * @pasid:	The pasid to be attached, only meaningful when
> + *		VFIO_DEVICE_ATTACH_PASID is set in @flags
>    *
>    * Associate the device with an address space within the bound iommufd.
>    * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
>    * allowed on cdev fds.
>    *
> - * If a vfio device is currently attached to a valid hw_pagetable, without doing
> - * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
> - * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
> - * as a hw_pagetable replacement, will replace the device's currently attached
> - * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
> + * If a vfio device or a pasid of this device is currently attached to a valid
> + * hw_pagetable (hwpt), without doing a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second
> + * VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is allowed.
> + * This action, also known as a hw_pagetable replacement, will replace the
> + * currently attached hwpt of the device or the pasid of this device with a new
> + * hwpt corresponding to the given pt_id.
>    *
>    * Return: 0 on success, -errno on failure.
>    */
>   struct vfio_device_attach_iommufd_pt {
>   	__u32	argsz;
>   	__u32	flags;
> +#define VFIO_DEVICE_ATTACH_PASID	(1 << 0)
>   	__u32	pt_id;
> +	__u32	pasid;
>   };
>   
>   #define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 19)
> @@ -963,17 +968,21 @@ struct vfio_device_attach_iommufd_pt {
>    * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
>    *					struct vfio_device_detach_iommufd_pt)
>    * @argsz:	User filled size of this data.
> - * @flags:	Must be 0.
> + * @flags:	Flags for detach.
> + * @pasid:	The pasid to be detached, only meaningful when
> + *		VFIO_DEVICE_DETACH_PASID is set in @flags
>    *
> - * Remove the association of the device and its current associated address
> - * space.  After it, the device should be in a blocking DMA state.  This is only
> - * allowed on cdev fds.
> + * Remove the association of the device or a pasid of the device and its current
> + * associated address space.  After it, the device or the pasid should be in a
> + * blocking DMA state.  This is only allowed on cdev fds.
>    *
>    * Return: 0 on success, -errno on failure.
>    */
>   struct vfio_device_detach_iommufd_pt {
>   	__u32	argsz;
>   	__u32	flags;
> +#define VFIO_DEVICE_DETACH_PASID	(1 << 0)
> +	__u32	pasid;
>   };
>   
>   #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)


