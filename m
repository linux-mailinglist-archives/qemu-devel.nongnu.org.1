Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EAB74A487
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUvI-0000vm-7a; Thu, 06 Jul 2023 15:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qHUvC-0000uo-Ke
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:45:48 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com
 ([40.107.92.82] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qHUvA-0003M0-V8
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:45:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm+FXNpta+ghjaLIT80tHrxo9tqcjTIQ9bkSGPzKDcQ8jgJXjuOPNqCulrS5Wrry60DWsgUqYyx56xahSnxJVukE+fDEO1gJDbWXsjnQ4UaA53t1yBFCrsOeAdO4rn0pyXBs+VKdVqC2dmbndv5IRoofhXEwmiEjHtmLZ7Y/UdIMlgQayjPkJJNxzwZLAr1K0RokNhj9M9Ov3HtJQfp1kEpkM9exazem9PsaVS4yfJrxO4SO/vWcvSsHWWdbAsgOvh2wtcTNKCQrksLMqkJ9AImMw1m4DVVlWEGT+VqkkQB1xLIrrgpuGwT+yUG0ujgb5BC0+gvQFXQFfALmsylpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=colqGIM319Etps292BoDimUCTB/ZXYAwCQn0koNO5tk=;
 b=JgcCSWOoTaX7fjGBPthf8og8IzdPCBhWH8KGXKYjVJkRx/k6tFeAqP6nTZfT5jkAgdlPzuYXYMhiLAP52681IypRsmyK72Ze0sXZuqNipO1p7ktLeX34KFH/mA0RC4IJ85ybhxYLWQecH7Oc6DXvLGp6Hc8B95U5DrXYA7zvhT2+ZIJwPlcpnC536wI4px3C91NmJ/e+4/wDlTm+HjAdQxmvFEXNrmlt07iEAf5MoOnEB7G2gtluhLKJgfKxMAgCtmSzAA06mqAdU1AddxVH5vu39n3cBe1M+3bSHVAttUFfVmq16LzQ23Aoq0GmIVnv0O5RhENHwuQoyPD1K+VKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=colqGIM319Etps292BoDimUCTB/ZXYAwCQn0koNO5tk=;
 b=RqkBk8ffhgGJYcEn51Qku416MlEkSTovVj7TIxS5/Bj+KyisH59sqylw5SCPrvVD5Gjc1Q2EYoRg/H72JhuIUswu2zY5oCH+ppUrP7IWTEKMN7novPHT2ry9zlKZD48AlNr21aS5FxevxqRkp8hVpotwrpoS+s2tSaQNbGYbmFA=
Received: from BN9P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::32)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 19:40:39 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::4b) by BN9P222CA0027.outlook.office365.com
 (2603:10b6:408:10c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 19:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 19:40:38 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 14:40:38 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>, John Allen
 <john.allen@amd.com>
Subject: [PATCH 0/2] Fix MCE handling on AMD hosts
Date: Thu, 6 Jul 2023 19:40:20 +0000
Message-ID: <20230706194022.2485195-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fa4958-7214-452c-f402-08db7e58e051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEp7xWAF1vYhXOVpXn/O/q3xS+ZYkjO6Y1+rPQ24it0U/fQSNNJNEXvnfJOAUx0V1GkQqiC3NOB//Cl2lCVBXxbt9B6samYor3wtz6E1AcMBIu8LcmqvjRVlMwwJZXLXXvmdOElpFDoWwP80S1Bxw8ZOgTOfW0i6Zldb6G0u9kh9oE/IgcQMj6qpRKrHVdDMQFXFpiwU06jE7J8XX4z/ViZ8kBE5R9SQegnznL7lPdxQMlYXcZ9EwgABJSBIhTDDiVBKVqpD+OcnsyzMUexSIVsawJD8p2a4mt9P5jEsWNdprJ3kC75ue043PRdj9qUEBTK2dKm4ijKDBFcLZ68nymh/RGumqmkt9ytS+I/vERAqxXv+AhjXDuU3WEmQ0btWKyDslfwdsrndT5hEkLNtcrHTd3/Mp9B+MStYSPUQoqnbc/emWgkct+iV2GclpMLzC7geX88ZVxWQUR8rAZ4e9LUWPD45eD7b5BeZuuyJGtg/TTqsHB/VoB/nYohyDWQPE33BzgoeO+eEgvVf7fTMQw7R8S/LivP4GXRISc5av3P73zmyEiOcGDP3CUaQhPe9LathvGwztn39CQb0SayMLtpqyddpnHCjJF7HhDdwGDx40/pkWVtUEWRqsTkqnZaXV4Y/pbkVF05OsiPzazeK7DwJVatDJXEeiOQ7fNXi1u4M/GLmi1X/6KoLdeE+exJQKdkdq4YMIl9yYnXHlG+mWayqMmztm4UWCThDcC0hyJVvVd7ujYVlulLlVJSuubuaagUhoPnK6/4x/0KB/eSYCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(66899021)(478600001)(70586007)(7696005)(6666004)(54906003)(70206006)(81166007)(2616005)(36860700001)(426003)(36756003)(47076005)(86362001)(40480700001)(2906002)(4744005)(82310400005)(1076003)(186003)(26005)(16526019)(336012)(82740400003)(356005)(83380400001)(40460700003)(6916009)(4326008)(316002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 19:40:38.8277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fa4958-7214-452c-f402-08db7e58e051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
Received-SPF: softfail client-ip=40.107.92.82; envelope-from=John.Allen@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

In the event that a guest process attempts to access memory that has
been poisoned in response to a deferred uncorrected MCE, an AMD system
will currently generate a SIGBUS error which will result in the entire
guest being shutdown. Ideally, we only want to kill the guest process
that accessed poisoned memory in this case.

This support has been included in qemu for Intel hosts for a long time,
but there are a couple of changes needed for AMD hosts. First, we will
need to expose the SUCCOR cpuid bit to guests. Second, we need to modify
the MCE injection code to avoid Intel specific behavior when we are
running on an AMD host.

John Allen (2):
  i386: Add support for SUCCOR feature
  i386: Fix MCE support for AMD hosts

 target/i386/cpu.c     |  2 +-
 target/i386/cpu.h     |  4 ++++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 17 +++++++++++------
 4 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.39.3


