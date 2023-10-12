Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A98887C711A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLk-0006V2-QK; Thu, 12 Oct 2023 11:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLi-0006PI-86
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLe-0003hA-SA
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:41 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39CAbVNX017937; Thu, 12 Oct 2023 08:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=txiZGE3q+Kla4HQYXx7EAoeqc8Ao49ucsKlinIQKW
 Pw=; b=GfTAgfPaNtvOTz2AVi4xHu9eY5Pr5HSFEMZ1n2bH+wKZ393Wb6ZaWwdvM
 a3S+CEezDStXPzh/9RF8whcVAoVJZQtmFJ/+EGSGB9TAE9CyhY1UtycD81e2U6cj
 /eWkz8AJAEAXOg3ENLWjKDDoxOXCluNof0WM2PBh5dSSb31bVWrsKQFUNWM/nPQZ
 p4MD7D3eAWdC67Rm8H6kfGJb2g9+9jaGnSvg3s+TtcfRM20ohkLxPGC1kzG14K2h
 z+VmL6PB+BvTLG/L2CoTBLCkmjQRf0nt5nCKSgo5BGV8C4OLsPvBQH2GFb+JxmC/
 drYwZw3kcvUYi+4r9MKR7i++ImSkw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv0bhs2-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIJe6GFCW1okV99UsXEYg8qzW+0K6e/CSOoTyVshCPK/IL4yNjfb5tty1q+2MG8Iv2UFJ0Y3yKI37owkcx9i03+V1CAfmL3Nbx0pLKY0+BtMbF3GsbkcSQdAueINTZ+6pA/8d3jSasaTmLNJlmsihhoh/j58YwTADwhtniic/Ipj8wnr4D/PD4hSEn++Gf32We5rXdn92XtF2DeqzUkRTibHsz+KSmOSgDWLyYYBPA6F6gYaVppNUXJKoF1TcBWvPi9GvPZXKT2M2EjuNgQCY8B20XuFKjh7O9j85T4Lv6BW//mb74qyGpzPiDI4C81474/PNREEJuWl82VJ2fC5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txiZGE3q+Kla4HQYXx7EAoeqc8Ao49ucsKlinIQKWPw=;
 b=XeSFAdAe0PFH9dOqnf3soDm1lKOpAMfzyjQQnciQwNq+FK/kIBSsHzvginv2QB8LCDu0ZWq58e8Q+/Tr/s1RUARo8+jJhzYIuYlzMm1s/BPSs0zwLWI+q4OKSMTeaZnL7k5zsT5snscSffCDJ/hnByseCaFLiFAef9INDyLqS6K/oV1Buj+UgveSdpa27C+DRy2x8DVLUNtGoSvACx8+lZoK9YAqqSg2M8VZB2Pnpl0ZGqe7X/lnSjdEAbTXtIzzGkRFCrmzWImQT/Je5PgOMiwleJY+bFwsFVXZRIquwHDALUMVzWXyV40eZWURri8OWzNMICCjhCqD7TytNlpZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txiZGE3q+Kla4HQYXx7EAoeqc8Ao49ucsKlinIQKWPw=;
 b=VqNOG/7FM+xh2NjLRARNS01hX9yDKqab4CFGgEuipDnWMIudjdSY848DoWdGKWoufKk4yAjbfmqiCNT+gQz/Dzjnqo5ld9HVuooe36dXB+hx87rmwiVrXGhyh172n+g5VAJLch8Bus9+NSTs3F3WIYukw2+wZ02Gl8TCeyTMelBow85tkyUvHzlyliQuG8EgpZe3A9yUeAbRY9FKfAv+JviAdPRvRAOvg6GL4UcJCXIqkv70x4OLtx6pmJdDgyz1jwZQ5+PB1n0WX0Sm/Cqvdumn7aqpj2PKaUquqapMGVM75f/aSHIgimtmiCpJLCWJPaFA9Lj8fNT8NUrfKe3apQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:26 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:26 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Date: Thu, 12 Oct 2023 15:10:50 +0000
Message-Id: <20231012151052.154106-9-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e3999e5-0b57-402a-0eb2-08dbcb358139
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bBJsCjwRBas0Jtpg576W49Ko25DUA+fs/rYXYBR85E+MoqNAzssmhSC0I9bQLWSzT/D/bz41vXFwSRAWWU+RSOy7R/Zvmd8zkaTnPM4yDnaEkE/sIJ+eGXMiXkEC4ZC8VJQxO6i3w2DC/xLFZQYMdHJAB+L9e2FCHUax01ENxQeWh/obzDVaFYiQrHY98gCg2c6BrJ38u8B3bBbOD4CjYgmPUdk5v9ID48tQH3JRQf+W8RIH/J14jF9NMeiRcIOzx1XRPxUp/7hqbRWnQ/NOV9h+mnOlghprg79gFdDoxQDXcBBg0A3SMRw0+bRA2U0qOdCK9t15XE3prKaQvok8+fdZKm9aDrHoxaVywuKuzj/2rKh7Gsgv4ShC0B1WSMHEoAtRY6Ru/J3+PKlQiwmsOgpFPln8bBp3cWydF1K8jKTwsfcuc+EhFN01KctCw0alBOukopJVuX7SdKPsHqftJUP+l6DghFOQKTeiyIPQN4Vj+KinlZ6jQ5kgKRrlB5WMI6DwdlomNvDky9Hrroix0cDUPC4R2fA1C1fNbX6uV/+b32TgA7oWGhL4fikLeDW3sfYZoCuXXvi9gbljMHli3UmoqZjBDtyxYFTKy4DEw8Z6dTcV6HpB4Aicdm83pfc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRcCTDiojghjncx/2joTfeBDc7RJgeF8ZzbHczY4GepS+Rm04KBiq/1a9ca6?=
 =?us-ascii?Q?93pL95HMatF711D8SPbC7X9KBSvfMC6L2zzWlpAycWoVDeeaArBZ1EC+DFmD?=
 =?us-ascii?Q?V4LtG5i0CDrly+fKL6syhhA6jLJfmR3mlfOH8KLEWridmw6YKM4jlT+8tDft?=
 =?us-ascii?Q?RUL4Qv059udNHMNA1SnXiYLZAKPREnj9/QGHy3bmTmw/n8nKkPXeiO+j1cQc?=
 =?us-ascii?Q?mWRwvR5j/Sd/RKejibq7LxxeJpLjsyYfFD7BXJmqQkX8S2wYWgvm7m2K0l1c?=
 =?us-ascii?Q?TImvYv7YoYwtqclwIXhk6uzpsn4y1MYYaCsHRqviY7iTZTgjJyJRwCPB9/yO?=
 =?us-ascii?Q?yj/QVVgapXjLgfKJ1SjR1atUhwikTuaasnK0t5AnzDtQ7+0Fkug8KNZfrYSc?=
 =?us-ascii?Q?ZyMkdibCrzzvc99B+rPqqkQStJkJWdt1NAVE681nAPPtv0Ip0pAAVD1Nej18?=
 =?us-ascii?Q?aQqwLx374x6Y92G8NC3Y4nRRtJ+24XpcBbK25wRqJUeQJa3OCce06yDI2WYq?=
 =?us-ascii?Q?+sPH+aUYRi9tgzkz+0OabpxB+AoG6SuSDUjQoEY8OnNHTmzHR9/u5zpWY59T?=
 =?us-ascii?Q?LSo2nPs2b0r4yP6MjetNjummuWr1vvu7NHzBvUF8pWGEIXc9aOaKr4NYmpjM?=
 =?us-ascii?Q?QKa9Qrt8xtHK5JuMn1xAyQfQ2JDRVJAct/3Z+p9lWFQ1CFQ6Teb/x0DkLpw6?=
 =?us-ascii?Q?ukBYSKSgRhgHQj59J7P9x7KZEeqjGCQiak0SBAYsWogTfDOUhwP0nXaPz5Tt?=
 =?us-ascii?Q?X7v5qB/Lt+mgwI/TpsWiT07iEJQqT9Bv706GNY2tPreFPg9YbUUJkbIud3Ve?=
 =?us-ascii?Q?qrDnLYI80QVVB/x2uaHHTvyAZRbuc5onG9y3WUSsqqQTpDbF2N5scgzxZhNC?=
 =?us-ascii?Q?tZFv9IcCIk4o3g+StrWn+zrnAf8IabF9y/kosEIE8hdnmbukpAo6VQUN6s3f?=
 =?us-ascii?Q?dw7Ns2UlNhVT2FPMyke2HIpjGyNgpKPKQ4JMQLNm6C+y61VMc2RzHkB4No6U?=
 =?us-ascii?Q?ZWkW0U7cUY+j2Njm3Y+mJnlx9OhMwBnOGF1VhaESMaBlS/6v30qJQD5A7EQV?=
 =?us-ascii?Q?RZWW4//PcVhJTG3x88QexUsWvqciydvI4r1Abbb/NwBMKvUGPw8VKTCzEnaR?=
 =?us-ascii?Q?V89Z4k0vvNw9rEJRbZXeOAgYOUSdZrAt5mEl/w6XxGRaOsVmvQMjp5cGBaP6?=
 =?us-ascii?Q?vJY1QVVIPRGaHLVq/sbCn7W7XZ2d34nZ5SkHm5mBN1GWm3blh1ZTwY5XFuV5?=
 =?us-ascii?Q?i8OKSXmUVFDbpblDS9bC/PWGh5p4qD9fiuedpvQJKw7Tzp+ky91h26+Mx+Ir?=
 =?us-ascii?Q?8Cuaiz+kSjqFVfYaVK3/XR090g1POqPxYuVMr7MUywGJUUnorBBDkg5G7tMG?=
 =?us-ascii?Q?Dtm0p/fHgFcoz/t8fcJjKIHQniTbBiVQk91Xztj2zEfSEjQC0jQEBEnC4zXh?=
 =?us-ascii?Q?Fn1ZQu07SpTNVLzzmKtW8be9TXC5cQ67rVby4WQSqu7yvcY9t5WQ1TIR0QhV?=
 =?us-ascii?Q?kSEOml3VDsMtLhocF+9ffQPkVZEShk3DNgPpL9/MdOg7BY96jPYImSfNfJ7c?=
 =?us-ascii?Q?byEPve0R8N4EsBDIoAxOA9hvhtJBst9hASGxMnvS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3999e5-0b57-402a-0eb2-08dbcb358139
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:26.6381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7cerR7/MFJbl3YG0caAN1nIsW7ISRdJpo97j8LwwJMWZSb1eBnGJ8wCNuqr8aTl8KmQp2aYWnjFihAp+Qn1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: KyqQWlqq6HyPQICDVUymj54VnY8TCWYl
X-Proofpoint-GUID: KyqQWlqq6HyPQICDVUymj54VnY8TCWYl
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
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 95 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index cf5a620c8e..7db1f3196e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -433,9 +433,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = NULL;
     InetSocketAddress *isock = &addr->u.rdma;
@@ -473,7 +474,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = g_steal_pointer(&addr);
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = g_steal_pointer(&addr);
+    *channel = g_steal_pointer(&val);
     return true;
 }
 
@@ -482,44 +485,47 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           Error **errp)
 {
     const char *p = NULL;
-    g_autoptr(MigrationAddress) channel = NULL;
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_SETUP);
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -528,11 +534,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
-#endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+ #endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr->u.exec.args, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1768,35 +1774,38 @@ void qmp_migrate(const char *uri, bool has_channels,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
-    g_autoptr(MigrationAddress) channel = NULL;
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1813,8 +1822,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1823,11 +1832,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
-- 
2.22.3


