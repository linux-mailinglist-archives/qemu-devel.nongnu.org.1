Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4287FB221
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 07:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7rwM-0000GX-GA; Tue, 28 Nov 2023 01:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7rwF-0000G3-Pu
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:51:19 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7rwC-0000ey-3U
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:51:17 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3ARG8Kvc003348; Mon, 27 Nov 2023 22:51:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=H9ZBnWNKil8
 LX7hO6gLin8dH/O5MOLwzC+Xh7qpj7HU=; b=WDumhCEKXL5BIZEB/f2vKAZHxMP
 /+AqGp7aHoMOfRLYF5wMwLtjhivsu0T1SffLWJOyygSjEI57WZ0mHSkCIOjj+/L/
 aGnqoOEg9Xtf+zv1aZU4l7m1P3ofp0j3JxnDfT1Snhn5J28x3ljIkPMYW6X/WHGN
 3to3ykR+XKMgEgwztDYMtYiyx3qvixd8lCVSuouzhxEFMI/HbV4rIyeP1fYEHv8E
 HtlUxToRv4h6W/3l7Z9xbx1cxNCg1IZA4W+td0pL/KU8BcgQ1JSPNI6Q9bzgjpKa
 Mc/PWIm9B96LlfOCz9x640VW0IymnfVKJKWTVG5FydYpgyzTXRA486s4ISQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ukfwm4gjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 22:51:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7k6d1JfwgzZ0RMBPCRYWX6Px52X2RiFPqy2TBRacbGAEL9vAYYciDkJaj9pmzHzA8mGHLmkiyRxvRlCBL/FnCERiKWkycda64x5OGzFzmeHsrISFkj5ePERjwa308PIQQNYuAKxGQyWXunSwVcsQtAeoFgY/vOotWX2ngii6AwTn48JfGnFwrL2BZytAvLK2VSacFrQwqQEGN0wwB0Jw5DDUWs6iZiinOrDa3LLzQEO2ueSffKWS6SPPerDiI0CLwfmAOcy/Uq+k7kREBrcegoygGNhUuBSYkRLflQIz7MwhNjyn2+jtPYms6clmZ6zn4byrYekqGcGQM2M9dfa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ZBnWNKil8LX7hO6gLin8dH/O5MOLwzC+Xh7qpj7HU=;
 b=V1NjnGrrEnMXl7q/sINZyHiZNEhDAryARDtCpvIBa0UtjOqtzMtVX7NirsHMt3gWYj4B88vF2I1BukKymWtgj7y2ZfiINR4tFxU74msiEIYxBuCb6zz7ZMG7pNN4M6jYpxIPXS6pIxfPQOCK9Z7ocpMizkH3XbzyZf1z+XK+lzaG+i7Bw4J2Vp49qSGDlsi/kE/XcNWFLQQ8h9uPmwpoFbcc9cwr3hQT0dkqjlg6NauiRRSfjlmb6GHX/VzT5Gu7rPM5UvmarByuuw04qaUxtKjmhicK7bT311Sn/ISDGEIManQOJedn7GTRJQA7swJffMBeRkrOYSacf+MEwFsadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ZBnWNKil8LX7hO6gLin8dH/O5MOLwzC+Xh7qpj7HU=;
 b=CQKeMDp84m2cfFGwZ3pIsIMlWZsNA9lLBoJ6e8mHd73RNXIX6wiFDJ2jmQ0ZKHm2oI8/Cwd0ItNvIQQvVi1KzUOaakmIi1Yq9x4D7z/Z9T8vC3rRi0rtVQu5LN6BsqrWbNK6QjEPs9pXsO2bLQJBR8Uk++GjyiADFdplZvxGuQnhsgZ9ECiEHvEQg+verITrl67Y9hd2Eco66m3gdcPlZBJa4JukYX7yOy1tMvueMZOxclvJj/XbcCNCryKb5D21dVV8c8xpJtUzPW7mBP9kRqjkvVIHk8RWdYZLhaWCRtDg561qybNjn9chgjewe6ujvoHg4YELmHn2WytVoN+Mww==
Received: from PH7PR02MB9944.namprd02.prod.outlook.com (2603:10b6:510:2f7::8)
 by CH3PR02MB9116.namprd02.prod.outlook.com (2603:10b6:610:144::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Tue, 28 Nov
 2023 06:51:10 +0000
Received: from PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17]) by PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:51:09 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2] migration: free 'channel' and 'addr' after their use in
 migration.c
Date: Tue, 28 Nov 2023 06:51:06 +0000
Message-Id: <20231128065106.120238-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PH7PR02MB9944.namprd02.prod.outlook.com
 (2603:10b6:510:2f7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9944:EE_|CH3PR02MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e5a4f8-16ff-4649-06f7-08dbefde6716
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHzXeWcxz6407GRYHq3jVC10CeUuexUxeWqOG0CfFfQyx/VPrS1ghMIW2lFeU8ehL7bCuI0jvDv55ugOB/a8y/HofRyZituWBB3gxGOv8kZB1hnZiEGO0X9/zIUWaPZ51fnc206JjZx1O4Khow853OnaY+IUMJJieX3zsg+pVHNdWTdI6b7Ugp7CmAxGKOxmKcH8Fp52mZDnSE6tKRSp1g2PA4kvKZnaPbsog5U5R8lwZwwx3KPprqfPE9CIoUvoxTRjsUTCVWJzP229K6t3FtHX+tWHRNb8XnB4FRtvqyN/BQBDrJtpMDblkKpoeUTFj5NopqwNZjE80w9IV1UB8aYDHznsCFgJLicdfXUr74Kd+f3E0fISSaVUTI9FchnuA3yHYBvloq0PWkn58yHoEnUp51ur0QZXayu+oUNoBLWmWBpeX3DM8O/IAqjqe+D/8RpM/D/em3lJEAP2KwUBNUkb+IJvismm6DDWyt+St+BMI1fGgt8EDrTCIN+e3EOeNJ5JvxAlQqsRQITGsjR4UFcVZk8zDUPB0A+GIyK4HxsTZ8Nl/YPceRKvnUUdr1fZ7wuo5dwy+JMZEPL404qhdPJU6SJ2EX1fkFUz9FcjsSKfrD2w889k0wX0BZPN7IHH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9944.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(5660300002)(4744005)(41300700001)(8936002)(36756003)(38100700002)(38350700005)(107886003)(26005)(86362001)(1076003)(2616005)(52116002)(6512007)(6486002)(6506007)(6666004)(316002)(83380400001)(4326008)(8676002)(478600001)(44832011)(6916009)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EvL0D9FcLXaOypAlJ04zofpqiV8UIxUB1Q1dT8Bm1G0yFxEP0w38sagrD2Sg?=
 =?us-ascii?Q?XTOmSHerc7D3U/XAUjHSLdiN0+bFzYcXxp70BnGeMJrbYv6oUx1SrBcBFbkY?=
 =?us-ascii?Q?E45/dO1E75VWd8aBV75XiWCnW88r3S+cBGEphNRg1YSmec3wZPw9aJ4tCkPk?=
 =?us-ascii?Q?S8k/zWksqSamvMgfMkCqDJAdL9irZTy7c4cy0F1Vj2By/iwn/cnBrvH+wdEa?=
 =?us-ascii?Q?6fYMmtYlU2xIxFiuBWD68yKrhxb2WP3o6Hr8qudp6a9QU2ot5kyrr27kn1Vk?=
 =?us-ascii?Q?nQAm1GEOsHreik8zAYvJPoYWxL5274GXOeMYBvQ+APZiAxUjY57OEj3/Eq3G?=
 =?us-ascii?Q?5ZvXQvWzO6POJ0IVIbyd/3V4cPQ43dbEif6Aw1/iXjrsIhH4Um8XQVj2GAF4?=
 =?us-ascii?Q?HJ3MVtIrCEvETh5KVmXhyc7P7bSK4/6rdnOqS2TIQjNiCVC4AShcrF6Qpbqk?=
 =?us-ascii?Q?+AN0H7aSoZi9MRWssomVUY6augWwueiYJC3/dseWUe8Vyk/NVcWgQ5u8U23m?=
 =?us-ascii?Q?QpZ77I5gH9/EcldNT5SZ6UhmFkNR6xyx7Cm5nZ6JWQUEVUOWWh1Ig8ql2yI7?=
 =?us-ascii?Q?pyJTU5dsKEy5tyyEy4q4xmYLoifb6P4oegnS4HucP4sqzrfW0h4slsxHVLyn?=
 =?us-ascii?Q?jDg8sxHkVnpO4DvHX6Ntqvo/1xwkuqXrFEr8cm8G14Wi8xLQL06UEmSXYtAB?=
 =?us-ascii?Q?S3+vtwu8PNPXLsjdUdRcNaiJDb+ZzpHl0V2gGyLsKNxb1p83X7NnzNZH+itq?=
 =?us-ascii?Q?VxHlyk/X3CUsVIuo4Ncc+GIY8EzlGdBk4yldPfNkwP4tgF4zLA/YMerHHUZ+?=
 =?us-ascii?Q?4MGSlJK3PJC3xdUgiJ26Z/TB9VI7njrc24u6tZRRHUrRJDYunrmUzYyeWtIB?=
 =?us-ascii?Q?F0W3yVKBrKi9VB8nF25wSnraJQXe26CYoUnDxnytzxS66A+L4MaGlEfIiJb5?=
 =?us-ascii?Q?BWemX+u2tmKiHZU3o/xvdcBymT11LnKzNl5gPeMWAH5vNeemco2V8vZy3H51?=
 =?us-ascii?Q?Xgo5FM4onQHp2VyBxQO8PSrwd7wV1fH2KYXYq8uiiiajWM3yBdx/quraGKPR?=
 =?us-ascii?Q?dWOJP2rHG1iEiMDq7zTHz+bY/rI5krLbaFsr6wbY/FzOImlUEZ+77sJ/QUEO?=
 =?us-ascii?Q?vkq3GWro1Q5Us5rnQGhsJ5rpIlTjjiTRdLzbRkb/baKDUUfhyRjFRZ8Fm1Bi?=
 =?us-ascii?Q?D64FCdiQ3keNe8ClagxaUuNSn1vsegY1KR5k0KObodo1f2QuOG1U5cE0a2tK?=
 =?us-ascii?Q?IuS/MC5un8S9OarM/PZ4u7uKLbzUq2U7Hz2UsT3hO11o3EMhiVNtIM4bw/Lk?=
 =?us-ascii?Q?RZCnuwzKcz236WR8Pwn1TeTXd1V/ukie9SvGLtHkaW/WmRbmjIj18N2AwE8l?=
 =?us-ascii?Q?b2xj3/+OLj3Tb0NxStdw2JysQqpBqcLusXrxUwq1C6kpUAVjT0k7GRpyRmmZ?=
 =?us-ascii?Q?vQEohKj4RGwaZfoWIDHa8Q+TAagZO2RI9iX0JhduZJM51sAVRzKlwcuEx8E9?=
 =?us-ascii?Q?VnU8FzEVADwVwKE3VaW60lbDdAHIF+704WWvBM5MgV2NZre9ic8JTnfr10gP?=
 =?us-ascii?Q?FGvFMLL8ZOApEcNNcep1vPzPd0MwU+zOC1JXJZzSNJ1SUDXMFsWOCew6TDML?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e5a4f8-16ff-4649-06f7-08dbefde6716
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 06:51:09.5959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml9AFEwSxznDvyZLK8eS+rWbn/GY/RCuZb/Pyus15R9MKEAobN+Rf+9wbV0DmIWNVS9YlTFjVtMfFwKmFgZIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9116
X-Proofpoint-GUID: waJYpvejzg8L_nlj_UmvINdaSmy62ksk
X-Proofpoint-ORIG-GUID: waJYpvejzg8L_nlj_UmvINdaSmy62ksk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_05,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

'channel' and 'addr' in qmp_migrate() and qmp_migrate_incoming() are
not auto-freed. migrate_uri_parse() allocates memory which is
returned to 'channel', which is leaked because there is no code for
freeing 'channel' or 'addr'.
So, free addr and channel to avoid memory leak. 'addr' does shallow
copying of channel->addr, hence free 'channel' itself and deep free
contents of 'addr'

Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
migration flow")
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..29efb51b62 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
     }
+    g_free(channel);
+    qapi_free_MigrationAddress(addr);
 
     if (local_err) {
         if (!resume_requested) {
-- 
2.22.3


