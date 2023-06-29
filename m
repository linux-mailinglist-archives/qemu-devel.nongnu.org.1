Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2E7429C5
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtgz-0007Ej-G1; Thu, 29 Jun 2023 11:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qEtgp-0007DC-Fi
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:36:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qEtgn-00021v-HZ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:36:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TE7exG027647; Thu, 29 Jun 2023 15:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=c38/mZPTV5M3hOx0ovdfpaz1CaGH1GxAnFoDlLvC+M0=;
 b=u14RH15d+dw+eJwqgUlMd11BXALO6zKhmVuoT3zJJzyNuyN3lsxBGcTW6SaDfKsTLUaX
 6RjWEpRv3IZw31GXADOBbVoIGXolLKg45kBaU/DXp73gh3EL1P7jBAa7cZExRx9kmjMV
 omCojiawWBOhhTBJId2wXtYQXVADHEzPSD1ziM8DTxMIARNzOWkkcQ0YSoBDYbqP8L+f
 9SRpss0ULkEyOIMXqRCO9nUcUPdRWVvJQydIrbMQXbwcVC4PQgQkC57EiYpaxXiale9b
 yBn6aXN7aDrqBVAd6AR6lMWf8B90Lg0hs0pXKaD+9YfmRpn8ke0gF7wpQKU5F3tJAx0M cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40eayfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:35:57 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TFLSbi029629; Thu, 29 Jun 2023 15:35:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx7j685-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3ALMxu5bK+SNKMTy0Ud/+Fjy35qewx5lf0mxF8swxyaAAygfJuRjVBTtzYMIBFGPTRzocuTZPuRjy8xDeWxh0Mj2kicZw2jR8kQ9zBMFZ0RzM50V4YuwyQBjTZwSMzj0HiZUQZFtugSr0X/ep/p5pJlIeuuewQYZNxVxU9ktJWhZygmwrKZN9S5Iwrvq8BDdLgm5CHvVUbYTDC7+NPwMNoiGaOqLQDCww6UbAZAY2wyXTBVA86b/LAhqfYqYxvsSZl61DfdonNMryoQicvAtbfuL57ry2u0ruU2zO0qdHeXlxvZSV+8+CJquI3Ths7S8Dq3e89J9NBnEcGJdznfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c38/mZPTV5M3hOx0ovdfpaz1CaGH1GxAnFoDlLvC+M0=;
 b=GHxl3VFVCJcefAtZuklhU3hCZDBPxQuWziLKRbDk/cen4iNyA0IvHQFGPppMXiI4l7tR7GMlQpwHq5AJ4LbEJo/ANCcKUuRX/sDWQEWiLaw2aQww4eqAJTHU/vVACjnyB1EvlvZDKdo5h5TWOHwfL7MaEfTC4I+sur7/JiQ7Vr+hj1zK1lHjXTbu9EYaN59SVTsvD6L/yhr+p5SSgnkQVrdKPbqgp6cA0gWz/9YSTQQQOydCi4F+UolU3docngBiyTzDmGo0yx8Z8VCb6qmY0AmqySi+BRJisc8dgIBCWWIWocaODE2TjIBa+gMh6MS4yjXIj+wGtIRybR4NnuvUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c38/mZPTV5M3hOx0ovdfpaz1CaGH1GxAnFoDlLvC+M0=;
 b=oRrLnEunVdHUHCCnbdX/BcmUCogR03jfxgwWNcomF5B2h9aQuRfrKTlSq8RBQB0jheQRsrmiihTth25XisoY9eClCNw3hfr+f0Ut5yKCf6LzOIxB3XPjdLmfzijJ6n3eWonn3+sh5kSmE/tN3W7m5YDE+7wsKGKvDqcIVbe8EjQ=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by IA1PR10MB7214.namprd10.prod.outlook.com (2603:10b6:208:3f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 15:35:54 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 15:35:54 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@gmail.com, philmd@linaro.org,
 clg@redhat.com, thanos.makatos@nutanix.com, levon@movementarian.org
Subject: [PATCH v3 0/1] introduce vfio-user protocol specification
Date: Thu, 29 Jun 2023 15:35:47 +0000
Message-Id: <cover.1688051596.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|IA1PR10MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: c7263573-953c-4691-101f-08db78b686d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyC3t2JAa5BpUID8YnHZqbdr1hfrwBIsj3/GhufV1KVpM7S58yo6oKgyPfovKcLKnm/v20wUlfxfm/Uw7VZNmkcp1ZiEAy0g6IWT42xw9NtsSutkwC0EdnW2GJ+P1hjxrQUeSgg9qj9Ec1n6MFpM4j0TBZmmGGsgZ+xSxcex2rTUVljuVChULYonxgXul5EUFUYj6NalgdUEAhPBoU7Uyr4q+1LwflqWrGdJmoKovxyYJlGR1RpeYUwBuI7ZXAlA0dK8W0RHCxdt93Ov7cZ9G8WE+xP3xjPYaLW1gfOKSybtEZ83+Ji2PjcYvle9lTBWMeIuZoxa1cQYLkRpII4W8W4xoICpg3AubQOsC44A6gh3dccukontQInP5JP9yoLexp1EVL4yEJhxa899e/ziK2GI81CqJJgCYfj61B/++ZLpVz1feOwVo0ovYSnsO8tRw6pMHtCJw8fesP1lzE8fIuRWt3sdrbWvCHmzb032fiqE233F1JunFvH92axxrFy/xJHVMon0RzJetQnZQ+P9ED+p0+hK7xefV/Bpe5UNGpMLIzj8NS2rfw+yriwkUQDp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(66556008)(86362001)(4744005)(6916009)(36756003)(5660300002)(66476007)(8676002)(316002)(8936002)(66946007)(38100700002)(4326008)(41300700001)(2906002)(478600001)(6506007)(26005)(6512007)(186003)(6486002)(83380400001)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pagSVu53EkP3H7E3kQ+WHOOP3YWshdLMCJE6AHNS8ZcI17dVo1xr0e5Yf3up?=
 =?us-ascii?Q?eX5Sa/4SlDd8fE8UAN9kyXTbv77QTvJq/u8GnYsHDHa7p8fQcGUlGpuW9nkk?=
 =?us-ascii?Q?quZV85Iu2r5ujPGBJFQenFFC6hawOCETQvikZWIOiqXZ9t46kikPBoojqpSE?=
 =?us-ascii?Q?TJIazgvVsLfNzzJvtBsHhcbCfIRgZ4rZbYa/l7Da451s5hWVSkOfiMme7p/M?=
 =?us-ascii?Q?JCx7ToRzXl0Yc8hlbbw0oltlryKl+kVAHsJiBogN+nfe5GH1bAyEwXO9btjl?=
 =?us-ascii?Q?LaY6a7GXwS6qHEyKd10tH6K2Mhoo522c+3Ytyz1EKMz3QuMCLEyRjNXzb+pJ?=
 =?us-ascii?Q?7Gfa8O6YgboPiC1iUeYvkk6Em4S2Qnqo6IGLoiPLCvBDpWXAAhHm1ij1Yj9A?=
 =?us-ascii?Q?aNpkRC1QUF4n/WzL2rgEb8y4zPaSFzAcXUesmeZZRizc515LUJVS04CoP/WH?=
 =?us-ascii?Q?DbXxgvx6U/q+YOehb+QQKkRTB6akP2rH/z2FcJvb53pexH0Tc7SWqOo/7rML?=
 =?us-ascii?Q?U4nVBxLHnu+Kb9EJVYhNj84s6pNpbNgDhi29fBqk/fPTLuis9Pi0ahy4vXJn?=
 =?us-ascii?Q?ZhN+jDU8YmTzMkeJpYl9WevL1PstRuT6KwKr8AzNbAVSJU1BHfJ6aU5xq1NN?=
 =?us-ascii?Q?mWv6282lIYRB6XB6W8x26p6kig4HMxuNSVixS+uI8mC1HeM4gaNY5sjrKjFA?=
 =?us-ascii?Q?h1kclDi8rNltHxzFxPO4GqacJ+kBx/NbbwVBS0EnvZsRvOvC9eVGfsYEeKXv?=
 =?us-ascii?Q?uvJ7nYC9SldX8a8PgIc63VbnmBd1Jzv+ty3R3bhHinbhrXl9CXaommcVvS9J?=
 =?us-ascii?Q?0zIamFOsRKMWGUF69+3oEX/KWzwRkdwSFEE9dYAgb1GnVbE9l37q//Si6Iyt?=
 =?us-ascii?Q?bHOn5qHW36j+TEzUpOq37c3C5m7c/24jvlcyfZNgtAeftHo719c+pAIIF3U0?=
 =?us-ascii?Q?4hBVdziz4WfgEvybMbdDyYadvgD+vOZiwY8KDXlje5hF9Pv/+8RDLL9a4dfk?=
 =?us-ascii?Q?6QFFlbaHyJETxbC1s6BCF44Z2zGVvhbQ2kQ+szSH29A11sPgI378ZbFo3i8f?=
 =?us-ascii?Q?XNelhAotPy+h6DAWwyVUunCuH6fgoQGl3jPUQCALzZFVDgrirPv6eEgXi7WJ?=
 =?us-ascii?Q?qbl+ayv3mN9EMNy+8skC828WX6evm+UNgGibu2nKh308B2ogAnKj7+1crTcV?=
 =?us-ascii?Q?zWpK7kQQd0p4u1p1Ndiy4Rl5IPpw0/vyMaCC4RLfLllZxZ9AMmjTAX+BwJlS?=
 =?us-ascii?Q?h/bSO4nBukkFpKw5LKXbixuU3CD7FucdX42HK2IM4TvI8cJiT8Li0SReCQg2?=
 =?us-ascii?Q?0JxLkWdGPdRAt3H5hc3XAAlnf6sooI7P/HxF5yvmQQQt62sNQt1FJVUTQG77?=
 =?us-ascii?Q?JAI8IidwNCOUzVhNKmNsVb4KG/49gJHd02MyhTpA1CPI9nTDjIllvImdb+wC?=
 =?us-ascii?Q?VisHlEQJfBer19zQYb+H7nHzrB1T3GOvVrN8caMqecfjSy9Wf1BRRsBMP+X7?=
 =?us-ascii?Q?RGwVd7zTt0Ey84eNos/YDjW/PtKZNnNFVgqnk+cCMaaYGlNSz+a9d3Wr7QGy?=
 =?us-ascii?Q?/VL8PFkQ7Id5jzKFmpMyYUyY+Xhm3Gy/4xCaj0Gv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1VDKUhTbWT2vY/hzbV3/svk1YJdakIyJ7WeLEGfbo3U01WF0nRngB8xDVP0APfJ3U/ytcsN4yA12OW2O230AueRg3CU/pvFpEJ6vkoXOIrIb93Kyji9314ZegSjL/bgdWgVSzjSUAHxeiCy+iwfwn+ZcJn8tcc56M5AJh1AYvjgnk9p1osfThKztzJwWMbyyoBpiFhm7HZPBYnxSdh4b4wmi+NFiKFze7pyxpB9lgWJHIytybHfUPa08BfB8lKWL1w5jwCs7dG+rSJWqaKkvjROkMmHucXBEZ//rIFb2dSrcM2KxistMQotMwjS+OzLp4kvu3PJn3NDkoMUEy3oiqZwvN/mYaZLuCN1DY2uoCByM5jaBkrw+fptqWGR0QAsG7KeqScZKwvq2PxfNCjmdYeCuc6o8DgBjLlz9Wp9uuYejE819rqq1iAe1HCcyUCciMZm5QxQgzMTW+ukeJtPWXbTiIU5rY5m5VlTAckM7e6bYFvL9fytp5V96OKMrCuvuqd2YXaf27ngDXHN/JIgSng1II+Sz6O4aeMSWo3nchwoZBqaJTI1+CUNMivPKBn6KIZ4MjUgwZhR8fakftXkueU7Ps1xXZjYHziiodxOK5eBe1eEgB247WeVqTgxJDGCGMqVvXXS20fbXJthtQR10IJQA+eVO0wXd96Vz8hS2FL9RSZA19hCAs0D3/bXjDlPYoK3QDWAkvREQXJAQc3A4L9VU98GgTIv8ODyz1T+k/rFA775/z4N1p8TSa9Sp/+U5+Ky5ISdZM5OCzOwtLwVEyuRr9GRRCydS7v9sSR7GKCmCimySeLcY9DcfZJQ7HHsozMDuhiGvrXuoHPfw/wimu3oqi3kxY91AFuTOVFneaAPgcFLRSlhzJYoyvV5mToHZyAXzN+ZzQbPtWZG7JeIyPjSQywjhnbVmgpHAMnZyQ38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7263573-953c-4691-101f-08db78b686d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:35:54.6833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOT3rUbds0OLTDfZFVzObxehtu0benMpDSfcmHkkG9DJT2dZKORq99l904y15mvl/D/g8ABbbjLwC6GKQ/05PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=856 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290141
X-Proofpoint-GUID: vSOryTjontIawD_X-vsvPKVsKNsnHrBb
X-Proofpoint-ORIG-GUID: vSOryTjontIawD_X-vsvPKVsKNsnHrBb
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

Hi,

This patch is a continuation of the following patch that John Johnson sent out
for review already:
[PATCH v2 01/23] vfio-user: introduce vfio-user protocol specification
Message-Id: <b061726a770a8b29cdfe23a698a6651f5922736a.1675228037.git.john.g.johnson@oracle.com>

We have separated this patch from the original vfio-user client series. We
will send the other patches in that series in about two weeks.

v2 -> v3:
  - MAINTAINERS: Combined vfio-user and Multiprocess-QEMU sections and
        named it "Multiprocess-QEMU / vfio-user" as it already refers to
        the vfio-user files
  - We will remove multiprocess support after the vfio-user client gets
        through and rename the section "vfio-user."

Thank you!

Thanos Makatos (1):
  vfio-user: introduce vfio-user protocol specification

 MAINTAINERS                    |    4 +-
 docs/devel/index-internals.rst |    1 +
 docs/devel/vfio-user.rst       | 1522 ++++++++++++++++++++++++++++++++
 3 files changed, 1526 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/vfio-user.rst

-- 
2.20.1


