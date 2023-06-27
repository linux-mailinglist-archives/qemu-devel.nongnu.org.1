Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D273FD73
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9Nm-0005sd-Sv; Tue, 27 Jun 2023 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qE9Na-0005s6-2F; Tue, 27 Jun 2023 10:09:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qE9NY-0006PI-1t; Tue, 27 Jun 2023 10:09:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R6HqBV019157; Tue, 27 Jun 2023 14:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3HQpuaHA0YzORmVMVQEZOPMNbUH11gGX8DWcXtX+zDk=;
 b=fgf9LA+EksEXUFDy4Qa4jhX7X6Mrl8h+z4y05qqGpBBIeprR8XQMpyksd47M8QxyhmSG
 zAqs0GYLXD+gsjaIQWB3WuxX0SOcvToM8VjtyB0HNKY2FEftgy0u3/6JpU1gUccrpQfD
 J2R9qz+A0rfL3AMXPK5Lumt72+RLx7S9gegNPcy4xG8rCr3h4cbIF1zQAg6BfNsOtuFq
 syNrpUx8k1lKk/PgS9PMFDL8SHOOC+ztNKYbSNgKxBn6lSDyrHME7BVoKCxi0yFDkAR7
 qWpToZRdwA5j0vwjiZaQp0EUcHkiYlpEHtM+xa2iNqiRAGW+1Xnl3O9BznAFTGOi7Wuh xg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfbfcaqme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 14:09:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RE97Ql017521
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 14:09:07 GMT
Received: from [10.111.135.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 07:09:06 -0700
Message-ID: <d8e93b7b-5e86-5e26-21cd-fefb76f88204@quicinc.com>
Date: Tue, 27 Jun 2023 15:09:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Peter Maydell <peter.maydell@linaro.org>
CC: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 <qemu-devel@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>,
 <qemu-arm@nongnu.org>
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
 <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
 <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: yt0qlR_X4M0iQdUrWu-mfUHcdqLD1WfE
X-Proofpoint-GUID: yt0qlR_X4M0iQdUrWu-mfUHcdqLD1WfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270130
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023-06-27 14:27, Peter Maydell wrote:
> On Tue, 27 Jun 2023 at 13:52, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>>
>> On 2023-06-27 13:12, Peter Maydell wrote:
>>> On Mon, 26 Jun 2023 at 08:52, Marcin Juszkiewicz
>>> <marcin.juszkiewicz@linaro.org> wrote:
>>>>
>>>> Add PCI Express information into DeviceTree as part of SBSA-REF
>>>> versioning.
>>>>
>>>> Trusted Firmware will read it and provide to next firmware level.
>>>>
>>>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>>> ---
>>>>    hw/arm/sbsa-ref.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>>>> index 0639f97dd5..b87d2ee3b2 100644
>>>> --- a/hw/arm/sbsa-ref.c
>>>> +++ b/hw/arm/sbsa-ref.c
>>>> @@ -171,6 +171,25 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>>>>        return arm_cpu_mp_affinity(idx, clustersz);
>>>>    }
>>>>
>>>> +static void sbsa_fdt_add_pcie_node(SBSAMachineState *sms)
>>>> +{
>>>> +    char *nodename;
>>>> +
>>>> +    nodename = g_strdup_printf("/pcie");
>>>> +    qemu_fdt_add_subnode(sms->fdt, nodename);
>>>> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].base,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].size,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].base,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].size,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].base,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].size,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base,
>>>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size);
>>>> +
>>>> +    g_free(nodename);
>>>
>>>
>>> Why do we need to do this? The firmware should just
>>> know exactly where the PCIE windows are, the same way
>>> it knows where the flash, the UART, the RTC etc etc
>>> all are in the memory map.
>>
>> That is not automatically true (it was not for at least one SoC I have
>> worked on). In a real system which had these dynamically decided, some
>> coprocessor would program the CMN to route these address ranges to
>> certain offsets within certain components, and that same coprocessor
>> could then provide a mechanism for how TF-A could discover these and
>> provide it to later-stage firmware via SiP SMC calls.
>>
>> Sticking the information in the DT lets us emulate this without actually
>> emulating the CMN and the coprocessor, and prototype (and verify) the
>> same firmware interfaces for developing i.e. edk2 support.
> 
> OK. This is the kind of rationale that needs to be described
> in the commit message and comments, though, so it's clear
> why the PCI controller is special in this way.

I mean, ultimately it's not. We've kept static mappings for the items 
that it wouldn't really provide any additional benefit anywhere to be 
able to shuffle around. (Which failed with EHCI.)
Having the UART static has minor debug advantages. Everything else is 
static because it's poor return on investment (it doesn't let us test 
anything interesting in the firmware stacks) to make them dynamic.

> What I'm trying to avoid here is that we start off saying
> "the dtb we pass to the firmware is just a convenient format
> for passing a tiny amount of information to it" and then
> gradually add more and more stuff to it until we've backed
> ourselves into "actually it's almost a complete dtb except
> it's not compliant with the spec". That means there needs
> to be a clear rationale for what is in the dtb versus
> what is "the firmware knows what hardware it runs on".

Yet again I find myself wishing I'd invented a custom format instead of 
using a DT to pass the information across. And I'm not even being sarky 
- it keeps confusing people, and across multiple projects we're being 
asked to repeatedly justify why we're not conforming to bindings that 
are not designed for what we want to do, when we only opted to use an 
existing storage format in order to maximise code reuse.

The purpose of the DT in this platform is to pass information about the 
machine configuration to the highest-level firmware that in real 
hardware it would have means of determining programmatically *handwavy* 
"in other ways", so that that higher-level firmware can abstract the 
information away behind SMC calls that lower levels of firmware can 
access throug into reusable libraries that will also be useful for 
actual hardware platforms.
*and* let us wiggle things around to try to shake out bugs in those (and 
other) firmware components.

Serious question: would it be preferable if we moved to a custom DT node 
where we stick everything in as KEY=VALUE pairs to reduce this confusion?

The end goal at some point in the future is to add an (emulated or 
co-emulated) SCP that can provide us with this information, at which 
point the (not a linux bindings)DT can simply go away forever.

/
     Leif


