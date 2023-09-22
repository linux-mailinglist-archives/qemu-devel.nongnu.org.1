Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1660E7AA997
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja69-0005Fs-HZ; Fri, 22 Sep 2023 02:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5l-0005Dh-1I
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5j-0005DA-CP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LIsSjq018770; Fri, 22 Sep 2023 06:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=eUj26dcQwy/mBN06BgEdjhWrgG4dzQlnKi2T6Af6STw=;
 b=fpMUplLs8ypsKKCCS/UVdwfIJWSaHyuPh09VUmLu4ard42cl49a47klP+WS6lRqHOiyy
 KON4lZJUfFmUBm1WdoUhf2v1jIWt/VRzzU+IOBLHLu22FcAim7kNi0LjCcxICEZ6O6in
 aJDK7EUaFfCGc8+a6wZ0MAPBAXN/RD15KTPVW5g4pKNQFSfo8vU0zuBn3vqorinFmy+l
 esriLCYSz0l8dZNToD/9R8WJp3DhNXSQvoodgEgVLYj7zhnLCAAothzin4/dHHBrNxLE
 aqBQUsfD8SDRB9QXVTYFs7pmjYo+p4SIL8+VjRPxHqAV8OAK/jaoqIZBAQ7SAl43WiMh OA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt012ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:41 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38M66iFF006857; Fri, 22 Sep 2023 06:56:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t92vwxff3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGTp/o3Ktah1KdO1lq7JKC/arydB4xSIhcE/JuruuS51y7wiwbqkpUbQbiORfAqcxNU1DxzpKeo9eOH7k4bZe8HFH2cvLliLkkXmj7KkL9jjiDX4uPofw6C7GIOLtyCE3mg1PBGxkO2/lGn8w6Bk/ZQg7nu1YbH5RH2iRDHYedQf1v01bKR5RCzFQqm2jxWVq1QI1iinEo6/DwFvUZA96j16LNEaoI6LAabD+yYwz4tDV3SnQ4oNLtLBa/0hIt519/QIGEnFTIaeFSqKfoaXRTTYcwDyVbPK600MMXoUDLdw5eAMhIhg+GhSXdKhq4kxxZqNP4UOeoJ5rs7Irz4asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUj26dcQwy/mBN06BgEdjhWrgG4dzQlnKi2T6Af6STw=;
 b=JVTxvhIuaC3KjfHzjwV2U6PSQtbUVsID+HYSfmqqMhQ9QXzroN2Tqu5BX9MvMToDLQm/8vfYSU6nstuJJpDSQM85+OggIAtXeMLdwRJ7c29jBWf/ktMaLvzs0gJHjpsJe915cUN+YqJMkXaPJAMlKcXEcGTEmTq7QFZIaD2aM/iEM2AHQMKP8iUsT4ary3aCFVRAT5JkMNzXRZ1piBqEzqD3liD3+85hXfR1eoifCFgLbyim+tgGcx/ADbSVvItk8gS1Kkt7DPREKDBt5iSw8gem2KJCfnV1lwBjmWLd+v3YhqVYdY0CdsEkIhdkcTyDd+TOveBIn5ZbraDcJ6Ka7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUj26dcQwy/mBN06BgEdjhWrgG4dzQlnKi2T6Af6STw=;
 b=NB6BSRK68/iIJMXuPXprg5MDz8SkOw8+1soGFSS+N9gpPEm/EJ6uCqHDzuhoxQLLu/6lQyxSOCNti6/b6o8KAb54imKlFzoXYBer3sykhAI3XSx+bGaf+yw4V62xIDozSq4tuK4RAvHWHm0lgWd/oDxyd5z9W94H11Wehzf1Fkk=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Fri, 22 Sep
 2023 06:56:38 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:56:38 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: [PATCH 4/4] multifd: reset next_packet_len after sending pages
Date: Thu, 21 Sep 2023 23:56:25 -0700
Message-Id: <20230922065625.21848-5-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 149027f4-1158-4aa4-4dda-08dbbb391153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/n48hsOWk4w5zQPlxJJZjsYhK6StDR/STbWPLCpzFiRsWZZlc7UHEIBW5kvNWVOMpctwygrhRCw+uNKTIAtlswJCkhFIrchUI5jEu/NfeMgjA5wvsrEkT+8yYg6CTfDGajEDgX8/oB0KHcoBa32bLieW7QQ2o9itxaVQAjDATutR5Gcx8WL3ExJ5EE1I5CejgdEaSbDpd7mfLt9WW/XMOXKUUfafJ/i5Giz4HdKTj+s1SEFAHs+c/A5NgG2pApAQjOhY55KT4/XDnZNx70DDVJSOpT7bwyqItG9DdVx6Ismf+0q0rUsoUJIgCwhmomq6756dEZY7De10jrcHJDOBI8rfvGHYdw11Hj15BUn9TrE8E7uG3d0d/GCx7E+12g/lSZtJKhY20JTExPLfoFhqOmub1eqFYHzC1+VsILgt6CyXjuTaqTQ5/X1WHTJ/eczui+H8bmikcZePs5vOigszkVi5EY5vsEEH/Sg5aXzlF1324BsQR6CZ2rU/jGXN+/rmXrJkKeZxxtwV1G34K08W3sSYuLaLYgcWEjjOVkQ4ZJXYoPsGDAc2HdYzRuReZo9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(44832011)(5660300002)(8676002)(8936002)(4326008)(6512007)(6506007)(6486002)(2616005)(1076003)(83380400001)(6666004)(36756003)(316002)(66476007)(66556008)(66946007)(41300700001)(86362001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1nCM3dDo8HIWqK9EfPFTwskTyezfPodbRcAqL7er+m9T3dpiujgiRtD8hUc4?=
 =?us-ascii?Q?NnsB34tDgALI4sJqoAueJ3/PW3nYNMkwCivxcxzYSGZqV2rn5otM8Jc1ZwId?=
 =?us-ascii?Q?ajvv3b7MG+hZCebJVI1XMHtH9Cd92Fwt+xbpTa2jRjGXUgudHGhkkaenrhLx?=
 =?us-ascii?Q?vhkUG3zfbmU33zzRSDgNviK/xEHFde2tuVslDivmcYxE9SuNrWq0MlBUwHsV?=
 =?us-ascii?Q?XA0vHRVl35TPzQsqI8f0A/wiffR9pT0e68mGUfKO4wNSunKkedNJQjFAa4/9?=
 =?us-ascii?Q?3E5xR8GvbIWu7kGdAHxHo5zgG17NSFlnd/3edKOxG9ddVKpTG9S5RU6N6NDF?=
 =?us-ascii?Q?e+TGb6xdQqbbq5APyZkhRcdPSqsXTBeVcdOIlyS0im8veRKbbdJHW7k2kqv9?=
 =?us-ascii?Q?CVjBB/CPHhQz7qa/KhqIuU+8EGNETucg7kuQHhZKK70sC8E9YUBJuLhepfcy?=
 =?us-ascii?Q?FWWr32U3h5dECG619SSX+0MI/96k0Je3j8BmZb9LrxcnTtEcxAlIA24JM5Xy?=
 =?us-ascii?Q?8nUOzjahC9LB8Jx7GMJsdkRLolT4Z37b2FSb0Wu6/KGcf9Sc6iGcD3xvRNTx?=
 =?us-ascii?Q?n1M9+PFFBvVm89M9eVy+jCMXh5H51tLObFBnjNN6Vp9eaTYLGCL4bPWuedlF?=
 =?us-ascii?Q?Q8EMNCTKnjsg3E/MgvPiXiPWdD7tNUEJ0AgkNv7/lGMGiR2OnzWlPOn4tkUn?=
 =?us-ascii?Q?td/CM1iGhttv/1huwTBMshy0+8IiCdaGpLITPjGbYAzyge/UjhW58zvAphlz?=
 =?us-ascii?Q?C3PlZ0hKjbD3UUp8oRoDMttvEuMhhMafqOUV8YQFfukbWsB/tVVv7g/sOJbD?=
 =?us-ascii?Q?qESS1pgqv9fZmGIEbh0MZhKponGCP2QqxSWknynZ5G9SQ7Og2CGq8eBX1JIO?=
 =?us-ascii?Q?/DyXvANv3XkYnBUPTixXgzpsU3CKowUWSQWMywOR4okDVzwfEcEP8QOKByyC?=
 =?us-ascii?Q?tBSIzYGaHJnznl33k0C3rSlGjkD5qbtmfdOY/TVkPgrgGYA0PFP4fiKFRq/y?=
 =?us-ascii?Q?1ZdVHrLq5cMioIVRh47zRa4+VauwzI8872rOTXnn0J9NMQc0dZBkRfFF+LL1?=
 =?us-ascii?Q?xd8dhqGu79hWzyjReSq+hb0G4r0B22NkUAEGvTvyneERQWivB1LusfGhaM3n?=
 =?us-ascii?Q?hsyPnNF859BnwV4x1sL6EC+1+dPPRY1tYnRYre7x6W6LFQzw39gA4/uGXJ5N?=
 =?us-ascii?Q?zCpOPthGEF4a8JuFXaZBRPjLkXkCxhfZ4VrkIxLss3qiClHQ/yLfZYC+fkEG?=
 =?us-ascii?Q?KCTOZ+qVUS/LmJgtnTJO2u5yePeY/kHt50R6vUlfLZj4s0cHazjh6wkvFgKx?=
 =?us-ascii?Q?iOuXIKhbSVKpSXBHC5OyagcD9aHv0W6BZHGK2EfmP4SBDgXOLrOY8ocaGXnL?=
 =?us-ascii?Q?n11MdZZuDSQLNTLXGXbs6yMSNMhGExEJed0BQADs1ixjkDcIAXsh3yoKqpN4?=
 =?us-ascii?Q?MdWYm53kZdFAhANeflOG/6Lw0HoigGK9gMZYYB+6M+tqw8BPPXV0mWMDqUp0?=
 =?us-ascii?Q?LtDuZxtAUJ9G7zDRXbpoytkIZ+7XZ0oxk0+fa5UveH6UVoobiYa6zCp0jMAe?=
 =?us-ascii?Q?nf6OLWsA8A6fWO5QssXgX1YyhOVG6jzZFzFER1OYHoOXgeMxHn2sgfVXsGLn?=
 =?us-ascii?Q?GpUPiZqoY5R49CmFjOJRI/xh7uEyPuiLUU/ZKclaKk9ZXeAxgFz3HPf+LYBD?=
 =?us-ascii?Q?33huPQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NJImWotEWMTr0LFUqP5K18NCDzrf7PhMJi0s56ECpPrFafi+d4qdS2E1KP+fncf7/H0aN9Vu4YHa4I7+r03vMRJK91A1O0FAGiuY9wpb8/IeU86rjB3TeGtn9iE7BXta8x+KivuypYT8wL3vM5BPSzOXRMpIqO4xGCiyNFhUTLZ4PcZbps7HVt4wB/AB02gtfsGwEy6W44buk9mznZM+s8lrxY1ekaMn0UgVZ6Egz4cFjYo0U/1az0Cmvpv2ESETbXUpTEcur5B2uN+g7hwz0XHjErreI4Ee04jXIpjaum9BqcJIfVLnC2TREkI1Yb7R3bpQIwlStFU5XtK652HHIyy1jmXZxk3Zvl4MOhtnWSxBky9N3SvrhBvGLdc7KTRtL60r77P6mXT2xWA/ae3mIJkGTM68J4pPwBfo+We9rG41dqh7Px85sNyaJSotROBewsXMb/03B/lnBIGw0Flkr/XV8FXiiDrEL+x2CGnywvq82uaUk6P/hk+rU6C7uZbSg8zTr3W7fCjjkEuzKYh3wwAp0s4EsC3dkaxI4vcugydQQkWKZv3O38POUta7sbhg4WylYsQO4EYL723eycybxfThj7CFXB3vlZXtvDV1O3dEZ5mFvt2UGOs5F9sgj9ZtsJVwMPdpvEtRn2egYsuMPyCls+QWh2FO61dde81XhOTUK3COkEE7FL/xhth9kCshqb8B78H/8xJO5jM4px5CcAfLiYFvE6LgidxBRcJguNlbafQpu5s7jMZ5npH8sLtHY+zLYgLPNeMyLZrK/yfjHg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149027f4-1158-4aa4-4dda-08dbbb391153
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:56:38.2240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahK1LxCiRmYWynTPK6zEHuGv8mmkHIUtUQxYPs9vPSQe3NkIxCQ2x3E0xmwl0r/GFHfUjGjqWvw5ykzdLpko3SRnrTAy7kCEqnudVxADFQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220056
X-Proofpoint-GUID: jupPJrZP5QiyvAwiw9BBbd67veh85nNc
X-Proofpoint-ORIG-GUID: jupPJrZP5QiyvAwiw9BBbd67veh85nNc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Sometimes multifd sends just sync packet with no pages
(normal_num is 0). In this case the old value is being
preserved and being accounted for while only packet_len
is being transferred.
Reset it to 0 after sending and accounting for.

TODO: Fix the same packet ids in the stream.
with this patch, there is still an issue with the duplicated
packets ids being sent (with different number of pages/flags).
See in below multifd_send trace (before this change):
multifd_send 394.774 pid=55477 id=0x1 packet_num=0x6f0 normal=0x57 flags=0x1 next_packet_size=0x57000
multifd_send 181.244 pid=55477 id=0x1 packet_num=0x6f0 normal=0x0 flags=0x0 next_packet_size=0x57000

With this commit there are still duplicated packets, but since no pages
are being sent with sync flag set, next_packet_size is 0:
multifd_send 27.814 pid=18602 id=0x1 packet_num=0x574 normal=0x7b flags=0x1 next_packet_size=0x7b000
multifd_send 136054.792 pid=18602 id=0x1 packet_num=0x574 normal=0x0 flags=0x0 next_packet_size=0x0
If there is a suggestion how to fix this properly, I will be
glad to use it.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3281397b18..8b4e26051b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -730,6 +730,7 @@ static void *multifd_send_thread(void *opaque)
                        p->next_packet_size + p->packet_len);
             stat64_add(&mig_stats.transferred,
                        p->next_packet_size + p->packet_len);
+            p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-- 
2.34.1


