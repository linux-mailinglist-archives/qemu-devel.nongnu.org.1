Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDB7FDA98
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:57:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8M02-00007l-Ux; Wed, 29 Nov 2023 09:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r8Lzo-00006R-I5; Wed, 29 Nov 2023 09:57:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r8Lzl-0007hn-Gr; Wed, 29 Nov 2023 09:57:00 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ATEiAPx011907; Wed, 29 Nov 2023 14:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ih1nHrR1TSSuJUsXkba7PLZfJLpEaWddd74IxSPkRtE=;
 b=JS34VWJx8CI1hVns0OCPrGPZXYfX2f2VPob4erv/7h1jHqLXl1AuGK4DzmvlYIep6GBl
 9Bcc9UvMmGU3g7UkHz1iBp36r6DW8NMvYhkHnXByWeB4zm7xSVO+mFZf5Ye8dEEtFu6n
 TRtlxw6AMJ0Cbd6chOEc+rIRP4jc+WkiyIgQ7rujKiNPAZQf79+MOH/bkAvECUty4Zyg
 GZj1q5x+nip9zGXd1WEjuT+poy7y88LMYxyrWzA/nrjs13Au8yHn4DD/zlEDOsOxbomK
 3wz7+wvFJ04Avjnk+p/inP2jNPW9sMcNKimOjte36EXTgBUt3qfm4UAsxRt6/CQENhAC aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up7ar0fq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 14:56:41 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATEj4iD014390;
 Wed, 29 Nov 2023 14:56:40 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up7ar0fma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 14:56:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ATEBNdV004317; Wed, 29 Nov 2023 14:56:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1yapn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 14:56:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ATEua7K49218238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Nov 2023 14:56:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 831C85804E;
 Wed, 29 Nov 2023 14:56:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEC075803F;
 Wed, 29 Nov 2023 14:56:34 +0000 (GMT)
Received: from [9.67.13.86] (unknown [9.67.13.86])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Nov 2023 14:56:34 +0000 (GMT)
Message-ID: <a1fbfc7b-6f5a-44c4-9af4-65dac15763b6@linux.ibm.com>
Date: Wed, 29 Nov 2023 08:56:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Introduce model for IBM's FSI
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <417e8a68-2f35-4315-b694-892f78c811b6@kaod.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <417e8a68-2f35-4315-b694-892f78c811b6@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yFMbS6IkdABEeS6T_VNpwTC4x9dzxXwV
X-Proofpoint-ORIG-GUID: iDLv6uVv22_xiyvZVDWxrDxxjan6_ZJh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_12,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=773 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hello Cedric,

On 11/27/23 10:31, Cédric Le Goater wrote:
> Hello Ninad,
>
> On 10/26/23 18:47, Ninad Palsule wrote:
>> Hello,
>>
>> Please review the patch-set version 7.
>> I have incorporated review comments from Cedric, Philippe and Thomas.
>
>
> I reworked v7 with the suggestions I made in patches 1-6. Please check :
>
>   https://github.com/legoater/qemu/commits/aspeed-8.2
>
> I will have more questions on the mappings because some parts are really
> unclear.
>
I forgot to mention in my last mail. If I build against your aspeed-8.2 
branch then rainier machine is failing to boot.

The same images are working with qemu master branch.

fsi/qemu-system-arm -M rainier-bmc -nographic -kernel 
./fitImage-linux.bin -dtb ./aspeed-bmc-ibm-rainier.dtb -initrd 
./obmc-phosphor-initramfs.rootfs.cpio.xz -drive 
file=./obmc-phosphor-image.rootfs.wic.qcow2,if=sd,index=2 -append 
'rootwait console=ttyS4,115200n8 root=PARTLABEL=rofs-a' -net nic -net 
user,hostfwd=:127.0.0.1:3222-:22,hostfwd=:127.0.0.1:2234-:1234 -trace 'fsi*'
                         |
                         |
Starting systemd-udevd version 254^
[   50.630407] /dev/disk/by-partlabel/rofs-a: Can't open blockdev
mount: mounting /dev/disk/by-partlabel/rofs-a on /mnt/rofs failed: No 
such file or directory
/bin/sh: can't access tty; job control turned off

>
> Thanks,
>
> C.
>
>
>>
>> Ninad Palsule (10):
>>    hw/fsi: Introduce IBM's Local bus
>>    hw/fsi: Introduce IBM's scratchpad
>>    hw/fsi: Introduce IBM's cfam,fsi-slave
>>    hw/fsi: Introduce IBM's FSI
>>    hw/fsi: IBM's On-chip Peripheral Bus
>>    hw/fsi: Aspeed APB2OPB interface
>>    hw/arm: Hook up FSI module in AST2600
>>    hw/fsi: Added qtest
>>    hw/fsi: Added FSI documentation
>>    hw/fsi: Update MAINTAINER list
>>
>>   MAINTAINERS                        |   8 +
>>   docs/specs/fsi.rst                 | 138 +++++++++++++++
>>   docs/specs/index.rst               |   1 +
>>   meson.build                        |   1 +
>>   hw/fsi/trace.h                     |   1 +
>>   include/hw/arm/aspeed_soc.h        |   4 +
>>   include/hw/fsi/aspeed-apb2opb.h    |  33 ++++
>>   include/hw/fsi/cfam.h              |  34 ++++
>>   include/hw/fsi/engine-scratchpad.h |  27 +++
>>   include/hw/fsi/fsi-master.h        |  30 ++++
>>   include/hw/fsi/fsi-slave.h         |  29 +++
>>   include/hw/fsi/fsi.h               |  36 ++++
>>   include/hw/fsi/lbus.h              |  43 +++++
>>   include/hw/fsi/opb.h               |  33 ++++
>>   hw/arm/aspeed_ast2600.c            |  19 ++
>>   hw/fsi/aspeed-apb2opb.c            | 272 +++++++++++++++++++++++++++++
>>   hw/fsi/cfam.c                      | 173 ++++++++++++++++++
>>   hw/fsi/engine-scratchpad.c         |  93 ++++++++++
>>   hw/fsi/fsi-master.c                | 161 +++++++++++++++++
>>   hw/fsi/fsi-slave.c                 |  78 +++++++++
>>   hw/fsi/fsi.c                       |  25 +++
>>   hw/fsi/lbus.c                      |  74 ++++++++
>>   hw/fsi/opb.c                       |  74 ++++++++
>>   tests/qtest/aspeed-fsi-test.c      | 205 ++++++++++++++++++++++
>>   hw/Kconfig                         |   1 +
>>   hw/arm/Kconfig                     |   1 +
>>   hw/fsi/Kconfig                     |  23 +++
>>   hw/fsi/meson.build                 |   6 +
>>   hw/fsi/trace-events                |  13 ++
>>   hw/meson.build                     |   1 +
>>   tests/qtest/meson.build            |   1 +
>>   31 files changed, 1638 insertions(+)
>>   create mode 100644 docs/specs/fsi.rst
>>   create mode 100644 hw/fsi/trace.h
>>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>>   create mode 100644 include/hw/fsi/cfam.h
>>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>>   create mode 100644 include/hw/fsi/fsi-master.h
>>   create mode 100644 include/hw/fsi/fsi-slave.h
>>   create mode 100644 include/hw/fsi/fsi.h
>>   create mode 100644 include/hw/fsi/lbus.h
>>   create mode 100644 include/hw/fsi/opb.h
>>   create mode 100644 hw/fsi/aspeed-apb2opb.c
>>   create mode 100644 hw/fsi/cfam.c
>>   create mode 100644 hw/fsi/engine-scratchpad.c
>>   create mode 100644 hw/fsi/fsi-master.c
>>   create mode 100644 hw/fsi/fsi-slave.c
>>   create mode 100644 hw/fsi/fsi.c
>>   create mode 100644 hw/fsi/lbus.c
>>   create mode 100644 hw/fsi/opb.c
>>   create mode 100644 tests/qtest/aspeed-fsi-test.c
>>   create mode 100644 hw/fsi/Kconfig
>>   create mode 100644 hw/fsi/meson.build
>>   create mode 100644 hw/fsi/trace-events
>>
>

