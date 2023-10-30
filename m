Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B867DC299
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 23:47:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxb1a-00046L-EG; Mon, 30 Oct 2023 18:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxb1Y-000467-A1
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:46:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxb1W-0006Jj-GL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:46:20 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UMkGEG002988; Mon, 30 Oct 2023 22:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iDffuQ8As0rVkfO0MmY3pUJqg5EBBEwgrx7fWFhJSL0=;
 b=EmAehIqnX3TeLA9r30o4HxmFA4JT2+ojgOcOWsV4ke2cb1vZL0kgk4iqdznvOY+j/quj
 CpFmlCRqgClrEwL/h1Dzo2TTcQA8PktNseTsx+UoJgvRZ++ignAOp0Bg5kOSgY5k7nB/
 uMAmpm4Vb1aVjTy7jdKvWpHjEGC+Eoz7ogBpHJUseQ35OWF8SQE4Om/bYOgYiNEjiMX8
 jtcKIJU9iXO0FwBTe1OzbgNrmXwpI07iCUDirmEJGQ7T7WIgrA7ddhTTvPFhQsi6O+TK
 uhrRO07lzyfqmVKy1OqHHkGdeuy97O3byeOhRvW/mVA240fUxgi4K0+LKDdkKo24J16B 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2na08a0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:46:16 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UMkFdC002830;
 Mon, 30 Oct 2023 22:46:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2na089yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:46:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UMN9Ha007713; Mon, 30 Oct 2023 22:42:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmnc9dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 22:42:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39UMgVHq2818716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 22:42:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD2EC5805F;
 Mon, 30 Oct 2023 22:42:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 449245805A;
 Mon, 30 Oct 2023 22:42:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Oct 2023 22:42:31 +0000 (GMT)
Message-ID: <b2828199-610a-4b2e-8964-92513e1872e0@linux.ibm.com>
Date: Mon, 30 Oct 2023 18:42:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] tests: acpi: updated expected blobs for TPM CRB
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-14-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231029060404.71196-14-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r7G9lHpuKACHWksxetY7oECIl2N7eEPY
X-Proofpoint-ORIG-GUID: gh2DtFx0HaolwAlyHNT7BwyCKqSSdzJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300179
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

I see this error here with the test cases:


| 364/377 ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: 
assertion failed: (all_tables_match) ERROR
364/377 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/bios-tables-test                     ERROR 34.83s   killed 
by signal 6 SIGABRT
 >>> QTEST_QEMU_BINARY=./qemu-system-x86_64 MALLOC_PERTURB_=200 
QTEST_QEMU_IMG=./qemu-img 
G_TEST_DBUS_DAEMON=/home/stefanb/qemu-tpm/tests/dbus-vmstate-daemon.sh 
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
PYTHON=/home/stefanb/qemu-tpm/build/pyvenv/bin/python3 
/home/stefanb/qemu-tpm/build/tests/qtest/bios-tables-test --tap -k
--------------------------------------------------------------- 8< 
---------------------------------------------------------------

$ diff tests/data/acpi/virt/TPM2.crb-device.dsl /tmp/aml-98C6D2.dsl
6c6
<  * Disassembly of tests/data/acpi/virt/TPM2.crb-device.tpm2, Mon Oct 
30 18:30:00 2023
---
 >  * Disassembly of /tmp/aml-98C6D2, Mon Oct 30 18:29:29 2023
16c16
< [009h 0009   1]                     Checksum : BA
---
 > [009h 0009   1]                     Checksum : C2
30c30
< [044h 0068   8]                  Log Address : 0000000043D10000
---
 > [044h 0068   8]                  Log Address : 0000000043C90000

The diff is in the address of the TPM log ... Not good. I don't know how 
we could have it ignore the address or not build the TPM2 table with an 
address for a log. It would be good to have test cases.

    Stefan



