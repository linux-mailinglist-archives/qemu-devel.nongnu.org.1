Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5CFA60010
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 19:51:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsneC-0008AG-P3; Thu, 13 Mar 2025 14:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsndx-000897-SE; Thu, 13 Mar 2025 14:51:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsndv-0004uY-Sj; Thu, 13 Mar 2025 14:50:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo6K6003549;
 Thu, 13 Mar 2025 18:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6HCXD/
 KzOYsqeTvYmanslDQrrpkk9EDWINfbVwLVVmM=; b=a7qmJDoTnns1IS3ejOmiF6
 TWe1U4pVfLXxl/yeTbpzOrrVEw+iCGRJIF4V1vk1Nl7bKi4ENEq4uTVW6X0k+Khz
 YoOX+6/JkXYZac2Ai7aGnXpw48a7eSPhgukreYeAIInvar3P7jeDtP5IjsAreZup
 7m1JChANd7HeC8zQNWimay9LNsrE7fNQ6wHsqdq8ViAgXPQ5WGR+W7ngbvTq6jTN
 BTZ+G1Ss6R2tWKECsk/MG92+GL2lYA2s3aH2nevc2EfkMLhr6ZnejY/nlNcbsIQ0
 9gL4ocwmlZQysJPsjmJlHlk5RIUYJwUPhBQBXlnG2TbeuhP6MAWgyuNOobpsPy9g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnrck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:50:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DIg9G6002495;
 Thu, 13 Mar 2025 18:50:53 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnrcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:50:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFwQsC026099;
 Thu, 13 Mar 2025 18:50:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspkcac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:50:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DIonaX37355894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 18:50:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74CC020040;
 Thu, 13 Mar 2025 18:50:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F35F820043;
 Thu, 13 Mar 2025 18:50:45 +0000 (GMT)
Received: from [9.124.223.53] (unknown [9.124.223.53])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 18:50:45 +0000 (GMT)
Message-ID: <0237f390-8a73-46df-b361-291f37208d82@linux.ibm.com>
Date: Fri, 14 Mar 2025 00:20:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/ppc: Add MDST/MDDT/MDRT table structures and
 offsets
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-5-adityag@linux.ibm.com>
 <4c87e14e-460e-4a59-b8e2-85ead830ee59@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <4c87e14e-460e-4a59-b8e2-85ead830ee59@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bJpkOln5tUxR2w-LMMTNXb8i4h-LU-B1
X-Proofpoint-ORIG-GUID: vcGkSPGARQc9BQ36k1AIXZMhJF57Ih-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 11/03/25 10:41, Harsh Prateek Bora wrote:

>
>
> On 2/17/25 12:49, Aditya Gupta wrote:
>> Add the MDST, MDDT, MDRT tables offsets and structures as per current
>> skiboot upstream:
>>
>>      commit bc7b85db1e7e ("opal-ci: Remove centos7")
>>
>> These structures will be later populated when preserving memory regions
>> for MPIPL
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/pnv_sbe.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 113 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
>> index 79818177fc36..361a3854307d 100644
>> --- a/hw/ppc/pnv_sbe.c
>> +++ b/hw/ppc/pnv_sbe.c
>
> These should have been added in include/hw/ppc/pnv_sbe.h
>
Got it, will move the #defines to a header.


>> @@ -84,6 +84,119 @@
>>     static uint64_t mpipl_skiboot_base = 0x30000000 /*default 
>> SKIBOOT_BASE*/;
>>   +/* Following offsets are copied from Skiboot source code */
>> +/* Use 768 bytes for SPIRAH */
>> +#define SPIRAH_OFF      0x00010000
>> +#define SPIRAH_SIZE     0x300
>> +
>> +/* Use 256 bytes for processor dump area */
>> +#define PROC_DUMP_AREA_OFF  (SPIRAH_OFF + SPIRAH_SIZE)
>> +#define PROC_DUMP_AREA_SIZE 0x100
>> +
>> +#define PROCIN_OFF      (PROC_DUMP_AREA_OFF + PROC_DUMP_AREA_SIZE)
>> +#define PROCIN_SIZE     0x800
>> +
>> +/* Offsets of MDST and MDDT tables from skiboot base */
>> +#define MDST_TABLE_OFF      (PROCIN_OFF + PROCIN_SIZE)
>> +#define MDST_TABLE_SIZE     0x400
>> +
>> +#define MDDT_TABLE_OFF      (MDST_TABLE_OFF + MDST_TABLE_SIZE)
>> +#define MDDT_TABLE_SIZE     0x400
>> +
>> +#define CPU_CTL_OFF         (MDDT_TABLE_OFF + MDDT_TABLE_SIZE)
>> +#define CPU_CTL_SIZE        0x2000
>> +
>> +/* MPIPL reserved regions (offset by skiboot_base to access) */
>> +#define MDST_TABLE_BASE     (mpipl_skiboot_base + MDST_TABLE_OFF)
>> +#define MDDT_TABLE_BASE     (mpipl_skiboot_base + MDDT_TABLE_OFF)
>> +#define PROC_DUMP_AREA_BASE (mpipl_skiboot_base + PROC_DUMP_AREA_OFF)
>> +
>> +#define __packed             __attribute__((packed))
>> +
>> +/* Metadata to capture before triggering MPIPL */
>> +struct mpipl_metadata {
>
> CamelCase for structs? Applies for other structs below.
Sure, will follow CamelCase. Had just copied the structs as it is.
>
>> +    /* Crashing PIR is required to create OPAL dump */
>> +    uint32_t    crashing_pir;
>> +    /* Kernel expects OPAL to presrve tag and pass it back via OPAL 
>> API */
>> +    uint64_t    kernel_tag;
>> +    /* Post MPIPL kernel boot memory size */
>> +    uint64_t    boot_mem_size;
>> +} __packed;
>> +
>> +/* Structure version */
>> +#define OPAL_MPIPL_VERSION  0x01
>> +
>> +/* Preserved memory details */
>> +struct opal_mpipl_region {
>> +    __be64  src;
>> +    __be64  dest;
>> +    __be64  size;
>> +};
>> +
>> +struct opal_mpipl_fadump {
>> +    uint8_t version;
>> +    uint8_t reserved[7];
>> +    __be32  crashing_pir;    /* OPAL crashing CPU PIR */
>> +    __be32  cpu_data_version;
>> +    __be32  cpu_data_size;
>> +    __be32  region_cnt;
>> +    struct  opal_mpipl_region *region;
>> +};
>> +
>> +/*
>> + * This is our dump result table after MPIPL. Hostboot will write to 
>> this
>> + * memory after moving memory content from source to destination 
>> memory.
>> + */
>> +#define MDRT_TABLE_BASE        (mpipl_skiboot_base + 0x01c00000)
>> +#define MDRT_TABLE_SIZE        0x00008000
>> +
>> +/*
>> + * This is our dump metadata area. We will use this memory to save 
>> metadata
>> + * (like crashing CPU details, payload tags) before triggering MPIPL.
>> + */
>> +#define DUMP_METADATA_AREA_BASE    (mpipl_skiboot_base + 0x01c08000)
>> +#define DUMP_METADATA_AREA_SIZE    0x8000
>> +
>> +/*
>> + *  Memory Dump Source Table
>> + *
>> + * Format of this table is same as Memory Dump Source Table (MDST)
>> + * defined in HDAT spec.
>> + */
>> +struct mdst_table {
>> +    __be64  addr;
>> +    uint8_t data_region;    /* DUMP_REGION_* */
>> +    uint8_t dump_type;    /* DUMP_TYPE_* */
>> +    __be16  reserved;
>> +    __be32  size;
>> +} __packed;
>> +
>> +/* Memory dump destination table (MDDT) */
>> +struct mddt_table {
>> +    __be64  addr;
>> +    uint8_t data_region;
>> +    uint8_t dump_type;
>> +    __be16  reserved;
>> +    __be32  size;
>> +} __packed;
>
> If both mdst_table and mddt_table are supposed to be same, we could have
> just one mdxt_table and variable instances could be named mdst/mddt.

Agreed. But mdxt might be confusing, as 'mdrt' has a different structure.

Maybe will do a 'typedef MdstTable MddtTable' ?


Thanks,

- Aditya G

>
> Thanks
> Harsh
>

