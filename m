Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E007AA99A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja63-0005EF-7y; Fri, 22 Sep 2023 02:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5l-0005Dg-0y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5i-0005D4-KO
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:44 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LIsnZg009305; Fri, 22 Sep 2023 06:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dStZa1QMiy2ATwKrgdrlnu3LNy3DRG6/zZJmYv3JghQ=;
 b=1QBqVvV8pJPOVrmWY7PiZynPkT85pprim8ZN8OHms9ibrru9XaPOhVRJKIoXSAq2oU7V
 gt0R0KFSxmOdVYnWcwqUb5NHPHe5WFHLNgHwtxcZYjATwruFj1ax/wGVyVhog8vf1Z8w
 M1iJ2O2VNeXHFEHde0s2ogOgp16WTu+poaXaMtRuHWpHbrjcVd0oJl8+5SVLf4xXaHRF
 Z5xMmkLjOw4j1Ki0OPtDpYg8B8y7oSSx1z0C6JLE0iHgLZf1418iz4zDi/+DC0ADWBke
 dAGPiDnYkj8Zt+KkZTmoIXpdVVHwNNz0tG3baLxVBwfuFYhop7a98K/zQL+A2S3Z+nZq 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxs234-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:40 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38M5OhiC039466; Fri, 22 Sep 2023 06:56:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8ty24nwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbbB2uQz6XaiQ6SL8iGlf2hzD7Kf6RKvvD/hSNGMq0Afp9bhS19tIUViEO+NJ9BwSNRmcz11eeVTjjQ74il+RBgDCnlZ9hnWKNNd1A2jPyCCIHHJppJR1iw9Q1Mub8EQlWVkg4/1bDi+Lzk+fxzgqfG1YkTM0/a6g9tyISbEw2gJGVkIqtguDnw7eCD0nJV6+2TBIrFWGg+mEceRN/Dgp6uMSXCOkCahQ1jOUNOYcjlkZDrSYa0tWjhvJY8pg2QKBq2Gx3/KUB54zeOfXML2U1oTpOFgEhB2L6lPa3JS9r4Ox2+sRBtGFlSpW6TlwxtvtHkcr7lAf4pZ5RKdaf8dqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dStZa1QMiy2ATwKrgdrlnu3LNy3DRG6/zZJmYv3JghQ=;
 b=MSZYctlMT8zQbbFcJzFixUspDjUwetNytpr1kNjPT1qf3p+Rb6beoQZ3BVkBLRni8oWLCzg+wPX7i8BmyaSTDcOKSsFBGeDj9sOZIoBanrkrACMsakzk6eBetFcChkaSilv31r0umjfBkMZYSTD/qsr8aGTH7IgFo8tG4bJC/WaERPPX4036wqYjEu/Up7QTojjJ1obnHWlEKEyJfIQLNPWFmSGJBufaakPodkVBKXoa9Qr8mZqW+AIQPCrNz5NeybOR5Qc8U33eqBPUJ6bzJr/zXTPRQmBUdZ7lU+0Ug7r/MLjtPZd4PCNMXtCHD/QLWxS6aRjUPWtOsVAu6odFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dStZa1QMiy2ATwKrgdrlnu3LNy3DRG6/zZJmYv3JghQ=;
 b=fzOwh/8XjL/ILceGi3B+UdyOyDaCdjGiVHEBMsSDkrS5JhQ/dpMWs9p1jMpTYY0a+mI8G9iqoWaq+GT2aNeUaiW9Q5sn31QBAUfTjsvxKg1pmlLNrxCJptpl07SVmNK6tru1zVnQfBpXf3CDhDtphLlvL/FfNleCm+nUpZ7RPmM=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Fri, 22 Sep
 2023 06:56:36 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:56:36 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: [PATCH 3/4] multifd: fix counters in multifd_send_thread
Date: Thu, 21 Sep 2023 23:56:24 -0700
Message-Id: <20230922065625.21848-4-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d472b6b-5102-478c-9ae5-08dbbb391037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: os/RJIsLXsuHo4J0KO5NBPEwzeCUVYwXYpb9WeeoISeM0K2VnLPpBPSG7C1SxnegqtoZZpXJDm21NGUXiwHiANfLFme9lwLi3F/tq39ZqRJEJManuAr+exJMByVPEX+fr3/ccNZn2wqtDo0CzcvAReULdN77Akywr2B1lWi2lgFjnenxA3CuSVPNWZZ9jbIkwwOR5b/2gN0FTbdVdGEg21zS3ScUmOz9mGHPMxzmqZD8fYM1h7m61iW17kHTJlhfB8DUawMgZ602D37t8FR7L1ZNb1ARvOzM7Qy2gI+dAFSYBHTVPjKwgOxPL5oSa9o1yLQ5ZW8I/hCqZpV+cQrh0mb77n0qXCPvTnEXT0w/0AMse6PquTgvEnOqadI6omP+BNutkPHYYIcKyG6sg2ECfWzDHUoIw329Vj7xKKyeKpSALlHzvozmAuP+mfUPTbDgDQZwqdkZM52WuzQpLhRX6z9y/ENDt769dylkMwPDuQhv4oFF62w2YGc8FK4s0mWXQB2XwJr/SpOy4YBm/TVzvVS61Za8dKkvVu81Y+QAYTc4e0xcuzq9DYoZWctZulYW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(44832011)(5660300002)(8676002)(8936002)(4326008)(6512007)(6506007)(6486002)(2616005)(1076003)(83380400001)(6666004)(36756003)(316002)(66476007)(66556008)(66946007)(41300700001)(86362001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNLs5vvkb4UC2pUDeGOmsa0iY4Q58LuuBhY6AENQ2KPiAeU9awqkImdkFgF/?=
 =?us-ascii?Q?A9fXa9pKmXXzT5SkLeTxxvgoa4oQfSZ4dnYU6M2Edv7Q/PMOZqN/0VbJnotb?=
 =?us-ascii?Q?rFI8Duh63UO/1Hw2fv0xNUA1ye3b+8y2o8JXoFXCHCs4uYerJbXIdD6EugBe?=
 =?us-ascii?Q?fNhxAnBNwUbKuBXdluhI4VopUCu/H2hH4IRDTsmSSY8kCnkRe7w9ehbSwiLV?=
 =?us-ascii?Q?IH0yqZCrUPLyNDAWAJfHIoDG6pRPp6g4zMd5g3DWZ2BVtOROL/7KNy2Cqkd6?=
 =?us-ascii?Q?KtGJbKUPtCpj1Q4ljQo/vKuIcktTNPQdZmCAE/QiZasan1EGCTIpk+HAeHoQ?=
 =?us-ascii?Q?5CpqyFCaPYFS9EgTwgVXE6doIbw56HakuEkyIQGI/SUij+PofIl8dKKnxA1A?=
 =?us-ascii?Q?SaE9T29hzZxj3baUEUIaQe2krdmQj7SR6JSSxTNO8Z4AYPRZLXu0vTztHn6N?=
 =?us-ascii?Q?INGeIps574ov8WpIaKLEgODpU2l1YwwQbSKSLpS0LfXutsJXLI1DrfgULmIr?=
 =?us-ascii?Q?tggNK+uz537Y1jQrGCasVpoOsuTjCBJuA4Ub7iuSBaGRAagV8BhtgbWtR673?=
 =?us-ascii?Q?P/bnVxB190bkb5cyLBL+HPLhTberru0Lvtoon7ADEMfsnhHXSbZ6GJbIeVWL?=
 =?us-ascii?Q?kyoAQJO+B7NMACatgLueHhvWmB5+NmrCCUcRU1/t4pTPDwf3eHgTYoAepjCf?=
 =?us-ascii?Q?+siCg916zXVCaAr731b3hOKAiIsyjrSb3LnZWa3MMVSczG6LSy53cVkQR2JR?=
 =?us-ascii?Q?33hNwuV6ne6jAB0ngzzMzQGb7Sxbr7Ox8K7XhNSGSYBJ3PA9AcpiF2ejUbjP?=
 =?us-ascii?Q?7bRTfFBFJQJCCgUlo2r5t0eOo/VeLp22Ds9stR97qji9pZDF7/My9p4ob8lR?=
 =?us-ascii?Q?vMSfay8GKc2ISrZOVAJyWhhWTcYCiD9dEd0d1Zt+ZsrgS6T28WeP7ykkJVTv?=
 =?us-ascii?Q?sFoaNH1p2r1caEm0g9dGMSVLIFdF4xJLz2HMitctEoyI/AbL2DCSxfO1Em6L?=
 =?us-ascii?Q?oNN3vvg9MGbFnvDPqJPyTPteMsmSBtbJ124J7Otpexz2xxz1NPqqlE27O4X7?=
 =?us-ascii?Q?pzGqdPAVGJNS85g/xNSSIAOsUmYBl5rBQxHVZUDhKpbENRSZfeiGn4GX390q?=
 =?us-ascii?Q?mDFX1fjqEMOzzDMhPnTZ6+lljj3xWADlqAz0t2gAlRg49j9MmjFM6tDVOHnT?=
 =?us-ascii?Q?VD5BRstyE5paax1p59p2oqYLw1pTj425gDIeXtni8bmF5Nd9GsJJ+xWU0Ny1?=
 =?us-ascii?Q?ohjXUDdSaq64GtUdroZBFttcC9CewrFiK4EARbYabQAXUwascPNqCJPhFUl6?=
 =?us-ascii?Q?UFGbDjlQfaAB8TpBui9APRi38DWq7oi8D15pxrijSNOaKScPnrUPYjx+Aee5?=
 =?us-ascii?Q?x2/I3jMCTL6HtnODVxeGP+8+corluQ9N6+tZLDpyM6ETK0JZHoeHDlojxe1P?=
 =?us-ascii?Q?tXzKjzazgXBVHkjHnu6mPa3sLNw2eRoXYWeSiPbh+gE+JKTCwJYXwb2gViCW?=
 =?us-ascii?Q?XOERUPyrgk6mFZcKG2d4RKru2u8vT0hIg3qCSKuK703PSjCMjCdkW8CGe0N4?=
 =?us-ascii?Q?AHvuT1foQ2wG2/AiMom9tYBYyBkG4+OptVpCZaogrOh5rCOxSsdAxNgZS6XI?=
 =?us-ascii?Q?D6NbULOkvggGcqXdex7bFgFnu39HhQNJtjP6mk7olJobO6c4durVGtzablMN?=
 =?us-ascii?Q?IT+NnQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vMAQ4iN6QLzKmFWdlS9TM2ygMEO7LeHF7Q7HQf2B7ANZ2BsBP33DEclGKJpFFEXlKqdInf+TkStnS6jYnXhsfRTn8w8jJuTs+FVTsAKDX9IVB1EGKqcZmHRProoiJeSh6ZzvP1GBehDECZ+V8KItY90QjR7ZeQHAAhQbPtXhQ72UdxhZe+G2hzVqPyqxL4vfpnNlIkHsfsmpcJcfNgXcaU1qvE2zxS6cAiaw4skRPQjtdyim9xYW51ttcWJJrLNBtj5ieDCRuswLKUYvlyHvpP91Cn5AX4bu5sYvvMDZ0EN+70hkGwVMH+e/LT6D8mI5l6DhEu8h6AUQpjc5X/3o9GK63M3pNTyi7VybVTfrT8UwTN/I3hsYntVUChTSRv+JggQd3MkyyoX8DTogPNa0eJhQjoD5MbwLa+beT5/2MNnOU8FXc3uAhVaBfqRO3HxTfSr1G20U8JQCHaIc6W4D5y4xBH9No7BB030y7YvTGHYDtlILOEqE18wKf6WSmKcQRSS1VoZe/Zt+ZsSA1+jh7dVvN2zmwX7fj8ZPVv0uzt543tCDf7QoKg9wUaXLarFeEoETAFzG0PyPjVB6RlAXHu4SvpwPc79DT/32+U7SAbmKCfbFL8LUVD6dIViFgh+u9oPbJ7D+okhNsQrvKUBhncW/vvocNCVIbVfParWpP/bsDxTyhB1ImHm5nrmQ9A28RdSnbleZ/AzIRUwP4iLeYBWWVdFxlgxe1Vxa+YJVFzR28ml9SHMeqmNB6p4xtv2qzy24+Rh4Tg2DwZPny9DlTw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d472b6b-5102-478c-9ae5-08dbbb391037
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:56:36.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPiihVyPPNBBHmfts2whATNxrPJOGPLgcGCjpRGtxZ4jSfpB2ZQbKCDtCZ67cydMZ2lfgNLux7Gk/WPq/5DudTx8pbBr9psbzfqrNwMjGo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220056
X-Proofpoint-ORIG-GUID: OTPVJO6lWz3zCldIWTlwLNB4a7Mr4Unh
X-Proofpoint-GUID: OTPVJO6lWz3zCldIWTlwLNB4a7Mr4Unh
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

Previous commit cbec7eb76879d419e7dbf531ee2506ec0722e825
"migration/multifd: Compute transferred bytes correctly"
removed accounting for packet_len in non-rdma
case, but the next_packet_size only accounts for pages, not for
the header packet (normal_pages * PAGE_SIZE) that is being sent
as iov[0]. The packet_len part should be added to account for
the size of MultiFDPacket and the array of the offsets.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 migration/multifd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index e61e458151..3281397b18 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -714,8 +714,6 @@ static void *multifd_send_thread(void *opaque)
                 if (ret != 0) {
                     break;
                 }
-                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
-                stat64_add(&mig_stats.transferred, p->packet_len);
             } else {
                 /* Send header using the same writev call */
                 p->iov[0].iov_len = p->packet_len;
@@ -728,8 +726,10 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
-            stat64_add(&mig_stats.transferred, p->next_packet_size);
+            stat64_add(&mig_stats.multifd_bytes,
+                       p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.transferred,
+                       p->next_packet_size + p->packet_len);
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-- 
2.34.1


