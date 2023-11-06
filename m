Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6C7E2F63
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:04:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07hU-0000MS-Qu; Mon, 06 Nov 2023 17:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07hS-0000M3-Sf; Mon, 06 Nov 2023 17:04:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07hQ-0006Kv-Rc; Mon, 06 Nov 2023 17:04:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A6Fkjon007868; Mon, 6 Nov 2023 22:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jQJHQ2803v9+6/oiamA/h8nSctt/yDMyn106gabC3EU=;
 b=RGXsc0Pfug3GDt33GmntJBkff+TEUgG8ZK/7wx4gQfQluXUOZ45HRWTGa+j5HJX58XkI
 WyFg0aay4F6EjlUHB97Yao6YdM7wXS+GQbDURsbhS+IMNuF22rlqs13s1xmAQVvW+nsC
 7R+986CF8YTd7MfVkAbhVbljAHi65EaZy0yxizc+c/OKLLhoL1joINpG353MqVeC1zbL
 /p9KTr+v2NtCyi2bJkSmZe1PQTp+9FEFkuyHkRzVYD3eyh4qm0c1PAaINrxsX9qpKpIP
 WzbLeioFlksuhcxeQ/LnoONdXDgPHbUoIPGq3bIk1VegvMOtWI0DvdhYRas2IlLsC05o HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cx14hmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 22:03:57 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A6Ld0Zh023638; Mon, 6 Nov 2023 22:03:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u5cd5mf8v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 22:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaI+PaZzILxx3bHrW/GSISOvTRloZwzBMAY3MkNCGrYUqi5nFrpKXD7tiySGR2mw4XL1H+ClA08G2opk0OChBH3WqgLdE5YGR/kJDVOvUxeqPJsELIGvZfEOdEde4bqVfItCSXKQVi10MpZHzPEoYz1N0I7q9zD9fW4CsjhTB1DkWMzAr6pDB87he6sE4Zdb0NdRUTRj1DzBAs+NuLu50oA6LfH30r09VktWXBjDcv5UR05EcavOfMLLvjPP1VCpoADYnovFfKHVkHlx/rsJfBxZZEYHHtlpe36RFWBOkathvmFU1RmOxpHGpmVjNPEwlg9bd4s/8O52LAVJo9XU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQJHQ2803v9+6/oiamA/h8nSctt/yDMyn106gabC3EU=;
 b=TWFwpmH7+EeEKvHLNQ0WEikeQ6ddUErgMf9snu9S50n0rygl/xkNyCKQExXOYGEGpzcW+hGOLv3tfnu3bNDWlZxeJXcavB3+axGk8Db7KtiVuqwoCo65cdCVsL67kI31qtlWEZOH7X9owVDN5mRC3DGr0TPlHJMkSXa6LeJP8sQXLTl8GStxI16xHCzMiabLDJgACA+AOex2t7sE/Wyv0lToUlXe/1BUGrDypxEXRlBUl/cDjntl1HYNisANYymRaYbGwVakHK8SgJv+qgpfS/onbwiAhcSAhlPkujiqWi59Reuoe7RJaElxx4zotp3qXW9miIX1ItBeNAB8hzR6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQJHQ2803v9+6/oiamA/h8nSctt/yDMyn106gabC3EU=;
 b=dtz4yMl9m/IRVVJYemofXbLCZnkAP1vs7ZnKn4sNDZfl9SQ7rVRWrLUqULkcwYPms1vaL2omcvoQqoM/Siv4L21xHEKrdBdzgGjlDJpTlF8mqGiUfyWmpv+6dF9F7G4UwMPho2rlX+nVJqmkUpBGRtJWDB6kCX4wzR1rJTeNX9E=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DM4PR10MB6790.namprd10.prod.outlook.com (2603:10b6:8:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:03:39 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:03:39 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peterx@redhat.com
Cc: lizhijian@fujitsu.com, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com, lidongchen@tencent.com,
 william.roche@oracle.com
Subject: [PATCH v5 2/2] migration: prevent migration when a poisoned page is
 unknown from the VM
Date: Mon,  6 Nov 2023 22:03:19 +0000
Message-Id: <20231106220319.456765-3-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106220319.456765-1-william.roche@oracle.com>
References: <ZS6ksf8o7dJ8mzUe@x1n>
 <20231106220319.456765-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:40::40) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|DM4PR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ecd0c4-6c94-4017-2d74-08dbdf143a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPjPaNgjIFH8l4FMwiPGrcoZORi7rM21mxjJrDe7N7BdHxbI0EMfLsnkWDPWqFH660ngj2Phv4oHpq1+X9N0NLVPFR458muLyEpUdQsEVbC+Gm4YP3w+qJ4BsUsIwDnP2NKRgcvEcnzwhRFQ7asXc9hRun6HBz5clOlqGJzjpcNWZyaoDDTsCcjwIb4v1ZSRcJqEjqM7M1jqXDStD/VVdo8OPGucpSx+0ldX29bVWA+awSBoiN8UgvwCYHYCTEg7uZbF259yV4AM44BeTDgSz550uE0IkPBfb2BCdICbTQ5ntEDB/T9t1Fqwu8Jle/rkcEXlvyDoHA6RcmkOrHkUaEMVc+F/bAJ1f7+0BFOFvVZC3NidXJpT2SJ472Z9ZyJsiPRi4SDi2HeYU47I4gXID+BK3beFZD+x8dTX25voxIQ3XNrKEfWoYr3Wv2Ck1fPVgVC7zLK0SxNfFb6slE1fRpZjiuXYYANHKbZFg9Cj3eFsy9UhI8+vzQ1UxRV5nd1Queme6J1/yvsRAxfWWLRh5BqcAnc/ZN8tjrHL16MVs1Y5z3svNm0LC+lctecsVjjf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(83380400001)(6512007)(107886003)(1076003)(2616005)(66556008)(2906002)(86362001)(41300700001)(36756003)(5660300002)(8676002)(8936002)(4326008)(66476007)(66946007)(316002)(26005)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKDPwyTG67l1vEqyvBawqSrFIdDNJuGTKDY1CNy0qG9Nm+6ymAtHuVZd/Gu8?=
 =?us-ascii?Q?sNFB87wc5LUsr4AQFLIUMoCtYip1pfBKlR/r12pRjz+J258uYvKl5zVZVpLU?=
 =?us-ascii?Q?qZHiHTjMXcVmu1o9vTdvvO9M2GWxb9Gl0A/BhWqXcc+SWdBaNNfcL2bftG9/?=
 =?us-ascii?Q?aG0Z/0ochZp1EQwvd9/AP+uGcOomfm+LALA8pBX2H13vQSbi6EBYo4RxxdR9?=
 =?us-ascii?Q?vti4Ga9bIBrvYCOIZzrf1K8Qv00DIzAgEOx7iOgac/JI2tUp5v65Qtdol34a?=
 =?us-ascii?Q?/OY7LMFu8XUEf+Dj7CLggkdKusFj//yuH2lbE/y6Z3iZa10pbL3MYMq8fPlT?=
 =?us-ascii?Q?vi4rP5sl44kyOXmR1hx9L4+erXYSG8KFc1nh8UjmRcpK+ZepsiyVqPia6G6/?=
 =?us-ascii?Q?G8S8y61UZmQleABqnyeNwkr0uqPwQUzv5gyO5lImLck26gNJVCZAsIfFLnR3?=
 =?us-ascii?Q?ek3qwOAWPvrqSp0LAs0wU3RG2zeTUaUPmFKCiL/24uxLbBKEhsya5X6Au7Od?=
 =?us-ascii?Q?1UphYb9ML2awcq74Fja9vTH+WzeJHYFbgGrfJXJ1EwPbbf29cFMX1wsTLurw?=
 =?us-ascii?Q?uanz+W+7We5TMb5OrIigSPekgwPXns4X2DBGkJ57QawJLLSZb4RtYqOrr7iH?=
 =?us-ascii?Q?OCufuhi5u4eld7ZZCi8KyuqWxAwE5CK7H1tgikqYsxfgGQh+kD8Mr77WFM8q?=
 =?us-ascii?Q?IHz3FH3Wxoqd6xsqUrJQM3UHuh4R4/xYwl4YrRc/gn7p4rA+1VqJL7nSRpBk?=
 =?us-ascii?Q?lBGIUI1cwI7GIC5TEcNEZvLhoy2QDAqyLwg07IJbPrxq+BgQjH7OEXFMWo1R?=
 =?us-ascii?Q?wBZCSeaJy0Ij8ZeaVcNoFc5YlAvnYm3U82tzUeHimC62j+I0lBZ2YWwgAEiv?=
 =?us-ascii?Q?QG664dwAQGmCqvFbBVlvr06ywkcOIngUkYJ2tG8VzuGpl7rLLHADf8+LVMYe?=
 =?us-ascii?Q?BOFtCCeEDZQj4KKd8oe4fSZUtOhzUabPTPXTPq6UDRDcA3aYdiEtPYDo+MTX?=
 =?us-ascii?Q?q/slqxsax3Cu21j3ueWeBI5iknGBVg3UyUF7dc/0/nwaf1YgSZxZmm6ylZo2?=
 =?us-ascii?Q?OFciQx5OOuC/4Epp2FaJBUUAl7/0tD8XBzmr8ltL7mp245bDs8/QZmL8T9Kd?=
 =?us-ascii?Q?19TB4+XGvN0Jb8CqmJgTa5MCYPK9kKmh2HYyEUQw5w8HYB5wXLuPgDPxTrZw?=
 =?us-ascii?Q?d/Cv538DzpLNu+tOBfV30j0w/GHCCyW1UlgZuDoc0x5grOOFz1YZb+NBEEN6?=
 =?us-ascii?Q?9XzBKIHBeDpOOW1GhdG9lKcvm0HZYl337qt1plmQ/1vnqTe/w15h1QO9V303?=
 =?us-ascii?Q?IGIoauxnmPkpB0hQ1ETPKW1ylzKaI8S3gngAcTtA0F5C3j6SneXIil1csJ/7?=
 =?us-ascii?Q?rmwYMIk3+MttpSfBP/8822g+daHauTwKfXlp7IquWm/ZoWGBrGFUunnxGmhe?=
 =?us-ascii?Q?QYNeCJXu3XgSwQGH6t7NuM6g4P4+Cg8NhABjrV6zdVN2Sdve+kZcWAWwHJuE?=
 =?us-ascii?Q?YoMsFxigqd46dGet5B16MFofKxQooLI0zDAJDi+gzFPYgkTgReLda7sJPnBA?=
 =?us-ascii?Q?miuq/pIm+sUhk01x68zuxi0ClIoz4e3k/k0DVpKj0OV1ERvnP+BQsUyT6uGk?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TR2aqCpDzoL4VpxZ+mwCAzbSOn/Ib6SNSnhRgYestdzkNsLQOwbot/oJa9F58vy0DICVrX3F6bniHL3SklqCOVcJrkpxbIsw+QdwxXL/Nqy/uGgFm9vDFDOMmod621W0OOUDyTiwkgDMwD52dF+/XiycrtyBQt2+n+uVp2zAn3Y/jTa9m6LzEwXe/3NNcTpXK4o6UKo4dFPF95cbbouPk7zAMln6xIP+Li58goFeXQrWmz09bfEQRJmDTMZ3g9XyXWIIY5jKLiXDadre2PdJ2GE/FpzjB1/OIjLtW3UhMbQnAFHzhc+iqHPHsXSYEOyZg+cxGVzB39dcZvYwwj+lGpQRcY7MvQ7l1dRggPDkgqy97jyw9cAdW1x7RrT5IZBPtedMFgNIXbzwjuBx/TnzGTdbPbjFMe5TuDZk+Muh7YiwS8HKUw8ghwImDcVQS5PLhIB5cGYLaPu32IjdOTcVpR3v+1wP31TFqwswSATujUZ2qXRy2PWxTYquvTxpvID2LD2xfVKmPIYHVMablvnugw4hVI+BtG/mwyzd7doTmjfSz2LPWUpvlOD9b3ySF0DdT2dF/BAHfQ3u63MsCxz/KmUQyVdEAzyqwBy0Jv8RHplnN6vt75eaUQWAmQKucs7c8oF6+V0zh/TP2Fd6thBqb3QP4EhuqpbLOf6qC6VP1+3FaCwPksi6jE81sWcMToj2XY28ckd631Q5nRoL+R8PjGllZtzwwwGl1iMe6poj3LihMJ0Z00iimyftNpH9b3zRyDPSaWhiG2XkD2XfAj/k+YXGXiGoshoNPKOqYDCfqRre+A8sd0siVd9oDOkIOacVJUHXZwnGMxjY1ODYnr/PlA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ecd0c4-6c94-4017-2d74-08dbdf143a9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:03:38.0288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSFmSH6foK6Gvm4HW2ZlVe7xMnVhWjOrZyC6KBhVUQYso+DLYi3axStY3uyCD4AmamQH/KkqvKvkZiN3RqPRZb0EusGKHvbEhF0XcxPzTlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060181
X-Proofpoint-GUID: wwlrYxXcR6qdjWAqx7QHP9OeIN6HjZdk
X-Proofpoint-ORIG-GUID: wwlrYxXcR6qdjWAqx7QHP9OeIN6HjZdk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
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

From: William Roche <william.roche@oracle.com>

Migrating a poisoned page as a zero-page can only be done when the
running guest kernel knows about this poison, so that it marks this
page as inaccessible and any access in the VM would fail.

But if a poison information is not relayed to the VM, the kernel
does not prevent its access. In this case, transforming a poisoned
page into a zero-page could create a case of silent data corruption.

So we have to keep track of poisons not injected into the guest,
like the ARM VM emulation ignoring BUS_MCEERR_AO errors.
When such a page exists, the migration has to be blocked.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c      | 27 ++++++++++++++++++++++++++-
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     |  6 ++++++
 include/sysemu/kvm_int.h |  3 ++-
 migration/migration.c    |  6 ++++++
 target/arm/kvm64.c       |  6 +++++-
 target/i386/kvm/kvm.c    |  2 +-
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 64c0b37823..59af34f5a6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1130,8 +1130,17 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
     return ret;
 }
 
+/*
+ * We track the poisoned pages to be able to:
+ * - replace them on VM reset
+ * - skip them when migrating
+ * - block a migration for a VM where a poisoned page is ignored
+ *   as this VM kernel (not knowing about the error) could
+ *   incorrectly access the page.
+ */
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
+    bool       vm_known;
     QLIST_ENTRY(HWPoisonPage) list;
 } HWPoisonPage;
 
@@ -1163,20 +1172,36 @@ bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
     return false;
 }
 
-void kvm_hwpoison_page_add(ram_addr_t ram_addr)
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, bool known)
 {
     HWPoisonPage *page;
 
     QLIST_FOREACH(page, &hwpoison_page_list, list) {
         if (page->ram_addr == ram_addr) {
+            if (known && !page->vm_known) {
+                page->vm_known = true;
+            }
             return;
         }
     }
     page = g_new(HWPoisonPage, 1);
     page->ram_addr = ram_addr;
+    page->vm_known = known;
     QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
 }
 
+bool kvm_hwpoisoned_unknown(void)
+{
+    HWPoisonPage *pg;
+
+    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
+        if (!pg->vm_known) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
 {
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 17774fa5ef..3c914b5b65 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -129,3 +129,8 @@ bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
 {
     return false;
 }
+
+bool kvm_hwpoisoned_unknown(void)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 66937f9dfe..37d66ac614 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -549,4 +549,10 @@ uint32_t kvm_dirty_ring_size(void);
  *          false: page not yet poisoned
  */
 bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
+
+/**
+ * kvm_hwpoisoned_unknown - indicate if a qemu reported memory error
+ * is still unknown to (hasn't been injected into) the VM kernel.
+ */
+bool kvm_hwpoisoned_unknown(void);
 #endif
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index fd846394be..fd0a32c34a 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -132,10 +132,11 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size);
  *
  * Parameters:
  *  @ram_addr: the address in the RAM for the poisoned page
+ *  @known: indicate if the error is injected to the VM kernel
  *
  * Add a poisoned page to the list
  *
  * Return: None.
  */
-void kvm_hwpoison_page_add(ram_addr_t ram_addr);
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, bool known);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..63cb2c80db 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -67,6 +67,7 @@
 #include "options.h"
 #include "sysemu/dirtylimit.h"
 #include "qemu/sockets.h"
+#include "sysemu/kvm.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -1892,6 +1893,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (kvm_hwpoisoned_unknown()) {
+        error_setg(errp, "Can't migrate this vm with ignored poisoned page");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3c175c93a7..5dea8051f1 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1101,7 +1101,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
              * synchronously from the vCPU thread, so we can easily
@@ -1112,7 +1111,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * called synchronously from the vCPU thread, or a bit
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
+             * In this case, BUS_MCEERR_AO errors are unknown from the
+             * guest, and we will prevent migration as long as this
+             * poisoned page hasn't generated a BUS_MCEERR_AR error
+             * that the guest takes into account.
              */
+            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
                 if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 770e81d56e..08410185a6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -642,7 +642,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
+            kvm_hwpoison_page_add(ram_addr, true);
             kvm_mce_inject(cpu, paddr, code);
 
             /*
-- 
2.39.3


