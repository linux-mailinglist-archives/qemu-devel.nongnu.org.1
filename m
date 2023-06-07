Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2A7262FD
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uJB-00020t-DU; Wed, 07 Jun 2023 10:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6uJ5-00020g-Ie
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6uJ3-0006eS-Pn
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:39 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3576JsKB011477
 for <qemu-devel@nongnu.org>; Wed, 7 Jun 2023 14:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1JKILPMA/RcP+4QsprCzhPWMGRrA27pEoSceX6RYuH4=;
 b=MIWQH/tZ+Yne5vy4MEaLLRxy7zGIZxHUsJIOh+PJjnQEMvYZSBuUgfrk8mSfsAwFxFJo
 VYExI2ZeW9UCIcFWbTS/FgK1Kuu29igdh6PGGZ+SN+zEHBkZk2KkK3BCx54U5EvZN0b1
 UUURIxxHT8AyZCEi/89N56vUzT+uCO8ITHvtQaa5epzQJXdnzgwcgwUOeP1ISG3qzen0
 BUluugvJMOo6t4otvYAPbsnevf5wrB0Aj3uc3u5oZc3l1eymiV5W5rP901jbQRUxIcCy
 4LNS9YCbgLBcBYrcFdUzb4khyHWKkOrIKHq4+OT6ZzymoYqmbOo4M/Jls2D50rk8nGBu qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6usy8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:38:34 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357DGZus037136
 for <qemu-devel@nongnu.org>; Wed, 7 Jun 2023 14:38:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6haunx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZIKmNxwPjEBmJWLakMxKdwezIIB7XmfqthaEzm106PBjmCvTimNHgZqLnmvelxmeKuStqzepfldojJaO/fO2j3PHqNU3H0EYoOIVbAcGXunMVU3ioYY+CqAjPuAd8g9zIhzkM/7FSb2ivDC5T7G3hMnMU8f7417eD2V1kyyVpbzUemsM0cyQhyKLoSuPTJSQ7VPG9n1ihkUrjZlb2AFCCuUzbFxR8wGVlobmtY9dSGgF6dh7ROyc+xGW/agCmfUHIuhY+TAxbjQaLeFL6c/0eex8CnE2SJQysFbHPo/NHd6TUoMhVzf8IjNrIAyR1RwJpSNP1BffNL29ZewouipMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JKILPMA/RcP+4QsprCzhPWMGRrA27pEoSceX6RYuH4=;
 b=Eg27WgmhBZUc8H8dF2nPqSOR2WGYV0Evo6iBlvh73hkeB2L0U/lFT0WJATmnmHBhUgen0mH/Bthhm8SRGW2MfzyXfxIGJuanp2rBDoUcBujzK9iEKudR/P/LWSxmiUx6ddOHqpsb+xpukJF/lq9GOUHI1oZDIvhZYrBCN1eojkNvbk3UiMrqTN1XhYuS5MwCQWf3P0A9FAfhmFxAgTOxWiK414XnMz7mRNw8ofcsNUsRAiLjQNDdRhbkB0EcH3F9YB6HmmkTUhxf8095vIo8uLxznLpUOR52wESkWzH9Z2b+76AvjnSHzbVeiGJvrgkfsXDubUfzK9Kf8fmNksby7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JKILPMA/RcP+4QsprCzhPWMGRrA27pEoSceX6RYuH4=;
 b=mN9Qhnhhbge7bgxBVdRmAFr4WA8SmmYBZwCgX1oI9iv3Vn6kTrZ//xtAdWO8JNvK0v03TxoCjIIloIpNqRq7O7Uy3dBsotPKBorN42yiphNHoDN0oRAsrhMDTxjSe1PHWuIHzQHBloDU+l0jFCW1zl9o10sR6kH0sHHFMdvICk4=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 14:38:30 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:38:30 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] vfio-user queue
Date: Wed,  7 Jun 2023 14:38:25 +0000
Message-Id: <20230607143827.1435488-1-jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0003.prod.exchangelabs.com (2603:10b6:805:b6::16)
 To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c9b0a8-418a-43e2-0945-08db6764dd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2AhijgvxQU+BB7OqAzV0v9D+8avb3loA0mVgRXp8zsaaGcYokNEhzSD4vXChzb66q5aiDfmgxy1JhxRIqPn4SLskyjJxmP8AzCFU1KbcPj8Fk3MryuOTLTTRuuaB6pQGi1xyF8TfJ4jmvqrEKNsib3evEyHIsg6nfEvlaknl+uUEbvlrSVFQHHqypnCTne+jteoeh+KVczTTmMsFcAnT1sm7t8jdl1Wj38FZeUvNVSXM160EnXBSYI8ikaN1owMN/tsCgYKY/3lE0RcG+mWbZYV5v7xJ4PnaRH2NaMqdgIlDtiG1XQC2Alym+kK3Q9ZU5eFSeCKuOLx7Z+XHzLx7+Z+0mJ19JftYi2HZ1amoKU50pxJ9JNjwf9api5kQH+0RsNjoUiIDnqS5rdN5+gHpFfoFGrygZMvWQ6Fq74UC5WSWTYoaNbvM4uZ32Qf+tFvzGD+yrowRVyrKS64PqzjHD0Uy/UzRnxtFhpb20+593WW23zBbnuLZKVQQEocNKRuxOMoZBvThp8rQe6jZoZRSvD07AKd7w1ASyXraf2Sj5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(966005)(83380400001)(478600001)(4744005)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IugDqoBLPT+5GuIPkc68u+gVH2+uQrgRZ9VWyN61JW0B/gCRPVZGdd1Ps/X?=
 =?us-ascii?Q?czpVyVpxv5xAL8uWkL7YOT7XiUBy112xzGeQQf+cFSMkTAfoxrzsTHH7vMeS?=
 =?us-ascii?Q?zkhKJy6SFxomGBt7uv8LyvOuPffL/f2Moidwiugf2HzWejTAMpl/2+s2zxgE?=
 =?us-ascii?Q?edBnHpDyOO2N0vtAvkcK2FPkZcOcn1OYOC8iyQyaSR2YDs/kzonMEiB48vi5?=
 =?us-ascii?Q?FbWzLYymK7kZ4ASzX0VtmCJmYMAMYZJQ0wNbBEJre+rdQ0mY8bW7e8L8mfmA?=
 =?us-ascii?Q?9HKwamZRyOEij4mZ3WqlRepVgBwlsgyz62xR/rBZBHe4yHGfpgSyDXnRYCxe?=
 =?us-ascii?Q?9IBJcQxf8raisAFahnuou1+K8fuFORpmq6hg2Rk992N+MSmQ+42wS/UScw6b?=
 =?us-ascii?Q?IB6eoBxEx1rJbI+AN0fkWy38+5/nCF0zd+2rBFMxsRVfiP77S+8cJc9JExn5?=
 =?us-ascii?Q?uFF+t9xlMK6awa0XZwpEBIPt2mw7xAzzAeJ260M0VLqpx69Cv+/sR8LoisJT?=
 =?us-ascii?Q?QeQ5lSBV+KfqqhMzmLdXfOp1nEVQer8DiAI4fsuQ/tIBzoSGO+CH3Tb4PLBo?=
 =?us-ascii?Q?pV/yccmZr+Kwkm5texAFe734MjXxyb1vIEcVkk1KymfuNDsHAzBZTC8iYpw/?=
 =?us-ascii?Q?ETOiDqFhIKiiwclKnL0aZpwhuSJb4w6UQirinu/34aAnrqB7/4Cy3CxtrZOn?=
 =?us-ascii?Q?tCmepPz47T0O1Ah/zJrj7QgR2Ni4qqTV+KDhIIERmzt/1yxXQPykx91vRRpc?=
 =?us-ascii?Q?/dZrh0UL8HdUxsddroQvbrNDFhpsyfF52rfkumz8+09YJjc6fJJ1KbE7QnjC?=
 =?us-ascii?Q?GHNnMpAFuB0dpiJ52FLdaWA5X9fEsvcQkLeNP8Qzx9TDYR22BzudiO1gU/Kn?=
 =?us-ascii?Q?VUzeRa1fw3CD1pGNONVxfXmq0IbFE9QD8A99iH92z8iLR5zo3Kay3ZEDWykH?=
 =?us-ascii?Q?RTQyGWqXxvtzJFcMWib9I5mzwS5aS1MGuNvAw86bLBnNyPNAGvdCr1BWwCFB?=
 =?us-ascii?Q?mFeuEp0//3Yfe5YFLzkIoEc0zVJVdFlTtHDVpRnVMB0dhPAzxehv7/tkp5IQ?=
 =?us-ascii?Q?fI7xwW+nG6IdFZ7Nh9TOVvaxCkfbD6cJfqKfCJ1WNuyNJ6UBDVRu/i9Iq65j?=
 =?us-ascii?Q?s5f/G47g+rrmvpcUWNO8tUIGdzoQzCydDjCKkyGm4OuNVq0uUstvy8DRgwgg?=
 =?us-ascii?Q?uvSDoX3cbNNDuI8Sd3aSs1fmAt9NtNf83+tYzQxWzP5YBx3ZZ2B368s05czm?=
 =?us-ascii?Q?q17uwd8lsYmJJPjk3NizGYiwd5pIKei3cs9c7y8ZyhLnS/kzTtmPk1w3Zxl6?=
 =?us-ascii?Q?xtDfttlYmga9bweEugJKHr+pynmpL6BR8gEzCKrYA3z6+EKkJ/vgwJxUuHxD?=
 =?us-ascii?Q?MtAXcPyiVWYcrgdkImUEcV0NUO9OaJWgty5HQmmOzpTKDs79zRvPMlXufFvz?=
 =?us-ascii?Q?eQoi4IgU5AT6j2TDQRaI1hEKWBQjV0R87aMLhfZQxR60F1BYdRXs0OORWIoq?=
 =?us-ascii?Q?rQY2NUcTbor7L2o68fD+Ly59YrQ+ZB9QQxdJQkJksegBmu/utbhIDCwQYvnp?=
 =?us-ascii?Q?YmEfEtLnP9IELkDbtQ81imD5KCO6s+9D3FkRHSfx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QGJFk0leu22n2L2PJKLSLupB0VOTVc+eIbfBmFsfhzAb39ckLGi+ng6Pa2iofshKdcHiJHAvNdrm/w+u3mddGxjXtOojPy8zjnRPp0yDWp61+Db5OomPel+2RsAUKXs1ml0pVYHEVAT9lEi/AywDbpYcOv9XjhO+vBWrgrTqdLVnIJBd/fv9aXe7UGhuYfd3qSk9uor5wYsm+uqaBOvraGQXBxIEm6+FjlFljEmkq8x2DKndlR3Aaz9hbAvG70KCqs6hf/EYVytGRWD0YGguYR1cDEnU4Wjtcl7KX4iehwCFxFbxZ5gP6OmGV4HrZe+iTd52VP+tg/J+iCpy/BJbi0htmvhrzJ0sg0HbTDU8vN+lzotboQNumvhngE5f2zCnKZeRCpFlzsajtDU5wJStYyEtjXDZM8ePYFn4Lbc9V480PdLYdzh2odRTweZACmXodecEiWoLNJ1TA/Ls/LS/+D/02DpaTKhwkPL7Y6X4GJelyYF8gbPYOoz2kd5nw6bieNgXWjSP0vHtMtF2Ifbe3t7zZ0/teDY0QNBLWuFN6Qo6QMZod6KiHP1le0/E0SOfyksxy8V5uX2Udre07mXUOvEDV2DYr9S+1rKCQHeVSIYH3Du8pF5W5iFagkijeHxPasbOBS9AENaTrQENe6sEmBRe/hdByRcmL3CwMnazCF2tyiTQLtv8c+rnjCULIUXJvNUAEhu+TaWMRlhlyHScMMOTHA17FurlcrhF5NUnULC6tzC0+Cjpk+lnGOHfbUkS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c9b0a8-418a-43e2-0945-08db6764dd16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:38:30.8342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eHPMvW6uOOtqunVuGt9UuELFmagTs92TXcyNmdigo9KGjoyFkkPK2JmVzh95kzpFrjULGl7s/ijSXI0wULaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=831 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070124
X-Proofpoint-GUID: H47er2bJ2qeP5RCWVuVrEMkOOP0RFOtC
X-Proofpoint-ORIG-GUID: H47er2bJ2qeP5RCWVuVrEMkOOP0RFOtC
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:

  Merge tag 'pull-target-arm-20230606' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-06-06 12:11:34 -0700)

are available in the Git repository at:

  https://gitlab.com/jraman/qemu.git tags/pull-vfio-user-20230607

for you to fetch changes up to 7771e8b86335968ee46538d1afd44246e7a062bc:

  docs: fix multi-process QEMU documentation (2023-06-07 10:21:53 -0400)

----------------------------------------------------------------
vfio-user: Fix the documentation for vfio-user and multi-process QEMU

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>

----------------------------------------------------------------
Jagannathan Raman (2):
      vfio-user: update comments
      docs: fix multi-process QEMU documentation

 docs/system/multi-process.rst |  2 +-
 hw/remote/vfio-user-obj.c     | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

