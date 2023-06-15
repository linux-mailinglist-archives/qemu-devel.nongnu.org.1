Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E3F730BFB
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 02:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9aUO-0005pf-5Z; Wed, 14 Jun 2023 20:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUG-0005lL-Fh
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:17 -0400
Received: from mail-bn7nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::602]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUE-0006qw-If
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx5tAR5XuwPKrkGZq7wlodQo0AcFxwitoxH26zycfrAwZmEZVyC6biSF8SeTY4mSS+n3jj8Gv0aU7ISrC+SPQMXZn8Hx56V9EVrtUYlyQyqnxn3ZmyAFd/aCWNsBYqLI6LzFYMfzxGrFuJPvqqgyrKpfw1aF+kQ08ihnZyR5IQE8eyrhUZlGT1smbNzueRXgcr7Pwfe17hoEk2RfqRPufwxl0wHzFRh8RF4Q+fm1IbakSMUpk6G+m3L5vm95P170cN/Knr8CIfQGRzJEGvFyvLTVPgYBq9IomgXuW0gQNQUI1ICKhiLOMSvQ4aOiuNHQc9E4w02T1uaufdhDNNI8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2/440lErbRVHq/8o71SRNhv5jl2wKDCEr9Op4/IeM0=;
 b=WvTF2SsBRtdueq6lzX1mj1Bs+TAr6TI3WuVyKaMvqs1fvjTQyiGXpkfwHEBI9F1wLs1YnAcdtzzAGpIdh7Ogzr6Flrnb/6DsmkQxZ0KnhiGUIrv6LiaCwqs510yIFq7+bykZRoyzyZmCU19QGap0dl/TSf0B9svd6n7fujXsud4tKcI1D/eyVkJXjnS8LhBT5DjVH7vMEq/TJbe5OPfxiiABxLkTnjRjtzB9NuOoujomINN4acIRjsaIIehAUWmv7yXEYWvgLtMEHqDdfEpvMRPXFld2JRowgpzdPx1r/9oZbr2KfHztPntfutqVEmCcDHSnvgSLZ3c7vxrnt5o7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2/440lErbRVHq/8o71SRNhv5jl2wKDCEr9Op4/IeM0=;
 b=Iz5b6bhlFfe24ewz76uF+UMzkd0Jf5y+t9daWdIaAQU5tLuOqSkRK6lKxxO5abvRea8tKZcqLyN1z1QA0r3Epsfzcl8M+I1ILuRgZ1astFo+CW92BANiZ3F+mWwceafL/XUCA6sKP64y/tZ2dtKmBc4AKayMBlGjgOyvVVQT2uo=
Received: from MW4PR04CA0271.namprd04.prod.outlook.com (2603:10b6:303:89::6)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 00:05:10 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9) by MW4PR04CA0271.outlook.office365.com
 (2603:10b6:303:89::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 00:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Thu, 15 Jun 2023 00:05:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:05:00 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 14 Jun 2023 19:04:59 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Vikram Garhwal <vikram.garhwal@amd.com>,
 "Stefano Stabellini" <stefano.stabellini@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [QEMU][PATCH v8 10/11] meson.build: enable xenpv machine build for ARM
Date: Wed, 14 Jun 2023 17:03:38 -0700
Message-ID: <20230615000340.1135-11-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615000340.1135-1-vikram.garhwal@amd.com>
References: <20230615000340.1135-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|DM4PR12MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: ec13d141-32e3-48de-0ef6-08db6d342f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiTzQLQITuOGDQ8kTxHHmwy3yfBSKXae268l8HRHMrFl8nvsDfkbYzAt6D2esE88w4TGpjdjXSx5s3A18qfc/mUZ7CUFlOiezJo1rgpNdJrrDslnEKcUei+cS3JA3WygVwEobvouv+EErySzCVchdy9jzVroV8B1RFWpshhWfSybcoLWSpqHtma0VDaEMiID7zESInoS3R6xxOcuqL7ua3GhbPTA7s1KpLaCouknHmOuuIet50xpANMttEgJTXws+gPd00n27VYpjnr9gqoiKsvElGnH/MSxJCjdAQYAh+lO3fOlVWGz9biWIsRLx/Yi79Whn0tqzrm3G1mjuPfFAq0rGFyNryNUX8WRmqBhq956t2JgYtFCop4EbdmDIRmN2OcRuJcaJ5bsDeBdH5W76fazdTeAW2v4jGCt9QFG0ORDePcDXiZcO0Ys0icfr1mFe6jriwIeg28lSId+JB9cd1/npnJJPKrd6mWsZl1NIVtEyBdXzNgqsWBE9CaA14dcOOyJ3DofFhtaBdbxRI96sQ3Roz6YpdSN1b7wkBan2qRh/LKT+WVSiBHrolaYUCO/qRgvOSXVj31QaP7AmWB9E/fsX8kDNOR2Nn4hZBDvZYA8lqF9SM35M58rGnIaLI8mVxH0BXlVeiqsCsaIw8iR4+dcCpU5jsM0E8appu6VKstCC4Wb5UXKXLnQQ7/767xccEgJYFnaiWnPLPXMlQrMS2Rsrm8n/D9P5gCqnRwQ5FQacA23qKF+uEB0kgEignL+Lo5fWLAB5G3hzsK3/bbDIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(83380400001)(426003)(336012)(186003)(40480700001)(44832011)(66574015)(2906002)(4744005)(47076005)(2616005)(36860700001)(41300700001)(8936002)(26005)(40460700003)(8676002)(316002)(54906003)(6666004)(82740400003)(36756003)(478600001)(81166007)(82310400005)(356005)(4326008)(86362001)(70586007)(70206006)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:05:10.4470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec13d141-32e3-48de-0ef6-08db6d342f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::602;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Add CONFIG_XEN for aarch64 device to support build for ARM targets.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 481865bfa9..cfa98e9e25 100644
--- a/meson.build
+++ b/meson.build
@@ -136,7 +136,7 @@ endif
 if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
   # i386 emulator provides xenpv machine type for multiple architectures
   accelerator_targets += {
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
   }
 endif
 if cpu in ['x86', 'x86_64']
-- 
2.17.1


