Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF873FC36
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Br-0005RU-Eg; Tue, 27 Jun 2023 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qE8Bp-0005Qu-1o; Tue, 27 Jun 2023 08:53:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qE8Bm-0004F8-P4; Tue, 27 Jun 2023 08:53:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R8GriD006160; Tue, 27 Jun 2023 12:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v4ff5Ye615VwfmhzhdQIsGtbXc6slQm1U7qomvrltJM=;
 b=QC8FEpQixa5Q0XYQ5zFWVuaKMzNiJHxPJH9kKAuIX6oE5CMTPMvuOQrH5B35bnfv4vnk
 IPFrbYNUnVfOuF/YqImmSxjRo5M0CQP3GGt+IWpPxUQdCNmw90xNKPDuCYf4PXl/08I5
 8GFzHA6zwG+DXrb3+VaSil7Ae5UobDFv6Y1vo5/DktVgk4XRZDPm5MMhQOi4xwTVFChy
 2uerGj6p0yHttdOxNzi2bAv8otypJm5/DTiSnr0y/O/2tHDp93BrxFZvJaTTb1QZ7oHz
 Wp330sP53baOI8dfklhS+jpZH20XqykXv89BYSNDNoxxsME6WYlAnmix789GE9xkdoD6 HQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfbfcajn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:52:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RCqrhM020046
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:52:53 GMT
Received: from [10.111.135.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 05:52:52 -0700
Message-ID: <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
Date: Tue, 27 Jun 2023 13:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Peter Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>
CC: <qemu-devel@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>,
 <qemu-arm@nongnu.org>
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: CJPQ_d7ouQyNDnl7D9TlswPVdZb6jwmd
X-Proofpoint-GUID: CJPQ_d7ouQyNDnl7D9TlswPVdZb6jwmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270119
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

On 2023-06-27 13:12, Peter Maydell wrote:
> On Mon, 26 Jun 2023 at 08:52, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> Add PCI Express information into DeviceTree as part of SBSA-REF
>> versioning.
>>
>> Trusted Firmware will read it and provide to next firmware level.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>>   hw/arm/sbsa-ref.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 0639f97dd5..b87d2ee3b2 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -171,6 +171,25 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>>       return arm_cpu_mp_affinity(idx, clustersz);
>>   }
>>
>> +static void sbsa_fdt_add_pcie_node(SBSAMachineState *sms)
>> +{
>> +    char *nodename;
>> +
>> +    nodename = g_strdup_printf("/pcie");
>> +    qemu_fdt_add_subnode(sms->fdt, nodename);
>> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].base,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].size,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].base,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].size,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].base,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].size,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base,
>> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size);
>> +
>> +    g_free(nodename);
> 
> 
> Why do we need to do this? The firmware should just
> know exactly where the PCIE windows are, the same way
> it knows where the flash, the UART, the RTC etc etc
> all are in the memory map.

That is not automatically true (it was not for at least one SoC I have 
worked on). In a real system which had these dynamically decided, some 
coprocessor would program the CMN to route these address ranges to 
certain offsets within certain components, and that same coprocessor 
could then provide a mechanism for how TF-A could discover these and 
provide it to later-stage firmware via SiP SMC calls.

Sticking the information in the DT lets us emulate this without actually 
emulating the CMN and the coprocessor, and prototype (and verify) the 
same firmware interfaces for developing i.e. edk2 support.

/
     Leif


