Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A905F7A089F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnvf-0003Bb-RI; Thu, 14 Sep 2023 11:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qgnvY-0003BK-Ow; Thu, 14 Sep 2023 11:06:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qgnvV-0006Rq-PU; Thu, 14 Sep 2023 11:06:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EErVfk006838; Thu, 14 Sep 2023 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qQvrPrh+xvIe56d5uo0qvDn3JmUfFi6M5giv99B/asQ=;
 b=bTOBAQoUDXhNzhzen5BW9Aq7792R3KHYWtqMeG2FjnGztzNvyZhqQo3oiR0bIDvuVaY3
 pFhL41CqjAMHm9XlbbtqhOWkA7m8X7hKGjV9RInKEKGanUmUQsr80XjY9Bxa7yb/DhqF
 RdAwnSN+c/etanpPPggJ6UeW+FDQtr170wuoiOYBC47GXp71FT2nUGjxOSTi5XMvQ0Pg
 4YtEmCNyjPD7X/ZZ4Frye0IwpDOmM3LHBlIphWQxaGDk1ntfDxuEJ4ODnWkO9wkN5ewl
 VjNUzT82zWb7VXFUoYCCS4DVuwQtkwBuUPllnBYFW8tz9Fgzs3fxjYtWEoPUDavHBoXX NQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dk0cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 15:06:33 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EF6WVC030080
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 15:06:32 GMT
Received: from [10.111.140.37] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 08:06:31 -0700
Message-ID: <54fb614b-a2a2-4472-81e9-da0cb81441a9@quicinc.com>
Date: Thu, 14 Sep 2023 16:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
Content-Language: en-GB
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>
References: <20230914120124.55410-1-quic_llindhol@quicinc.com>
 <986148e3-2830-4333-bfd7-29de9fa2dab8@linaro.org>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <986148e3-2830-4333-bfd7-29de9fa2dab8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: JgbG12oTUPPFAMA5EDXkjRtJOf_G_4st
X-Proofpoint-GUID: JgbG12oTUPPFAMA5EDXkjRtJOf_G_4st
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 2023-09-14 14:15, Marcin Juszkiewicz wrote:
> W dniu 14.09.2023 o 14:01, Leif Lindholm pisze:
>> While reviewing Marcin's patch this morning, cross referencing different
>> specifications and looking at various places around the source code in
>> order to convinced myself he really hadn't missed something out (the
>> existing plumbing made it *so* clean to add), my brain broke slightly
>> at keeping track of PPIs/INTIDs between the various sources.
>>
>> Moreover, I found the PPI() macro in virt.h to be doing the exact
>> opposite of what I would have expected it to (it converts a PPI to an
>> INTID rather than the other way around).
>>
>> So I refactored stuff so that:
>> - PPIs defined by BSA are moved to a (new) common header.
>> - The _IRQ definitions for those PPIs refer to the INTIDs.
>> - sbsa-ref and virt both use these definitions.
>>
>> This change does objectively add a bit more noise to the code, since it
>> means more locations need to use the PPI macro than before, but it felt
>> like a readability improvement to me.
> 
> I like how code looks after those changes. No more adding 16 to irq
> numbers to fit them into BSA spec numbers is nice to have.
> 
> Will rebase my "non-secure EL2 virtual timer" patch on top of it.
> 
>> Not even compilation tested, just the least confusing way of asking
>> whether the change could be accepted at all.
> 
> There are build warnings and final binary segfaults on start.

Ah, yes. In my rush, I failed to spot that the -virt gic_create function 
contained shadows of different type variables called irq.
Will address if there's a v1.

Thanks!

/
     Leif

> --------------------------------------------
> [1799/2931] Compiling C object 
> libqemu-aarch64-softmmu.fa.p/hw_arm_sbsa-ref.c.o
> ../hw/arm/sbsa-ref.c: In function ‘create_gic’:
> ../hw/arm/sbsa-ref.c:496:13: warning: assignment to ‘int’ from 
> ‘qemu_irq’ {aka ‘struct IRQState *’} makes integer from pointer without 
> a cast [-Wint-conversion]
>    496 |         irq = qdev_get_gpio_in(sms->gic,
>        |             ^
> ../hw/arm/sbsa-ref.c:499:37: warning: passing argument 4 of 
> ‘qdev_connect_gpio_out_named’ makes pointer from integer without a cast 
> [-Wint-conversion]
>    499 |                                     irq);
>        |                                     ^~~
>        |                                     |
>        |                                     int
> In file included from 
> /home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/hw/core/cpu.h:23,
>                   from ../target/arm/cpu-qom.h:23,
>                   from ../target/arm/cpu.h:26,
>                   from 
> /home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/sysemu/kvm.h:244,
>                   from ../hw/arm/sbsa-ref.c:27:
> /home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/hw/qdev-core.h:699:43: note: expected ‘qemu_irq’ {aka ‘struct IRQState *’} but argument is of type ‘int’
>    699 |                                  qemu_irq input_pin);
>        |                                  ~~~~~~~~~^~~~~~~~~
> ../hw/arm/sbsa-ref.c:501:13: warning: assignment to ‘int’ from 
> ‘qemu_irq’ {aka ‘struct IRQState *’} makes integer from pointer without 
> a cast [-Wint-conversion]
>    501 |         irq = qdev_get_gpio_in(sms->gic,
>        |             ^
> ../hw/arm/sbsa-ref.c:503:65: warning: passing argument 4 of 
> ‘qdev_connect_gpio_out_named’ makes pointer from integer without a cast 
> [-Wint-conversion]
>    503 |         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0, 
> irq);
>        |                                                                 
> ^~~
>        |                                                                 |
>        |                                                                 
> int
> /home/marcin/devel/linaro/sbsa-qemu/code/qemu/include/hw/qdev-core.h:699:43: note: expected ‘qemu_irq’ {aka ‘struct IRQState *’} but argument is of type ‘int’
>    699 |                                  qemu_irq input_pin);
>        |                                  ~~~~~~~~~^~~~~~~~~
> --------------------------------------------


