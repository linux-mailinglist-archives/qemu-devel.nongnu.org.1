Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38A804EC4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:53:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAS6n-000725-R0; Tue, 05 Dec 2023 04:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS6k-00071d-93; Tue, 05 Dec 2023 04:52:50 -0500
Received: from mail-mw2nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::62a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS6i-0005Q2-Jm; Tue, 05 Dec 2023 04:52:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTVjmogTMYRra0W/I0d5P86nD5TJ1iHvO+iL8yPOVBWZjShMqkIzl/hp+RvUdIvrDvdoYylysghLS1R8lJbA6dfLwvK2beQOhtCay38CcY2A32WGeOsp87jxuK+fdneHrQLlIE2sMQLAivOEqpSmigQXqNgLIyn7GlwG9YIfAko9+W7xXqigV5ZZ8k7gV8m/FD4k2AoHZ4zu8TlwQ/tXpHAl5asFa7mI+FO98SLGpGByIkAiS+J/ZunQbf7LhOhN9JiWtFIEU+2Fc/HIe1VhSq7VYvlxYr8Dbq98HeEW3Ev12i9ANGkO0Om0igm0alYO9vAdwyUz4Keh2QVm36Frdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ReaLTPflcB9NX2tdeaVUkpAx8qC+T9GMR7r/YwPssc=;
 b=lTeMSB67Rnogv83cEgIJV+9RgbcIui/qJujMz1fgCZhyTYb8eos4LHDAZtD/3nMrk65cf6+7gX+ItPIHXRMym5c05eM8odb5LWLrXxOi+PyTmuC0SoJxqn9m/XPEUqDQ3IKcxllANjPB0s2a+E/eRcQaTDLQoFHimiG69V9mbPSr82gnH0bH/EMbvt/lza0Xx7t+KexfA/lrAhb43ciX4djH2qFovtVB8ZnihGx8yO/iF1oxYJHwG1tZYHI8RdAQ439zjcGO7iERgn4Lt/9EDAsWFpyf3mkAf05e+fhAopzh1j/IXVCWYowHSjxJsuZaK/kYjqT4Vg06Eu+pfx/aIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ReaLTPflcB9NX2tdeaVUkpAx8qC+T9GMR7r/YwPssc=;
 b=kmwB6RH1mwvWs2SXoN2Wcrfh64xykKQIe9cjV7NAq66uJ08dCk6E2DjXfWBcpgs07+XUk94OEcIv3Gxs5EdcufhsM35JsjUNjqlInnBQoxNyfIDByQK0KFq9F+BoLVoSgokIDfzndcCUfWM5HVhRIocgKqaSrWHAT+ExprOH9iE=
Received: from CH2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:610:4d::32)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:52:43 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::26) by CH2PR19CA0022.outlook.office365.com
 (2603:10b6:610:4d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 09:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 09:52:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 03:52:42 -0600
Received: from xhdvaralaxm41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Tue, 5 Dec 2023 03:52:40 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>, <saipavanboddu@gmail.com>
Subject: [PATCH 0/2] OSPI updates
Date: Tue, 5 Dec 2023 15:22:24 +0530
Message-ID: <20231205095226.2688032-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 450a77cd-01ac-4e69-2ffb-08dbf577ed3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C39DHEU4OFV/3DfqPvX/zQeGupfmSQbg0BC4MJ3ddvUmW+PZx8Q4pZ/rEvpUEQFxXb3A3E/Z2f75iVMJfD9NvehR9nzQZSgCKGS5QmXRfIZ+bdjIq0Qtob3zyMBbp7LZS8ab7nzzN8lJbZthTGOCRSTi8XVz/SNlfo05iFwUrBjqH1E9uEymPha5xfzkSiQL3FM3zmI3XxaL56+7ZAaAGGoYPHeJjwDZIx1/5OpHxCAATrNOszH+gDcFJbbuJu/aFy7T0KzGvooQC2oAIuDbLR5DHTjyHrouZl+aHc3iaZgEs2b/OJ4MkM1OYsTUpRZ9q4EX0IsLJpMhSlw1F2rUaQMXGk/t5dagGUiFaFnV2QlwH1bs55rY8C4tywk8i2N0bdPoV0ZGecN/loe//HvZiAtrg5+oQDhD1IHpjpL11qD6MJ/9IBcJoOdEe0QVTvBtrbaMOIOAZMpT2Cta8JVpRbDFuFZJ+t70KHU/8pAYnzg+15FeT/M8LKQ5ERanm5b7oEgEIB3omFua6UpV+UIBEP23/1lkjS/8LkBV9Wbku3lN2Yy1Z0ob2ycwfoOJU96sqHd4A2DuAG5ROZFrclZFt7l43U8JD9mLZbt9MeIa7OUUZNVxVbQ5AmeE9S6+ADbU+PWpJ0qXxe3/+FOcMzsJebKt8n3y2MMij8qU9JWpfEMvva2Co8ZAIcW5PzH25S8tChunY6oSFC/Of0InX6lhPo+gmUqil0fOlfoU5wAgF8anB4jKpWJuKw1cBBXjgaQ6kB7YfHjulG7v46RkVczkMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(103116003)(81166007)(47076005)(356005)(41300700001)(2906002)(4744005)(5660300002)(83380400001)(6666004)(336012)(426003)(82740400003)(26005)(1076003)(2616005)(40460700003)(478600001)(36756003)(70206006)(70586007)(8936002)(86362001)(54906003)(316002)(8676002)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:52:43.1955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a77cd-01ac-4e69-2ffb-08dbf577ed3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::62a;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add a new 2Gib octal flash mt35xu02gbba. Add an interface for versal
virt board to swap the default flash.

Sai Pavan Boddu (2):
  block: m25p80: Add support of mt35xu02gbba
  arm: xlnx-versal-virt: Add machine property ospi-flash

 hw/block/m25p80_sfdp.h    |  1 +
 hw/arm/xlnx-versal-virt.c | 31 ++++++++++++++++++++++++++++++-
 hw/block/m25p80.c         |  3 +++
 hw/block/m25p80_sfdp.c    | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.25.1


