Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6C83879D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:43:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSAUc-0001QQ-K5; Tue, 23 Jan 2024 01:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rSAUZ-0001QB-OK
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:42:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rSAUX-0000ZY-17
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:42:39 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40N4D7fA026714; Mon, 22 Jan 2024 22:42:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=FElhX9HMZTB
 kWTwTuphjCjb1V6fmwuqcYeZLYWESW/c=; b=O1Lhpcs88BLimX51/gF2khAs1Pj
 snDxpJS1XIU9AmV7sKu0CoHAV6fgelbOZR2Y+BMHdnHCCivykB6hIUR5ubwLG/Ge
 2heJIgex9DZz+n8fvGn7b1FKRW21gH/dya6Ho/2hbA18jwHB35q1vctqNYq06a2b
 FX8mdEe4B1+kMrbZAcGwOTQyRn4V5d2KtleyiGpRZZ1ji8NG+C7/ccgsVwXLxGaa
 XxEU7XfLIWetADlGyhIxa3+K+iV6pYr68sCRYog5pPVY0XeaMG0WqAVp0BR0qude
 NLt8Y09AyAvVZelSuoxyzBb5n9Rj3YblBbAYlR71/doGgJOVbrut4btQt2Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3vrckact57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 22:42:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EANfwwsfVrENVaOtb8/7ql93W4PNKkz7cCJFJgkRzUw2OrXUZNTZnf2R7UGW8VIJsIwhlQzGBjfMqPcdt1TrtPUiwhTlQxJ2JBB3S+Oo67nl9cEBJ5miCwnc2KrNaUGUOJGFPtLRhTFFenrd7uZetlvfKs2WwpOOf63TPht78LY6HjJcJBuPdHrr4d4fVs+pfNuDdakYnvVTToXC6ttdQg+q18hb8VhM9hE4r6kVz0TllprzZi7c+luCnBnGfQjNT36uebgKnMz2YLuJ6Ax0/C4BWcEFOR/exdTyeTIQDyrAxYPxmWkPr8HZqhNT3a1fPbya6P6ZEQcnIkZU1wb9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FElhX9HMZTBkWTwTuphjCjb1V6fmwuqcYeZLYWESW/c=;
 b=MKE3RMnuKZKU5D06KdENpYrrK1R2t6eudRy5oYgjyJNVOv3p3ZprNbFaYmLV1S24EOoUgjBW8W27vTC6XGLa22tp3G57pfX5nuObNAuitvxZ0kVF+7b9Svp/Sbg2g0Mi+yl+fEeX+7isy/bQgbyep9FeAulRecUwzkDU77Z6tRYLkF8lVzMfnnraqiizAldbiPzZdkUwUYom2uJG8Euuhb25jpHbuOaSNwMNFCjKshaRPbiKaJwn1T2oiJR6iHIdQMJZ9yb8CFqvrtwYoU3aXMcIdZ7yrPlr/6M7hkeBQ7LYgVPr68CftWXmOU9K1Qdm/MN33jVpf/zMjzHvK2unIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FElhX9HMZTBkWTwTuphjCjb1V6fmwuqcYeZLYWESW/c=;
 b=SGBaV4K89GRJKqe6xMpo0rFMpUFHB2d49SdwiQDBCbp6OvRiK3eehtl4Fav1vBpNaRlUWIBhTdh6Wer/QcviILeHgWr3NCCcD8LI9Ox4e1Pa3Im5b6AoWYAR/b7hWWHrSGD8p12u1iGRqfcSVyv2oK7xO1j2toO50Pu9wv7DA7owxGwg7aoKLD3+TlAsKT6if23mc0z/OUwlnDOkdkwkKxapRjydItn30peusHnLJGfCTdLEu7WX968retF+Vi9FX6aGRyx/Rx9LT4VnhfWk6O6QOH5DfeCsrXgAhtDArw4TCRwXsPL/jnl+mhLbrZ1dKRqy1qh6VbcMY/G3jTOhMg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB8536.namprd02.prod.outlook.com (2603:10b6:510:de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 06:42:30 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 06:42:30 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, farosas@suse.de, armbru@redhat.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH] Make 'uri' optional for migrate QAPI
Date: Tue, 23 Jan 2024 06:42:19 +0000
Message-Id: <20240123064219.40514-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d485825-a40f-4db0-25c9-08dc1bde78dc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbtcEKL30q5uyi39N+MlJ5pmf/wiZ9OEVkPceg+XLN283MHsj7rqArzgzY35fNImr/iI0hNUEs3+Li0Ch1dZLUK03X5/tWwxxX7uTaTLJ5axvCOGbuPUBudXl0I8nCcFOyZ2eDocnfc/guVEEl/buqdDNHSiuvbENGotNuLG0Rx4mA9vbK7XFnTaYNnR1LMRlftiYePlBRu/RW5bMGVorsQsHNAASaIvR7TYFSaMZkPTygoVsZBRyyOXndSJQ6lki7LGUBw50ZifUW2HEF8ihEEXy38PaZy1Vz6AoOcxHv1Yyv1CXEd+FE1Xkg5DiCNHQOcn0VDWwmqguVhyJhpEghqvh4I9iKQ/7jKPuuepgGH36LJ1D4TSKQ7iM0kGyjnfzadN564VpDvfHyBGXkkhXtRGTSWwuRjY7Ib5N1/4MbYY6bc6L4JYRGNV4NxbogKinncEQomYnQ57L4tQu//dtcTJcYiVhGgVzwx6h1GE5yVfIClbgw9od1782v8H268NDlH54/nuOFtBAmbSzbB4jVGnHTk1damU2kB3U1HirFwJtq2qcG4J1fyx+TGFxj6bpYnopKSdX7bAJhVRqWwqbDjph4PkOVmtlPQr/fFPPw3/CHPJO1ogSYC+aKvAg28r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(26005)(6512007)(52116002)(107886003)(2616005)(6666004)(1076003)(86362001)(38100700002)(36756003)(38350700005)(41300700001)(44832011)(4744005)(83380400001)(8936002)(2906002)(478600001)(5660300002)(4326008)(8676002)(66556008)(6486002)(66946007)(316002)(66476007)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f70LtDZ1mD1mgklF+wPNa6N0EsJlen7t3Jj6hpJYfFeTRFNTVG1f94aCyEf8?=
 =?us-ascii?Q?IClFwYZ7EB4YK6hJMugCTMayBcfbtskZJZ3Ujp2w6j9s4D5nEyGDQNl3jxzL?=
 =?us-ascii?Q?OSw8dLcTh5r9DF4JMe4D9U/kht9ciGKXnr+H2Fa/NVFVHV5/sWEMTpdqUCfi?=
 =?us-ascii?Q?uyRmyWLU4kJP2nn2C/9K4IpGsZ8L9Q9HwkkaLcV00yIjPBmTtq4/cSSpvHpz?=
 =?us-ascii?Q?32FKiyS8JYfxStQ3nlmUkB6OK6BdLC5xUwNrEVGssqE/mGhmR+2bK6FoE9X4?=
 =?us-ascii?Q?x8r36owsRrr9ujwF8iuajo3IrXOVrcOikFe3LDncQNHzLbCXsJbiYgnTwK6R?=
 =?us-ascii?Q?PHckfNcqR9C2nRivIrDaVRxyT3E2Ql4lF0PFiLhBTJ0bPCtWw3zLIqmlADGt?=
 =?us-ascii?Q?xDCctVBOSw1/hWP1y8DmupwT/+LNAC1FpPsfYHzUmPN5rs76DG5KvaY/djdA?=
 =?us-ascii?Q?YDrMNzg0JEn/bCI8qN3QkcASykhV/lVVSysILTEGhJOOI0iuMK41mzQVobPs?=
 =?us-ascii?Q?MkyXDkTo5V5YyvJb8dzYL23ftjMx8kwtJYLR0VI7kUG56byW6OMXN+W75EAq?=
 =?us-ascii?Q?t+KchZ28GSSQOzaa8rJ3tI8lJNroLk9rQWVHeamDYILVCjX9FzASFHUm3MAy?=
 =?us-ascii?Q?URpHBsfyqDOvLGmo5iwoJtOa5FRBOQ3UO+eHjdjw3P57UXbqtNYveIYIfmvq?=
 =?us-ascii?Q?BmXywVNEgXcxapk6LitWrkLaVAX0XAodqsGDTjUx4WXN3otiQaZNADJNCOij?=
 =?us-ascii?Q?btYjlLbBWY5v4VgNIOeJqUZXh1702QQV7+pID35LmfNG82jQno+pY4SXCMlg?=
 =?us-ascii?Q?TodKg+QZvfD6/g/jBeTu+hAhqTx7F6qHujIRf6OPba3lFrVCdrjl4oGRMCG/?=
 =?us-ascii?Q?G/1DlQzs4Bh4EsE/EDu/4c4IoLu2l55bksRvR2gQ2tpvRd9IPd+DhooLioet?=
 =?us-ascii?Q?tJnESd8Td0e9QQ7NGKupBVaHBqwfeXP73W0t0dvUjuf/SnCBj8l302Qtvzvr?=
 =?us-ascii?Q?/l1wrvVqL0TpmtWx2bYS0Ke2YTPAK4mOEckil4Hf9zfsXzylKuijQzPYf65d?=
 =?us-ascii?Q?4+hnmNN20qMVnIRte+JaWBQrPpqppRdkuTjkC5Wp8+yUrHzJNIytmI7Zzlch?=
 =?us-ascii?Q?LkO4Wd9NwW8e0KGsqXg2+dPD+ub/YmvIGKhWthnh1xOuXNCRYNQdKMA9snhX?=
 =?us-ascii?Q?ZGLVr619kR9qR0KMq4Z1Q90HZhZBNWTBG3TW+O7YPAJCpt40BhNzSMTxp3aL?=
 =?us-ascii?Q?b9uYt/tJGHpyUr2KGSP6F60YU1QVC9xJX2NhHI1+LaHGb7aGC5MMTGvUVfAt?=
 =?us-ascii?Q?Oy5JfCxg2t7lkrUSYssHS77Snm/jztL3wAj5QhizTTrqjKbP9IRQls674U8E?=
 =?us-ascii?Q?OiXWzEN0YHmk5zmb7mKHNQe8dE6bjnT8d9ub1TcpcQOTiWRHCE7vXHDVVtq1?=
 =?us-ascii?Q?XjMAHsQQyXs+NNBjlmbnTMGbynO9PtU0fJSbQpeIofJ97s5Ss6wtLnTwK8+4?=
 =?us-ascii?Q?09CWosYtS1Jnvw0pdQ7661H/F2sKjYaWLDzPd5SoxZDqdgt5ogsE/eSdIQz/?=
 =?us-ascii?Q?SnV+k2MroHkRORRX7QCiy8Zonu6oQkr8/zQViUTO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d485825-a40f-4db0-25c9-08dc1bde78dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 06:42:30.5733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pGErtHj3oCd1at9igRQrlcWCd4xC3QrANkSuQXrNkUewvHac04GLamYVgytHYNqn3q6YPR25n4jEeVG6zTkDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8536
X-Proofpoint-GUID: d2d4WNLX8vWyDee7RoxiAule9mQxljz5
X-Proofpoint-ORIG-GUID: d2d4WNLX8vWyDee7RoxiAule9mQxljz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

'uri' argument should be optional, as 'uri' and 'channels'
arguments are mutally exclusive in nature.

Fixes: 074dbce5fcce (migration: New migrate and
migrate-incoming argument 'channels')
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..197d3faa43 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1757,7 +1757,7 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str',
+  'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
-- 
2.22.3


