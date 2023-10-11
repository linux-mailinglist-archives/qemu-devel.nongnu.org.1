Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD927C59A7
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcUQ-0007kG-RP; Wed, 11 Oct 2023 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qqcUB-0007Fg-86; Wed, 11 Oct 2023 12:55:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qqcU8-0001O6-II; Wed, 11 Oct 2023 12:55:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BGlhUc010198; Wed, 11 Oct 2023 16:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4Zl6vTRMQqU2eJF3c+UNxdx4QTlsfKgHCABC6R4wmKw=;
 b=qtvigNjyAvqcBxzLqfDBUc/WW5tNujR3KM/6IVf4jPc8ix/ksnnhWweZrPWExGtlFmV6
 s5Lfj/KfRcfcSdsPk3+eM24cf5/AjX94dCzI3icxEoSQzYaM6z89fv9hSPbCUPViPA0N
 2NkoE2RuJx6qOcFegTMxTAikJrTy/X5lPRGXlwGaEN427/+mQNiRcB1+sNOJQiZcdtu0
 yh73a3VTlGnPMNOZ+nho/8oGxq/68qB/ONR8Ih3PaWfbgUIbMUb795Thduzh/YtcMBqc
 PgrG6g9xohqOycvAMgNmh0VcYR1EZksEC9ivcF5ta9YRQPY2L4RwcGj9/2WarquSHM2L 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnyhmrd2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:54:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BGmPb1013549;
 Wed, 11 Oct 2023 16:54:46 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnyhmrd1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:54:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BFJDdf001147; Wed, 11 Oct 2023 16:54:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk13qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:54:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39BGsiaf21168668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 16:54:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B338C58055;
 Wed, 11 Oct 2023 16:54:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00A225804B;
 Wed, 11 Oct 2023 16:54:44 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Oct 2023 16:54:43 +0000 (GMT)
Message-ID: <46e787e3-6901-47da-b7e3-26c9f0d5aafa@linux.ibm.com>
Date: Wed, 11 Oct 2023 11:54:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] hw/fsi: Added qtest
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, clg@kaod.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-9-ninad@linux.ibm.com>
 <cacc4a01-88e9-4631-a6d6-fbee2b483fd6@redhat.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <cacc4a01-88e9-4631-a6d6-fbee2b483fd6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D16UPvwG0hdNY8spdLZGSV-FpPTBph62
X-Proofpoint-ORIG-GUID: 5Gy7xxj9uaxd7mSAXLpZAd-7OQgC_x99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 phishscore=0 mlxlogscore=884 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
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

Hello Thomas,

Thanks for the review.

On 10/11/23 10:35, Thomas Huth wrote:
> On 11/10/2023 17.13, Ninad Palsule wrote:
>> Added basic qtests for FSI model.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v3:
>>   - Added new qtest as per Cedric's comment.
>> V4:
>>   - Remove MAINTAINER and documentation changes from this commit
>> ---
>>   tests/qtest/fsi-test.c  | 210 ++++++++++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build |   2 +
>>   2 files changed, 212 insertions(+)
>>   create mode 100644 tests/qtest/fsi-test.c
>>
>> diff --git a/tests/qtest/fsi-test.c b/tests/qtest/fsi-test.c
>> new file mode 100644
>> index 0000000000..30bb7475c7
>> --- /dev/null
>> +++ b/tests/qtest/fsi-test.c
>> @@ -0,0 +1,210 @@
> ...
>> +int main(int argc, char **argv)
>> +{
>> +    int ret = -1;
>> +    QTestState *s;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    s = qtest_init("-machine ast2600-evb ");
>> +    if (s == NULL) {
>> +        return -ENOMEM;
>
> returning -ENOMEM here does not make too much sense ... and actually 
> qtest_init() cannot return NULL. So please drop this if-statement.
Removed if condition.
>
>> +    }
>> +
>> +    /* Tests for OPB/FSI0 */
>> +    qtest_add_data_func("/fsi-test/test_fsi0_master_regs", s,
>> +                        test_fsi0_master_regs);
>> +
>> +    qtest_add_data_func("/fsi-test/test_fsi0_getcfam_addr0", s,
>> +                        test_fsi0_getcfam_addr0);
>> +
>> +    /* Tests for OPB/FSI1 */
>> +    qtest_add_data_func("/fsi-test/test_fsi1_master_regs", s,
>> +                        test_fsi1_master_regs);
>> +
>> +    qtest_add_data_func("/fsi-test/test_fsi1_getcfam_addr0", s,
>> +                        test_fsi1_getcfam_addr0);
>> +
>> +    ret = g_test_run();
>> +    qtest_quit(s);
>> +
>> +    return ret;
>> +}
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index b071d400b3..5976081b44 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -207,6 +207,7 @@ qtests_arm = \
>>     (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? 
>> ['tpm-tis-i2c-test'] : []) + \
>>     (config_all_devices.has_key('CONFIG_VEXPRESS') ? 
>> ['test-arm-mptimer'] : []) + \
>>     (config_all_devices.has_key('CONFIG_MICROBIT') ? 
>> ['microbit-test'] : []) + \
>> +  (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? 
>> ['fsi-test'] : []) + \
>>     ['arm-cpu-features',
>>      'boot-serial-test']
>>   @@ -318,6 +319,7 @@ qtests = {
>>     'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>>     'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
>>     'netdev-socket': files('netdev-socket.c', 
>> '../unit/socket-helpers.c'),
>> +  'fsi-test': files('fsi-test.c'),
>
> I think this hunk here is not required - you only need to specify 
> additional dependencies here, not the main file.

Removed list of files.

Thanks!

~Ninad

>
>  Thomas
>

