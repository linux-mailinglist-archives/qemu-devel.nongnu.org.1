Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F097D664D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZtO-0005qc-Rq; Wed, 25 Oct 2023 05:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <JuliusAndreas.Hiller@vector.com>)
 id 1qvXOA-00048W-CL
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:29:10 -0400
Received: from mail-he1eur01on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::628]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <JuliusAndreas.Hiller@vector.com>)
 id 1qvXO6-0002Nd-3G
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvwnppX7a7qtHMnU9nexegudvlJRkKYkjUJpnkWQ31ieIB6bYV63N4qvq+gLl1Nr7ltKoNc/3KEdj+YUyJcplUuWtC6aJc0fi4vYMGCEKJDRbUVAlFRxuPtVE1IRGYaSdI6XIRZrofnk7zSmZfvX0RXCwO7BIviiILrLSUAE3O3UWTT78TKI+BEY+3sB30dzIF+yyQQkv5ouNzPKwSEVObv+9a4ZCmBz05Hwb0BrEav5fe6s61URcjbPMRNWJa4KWo6Wqfkb9n+VvIIJxVbxVJwLTn3lOtN0p0ziLq+K2bo0cBTawe8CwUsN6gxgqJbafnTpywMfPViAEVAxj4n6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up4cz9Kbg83aywHpkO2jE9cXSpxRpk75xTbe6McWHCE=;
 b=IV3u6LG9NDWM7iBRSP6+xotIz17khrr6RFZzC6zkVujOejuIGAe7t7CT51Cn/W2hvOqUG8tzhDoKiyR4INvavpuxvEA5yxsABt8lCXcmsplLoHqc1oTGBrI5p1/VPbiO0zyswKh/9j9Rk1FMjyo5t960gHlc3cKTjVKDdlvDd9YMMpnNPhEGfHJf5kJfGBZzxDhIs9CMV/wpMZj0I8fuXdtRVC0HcW5lpQtKYq7ZMCHX3gBn+Rb+YxHbutLXzn6TvNrnEjZyr2oTBlro37W2fVX0HWPpcb5j3uaLjZh09x8jxssyr86ujqM9gU12QkN8ou10I4eD+iILdvSTel+gxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 185.199.76.237) smtp.rcpttodomain=redhat.com smtp.mailfrom=vector.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=vector.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vector.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up4cz9Kbg83aywHpkO2jE9cXSpxRpk75xTbe6McWHCE=;
 b=fmlX/4VwXefoEs/7loMGosh0X940g/xmPgrbc/ELEn15YRog+FEeAyLDKB5BWleQRwanfw9lyeDbnoS/eL+px4SxFAprFjDZ77U99qqyQYVPj4m1feI4KSl8j946jXfzTBxa2yub09XK6ryeuCvCiddD8tSgYb5zamXHFUSiRAU=
Received: from AS9PR05CA0191.eurprd05.prod.outlook.com (2603:10a6:20b:495::16)
 by AS1PR01MB10223.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:47e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 06:29:02 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:495:cafe::32) by AS9PR05CA0191.outlook.office365.com
 (2603:10a6:20b:495::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 06:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 185.199.76.237)
 smtp.mailfrom=vector.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=vector.com;
Received-SPF: Pass (protection.outlook.com: domain of vector.com designates
 185.199.76.237 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.199.76.237; helo=mail.vector.com; pr=C
Received: from mail.vector.com (185.199.76.237) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 06:29:02 +0000
Received: from DE20455NB.vi.vector.int (10.110.138.73) by
 vistrexch1.vi.vector.int (10.149.11.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 25 Oct 2023 08:29:02 +0200
From: Julius Andreas Hiller <juliusandreas.hiller@vector.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, Julius Andreas Hiller
 <JuliusAndreas.Hiller@vector.com>
Subject: [PATCH 1/1] Add acpi option to microvm documentation
Date: Wed, 25 Oct 2023 08:28:19 +0200
Message-ID: <20231025062819.23175-2-juliusandreas.hiller@vector.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025062819.23175-1-juliusandreas.hiller@vector.com>
References: <20231025062819.23175-1-juliusandreas.hiller@vector.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.110.138.73]
X-ClientProxiedBy: vistrexch1.vi.vector.int (10.149.11.5) To
 vistrexch1.vi.vector.int (10.149.11.5)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|AS1PR01MB10223:EE_
X-MS-Office365-Filtering-Correlation-Id: f26b9c67-6bd2-4b43-58c9-08dbd523ae31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOh7KDwKP9xoHQ3TUoJxuc040DIhJu6k7jB8j1AP4stzPKt0+mTAzY62jdkoL1LO3ON77AzkSFVwhFz4K5yvc3GdhsNcmomxi0z97PkYWqeuqPktkRFQqL5s7MJ8Wl5vYuhRWnhz5OR3hMmzBBAR2NQuS4zoRl9a1RNxr7UEi44XVKnpogbWh1VfoGq7rYThQiqhCXHb7g5eSqvwDlTM+j4i7bGWFJibEZ6vmt3hpOQGGqZezUmcCfGuzPfo1nFVWv7EUKgwtcUXBKHuUOFwPiL/4OrBU4NxPndnvvGL5XLjGtQyQB81i4/RgpRHcXFpcLFAPNE/9fE3fE8Afd/VSIQ4/PxHOdNUrQMDxh2QA0SzRVtbQdjAUUe1Jvr7sfcYa1v4JKk5o5ebTZ51iKQs4YxQSk8pE+4rUc1SB8UDTC3UVDx82ZacJIFLJooimD4Y3b46oW8Z1A9gCq+PfRG8NO4vqMqAzELT/osVci8ez4+hl+iobIl04UT8xFrbS+4mGwgXa9mKOCnt3fM6aBQPMmjIx/dIPrYfJmw7ElIWepCR5k4ahId3J/lD26DKJCooaJDDhMzZLW6oIznPzQ2mL0IDFNla3aWv/oyOcLyJPg8AI3B5AYIVlXhcAzeNL+hMhC1+2hDLhen8gV8cFCYiikPcvbVrG5fHMsO3799ki/+hj2JeYal5vyg/esOo5V4j7PoaN+qIE+q4BRoyE/TVhy/NmlGeSVc3ChGcJ75ubA+o4yuUCsty5EyTZ557fNHU
X-Forefront-Antispam-Report: CIP:185.199.76.237; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.vector.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(46966006)(36840700001)(26005)(16526019)(336012)(107886003)(1076003)(2616005)(47076005)(82740400003)(356005)(81166007)(86362001)(36756003)(36860700001)(40480700001)(83380400001)(70586007)(70206006)(316002)(6916009)(54906003)(4326008)(8676002)(8936002)(41300700001)(5660300002)(2906002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: vector.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:29:02.5473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26b9c67-6bd2-4b43-58c9-08dbd523ae31
X-MS-Exchange-CrossTenant-Id: c844b2b9-7a68-473f-b386-e2e1b968279d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c844b2b9-7a68-473f-b386-e2e1b968279d; Ip=[185.199.76.237];
 Helo=[mail.vector.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR01MB10223
Received-SPF: pass client-ip=2a01:111:f400:fe1e::628;
 envelope-from=JuliusAndreas.Hiller@vector.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Oct 2023 05:09:30 -0400
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

From: Julius Andreas Hiller <JuliusAndreas.Hiller@vector.com>

---
 docs/system/i386/microvm.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/i386/microvm.rst b/docs/system/i386/microvm.rst
index 1675e37d3e..5e11dbab0d 100644
--- a/docs/system/i386/microvm.rst
+++ b/docs/system/i386/microvm.rst
@@ -4,7 +4,7 @@
 ``microvm`` is a machine type inspired by ``Firecracker`` and
 constructed after its machine model.
 
-It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
+It's a minimalist machine type without ``PCI`` support,
 designed for short-lived guests. microvm also establishes a baseline
 for benchmarking and optimizing both QEMU and guest operating systems,
 since it is optimized for both boot time and footprint.
@@ -50,7 +50,9 @@ It supports the following machine-specific options:
 - microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
 - microvm.pic=OnOffAuto (Enable i8259 PIC)
 - microvm.rtc=OnOffAuto (Enable MC146818 RTC)
-- microvm.auto-kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
+- microvm.acpi=bool (Set off to disable ACPI)
+- microvm.auto-kernel-cmdline=bool (Set on to enable adding virtio-mmio devices to the kernel cmdline, this requires microvm.acpi=off)
+
 
 
 Boot options
-- 
2.34.1


