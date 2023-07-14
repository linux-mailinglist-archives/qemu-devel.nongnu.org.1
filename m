Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49685754218
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKN76-0007hu-PA; Fri, 14 Jul 2023 14:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKN74-0007hD-9h; Fri, 14 Jul 2023 14:01:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKN71-0005TY-Em; Fri, 14 Jul 2023 14:01:54 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EHq8sW008541; Fri, 14 Jul 2023 18:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=q9GuIFbfEjzy6ek6MLn46SugcVDlVjVUxxJ1hsvmQrs=;
 b=ac98aNvQN0OnOiayzF++8iLy47ckIrR8lmOrhV11ANNfBuXd7rGemPVB5iV6ThQnZfbQ
 uNij4dyUBnCCHNt4h1pQGWcOv7xf0PwmpWPGyX0CdHusdXm2J+4XR/MScVY2q8Bsx4qn
 CYcLakcq3DzjWyU9l9ZlAiRi9rq8Qt47rkAvztEW7z0rs8Rtt+VEiLlrwqPB75C1C1Zf
 k167eFoKu4lyfLBx+3OK6Y9Q1xWJHpiuFs++5b+WtWxnk/Cr8snQ7mtUFR+G9Vjlr73H
 mvD+y2Bttj7oHvlM1kmmxsGSigN6OpMH8oOav/Jn9UtTZFhmFlstOQmn0yzRhQS+i8qp oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rub4x05hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:01:30 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EHt3Fs017650;
 Fri, 14 Jul 2023 18:01:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rub4x05h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:01:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EDaw3h001157; Fri, 14 Jul 2023 18:01:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvutbcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:01:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EI1SJW16581004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 18:01:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE36A5804E;
 Fri, 14 Jul 2023 18:01:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D46C45803F;
 Fri, 14 Jul 2023 18:01:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 18:01:27 +0000 (GMT)
Message-ID: <da3ed561-ba4d-5782-35b7-edcfae28538f@linux.ibm.com>
Date: Fri, 14 Jul 2023 14:01:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to
 device
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-10-j@getutm.app>
 <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
 <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
 <1a394fc6-4a64-5e00-5631-eb5a6aa4ce59@linux.ibm.com>
 <CA+E+eSCbPXZWk2zst+AunRpL74DOEB437mZqMhpWQ0K+=dvf8A@mail.gmail.com>
 <bd034676-1a9b-59a7-0445-129c32daa7b1@linux.ibm.com>
 <CA+E+eSC7MOOWhZ1WzAAjczX+P8WvjGdLY8wkX=sq98M3YCRVJQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSC7MOOWhZ1WzAAjczX+P8WvjGdLY8wkX=sq98M3YCRVJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mmCy0EW3qw7J1gxMaSoJOhokwIV-7kzL
X-Proofpoint-ORIG-GUID: ImjBZAP6BNjA_awDM6KAdjJ2rtEGeNww
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 7/14/23 13:46, Joelle van Dyne wrote:
> On Fri, Jul 14, 2023 at 10:43 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/14/23 13:39, Joelle van Dyne wrote:
>>> On Fri, Jul 14, 2023 at 10:37 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/14/23 13:29, Joelle van Dyne wrote:
>>>>> On Fri, Jul 14, 2023 at 9:19 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> I don't know whether we would want multiple devices. tpm_find() usage is certainly not prepared for multiple devices.
>>>>> Sorry, "multiple TPM interfaces" here does not mean "at the same
>>>>> time". Will clarify the description.
>>>>>
>>>>>>
>>>>>>
>>>>>> Good for the consolidation.
>>>>>>
>>>>>>
>>>>>> Does moving the TIS to a different address help on aarch64?
>>>>> That was the first thing we tried and no it doesn't help.
>>>>
>>>> I would remove it if we don't have a known alternative address that makes it work. If we do, I think we should document it in tpm.rst.
>>> "It" is referring to tpm-tis-device? Note that it does work fine with Linux VMs.
>>
>> yes, tpm_tis_sysbus and I know it works with Liunux but I see this discussion here around Win 11 on aarch64. Why do we need to user another address than the standard address if for Win 11 on aarch64 it doesn't get it to work.
> The standard address won't work for Linux either.
> 
> TPM TIS on standard address on ARM64 Virt machines = collision with
> DRAM, will not instantiate

I thought that this was working with Linux on the aarch64 virt board as contributed by Eric Auger.

https://github.com/qemu/qemu/commit/fcaa204194e15ba24cd53087dd616aabbc29e64f

Also I had tested it to some extent: https://github.com/stefanberger/swtpm/issues/493#issuecomment-885221109



> TPM TIS on SysBus with dynamically allocated address = works on Linux,
> cannot start on Windows
> 
>>
>>>
>>>>
>>>>
>>>>>>
>>>>>> Can the size really be an option? I don't see it useful and if one gave the wrong size it may break things.
>>>>> It was added for consistency (otherwise we have to determine the size
>>>>> by looking at the interface everywhere). Also, it is possible for the
>>>>> size to be larger than the constant. For example, Apple Silicon uses
>>>>> 16KiB page sizes and we may decide to force the device to be 16KiB
>>>>> aligned (not sure if this is needed yet while we still track down why
>>>>> the dual mapping was not working). In that case, we would need to
>>>>> inform the OS of the true region size to prevent any overlap issues.
>>>>> Both baseaddr and size should be provided only by the plug handler in
>>>>> the virt machine, otherwise things may break even if we get rid of
>>>>> size and have just an incorrect baseaddr.
>>>>>
>>>>>>
>>>>>>
>>>>>>

