Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C8730C02
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 02:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9aXx-0004Y0-UW; Wed, 14 Jun 2023 20:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aXs-0004XK-DS
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:09:02 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com
 ([40.107.243.56] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aXq-0007PY-95
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBAgNw7dXKwqCPGJ87ZlmLYQZzLoN9M4f2iW0npE56FObqCqFxBRFu1LDoCWPylmpBbUgMM0quKg44Jx9nL6J2ahdjFeRIkJXZJFP7wtKYgxrwUgYRtFhZM+MaqP6xk3q1T20O/VTNlUj/SjM92IbT+uknl0i2qkIBFQsN+hJqZiFXHG9uhf2WRfF2w9unSrmC3bVp46z1INdExVyZA5e+z92K6BfTT/N+EmuryFH9kT8+T4ZWA2GJbHROJ0+da3FCzN1ajKLet/9DJaGbJRQF3Oh80CfZJivoosvpkATg6rjgHkyc013FeozgOSwN7iCYjYa8BO26hHBD3+jULkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZCM6i2+7+0gF82OFgzUP2txmEyPchs8PVmver751QA=;
 b=mLy9lN2lwzrRNQ/xd4axxrcGqugHkl4aqLyNCVxpJK21aGJ8awKKsITcfZJ1kVli0MsixtQis3LQF8OHr1cvunkyZEsGSY9gzZTN3fv9m7RjXVmYk4lQKx/ZJrRcdrXhLbHp2wkRM0nOZ9LcFx0vcU2Efnuy/O2Du0xpi9bouerzVvxN0BNQ+PeaJ1CmszcX9QRMmsFViXOaqx+dVKt3mUQCtCIKzMjdUX5Cc2AhKhkpuZM9fieEmf0TJIw9eWIoLiVIn5K1juxdfxomoFDgeeTKJnzksGqB6hj1MdE8ace95xAWQa8QeYl6VzsBL0DTO0mqgNpIGxyScMnUwVlEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=nongnu.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZCM6i2+7+0gF82OFgzUP2txmEyPchs8PVmver751QA=;
 b=A9IshU8d5WxoRkUkob4PIBj4tZv8r5pGPNQBJjJnsX07TtB3sg9Z+HDt6a5plPm58tnpZBZAsDU/Q3LDQc6J/7s5bNmdmB74K46CVZlub6fGZVnx/mdkBuE1kK1b6D1/9GB8e/pEgYeC0YWiylVzAFMNhcqdxTTEAXO+dcRLnRk=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:20b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 15 Jun
 2023 00:03:52 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::2a) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 00:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 00:03:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:03:49 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 14 Jun 2023 19:03:49 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Vikram Garhwal <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v8 00/11] Introduce xenpvh machine for arm architecture
Date: Wed, 14 Jun 2023 17:03:28 -0700
Message-ID: <20230615000340.1135-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 840ad922-daba-4b5a-d61c-08db6d33ffc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/rfuczDjNoSuPWvXclyt8XXr7hWuW+YRUNOtYyD00jr0XL3veaN5sEciuaTDW7QOS3S/K3pJrQaHDjwhHrFG+mPnuM75T1lUShWFw651xAONn8mnBKYySexxYOFY4jBPSsBqq8L92aE4sQoaqkPR2mvnisbgBQgC3mjUFHgnY7mOUY1tS0V6UDWzzgcjHQ5xdIQ6zOc4+ZtTEdX1O90lpv/+ZjamRff8F6S1f7WiSiCnBDup7VfR+cQgKAmf39GYoNawZHoIXymSSLFf+hJykBd1vJezbdXvcQKdrwwkSIQLugCa84PLrG2FUK0dyQvK1I664A7cZOH+6uyV2KPrODLfTehrsaiRedRZNWa8cCAgVdi48XzXqI7yZ1B1m98Lf33ZaXouf19L1priOW7hl3oekf5BVOcWy5sJ6vz0WQlcrcfoMmUwz1Ar9m5FZctUCgkMbH/ktT34H3TprvJ19CChCNI+KZqAA8XJtTGXY5it7gxCPEU/MRxvvsRgrvdqztUIi6PkfsEdTEfwxItdwL52LxwPVy4Pl4g0mhC39+/DVYvWAFPtw/x2JitFXbJ5W9YPL86WDuS/Iv1KVfhKecu3bF2SQ5UFJlYMxqGkhkeannDsg0JK+yppAwDRiHrV2wUX+jJAdgTLUJhAPPPnHcgxgJkeGVZYWeG7dtcdqtal91tzcxerqVZtkPQZrcoiki10OnQCyyosexkRkZuKMYQu/on6oP+14BiZ8upl+W8Iy372FSVtkgPtBIJCAXRgPsOY8qEVkgza+DamcjLPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(70206006)(40480700001)(63370400001)(6916009)(81166007)(478600001)(82740400003)(54906003)(70586007)(356005)(8936002)(316002)(4326008)(2616005)(41300700001)(186003)(426003)(36860700001)(63350400001)(6666004)(336012)(83380400001)(47076005)(26005)(1076003)(86362001)(36756003)(5660300002)(44832011)(82310400005)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:03:50.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840ad922-daba-4b5a-d61c-08db6d33ffc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
Received-SPF: softfail client-ip=40.107.243.56;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hi,
Rebased and resending the series with latest QEMU as it's been quite sometime.
There is one line code change in patch 04/10. Rest is just rebased with latest.

This series add xenpvh machine for aarch64. Motivation behind creating xenpvh
machine with IOREQ and TPM was to enable each guest on Xen aarch64 to have it's
own unique and emulated TPM.

This series does following:
    1. Moved common xen functionalities from hw/i386/xen to hw/xen/ so those can
       be used for aarch64.
    2. We added a minimal xenpvh arm machine which creates an IOREQ server and
       support TPM.

Also, checkpatch.pl fails for 03/12 and 06/12. These fails are due to
moving old code to new place which was not QEMU code style compatible.
No new add code was added.

Regards,
Vikram

ChangeLog:
    v7 -> v8:
        Add new patch 11/11 for "xenpvh exception for qtests".

    v5->v7:
        Change in PATCH 04/10:
            Fix build error for cross compile case by adding
            "#include "qemu/error-report.h" in include/hw/xen/xen-hvm-common.h
    v4->v5:
        Fix missing 3 lines of codes in xen_exit_notifier() due to rebase.
        Fix 07/10 patch subject.

    v3->v4:
        Removed the out of series 04/12 patch.

    v2->v3:
        1. Change machine name to xenpvh as per Jurgen's input.
        2. Add docs/system/xenpvh.rst documentation.
        3. Removed GUEST_TPM_BASE and added tpm_base_address as property.
        4. Correct CONFIG_TPM related issues.
        5. Added xen_register_backend() function call to xen_register_ioreq().
        6. Added Oleksandr's suggestion i.e. removed extra interface opening and
           used accel=xen option

    v1 -> v2
    Merged patch 05 and 06.
    04/12: xen-hvm-common.c:
        1. Moved xen_be_init() and xen_be_register_common() from
            xen_register_ioreq() to xen_register_backend().
        2. Changed g_malloc to g_new and perror -> error_setg_errno.
        3. Created a local subroutine function for Xen_IOREQ_register.
        4. Fixed build issues with inclusion of xenstore.h.
        5. Fixed minor errors.


Stefano Stabellini (5):
  hw/i386/xen/xen-hvm: move x86-specific fields out of XenIOState
  xen-hvm: reorganize xen-hvm and move common function to xen-hvm-common
  include/hw/xen/xen_common: return error from xen_create_ioreq_server
  hw/xen/xen-hvm-common: skip ioreq creation on ioreq registration
    failure
  meson.build: do not set have_xen_pci_passthrough for aarch64 targets

Vikram Garhwal (6):
  hw/i386/xen/: move xen-mapcache.c to hw/xen/
  hw/i386/xen: rearrange xen_hvm_init_pc
  hw/xen/xen-hvm-common: Use g_new and error_report
  hw/arm: introduce xenpvh machine
  meson.build: enable xenpv machine build for ARM
  test/qtest: add xepvh to skip list for qtest

 docs/system/arm/xenpvh.rst       |   34 +
 docs/system/target-arm.rst       |    1 +
 hw/arm/meson.build               |    2 +
 hw/arm/xen_arm.c                 |  181 +++++
 hw/i386/meson.build              |    1 +
 hw/i386/xen/meson.build          |    1 -
 hw/i386/xen/trace-events         |   19 -
 hw/i386/xen/xen-hvm.c            | 1075 +++---------------------------
 hw/xen/meson.build               |    7 +
 hw/xen/trace-events              |   19 +
 hw/xen/xen-hvm-common.c          |  879 ++++++++++++++++++++++++
 hw/{i386 => }/xen/xen-mapcache.c |    0
 include/hw/arm/xen_arch_hvm.h    |    9 +
 include/hw/i386/xen_arch_hvm.h   |   11 +
 include/hw/xen/arch_hvm.h        |    5 +
 include/hw/xen/xen-hvm-common.h  |   99 +++
 include/hw/xen/xen_native.h      |    8 +-
 meson.build                      |    4 +-
 tests/qtest/libqtest.c           |    3 +-
 19 files changed, 1349 insertions(+), 1009 deletions(-)
 create mode 100644 docs/system/arm/xenpvh.rst
 create mode 100644 hw/arm/xen_arm.c
 create mode 100644 hw/xen/xen-hvm-common.c
 rename hw/{i386 => }/xen/xen-mapcache.c (100%)
 create mode 100644 include/hw/arm/xen_arch_hvm.h
 create mode 100644 include/hw/i386/xen_arch_hvm.h
 create mode 100644 include/hw/xen/arch_hvm.h
 create mode 100644 include/hw/xen/xen-hvm-common.h

-- 
2.17.1


