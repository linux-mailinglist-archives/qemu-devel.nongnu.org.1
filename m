Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45617266F1
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkJ-0008NY-Cn; Wed, 07 Jun 2023 13:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkG-0008NN-EI
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:14:52 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkD-0005s8-Di
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvOPobOaUUnEABmN2E6TsnHL9Dg5Q/Su6Jpfv4O8kdKlv2ORF4XGenDR4n98aKN7JqKjDLXLBIdqzYBKdhS0e3Ag+PdTK9Pi0FbwktJj2az6iRqopujgTfgwql5oHis044nqodcDX3+eaNAR4jlCKDxtn2LXm4M+C6eTpHkjOl2A7Ol09mFEE9fRI7Adty2UfwP/jPWe5LRmaR5GFNx5jwZTlUaO93y9s+AwAAClIB+dfBbZuz2YwVxfY/UO05VEmK1q7YYqZgtdOPpErMQM8k/u65YXqfnxOgiZSz8A+a19pMtXS6tZQswLSD8aLwZMg0WBH9dCqd4Ppe6cWWdE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CdcVeBUgSrteBNNaVVIhxEufFudh/HPBLDNxr3NyD0=;
 b=hsKir2ESEUi/W+lJ36hn74o3UY7EVC08j2YOkuj6+W4WY5Qw/Y6K5bOfejLbZYb56Qa/6Ydj+9DsYGoGsTl+nw6FCFH5vXAKq9qvdEDyZ56AwYMQqeGIOdfOFbhg81OdGs4pb9sKPs2TuU1glOWptN2Zrd0IZzptRtVw3ivwq8lAv0Y7A/poEVdVjgzjfCA38EJSW+rpcYQC5ukgnHzgD7++V0ZMua2cAomFIA8PbvrqUkuXifge8G7RPAkPJyh0t8c6Bf0Bc+Nd7zijcYq8uqNoyFOwZQHHKvmx2rUfHwYV4QSBzjaOx3cj+um3UbTnYAmTCcUTOlPjyngstDMqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CdcVeBUgSrteBNNaVVIhxEufFudh/HPBLDNxr3NyD0=;
 b=rG7eWEYsiPbwbV2xerR2PQ0WxhT1P8x++Ojwls3xz21d1MJ1NbptP7+YpJUIhl4Yc+VDu+o9aIbTnN04tKeOv5Mtn0xPRtcO3u6kLxYW7oUegD6/7Xmti0eZJYzCjahKfA3rgHXbhpPKZCfMshIUVT5ZGtJP+OOWq7n1MejzjhQ=
Received: from CY5PR15CA0159.namprd15.prod.outlook.com (2603:10b6:930:67::27)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 17:14:42 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::83) by CY5PR15CA0159.outlook.office365.com
 (2603:10b6:930:67::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:14:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 10:14:40 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:40 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v7 00/10] Introduce xenpvh machine for arm architecture
Date: Wed, 7 Jun 2023 10:04:49 -0700
Message-ID: <20230607170459.14722-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: bfae5a0e-27c4-4350-577b-08db677aaeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vf6uGdgGRCnamU43UWCiiVuPhVg4j8HkFztKMsfwjB9saPdvfrx23FDzpIjtJfs4+GauOm5vCK0Izr05vxm+1dw0o9MPKbf9Uc+WOqZNUAyS+KK8E44nNdlMmxf0wE4OpqXFTthPqrsVJ8q6tOsrTw7x5QyTXgcQBoHMGj7H93iicWHwwDkPjjXYtxZzhdNZZEIzK35Dy8Cz7X/HIY29wPWHTQWcrwYSj57q3HehUzfRV9vIF/4Cc1bMeCTansN657H6I3hFtAqeOe61M1IKrkNZ24tboWBkJpPTi5zUkC6cWuR+3I7TuGl3KBrpJqpev4VI8Wlxlv2ZYWeF2LrQvCOUf1qd1dhf1ymggp7D1GOuuylUqKWleGBa09mYcwRuy6yJMD/hfrpCG62Q9no8riDf4f3mRh2IFae8wGiU2aadoG67uRptRDw5PHtxflyfVhpET0w/E+HTpcs4zZpRDSBVBSQkyN8x1y32lcWDwrgWoCN50nXS6Iy+Fqgl/kQZEhPpdbpHJnI0ZL9vs6j6kVM1ebPWfQwqFGwZpmWgBTikccYNKxc0kp4OynrvwoJ1uXGJaiv+DasxWG1NFoSCynLEH8uFttilvg93PXTR9pafNhnoJPHmP8L73oj45SVDXTg8uFYftDBwO/aCu+Ppw9cZHvJwF/Hvwa7k4Rl5mQzVoj7MB/7x2mGxoEtQLYM8PTCKBIHiWspgcgUHeJMpmQquaY5EFcDPL9xrFJDUPmDi4sZyUmX0sBaksO+HJPPSKqz+jatgqE3cohOKu4YAamdSnJIEvXZ7RgF378wPBak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(966005)(36756003)(40480700001)(8936002)(8676002)(5660300002)(44832011)(54906003)(6916009)(4326008)(70586007)(70206006)(316002)(478600001)(40460700003)(2906002)(82310400005)(1076003)(26005)(186003)(83380400001)(47076005)(36860700001)(336012)(426003)(2616005)(356005)(81166007)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:41.6885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfae5a0e-27c4-4350-577b-08db677aaeb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Also, this series has dependency on following gitlab-ci
patch: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01471.html.

I ran gitlab-ci and here are the successful build logs:
https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/pipelines/891635328/

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

Vikram Garhwal (5):
  hw/i386/xen/: move xen-mapcache.c to hw/xen/
  hw/i386/xen: rearrange xen_hvm_init_pc
  hw/xen/xen-hvm-common: Use g_new and error_report
  hw/arm: introduce xenpvh machine
  meson.build: enable xenpv machine build for ARM

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
 include/hw/xen/xen_native.h      |   13 +-
 meson.build                      |    4 +-
 18 files changed, 1350 insertions(+), 1010 deletions(-)
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


