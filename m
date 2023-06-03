Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F23720D9D
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5HwW-0006B5-Hh; Fri, 02 Jun 2023 23:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q5HwV-0006Al-F9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:28:39 -0400
Received: from mail-bn1nam02on2055.outbound.protection.outlook.com
 ([40.107.212.55] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q5HwT-0004BA-OU
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:28:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCtAopJMv9bUE5GRPZOl10CaUxaM5nPVs+EvD39iITPmkspxrept+omXdyYZ6F/n5sH3Ul4HgVTWsjbROW1Z9sYl9QOPQkEIDmxrdl/kqo+QjY4nyynb339exJlpcs+SLBQkYAPn4W59b/1fdHWtKhc0Sa0UkS+UHmSNLP4UXXVIXUTMdIo5L33rKUPX/2hQ2P68PypG4oDlO33yxFGoq95ApWlYzMvToQur/mnG6YWbUcfjgsshXT4SyRpIspg+kp58w1IQ+6LBtgrsv7hBY+TLKbEGrKKA/VMuXsIDMZgjcqAWw0WCBdChDXv8JPSCoonyXvts2gWufPITiVIKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AUH5ZzbbZrnJLCPeVg0EBQY4hBBai9hokh+P52e6iQ=;
 b=LqiJo3uHQykw4i3d8OoIq5SXzwYxsqbrOC9MG0b/NebN1J3PFMZHRxeJcHlM5VyYqKi0CAzeALCNMNH3aCDjSMlZ4cPAZGKV9tENMRuQQHxYH2NZIV+J2yBrEZwI5+uxxtM9lETCkLDe/h9zxZ9D5nnCrVwrGHIcYn1BXxE+kbXYUZrMr7eN2ljv51yF9U7IRcsn384Tc5jaFxY/PvK5mWytlErDZdlT/j8LhUP0uZDri7tDQuKpddnZ8oVf4g2nxKYuuqA5PGvpEfExP40EA4KuBpBWe3nDWo+LtDx9EhWWuyxHXcqY9Ip6rQ3wgbmktuOkp52L1UC4bM2XNcscFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUH5ZzbbZrnJLCPeVg0EBQY4hBBai9hokh+P52e6iQ=;
 b=R2yZTNxBeY9y0M6xzH8tbwWT3TrSIkJA7JoBy3RFh3dgpZTzDhfNulzI7rYBFV94F+3nIMaTim6JbrMBmYqV1zvAwDIfPgqjQrIuMvReS4gFnIvm3XpMgjQRWm/5nYkRpQTU3FssVeZxhpHmg2D4mulFjJL4yQC/oPPbjIW83/s=
Received: from MW4PR03CA0096.namprd03.prod.outlook.com (2603:10b6:303:b7::11)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Sat, 3 Jun
 2023 03:23:29 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::7f) by MW4PR03CA0096.outlook.office365.com
 (2603:10b6:303:b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 03:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Sat, 3 Jun 2023 03:23:28 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 22:23:27 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 2/2] pc: q35: Bump max_cpus to 1024
Date: Fri, 2 Jun 2023 22:22:55 -0500
Message-ID: <20230603032255.517970-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
References: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: fc441dd2-7fc8-449a-e0a7-08db63e1e698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1g20r1WWviOw00tcxHiVQVvl1zr/Xfs4cq+84v5jMzgMSYyAAvnCD+ct3ZK9mF1ZmWF4LzAL8b4NPoO+VEaS1pCA/B1L2nLZ1Ck4HsNtrXqYzmJOV/siDYcGiyaGNWFVw4gsSlQSGR5jAzz24/DPHxW+y5xbotDUflolBo3yX48cRjhwPK1Z5uAlGA4hoy48SWpnJ2Zs3W1F41qtUt7iRV96AN/EYaQzccZJQg7h0gKZGEPn4IKU4aYt0PbZlT7tXj0jHy8NG7CyP1ugKhjdB1KPWZ23NQmcOSFUb5L4BThk+QCPNufxyaSWrHKOkFKlT9dcVyDIQ0b658WEBergo2EWCgbsXxQ32Sy9emYUYQ0dWB8puqX68ZIifuC3+a9GQnR/LGpmjQ1beSCcXN7UiaRaFnhfE0OAw9srRWik0OzoHTP5Lz2cPH8NmxwlhcEVv1Gv+pm3RFUATruJx56ENDDunKeMUdxnBuD/JgNKR7L+oIbNTUtMt52vNGqIlvaBTpsL/+Zc2z423QNeh5jSDdnZzLLUbz9XctDvO/HdgNEd3iP3WS/Y9tH7Oc/Rz+2TZtVZ5Z0NIyEHjq5UTJFR3lUgr+LMQQzrICx7y2jV3iNk+phIr/MBCPmGdq5c0bSgkLso7+wba7+YrU6csNY25fSRj/T8yAxLmIb0hqTWYUSIqmWD3P5e57VupdjhEBP9MlwSxIqxrQdZen1lYekgiVYRJZqO1XfN/T03X/JzaAH9MrarDT2bAT56XjZ2YnH6h/R8jda6RJJjryK0KB340j49ebddj6ZYQ3sZYAC/64=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(478600001)(54906003)(70206006)(70586007)(2616005)(426003)(336012)(83380400001)(40480700001)(47076005)(40460700003)(36756003)(36860700001)(2906002)(82310400005)(186003)(1076003)(26005)(7696005)(16526019)(81166007)(86362001)(41300700001)(356005)(6916009)(316002)(4326008)(82740400003)(8936002)(8676002)(5660300002)(7416002)(44832011)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 03:23:28.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc441dd2-7fc8-449a-e0a7-08db63e1e698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
Received-SPF: softfail client-ip=40.107.212.55;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 2d1bb5fde5..2124ada58d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -382,7 +382,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
-    m->max_cpus = 288;
+    m->max_cpus = 1024;
 }
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
-- 
2.34.1


