Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1EC82D3AB
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEgj-0002HR-G5; Sun, 14 Jan 2024 23:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEgh-0002Fo-BM; Sun, 14 Jan 2024 23:35:03 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEge-00031n-75; Sun, 14 Jan 2024 23:35:03 -0500
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F4K2Ir008296; Sun, 14 Jan 2024 20:34:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=PPS06212021; bh=1fAkXzHn+gsHhJ0EFb
 t32rQ8ukkXwKphrgbBeRvrSoI=; b=rfh35mCY43zQXfoRyX3h3jDTvcoFpnS5Wl
 6cVM8opSz5ftg2WZbB27XWjBrHmMgOWrCg+W2y0TTFtUHT9PXEghVVcLnlygS0KK
 SlxKeoCY4seTyPOvyP/9p3R6MHWfdcimwl3Fvs+ThvT3SdrkF65u2cLkei1t6jt0
 6h/BJiuBgXlOJb+CjYTSFQY2XIUDlPamZVvHU8gqmVEVGdwV3UnCP8PsSaeub72f
 phjF1iBV55hZmpYgi74sq304rkAD3vVJosT4m4XECZauAR/a/ATsb+/OTcAwg7t3
 zHAOGlQVOIkNFajyRBfRrieaV0wZ9zX33dAWGxNqV+H/CqZrnJdQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vktwkh7jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 20:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQpE7IfmkRc1nvfAuM7kawQuqwMb7ilQ6nAB0NtLdb6p/ct1VcJWaUiKo/BjfcAvIOo1rIt14hf8pnfODFIkU1DDBYcnAmebHdhuo5gDRxNY2Xo2xiRm809/qjFVjdiStLO5jhZW+EFyHjKi3P7uZRQmp+D9sqLeJ8wPbUNVihKwsgjgJ2Yoq/ut6lcuocB3aerrXLHZogSlRqQv2Q9krLYv4xHEjcbjQGItoLC9Ovg4hdJdRcTivTiAEJjy++DO5rdxA6+3wAETgawjo3YVQfc8Uy+SkGxpFnhPmvRWafHukwKd3zV7TLzMHQa01Q3xdNvrUbHMSiAXB6pxyPAg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fAkXzHn+gsHhJ0EFbt32rQ8ukkXwKphrgbBeRvrSoI=;
 b=cv8kgrzv8os5OqfRoeNecht2+QhtxpZUSc5pYYoX7Qs+N63ea2w/AWUUWusftHRrbHxWTK5Fu0vqIchVHfIUqLsEpXRtAC8ARlt6s0ERNZ+RVzs9u4Uu9Q7okILzFOYF89CIX4e4oTKiOUHnWBZIW1Ongz5syQCLIIXF/wX6sd+qxgQ6iGmcgCJnbIWoNUU9PeTuoNqDCZ9ngottSWKSV3lpToNTuSmUEdr6/69RRj2jOqwRCx73u1qwKDtsWbb0KChs1/1D5RoM3/4W7SkJNM+SEPnwXcNDn2wQdojMJFPP4RNMb9bxCIDVV3uI/bqzjWQB2ytJcDi/3M/Vu/JXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Mon, 15 Jan 2024 04:34:48 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c%6]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 04:34:48 +0000
From: Bin Meng <bin.meng@windriver.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Subject: [PATCH 0/3] hw/arm: Pack the QEMU generated device tree
Date: Mon, 15 Jan 2024 12:34:27 +0800
Message-Id: <20240115043431.3900922-1-bin.meng@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DM4PR11MB5358.namprd11.prod.outlook.com
 (2603:10b6:5:395::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5358:EE_|CY8PR11MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: ec256b4e-3fcf-4f36-805a-08dc15834e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KwS+CskA5qG1Nxry7QaHZVf9qofAM2qc5fz3uqNVw5R/b3RYlh0Ley4ZT6t3T/Azq5Bmzld9yT1jsXruYd6WqPQGrlDE01tOO1rGRIGCS/ULjIuAv4cb0iRWOU1O/cTHfLNldGRSSAxsT2u4p8trBGPRwvxSeYtvpSNTtPdroqy0MgOkj5SLtWk46NH/ukGJGSd7JPb1QUV+Rx8gvsg6sJeP7jx1+Kg8WyFepyWi6PxzJCs2GD8zUZkhrEi9nrj3jh5hrwTWJWaTx3KELJPibMC7aPd7/SnW9xCefshmrGC1Njr9LiiSM9+sDYhxpC0dCcLOlV4RJkfLcbpIQ520fV0VI1n797+KOxg2NgiP/g7dx6tLKKY+TvvzVfRHG5gaU6OjsBuQEEmLmFBvYIBwWNTpyLxbABnJgP5PgyJeu1iphGfK6dAYa51PExPRhpVYwojfrMc8HaAsT8JJYSLbL3chqZdio8Vt/Z+tcHWqFyimmKy4UDlNVb+l696rUVrRyeQJeHWiGLBbsai4GZ4PH6K5ylzQ5IgzDFOb570e75zXM1uTrVTjJnHz24TqClgpa6AGAyNPfn3Qdjkjk+zzYZwWdImsr0vjOL0Uv4NxAdRMcdq2JEwbp4oB4TCBP3E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39840400004)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66476007)(66946007)(66556008)(6916009)(44832011)(36756003)(8936002)(8676002)(316002)(54906003)(38100700002)(6512007)(4326008)(6486002)(38350700005)(2906002)(4744005)(5660300002)(83380400001)(41300700001)(86362001)(478600001)(26005)(2616005)(1076003)(52116002)(6506007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+316PQlFpm3Q8NZnHH7Cicc7DqqHhmQsXfPZ6q08SLm8+/KYn8qlEEBc5vVB?=
 =?us-ascii?Q?jLYzxfe/Y5x7Ja2+DTFTcMeysCVT3df/PYid7dpXs7I3D++Cb0LH1bXSxIZO?=
 =?us-ascii?Q?AEp4oID+os0XWHZYFW1uRsBmgOkEz2D+nFFP+UYKGNEOE/qLKd5ZWdU2Xr5D?=
 =?us-ascii?Q?X2Hl/Psh1vRBR88FWGxvQYi60tjKQxU/4hH/K4DkrNCcNdXQJCjjcdnDDKeR?=
 =?us-ascii?Q?kDk1L/Ia+FMIq7/0OqWwo+CUjZW7UtbrQNxkA0hgfVNq3JVVjjsVbP5ba7sU?=
 =?us-ascii?Q?8p7C1RyyKB0qF6dKnfDl6PFqyvwnoMu/rtaCQT58OByCVyPMto/+4flYvNNa?=
 =?us-ascii?Q?1nBHSsetn6zOe9/BzI/oRKTIvFrF3xV0CwqobBV0X4/jeZ3kSuBfFGDNBH7G?=
 =?us-ascii?Q?Fd2tdGS/vzdiHqDNfLP2ASC+0wavpesn9rhBhtEh/31JrC+UFOEMMllJYvRt?=
 =?us-ascii?Q?AJ5vpj76+Q7Pz7dy48V9cuZeEXEh5dlQYakVVo89ohVGEsQE/YnejRXPiqP4?=
 =?us-ascii?Q?TEolkx/5Mx9ZjEWYoeMMCOdtsJZ8ArdWZBWSXvW1MsqaVZwJfV9uyHy1CoiN?=
 =?us-ascii?Q?I1O78yBIOtPAI5Mt1LGekuUWPB2Z53qcCqpKuEsdQOQPGoRxXFynWMTBKHK/?=
 =?us-ascii?Q?MjClKQCHVEIsqIXevEHVksZ/PUgDkjCMf7+afL7cBxoqFaJOJH0LpqsWty65?=
 =?us-ascii?Q?zP62eOpv2MhlGnz+M1Rj9xGlQuAQHX0i/SRntWuGtrm7iPaNYwqyy++0ERM6?=
 =?us-ascii?Q?jcAMw/3PMIuts+FYnZ7G/koqhgbuYaRbIRnoObLtx0A5uAPbLjcvHWCrs3Pz?=
 =?us-ascii?Q?mi6sDz14VImFdwye4oGPPNxL2/SxgLChHTCflI/MWXJGWVCvDmy9B0U2Uvoa?=
 =?us-ascii?Q?lOGXY956J9daREF7dJmJZUMxQP/8rdD4AqYo9ML2pa1CwF37LAZnEmEhw5uq?=
 =?us-ascii?Q?x4fm6IIGAoHl5IGAS+a4oDw6MbbDFQlJSrHw/nlIZMl2QODvQkn7jNXf2cLQ?=
 =?us-ascii?Q?l1j07IEcq97fYTokqcMyyxzJuy976Kv/LUAq0Mb+i5zGKOHzFiAEuHW1g1os?=
 =?us-ascii?Q?bzCIPvkW5Kynu97sWK9dru1KTe7W9vROIzjvMlbWtSmdlNNLz1BKPS0RMi6S?=
 =?us-ascii?Q?jixDWKVuXKcKDVcoVhCKXqjv5H44Zam2ATJly+TLVsH4dnnvEkRxluKm8zJL?=
 =?us-ascii?Q?WQRsiQsOvcFiE0rn31ANNglbXbv11zTLRCsI6GXyoWHutdcc57E1PhNQ2EE4?=
 =?us-ascii?Q?lbDw/CxUOeDuoXThALcnwhRSDo6pQF0Yjf5CS5fYDpfqf30Knze1waUdWfTs?=
 =?us-ascii?Q?gIgME+fc/NuJmHXrs5mposJvc7G/+GPjHuKsAQ78BNyJRlK5sUg0z9L8eBAK?=
 =?us-ascii?Q?K8RU8PNGqeAwu3Auu1bb3PLRfX4HYfFk+yC/PkBMMsCLfVxgBWYDTTF6oY3B?=
 =?us-ascii?Q?a1J2z+mH7yUaTb4DiU9lRb2FgwVAG2t0oKcM5cP+FfOvOREvoMinWXmEvP9j?=
 =?us-ascii?Q?XM0uPYiy8mdAZopL3RDgH/0iwYPTzNTQwuwjb8Do8fWDcmgcsFJXPp72Vexn?=
 =?us-ascii?Q?dssDz1ZhJp4XpW0lIHT80efdpLVbDzbQkjuHcuQU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec256b4e-3fcf-4f36-805a-08dc15834e6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 04:34:48.2956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lim0frKhjH8ClZB47czFIC6lR/oPCld3oq6CIaK7mjzlDQ/0tfea77/8uGZIeWMcVjMYWhNvBC1NIamo0kb/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-Proofpoint-ORIG-GUID: ojncPyuhs5m00o1OzUAbc-FGidKKLo59
X-Proofpoint-GUID: ojncPyuhs5m00o1OzUAbc-FGidKKLo59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=414 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401150033
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=1744ec9a4b=bin.meng@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


By default, QEMU generates a 1 MiB sized device tree. This appears
to be unnecessary, as the actual size is much smaller than what the
DTB header claims. Let's pack it to save some room.


Bin Meng (3):
  hw/arm: Refactor struct arm_boot_info::get_dtb()
  hw/arm: Pack the QEMU generated device tree
  tests/acpi: Update virt/SSDT.memhp

 include/hw/arm/boot.h           |   8 ++++----
 hw/arm/boot.c                   |  14 +++++++++++++-
 hw/arm/sbsa-ref.c               |   3 +--
 hw/arm/virt.c                   |   4 +---
 hw/arm/xlnx-versal-virt.c       |   4 +---
 tests/data/acpi/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
 6 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.34.1


