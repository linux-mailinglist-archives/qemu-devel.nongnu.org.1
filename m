Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC37EB087
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:05:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2t6J-00016C-At; Tue, 14 Nov 2023 08:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2t6G-00015q-AZ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:05:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2t6E-0005bR-6z
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:05:04 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AECu03U029621; Tue, 14 Nov 2023 13:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mpQrXVC4toC/JU24ZmjTekiR4+bvyF89jXgfPuBmUCc=;
 b=MHlUkChhuN/XJwBPjyodREOKEZvFGAVLELrJlaMr6CIauZpzz897QU/MiAvVs6d+QLJ4
 ErFQ32wP2uJz0D0tMamzY2LtsvZP+6xQ6t0cthUiPQOincWt9Vxv/LjeWZXdc3OSH+7J
 Qf0x+qVeb+Py65pTnXeINEkqXZZTXuX4oMcyRITk0DhguUK74Z8sZxfZ57x7bw/S4+le
 N+K5q77+rtFXYGfazxyQ7eQH9ov4/+TUF+LkAhnb1/AQc6PpWMh7Y7U+e4k5JiBDw7p9
 qfuFfK/5qPwIZi6wh5F6DX0ow6m6CQ4ZczKmNSivDxL62h1KL60ykEI9sRsScCCdRiuT Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uc8s21ebr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 13:04:59 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AECw4gS008116;
 Tue, 14 Nov 2023 13:04:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uc8s21eb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 13:04:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEBKUdx011393; Tue, 14 Nov 2023 13:04:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn1fchc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 13:04:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AED4u8h12255822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 13:04:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D5F55803F;
 Tue, 14 Nov 2023 13:04:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C36458064;
 Tue, 14 Nov 2023 13:04:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 13:04:55 +0000 (GMT)
Message-ID: <fd941c35-f758-46c0-b168-aa8bb4ee59b7@linux.ibm.com>
Date: Tue, 14 Nov 2023 08:04:54 -0500
MIME-Version: 1.0
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eAnJrW2aX-kwHqNGFlvMygIgvIyWGT3j
X-Proofpoint-GUID: NJ6dk7pfWy1rQlnzVUo-hYFPHfPY1CUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140101
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

I had seen errors like these as well. However, the first error appears 
when applying the series after getting it using 'b4 am' -- it complains 
about patch 13. I always take patch 13 & 14 from my email client.

Both of these here pass:

QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/bios-tables-test
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/bios-tables-test


