Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328027DC25F
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 23:19:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxaac-0006mx-J1; Mon, 30 Oct 2023 18:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxaaX-0006mZ-6B
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:18:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxaaJ-0001fm-7p
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:18:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ULlltY003692; Mon, 30 Oct 2023 22:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LaOUvLuWXDksWqG3sVk4bR3K3p89j9w3SgtsMTHCsCY=;
 b=XTs3FWiTLC8Pc+vHcLFw+nUdHY880fVI/ddCshhMd3NY9kiABOfX3E9BovCuGkGmBeMz
 TKmrYI3YPxoMUfAA1aTLLrdqBoZs9nbaU4FIFtpnInTo3Pbjm0UaKSwHS30F3jZOW5zx
 0/9K+mcYpQlQgOdIeeeY7EAYECD3NWy/klEgfMAkhWuOqNAlV8txAW8ljKjuZPa/E0Ix
 TDJrTo8ttMRVmzSUq6xlyIUYS5qAtlrN3z3dd1VStZPAh3bNoSVSq7uIlFQr/VdTJyLn
 CS8sI4x4Bdscfley8dqOZmn7byAmcOX3piOFLNgQZj1I56H9DElr/UyuFF5H81DGMmfr zA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2mq6rmrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:18:08 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UMBAHH030478;
 Mon, 30 Oct 2023 22:18:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2mq6rmqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:18:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UKhj7x011268; Mon, 30 Oct 2023 22:18:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1eujuryk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:18:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39UMI6Wv4391636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 22:18:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72E5658062;
 Mon, 30 Oct 2023 22:18:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 022DC58054;
 Mon, 30 Oct 2023 22:18:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Oct 2023 22:18:05 +0000 (GMT)
Message-ID: <8bd11592-0adc-4495-a0d4-81be298fa9e8@linux.ibm.com>
Date: Mon, 30 Oct 2023 18:18:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] tests: acpi: prepare for TPM CRB tests
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-11-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231029060404.71196-11-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vvqncw1DrmAJPGhg8HxRj1Q31ENbCR--
X-Proofpoint-GUID: 4FOyfvmK5N_Ywc-b30a9Om-956OHDpSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=956
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
>   tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
>   tests/data/acpi/q35/DSDT.crb.tpm2           | 0
>   tests/data/acpi/q35/TPM2.crb.tpm2           | 0
>   tests/data/acpi/virt/DSDT.crb-device.tpm2   | 0
>   tests/data/acpi/virt/TPM2.crb-device.tpm2   | 0
>   5 files changed, 4 insertions(+)
>   create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
>   create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
>   create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
>   create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..c2d1924c2f 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,5 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.crb.tpm2",
> +"tests/data/acpi/q35/TPM2.crb.tpm2",
> +"tests/data/acpi/virt/DSDT.crb.tpm2",
> +"tests/data/acpi/virt/TPM2.crb.tpm2",
> diff --git a/tests/data/acpi/q35/DSDT.crb.tpm2 b/tests/data/acpi/q35/DSDT.crb.tpm2
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/TPM2.crb.tpm2 b/tests/data/acpi/q35/TPM2.crb.tpm2
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/DSDT.crb-device.tpm2 b/tests/data/acpi/virt/DSDT.crb-device.tpm2
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/TPM2.crb-device.tpm2 b/tests/data/acpi/virt/TPM2.crb-device.tpm2
> new file mode 100644
> index 0000000000..e69de29bb2

