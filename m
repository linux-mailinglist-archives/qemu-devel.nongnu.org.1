Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C07378CA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmp1-0002lR-2G; Tue, 20 Jun 2023 21:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qBmov-0002kn-0p
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:39:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qBmos-0002Hb-C1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:39:40 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KLYIRx000826; Wed, 21 Jun 2023 01:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=oGdJqwG+94ETUX+ld72uG6MAAH8j++PE8pGTxyYccjY=;
 b=gRti825M/CrDxo8V/DstD8HeNeemo1owEfu+56PyizaWA0/ir5HNKlAyIdDCZ86Sh0n0
 Sn2g4Z4PTCnPq+HgVkobaWA+AdDgja2GJaGcwuDHt4J0krqAT3joZS+pt3SLZAwcrBHv
 lqilQlGNTDYOqZWcqr25Ywdkzs6p8kvU0pMmyAoLQjG/z6jTLSwXaiZs9qfemiqAZBoH
 qtnFBK9ufuA/lRNQpdA8QmipeSKBr4C8CP9urq19lnDxLCD9NPoPLny61IQWz4l6Fwj3
 pgwX1bbAEI0JoN4BxdyQ8G8ALOy7Eh2Pa0VSybmcwPuC0mCymbZwr15qMajGz6q6YtIz vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95ctx4ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 01:38:59 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35KN6YBc038670; Wed, 21 Jun 2023 01:38:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9395chgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 01:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhSxPeyHq+fgeNalJo1YVVkKZDaQCp+NBElhSyY4pmqj4rPttGjmlPsG9hk7GttIPIIvE9lCR62zRV8zMehal1eUSGeYBF+sGB6BTO3nMB1eZDRhwAzlAsC56G2t9nMk71Ty4+e4OQK/MbaPe/u3RKRjjvaK0qdFT3D+W+3VH4b+Zu99XMaorKtRFt9dbzCjppSO7abFFJ+CAUJRCFxKvxaW8IdttTFrGrw/Ssmih6sdG4ZpxGavb1R8525Ev2IaLye92QNjo2+Ve/02/+a4SEN5iJFo51jTQ7fsxbtm+FP9Rc22FQeDf70lTslLcHxR6ENcOPvrCEXYr1waoNkfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGdJqwG+94ETUX+ld72uG6MAAH8j++PE8pGTxyYccjY=;
 b=oCq37/UWkAkKWw1znsEHgnly2+MNpWd9UihhYskXsl6T8/+30/Ms+yJKM29hzr9lH/mpyaLUIBV45aeshgO+8+sKVOmmHmX8FEz3SYrL4TBpoXxgMZ8Z99R6ocJBpyMLRmHhC0YIYqzJXzseouNXf/fbVJG10t7EA7DcioWel1RHZ0A+pL404wl4+FLFhywWpE+JiC0EUbEZAg+wKpkxW8owya0AGHpVU9wiPvxFPKqIMGXHBhh1l1COXk4hnUTcvLBEGonIgmB6gKB5PEqR3Xy3bIg9AWPZlGXQBlDrfYYs78EDj/cWIZzFRgBjGyT09srxe6WFO1xmUWmT+xoXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGdJqwG+94ETUX+ld72uG6MAAH8j++PE8pGTxyYccjY=;
 b=GEOeQveOmDHlVr3ISrikZ1U5Wqkkoe7VSwufHeYnQHLR7wQzknhmSUYf/pNn62WayK3l8+UNi0u42H39DaCs6LunWU2cXQjaORjraNszPNKTMcaI6A+/W8DVvLU2mCy3L6uOh2lY2nI2jvq2cd5CedpfCeT039HPd8JBy6bKwDs=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 01:38:55 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::96aa:8e73:85a9:98b9]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::96aa:8e73:85a9:98b9%4]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 01:38:55 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, joe.jin@oracle.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, lyan@digitalocean.com
Subject: [PATCH RESEND v2 0/2] target/i386/kvm: fix two svm pmu virtualization
 bugs
Date: Tue, 20 Jun 2023 18:38:19 -0700
Message-Id: <20230621013821.6874-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:806:27::22) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: f940e7f4-f5d1-4111-e5b6-08db71f84657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dz0EVev1R0xzFVFl7Iwf9dnFC4tE0eqJzn+ISTosPGUwtk4O7zGhWN/bRGPQV124Wj1LMOJOUhz+7Wi3W2cGHvB+YMnzbdyHU0sCUDQCoVyKF6g/pRUMXRr0gSANSBoWu12QEqaXiFWbalTCnDIgnBCyD3BUyA54TrZZNYwUnQpphLJWwJN1RFh2JrNlkU4TeB24PfomWf8yte+lUeBEzNT7Pw2fpnc29HCQIuM8aaG8wcdYc3auxSAIyHriOM5Ecg1OlkxyqohO3C/El7A9Hb7tJwkO7nGkOnK3Akt1z+6Gn/mSVuW+Y3gzBan7YFhdxpc0M1M+riSKBKJmi33FHKXiWwTPMNdyOTpgPgAbB6PdLuGenNYXoTV8F2LNYBiLx7fQjqqFpzcsd6SMEiz3r0MU+O7JXZzQUXa5yAbk34/FrLeriDLCaDe/hrT8ZBrdwWatIu3QOEq4WzODgbeKULEuvYbYUYpssP76WpESDzcY6qm4eYyMch/ZrNNyTevRb8JZtZ1NKbbuRHmD86ZYdybXetYhsEOCTMQVb1QcaY6+vS2Mf92W9flNnR6wmGB6S2EOaul5rWLp8n/gzMpfEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(2906002)(41300700001)(5660300002)(44832011)(8676002)(36756003)(8936002)(86362001)(478600001)(26005)(6506007)(1076003)(6512007)(186003)(6666004)(966005)(6486002)(66946007)(66476007)(66556008)(83380400001)(4326008)(316002)(38100700002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6AYdVQb1MCkRi8qQQ/kvztpREm0hYEMZwsZ4TrQTCm329EL1533CevvGXPA?=
 =?us-ascii?Q?zgX/go8WjljYS9amHFYG2C+WEovwcuau8pW8LkJ2qlYf74MxHCirCIqhk+Qh?=
 =?us-ascii?Q?4GsRxhiJZi1bS8DvLYzb3A71BJBLNAvzRjQokyfjVBXFoNd1JG3OzwPXP9rc?=
 =?us-ascii?Q?hcqSFjrEk5kE0i3L5EmW+PLnL+4kj+KCKyrnzQa1vhcYcAVLMr8nNlU6QO4d?=
 =?us-ascii?Q?j2YuvX6oxvPGYmlAdW3JxwTK9T5tGYWpEH2mKVQ+8io55H1YgTgIbVP6a9Hc?=
 =?us-ascii?Q?Po+qIXlOpkbFFeEZlhfOHaRqJCjt/NnlI+hSBikEOsOlD6FnT7Tex6PTI8vO?=
 =?us-ascii?Q?CD8UwMQ5CLsotcJh1OIyVxpZxNGtRs5Is7ke3r4xEwFj+tu/tOMogG+or8BJ?=
 =?us-ascii?Q?jLbEOzs46kya0wRRz7orLzgQmHQf0zofKZcBEBQLDiCjxmxUYOUsmK83bT1s?=
 =?us-ascii?Q?t0DSX3ekR24nmGritq5OLfMIp7XyHJELak/xrFRwiQOhnyjaSQo8REARV3FI?=
 =?us-ascii?Q?D+/v3nFHiuhXWLCFhVtsgexn55tsKkqeruZk0LekUBxIrzVZCRoEuKLgt+qK?=
 =?us-ascii?Q?m4p0GkyzYoK1npp9qU8Ug6zkrbzHQcI8jTin/lAHfAlNwGtTGGAN4+NYG32m?=
 =?us-ascii?Q?cATIY4nOhY7ZqD3xajJJ7JqF0QwkokdaaUdljW4TntsWMVTBKaCOVV+MY1+B?=
 =?us-ascii?Q?z3ERJPHeu+n/j5y/AZ2CQcEqz1Eorx1mCN6SffuN+otc5FizxmGpdKKW4nhv?=
 =?us-ascii?Q?Vn9JbvvZrnDVQDckOWmJl+TsB04mOJtcboqPVjj+x3PTI8r32aMD/0J7wneM?=
 =?us-ascii?Q?Xmu3eaSkiC1Wd9LjVjgR8oJSIz+ZvGoPZCRLsjGcG3ctcy/CuLagj2AYg+G1?=
 =?us-ascii?Q?z5nCXOMi4ETur7e6BmuEvuHU1UAKxPUJYPYq4ZlO6N7SqMNpneMa8l49DD6A?=
 =?us-ascii?Q?vcOikvgV0bnmmjuxdOZzlEeCpRJzsQaWmi7chNxXt6Oe4tDHBv07aU/jwDoH?=
 =?us-ascii?Q?T98bxOv8Cx1ZKHZqGZZ/gtOr8nApnOFxtM8ar7oTlAxWpMhkbzhpwR2DFgTJ?=
 =?us-ascii?Q?L4Byzykjonc7KYooABh1TqpBYGiWMZA8YHkfSSj9zL2Gmp8VBwi7opB6yL3m?=
 =?us-ascii?Q?zkrPpnWsLP3MF2DtPgtmLYRdhwwndPJnCBqM5U8yzFiBTkCJTlmrfFeOFv24?=
 =?us-ascii?Q?T6pb6mhZiXqNpQ4uy8eSYFWqTgz8L02ChUqdGSoepJ3KnLMf6ZA+xNlSZorT?=
 =?us-ascii?Q?GhyIQbJBGIspMAkB19RBj5ArqgxId2uNNXMwxGIesRD3t/T3jssSNgXDxYud?=
 =?us-ascii?Q?Yqd3lFn9ubWSQX/Uc6gBqy0QqqR0p7s1Q1HB+NSZIEWacxzY8kkbvDo8Kmp3?=
 =?us-ascii?Q?d61FlMy38G5wQHF5KEiv57iaqwK6SrXpp1Px85QPB7fVzYsrPcnM1fYYhPOm?=
 =?us-ascii?Q?f+U6h+X5wSZlnWj89fcdHg8BmdykRCZtJ1tnNIjfoqz7p5NCuJPBcK+w4G6O?=
 =?us-ascii?Q?F4L4W8RXAUz9ozI0xDDMBAcp2Lca+gAlrSE0N/h4sed36sdfEEfnpXIftyKn?=
 =?us-ascii?Q?UnK8NuPr/YldJ1gLnPtgFOKM5qsQcib92FJqSwxk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?woiB4Hq+aQ0ARo9IIpIRIaoEi4lR1hdn5m9peXyi3SFOM0aHRj3os/C7ykOt?=
 =?us-ascii?Q?uCmjZ1qtlOVZi3VK/gkKWrjP776XueNpVFHvCFlECCh/cSdYavJtqChiIVDq?=
 =?us-ascii?Q?G7+WdMHwMlhZsbOBIOf9vuwYyDPvopcEe+73iXGdgd9gB9UWTb8lmjBDARhi?=
 =?us-ascii?Q?2HTKWUn2QUvaRd5g+UV4xdLji+LuzGIXPCtErcir5kduv5aeNNZc3PTHH08R?=
 =?us-ascii?Q?ibzSdB8LvUeew1vMjCyYSt1L6ivZd9/TldbawxtuMhKIus9RA42yKbD/n9u0?=
 =?us-ascii?Q?np8fW10z6ozdmX/QkjmPmUwRhNJa4pDVLBLZLLmzBnbzEE9WgPQRw00gMGoA?=
 =?us-ascii?Q?TA5KmSyf5ev6JVsnVHm4gG1iSOsgFf1IM49LUcA9dER6mXDtzeiKShzumyFH?=
 =?us-ascii?Q?4L4OQcmnBeNdGIM7tYIZ3eT+I7aB+vu6Gt8nkYX+t21N7jHvD0zUQSZTp3id?=
 =?us-ascii?Q?/DcxzpZp9KIlWKVe3wdpMwVZoSDbtDJWvT62Hq5bWJ2wm8/8m+esUlOH0cZv?=
 =?us-ascii?Q?g58ClDuPBuXFFzjoHURqvzCLE6nNIslUtPffnwyo9viKX6LjBa40i5JPjUzj?=
 =?us-ascii?Q?3TjYoXb3HvCzD1Ww1K4kYqJ+owFnkXdgXJXY0KWMZpEv+8a9dF2st+E5tgpz?=
 =?us-ascii?Q?B/Yp0cvlR0hCj7hXCVK4BRBcQaunX4N1oXxPShmyc4zqBnL6HrLOLa4mjy5M?=
 =?us-ascii?Q?tvumhD9yVifwbHQpodKVX746v/pJKq4i2Mo3HpA/uNFJPgg2PzkCyONrfkN1?=
 =?us-ascii?Q?15g5uw6n+2+Vz/TzmG6g2fob2yIpg6vbliaJ7SlJtTnjrYOrQBQ7oxglqwue?=
 =?us-ascii?Q?3tBaaF8pVM3jSxiO/CN/T0Y8ZycRUqFyCJSiakTYrDrH00g2T7llbp1aFiXF?=
 =?us-ascii?Q?5sFG8hbJehmpPxmdUxiSUm/kdJQVmYbDFwy6pOLs7gOFCRGZ8UOEYukN2Wnw?=
 =?us-ascii?Q?JKZaNMqKsLNiXf8eti0l1YKN4fUynPosJbGiX06rwW0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f940e7f4-f5d1-4111-e5b6-08db71f84657
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 01:38:55.0653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZa6QMj50Pa73T1HPmM2Z0Kjyc9D8BI+ffoo9sF8yAxvjbcxjKPm7Qoo0nsxqkNfnKzqwdeV4zbIqA/a8BRmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_01,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210012
X-Proofpoint-GUID: D2h2w5Vb8Tqc2NNDlq71AR24T0mEGtfv
X-Proofpoint-ORIG-GUID: D2h2w5Vb8Tqc2NNDlq71AR24T0mEGtfv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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

This is to rebase the patchset on top of the most recet QEMU.

This patchset is to fix two svm pmu virtualization bugs, x86 only.

version 1:
https://lore.kernel.org/all/20221119122901.2469-1-dongli.zhang@oracle.com/

1. The 1st bug is that "-cpu,-pmu" cannot disable svm pmu virtualization.

To use "-cpu EPYC" or "-cpu host,-pmu" cannot disable the pmu
virtualization. There is still below at the VM linux side ...

[    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.

... although we expect something like below.

[    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
[    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled

The 1st patch has introduced a new x86 only accel/kvm property
"pmu-cap-disabled=true" to disable the pmu virtualization via
KVM_PMU_CAP_DISABLE.

I considered 'KVM_X86_SET_MSR_FILTER' initially before patchset v1.
Since both KVM_X86_SET_MSR_FILTER and KVM_PMU_CAP_DISABLE are VM ioctl. I
finally used the latter because it is easier to use.


2. The 2nd bug is that un-reclaimed perf events (after QEMU system_reset)
at the KVM side may inject random unwanted/unknown NMIs to the VM.

The svm pmu registers are not reset during QEMU system_reset.

(1). The VM resets (e.g., via QEMU system_reset or VM kdump/kexec) while it
is running "perf top". The pmu registers are not disabled gracefully.

(2). Although the x86_cpu_reset() resets many registers to zero, the
kvm_put_msrs() does not puts AMD pmu registers to KVM side. As a result,
some pmu events are still enabled at the KVM side.

(3). The KVM pmc_speculative_in_use() always returns true so that the events
will not be reclaimed. The kvm_pmc->perf_event is still active.

(4). After the reboot, the VM kernel reports below error:

[    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)

(5). In a worse case, the active kvm_pmc->perf_event is still able to
inject unknown NMIs randomly to the VM kernel.

[...] Uhhuh. NMI received for unknown reason 30 on CPU 0.

The 2nd patch is to fix the issue by resetting AMD pmu registers as well as
Intel registers.


This patchset does not cover PerfMonV2, until the below patchset is merged
into the KVM side. It has been queued to kvm-x86 next by Sean.

[PATCH v7 00/12] KVM: x86: Add AMD Guest PerfMonV2 PMU support
https://lore.kernel.org/all/168609790857.1417369.13152633386083458084.b4-ty@google.com/


Dongli Zhang (2):
      target/i386/kvm: introduce 'pmu-cap-disabled' to set KVM_PMU_CAP_DISABLE
      target/i386/kvm: get and put AMD pmu registers

 accel/kvm/kvm-all.c      |   1 +
 include/sysemu/kvm_int.h |   1 +
 qemu-options.hx          |   7 +++
 target/i386/cpu.h        |   5 ++
 target/i386/kvm/kvm.c    | 129 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 141 insertions(+), 2 deletions(-)


Thank you very much!

Dongli Zhang



