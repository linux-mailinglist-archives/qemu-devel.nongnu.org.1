Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29FC82D3A9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:35:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEgi-0002Ga-F5; Sun, 14 Jan 2024 23:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEgg-0002FH-54; Sun, 14 Jan 2024 23:35:02 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEge-00031f-1Y; Sun, 14 Jan 2024 23:35:01 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F4O3Gf003990; Mon, 15 Jan 2024 04:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 PPS06212021; bh=6+KeztvLgQtSzYS/TQvIYfNGAPEQQaGKKtQ45xpVw98=; b=
 qfQeocVW7O2t3fxMO1J2tgOpp4mHXzFiBxSyd9baOOcM5TDMmGFY8dU9kI1T1vrw
 iwG9NjPa23Hc+6zDWhdnBOfJLjl7Ka3EoMIfJ/ZQq42e2m4n79+XQP77KQC9Gui0
 oSaMD2pxdB8pMLu4ACgXDGR0EcuXcqbcYpWsRWBguhs0ma8ChxHscSZGeA3FsUc3
 mow6yn6DHsjcsHi2J3bQSvGdYoJ/v/4h9IDbZd3jhBJG75yEJn4bWnx1htSm8VnQ
 1ExgXoFc/fYhRJAxbZF0Mze3fj8niJ3ltophOkQ4aH+yHCt20+Og6LJSRi8jiGc+
 9z5Sy7E/rGCb6IZqvG5eOw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkfqx9mya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 04:34:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVplWGu36+6xKWKJYLghFRT59bbwwDpyjVoxl7J9xYlZ3sroFJeQiQkQuyYxIcuOEeSFiCFGDcprb4VvxNVwKiQo8O6SrjRsbTwlvb+b+DtJbzk9zkzUHi6dzMZqLrscLwt6ieb6YahVLdRe32cw303tosc9FDyHYsZGxr4EJRX4FsUYhIaLFJO8O/AbnrMVvAO4ega3jhMVKKGiq4j1oALAE9QHpWyX/1SOd5mP1pVNdTMmHvcm+BkeMd5jNLnaB65nf8VpmyPOR31lJnQ+UjKYQkKQ0zyfJpaqDVLFQW1VXRtz2ANsuplJpzAR2ximDIZoNPTW1uACHGDtBrC6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+KeztvLgQtSzYS/TQvIYfNGAPEQQaGKKtQ45xpVw98=;
 b=GixiOd4OhSZdT7lOA66YRKBH8LOya40kS6PPxGGGGbBoYqjDTiJxfntqwReNzvO4I+yRnhNF4QhDPden81MOPJMDUnQSyZ1ma0Ohtl+NywbJQquJpNBEQqZF1yx/e4TQR2bdhlR7Td0NE+AqHlJHlPZGNOHOGv0zt5FvwnV+ISgqR2mqpwBzKrlQUkorJM+DJU2l+BYHxA9j7MvRB7mc6PKQkOM61Ec8KK7SAKvmMqc4R4Uitv0mXV7dMG9wanMU8rXO9lJcngd7MM11TqDuiLkgrFjgR0LARkwdMjV4u33it6sEUgN8GVaMrjHfAC75r00qmkvb8wmq3d5kb7PRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Mon, 15 Jan 2024 04:34:51 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c%6]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 04:34:51 +0000
From: Bin Meng <bin.meng@windriver.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Subject: [PATCH 1/3] hw/arm: Refactor struct arm_boot_info::get_dtb()
Date: Mon, 15 Jan 2024 12:34:28 +0800
Message-Id: <20240115043431.3900922-2-bin.meng@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115043431.3900922-1-bin.meng@windriver.com>
References: <20240115043431.3900922-1-bin.meng@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DM4PR11MB5358.namprd11.prod.outlook.com
 (2603:10b6:5:395::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5358:EE_|CY8PR11MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bed8eaf-ad42-4548-b810-08dc1583503a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFwS8/SSjA624Yr7sVxgvdaxbjpeq7iTXNYJhSbFU9ofDlfy6uYfLP1IF0tDrzFAzr01IBTDfV2s6GXKXIRIGUFLtGbKUfjvhy4SYEeKWUI5zbLqkP/a+DCMLXwqG3Yu7bxE3mlsK+2XEJ0daBJW7JzzKCF8aZcaDnFEHydwIR/GnmMoclu344wLankQxfPebxHWdwsz5gpR1ICSAjuYol7UP6M07/WMeuJLImBoTYNyh6t995QHlPbaw36XWsinFvd99vl7Icr8Z1dEl4K1EXPLvmlvnCIAjkj/SRqr8BSUC185KaVjyaq9xxGcu77WDKDUpgAihiG8U61yps1m1ZffbWulRdRrN7S1GI7NrWfxv6/3btNWIIs5MrUB+uE/xDIO3HER9ukp9EGQzr0oh6UnPhHLrjqIcIsV7GDg9yvPCSkJMkAPNwiJSiu+cQleWio14louKSRI95u4om+GsySKWaMg5bAJv6Y9PSbtt2baOay4PiQUxbGSQN+f6oo1d1dPDFH/qtifqgbzSRMYuwNH9rGoTqjy+3UC05+2aWlANeWITZYi6xZZ4+K6Xe3cSDHrrEwYf5LEZprxQeDOFPbISliUsQcgEFnDZP1qoL9gyyjlmkXBp2NuomdxHDOX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39840400004)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66476007)(66946007)(66556008)(6916009)(44832011)(36756003)(8936002)(8676002)(316002)(54906003)(38100700002)(6512007)(4326008)(6486002)(38350700005)(2906002)(5660300002)(83380400001)(41300700001)(86362001)(478600001)(26005)(2616005)(1076003)(52116002)(6506007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6qSI9DP94f4Zxw3Qieuc+z3xRAhZG+zHYIsTUxSYCy9gj7HXyqu2ZT5lMAd?=
 =?us-ascii?Q?tPpP7B5aK4ivXpCGrSj0lmT4XHFrJ7R9ukF7vHRNSMpTWyjvLuRuuDznUHtf?=
 =?us-ascii?Q?acZ5YAcoQmHVyYleUf4xJQHuFZCDxOAG4eA0OMQJOYrWnAnO/YzvNVXKK09j?=
 =?us-ascii?Q?OVI/NE2sL7DB+JuJoDsKaYlIBqJ0+JPNiT9xkbm3hjHux46+QbXJy/W/d0fd?=
 =?us-ascii?Q?rgDIoSdHkuHLZhP9SXuaEYMbsWXerDg5OTY59DeJBIjK2hOE4UxTZbQwDGcX?=
 =?us-ascii?Q?UXkIrmr3+PilFo/7NH3MjbsjRepxkfOHmKuGDpOQdPGBVyi1DSsSPkn6+NAO?=
 =?us-ascii?Q?ItoRsDeY8IxgOZLQflVksIDcTHqYIzKeox2xi/uThAfq0MAg37bUU1ANF8XC?=
 =?us-ascii?Q?O0xGQWOevFHk/Cxzf0K9jbRJnCflFR9vjWLr3Ycsbdv0yb4m/kYcTda+SkCF?=
 =?us-ascii?Q?oBJ98vJrsaAn/ArBB3KOBRf8MYnRgDVRaj2BRg6kYHXDg/Ml35J0YJnwHXwA?=
 =?us-ascii?Q?VQCdT8vu2pik7scks7ecQCJ1r3pXJGx8gt1Goe2Bt0CXwXhgxiL+Ct2rleoQ?=
 =?us-ascii?Q?2VVQR1PJeUN8EArNBPUtZ6K3U9G1+WLFqExPSKkw6hvtGJj0II6aTgHi5oyQ?=
 =?us-ascii?Q?yCZFixaHD4H+s1T+KxbWBrnNtwyZji/TTYJ6aLtT+bI7hLeozRZRPtK7IJ0A?=
 =?us-ascii?Q?nzWr9AtGbSd1dnN18j24/lyuD0zZtzabkVjohhGzXSfXrUhfNr0LnGSSyR5n?=
 =?us-ascii?Q?t0O25elGZauzhFkUbEs5hKi5PimBmRvG7GGssLk301hWqTFai9nHixPmXnFF?=
 =?us-ascii?Q?+Ii2Bo2+PzhTSUrijbvIvtFuWCHzersPeMwoaRA7GaBwEqq+x+2h0ku7/TPV?=
 =?us-ascii?Q?dcMzW4274LJuJD6Mw8JbSYeJeqdJuR+PybEqmQPjTfLZLWylBp+iaYieVf9c?=
 =?us-ascii?Q?uXObAr/7dFQZYU+6QsLlqHEtZPyzQVu4YBqsAdLLtzzy93lxCSaepsoG7VW/?=
 =?us-ascii?Q?iP8UWjK5iv0FWlI7MtKGigAM7y3iWLws5Ip2Wjy4u/AQMqLmAoGmwaB4/Ssf?=
 =?us-ascii?Q?XRLhsdRRQzlK+zxag2wojawvCUA7rKIuv5nYy/+stv2GQau0wfmr9h7l0byd?=
 =?us-ascii?Q?FNkcN7C4Pns0a4YKsBEJo7YKFGG7GqkfY50+CDR1c/B2SwPtQPLsUAP0UIcp?=
 =?us-ascii?Q?MNPfXNaoYi1T9m4A/O1EaDLISF2+AUqTxKN592UQQM/KaHI3EU62dqMeyM2E?=
 =?us-ascii?Q?op38yuKb3hdRWPWvedNp0kzNIsjJLPLyH/uZrKsfu+mSmdmpkboa43qPEk5H?=
 =?us-ascii?Q?JBu0PwWyRZmWAz8uwKOzd8YCUC42u7CEQTUzEe0LoGIzRy/r35Ah2nzL5Miv?=
 =?us-ascii?Q?CdgjGWxO757aiOU766CeNt9+U+humoauscqD+yURicGYenlS+ZmsdPgUFoLK?=
 =?us-ascii?Q?d0mLIVkJLbY8AOn+7s6n9y1JmiaADb6ZjmjNNQDF6wlX+kOfIvLCYpIWS3Td?=
 =?us-ascii?Q?cmVsjU3KBQSpc3cOkIkBV9D/ZQTZ90s61Dmw/AQYUVbhw+hA6cElDcBnOFfw?=
 =?us-ascii?Q?Ay1oKmPSiQ1jLOBVPOukCs9s5d/DnkChIacA/YJU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bed8eaf-ad42-4548-b810-08dc1583503a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 04:34:51.2760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpcbbfwjVkS9558W20TJo9ddmPBRaNHrKpdK/5VyomMN8l63Jnv5ZhOuooqRyNPzm+xl1aumo/jzWspoCFwHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-Proofpoint-GUID: anqETuVdNi-dYw8jpuOS_ljp3Kq9meKX
X-Proofpoint-ORIG-GUID: anqETuVdNi-dYw8jpuOS_ljp3Kq9meKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=740 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150033
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=1744ec9a4b=bin.meng@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

At present we expect struct arm_boot_info::get_dtb() to return the
device tree pointer as well as the device tree size. However, this
is not necessary as we can get the device tree size via the device
tree header directly. Change get_dtb() signature to drop the *size
argument, and get the size by ourselves.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 include/hw/arm/boot.h     | 8 ++++----
 hw/arm/boot.c             | 3 ++-
 hw/arm/sbsa-ref.c         | 3 +--
 hw/arm/virt.c             | 4 +---
 hw/arm/xlnx-versal-virt.c | 4 +---
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 80c492d742..37fd1b520e 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -82,11 +82,11 @@ struct arm_boot_info {
                                      const struct arm_boot_info *info);
     /* if a board is able to create a dtb without a dtb file then it
      * sets get_dtb. This will only be used if no dtb file is provided
-     * by the user. On success, sets *size to the length of the created
-     * dtb, and returns a pointer to it. (The caller must free this memory
-     * with g_free() when it has finished with it.) On failure, returns NULL.
+     * by the user. On success, returns a pointer to it. (The caller must
+     * free this memory with g_free() when it has finished with it.)
+     * On failure, returns NULL.
      */
-    void *(*get_dtb)(const struct arm_boot_info *info, int *size);
+    void *(*get_dtb)(const struct arm_boot_info *info);
     /* if a board needs to be able to modify a device tree provided by
      * the user it should implement this hook.
      */
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a..ff1173299f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -538,11 +538,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
         g_free(filename);
     } else {
-        fdt = binfo->get_dtb(binfo, &size);
+        fdt = binfo->get_dtb(binfo);
         if (!fdt) {
             fprintf(stderr, "Board was unable to create a dtb blob\n");
             goto fail;
         }
+        size = fdt_totalsize(fdt);
     }
 
     if (addr_limit > addr && size > (addr_limit - addr)) {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 477dca0637..c5023871a7 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -681,12 +681,11 @@ static void create_pcie(SBSAMachineState *sms)
     create_smmu(sms, pci->bus);
 }
 
-static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
+static void *sbsa_ref_dtb(const struct arm_boot_info *binfo)
 {
     const SBSAMachineState *board = container_of(binfo, SBSAMachineState,
                                                  bootinfo);
 
-    *fdt_size = board->fdt_size;
     return board->fdt;
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2793121cb4..1996fffa99 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1577,14 +1577,12 @@ static void create_secure_ram(VirtMachineState *vms,
     g_free(nodename);
 }
 
-static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
+static void *machvirt_dtb(const struct arm_boot_info *binfo)
 {
     const VirtMachineState *board = container_of(binfo, VirtMachineState,
                                                  bootinfo);
     MachineState *ms = MACHINE(board);
 
-
-    *fdt_size = board->fdt_size;
     return ms->fdt;
 }
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 537118224f..1e043c813e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -551,12 +551,10 @@ static void versal_virt_modify_dtb(const struct arm_boot_info *binfo,
     fdt_add_memory_nodes(s, fdt, binfo->ram_size);
 }
 
-static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
-                                  int *fdt_size)
+static void *versal_virt_get_dtb(const struct arm_boot_info *binfo)
 {
     const VersalVirt *board = container_of(binfo, VersalVirt, binfo);
 
-    *fdt_size = board->fdt_size;
     return board->fdt;
 }
 
-- 
2.34.1


