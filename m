Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 582377D48A7
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 09:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBvo-0003k5-8Z; Tue, 24 Oct 2023 03:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1ohf=GG=kaod.org=clg@ozlabs.org>)
 id 1qvBvm-0003ee-7z; Tue, 24 Oct 2023 03:34:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1ohf=GG=kaod.org=clg@ozlabs.org>)
 id 1qvBvj-0007Es-H3; Tue, 24 Oct 2023 03:34:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SF3j55JSBz4x1x;
 Tue, 24 Oct 2023 18:34:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SF3j16kbCz4wcf;
 Tue, 24 Oct 2023 18:34:13 +1100 (AEDT)
Message-ID: <3d1fc354-0daf-4bf4-bf33-d737e180a14c@kaod.org>
Date: Tue, 24 Oct 2023 09:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] hw/fsi: Added qtest
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-9-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231021211720.3571082-9-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1ohf=GG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/21/23 23:17, Ninad Palsule wrote:
> Added basic qtests for FSI model.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v3:
>   - Added new qtest as per Cedric's comment.
> V4:
>   - Remove MAINTAINER and documentation changes from this commit
> v6:
>   - Incorporated review comments by Thomas Huth.
> ---
>   tests/qtest/fsi-test.c  | 207 ++++++++++++++++++++++++++++++++++++++++

please rename the file to aspeed-fsi-test.c

Thanks,

C.


>   tests/qtest/meson.build |   1 +
>   2 files changed, 208 insertions(+)
>   create mode 100644 tests/qtest/fsi-test.c
> 
> diff --git a/tests/qtest/fsi-test.c b/tests/qtest/fsi-test.c
> new file mode 100644
> index 0000000000..01a0739092
> --- /dev/null
> +++ b/tests/qtest/fsi-test.c
> @@ -0,0 +1,207 @@
> +/*
> + * QTest testcases for IBM's Flexible Service Interface (FSI)
> + *
> + * Copyright (c) 2023 IBM Corporation
> + *
> + * Authors:
> + *   Ninad Palsule <ninad@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +
> +#include "qemu/module.h"
> +#include "libqtest-single.h"
> +
> +/* Registers from ast2600 specifications */
> +#define ASPEED_FSI_ENGINER_TRIGGER   0x04
> +#define ASPEED_FSI_OPB0_BUS_SELECT   0x10
> +#define ASPEED_FSI_OPB1_BUS_SELECT   0x28
> +#define ASPEED_FSI_OPB0_RW_DIRECTION 0x14
> +#define ASPEED_FSI_OPB1_RW_DIRECTION 0x2c
> +#define ASPEED_FSI_OPB0_XFER_SIZE    0x18
> +#define ASPEED_FSI_OPB1_XFER_SIZE    0x30
> +#define ASPEED_FSI_OPB0_BUS_ADDR     0x1c
> +#define ASPEED_FSI_OPB1_BUS_ADDR     0x34
> +#define ASPEED_FSI_INTRRUPT_CLEAR    0x40
> +#define ASPEED_FSI_INTRRUPT_STATUS   0x48
> +#define ASPEED_FSI_OPB0_BUS_STATUS   0x80
> +#define ASPEED_FSI_OPB1_BUS_STATUS   0x8c
> +#define ASPEED_FSI_OPB0_READ_DATA    0x84
> +#define ASPEED_FSI_OPB1_READ_DATA    0x90
> +
> +/*
> + * FSI Base addresses from the ast2600 specifications.
> + */
> +#define AST2600_OPB_FSI0_BASE_ADDR 0x1e79b000
> +#define AST2600_OPB_FSI1_BASE_ADDR 0x1e79b100
> +
> +static uint32_t aspeed_fsi_base_addr;
> +
> +static uint32_t aspeed_fsi_readl(QTestState *s, uint32_t reg)
> +{
> +    return qtest_readl(s, aspeed_fsi_base_addr + reg);
> +}
> +
> +static void aspeed_fsi_writel(QTestState *s, uint32_t reg, uint32_t val)
> +{
> +    qtest_writel(s, aspeed_fsi_base_addr + reg, val);
> +}
> +
> +/* Setup base address and select register */
> +static void test_fsi_setup(QTestState *s, uint32_t base_addr)
> +{
> +    uint32_t curval;
> +
> +    /* Set the base select register */
> +    if (base_addr == AST2600_OPB_FSI0_BASE_ADDR) {
> +        aspeed_fsi_base_addr = base_addr;
> +
> +        /* Unselect FSI1 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x0);
> +
> +        /* Select FSI0 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x1);
> +    } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
> +        aspeed_fsi_base_addr = base_addr;
> +
> +        /* Unselect FSI0 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x0);
> +
> +        /* Select FSI1 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x1);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void test_fsi_reg_change(QTestState *s, uint32_t reg, uint32_t newval)
> +{
> +    uint32_t base;
> +    uint32_t curval;
> +
> +    base = aspeed_fsi_readl(s, reg);
> +    aspeed_fsi_writel(s, reg, newval);
> +    curval = aspeed_fsi_readl(s, reg);
> +    g_assert_cmpuint(curval, ==, newval);
> +    aspeed_fsi_writel(s, reg, base);
> +    curval = aspeed_fsi_readl(s, reg);
> +    g_assert_cmpuint(curval, ==, base);
> +}
> +
> +static void test_fsi0_master_regs(const void *data)
> +{
> +    QTestState *s = (QTestState *)data;
> +
> +    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
> +
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0xF3F4F514);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_XFER_SIZE, 0xF3F4F518);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xF3F4F51c);
> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_STATUS, 0xF3F4F580);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB0_READ_DATA, 0xF3F4F584);
> +}
> +
> +static void test_fsi1_master_regs(const void *data)
> +{
> +    QTestState *s = (QTestState *)data;
> +
> +    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
> +
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0xF3F4F514);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_XFER_SIZE, 0xF3F4F518);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xF3F4F51c);
> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
> +    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_STATUS, 0xF3F4F580);
> +    test_fsi_reg_change(s, ASPEED_FSI_OPB1_READ_DATA, 0xF3F4F584);
> +}
> +
> +static void test_fsi0_getcfam_addr0(const void *data)
> +{
> +    QTestState *s = (QTestState *)data;
> +    uint32_t curval;
> +
> +    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
> +
> +    /* Master access direction read */
> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0x1);
> +    /* word */
> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_XFER_SIZE, 0x3);
> +    /* Address */
> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xa0000000);
> +    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
> +    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
> +
> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
> +    g_assert_cmpuint(curval, ==, 0x10000);
> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
> +    g_assert_cmpuint(curval, ==, 0x0);
> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
> +    g_assert_cmpuint(curval, ==, 0x152d02c0);
> +}
> +
> +static void test_fsi1_getcfam_addr0(const void *data)
> +{
> +    QTestState *s = (QTestState *)data;
> +    uint32_t curval;
> +
> +    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
> +
> +    /* Master access direction read */
> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0x1);
> +
> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_XFER_SIZE, 0x3);
> +    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xa0000000);
> +    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
> +    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
> +
> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
> +    g_assert_cmpuint(curval, ==, 0x20000);
> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
> +    g_assert_cmpuint(curval, ==, 0x0);
> +    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
> +    g_assert_cmpuint(curval, ==, 0x152d02c0);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret = -1;
> +    QTestState *s;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    s = qtest_init("-machine ast2600-evb ");
> +
> +    /* Tests for OPB/FSI0 */
> +    qtest_add_data_func("/fsi-test/test_fsi0_master_regs", s,
> +                        test_fsi0_master_regs);
> +
> +    qtest_add_data_func("/fsi-test/test_fsi0_getcfam_addr0", s,
> +                        test_fsi0_getcfam_addr0);
> +
> +    /* Tests for OPB/FSI1 */
> +    qtest_add_data_func("/fsi-test/test_fsi1_master_regs", s,
> +                        test_fsi1_master_regs);
> +
> +    qtest_add_data_func("/fsi-test/test_fsi1_getcfam_addr0", s,
> +                        test_fsi1_getcfam_addr0);
> +
> +    ret = g_test_run();
> +    qtest_quit(s);
> +
> +    return ret;
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index d6022ebd64..74228a4aed 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -207,6 +207,7 @@ qtests_arm = \
>     (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
>     (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['fsi-test'] : []) + \
>     ['arm-cpu-features',
>      'boot-serial-test']
>   


