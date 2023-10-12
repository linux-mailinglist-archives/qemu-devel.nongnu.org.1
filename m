Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F87C7120
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLl-0006Va-S3; Thu, 12 Oct 2023 11:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLi-0006Qg-Hd
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLg-0003hI-M1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:42 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39CAbVNY017937; Thu, 12 Oct 2023 08:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=3Xg3QzICmN8m5yl5q0Qo77o6PzxIUs5dsxgW21z8X
 Nc=; b=QyKoExGx2m0YEqQz0/8wY+6H4UJG+aBPfPSuACA1O7DZW5G4XVyJ41WTp
 MZMnnjqE29S6x0ATzCWdV2NA0v9KHr7cN9KVCFVeMrkdY5Zy4GXJfF/WsBkHq+1W
 2A+oYVTMo27UUlb80pfJeBwOqzjdFzhUMHADYLsmJU798FAVNFSGSVB2vu17Fh1i
 wMSkKv7q66dRFyf1CNS4j81007uMVetG1Bfbh6INK0mzpYyxxWfUrRfp8uqS9rRN
 uYcs2s5CULohRnEMBzsV2+C5HZV1Fu+ZGCyWX5LVbTUkjhuxsu1C3fGT9kMV4hMV
 Cf6dTx6+EMQl7exulr6RuxXcKbqlA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv0bhs2-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU47dOH5C44ZdvVUicohEBZQNYsil+iGviQcNblNgea5nplDkwxXHqTImVkH8SpytBi9liTaiHEPlrPfYA1MTC7R5wktprk1hzsL724y9Mpv6ODJPwYZ+O7QwEfFAIPSrDBXekaSTvgqd7EldYyvk4Nv4uwcapcoAvBD2p0DGcb7c/rmYtW/nXZW3uAZWYj3GCvR4XTFyMfcFZ+Mj8S7G3uwTbmPKmN3ymYyOBuFKF7ayzA2DnW+qbSEtRC7ilW3XJFAo4BitsVyjZ2YWba2rv8LI/yg+dtVtrSLBso0lf03fWOiY3fq9h+8J1Neng0w51v4i9JKqDaocmoKy6T0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xg3QzICmN8m5yl5q0Qo77o6PzxIUs5dsxgW21z8XNc=;
 b=A+WibXMRNDCfSkzHD2w7Uf7JsTSoRulGTkfk1X1cKowkV558/XaCG9M5IG6sVhtFESv/tH2b9N3h51Q7WqYbGGJz6yjK0RMM5YeUyTdXt9ier/rDzKakFF93RzOr/TcUppw+ee3d9jnR1G5smw4AsTCsELNAEimXTck/5zJviUoyyQuEyeZV2dgqwnIIsllAOfaXZ0e0T1b9TIsm5CYJvFungcpy6+BdBJ579iPK4UGNtNuepIKtQspUMGzjYJ+5IGvbr+EYeDOL3RWwvz2sThbmtk4tQt2OVFLzoh+eeMWcfNdF6++2kLJnP+d/3U3n1H4cn53ldl4MHKqrf5cRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xg3QzICmN8m5yl5q0Qo77o6PzxIUs5dsxgW21z8XNc=;
 b=Dhl2UgLJ1aqvol19RtczRnXGfaadPI3Ctbh/gztcLT6+k8ujK9VMcAM8EPOdfJhVAUdOufukmf6g70z1LvSXZ4trlUOL0Lx5IC9y1Tlg0och69Vlv0GOnxJwvA4WvXaXOAUPyJpNLChiuYLZC0sFwDp7OpPD1Ey7wTxur3zMQxJUkP0E/4Yc61fOaKtuIM7mLM6t0iUWd/FJIciiCGYJ+wLapyA+4vLtUlxWsAUgZDF9RkkcpjhxgWTVOiyPhGZAA7j/KBfCQnmpcLkwma8qjjHxDjE5RKSgxh0AKqrMKgoAk/ESCTHqolCUmeVlXG61/g03URt8aDtGsht5iDm4iQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:30 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:30 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Date: Thu, 12 Oct 2023 15:10:51 +0000
Message-Id: <20231012151052.154106-10-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d34b4d8-bb2f-4fcd-3de6-08dbcb358343
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU6wMxHUdopYU5fIojYbRkeMyVJ8Daq93W7tP29l8s/e24LkqnSZdb4uXcwv8/peNdZxwcNORkGCd14fwPyQVgxGp8OSX2gaCIzszAb6C0nyhV0SBOV5Xb73Pn6NPazNKk7i1grMIs8/3FDH/sqRD+YwdTBX8UlGJDGGNUYMmzcRDJIpE68D7i6fc0ZfICKCrqtONZWW+N3+Hw4jB1ocwxqgE2k9x9uUrKIQMQvvHTQiGR9av9Pj2ZnkNX7Z0pZ7D8i0+NSA3uvzA9mMQAQzJdxHDrUeXl+Yzs1NH/szAMqXwKG9FtCGjZYf+9SPCbfkPwk7dRok7EeQc3Ys9A+XwPeuZvQz9Cce0YAY/71jGILdoZTWAS7RsgTXMkWLvnHQbvVcVyEB/sUSOOfac/8yw1DIxPsbhDiShGS8mTYI9dlE9o9wr7zxYup82NQDQtlet3ZcJNtAduYSBp+QOBCcoxHvxcNQjQBgcQw36mf4cSTvlb5cQxQDBV7A4SWNGVYcQjk+NaIelUNCYVYl33+Werarb92SVpgFyD3NDF4AgKWVDLiMCPD4WEkPsCVlenFS9nPY0Pxomm7SZHyqOn6+qrxbeQK6DNW5u4Ff6gJJW+5v++mz6Noh+UTQC5JRKYz66Awjo0J9qf0h9HxCBIhjyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(66899024)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hoskpACS8lS1MVJuNZIvq/xhuKATDT+dW8S519LZk2vPQxYP37fi/PFig28x?=
 =?us-ascii?Q?Fomdjz+b6qOP4TLWVKmNX8qXel388o7bSGJWaeL25irrbpt4qnFnzq8QPmtr?=
 =?us-ascii?Q?R3rsUzJm5aXXPYs5ymhCCb7oc0egpgqm45wlrJJjqGQ9UB2g4/ZvMDmKswUw?=
 =?us-ascii?Q?OMhKfw0+KWINVUiYlikb+Wk1Tyvi+2nQ+MGzprtM+HCXIs5KGEe6wGLPoqXb?=
 =?us-ascii?Q?oBoKXnfWFohfcNM1x61HGExcG/nv9wbooW5m/l2ZFWhFR4HAqJU8l0VYQpch?=
 =?us-ascii?Q?jmpAKuf3k79AFX0/OJSlKQud/R33tuJK9rkCiFia8Fk3fjdTutUxTRWYPZUS?=
 =?us-ascii?Q?VQGxg+dbEhjKiJvfuH0aCCXdbdEj1ElYOsVuJ+BZAJvkYxNhr9+wx9qkV3Dl?=
 =?us-ascii?Q?kcpxdkKIQDcMsQya5Sm/T0HEsUEuiVDuF01hSvg9mUnJfEIB0MypsX9E8fol?=
 =?us-ascii?Q?cq80jXi5dr3qyogG2xT2I0p0pPF0y/mFmkaThTuJ/UE7Lr0W9VFsXVEvR81j?=
 =?us-ascii?Q?Wa5Lr9X4H107VyY3p4c73c5uCterTDSpfwttpIrbAehQgLEayl6F2qnDbYPC?=
 =?us-ascii?Q?9/skzxWo++BL8Sgd4vvMtxth4tthz7v/Jd7W3wOePAdCkGPaNLWQK87uJeI8?=
 =?us-ascii?Q?KYi5aW3dviaZYQnjJAnfTIDvz23rhzq3nRq0BIIO09zODCpNc/2kmqetu/jo?=
 =?us-ascii?Q?+rbi7zZM9LpGIdL5QRWzbRmMrIK7dDoXHvRvqRgiqp2y+OIWmQZOMa8fKXa6?=
 =?us-ascii?Q?0chkCuYdOW+uaH1eeuE2p3/v/C7MUHu7fnV3Odq44tRrh13FX5dCoP16dAUh?=
 =?us-ascii?Q?WYkRl4rPB4zICItDPSi42WzDUbcdRmkbXyT6k/f1ZJYDRBN8jhj15ZawoCx4?=
 =?us-ascii?Q?wb93JhnGNnn7WFw2LK4L3S82SJUi3UIxRfVQQmWgsE0jzeUYQ1N0hbAVj4xz?=
 =?us-ascii?Q?ffk/XkiDlwfYkQxtEyoGSEApu2Pgvj8eoGMeiKveMfSe5mKaxvoL85AQsNI0?=
 =?us-ascii?Q?/lKn9LbnTGuURSAJEStbCH8C70ETp+VrxJUmHK1y922gEWKahzEyxJ84h67S?=
 =?us-ascii?Q?8Mud3HVd4EXBIM7+ArMCzXW0HAJKwBVCMBozGd3WaIHIIgoZWGpkfdrWuZvG?=
 =?us-ascii?Q?nvbOOvbvA22oqN6yhbPBGZCJ4Vtd7TbZOGZYrXFH1JYe42+hrj+3XMyG/UHs?=
 =?us-ascii?Q?4L05du3j4a33ccdcuMRo7ziUCIdjnYuAE1t8qs2fMjSj9iwtpnZWKkNWOziS?=
 =?us-ascii?Q?1oISloE95rjFKKIxO23FQKRwQ7FctuqDWRgUc+7ZsDrJ1CbQuVPWtVlLxft3?=
 =?us-ascii?Q?EyEgFw+eW98W+maiQPbZl/QwUEDakwR/hVTaRiISRVPSh/+DOygq7A4nmueC?=
 =?us-ascii?Q?BdIPBktc0squROK9wXq3MbknCtUy0bnycvAEQAAxlyBI46+qKyun3lkxjs0o?=
 =?us-ascii?Q?4i+e7dAceqGPdju6IdbU/Kb3tnig6PIrKhUwGqF4kTWKOYvaQm3v754TjKu4?=
 =?us-ascii?Q?csXwFp9IYQiLxh5bwEjOsKHWdhTR7irSMxyX20FpPxzC20kC7b/uyjQok3ZV?=
 =?us-ascii?Q?70KUwkN/z2q+JG4oM8YDgIJeNVE6cu9maMOEuliy?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d34b4d8-bb2f-4fcd-3de6-08dbcb358343
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:30.0754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Vc1xvvOzc9+UEmxpuprRxcnCXYltt6WEcRqc3ClMqC++Gi+cmQFT3wx+Iey3kNLbrsayNTyYvhJqpMQOxamtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: nJ_jmnVGkob37XE-DLwdLJdFhn-sbOon
X-Proofpoint-GUID: nJ_jmnVGkob37XE-DLwdLJdFhn-sbOon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration-hmp-cmds.c | 27 ++++++++++++++++++++++-----
 migration/migration.c          |  5 ++---
 migration/migration.h          |  3 ++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2e6a5c51e..6799a699cf 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -441,9 +441,18 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate_incoming(uri, false, NULL, &err);
+    if (!migrate_uri_parse(uri, &channel, &err)) {
+        goto end;
+    }
+    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
+
+    qmp_migrate_incoming(NULL, true, caps, &err);
+    qapi_free_MigrationChannelList(caps);
 
+end:
     hmp_handle_error(mon, err);
 }
 
@@ -730,12 +739,17 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
-                 false, false, true, resume, &err);
-    if (hmp_handle_error(mon, err)) {
-        return;
+    if (!migrate_uri_parse(uri, &channel, &err)) {
+        goto end;
     }
+    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
+    qapi_free_MigrationChannelList(caps);
 
     if (!detach) {
         HMPMigrationStatus *status;
@@ -753,6 +767,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
                                           status);
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
     }
+
+end:
+    hmp_handle_error(mon, err);
 }
 
 void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
diff --git a/migration/migration.c b/migration/migration.c
index 7db1f3196e..ec01ad34ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -432,9 +432,8 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
-static bool migrate_uri_parse(const char *uri,
-                              MigrationChannel **channel,
-                              Error **errp)
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp)
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
diff --git a/migration/migration.h b/migration/migration.h
index cd5534337c..2da414e8cf 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -518,7 +518,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
-- 
2.22.3


