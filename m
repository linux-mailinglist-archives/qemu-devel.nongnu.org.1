Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F375BA63
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 00:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMbxc-0000Pm-MF; Thu, 20 Jul 2023 18:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qMbxZ-0000O1-0t
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 18:17:23 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com
 ([40.107.220.60] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qMbxW-0007fB-H9
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 18:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBAhaYsskJd/5JayGy+KMFOdpu9C3zsFuY1DV2V4GsDYGJJoY6kkW+bEkBWU0a+0u+NslXR5gC/5wG9OFMZ0sFhLZcKT0FLDRUJbnWJzK40HxkrJCVMRyJMZ2Jf2hTZ8ZNEpLgV/N3iFL1+COiaqfk4hP/xSb1+uH19swMijaJ0L2wN7qNvcvJSvgEwuktvROK67eKmJUnR6lQ48bdHOaU0oBv5jegWSxTw6sZJ9ZRi3i8T8nsq2uL6SssJI0DW60/OiVf5Affa6CV9e4gWPl1tHKk4XVe+i6ArxgYs+bVAZP84gLvsgo7E8CVKiImG23lZ8nAwHJA9NDQC6cuIYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dZt5o2gbta/Yumwz/Bany0swm6T97d+xAsjPmdedJU=;
 b=cgeaGrkgCrOTyUoCn8bby76FiNoDc8EUELuhG/TKevtoQJ7RfQdT9e2ZFdtL8pujOfO7wQX1JpdFAqO95lCNtrpW40GQCNc4x+sWNaGYh/HW5NpgXmlUwL5o0wgkbgbf2lW8MNIuJp9bgKB04hbQq5OrerD/PPvMUeJuVEDBLctSWzim38Eu34eZbEmwE1lBlZjXPMUPOJW+qaRe6Rr3h/MhHyz4J0Beq3BLopUGO8kXbHlDtgG8dsFho+X8lckjL2BpBojJsD+3lhLhHe7RorHkgW3E+6oeIMN4P5PtFZw+uKfG+QRBujLfziDza2m/D+XoFWBWDNQoO2oA/9hYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dZt5o2gbta/Yumwz/Bany0swm6T97d+xAsjPmdedJU=;
 b=y0ZylSPhUQhtIFRvXJG/LGwyDxvT/5sbgrS8IbX4ruuU9bqHxp3N3ryUYvuehKYdktnGVD6Mye803FiEbasDkgKla68/h5CYaTedCBDAZDOU4+nTIvdlvq+KZThqL5w2zr1pCHcrfSPIxw8RzYrGjiaYmgSuDBjusRhfnDPyBQ4=
Received: from BN8PR15CA0006.namprd15.prod.outlook.com (2603:10b6:408:c0::19)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 22:12:08 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::a) by BN8PR15CA0006.outlook.office365.com
 (2603:10b6:408:c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 22:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 22:12:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 17:12:07 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.1.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 17:11:18 -0500
Message-ID: <168989107854.12263.10157918823734727896@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e59cf51-85e2-4776-e34d-08db896e5b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5toqVIzsaAPpzXep8lfeGMI8LVYpE/zsgcF1u8oTE0r/dU1xLa8F6vVU8B/Xcpb+Giq1DnCB5cCh/V4by807Tj64GB6HFC/SKZYwLwINRXjevZn2Q4v3sKnJ53SSgBJQ3ZC1GlitxiQsHqPZ6Xs9u7DRyzH4iRhtFr2L2SZmSYXYIwBnBG7fbce7DL1kEb7MpzXAR69P+51TG6Gkm3tzBfYEIfeg21LtIPNMaOjtgXlRGg+my9JykuxQW8tIScHddLVxBnZ6Acbx1d01PpJTit7bd1mGfweSFEgaiQ3ye41yaRygEP3rAk59PW5bVMXPEApxIAxsRwbClcg82rJ2MntMuPSiyZLixYEjEG7qQT/yRi6dIul5+hn8tnOUxa44EN2TEpWWvIm+YkYRxiqiNQKeuE90Pomn0VjZLMRWOqZMzbIVxamREjYSauVUs8CTWOCzGSBdGdZWGQnzCEkckkWi/lXJNBFM0X3tyecMfyUZP37nfVOm8ESw9vYNR56vjskESFSnUmB//HhcB3HJSUykn0oi3hyh+AUcQ9NYDatOpQPex6fRsLVMDhDcUCuomTxR9cEqcXC02HxWyCCtqZbFTTsEuj2VUAkapsnzI4HxoHTJZjESHZ6BHpr59a9I5wTam9skxBV99t7dcSHeEaPzXTZ3xDZbWSxPD0rlsE4O+Eo2dn5KGG9tWNLaZ3EgHt3fmULKCduTz+Oyjmkxjy9ygoPtXX42CEBQppmatAomJLoqJXXMNVflXqEzFeV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(4744005)(2906002)(44832011)(47076005)(40480700001)(336012)(16526019)(186003)(83380400001)(426003)(36860700001)(26005)(966005)(6666004)(70206006)(356005)(40460700003)(70586007)(4326008)(316002)(2616005)(82740400003)(8936002)(6916009)(478600001)(8676002)(81166007)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 22:12:07.5007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e59cf51-85e2-4776-e34d-08db896e5b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
Received-SPF: softfail client-ip=40.107.220.60;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 8.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.1.0-rc0.tar.xz
  http://download.qemu.org/qemu-8.1.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 8.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/8#tab-issues

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.1

Please add entries to the ChangeLog for the 8.1 release below:

  http://wiki.qemu.org/ChangeLog/8.1

Thank you to everyone involved!

