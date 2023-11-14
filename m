Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A57EB613
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 19:04:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xkw-0007MO-Qd; Tue, 14 Nov 2023 13:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2xks-0007Fy-7J
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 13:03:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2xkl-00012X-LM
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 13:03:17 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEHvjvu002193; Tue, 14 Nov 2023 18:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gV6Z/SR3Ytu8slBddCmm/gatirF7AYy0zaG2fKvvko8=;
 b=HqTex9hNNGzqUdFPu1Hs+/SekR4Tx9oOf80pOLZgLQu3pXaWOihbvGNflEDZXVYzX+PH
 K/jA233E1PTTIWzGQRC0goB42GYDmyUY56KrOkm0NSKjxkE/tySlBZtkLDIjJhiNidFR
 XmRhPQntSyZz1H1YFAxJiRZJecNDMZw4hV8LDq0PqaX0+WIXoxnWE5a4Qf7CspRcabAX
 klzz/aQsskv6p18xaDHg88+PUYydkJc/SuBNNfYc2OJ65DXPPp4YhAtyVwGIp3n0sIau
 Wbpu1JxIpB3sHZnRL4srMf4pYDE4wk2ZTu4PAIgScj2VKn0TqPOryeaI00cIvzgtojLP lA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdrc06kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 18:03:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEHvsQX004701;
 Tue, 14 Nov 2023 18:03:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdrc06jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 18:03:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEGY0sN017532; Tue, 14 Nov 2023 18:03:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekhfww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 18:03:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEI37E618219620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 18:03:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4893258043;
 Tue, 14 Nov 2023 18:03:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B213C58059;
 Tue, 14 Nov 2023 18:03:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 18:03:06 +0000 (GMT)
Message-ID: <b1542ca5-18a6-44bd-a639-5765580bdc4d@linux.ibm.com>
Date: Tue, 14 Nov 2023 13:03:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
 <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tN1tccY9U0mB4mhwedm8S6IVZpfWOqQq
X-Proofpoint-GUID: jGg3_-ybZEL7TT2obAGQghHxSnXzpeYG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140136
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 11/14/23 04:36, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Nov 14, 2023 at 6:12 AM Joelle van Dyne <j@getutm.app> wrote:
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> nit: you also added tests for x86, could be a different patch?
> 
> For arm, the test fails until next patch with:
> 
> # starting QEMU: exec ./qemu-system-aarch64 -qtest
> unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
> socket,path=/tmp/qtest-991279.qmp,id=char0 -mon
> chardev=char0,mode=control -display none -audio none -machine virt
> -accel tcg -nodefaults -nographic -drive
> if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly=on
> -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on
> -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
> -cpu cortex-a57 -chardev
> socket,id=chr,path=/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ3GE2/sock
> -tpmdev emulator,id=dev,chardev=chr -device tpm-crb-device,tpmdev=dev
> -accel qtest
> Warning! zero length expected file 'tests/data/acpi/virt/TPM2.crb-device.tpm2'
> Warning! zero length expected file 'tests/data/acpi/virt/DSDT.crb-device.tpm2'
> acpi-test: Warning!  binary file mismatch. Actual
> [aml:/tmp/aml-GO4ME2], Expected
> [aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
> See source file tests/qtest/bios-tables-test.c for instructions on how
> to update expected files.
> acpi-test: Warning!  binary file mismatch. Actual
> [aml:/tmp/aml-6N4ME2], Expected
> [aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
> See source file tests/qtest/bios-tables-test.c for instructions on how
> to update expected files.
> to see ASL diff between mismatched files install IASL, rebuild QEMU
> from scratch and re-run tests with V=1 environment variable set**
> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
> failed: (all_tables_match)
> not ok /aarch64/acpi/virt/tpm2-crb -
> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
> failed: (all_tables_match)
> Bail out!
> qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the TPM:
> Resource temporarily unavailable
> Unexpected error in qio_channel_socket_writev() at ../io/channel-socket.c:622:
> /home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Unable
> to write to socket: Bad file descriptor
> 

Travis testing on s390x I see the following failures for this patchset 
(search for 'ERROR'):

https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267230363

Summary of Failures:

134/320 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-crb-device-test 
   ERROR           0.70s   killed by signal 6 SIGABRT

219/320 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test 
   ERROR           0.88s   killed by signal 6 SIGABRT


Summary of Failures:

271/537 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test 
          ERROR           0.59s   killed by signal 6 SIGABRT


My guess is it's an endianess issue on big endian machines due to 
reading from the ROM device where we lost the .endianess:

+const MemoryRegionOps tpm_crb_memory_ops = {
+    .read = tpm_crb_mmio_read,
+    .write = tpm_crb_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};


