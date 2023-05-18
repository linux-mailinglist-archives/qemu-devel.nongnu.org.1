Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4694707A3F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:25:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzX3j-0005xK-5U; Thu, 18 May 2023 02:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzX39-0005wG-N8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:23:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzX36-0006pQ-20
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:23:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34I4GUFs010641; Wed, 17 May 2023 23:23:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=Hhv0zaHlw6I/WknkKGKNakQWgq4MsCoA0Iq5r6cDl80=;
 b=S/b4T9isUKb4vWGMc6K+jZKqa4wZJ2fEWebRbeK962Xty5249M2THeJOQcO2JAeGVRiF
 e9pCS4OYXoL/OWgwjy7Tr1BK+d7Anh6H/MTtyGN87RV90GDlZgbdauec8RhLV5p7l/Os
 pnc1y2eLqCg4GwLwpWKSBBJ22cjljUZ0qns60sIKdUHl1LAmYcb+Zb7LfeRvNdNxCyJB
 Dsitwu8Sdc2PfmK12fk9aluyLg+S+t8z9Pt6fWRBYw3p09LJMIm6sZHSUz+FtCRAS6A7
 Y+SLxF/JIPFpZri0i6TIc30g33m0ZmUmtjfYbgDtrMG8kdiEczpM5Mwoj64yTDpJ4Ie/ Yw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw97sxbn-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 May 2023 23:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgdDxkql6nso+BVzcn4rqH0tMdZoJVUptqEpINIn7sFxEBUcQWVkfziUJaYMO63WrS29aOO4EAG6ChfzqsJP5Jd2fXdGri0SWVHg5JI/jM8GW6NMFM1siN8V6vNssyykpgCUZUMydG/EBo2Ql+aadHjuloGjBM+QIHc4ymWOeVHwd+gC1t+zDIZ5Y1cbPVIjTKReOjBaO2Kg++TqNbtcZB3ik8n3o/FYtd2Q+N0Eol882X6bfpAD0I1DBZtlarWlILsa2YVh7U3Z8jkhy+Wag42rQTScnIou6z2XxpL4d6CMj636flBL3kc4w1aw1bGAP0Y3lWwi3S12n566H2z1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhv0zaHlw6I/WknkKGKNakQWgq4MsCoA0Iq5r6cDl80=;
 b=Ckj87oYhs4P4fZci1XTgeBKqKSc/CbJOs1YKpmeMuJ1AmQMnBkElW46YH8nNSOn+8FS9iasbu09AzXqLSpiG9dxEgFwCPhERisSemRVigqEqMnpD76gJ5VVweMSyM71Q8E0WvQOsRL8YAbPQKcd7iwC1Y4S3m+dQyWM8+KesVjUwZwRr9u6QWZWtIxHRfCDKB6jWKQj4F8Sl1gz0+mncg56hK9aKXQBDixfLsnwH+g/kPNiUUqML57v9699F/ck23+26QG4lj3tXvkAwAGB2stGHXxZq00SR314bbhYTVevTQ47jDj0GCHrRUEInZn2WJX9qphb1V5CP8PHU11owtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhv0zaHlw6I/WknkKGKNakQWgq4MsCoA0Iq5r6cDl80=;
 b=Q85zAbFxXlOJJB4S2J89kv/DuUF1AqCphlOTu90Zix+QzVZHkIAXA71KtoIbpz0pXHKMxkrAW444c9oovemOYCNU/emNNf9wizeAD0caPiOqlZJOlnzkxd8zQmVCbWEyO0DDGjypJgW3kueHOOkqNvvkeuqyX5zoKVMPUC2fZ+Iyd12nm3Soo29pNLURGE53Ny/E3hVBQ610jesBOXcVM1KwFCmEpTgw1QFfP6mCeu/NfDFMrXC0E7tmvYu/MaH6KdBqYeZmTHQfhKw/xQLWbwSl5imiXIp0qbK2nT3BVxRjRaR1iCGBbfiO+YneW/dR7mTeLGleQyWmm1lUTWzZ7w==
Received: from DM6PR02MB4810.namprd02.prod.outlook.com (2603:10b6:5:fb::15) by
 CY5PR02MB8920.namprd02.prod.outlook.com (2603:10b6:930:38::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Thu, 18 May 2023 06:23:36 +0000
Received: from DM6PR02MB4810.namprd02.prod.outlook.com
 ([fe80::7b0b:cd05:f137:7f12]) by DM6PR02MB4810.namprd02.prod.outlook.com
 ([fe80::7b0b:cd05:f137:7f12%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 06:23:36 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, shivam.kumar1@nutanix.com,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [RFC v3 2/2] migration: Update error description whenever migration
 fails
Date: Thu, 18 May 2023 06:23:08 +0000
Message-Id: <20230518062308.90631-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230518062308.90631-1-tejus.gk@nutanix.com>
References: <20230518062308.90631-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To DM6PR02MB4810.namprd02.prod.outlook.com
 (2603:10b6:5:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB4810:EE_|CY5PR02MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: def10707-013e-4955-000a-08db57686955
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcDCh14QxlZSrnapr3/1QhkLWWJ7Lreur3Yl8KKlsPX0Rhb1+EAivYbz9bNRP0gumCvaiE8V7oqR8gxWOymezmEqd046vVnFIw3GF+XLqmvBxAzGfMTI3ImlFx9aOU2/U/xbrEanBVj9pY07F7lnzYZ69VJjbpwqOIaN00h8sDkfjloPErZhggFEqaukSv5NeOTz6Ui6wBH6pm7MgXWWMkXoAQpmtvr/6D5zgfTTVfihVPg3b93l1Q5tm2GNbc76dMtoIb65nuuJNNOqzPbggvV7XCaUQiAnDViDzU82jIaGsL68zNIEu3zbSOP2E0Id54IlJ8R+QYOC2J+DCaFPXeb7mKvjSbmjxmYUEmods55/JQUWySw8p/A3hDUNzrv8tCnEOB+a1/AYajPKMIPkQi9kcbX0TKPqVxUOiXl32H8JPTLghZWpw99WnTN5YWUletV4c5Rg7CHZ4gYwmRQIow9Qz30CVL+LbPt5x1Dp/pcPNoth0z4i55yey2TbmGJxmr5hhuaocmwmMtyTs/k+Nwcn1v5qhOXY77mVLpYNg0dTkFdHgYRHrWewXLD4/Qv8BmZ1m0FrevlWe1PNozxfcfpV5NbccQ93LdukxozVpWU2C7vHNUjlTAb6sarJMKMb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB4810.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(316002)(6916009)(66476007)(52116002)(478600001)(4326008)(6486002)(86362001)(36756003)(83380400001)(1076003)(6512007)(6506007)(107886003)(186003)(26005)(66946007)(2616005)(8936002)(2906002)(5660300002)(8676002)(15650500001)(6666004)(38350700002)(41300700001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ly8qrmSMbAnXRp55nwJDqJt4MrvSuDIoj1wxeBPMyJP1H/fa3Id96VXYMd4J?=
 =?us-ascii?Q?eequtzqK1WkQNf+iDy8Mb7+gHWKqnrgQrIBxfDKwgBwQ27knpuZulAWKvNbE?=
 =?us-ascii?Q?CU3lG/UDNpdtA+LD92KraKFuoRA30UETZlUuzLg9yifkFbhuJVR1pmiuj8p7?=
 =?us-ascii?Q?8s2/e43W+QsF/0gqdWjGq+659V3TAjEQNAQDTh0XfcSkA2lbEqpwo/4F11am?=
 =?us-ascii?Q?nNTsTkdxdVNWopwtc4xgZgVD+jyLCkRZcKMNlt0vCOdWT4bUANY+bZVcK9o8?=
 =?us-ascii?Q?sCPPD+dvgp4/WwZNTGJIt19V+WdtMPe0n7RESVDYra5ktRk7xHzfQMWMFlaI?=
 =?us-ascii?Q?jhPYQqPCH94P4AP5T5vgkrwKFPoiG8d9DcILbh12ncqds9t093cO+rknkb8u?=
 =?us-ascii?Q?7wXBaTfYWcurc/DMD8x60vY8FCG87ZVAEMW7XbSx7nLZafT+qfw1sAlnQEo8?=
 =?us-ascii?Q?kOjfWitRiQiehT8Nj0kUmzoK0UfvcCyznSqfBY6aCCNbG9fwelvFL5Z2mJLl?=
 =?us-ascii?Q?cI1L91bht24NdIScRjZo88XkJBJ167p4Igy7TsRfJI2D4t/n4i2a5ZD1Yp+j?=
 =?us-ascii?Q?w5tBevHFPnnTZQfYwieUGVPE1I6TkigXZ9SEWTyhLxHYZ/TSblqVwiyS1ggz?=
 =?us-ascii?Q?exO2pq3xd3UMolnoawwXmcn8J/LjP8G68Toi0yHFBwgP6lXt6E8RAuinoWR8?=
 =?us-ascii?Q?y72w2fw2OVj+vzomlq7+mfTLQiUc9+atBnW7Zoe6wwt39uffFBoQyvI3GIcP?=
 =?us-ascii?Q?SV4E1OlmvowZY8PHdvdBbChxYTUaLG9PiMePDAwtw8bCaj3CTKhCyBNj2Y05?=
 =?us-ascii?Q?9JZH6SaKpyvT5r0ZFhUkU7u52rJpw+YB3X2TbwQGEkoOLR3uoYT6HK8q8H7I?=
 =?us-ascii?Q?JUzZnTr9fBOXsilVHNf1Y0wUsvaY916pWIcoN+Ap0/o9yQ70iV/uhbHz2OKp?=
 =?us-ascii?Q?SNmi07sc+MX48uqnzlTfK1RJMSCYrGQTEGopMVn7YogwFknn+8wgQbq28A19?=
 =?us-ascii?Q?mxFZRmrMiw0osuAOA0s9S3Kocqnw7BzPY50VtoSiO/KhfwJPFlZUxhrztREv?=
 =?us-ascii?Q?77wzNc8y05sc/Y4CAdy1gMw8VbufV6IAyceXnDBFiGmuzA/dm46yM0tCBhEy?=
 =?us-ascii?Q?KvhhgzFivnTIunHawc4jzgx7/BpZmNeITl/9mhzqv7981JnRomiWiatUL1oo?=
 =?us-ascii?Q?1Eo44GtQTtxDtjBaexHh+LLNaxWwlHj5uv00W8JlY2KZbSnjL+MyFotVWycj?=
 =?us-ascii?Q?7Z3l6eLpW161inCIrNtR4r6acYa9ShDIgBFODIgzjtN9drGGnNvJvwKoI+oJ?=
 =?us-ascii?Q?GM0jsivgh2f4g/Bmz1RxmV9Zk7/hr5WcKRfmjiIKOOvsch7Mnp7jjnOJMgkv?=
 =?us-ascii?Q?Wug/W8wybIFlz1d5uPECcta158isrh7K0VSFeEc9aaEVE3Tb3XHKzSJNKS3X?=
 =?us-ascii?Q?wYoFoQq4K33s6f5rIgwUW0waSBX10gxrLZoL8IIPLVlGVuSU3OCf53zlSxwv?=
 =?us-ascii?Q?UVijhoZTg+wzZlYCQOkARbgc+9gVJozMBntE2bZVWvCgqawzJSOkx0NsEcTV?=
 =?us-ascii?Q?U37LR09/OuaJw2kS2kU/IlYB4kVSQjSg5clx2kqWSNLHlmLVfeUB6OBbelne?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def10707-013e-4955-000a-08db57686955
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4810.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 06:23:35.9798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJp7oM7cwD21iDCTP6wtTQCYeBrwj3aY1jnwUPfNb53VJ4rulYOFTUw4JH4NQjl9culDv6mS84P96Dl4c4e3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8920
X-Proofpoint-GUID: GUIQgA9Ojxo38AtSOyY20AEfbksDT55-
X-Proofpoint-ORIG-GUID: GUIQgA9Ojxo38AtSOyY20AEfbksDT55-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

There are places outside of migration.c which eventually leads to a
migration failure, but the failure reason is never updated. Hence
libvirt doesn't know why the migration failed when it queries for it.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/savevm.c  | 13 ++++++++++---
 migration/vmstate.c | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e33788343a..39d4ecdd41 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1068,10 +1068,14 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 {
     uint32_t tmp;
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
 
     if (len > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("%s: Unreasonably large packaged state: %zu",
+        error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
                      __func__, len);
+        migrate_set_error(ms, local_err);
+        error_report_err(local_err);
         return -1;
     }
 
@@ -1456,6 +1460,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     int vmdesc_len;
     SaveStateEntry *se;
     int ret;
+    Error *local_err = NULL;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
@@ -1475,8 +1480,10 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
-            error_report("%s: bdrv_inactivate_all() failed (%d)",
-                         __func__, ret);
+            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
+                       __func__, ret);
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index af01d54b6f..3a5770b925 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -14,6 +14,7 @@
 #include "migration.h"
 #include "migration/vmstate.h"
 #include "savevm.h"
+#include "qapi/error.h"
 #include "qapi/qmp/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
@@ -323,6 +324,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 {
     int ret = 0;
     const VMStateField *field = vmsd->fields;
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
 
     trace_vmstate_save_state_top(vmsd->name);
 
@@ -330,7 +333,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
-            error_report("pre-save failed: %s", vmsd->name);
+            error_setg(&local_err, "pre-save failed: %s", vmsd->name);
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             return ret;
         }
     }
@@ -383,8 +388,10 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                      vmdesc_loop);
                 }
                 if (ret) {
-                    error_report("Save of field %s/%s failed",
-                                 vmsd->name, field->name);
+                    error_setg(&local_err, "Save of field %s/%s failed",
+                                vmsd->name, field->name);
+                    migrate_set_error(ms, local_err);
+                    error_report_err(local_err);
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
-- 
2.22.3


