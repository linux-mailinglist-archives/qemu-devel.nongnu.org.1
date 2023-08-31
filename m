Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2778E758
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:46:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcMI-0008LG-Eu; Thu, 31 Aug 2023 03:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcMF-0008KP-Fc; Thu, 31 Aug 2023 03:44:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcMC-0008R9-Vs; Thu, 31 Aug 2023 03:44:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V7fQKa003959; Thu, 31 Aug 2023 07:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LrqZQZRG2HA907WHLdcaH5RVAyOtdfB0qgWoC6rju0A=;
 b=ee36yvkhMXjwOU4yXvSe0WQf1mgHnx5k5y2mGCkqpPjmph9G7ilDduKtH+LD8ti8NU8H
 dWxLCcKOZKb1MTZIC3Zc77ZWoD7W6o8sp7uq1BLtfrYKZlOTXpaSNUKeEIT727u055h1
 bA4Lt5VEtDXw48ra3nn2X0Cnu6YrUmZH+JK4wtkjVNyDcyktZNyMbg9Qf0MijCfKOf+v
 LnAHiz+70xTkeM/wLYKZlh7KewkLCtXGLbzdl+H8g3YPw//tYILlbgsppYnPJCeMv4gF
 9qb2toxmeiaLMNl+FrDJw6JQj9LDHBmknvFu2GB/+aSwW1olz3ZHiOh7YFzPTY6tfUd5 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st71epq58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:44:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37V7fMPD003735;
 Thu, 31 Aug 2023 07:44:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st71epq52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:44:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V7BhhF009941; Thu, 31 Aug 2023 07:44:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7ktf84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:44:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37V7ierc20054760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 07:44:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8FC720043;
 Thu, 31 Aug 2023 07:44:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65E9920040;
 Thu, 31 Aug 2023 07:44:40 +0000 (GMT)
Received: from [9.179.13.135] (unknown [9.179.13.135])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 31 Aug 2023 07:44:40 +0000 (GMT)
Message-ID: <288cb639-0b1a-9f46-d348-731c201cc535@linux.ibm.com>
Date: Thu, 31 Aug 2023 09:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] ppc/xive: Use address_space routines to access the
 machine RAM
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230829143236.219348-1-clg@kaod.org>
 <20230829143236.219348-2-clg@kaod.org>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230829143236.219348-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RFQN5YICXpQCJm6wnE-XCLyOrmj0Fle4
X-Proofpoint-GUID: U87UBPhIvndXeyLdF6jYxjZY5a_OqdvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_05,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310067
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 29/08/2023 16:32, Cédric Le Goater wrote:
> to log an error in case of bad configuration of the XIVE tables by the FW.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/intc/pnv_xive.c  | 27 +++++++++++++++++++++++----
>   hw/intc/pnv_xive2.c | 27 +++++++++++++++++++++++----
>   2 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index e536b3ec26e5..b2bafd61b157 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -242,12 +242,20 @@ static int pnv_xive_vst_read(PnvXive *xive, uint32_t type, uint8_t blk,
>   {
>       const XiveVstInfo *info = &vst_infos[type];
>       uint64_t addr = pnv_xive_vst_addr(xive, type, blk, idx);
> +    MemTxResult result;
>   
>       if (!addr) {
>           return -1;
>       }
>   
> -    cpu_physical_memory_read(addr, data, info->size);
> +    result = address_space_read(&address_space_memory, addr,
> +                                MEMTXATTRS_UNSPECIFIED, data,
> +                                info->size);


I had been wondering which is the "right" API to update the guest 
memory. Since the cpu_physical_memory_* family ends up calling its 
address_space_* equivalent, I'm guessing the point of the change is 
really to catch any error and remove any potential ambiguity about the 
address space?

In any case,
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


> +    if (result != MEMTX_OK) {
> +        xive_error(xive, "VST: read failed at @0x%" HWADDR_PRIx
> +                   " for VST %s %x/%x\n", addr, info->name, blk, idx);
> +        return -1;
> +    }
>       return 0;
>   }
>   
> @@ -258,16 +266,27 @@ static int pnv_xive_vst_write(PnvXive *xive, uint32_t type, uint8_t blk,
>   {
>       const XiveVstInfo *info = &vst_infos[type];
>       uint64_t addr = pnv_xive_vst_addr(xive, type, blk, idx);
> +    MemTxResult result;
>   
>       if (!addr) {
>           return -1;
>       }
>   
>       if (word_number == XIVE_VST_WORD_ALL) {
> -        cpu_physical_memory_write(addr, data, info->size);
> +        result = address_space_write(&address_space_memory, addr,
> +                                     MEMTXATTRS_UNSPECIFIED, data,
> +                                     info->size);
>       } else {
> -        cpu_physical_memory_write(addr + word_number * 4,
> -                                  data + word_number * 4, 4);
> +        result = address_space_write(&address_space_memory,
> +                                     addr + word_number * 4,
> +                                     MEMTXATTRS_UNSPECIFIED,
> +                                     data + word_number * 4, 4);
> +    }
> +
> +    if (result != MEMTX_OK) {
> +        xive_error(xive, "VST: write failed at @0x%" HWADDR_PRIx
> +                    "for VST %s %x/%x\n", addr, info->name, blk, idx);
> +        return -1;
>       }
>       return 0;
>   }
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index bbb44a533cff..4b8d0a5d8120 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -240,12 +240,20 @@ static int pnv_xive2_vst_read(PnvXive2 *xive, uint32_t type, uint8_t blk,
>   {
>       const XiveVstInfo *info = &vst_infos[type];
>       uint64_t addr = pnv_xive2_vst_addr(xive, type, blk, idx);
> +    MemTxResult result;
>   
>       if (!addr) {
>           return -1;
>       }
>   
> -    cpu_physical_memory_read(addr, data, info->size);
> +    result = address_space_read(&address_space_memory, addr,
> +                                MEMTXATTRS_UNSPECIFIED, data,
> +                                info->size);
> +    if (result != MEMTX_OK) {
> +        xive2_error(xive, "VST: read failed at @0x%" HWADDR_PRIx
> +                   " for VST %s %x/%x\n", addr, info->name, blk, idx);
> +        return -1;
> +    }
>       return 0;
>   }
>   
> @@ -256,16 +264,27 @@ static int pnv_xive2_vst_write(PnvXive2 *xive, uint32_t type, uint8_t blk,
>   {
>       const XiveVstInfo *info = &vst_infos[type];
>       uint64_t addr = pnv_xive2_vst_addr(xive, type, blk, idx);
> +    MemTxResult result;
>   
>       if (!addr) {
>           return -1;
>       }
>   
>       if (word_number == XIVE_VST_WORD_ALL) {
> -        cpu_physical_memory_write(addr, data, info->size);
> +        result = address_space_write(&address_space_memory, addr,
> +                                     MEMTXATTRS_UNSPECIFIED, data,
> +                                     info->size);
>       } else {
> -        cpu_physical_memory_write(addr + word_number * 4,
> -                                  data + word_number * 4, 4);
> +        result = address_space_write(&address_space_memory,
> +                                     addr + word_number * 4,
> +                                     MEMTXATTRS_UNSPECIFIED,
> +                                     data + word_number * 4, 4);
> +    }
> +
> +    if (result != MEMTX_OK) {
> +        xive2_error(xive, "VST: write failed at @0x%" HWADDR_PRIx
> +                   "for VST %s %x/%x\n", addr, info->name, blk, idx);
> +        return -1;
>       }
>       return 0;
>   }

