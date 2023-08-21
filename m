Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B97821D0
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXvf1-0004Ld-6w; Sun, 20 Aug 2023 23:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qXvez-0004L8-Qi
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:32:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qXvev-0007EC-GJ
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:32:57 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37L0eAoJ032093; Sun, 20 Aug 2023 20:32:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=JytXBqUDwpu
 cncWkO/W5DmrdNO51ZnoCp6on9RpT1Dw=; b=AskD4+wB8G68BhpyHhzJXiJIdIi
 KJJvuKGBHiTk95LPXnQkCKtvdanvs0aE+qnxmZfgcrOytXmm+ZnqM43GrZxhWfJi
 IzvwvquERyP0CwYvgjOwyuV03K/yUHoEjQVkF67gaFNv0EQfM/JA4AphAtZp3kr4
 dILujTrfAB15TRAEJ/5EwRfFIaAo0Z2+Me+ZLCwxeAPKu+TBYfAMm4bkEa2vtxUc
 4mDmIhgz90UPF9VQDsIBHjTnnaoJIupAbmMhkPBBQ3YV0nX8GC49VzyR6+eEhvD2
 oUllhY2BuunCNv3V9Kp3uderF16WUPR2tL5HYdIrueRPMJ12q67g0V9hIBQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sktp1gak9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Aug 2023 20:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGeddr75a0r2q/wYGlbbnat4eiGdokaqcWD8QTD1Bf81UNrzzqG3zKMM32ICP9Af9PJKQMh6GaGZAmGBuSciwsb48VFjjQNkBwodJSsBc4cbRtG17DdWuBfbqD27h7EUBszaBn5x7nOTgK6N3UwQZb5r9vQWiNBmmeueJ9iD7oPuahdXQn5mNHi5be1JAbGi5d5gn1l3t8ls23wF03NGkVz4zVkAcgyuJNiPigxjjxZTlH/Av7h8BI0ZMx7SG8p/HnucMHq2p3MmsszkkbJxzvW+3JC09gOgfAE9ZBNvP3FcJ1A2jfFF+XLYd5uhVU1IssFy69H/AFIZAlN/eBNBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JytXBqUDwpucncWkO/W5DmrdNO51ZnoCp6on9RpT1Dw=;
 b=lWhW7rhZ1LiyUg3PbIg+V/3S9xS3Ts3+x3XLKm2ZwNsiDxP7xXIgEpihN5KxURDKTHV+GMtvcD6FN8s8XFwSNusx9W9A9K+HVsfjUaP5J6DpXglxzvccvxwSIvwHKog1+gGXKJ/Llxhq4V6soy0OvXf9dYukBKHDf+wIY7cDNLCBf2h6kuFNN9u2zVhJ99oCohWTz+c7DjbNH+IZrQdIAfhis1rhJMlevzcZ+4wGKHJEQlLlhj71boodglUNGOo6GdswzQmO/9zZd2JOya1wEgLmMIXI98IBM39WS+Bqkc/07Vdfk5kWaJLwgYghwGmzxawrPH+yIX2c2eF1AnoCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JytXBqUDwpucncWkO/W5DmrdNO51ZnoCp6on9RpT1Dw=;
 b=ot0OUkHKTNyIgNJcz4Nt7abdZrFMAzqR/mr9u3H4n94TUpxNjJAeLCSfehRYW14cAyWhTivoRYrCWfvvtmmbkt7bFXM0QlrLCEK7SFuyQeEFwSS/TFmc6Ha3T8MSC76c8awKFULEDLjXBR61WJxZBE3YoEaswFPH7tUpCA260h0jCwWRL0XFcsaVSl4gzqYEU3lWT+mh+KvYUnem3FpvjUm7uZyJZjR2RnHgdn3RZEklkeswLuLDcK+8d7NlEa0ZWp0r16yIxpxCkkV3lqNl0HBlvK1UP7YnRHv5E0p9ijH6immwrZNG7L1mx/3ZnjHoq44cIL8LgO7s4to87wVMhw==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CYXPR02MB10228.namprd02.prod.outlook.com (2603:10b6:930:dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 03:32:48 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::6c22:957:5d20:651b]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::6c22:957:5d20:651b%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 03:32:48 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v4 0/2] Update error description outside migration.c
Date: Mon, 21 Aug 2023 03:32:14 +0000
Message-Id: <20230821033215.6112-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CYXPR02MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ee3b2b-d4d8-4a04-b13a-08dba1f74a26
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3kB2kgcA1M0zKWUwiNKfs9G0lFRicbx/eCwP1H9Xa6Ne9ABkRltD/hEXPrOPrG2rIsqWmVW6bEMWlTsnFoomik+PFQ3pQZN6wN/LydR0YUsCKFfkaoneJ7f24a2FmBc7BLiTkDymX8LdfPuNwspTWhKHwkL74tuh1SUz3KNnKtxD46s8ByZzzkCbxZpeghUsJfp1bNDSeho5AjdXvfdMRpoKx1IHUQEauhheem546BMpn115QXTfSPAqM8x8bp+lapYPu7TlWseMgL6NDe3p9KAoBfyldSGscgsUiPAGP+SUVsrEJCgN/yMfTJLZAVs3YUNK5z8EJCW/qWQaaGt4dADZHx09A7REeqdJ/XFB8T3qOJNijJ5BLqVx806ixFiFIN8f7UHyn9bs/lROEPrXLnvkj7z1eBnjMvZAWkkk9ZyiiF0ZJz/gNccICsxzCagoVGgGNQ7AcFdAzMcI3I/65NAeNiWU02Ll59z3c0Jwkxnt9m8CqeYPAqcU4s6Rxo/zt1yvjKfrBzuKRHi1K1PhVdKARAG2OdONHVF+JiFBHd9xZs+bsjy0Y6VFpdFdbruGAOttZfIs80SUqQlORTt9eBS2Q9t9xH8Lg1vlxQO325XPnEorFaqoSdq8Oh73o5K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(6666004)(6512007)(52116002)(6486002)(478600001)(83380400001)(15650500001)(41300700001)(5660300002)(86362001)(8936002)(8676002)(38350700002)(38100700002)(107886003)(6916009)(4326008)(66946007)(66476007)(66556008)(2616005)(316002)(4744005)(26005)(1076003)(6506007)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSFP9IdNsH5kmKoaDf4Zqz9Y7/YOxnOiouqgmKRLNPmgkiMpOtbMqy0u8TK/?=
 =?us-ascii?Q?Nm1Cve99ghzzQBJeg5/Bwe+TieOdOz8ja2QV+Sv9YxL0VOTM+UzNDTkq1lD/?=
 =?us-ascii?Q?IOrUjv/IChUVo1Z/GJ5MMwljLKuX3VSRpMPhd6mh5fBgjzLIOyYh1clbbaW5?=
 =?us-ascii?Q?EPN7TQNE/6LurpFJ1B2mPIMzHZhStRZH/HFxm0HyivOyypgKrisJ1ZvIFwYC?=
 =?us-ascii?Q?wYaEu/YJLWKdSHxPBvd5YWTaPuV2z9wpJx+RgioCEAOpn84f606zxZ9fRsgM?=
 =?us-ascii?Q?/zwYZbk0ntMchknlUoMeUMConvRRqVSS3KdOEbFIopGrEGfUUhmNkQ8Twl//?=
 =?us-ascii?Q?wjZW49fiqS74V0KHG1f0t1ll8ED9MwfLK6XTMCghYhaGqCRU8AAH0GOf8NG4?=
 =?us-ascii?Q?Q4dENWdl8k41x2ofRuScEnDMF3yUfr/KPy49svR/lNWLpH7DnQil95Ye+A/2?=
 =?us-ascii?Q?adNEjsg9T0inhcpBTvdgKK2q2pGR6dDMF6vJ9nwbjzWVqroWknhSgyqqk5Zl?=
 =?us-ascii?Q?36pM8RbKfGLUgSRd+rsDHGM16Arv+EBy7ey/+1oz4lnwdHImX7c7Uc5W7Esv?=
 =?us-ascii?Q?r2CXThg86HCprc0AtvVb56anCih/Lu60IgActaDfuSgkzmgomhkD+KikL+Cs?=
 =?us-ascii?Q?Av/JVVUP8dyK6NSDwsWGuv8myiX0YTFUH2T8z6irlu9jqHvPckmnADVUWlfQ?=
 =?us-ascii?Q?w2Zoi3DCrlzenRr/QjI9+W4TBUmBHEiZB1Jc9JXbfFqjDGgdSOLds205PAu2?=
 =?us-ascii?Q?tVhLbk+tk5a3qHY6fEctego2OX+1HteyOLuc2J3v8Y1mx62VSMiARr/WKzBX?=
 =?us-ascii?Q?fBZkao5EFF00b5xkjYalIE8Z0MrIxnLEV9jK9fJSLi+elNy5I8cVbhNShkUG?=
 =?us-ascii?Q?VU1nrMdAiQwySqk2rjS0Liu1Ltrn5PAMzH+OPBRuoDrcCFDmntmOPKbuvDOn?=
 =?us-ascii?Q?kRzbqUM/fXf1CXiiuXw2FQPrveIFyurnPfYnoQGmy9Zq+Xb2mJQs+BJXkrGn?=
 =?us-ascii?Q?PL7CpAgEeXrCZqSfilegPkHCrY4qIAE2irQfCOhMHf7SqUGuuXgW4swatbBJ?=
 =?us-ascii?Q?lJKlBYW4r8EvX2tieeNlSY8YwlxM+25EN8yo8FLabDxsfA3FxF36Gnhdusdq?=
 =?us-ascii?Q?FgHcNKxThJzm+o9E49F7X2vVlQrlm+teLzbN3YZzo9132kDR/5QvzOakPB9A?=
 =?us-ascii?Q?/kXWi3akQVFqaY38afhGoBKNBxBf3kt0SIfV5x132HtqJbwJy6RVFEUa6TKr?=
 =?us-ascii?Q?BKGixYRT+F17oy/Racas5g57CvpM1OhePCyIRIwkk7r0VD4739PsmHLGl+CT?=
 =?us-ascii?Q?C6WbczLMBrB8t7t4KeZINDx79dHPtgxQONzR5si8wNEev0YuP9OYGIPANV1R?=
 =?us-ascii?Q?HQ4rTc8a8ecNJcuH8nQYIciBiTStfKse+R9sRtxKx99B6/EXdNFKfyrE9z6y?=
 =?us-ascii?Q?jYALGguyXPVKtUUWjGeYXyp65dcGjmjOMw94fI9jkN4YPFyT8zED5bEtb6G+?=
 =?us-ascii?Q?9/uxq2AMvkpPM43SRCEjqzOjkodYE21mlaVMNVlBDK4BbZ6I8nMgVTiXLS4s?=
 =?us-ascii?Q?nxWyfvNx0S7ij4ssqUXel5lxWcJH9H99R5ZElbz2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ee3b2b-d4d8-4a04-b13a-08dba1f74a26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 03:32:47.8283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myV3bbmVICNcDLBQe8T0m8p+O6TBhv/hfsQm7cCAWSkjQJ+ckK/unZjRfahTg53tJNWLmieaAcwvrsf6nRSKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10228
X-Proofpoint-ORIG-GUID: -nYg_w8LyeCjdOOlsKQgqMfRAlrvQhJY
X-Proofpoint-GUID: -nYg_w8LyeCjdOOlsKQgqMfRAlrvQhJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
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

Hi everyone,

This is the rebased version of the v3 patchset, please review, thanks.

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


