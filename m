Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C234C7944E4
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 23:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdzcK-0001W2-7W; Wed, 06 Sep 2023 16:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzcB-0001Vm-V7
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:59:08 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com
 ([40.107.243.79] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzbx-0006Ku-2I
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:59:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMB/xy+F9ISSmWcVXlT7ZvFrwfvmlNSbZJEH5CA19dsXJqEiHyfa51LmVzNSsWIkKzmdYMVSdjyEiv+HTYXlYKtVd69wltws3if79rTqVCfumFpPwsokw0iQuKfEJeNespZX/Bqn1OyiF1jl7GPtR59HDAN1T4ekM3SEf+rWH5EYZVW/aDwNZauh8+/R6c1PqJvbQqkMvgQZkuu0zJT2+r9J6U9DMieyMShZN7efoZR8C+Cr+Z1ZLVHpUh24NOz/IKlWIvoQtdOJjKjPqrb1v84Qf62/FlrRSZCLwYfbGPdNSC3vJIiTORBsYkAs1r3Z7scQiFFESTfZj8aZ2TmLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srSK2FmT8J41t5nSBlH6qrseOyQJoUBFB5lP4LKVv7I=;
 b=LeGIEcJIVpU3GL4uMXrmAq3+586MypkETBWS1LePBOm3IkoQNKSautgsAAJb19V9kwUgA96zWGxInOi5GKahgUZednaMbG77Ko1gEXp3R3Db8a5I2d8aACjM/7+HB360YQ01rWUm+k7H+9sGPFWkTBOBIkCLX44ns2KhUBKCTFy7G8nsrbFDzlMSOv+XvsoZpopqcdXoIIl94luiMduZwem//eZiTUbAW9COaMH8AsU8ssOpttcE76Pfsfn33Y7/QdMG89t18yggVmdwYQIby45RLiCDifLz+9C+/4162vaEIHofwnxWSrXMrnwMX2PM502C8EgP1iMoDzu/Fhqfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srSK2FmT8J41t5nSBlH6qrseOyQJoUBFB5lP4LKVv7I=;
 b=jgAJpKTKUpBv1fJx+Ax1PSmex+Rrp/iiDpLtN1ddi58318Dn4T19Nkt7dbY7PAZqy3jaNT2elxfMaLEcFL0RRbpIM1xv9HeJqAlvH4rJBNkGUsu79Xp50goLUMn6YVl3eQofrstVk5eKCJ5AoIjb1pDFrouR2tlTw1KNzU9/h4I=
Received: from DM5PR07CA0064.namprd07.prod.outlook.com (2603:10b6:4:ad::29) by
 SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Wed, 6 Sep 2023 20:53:45 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::ff) by DM5PR07CA0064.outlook.office365.com
 (2603:10b6:4:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 20:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 20:53:44 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 15:53:41 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v3 0/3] Fix MCE handling on AMD hosts
Date: Wed, 6 Sep 2023 20:53:05 +0000
Message-ID: <20230906205308.50334-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c895ca-73e8-400b-5a7e-08dbaf1b5c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVK6yczukH44v3yl7Lra1sVcKSaIBBIVnnGJxuQfuFoJAoe8oRzg3lCCHCb2vio8ymmt4/qwe+A27RCKqSHDyCcfhB2UYmLJIzVwDS0bfkmKAZJqFORZ/kbXRwhl2MX9I8B4vSZRc1SgbBqrAwyq0RFHVFkPvyfOxwcff+96NrshhHhYVWG5IgWpt8B863vgJ37+Ykb/LcpxPh0x00KkWGVeledpQLV18XHoxc01aA/5QW5y3XoE9ggI+sLcfi2a0JacDgvoTmYp8Ey8lb1PcCcaaGNYYB7x4ZjubIVcB45SiTl9V9ADsR9ZmZUuQnD4BAUNi6SwzngoTkmTcnmifiXiFXr9gxW30xw5YlwuqRbB2yB2or1f4qIzQ3txbH6dKQGRmA/IOjx1OZ59yVgFFdic5VX8mobo7AHFUwc+1kJk8VCnjUscd3c/4aQxZDQ/Mu84Uxoa79NIr+oqgobHHVO1w+TPei4AeVHZoSSaYP5fIp5hL80e38+J8yQ5Z37vPPbNRJdapPC/nYb0/6bOQC1wO/mMLEXZ74IUkJh8hchNMcjrFxDfJO5QXTQlYl/trwWxFFO643/0j+W334ogwSRKps6NoRcvGdqJLfh0pFM5A4pSIDSYzTRhlUG+b+h7zo4ydZgJ0ehIfpXLH1LuNbp5r46qmb3wLegduIG5jL0hvHs19WYZfKHGrDv8v4l3V7kwYFjed17sGJpWc6leAMai1xPKWn9UZB6QvDF0m+p46l/pQVUS101GzZPJ3+PHomtq8gCSsOh0vWivzPs9Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(356005)(478600001)(36756003)(81166007)(16526019)(336012)(41300700001)(47076005)(54906003)(70206006)(7696005)(2616005)(426003)(36860700001)(316002)(6916009)(83380400001)(6666004)(82740400003)(70586007)(1076003)(26005)(44832011)(5660300002)(4326008)(8676002)(2906002)(8936002)(40460700003)(40480700001)(66899024)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:53:44.6629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c895ca-73e8-400b-5a7e-08dbaf1b5c21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
Received-SPF: softfail client-ip=40.107.243.79;
 envelope-from=John.Allen@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Allen (2):
  i386: Fix MCE support for AMD hosts
  i386: Add support for SUCCOR feature

William Roche (1):
  i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  4 ++++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 34 ++++++++++++++++++++++++----------
 4 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.39.3


