Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E75267526F8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 17:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyF9-0004f9-AB; Thu, 13 Jul 2023 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyF4-0004dr-Ax
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:28:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyF2-00012k-Fz
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:28:30 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DFMltj023617; Thu, 13 Jul 2023 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jPmaGAsOj8gholVS4Yy0WKHmorktmsj3SmDoVrO+XWM=;
 b=rl0UyrYinWEEQxeRr7Ei4yueOBIzAgZ6fjPdLS3Hgv8GhMzomwbnNxZKKRJ62kNt3Oxx
 V45TU6uU78DQ+J5AhwTE1Uryvk4kibMV4Jn2iel0gvjidlOQrQJpI8kCJXNltQHdy4J3
 YQcXSK2EOjD5nRUfrhSel/+zhKOkl4/ARstDmiNU1zyjNBYzDJlMbFGspMtUNoNsJy2g
 lWb40TP4xVfgqLWofaMNGsFsPBzO/mMZqov+o1rR83VU0jk18rOkf4kBORAgc6i8mxzH
 UNBrH6JY/AbQTB35zQ1rS7p7i8rmoE8mRH7aYRLyiFqm8ta0Z+nz/EB3KKoHoZJ2cFi9 Ew== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtkurr3mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:28:25 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DDQNIU014052;
 Thu, 13 Jul 2023 15:28:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
 by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rpye612qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 15:28:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DFSNI027656744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 15:28:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA72A58045;
 Thu, 13 Jul 2023 15:28:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44E3D58050;
 Thu, 13 Jul 2023 15:28:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 15:28:23 +0000 (GMT)
Message-ID: <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
Date: Thu, 13 Jul 2023 11:28:22 -0400
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XlSVuE-_-4VeUo1aHdDMVwqJx5fYtCsU
X-Proofpoint-GUID: XlSVuE-_-4VeUo1aHdDMVwqJx5fYtCsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=955 adultscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130132
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



On 7/13/23 10:50, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 15:18, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 7/12/23 23:51, Joelle van Dyne wrote:
>>> On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
>>> the exception is not decoded by hardware and we cannot trap the MMIO
>>> read. This led to the idea from @agraf to use the same mapping type as
>>> ROM devices: namely that reads should be seen as memory type and
>>> writes should trap as MMIO.

>>> +++ b/hw/tpm/tpm_crb.c
>>> @@ -68,7 +68,6 @@ static const VMStateDescription vmstate_tpm_crb_none = {
>>>        .name = "tpm-crb",
>>>        .pre_save = tpm_crb_none_pre_save,
>>>        .fields = (VMStateField[]) {
>>> -        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
>>
>> This has to stay here otherwise we cannot restart VMs from saved state once QEMU is upgraded.
>>
>> 2023-07-13T14:15:43.997718Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
>> 2023-07-13T14:15:43.997813Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
>> 2023-07-13T14:15:43.997841Z qemu-system-x86_64: load of migration failed: Invalid argument
> 
> More generally, for migration compatibility in the other
> direction you need to use memory_region_init_rom_device_nomigrate()
> and make sure you keep migrating the data via this, not
> via the MemoryRegion.
> 
> I'm not a super-fan of hacking around the fact that LDP
> to hardware registers isn't supported in specific device
> models, though...

What does this mean for this effort here?

    Stefan

> 
> thanks
> -- PMM

