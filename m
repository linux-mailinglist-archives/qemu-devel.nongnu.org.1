Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D21F7FA228
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:14:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cMF-0000go-R8; Mon, 27 Nov 2023 09:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r7cMD-0000gF-EW
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:13:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r7cMA-0004Jt-VQ
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:13:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARDfTGU024136; Mon, 27 Nov 2023 14:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0Ia9IoZX41Mgc23muX2/YE1pE/HvKXfUkcedApIy++U=;
 b=T2ZIBW3uCcQF/Knyn8+VignTDWodNkLdrpeAHn/5COJJKTXt+S8m7Y2D9Ze2EqH/hyX7
 YfeN1U9kwjgpXYg94ZEiE4vmTNhnNmbJGfkO5S1I/OBh3zcnPSjCc7q4+M/CaZnYk3ra
 y6RckvBnD85bECAIUef5XWYhBOdXc2tYz6zO0QtipJMF+JAteQ4cSfrnOcMfblB7p/qk
 x0NpJ3ik9olhZ5uqPYpJ/FYhP4WlHoVvHyNLF7KUPnGK133rMNNpSa7CT31ULBGkUbK8
 3aMVWqKcV/YKbzr6pSFYTW0XHOFrkqc+pNRFfllRwK2gVIUe0Pg81oqC9p5U8ABQmn9T vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umm07d1qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 14:12:58 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARDv7oQ023181;
 Mon, 27 Nov 2023 14:12:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umm07d1pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 14:12:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARE4bDX016119; Mon, 27 Nov 2023 14:12:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1gk4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 14:12:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARECuwi14418646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 14:12:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12B045805D;
 Mon, 27 Nov 2023 14:12:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92CD158057;
 Mon, 27 Nov 2023 14:12:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 14:12:55 +0000 (GMT)
Message-ID: <4e83c3a6-8160-49ba-afd2-0ba77dfb0640@linux.ibm.com>
Date: Mon, 27 Nov 2023 09:12:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
To: Joelle van Dyne <j@getutm.app>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
 <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
 <b1542ca5-18a6-44bd-a639-5765580bdc4d@linux.ibm.com>
 <718d155f-004b-417e-8cba-d79ca4475850@linux.ibm.com>
 <7412f9ab-6826-4e64-a583-a4dc8a921b70@linux.ibm.com>
 <CA+E+eSDnC9cnm2CfPxFkp=yYkcjuBDaLbxb6Uwz3A4nzwAM3CQ@mail.gmail.com>
 <d850ca40-d822-4e7d-b2ee-848f6d4208a7@linux.ibm.com>
 <CA+E+eSANrNo23jcRk=rwLY1E19FHBROz+ifdr6mhEQ88xE0cOw@mail.gmail.com>
 <a375b8d6-ae8e-45cd-816d-9b2737370b7b@linux.ibm.com>
 <CA+E+eSCgUU=-f8XJw8i5RPFG2JauOW-SePyhMZbgB5XRfTMqRw@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSCgUU=-f8XJw8i5RPFG2JauOW-SePyhMZbgB5XRfTMqRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0WQJKAP3PBoR_GD6LklPQWmLUWtO94n-
X-Proofpoint-GUID: NwXUFfAu5ceSOtOhGmrwUjux0vCeVZ2G
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270097
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



On 11/24/23 21:39, Joelle van Dyne wrote:
> On Fri, Nov 24, 2023 at 8:26 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 11/24/23 11:21, Joelle van Dyne wrote:
>>> On Fri, Nov 24, 2023 at 8:17 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/23/23 19:56, Joelle van Dyne wrote:
>>>>> On Tue, Nov 14, 2023 at 4:12 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 11/14/23 16:05, Stefan Berger wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/14/23 13:03, Stefan Berger wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/14/23 04:36, Marc-André Lureau wrote:
>>>>>>>>> Hi
>>>>>>>>>
>>>>>>>>> On Tue, Nov 14, 2023 at 6:12 AM Joelle van Dyne <j@getutm.app> wrote:
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>>>>>>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>>>>
>>>>>>>>> nit: you also added tests for x86, could be a different patch?
>>>>>>>>>
>>>>>>>>> For arm, the test fails until next patch with:
>>>>>>>>>
>>>>>>>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest
>>>>>>>>> unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
>>>>>>>>> socket,path=/tmp/qtest-991279.qmp,id=char0 -mon
>>>>>>>>> chardev=char0,mode=control -display none -audio none -machine virt
>>>>>>>>> -accel tcg -nodefaults -nographic -drive
>>>>>>>>> if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly=on
>>>>>>>>> -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on
>>>>>>>>> -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
>>>>>>>>> -cpu cortex-a57 -chardev
>>>>>>>>> socket,id=chr,path=/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ3GE2/sock
>>>>>>>>> -tpmdev emulator,id=dev,chardev=chr -device tpm-crb-device,tpmdev=dev
>>>>>>>>> -accel qtest
>>>>>>>>> Warning! zero length expected file
>>>>>>>>> 'tests/data/acpi/virt/TPM2.crb-device.tpm2'
>>>>>>>>> Warning! zero length expected file
>>>>>>>>> 'tests/data/acpi/virt/DSDT.crb-device.tpm2'
>>>>>>>>> acpi-test: Warning!  binary file mismatch. Actual
>>>>>>>>> [aml:/tmp/aml-GO4ME2], Expected
>>>>>>>>> [aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
>>>>>>>>> See source file tests/qtest/bios-tables-test.c for instructions on how
>>>>>>>>> to update expected files.
>>>>>>>>> acpi-test: Warning!  binary file mismatch. Actual
>>>>>>>>> [aml:/tmp/aml-6N4ME2], Expected
>>>>>>>>> [aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
>>>>>>>>> See source file tests/qtest/bios-tables-test.c for instructions on how
>>>>>>>>> to update expected files.
>>>>>>>>> to see ASL diff between mismatched files install IASL, rebuild QEMU
>>>>>>>>> from scratch and re-run tests with V=1 environment variable set**
>>>>>>>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
>>>>>>>>> failed: (all_tables_match)
>>>>>>>>> not ok /aarch64/acpi/virt/tpm2-crb -
>>>>>>>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
>>>>>>>>> failed: (all_tables_match)
>>>>>>>>> Bail out!
>>>>>>>>> qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the TPM:
>>>>>>>>> Resource temporarily unavailable
>>>>>>>>> Unexpected error in qio_channel_socket_writev() at
>>>>>>>>> ../io/channel-socket.c:622:
>>>>>>>>> /home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Unable
>>>>>>>>> to write to socket: Bad file descriptor
>>>>>>>>>
>>>>>>>>
>>>>>>>> Travis testing on s390x I see the following failures for this patchset
>>>>>>>> (search for 'ERROR'):
>>>>>>>>
>>>>>>>> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267230363
>>>>>>>>
>>>>>>>> Summary of Failures:
>>>>>>>>
>>>>>>>> 134/320 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-crb-device-test
>>>>>>>> ERROR           0.70s   killed by signal 6 SIGABRT
>>>>>>>>
>>>>>>>> 219/320 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test
>>>>>>>> ERROR           0.88s   killed by signal 6 SIGABRT
>>>>>>>>
>>>>>>>>
>>>>>>>> Summary of Failures:
>>>>>>>>
>>>>>>>> 271/537 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test
>>>>>>>> ERROR           0.59s   killed by signal 6 SIGABRT
>>>>>>>>
>>>>>>>>
>>>>>>>> My guess is it's an endianess issue on big endian machines due to
>>>>>>>> reading from the ROM device where we lost the .endianess:
>>>>>>>>
>>>>>>>> +const MemoryRegionOps tpm_crb_memory_ops = {
>>>>>>>> +    .read = tpm_crb_mmio_read,
>>>>>>>> +    .write = tpm_crb_mmio_write,
>>>>>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>>>>> +    .valid = {
>>>>>>>> +        .min_access_size = 1,
>>>>>>>> +        .max_access_size = 4,
>>>>>>>> +    },
>>>>>>>> +};
>>>>>>>>
>>>>>>>
>>>>>>> I think we need a 2nd set of registers to support the endianess
>>>>>>> conversion. It's not exactly nice, though. Basically the saved_regs
>>>>>>> could be used for this directly, even though I did not do that but
>>>>>>> introduced n_regs:
>>>>>>> https://github.com/stefanberger/qemu-tpm/commit/90f6b21c0dd93dbb13d9e80a628f5b631fd07d91
>>>>>>>
>>>>>>> This patch allows the tests on s390x to run farther but the execution of
>>>>>>> the command doesn't seem to work maybe due to command data that were
>>>>>>> also written in wrong endianess. I don't know. I would have to get
>>>>>>> access to a big endian / s390 machine to be able to fix it.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> The latest version now passes on Travis s390x:
>>>>>> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267245220
>>>>>>
>>>>>
>>>>> Are the tests failing on S390X due to the added code or are they
>>>>> failing because previously it was untested? I don't think the original
>>>>> code took account of endianness and that should be fixed, but feels
>>>>> like it should be in a separate patch set?
>>>>
>>>> They are failing because something like the topmost one or two patches
>>>> as in this branch here are missing for a big endian host:
>>>>
>>>> https://github.com/stefanberger/qemu-tpm/tree/joelle.v5%2B2nd_registers
>>>
>>> Right, but is this issue new due to the patchset? i.e. if just the
>>
>> Yes, it is due to this patchset. The reason is that CRB switched to a
>> ROMD interface where the fact that the MMIO registers are little endian
>> got lost for existing x86_64 support.
>>
>>> tests were added without the other patches, would they still fail? If
>>> so, I think the fixes should be in another patchset while we disable
>>> them in this patchset.
> 
> I see, how do you want to best integrate your changes? Do you want me
> to squash your changes into the patch that introduces the code? Or do
> you want them to be separate commits?

I think squashing them in would be the right thing to do. You may want 
to append _LE to the macros in the 2nd patch if you take them.

     Stefan

