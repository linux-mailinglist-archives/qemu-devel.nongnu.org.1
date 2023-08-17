Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22677F7EA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:40:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdEV-0005BR-2a; Thu, 17 Aug 2023 09:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qWdEQ-00058T-WF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:40:11 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qWdEL-0001Dk-CR
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAkIOXz9dN2sh28MlJ/3fDQQNAY1lOPqpEB4qsU6+Ojzshggs3JnnhapagF/X4FyVRJweFWR347viTGeVrrfpob1D+o+nJfXDgyMl1NoaFVofDZSRKOTFCYCbK/qyP6zkKSiwOMFt69A8MHIMq/3U2XvaRIKMXJRGpbLiIsYRPiQL70AdIPYcqBJ/6Lx5qAG0I31F62kK40HXr0TYTPSMlwcgSIsPfE1oITocQTYMO3Z689pIgvtBBBsLm1mldEnPSAovP5I3fPgZd+3k6A8lfFK7h9CI8yh2fEcX71OFP7nW4hGOPK93KQC4rGUkA8QjKIHR2Gj9cCsLJnoWFhEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srct0+W83BfuY6LxeUtF54xupRnhwJzIbfGqFQZ2/Ac=;
 b=HnmQEyum5VuCIgF90cCqs9LB46Je3Lapw7840UEZAkQeEZfLYD8GU80+y0bKZjX5ezIbrHDCRzOygzjOnzD+QwWCIYMb6bQ3Rt7GMfPBRc9IKVgQAyLnSC9/vlIKhltOboDQPaqXOa5jVEhXU/twDLIu3Vh03hALFODpTePYud8Iedi7TwvFRkvgmrdjRjP/YrM/IzUvnaisgNgMHNiwHJJgbLrtLzXfI6XylYKGsSsP3blpp+xXgAtE4uNXOpN8Wxh4q1g5UJlQGIW8Gn9kKMpqfAN8E3A6p296nab4WnujrjXg5DyuNOggJGVr3FY9nrLQq61OGdx6f0tlE/5zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srct0+W83BfuY6LxeUtF54xupRnhwJzIbfGqFQZ2/Ac=;
 b=cvHJnvb09kZiUpJPhGum+kclw2yQwxv/FPd6CBwxdKoYhuNgDebfECT1mHOw1YjfPJdqzvEezusIRDkInLptCG20lcfGqjMC/LjuG4lfLDkHa7Ly11QjqkDdYaT0FIDvSI0wH9jqGU1JsHyHfsO0JdVdPkuG56ovqRD9SjBEHxQ=
Received: from CY5PR18CA0001.namprd18.prod.outlook.com (2603:10b6:930:5::6) by
 CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Thu, 17 Aug 2023 13:34:59 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::3) by CY5PR18CA0001.outlook.office365.com
 (2603:10b6:930:5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 13:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:34:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 08:34:58 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.1.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 17 Aug 2023 08:34:12 -0500
Message-ID: <169227925258.1681128.18113073581172111021@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 865824c9-ba24-4d39-9110-08db9f26c0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0/NYu5oRiaKdG/ml52VT7rbq+zDNSKxHsNHiGfQpemLxqaHY2mkZqSYfecOjvvgmBZ73E2FUcZh55A2u/T5F9qi9CzebcTxBgEYV4oZaKJTzd/lk+JLlMtiY2KkvlVEEE+34uw/na71uH2IfJPXftDzLv40rgZp8wlmaMCjI77yYBESbLJH0gT5pqxnW4lW/Ftt//qAOvjECMUFUjw405S8Kzgv3gWMuSn4gE+OOUwhydtfKuF/mFzpj1MHFzxcQBfq3KbLsE0eFcJHX5lBVYUSqM1QAFQ+tAKGYdeg5An1XAqW2zV/Twxltrw/o2E1qQTCTrYEmhnvgcL+59inS7hL9LdvPdID5MV0kRzltT+SaGKqW0/+7aB1EKNmY9DzRw5Ru0mHlAOiEyRW2bYfD3AZQ2DpQNL32TsYr3fhajVyIlIV7jiP1wIddIYELkERVIVeTtTn2e+fgZomYu3lUgBtqXVhzkEIWFeyuW5QYu8oxfEHXlAG5rISlyng2a+HBtowLbQ9HYf10ijPwf5JmFYQDQ56kC7axnIZmTmnlD3kXL4pQx8h79y8WXxXgnZfSXAEi9yyUb+LngskHEOTXWPF4kX2fMlpIOsYV4Nx1LkO6dGdEZCcRBjQqwei9cVdKLbsSlu3trrAd6htgiQNSRx5WnNVWBAu3MGHYxZ2/MApIel5EK1B2aELYgPlpJjinnRf2BuzvkLb6SXZOvEuAAsu0wh533veWYuJuPyjT299gzp/qs4G8Z9e3wf2GqT3UX0KL445Fpl3jm7tkkAEFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(82740400003)(356005)(70206006)(81166007)(70586007)(6916009)(966005)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(8936002)(4326008)(26005)(40460700003)(2906002)(83380400001)(16526019)(40480700001)(336012)(478600001)(426003)(86362001)(36756003)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:34:59.1744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865824c9-ba24-4d39-9110-08db9f26c0a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
Received-SPF: softfail client-ip=40.107.94.55;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 8.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.1.0-rc4.tar.xz
  http://download.qemu.org/qemu-8.1.0-rc4.tar.xz.sig

You can help improve the quality of the QEMU 8.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/8#tab-issues

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.1

Please add entries to the ChangeLog for the 8.1 release below:

  http://wiki.qemu.org/ChangeLog/8.1

Thank you to everyone involved!

Changes since rc3:

0d52116fd8: Update version for v8.1.0-rc4 release (Richard Henderson)
d3b41127c2: tcg/i386: Output %gs prefix in tcg_out_vex_opc (Richard Henders=
on)
b274c2388e: hw/riscv/virt.c: change 'aclint' TCG check (Daniel Henrique Bar=
boza)
136cb9cc03: target/riscv/kvm.c: fix mvendorid size in vcpu_set_machine_ids(=
) (Daniel Henrique Barboza)
0f936247e8: pci: Fix the update of interrupt disable bit in PCI_COMMAND reg=
ister (Guoyi Tu)
3d449bc603: hw/pci-host: Allow extended config space access for Designware =
PCIe host (Jason Chien)

