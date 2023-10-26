Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9057D8613
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2NF-0005EE-SF; Thu, 26 Oct 2023 11:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw2NC-00059i-3J; Thu, 26 Oct 2023 11:34:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw2NA-00035h-26; Thu, 26 Oct 2023 11:34:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QFXk82015788; Thu, 26 Oct 2023 15:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8S96I+GwIc6BZR8u2xdLhkmxjFWxeXf83Sud5jEP5Lc=;
 b=XX+nvMsV3VxRvdM7L3P47GlSQyppep6Ph6aeyidLqtOMXqAg+Y6LXF/lKI1WC2LdOKWF
 bDc33phG0GxII27SFH9EMAtQ10IiHudOlWLx3s+SikMrvlNB8cBGg6IcMzU0piSok0O1
 8U/2F5G8WI4YREma2upQzhZexuXdNi6nXzvA2HuM6P6OLaiLl5LRMpMg9dKuJGkB+Bd8
 rOn3TGcjirI70pMDLOozywwlmVcF8mDhMDDVBs/SfTjmQmUXw8uxe5IW73cVq9YqlgGF
 aiprY+QX6V2VCIpWXCFio4HpM5N5RydU9DPU5SCwnE64zC8IiRulk0SAa48NRbGT2Jjf AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tytk20c92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:33:56 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QFXsJa016986;
 Thu, 26 Oct 2023 15:33:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tytk20c0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:33:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QEAIFt010231; Thu, 26 Oct 2023 15:30:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyy7bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:30:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QFU6DQ59572566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 15:30:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAA7D58043;
 Thu, 26 Oct 2023 15:30:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 195BC58061;
 Thu, 26 Oct 2023 15:30:06 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 15:30:06 +0000 (GMT)
Message-ID: <e14bc1db-1eb8-4d74-8324-e0b0523040f0@linux.ibm.com>
Date: Thu, 26 Oct 2023 10:30:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] hw/fsi: Added qtest
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-9-ninad@linux.ibm.com>
 <3d1fc354-0daf-4bf4-bf33-d737e180a14c@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <3d1fc354-0daf-4bf4-bf33-d737e180a14c@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKc9fp01ERf4eJIJts3fWbEGgRLoxThw
X-Proofpoint-ORIG-GUID: -rNx5PoAl6o6CA8BNnr_waS5x7lhT1KA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=734 adultscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hello Cedric,

On 10/24/23 02:34, Cédric Le Goater wrote:
> On 10/21/23 23:17, Ninad Palsule wrote:
>> Added basic qtests for FSI model.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v3:
>>   - Added new qtest as per Cedric's comment.
>> V4:
>>   - Remove MAINTAINER and documentation changes from this commit
>> v6:
>>   - Incorporated review comments by Thomas Huth.
>> ---
>>   tests/qtest/fsi-test.c  | 207 ++++++++++++++++++++++++++++++++++++++++
>
> please rename the file to aspeed-fsi-test.c

Renamed it.

Thanks for the review.

Regards,

Ninad

>
> Thanks,
>
> C.
>
>
>>   tests/qtest/meson.build |   1 +
>>   2 files changed, 208 insertions(+)
>>   create mode 100644 tests/qtest/fsi-test.c
>>
>> diff --git a/tests/qtest/fsi-test.c b/tests/qtest/fsi-test.c
>> new file mode 100644
>> index 0000000000..01a0739092
>> --- /dev/null
>> +++ b/tests/qtest/fsi-test.c
>> @@ -0,0 +1,207 @@
>> +/*
>> + * QTest testcases for IBM's Flexible Service Interface (FSI)
>> + *
>> + * Copyright (c) 2023 IBM Corporation
>> + *
>> + * Authors:
>> + *   Ninad Palsule <ninad@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 
>> or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <glib/gstdio.h>
>> +
>> +#include "qemu/module.h"
>> +#include "libqtest-single.h"
>> +
>> +/* Registers from ast2600 specifications */
>> +#define ASPEED_FSI_ENGINER_TRIGGER   0x04
>> +#define ASPEED_FSI_OPB0_BUS_SELECT   0x10
>> +#define ASPEED_FSI_OPB1_BUS_SELECT   0x28
>> +#define ASPEED_FSI_OPB0_RW_DIRECTION 0x14
>> +#define ASPEED_FSI_OPB1_RW_DIRECTION 0x2c
>> +#define ASPEED_FSI_OPB0_XFER_SIZE    0x18
>> +#define ASPEED_FSI_OPB1_XFER_SIZE    0x30
>> +#define ASPEED_FSI_OPB0_BUS_ADDR     0x1c
>> +#define ASPEED_FSI_OPB1_BUS_ADDR     0x34
>> +#define ASPEED_FSI_INTRRUPT_CLEAR    0x40
>> +#define ASPEED_FSI_INTRRUPT_STATUS   0x48
>> +#define ASPEED_FSI_OPB0_BUS_STATUS   0x80
>> +#define ASPEED_FSI_OPB1_BUS_STATUS   0x8c
>> +#define ASPEED_FSI_OPB0_READ_DATA    0x84
>> +#define ASPEED_FSI_OPB1_READ_DATA    0x90
>> +
>> +/*
>> + * FSI Base addresses from the ast2600 specifications.
>> + */
>> +#define AST2600_OPB_FSI0_BASE_ADDR 0x1e79b000
>> +#define AST2600_OPB_FSI1_BASE_ADDR 0x1e79b100
>> +
>> +static uint32_t aspeed_fsi_base_addr;
>> +
>> +static uint32_t aspeed_fsi_readl(QTestState *s, uint32_t reg)
>> +{
>> +    return qtest_readl(s, aspeed_fsi_base_addr + reg);
>> +}
>> +
>> +static void aspeed_fsi_writel(QTestState *s, uint32_t reg, uint32_t 
>> val)
>> +{
>> +    qtest_writel(s, aspeed_fsi_base_addr + reg, val);
>> +}
>> +
>> +/* Setup base address and select register */
>> +static void test_fsi_setup(QTestState *s, uint32_t base_addr)
>> +{
>> +    uint32_t curval;
>> +
>> +    /* Set the base select register */
>> +    if (base_addr == AST2600_OPB_FSI0_BASE_ADDR) {
>> +        aspeed_fsi_base_addr = base_addr;
>> +
>> +        /* Unselect FSI1 */
>> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
>> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
>> +        g_assert_cmpuint(curval, ==, 0x0);
>> +
>> +        /* Select FSI0 */
>> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
>> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
>> +        g_assert_cmpuint(curval, ==, 0x1);
>> +    } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
>> +        aspeed_fsi_base_addr = base_addr;
>> +
>> +        /* Unselect FSI0 */
>> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
>> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
>> +        g_assert_cmpuint(curval, ==, 0x0);
>> +
>> +        /* Select FSI1 */
>> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
>> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
>> +        g_assert_cmpuint(curval, ==, 0x1);
>> +    } else {
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static void test_fsi_reg_change(QTestState *s, uint32_t reg, 
>> uint32_t newval)
>> +{
>> +    uint32_t base;
>> +    uint32_t curval;
>> +
>> +    base = aspeed_fsi_readl(s, reg);
>> +    aspeed_fsi_writel(s, reg, newval);
>> +    curval = aspeed_fsi_readl(s, reg);
>> +    g_assert_cmpuint(curval, ==, newval);
>> +    aspeed_fsi_writel(s, reg, base);
>> +    curval = aspeed_fsi_readl(s, reg);
>> +    g_assert_cmpuint(curval, ==, base);
>> +}
>> +
>> +static void test_fsi0_master_regs(const void *data)
>> +{
>> +    QTestState *s = (QTestState *)data;
>> +
>> +    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
>> +
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0xF3F4F514);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_XFER_SIZE, 0xF3F4F518);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xF3F4F51c);
>> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
>> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_STATUS, 0xF3F4F580);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_READ_DATA, 0xF3F4F584);
>> +}
>> +
>> +static void test_fsi1_master_regs(const void *data)
>> +{
>> +    QTestState *s = (QTestState *)data;
>> +
>> +    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
>> +
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0xF3F4F514);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_XFER_SIZE, 0xF3F4F518);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xF3F4F51c);
>> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
>> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_STATUS, 0xF3F4F580);
>> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_READ_DATA, 0xF3F4F584);
>> +}
>> +
>> +static void test_fsi0_getcfam_addr0(const void *data)
>> +{
>> +    QTestState *s = (QTestState *)data;
>> +    uint32_t curval;
>> +
>> +    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
>> +
>> +    /* Master access direction read */
>> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0x1);
>> +    /* word */
>> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_XFER_SIZE, 0x3);
>> +    /* Address */
>> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xa0000000);
>> +    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
>> +    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
>> +
>> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
>> +    g_assert_cmpuint(curval, ==, 0x10000);
>> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
>> +    g_assert_cmpuint(curval, ==, 0x0);
>> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
>> +    g_assert_cmpuint(curval, ==, 0x152d02c0);
>> +}
>> +
>> +static void test_fsi1_getcfam_addr0(const void *data)
>> +{
>> +    QTestState *s = (QTestState *)data;
>> +    uint32_t curval;
>> +
>> +    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
>> +
>> +    /* Master access direction read */
>> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0x1);
>> +
>> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_XFER_SIZE, 0x3);
>> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xa0000000);
>> +    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
>> +    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
>> +
>> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
>> +    g_assert_cmpuint(curval, ==, 0x20000);
>> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
>> +    g_assert_cmpuint(curval, ==, 0x0);
>> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
>> +    g_assert_cmpuint(curval, ==, 0x152d02c0);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int ret = -1;
>> +    QTestState *s;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    s = qtest_init("-machine ast2600-evb ");
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
>> index d6022ebd64..74228a4aed 100644
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
>

