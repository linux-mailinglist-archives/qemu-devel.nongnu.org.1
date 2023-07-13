Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE207527A8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 17:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyWT-0003HC-FM; Thu, 13 Jul 2023 11:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyWR-0003GP-AB
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:46:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyWP-0000mU-GC
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:46:27 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DFadq0007523; Thu, 13 Jul 2023 15:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=afSueKlQ38oF0E7j17HGY6ckutl7DlgutghGdcRmrmc=;
 b=XB9cw5gkahEoaaIX7lky6e13W4++CnVzhR5XBlggaZ/NOjg4xRMV0LBmw1Ae0HzS7qY4
 acy9L6Knx310sc+O42uEjE2CVkUrvTcG4yRWuYfp8hCpsacBmLZmYgoXqrs6TgddOhOt
 WLmSQETzFSqdpUCJPvM8jTZRoUPKrLlIDVelEHlcx5LXKVG5ssUk8SSf3fBgj79Ad2c4
 eOPpdxnab8qYm/tcs+JJWIoAoW7cHbFW/pVNBjAa9wghT7qX8k1vRVcKoMLBRmUL0NfO
 qbrV3aI+CGTOZr/de+CjxQBN4lJUhwBTw3zduuenw7CcSPs1DS2XsrQcYT7qfJ8knjWX zQ== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtksfgtk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:46:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36D7VZAf010967; Thu, 13 Jul 2023 15:46:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqk4mk8j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:46:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DFkJR629754086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 15:46:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F207358062;
 Thu, 13 Jul 2023 15:46:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8CC958059;
 Thu, 13 Jul 2023 15:46:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 15:46:18 +0000 (GMT)
Message-ID: <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
Date: Thu, 13 Jul 2023 11:46:18 -0400
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GwUy-SuIcEKhq0Lw5CQ07lOUiDFFYhqz
X-Proofpoint-ORIG-GUID: GwUy-SuIcEKhq0Lw5CQ07lOUiDFFYhqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130137
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/13/23 11:34, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 16:28, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/13/23 10:50, Peter Maydell wrote:
>>> On Thu, 13 Jul 2023 at 15:18, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/12/23 23:51, Joelle van Dyne wrote:
>>>>> On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
>>>>> the exception is not decoded by hardware and we cannot trap the MMIO
>>>>> read. This led to the idea from @agraf to use the same mapping type as
>>>>> ROM devices: namely that reads should be seen as memory type and
>>>>> writes should trap as MMIO.
>>
>>>>> +++ b/hw/tpm/tpm_crb.c
>>>>> @@ -68,7 +68,6 @@ static const VMStateDescription vmstate_tpm_crb_none = {
>>>>>         .name = "tpm-crb",
>>>>>         .pre_save = tpm_crb_none_pre_save,
>>>>>         .fields = (VMStateField[]) {
>>>>> -        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
>>>>
>>>> This has to stay here otherwise we cannot restart VMs from saved state once QEMU is upgraded.
>>>>
>>>> 2023-07-13T14:15:43.997718Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
>>>> 2023-07-13T14:15:43.997813Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
>>>> 2023-07-13T14:15:43.997841Z qemu-system-x86_64: load of migration failed: Invalid argument
>>>
>>> More generally, for migration compatibility in the other
>>> direction you need to use memory_region_init_rom_device_nomigrate()
>>> and make sure you keep migrating the data via this, not
>>> via the MemoryRegion.
>>>
>>> I'm not a super-fan of hacking around the fact that LDP
>>> to hardware registers isn't supported in specific device
>>> models, though...
>>
>> What does this mean for this effort here?
> 
> Usually we say "fix the guest to not try to access hardware
> registers with silly load/store instruction types". The other
> option would be "put in a large amount of effort to support
> emulating those instructions in QEMU userspace when KVM/HVF/etc
> trap and punt them to us". For the last decade or so we have
> taken the first of these approaches :-)

Is Microsoft likely to react to use telling them "fix the guest"?

    Stefan

> 
> thanks
> -- PMM

