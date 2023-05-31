Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C1718EDE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UkU-0000SH-NZ; Wed, 31 May 2023 18:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q4UkR-0000S4-Jd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:56:55 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com
 ([40.107.92.57] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q4UkO-0002WZ-NK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8DxdIW1PvR0lQespdVGhIe/mYGjaYnY3S773kE4wN4GPkHtbelfXhbnxeMyFbjRPAuewg0iyyOr+g4ZdNlT85By7aQTCk4SMZcAI/6jNVVQUb2NbAyS723zOgs+BO2/6zsFjahOkARdZlIMBTjOL8aNmx9Iq6nf9MhQjAKMrM1agj3o3myVhV3339IpblooERtSCn2APa16qZs8arSWNrgJq05V/WcZZQraKUBbNsMEfvPw6YTqqCNPGYzcQSasIEoisAFN0TFP/THvKD1WEPLgXLDdYvVUZdtUWMVi8R3rKc519MY0pPgKh9HYuzAc7acZ8UEXShYejpHUomelfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB9MuZ7mpRs1iYdODKU8769cnIjteqquYJ18Y0ZOu8o=;
 b=VLSf5+ILlHXNREqP3lmGrXUIPVonWftx6+CxPUiXV1Jb9h1xVJ+Kkd3OWSq9ZY6JWtC0RxQq9a8dd5RgsAFP4fSKU40KByBpe0TxwufeUg1JiUa6wWHgcacHyDk1mAC335tprWbecDX99QOLQglSOIHAjdhOYSm9rGABnXqZ/wwlN5udaVNrcT3eM4sGGK1YDzNAltfJ3484oWGf4tIyYcvosQQhpKuZFVH9fYTMhdWEhDloAUnoD7v2qikZHhHtr54BBdxwDKyc+NKNpw0q0oNFDpUX9nG+fY8NG4b7QGEGB51GFQ3DiL7zMnqY82iqfA9C2A5redpM3xTb1tOR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB9MuZ7mpRs1iYdODKU8769cnIjteqquYJ18Y0ZOu8o=;
 b=CJ+6WUTXoCRY8aOeh+SYtVJaK69cuMMpzp320kqGAbUGOFU2+RXowCm/gCkIymqTDHYpQIwtiBu4Xz6QGYq6lrUXReMqx5wPJk5vt0JfY03kSaq4wWTMKyemQUMNYV1H+i5gWENaYOK82VpuJRoUUPoPxrcuUHCuZ49gUGYkYzU=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 22:51:42 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::67) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 22:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 22:51:41 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 17:51:39 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <jon.grimm@amd.com>, <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2] pc: q35: Bump max_cpus to 1024
Date: Wed, 31 May 2023 17:51:27 -0500
Message-ID: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fc8430-8048-4e78-b870-08db62299982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHkS1UboVgsKbmmdqtfnCgj66sXLw9ZDl1kpwqEpIYfglUvgkuHM98AnbHMCiZNMyWU876RMmSgcPa3qRh1EBVRTM0X9ioHgj6AMO7ic5En88J8Off1wZctjA45VXDwfhWFTr0+d4muDBssE8zu9JDTqwP4dCTxrTRLdss2//kZb5Z2zTMjrD5O6BxVotFstDdfXWSazYHdqZrudb8Wdf9WufdmQRTislndSL9XXKiInh874NStqg4QalvbKNUwj4ltzmcXc79qj1I1nC2KxGVG+ZpbDdnAu4KWQm1S4tCI/aeE/syu5A+V1Myda6PfukEicC/qcXTG/wW9HqDA7KRhkNW2iDfMjd2xXwP7x07jVSbfBdyX2wKEmboo5uWiihbL5aLSJWh++W8iC51m0xPrk60X0KAaAm8A0HKs5P6qhwYvczww6ZuEWdeiEtQeIbp2Wt11oT+YRrNxeeoVLzvO+c3CXSKr31JSAX0kCeoeSQObGWhBH2SE9jZQPE2L2irHnOSJSIrMf+WOKhWAWX2S+g9Ujq47VhMCEM5A5NLl42HCNg6ZXlPchj8ZvR+kpxc955NYBGrva6+OxmK6kun8L488mfqnrj/7y3BN646Av/RtlVUOpTZUZQ0V0hZvVX9H+v/yWmPMTBrqBHGofCE9yyIddV0JhEvDV5V42g+XJpkv5uNhIU3mu174pTfWpoABLcRv6ft01npUhAXrV/abZbWfDNTPbagn3UC3xcFSK59gBsedU2dFVv7sMbWGqJamEj3ij+RXw8GuucCmDjOf58rK0YPCfJzACvmwf9Jc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(6916009)(70586007)(70206006)(40480700001)(6666004)(426003)(336012)(2616005)(4326008)(82310400005)(316002)(86362001)(2906002)(44832011)(26005)(1076003)(83380400001)(82740400003)(5660300002)(81166007)(54906003)(7696005)(356005)(41300700001)(40460700003)(47076005)(8676002)(8936002)(478600001)(16526019)(36860700001)(186003)(36756003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:51:41.1406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fc8430-8048-4e78-b870-08db62299982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
Received-SPF: softfail client-ip=40.107.92.57;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.

In case KVM could not support the specified number of vcpus, QEMU would
return the following error message:

  qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---

Changes from V1:
(https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
 * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)

Note:
 From the last discussion, Daniel mentioned that SMBIO 2.1 tables might
 cause overflow at approx 720 CPUs, and it might require using the
 SMBIO 3.0 entry point. Also, we might need to change the default for
 the x86 machine type to SMBIO 3.0. However, I do not know the status
 of this.

Thank you,
Suravee

 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f02919d92c..e7dc226bd5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -370,7 +370,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
-    m->max_cpus = 288;
+    m->max_cpus = 1024;
 }
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
-- 
2.34.1


