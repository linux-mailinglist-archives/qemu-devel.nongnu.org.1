Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FE746E56
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGd1U-0002ZU-RB; Tue, 04 Jul 2023 06:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGd1R-0002Yo-5n; Tue, 04 Jul 2023 06:12:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGd1P-0007RB-2b; Tue, 04 Jul 2023 06:12:36 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 364AAAiA009053; Tue, 4 Jul 2023 10:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lGAUwNOyse1r6HvBigXsvHV2L5WQogQC5FlgGI9oF30=;
 b=BPI4sZTSkLNFnD9wi5IOvhV/fq57r13Gwfzjmq73s/fm/8qLI4Q6lgVk6mD5dqc5Ldc+
 BjqzFnlywycYtDgvzusLHIJhd4TyAaZSC55P6vd78UmLBmT5MECILTzVVYXfGwbyvoQl
 8LxL53P4OUQShyahKUH7RiLEmAB3lsmEgsJwKr/ilFb9xwib7cZmOrLfOmk1sqeQywUK
 heP3Zlfx1nMtgGG0uuJkEbA+STr5rbX4M4/xI1128jg9Yd54THv+GqeDHSck1uGVFllf
 1OPzcI31WcJLg6Sba2sya14I2ogfeujdhVM5MCIDqnSKb8hSBUiaLBFywx9oH8uQf4jP 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t8j4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3649qVeL023659;
 Tue, 4 Jul 2023 10:12:25 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t8j47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:25 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3646N6rT030089;
 Tue, 4 Jul 2023 10:12:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sdyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 364ACK2U46924110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 10:12:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9852B2006C;
 Tue,  4 Jul 2023 10:12:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 154C620065;
 Tue,  4 Jul 2023 10:12:20 +0000 (GMT)
Received: from [9.179.4.4] (unknown [9.179.4.4])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 10:12:19 +0000 (GMT)
Message-ID: <f887812d-a292-ec77-dfa3-838309b95465@linux.ibm.com>
Date: Tue, 4 Jul 2023 12:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] ppc/pnv: Add P10 core xscom model
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-5-joel@jms.id.au>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230704054204.168547-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FPZ0fz6hdmjyizT0rruqr2A7hL9JayLB
X-Proofpoint-ORIG-GUID: 56f2FMqEz1PCB2ybPUpdUfby6FpAdCQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 04/07/2023 07:42, Joel Stanley wrote:
> Like the quad xscoms, add a core model for P10 to allow future
> differentiation from P9.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   hw/ppc/pnv_core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index e4df435b15e9..1eec28c88c41 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -167,6 +167,47 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +/*
> + * POWER10 core controls
> + */
> +
> +static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
> +                                           unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = 0;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> +                  addr);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
> +                                         uint64_t val, unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> +                      addr);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_core_power10_xscom_ops = {
> +    .read = pnv_core_power10_xscom_read,
> +    .write = pnv_core_power10_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
>   static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
>   {
>       CPUPPCState *env = &cpu->env;
> @@ -315,8 +356,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
>   {
>       PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
>   
> -    /* TODO: Use the P9 XSCOMs for now on P10 */
> -    pcc->xscom_ops = &pnv_core_power9_xscom_ops;
> +    pcc->xscom_ops = &pnv_core_power10_xscom_ops;
>   }
>   
>   static void pnv_core_class_init(ObjectClass *oc, void *data)

