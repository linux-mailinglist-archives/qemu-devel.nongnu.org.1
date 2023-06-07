Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66B726F6D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q70Dx-0006Xh-Nz; Wed, 07 Jun 2023 16:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q70Du-0006XF-B7
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:57:42 -0400
Received: from mail-mw2nam12on20616.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::616]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q70Dr-0002eP-Eh
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoS9jlCntA/PPNc+tpW5TjUUV+Xk62l21QduTpz7OndU+3VPMCCJYpxWFNgUW4trgeJAAlKdGen5z4fY8cXQ9Au0gxrwLdKRYLHJtTLCVUiqd2QVdvFVVogShKt7A7AVs9F3y0rmqoJTjt1ecPO/rxF+HS0gIqar36eYryXoTN/dFvKqxYhjOazPtSf22lhmrBBELbtWBW1hrvwidvPo8dujZBdl2ObQf8i3ih7H65PCWoFEMEH7OKDfdrWi3EULnkxnbX+05L/KIG1wA+qIkV2Sv5dQI7anGseGZImaRyZZttaP6vG32NtDK6cPwdt810w6xotRhx6kt099uOUU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MkFv8mKrOYCNcwdD8dA413qaJH04HZnTYBWMsSbJ10=;
 b=Afrnwh2GVRBPsg3w4FZlZnLQaEyOauiv0n0a06PEdGsWwhQHKIKSthIwzYxlYJCGhdfpSl+0XwckToZLhgNf1UntoxV1Eu1StJ+x4Mp80wbOgkBLqpo8MPO62fqlJlXeA7d4PlUsYGTTAPKi9zdXVDVUbh1wOE7ML9jTuENqAVUpoYtWqi4I7T8up3Pml4L368TxegWDHK3IygQU0d9J7dMgNrxKghSKkTbEtCbsU2d14IVOZfrQndZKXyNXGeXj1K4CyCyO5SAvBx9wmJjbOeE+yFxBe0+aP4PXGTfw4KGz2wtZp2k3LPIYIhn1+3iLO7XMeDj42Fht04UL0WRFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MkFv8mKrOYCNcwdD8dA413qaJH04HZnTYBWMsSbJ10=;
 b=txHXtPqdVYe9ID/EJgK99zvsIixnwlTCOA7s4MgV15Nr23+3Orsjj/nj9Lm9bpEnsF1Ii72hBWl9Kp6aGtMdjehzDSUfsgxHzqAeagzRmTk3DclMa99LoHrjZf8rCqYwJhFrM1LuEphY7ixc9ojYnDH4umMijgUvPqBHVsenJKk=
Received: from BN8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:ac::35)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 20:57:33 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::84) by BN8PR07CA0022.outlook.office365.com
 (2603:10b6:408:ac::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 20:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Wed, 7 Jun 2023 20:57:33 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 15:57:32 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 0/2] hw/i386/pc: Update max_cpus and default to SMBIOS
Date: Wed, 7 Jun 2023 15:57:15 -0500
Message-ID: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9876c2a9-1079-4bee-396a-08db6799d0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAU8kwG971o5frVJhFGVXr6lxaJX1Co8AfQD2WtzRUrJlLW3hGvZmrhAS1g8cK7BpjSczho7CiCsHMthamK0XMOBH2IVYRbDazvAkl54xaDZ/MXccTqS0f1BKNCqAN4Isb9KHr+A48Dx07LgQn4/3DCwf1EPPpYbIrHTYIdmnd0PYDz+VcCKFu1RQ/vo1L5LXyfbCDPl9qnv1NCKDFMmtCpPVaeqndpgMYCdnZ+/cVe6lCzuw0AMHQyJPa2/GTjhmZFm/YmN1s6kAQeYc/Qnim9X85rLOHvh84kSzUUYVGem3I4+lkjGcqISRbvX+w05XJa0W5IT72KytHDPV0XhfNboiHJG5EZQrgzNOfrgZrUcYhT7x7whc0+E6kAPp6eGsj+hSaYYkrI3a2X9j6koQ1geQnjHr2ybSl+mnyg2cyWxcFJojW2VEsZ6GpOv2DjmnHtcAda+SRKS8gSf7lMQ8eKltjbT4JLMnQpruMoFvvBGphcNdcqnWPoGbdAPZUh7NXpN7FuS6jvwG22U7nBy5qbaJuGQR9Stf74SgzuqxUMdvvFNTycwRY2NDPN1+kCOKETzLSnFnH4KB3Cl/Y4Z2+4ThWCpPHuVQrRWespvpAtOfPH7tz6VqJffXQ2Qjmh8E4fURrK/Veoq3izqzU4MyuwAhd1TSJKAksmFOLq+XjypeqSZALfv01A5psdnkTqMMDJJ1gc38UGWvF08P3uR9+jJkYNN9qAMp4OseQmAGHYJNcJo46Si2JhzdJD6UdWyxCCFIhxuuXSDmoh/XDodxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(47076005)(2616005)(26005)(1076003)(356005)(81166007)(44832011)(6916009)(316002)(40480700001)(83380400001)(4326008)(70206006)(70586007)(7696005)(6666004)(16526019)(186003)(36860700001)(426003)(336012)(478600001)(82310400005)(36756003)(54906003)(4744005)(2906002)(40460700003)(5660300002)(8676002)(82740400003)(8936002)(86362001)(41300700001)(7416002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:57:33.4666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9876c2a9-1079-4bee-396a-08db6799d0e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::616;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

In order to support large number of vcpus, a newer 64-bit SMBIOS
entry point type is needed. Therefore, upgrade the default SMBIOS version
for PC machines to SMBIOS 3.0 for newer systems. Then increase the maximum
number of vCPUs for Q35 models to 1024, which is the limit for KVM.

Changes from V5:
(https://lore.kernel.org/qemu-devel/20230607024939.703991-1-suravee.suthikulpanit@amd.com/T/#m5a9f0d0e2355aebf81501355a1bf349a9929f4bb)
 * Patch 1: Get rid of pc_machine_init_smbios() and simplify the logic
   per Igor's suggestion.
 * Patch 2: Added reviewed-by tag.

Thank you,
Suravee

Suravee Suthikulpanit (2):
  hw/i386/pc: Default to use SMBIOS 3.0 for newer machine models
  pc: q35: Bump max_cpus to 1024

 hw/i386/pc.c         | 4 +++-
 hw/i386/pc_piix.c    | 5 +++++
 hw/i386/pc_q35.c     | 8 +++++++-
 include/hw/i386/pc.h | 1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1


