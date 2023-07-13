Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC57529A2
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 19:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJzvt-000823-3h; Thu, 13 Jul 2023 13:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJzvo-00081m-PN
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:16:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJzvm-0006zd-F5
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:16:44 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DHF9Qg009390; Thu, 13 Jul 2023 17:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qSWuQHrQ7QriNY2SgPsd9zQHpa229N0arafmguLCyss=;
 b=ca1Tni1XRomX+/mlM+4JcmkjfBKOzJZZLm9VG3Zq5kUrlySwhaxm5UuLhIqiPnL1LxLi
 NlhwxkDiQgzHIl6Akwa9Kv5IDTf/kbGtA42G1VyYpvXCKEVwAiT/tqSlEuFJHjw52g+k
 saESH/l4b+/lWsQaTkoEtc5e8A8VJEvcRx4z81ZRbKsvKna8LN7ULHvhxMgo3Abu24/8
 ceQLNjV3h/ma9cRhQ6+qSzIkv20on3YW2HWKj5F9qfxEEIA8Vd4a/620wtt4XiwekQDw
 b1s13sQo5znJvGHtakXU9qTYza6aHk5jNr0jJMWGaomJME6a/RwHnM1BTLHzmDymdcaY Ow== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtmq59842-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 17:16:39 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DGqRQ0009334;
 Thu, 13 Jul 2023 17:16:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rpye61mbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 17:16:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DHGbBA32440666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 17:16:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D21058059;
 Thu, 13 Jul 2023 17:16:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1510A58061;
 Thu, 13 Jul 2023 17:16:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 17:16:36 +0000 (GMT)
Message-ID: <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
Date: Thu, 13 Jul 2023 13:16:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
 <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YEsASW6x2P3KOS8IectEtXTUu_ikOFxm
X-Proofpoint-GUID: YEsASW6x2P3KOS8IectEtXTUu_ikOFxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307130151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 7/13/23 13:07, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 17:54, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/13/23 11:55, Peter Maydell wrote:
>>> On Thu, 13 Jul 2023 at 16:46, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>> On 7/13/23 11:34, Peter Maydell wrote:
>>>>> On Thu, 13 Jul 2023 at 16:28, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>> On 7/13/23 10:50, Peter Maydell wrote:
>>>>>>> I'm not a super-fan of hacking around the fact that LDP
>>>>>>> to hardware registers isn't supported in specific device
>>>>>>> models, though...
>>>>>>
>>>>>> What does this mean for this effort here?
>>>>>
>>>>> Usually we say "fix the guest to not try to access hardware
>>>>> registers with silly load/store instruction types". The other
>>>>> option would be "put in a large amount of effort to support
>>>>> emulating those instructions in QEMU userspace when KVM/HVF/etc
>>>>> trap and punt them to us". For the last decade or so we have
>>>>> taken the first of these approaches :-)
>>>>
>>>> Is Microsoft likely to react to use telling them "fix the guest"?
>>>
>>> They have on occasion in the past, yes.
>>>
>>> The other outstanding question here is if this TPM device
>>> should be a sysbus one at all (i.e. not i2c), which might
>>> render this part moot.
>>
>> Does the aarch64 virt VM support an i2c bus? Would it support the aspeed i2c bus? Does Windows then accept this i2c bus? Maybe the faster answer comes via this device that Joelle presumably has working on AARCH64 Windows.
> 
> The aim is not "get Windows booting as fast as possible", though.
> It's to end up with a QEMU virt board that (a) is maintainable
> (b) is reasonably congruent with what real hardware does
> (c) works in a way that will also work with what other
> guest OSes are expecting.
> 
> I don't want to accept changes to the virt board that are
> hard to live with in future, because changing virt in
> non-backward compatible ways is painful.
> 

I guess the first point would be to decide whether to support an i2c bus on the virt board and then whether we can use the aspeed bus that we know that the tpm_tis_i2c device model works with but we don't know how Windows may react to it.

It seems sysbus is already supported there so ... we may have a 'match'?

     dev = qdev_new("arm-gicv2m");
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);


    Stefan

> thanks
> -- PMM

