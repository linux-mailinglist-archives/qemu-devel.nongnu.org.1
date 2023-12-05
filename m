Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D5804EC7
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:54:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAS71-00077s-1s; Tue, 05 Dec 2023 04:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS6w-00073J-Js; Tue, 05 Dec 2023 04:53:03 -0500
Received: from mail-dm3nam02on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::631]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS6t-0005UT-IZ; Tue, 05 Dec 2023 04:53:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/Hf5KkwuMOvLFPFPJ5Ar5oPO2YB4dBAgO6CykDaiK7rXm1h+LJSJV6Dkab0fKc9O1V3k0iE0ZuLaCB0Ue69wj3T1nNFBZP2FF9We0O75mmCCfDW7iZHLUiF6xTY/FQ1iTi0UJ2MwbBdQ6RwXTIAH+aFzMKGEXAnJRN7U8h+44kzXLOS3liA7KRazyyQx2glL6mgSunso29MLXhbmayOJwta7TqGIkLDlB4/2HJlCaPNOIQXRCxLrOlQbB+mVNsui7Z4Nq5BVK41ScNYwkL5+LWhNOhZfmPn4SAUKp4iIfSUILc3MJ/SxJDs2VLsLB/cNm2HGmpK9gxlpXSan1qjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c58MG9Tzp7EHm4bH6/EFEKOcQ35EhK6sXSZSLppobx4=;
 b=hXvzF23UvRThxuP+7WoPWeXi+XGgM1J5U8J13Pqa1BT3SzLlOkddtL7bJClDtwtjbELUfY1YHAJVeDtS36xn8vP6s1rsrNUY5g61ESWJ7OQ70bCt33l6BcR6zWagfYdGbFOAjW5xVkgpAgZ2eeFTy4mZMi3Vo+oB4eGvsKeVRddpBAYeD7jlPgjzPHmc4lFVqFApYwa1xk2fzGCapVoTXfXGMd/0fY0LQy1tMjbGFHb0Np49A7JE7WVLutAp0X6cio6mR7U3A/2uQuCc6iicHaVeWkiapgTTsK8sVUEYOvnrSmmvQ5OS7fhxI0OSiPDEybZfRlH3xyqnQAfCuZIH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c58MG9Tzp7EHm4bH6/EFEKOcQ35EhK6sXSZSLppobx4=;
 b=jZDBonQsxkTbjMmkiw+Ykydl9s+Getale6OCyJcA/ZwrQuBXKNTXBF+e/5JFG4JO/KiVeNGmfQZkz1QgPbAUKUN0oY9QkET/g/4NfApr/jelUI1ZBIG/qFR5c5nHIdxdVRLyX75CmeBdzGyZFmWGbGm15Ojx4w0NA5xw7bzdfGg=
Received: from BL1PR13CA0430.namprd13.prod.outlook.com (2603:10b6:208:2c3::15)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:52:55 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::d) by BL1PR13CA0430.outlook.office365.com
 (2603:10b6:208:2c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Tue, 5 Dec 2023 09:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 09:52:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 03:52:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 03:52:54 -0600
Received: from xhdvaralaxm41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Tue, 5 Dec 2023 03:52:52 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>, <saipavanboddu@gmail.com>
Subject: [PATCH 2/2] arm: xlnx-versal-virt: Add machine property ospi-flash
Date: Tue, 5 Dec 2023 15:22:26 +0530
Message-ID: <20231205095226.2688032-3-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231205095226.2688032-1-sai.pavan.boddu@amd.com>
References: <20231205095226.2688032-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 47456a01-c72e-47d5-5b89-08dbf577f448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD8OVPEcvtygbP6Bn0CSYyp2tcchv1+WSNPZTnLOzhTxgn2BGLtyo51BgmVnhQNc2QsxPouYm4Q3XDv0HI86zrf7uCxnlIJxBlqs+ye07YpGIXvOR53n0OUSSZr3JQuVemnfMekcZXWF7jrMdMU+eFLdGlXUMYlNXMUD4AFZNwscFrMwWBVDRqlG7wHR3NxxeN7/7/SYr8Yf29GOWiG75Un/6EesfGYBk5dcxrRkN63+lkk6zZtK5DTpkdF55RITe5Qds5nXJLW6OGm73epnO+2u7wa1fZrKxKSoWPxzgjEaegHAhLxD11zx7UxEvoJ7DU7XJl0d60nRqpsjxicQJjdEoGslKWk+ZD0ZpKE0kGfrfDqEfT5uxjILHs/sVWeVeVWruk0tmXs111OOhPdk1EarXZQkxXkzzYjA9HoK+zAombnmOkuW+fCiP4EXrCK9fpXg5PflKQAC3UrED1XgV74ZrgJyW+gSmLHLDSE7vA+eCjzaGxmTvsf65A+Rk44uPktA0lZkgJLi52HuXfWJGbezMyjIF5weUtXuhSJt8+niRJqCZGu3V8lI+cEf+3lCMeU2s2KG+s+tutt2u0/4G587w3kKy3hlsPk5JSQkkzNh40Am3h5BBU12+FKXY3GO2CY+lz2MPe3KO8OILOuV+EZEK1hq0hYlurFj6U0EDl5RHBvCKFbRiAQGCgh9ZLDi3pRgqP9IloenQXjCkjvUOiFT+L3VyafHVSg8xmkx2NGhJPhfYhiRG2+TF2s5BT+TGH4cKqb5D7nnGWV9kfJE/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(36840700001)(40470700004)(82740400003)(2906002)(5660300002)(40460700003)(36756003)(86362001)(103116003)(41300700001)(478600001)(40480700001)(36860700001)(6666004)(83380400001)(26005)(1076003)(2616005)(47076005)(336012)(426003)(8676002)(4326008)(8936002)(6916009)(70206006)(70586007)(356005)(81166007)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:52:55.0884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47456a01-c72e-47d5-5b89-08dbf577f448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
Received-SPF: softfail client-ip=2a01:111:f400:7e83::631;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This property allows users to change flash model on command line as
below.

   ex: "-M xlnx-versal-virt,ospi-flash=mt35xu02gbba"

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 537118224f..c57cff74d8 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -49,6 +49,7 @@ struct VersalVirt {
     struct {
         bool secure;
     } cfg;
+    char *ospi_model;
 };
 
 static void fdt_create(VersalVirt *s)
@@ -637,6 +638,22 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
                            &error_fatal);
 }
 
+static char *versal_get_ospi_model(Object *obj, Error **errp)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    return g_strdup(s->ospi_model);
+}
+
+static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    g_free(s->ospi_model);
+    s->ospi_model = g_strdup(value);
+}
+
+
 static void versal_virt_init(MachineState *machine)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
@@ -736,7 +753,7 @@ static void versal_virt_init(MachineState *machine)
 
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
 
-        flash_dev = qdev_new("mt35xu01g");
+        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
@@ -769,6 +786,13 @@ static void versal_virt_machine_instance_init(Object *obj)
                              0);
 }
 
+static void versal_virt_machine_finalize(Object *obj)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    g_free(s->ospi_model);
+}
+
 static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -780,6 +804,10 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
     mc->default_ram_id = "ddr";
+    object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
+                                   versal_set_ospi_model);
+    object_class_property_set_description(oc, "ospi-flash",
+                                          "Change the OSPI Flash model");
 }
 
 static const TypeInfo versal_virt_machine_init_typeinfo = {
@@ -788,6 +816,7 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .class_init = versal_virt_machine_class_init,
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
+    .instance_finalize = versal_virt_machine_finalize,
 };
 
 static void versal_virt_machine_init_register_types(void)
-- 
2.25.1


