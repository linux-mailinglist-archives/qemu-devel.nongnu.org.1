Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2167B7F96D6
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:30:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PUp-00077x-Oz; Sun, 26 Nov 2023 19:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r7PUl-000777-Nn
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r7PUj-0001Ha-W1
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:03 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AQNnuvU025412; Mon, 27 Nov 2023 00:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=g7jhaoxx5+XFdL07NL9vjufvwtMVG3ZjGk+HdbxAgng=;
 b=VpRLXkFEFJOUAZ4pLd/3v6UBq9iZfuA9Xi/t4ofwWO3MOudo3hANcSpTC0j9UAhCXIVl
 XOW4Qm4kNoXI3YUBKwvUVYWVnCPnC+fQxWgVT83+Hi3o4VIDxCEMvYoQmEiat+Lj7/3z
 VCvaLF8Sktvb3LwPVqfjDp6kn9vTOglo6ZTRb/tPyZe6qtYnfyL69Fd9JYRXGD8yHf8o
 aGipJYrLq3KQ2KuIdQgtGMVZPzH2lJ0W6jpseqJ76tVdvROHiF6P7WBdSHG31rU1KoOw
 kLjOPQT63aUFlGQoPFCQUWlPQ8UWJK4YDjJGj+Yxy/OeF1vVhs3dEuUaO+z7W/VmNjeh 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7q41sm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 00:28:56 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AQKSNrU012597; Mon, 27 Nov 2023 00:28:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7c4vpn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 00:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byocDRSLbkTZyDi89zQlewbvrCbhl+yPoswAxhaT3aGv8bzsrQoT3u9BHLMzRjE+FD+LIxjEY5COVMTTKBW2QWoIw9eYWOHrTA9mx3RmYAnGVK6/TpXvjw5ZNtoJ16vuhUhjzlfJlOM4P6pFABBMAUgCSVqMhaSAggugVkPpO7doksJX6LcWLnGuW1WSLTWwE1f+qKAKhAfe2KPcuoUMklKN63Tx1d5U6al/AaoBxDq2H2+X7+V7sYDtFYJMykjA8ukpoR57deFC0YEL1Gj93+wJ8+MsRWvyRJREoOvG4Lc17u7qMJyEnySV29kN7ghk7M1HkOVXezfZxQWiCNO4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7jhaoxx5+XFdL07NL9vjufvwtMVG3ZjGk+HdbxAgng=;
 b=UGdbVt2KjjrOUtQrbLQgk5uoPNiGbbr1qRJRJc4ETnBAqbxTgIC9Dt4s+4d12xTtCPlzYccR4UA0o6I4zQg9sqv3yaqffvX8emhK3vVHBlXHr3Fj9FAfqF3NdrHJ7UFI3L4oHjLr5etp+c2Ag9ABJSoPIGyUirdPYRGCb1FdMqCgVF2T4NZgzWBYGjTR0UtG1DcLpXChNqQZC5L7HJAIC/sVhchq494oymAtkiXfAxwJVb2l20suku6porq4M1rOC6BUZZnE2nzY6xhrD2NgjDnFNRN2arvGhrQc8c8/HLaiBz4wB6Epc9W7gGNU2a/yGs6WjHFL33cUPYoW/0khNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7jhaoxx5+XFdL07NL9vjufvwtMVG3ZjGk+HdbxAgng=;
 b=mCLDZckw7G1dcEODhdVHEO6wmFf8Hkv7t1bN3CDWhfRUYn47Ete3FQim7Z2vvzKXVSuGc/XNVdiWOB8NxXJxGBea6xFfX/kJ+TIMFvCayK5zlGyBOVQHNH4GF1GA92Qjw7WSlhc7i1Yzl15uAlykrF8RO41mPLNpJNEdxm1BFUU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DM4PR10MB6863.namprd10.prod.outlook.com (2603:10b6:8:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 00:28:48 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 00:28:48 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 1/2] vhost: Add worker backend callouts
Date: Sun, 26 Nov 2023 18:28:33 -0600
Message-Id: <20231127002834.8670-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127002834.8670-1-michael.christie@oracle.com>
References: <20231127002834.8670-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DM4PR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 609ebffd-4c9c-4b97-19d8-08dbeedfd2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sS0qTErcWjiBPel3G8+GehYUjVPM4FwMAqgzkMpbDO1IwOywhFABz75WnruE0boBmBkzy3AmHibfmJIG6IH2ePg8mrDWFHnNFYju9xAxhYnH+k7OsYwiV6JcLKelhcDeRan+hEi0/JU1zneYXwTpou/2sWzatsTRj1QVOqWo4pbWruUwxdQySTXYGhcL/6NJoV/QdoBJVYLYFC3372nXpEiIiDyv+55DWnWSUaKsksSRna7vjVgKzBJJAJNNm2v9/7hzlG+r5zc/FOtmkG+zAMkEHy4mLSaec/g8eIbGol0KxgoyMTkHE+mmGiE/+wDHFIGn/OQpDapptvK/BWxO3bT9GYHoaR+unXnE6V7+SoRZo3uq9KG8kRWEpdsjaL0n4qE7OYcNG2rvBgDmi/kw/juyuIJggWijQ2waervjB8NqF3THE+zobEVX7/9Q2iJcbb8GH92OePPxlSwcElma7GXXw+QLxSnmwmuHn0Cc08ZTNCjBYqUKQuRAuOrTN0r3uk7/fxcGnDxIzV9ByumSNrM+TZqKITDGcO9epsEGy6qyhkWaBTpZLz6qnbr6XKp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(5660300002)(41300700001)(1076003)(26005)(8936002)(8676002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(38100700002)(316002)(66946007)(66556008)(66476007)(6486002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MIXP4egln7AkEvdBgFUiQcvpbpCPvhJG/UFvCjvZNbQ+Qarl6o94dTvNRNxa?=
 =?us-ascii?Q?HrRfNtwew3VRP77FSONZHY2kr97wUJwzn2NWzn0GyoornTdQM7wHeXmPkNRI?=
 =?us-ascii?Q?xfpeeUPoP5ixtHV9iR0l6Y1ne/MRVw7owpCMBPbABPocAKhrNM7OTKXj3AGt?=
 =?us-ascii?Q?mffDNEP6A0DveZJ7p872QfF516NriwxWnAm/wBZOkFx0mb8Je/xK/SF3AuvS?=
 =?us-ascii?Q?AdwF2LvBUbaFZ0ZNEDP0sI867E6YuFRlEn4TL/NfiGgUkCTJ/HgLQ+m4qhdT?=
 =?us-ascii?Q?DjMtHKeYYYgAwuTHtjagQEGJZ6r/9zKnHRYx+PiGtEt7suWe0qJdR18sFbc5?=
 =?us-ascii?Q?8SC4OXeH5nNSmBEnOLxmB2WN+KPmCpYoAAucXK9dBtEHmS2qtp+ahofIB5+b?=
 =?us-ascii?Q?HZqnCbTraZtIZL4VMXykEqPgPyoxtRGxzmkWf8RLh5D54jm3TA20QZkf/Oit?=
 =?us-ascii?Q?/Kvy3r9SCp8yiJX7RZa26JkcqVKTr9qsDF1ieKw+Khs5jnhUTiKcCUcUW2br?=
 =?us-ascii?Q?8K8a5Ozv7hNCjWfEuUmFRLnW+SAtkxmGqpv77Rt0WLv194Iz8rbYhbWnSn1Q?=
 =?us-ascii?Q?jZQstOf6u6pvUT0N6ABEPk2poHAsCzJHZ4m1RrxEGq+by3B2Dase9ddo8MDw?=
 =?us-ascii?Q?ATZXokz46c6+/nQgQG6q2t5J49apUEi3xf3gaIIQ5VByELcIViFCOb9uGE3H?=
 =?us-ascii?Q?Kf2DZ0DPem92X9OohUSmu+U0rdT1ZpPZPk/np7+X6aPWTxgruEsBYyk77dJz?=
 =?us-ascii?Q?hGTL+58A3FXl59pHdx0is/GbKB8sPU7MOxU5Gg+hPuwb8rBwn4IZoRQTTJDj?=
 =?us-ascii?Q?4QrD0ErWnq6XwKGU+UL8RloLPudUrsgb3VUVfd7/zurIPQ8rnJjfD0xmVmKZ?=
 =?us-ascii?Q?1/+p4IlN+uFNVBMxuTW1N0Q25iKEg6afCwQMHxqEoUfCtxiUgRhatA0kCDzj?=
 =?us-ascii?Q?MeZos8gYvRl4lOxtOBK0hqyC7UmRo4OtvmRM3qPbqak+wR6LHmnd2NcmNQ/0?=
 =?us-ascii?Q?O/hcdFO+EqJU8zEgi+L82pZ8NVlZ+7ehL9f+tw34tG6mAAICInCNKz6SUrM7?=
 =?us-ascii?Q?LjuCfNqf3rJW1S1Wo/f6ijpJCkkDx3/w9Z+arXWN8oK6QqoHT2e0Rt/ylhhA?=
 =?us-ascii?Q?SJEOlwt7Zpeo3ghf+qp19XmWHiJ6ork7c12ulRYcjf9SisKCu62V7ioUDnXc?=
 =?us-ascii?Q?cajnR54DnytPWpqbpHK/7sUyvgYuxjxQNJ9faJ9lkU3M7kC0upr38GHyWMQG?=
 =?us-ascii?Q?/cylfyDwEnSpeRP7ZuYpB5EzstvRlmQFWA9euMjFDYY58c7iw+bACgGeKdQA?=
 =?us-ascii?Q?mgP/qj68XC8I1cZR93KV5x8+UjCzf+JSsFytu7qd3C2oq74cUjgovPHsy1Z2?=
 =?us-ascii?Q?jGp3S/1D43tenJnfr+RqfQorFriXGKr3CHzlcE/z4LguBqK3JYt5tettdJPf?=
 =?us-ascii?Q?1AgrOxPThYR6yAd0S5S12BA4v0+alF0Fim7M/DQ1GUKoC0Uyyb9zRR0bT/LJ?=
 =?us-ascii?Q?beaWSxqmLiUNL8pCuPCTx/wvbU44w8KpwaEqJcVFGtmOynFMNrUDNOpUWZht?=
 =?us-ascii?Q?w2mV1nKq/1I/kdw6Wib7qD/VVEMDtJ4KNBSEx85GJzIpFm3GRRZnho2/nvJY?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3JSXjuWNbyEjDqMy28T4F/XmKy4ooTh4cfnGlqYaVHrwEhFCN57K9DqDSSm17gBUwduaCW2gdRD6ixXzdva10fKxqi4o0zpqfIpTgPbH/sIrCRmsHEJYPaUThMyQnaKn4zQyJN9HvjajOWst/aqKU1Lc/zNoA3yo70979Wq9f9YHvLDtmpAllzV3bHX8wsaze64hOc2sCWSU0M+n36FWYCflVA3ybULOZBn1hIrp64jF5OOJcqqrrDCP0t8ZJhn7Gf8FI8lCu9ko8XQY73SlXqXaKNJuntJCYwaPlkSN2SRYw+Aj3YG769ixcJITmLB4xHizNzrA5D1RMGdnvFieseBdCbcE7BRdbjrSOlbetoSpP2eV5XQCls+CJjWUTitnRciJcZv0BxbDxKuImgPw8hVUUbd7DmgYpj5h/QvuTcMqq6xTgxoTxrs1GBNqhhL+5Sz79SBzxoE01Ud1QdN095vmt+Qg6Dmj6/gEvVI1V7kpm0De7JdMCGjhTskW6DfMaEPMMCLQSZnn6PKV4LaJ/7/LNfarGkmKU+ZzTq21NqeSb74ziMaklrVHFZlG44dJeKNdVwVMehRLgSgPiZgU70nKZSn/vEU/Nk1Z/yQJNa7pReYNfykn4qP6/obm679tBUFRvkF/9924uqIHE4rWaeixoGehmnn3Xx5xwZRA6G2Typqp2z2y+/vO8TlQDL41r7c7Uo8aXRadrDjgDbFieN0f/M3LmPjbr9vKY/zM0qhROL1dEe/kRzML0I4dQRvclB3E3abJvAfRXW76mQTlcfyYs6oZ6eJY0rFuRd/oxtk92Yles0mYI22tOYk3bWz3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609ebffd-4c9c-4b97-19d8-08dbeedfd2e7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 00:28:48.7594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw5/6aHQVKQvL3DyjfokCH+WDJ3p5CRkOISPmVz04Ah7JCN019QCNDkrLZIdKERQNbfTdI2VKoL81DhX4QkeSsVhaGwsrV3IbowbJwUsxG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270002
X-Proofpoint-ORIG-GUID: ClQBdNoVK4oR12xfZw-9_8o5fjujhleQ
X-Proofpoint-GUID: ClQBdNoVK4oR12xfZw-9_8o5fjujhleQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=michael.christie@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This adds the vhost backend callouts for the worker ioctls added in the
6.4 linux kernel commit:

c1ecd8e95007 ("vhost: allow userspace to create workers")

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 hw/virtio/vhost-backend.c         | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 17f3fc6a0823..833804dd40f2 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -158,6 +158,30 @@ static int vhost_kernel_set_vring_busyloop_timeout(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_VRING_BUSYLOOP_TIMEOUT, s);
 }
 
+static int vhost_kernel_new_worker(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_NEW_WORKER, worker);
+}
+
+static int vhost_kernel_free_worker(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_FREE_WORKER, worker);
+}
+
+static int vhost_kernel_attach_vring_worker(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_ATTACH_VRING_WORKER, worker);
+}
+
+static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
+}
+
 static int vhost_kernel_set_features(struct vhost_dev *dev,
                                      uint64_t features)
 {
@@ -313,6 +337,10 @@ const VhostOps kernel_ops = {
         .vhost_set_vring_err = vhost_kernel_set_vring_err,
         .vhost_set_vring_busyloop_timeout =
                                 vhost_kernel_set_vring_busyloop_timeout,
+        .vhost_get_vring_worker = vhost_kernel_get_vring_worker,
+        .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
+        .vhost_new_worker = vhost_kernel_new_worker,
+        .vhost_free_worker = vhost_kernel_free_worker,
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 96ccc18cd33b..9f16d0884e8f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -33,6 +33,8 @@ struct vhost_memory;
 struct vhost_vring_file;
 struct vhost_vring_state;
 struct vhost_vring_addr;
+struct vhost_vring_worker;
+struct vhost_worker_state;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
@@ -73,6 +75,14 @@ typedef int (*vhost_set_vring_err_op)(struct vhost_dev *dev,
                                       struct vhost_vring_file *file);
 typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
                                                    struct vhost_vring_state *r);
+typedef int (*vhost_attach_vring_worker_op)(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker);
+typedef int (*vhost_get_vring_worker_op)(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker);
+typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker);
+typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -151,6 +161,10 @@ typedef struct VhostOps {
     vhost_set_vring_call_op vhost_set_vring_call;
     vhost_set_vring_err_op vhost_set_vring_err;
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
+    vhost_new_worker_op vhost_new_worker;
+    vhost_free_worker_op vhost_free_worker;
+    vhost_get_vring_worker_op vhost_get_vring_worker;
+    vhost_attach_vring_worker_op vhost_attach_vring_worker;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
-- 
2.34.1


