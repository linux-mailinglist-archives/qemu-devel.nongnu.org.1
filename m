Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A618D75B8CE
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMaQE-0000qC-Du; Thu, 20 Jul 2023 16:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan@outlook.com>) id 1qMaQC-0000oL-Gc
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:38:48 -0400
Received: from mail-tyzapc01olkn20817.outbound.protection.outlook.com
 ([2a01:111:f403:704b::817]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan@outlook.com>) id 1qMaQA-0006HU-U4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6emttcPdsGW6RkrGUomlRA4fRdrcAgtyiAWW7THqZjNOqQfh3VEYrEPZiTjrpHwTVmAKPpPzB0uFDcZdgwhOWCaE0TwnWBEtr2QQ9jUpoAtk4ORffPUK9wuXyUSVo2gTmgueP93+4IyrjmIuw6r6TKcnsbAQR3FJJUlLFzTDPcNBxcyU/zfpdRQHrxxfKYZIFyUjbq6lbxvbeF25UUJDzRCjqtZBS0zV5ZaMIwmyBikJJheV7gOM9lx8k3WiE60KjTNI2hyN8Ehtep7lWLhvzpkJN75VVL7FzSCPtSjDIc+8hMQ/NzAgXDVbNi2JafiB1saVAp/Hrnlnpf/sDHrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY7kfGbbEytWCbfjZot/RU8TYd4HEhxmSgEpD80bDJE=;
 b=mLXcxGeaTkHo8Gs48yR3q9YVfw4NWb9fOqKwrlh59vGXPC87sfFX4ZtZhRhjlB45TVdUGA2zZ9d1Nqr2KWY+aRdinLO98TDr574YMjswzLVZdKVWOT5S1tYymlS1wi8VWWSuAU8nEJ7m+Sa2DRTmbOPTJVrSgpAMG4j8rF7Ow19rxK1b6WYrbRxkyo4vpKgYkyGU32gCHgANmbQ2wpUryHvyE/o0+XCfo6Cirdu09FUq3nUkEODp2d4y+Bfb3T4QPAOdINGv+5ndffBsO7lgdNHI2DFdXvCapvfL+7lmi89HeLGwIoiXkjAgLCSAnjNp9hrQFsX/bB4+JHC+Wu7McA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY7kfGbbEytWCbfjZot/RU8TYd4HEhxmSgEpD80bDJE=;
 b=q/nHieKz4kRU+7etamJip9hJFtId5hpMd+MEr2Pxo0RIWOu2OHb3KMR0zTyTAGpc58RbMxHwOYeioke/ul3fMFYGVWqNgKjFxx9hoZFLaiBrR3dFtoFNY/951kVQrmAnl/dhwIPCkYejJo6CqqX/yJw7Fz/pwmiW1uxk8GaE8SzdeWQwWmAnvsf7BRS5UYseO4O4QY9cj7dDgrdUqDVyK3NXSqwHwou0LkverpFgtf7fOjK2/yIY6TRU3BeQQPZV+VOgSr/PwZILxtGuwk0p4UzGLB/zuOKvYsBnOS+TDjY9QYdHsn4P8hNBf1t2mnzsvX3qPDFfHKaH0YbOHF1G/w==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:30 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:29 +0000
From: nifan@outlook.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, hchkuo@avery-design.com.tw,
 cbrowy@avery-design.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region
 representative and mailbox command support
Date: Thu, 20 Jul 2023 13:37:01 -0700
Message-ID: <SG2PR06MB33970F359FEF125EA18A1350B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JfKFZllsWyqFtH/yVDeEVw7AUOekIUP4]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-3-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: d030f563-b0de-4e6f-d442-08db89612662
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO/qzAKd82WE1LuLgf/v/GCykgkpUJblvxC/cpJDnoTwdLPg9tGpQxIL/PhVJiySk5Ul+C9C1KRY4Ki5UzGUitZihcFKHqMGg81i74Ek+/MRVMjrXDjZDXoEbAcpCloIg9tsE/nhyCs1gPOtDt8I9t1IuAPGeOAj4J+Olwa7M4YqutsQROLltpZ0FUhcOPhzSSS30cTIKGLgOEigqbNxPpBM8YPoeISK3dD3OEtN3HuTQGiRVyxtQhdVO4BXxkZAsDXxPnDVR5fgVlmijUhIswXWaxQBHMmnFKLea7DSL6fe98Vvx/eBXB7Wt2ESE2JzZQXH2fnGbhBQNNaSUoTS2M5/IWRF9Hv3wKv94zj5/2FfI6yDugx4tCNWmmXbH9X9k2Li8mpyb5/giVpTaC/URAoSrSADSroMgJKZjZPfCfu5abWhk3CRD3SWOSUJN4KsA1rfMul0LhcSS+zSeW86e0Oi+1aiXhSQByc6UKRk5VfcUrQ/2IDwwKqL6sJDT1s7nMDVrIhGwHPhEbYlrJEQOAw0jsD/l/Nd9iz/ldkK+AL2ESDJUHenqeOgpi43fe1kTrtxL3AUsWD6zYr/Jon6EJvtSKUEQ22NAen4UYkeAvVFAiXBjDeHSCxLXqhNE2IY3WLrCFCnP09snhpeWVeWs2acMIvt8zf3/KpQyf5LsZ0TQbKpQmcXlbTEINjgQ86Ut8PGJ3quCPoX6g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3sHHXTF8Kuj2okANYliJB4F9ZTujSzI+1cczP1LbgsKYVR9VUM2/XV3kTUH0Pc0jf6tkswm1eU3T/Ol7UkWstw+hi0DP5QmeTP33afx6x9M/RthQ9m1Luucz7VKLLJqL8DFiWQ58sT75aSUfGQ+KY6JYaS3+LJaZ2fQgVopbBnDLXA1le4AY+QPnmytxVWGO1TRIZ9eq4Z4cbAWRUKderdBQhpYxlgpUbg+ixntIxYCfXFhnWNuDjT+vqOsYB6kQ6AkMDW3zCU2shmdWJ49s6IU0f4JJk1MjjzAEVM+S+DzC9cX5VbvH/JHdSdin9ckHLDnn2sZb7Z1AwT2anFXv343jpQ5dRRCGnFexJrvpi3ycrztKNcUiCmpkRgJZwPIE6OhDNNqlUHO/6/QESoUDge3x0ODP44acztAIsAuKyjOqUgr0mf0Nzwcdp9Zx9gJONKUXZCoFTtuvkkaPev81r1S+lydEeXRs529PLlX0o/1puwFPv51AGtvG0QflH25xT3WjBvMNtBZzEc+jaPznik8JUbCg6PUhoOC7yo3QQ65BLFoj+R7JWDEcgAKf4xtBRCDLflfZz5vQRQUrJTbTci/jvQdvNoqVQ3yW84OhZbULfMG99G1k0cSF3RwGn7h
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2R8U1goY2+yNl2zrrV4Cjau7Z3W2EjoSnmzJ99OZh1ecrHXxMAIDzY6r/lRZ?=
 =?us-ascii?Q?2cI4rRgFJEJ5G/7E4SWwlnfBs9MO08W/CeOBSolBkaYxKodunEz5RF08qu78?=
 =?us-ascii?Q?IbIAhXCWHvQhP5S1XRJ9WW/IgrfwRETNmQJ9dwUxEIZVMNrF/HbD0+HyTUvr?=
 =?us-ascii?Q?4QH5hztsVk6MH/ighGdzEln5soHfMdNOL5NleoxFXwIP09owH0sFMYTw8qVx?=
 =?us-ascii?Q?EUESw26USuPEr/W4cqPu8Bj4rlyq+2HEOeD5F8ODWQkNi+6djMU5DydE19NM?=
 =?us-ascii?Q?d7IU6hOXVfICVH7ghCseFbL7cV1w+Q/MxAO5xqvGva9y6YKNZJ88B7REHG/b?=
 =?us-ascii?Q?XrJclsAgXjQ0/2vUkfVKJ6bvpc3pf4qnOhKZCeBsjsAMRyTv9NYt/7nNg0ca?=
 =?us-ascii?Q?hsiPnAorIZJpefuvyI7po+nX2IAnLt6nJ6/JyNCykcdfkYGYrYBaenDIwp/i?=
 =?us-ascii?Q?tR5EBmhREaf4OvXRutSdVE0ToswU5oOTdoiXcZOEx0U+hQiZfyneG1Isp469?=
 =?us-ascii?Q?5Oxw53IBX0CssrjLxjIfcFP4qmziKpgdvXPqKlK87NkkrM71xSGCDgzjivKb?=
 =?us-ascii?Q?ngOT+A6supLtTlZyy9ur8vk92ZZDu+nUzNQ+B/iK24IJsDcQCVTCqQU34h/y?=
 =?us-ascii?Q?VAF/9fZ39+WQ5iXT5q/EqQ8gWQJlc574pn+gEbOYJgX9CMDcPFud8OzpIxZL?=
 =?us-ascii?Q?SqFXWLrO71tHoawZjWNFeZsLIQojCZOTCQCNSIjrQ+7lhkVHlbOkMpD7lNMl?=
 =?us-ascii?Q?heugZQd0MgRtX2mqroc5xT/K/WbKykOaDUEuZ9Y1PRO1fGTiM9TOsphi2PI6?=
 =?us-ascii?Q?9nf+iknP/snOC9nCL/ERT6zYlk3FVRCYObSd9r6p2xWes4+LPP764Un+pgz3?=
 =?us-ascii?Q?bmkVrBouKldYJcWnhAWqzoRPW3CGN+QPjKh6bXVNDvTnw7op8kbBXdE2Bqis?=
 =?us-ascii?Q?O0J9VBV2esQfxzTskhgzwWX6YC8kF7p7QDI655K3iv2GYQTpN/aCYKt5sZ2H?=
 =?us-ascii?Q?Q0JrE264uKpgZlYIdvCE3M0c9DuNn4JWk6aNoCgTUT/e9x2YwpV3t8PAk7Ir?=
 =?us-ascii?Q?g7/glO5wEtBFpxVDeeUcqWzrbsctq/re+AcHyVV4qyscK37AuzJvEIoTuGS4?=
 =?us-ascii?Q?DKWN925h6s9jPrXBjaDNTC55UVqVOYHkvNiTHV8+4R2B0DAmGaifIwi6uDoV?=
 =?us-ascii?Q?XeUKAn3DgfG1e/4Cual6g4d7iiWAfWJcuAsHcA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d030f563-b0de-4e6f-d442-08db89612662
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:35.4065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Received-SPF: pass client-ip=2a01:111:f403:704b::817;
 envelope-from=nifan@outlook.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <nifan@outlook.com>

Per cxl spec 3.0, add dynamic capacity region representative based on
Table 8-126 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 69 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 +++++++++
 2 files changed, 85 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b013e30314..41e43ec231 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -81,6 +81,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48, /*r3.0: 8.2.9.8.9*/
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -939,6 +941,71 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * cxl spec 3.0: 8.2.9.8.9.1
+ * Get Dynamic Capacity Configuration
+ **/
+static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
+        CXLDeviceState *cxl_dstate,
+        uint16_t *len)
+{
+    struct get_dyn_cap_config_in_pl {
+        uint8_t region_cnt;
+        uint8_t start_region_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_out_pl {
+        uint8_t num_regions;
+        uint8_t rsvd1[7];
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint32_t dsmadhandle;
+            uint8_t flags;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_in_pl *in = (void *)cmd->payload;
+    struct get_dyn_cap_config_out_pl *out = (void *)cmd->payload;
+    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    uint16_t record_count = 0, i;
+    uint16_t out_pl_len;
+    uint8_t start_region_id = in->start_region_id;
+
+    if (start_region_id >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
+            in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    out->num_regions = record_count;
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                ct3d->dc.regions[start_region_id + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                ct3d->dc.regions[start_region_id + i].decode_len);
+        stq_le_p(&out->records[i].region_len,
+                ct3d->dc.regions[start_region_id + i].len);
+        stq_le_p(&out->records[i].block_size,
+                ct3d->dc.regions[start_region_id + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                ct3d->dc.regions[start_region_id + i].dsmadhandle);
+        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
+    }
+
+    *len = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -977,6 +1044,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
+        cmd_dcd_get_dyn_cap_config, 2, 0 },
 };
 
 static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cd7f28dba8..bf564f4a0b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -382,6 +382,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+#define DCD_MAX_REGION_NUM 8
+
+typedef struct CXLDCD_Region {
+    uint64_t base;
+    uint64_t decode_len; /* in multiples of 256MB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCD_Region;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -413,6 +424,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    struct dynamic_capacity {
+        uint8_t num_regions; /* 0-8 regions */
+        struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
+    } dc;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.39.2


