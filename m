Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74815754313
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 21:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKODW-0000yr-Vy; Fri, 14 Jul 2023 15:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKODU-0000yQ-Mr
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKODS-0006gP-MM
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:12:36 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EJ6xmv014376; Fri, 14 Jul 2023 19:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l94oNLR3yzECmswaY7YU6S4PML0eGVaTeDDjlrGHdTw=;
 b=rPLGPfbAXJ3IdDV33kqGxRXRC4m4+QtAI6+Jfm3aEfQiepCfG6cvbecZRVbodSe3bKVz
 nhpqiiwpTcBwJpRrQfqx6FLSP3hj4fETkiaqmFtpw3J8uQkN3AdlZZ6ZvdzU0p/BUA+d
 +mPJTJ+LE7nQL89xBuEHgrr0nfRG2/7q3M0hqvw3BoUoFuoe3Y1Ha8/uspFH86W5LHN1
 v72I42HDBmYLBZA/gLiQ0E4Xee0nDkYn4+3ZxEMmm+ZzbbDvkTZ41gf9LMxuoCG4/GoB
 3fXGbO1hZ1dEFmuFGhxRqeyLDqZMDBvlJ42UuR7ARdAgEEDUs/6hf4PJqGCWyRFB85US BQ== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rubkh0x6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 19:12:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EDaQ9U007313; Fri, 14 Jul 2023 19:12:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs2fn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 19:12:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EJCSN94457046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 19:12:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C14F58052;
 Fri, 14 Jul 2023 19:12:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9F4958050;
 Fri, 14 Jul 2023 19:12:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 19:12:27 +0000 (GMT)
Message-ID: <78cee616-94fa-baba-8dad-1dbcbbbbc45a@linux.ibm.com>
Date: Fri, 14 Jul 2023 15:12:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
 <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
 <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
 <67a2b78d-8eea-7c9c-cf1b-50444e481006@linux.ibm.com>
 <562ec838-2714-2bb2-d1a5-7b98bb43a60b@linux.ibm.com>
 <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nZO0ERUT7qWzmkeXEjgv8OnXcbuMQvyO
X-Proofpoint-GUID: nZO0ERUT7qWzmkeXEjgv8OnXcbuMQvyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=789 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140174
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



On 7/14/23 14:49, Joelle van Dyne wrote:
> On Fri, Jul 14, 2023 at 11:41 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/14/23 14:22, Stefan Berger wrote:
>>> On 7/14/23 13:04, Joelle van Dyne wrote:
>>>> On Fri, Jul 14, 2023 at 7:51 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 7/14/23 10:05, Stefan Berger wrote:
>>>>>>
>>>>>>
>>>>>> On 7/14/23 03:09, Joelle van Dyne wrote:
>>>>>>> When we moved to a single mapping and modified TPM CRB's VMState, it
>>>>>>> broke restoring of VMs that were saved on an older version. This
>>>>>>> change allows those VMs to gracefully migrate to the new memory
>>>>>>> mapping.
>>>>>>
>>>>>> Thanks. This has to be in 4/11 though.
>>>>>>
>>>>>
>>>>> After applying the whole series and trying to resume state taken with current git
>>>>> master I cannot restore it but it leads to this error here. I would just leave it
>>>>> completely untouched in 4/11.
>>>>>
>>>>> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
>>>>> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
>>>>> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration failed: Invalid argument
>>>>>
>>>>>       Stefan
>>>>
>>>> To be clear, you are asking to back out of 4/11? That patch changes
>>>> how the registers are mapped so it's impossible to support the old
>>>> style register mapping. This patch attempts to fix that with a
>>>
>>> Why can we not keep the old style register mapping as 'secondary mapping'?
>>
>> I think the first goal should be for existing TPM CRB device not to change anything, they
>> keep their .read and .write behaivor as it.
>>
>> If you need different .read behavior for the sysbus device due to AARCH64 then it may want to use its own MemoryRegionOps.
>>
>> I am fairly sure that you could refactor the core of the existing tpm_crb_mmio_write() and have it work on s->regs and mmio regs.
>> The former would be used by existing code, the latter for CRB sysbus calling into this new function from a wrapper.
>>
>>      Stefan
> 
> I agree that new QEMU should be able to read old QEMU state but vice
> versa is not always true. There's been many changes in the past that
> incremented the vmstate's version_id to indicate that the state format
> has changed. Also, we are not changing the .read behavior because in

Unfortunately the CRB device is being used by x86 on some distros
and the expectation is that this existing device can also downgrade
to a previous version of QEMU I would say. I have read people migrating
from RHEL 9.x even to RHEL 8.x and the expectation is that this works.

Now you are introducing a new device and I think you can leave
the existing device with its s->regs alone and have the new device
with its mmio regs work a little different just to preserve the QEMU
downgrade for x86.

> the old code, the only field that gets a dynamic update is
> tpmEstablished which we found is never changed. So effectively, .read

Correct and that's why you don't need a .read in the new device.

> is just doing a memcpy of the `regs` state. This makes it possible to
> map the page as memory while retaining the same behavior as before.
> (We are changing the code but not the behavior).
> 
> The issue with Windows's buggy tpm.sys driver is that fundamentally it
> cannot work with MemoryRegionOps. The way MMIO is implemented is that

At least not with the .read part as it seems and you have to have the
.write part to be able to react to cmd transfers etc.

> a hole is left in the guest memory space so when the device registers
> are accessed, the hypervisor traps it and sends it over to QEMU to
> handle. QEMU looks up the address, sees its a valid MMIO mapping, and
> calls into the MemoryRegionOps implementation. When tpm.sys does a LDP
> instruction access to the hole, the information for QEMU to determine
> if it's a valid access is not provided. Other hypervisors like Apple's
> VZ.framework and VMware will read the guest PC, manually decode the
> AArch64 instruction, determine the type of access, read the guest Rn
> registers, does a TLB lookup to determine the physical address, then
> emulate the MMIO. None of this capability currently exists in QEMU's
> ARM64 backend. That's why we decided the easier path is to tell QEMU
> that this mapping is RAM for read purposes and MMIO only for write
> purposes (thankfully Windows does not do a STP or we'd be hosed).

Thanks, this confirms what I thought.

    Stefan

