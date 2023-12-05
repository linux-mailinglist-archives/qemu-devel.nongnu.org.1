Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF196804EC9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAS86-0001Az-0X; Tue, 05 Dec 2023 04:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS82-00015E-CS; Tue, 05 Dec 2023 04:54:10 -0500
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com
 ([40.107.94.63] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS80-0005cA-OR; Tue, 05 Dec 2023 04:54:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG8Ul7bV43No4CqcOWQk77eGjnVUAg6v21TPG34zfyBpzjM5gYfHB80K+F0K2+xEzoh1a1aE5jFqjv43wpwCvbNZMgLHPmKAARqfNIBp7JRYq/GpC52AXxCvA8LvHuIzW/QOxW5f66z8NRFYssGFk8Gavziqyu8iQVwQGXK6WY2mGAW+nIm8d8q13/mYDOsFiUlsbSx9jMPMwNoGOp9TtlGn0afAKfYQFt2NWZYQr+ewgCj7x+GhFckZtnjpHrO1OSSvYrdMIeRxGWWbg6dtn/1mY5B63Q3NNfmslAIFn7obqR6S0dGQMFDBW0OyYoCeY+lIesQSG4VgVdLVQ3im5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNv14aJ0REm80Nw3ApfkRpR/D9RBQt469d3vbMvf6Mg=;
 b=jRua9Tm3z8FB5v6zLCBnq0hGDULMMu0BfWOvLzSwbyfFX0F5bRUoqsHpA/M9Y+r0rbz1HV4zhJtnM9+mKQiA71QwK5a1IQ0LerOULgLWP+x3fdxag6O0T7Prud2LTVI40soppFCoZGXVQ+9PFS1bTflep2QFkgOqgOSK0h11e+uApWnPEde6HE1CGV4WNTs3e6zYjXu0tpA61FdpJNSeFgl4jQpK0HdRabQlrcc4zaz+6t5tR2ooSevKv4dIhPElvpBO10NrieU4Pz/6Dhbdv4LdVSTXXGdOaYHEuKs0a8ciJl6tzu/1qmPlaPsjbSkOuhJJjf9mKhDvcpouYxAo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNv14aJ0REm80Nw3ApfkRpR/D9RBQt469d3vbMvf6Mg=;
 b=aGOekLXLhk1wZExipj8QdH8gOXHt237TSmKawlJCkm9yicgAcM5O1WvdG/mkm2ZhgyZWRus9vDl4TywCFioYIxI7ej8wEwhxW5arJJSr+5boKhOVgRVQCGS5kP0q1UhmyZkDmyIHgnB7pCZImeB1cFP8WVq3sAZajClxoVDHKoo=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:49:01 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::65) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 09:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 09:49:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 03:48:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 03:48:24 -0600
Received: from xhdvaralaxm41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Tue, 5 Dec 2023 03:48:22 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>, <saipavanboddu@gmail.com>
Subject: [PATCH 0/1] versal-ospi fix
Date: Tue, 5 Dec 2023 15:18:01 +0530
Message-ID: <20231205094802.2683581-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e53cf8-7b46-403b-119d-08dbf57768b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lp5j6xRWb3F5wyDPRfnPvFf9zKoDch+O0K6xkXE/0c9PNyhaue548xaG+3+m8usOv5uP7ncNHNgKsQN259o3rkvXuVUf9AMx4MRX5mR3QuYbTlFp6oKq9diHJfWPrYMDTGNjjcJEiGZLSqtGKSimwGs1r9PKdw++voEk/UowX9snY/PnUduc0rhHqw+YDuqX4F5VE+pgdJd2D9op6Go8+gO5Us/CN7lYjs17FOIHdjSrKkOqTLTogDMyBKo3Qpq11AmoVjFk+6+l+dRiARRzkjrfgpkSFlupHtARh1iiIX/hm3osQ3ef1VW+nY6U6AZhdW0rwn5RIPXiwTWR7Ln6q9W/zeEOyefIm7/hKIDif5ZKVdEIl67U7j7gYPZj+53X/vLx4nIgXEBZzKkXnDyuA3dpOKHs3kRBuSQSiglLSvcTgGLK4OLJ9/6dEvCXkABS8DaHWHvNDuz0837XtBwT7v+aopE+qK8Pa+spAcmc72rNVqUv44KRdFZuu4J278dHkuNSaUkJreVh0QKWOAyLXTbyN2oqjEI6/SXGVj3TB6LI0Vpqsx7soxp98tE68is+i4uFs2Q89WAXQnlsrtdnZ1jAC06tDMmUv2hCvkxRPJnYbX+Ulj4Fr9Q9Muk0DwY9o4iDSTcMUmowjaP1EBbGaGjYnt047cXhgPWJZQzANIaIdCKbQ1gcqCxSm5vA28D9XoCt6nfSgCm80lEk6HSC+Nb8doFRMU+xhguFQ9N4VIjajndAG7JYr8DGr6ngAK9YyDVNGQGnwarUx5xRXGSqNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(36860700001)(40480700001)(478600001)(6666004)(54906003)(356005)(81166007)(70586007)(70206006)(316002)(26005)(47076005)(2616005)(1076003)(83380400001)(4326008)(8676002)(6916009)(8936002)(426003)(336012)(82740400003)(40460700003)(5660300002)(2906002)(558084003)(41300700001)(103116003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:49:00.8689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e53cf8-7b46-403b-119d-08dbf57768b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
Received-SPF: softfail client-ip=40.107.94.63;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Disable reentrancy on iomem_dac memory-region.

Sai Pavan Boddu (1):
  xlnx-versal-ospi: disable reentrancy detection for iomem_dac

 hw/ssi/xlnx-versal-ospi.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.1


