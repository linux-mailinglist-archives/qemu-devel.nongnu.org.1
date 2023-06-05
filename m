Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B697723266
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:40:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6HvZ-0001RH-DH; Mon, 05 Jun 2023 17:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6HvV-0001OY-EH
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:39:45 -0400
Received: from mail-dm6nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::631]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6HvT-0000AQ-Ic
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUZl/isXQc6BeTUDLwtZ1ths1TS8Ys2xeYnVeF3eIN8QHwJyRgxPEqzW7vhqsdUDjWv1/2IkPwwKukC6z5n4u/I304h9iKU0iJjWX9syTjSNY7FYf9IWEBpRSwDYWOwMIRwFYE5VCOjBc7Yir0D3Vks49+Mv4YI9oNysFbO/sayT0U0Bh3YtHqjPMrikG8izfso3C0ZFQDVk5JswEWI6/rRWPevnDU/SCJBRFGETaDuBs4jaUp4tF6+HT0qXOo0bpb9+I5LH9jSNG0QRtUA+59tDo/Hnw0a9r2PhnbD9O0yc/b5YXJwv5lvfR4Wv/Aer1dLzorsqdG1XKfcUUKdEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tZEk4XkUDXTdNP7QD013WwsPoNgnOuHeHxjZatu3A8=;
 b=Bnun8xHY++OHTPrJ1XfNyB97+GnDG5qkoLkE1IwpBOrs/cOcUSxr2dsyxOVc+82lYhRu2wpOoRwEcya2LKaH6lL+7/wnmhti1Ameyc30oBcEcdia/0E86/slS+ym1kf41AqIwIFByUegm1ItRlWvDpV6gpAVYyeCxTizOsqU2TkHsUylONLhLEcyF68AUcVI/wQW2AICuFclIJfrrU5B7ytfKPOCcmdKbvPPa0er7F4yi2JZcHafln3Fdnu9hxqZsHTY33mB26AQdQnMF9AGcl4WtPaTcdG8u4XXWHmGUgSXisz4CZRDwZHHf9AasakbdAmiXxQQpOIDhg/vDqvJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tZEk4XkUDXTdNP7QD013WwsPoNgnOuHeHxjZatu3A8=;
 b=XvjEWum8FEhSBHVRNGoPNMVgqfF2sIYQ6eB42KMZTTGFhYB5ToYeHdt9ZJC9ojrYOHNZVf4aKrlhAf211lGfW3J9kXreHrhd3VLvVPkjrvsZ1mnYladcUseE2CGc4ZlTFZNlpa4quPM2PoqiLx/JwSxuoT/GpeURRU6AnX8sTEQ=
Received: from DS0PR17CA0004.namprd17.prod.outlook.com (2603:10b6:8:191::12)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 21:39:39 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::2d) by DS0PR17CA0004.outlook.office365.com
 (2603:10b6:8:191::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 21:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 21:39:38 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 16:39:37 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 3/3] pc: q35: Bump max_cpus to 1024
Date: Mon, 5 Jun 2023 16:39:06 -0500
Message-ID: <20230605213906.644883-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8f1ce7-9768-49e3-38a4-08db660d5d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/A8MMcONOX6NSOLZdTOycDIqMXEgWcfL+pt0gAfxvZ3YgbZAoFxz6Zpy4XRCfuqKs5Abipx8LVMwCqzh0lYweJ4352uzSJzkHDFdjoT0RT+3A1PF6RprhUslW59HP4uwHEsGIEekkZG1/KBcu+CYR3zrZCLlrmWO47LwvfmlbI2jbL16glGxgdyh/pfqm9NnRRWPtDzRysdhO7o8waGtq0ACcL5aydxhOOByWaDsQXkmUi880/F6CzVxKefGsdKY3thJUkvgYfECj3GEYoM/V8NyEEY1DrtgUmcdbFPOcvtumor+tETI8MUrybuVQy9bpbScAOeI4xVZH8U0++c9YafeU+SjoDOhmkK5lJlcU5No3Jnox1DVSFtm0h25pNATgyV0OA40E/nB8FCvW+Yq0qMgNii+cq1+eJJ1k9fqpUnZ4mmE1DhXSgdSO5p6d1nRIaBRZat/XCw7+Eh6lkLumV/WM+6JGUP3JdIZv7TzJzkYEItshu5JSAHwSHYye3jN8uQqnnLy8JenBMc/R2RkjF/dEHOq7jns/TULxwNqYZR0jv2o2/3s4MNpvmkIZTjH7IQ8NdXv6Ocw5Ebrf1xns0n98Gep8bOejzuJeUjsrWnh1nQTvby1hYrpcDDLBYlR1/3n1o5HDnUYrhspGdTeNfuseOvej0ViVpTwv52gtW6tkRIURlOrSQusu+AMF7TQufiFJzQT2haHnLIAJukDvXsleFcUPWJ6ctX4dx3DZKxmjnmp4WrNLcHc/jKAqW+4dbq2//jUm+mMvM6V4cgkAETlMjwziGdQz1xYNU5ii0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(7416002)(44832011)(8676002)(5660300002)(8936002)(2906002)(316002)(70586007)(70206006)(6916009)(4326008)(41300700001)(54906003)(6666004)(7696005)(26005)(426003)(1076003)(336012)(186003)(36756003)(16526019)(2616005)(83380400001)(36860700001)(47076005)(81166007)(356005)(478600001)(82310400005)(40460700003)(82740400003)(40480700001)(86362001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 21:39:38.6365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8f1ce7-9768-49e3-38a4-08db660d5d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
Received-SPF: softfail client-ip=2a01:111:f400:fe59::631;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 371cca7484..bd862add94 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,7 +365,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
-    m->max_cpus = 288;
+    m->max_cpus = 1024;
 }
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
-- 
2.34.1


