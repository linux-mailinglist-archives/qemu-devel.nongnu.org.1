Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC6753A50
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHW2-0006ze-4L; Fri, 14 Jul 2023 08:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKHVy-0006yt-J8
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:03:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKHVw-0005qm-Je
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:03:14 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EBt0g5008389; Fri, 14 Jul 2023 12:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JFXARV3nemiI6GbBBX1Vfux3RoJx9hYh8A2lB9XRudE=;
 b=l4xuSGEuXqrqeOX2766P+LixFSYcRix+lAgP5nTJtSS3UiGIUToWn9Xs+dALkO6oYFT7
 R5Ssfh6pu1T/4Y/F/tl5kAJf+/2jcKN+Gr+f1XOOLJLGKIXGzMuSYNwJYAnHaPKVUVxi
 hpoZ/BNXF75Fr7xaAQJRvXkwSIhFPMUibLUJ64AIm2p6f/BjVqTtKUWPefe9Uyiot0ts
 EiIHN9PjUEpMG1g+4rl01NZT8lLIJyp6dAE5B2ZNzLL1jVvDfPxnWWMWcBK4ee3Bc1Yi
 ahnYwBFaz77DgvI7rici6kRcZS84ZMGiew1NcVxFZjpZyOJMZalQPRDi4SDN8u7ZA3BL Cw== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru5wb06hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 12:03:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36E4puuj007365; Fri, 14 Jul 2023 12:03:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs1kym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 12:03:06 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EC35RW33620590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 12:03:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B48358059;
 Fri, 14 Jul 2023 12:03:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E87458055;
 Fri, 14 Jul 2023 12:03:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 12:03:05 +0000 (GMT)
Message-ID: <89abcf2c-e34e-ed0c-8f90-c2469dbcf860@linux.ibm.com>
Date: Fri, 14 Jul 2023 08:03:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-5-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230714070931.23476-5-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZkGzGGOiiSsDUuFjEMutV-qvJsIFkgrd
X-Proofpoint-ORIG-GUID: ZkGzGGOiiSsDUuFjEMutV-qvJsIFkgrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 7/14/23 03:09, Joelle van Dyne wrote:
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
> `tpmEstablished`. However, `tpmEstablished` is only cleared when a
> TPM2_HashStart operation is called which only exists for locality 4.
> We do not handle locality 4. Indeed, the comment for the write handler
> of `CRB_LOC_CTRL` makes the same argument for why it is not calling
> the backend to reset the `tpmEstablished` bit (to 1).
> As this bit is unused, we do not need to worry about updating it for
> reads.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/tpm/tpm_crb.h        |   2 -
>   hw/tpm/tpm_crb.c        |   3 -
>   hw/tpm/tpm_crb_common.c | 126 +++++++++++++++++++++-------------------
>   3 files changed, 65 insertions(+), 66 deletions(-)
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

The same comment as stated on v1 still applies, this part has to stay since VM state contains it:

2023-07-14T12:01:38.005199Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
2023-07-14T12:01:38.005318Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
2023-07-14T12:01:38.005350Z qemu-system-x86_64: load of migration failed: Invalid argument

    Stefan

