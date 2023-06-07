Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C8726303
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uJK-00022w-Uq; Wed, 07 Jun 2023 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6uJA-00021b-0m
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6uJ5-0006eg-64
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EXs1U005548
 for <qemu-devel@nongnu.org>; Wed, 7 Jun 2023 14:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=v0WHxOH++wdZvykDDtWrhgGcoJ7D7aJQKlzcbP1y1Sc=;
 b=pH5fmbHwZvRVxWf/1QJ5Bo7bC7jPx7Vpwy+Q8Bsnux2AaD/T13o+u5RuP8WRrHn3WkZk
 b8PmV2BvXE5u5Oui/w/DbqsQv7Qvyv1c0cTWYTNwlBmoOxUQNskcNEDoqHjCAH7oHC9Y
 3qw0czQDKrIrZE2J+Q/CZISfw6cPlW7VcHFEnmjD+jZ2OYZ98iFygP5LD8bbiJA/bUli
 Hk0fvBreMnZDLGghlaWReLYfI4loSq+wGETHCH1S+MN4gqrymkGcQqraF8CtUqnkMPrx
 /2gqV6BKhfODYLO6qm0g9DwT1UZjKOonQkRsma9PCyCnU17cLVf1VPnZdUeuk6GVWG4M AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6shyqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:38:35 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357Dx5W6036807
 for <qemu-devel@nongnu.org>; Wed, 7 Jun 2023 14:38:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6ju3jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l55PCuRpuZR5nb5pbck5KjOdkH/xJN5ZK1Vva1dZmuMZXlBOtsfj7DVCiaSepKuggVN3Ln2+M6iBig2ofQnaymrATs4KpCqqcUcizuPqc6xmGC8F1765HAqi7hMxXuMYv0Q0hYi2mO0j1KOFq1FPQCD+lAQxiu8OFCMpb1x7A33P5ZKXioD998jWyr+g3hgyWS5lUN4kOAV4fD3lU9iAXwlwiX3UcDWPz3MWNA6CvGFZlMb6vvu4bjWAX+kuSs5Gm6pMNs0bYB6vDhH7WbyeEXE+7Dxq+kugK/FpzgXpUwh23JNIjS5CIO8KINMEARo0zDEpO/7fw/DLHTS7K4Yf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0WHxOH++wdZvykDDtWrhgGcoJ7D7aJQKlzcbP1y1Sc=;
 b=jauki3dY7Y7SZKiFJovXtTgzzy9eUuslx2/htspHCmFrNxbrlgCrrlkxmva7O4621m7NlOsbXYQqoO0Bl/DTyPeF3RHNApmjmDN5McdJ3ufR17pl6FoCeHKjlbfB75cQFnPlAR4EX4JFp0Skx+hphOg6DPsIDAfrXCIsIEZt82Rdj2zl0ojDWBwDv/vMW4Snt618XjfyJGarNnFcc3W49QeYl+RwQWAfDfTmkt92pU+uVFMgRNGOsxCGPETmrJc1pjR2vkakOzLYnMz78NdGWVFaGKQDNBOg7BaP6dNDA6qwr9uMSXPuWM/flQbyneig/z1gPlg4VnSsbsALlZusBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0WHxOH++wdZvykDDtWrhgGcoJ7D7aJQKlzcbP1y1Sc=;
 b=BIA2GVy38ad9AFz/t/LtzdSzj4r544wvwrH4DqE4exb2381bEbp1mDkLRMRmjTgQOQf9t8MfvcqQ64j/L3d0w7NmBmMrKpKqCsv3kFFvtXIykOoP/6gp4pcwD4yzDm7hbHWn1NNP66h2VIuTQBGqoxy8eAnUG1o/9rbh/7WTByc=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 14:38:32 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:38:32 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] vfio-user: update comments
Date: Wed,  7 Jun 2023 14:38:26 +0000
Message-Id: <20230607143827.1435488-2-jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230607143827.1435488-1-jag.raman@oracle.com>
References: <20230607143827.1435488-1-jag.raman@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1381ba-9a0a-477a-59cd-08db6764de2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duE1RDbGNOWbmu0rKEVBAAQQoYbl2RZ/Cq35DFEDg3cINzAN/e6VOTnsAKp7IQW5lp4QUqdx/GSPvyjWasAFi4HrXlb4mpDZ0wQYwCZXNU9wJVlZ6qOr2LPxNGsjSCZyUCLpUbKCw+0qLw+uZt75XUkkTsBsvBKZ8TVHPnWCGUvhCWPs708HFgZU6ExKUCp+V/8dcCtjNkZyGfobUALrGUD5IXXmvezW+j372+QxhwEcjA/YNZebLPxBuJZvA4uOLcv43PRtGWi9MA+HNaVzUA++JvLQMm3lzsBotccR4l1qaZBi+5+vxP8Qm/fQHigp2wQHFEq/wBzDPHGsOy+XQ9FEOEU2ciZnJbfnDFXXErLVerrb1dBmjhXmwdTFpPfsK6LpbFGODPknZLwWEc1S6ekrCpKzUC6Y5W/3RNJUToqJlNb2Jvk+CpL42ifyi9yqE5gRTAtDKCmof8RARrUGmtknWV+ynUnj0c+0KB7W9y9h07IliMNY8bz28jr+NJ0woMHHisTzAgKMnTtvai0K3WOMdN4z1wDGkbVNHlxc1GoOkhgkhbJ1nmt422QYMFhK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(86362001)(15650500001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8p0S0wpzJUJIjOCZpZ6NQzb9JQPpJUGqtzWEwPzEErZKnFOuX6T/voPumeP8?=
 =?us-ascii?Q?dEVhqPJjkQSJM8TSsM4xdmEpTlSuYQwySgR1TR/jOCY0BsKdL7vYfnArUlGW?=
 =?us-ascii?Q?WEIoultMiS7prtXXvSIoGM9cNzGSQLD/nJY1f+mlKxZFbrux8yk2Ub0+udRK?=
 =?us-ascii?Q?d40anL4QG8uClO8RLkO+0y6cTvGd78k5h4965ftaleVAsWhkm2JWknDoL7Up?=
 =?us-ascii?Q?+Iqqdv3fHHK7ctPtYdsjd9KRlmbv8WlJsyerdKQjlROINARX8QXRPzjwnWi5?=
 =?us-ascii?Q?qWvGPUvh29g1qQSmY5zgA0RhhXhAYsOMp1LhA/bKqMTHtpZOw05Li7d+jnyX?=
 =?us-ascii?Q?gxOpODFbP5HLwhKhC7eJqN3utAlyeODPuZPjhyXNVmYOrkP3UB1uou9dkVY/?=
 =?us-ascii?Q?VoHo4Fzl0wAcmKw/9YSGEP5SMjBgJEpKiyvT4+IC3X4i3lvADlbB8ML+NC1J?=
 =?us-ascii?Q?QgH1EVINy9T9X/i638yAGQnxyrotvzIFGsYhWUaAa2CLpXvvlOBY6cLrhSdW?=
 =?us-ascii?Q?SvzF6FUEDANvxGfnswGyfP/eaghU4Wywwm9dufJytXoOXSoH5a2x/gExI1zj?=
 =?us-ascii?Q?qBC4S76B85GVbOke95YFbBU/dvQeLEA2Euq7qxaZAXTkUEKLAHpFpCctsxfg?=
 =?us-ascii?Q?hTuxifaLG3tFpUhHV4arZBhrXUA/xqkNT6RR9Gl+vTKtwPWvbWam7ExxKP+/?=
 =?us-ascii?Q?TzcaePFk07YtCzEZJ5xBCYANgpPx8IUoqUw5j5+6h0K+eamXoaq7S8UuVny0?=
 =?us-ascii?Q?TyEstMtyXksdRZIj3qOvG8sDA5iPQ2ZIQ9fdNhAO8nMSVz2rF4ktbfvqTOrZ?=
 =?us-ascii?Q?pSuIKe6AlACY+/P5dv8Wte3Vb6A+uMonFOrOjskqUQXiekXPGaL/j3gz7ajc?=
 =?us-ascii?Q?vABZDBGMN9He/WY4B5ujq62+HH36/1uhcYUUYqsEooAvzar/buPyMNMKflfG?=
 =?us-ascii?Q?meKiZ1pS2GePZo3X3P/IbUMfv598FYlxyrOtW/jI3QKQpaFdjpOUKo5Y7al1?=
 =?us-ascii?Q?mePh7WYa2jBQlmBfUnRuFrqeIp+90NwprgkZa9VetEF+KASP4DvvqPwEtudi?=
 =?us-ascii?Q?Ra5FmBKwSzpPs6qOm0L3hRrx4syVge1k/qSuIDTpZysOA3GXqHoFxXV7k+Qn?=
 =?us-ascii?Q?1xPHHD+szpOnoiLzcFqEwnav6pB3dfYOn83LUTRkJ8sCLQoJLyNrWwsdfAvb?=
 =?us-ascii?Q?3KYwCOEcgID7Hiu5jmobuv2ctWdDVpNRZ39B3OxnpQottZhJEt3zcNnqeIVZ?=
 =?us-ascii?Q?1pqWRJ50L1038yl9NN+6PwMbr/YlSwFeuCzE6S6uZxtWVgRi3Hha31BuW5yg?=
 =?us-ascii?Q?hRGAGrStXYTQrUbFsnzL9Zt+J5SEOh8TPtksCqXlNDfDUM9Obs3Zb+3f8viA?=
 =?us-ascii?Q?sfP8mpX6JK2fHtUTOfCgPT562JHepUcpbVDJLOoJxs1SAQS+B6TGCgrsv/4p?=
 =?us-ascii?Q?L9lq/o6+30hgzUKIzImqTh8ECV/kn0ZbP8p9HlXCP3yL9NU3S63qrcQJCQP3?=
 =?us-ascii?Q?6dJ44amWd/CuggsFJfhRndhm78qjxw3C9jgphk4ILDGsy7xdwVDfabx3PF11?=
 =?us-ascii?Q?Lg8+ZnQW/YRUF/oTpyqhrV31uddhFsXfKWY6lQPG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y6pm4rdyIf29R/qS34MiwKdWrb4IHVn1SdKUlxEuw7rAoRL7xxP7E3YiAk10o4ZWEu22hgyrlUlujGrALOXNpMYY3v2lDkcjFgOTOgpXQMmp2X372ont0IH+at4vR3rmYrxIXws5YEGSuDIYOSGVDr94fCaCAqs+XQF0KR0+RS2gFW1aSgMnhveCFShxBr1qZi4gBCQzmib9rcSVAZNzXWZT5HU73o/DNjsg8I6Ho/6abXLU/t3+5D6dViHoIo0XTAetvrpK+cbvklSnU0AiLsZQp4ye7oWHiSWRAS4dGsxX6OXptltKb98C4VgvDXIXgpB5fcrFhfjK6z2YwSCtM+f1LbaoHgefS5i2XInja0J5NkfGdD8PmjuYWxJKfZW3H+uMdYDYsBJx+n5oxKIHv9lHPca7ZPlfMEK7LhPRpbCPatOgpg3EmmYYglwb36L7sa8FTLNKKA3UQuezt/gzj8ThwEVsWojTRcUx/aQYfL59BGbqDpfHmaSV9/ghK5jF8Jm5jsC38Y9mO/+5KCP/pdtTVOrgBT3U234reyhUte5SZ51FfhOiA0vE/LdlvyUOxm8FBEifzZwb46SJE8DtVGL9d06mEMYED7dMZa2vlhJJGqMkXuUIKFvWJNBgPBOibh4x7FiGuV/mcxW+UJ9YuBAb4zlMUsanMCbf2EPvCb2sa/CGYBdc6mnNN86fU0JMmoJzy0YloUwyuaUvISJodXwTIBDr3n3AT7wdJSlmVKoDMXkI/s1ChYoHpdp8ghpu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1381ba-9a0a-477a-59cd-08db6764de2f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:38:32.6340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As5f6BBC15ONttd+yQxGAJQX5LPTX8gWvS2Exlf3rYj0f2wx4vSf4R3y6TsoLfCBl/QZOkaln1g2StX6bBUTlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070124
X-Proofpoint-GUID: exHMFsiHghgqAGAC1Vwaofr6xusOocsm
X-Proofpoint-ORIG-GUID: exHMFsiHghgqAGAC1Vwaofr6xusOocsm
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Clarify the behavior of TYPE_VFU_OBJECT when TYPE_REMOTE_MACHINE enables
the auto-shutdown property. Also, add notes to VFU_OBJECT_ERROR.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/remote/vfio-user-obj.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 88ffafc73e56..8b10c32a3c6e 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -30,6 +30,11 @@
  *
  * notes - x-vfio-user-server could block IO and monitor during the
  *         initialization phase.
+ *
+ *         When x-remote machine has the auto-shutdown property
+ *         enabled (default), x-vfio-user-server terminates after the last
+ *         client disconnects. Otherwise, it will continue running until
+ *         explicitly killed.
  */
 
 #include "qemu/osdep.h"
@@ -61,9 +66,12 @@
 OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
 
 /**
- * VFU_OBJECT_ERROR - reports an error message. If auto_shutdown
- * is set, it aborts the machine on error. Otherwise, it logs an
- * error message without aborting.
+ * VFU_OBJECT_ERROR - reports an error message.
+ *
+ * If auto_shutdown is set, it aborts the machine on error. Otherwise,
+ * it logs an error message without aborting. auto_shutdown is disabled
+ * when the server serves clients from multiple VMs; as such, an error
+ * from one VM shouldn't be able to disrupt other VM's services.
  */
 #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
     {                                                                     \
-- 
2.20.1


