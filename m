Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E520A758FA9
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM20H-0004KL-2W; Wed, 19 Jul 2023 03:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1qM1zy-0004Jw-5c
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:53:26 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1qM1zu-0003AX-0j
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnsHFoBwbuvIInDPegzUJ4OHYiZdMcVUsBQtsBEN44xI1Gd28z+H0b3IGM0Vfh/hOko6UQu3mQC6gChalYYxsxd29Gl8jE7itfaK/ad+yxS7/qWGc2d7tP2VsGJ9pn+8yzVM96TD80p7J4TkFSEgKlWK83NvslaCE6jhy+KPUNzDt8SFKk/9v17fAKc0FjPL07gAoyHueYEH53PRVvXesKFoNGfYbPIOQ3l9M6vXIcDU2vpWN86ch9Bzrhd9W+T/j++QLAL0IGOe9St/n4XeKKkPspbnGkFl4G8bqmbcwqJ6WNDfszw72jrySxUlgRjjg2TRJtwYNhvK3NKd0gFDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7zgi8Bt9cY/BXVe0Fdk4OXXzcNBsCIpdX5aoRfuoIM=;
 b=O0H1rKyWaOyrOzc9UxJR+V/URyJCTLUsgLMbCYYg6/dGMvgg3Sf6c33usM5T//0xwNYpVaRRr6fYBp79o2RmuxhyJ3Dw3y5SPfVN5NK5i21IDi63PsXPKGfavaMOS80B42HxUpCwk2ebVQcxPans84gn8agWtn+TEgREmDkx5G1zILllft31WaYcnDHHNSOZ831y/zl3GV6HP+OUfR2YEnptUPP4bsSf2EPc1PUcXI6xWeVEdKeYocutS0WM8qF8851v21WDE86EJltdDVuTIMQMIk40cZjySEGItvNWHJyBhQFdKgDhtGN9n/bnHrYQ6bv+Xqqhj4KFNdWzlKjVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7zgi8Bt9cY/BXVe0Fdk4OXXzcNBsCIpdX5aoRfuoIM=;
 b=T+Ln31+AohLUDyOQK7QuOIKmgd+E8xjThpSoGWn+yipTLbeiHFjY1AkwHORaaAL5YaqpLwPh56EB1Ony2OdrryI0v2+bJ7yPsIFhdr77zkqeVAjCuVLECtrat0xWNzsvpQbYjo8XP0yTKCzJv2nTfoQpzkiej8jRJDIsQMUx4bk=
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 07:48:14 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::6) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 07:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 07:48:14 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 02:48:08 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Robert
 Beckett" <bob.beckett@collabora.com>, <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, Stewart Hildebrand
 <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v3 0/1] S3 support
Date: Wed, 19 Jul 2023 15:47:25 +0800
Message-ID: <20230719074726.1613088-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 600726fa-98aa-45a8-9c5b-08db882c8235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCMM/3zVKpIRkTmXC79h4uY1TCnAgrZL60cmgfIdnQQTMdzXrdeKsTZ/GxH7M7WhcedbVyXCE7/kypc9e46iQxMXIc73IUfWYp/4MiL8x+uDAcVNxv399/m1IwWfie+cRlkNCGV2I9SVLN7JMjoGx0LjVu/nv+PV/HfHBKeQz5/l8x1WLCtRyCOfwYqvkw2vZvQ8m7WIX5z9GsF30Db6o/dmpAuxGrMSZqjSuqjNFtqaL8cZ1qpHg9wHNULHcmjs3GpUGtUrLiSEZl0uDOOFJMn1eAybfwMqFmg9SoiWaYJX4VsvCJE2SEKcHMK6R9xsS0Qx36TaCPn9UMe6LMXKQ2weju1iC6w6qFRbh+NwXXzkV80TUiYIwA6YwhuLp2w+Y6aRC3TOtETreMB8LJ7oJu4kL2iCnODap5mK2nscsoO58ymfOkJ/K/yyKsuadAxRMe6bx82uPD5UJu7ZOFa0oRY6b6qk4pCIf4gryES4sF0BWqPyKS4bpAekgquxUoiDRzPaDs0q3+xBSUt1Wl6+Dsa65hR5qwtExCk4mtd0vIX/VC1UxkxIQhXlNjOaMtFp+gUXZwLGn+rv1U3R+S4133oLVMUIyiKzBb3I5XautCzWBv+w1y+Hhj1t53df04yBgXOeJ6KkgkWff+hHVdYMQOPnMcaCnXxVYlcFolrakqS70Xhi1P+L07iIRvAqP5EM6py9nWmxCxn9V/uRgh0m6BtOXj5zSkPxA8UYIS20qAzlUb1NWh9r3762jKfLmOvQqUXmgiu8dapT2fKzSSKrfAW/agxdyNxsp9DDrctontA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(7696005)(1076003)(26005)(966005)(40460700003)(36860700001)(47076005)(83380400001)(336012)(86362001)(426003)(2616005)(16526019)(82740400003)(186003)(81166007)(356005)(36756003)(54906003)(110136005)(478600001)(40480700001)(41300700001)(5660300002)(70586007)(4326008)(70206006)(7416002)(8676002)(316002)(8936002)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:48:14.5984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600726fa-98aa-45a8-9c5b-08db882c8235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
Received-SPF: softfail client-ip=40.107.93.85;
 envelope-from=Jiqian.Chen@amd.com;
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

v3:
Hi all,
Thanks for Michael S. Tsirkin's advice. V3 makes below changes:
* Remove changes in file include/standard-headers/linux/virtio_gpu.h
  I am not supposed to edit this file and it will be imported after
  the patches of linux kernel was merged.

Best regards,
Jiqian Chen.

v2:
link,
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t

Hi all,
Thanks to Marc-André Lureau, Robert Beckett and Gerd Hoffmann for
their advice and guidance. V2 makes below changes:

* Change VIRTIO_CPU_CMD_STATUS_FREEZING to 0x0400 (<0x1000)
* Add virtio_gpu_device_unrealize to destroy resources to solve
  potential memory leak problem. This also needs hot-plug support.
* Add a new feature flag VIRTIO_GPU_F_FREEZING, so that guest and
  host can negotiate whenever freezing is supported or not.

v1:
link,
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/

Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest who enables virtgpu, and then
run "echo mem > /sys/power/state" to suspend guest. And run
"sudo xl trigger <guest id> s3resume" to resume guest. We can find that
the guest kernel comes back, but the display doesn't. It just shown a
black screen.

Through reading codes, I founded that when guest was during suspending,
it called into Qemu to call virtio_gpu_gl_reset. In virtio_gpu_gl_reset,
it destroyed all resources and reset renderer. This made the display
gone after guest resumed.

I think we should keep resources or prevent they being destroyed when
guest is suspending. So, I add a new status named freezing to virtgpu,
and add a new ctrl message VIRTIO_GPU_CMD_STATUS_FREEZING to get
notification from guest. If freezing is set to true, and then Qemu will
realize that guest is suspending, it will not destroy resources and will
not reset renderer. If freezing is set to false, Qemu will do its origin
actions, and has no other impaction.

And now, display can come back and applications can continue their
status after guest resumes.

Jiqian Chen (1):
  virtgpu: do not destroy resources when guest suspend

 hw/display/virtio-gpu-base.c   |  3 ++
 hw/display/virtio-gpu-gl.c     |  9 +++++-
 hw/display/virtio-gpu-virgl.c  |  7 +++++
 hw/display/virtio-gpu.c        | 52 ++++++++++++++++++++++++++++++++--
 hw/virtio/virtio.c             |  3 ++
 include/hw/virtio/virtio-gpu.h |  6 ++++
 6 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.34.1


