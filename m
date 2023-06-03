Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CD720D9E
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5HwU-0006AH-Lq; Fri, 02 Jun 2023 23:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q5HwT-00069H-4o
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:28:37 -0400
Received: from mail-dm6nam04on2087.outbound.protection.outlook.com
 ([40.107.102.87] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q5HwQ-0004B2-TB
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJosBlL9+3fmwPhqa8EaHLCTXofOU5DU9iwh9PlX2WOtt6NXI76JlCPtbLmI7i6ViXk4Pz5Th5kzzpHRXSLY/dUpWOcvhA3XES+/iHwq9QLTpdXF+v8lvUQdOUxVgW+LFWn3zzFr2JhR7+ZmVaZobhtzVXOTcAlLCENBc9KIyJNYcPqOTTIPOuE+swowSnSnAWk4YXRaxDmflx9VrPsZhfiTuYD1caURd92LFz7sAVuKs9EksZNJvTRitsP9qsEHWdqRlzEsbHs6BxIphzDaTTtIKM4paiB3fTkCdeNw7jONV2/jbWu06zJsjx3jK+YVYdYA7zhruZoRnEsENMJwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdBLgTAFSisxpMCWm4+Y3eWpM8qtz2Kq/tu2DJ2DzCY=;
 b=Gm0UuGz29V3T6RZXwLpmn6VOuFhnZ7f50g7EQF6zPatgSSOKEEpwWZyiAEsd86Ue41ylYN39VYPOHNLVdR11R5FOn6hHyWu+OWhF8JGwkm0UoqCw67amKetJIk19S3bHYl56ZLGhQvqg8NY6u8LnpOfDK7AwFzqm3FNZHJxF6KnqHaQjuE+l3hq3FGilmS6kGrKl3Gtt8km3I2fUkktZRPYhEZ2sXqqqTYhB4a1YHbM3+4TfPlTbpRjP9DQIUWORdCVStKE2ivR8VxTBgn4e9zS4d7M7g3ks5RgG+TXtwEltgnwZoJq/Ici7g2chhlNlcJhyqVmd2hW+Ilk6FyzpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdBLgTAFSisxpMCWm4+Y3eWpM8qtz2Kq/tu2DJ2DzCY=;
 b=tdi9Pe8wTIhkQzugmr0fHOIPqqvhIhdDWgxw65/5k4ly1DHdMIH9joE2h88xCmwHtwMEIx0tca8M85x9+6VL69iOxYlVdCWP7e9HIg6ZZLsq5GtjVCBSMu6gmFWEHC6JCJmeW30KC507mpFGx4VhvNffL7gPhSIWB9VbyRJ5u2U=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 03:23:27 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::c7) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28 via Frontend
 Transport; Sat, 3 Jun 2023 03:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Sat, 3 Jun 2023 03:23:26 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 22:23:24 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 0/2] hw/i386/pc: Update max_cpus and default to SMBIOS
Date: Fri, 2 Jun 2023 22:22:53 -0500
Message-ID: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: e3adb7c7-d65a-44d0-244b-08db63e1e55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2r1t+dcfuyanQ4i4ob9mwyQjg3t4Gi+DwequrSPvMMcTQ/feqf5CvaIM3f/+m5zktGeLcJC5KhPtcC1nonavkM57lFDEW3rGGL9LwXGXIdmmzlVJgyhnAd4OE9OJzDQZiVNboZ4Q0JcM0UxwiVd+8TuHux3hGVr/qIXv2XD9aeGwfE64orWLjXmv+AG1oacdjWAB92gCv0KRKERfMbYY8cNrvnVaXngeeoANhK72kdAazf2AEHyF9ou5FggsYhN+LoO3lMUAiVq8lLQycHEzZtBmO2D5KN5GkByAeixPuB08ClCxtqvQdTawE3WmSi45qtt6nViegOuIOo2pakcDnyjGFNwwa0zXkiz6zAa8/54Nran+mFHKqQ28xd+7pYeZ3BSVI2ijZ/ekZIDSgEQrY2tbrBMSd3PonFTnWlmSMSlFVjhDmfU0DzMDNgiSNzK8okODZwLxI/HOEqexb7b5xWkXtS3IeEWx5QEN2OAf0eNeBC7/cvPGCMFyO13mWG0bAEFPLYhkUbfdbiBm27n5V4UmmZK4mcOKImApn3XMSC72xIx1luja26M6u5YqvFuAdeUyJWBNJaEReq2yCdxO5JupHMJJlGQDx9IQhC7KAj0g2tS5Sogm+0rjRh04IDsREyrdqLv2ZI+FO1rOdFKL7kgwkrDqX0p/8WpVlzXT2kPRse6dILRr350A68sNhuKU32eRREeU5RuEVaQnALItjH0ulpm+9ZYAeIoBf5AOLLBbJxsY217N6pM9bzNa9DmL3eyev6axm0NJ1n9scojK4Sos7Y9qlK+v8dbwoo1hwA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(40460700003)(478600001)(8936002)(5660300002)(8676002)(44832011)(7416002)(36756003)(2906002)(4744005)(86362001)(82310400005)(4326008)(6916009)(70586007)(316002)(81166007)(82740400003)(356005)(70206006)(40480700001)(41300700001)(6666004)(83380400001)(47076005)(2616005)(1076003)(26005)(186003)(16526019)(336012)(36860700001)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 03:23:26.8438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3adb7c7-d65a-44d0-244b-08db63e1e55e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
Received-SPF: softfail client-ip=40.107.102.87;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

Changes from V2:
(https://lore.kernel.org/qemu-devel/20230531225127.331998-1-suravee.suthikulpanit@amd.com/)
* Add patch 1.

Changes from V1:
(https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
 * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)

Thank you,
Suravee

Suravee Suthikulpanit (2):
  hw/i386/pc: Default to use SMBIOS 3.0 for newer machine models
  pc: q35: Bump max_cpus to 1024

 hw/i386/pc.c         |  5 ++++-
 hw/i386/pc_piix.c    | 14 ++++++++++++++
 hw/i386/pc_q35.c     | 16 +++++++++++++++-
 include/hw/i386/pc.h |  2 ++
 4 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.34.1


