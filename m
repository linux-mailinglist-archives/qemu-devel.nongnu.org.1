Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B587F169B
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:02:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55n3-0001Sq-NQ; Mon, 20 Nov 2023 10:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r55mg-0001Ju-5H
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:01:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r55mc-0005AB-LE
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:01:57 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKEeomY032023; Mon, 20 Nov 2023 15:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KHY+rxpzjEsLJDlE5bcVk2Zye4mLpkTMZm/iMXmwOBU=;
 b=exDAj2/VSlQTBBKg3UQF557+D3mlSjxJtsVAMObLFKPQukTQTJUT8ILeE7+7grAmshpV
 Ppc30bDojidwdIl59emXGYYTgSVmc9ihovq/jLCuWINMP0zW4a+if0YzGLVQ+82lW/QS
 PPkJ1fNhkRMPiKY8CdkezqtHG0Mit8ujv9cdpV1gtsabsCIHKEINPdDj2jRKAh2v2D5d
 hPlXSMZ0+axXlh6OsTRjd+1qqL+JZ4jAarZy84/rGz4eHQtJYwHC65kcHUEFa0tqbkMb
 xJs3ynE6NoloxWIcnIVh5WPlpgPSLz2G7q4Zx7SB/Q0UzkcEZhJnKuOLc84mQs3AxAeY oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89ejf7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 15:01:50 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKEgID2004125;
 Mon, 20 Nov 2023 15:01:48 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89ejf6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 15:01:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKDS2Sc028315; Mon, 20 Nov 2023 15:01:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kst57s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 15:01:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AKF1je341419062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 15:01:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8970158053;
 Mon, 20 Nov 2023 15:01:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3828E5805D;
 Mon, 20 Nov 2023 15:01:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Nov 2023 15:01:45 +0000 (GMT)
Message-ID: <8a7e9875-8185-4b72-8e81-6347f6740dd8@linux.ibm.com>
Date: Mon, 20 Nov 2023 10:01:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] tpm: introduce TPM CRB SysBus device
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org
References: <20231114020927.62315-1-j@getutm.app>
 <CAJ+F1CJunC52JX=YOiycHDeTVxVRwjuV9veQZ1QaN1=JCuo7nQ@mail.gmail.com>
 <CA+E+eSAd_NyD4WH5VEcz8G6pSD+AMZDcrkbPHgHB5KDmG=P+aQ@mail.gmail.com>
 <CAJ+F1CK7gT1AC_985wy74KgB+eDwgw0LXQnpQA7Pydb2EmfAwg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAJ+F1CK7gT1AC_985wy74KgB+eDwgw0LXQnpQA7Pydb2EmfAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uRxsvFhTJvtlG6tT9VZQCPP2qVzGazNk
X-Proofpoint-ORIG-GUID: s919Gasf8-nhvgxpfFPBlFWr5i9VYKVA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 11/20/23 03:29, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Nov 14, 2023 at 11:25 PM Joelle van Dyne <j@getutm.app> wrote:
>>
>> On Tue, Nov 14, 2023 at 1:38 AM Marc-André Lureau
>> <marcandre.lureau@gmail.com> wrote:
>>>
>>> Hi
>>>
>>> On Tue, Nov 14, 2023 at 6:10 AM Joelle van Dyne <j@getutm.app> wrote:
>>>>
>>>> The impetus for this patch set is to get TPM 2.0 working on Windows 11 ARM64.
>>>> Windows' tpm.sys does not seem to work on a TPM TIS device (as verified with
>>>> VMWare's implementation). However, the current TPM CRB device uses a fixed
>>>> system bus address that is reserved for RAM in ARM64 Virt machines.
>>>>
>>>> In the process of adding the TPM CRB SysBus device, we also went ahead and
>>>> cleaned up some of the existing TPM hardware code and fixed some bugs. We used
>>>> the TPM TIS devices as a template for the TPM CRB devices and refactored out
>>>> common code. We moved the ACPI DSDT generation to the device in order to handle
>>>> dynamic base address requirements as well as reduce redundent code in different
>>>> machine ACPI generation. We also changed the tpm_crb device to use the ISA bus
>>>> instead of depending on the default system bus as the device only was built for
>>>> the PC configuration.
>>>>
>>>> Another change is that the TPM CRB registers are now mapped in the same way that
>>>> the pflash ROM devices are mapped. It is a memory region whose writes are
>>>> trapped as MMIO accesses. This was needed because Apple Silicon does not decode
>>>> LDP (AARCH64 load pair of registers) caused page faults. @agraf suggested that
>>>> we do this to avoid having to do AARCH64 decoding in the HVF backend's fault
>>>> handler.
>>>>
>>>> Unfortunately, it seems like the LDP fault still happens on HVF but the issue
>>>> seems to be in the HVF backend which needs to be fixed in a separate patch.
>>>>
>>>> One last thing that's needed to get Windows 11 to recognize the TPM 2.0 device
>>>> is for the OVMF firmware to setup the TPM device. Currently, OVMF for ARM64 Virt
>>>> only recognizes the TPM TIS device through a FDT entry. A workaround is to
>>>> falsely identify the TPM CRB device as a TPM TIS device in the FDT node but this
>>>> causes issues for Linux. A proper fix would involve adding an ACPI device driver
>>>> in OVMF.
>>>>
>>>> This has been tested on ARM64 with `tpm-crb-device` and on x86_64 with
>>>> `tpm-crb`. Additional testing should be performed on other architectures (RISCV
>>>> and Loongarch for example) as well as migration cases.
>>>>
>>>> v5:
>>>> - Fixed a typo in "tpm_crb: use a single read-as-mem/write-as-mmio mapping"
>>>> - Fixed ACPI tables not being created for pc CRB device
>>>>
>>>> v4:
>>>> - Fixed broken test blobs
>>>>
>>>> v3:
>>>> - Support backwards and forwards migration of existing tpm-crb device
>>>> - Dropped patch which moved tpm-crb to ISA bus due to migration concerns
>>>> - Unified `tpm_sysbus_plug` handler for ARM and Loongarch
>>>> - Added ACPI table tests for tpm-crb-device
>>>> - Refactored TPM CRB tests to run on tpm-crb-device for ARM Virt
>>>>
>>>> v2:
>>>> - Fixed an issue where VMstate restore from an older version failed due to name
>>>>    collision of the memory block.
>>>> - In the ACPI table generation for CRB devices, the check for TPM 2.0 backend is
>>>>    moved to the device realize as CRB does not support TPM 1.0. It will error in
>>>>    that case.
>>>> - Dropped the patch to fix crash when PPI is enabled on TIS SysBus device since
>>>>    a separate patch submitted by Stefan Berger disables such an option.
>>>> - Fixed an issue where we default tpmEstablished=0 when it should be 1.
>>>> - In TPM CRB SysBus's ACPI entry, we accidently changed _UID from 0 to 1. This
>>>>    shouldn't be an issue but we changed it back just in case.
>>>> - Added a patch to migrate saved VMstate from an older version with the regs
>>>>    saved separately instead of as a RAM block.
>>>>
>>>> Joelle van Dyne (14):
>>>>    tpm_crb: refactor common code
>>>>    tpm_crb: CTRL_RSP_ADDR is 64-bits wide
>>>>    tpm_ppi: refactor memory space initialization
>>>>    tpm_crb: use a single read-as-mem/write-as-mmio mapping
>>>>    tpm_crb: move ACPI table building to device interface
>>>>    tpm-sysbus: add plug handler for TPM on SysBus
>>>>    hw/arm/virt: connect TPM to platform bus
>>>>    hw/loongarch/virt: connect TPM to platform bus
>>>>    tpm_tis_sysbus: move DSDT AML generation to device
>>>>    tests: acpi: prepare for TPM CRB tests
>>>>    tpm_crb_sysbus: introduce TPM CRB SysBus device
>>>>    tests: acpi: implement TPM CRB tests for ARM virt
>>>>    tests: acpi: updated expected blobs for TPM CRB
>>>>    tests: add TPM-CRB sysbus tests for aarch64
>>>
>>> The series looks good to me.
>>> Have you checked there are no regressions with Windows HLK?
>> I don't have any experience with Windows HLK. Is there any guide on
>> running it with QEMU? Preferably with a prebuilt image? Or maybe
>> someone in the mailing list can run it?
>>
> 
> I haven't done it for a while. (it wasn't that hard, just a bit
> tedious: install a Controller on a Windows Server VM, and set up a
> target VM)
> 
> There is also AutoHCK, but I never managed to use it.
> (https://github.com/HCK-CI/AutoHCK)
> 
> For the current results, they are summarized here:
> https://github.com/stefanberger/libtpms/wiki/Testing-of-libtpms-Functionality
> 
> Stefan, do you have a working setup? I'll try to make one if it can help.

Once we have the fixes for big endian support I can run some tests. It 
should be rather quick to verify that the CRB interface still works, 
even with Linux. What I would be more concerned are suspend/upgrade or 
downgrade/resume tests.

    Stefan

> 
> 
>>>
>>> thanks
>>>
>>>>
>>>>   docs/specs/tpm.rst                        |   2 +
>>>>   hw/tpm/tpm_crb.h                          |  79 ++++++
>>>>   hw/tpm/tpm_ppi.h                          |  10 +-
>>>>   include/hw/acpi/tpm.h                     |   3 +-
>>>>   include/sysemu/tpm.h                      |   7 +
>>>>   tests/qtest/tpm-tests.h                   |   2 +
>>>>   tests/qtest/tpm-util.h                    |   4 +-
>>>>   hw/acpi/aml-build.c                       |   7 +-
>>>>   hw/arm/virt-acpi-build.c                  |  38 +--
>>>>   hw/arm/virt.c                             |   8 +
>>>>   hw/core/sysbus-fdt.c                      |   1 +
>>>>   hw/i386/acpi-build.c                      |  16 +-
>>>>   hw/loongarch/acpi-build.c                 |  38 +--
>>>>   hw/loongarch/virt.c                       |   8 +
>>>>   hw/riscv/virt.c                           |   1 +
>>>>   hw/tpm/tpm-sysbus.c                       |  47 ++++
>>>>   hw/tpm/tpm_crb.c                          | 302 ++++++----------------
>>>>   hw/tpm/tpm_crb_common.c                   | 262 +++++++++++++++++++
>>>>   hw/tpm/tpm_crb_sysbus.c                   | 162 ++++++++++++
>>>>   hw/tpm/tpm_ppi.c                          |   5 +-
>>>>   hw/tpm/tpm_tis_isa.c                      |   5 +-
>>>>   hw/tpm/tpm_tis_sysbus.c                   |  37 +++
>>>>   tests/qtest/bios-tables-test.c            |  47 +++-
>>>>   tests/qtest/tpm-crb-device-swtpm-test.c   |  72 ++++++
>>>>   tests/qtest/tpm-crb-device-test.c         |  71 +++++
>>>>   tests/qtest/tpm-crb-swtpm-test.c          |   2 +
>>>>   tests/qtest/tpm-crb-test.c                | 121 +--------
>>>>   tests/qtest/tpm-tests.c                   | 121 +++++++++
>>>>   tests/qtest/tpm-tis-device-swtpm-test.c   |   2 +-
>>>>   tests/qtest/tpm-tis-device-test.c         |   2 +-
>>>>   tests/qtest/tpm-tis-i2c-test.c            |   3 +
>>>>   tests/qtest/tpm-tis-swtpm-test.c          |   2 +-
>>>>   tests/qtest/tpm-tis-test.c                |   2 +-
>>>>   tests/qtest/tpm-util.c                    |  16 +-
>>>>   hw/arm/Kconfig                            |   1 +
>>>>   hw/loongarch/Kconfig                      |   2 +
>>>>   hw/riscv/Kconfig                          |   1 +
>>>>   hw/tpm/Kconfig                            |   5 +
>>>>   hw/tpm/meson.build                        |   5 +
>>>>   hw/tpm/trace-events                       |   2 +-
>>>>   tests/data/acpi/q35/DSDT.crb.tpm2         | Bin 0 -> 8355 bytes
>>>>   tests/data/acpi/q35/TPM2.crb.tpm2         | Bin 0 -> 76 bytes
>>>>   tests/data/acpi/virt/DSDT.crb-device.tpm2 | Bin 0 -> 5276 bytes
>>>>   tests/data/acpi/virt/TPM2.crb-device.tpm2 | Bin 0 -> 76 bytes
>>>>   tests/qtest/meson.build                   |   4 +
>>>>   45 files changed, 1057 insertions(+), 468 deletions(-)
>>>>   create mode 100644 hw/tpm/tpm_crb.h
>>>>   create mode 100644 hw/tpm/tpm-sysbus.c
>>>>   create mode 100644 hw/tpm/tpm_crb_common.c
>>>>   create mode 100644 hw/tpm/tpm_crb_sysbus.c
>>>>   create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
>>>>   create mode 100644 tests/qtest/tpm-crb-device-test.c
>>>>   create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
>>>>   create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
>>>>   create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
>>>>   create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2
>>>>
>>>> --
>>>> 2.41.0
>>>>
>>>>
>>>
>>>
>>> --
>>> Marc-André Lureau
> 
> 
> 
> --
> Marc-André Lureau

