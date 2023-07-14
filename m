Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF0753D1F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 16:21:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKJeA-0002UV-6I; Fri, 14 Jul 2023 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKJdi-0002Sr-F9
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:19:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKJdg-0003TV-LG
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:19:22 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EEHmU7031961; Fri, 14 Jul 2023 14:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HQdfjd8ZpcrjUIsf35lNszjKUf31LzRsJTL+GDY5Y5g=;
 b=dwVewO+6hNesorm7FA/f8kJZ6qeqqCzpDShktrfdpDwZN3+MytMm8zTo9gjhPOhjn/Hi
 4c9Y9P/i2VF6aVptZ+CpWdY3C1j/tcEBDE9J15KTjuNbgONDmAc+6GB1tpdvTaSdRjTy
 khFV3wMK0IcMUqMaq5UyVnJ1S0wHtleSg2tx2kXgDTvqSPqGY4VXyx3anUtkl9Bs97ot
 oKQI4Oh1E5wCmyKuSj6DdumTAcmK5JGt+tD82U9X454lp9Gmhu7vj3n7/y2eCyPOjoqA
 8BgFhaPciyw72ePJWzAMI9Zj5k+v4ASpfcJ0WWZ6sBvmIrxh0+W1WVhmUtvS751TXnqx FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru804810v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 14:19:16 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EEJF1s005101;
 Fri, 14 Jul 2023 14:19:15 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru804810n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 14:19:15 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EE1wnf008508;
 Fri, 14 Jul 2023 14:19:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rtq33p9e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 14:19:15 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EEJDfx62128456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 14:19:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 707575806C;
 Fri, 14 Jul 2023 14:19:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FE925806E;
 Fri, 14 Jul 2023 14:19:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 14:19:13 +0000 (GMT)
Message-ID: <6db33e13-523f-8b03-f668-40fbc7f03729@linux.ibm.com>
Date: Fri, 14 Jul 2023 10:19:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/tpm: TIS on sysbus: Remove unsupport ppi command line
 option
Content-Language: en-US
To: eric.auger@redhat.com, Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 ard.biesheuvel@linaro.org
References: <20230713171955.149236-1-stefanb@linux.ibm.com>
 <CA+E+eSA1O=39JRjWni1YnVg3uwWATpe2zw8EWgDEBbv+EPgU7w@mail.gmail.com>
 <56a562bf-5b3d-0914-f530-dd965587a3db@linux.ibm.com>
 <d1a121d2-b0ec-7928-ff21-ce5389cf7749@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <d1a121d2-b0ec-7928-ff21-ce5389cf7749@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ayZ9MZ2CojJPZ4S6k_Sjg7ZRaK-fdUgg
X-Proofpoint-GUID: eQX-Vc-3kyv5JmLwYjGWkCF98IKCcZVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140128
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



On 7/14/23 09:51, Eric Auger wrote:
> Hi Stefan,
> On 7/14/23 13:51, Stefan Berger wrote:
>>
>>
>> On 7/14/23 02:07, Joelle van Dyne wrote:
>>> On Thu, Jul 13, 2023 at 10:20 AM Stefan Berger
>>> <stefanb@linux.ibm.com> wrote:
>>>>
>>>> The ppi command line option for the TIS device on sysbus never worked
>>>> and caused an immediate segfault. Remove support for it since it also
>>>> needs support in the firmware and needs testing inside the VM.
>>>>
>>>> Reproducer with the ppi=on option passed:
>>>>
>>>> qemu-system-aarch64 \
>>>>      -machine virt,gic-version=3 \
>>>>      -m 4G  \
>>>>      -nographic -no-acpi \
>>>>      -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>>>>      -tpmdev emulator,id=tpm0,chardev=chrtpm \
>>>>      -device tpm-tis-device,tpmdev=tpm0,ppi=on
>>>> [...]
>>>> Segmentation fault (core dumped)
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>> Do you need to add a VMSTATE_UNUSED_TEST in case a future QEMU version
>>> introduces a new field in the same position which will cause an issue
>>> when restoring from an older version?
>>
>> Hm, you got a point there. We will have to error-out in case someone
>> sets ppi=on instead since the expectation that PPI would work is
>> simply not there. v2 coming soon.
> as Joelle pointed it out ppi_enabled is not part of
> vmstate_tpm_tis_sysbus fields. And since it has never worked I suspect
> we cannot have any existing VM enabling it. So I don't get the issue
> with this 1st version?

You are right. I repeated my test with restoring state of a VM taken before the removal of this field and it restored it. So that other patch is good and I am withdrawing this patch here.

     Stefan

> 
> Thanks
> 
> Eric
>>
>>      Stefan
>>
> 

