Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC272327A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:45:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6I0M-0004nC-Hy; Mon, 05 Jun 2023 17:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6I0K-0004mv-6r
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:44:44 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com
 ([40.107.237.69] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6I0I-0002YH-8O
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:44:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km7DGLnWoh85n7PcPt4Y5agDhhPFlLSHR5CwIvyQnGrCcHWhPN1TKkZeLUIYBUBW4YPZFTE97rbvDqSIxO2a0N+Io4rKW40EdN6hikzpwa7YcrQBYXN1JXa+FasJucym9qdV8g5HmmUGtT4u2D6sNgwUtfPVkCC4kCaOddFwI1gdzvGArEPVp9IapCiLU3hz209dJdN5gvHal3HssrVOpocsG4z01rMEoJdiHipFLUST3qhe2Zb3j502DaEK93jBg4loU5XZVkD0EZ4oEanzR4PXpngz6gi4ppAx0yX/2a/jxHB6kAS/BaEkMdsZxP25DPuFIugo0T2cpzsF6FMHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W21FU6o30/0vmogKp2NwxNaXk8UwQvN84r1XN0RNGsI=;
 b=fcdJYnJhrACIMFxl5c90mJ84gTZSAotOA1n3UAAY08+TpAe3rBgUe9Uabef4OwL2VWe/yd5UpeQL4UyXtFuX+DbO5lNtC1ZLHQlAHZiae0TB5qHmrcMYl631Ucmduw/3at0R1ikfp1FbggB+CEeJm0OR+lEEP8/Z2zWT++xPrqMNHk34mRhCyuW46bKY4nKiKk8n6JJXItznrjttrdQRWQ6DNs3C63qmfpUzR1xC/EXSwF7vOEekmMg98QJ9SfWAmgHcOU8TLxH6OBCs4wNWJvJe4Gwd7xrn8vvjBmMfN4MyIIsF4uz6yPWxm3nHjjwPZ7uh6aTPFDsRgwGgUJln7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W21FU6o30/0vmogKp2NwxNaXk8UwQvN84r1XN0RNGsI=;
 b=Io3mjySyNoresXUzNlR20TjQUDnYM4WzIouCUuypbmG2DF52jhgAW44nuEJc+JhzWk+7FYVzZu604Xbq3xONrQGpMnkqXCjdTQDeI//qnNGwehGCScRXkLrX8RzTW9LdqFgjT40c+wcSrnKT9q4b7dQlfmfDbl+85/Efjvmixko=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 21:39:36 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::53) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 21:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 21:39:36 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 16:39:34 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 0/3] hw/i386/pc: Update max_cpus and default to SMBIOS
Date: Mon, 5 Jun 2023 16:39:03 -0500
Message-ID: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM6PR12MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 618e9eab-1078-4a22-bfdc-08db660d5bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bcUxlBR9NFVGY0XMWObJ8Rh7ZaqpdeZ0LWBv42KxxkZipoVvE5G1+6dnuxxDYFFzZibTMlTa9ogiFSR6tCtOI1alMPiNOYl/L6arVp5IurGOxUzY808ivKjiPVYkXhWvD1wqBfcdE8yml+nAB2t4sJ7/X5xmTeY/mDKBA/Zt3p/C/22W6tmYcapBFYoHz9hV/+jOoN24d64VH6BDWhdKchbwkVQhT5Pg0erEVN3pGzafbcjRe0s3yfxRGt9crwHBZMcbFvdtVNijG24m/YsCyXWxaglbQc8TbAfnaq3IgX0ayQ4w5VyZHdzwNj6tJtq305oRS2C3jZWb7WYcuq62ZbS3OsYxMQYlAySCihqwCZGefNiXcXKu9nGThg4YWlTp2Equm81mR8DYO1E1eBEAS9aVhb4883Luu1wJrKg8bdjf84OOGcQjM/7TxZd13EyRJYgWuz1EFen1N9m7l5klQ69RmA1glDgJ6UClejhLzbL4uJCokBOvoieRUgg1aJfHlvAsnBIqccQerFWSR+wNCTH24JiJxo5lISNPO3ngx+A9PD4MmhK5jPLdXVJbWcH5G32IFxDoBjNUlhGi5Cuwed2fJo2A1/kMHY9ihHQdb4YiZ7noiPEMl6xfIRLtFZjT/jcEkA6IkpF3uDn1ROy/znUv78lFwv4kPGZTKlY69vvTdgPPtHIamgneOtFuChGj1Rw3PoXNHUSIsSV9CDZWRJda9g9cECq4xxJSWlXkq1iNAyWSr3+IxE3BByLERPP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(54906003)(356005)(81166007)(478600001)(82740400003)(8936002)(8676002)(4326008)(70586007)(6916009)(2616005)(41300700001)(316002)(70206006)(186003)(16526019)(336012)(36860700001)(6666004)(426003)(83380400001)(7696005)(26005)(1076003)(47076005)(82310400005)(86362001)(44832011)(5660300002)(2906002)(36756003)(7416002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 21:39:36.1365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618e9eab-1078-4a22-bfdc-08db660d5bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
Received-SPF: softfail client-ip=40.107.237.69;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

In order to support large number of vcpus, a newer 64-bit SMBIOS
entry point type is needed. Therefore, upgrade the default SMBIOS version
for PC machines to SMBIOS 3.0 for newer systems. Then increase the maximum
number of vCPUs for Q35 models to 1024, which is the limit for KVM.

Changes from V3:
(https://lore.kernel.org/qemu-devel/20230603032255.517970-1-suravee.suthikulpanit@amd.com/T/#t )
 * Patch 1: Refactor the code to setup SMBIOS defaults to pc_machine_done().
 * Patch 2: Minor typo fixes in comment.

Changes from V2:
(https://lore.kernel.org/qemu-devel/20230531225127.331998-1-suravee.suthikulpanit@amd.com/)
 * Add patch 1.

Changes from V1:
(https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
 * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)

Thank you,
Suravee

Suravee Suthikulpanit (3):
  hw/i386/pc: Refactor logic to set SMBIOS set defaults
  hw/i386/pc: Default to use SMBIOS 3.0 for newer machine models
  pc: q35: Bump max_cpus to 1024

 hw/i386/pc.c         | 26 +++++++++++++++++++++++++-
 hw/i386/pc_piix.c    | 14 +++++---------
 hw/i386/pc_q35.c     | 15 ++++++---------
 include/hw/i386/pc.h |  2 ++
 4 files changed, 38 insertions(+), 19 deletions(-)

-- 
2.34.1


