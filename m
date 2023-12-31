Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD64820AC3
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:35:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsEQ-0001TJ-Lc; Sun, 31 Dec 2023 04:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJsEP-0001TB-Gy
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:35:41 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com
 ([40.107.220.81] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJsEN-0000hL-Jy
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:35:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Piuk+YQSbZnKoavS3pdtXZjncS+pDtQ4cxeUvfT7MYTIL6cqdSvX5OYKuGVt6copMs6yo9ilEN9ziAOWFhqFu5qQqbMLDE5RyGliHxUZnOrhH6pUBOP5/OhS4V41nfF8c7Hniedq++dkN33o8dewPh7xDqmp9seI8zcWFneN/GTZMf0qi+riRf67eCVQizjlqDISmU9nzEsW8kW5VtCfg0lBwcLiqfpEu4WwJqA2OULS5VL9lK7iJpPL/S4vhipfNKLdJqH3u9ROP9AFVS81AXQPgxu4lCgPTGoX/REa5yiky3gdgbLNh+KfxU4UsVmoUGkyq8iFYoL4I4ixnn4ENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUNbWtxjtOHi99agwg52eX0xzUe4V7ZfOKcA/gCSeks=;
 b=jjN7WRNreHFbre5TyF12Zyr3x0r9Xa1YjY/PlQglB3T1BjuCOiynV5uIpz1MJLs2CIKj7H+XKStDlUfOVc2QntGb7MXgDBJnHcfKV+XDzfmrzH7TPOixoWp4HVtxOHr/PijmZ/Cy8mz+QAs8WVMcqCg5bwGZO1TvU7GRuSuxGzooCM2nHPEamaN93CcmZwFb9RRbbBGcJ3vtAh0Wg3CrvqK43DkRGD4cLjtwj86Drh6LXw6ag/2vgLeZXsd+n2OCVPZhc9rc8hsONed+ceLwa0QxBe73QWasv0fv3rxfWF75Uw7SaGP8UB0oy/J0aaADDPVHLMjbqboE/2/q3dp+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUNbWtxjtOHi99agwg52eX0xzUe4V7ZfOKcA/gCSeks=;
 b=VtI0Tx5iANZyhMwfr2EKyfT2ob/G9g3MSBRTm++X3dwQW0Byq3XZw2qFQKlm85YuEVC03Cb07x0igya7XpSM5B1BMZ8AnL/6UwdEbPORsP+4OWn5cCPeJZ2jBeWlaHA0EYXaEKTRYSWAd9aRO9K0A2zCd90QCkEy4tS6cyrCi6GWsaq4ZIIlR5Tx/U8doguiGPkJteMUvRUGqNghbeP5Ise2g/9zNu8PJqRLM3HuxCc96TKs69oWE3NjdiV3NGUKexOl70/P7QrebV+TozTMh9vVjzH3uvoFn3UjsGzHBZnCFYQwpwt1yyy4gbRdltd26706jaXQbxZ30COvH3aLFQ==
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:30:33 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::a) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:19 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:19 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:17 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 00/11] migration: Misc cleanups and fixes
Date: Sun, 31 Dec 2023 11:30:05 +0200
Message-ID: <20231231093016.14204-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: e94fdbd3-04e5-4569-dc02-08dc09e322df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N19hL1/Pq22wMLLuasiKhMz2aIGuvZ6XXClF75sakGq8Dab7wrHTUqlwEYEOUtbmkc9YB0Jc2RkGvCbPt+FzJl+UDV8SaJawUavfE+9Mjm4cNM7OFlmyrLHBa1BgPx2BsurOZunQePcQjweSxvykMegFGcu6a/m+4SmtUxWH4TPLpv6Ymk/NuhUxRvtJScw8j4Mj6pDQaaoEiGAYQCwB0L3EmGo2992/kgSrGe8NXCF6RJwVD5pAl0AJh1jGbW85v1itAO07t/AWyZXfpXGSgOvLxvZeoOkAaYWwMl2MYE/D+pz0TlAfmrc0RAJuaip59w4vt/nNftTI1CCmgbYENaaQPGXpiM9yBsb7oMURvJNTaWL3ge5xv1JlCG3Pox0MR5xlmJVBYP1Kk6G4Jfdtg2AAX/xXu/9LyzpbLMxZ6zXnLmWbXnYvLyLxLGKOdk5xPWHHUmDJQ5rSZefvKI32Uqgc7C2EfBJyYPfueli5UEcG+fbkwVNfWeoaMQKrGIJrmdiaJ4oF3aII3UtIjskGwzS49CL2mFN/feZqKyTL/DExytBYdyp9rwyHJ+2Xt2tqaDHd6Mctohbr4boIPnzjrB2jVa/fUWDjoaD/OR358gC0mikaXmKscIl7/hKMIJAEMcWnB7OACXqlsl9o3zy+UNhCe5IVnWx+UUnw6w6t7u3qW4UgRYyIEVQ7uAxI358NVGREAaHROPjed6HSiYvyPN7KO51Fi9P5Cu1JtMOEr1JZD18ZM9K8UaW/6lQ3ko54
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(2906002)(5660300002)(8676002)(4326008)(316002)(6916009)(54906003)(70206006)(70586007)(8936002)(36756003)(86362001)(82740400003)(7636003)(356005)(478600001)(7696005)(6666004)(47076005)(83380400001)(26005)(107886003)(1076003)(426003)(36860700001)(2616005)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:32.5683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94fdbd3-04e5-4569-dc02-08dc09e322df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
Received-SPF: softfail client-ip=40.107.220.81;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Hi,

This series contains misc cleanups and fixes in migration code that I
noticed while going over the code.

Thanks.

Avihai Horon (11):
  migration: Remove migrate_max_downtime() declaration
  migration: Remove nulling of hostname in migrate_init()
  migration: Refactor migration_incoming_setup()
  migration: Remove errp parameter in migration_fd_process_incoming()
  migration/multifd: Fix error message in multifd_recv_initial_packet()
  migration/multifd: Simplify multifd_channel_connect() if else
    statement
  migration/multifd: Fix leaking of Error in TLS error flow
  migration/multifd: Remove error_setg() in
    migration_ioc_process_incoming()
  migration: Fix migration_channel_read_peek() error path
  migration: Remove unnecessary usage of local Error
  migration/multifd: Remove unnecessary usage of local Error

 migration/migration.h |  4 +---
 migration/channel.c   |  9 ++++++---
 migration/migration.c | 27 ++++++---------------------
 migration/multifd.c   | 27 ++++++++++++---------------
 migration/rdma.c      |  6 +-----
 5 files changed, 26 insertions(+), 47 deletions(-)

-- 
2.26.3


