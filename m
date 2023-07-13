Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3FC752752
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 17:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyKw-0006h7-4Q; Thu, 13 Jul 2023 11:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyKt-0006gX-00
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:34:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyKq-0003bB-T6
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:34:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DFYGA8016621; Thu, 13 Jul 2023 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k6nSgXK+l51J4V3dyAWwJZ92tLbuRPZdItpyGW2PAxA=;
 b=nVY+qqFEdNrIoc7r1oXxAefJcJtfXSkAeJw75iz9Ibpt1Ry6nuHGRPk3ChgeymjEGXQz
 KKhsPjYE2AkZkCxhOG+0kH9EivT9+qq5p6GSccGdHef9QQ0O0kPynTLxxu42n8X+P2r0
 yrRnRpT0YPp1k2OJiHtgTRMk00sANsu68OvrvPVL9UjUL/BWMWafCCrfYAzTy5Y4YfbV
 GXGe40P1CqfHddOqV85CQ5GzZtWZ9Nu2Z1MEDM0MFj5qi5BK8Mq7WlLrNW2KNyDQoxBr
 9V68uRu3zlV2ZgA4jQ/uONEXdK0KQUOsLXm26PBNuiwn3COzJ+ymep5fj/FYQ3ll8D8r 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtkse8csk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:34:23 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36DFIjAa001836;
 Thu, 13 Jul 2023 15:34:21 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtkse8brr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:34:21 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDujrR005820; Thu, 13 Jul 2023 15:31:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqj4rr8hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:31:26 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DFVPZ936438520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 15:31:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8721658043;
 Thu, 13 Jul 2023 15:31:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 030CD58055;
 Thu, 13 Jul 2023 15:31:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 15:31:24 +0000 (GMT)
Message-ID: <8c5e1d5b-16be-e391-11d1-b4272cd8a69d@linux.ibm.com>
Date: Thu, 13 Jul 2023 11:31:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/11] tpm_crb: CTRL_RSP_ADDR is 64-bits wide
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-3-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-3-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uhRBg2JpueyF5B1g_3VZ-Ja6w_jBUE88
X-Proofpoint-ORIG-GUID: xUxeXOOqXVnR7u-Ip7ryuJQovbE2sUfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130132
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
> The register is actually 64-bits but in order to make this more clear
> than the specification, we define two 32-bit registers:
> CTRL_RSP_LADDR and CTRL_RSP_HADDR to match the CTRL_CMD_* naming. This
> deviates from the specs but is way more clear.
> 
> Previously, the only CRB device uses a fixed system address so this
> was not an issue. However, once we support SysBus CRB device, the
> address can be anywhere in 64-bit space.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   include/hw/acpi/tpm.h      | 3 ++-
>   hw/tpm/tpm_crb_common.c    | 3 ++-
>   tests/qtest/tpm-crb-test.c | 2 +-
>   tests/qtest/tpm-util.c     | 2 +-
>   4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 579c45f5ba..f60bfe2789 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -174,7 +174,8 @@ REG32(CRB_CTRL_CMD_SIZE, 0x58)
>   REG32(CRB_CTRL_CMD_LADDR, 0x5C)
>   REG32(CRB_CTRL_CMD_HADDR, 0x60)
>   REG32(CRB_CTRL_RSP_SIZE, 0x64)
> -REG32(CRB_CTRL_RSP_ADDR, 0x68)
> +REG32(CRB_CTRL_RSP_LADDR, 0x68)
> +REG32(CRB_CTRL_RSP_HADDR, 0x6C)
>   REG32(CRB_DATA_BUFFER, 0x80)
> 
>   #define TPM_CRB_ADDR_BASE           0xFED40000
> diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> index 4c173affb6..228e2d0faf 100644
> --- a/hw/tpm/tpm_crb_common.c
> +++ b/hw/tpm/tpm_crb_common.c
> @@ -199,7 +199,8 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
>       s->regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
>       s->regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
>       s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
> -    s->regs[R_CRB_CTRL_RSP_ADDR] = (uint32_t)baseaddr;
> +    s->regs[R_CRB_CTRL_RSP_LADDR] = (uint32_t)baseaddr;
> +    s->regs[R_CRB_CTRL_RSP_HADDR] = (uint32_t)(baseaddr >> 32);
> 
>       s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
>                               CRB_CTRL_CMD_SIZE);
> diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
> index 396ae3f91c..9d30fe8293 100644
> --- a/tests/qtest/tpm-crb-test.c
> +++ b/tests/qtest/tpm-crb-test.c
> @@ -28,7 +28,7 @@ static void tpm_crb_test(const void *data)
>       uint32_t csize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE);
>       uint64_t caddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
>       uint32_t rsize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
> -    uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
> +    uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
>       uint8_t locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
>       uint32_t locctrl = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
>       uint32_t locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 1c0319e6e7..dd02057fc0 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -25,7 +25,7 @@ void tpm_util_crb_transfer(QTestState *s,
>                              unsigned char *rsp, size_t rsp_size)
>   {
>       uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
> -    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
> +    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
> 
>       qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> 

