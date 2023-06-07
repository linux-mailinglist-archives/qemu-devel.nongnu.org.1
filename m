Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0252725233
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 04:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6jFb-00010n-Q8; Tue, 06 Jun 2023 22:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFX-000101-VD
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:15 -0400
Received: from mail-dm3nam02on20619.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::619]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFU-00029g-RG
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBAK5WwNu7F6XIeVWzyIcIe9MckbWGJo29oKnF2nMGuptfVH0/Z6g0YvMZ1awpbduXuukW1NRt8Zch3ykqMk/sbCxFQwajMgtGYj+W7rsWhPUIk6j58Re/DI1fF9Ay8958uxWjHe6qC3faQJH40b7h8D1CbLwRk/fhKcc+LLFg9fOfSr6Ud/R3aXscXd1FIIXIMhfx8xEh6ZfS9mVjUrvlAsnQVyH35xPQgUhWeb6i4xKgoWIbcl4RPFUUXMlg9F6SnXmg/G67eRWeed+jOp/Ll0w5oN3NRXvz7sMqIMTGqA4ekHETOynIGeIY5pEj3nQcHYG5qHgi6F4NtT9UEiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3lWz8INAjGJKDKpj9tdUng8pcT38myJDNXnG7l8GpA=;
 b=Csavjx6M+6Hey4+hkfib84+yiqpUmAecConiIO1oWTkbXUequegvJ8jwMDdl9Q45ugYYppU+RugNUqnSJINT7828g5ns5CSCkEb1G0mZ9P0WQSLt9FNuMWc846COH8nuTddtkSIOUVrZbTXL2Byf/pBww+U5T0DyGcbRIiOAp0lvFMvqI1bNGjAZV3mo4anBKJDXq4iimkNU2Y4EWgtY39w6QU3eBIGL6YJtpBkktwPkTsvFJH4x3y9pV+c88gUmLJbCG2xPB/fCsswQW6iLW3ETrfH5IB5iC/amDuLKtCMs2bLqBTXNZT7bvCMRYgXskjWCbVtb6RL9fQUjBbbpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3lWz8INAjGJKDKpj9tdUng8pcT38myJDNXnG7l8GpA=;
 b=Mu+LZoEStDADp4FYni9GEctFPDAx2wNGI35XWS6wmWM5Jj6riqGTUJ/Asvtm6gwQ8/AZ1ayuMwO3QC8ELNmLAVmD8VEESRusn8CWI+70XAoSbCo/G3hw1Zin9rrLfEZ37NDpA+P8RRV4IaM2+jsp7XpAJ+27UwIGCmpM2WjFYSk=
Received: from BN0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:408:e5::20)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Wed, 7 Jun
 2023 02:50:08 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::87) by BN0PR02CA0045.outlook.office365.com
 (2603:10b6:408:e5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 02:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 02:50:07 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 21:50:05 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 3/3] pc: q35: Bump max_cpus to 1024
Date: Tue, 6 Jun 2023 21:49:39 -0500
Message-ID: <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c9ec38-5f5c-4671-cee3-08db6701e721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6adu+05ciZIjfAmkdIIzQYqqibRy3jee2DXRa3fIrJwu4h+0JrZ4H1chzNtRcd0yE82sn0YnadXwUU3SsFzRp1ndO1M80lhSEqe4pjXxwUsQ4hElNjg94Z69I+b10vS7KmN5K4qwvBenDF1LaHXnOeVFoFkLjczXcJYlcupGfXtaz35an7Al+n1QbDG2fYHlMOLR+zjPNM3bxnDfid0jEgj7AK7PwrMCtKA5/tf4K+dCtfh2DjtJgs/LeXOv+ff/GQkPUV+UyHKJPpJ4pp9ttqCAYhGMhugVHaS13uY9XgGwdpixj9CquGZ9yYVOs+ScVAMxba8K2gsVP0e8ZmY1y1luvVil76kuQN6Mc5iU+fNryf9rlutxpImu79Fmc3Enh8OjFpgPDtTnuyYu9aspHJQWevcE3sE0+++cTrV4zREemgwi037v3WdhV2XSUmnED0LcKJAV6ukgzZp7iOSAEXu7xuFfgp//KzUFmE7mtLrOSEw0FLGbQq0Q36Y0HW/ScRN+dEktU83nOUP/eEi39m660RerHAjkflhGquf5JY9l2F96TuM+QqBq7qjeFPTCXf+vc5HbHrdgnl1dYnF4T03K5Qa8JQI1mMCGahZ2HvArGT83+BmxTkBKkFCJoOMJN6qVTETnaVfdvj78DhefA8Y6BsnQDxGJOtsdrJ7DWfF7GB3AWAsIZxZMq327PY7GEEX0UVekgGQJpW8PLyPYhvxvW2S3MNDcenwks+YJh0HnaxDnXAKgYrVznThdGk9DxmzsP0Z5Djp9CR/O3lPQEeZ2aBNAR4Popg/L5YPZd2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(7696005)(478600001)(316002)(70586007)(6666004)(70206006)(82310400005)(6916009)(4326008)(41300700001)(54906003)(86362001)(40460700003)(16526019)(47076005)(44832011)(36860700001)(186003)(40480700001)(7416002)(5660300002)(2906002)(81166007)(8936002)(1076003)(83380400001)(2616005)(82740400003)(8676002)(336012)(356005)(426003)(26005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 02:50:07.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c9ec38-5f5c-4671-cee3-08db6701e721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
Received-SPF: softfail client-ip=2a01:111:f400:7e83::619;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Also, keep max_cpus at 288 for machine version 8.0 and older.

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 371cca7484..63866a16e0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -360,12 +360,12 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
+    m->max_cpus = 1024;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
-    m->max_cpus = 288;
 }
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
@@ -388,6 +388,7 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
 
     /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
+    m->max_cpus = 288;
 }
 
 DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
-- 
2.34.1


