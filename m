Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C0754280
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNRN-0005qw-7f; Fri, 14 Jul 2023 14:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKNRK-0005qU-GU
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:22:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKNRH-0005yH-UG
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:22:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EIH6O5031086; Fri, 14 Jul 2023 18:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jh5z0u3a9679klDy4rEAlQAkSsjBGHw4uKV0lJFMP/I=;
 b=Y+vvj5+nj8QFpgQXLn0BMHiCzy9SB8OKBzNHWQeKQ5raB9GXelv0Lh1PeAhKKADaOq/D
 KOF1w+Uj4Qmk896iIQN/BvXrVPpvqc701NSlT0inwBbczetA/56N6JyqMP+LPJMxRO+X
 CdTMxqE2ISDiXNa3J5zUOU+hujTzFMPHaH/Dz8PYtvCdsHjEzgQEAt3exc9qx5kCBfZY
 ULsUuqJ7W7eLB00hm5Pv5Ju9GGr+cYOM4OzkI7zdXH8DwgFXEspzmKUyEGGJ+rpj95SD
 /VErt0xxrqk/s9eQa/Gpo6RMd46obVRDcIgsSITiQsX8WIn70gQbVH55xTlOZev1/W97 3w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rubgq82r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:22:44 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EGZSQx008094;
 Fri, 14 Jul 2023 18:22:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rtqkhvu1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:22:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EIMgbo22282614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 18:22:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5378C58056;
 Fri, 14 Jul 2023 18:22:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DD6B5803F;
 Fri, 14 Jul 2023 18:22:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 18:22:42 +0000 (GMT)
Message-ID: <67a2b78d-8eea-7c9c-cf1b-50444e481006@linux.ibm.com>
Date: Fri, 14 Jul 2023 14:22:41 -0400
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -wAzKNJv-kU4wHveWB5udf5VDDXx857r
X-Proofpoint-ORIG-GUID: -wAzKNJv-kU4wHveWB5udf5VDDXx857r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=851 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140165
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

On 7/14/23 13:04, Joelle van Dyne wrote:
> On Fri, Jul 14, 2023 at 7:51 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/14/23 10:05, Stefan Berger wrote:
>>>
>>>
>>> On 7/14/23 03:09, Joelle van Dyne wrote:
>>>> When we moved to a single mapping and modified TPM CRB's VMState, it
>>>> broke restoring of VMs that were saved on an older version. This
>>>> change allows those VMs to gracefully migrate to the new memory
>>>> mapping.
>>>
>>> Thanks. This has to be in 4/11 though.
>>>
>>
>> After applying the whole series and trying to resume state taken with current git
>> master I cannot restore it but it leads to this error here. I would just leave it
>> completely untouched in 4/11.
>>
>> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
>> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
>> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration failed: Invalid argument
>>
>>      Stefan
> 
> To be clear, you are asking to back out of 4/11? That patch changes
> how the registers are mapped so it's impossible to support the old
> style register mapping. This patch attempts to fix that with a

Why can we not keep the old style register mapping as 'secondary mapping'?

The expectation is that old VM state / CRB state can be used by the new QEMU and
also new QEMU CRB state should be readable by old QEMU. So in a way the old 'secondary'
mmaping has to hold the true value of the registers so that the latter works.


> migration path but I realized that I missed the "tpm-crb-cmd"
> ramblock. It can be added to v3 for this patch. Similar to the logic
> to have `legacy_regs` we will add a `legacy_cmdmem` memory region that
> is not registered with the system bus but only exists to migrate the
> data. Would that work? Also open to better ideas on migrating legacy
> saved state.
> 
> If we back out of 4/11 (the split mapping), then the proposed way for
> working on Apple Silicon would not be available and we would have to
> go down the path of emulating AArch64 instruction in HVF backend (or
> decide not to support Apple Silicon).

