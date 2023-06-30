Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F2743581
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8EH-00071f-US; Fri, 30 Jun 2023 03:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1qF8EF-00071V-AF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:07:39 -0400
Received: from mail-dm6nam04on2076.outbound.protection.outlook.com
 ([40.107.102.76] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1qF8ED-0000CY-CA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfS8eiG6A0Fc8Kglxwdq1j5nPSJaI54XPL7WpVhd+v9baktWU7MCoMJFkCkvYMRP2puc4ix0FIbBzNWmGabx9yitoCBhU7P4FVL7A2s07T0Zmdz7HZ5Q3P1lXHXL1Qvv6Z+2TPVE6vNlYmGZdg3fu7alYIKDQvHVYS7dDaUxRT2Tu1uy11U46BlmuGo0URHFKl9XXPxR7HCMuuAH/OTr5Cphlr3IYTOyHw5eXWYRASmQY4+rdJVhbV6uOgGLjzNU16cUAs2m4K/3NrXlYYoU4S0AiMtyTLIKFrncOlRYnk1BmSvGWmTuwuE9VXyuyvDoDJUMdEp7flcn2g321USVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh/tfwlmMHLATsr7SpyJya/fhOiP5HoWlhyHVvGtA8g=;
 b=PzwcrpVumvzQCYdbBw7Rn11Av7ryB1LKV428ck4x/MOKqrthQzmYZ3mzTUMO301bhBCVwcPLPvUvXBKyHYPdtO/8xnsW8QeOfiOAAKlDoUhiwh8mIwOU+3lkia75mJ/YYEKK5uPSnSwN0rZWNs4TzaBTj3R86EUIWEjZYOxFTWQn6DmuOX4sREdFpbSNXxtTkG7HRJFc2hbZBq+Jn888lztUvulm/Gd0ngAa+wO0yzP4GnuNAXt77Sqr1acSfFMrt5UrMZf1WfgGlc/Iv6sS/PXfmrZwfR8V1brU0IG+cAV1dB3f7GDyP6HA0/nJ8awkTD0mcIjMlQL5L7ejbCx/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh/tfwlmMHLATsr7SpyJya/fhOiP5HoWlhyHVvGtA8g=;
 b=cEZXSqU/VX/fYtFiRjtFiZxiVZEgpyAZp1sxAExdexUzhAL6mMOpzfVse0iPbLl2yxfqxY9vabde+cEMR4I5uoH45mHbW/+LMp0HtWTlTvdRCkk2PNbXg570pqrUlDiAPgl7aWUBNF7t/FLAFhwzzzHneyoKscJD+Zm5rDsxEpw=
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 07:02:31 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::a3) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 07:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 30 Jun 2023 07:02:30 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 02:02:10 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
 <roger.pau@citrix.com>, Jan Beulich <jbeulich@suse.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>,
 <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Christian Koenig
 <Christian.Koenig@amd.com>, Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>, Honglei Huang
 <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>, Huang Rui
 <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v2 0/1] S3 support
Date: Fri, 30 Jun 2023 15:00:15 +0800
Message-ID: <20230630070016.841459-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0ec17d-537e-4f9c-ba96-08db7937f8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIKoUZGJOnz/SVBiKCeG2/kG5XS5yH6JVgZ4dZjOFGrgAHDJoZfoqjpYGSZquufYLOagLJlf+VuSddhCqXXH7EyEz9p1KCytiTYh0P6nT08RW9mEDvCv/W35xfdckI1GPGdEOspmxvrJOBsW42GBGPjjZr4QXjE/6FUzRXFV+W0lH0yMdJg4h+Jb/e4tMraxyCqjE6JNCy72O5ZADk0TqrxmiR7DpOxjHAqC/q39sefXmkpAS7IH7VaiclKT7lNtJcC8U87OgdHbTc1nwDjO/MrfkjQBeauxF8hfTOUyhRQTEVatg4hGxxZ6PnVB196dpy5Tph70f9iUK6F97/mr1rBqATpCBPVUI1TJzOWW0TEgeGJSs/VPdrBtHZDxqO6fABpnI4812cJ4QrN2DoELkOig7iyCbbEarpXBg92sWoiCqn+EM88BS1saHkXmqvf0shhlr3IXmHCkTQwlXVGiIyjnx7XTn5N8F+RXZAMk91+Bgu4Ydu50jU6eympgxFgIhyDupvs4Tm0OFG6uFEfBuQ6uzBg41OTkMHwWzwzyGzPFkB3hOy/FTxmMUXPgTO6SRzYjYzc6eeU6gYifX1d5l8WST9ahtM6CcgiSQSqiOrr1Byv60UySghYM1aOAdPukQCnCOulGoArFDTTPSJPC38zFSmMIXxgiru5T8RkcDq5uooOZ0WK5KM2tYJL3fJ34a0YnnIkhn4Yr1d5ewWZe1fPSHDQuOzcytUXEEJe2ARrcNOXJD7GCaVkn9Vn/543Uyh0ESShxDWRLki7VwMS9dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(36860700001)(966005)(47076005)(336012)(83380400001)(478600001)(26005)(54906003)(2616005)(426003)(110136005)(7696005)(186003)(2906002)(16526019)(1076003)(356005)(86362001)(7416002)(316002)(5660300002)(921005)(70206006)(82740400003)(40460700003)(81166007)(40480700001)(70586007)(8676002)(41300700001)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 07:02:30.8308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0ec17d-537e-4f9c-ba96-08db7937f8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
Received-SPF: softfail client-ip=40.107.102.76;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

v2:

Hi all,

Thanks to Marc-André Lureau, Robert Beckett and Gerd Hoffmann for
their advice and guidance. V2 makes below changes:

* Change VIRTIO_CPU_CMD_STATUS_FREEZING to 0x0400 (<0x1000)
* Add virtio_gpu_device_unrealize to destroy resources to solve
  potential memory leak problem. This also needs hot-plug support.
* Add a new feature flag VIRTIO_GPU_F_FREEZING, so that guest and
  host can negotiate whenever freezing is supported or not.

Best regards,
Jiqian Chen.

v1:

link: https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/

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

 hw/display/virtio-gpu-base.c                |  3 ++
 hw/display/virtio-gpu-gl.c                  |  9 +++-
 hw/display/virtio-gpu-virgl.c               |  7 +++
 hw/display/virtio-gpu.c                     | 52 ++++++++++++++++++++-
 hw/virtio/virtio.c                          |  3 ++
 include/hw/virtio/virtio-gpu.h              |  6 +++
 include/standard-headers/linux/virtio_gpu.h | 15 ++++++
 7 files changed, 92 insertions(+), 3 deletions(-)

-- 
2.34.1


