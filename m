Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081E7AA99C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja6j-0005Id-0K; Fri, 22 Sep 2023 02:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja6F-0005GL-U2
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:57:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja6C-0005Bk-J7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:57:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LIsoOJ009379; Fri, 22 Sep 2023 06:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=tf7r/zzxnlbbLcpIIOW1KXDUI5YHH52yX3M2HUaMckc=;
 b=DdbNfidYHOXh2rQ4GOTcu0oUaWYF8wrlLOVxKOSi/lPYsF6sXfyPz6C97PfFCQfdmP0T
 BPANklzGLdXolkrOF4s9HhALklebrLCmdBgkRusFZ7z2RBGuWsR1KQiFN1uQtIhBRkt8
 j5sgolrKI2mRREaiqL7EKITnFTc5efYDbPTTWlsscZhcNJ5VIAJEy4WRIMvBtjIgLO1L
 OkKOR5bJhxLH7DrjXLPV/LrR03/R3qntFkLgmsnLRA/2NbaoaA6aAWy3XpUag4R9C298
 X+371wE/24usC/H6DLeBAOW8fTywYThLTg4zJOTcqQ6QzrqCmFUsXdXFka4zIwc9DHED sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxs232-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:35 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38M5tR1s029722; Fri, 22 Sep 2023 06:56:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8uhcbqym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFiZ/29KimGQLIbcr1MIipJKZ7kXGreEpALG+agtWmv+KvFjdL3wHxn3iegEwtY2QUaCDcXzltwp0eNW/BrEskf2N8cROWqkjcEkRAI1XZ+GGAWZ58qFiQPVLGiwFFvYVGLDTz3X4GBeirUKvoyECMGQKqSFnSRiekoawVmiiK2oe1g7i2/tLshXruxQeaKjD8BsT3JRJKOtFhh+bRKoy6Vdx3xXb4eyz1Bd7AbuLzi7zcjLxrSOVGYPdAhcKUdX/ewytIZF4pYgfTUEjGjR0BSvBgYzLs62lwj9mWXBQN36H1auM/Wc8T1hOejJiLxMGsmamNOewZue1oL9vUWuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf7r/zzxnlbbLcpIIOW1KXDUI5YHH52yX3M2HUaMckc=;
 b=EkHeDSI7M/D8pPSHPxnYrOsZaDtFiNBGO+sQYgoHYGLp+UhHqK/EL8k5eH//ZBFTStA5YCT+nnxY0hNoT03NY53HqLExYLs+c61ao8+Jeuu4w9ofEVmddAli3SKDWTK5neJ068u7AY36WxYGByrHCidbUgbelgsxYGlueO4N1H7jRWZ8KBKrOOY0Uf14W+HPBhT+T17btyIoO2Mej/Qv+OGRmK9p4fBTwSIxV9H/GA52BIRuxkSYBKGBf7lKtWy/y27dyLXYvwd7smE0rGClgjXoYbMIeKSp5hzJrPxbu/n5QA+itZU/dl3qz7aDW07QFHyluWnOaojBI02u7OfChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf7r/zzxnlbbLcpIIOW1KXDUI5YHH52yX3M2HUaMckc=;
 b=PkClliq9rL8sfXuEaVme0QdNT/NfeJ5SQvdwa2zBUzQFaK6Uw6dyzvz0L2OFNQ6dQyW9rQJa+6pFsIjjQKjpMchBc+SEgKM9nAKAXd65MJbZFLfgLrCnmjNdFb73rrqD90HTYn1QuSRTIxLlBfdzoiiTdfTrXsY1/m9Rj1YxEOE=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Fri, 22 Sep
 2023 06:56:32 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:56:31 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: [PATCH 0/4] multifd: various fixes
Date: Thu, 21 Sep 2023 23:56:21 -0700
Message-Id: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:a03:167::39) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd6be26-9ad4-4955-5505-08dbbb390d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWQJoogYg1vyf/HcevQ/Bbhym/d0W1EYnr7tVQeU0wZcw8h+XGNmkumYdZ44XzpvDiMadN/Ix8qqjh9rn9nUzSW7+a8PlvamDCeqQAY5Vmmm+vLjTJt/lCpeyC/afIQRvQrT4k9+q4M/MSlLDlcwLYwirdGCVwCRcMxtuV0yWXHbQB8ZyHPvmmJ30ynwP9ebaGVcPXC16QiOiauvhYUNBQJ6RL3ZHob6oGRrraf86jvytJG7i0XWGJWTnjAHr+9SA81jfpUey7WrZU4s/xdcZpJ/azX2sPTQ9Uvpj0RPNpGT/oxvhPCj+C+ehJ75W17ZC0MB2AGHYZh1gv8QsTu739Tcyk7RA8OhTBNbel7N87h+qwkwlxKGLgKC+c9/VjXghNTkOjebqzn+CzFZMx/iJZhqBd+h5Nm6+1l9NGcmd7JXvPQF6MJDvuFFZ4hdW5cB+qJBq+WBM3wGeT/XsLeP7Wa+Ekb8I4XBv+rJPYgs2rJ5kXQTVpihhAnxQJ5w+DwPSVRwsuNezepqMhCNSqz+8xzxr0xeLBgjLoEFJ+FVE7LbsW3qiL8k4UNyc9i3+s9G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(44832011)(5660300002)(8676002)(8936002)(4326008)(6512007)(6506007)(6486002)(2616005)(1076003)(83380400001)(6666004)(36756003)(316002)(66476007)(66556008)(66946007)(41300700001)(86362001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yS+c3jsk0UxzOWh+VWUcHpol5rgaafD2T8n3lMR/2kN8JKV1cj/L9TOTQU7B?=
 =?us-ascii?Q?L94bfUKfqe0AjvMVn3+cPPlfJe5+pMbvoonqwU92drupmQn9PajRIq3MUt5u?=
 =?us-ascii?Q?R2d23gTgo+KQZ7D1H28BJdSqKcsRq2UJWh+K3jhtoUOj3lwa/0SZs732yQIQ?=
 =?us-ascii?Q?5VAsXFzrMctj5SYpwZoy5/nVLVjWY2MCXRsa147LU3Wd4FUGVAxjZ1EYSrZy?=
 =?us-ascii?Q?m3wCuX8KN/qOKkP/cIX7o52F1wbUinYKL/t5xlYs5UQJtQ5wa8N1TZNxXgqj?=
 =?us-ascii?Q?GfBeY0tgZJEeJozF6+GZgJ9JlpKUEyck5CJBmbxA2KiFuQayxXXIoQ0mVyje?=
 =?us-ascii?Q?zGog9lS+m5fc6UeTIGeQWbPJjKr0OS61m0zZW/Mgal82jnyFiSKzhGkZr1R2?=
 =?us-ascii?Q?hb+EN0HYr00MMOQ0Tq7fSAuggmB/q1qE18jo2ruWhGstmMmXmVbkECpk8QQ0?=
 =?us-ascii?Q?uhVsSH9iczf8qeAP/ysFrlOQN+vf0ElhAvCRmTkxPezUPzIDf2l8nU31AuD7?=
 =?us-ascii?Q?u+eqAjot42NpNFfUzVK0s1NfyDdPbjwOCTivL5ZUO9IcF9XwUv87RoCTb6RH?=
 =?us-ascii?Q?7iOzPIDAAN8NoxJmC5APNhFhqJWL/JOsTrdFnUF5vgh8ylB7rTr2KuZRbQq0?=
 =?us-ascii?Q?9iWgYNAcgkppMEOqleSzug8+cx82vHlSi+PYIFKmv/udW7algUoOaVv/OyA7?=
 =?us-ascii?Q?CT74GqvF2z7NtVEWy5sAKTlTGpkozKLYASWIDGrD86lnyWQ63iLNJsg54VWl?=
 =?us-ascii?Q?bGLXLyS/S4x+Xi+nj/0lNIpTpmuGAMeszKJh8fCyclNdXaxAIg8Bit6MMjRE?=
 =?us-ascii?Q?owzeE0cvs1IPRomZWkLk+4CxXTAbr9bU0ntXy/riuDpUU0EJO8HsVHsgRVai?=
 =?us-ascii?Q?W1c3gdkxivdjdnq7mq3aiQfdof7Ormrl+3CLvW/rHbIpGiLNTjomLoK8wTV6?=
 =?us-ascii?Q?32g9M1yVzVBK9cruwbtKCzPsgX4LUAM9sIHZRR1eR15aluPjTcjQ1wDf2wfb?=
 =?us-ascii?Q?OxNRu3U0LdlqxaMPLmrJzcwWrs+UW4CHjlRZ/K63Ya57AqYGHqoHFRZjkxy+?=
 =?us-ascii?Q?vsqRyRZs7ZIX4PTo35J1cqDqyt9Xb/iAqIbqMZ8HR5tVFhSybDdGSKeTKZ3K?=
 =?us-ascii?Q?onW0UzzhApBFeBkYDkfpF0E/ze+iWiLhK84vEhBtx4TQHQXWEz+/V82iiIKP?=
 =?us-ascii?Q?IaMXs9Z3/xf4MMBLTvdkMX+It2lqbrP8f4Lvv1quEkDSKQQWgXC1MzoQ2Qal?=
 =?us-ascii?Q?1MMkRRd/mA9PHPAQVO52bpF7r21iOsB3LEE2pw4PwcQekc09dO7a/RpUsrcO?=
 =?us-ascii?Q?H8qyeYLcjOVVCkY5LFQXHDyIEmY1ecmqDSuoyPWK0m8erKkde6mLjl/r3zcG?=
 =?us-ascii?Q?/LLBKh37xa7Kxn0aIQmF26p1yqAbbnkNH95Gbb/bTAlP1TbwBzGHX57QGFbj?=
 =?us-ascii?Q?VLelb6Kpv54VRlKLoBUa9f1rhWKk+QF3U6mAhNKxWO3lPsa/f7gAQsQiM29P?=
 =?us-ascii?Q?G4FewfQ29Y4/oyyjarQyAOioJ/w5mdKNvudqdfegP0x1mX58QKdAdC1F/I4r?=
 =?us-ascii?Q?8B3mOYSAWREj33UJ5U5Yevxsa5Kq2n1zIfmlLQg2voqq//kei/v00wVHT7TD?=
 =?us-ascii?Q?zHwP9CVfqF80xv5lQw4RG/tjSYEiFhTNxT+vuG3T8lfCRbplGeEM/ZP5b0Tz?=
 =?us-ascii?Q?9FfWIw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EnIN5BHwqPB99suWRBtjoxXJKf24OeTRnxPZJpzy9aYz5Y1vQTuyWC5MrebTB1J7UUlBjSaWIt2khCJMhAFpdFUFICWb2KsI3BXp0mBFzd9CrtbN+UVmy1pE0CTRJYEgval3hkOMvJ37blQW4RICpCX/qJylEyjpmeRncB6Psq54Q3VaGWPrY22tMEtpurIY7WmnIhgpy9+2n0DSqczXGiIaXO9jmlbyY2ApcierJjJq9PvevgBxFpDcVbMtOCS5NFr1jMGNzOTaz6RvlKi+Hwyv2tfNd6gGpWhjIi6x9Xb1RxIsU4EofEIn5XHR/BmyG1KwovOYf+HjV1gHEYMKhnkQy+kDDap+BkntV7Nf7stiFHRLO+BDNVj3LqqY3Pj1k7iohWo7mnY+g0L++9e2XOCV09C/OqVNExSCWAh11dA3KK5UlhGKiXOz2galTRSuaq3ZT+U5u65pU/5DiTNOHxm0elr3Wk2gia8I7FjjhYYWDSZAFtrf5K+wUg6DN2XFC8F2wR5A0KC0HFJ+e2bGv6qvtTgasIzdhSyM5U3hKuoK58vRPxzOmGpM16LKLXj9j9WXG6HnuD3Wa9qil4g4ywEzv+IW0qveQDbswojlwA+G8mWMgA2G9HBqjNdCWmN34ehQZIVV6uwfomICagYVxEyPfCiRZg45ZlA/YIKiN616DhARwxSX3eRHQKPdLZuCLnJWERPY/VmBaH81quzjYp98deRpIFYmnLO0OlpdSw/Q34XMo4cjWF/A7uGGvsimKGqa+268+czdURq1djKr1A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd6be26-9ad4-4955-5505-08dbbb390d3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:56:31.3655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uup3jnhRo2x++OTaiYZByJQ/ATZei8RNon2noyzKFl/X2nmOWGavbpRnzyiIYcufHmxrFXAP39KSghCAk8jqJf5TFG1ylnSJIH9F5Ry15l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220056
X-Proofpoint-ORIG-GUID: YyGI9dSSU1fhbDXLZQRDrch6vs3PgaYh
X-Proofpoint-GUID: YyGI9dSSU1fhbDXLZQRDrch6vs3PgaYh
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

Hello

While working and testing various live migration scenarios,
a few issues were found.

This is my first patches in live migration and I will
appreciate the suggestions from the community if these
patches could be done differently.

[PATCH 1/4] multifd: wait for channels_ready before sending sync
I am not certain about this change since it seems that
the sync flag could be the part of the packets with pages that are
being sent out currently.
But the traces show this is not always the case:
multifd_send 230.873 pid=55477 id=0x0 packet_num=0x6f4 normal=0x40 flags=0x1 next_packet_size=0x40000
multifd_send 14.718 pid=55477 id=0x1 packet_num=0x6f5 normal=0x0 flags=0x1 next_packet_size=0x80000
If the sync packet is indeed can be a standalone one, then waiting for
channels_ready before seem to be appropriate, but waisting iteration on
sync only packet.
[PATCH 4/4] is also relevant to 1/4, but fixes the over-accounting in
case of sync only packet.


Thank you in advance and looking forward for your feedback.

Elena

Elena Ufimtseva (4):
  multifd: wait for channels_ready before sending sync
  migration: check for rate_limit_max for RATE_LIMIT_DISABLED
  multifd: fix counters in multifd_send_thread
  multifd: reset next_packet_len after sending pages

 migration/migration-stats.c |  8 ++++----
 migration/multifd.c         | 11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.34.1


