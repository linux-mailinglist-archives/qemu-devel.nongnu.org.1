Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F647D6645
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:10:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZtN-0005qb-Vw; Wed, 25 Oct 2023 05:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <JuliusAndreas.Hiller@vector.com>)
 id 1qvXSx-0005gt-Hi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:34:07 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com
 ([40.107.20.70] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <JuliusAndreas.Hiller@vector.com>)
 id 1qvXSv-00034x-Vb
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:34:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enQqV3MmuLYpupgKklOB0egR7fmZqPcshbKAIqDywMAU9AthZqVZkKW0j7NdUEbfcg6U+P8zlLWa/TEUaW2mRgwDW/DHnb/E1Pqqfp1ux5/IKADw+yE6O5fl41QwX2IgumLP+9HPnyfj5qs/WSnaYKP6j0h9A68xCIus2E6fb0ebr2BPd/FZvx1CiQZAbpfE6S83xSFjOyMlAPwSQg4TJNuLZXc2z20l5jSkQqXr3wyAVwJTr0n9uzEK/8YUPKGE0QqWygCPnYk4nfNikHf7wS7unF6Ro8ueZUeMYi8aa9+rVeCNTv0KosW3rErmiZ2NKSyZTUSp6v4l22vQkjWMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBjRLoUw0OhpvJTn2vQfZYj4xpR3aK0e0qGMAhqH81A=;
 b=LTmV388RrD99vBV9pEJOc8ydY+LHLr0xGrFuTUe581euYBaWkPewgtDcEyZhPcfOi3hSBr4/0Mch0PEINemx9Xr3XHRZ7p5D9/0/r4sbY4sWNfgVkWgaMjTIIS+HoLl/fJlhyz6/x1kbGd/OnPk0COE1nDtNl5WjlHECzUNjiCUU5OXKs9Uu05J47ci2ccaTNncasxA8OPfi1y9Xnsgp4gFod/UyfNd6DQymumkROpAg+FXTeNNhKOWhtF/LdOt8Ry6rn9xtfZE8L2ll2FwoHEGAst0FM3D8X2kaWFhHQPuFjT/Y/iJp4N1uisns8cd0wzXA86JmUDVl8IyiTbNgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 185.199.76.237) smtp.rcpttodomain=redhat.com smtp.mailfrom=vector.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=vector.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vector.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBjRLoUw0OhpvJTn2vQfZYj4xpR3aK0e0qGMAhqH81A=;
 b=QQXtpzEQPcHWHTVxcpqYfE+xDO4kZsv0FcLdfed4T/T9blV+CQw22bASurE3JpppYOglc/owYxDQvJy8slVZFlix9Ks889nX551WyEaWgkKSdexRPIf2zWBAnAGgzmOfcABZLjJARqdO5pWIOnHKZAe43gnP/Ty/U0unHU6Ka8M=
Received: from DU2PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:10:3b::15)
 by DU2PR01MB8800.eurprd01.prod.exchangelabs.com (2603:10a6:10:2ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 06:29:00 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::1) by DU2PR04CA0010.outlook.office365.com
 (2603:10a6:10:3b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 06:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 185.199.76.237)
 smtp.mailfrom=vector.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=vector.com;
Received-SPF: Pass (protection.outlook.com: domain of vector.com designates
 185.199.76.237 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.199.76.237; helo=mail.vector.com; pr=C
Received: from mail.vector.com (185.199.76.237) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 06:28:59 +0000
Received: from DE20455NB.vi.vector.int (10.110.138.73) by
 vistrexch1.vi.vector.int (10.149.11.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 25 Oct 2023 08:28:58 +0200
From: Julius Andreas Hiller <juliusandreas.hiller@vector.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, Julius Andreas Hiller
 <juliusandreas.hiller@vector.com>
Subject: [PATCH 0/1] Add acpi option to microvm documentation
Date: Wed, 25 Oct 2023 08:28:18 +0200
Message-ID: <20231025062819.23175-1-juliusandreas.hiller@vector.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.110.138.73]
X-ClientProxiedBy: vistrexch1.vi.vector.int (10.149.11.5) To
 vistrexch1.vi.vector.int (10.149.11.5)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|DU2PR01MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e5fe45-1587-4026-99ca-08dbd523acbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJdlXalIcL5grucM9nTb9Yp2lX/0En//yf8Q6zSxVQIDAeWLyScToxYovGWRRay1f670uBYiPnB0tn7JY9W5gxP7oftgXKt/fUW5kwcj0E4YClnbjsm9L8c7vrzvNiF8iycNvC+EWHqHJ0LZB1HxrHX3sFvoGD4fcpbU4aYNhPtx9dTR96Tux2y2BA2qgsk8CdXDaxNSWZxXsUB3Jyma7whYigFXMyXJmGqjOhEFU5QFbIn/MEXL2AdnDVOV0elBz6QjWUA3oJd3x8CjhnvfCFPjyjD1EYzDhKS2OYsrfhZufIKodEhO6RLG7Oja6LaaaQkB38PzrEJp305nqSRnDex0ax/DF9WC0sHuc1MCWVOedFEgMxBy3MKiFcTtVQMBK+qAIi31/k5msCD7Q3j2Tvv2Y61e0GyOMmtirpck+O8tWt1l6FnBV7jFtz296CGrb6KJZ1MabUq2JKqoX92pPcO7L3dyE7ea3nH0lGNCa6a9YJub98srrSuJvy8XAK6/5Wd4hpFuoH34ecCUOuItwelxcCgGtkDx4a4YsCnmxE8Fok1GRWA13WnRJBLZKYynZJ0mcURPqldD7YCa4e41LN2gvBwy/hShr9oZwJb2MfOwgeAZUIHeqU3qw46obXYWQdc2cAxTv9InvO14lIb5N6YY90A+6ev6UqbmbkqHsxxgyrv7sC+p/xf8zQ8vMbnGyRj9fJGOXu3yklqYAkP4wg4GYNMcDq2y+La77xOKn4I9tddjngPqTg43w2/buD8B
X-Forefront-Antispam-Report: CIP:185.199.76.237; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.vector.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40480700001)(83380400001)(316002)(47076005)(36860700001)(86362001)(36756003)(41300700001)(356005)(82740400003)(81166007)(70586007)(2906002)(4744005)(70206006)(5660300002)(478600001)(6666004)(54906003)(8676002)(8936002)(4326008)(26005)(1076003)(107886003)(16526019)(2616005)(336012)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: vector.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:28:59.9951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e5fe45-1587-4026-99ca-08dbd523acbc
X-MS-Exchange-CrossTenant-Id: c844b2b9-7a68-473f-b386-e2e1b968279d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c844b2b9-7a68-473f-b386-e2e1b968279d; Ip=[185.199.76.237];
 Helo=[mail.vector.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR01MB8800
Received-SPF: pass client-ip=40.107.20.70;
 envelope-from=JuliusAndreas.Hiller@vector.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Oct 2023 05:09:31 -0400
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

Microvm machine received ACPI support which impacts passing of mmio
devices to guests without ACPI support. Without acpi=off,
auto-kernel-cmdline will be ignored. 

Julius Andreas Hiller (1):
  added acpi option

 docs/system/i386/microvm.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.34.1


