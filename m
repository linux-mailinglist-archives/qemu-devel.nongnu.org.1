Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061DC7C8058
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:33:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDbj-00033j-DS; Fri, 13 Oct 2023 04:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qrDbf-00032j-W3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:33:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qrDbc-0006kG-L6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:33:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D8HE9N001329; Fri, 13 Oct 2023 08:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7l6MO0yUrJI8RxgKzl1Ef6o2BXvVmdp+n5vj4o9VhMY=;
 b=bao85rALidh1fYVqbKa1+is1/W3IwKSvcoYYmeEHQ7CMBZzALu42m5PtiA3alDVAaLwd
 pFxfPkGADv82sWNzW+YCgicSyNnxeaFFs7/6Gtj+gnfp5dZkHiZs2WM0KXXE86PaerTd
 UnBIUY5LL2ycolZx35w+RuDZlHbhPFFQ/O8NQEiTMRCK90WV/SxteEyZyeRzU1hSviKl
 ee5OgRNaFShHmh/Zrp3Sg91UNIWUCGYhxb9D7VpTdgkfvVQWbCEbF7eo7Bf2PMQf30j9
 CvOYm8iugeeWhWvQkrfL7UJaCslbRia8jDS+/fEQ735vRKMP+Og6BHKTuWjbB6e6A4rt RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq28e8gqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 08:32:55 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D8HD2g001201;
 Fri, 13 Oct 2023 08:32:54 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq28e8gqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 08:32:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D8VhjQ026141; Fri, 13 Oct 2023 08:32:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt54tnfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 08:32:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39D8WqXZ27656916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 08:32:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3CF658052;
 Fri, 13 Oct 2023 08:32:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E69175805D;
 Fri, 13 Oct 2023 08:32:49 +0000 (GMT)
Received: from [9.43.35.251] (unknown [9.43.35.251])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Oct 2023 08:32:49 +0000 (GMT)
Message-ID: <a9cb8b38-55fb-797c-a6b5-46a0811c6982@linux.ibm.com>
Date: Fri, 13 Oct 2023 14:02:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 58/78] hw/ppc: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <a8b851d14520d857fccaadb9097e9aa71bb7e1bc.1697183699.git.manos.pitsidianakis@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <a8b851d14520d857fccaadb9097e9aa71bb7e1bc.1697183699.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XpuqqcEmTkQfEKjukjeWa7bhEm8Kylo1
X-Proofpoint-GUID: xtS89O0S-LMr8O0zUU8Ia9TEtRcQcysl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130070
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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



On 10/13/23 13:27, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

One question below, may be Cedric knows better who introduced initial code.

> ---
>   hw/ppc/pnv_bmc.c      | 2 +-
>   hw/ppc/spapr_events.c | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 99f1e8d7f9..9bff7d03cb 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -172,69 +172,69 @@ static int hiomap_erase(PnvPnor *pnor, uint32_t offset, uint32_t size)
>   static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
>                          RspBuffer *rsp)
>   {
>       PnvPnor *pnor = PNV_PNOR(object_property_get_link(OBJECT(ibs), "pnor",
>                                                         &error_abort));
>       uint32_t pnor_size = pnor->size;
>       uint32_t pnor_addr = PNOR_SPI_OFFSET;
>       bool readonly = false;
>   
>       rsp_buffer_push(rsp, cmd[2]);
>       rsp_buffer_push(rsp, cmd[3]);
>   
>       switch (cmd[2]) {
>       case HIOMAP_C_MARK_DIRTY:
>       case HIOMAP_C_FLUSH:
>       case HIOMAP_C_ACK:
>           break;
>   
>       case HIOMAP_C_ERASE:
>           if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
>                           blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
>               rsp_buffer_set_error(rsp, IPMI_CC_UNSPECIFIED);
>           }
>           break;
>   
>       case HIOMAP_C_GET_INFO:
>           rsp_buffer_push(rsp, 2);  /* Version 2 */
>           rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
>           rsp_buffer_push(rsp, 0);  /* Timeout */
>           rsp_buffer_push(rsp, 0);  /* Timeout */
>           break;
>   
>       case HIOMAP_C_GET_FLASH_INFO:
>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
>           rsp_buffer_push(rsp, 0x01);  /* erase size */
>           rsp_buffer_push(rsp, 0x00);  /* erase size */
>           break;
>   
>       case HIOMAP_C_CREATE_READ_WINDOW:
>           readonly = true;
> -        /* Fall through */
> +        fallthrough;
>   
>       case HIOMAP_C_CREATE_WRITE_WINDOW:
>           memory_region_set_readonly(&pnor->mmio, readonly);
>           memory_region_set_enabled(&pnor->mmio, true);
>   
>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) & 0xFF);
>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) >> 8);
>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
>           rsp_buffer_push(rsp, 0x00); /* offset */
>           rsp_buffer_push(rsp, 0x00); /* offset */
>           break;
>   
>       case HIOMAP_C_CLOSE_WINDOW:
>           memory_region_set_enabled(&pnor->mmio, false);
>           break;
>   
>       case HIOMAP_C_DEVICE_NAME:
>       case HIOMAP_C_RESET:
>       case HIOMAP_C_LOCK:

Do we need a break here ?
Otherwise above 3 case statements doesnt add any value.

>       default:
>           qemu_log_mask(LOG_GUEST_ERROR, "HIOMAP: unknown command %02X\n", cmd[2]);
>           break;
>       }
>   }
>   
>   #define HIOMAP   0x5a
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 4508e40814..9d51746daf 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -411,25 +411,26 @@ static const SpaprEventSource *
>   rtas_event_log_to_source(SpaprMachineState *spapr, int log_type)
>   {
>       const SpaprEventSource *source;
>   
>       g_assert(spapr->event_sources);
>   
>       switch (log_type) {
>       case RTAS_LOG_TYPE_HOTPLUG:
>           source = spapr_event_sources_get_source(spapr->event_sources,
>                                                   EVENT_CLASS_HOT_PLUG);
>           if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
>               g_assert(source->enabled);
>               break;
>           }
>           /* fall through back to epow for legacy hotplug interrupt source */
> +        fallthrough;
>       case RTAS_LOG_TYPE_EPOW:
>           source = spapr_event_sources_get_source(spapr->event_sources,
>                                                   EVENT_CLASS_EPOW);
>           break;
>       default:
>           source = NULL;
>       }
>   
>       return source;
>   }

