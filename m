Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C87EBA86
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:15:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33YX-00037W-IL; Tue, 14 Nov 2023 19:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1r33YV-00037C-LR
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:14:55 -0500
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com
 ([40.107.94.51] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1r33YT-0001z1-3O
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:14:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9hVyaS6rRmjXBGMwg+89qMhohiFFylBhQXdfzrX2j7zkmnTzLlEQLRb+hdewIBs1Styw4DRIfJZvCJ3VqwcqWEfIDSIkFHebTDGq/EwnIlxwT+MKNb5ip+ZIbR1tZRxwPmBdBVuWCUDuovKHKEvOcSJoLUROLuuDt7I0KjfrZaebuNKNedkZ0W9l2Chd5Ai3y9J0If0xV4U1DqMrJtWNonPqz52RaS1RGQQ/j/WIzourN/upDn3kifoDyRZQVnPCYaBzqQMvDtfR/NMpR9q7Sv7FkySLAHxjWbFwkLMldbNVUIlxed2P9B3LH4WM2KrwdLqZxSy1myGiZhdJ1QYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrivDq39IrDTBtqKA3G4MTvZSpI29Fq1CxasFzkp/+0=;
 b=AyqhFe8PUDL0Q8qUOt0PIrNTy/xRVPralntvwfL9NZo/thCG+thkGLsKQwcDbLm/GcZT1FGnj1nzF7GYm1JW+YuV4qlh0Aa9v4ZTXWKrxCDdVGLgXZw0w5fa5uwltGlqh2GUfChlEQos69NvdCXmqWSWtwpaTs03NPvy/92B2FctDHZJxLpHX6nz30r36dU2mHXi05OCH+12Cw6TYGfUVuaP9kGRzqiyJFifRgBaUUT9aL5Ama5GG6ZelvmrdhWi4C8ZG/InyVs1Q/KBVlFFicMNWLjkCNXx/aJjCZrTNvbgvGnvbj+z7igUj7CRSAocLQit/2Vth450ur7VCEmM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrivDq39IrDTBtqKA3G4MTvZSpI29Fq1CxasFzkp/+0=;
 b=gDSeXGDBqVVkwm4lZn/OQHNdTv4eVQ1P/pqIwvtuv4w8hVOLvSkw8cCXNMge/vXLRPPjXWlm2egT5q8lPzplxAIwklm2LizZyFRIMe61OVrtqa9mZuGSqvIbUAJ7iHIRB0KPpkNBmpgxLquxT3FUbGLCJqr+z34lB14r0WKNGks=
Received: from MWH0EPF00056D16.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1d) by DM6PR12MB4076.namprd12.prod.outlook.com
 (2603:10b6:5:213::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 00:09:42 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF00056D16.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.5 via Frontend
 Transport; Wed, 15 Nov 2023 00:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.0 via Frontend Transport; Wed, 15 Nov 2023 00:09:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 18:09:41 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.2.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Date: Tue, 14 Nov 2023 18:08:46 -0600
Message-ID: <170000692689.770168.7402752279922677160@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 518f8175-eb0f-4061-21a8-08dbe56f2af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cd03LBFVjwaeWVb85gLgRrmyDvILcTZNeILwi1vSrdLYWU8X/egenhSM90Eon5i8ckCCO8PWigOhKYYmd2MdMfyyqV2Wvz8gUucJ7A54sTAfeZnEeXVXEynMvC02l69wi708M5lbds2foZsKyKdIyrnxQ5zd7lb4nnJbmyJSth93unbX3ni4hmlVrgVErNgWMXA0c5icEY99clg6pATuNdHeHMrM0hYo+z+ALgv17KWLow4P2DPOtjp/T5kNnkAXfS78I9Yepp9ddewJtdxGcbhLwdw44T3hVSJ8nYu5HQzOw2QTaMhknRfKcNcPSJ85fpjqm9OOgWJ0P4iWfq0P4asnTX4KiMnvbIU79SmtkZZACwPu/W6lcGdQY1rQFmdACLDNUCivI60JQRfaq2WmFFhlbmjpBcWlhi0QOu7DGXwihKSe7zU1hkd4EGbK2eyyOg910yc1UAj6dtd7t9XSqSzxPGej8gVAnWnDtloEQ1DJuCtjBIQZ5wJaK5qcTKfUfNmdIm2BL3z/Zd9edDaGDwSBqObaUqC/qWBFCzyaST7+9++T4Q0y/jTwKg14zKmeo0+McCj3P49NvuIlEocdpyE5IUhRXke0GKdTu0rF4KqGwEaEFyVts9K+COWRpVu2BYOK0PcOaqWnXAO1Ghx5knRLNnfnoXKF89sjpAoFQnjRwGzyJdPU1kVg85AaTOpUrZnZKZKSAYMqUJBjZYRv1I0jfjpeA6EE9H+kIUdGY97tBkQNfJBZN9F+28GhN+R8u9iv6aRxIaccYQekUXRY6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(86362001)(8936002)(4326008)(8676002)(316002)(6916009)(966005)(70206006)(70586007)(47076005)(40480700001)(44832011)(478600001)(5660300002)(2616005)(40460700003)(2906002)(426003)(336012)(36756003)(82740400003)(83380400001)(356005)(36860700001)(81166007)(4744005)(26005)(41300700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 00:09:42.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518f8175-eb0f-4061-21a8-08dbe56f2af1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
Received-SPF: softfail client-ip=40.107.94.51;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 8.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.2.0-rc0.tar.xz
  http://download.qemu.org/qemu-8.2.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 8.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/10

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.2

Please add entries to the ChangeLog for the 8.2 release below:

  http://wiki.qemu.org/ChangeLog/8.2

Thank you to everyone involved!

