Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7F743AAF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCB5-0003lc-3n; Fri, 30 Jun 2023 07:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFCB2-0003lM-Mi
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:20:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFCB1-0001SQ-2L
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:20:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UAegs1004737; Fri, 30 Jun 2023 11:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=80h5lYs6nwht1IvGJEhp9mExcoDo9ecwKOPGfzk8hDw=;
 b=e2np6n5NwyRD08tE+hse+g3nP6qyfQHfAGitl5IjMSeU5ZFu05Y3klI1V9SS0qdhoz0k
 dH39xFEsc/gsSBC6FYLByacrlM8yYRkn7My5i2A/W9r2VyO99QZfmq05zH+bgC0UdQ1S
 iTGqfEoSrhZTqLtxA4A+urwr6CNLsKA1N7T8vNvDGvatum62GNVmKpuiosHRirPs/9sT
 BuWJnkQiq5oRvV0vrB1g6/mJO28FwTfjiRYHI7svZrg2QQTGmH0Qmr8gb0e42zG10urC
 5+wZC0PtnkdCbrkPXODP81w9UTBAozZHSNWs1pPPIKxzknNYCzP+ISyky4WRvFzxkzYm rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1ughqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 11:20:28 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UAuXJC004083; Fri, 30 Jun 2023 11:20:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxerd48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 11:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7YhqBLJclEpdi0D+TrO47Ip43RcfqagDl5mk5wVbt7R6n1Up8bFCeuk/S3aai9R5WneLkptED1pTbju7joYjJMRlrz2szGMY740Crh6ceB4YqP1E4HoWJ6qej0c6VzJzj6AboWdIBc0lUBzT3WVXfEXDq9TAMMiR2nOo9wmiTK9vFdeTuYvVQiVNkpfiPvD1Yj0+FFB/C+tejqp8Cq+islIIYfStDRAvk+aZxs4oj2EVIi2nvXGceclHSaqYH/xYKNcb4I5dZhXcLU2Wn0EOCVsvXgNQtypJbQh8tt9f2Bu9ilTVr/i1jEcMF+pPq9VDN/lNZgZYepAvL8qbTSHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80h5lYs6nwht1IvGJEhp9mExcoDo9ecwKOPGfzk8hDw=;
 b=CqH9nOeE5wOpx+SuBp6UqgBQMpVkz3swDnA0Mqenl3upK8LJSeM66lTkwpjaPsAPfUEGIgoM2xiCcEt4KUsXsj1ll5/v/CYHVniQUvxtt464A6fH7vsN/oqryHFRcQs2eXOZRcg1K8pTgj+qyjUvyArXnXpnX8XGT2JIV000H7D++thmg4xBN4HWBmIcnMclLyWlpXMwwWlerehkdu6dpLT8hHBBTtKsgKS84bgJCabKKsL8p8td9ccUsersy5plDG5EQ0SgTbi5WmI7i3PaChz5Kn99mO1Wpye2q/L9bM4UMtCgWt6TTvO04cwMCsitvL8Bf/aUsCirQlcuq5TpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80h5lYs6nwht1IvGJEhp9mExcoDo9ecwKOPGfzk8hDw=;
 b=qpV+bxNDo2zwYT/Rx9K500Sa4igCUmifHhr55UfZ/UtByKwJklvQCxJlqLHbEzmD0QczdWpJ/SMyuc6+JvD/WXjpxpY7ch8e8/dGZ9p5jo77yXSDzgoQRESUq+/mTyn4kMexDqGbwhXg7tRcuikPGPq0VN/xH6XwppR9B1KPyaI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 11:20:26 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 11:20:26 +0000
Message-ID: <24c5a6a8-5422-ad96-61ca-006ed6887265@oracle.com>
Date: Fri, 30 Jun 2023 12:20:13 +0100
Subject: Re: [PATCH v5 7/7] vfio/migration: Remove print of "Migration
 disabled"
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-6-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230630073637.124234-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: cdae9e2b-f1d8-4384-f446-08db795c00a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6L6UX7/Rp0l6v9Cq2m9CQXCFmMONmZut0X4udvsu8vHNr6EFm8qMgQe6YLxlUZDt0LFQeCZ2s2403IgLPW/v7+7pdUFGznNH83UGS5gS5inDB/9p/Kro5B0XduJxtG0qqbht+MBchVeiIthTp8HdnmflsxNSwv5WqyJbqpUrlfRaCT+pe0IbAR66u+cNXmz2epswaPxjNSYetQ7q8tAqGyMnLwWGfZ3mNqyJqb2XRz9XJm7SZryigH1Eu4B4Y0aPkBSbMpRStYBgBF7cGjqAtCQJsCU4ZhrWik5C8uzAr5o0krkR09rBKfEPJFlnG9hY7HrPwF0wyi6bctPjb7Ab9H9Vu3URuqojX7Sy2VZ7vYequhMe16iD7lv9STJ9/UZYPB6hwA4AmyeJ3sa/znJaw9L+tHbMoS8xesTftXDSmlYJGHP4nUlK7UsF7LurQCY00F0e0Mr/24pZyinl3y5In49uplkerzQQ5rK225j3C1ziADDFGjbQht2OoSe9cG3cpzSs5DoqCNiHOnGYfQ/1D5va7nURT4IWdex0ytO75n9OqRJN449gSBj+eREDdJsp6r0vVqR4zbS1Fath3+hNVYBEJdztHosmTu2gFV3aggDoc23J7de+TRpHZNRVM2l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(6486002)(6666004)(31696002)(8936002)(8676002)(31686004)(478600001)(5660300002)(86362001)(41300700001)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(53546011)(186003)(26005)(6512007)(6506007)(2616005)(38100700002)(83380400001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1k3NFYrckt4YzcxMWUyQUYycldlZGw0MFFyaTdSbVJZeHJUN1dyMFJROWNZ?=
 =?utf-8?B?SVRBc3QvT3FoVW9DMWhRMnVhUnhhci85dno3cktGTXBaWlRrL0xySno1Tkxa?=
 =?utf-8?B?WlJMaXBKeTkxcEJXM3UrNkpyQmhMZTlqY2tCcGRwUWlSd3NWMjcrUXFIMUFv?=
 =?utf-8?B?cEpqdlRBWlhVZVM0ZmFlZWs4VFNJZktsUFNFbHZQYVpybFB6bDRwa1F0bHJJ?=
 =?utf-8?B?RmpwNjVNMkhHWXFyQktJSnZGYXFiRFNaK0RuUkVRRVkrMm9BZXJvNG1Xb3k5?=
 =?utf-8?B?emJFUXBJRWNIMkV5WlBzdXhQUi9PUEh3SHBIaFJ2bjJXbHh0NWxqOVZzelZv?=
 =?utf-8?B?QzEwNzdzWUtDOTRnY21jNnJlMHAvTVZ1T1FTWFhrc3ZDMWZlbUh4VHdueElJ?=
 =?utf-8?B?MlJOOVNwZ3pGckNMZFhZa0N4SlNIZC8yYmxqUVN1ZUZTYXFuRDIvalB4UTk5?=
 =?utf-8?B?MGsycEI1ZnN2T0hKTGtobTFGbFIvM09sY25Oa3hXUWpNRndoeDdHVDNNVVBW?=
 =?utf-8?B?dnBwcEYrcTE5N09tUm5WQWZmSlYrbVJuUFp3a2Y0U1BUamVyYTE0allRU082?=
 =?utf-8?B?T2ZSdy9UMDJ6YU5LOHd6aGVWVHBKdDgxZHFJTVdiU0s5Q1pnNVU4TGR2ZzhN?=
 =?utf-8?B?ZHNJaGc5NUR6bVI4ZjJKc05ibDZwRWFFNG51b0lHLzhFc3V2T0Vrb2l6aXhC?=
 =?utf-8?B?U0lNbmJLRW5yb0VjK25iWUpEays3VW1vTmttV1lTMjNiM3RLVkNFMXRTQlVz?=
 =?utf-8?B?TkJIS3FYTzNCV1RyaHl3NlhqVGRpRTk1TXRaanpHdlp3TkVvMlQzYi94TnVC?=
 =?utf-8?B?anpDeGpRVnZ4STVtdTlNZ1k2aHh5WVY2VDA5ZkJmNCtFdEFiRXFqV3psa29W?=
 =?utf-8?B?S2lQQmNkU0VvWHFKQ2FwSUY1amtyZlBSUm9yR1J4dW9GZ0k2cUNKQ1pUYm9u?=
 =?utf-8?B?NVhPNE0yN2g2aG9KbHZvam5reFNsTUdVWVg0aE85eEJOYXlwQVFNMTdFMi9m?=
 =?utf-8?B?dXg5OVVKQjUvZ2tpRmFqMHppbHhhWXp1a3c4d1FBUHN6ODBIZmt4SXJuWU1M?=
 =?utf-8?B?ZG1FZkZHZ293Sjc0bHVYcjR2K0dRQ3laSjQrVk43VzlabGdZWWEzdzJiUWto?=
 =?utf-8?B?U0RjeGRDaDRHQmFLekYyaUw3VitFVFAyT3Ziak5uZlJXN09LekFJUWh6VFpH?=
 =?utf-8?B?bHV2K1lQRzBRSjRlR2ZqUGxhN0dKNk91K0VkUDZhYWdwd0w2OG1qRWVWYW9m?=
 =?utf-8?B?TmdPcU9zTWVTbHBTaGVPaHVQeURUYnlwK3F6bTR1RlI2a3hiNGdxaUNNOEJ5?=
 =?utf-8?B?Ky9yQ0t3aUNYUFRHbTN5WUpWTlA0aUpYWlp5Y2txaEdoM1ZyOHgyQWdYcWVD?=
 =?utf-8?B?cHNic0VNaTVWVUtzSXhFTzRkMUFqZ1pqUHV6MEw5TE1TTnRWWFJpb0grUmpB?=
 =?utf-8?B?Q2xhT3dsMFNLQVJjNkJvL3VmUzI3dzVDaWdWd2U3cVJtcGh5Y0NZMXU4ZWx6?=
 =?utf-8?B?WnJlT2pBTHVVRWkxY29QR2FzQU05TFRQVGV2dTQyL1NYNy9LdnhyN3V0NGha?=
 =?utf-8?B?R3BZV3dZdXgzOXNKd2hmVDkyNmFFWUhZQ0t3L1NDUTdRMGlKeDBUcXZNRzcv?=
 =?utf-8?B?WmZFYjR4MDBzTmdSNjNUT0xyUHNRbnNuMmtYRDVaMGdnM3d2T013YitKeVE5?=
 =?utf-8?B?MXZNdmFGU3hFMW9veXhvK294V2UwMVVpVCtMamZZbE5sTHFqcEVkamM1Sjk4?=
 =?utf-8?B?K095TDFzVVBTZXpXUjNJR2FmQXJKRVRsdE1IV1YrajJOTThPaDFUK1dHK05Q?=
 =?utf-8?B?akZISithQXo3Uk81R05hWE84ZWVaL0pReTMyRUQyQWRkV09IVU12RXNYc3A5?=
 =?utf-8?B?MDFkYThlcENoc2grNXZWU0xUWkhjWnFkeUp2ejBCU0h1Z0tKajJqOWtJcmIy?=
 =?utf-8?B?L0UrblJPYmZqTDIybjkrTUV3RkN5WS82b2NNWHpndUF3WHI5OUE3YTI1dmFr?=
 =?utf-8?B?L0FSVW1QVDB5ZlJWa0pxV1RzMlh6OStpV3oxbE5qTEx3dzF1amR4OFZHdldU?=
 =?utf-8?B?bmV5b2F0K2tOMk9vblUvemxZOWQwUzZzM1Z6cnBnNnpXOHY5M0RHR3Z1VGRi?=
 =?utf-8?B?NHFSanZkUElvRi9pWCs0Q0NhZVR5M2kyQ0NETTBOdGoxTWRWQ0gyNUxHTFBZ?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pytttgzJjVTFxviwCO1nzGhZ+kAyPIbjQneYpZC2b91eNspKcSQxc/wojEcWfaIkfMp+15IIdyTBbrs0Ho/k9RRiSwv5XJ3EBv3EqzbtiHy4J+RKKjjWKfs6r+fQj7kE+nDuhBALufNnpms53dbKLVMRtOjo78aVf6R8cUByEkDjRp00CniBLEkWKtJ7EZDf0qgSTBwJzXuGBn+sOuJQYBa7I8Qa9OXXOAq2tIwolXzOmQCAQ+h9KC/7IOV18pFko9Q1nWxsuYxuNxyuLfuUsoxML+OxGjmCjGmitb4YI4MCwYNs+s++kbgC9IZ4VyIUdazKJln1XhmPh2MA7HuDw2FCBzkKlUH4vRE72+TOoPVuVIkgqD7VyMDEisZ5eRvG75nYFltWm/qBQOKT5Kd8zjk5/4nMETRnfCFhXH6z9p7r11LQevHz9nwl5p6+ssb+zOK9XBsSm5lXyN5p/oksdkYOP5xqiqQRTYh6FzqILFDq7I6ZN2OLEbI02eIqGF9fvi1H+Oh+q3TxLfHYouoj+1u2EIfHkhyml1Zd/EFmRLGuNHqEXoPpUfk49NNZ+sg2oG/m+eguoiy5BLGeOMnBG0QdhF7t6K0jRb0Y5XHCos3eEXJtIkODNneP6iHJMlbeqPxSI1e7Ve5i8RJQ1So6OkC6JDRmkUs00lZbVNet0O8e8masB7nH62ec6xVGpwqOUDWvZyzhkrKrywETq6HyVVP47S2qRbk/5tsYnZT+q93AZN6JU+0sKvVXRMrToU2HXGQqBc2iv1sTbxfGCeM23E1J5hOoL5C4M+HnGUf8Lyh1bmgElECyhYPybxrTmrxrKc+1c+OHQsSZZq0gkBJU8Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae9e2b-f1d8-4384-f446-08db795c00a2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:20:26.0929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mq65KOhyflnVNQP6u4HRo3rQIEeRSTHlZB0t0AjV0CZ9KY8sLi4BrBN5surCcGGaZZKrugwS5NWF7osXjxI2gzWTutMDLVYLhtnuxejV6ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=962 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300096
X-Proofpoint-GUID: Zz_2tW-ssE6kmLAq2kmqa6EB_YEpYet6
X-Proofpoint-ORIG-GUID: Zz_2tW-ssE6kmLAq2kmqa6EB_YEpYet6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 30/06/2023 08:36, Zhenzhong Duan wrote:
> Property enable_migration supports [on/off/auto].
> In ON mode, error pointer is passed to errp and logged.
> In OFF mode, we doesn't need to log "Migration disabled" as it's intentional.
> In AUTO mode, we should only ever see errors or warnings if the device
> supports migration and an error or incompatibility occurs while further
> probing or configuring it. Lack of support for migration shoundn't
> generate an error or warning.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9cf70c1965d3..1c969fccc543 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3209,7 +3209,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      if (!pdev->failover_pair_id) {
>          ret = vfio_migration_realize(vbasedev, errp);
>          if (!ret) {
> -            error_report("%s: Migration disabled", vbasedev->name);
>              goto out_deregister;
>          }
>      }

