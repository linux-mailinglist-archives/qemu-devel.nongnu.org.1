Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB67A6796
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicKo-0000st-Km; Tue, 19 Sep 2023 11:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qicKm-0000s2-6P; Tue, 19 Sep 2023 11:08:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qicKj-0000RX-L7; Tue, 19 Sep 2023 11:08:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JAlOMK009476; Tue, 19 Sep 2023 15:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r97l5vwZS5XFaxpRvXTKnunfsGMbtSmMIzYbzbl6vSI=;
 b=j3BP849dZqsJdiU9H2NpT2lSOGYIUz13gzHc+41VmHLq2lvFZSVud1BHAhLLdsE8OB3/
 /uKmgC9G2fS3l0Tt148nMzOpd7iXa8fUpSCb0kX7LXkdO+yee5qXTLA0HLNFwfyFMk/R
 0J95AMXg3tnzBieEk9bC+Z4B7NcuNUdHv2zA2uCpAM/5urJSp9xJSzgfxc+SKNWedJq2
 U0bviaR0I6xtNzukLSEFZQJQ2k1i8qPdeThV1M4XZOTc1eA1BdfNYy2EsjS/28sX7Kg/
 MiZtvWJ6Dvb1Hdm3A2j0gZNRhrnsrLuNOvSxSxd5wuQMqrhgp2LaNrBrRF9eHNKcWozz xQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6pmq2vrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 15:07:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JF7sM3006424
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 15:07:54 GMT
Received: from [10.111.128.147] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 08:07:52 -0700
Message-ID: <e4223f6d-fe0c-411a-a345-a79c019d1bee@quicinc.com>
Date: Tue, 19 Sep 2023 16:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] virt: wire up NS EL2 virtual timer IRQ
Content-Language: en-GB
To: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Ard Biesheuvel
 <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
References: <20230919101240.2569334-1-peter.maydell@linaro.org>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20230919101240.2569334-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: MLNbrbXCcFuaKNZXI49Xl980BczZg0T_
X-Proofpoint-ORIG-GUID: MLNbrbXCcFuaKNZXI49Xl980BczZg0T_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=643 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023-09-19 11:12, Peter Maydell wrote:
> This patchset is an RFC that wires up the NS EL2 virtual timer IRQ on
> the virt board, similarly to what
> https://patchew.org/QEMU/20230913140610.214893-1-marcin.juszkiewicz@linaro.org/
> does for the sbsa-ref board.
> 
> Patches 1 and 3 are the usual dance to keep the ACPI unit tests happy
> with the change to the ACPI table contents; patch 2 is the meat.
> 
> This is an RFC for two reasons:
> 
> (1) I'm not very familiar with ACPI, and patch 2 needs to update the
> ACPI GTDT table to report the interrupt number.  In particular, this
> means we need the rev 3 of this table (present in ACPI spec 6.3 and
> later), not the rev 2 we currently report.  I'm not sure if it's
> permitted to rev just this table, or if we would need to upgrade all
> our ACPI tables to the newer spec first.

Ard already provided the answer for this.

> (2) The change causes EDK2 (UEFI) to assert on startup:
> ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48
> This is because the EDK2 code that consumes the QEMU generated device
> tree blob is incorrectly insisting that the architectural-timer
> interrupts property has only 3 or 4 entries, so it falls over if
> given a dtb with the 5th entry for the EL2 virtual timer irq.  In
> particular this breaks the avocado test:
> machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
> I'm not entirely sure what to do about this -- we can get EDK2 fixed
> and update our own test case, but there's a lot of binaries out there
> in the wild that won't run if we just update the virt board the way
> this patchset does.  We could perhaps make the virt board change be
> dependent on machine type version, as a way to let users fall back to
> the old behaviour.

And kind of this one too. Although I might expand somewhat:
As I understand it, this only breaks an existing setup where someone is
- Running a DEBUG build of edk2
- With virtualization=on
I don't see that (currently) happening outside development/ci, and the 
RELEASE builds should save anyone not actually working on edk2 but only 
running it to test other things.

Ard has given me an r-b on the fix, so that can be merged today.
It will then land in edk2-stable202311 around the end of November, but 
will be on the main branch as soon as it passes ci.

I have one comment on my own, which is this clearly has a merge conflict 
with my PPI rework patches.

Regards,

Leif

> I'm putting this patchset out on the list to get opinions and
> review on those two points.
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>    tests/qtest/bios-tables-test: Allow changes to virt GTDT
>    hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
>    tests/qtest/bios-tables-test: Update virt/GTDT golden reference
> 
>   include/hw/arm/virt.h     |   2 ++
>   hw/arm/virt-acpi-build.c  |  16 ++++++++++++----
>   hw/arm/virt.c             |  29 ++++++++++++++++++++++++++++-
>   tests/data/acpi/virt/GTDT | Bin 96 -> 104 bytes
>   4 files changed, 42 insertions(+), 5 deletions(-)
> 


