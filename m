Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF47D3AB4
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwoG-00050v-DB; Mon, 23 Oct 2023 11:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quwoD-00050Q-Gl; Mon, 23 Oct 2023 11:25:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quwoB-0001Dv-2n; Mon, 23 Oct 2023 11:25:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NFCM7I015348; Mon, 23 Oct 2023 15:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rfNReCA2fliiYz8Pmb03KS1qVpFI9bMjFGApcMeCDSU=;
 b=DUBJOK/PWvg6ehgJ2ZQmabY+DOYyeArPc3U5TeYV7SUqxhVIqYoF9zJiJZJO9MrlFxQB
 T1GGQr5ycsGg1mxsJY/+704SmQxqKBXMCz6hznCp2hCJV8MY8XiZrm4FfWShhdXEYMeA
 7Rg6MK84ATeLzb/vvxgUMYc2CAa/EbTqDr8ZYt1ems6YNb6cRLAwIcO5Cvwac+tTLEXA
 Lh+NxemXL+q2SIGYVDDAg4r1jvL091PtFvcoA1x84mUCma3i7nBZvFL1ihonaaZTTrS1
 o3Nmjze2z/H0NSjYjNtUcXgCaXsnV4YboyxLY8SpuAsSjhoTMzBKe75w2gVdd0oFPhGf fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twu910erq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 15:25:19 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39NFOXtF002239;
 Mon, 23 Oct 2023 15:25:18 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twu910er2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 15:25:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NCfYVH023782; Mon, 23 Oct 2023 15:25:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryssqdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 15:25:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39NFPHRr23593648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 15:25:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 237BC58056;
 Mon, 23 Oct 2023 15:25:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D46A058052;
 Mon, 23 Oct 2023 15:25:15 +0000 (GMT)
Received: from [9.67.93.191] (unknown [9.67.93.191])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Oct 2023 15:25:15 +0000 (GMT)
Message-ID: <f33cbb81-0f01-4ed9-827b-c86b46210ebf@linux.ibm.com>
Date: Mon, 23 Oct 2023 10:25:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] hw/fsi: Added qtest
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, clg@kaod.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-9-ninad@linux.ibm.com>
 <567d1dbf-8b4b-4447-b6ab-c6125ef9daff@redhat.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <567d1dbf-8b4b-4447-b6ab-c6125ef9daff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JQDnEotFoLrzg6Rc5pEajVKYEGP5culC
X-Proofpoint-GUID: sYTH0ERC5Y0N2gMaDxlNnjBP3YzsiMo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_14,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=564 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230134
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

On 10/23/23 01:51, Thomas Huth wrote:
> On 21/10/2023 23.17, Ninad Palsule wrote:
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
>
> You could move "aspeed_fsi_base_addr = base_addr" before the 
> if-statement, so that you don't have to repeat it in both cases.

Fixed it. I will update it in version 7.

Thanks for the review.

Regards,

Ninad

>
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
>
> Anyway:
> Acked-by: Thomas Huth <thuth@redhat.com>
>

