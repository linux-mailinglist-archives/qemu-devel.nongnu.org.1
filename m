Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB9752308
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJw2u-0004aA-PF; Thu, 13 Jul 2023 09:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJw2q-0004ZP-QT
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:07:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJw2n-0000wf-2n
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:07:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DCqcp0001391; Thu, 13 Jul 2023 13:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wkorjVBIQ/cotenUnRUBmylu20tzx2KpjgI6eaiCqq4=;
 b=QJVcfQxihjwVKCE6UmnuwdlA7AuIad+THaElkhvTwN7NRvIyXhwTYJ8Riai8KF2DkS7t
 mrGedhYEuuDpCXh7DRiuMtuCuGKRaAQ5ObVADHJ7RFqvg8I1z+1Z8gthDm5dbHYgYZK1
 mtPlkw91j+QItNGfwnC6mg8z+CH7aOT+dn89ESbunHW/uSYjjNKs4rA7dgYbRe8U6E0A
 eRmEOf6FWOXF5JMl5mlDWTr8OepP7OhLH3h2yDvu/W59natrwgUbn8uZ5UDcRfsqfB6C
 HKnu6P7hp2qmjA+J/3NQS+Y6FFgRdpn59eRThVl3sca2ZB1FnP1h/XFJNXSRICd9/s6j CQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rthnf0egd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 13:07:34 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36D9I2xW005862;
 Thu, 13 Jul 2023 13:07:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3rpye68mj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 13:07:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DD7Wrh3408454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 13:07:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19D1358043;
 Thu, 13 Jul 2023 13:07:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C81D558059;
 Thu, 13 Jul 2023 13:07:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 13:07:31 +0000 (GMT)
Message-ID: <c58eea48-413b-d7e8-2a4e-f5b189536e7a@linux.ibm.com>
Date: Thu, 13 Jul 2023 09:07:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/11] tpm: introduce TPM CRB SysBus device
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20230713035232.48406-1-j@getutm.app>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dEivgZFEDGrSL9-qSLe3AQWCYfHB4C3w
X-Proofpoint-ORIG-GUID: dEivgZFEDGrSL9-qSLe3AQWCYfHB4C3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130114
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



On 7/12/23 23:51, Joelle van Dyne wrote:
> The impetus for this patch set is to get TPM 2.0 working on Windows 11 ARM64.
> Windows' tpm.sys does not seem to work on a TPM TIS device (as verified with
> VMWare's implementation). However, the current TPM CRB device uses a fixed
> system bus address that is reserved for RAM in ARM64 Virt machines.

Thanks a lot for this work. The last sentence seems to hint at the current issue
with TPM CRB on ARM64 and seems to be the only way forward there. You may want
to reformulate it a bit because it's not clear how the 'however' related to
CRB relates to TIS.

> 
> In the process of adding the TPM CRB SysBus device, we also went ahead and
> cleaned up some of the existing TPM hardware code and fixed some bugs. We used

Please reorder bugs to the beginning of the series or submit in an extra patch set
so we can backport them. Ideal would be description(s) for how to trigger the bug(s).

> the TPM TIS devices as a template for the TPM CRB devices and refactored out
> common code. We moved the ACPI DSDT generation to the device in order to handle
> dynamic base address requirements as well as reduce redundent code in different
s/redundent/redundant


> machine ACPI generation. We also changed the tpm_crb device to use the ISA bus
> instead of depending on the default system bus as the device only was built for
> the PC configuration.
> 
> Another change is that the TPM CRB registers are now mapped in the same way that
> the pflash ROM devices are mapped. It is a memory region whose writes are
> trapped as MMIO accesses. This was needed because Apple Silicon does not decode
> LDP caused page faults. @agraf suggested that we do this to avoid having to

Afaik, LDP is an ARM assembly instruction that loads two 32bit or 64bit registers from
consecutive addresses. May be worth mentioning for those wondering about it...

> do AARCH64 decoding in the HVF fault handler.

What is HVF?

Regards,
    Stefan
> 
> Unfortunately, it seems like the LDP fault still happens on HVF but the issue
> seems to be in the HVF backend which needs to be fixed in a separate patch.
> 
> One last thing that's needed to get Windows 11 to recognize the TPM 2.0 device
> is for the OVMF firmware to setup the TPM device. Currently, OVMF for ARM64 Virt
> only recognizes the TPM TIS device through a FDT entry. A workaround is to
> falsely identify the TPM CRB device as a TPM TIS device in the FDT node but this
> causes issues for Linux. A proper fix would involve adding an ACPI device driver
> in OVMF.
> 
> Joelle van Dyne (11):
>    tpm_crb: refactor common code
>    tpm_crb: CTRL_RSP_ADDR is 64-bits wide
>    tpm_ppi: refactor memory space initialization
>    tpm_crb: use a single read-as-mem/write-as-mmio mapping
>    tpm_crb: use the ISA bus
>    tpm_crb: move ACPI table building to device interface
>    hw/arm/virt: add plug handler for TPM on SysBus
>    hw/loongarch/virt: add plug handler for TPM on SysBus
>    tpm_tis_sysbus: fix crash when PPI is enabled
>    tpm_tis_sysbus: move DSDT AML generation to device
>    tpm_crb_sysbus: introduce TPM CRB SysBus device
> 
>   docs/specs/tpm.rst          |   2 +
>   hw/tpm/tpm_crb.h            |  74 +++++++++
>   hw/tpm/tpm_ppi.h            |  10 +-
>   include/hw/acpi/aml-build.h |   1 +
>   include/hw/acpi/tpm.h       |   3 +-
>   include/sysemu/tpm.h        |   3 +
>   hw/acpi/aml-build.c         |   7 +-
>   hw/arm/virt-acpi-build.c    |  38 +----
>   hw/arm/virt.c               |  38 +++++
>   hw/core/sysbus-fdt.c        |   1 +
>   hw/i386/acpi-build.c        |  23 ---
>   hw/loongarch/acpi-build.c   |  38 +----
>   hw/loongarch/virt.c         |  38 +++++
>   hw/riscv/virt.c             |   1 +
>   hw/tpm/tpm_crb.c            | 307 ++++++++----------------------------
>   hw/tpm/tpm_crb_common.c     | 224 ++++++++++++++++++++++++++
>   hw/tpm/tpm_crb_sysbus.c     | 178 +++++++++++++++++++++
>   hw/tpm/tpm_ppi.c            |   5 +-
>   hw/tpm/tpm_tis_isa.c        |   5 +-
>   hw/tpm/tpm_tis_sysbus.c     |  43 +++++
>   tests/qtest/tpm-crb-test.c  |   2 +-
>   tests/qtest/tpm-util.c      |   2 +-
>   hw/arm/Kconfig              |   1 +
>   hw/riscv/Kconfig            |   1 +
>   hw/tpm/Kconfig              |   7 +-
>   hw/tpm/meson.build          |   3 +
>   hw/tpm/trace-events         |   2 +-
>   27 files changed, 703 insertions(+), 354 deletions(-)
>   create mode 100644 hw/tpm/tpm_crb.h
>   create mode 100644 hw/tpm/tpm_crb_common.c
>   create mode 100644 hw/tpm/tpm_crb_sysbus.c
> 

