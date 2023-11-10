Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E27E7CE4
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 15:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1SHP-0000lB-F4; Fri, 10 Nov 2023 09:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Julia.Zhang@amd.com>)
 id 1r1MDM-00088B-GF
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:46:05 -0500
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com
 ([40.107.237.48] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Julia.Zhang@amd.com>)
 id 1r1MDH-0001UU-UD
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:46:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEk1uP0lGUnY0LLIHlJ1ADjZ6o0ZiwpkHd7ta5jZhjp7sHMNCnQHJWriS3aHuLsQQ4mPC3UpLs51nmApo2Mf5Q79njXI1JpIqCiw7nAwQKyyHxJiGIGaFMfY2PY0FpYpN3MWaoAqnCTn3rXpQ+u3JXj374XiXtZ2NyPAdMADRntgwl0JvN03x/aRAEdv7tkf8mFHfVXj/Q65kg2+/C8fe0OCCjKOGyW/je3m+6ZtJqrnAMyjV34JXUV/4yHgXf5ZPBpkzUS5opLp5n7EUBhghVHP72lGw8qQ8bftnZ3DCDtYrZz4htJjP9DxNfakc79mZ/MOEdpWYC9g1Z/7I7+Lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGDzmHa8OEhPPEAOSIU8ytz1xQ9bIs6QVntjhfnDetA=;
 b=DEu05q+L0WishkyqEsBH0flQ8RHXq0b+QWr+UWnoMBkPps9Tz5sesmCfSEEf0EYnjflePehq+kSFLmRpoACEkvC/yj5ifcua+YughF5TOkVrwTNvZLZf01dRVRRd+nLn3opa7OjxXOtaqkrGz62ELiNf0nk1VwMZnMCM/VaHWQIWca3qCEcwTi9fd298MvtWWi39yDdCUyR7tB3mUJ3HyCfnXfKJNnsRC3PTrXJN/5Qes4o/fxeWmQ74XDrV4Wue/bQR7vGmjzuKfqhEh0ZoDdPpDxE3OzL2ME1FQ3DHI3AhNy1qWThc9d+0HSiCF0439abNrCWPHugCVSlyeobuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGDzmHa8OEhPPEAOSIU8ytz1xQ9bIs6QVntjhfnDetA=;
 b=GzHH0LuM77hF/Y1r2BUH7YVPhPP+/SGvIjIT6oe7yunKMSZ/KoEjZtFPoJGdoH7GZ+cF23YU5imfah2tCodvmmA4+a6p88ihslKaucRrToqRVCAukeDIP5wDSAIIzP5tTIAOyPMBhUBi2or2i0gYdppz7RQ8eWe6bcwlY+zQrQc=
Received: from CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::8)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 07:40:51 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::c5) by CH0P221CA0019.outlook.office365.com
 (2603:10b6:610:11c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 07:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 07:40:50 +0000
Received: from jenkins-julia.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 01:40:45 -0600
From: Julia Zhang <julia.zhang@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>,
 <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Honglei Huang" <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 "Chen Jiqian" <Jiqian.Chen@amd.com>
Subject: [PATCH 0/2] Implementation of resource_query_layout
Date: Fri, 10 Nov 2023 15:40:25 +0800
Message-ID: <20231110074027.24862-1-julia.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 377251bb-2983-450b-f774-08dbe1c05ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+UJh3S3TLAzTDuY0M1zTsltAxWWlwtX5Iieds/pDAqDc2hooF9CLIXb4hK+WEarYRP1aStxTCHUbyCypEbLX3x+V19jQpLwLSzyH0MMu6KZcpmi5SP90LRqf1dAUSUQI4/Mo0KPr8/Mqd+VHxLWYqdfLodDhN/RNbex4FiOLj0jHcHx0h9SKxhrHrFUou8zckP0LTiqoRIutdaOYsh6SSYo1t+nO0IqPT2/e4ylK26+GALWKD72K95cRzFqHJJuiTW5UmtnRsu0/BIUeYIsdVAtoj0a8Q4dwsVyWa4G8rBTlrNQokQVX1hJIBEx7NyPCATZdsT4kBrR/Txm/oBrqBI1Hun8yQAH6QUnQzJ3vkmDeepzTQJiAV/TXfkF8Ftnnqzws8dYweueCIkqNch0rNqLvOyhru+5G6/npy9Vvf7H1IetKdKeOtEvfyOKBTpgwEqJDPW11bvB9f++HrB+qGwgBl6dr1TV53uXy0GaicMYl2al0V2JcDJHDQTGQiGdLLhpQ2cYzeKlc7EOSJ4MGac0RFia6wa9HzA/wjMFRn5gzbn/7qMGhxwMTzhKuMO/vTWQrQTO2QpiGtmTBJIYfGygzhvmqjRsuAnrWlnZBF7zJGKYG6O9CL+auWOCgTuAJcDTRDSa5wKq44J2q0TyH6yaHsqPnYDEqZrYkovoYeNfvlj0DxTvMzJZgnEBCRmobKjD5ojIOMVX+JrJK7ESZUDkklhpXIp90BZvRKeiXq/Wc34a9PQ5AnYbrnQ/dMOzCTLw3tJryShEP7dxB98N8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(356005)(81166007)(40460700003)(82740400003)(70206006)(6666004)(110136005)(478600001)(7696005)(36756003)(86362001)(70586007)(26005)(1076003)(16526019)(2616005)(426003)(7416002)(336012)(8936002)(2906002)(41300700001)(47076005)(54906003)(4326008)(4744005)(5660300002)(8676002)(316002)(36860700001)(44832011)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 07:40:50.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377251bb-2983-450b-f774-08dbe1c05ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
Received-SPF: softfail client-ip=40.107.237.48;
 envelope-from=Julia.Zhang@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Nov 2023 09:14:31 -0500
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

This add implementation of resource_query_layout to get the information of
how the host has actually allocated the buffer. This function is now used
to query the stride for guest linear resource for dGPU prime on guest VMs.

Related mesa mr: https:
//gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23896
virglrenderer mr: https:
//gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1268

Daniel Stone (1):
  virgl: Implement resource_query_layout

Julia Zhang (1):
  virgl: Modify resource_query_layout

 hw/display/virtio-gpu-base.c                |  4 +++
 hw/display/virtio-gpu-virgl.c               | 35 +++++++++++++++++++++
 include/hw/virtio/virtio-gpu-bswap.h        |  7 +++++
 include/standard-headers/linux/virtio_gpu.h | 29 +++++++++++++++++
 meson.build                                 |  4 +++
 5 files changed, 79 insertions(+)

-- 
2.34.1


