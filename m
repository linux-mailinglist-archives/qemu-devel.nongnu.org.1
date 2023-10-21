Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889C7D1FA1
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIr6-0003RS-FA; Sat, 21 Oct 2023 16:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quIqx-0003P7-BR; Sat, 21 Oct 2023 16:45:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quIqu-0006md-TK; Sat, 21 Oct 2023 16:45:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKAA78017266; Sat, 21 Oct 2023 20:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dRGX4JjLRMQkLaFBEpU6yaKG+JeWkp3B/j4oLF9gZ0Q=;
 b=Lp5zFwO7You+hfwojNjPugv8wYmomEfYUGRD9skrPXL9RPhG4tVFppjRjNc7gwFE88de
 +cIRRtSO5eIcrQcWNNCtpRS1d51LNmccdgyQeA/zUkii3kJhK8KMKYbiWD/tsxdb2kVD
 48OFDMs1PHpK8kEnVddUl6tATTEOj0Ps1OnK4pL3LmXZglQwdHst4fveGnuMkDzt8hut
 I3eYVBXxK/YU2/8zvfXSNlkGVxO9ECVmvuosPlQDQUZiSe3rJ0LeRkAmqwP0lBcamu+Z
 Q91QAYzEBvklraGbLKVsvHTio7qrc5xTPykvJZvrkHAr0duyLL7TttoDxn4AZ5gappIE CA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvnefrkju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:45:31 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LKjJeN029946;
 Sat, 21 Oct 2023 20:45:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvnefrkjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:45:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LHHhtq032130; Sat, 21 Oct 2023 20:45:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc35w815-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:45:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LKjT9240960548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 20:45:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 462CD58055;
 Sat, 21 Oct 2023 20:45:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6409758043;
 Sat, 21 Oct 2023 20:45:26 +0000 (GMT)
Received: from [9.67.95.215] (unknown [9.67.95.215])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 20:45:26 +0000 (GMT)
Message-ID: <40c94d54-cb2b-48f4-b62d-8133dbe1a689@linux.ibm.com>
Date: Sat, 21 Oct 2023 15:45:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Introduce model for IBM's FSI
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <cd99c52d-8232-4598-83cf-088a715a7a34@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <cd99c52d-8232-4598-83cf-088a715a7a34@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TT8m7-ue-EcwNdg2LS7evz1YkXWH80Ov
X-Proofpoint-GUID: liDmhLVEpXWT1pBWG6drZA_irekFZY-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=596 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Cedric,

On 10/19/23 03:16, Cédric Le Goater wrote:
> Hello Ninad,
>
>
> On 10/11/23 17:13, Ninad Palsule wrote:
>> Hello,
>>
>> Please review the patch-set version 5.
>> I have incorporated review comments from Cedric.
>>
>> Ninad Palsule (10):
>>    hw/fsi: Introduce IBM's Local bus
>>    hw/fsi: Introduce IBM's scratchpad
>>    hw/fsi: Introduce IBM's cfam,fsi-slave
>>    hw/fsi: Introduce IBM's FSI
>>    hw/fsi: IBM's On-chip Peripheral Bus
>>    hw/fsi: Aspeed APB2OPB interface
>>    hw/arm: Hook up FSI module in AST2600
>>    hw/fsi: Added qtest
>>    hw/fsi: Added FSI documentation
>>    hw/fsi: Update MAINTAINER list
>
> I made some comments, mostly on the bus models which need to be reworked.
> This is code reshuffling and it should simplify the models. Please 
> consider
> reducing the amount of files.
I have incorporated most of your comments but couldn't reduce the files 
as there is a file per bus or device.
>
> Also, could please remove my Sob ?  I didn't write any of this, only did
> quick fixes over the years because I kept the series in my aspeed tree.
> And this would help me to add a Rb :)
Removed your name from signed off by.
>
> I expect one or two respins before merge. 8.2 freeze window is in less
> than 3 weeks. It could make it, else the next. No big issue since I think
> we have been dragging these models for at least 5/6 years.

I am hoping to get it in 8.2

Thanks for the review.

Regards,

Ninad

>
> Thanks,
>
> C.
>
>
>>
>>   MAINTAINERS                        |   8 +
>>   docs/specs/fsi.rst                 | 141 ++++++++++++
>>   meson.build                        |   1 +
>>   hw/fsi/trace.h                     |   1 +
>>   include/hw/arm/aspeed_soc.h        |   4 +
>>   include/hw/fsi/aspeed-apb2opb.h    |  33 +++
>>   include/hw/fsi/cfam.h              |  58 +++++
>>   include/hw/fsi/engine-scratchpad.h |  33 +++
>>   include/hw/fsi/fsi-master.h        |  30 +++
>>   include/hw/fsi/fsi-slave.h         |  29 +++
>>   include/hw/fsi/fsi.h               |  37 +++
>>   include/hw/fsi/lbus.h              |  51 +++++
>>   include/hw/fsi/opb.h               |  43 ++++
>>   include/qemu/bitops.h              |   6 +
>>   hw/arm/aspeed_ast2600.c            |  19 ++
>>   hw/fsi/aspeed-apb2opb.c            | 350 +++++++++++++++++++++++++++++
>>   hw/fsi/cfam.c                      | 220 ++++++++++++++++++
>>   hw/fsi/engine-scratchpad.c         |  99 ++++++++
>>   hw/fsi/fsi-master.c                | 198 ++++++++++++++++
>>   hw/fsi/fsi-slave.c                 |  96 ++++++++
>>   hw/fsi/fsi.c                       |  54 +++++
>>   hw/fsi/lbus.c                      |  87 +++++++
>>   hw/fsi/opb.c                       | 185 +++++++++++++++
>>   tests/qtest/fsi-test.c             | 210 +++++++++++++++++
>>   hw/Kconfig                         |   1 +
>>   hw/arm/Kconfig                     |   1 +
>>   hw/fsi/Kconfig                     |  23 ++
>>   hw/fsi/meson.build                 |   6 +
>>   hw/fsi/trace-events                |  15 ++
>>   hw/meson.build                     |   1 +
>>   tests/qtest/meson.build            |   2 +
>>   31 files changed, 2042 insertions(+)
>>   create mode 100644 docs/specs/fsi.rst
>>   create mode 100644 hw/fsi/trace.h
>>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>>   create mode 100644 include/hw/fsi/cfam.h
>>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>>   create mode 100644 include/hw/fsi/fsi-master.h
>>   create mode 100644 include/hw/fsi/fsi-slave.h
>>   create mode 100644 include/hw/fsi/fsi.h
>>   create mode 100644 include/hw/fsi/lbus.h
>>   create mode 100644 include/hw/fsi/opb.h
>>   create mode 100644 hw/fsi/aspeed-apb2opb.c
>>   create mode 100644 hw/fsi/cfam.c
>>   create mode 100644 hw/fsi/engine-scratchpad.c
>>   create mode 100644 hw/fsi/fsi-master.c
>>   create mode 100644 hw/fsi/fsi-slave.c
>>   create mode 100644 hw/fsi/fsi.c
>>   create mode 100644 hw/fsi/lbus.c
>>   create mode 100644 hw/fsi/opb.c
>>   create mode 100644 tests/qtest/fsi-test.c
>>   create mode 100644 hw/fsi/Kconfig
>>   create mode 100644 hw/fsi/meson.build
>>   create mode 100644 hw/fsi/trace-events
>>
>

