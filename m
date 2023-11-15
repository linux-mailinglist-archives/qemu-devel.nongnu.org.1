Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96F7EBA84
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33WY-0001kn-Mq; Tue, 14 Nov 2023 19:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r33WU-0001kR-SP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:12:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r33WR-0001dO-6z
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:12:49 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AF07FJG013431; Wed, 15 Nov 2023 00:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NSgxtRyTqKOkTGfUhc7fRQTfpzN5laBArqCx5kWrxKE=;
 b=j5eX4Lr7ctQ7iNdTuTNQff3LxhKYVTVc0+mV+6/MWJ30EIrTVj2GcV5bs/azgS5O3/Lz
 LJGcTueWwopOEH+y+ngz5+z8xU5siv16mNXrlEOS6tGOvy7Lq2YNV6+eVN68AZO9uJVg
 8+IGEWhvo15G1Rz2cWhSrETiw+G1vVhYkgdFwqIdiOTMpO1sHbxIPhBmDGe/jscbjG7S
 zoMdgt6uiVyjj6jlM64zoupYKcLWyJINXw28JRHRTjwAJNcuvj0LwOHgSW5LO1/WlUtg
 y8vu9Bhjv0zFpQ1elSbxg1hFNUDHtxMcvYjMkohnbk9e7w/eLFloEO+eCZU5Qu53zqgu kA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uck5qg7fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 00:12:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AF088DQ018701;
 Wed, 15 Nov 2023 00:12:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uck5qg7f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 00:12:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEMV6df022165; Wed, 15 Nov 2023 00:12:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekkfgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 00:12:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AF0Ce2j10683058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 00:12:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C716B5805E;
 Wed, 15 Nov 2023 00:12:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D98358051;
 Wed, 15 Nov 2023 00:12:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Nov 2023 00:12:40 +0000 (GMT)
Message-ID: <7412f9ab-6826-4e64-a583-a4dc8a921b70@linux.ibm.com>
Date: Tue, 14 Nov 2023 19:12:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
 <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
 <b1542ca5-18a6-44bd-a639-5765580bdc4d@linux.ibm.com>
 <718d155f-004b-417e-8cba-d79ca4475850@linux.ibm.com>
In-Reply-To: <718d155f-004b-417e-8cba-d79ca4475850@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C0k-zq0tN__tgwRhTbU2GHxrHgz2BRbx
X-Proofpoint-ORIG-GUID: uZpc_MAcyTQPa43MVQHUVJ__hRiC55k1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_23,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150000
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



On 11/14/23 16:05, Stefan Berger wrote:
> 
> 
> On 11/14/23 13:03, Stefan Berger wrote:
>>
>>
>> On 11/14/23 04:36, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Tue, Nov 14, 2023 at 6:12 AM Joelle van Dyne <j@getutm.app> wrote:
>>>>
>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>> nit: you also added tests for x86, could be a different patch?
>>>
>>> For arm, the test fails until next patch with:
>>>
>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest
>>> unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
>>> socket,path=/tmp/qtest-991279.qmp,id=char0 -mon
>>> chardev=char0,mode=control -display none -audio none -machine virt
>>> -accel tcg -nodefaults -nographic -drive
>>> if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly=on
>>> -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on
>>> -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
>>> -cpu cortex-a57 -chardev
>>> socket,id=chr,path=/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ3GE2/sock
>>> -tpmdev emulator,id=dev,chardev=chr -device tpm-crb-device,tpmdev=dev
>>> -accel qtest
>>> Warning! zero length expected file 
>>> 'tests/data/acpi/virt/TPM2.crb-device.tpm2'
>>> Warning! zero length expected file 
>>> 'tests/data/acpi/virt/DSDT.crb-device.tpm2'
>>> acpi-test: Warning!  binary file mismatch. Actual
>>> [aml:/tmp/aml-GO4ME2], Expected
>>> [aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
>>> See source file tests/qtest/bios-tables-test.c for instructions on how
>>> to update expected files.
>>> acpi-test: Warning!  binary file mismatch. Actual
>>> [aml:/tmp/aml-6N4ME2], Expected
>>> [aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
>>> See source file tests/qtest/bios-tables-test.c for instructions on how
>>> to update expected files.
>>> to see ASL diff between mismatched files install IASL, rebuild QEMU
>>> from scratch and re-run tests with V=1 environment variable set**
>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
>>> failed: (all_tables_match)
>>> not ok /aarch64/acpi/virt/tpm2-crb -
>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
>>> failed: (all_tables_match)
>>> Bail out!
>>> qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the TPM:
>>> Resource temporarily unavailable
>>> Unexpected error in qio_channel_socket_writev() at 
>>> ../io/channel-socket.c:622:
>>> /home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Unable
>>> to write to socket: Bad file descriptor
>>>
>>
>> Travis testing on s390x I see the following failures for this patchset 
>> (search for 'ERROR'):
>>
>> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267230363
>>
>> Summary of Failures:
>>
>> 134/320 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-crb-device-test 
>> ERROR           0.70s   killed by signal 6 SIGABRT
>>
>> 219/320 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test 
>> ERROR           0.88s   killed by signal 6 SIGABRT
>>
>>
>> Summary of Failures:
>>
>> 271/537 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test 
>> ERROR           0.59s   killed by signal 6 SIGABRT
>>
>>
>> My guess is it's an endianess issue on big endian machines due to 
>> reading from the ROM device where we lost the .endianess:
>>
>> +const MemoryRegionOps tpm_crb_memory_ops = {
>> +    .read = tpm_crb_mmio_read,
>> +    .write = tpm_crb_mmio_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 4,
>> +    },
>> +};
>>
> 
> I think we need a 2nd set of registers to support the endianess 
> conversion. It's not exactly nice, though. Basically the saved_regs 
> could be used for this directly, even though I did not do that but 
> introduced n_regs: 
> https://github.com/stefanberger/qemu-tpm/commit/90f6b21c0dd93dbb13d9e80a628f5b631fd07d91
> 
> This patch allows the tests on s390x to run farther but the execution of 
> the command doesn't seem to work maybe due to command data that were 
> also written in wrong endianess. I don't know. I would have to get 
> access to a big endian / s390 machine to be able to fix it.
> 
> 

The latest version now passes on Travis s390x: 
https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267245220


