Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F80764184
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 23:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOlPp-0007fP-93; Wed, 26 Jul 2023 16:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qOlPk-0007fG-Sg
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:47:21 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com
 ([40.107.93.78] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qOlPj-0007Y0-5x
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:47:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8YR6aGZkF2C8QKv3Mp+ZjfsT1mzXxXhBepImGIPoKdEg8IoQsalVUriAmZ2cVdPU4dOodUJr2VjlxDxfWt6R1W2/JqwSOFiS6GcjaXdTMTGRCPFjiSzuYxmaJ9JZdzjC2e8UCeT1uuHgj5NzLx3/+ppXzX8N7fMaU7Gd+xI8eTCE7Ybix9usGSvQdeBqlMRN78Ih3iVPqbCCYjaTzPQAqEv0wes3nWrU/rz9BOKxy4+l68lrOm8fc4IppAtT8Z+R8t7xElRsK6c0uma7jMsfHqVgQstWZX3q2kR1BG5uf1ucgxtVEkAD7/JMWCH3lytBRr2wBCC0A9fZAf+Nt5cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc1PQt5ByqKxcBwI4ZlLPRxxqdkZAqOCBMxoJVlyAPg=;
 b=R8NIETCFrytArinLSFamPrhNTS9fbJcOjb81UPawyABspZazhBI/cX5rMbKJIQUwDpHyVxEFs+4Z+bjbOuDZcwuI+DLTRYKxa/SFVn9uuoYgqLp6mKopqNFenMzhFbn8wPHGuMVOeSHoy0N216UO12nyQIq4FuwwHCVgOXL4+An39PA87yz0F1Nnu5v55aT/m3Jrvv2yXKqxjG1xe3N26z9NDvbJoKebaSuHr0oviCN28bFGAV7HwF9T5Ia11XWmNrNVYRVxKUaiUuvN8lyZlfRiiDrk9Fstnj5yl0uXpeLbIzku6CqOn1HcgOxc9l2NESoINCeDdXVoZl9yMv7zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc1PQt5ByqKxcBwI4ZlLPRxxqdkZAqOCBMxoJVlyAPg=;
 b=AwswrD8lnjwYOfpbLM/LAVn2d/J3bHBeVL2RH+mEag+kirzoQV/ttP2KRwoUaRmA/xNGPqpCkXGV+s+PA9ZEXen8FPpKQiceNs5bd0Qp+sBBLxylzX++u2EHGWMdqnV/KaaJwbwtqqdQbNnODJEbdzHnJoT4RDF4by2b9Criqgw=
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 20:42:11 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::15) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 20:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 20:42:11 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:42:10 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v2 0/2] Fix MCE handling on AMD hosts
Date: Wed, 26 Jul 2023 20:41:55 +0000
Message-ID: <20230726204157.3604531-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4ed73c-dc5c-416a-3442-08db8e18c99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mJpPQtHH+NOxPwVguquFGr2FA3LI6sP9AS8pVTIvcx0mkyS9DlCn2UVND7emBZUjjikmGVwZnc/1Cnjhf+ZWuybqLTHK2bNwoQlgRRr3kia0FwZjb97Je/6FEJGZXLme7/4ZgWTtqIFsdEHl6o5V4YA/7AOmEhLoLEFDwadZZXfmm4cboYnTt2OsxNFC6xzVdoJAQLQiZPfov9J4K5laqKGKI08BhsGH88+ec6MiwNEhI9LLcoz0Gg+PCIJLJfwsRoEqWY9R8F/aDLXl8SqKdWRECTRmoNG48LsQChT3SvE9XJCbTbbJJcLuzAU5FuvAuVi07qx6s9IEeVxp0YGNFIkJRQZndjMu2iXdEJqmzAUdeiBi4frUD7BYV3q0UCm3eU3JmTUb9RQHec5UC/DETen1lBK/K3XAbW5IU/OXCw5BC0e6SpEOCQdljaGEDAeCfTclme39gfiE2EukGLaa5zEja1OAxdu65EDpaJqheOiZqq24J2LaNrJJ8kvrlOGPeO+T9wZJGe8sc6u9HXwDQFD79vcA16RwT8rjRBCCz3aCDGlmrTkp9kKyTFNusexJklBNeSOWqw+vEh0b7PHlTW9Xv7PUnU8vNJePA4eXdy+zjBQfuJ7CGP1S5UQblpALdQvaVw2IImL7YwFN9CwjDppDceHVliU46aDEef0J4glEoEQH9lyP8RjiEl8/FK6PBoTmaR3aHGmhv87E9L14Cl22GNoynY8Id9wMd5RptUWUGYiss7k78wUxtRXInY+j7LHNXHm393wMTSW+aYBXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(478600001)(54906003)(7696005)(6666004)(16526019)(186003)(2616005)(2906002)(26005)(336012)(44832011)(1076003)(41300700001)(8676002)(5660300002)(8936002)(70586007)(6916009)(70206006)(4326008)(316002)(82740400003)(81166007)(356005)(36860700001)(86362001)(83380400001)(426003)(47076005)(40460700003)(40480700001)(36756003)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 20:42:11.5470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4ed73c-dc5c-416a-3442-08db8e18c99d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
Received-SPF: softfail client-ip=40.107.93.78; envelope-from=John.Allen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.

John Allen (2):
  i386: Add support for SUCCOR feature
  i386: Fix MCE support for AMD hosts

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  4 ++++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 19 +++++++++++++------
 4 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.39.3


