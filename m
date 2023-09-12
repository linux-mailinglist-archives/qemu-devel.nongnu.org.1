Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38479DAA6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgArf-0005EQ-QN; Tue, 12 Sep 2023 17:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgArY-00059f-6Q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:24:03 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com
 ([40.107.244.74] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgArU-0006Zq-VW
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhG9f8BqjlbXAoI/l+Uu+7+bGj/y33qytYspB/w4Pzg/eYtBBanBwZGVpZhGuIunut/15cH3E0xJldgMqD0K67RTC6DaylFtTGJ8ZgpO6AjWyu/on0XYnFGMdw3/bhiSZQYSIlj303GAjgBuZk1OkLMktPXV3M16/SOQ6Z5ErPVXHfpyRwLt/i7BNcLUivphN2ZVw5bBcKD59qmLhf84/KEFRbz3iKEMjY3S0Ylk34LfQHYTrisbTq4z6WF+4Humm7AqsuiUI0Q93vLJR/QXdVzmCb4xeea7d7edLBa7nxeHr6FzrocEsaWKqHRlrZfeoEVsQdwqh06R0+aFx+NBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XuW4rGOTZzpR1i6AhLmURRXq1pYu+pOrRyb81ZxuYI=;
 b=ckzEJaZHoh3GRTLeehvJRw2YDPxmAEdHhC8T2B61TjNPqRJz3WS0OvpS3U0IsJNPYzCor1/WPn3fyvkuIeFRCA257u8mu6A71Y+B8pOFiJIrB1XXtIGwc8ysdCxxXlDc5Tg/B9yfu8rN4hyE6rpB/VITV/f+zMXrPqPz50It1aBvoq49Ziz08LRFvx/fq8g73l2AzviURqBxAXWTpi/iiauKJZEjdNuLf7Mamatukiy8CriyQPgYq4C4JYzWwIO3BrZ+dLFFHjl66B6346hSgIOodqrSyd6qrHX3A2BMi/dZyZdWamiWjQ6ft7CRz06SWKjenZ/Co8eAIMO2IbvN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XuW4rGOTZzpR1i6AhLmURRXq1pYu+pOrRyb81ZxuYI=;
 b=xCMwM8qzs1pUKe9+Ptbqco9O/77HmirUO9xvBgosOPzXoqFuMm11aEjQIGXquTdh/9gb5oGkFcdvafRQZwG83bjC3pztFgKRs0XYMGIm7mQfG32/QQhGjcWPccENqgb4ZBsdRthJc8o/aNA7XDLwJxUnnqaBwu5oT6ijBabR670=
Received: from MN2PR15CA0064.namprd15.prod.outlook.com (2603:10b6:208:237::33)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 21:18:48 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::74) by MN2PR15CA0064.outlook.office365.com
 (2603:10b6:208:237::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.41 via Frontend
 Transport; Tue, 12 Sep 2023 21:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 12 Sep 2023 21:18:47 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 16:18:46 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v4 0/3] Fix MCE handling on AMD hosts
Date: Tue, 12 Sep 2023 21:18:21 +0000
Message-ID: <20230912211824.90952-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a086255-3a7c-42ba-63e8-08dbb3d5da71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+yUtoCbAjC81oHdpoIHgpSshyPcH0MPRInmFVNGEP16kJ8egk43gISN6zzB81UKneld8ysl6Sj0XcFYpHjPxk+sd05kKmb5VpzeVaQO5ZO2HvZLkZy5ZDnhsnSV+cqUYR7iWfLsQOTzg/6QOEySLc57jF5D/f30/d4vJSP0oNvgOboFJ1ZOEoLDVKlvLaFXnvQ8Kt6/ZV68Uf/2A2JGKAulnzlPfW3epU0tfrEQn+cPG2Mj5nuBVOS/5bvz/lpYhtQKfuiizlimw8O5AR51vzFZSydldjk+jw0T+tUZfRzZR+t9sqIJk5mS0LL3xL5+nuHt+RD3qFrwVAPRS4ae9LaQcQEjSfiIMcxw4N//BL5/bdzpU2UFTokH/kkk1ONAU9BMT+UebRDFr9dR4V42FtORKFOpK9fy6zSbyyzk8NiC7c0e3ENDihyPnFLbGl0Zl/rEpwh9GA8PCgYOvFlz0vTSxlsSykM1m1NZB6Q7KppSIFCVo4t2/Ca7X5WRcO8gh299wl3nUkZmT7EnR33U0LzW4wpGSd/ONYOcyiceXoowUZ7D2ddoFoitdXIIeKN6s6VOxDickHK0UyFZcT+w4E4ShPwD1vkjW+3a2Ob5jAArA6wZohtq/YTR75OsPl9hWbX4jvKTT7G+eCakhoTT5Ks9S6uqacln1yeWsl91s12jFd7ZKmM5sWO2XuiIMayRxZD2p+AZNDXom6HOJ9O4A8U+XnVf54Eyu7uAZIzGFowwOQ6rLwbDmguLVxvXZi1dhq3PVvSvr1smUaAyAlI5iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(81166007)(66899024)(356005)(6666004)(7696005)(70586007)(40460700003)(36756003)(86362001)(82740400003)(36860700001)(40480700001)(426003)(2906002)(2616005)(16526019)(83380400001)(54906003)(70206006)(26005)(8676002)(47076005)(478600001)(44832011)(8936002)(4326008)(1076003)(316002)(336012)(41300700001)(6916009)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:18:47.6858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a086255-3a7c-42ba-63e8-08dbb3d5da71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
Received-SPF: softfail client-ip=40.107.244.74;
 envelope-from=John.Allen@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.

v3:
  - Reorder series. Only enable SUCCOR after bugs have been fixed.
  - Introduce new patch ignoring AO errors.

v4:
  - Remove redundant check for AO errors.

John Allen (2):
  i386: Fix MCE support for AMD hosts
  i386: Add support for SUCCOR feature

William Roche (1):
  i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  4 ++++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 28 ++++++++++++++++++++--------
 4 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.39.3


