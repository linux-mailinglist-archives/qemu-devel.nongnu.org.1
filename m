Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE2BF49C1
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 06:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4O6-0007Zi-OD; Tue, 21 Oct 2025 00:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB4O4-0007Z9-41; Tue, 21 Oct 2025 00:54:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB4O1-0002O1-8b; Tue, 21 Oct 2025 00:54:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L2vl1v007748;
 Tue, 21 Oct 2025 04:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NFKh4h
 t4hFSOdQzwq1AmS2Pc/7IYmgtNIe2JKEo3f1A=; b=i7rQU2GvxaQ1FaYQ/zO+am
 rnLFGbAsU2QquOrVkvlcuONR2Ake5xwBfBbqCzCC4YenhPcAS1VuZNuUV/8YeU9B
 /VGvMCKJ8elUpaZdGkpQ+UWVHeG9KYswDLgRSXhOmCIXcEJG80F7MPxDEW/oBlwE
 ductAtvQ40xb9COEJRGtfjJmcxV7Oz6gRQjB1MkGkw7xgOgaoM0yWF3TYldn4UOv
 4tf6ONYiMFnGs8iH3ag4uUL/0hyvmcj+vWBTv4azDJrFnmzH/0FBcZrbhgDr/XaS
 QuplXX7AnTD/geeKKInkalgSdhomqG6fqzFWT98dWJP8gWwnTuCYBzpJ6mULdn3g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326n2x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:54:14 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L4pbl6018349;
 Tue, 21 Oct 2025 04:54:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326n2x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:54:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L28jeG017081;
 Tue, 21 Oct 2025 04:54:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxs5u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:54:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L4sBSE7799986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 04:54:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A719958067;
 Tue, 21 Oct 2025 04:54:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D68F5805D;
 Tue, 21 Oct 2025 04:54:09 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 04:54:08 +0000 (GMT)
Message-ID: <fdb7e249-b801-4f57-943d-71e620df2fb3@linux.ibm.com>
Date: Tue, 21 Oct 2025 10:24:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20251020103815.78415-1-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f711f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=GLR4iIx02OIjODZsis0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxB7aRVRdXeK8
 zCu5U3Kd3m8aTvInr6WvcUe3K6HULugPO07gbG8JZFuS5WQOsehXKUXFvzepSmqsUykGMTLdvVx
 GcKpBjnXjhNT0RgcdPl0Mf3HN0FjM8UopDoEJDnMx/EuAWuTfumUMNr/mp8viqz8y31zFs6MSyo
 H/QfZ1Ja9g2P26HZ8U3pTdS3twQUKnlM0k1Ci9Lx53ikkM+yZrHfvqkkGDjZwtIQc8FZevJCU3g
 mRoAvaeHRuwLIpnk2CpwV55VxD5JvBojrD6LEZBYsoobj2QGM46MiyWN7nbhdoB3iuyoQiRbO+a
 JRJc3uUW17dpsPyLaY0oY0PN3ldTsWQ809FsteHx204Ts5Scol/pS6CFPh9PJpXg2n4j/OJe+qG
 +uR3zIHXb3UUJyD2Tb5gDnqow+K8xg==
X-Proofpoint-GUID: D5oKnqXmEzXn5SbvMkWos5pkiqF7rwDb
X-Proofpoint-ORIG-GUID: WDuAOAPfPmu7T1bLe9QYgK9nl7Nvr96M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+Cedric

Hi Phillipe,

It had been done and the patches were reviewed already here (you were in 
CC too):

https://lore.kernel.org/qemu-devel/20251009184057.19973-1-harshpb@linux.ibm.com/

Let us try to avoid duplication of implementation/review efforts.
If the motivation to re-do is just to split, I think let us consider the 
original series to avoid duplication of review efforts. I should 
probably send more frequent PRs to avoid such scenarios in future.

Thanks for your contribution in reviewing other patches though. It's 
highly appreciated.

regards,
Harsh

On 10/20/25 16:07, Philippe Mathieu-Daudé wrote:
> Remove the deprecated pseries-3.0 up to pseries-4.2 machines,
> which are older than 6 years. Remove resulting dead code.
> 
> Philippe Mathieu-Daudé (18):
>    hw/ppc/spapr: Remove deprecated pseries-3.0 machine
>    hw/ppc/spapr: Remove SpaprMachineClass::spapr_irq_xics_legacy field
>    hw/ppc/spapr: Remove SpaprMachineClass::legacy_irq_allocation field
>    hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
>    hw/ppc/spapr: Remove deprecated pseries-3.1 machine
>    hw/ppc/spapr: Remove SpaprMachineClass::broken_host_serial_model field
>    target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
>    target/ppc/kvm: Remove kvmppc_get_host_model() as unused
>    hw/ppc/spapr: Remove SpaprMachineClass::dr_phb_enabled field
>    hw/ppc/spapr: Remove SpaprMachineClass::update_dt_enabled field
>    hw/ppc/spapr: Remove deprecated pseries-4.0 machine
>    hw/ppc/spapr: Remove SpaprMachineClass::pre_4_1_migration field
>    hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback
>    hw/ppc/spapr: Remove deprecated pseries-4.1 machine
>    hw/ppc/spapr: Remove SpaprMachineClass::smp_threads_vsmt field
>    hw/ppc/spapr: Remove SpaprMachineClass::linux_pci_probe field
>    hw/ppc/spapr: Remove deprecated pseries-4.2 machine
>    hw/ppc/spapr: Remove SpaprMachineClass::rma_limit field
> 
>   include/hw/ppc/spapr.h     |  16 --
>   include/hw/ppc/spapr_irq.h |   1 -
>   target/ppc/kvm_ppc.h       |  12 --
>   hw/ppc/spapr.c             | 298 ++++++++-----------------------------
>   hw/ppc/spapr_caps.c        |   6 -
>   hw/ppc/spapr_events.c      |  20 +--
>   hw/ppc/spapr_hcall.c       |   5 -
>   hw/ppc/spapr_irq.c         |  36 +----
>   hw/ppc/spapr_pci.c         |  32 +---
>   hw/ppc/spapr_vio.c         |   9 --
>   target/ppc/kvm.c           |  11 --
>   11 files changed, 75 insertions(+), 371 deletions(-)
> 

