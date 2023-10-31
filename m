Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817967DCE6E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:00:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoQv-0003gv-MR; Tue, 31 Oct 2023 09:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxoQs-0003gj-Cl
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:05:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxoQo-0006rb-W6
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:05:21 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39VD3sW8003578; Tue, 31 Oct 2023 13:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9SKhOyHIJFdMVTjTorSuTSPivOgmdwQl8BDkj0c+JQE=;
 b=p4yDHf0/RCnXWq0XpEH9wJggj7LiQmxSBp3afyVfitCtnW6fOISIm79IAOpFREIR26jZ
 kaiEo9P4pt8WHi1cDv6DMORiQ5HKp+DlShLPI4iVhDQV7J/bLc0HJDJcdi5jxTpHpoqW
 adPHVmn3pvkMTn9F+ouBa/A3oBPggwHPKH4GpIQRDABoy2QH+fqtar/wnHqeJlbBqnTU
 uVoksiYE/jIGxpl+1fAMgvQ9uoCErKEQh+GUtsVtLwkpxGbDImRsMlAML6lKxdjbBFJ/
 tlBLfxo3UKiEzxlAPvCpDby+PHvecgMXI9jvMoA/nvTxpavHpXB3vdxnjB88Jj7QM1r3 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u324p80ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 13:05:17 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VD4WIi005276;
 Tue, 31 Oct 2023 13:05:16 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u324p80yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 13:05:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39VCPYmk011286; Tue, 31 Oct 2023 13:05:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1euk04vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 13:05:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39VD5Flc21103276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 13:05:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F56858052;
 Tue, 31 Oct 2023 13:05:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B22BE58065;
 Tue, 31 Oct 2023 13:05:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 31 Oct 2023 13:05:14 +0000 (GMT)
Message-ID: <5a47bb9f-225a-4ea1-ad41-968365f4c807@linux.ibm.com>
Date: Tue, 31 Oct 2023 09:05:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] tests: add TPM-CRB sysbus tests for aarch64
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231031040021.65582-1-j@getutm.app>
 <20231031040021.65582-15-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231031040021.65582-15-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NxI87sCpO-fPH3jarKb8y7r5qBoFyAps
X-Proofpoint-GUID: PzN9kVRv4m_KG5fFqTt0bboF1OY9JOGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310103
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/31/23 00:00, Joelle van Dyne wrote:
> - Factor out common test code from tpm-crb-test.c -> tpm-tests.c
> - Store device addr in `tpm_device_base_addr` (unify with TIS tests)
> - Add new tests for aarch64
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   tests/qtest/tpm-tests.h                 |   2 +
>   tests/qtest/tpm-util.h                  |   4 +-
>   tests/qtest/bios-tables-test.c          |   4 +-
>   tests/qtest/tpm-crb-device-swtpm-test.c |  72 ++++++++++++++
>   tests/qtest/tpm-crb-device-test.c       |  71 ++++++++++++++
>   tests/qtest/tpm-crb-swtpm-test.c        |   2 +
>   tests/qtest/tpm-crb-test.c              | 121 +-----------------------
>   tests/qtest/tpm-tests.c                 | 121 ++++++++++++++++++++++++
>   tests/qtest/tpm-tis-device-swtpm-test.c |   2 +-
>   tests/qtest/tpm-tis-device-test.c       |   2 +-
>   tests/qtest/tpm-tis-i2c-test.c          |   3 +
>   tests/qtest/tpm-tis-swtpm-test.c        |   2 +-
>   tests/qtest/tpm-tis-test.c              |   2 +-
>   tests/qtest/tpm-util.c                  |  16 ++--
>   tests/qtest/meson.build                 |   4 +
>   15 files changed, 295 insertions(+), 133 deletions(-)
>   create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
>   create mode 100644 tests/qtest/tpm-crb-device-test.c
>
> diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
> index 07ba60d26e..c1bfb2f914 100644
> --- a/tests/qtest/tpm-tests.h
> +++ b/tests/qtest/tpm-tests.h
> @@ -24,4 +24,6 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
>                                      const char *ifmodel,
>                                      const char *machine_options);
>
> +void tpm_test_crb(const void *data);
> +
>   #endif /* TESTS_TPM_TESTS_H */
> diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
> index 0cb28dd6e5..c99380684e 100644
> --- a/tests/qtest/tpm-util.h
> +++ b/tests/qtest/tpm-util.h
> @@ -15,10 +15,10 @@
>
>   #include "io/channel-socket.h"
>
> -extern uint64_t tpm_tis_base_addr;
> +extern uint64_t tpm_device_base_addr;
>
>   #define TIS_REG(LOCTY, REG) \
> -    (tpm_tis_base_addr + ((LOCTY) << 12) + REG)
> +    (tpm_device_base_addr + ((LOCTY) << 12) + REG)
>
>   typedef void (tx_func)(QTestState *s,
>                          const unsigned char *req, size_t req_size,
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index c63bad0205..dea2a18158 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1343,7 +1343,7 @@ static void test_acpi_piix4_tcg_numamem(void)
>       free_test_data(&data);
>   }
>
> -uint64_t tpm_tis_base_addr;
> +uint64_t tpm_device_base_addr;
>
>   static test_data tcg_tpm_test_data(const char *machine)
>   {
> @@ -1379,7 +1379,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>       const char *suffix = tpm_version == TPM_VERSION_2_0 ? "tpm2" : "tpm12";
>       char *args, *variant = g_strdup_printf(".%s.%s", tpm_if, suffix);
>
> -    tpm_tis_base_addr = base;
> +    tpm_device_base_addr = base;
>
>       module_call_init(MODULE_INIT_QOM);
>
> diff --git a/tests/qtest/tpm-crb-device-swtpm-test.c b/tests/qtest/tpm-crb-device-swtpm-test.c
> new file mode 100644
> index 0000000000..332add5ca6
> --- /dev/null
> +++ b/tests/qtest/tpm-crb-device-swtpm-test.c
> @@ -0,0 +1,72 @@
> +/*
> + * QTest testcase for TPM CRB talking to external swtpm and swtpm migration
> + *
> + * Copyright (c) 2018 IBM Corporation
> + *  with parts borrowed from migration-test.c that is:
> + *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "libqtest.h"
> +#include "qemu/module.h"
> +#include "tpm-tests.h"
> +#include "hw/acpi/tpm.h"
> +
> +uint64_t tpm_device_base_addr = 0xc000000;
> +#define MACHINE_OPTIONS "-machine virt,gic-version=max -accel tcg"
> +
> +typedef struct TestState {
> +    char *src_tpm_path;
> +    char *dst_tpm_path;
> +    char *uri;
> +} TestState;
> +
> +static void tpm_crb_swtpm_test(const void *data)
> +{
> +    const TestState *ts = data;
> +
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer,
> +                        "tpm-crb-device", MACHINE_OPTIONS);
> +}
> +
> +static void tpm_crb_swtpm_migration_test(const void *data)
> +{
> +    const TestState *ts = data;
> +
> +    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts->uri,
> +                                  tpm_util_crb_transfer, "tpm-crb-device",
> +                                  MACHINE_OPTIONS);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    TestState ts = { 0 };
> +
> +    ts.src_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
> +    ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
> +    ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
> +    qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
> +                        tpm_crb_swtpm_migration_test);
> +    ret = g_test_run();
> +
> +    tpm_util_rmdir(ts.dst_tpm_path);
> +    g_free(ts.dst_tpm_path);
> +    tpm_util_rmdir(ts.src_tpm_path);
> +    g_free(ts.src_tpm_path);
> +    g_free(ts.uri);
> +
> +    return ret;
> +}
> diff --git a/tests/qtest/tpm-crb-device-test.c b/tests/qtest/tpm-crb-device-test.c
> new file mode 100644
> index 0000000000..17d09a57fd
> --- /dev/null
> +++ b/tests/qtest/tpm-crb-device-test.c
> @@ -0,0 +1,71 @@
> +/*
> + * QTest testcase for TPM CRB
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *   Marc-André Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +
> +#include "hw/acpi/tpm.h"
> +#include "io/channel-socket.h"
> +#include "libqtest-single.h"
> +#include "qemu/module.h"
> +#include "tpm-emu.h"
> +#include "tpm-tests.h"
> +
> +/*
> + * As the Sysbus tpm-crb-device is instantiated on the ARM virt
> + * platform bus and it is the only sysbus device dynamically
> + * instantiated, it gets plugged at its base address
> + */
> +uint64_t tpm_device_base_addr = 0xc000000;
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    char *args, *tmp_path = g_dir_make_tmp("qemu-tpm-crb-test.XXXXXX", NULL);
> +    GThread *thread;
> +    TPMTestState test;
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    g_test_init(&argc, &argv, NULL);
> +
> +    test.addr = g_new0(SocketAddress, 1);
> +    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> +    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
> +    g_mutex_init(&test.data_mutex);
> +    g_cond_init(&test.data_cond);
> +    test.data_cond_signal = false;
> +    test.tpm_version = TPM_VERSION_2_0;
> +
> +    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
> +    tpm_emu_test_wait_cond(&test);
> +
> +    args = g_strdup_printf(
> +        "-machine virt,gic-version=max -accel tcg "
> +        "-chardev socket,id=chr,path=%s "
> +        "-tpmdev emulator,id=dev,chardev=chr "
> +        "-device tpm-crb-device,tpmdev=dev",
> +        test.addr->u.q_unix.path);
> +    qtest_start(args);
> +
> +    qtest_add_data_func("/tpm-crb/test", &test, tpm_test_crb);
> +    ret = g_test_run();
> +
> +    qtest_end();
> +
> +    g_thread_join(thread);
> +    g_unlink(test.addr->u.q_unix.path);
> +    qapi_free_SocketAddress(test.addr);
> +    g_rmdir(tmp_path);
> +    g_free(tmp_path);
> +    g_free(args);
> +    return ret;
> +}
> diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
> index ffeb1c396b..08862210a4 100644
> --- a/tests/qtest/tpm-crb-swtpm-test.c
> +++ b/tests/qtest/tpm-crb-swtpm-test.c
> @@ -19,6 +19,8 @@
>   #include "tpm-tests.h"
>   #include "hw/acpi/tpm.h"
>
> +uint64_t tpm_device_base_addr = TPM_CRB_ADDR_BASE;
> +
>   typedef struct TestState {
>       char *src_tpm_path;
>       char *dst_tpm_path;
> diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
> index 9d30fe8293..51614abc70 100644
> --- a/tests/qtest/tpm-crb-test.c
> +++ b/tests/qtest/tpm-crb-test.c
> @@ -18,124 +18,9 @@
>   #include "libqtest-single.h"
>   #include "qemu/module.h"
>   #include "tpm-emu.h"
> +#include "tpm-tests.h"
>
> -#define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
> -
> -static void tpm_crb_test(const void *data)
> -{
> -    const TPMTestState *s = data;
> -    uint32_t intfid = readl(TPM_CRB_ADDR_BASE + A_CRB_INTF_ID);
> -    uint32_t csize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE);
> -    uint64_t caddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
> -    uint32_t rsize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
> -    uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
> -    uint8_t locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
> -    uint32_t locctrl = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
> -    uint32_t locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> -    uint32_t sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapLocality), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRBIdleBypass), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapDataXferSizeSupport),
> -                    ==, 3);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapFIFO), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRB), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceSelector), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, RID), ==, 0);
> -
> -    g_assert_cmpint(csize, >=, 128);
> -    g_assert_cmpint(rsize, >=, 128);
> -    g_assert_cmpint(caddr, >, TPM_CRB_ADDR_BASE);
> -    g_assert_cmpint(raddr, >, TPM_CRB_ADDR_BASE);
> -
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
> -
> -    g_assert_cmpint(locctrl, ==, 0);
> -
> -    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
> -
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> -
> -    /* request access to locality 0 */
> -    writeb(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> -
> -    /* granted bit must be set now */
> -    locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> -    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
> -
> -    /* we must have an assigned locality */
> -    locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
> -
> -    /* set into ready state */
> -    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 1);
> -
> -    /* TPM must not be in the idle state */
> -    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> -
> -    memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
> -
> -    uint32_t start = 1;
> -    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> -    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
> -    do {
> -        start = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -        if ((start & 1) == 0) {
> -            break;
> -        }
> -    } while (g_get_monotonic_time() < end_time);
> -    start = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -    g_assert_cmpint(start & 1, ==, 0);
> -
> -    /* TPM must still not be in the idle state */
> -    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> -
> -    struct tpm_hdr tpm_msg;
> -    memread(raddr, &tpm_msg, sizeof(tpm_msg));
> -    g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_msg));
> -
> -    /* set TPM into idle state */
> -    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 2);
> -
> -    /* idle state must be indicated now */
> -    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> -
> -    /* relinquish locality */
> -    writel(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 2);
> -
> -    /* Granted flag must be cleared */
> -    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), ==, 0);
> -
> -    /* no locality may be assigned */
> -    locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
> -    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
> -
> -}
> +uint64_t tpm_device_base_addr = TPM_CRB_ADDR_BASE;
>
>   int main(int argc, char **argv)
>   {
> @@ -165,7 +50,7 @@ int main(int argc, char **argv)
>           test.addr->u.q_unix.path);
>       qtest_start(args);
>
> -    qtest_add_data_func("/tpm-crb/test", &test, tpm_crb_test);
> +    qtest_add_data_func("/tpm-crb/test", &test, tpm_test_crb);
>       ret = g_test_run();
>
>       qtest_end();
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index fb94496bbd..83c5536136 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -15,7 +15,10 @@
>   #include "qemu/osdep.h"
>   #include <glib/gstdio.h>
>
> +#include "hw/registerfields.h"
> +#include "hw/acpi/tpm.h"
>   #include "libqtest-single.h"
> +#include "tpm-emu.h"
>   #include "tpm-tests.h"
>
>   static bool
> @@ -130,3 +133,121 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
>       g_unlink(src_tpm_addr->u.q_unix.path);
>       qapi_free_SocketAddress(src_tpm_addr);
>   }
> +
> +#define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
> +
> +void tpm_test_crb(const void *data)
> +{
> +    const TPMTestState *s = data;
> +    uint32_t intfid = readl(tpm_device_base_addr + A_CRB_INTF_ID);
> +    uint32_t csize = readl(tpm_device_base_addr + A_CRB_CTRL_CMD_SIZE);
> +    uint64_t caddr = readq(tpm_device_base_addr + A_CRB_CTRL_CMD_LADDR);
> +    uint32_t rsize = readl(tpm_device_base_addr + A_CRB_CTRL_RSP_SIZE);
> +    uint64_t raddr = readq(tpm_device_base_addr + A_CRB_CTRL_RSP_LADDR);
> +    uint8_t locstate = readb(tpm_device_base_addr + A_CRB_LOC_STATE);
> +    uint32_t locctrl = readl(tpm_device_base_addr + A_CRB_LOC_CTRL);
> +    uint32_t locsts = readl(tpm_device_base_addr + A_CRB_LOC_STS);
> +    uint32_t sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
> +
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapLocality), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRBIdleBypass), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapDataXferSizeSupport),
> +                    ==, 3);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapFIFO), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRB), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceSelector), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, RID), ==, 0);
> +
> +    g_assert_cmpint(csize, >=, 128);
> +    g_assert_cmpint(rsize, >=, 128);
> +    g_assert_cmpint(caddr, >, tpm_device_base_addr);
> +    g_assert_cmpint(raddr, >, tpm_device_base_addr);
> +
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
> +
> +    g_assert_cmpint(locctrl, ==, 0);
> +
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
> +
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> +
> +    /* request access to locality 0 */
> +    writeb(tpm_device_base_addr + A_CRB_LOC_CTRL, 1);
> +
> +    /* granted bit must be set now */
> +    locsts = readl(tpm_device_base_addr + A_CRB_LOC_STS);
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
> +
> +    /* we must have an assigned locality */
> +    locstate = readb(tpm_device_base_addr + A_CRB_LOC_STATE);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
> +
> +    /* set into ready state */
> +    writel(tpm_device_base_addr + A_CRB_CTRL_REQ, 1);
> +
> +    /* TPM must not be in the idle state */
> +    sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> +
> +    memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
> +
> +    uint32_t start = 1;
> +    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> +    writel(tpm_device_base_addr + A_CRB_CTRL_START, start);
> +    do {
> +        start = readl(tpm_device_base_addr + A_CRB_CTRL_START);
> +        if ((start & 1) == 0) {
> +            break;
> +        }
> +    } while (g_get_monotonic_time() < end_time);
> +    start = readl(tpm_device_base_addr + A_CRB_CTRL_START);
> +    g_assert_cmpint(start & 1, ==, 0);
> +
> +    /* TPM must still not be in the idle state */
> +    sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> +
> +    struct tpm_hdr tpm_msg;
> +    memread(raddr, &tpm_msg, sizeof(tpm_msg));
> +    g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_msg));
> +
> +    /* set TPM into idle state */
> +    writel(tpm_device_base_addr + A_CRB_CTRL_REQ, 2);
> +
> +    /* idle state must be indicated now */
> +    sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
> +
> +    /* relinquish locality */
> +    writel(tpm_device_base_addr + A_CRB_LOC_CTRL, 2);
> +
> +    /* Granted flag must be cleared */
> +    sts = readl(tpm_device_base_addr + A_CRB_LOC_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), ==, 0);
> +
> +    /* no locality may be assigned */
> +    locstate = readb(tpm_device_base_addr + A_CRB_LOC_STATE);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
> +
> +}
> diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-tis-device-swtpm-test.c
> index 517a077005..54d1cedc6f 100644
> --- a/tests/qtest/tpm-tis-device-swtpm-test.c
> +++ b/tests/qtest/tpm-tis-device-swtpm-test.c
> @@ -21,7 +21,7 @@
>   #include "tpm-tis-util.h"
>   #include "hw/acpi/tpm.h"
>
> -uint64_t tpm_tis_base_addr = 0xc000000;
> +uint64_t tpm_device_base_addr = 0xc000000;
>   #define MACHINE_OPTIONS "-machine virt,gic-version=max -accel tcg"
>
>   typedef struct TestState {
> diff --git a/tests/qtest/tpm-tis-device-test.c b/tests/qtest/tpm-tis-device-test.c
> index 3ddefb51ec..4f6609ae98 100644
> --- a/tests/qtest/tpm-tis-device-test.c
> +++ b/tests/qtest/tpm-tis-device-test.c
> @@ -27,7 +27,7 @@
>    * platform bus and it is the only sysbus device dynamically
>    * instantiated, it gets plugged at its base address
>    */
> -uint64_t tpm_tis_base_addr = 0xc000000;
> +uint64_t tpm_device_base_addr = 0xc000000;
>
>   int main(int argc, char **argv)
>   {
> diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
> index 3a1af026f2..9495cc1739 100644
> --- a/tests/qtest/tpm-tis-i2c-test.c
> +++ b/tests/qtest/tpm-tis-i2c-test.c
> @@ -39,6 +39,9 @@
>   #define I2C_SLAVE_ADDR   0x2e
>   #define I2C_DEV_BUS_NUM  10
>
> +/* unused but needed for tpm-util.c to link */
> +uint64_t tpm_device_base_addr;
> +
>   static const uint8_t TPM_CMD[12] =
>       "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
>
> diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
> index 105e42e21d..5bfbbc0a67 100644
> --- a/tests/qtest/tpm-tis-swtpm-test.c
> +++ b/tests/qtest/tpm-tis-swtpm-test.c
> @@ -20,7 +20,7 @@
>   #include "tpm-tis-util.h"
>   #include "hw/acpi/tpm.h"
>
> -uint64_t tpm_tis_base_addr = TPM_TIS_ADDR_BASE;
> +uint64_t tpm_device_base_addr = TPM_TIS_ADDR_BASE;
>
>   typedef struct TestState {
>       char *src_tpm_path;
> diff --git a/tests/qtest/tpm-tis-test.c b/tests/qtest/tpm-tis-test.c
> index a4a25ba745..7661568aa8 100644
> --- a/tests/qtest/tpm-tis-test.c
> +++ b/tests/qtest/tpm-tis-test.c
> @@ -22,7 +22,7 @@
>   #include "tpm-emu.h"
>   #include "tpm-tis-util.h"
>
> -uint64_t tpm_tis_base_addr = TPM_TIS_ADDR_BASE;
> +uint64_t tpm_device_base_addr = TPM_TIS_ADDR_BASE;
>
>   int main(int argc, char **argv)
>   {
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index dd02057fc0..1608901a76 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -24,18 +24,20 @@ void tpm_util_crb_transfer(QTestState *s,
>                              const unsigned char *req, size_t req_size,
>                              unsigned char *rsp, size_t rsp_size)
>   {
> -    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
> -    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
> +    uint64_t caddr = qtest_readq(s, tpm_device_base_addr +
> +                                    A_CRB_CTRL_CMD_LADDR);
> +    uint64_t raddr = qtest_readq(s, tpm_device_base_addr +
> +                                    A_CRB_CTRL_RSP_LADDR);
>
> -    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +    qtest_writeb(s, tpm_device_base_addr + A_CRB_LOC_CTRL, 1);
>
>       qtest_memwrite(s, caddr, req, req_size);
>
>       uint32_t sts, start = 1;
>       uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> -    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
> +    qtest_writel(s, tpm_device_base_addr + A_CRB_CTRL_START, start);
>       while (true) {
> -        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> +        start = qtest_readl(s, tpm_device_base_addr + A_CRB_CTRL_START);
>           if ((start & 1) == 0) {
>               break;
>           }
> @@ -43,9 +45,9 @@ void tpm_util_crb_transfer(QTestState *s,
>               break;
>           }
>       };
> -    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> +    start = qtest_readl(s, tpm_device_base_addr + A_CRB_CTRL_START);
>       g_assert_cmpint(start & 1, ==, 0);
> -    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> +    sts = qtest_readl(s, tpm_device_base_addr + A_CRB_CTRL_STS);
>       g_assert_cmpint(sts & 1, ==, 0);
>
>       qtest_memread(s, raddr, rsp, rsp_size);
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index d6022ebd64..0e6ef6aebf 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -215,6 +215,8 @@ qtests_aarch64 = \
>     (cpu != 'arm' and unpack_edk2_blobs ? ['bios-tables-test'] : []) +                            \
>     (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
>       ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
> +  (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_CRB_SYSBUS') ?            \
> +    ['tpm-crb-device-test', 'tpm-crb-device-swtpm-test'] : []) +                                         \
>     (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
> @@ -312,6 +314,8 @@ qtests = {
>     'qos-test': [chardev, io, qos_test_ss.apply(config_targetos, strict: false).sources()],
>     'tpm-crb-swtpm-test': [io, tpmemu_files],
>     'tpm-crb-test': [io, tpmemu_files],
> +  'tpm-crb-device-swtpm-test': [io, tpmemu_files],
> +  'tpm-crb-device-test': [io, tpmemu_files],
>     'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>     'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>     'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],

