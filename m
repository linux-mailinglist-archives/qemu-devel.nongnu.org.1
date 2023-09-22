Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB97AA999
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja6M-0005GD-SB; Fri, 22 Sep 2023 02:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5v-0005EN-EW
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5t-0005Cu-Tq
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LIsojr008307; Fri, 22 Sep 2023 06:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WHMGOJQneRlx3RNmZ5mnBaIIVv1UhegMFSTP527o31c=;
 b=j2D8XIuZcfQJwdLGkKPfglJcW0mSJ3EnQTvYRkXlPhxbOoISGYRuifcquG+3SzMUFRbU
 5UIR56JG8vZDbfpQPGBi6hc5riZy1E6EXd6SM59+qucFyh1lzX/MyvQZUOLDk/uNNHbU
 58zMx6CA4LrF7YjnBsbasqzaPE4618SQnyY9EnkhN3QHnhWmLJMYXUxWh42rUgaJQP3W
 xZv3KsDs/Rrq2t9nnX/2oerxmQxCausRVU1ZO6zcAKDFHF1SgO9XFwZGWOuAyu0gtut2
 S2yAwyp9zsPjbAJjMvabyohozpa7+plmKMuVmcZlolnUvYvdIWJMRQgESC0+FHRqJVrC 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvs212-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38M5GF0h015636; Fri, 22 Sep 2023 06:56:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8u0um9kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W19HiNTAzcuuakP9I13sG1SYyzHu6o9IN4DMa/u1dHsz1xUBNodbQ8JZBFXppstDXLQ/O6/Ej+gIZvyzOFCte7ImfMU4WbKlcybf5tvhKBAkdoUEfdHDVUXiP3NHWOffXD5mYVhuPxE80SMacvn5d21R6hBotfs/O8/2kp7rSNYhqJcRUwRMbDqGRbYF+wWrpctCgGjPEHUASrEr9H2USc0sStW1CSxTpp/d7IxeC16besbKuyK04PrrHiv1fAOAURVZQU8lqcVYL+F3Ujhynz/MVhqkqDYMm3FEMzlliH55BIdAjmm92J/IY7PVpOK5EC1ru3XLLdarF2uephOL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHMGOJQneRlx3RNmZ5mnBaIIVv1UhegMFSTP527o31c=;
 b=ctMfCH9cOrag1TaHQ9iaojq72NljIChFhBurvyay+rx+azpNwuvLPUiqlUm483nujF0B4Bd4n5IFgapqIXG9U6CplkQyFA1KlGESkzS5NUiOfuD9rNpfqAmmcIPjMbPxSeaPWmTIhccyzGBxpwUYxeHNA9jLszmhKF92IJJMWe1qwLUVNDmX20uSTwy36ol+BIvKhFdqyYQCwWC9wLl6haNWgjxz02aai1VwGWBpJeb9P+CFr7fzUv/7N/dujukaWVy/IovrOw+vcFrrMvgkzBSH/Hy29gHbbBrmoqNTg1g4cKc/AsDl97YPlbc1qUXFsuAKvcA0QNvF42k1Qvi1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHMGOJQneRlx3RNmZ5mnBaIIVv1UhegMFSTP527o31c=;
 b=Xroi+7Vub13ZhxKlWeUGfkWFVAIthfK0NXIonHf0xfi9/QVklBrMYuUWH1ESiQitM3Ej8iKTGjFdRTvPm/8xNAFXWLSW+6B/jFhz5RvM6lpW/L2VSycefDdPF4hcX9jP5vbJhE4lO/KRWna84h1gWuKvtxJTMwcucc2NJadH6wI=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Fri, 22 Sep
 2023 06:56:34 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:56:34 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: [PATCH 2/4] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
Date: Thu, 21 Sep 2023 23:56:23 -0700
Message-Id: <20230922065625.21848-3-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 15007204-9999-401c-482e-08dbbb390f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joC4XW8oLqzfpbtMl29DptNNmIv9szVBOClfQSmKsPytMmbBSWVfQBezM/w8KaF5hZ4X4sa/CWdMY0d7pyen0YfqphJFQbI+XS+ZatvtLLfFKt60X3BzUEZeLH08oaa9VC2NHBmxDN2f7OehxDV2tm4eNw/ICk4IbCnjRkrYuZvZJwtDiDxTNy20R/FDURnzPYM1Y/zkTPGxvBrTGXk5GquA7m7i7gPEmfnTC19YjvzzJ7d9DvK+5tZICg2rVcyBFo7yjxUleNxDCPGTwts4UNtmUqyo503mCLIfHEOphazHuzbLxPlAd3wkf87Vr8QhLYHLd2gLj67IgOBcw6ImQMR1ipRumnmfrzkx+i+Lfvek+7/QM7zNm7BoplIz5rdFQcv5yQs20wThmQb68SuCimWeZHsTBMibt8v/qTrRRlV506xglahdAEuYzHitXicSkqsXWkUs069DPZMB+FI6JboejjRNQy90PISH2GesXKpq+8tCU9m/qoyOPlg8myzWg63DJ6/eqRxTPdyD8qCN6P/elmphyNltcpTf8FQMaeHQejWnQfz78G+1Pm3BoVaW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(44832011)(5660300002)(8676002)(8936002)(4326008)(6512007)(6506007)(6486002)(2616005)(1076003)(83380400001)(6666004)(36756003)(316002)(66476007)(66556008)(66946007)(41300700001)(86362001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1J3PcV2Q24VJBbxXxERN4csugXHJMs186uWWtgOxUi2J1qS3UIIznrY9dA/?=
 =?us-ascii?Q?uRsH94fJ1BSrz/4fnnaAyJmPnv6tm6sfLuNvvLFnqjyBC6RPcHbLB8scqCt0?=
 =?us-ascii?Q?kjsCclXtswGUStV5jMS4MvJjspqfAVMzprUeh++oBGZ/8V69jy4DDH42c88D?=
 =?us-ascii?Q?5FbS/qS4A0etmJsaA9ikTzE3UHPS3kzGkkAJ6w/skUsW7dVKxh6Y+nI/0fFU?=
 =?us-ascii?Q?14YhSzI+2Bfa7xWJ2JRcZrVs7fXea4pgaNqupaV4kzu4AdSvrEizroB+ATNd?=
 =?us-ascii?Q?7JNrYYV6Ak1E37NHfTCTkBwXK6AtJZ8VaHd5IwuF1Pz6N7PxgEaj647cf+sh?=
 =?us-ascii?Q?SEWXZiULUMXfo1QnADqDr6MpTEK8wvxIiV14OZHDPwi4DdlgSMretS+VB/CC?=
 =?us-ascii?Q?Jzdc6c8eGiwdATP0LrjRoB7hhstHa7PzB2f84m7AbqibFMzveblSdJ7Uk9qy?=
 =?us-ascii?Q?YW++Mx21IxWLPo5ZO5Nquxh5yBpOr2yuCww4MBeYOhyRlFL6Xo+qLEKouT7O?=
 =?us-ascii?Q?0nsaddTVr2ZclP+KNN3J7aY1nponiRnc6M/PdPFKgnspJEY1vCAKaZ9uf5lH?=
 =?us-ascii?Q?tlWZfAF7kvCdbYfVG045irVMY+xBMfCjBJ5bdYvi6Ecf46Yfo2MfuBlwxG8F?=
 =?us-ascii?Q?f3eY5z3JGnkhUht/cErAhUVKsEGBGGtGjkFdsZpYoXSmCRTIahCULHWHQxam?=
 =?us-ascii?Q?ABDGTUU3muxWJl3xxRC5q9OJ/5D3YyKreVAnSdnaBoMAIeVtjTOW4ShD6VVM?=
 =?us-ascii?Q?R0j/WM/KG2oIBTZJL8qW9K4hG9GKZBzy38a/nVRhXDZddXj7WdBWxX1bwhxo?=
 =?us-ascii?Q?YMKOtj5bra5MiCOjEoEOMbvQ7DgCyzfKc1za9NnONtg5e+IXw/6kg7JalM/H?=
 =?us-ascii?Q?ZrJkEuxq+Qqql/X1yPvtEdEX+OL7vMWqCX4oGcir1JPjCJHPjaICjuqUyt+q?=
 =?us-ascii?Q?hNPlPpB11iNuzfoFP0DUD3wLG17x0Xv1TGFyseHoNZgl4PyXmb+G2TBz3qs/?=
 =?us-ascii?Q?wS5PYYoWkl8nbLfeUPbCFEdiWgnH4vvWFygxUIuhCaLkyNDiWEMQKZa/0U8P?=
 =?us-ascii?Q?iyUXLJireBhSt6GPovfb7C4Odw2QaScjpsMLQfXKEFK0Rjhixj7z8+NrMr/B?=
 =?us-ascii?Q?MLWFA/KJrF9CqTW7qVJkNMrGC/2lLA+67WgaXCNLKmUhMB7MCjhRpYfrI0xd?=
 =?us-ascii?Q?f/NvhrRdIyYAuyc1AeLPo8JPsHC/tlQtbNCKtJPpTS5RmBYY1JwffRHpnv5I?=
 =?us-ascii?Q?2FuVk3s9vNeu1TbZzx+5hJle3JPsauySnjlX4t5YUF9McpDfpBkYesQqLyyC?=
 =?us-ascii?Q?fWXCm/pO8kzscSMorYH1+Sg8kZyUn8sTq5alJ+0jNKtH2G9raD88s9bAWgXt?=
 =?us-ascii?Q?NHro0MCOhxODHCq09Yy2GVxeTfJ+K/Fq4bLdcbX8DseK1qIyt7V86O0/9L/z?=
 =?us-ascii?Q?sZnmNvgLH+3+8+wIAXqN3Z2YPd2DJiMLOL0l30zUAWZO2WrmXDNufWKfo9eL?=
 =?us-ascii?Q?MgXOKYpF3LXI0BhwIR3EgaVHAHTDd5wR0SpOo17jjn0n7fy3WhhzxpkqUtya?=
 =?us-ascii?Q?M4Li2d65OjyKpbQ+/qrQCfRiOo6C1Bg8zafMIBEzvjIHn9SxXHGWIM2iNKvY?=
 =?us-ascii?Q?5yjgxnaUmDNJ+dvTjPYHIpnlLqDA3VEAppEOZPCL1u3bA0sOU8uJXlTfRVsn?=
 =?us-ascii?Q?coerOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CnHGxk+sNJ748VRWv4JKEQgQ3hKJcC+0mFQDQhn7H9bKbdYLmYO4lIhn52p8EGTU4UP1xWv4aulllwSoj7H61+B26tC+/qAbJJbH9a6EEesyhu4QTXBftXpLlBe5Lq5FZFcug6za4xwMGaSg5mbfC5SA1o4MsQz1oQhXiozjv/EdOyHAgQ9kT1yxkG6S0+OR9Gh2qQRah/Ay0PM0L+DDIzn+knkl45EO9y93t9/lbIAn1YZps6bH+vbIt+oHR6neQe+MmHqSIdB9GA82ieNXA6iKK2v5MGc9M6h6UBSc6yc8xH9H5pCoas5ufRaQHgPATe0bH5KTC3rfHeRIIGmqNk00QMOlBVH5BVyw6WoMcu+n8izvkfL9vOBkwbNs3DwyFN1ZeOwhGvBirPkOYvgQ24XUuXjwp9/uISLiZUWQ/GwtGRHXXUkN/ldyPbE+nkNX2/imu50qwo1j9vo/SHGk15zdq8m8AwvYlyk2bYggA23L/rjFvO1c/MQLFnFj0yfQbVeahqB9cwtuvWeQ9MQbjzxQF8VnYTAJ7XACgdZ3N2tpAbo+mRNl3XxFRBvgSYB9wr0W3htdyOQdSV5ein5tStR2twsAZmcHyKwPb7LKgGYmj2WUWs6BWVC0bBTjowBU18Cuz80gUfIWfHlkkgTkBkBDDOK8oB4jMBX3GHA9J1lfMuUvm5QYqHc87wi9ZwjVJZnfuP+dIImSI6wR+riZfvX486fZ217xGjKtPrhwND2nKoM34TipFLK6AV6Vfj18/Nsas5CjMovpQohZ/L5QUw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15007204-9999-401c-482e-08dbbb390f3d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:56:34.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WF7Ypm8Awz8n4UXUex86bhybPe724r6vrOb1QxrUO5Y8fKrEOmeTF2tfx8RwG/+E9u8k6DyqupNo2lczWmHs4TdKvfixnlRwLK9aLAKlqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220056
X-Proofpoint-ORIG-GUID: WOLQtiqkvmZw9oQMi7zK7YGFSsn1FrmA
X-Proofpoint-GUID: WOLQtiqkvmZw9oQMi7zK7YGFSsn1FrmA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In migration rate limiting atomic operations are used
to read the rate limit variables and transferred bytes and
they are expensive. Check first if rate_limit_max is equal
to RATE_LIMIT_DISABLED and return false immediately if so.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 migration/migration-stats.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 095d6d75bb..abc31483d5 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -24,14 +24,14 @@ bool migration_rate_exceeded(QEMUFile *f)
         return true;
     }
 
-    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
-    uint64_t rate_limit_current = migration_transferred_bytes(f);
-    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
     uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
-
     if (rate_limit_max == RATE_LIMIT_DISABLED) {
         return false;
     }
+    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
+    uint64_t rate_limit_current = migration_transferred_bytes(f);
+    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
+
     if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
         return true;
     }
-- 
2.34.1


