Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E27DC262
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 23:20:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxac4-0007PK-TT; Mon, 30 Oct 2023 18:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxabx-0007Nb-W7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:19:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxabk-0001mx-H9
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:19:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UMAXLt005961; Mon, 30 Oct 2023 22:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NKjcOkLYZcFtXNn8dd7SvU+UPezQwfIp/CEouJ2QBas=;
 b=GkdshZE080nG5cM3gzvNFuJqziLOXsiWhiTMDPfmkH85r0uE6vFs2mhMQ4RKfGLQYRJy
 UxiWBlEPlNMLM0rzhFxn67uF5+Y9dtgcjYuW/06hdpTJW8A1XzRIyFYd0r0SHzlToTCA
 SRRp2/zY+fW5fSW0Dns9cp4mxdJwkFEy846NnXgg8D8S011Y6gmFqoFI0vYkVWrznvcb
 UdkeZj3jnZjeTtys3D2JNaa7oW1CJ6gfPsms9te/15o9LDYasu9tYBYxwmwSDGLMUgWR
 SIVUmef2m9bJBYClLD7egTHuhl5INav754tisH5e5cpikmuf95QHt7kPimuKO3p4i6OW 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2n1y07v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:19:38 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UMG6lg023955;
 Mon, 30 Oct 2023 22:19:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2n1y07v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:19:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UL5MAm011389; Mon, 30 Oct 2023 22:19:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1eujus5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:19:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39UMJaEE29753998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 22:19:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5851658054;
 Mon, 30 Oct 2023 22:19:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCB7D5805A;
 Mon, 30 Oct 2023 22:19:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Oct 2023 22:19:35 +0000 (GMT)
Message-ID: <eb51eb3c-cd6b-4383-a63c-789682612e45@linux.ibm.com>
Date: Mon, 30 Oct 2023 18:19:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] tests: acpi: implement TPM CRB tests for ARM virt
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-13-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231029060404.71196-13-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EyrVHXI3T4Q07KeduHgnymzZStcYwf-E
X-Proofpoint-ORIG-GUID: NwLU8Nkg9BuNA3Q4R9uRSwRIu7oXSuh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


On 10/29/23 02:03, Joelle van Dyne wrote:
> Signed-off-by: Joelle van Dyne <j@getutm.app>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   tests/qtest/bios-tables-test.c | 43 ++++++++++++++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 9f4bc15aab..c63bad0205 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1345,6 +1345,28 @@ static void test_acpi_piix4_tcg_numamem(void)
>
>   uint64_t tpm_tis_base_addr;
>
> +static test_data tcg_tpm_test_data(const char *machine)
> +{
> +    if (g_strcmp0(machine, "virt") == 0) {
> +        test_data data = {
> +            .machine = "virt",
> +            .tcg_only = true,
> +            .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +            .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +            .cd =
> +               "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +            .ram_start = 0x40000000ULL,
> +            .scan_len = 128ULL * 1024 * 1024,
> +        };
> +        return data;
> +    } else {
> +        test_data data = {
> +            .machine = machine,
> +        };
> +        return data;
> +    }
> +}
> +
>   static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>                                 uint64_t base, enum TPMVersion tpm_version)
>   {
> @@ -1352,7 +1374,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>                                             machine, tpm_if);
>       char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
>       TPMTestState test;
> -    test_data data = {};
> +    test_data data = tcg_tpm_test_data(machine);
>       GThread *thread;
>       const char *suffix = tpm_version == TPM_VERSION_2_0 ? "tpm2" : "tpm12";
>       char *args, *variant = g_strdup_printf(".%s.%s", tpm_if, suffix);
> @@ -1372,13 +1394,14 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>       thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
>       tpm_emu_test_wait_cond(&test);
>
> -    data.machine = machine;
>       data.variant = variant;
>
>       args = g_strdup_printf(
> +        " %s"
>           " -chardev socket,id=chr,path=%s"
>           " -tpmdev emulator,id=dev,chardev=chr"
>           " -device tpm-%s,tpmdev=dev",
> +        g_strcmp0(machine, "virt") == 0 ? "-cpu cortex-a57" : "",
>           test.addr->u.q_unix.path, tpm_if);
>
>       test_acpi_one(args, &data);
> @@ -1404,6 +1427,16 @@ static void test_acpi_q35_tcg_tpm12_tis(void)
>       test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_1_2);
>   }
>
> +static void test_acpi_q35_tcg_tpm2_crb(void)
> +{
> +    test_acpi_tcg_tpm("q35", "crb", 0xFED40000, TPM_VERSION_2_0);
> +}
> +
> +static void test_acpi_virt_tcg_tpm2_crb(void)
> +{
> +    test_acpi_tcg_tpm("virt", "crb-device", 0xFED40000, TPM_VERSION_2_0);
> +}
> +
>   static void test_acpi_tcg_dimm_pxm(const char *machine)
>   {
>       test_data data = {};
> @@ -2110,6 +2143,9 @@ int main(int argc, char *argv[])
>                   qtest_add_func("acpi/q35/tpm12-tis",
>                                  test_acpi_q35_tcg_tpm12_tis);
>               }
> +            if (tpm_model_is_available("-machine q35", "tpm-crb")) {
> +                qtest_add_func("acpi/q35/tpm2-crb", test_acpi_q35_tcg_tpm2_crb);
> +            }
>               qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
>               qtest_add_func("acpi/q35/no-acpi-hotplug",
>                              test_acpi_q35_tcg_no_acpi_hotplug);
> @@ -2191,6 +2227,9 @@ int main(int argc, char *argv[])
>                   qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
>               }
>           }
> +        if (tpm_model_is_available("-machine virt", "tpm-crb")) {
> +            qtest_add_func("acpi/virt/tpm2-crb", test_acpi_virt_tcg_tpm2_crb);
> +        }
>       }
>       ret = g_test_run();
>       boot_sector_cleanup(disk);

