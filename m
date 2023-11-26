Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C6E7F91FE
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 10:30:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7BSd-0004cV-IH; Sun, 26 Nov 2023 04:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r7BSS-0004bz-Tm; Sun, 26 Nov 2023 04:29:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r7BSQ-0001tb-Qb; Sun, 26 Nov 2023 04:29:44 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AQ9FcUD018066; Sun, 26 Nov 2023 09:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vMdq+ZJs9JVmPNMuPk7zyri/v/83ao7aenSOcghEaZc=;
 b=fG+MACizTp6JUUS4GCKG9vxW9At6VR26e7bZ9dSN74swE8S1RJA5opLnC8BAzia2NUmj
 vPyi815D+l6xfZMRaIIJDFor+7hezhVZZ57pe85pk7oGaHj5fL6jJFMIsKdP3N8fmbXP
 UjARi5SMjWnkhKHGxW1KlEwjhBbt0W/J11H8jmmJ1wioyrLmO7BWoYqtGgrYE0qCVEEz
 CKn4PamfAPmmmfwRBZKN6IngM2FZzrR5KbJXPltL3wTEWbTm7k0wvG+ME0x/kU38cWa9
 eJ8JyXvslnGm2ljHsVZKjtk4k+RLbSxVnZnlGwdvTw6IIGWvv7ewNWaW7D+9Ja9ZDHQc AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ukrjdhvef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 26 Nov 2023 09:29:32 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AQ9TVBB017234;
 Sun, 26 Nov 2023 09:29:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ukrjdhveb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 26 Nov 2023 09:29:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AQ8l5pl030007; Sun, 26 Nov 2023 09:29:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumy2312-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 26 Nov 2023 09:29:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AQ9TS5Q43254152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 26 Nov 2023 09:29:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B5B820043;
 Sun, 26 Nov 2023 09:29:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73DB320040;
 Sun, 26 Nov 2023 09:29:26 +0000 (GMT)
Received: from [9.43.10.100] (unknown [9.43.10.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 26 Nov 2023 09:29:26 +0000 (GMT)
Message-ID: <887ebbb1-7de9-4d39-b820-2adcc6639961@linux.ibm.com>
Date: Sun, 26 Nov 2023 14:59:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] hw/ppc: Add nest1 chiplet model
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@us.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-3-chalapathi.v@linux.ibm.com>
 <CX707LTEH9J0.3UF28GS7L10P7@wheely>
 <236fe044-7adb-43c2-8887-0303ee33d6c6@kaod.org>
 <CX728N8AEA4N.1WTXYOBNMBOF3@wheely>
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <CX728N8AEA4N.1WTXYOBNMBOF3@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Knq26ucfId7fZ1oiBIBX3TP7366wG7Jl
X-Proofpoint-ORIG-GUID: 5F44skGli-Ea1Qv2uGNkey7x4NCqW1q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311260067
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 24-11-2023 18:31, Nicholas Piggin wrote:
> On Fri Nov 24, 2023 at 10:19 PM AEST, Cédric Le Goater wrote:
>> On 11/24/23 12:26, Nicholas Piggin wrote:
>>> For this and actually the last patch too, it would be good to mention
>>> (possibly in a header comment in the file too) what actual functionality
>>> is being provided/modeled. It looks like it's just modeling behaviour of
>>> reads and writes for some registers.
>>>
>>> Oh, and sorry I didn't follow development and comments on this too
>>> closely, so forgive me if I've missed things already said. I'll go
>>> back and read through the series.
>>>
>>> On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
>>>> The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
>>>> The nest1 chiplet consists of PowerBus Fabric controller,
>>>> nest Memory Management Unit, chiplet control unit and more.
>>>>
>>>> This commit creates a nest1 chiplet model and initialize and realize the
>>>> pervasive chiplet model where chiplet control registers are implemented.
>>>>
>>>> This commit also implement the read/write method for the powerbus scom
>>>> registers
>>> The powerbus scom registers, are those specifically for the PowerBus
>>> Fabric controller mentioned in the first paragraph, or is it a more
>>> general set of registers for the chiplet?
Yes, They are for the PowerBus racetrack unit.
>>>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>>>> ---
>>>>    include/hw/ppc/pnv_nest_chiplet.h |  36 ++++++
>>>>    include/hw/ppc/pnv_xscom.h        |   6 +
>>>>    hw/ppc/pnv_nest1_chiplet.c        | 197 ++++++++++++++++++++++++++++++
>>>>    hw/ppc/meson.build                |   1 +
>>>>    4 files changed, 240 insertions(+)
>>>>    create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
>>>>    create mode 100644 hw/ppc/pnv_nest1_chiplet.c
>>>>
>>>> diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
>>>> new file mode 100644
>>>> index 0000000000..845030fb1a
>>>> --- /dev/null
>>>> +++ b/include/hw/ppc/pnv_nest_chiplet.h
>>>> @@ -0,0 +1,36 @@
>>>> +/*
>>>> + * QEMU PowerPC nest chiplet model
>>>> + *
>>>> + * Copyright (c) 2023, IBM Corporation.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + *
>>>> + * This code is licensed under the GPL version 2 or later. See the
>>>> + * COPYING file in the top-level directory.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef PPC_PNV_NEST1_CHIPLET_H
>>>> +#define PPC_PNV_NEST1_CHIPLET_H
>>>> +
>>>> +#include "hw/ppc/pnv_pervasive.h"
>>>> +
>>>> +#define TYPE_PNV_NEST1 "pnv-nest1-chiplet"
>>>> +#define PNV_NEST1(obj) OBJECT_CHECK(PnvNest1, (obj), TYPE_PNV_NEST1)
>>>> +
>>>> +typedef struct pb_scom {
>>>> +    uint64_t mode;
>>>> +    uint64_t hp_mode2_curr;
>>>> +} pb_scom;
>>>> +
>>>> +typedef struct PnvNest1 {
>>> Naming nitpicking again...
>>>
>>> The main ifndef guard for header files should match the file name, so
>>> the file should be called pnv_nest1_chiplet.h (and that matches the .c
>>> file too).
>>>
>>> I think this struct should be called Nest1Chiplet too.
>> I asked Chalapathi to do the exact opposit :)
> Oops :)
>
>> I don't mind really, my argument was that most models represent HW logic
>> units or subunits of a bigger unit. I don't see the point in adding a
>> chip/chiplet suffix apart from PnvChip since it represents a socket or
>> processor.
>>
>> You choose. I will keep quiet :)
> Ah. I can see that side of it. And for many of the nest chiplets (MC,
> PAU, PCI) that makes sense. For Nest0 and Nest1... it's a bit
> overloaded. First of all, all the nest chiplets are "nest". Then
> there is also some nest units inside the processor chiplets (L2, L3,
> NCU are considered to be nest). And then the nest also has a Pervasive
> Chiplet itself, and we also have these pervasive registers in each
> chiplet, etc., etc.
>
> So my worry is we'll run into confusion if we shorten names too much.
>
> We can always rename things, so it won't be the end of the world, but
> thinking about the pervasive chiplet, I think we can already see that
> "PnvPervasive" would not be a good name for it.
>
> The chiplets have short names actually if that would help. Nest 1 is
> called N1, so we could call it PnvN1Chiplet. That seems the usual
> way to refer to them in docs, so I think a better name.
>
> Thanks,
> Nick
Sure. Will rename this to PnvN1Chiplet.

