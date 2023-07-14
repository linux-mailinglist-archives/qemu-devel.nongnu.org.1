Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C7754383
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 21:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKOu8-0003iR-UR; Fri, 14 Jul 2023 15:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKOu7-0003iJ-3u
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:56:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKOu5-0003hI-1U
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:56:38 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EJpg5t020980; Fri, 14 Jul 2023 19:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EFCpVViomWgdcvBL4xQHD8Itr43BN7whpgfdLW1cpXg=;
 b=J/ICrkQh6pDXHeV1dwBg7S5ERkV+fw/TReFnqvc9x5tkaqcNbgIbF5rD90UiLJCmKFRw
 s85ZPggR1w+7bVEHJqgCvvxKY0j0Ob0Ukq/JGTKva6Y6eptJC63c/GjN3QmjTwbjM7aP
 BQLhAQWhcqgQ/otu0hdXP89dGnblXVkCLj7CROtfS6cBYS3uKJKMhamO1pcQpyQcpn/K
 5cqihmUCzPuiyOL0zel51cL3zcQsdHX3EsV6u73DvJwTIpRN8+xZuBQndV5SQ34IUSvw
 EIkLppf7x6LXA4vcsQTZ+kwrQ5Dn5ef28EAvXjps1eB6i5yE7YeAFSLG08HOSRhYgxeF lw== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rucw2g262-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 19:56:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ED9OJw007309; Fri, 14 Jul 2023 19:56:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs2j79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 19:56:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EJuWUt30343662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 19:56:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F22158061;
 Fri, 14 Jul 2023 19:56:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D87ED58060;
 Fri, 14 Jul 2023 19:56:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 19:56:31 +0000 (GMT)
Message-ID: <cb08ea9e-78cf-ce46-dbc5-d79051965cb7@linux.ibm.com>
Date: Fri, 14 Jul 2023 15:56:31 -0400
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
 <78cee616-94fa-baba-8dad-1dbcbbbbc45a@linux.ibm.com>
 <CA+E+eSAfzpLV_--hZnHjYsfRRrDTzOkVbT68KvdL_otteX94rg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSAfzpLV_--hZnHjYsfRRrDTzOkVbT68KvdL_otteX94rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tHxwdJehphrOq0b0vuZQ1cyyTOUPvdvK
X-Proofpoint-ORIG-GUID: tHxwdJehphrOq0b0vuZQ1cyyTOUPvdvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=732
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140178
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



On 7/14/23 15:44, Joelle van Dyne wrote:
> On Fri, Jul 14, 2023 at 12:12 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/14/23 14:49, Joelle van Dyne wrote:
>>> On Fri, Jul 14, 2023 at 11:41 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/14/23 14:22, Stefan Berger wrote:
>>>>> On 7/14/23 13:04, Joelle van Dyne wrote:
>>>>>> On Fri, Jul 14, 2023 at 7:51 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 7/14/23 10:05, Stefan Berger wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/14/23 03:09, Joelle van Dyne wrote:
>>>>>>>>> When we moved to a single mapping and modified TPM CRB's VMState, it
>>>>>>>>> broke restoring of VMs that were saved on an older version. This
>>>>>>>>> change allows those VMs to gracefully migrate to the new memory
>>>>>>>>> mapping.
>>>>>>>>
>>>>>>>> Thanks. This has to be in 4/11 though.
>>>>>>>>
>>>>>>>
>>>>>>> After applying the whole series and trying to resume state taken with current git
>>>>>>> master I cannot restore it but it leads to this error here. I would just leave it
>>>>>>> completely untouched in 4/11.
>>>>>>>
>>>>>>> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
>>>>>>> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
>>>>>>> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration failed: Invalid argument
>>>>>>>
>>>>>>>        Stefan
>>>>>>
>>>>>> To be clear, you are asking to back out of 4/11? That patch changes
>>>>>> how the registers are mapped so it's impossible to support the old
>>>>>> style register mapping. This patch attempts to fix that with a
>>>>>
>>>>> Why can we not keep the old style register mapping as 'secondary mapping'?
>>>>
>>>> I think the first goal should be for existing TPM CRB device not to change anything, they
>>>> keep their .read and .write behaivor as it.
>>>>
>>>> If you need different .read behavior for the sysbus device due to AARCH64 then it may want to use its own MemoryRegionOps.
>>>>
>>>> I am fairly sure that you could refactor the core of the existing tpm_crb_mmio_write() and have it work on s->regs and mmio regs.
>>>> The former would be used by existing code, the latter for CRB sysbus calling into this new function from a wrapper.
>>>>
>>>>       Stefan
>>>
>>> I agree that new QEMU should be able to read old QEMU state but vice
>>> versa is not always true. There's been many changes in the past that
>>> incremented the vmstate's version_id to indicate that the state format
>>> has changed. Also, we are not changing the .read behavior because in
>>
>> Unfortunately the CRB device is being used by x86 on some distros
>> and the expectation is that this existing device can also downgrade
>> to a previous version of QEMU I would say. I have read people migrating
>> from RHEL 9.x even to RHEL 8.x and the expectation is that this works.
> But would the migration even work due to other parts of QEMU? The only
> way you can, say, migrate from QEMU 8.1.0 to 8.0.0 is if every single
> VMstate has its version_id unchanged. Does QEMU provide that
> guarantee? I'm fine with changing it but just want to make sure
> expectations are set correctly. Have you tested a downgrade and found
> that no other device impeded the process?

No I have not done this. The best we can do is that CRB at least is not the
reason that is causing such a failure and since we are introducing a new
device it need not be the reason, either.

   Stefan

