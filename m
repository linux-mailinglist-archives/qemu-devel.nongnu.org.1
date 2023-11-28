Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCEB7FB1EA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 07:27:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7rXS-0003Ae-OQ; Tue, 28 Nov 2023 01:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7rXK-0003AQ-Is
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:25:34 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7rXI-0004tL-8Y
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:25:34 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AS5ses9008787; Mon, 27 Nov 2023 22:25:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=+sK53mqDh5r
 hjNJq7XvEukknS7Z/HCPFDR2HxkaOzUQ=; b=HIMZbwiI5ddWJCYZn4IoAQGimhJ
 NFROWKJiZVhl/TAJWdzCdMat1la8LT7cnXdBVJZdtjqGVt/cHRL8w/Z/jEmM7RRM
 zSbRlL+dGYW8oJQKpzTgA/ANO/oDPSRDaNw2eqxe13K1DrW/BsOuaK9SQpu1bmls
 nQXlNEseIC9WiaS2xsnZTbXrKclg89OWY079hmQr+7HErE5DVe69kG9ebDGZFO44
 KNuQXA3LLaO/UOZhbFW279KwBagVWG4VbbNeqkcl+Aa76ZKibYwJY1olsvrKY2F0
 qs+xYEFRrDdBAVJBentQK+Nx6nnzMnPqaGv+SG/zKknuJvvA70FdHyo2Q7w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3uke4vckmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 22:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI/wMp6A/db+UUdTvEdGugsFz6VKIUp0EUCvgYjE+8uqrTEQ/fsBrifbxeWn80nKl4A1N8yL8Uc4yXoUKFs/wOTIG8yICRQ/iUpQM7aRr1P703OjRKqUXWQ4O0dBgwYJiHxs4XydLMRieh9J8tAnk3/tUylIfuUbvX+qMmPtaMLN3rrMaDwqdIXd6uBOhUTRYfW8YcCkW8QOwEPpQ4KlIHmj2VJyAzI4yWlLskYX+XWoWGSpg/Wtw13rFfbVigi9dIIUMjkiFkD/hRRTvH3noBJa9Mddtc1T9Nej4OzmWR8UWWhngXmXJRgNCuBdEYufNI6cWl21Dh0NzZNI/hqUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sK53mqDh5rhjNJq7XvEukknS7Z/HCPFDR2HxkaOzUQ=;
 b=d/Hj2SyNbWYx5i43X5GomswNedojNimXtRWrBH63HUoRL2ppB/Q8EsBYKntqKeJpo8WYsRR11tXKVy3BZb8V17wB1347Xm1K/kPFOJwwM7/wV2IlOnBKXrM1VFxJDVx/9+hEa5cj4OKUbex2jbHvOQQ7LABiusCuNbsicMVNXLhmZrV5a3JZudS0PcGSr1csNrKXTohjCwAn0XsiidbYswEBXTDBWwizOF253vsh1s8O7Zzp6qVmfTCisnXwNiJ7FBHtMCIbFFphIDXQwfLbJ69ac0jLCN08MVvQ/o2dPnabtSdePadQuKU4JkiLYDE7nWUUcSAkE05cb3NggV/2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sK53mqDh5rhjNJq7XvEukknS7Z/HCPFDR2HxkaOzUQ=;
 b=VJyNmnAAnTxSDge0YPRQ2OvUJA2o7gb72i3V5EJYg9fOjugqnFa6/2i3J9fvbjgIm+SEDvZ+0S0admvvZAOCi87DcyUpQZZmWCHZ+EOrPoOxaQmwcy0Uv1SlpxZiuyPhfEuJixrBKYq1gZke82ZRo/5nWQi86aqXZ6JFP4xwQNMoBxBqyg+8jRNjMFXAV4e3m7II5MaO0H+9/6968JlCBz6HlQBi4newJfJ74ig3arbYdvqJg0+0gNvUqYdxkibWSTXmfqqfqAaDaSiszT5yZtneP74gM3dZpt/TF2IpLfEdEW4Kx4ovg0uCntG+ndYyah5uWpnmXKJku1/8ZgZPhQ==
Received: from PH7PR02MB9944.namprd02.prod.outlook.com (2603:10b6:510:2f7::8)
 by CO1PR02MB8635.namprd02.prod.outlook.com (2603:10b6:303:15e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 06:25:24 +0000
Received: from PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17]) by PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:25:23 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de, Het Gala <het.gala@nutanix.com>
Subject: [PATCH] 'channel' and 'addr' in qmp_migrate() are not auto-freed.
 migrate_uri_parse() allocates memory which is returned to 'channel',
 which is leaked because there is no code for freeing 'channel' or 'addr'. So,
 free addr and channel to avoid memory leak. 'addr' does shallow copying of
 channel->addr, hence free 'channel' itself and deep free contents of 'addr'
Date: Tue, 28 Nov 2023 06:25:20 +0000
Message-Id: <20231128062520.36456-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:510:323::12) To PH7PR02MB9944.namprd02.prod.outlook.com
 (2603:10b6:510:2f7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9944:EE_|CO1PR02MB8635:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bc6a24-232e-4ce1-c0ca-08dbefdacd9b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fpYQM/y/wVxVOu60n7gX7aD7WGmO+0ke9S6Q4c6SGJBRmmM5FoxkhyKkOTKhOX1Q6qvGFBxbfwRU0C6V+G09l0VqXC+zuiBjvgSXzMfSciFpV7hf/e0ERCVwr0UIC3FwWsydlAGQKKy4gO8CG575dUSCXd1ZciRj4DiVoI1yxY4zTiYppOfCRpm84Xrhu+DyQsI0FTkpOVsdsaDrLFvKh/bwab8NnZw/z3OpO6mGnl6Xiyn0K3Sr+RUz7kmSPVqsXEjsuaZ0WxiI5IJmSvaRlgotub6kXwKCq9bsnBk1pWZuDUzsbjlWI5qFB8mkH5JneaNBjXn3SCspB5RuFZemYY03p7yBug8BuKMcQn9jZY2VhKTyeP2jIwZ/yHzwk2/4kBJzON53xihsq6XoXTa9AaXgDYOym5ymvJEnpcm+U8uDo4JnojX8ojKswdEJH5ApLDPJ47xTUZ9tO6lDot27MgGQs+sfzmaQ51IrMs0KedOHjZSk391/0gHJT+JV4WvyNCnwc/nFyPgz0VL4v5BT1LHN6M5dSUfdDj3WGu8xrwhTCYGstIRc5I4bG88ozDjemJQTy6WDPcnRrFYcOhq4fKzdyws5mUApjHorYdxukTcByiSk4YqO2Ri8uMF9UUklp48aMGWb0IziO8qUO3NUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9944.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(36756003)(38350700005)(86362001)(8676002)(6916009)(66556008)(8936002)(316002)(66946007)(41300700001)(6512007)(66476007)(52116002)(6506007)(6486002)(4326008)(5660300002)(478600001)(2906002)(4744005)(44832011)(1076003)(26005)(2616005)(107886003)(83380400001)(219693005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEKkHyBCOE+VqzhfayKuhvansqY0McvywepwNBxAsBe4PeVVfrToSDSAtatB?=
 =?us-ascii?Q?AgZBYehuXn27DBcvJiQiOWCDhZC7rUuVUmqMqhsl0mQG5lUQbhTi18WV/HkM?=
 =?us-ascii?Q?0l7NQxieUE7vtRKo5yzFUyFUBLzdq9AAwRdYj2QetOjo5JjxKSPktoJUB8qr?=
 =?us-ascii?Q?P7WVmCmIRpI/ljhAWG4nBZdERGxzKVlmdcJmv+SCdt7dGfYVHY5uCpFViei7?=
 =?us-ascii?Q?rGDwzjyc3gIJAZNQHgWn+8eQdUO3dODt+Dq0rWXb+sUm4k4qxl/rHFdukdhf?=
 =?us-ascii?Q?LdQ2K315dYmguZcEZPIcS+Ee857LsItiYEp3b4f07DLFPh0DdCudyv+xoNd7?=
 =?us-ascii?Q?M2x+ZHXzKcuvRAnoz2gDEVGbKzqfQYx+vfyO+dRWeAQTu3+96JIV64SMcbne?=
 =?us-ascii?Q?fOl3F2kJnDqc03MzLoJx5gAarPq1vqXdrsEEXZpanEHYwjC1ny12GZWcz0Ez?=
 =?us-ascii?Q?va/dK+7/T3QeHaPCusWh1aKofuWOswU+BfibpPXY6K5Vb0KeU6Vwymr4E9L/?=
 =?us-ascii?Q?lfy9WPMwJZWvoHoBEMnOg1yzNhP3p2CT8lhhEdDBu3RSpPh/ElhtMINkUhf+?=
 =?us-ascii?Q?Zsb3vsBKKbxMyoWK+34rnu5Mw8NU7kb1hjQsooWF69QGwj65zhRYuz03SaP+?=
 =?us-ascii?Q?Rg2DVsYe7D8UefQuDIXiUbqz6ILLVO2uylXI5pOs62tOHF3J36NhWFB77JUI?=
 =?us-ascii?Q?cEK5MFvFBJLIPZMk2LGIxhC29sshTr5CnBZ+bp25A+cm7Rbq8HI8ULoIif0B?=
 =?us-ascii?Q?bqHFIBZPthkIDL7Xzpu84bbjM11rEJFb8iU7Ysf3+2ApuyuagPCqnFMHtDFa?=
 =?us-ascii?Q?eMSAKOzZeDe4AgDRJy3i7W7rrWCIlsyDlfZElaPcTp8Sj5JukNzgVZblR1A9?=
 =?us-ascii?Q?BukWCggVexsZeZF++auURxsTWdqHQiP/6bulLc2LevjJ6TuXcUI8wY3ifa3H?=
 =?us-ascii?Q?9uLGKrmyDLSA8D+/MRjw5PPWCnaHw/vX3SwfUcsSpgBYpnzaPJCfWHevWcaW?=
 =?us-ascii?Q?nQ/aD8+bcOOBkCjVFo2uMH8WvJsW/WpgYYWh57AEDLpKejYhvWZ7tDnNJGBQ?=
 =?us-ascii?Q?WzqZ4TF96wpXQOs05hUuJhHyFGkXqEaRaZEkGP66nRaeX66+wf/xz7Rz5EoK?=
 =?us-ascii?Q?M+RyvWCxrrReNmlaBtGTJ7/9Ky17UdlcGQ1cIEiJ7v+MDW23M9rHJOHCRvR+?=
 =?us-ascii?Q?pxCidnzz4vhZd2h6MjU2EhCVw96k2XBe4gLVFZQsh0k+ClJj5f6PnV43DC2B?=
 =?us-ascii?Q?w+6kw4V1kIxNg5JzWkpOcOF1U9e0iTgDnHXyQzHVngbddNC7uyCEUDXxwNnV?=
 =?us-ascii?Q?00FZh2GbeA55K6laKUcRM6UI1JCe/hplmtxJ05RnsXtAaA7Bjre9mI5CkiL7?=
 =?us-ascii?Q?Ekk2JhSuC2Oe3F6HriIWJj+n6j+L157Rw/bDUmvbIl7OpcRNw+9nJgIvcLd3?=
 =?us-ascii?Q?LHHAGdTaO43ZDf240KAescja5x06QJNJgG50PW+Hv/zE6ddh+ewduF0Fxakx?=
 =?us-ascii?Q?UQywoSuJSAAALQR/q88QrHNuy+GUZvF8wc5+6nIxkjuAIIJXFYTaqbkdk7/f?=
 =?us-ascii?Q?HuVBbRWikXexdGhAY/YrNX7t4dLZ+wXqaqX+SWzZoXCtSRCd67h2zu1x3rND?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bc6a24-232e-4ce1-c0ca-08dbefdacd9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 06:25:23.6185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKTumai3XO+Cb4jtEbmztMvH5kMwNE0mEN9L3kQF7ImskHc8gj7Cc4+P+s++x3rb5DlCWhgRyYD9mqdoiyPX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8635
X-Proofpoint-GUID: RDTiGiKhqJKGsMNvpEVSRIgq5YlDHyZv
X-Proofpoint-ORIG-GUID: RDTiGiKhqJKGsMNvpEVSRIgq5YlDHyZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
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


