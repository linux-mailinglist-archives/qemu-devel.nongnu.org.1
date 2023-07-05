Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B80777486F2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3tY-0000jt-3l; Wed, 05 Jul 2023 10:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qH3tV-0000gP-Ku; Wed, 05 Jul 2023 10:54:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qH3tT-00052r-F6; Wed, 05 Jul 2023 10:54:13 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365EkBCB014718; Wed, 5 Jul 2023 14:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=n1/8lltmCTysSv23G8HWDNHgfSq6dTdqvlU8wPtKpMc=;
 b=BmOXEsDj9Sn6MnhrBJZzgkhHwD9WNH+z+Qy0wTW1GighjW1ojsK6W+vsrwSL3AUD6r+h
 7LD097vMsKdisfT8GOEuNBrDKryoYMDuVeLbTMenHOBaf3Xa4Sq/DXPQX8F5n55WEqPa
 nIiNWmo7QjBipw3BeV8REG/LhDNB/sVndKnMA2kvx344/KP2QtojxYfLvv4ye54CljKX
 yt0ZgwUc9rl1hI1MxPRtkH2FHnkjXTs3L5aUYEKBb8OfDEhVaUFr/sngtMeerL8zfIHM
 PAOD8+rfPrmUaXEUOTX+UyILI7p7l4p1EbCF5UtndvCdlHsSsOg2+ggd71AJwBJsJLk/ kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnajp871v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 14:54:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365EkPkP015205;
 Wed, 5 Jul 2023 14:54:05 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnajp871h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 14:54:05 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 365CPqBB029952;
 Wed, 5 Jul 2023 14:54:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rjbs5yh90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 14:54:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 365Es3qC56033612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jul 2023 14:54:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52CC858066;
 Wed,  5 Jul 2023 14:54:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7618E5804B;
 Wed,  5 Jul 2023 14:54:02 +0000 (GMT)
Received: from [9.61.162.136] (unknown [9.61.162.136])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Jul 2023 14:54:02 +0000 (GMT)
Message-ID: <497815d2-27ce-fa08-c835-f2245f79bacb@linux.ibm.com>
Date: Wed, 5 Jul 2023 10:54:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230704120137.2604646-1-clg@redhat.com>
 <6fb9e146-7ace-0db6-305b-f6fc135878c1@linaro.org>
 <149fdc25-f88d-67f5-f409-8ea2299e41ef@redhat.com>
 <bf100be6-2b22-f45d-3479-f8ce50cfdf76@linaro.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <bf100be6-2b22-f45d-3479-f8ce50cfdf76@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZT5rmEd3y-o7SJ9_qvOCX7G8jNwnZQFM
X-Proofpoint-ORIG-GUID: E0Hn83LqQCwatOCx6IKJe4EkDKnFS7Bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 mlxlogscore=941 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050131
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 9:33 AM, Philippe Mathieu-Daudé wrote:
> On 4/7/23 14:32, Cédric Le Goater wrote:
>> On 7/4/23 14:09, Philippe Mathieu-Daudé wrote:
>>> On 4/7/23 14:01, Cédric Le Goater wrote:
>>>> It is useful to extend the number of available PCI devices to KVM guests
>>>> for passthrough scenarios and also to expose these models to a different
>>>> (big endian) architecture. Include models for Intel Ethernet adapters
>>>> and one USB controller, which all support MSI-X. Devices only supporting
>>>> INTx won't work on s390x.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>
>>>>   Tested under KVM as a machine device, under KVM nested as a passthrough
>>>>   device
>>>>
>>>>   hw/s390x/Kconfig | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>>>> index 5e7d8a2bae8b..7a82c58cdf6e 100644
>>>> --- a/hw/s390x/Kconfig
>>>> +++ b/hw/s390x/Kconfig
>>>> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>>>>       select SCLPCONSOLE
>>>>       select VIRTIO_CCW
>>>>       select MSI_NONBROKEN
>>>> +    imply PCI_EXPRESS
>>>
>>> No, PCIe is a bus, which is implemented in s390-pci-bus.c;
>>> S390_CCW_VIRTIO exposes this bus, so we Kconfig SELECT it.
>>>
>>>> +    imply E1000E_PCI_EXPRESS
>>>> +    imply IGB_PCI_EXPRESS
>>>> +    imply USB_XHCI_PCI
>>>
>>> These are devices you can plug on a PCIe bus, so Kconfig
>>> IMPLY is correct.
>>
>> If I understand correctly, this should be ?
>>
>> @@ -5,8 +5,11 @@ config S390_CCW_VIRTIO
>>       imply VFIO_AP
>>       imply VFIO_CCW
>>       imply WDT_DIAG288
>> -    select PCI
>> +    select PCI_EXPRESS
>>       select S390_FLIC
>>       select SCLPCONSOLE
>>       select VIRTIO_CCW
>>       select MSI_NONBROKEN
>> +    imply E1000E_PCI_EXPRESS
>> +    imply IGB_PCI_EXPRESS
>> +    imply USB_XHCI_PCI
> 
> This is how I'd write this patch. Note I have zero knowledge of zPCI.
> 

Indeed, our s390x PCI emulation is lacking in some places (e.g. missing legacy interrupts as Thomas indicated in a prior thread) so we want to be selective about what we enable.  

I have no strong objection to adding them as long as you've tested them.

Based on the above comments, will there be a v3?  I don't have the imply'd devices readily available for test but I did do some passthrough and virtio sanity-testing with s390x hardware to make sure this changes doesn't regress anything there.  I used the diff just above (select PCI_EXPRESS + imply*3)

Thanks,
Matt


