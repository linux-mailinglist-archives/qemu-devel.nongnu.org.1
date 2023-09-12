Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E979DA9D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAn0-0001mN-Gc; Tue, 12 Sep 2023 17:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgAmw-0001lq-KS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:19:14 -0400
Received: from mail-dm3nam02on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::607]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgAmu-0004mq-2X
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMzS4FwvQ4UlaEnq3QXk31/3KnydQSkmdbkUFm3DbW+Y9QJw4DXbS91ht/5RjBknrH/kSG+Fxs/GzguYqy0VI9hdyfnxJ6ZELZKZbkPFH+IYhozlMQSlILaD9zAUHnqnvmNw9tIN1HqJ75T13ldMLqB41cYOeRa8FXBfQH0w8ZONPeodXPK16gSfemLsGW/poTvpXB7HHpPxsYTaWe4NE3kjS15lth0IN2fezCBLKgcmdo2bjTrJS+9sWbtcSk/0zPQ+XHXSeVuRA+HpQcrHG/olNRBorjdiAAUHPnacbZyVtIbpmTU3wKWvAZCtQFcTd7jVchyYdjcUPvIjO/O2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5FhHxm4HX0+cJjPJck17fhg2Z4jaxDXyW8zFH/Wa1E=;
 b=c88Np/jp600kJPR2buoOrw8jqacKkLTlxwUxlKdwseMAS4N8UXhneRdxbq42YukXWUfJrSeuBcM8X8aUxx9yrszzY7egSJSO446Wmf2oq0AMTfRYnLnihctjY17xDIWnwPqx3sEuFsXnrcapFmR723FHS0uuWnmPShK76k0zz/pEMSQtOA7QiLoXnpLlzz5+r+/VoGQTkOoKtZUHnYtq4g9NAYYlxKdQVJJXyuTyjx8v0wrQeCQYL9/fabpXlojkBQY/fFa8C5KiVL0Ow6I+t4NAZ2Ks5zFx7ckDMTScAgro0K+1ZwdFtk4iG5i5bAUoVV8eofA9HBVxfnUcFuX3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5FhHxm4HX0+cJjPJck17fhg2Z4jaxDXyW8zFH/Wa1E=;
 b=I/wv3IlYAVrOj1m9eTklow2VsO304Nl1HykZ0FpJD29k0Wlae8pMWjU07eD7WN95TEI46UcRpeBxdjPkTVvotOA039oxYLRBX0HHNtNGO/XB8IGmNYBl4SZUcDulJgSsN4ls/fiIkTpQOFiWNwpxsqPwt4+P20kojO3iqjoACro=
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 21:19:08 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a5) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 21:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 12 Sep 2023 21:19:08 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 16:19:06 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>
Subject: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE
 on AMD guest
Date: Tue, 12 Sep 2023 21:18:23 +0000
Message-ID: <20230912211824.90952-3-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912211824.90952-1-john.allen@amd.com>
References: <20230912211824.90952-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5a77ee-4d01-408e-e881-08dbb3d5e6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeYxzObG+1KaybA8tygSylHDw+ThipmrlVS2SHYrY6yaEr+i6qaHegZvbYfH1kwkU9o6ij48smdioLvCbctM3tiU4HpOUe3/FEWIUF5wmjyCH6L3T3YGp5Gk7O9C5WxDcX6nED+N+aOg0ZrNk8lgv0nSuJDZqK+Oggcr6rH3PeVCAG6fp/IxoAcDwE7pcc6+lBDAmQJ0orqour+H0CStFU6UNCZ0BtJDR99k8GARvEUWlmfEvcBuKHcXHP14gJGTCux5mN4aOb6Jh64RlYXeteNDMPULqefnL+FFIIU744YzWCweK8FWtHy7wIL4Bu+mMdJ9tJUj94EGQeIFby8LZUE88WSILDL074IWCdnwTuvowFgqVCH3vRxHDBRGrUg5GzjkWpIQRUN8HGNPv2eHsEno/qIO6YYL5FYuH2vLXhiecDfWA3GIbBjk+eQ/1T/sDF7tgA+LlRMNMxwuj3FhXceMNZqWJhomQ2867Ekih6httQtsZVwhwsnwSfLMofLOALi1XdUxZogGArjrsUXrDDi/xpVfrVP4Wum3THFQGw3+AFisWABJ91rNPQRpBL96N3VBiSecQ52GZEhqcwizJWje6rwbAADK24lob8B0A1WDvuurKrsXQgjy0ApnqyvrMU7UpHArv1khyOnCapqB8zkMZjCoc6MXvZ8jk0tW7xwy9LVH2kIzuq0llR+gxMM/5sODPZjXN52qPRkzYIHCh/MWEw28LjV15+ZG3V4HuKL6me0Ti0ddSb8rzXKN+vUee7QbMO4n8yBJLaT3hcw2tpTa3N+l9Ooi/MGTgnbs4NQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(5660300002)(70206006)(41300700001)(4326008)(8676002)(8936002)(6916009)(44832011)(316002)(54906003)(66899024)(70586007)(40460700003)(81166007)(47076005)(36756003)(478600001)(6666004)(7696005)(40480700001)(26005)(2616005)(86362001)(426003)(16526019)(1076003)(336012)(83380400001)(2906002)(82740400003)(356005)(36860700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:19:08.2126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5a77ee-4d01-408e-e881-08dbb3d5e6af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
Received-SPF: softfail client-ip=2a01:111:f400:7e83::607;
 envelope-from=John.Allen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: William Roche <william.roche@oracle.com>

AMD guests can't currently deal with BUS_MCEERR_AO MCE injection
as it panics the VM kernel. We filter this event and provide a
warning message.

Signed-off-by: William Roche <william.roche@oracle.com>
---
v3:
  - New patch
v4:
  - Remove redundant check for AO errors
---
 target/i386/kvm/kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5fce74aac5..7e9fc0cac5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -604,6 +604,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
             mcg_status |= MCG_STATUS_RIPV;
         }
     } else {
+        if (code == BUS_MCEERR_AO) {
+            /* XXX we don't support BUS_MCEERR_AO injection on AMD yet */
+            return;
+        }
         mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
     }
 
@@ -668,8 +672,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
                     addr, paddr, "BUS_MCEERR_AR");
             } else {
                  warn_report("Guest MCE Memory Error at QEMU addr %p and "
-                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
-                     addr, paddr, "BUS_MCEERR_AO");
+                     "GUEST addr 0x%" HWADDR_PRIx " of type %s %s",
+                     addr, paddr, "BUS_MCEERR_AO",
+                     IS_AMD_CPU(env) ? "ignored on AMD guest" : "injected");
             }
 
             return;
-- 
2.39.3


