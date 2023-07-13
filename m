Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A0752506
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 16:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJx8w-0008R5-6n; Thu, 13 Jul 2023 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJx8s-0008QV-7i
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 10:18:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJx8p-0000Q8-VC
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 10:18:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DE6sSP032152; Thu, 13 Jul 2023 14:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=er+J+1oEAK+TQVmgcwN/dS3a9+UzAca+6DLI3M4kAis=;
 b=tcSpJvpOLA4MeysaXvptL2wzSPS6i6EeuNbHf6QlmW7oiTAa+ncPX1/GYd+JT06FUDcX
 H5DCGGbxSQr6JhOdLm9Cryc3uGYvnoCra84sHNealuM3njXuCZGO7G16DxJpicHYr8CA
 Q9ERi/tYPx6K2mC1a6Aan0TLoP+1Dfkaydoor96D5cK48q+iaOsnlT41vTtGcqxHTgxj
 bkxEQ9cWFqehWam9lNWe5wHA1c4Vwv3ncbiTnS3qdH/LMGn7j40q2cugZpFyU4uxRENF
 Z53qhfI/Uar5n5TqzkbKa9CqDQo6NdcOMq31vf7ewnxB2BM2E0svFOTrVr1QZ05a3VHP ng== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtjhprn7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 14:17:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDvlPF006619; Thu, 13 Jul 2023 14:17:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqj4rr3ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 14:17:55 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DEHt5f4850416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 14:17:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AD9358056;
 Thu, 13 Jul 2023 14:17:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD88358061;
 Thu, 13 Jul 2023 14:17:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 14:17:54 +0000 (GMT)
Message-ID: <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
Date: Thu, 13 Jul 2023 10:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-5-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wCDWnNrfXXfsjmjN_YiRQiknN8NlgDEL
X-Proofpoint-GUID: wCDWnNrfXXfsjmjN_YiRQiknN8NlgDEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/12/23 23:51, Joelle van Dyne wrote:
> On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
> the exception is not decoded by hardware and we cannot trap the MMIO
> read. This led to the idea from @agraf to use the same mapping type as
> ROM devices: namely that reads should be seen as memory type and
> writes should trap as MMIO.
> 
> Once that was done, the second memory mapping of the command buffer
> region was redundent and was removed.
> 
> A note about the removal of the read trap for `CRB_LOC_STATE`:
> The only usage was to return the most up-to-date value for
> `tpmEstablished`. However, `tpmEstablished` is only set when a
> TPM2_HashStart operation is called which only exists for locality 4.
> Indeed, the comment for the write handler of `CRB_LOC_CTRL` makes the
> same argument for why it is not calling the backend to reset the
> `tpmEstablished` bit. As this bit is unused, we do not need to worry
> about updating it for reads.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/tpm/tpm_crb.h        |   2 -
>   hw/tpm/tpm_crb.c        |   3 -
>   hw/tpm/tpm_crb_common.c | 124 ++++++++++++++++++++--------------------
>   3 files changed, 63 insertions(+), 66 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> index da3a0cf256..7cdd37335f 100644
> --- a/hw/tpm/tpm_crb.h
> +++ b/hw/tpm/tpm_crb.h
> @@ -26,9 +26,7 @@
>   typedef struct TPMCRBState {
>       TPMBackend *tpmbe;
>       TPMBackendCmd cmd;
> -    uint32_t regs[TPM_CRB_R_MAX];
>       MemoryRegion mmio;
> -    MemoryRegion cmdmem;
> 
>       size_t be_buffer_size;
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 598c3e0161..07c6868d8d 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -68,7 +68,6 @@ static const VMStateDescription vmstate_tpm_crb_none = {
>       .name = "tpm-crb",
>       .pre_save = tpm_crb_none_pre_save,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),

This has to stay here otherwise we cannot restart VMs from saved state once QEMU is upgraded.

2023-07-13T14:15:43.997718Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
2023-07-13T14:15:43.997813Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
2023-07-13T14:15:43.997841Z qemu-system-x86_64: load of migration failed: Invalid argument


    Stefan

