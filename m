Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6470491A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyquP-000119-Bf; Tue, 16 May 2023 05:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1pyquM-00010v-VJ; Tue, 16 May 2023 05:23:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1pyquK-0002oO-Ls; Tue, 16 May 2023 05:23:50 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G9CN2s007740; Tue, 16 May 2023 09:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FCcBnfTTXpL1Ger6q2GgLVfX08RkcNqh1+6QYOQ6xyM=;
 b=qhYzrJ0SCmrdm308M18YiV9j3VE+YMYgDhec+2g6Nik6yMcv8WiVNHAd6E3UMB4hX+8H
 gVIU6tO0Fwnm7wIqvQ8+iM9F8+GyAr5d+wQ6V1qatDoMfe3RjRwh1dn31Vi4Sk7Wfw/d
 kF2edW2reff+l36M7plglZhMAGqWluBUgNrI5+zZrSjMBu0bCa70s3NDm36DKqnSsWfr
 XfwqKUrGXSvp2vvXCIArRWkvSrF1ASbWGdfPCMOwldwq1oyrqpYkZX8VpyTGH+aC4hyA
 LovS2xt4dnfJnSzrvzYw07avQRBVnYxsUWBdLqdwA1PEBfhXyXU/DmMYYGrUxKMtn6Vh UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm6mxrrhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 09:23:46 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34G9N6LN014839;
 Tue, 16 May 2023 09:23:46 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm6mxrrh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 09:23:46 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G8TbOZ000686;
 Tue, 16 May 2023 09:23:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3qj265km8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 09:23:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34G9Ni4J62259530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:23:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F5EB58063;
 Tue, 16 May 2023 09:23:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA8EC58055;
 Tue, 16 May 2023 09:23:42 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 May 2023 09:23:42 +0000 (GMT)
Message-ID: <f9167007-ca18-eef6-5973-64da0ff4fedc@linux.ibm.com>
Date: Tue, 16 May 2023 14:53:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230515160201.394587-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230515160201.394587-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: avE7NHYr_k82HE8XCLnWXoG0Qsp_4671
X-Proofpoint-GUID: V_Uqsa9ZfosmWS-ovXWki8j7re8PL9fH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

<correcting my email in CC>

On 5/15/23 21:32, Nicholas Piggin wrote:
> POWER9 DD2.1 and earlier had significant limitations when running KVM,
> including lack of "mixed mode" MMU support (ability to run HPT and RPT
> mode on threads of the same core), and a translation prefetch issue
> which is worked around by disabling "AIL" mode for the guest.
> 
> These processors are not widely available, and it's difficult to deal
> with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> and make it the default POWER9 CPU.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This is unchanged since v3, just reposting.
> 
> Thanks,
> Nick
> 
>   hw/ppc/pnv.c                   |  2 +-
>   hw/ppc/pnv_core.c              |  2 +-
>   hw/ppc/spapr.c                 |  2 +-
>   hw/ppc/spapr_cpu_core.c        |  1 +
>   include/hw/ppc/pnv.h           |  2 +-
>   target/ppc/cpu-models.c        |  4 +++-
>   target/ppc/cpu-models.h        |  1 +
>   target/ppc/cpu_init.c          | 21 +++++++++++++++++++--
>   tests/qtest/device-plug-test.c |  4 ++--
>   9 files changed, 30 insertions(+), 9 deletions(-)
> 

<snip>


> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index a77e036b3a..572b5e553a 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -350,6 +350,7 @@ enum {
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
>       CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
> +    CPU_POWERPC_POWER9_DD22        = 0x004E1202,
>       CPU_POWERPC_POWER10_BASE       = 0x00800000,
>       CPU_POWERPC_POWER10_DD1        = 0x00801100,
>       CPU_POWERPC_POWER10_DD20       = 0x00801200,
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 0ce2e3c91d..6775828dfc 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6284,9 +6284,26 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
>           return false;
>       }
>   
> -    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
> -        /* Major DD version matches to power9_v1.0 and power9_v2.0 */
> +    if ((pvr & 0x0f00) != (pcc->pvr & 0x0f00)) {
> +        /* Major DD version does not match */
> +        return false;
> +    }
> +
> +    if ((pvr & 0x0f00) == 0x100) {
> +        /* DD1.x always matches power9_v1.0 */
>           return true;
> +    } else if ((pvr & 0x0f00) == 0x200) {
> +        if ((pvr & 0xf) < 2) {
> +            /* DD2.0, DD2.1 match power9_v2.0 */
> +            if ((pcc->pvr & 0xf) == 0) {
> +                return true;
> +            }
> +        } else {
> +            /* DD2.2, DD2.3 match power9_v2.2 */
> +            if ((pcc->pvr & 0xf) == 2) {
The comment is futuristic about DD2.3 although the condition checks only 
for DD2.2, may be update comment for now and another patch later along 
with other changes needed to support 2.3?

Otherwise, looks fine to me.
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

regards,
Harsh
> +                return true;
> +            }
> +        }
>       }
>   
>       return false;
> diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
> index 01cecd6e20..165ca13f8c 100644
> --- a/tests/qtest/device-plug-test.c
> +++ b/tests/qtest/device-plug-test.c
> @@ -168,8 +168,8 @@ static void test_spapr_cpu_unplug_request(void)
>   {
>       QTestState *qtest;
>   
> -    qtest = qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=2 "
> -                        "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
> +    qtest = qtest_initf("-cpu power9_v2.2 -smp 1,maxcpus=2 "
> +                        "-device power9_v2.2-spapr-cpu-core,core-id=1,id=dev0");
>   
>       /* similar to test_pci_unplug_request */
>       process_device_remove(qtest, "dev0");

