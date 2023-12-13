Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638C8120C2
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:31:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWnR-0001xx-5V; Wed, 13 Dec 2023 16:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rDWnP-0001xd-Bk
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:29:35 -0500
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com
 ([40.107.243.87] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rDWnM-0005In-5J
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:29:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0i3cxiQESHtmsRfI75T0OxY4vNiORhjfMl2iauNZNbyCbiHYYNVamiQGtOVcczNUd2R4a8NS3cm5zKgtsWJrGTxFX7/mCcBRmJgKh6XSHosY+4esUA5MtmMh6ek4XRTKx3PPXgPkTGBzJD2ZPgePP4l1El5mdQ06Aa/e/H0U91I99rl3KkfrBSvfu6z0aFhdTECVlRKarATVpTAif+ZqvMWVC4EyJaI+mRSUgRwiadzG8pHP9F4eH2LB4GqwdN+P340B1jliopr70AL813POpN9qjLI+g9+6oGh36a6FUJ0mtVugkwZxz34UdYYYmtQQh3EcANV6KjQljWTXrEx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuWvPmBRLjF5/o99fNdd2lvCS5pr4nOP0m+CkFDyd18=;
 b=Py65H2iUeuzhHOPXGBVVpqsg4A+y/svmHsBcmgsHjbXhvcOibWWnwRAxXIoH2aEVOaUSP+suTmG+lxFqBF+QZX5fWaMhYdNyt/U24WVWfGpuHMoGUtCJGU3eiYlhZnD5nicobU5nOpQQ3JwOCiO+SRw59v8hdTJYY5vdrS310B8Tog9Xi86/6An8DB90+4MSLSBX2ZB+JGEEncwb2EMnmeQ2ouKehZYg8wSrtd+KodreSkpqzCV/pdlrF7Lb0HNnesZQ6Fbp52dawuUB9NHKLmm5Xi3Kw1Qf4yzjtt0/lF+B0uEir/2KScd9rMJgLlmq9RBuPBJaSa1sMNB9JQIzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuWvPmBRLjF5/o99fNdd2lvCS5pr4nOP0m+CkFDyd18=;
 b=1Z1YoCGeqXuUX6APtMJkNg6OWI0vs9UCcRbKy7rpDfqK8OwiB3C0lupIhUERSZR93nN6t0uNlt+tFb1S65sv7Xgu2PlyiNQrg08/Q6wo3L7BQpD7+oScIVJ+fSCHxa+LzXgbUNo2SYP6gqOOUePa/jGAPY8EgLSz03t/Q9zCIXE=
Received: from DM6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:5:80::47) by
 DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 21:24:24 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::10) by DM6PR08CA0034.outlook.office365.com
 (2603:10b6:5:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:24:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:24:22 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.2.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Date: Wed, 13 Dec 2023 15:24:07 -0600
Message-ID: <170250264782.1619920.15808841906236254464@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 902d226c-7830-49f4-331b-08dbfc21e004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlheiAcTE5tNLNy7oDiSzs5RSOaMJlmyHqE6OVs0jkqOGtPz8QK39P+E2eIJBSYwc3MdZ8HdN+BcVgsYqp7Pwz3IKzLp9ITJlJrhA9HLpYC7DHdy7wu8LDCsGQ6HDJcN4lydYnZIjfC89XgFbxU7L1Z7MCYARLQs6WXBgr1Ph7aFujk7Xpadmnuq5Uug3fMY9I/6q0ddw9nzHQacM4d+V0nO1tY64RpHImaV1IQ521+JtFbXJOObaSiaQN/2HgI+CEA2nEhMcRhvF+nW/zv8T97uQRrrgNeuLdu7rVN+iAWJZn3peEWV87kOu+IhQRfPcP9RtJVKSHSpzfy3yZBTEUUrkzn9FjAf33DUp5pKCVJJo3tUlOYIha6wuxIVSYVyM5oAEM2YF49Kp7rh3qBTfBrRwGII1jJVnyIMq3DUEUat7FsfiQ7osirrd1vBw0xzu4V0J1/OZpo3sXkMXjUyM53DwbjLHC2DMaYgtWdBArALuYkcoG1QliDzJ48LVumupk3QBAIz4EPhZNaODfyWEs/cEahcotrF2IcxS7f/21W4lRJXAU6jAF4B6TgIkD4uQzPNc8PIyfjRvZ3SifEVFJCGSVQK59I0nGpuz9WYN5SO6Ghw9kSdeVbh8JaMg7HWgzPM2HLTx1Av0bQpJAT7IVVkpLHsiFk/RiwmhrZFWiDYWnJtR1hwqAWzAB8N1ZUcZtARIHrKBWPX5nKvfa+uxuQcNc3yMrpoKgG8cA9tttEPfwp0ut8e3GuSMFp1qZ/M/aT3xtOR0FFoIF6GH7JeBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(336012)(40460700003)(426003)(83380400001)(16526019)(44832011)(2616005)(47076005)(36860700001)(66574015)(5660300002)(8936002)(4326008)(26005)(8676002)(41300700001)(2906002)(966005)(6666004)(478600001)(316002)(6916009)(70206006)(82740400003)(36756003)(70586007)(86362001)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:24:22.4767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902d226c-7830-49f4-331b-08dbfc21e004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
Received-SPF: softfail client-ip=40.107.243.87;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
fifth release candidate for the QEMU 8.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.2.0-rc4.tar.xz
  http://download.qemu.org/qemu-8.2.0-rc4.tar.xz.sig

A note from the maintainer:

  A few last-minute fixes still came up so I tagged v8.2.0-rc4.=20
  [...] next week we'll finalize 8.2.0 unless something
  critical comes up.

You can help improve the quality of the QEMU 8.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/10

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.2

Please add entries to the ChangeLog for the 8.2 release below:

  http://wiki.qemu.org/ChangeLog/8.2

Thank you to everyone involved!

Changes since rc3:

039afc5ef7: Update version for v8.2.0-rc4 release (Stefan Hajnoczi)
cbb145567c: tcg: Reduce serial context atomicity earlier (Richard Henderson)
b5e0d5d22f: target/i386: Fix 32-bit wrapping of pc/eip computation (Richard=
 Henderson)
06ecb6ac19: docs: clean-up the xenpvh documentation (Alex Benn=C3=A9e)
755ae3811f: block: Fix AioContext locking in qmp_block_resize() (Kevin Wolf)
4efb13f845: xen: fix condition for skipping virtio-mmio defines (Paolo Bonz=
ini)
16b6273b4b: meson, xen: fix condition for enabling the Xen accelerator (Pao=
lo Bonzini)

