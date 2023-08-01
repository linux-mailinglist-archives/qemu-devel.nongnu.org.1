Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E895F76BE44
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 22:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQvc8-0003rG-2W; Tue, 01 Aug 2023 16:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qQvc5-0003r3-AP
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 16:05:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qQvc3-0004Sv-9f
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 16:05:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 371JvT2l024426; Tue, 1 Aug 2023 20:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9uxChzT2vFDz9oBu8tQiyEyy8BTG273ixCjP6q3BGzM=;
 b=bor9Sp9rNO+OetrJRFEqsYZFkvPgAn5C7i/rd60RqyfDesezj1popdzKcFOdc8mJSBXn
 z5CAEOJSE721DtmVIIiumOCmfgLoolvZU8j9RNEo1WauvuKLxMrQy322Y7l06Kqhk2CD
 7kPJmecpoHwvswl9UIVJA5xz/cSmdGczavEAd0Ys9mFHBIogx9mPwG23kAMy0Sf3aNgp
 VvzZy08gVJEu1QLFCJ6FFQmLh7PXBoQcqVbaPuraiCa16/rU8RVUCzJTInBqldMEC1SN
 vI7BwwriDXMltzJE89+Bz81a8Tj1nTerbtmIaEqmAQHhj/LzaS3nQS+5OFFZx+l6+waD mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s78nrr578-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 20:04:43 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 371JvVue024639;
 Tue, 1 Aug 2023 20:04:42 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s78nrr43t-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 20:04:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 371IrgnF006073; Tue, 1 Aug 2023 19:38:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5d3sf1hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 19:38:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 371JcXbk3211834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Aug 2023 19:38:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45DE85803F;
 Tue,  1 Aug 2023 19:38:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B709958056;
 Tue,  1 Aug 2023 19:38:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Aug 2023 19:38:32 +0000 (GMT)
Message-ID: <dc4fa093-3940-8fe8-057b-789243648765@linux.ibm.com>
Date: Tue, 1 Aug 2023 15:38:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/11] tpm_crb: move ACPI table building to device
 interface
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-7-j@getutm.app>
 <c3e07358-0d07-ffdc-6dbf-aab763ef92be@linux.ibm.com>
 <20230717154249.3b11f50a@imammedo.users.ipa.redhat.com>
 <CA+E+eSB4KkTP7mkMm4VWb6DE3nhSOOB7O9ibtusAW4KKjqQakg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSB4KkTP7mkMm4VWb6DE3nhSOOB7O9ibtusAW4KKjqQakg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3YRR5vSDafrKRSQykmpezK2bdCFYEWJj
X-Proofpoint-GUID: adkyGtbWOdB1HEpFs86a_CzNZwZcersh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010179
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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



On 7/31/23 23:02, Joelle van Dyne wrote:
> On Mon, Jul 17, 2023 at 6:42 AM Igor Mammedov <imammedo@redhat.com> wrote:
>>
>> On Fri, 14 Jul 2023 13:21:33 -0400
>> Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>> On 7/14/23 03:09, Joelle van Dyne wrote:
>>>> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
>>>> support TPM 2.0 backends, we check for this in realize.
>>>>
>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>>
>>> This patch changes the order of in which the ACPI table elements are created but doesn't matter and also doesn't seem to upset ACPI test cases from what I saw:
>>
>> it seems we do have tests for TIS only (which I added when I was refactoring it to TYPE_ACPI_DEV_AML_IF)
>> perhaps add a test for CRB before this patch a follow process described in bios-tables-test.c
>> for updating expected blob
> I read the file and looked at the commits for TIS tests but I'm not
> sure I understand how it works. At what point do I specify that the
> CRB device should be created for the test?

For me it would be a bit of trial an error as well. So here's my best guess:

Did you look at b193e5f9cccb322b0febd5a2aba486? You basically have to find out which files
are going to change due to extending the tests, so doing something like in that patch comes
after you found out which files are changing and iirc the tests are going to complain about
those files. So I would try to first add CRB tests similar to the following to tests/qtest/bios-tables-test.c.
in one patch, then run the test cases and they will tell you which files changed, and then
add a patch similar to b193e5f9cccb322b0febd5a2aba486 before the test-enabling patch.

             if (tpm_model_is_available("-machine q35", "tpm-tis")) {
                 qtest_add_func("acpi/q35/tpm2-tis", test_acpi_q35_tcg_tpm2_tis);
                 qtest_add_func("acpi/q35/tpm12-tis",
                                test_acpi_q35_tcg_tpm12_tis);
             }

I would try to something like the above to aarch64 here:

     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_virt_tcg);
             qtest_add_func("acpi/virt/acpihmatvirt",
                             test_acpi_virt_tcg_acpi_hmat);


Then you run the tests again then it should create those files with the ACPI data and you copy them
to their destination (like in ca745d2277496464b54fd832c15c45d0227325bb) and remove the changes from
tests/qtest/bios-tables-test-allowed-diff.h and that becomes your 3rd patch. Once you run the tests
again with the 3rd patch there should be no more complaints about ACPI related changes.

Since CRB ACPI tests are not enabled right now you can add these patches somewhere in the middle of
the series or also at the end.


I hope this helps.

    Stefan

