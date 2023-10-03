Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B17B61CA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZK6-0006rf-NT; Tue, 03 Oct 2023 02:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qnZK3-0006qr-TK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:55:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qnZK2-0006mn-0E
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:55:59 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3936cxUC005323; Mon, 2 Oct 2023 23:55:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=jgiwlA1uYSx
 k32DAUo4jQYB/TXS4cWkPu1ozLC2yX5I=; b=ae93oHm6nX/DAiKS+89xIxuNl6e
 kl6g4rGmRlM8sP5gW+BZHUtbQFTSkbFOm2CbHw0aaxR/ATqh1XYVrgJFmRLDVJKK
 Bz0wmcPaJ74fmBwQJ6eVnDjjCbWwfzb2gZpK40vtvFqNGSIfRRWhLfylHW0QNtwa
 XWn6dMCs8cGzeyX8CoJJgCwbSChkMRyV5p6MY+kycROoacWkznVXk7LSzUJ5exfu
 PAaqqxliVnDXOrVPT4tTC9bFzOdxCGewfjpWW0rVrPkXCiXMtc3CC//+l5tPUVfm
 2HeMNunGb3bfgHma2wGEsWOlnLCMyQS94MWUnYxeWqJqxew69cSrXGaxcHg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tefk6c7v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Oct 2023 23:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P19NqGOPLv4vGw6jN6AtlAXJOPp4yCtllXT79Z4JydpXeIi+TPHnY9UzYYV0rKy59fQ6EAc59ylFnE+QZd00DDhDuBFYDXCQAhJOEX+ZYOvmLFpns5fCSrUaafDpxqw0H/G0YbovOKY3lbAEtrrZUPtqCjoNZFZhpiv44lGR/hZHZ+uGoL7g8agmds8aHE7dwzuUzSAvkktAr/PwAAZkgo1vcpcVYqjbPyeAkznDVmxWp7prXpfZQ4MwqCL0Hl4kvuBMRFfN1ZOXXmhR25RfJcwzFt/F0EyYxkeJYaTtIVjD9hYcacw+XZf12IM0Ifq1Sx74rMMOiUIvgN+OUpuZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgiwlA1uYSxk32DAUo4jQYB/TXS4cWkPu1ozLC2yX5I=;
 b=kRXxPF++OBdqrE9DwflUUFzhr6o4CZeExaeWT6VaEd23KND3TRCbpSq64jluXZUh4ySXQRDziN4ihN6fKTB9EiSLzvteNM+KQRfRXKMyNyVPhJ2tq9wPFuBkDKDSMhb0waw7nD+tdVw6hVcq2zDgE3N6nBe7j+JZdrly52ynwcPf96FDkNhYYhw08gt+mg1EkpZJ0u91crvdyPsxx0X509m14gjJGJ32FyX1i//3AeWdrOLm+IrDRO+GfzUnPtbzcgeZFGyR4LHbhx2hLlKj6pPON1vd0asRhIG03bMhZulQAyzjAyclnGTNp3HxTHgx4q7z2AV19mrH4EM9+YVFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgiwlA1uYSxk32DAUo4jQYB/TXS4cWkPu1ozLC2yX5I=;
 b=lGxMj74RmNO8q65bi+5jQkTkXaHIhOQQxbqL1AL8NuHT6h90wTTFj+EHQRNfeKy3BG8chVeXt+INnWNLTyeQ69s0RYHebbWBUTsq6lcjoj/VUggh4UE8GCIgqPBreiLuVqINvvo0IMtCC5R8EPkFAt4apNhxqKSBvJrsm4dLi+t2v02PP45enzbOFDZEwdycqwtxB6LW8Sxfa8ww+76leJ8anaj39IkGeBsM15DcoaA/3jwBEmaBzq4rHO7X0Kc15uYBsJqtXuj+OfmuSJygwSJeNI2eh4ld+1sp8Emtnj+nmVimCacDIFtBWlzDB1nhhN5OMlmpVxls6C4PcS3oFg==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH3PR02MB9746.namprd02.prod.outlook.com (2603:10b6:610:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 06:55:50 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77%4]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 06:55:50 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 0/2] migration: Update error description outside migration.c
Date: Tue,  3 Oct 2023 06:55:36 +0000
Message-Id: <20231003065538.244752-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::31) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CH3PR02MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d59bcc4-eb84-4815-d934-08dbc3ddc75f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTBAC6YYQsAdYQyiGKcaz3XyhXxUGE2tUCUSw1LSCV0gB1fuYooBH9o4oy0c7eGlEPVEDiuBW0Ar1TIYIc3QN3/3ztCL/jsvyQZj5SkuhYKDaXixco0ek6L2Av+A2qygjoGptSki5+5WGrpsdzAYXk9r/WvmFkF9XKYaVvIVhqT3RNpgB6ADE+KQ6D7vkAJiaKY3EmvFM+M7leGBDbh9sWUyo6UCvjt+YJ+SNxNK2dhtBYxjPHAJZnGxSK8Jqufid6nfVFzkfSqa3KDwY4561M78kDY59aKFBSYk0j7wmhbKiqmVC1t1908ySxsMfsis+BIvQe4XkhXtOO79ONGvNo0LB4yGZ/inkHqTEZmtkMjYDYgwOUa16Rg/l9iGZ9TFlGWwAr3/1OqC9OpqND0wEP2lDxSAg8DCLFGqmxVSGdR+NdAQXjz/1PS3kI0/RJYi95I2+ziirXlgFJ9LQqjQ2gM3YENUapVo3E7FUgyKJhPCEHH+UuV1vNboMIyYq/w/CYsTVhbg391vfxuJPnI13GtjhQWK6lLn5inUUh++AS+eU7+yGM2XmuU7KnEXiBrmGci3i1CUmhTZjaNQna/6BEcbaASTkuGMr096hvuz2rdjW17j/kMui0kZS74EMKSb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(15650500001)(316002)(66476007)(52116002)(41300700001)(66556008)(6506007)(66946007)(2906002)(4744005)(8936002)(4326008)(5660300002)(8676002)(6486002)(107886003)(478600001)(6666004)(83380400001)(86362001)(26005)(36756003)(2616005)(1076003)(38350700002)(6512007)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5a/hn2+t8004uPCz47c8w6bVQZJ8qqYqMCkpCRF5nLyTtFDm4wJe7b6Y1Ye9?=
 =?us-ascii?Q?ODlGsAuS1oUCvSksOptWLyrWxuS59IRMF8AOrle6cOwYj11sygUSgSz5pWaD?=
 =?us-ascii?Q?oAYjHjH/ysqErAQPt//mj6vI2tjhCN9Al39lhl/lLRzBlTLVVH59cuFvL3vP?=
 =?us-ascii?Q?ilxyP38gDqUO8LmaXrjJK/SdNKna7AKnv/6Bg+5ZXcn1K213kBQdKUKHxOIr?=
 =?us-ascii?Q?R7laZeJIPKmIr/nM/XlVHYMWrWx+Jeflg0h2G8wBZZnc11lry8WzgJ/E+jus?=
 =?us-ascii?Q?KlLepSBmgk0NlBdO5v0bW67cBBv8/16xabUI0UawyalevymtEuMTCqqg6sCd?=
 =?us-ascii?Q?43ItqstMYSz3dN4q1CzmxsnWM4KPsHfB6+ftKvXo4PB74E9JFpNcnC2etmcw?=
 =?us-ascii?Q?Pz10AMZsaCTt9Ds8DwX32aM8KPwWYdKMO3tAZg8fnRX7hw3lzNIxJkNtPlmY?=
 =?us-ascii?Q?avXLAoo426hNG5kR3ytx8OvjiUzfOyzcRwck2E/CAaapWzgzimIl9q1+Fu+g?=
 =?us-ascii?Q?NLu+hg4HcoRT9WzzAC7+gPcOmjEWDaDI8IjugMkQZ6yipdFvkOE+X7A03xXo?=
 =?us-ascii?Q?sLAZ0+EVHHPOgbbBsap5kqpkr1bdURXEBwikh6Zn6A3u7A5buaj0b+CEzU/X?=
 =?us-ascii?Q?f5pwLwUSpgDpiqX7LrcVFBgK+I175RXEYWIGCMuMW0kjsWq61z6bhk0Mw+Iv?=
 =?us-ascii?Q?kSvCWK4HDPYDpIIokuZkEy/P5OisTYiczO6FNmm65mRGF15IGk6Q1mQ3+pLb?=
 =?us-ascii?Q?LcN+5X7upHwiU9240XOH49+iz7GxBDIgGQhROQ5fcDS0kpt7gVTEA6/IaWoG?=
 =?us-ascii?Q?VOGmoMRU0qRzy1kmDA+G7MGP7aBLPgicB9EtUoKUbcUpit12ZwjxyU7Ivpkc?=
 =?us-ascii?Q?oJavsJSH3keQJgQJ1XPhr6hURhLs0Pw6uh5tFL18fAv2fpvOArefaP083lln?=
 =?us-ascii?Q?7Pi5GYB/psRWqxEtAbbFiO5FYJgyX6t/55IlTeuRZ0upK5fQWuL6CPN90z6g?=
 =?us-ascii?Q?7P1I8JACwk+LA+e9flILScJJxpNsMr4q8lV0opNLOIqfM+Lv6gM7Mqr8SzsY?=
 =?us-ascii?Q?U8132JBMPwdGBB4puWtzh8XnYS7RFh3NNo1Gujf7hvTlVBNnugmuQ39gJ0fI?=
 =?us-ascii?Q?6wrQJUcSPrzf8qd9/3CXfzOi3BvwkCqFNnjL7YjhQ1soEYbUwphaMB6oPHC9?=
 =?us-ascii?Q?tfPxZnmI0/Y9V+dogxcob5Yu4kKMMRb9HaVbPStL9qn52M0YedKkAX6QEUi9?=
 =?us-ascii?Q?u662zyyeUE0xRtgOwcIR6BNf8+n707PPwkypGPJFwJ+GPs5qmaLUtvgBbq7I?=
 =?us-ascii?Q?gJ5kz3l8gwIqglSyt8E6sMHoenOlzRqaDre4CgwzWKucutsG6m2tQTDvRODm?=
 =?us-ascii?Q?OL+wp06DKUMers7Pd+fWn6INF1cuBy3CDve5/IW4gAPdTkYtvKWhy8HyjkNO?=
 =?us-ascii?Q?dSVBLVFPVcjWaNWRqV41IEztdiLm1WsaSdYkx/9NsM+1aKVoNmP+xDnLNBgs?=
 =?us-ascii?Q?S5EiIcUJ/X+alF5Um7TUFMGVUXuNawklZrYs7TD2bjRSTd1DIx7SnLxg7CQ4?=
 =?us-ascii?Q?CuFHOQtePmlLBrWn4sMj54cYvEQtZEZnccko6F/a?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d59bcc4-eb84-4815-d934-08dbc3ddc75f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:55:50.4815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCs/f/wxpLYcGc0WnGBl0gje1r+PDM4jr5yy82nf258WADkK4CiRN03ORjvKdypShFwNa8ZEh0FLdkEWf8T8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9746
X-Proofpoint-GUID: H3G8FbWyMPpiMqRa_ksm7lwpDAGWcaRL
X-Proofpoint-ORIG-GUID: H3G8FbWyMPpiMqRa_ksm7lwpDAGWcaRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_03,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Hi everyone,

Now that the patchset covering improvements in error descriptions inside
migration.c has been reviewed and merged, can this patchset, which
covers the same outside of the context of migration.c be reviewed as 
well.

Regards
Tejus


Changelog:

v4:
- Rebase on master

v3:
- Rebase on master

v2:
- Rebase on master

Tejus GK (2):
  migration/vmstate: Introduce vmstate_save_state_with_err
  migration: Update error description outside migration.c

 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          | 19 +++++++++++++++----
 migration/vmstate.c         | 19 +++++++++++++------
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.22.3


