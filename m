Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB9873FBE2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:20:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7g9-0000Dm-P0; Tue, 27 Jun 2023 08:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qE7g5-00009p-51; Tue, 27 Jun 2023 08:20:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qE7g2-0003Se-5J; Tue, 27 Jun 2023 08:20:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RCGTXn012865; Tue, 27 Jun 2023 12:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+lZDRCllQ1I00vuloyO2UhAzbevOCZJ69Dr+tZP0FdQ=;
 b=XLirgCa/vZOm/a4Eof/AGJkhX4DaDRS2r7nU1xLBQxxoyP50acwexUDYEbAxiy5Ln/FP
 A3Kd89ytkj5f4tHFIZOWYLz7/O9RIpxde+BjX9nl3T4YOpsg9uM0cLfCJGzVia4hSe2/
 hxZzCc0f5gz00FrRHNjGqbacIpzgr3eOrAK11r0jKSFj8yqs322P31afDCXF1sBi9Q8O
 GNFnI4Z+3cIz2kiegt5YL0YkVg8qFd54CiY+GlMx7CwiEt1bTnWe4zWk5I99lmOpRG39
 tYm+w+UnO5KXIWT3ggJs/HBZQdWTiDfd6KSfy2FKmyEky763sxX8pYD4pRxilXBCKdA1 kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfymn82tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:20:07 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35RCJSR9022729;
 Tue, 27 Jun 2023 12:20:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfymn82rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:20:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35RBO6Np029129;
 Tue, 27 Jun 2023 12:19:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre1u2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:19:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RCJ58h17826504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 12:19:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDBA520043;
 Tue, 27 Jun 2023 12:19:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84A9D20040;
 Tue, 27 Jun 2023 12:19:05 +0000 (GMT)
Received: from [9.152.224.114] (unknown [9.152.224.114])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 12:19:05 +0000 (GMT)
Message-ID: <585834bf-33a0-2a64-0bba-f1f47df41275@linux.ibm.com>
Date: Tue, 27 Jun 2023 14:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pc-bios/s390-ccw: Get rid of the the __u* types
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, cohuck@redhat.com,
 Juan Quintela <quintela@redhat.com>
References: <20230627114101.122231-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230627114101.122231-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: doLHMEvRh2Q78YQ2BYB2PVcUohLbgPd-
X-Proofpoint-GUID: icOpaBMA2o_Yuqd5h4SQxvXR-KEFj5W8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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



Am 27.06.23 um 13:41 schrieb Thomas Huth:
> Using types starting with double underscores should be avoided since these
> names are marked as reserved by the C standard. The corresponding Linux

In general I think this change is fine, but this is kind of interesting, as
/usr/include/linux/types.h does have __u64 and friends. In fact there is
__u64 but not u64 in /usr/include.

And yes a google search for double underscore  has

The use of two underscores (` __ ') in identifiers is reserved for the
compiler's internal use according to the ANSI-C standard. Underscores
(` _ ') are often used in names of library functions (such as " _main
" and " _exit "). In order to avoid collisions, do not begin an
identifier with an underscore.

> kernel header file has also been changed accordingly a long time ago:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a

but IIRC from a kernel perspective u64 is for kernel internal uint64_t
and __u64 is for uapi, e.g. see
https://lkml.indiana.edu/hypermail/linux/kernel/1401.2/02851.html

So in essence we (QEMU/s390-ccw) have to decide what to use for our
internal purposes. And yes, u64 and this patch is certainly ok. But
we might need to change the patch description

> 
> So we should get rid of the __u* in the s390-ccw bios now finally, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Based-on: <20230510143925.4094-4-quintela@redhat.com>
> 
>   pc-bios/s390-ccw/cio.h      | 232 ++++++++++++++++++------------------
>   pc-bios/s390-ccw/s390-ccw.h |   4 -
>   2 files changed, 116 insertions(+), 120 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index efeb449572..c977a52b50 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -17,10 +17,6 @@ typedef unsigned char      u8;
>   typedef unsigned short     u16;
>   typedef unsigned int       u32;
>   typedef unsigned long long u64;
> -typedef unsigned char      __u8;
> -typedef unsigned short     __u16;
> -typedef unsigned int       __u32;
> -typedef unsigned long long __u64;
>   
>   #define true 1
>   #define false 0
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 88a88adfd2..8b18153deb 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -17,32 +17,32 @@
>    * path management control word
>    */
>   struct pmcw {
> -    __u32 intparm;      /* interruption parameter */
> -    __u32 qf:1;         /* qdio facility */
> -    __u32 w:1;
> -    __u32 isc:3;        /* interruption subclass */
> -    __u32 res5:3;       /* reserved zeros */
> -    __u32 ena:1;        /* enabled */
> -    __u32 lm:2;         /* limit mode */
> -    __u32 mme:2;        /* measurement-mode enable */
> -    __u32 mp:1;         /* multipath mode */
> -    __u32 tf:1;         /* timing facility */
> -    __u32 dnv:1;        /* device number valid */
> -    __u32 dev:16;       /* device number */
> -    __u8  lpm;          /* logical path mask */
> -    __u8  pnom;         /* path not operational mask */
> -    __u8  lpum;         /* last path used mask */
> -    __u8  pim;          /* path installed mask */
> -    __u16 mbi;          /* measurement-block index */
> -    __u8  pom;          /* path operational mask */
> -    __u8  pam;          /* path available mask */
> -    __u8  chpid[8];     /* CHPID 0-7 (if available) */
> -    __u32 unused1:8;    /* reserved zeros */
> -    __u32 st:3;         /* subchannel type */
> -    __u32 unused2:18;   /* reserved zeros */
> -    __u32 mbfc:1;       /* measurement block format control */
> -    __u32 xmwme:1;      /* extended measurement word mode enable */
> -    __u32 csense:1;     /* concurrent sense; can be enabled ...*/
> +    u32 intparm;        /* interruption parameter */
> +    u32 qf:1;           /* qdio facility */
> +    u32 w:1;
> +    u32 isc:3;          /* interruption subclass */
> +    u32 res5:3;         /* reserved zeros */
> +    u32 ena:1;          /* enabled */
> +    u32 lm:2;           /* limit mode */
> +    u32 mme:2;          /* measurement-mode enable */
> +    u32 mp:1;           /* multipath mode */
> +    u32 tf:1;           /* timing facility */
> +    u32 dnv:1;          /* device number valid */
> +    u32 dev:16;         /* device number */
> +    u8  lpm;            /* logical path mask */
> +    u8  pnom;           /* path not operational mask */
> +    u8  lpum;           /* last path used mask */
> +    u8  pim;            /* path installed mask */
> +    u16 mbi;            /* measurement-block index */
> +    u8  pom;            /* path operational mask */
> +    u8  pam;            /* path available mask */
> +    u8  chpid[8];       /* CHPID 0-7 (if available) */
> +    u32 unused1:8;      /* reserved zeros */
> +    u32 st:3;           /* subchannel type */
> +    u32 unused2:18;     /* reserved zeros */
> +    u32 mbfc:1;         /* measurement block format control */
> +    u32 xmwme:1;        /* extended measurement word mode enable */
> +    u32 csense:1;       /* concurrent sense; can be enabled ...*/
>                           /*  ... per MSCH, however, if facility */
>                           /*  ... is not installed, this results */
>                           /*  ... in an operand exception.       */
> @@ -50,24 +50,24 @@ struct pmcw {
>   
>   /* Target SCHIB configuration. */
>   struct schib_config {
> -    __u64 mba;
> -    __u32 intparm;
> -    __u16 mbi;
> -    __u32 isc:3;
> -    __u32 ena:1;
> -    __u32 mme:2;
> -    __u32 mp:1;
> -    __u32 csense:1;
> -    __u32 mbfc:1;
> +    u64 mba;
> +    u32 intparm;
> +    u16 mbi;
> +    u32 isc:3;
> +    u32 ena:1;
> +    u32 mme:2;
> +    u32 mp:1;
> +    u32 csense:1;
> +    u32 mbfc:1;
>   } __attribute__ ((packed));
>   
>   struct scsw {
> -    __u16 flags;
> -    __u16 ctrl;
> -    __u32 cpa;
> -    __u8 dstat;
> -    __u8 cstat;
> -    __u16 count;
> +    u16 flags;
> +    u16 ctrl;
> +    u32 cpa;
> +    u8 dstat;
> +    u8 cstat;
> +    u16 count;
>   } __attribute__ ((packed));
>   
>   /* Function Control */
> @@ -117,42 +117,42 @@ struct scsw {
>   typedef struct schib {
>       struct pmcw pmcw;     /* path management control word */
>       struct scsw scsw;     /* subchannel status word */
> -    __u64 mba;            /* measurement block address */
> -    __u8 mda[4];          /* model dependent area */
> +    u64 mba;              /* measurement block address */
> +    u8 mda[4];            /* model dependent area */
>   } __attribute__ ((packed, aligned(4))) Schib;
>   
>   typedef struct subchannel_id {
>       union {
>           struct {
> -            __u16 cssid:8;
> -            __u16 reserved:4;
> -            __u16 m:1;
> -            __u16 ssid:2;
> -            __u16 one:1;
> +            u16 cssid:8;
> +            u16 reserved:4;
> +            u16 m:1;
> +            u16 ssid:2;
> +            u16 one:1;
>           };
> -        __u16 sch_id;
> +        u16 sch_id;
>       };
> -    __u16 sch_no;
> +    u16 sch_no;
>   } __attribute__ ((packed, aligned(4))) SubChannelId;
>   
>   struct chsc_header {
> -    __u16 length;
> -    __u16 code;
> +    u16 length;
> +    u16 code;
>   } __attribute__((packed));
>   
>   typedef struct chsc_area_sda {
>       struct chsc_header request;
> -    __u8 reserved1:4;
> -    __u8 format:4;
> -    __u8 reserved2;
> -    __u16 operation_code;
> -    __u32 reserved3;
> -    __u32 reserved4;
> -    __u32 operation_data_area[252];
> +    u8 reserved1:4;
> +    u8 format:4;
> +    u8 reserved2;
> +    u16 operation_code;
> +    u32 reserved3;
> +    u32 reserved4;
> +    u32 operation_data_area[252];
>       struct chsc_header response;
> -    __u32 reserved5:4;
> -    __u32 format2:4;
> -    __u32 reserved6:24;
> +    u32 reserved5:4;
> +    u32 format2:4;
> +    u32 reserved6:24;
>   } __attribute__((packed)) ChscAreaSda;
>   
>   /*
> @@ -160,37 +160,37 @@ typedef struct chsc_area_sda {
>    */
>   struct tpi_info {
>       struct subchannel_id schid;
> -    __u32 intparm;      /* interruption parameter */
> -    __u32 adapter_IO:1;
> -    __u32 reserved2:1;
> -    __u32 isc:3;
> -    __u32 reserved3:12;
> -    __u32 int_type:3;
> -    __u32 reserved4:12;
> +    u32 intparm;      /* interruption parameter */
> +    u32 adapter_IO:1;
> +    u32 reserved2:1;
> +    u32 isc:3;
> +    u32 reserved3:12;
> +    u32 int_type:3;
> +    u32 reserved4:12;
>   } __attribute__ ((packed, aligned(4)));
>   
>   /* channel command word (format 0) */
>   typedef struct ccw0 {
> -    __u8 cmd_code;
> -    __u32 cda:24;
> -    __u32 chainData:1;
> -    __u32 chain:1;
> -    __u32 sli:1;
> -    __u32 skip:1;
> -    __u32 pci:1;
> -    __u32 ida:1;
> -    __u32 suspend:1;
> -    __u32 mida:1;
> -    __u8 reserved;
> -    __u16 count;
> +    u8 cmd_code;
> +    u32 cda:24;
> +    u32 chainData:1;
> +    u32 chain:1;
> +    u32 sli:1;
> +    u32 skip:1;
> +    u32 pci:1;
> +    u32 ida:1;
> +    u32 suspend:1;
> +    u32 mida:1;
> +    u8 reserved;
> +    u16 count;
>   } __attribute__ ((packed, aligned(8))) Ccw0;
>   
>   /* channel command word (format 1) */
>   typedef struct ccw1 {
> -    __u8 cmd_code;
> -    __u8 flags;
> -    __u16 count;
> -    __u32 cda;
> +    u8 cmd_code;
> +    u8 flags;
> +    u16 count;
> +    u32 cda;
>   } __attribute__ ((packed, aligned(8))) Ccw1;
>   
>   /* do_cio() CCW formats */
> @@ -234,31 +234,31 @@ typedef struct ccw1 {
>    * Command-mode operation request block
>    */
>   typedef struct cmd_orb {
> -    __u32 intparm;    /* interruption parameter */
> -    __u32 key:4;      /* flags, like key, suspend control, etc. */
> -    __u32 spnd:1;     /* suspend control */
> -    __u32 res1:1;     /* reserved */
> -    __u32 mod:1;      /* modification control */
> -    __u32 sync:1;     /* synchronize control */
> -    __u32 fmt:1;      /* format control */
> -    __u32 pfch:1;     /* prefetch control */
> -    __u32 isic:1;     /* initial-status-interruption control */
> -    __u32 alcc:1;     /* address-limit-checking control */
> -    __u32 ssic:1;     /* suppress-suspended-interr. control */
> -    __u32 res2:1;     /* reserved */
> -    __u32 c64:1;      /* IDAW/QDIO 64 bit control  */
> -    __u32 i2k:1;      /* IDAW 2/4kB block size control */
> -    __u32 lpm:8;      /* logical path mask */
> -    __u32 ils:1;      /* incorrect length */
> -    __u32 zero:6;     /* reserved zeros */
> -    __u32 orbx:1;     /* ORB extension control */
> -    __u32 cpa;    /* channel program address */
> +    u32 intparm;    /* interruption parameter */
> +    u32 key:4;      /* flags, like key, suspend control, etc. */
> +    u32 spnd:1;     /* suspend control */
> +    u32 res1:1;     /* reserved */
> +    u32 mod:1;      /* modification control */
> +    u32 sync:1;     /* synchronize control */
> +    u32 fmt:1;      /* format control */
> +    u32 pfch:1;     /* prefetch control */
> +    u32 isic:1;     /* initial-status-interruption control */
> +    u32 alcc:1;     /* address-limit-checking control */
> +    u32 ssic:1;     /* suppress-suspended-interr. control */
> +    u32 res2:1;     /* reserved */
> +    u32 c64:1;      /* IDAW/QDIO 64 bit control  */
> +    u32 i2k:1;      /* IDAW 2/4kB block size control */
> +    u32 lpm:8;      /* logical path mask */
> +    u32 ils:1;      /* incorrect length */
> +    u32 zero:6;     /* reserved zeros */
> +    u32 orbx:1;     /* ORB extension control */
> +    u32 cpa;        /* channel program address */
>   }  __attribute__ ((packed, aligned(4))) CmdOrb;
>   
>   struct ciw {
> -    __u8 type;
> -    __u8 command;
> -    __u16 count;
> +    u8 type;
> +    u8 command;
> +    u16 count;
>   };
>   
>   #define CU_TYPE_UNKNOWN         0x0000
> @@ -271,12 +271,12 @@ struct ciw {
>    */
>   typedef struct senseid {
>       /* common part */
> -    __u8  reserved;   /* always 0x'FF' */
> -    __u16 cu_type;    /* control unit type */
> -    __u8  cu_model;   /* control unit model */
> -    __u16 dev_type;   /* device type */
> -    __u8  dev_model;  /* device model */
> -    __u8  unused;     /* padding byte */
> +    u8  reserved;   /* always 0x'FF' */
> +    u16 cu_type;    /* control unit type */
> +    u8  cu_model;   /* control unit model */
> +    u16 dev_type;   /* device type */
> +    u8  dev_model;  /* device model */
> +    u8  unused;     /* padding byte */
>       /* extended part */
>       struct ciw ciw[62];
>   }  __attribute__ ((packed, aligned(4))) SenseId;
> @@ -342,9 +342,9 @@ typedef struct SenseDataEckdDasd {
>   /* interruption response block */
>   typedef struct irb {
>       struct scsw scsw;
> -    __u32 esw[5];
> -    __u32 ecw[8];
> -    __u32 emw[8];
> +    u32 esw[5];
> +    u32 ecw[8];
> +    u32 emw[8];
>   }  __attribute__ ((packed, aligned(4))) Irb;
>   
>   /* Used for SEEK ccw commands */

