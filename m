Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A5789226
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 00:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZflJ-0000Oo-N6; Fri, 25 Aug 2023 18:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qZflH-0000Ni-Nt
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 18:58:39 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com
 ([40.107.243.71] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qZflF-0005OK-FC
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 18:58:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKmtEjrHgXMwSHlbugJWT6mCEu0fLIamfVOhuY7D6nJqRAJYk38b1IRKAaGrTibz9ZRSONYsSmsJGIRTbleLjTAOVXK/wp+gPV8rIWlaEEd+1JK0T++RgOUQHwNTyJx7O/x6SMDmgmDuCgMjRh2QtEcFaSNeXNvNSdJt0vtyhfseftowvYK3gESVQkbmK8GUNrlzB/QG6P0aUQNBpFPMbLMenidL/YkxDgR0nfCEedaJtkzqc6rOVbwyISYA8Ie08UZaPo4PjFYIufy75Jj/9/G+14t4bQuYZThncyVyy9BjG8Vbwu/e4JMuuv7ugaRDcMX7X8nx2qWYpQM0sdRhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHarWtYamZUCKYDUeYdKebrfcskoZ3Bqx6R7kMzWlXM=;
 b=gqyw4I2ZppsgIcVSUqoZfhcrzU71Gsuxpkr0JqpXO2dmLlrkF4I7WP2QrKE6rLl2ZKLpHAeGQPriwTxhUC1UlPqOt3Fheg2VjqNxv9rpJaeSREjAR8YM1RtKJofmASROW92d2klFWzaIxWXgHQyTlMvC6PMyZbcqIpv49iQxCIAvaAG24Cs27iELRGNk2t1Z1isDZD/hHlX3LkRHlnGezOX1egYZ29aW9ZUBbxYrBhJRXa6w5Nlg2LO4K16z2d047CiWl8qo8CILtoIjk8ZtGeNxiLnNhCMCmqLtSrnTEm0gxC1szXj0wDDcgubfQcHqTZzrv4DfizfHsdoOhnXrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHarWtYamZUCKYDUeYdKebrfcskoZ3Bqx6R7kMzWlXM=;
 b=DhqGK9T+L4+aQ9kjg18QGa4s/aN+lrQOTp3S6jbiQChozZ3D66sl8T550axA1PDP0l3mbjpAG8O08A9VKK5DuD8SrMNr9COWM0TugXPfh/fUpizbOeiB+viDwpzAEvvRprHmoGLiu01DBIbnwpUzht5m+TJuds8ZbgNGNEAevKg=
Received: from PH8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:510:2d2::10)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.32; Fri, 25 Aug
 2023 22:53:30 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::4b) by PH8PR15CA0007.outlook.office365.com
 (2603:10b6:510:2d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 22:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 22:53:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 17:53:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 15:53:29 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 17:53:28 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v3 0/2] Add Virtio support to Xenpvh machine for arm
Date: Fri, 25 Aug 2023 15:53:24 -0700
Message-ID: <20230825225326.9438-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: a092de58-162a-4045-0844-08dba5be19c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGo9he9MEVmMYLWFmx1oRuIxTmikElS1Sbm5JgwCNWGKAxL7iXDnNUSnDsYv1mXN2hmI7EZFkwoTfSe6Es2/hyF6W46SDiz4WTcEMd74OVpSDm9l0fRZduZFTdgVu6AtgXEeeC2ylawh1TG0WGPYgGBXOu7/0/d4TNEYk/9FREqnO1MjQ+8l4dK6XHN3u0CyJchsM6+ONqRCjFsXWC3803xxVQyKiFS7//5YIvyvbGwk9mOVH14DR/wD1JoQJFyFOl95qxRp7VoJQJOm1XoMUjFuw5JV1ZRN0dwiAVE95tYP3DTtBdcUG/wxuEvu5jJ5VRN2Qoc7O0H7TSckLfTlO9wQSq58E5MkY8TlshgA/zU63jeQvXW4GfYx8hsKlRmozpUgBG7RJgdOeBxdCfllfJqUSLRJKPZkbV094DDXoQaxRJl9lUuaarAsxHpghLpMP9WLWVVhI0re3EQZ6QPmSFV+fMkxSUcR/kWBXC54DHe+uwRzWmSjAq7mSsnkDhZczDcwbYK9ZBUUVe3o+D4skBwkQYzckpHbXkZZ8hZpFQjzCEM/enAVDiokqvcOwCpR0tRidxiyUltofK8zx1y4A8r2/mFkfKv3fhZe+yA7GU0FfxIYocQDDn7sbt1MkD+q5A//iIzbZM7MBaJldoCfqMvh7pefAKAlHbDG2Y0AdUx1ZGDFEs/v57Uu8BwWnCp5WrbAtsUyu9ZgSGiAJZyQlLwhuo7/f2b+tEzIXBV3+jcuphazO8jvpfLPFEYUZw9Nj7SNIDbrVKID/1PNCWFP+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(5660300002)(8676002)(8936002)(4326008)(2616005)(40480700001)(26005)(6916009)(4744005)(316002)(41300700001)(2906002)(70586007)(54906003)(70206006)(1076003)(44832011)(478600001)(6666004)(40460700003)(47076005)(36756003)(36860700001)(83380400001)(426003)(336012)(81166007)(86362001)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 22:53:29.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a092de58-162a-4045-0844-08dba5be19c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
Received-SPF: softfail client-ip=40.107.243.71;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Hi,
We added virtio-mmio support in xenpvh machine. Now, it can support upto
10 virtio mmio.

Changelog:
    v2->v3:
        Define GUEST_VIRTIO_*, GUEST_RAM* and xendevicemodel_set_irq() manually
        for old xen version. This was done to avoid build failures in gitlab-ci
    v1->v2:
        Add reference for VIRTIO_MMIO_DEV_SIZE.
        Update ram_size=0 print statement.

Oleksandr Tyshchenko (2):
  xen_arm: Create virtio-mmio devices during initialization
  xen_arm: Initialize RAM and add hi/low memory regions

 hw/arm/xen_arm.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

-- 
2.17.1


