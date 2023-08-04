Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0415B7702D1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvcU-0004Ly-ES; Fri, 04 Aug 2023 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRvcS-0004LI-Pg
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:17:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRvcQ-0006L3-DM
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:17:32 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374CJ3Yp012801; Fri, 4 Aug 2023 14:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pO5E+wahHD0vAL2acjLnCp4pGzdkiCvHhf0fjW5bivg=;
 b=pGcSHVLTleLPSRVMzv5hzkg7Q/Ai+voMQVv54dujlBrv6nmulUNMJgQ7o7MjKUL9o3fx
 umAn8qWot1bipCVeMd7SeKmxfpMmC/owWK1WoD34UIztxN3N+2EePkFv096rtbSm3Ocu
 CwFx1Qlw+B0vQU2EDN5taHuBSVeNvFb4GZThZeIerkmB+4pmubuASZku66p5vaPAVicP
 iByyZ9oFUceSbfqlQ22uOpnsxHBOyWh0z7hGFyutvOPxuayPaA06v7VzHAHx41mLIv23
 Ys/l4azuGP4iTHAnHluMD5YC6h+gA8CZUD4JXu1JSXs2AgHrkFuYanYHEVncOlLvzyEK zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttdc0h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Aug 2023 14:17:26 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 374CgdO2021391; Fri, 4 Aug 2023 14:17:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3s8kqewa75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Aug 2023 14:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7645jNK/EOZc5aEu3NNswvf92E4seRIgRbGdWZgZvfVVYNagYW+531MmYutcFJJUp9Q8u8Nj4DBlh34sYWwjMl8iGptaVoFNPeK2Sgj5LY4+ny94jTWKXL8YcxtwELYsu5fv5Bu5q+aDsXfZNRzYJkP4nTys4R/mlFtHbaUTWQrrweOp+QbBJV970NFGSclePZ23HtyPkHb5xXQaaikWRvFjwp+yjDUFtPyfeHD4QCoBMpUqDn2gEkrNWkmpGIA+2XXKlsspNEf7e2hIMw79/ZR8/+28Gi5dKR5mPpx6FFP2GN4gPET7zjah+6Qiw/Ks0VLXAJlqF3Vu08XocCMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO5E+wahHD0vAL2acjLnCp4pGzdkiCvHhf0fjW5bivg=;
 b=SbjuIzOL06tKqUwtl+rkcwl+/lYGQJU+pvS05rF4tsBT0UkgVmAZ4Hd9emP3DIZ1b6M8uaJLVtHsugIzroaLIKDD5XkuDrjWhMN8ZgPI/cK/4JqlhsqTiQ0B56g2kPRpbWQdjgrvMfDahsxouFyRdcSivcVB+OO4KO3JMPJhpyPVnB3n4by+tOGZoGgdU6hmZgvJh2e2vuK2WmfeJ3F2UM9VqtE127yIyE4nWr1zzjGBf0Kj6dW8XohZ4vxq9xXbUWbobnVW7WZMC8dp3B5LwHmx4IeWmRPUiX96X3hNAGVTB8BbGjzs7eHknUbKlxV/g5XLLIsd0t8bm3Cx3DACkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO5E+wahHD0vAL2acjLnCp4pGzdkiCvHhf0fjW5bivg=;
 b=GJKo23sCd7S2gXB3DBR1OUPaI3V0JmCPqpmJH00qLyTr3tmJtZTJomun3Aau71kEJQgEQ4LomzNN6pZjizMX7d/TnPr6hq7gXba064f1hh1jdwN/PEmqTkSlXhWoILxEf2w48h2y6q1lk1WGTc8NfPvu6jqIIRD91PpASSsK2WA=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:17:22 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::565f:a60:aaf8:bae]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::565f:a60:aaf8:bae%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 14:17:22 +0000
Content-Type: multipart/alternative;
 boundary="------------VxpIPt04SKE3nwGM6KRjyEG4"
Message-ID: <baa9a2a4-09d6-d073-67a1-ba6d3510c181@oracle.com>
Date: Fri, 4 Aug 2023 10:17:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] qmp: remove virtio_list, search QOM tree instead
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803145500.2108691-2-jonah.palmer@oracle.com>
 <ytsdr.hu96pu2zioj@linaro.org>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <ytsdr.hu96pu2zioj@linaro.org>
X-ClientProxiedBy: BLAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:335::11) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad51692-d5de-496a-1795-08db94f5851d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSGaEYVNQKUr59usf0Q0+fWuwtSxMgs1ypQ/FitAAjnYrm4GQoQdmFQjLWLeiyLaskl/KByVKQS1K4JvxUirxV/YUmarb4WRlfH5cSLAmZDnrDYWy4RRBKanbxYV42zfZyDZpC/EVKZmQVX2DgpxSauZD5ZZ+2gMya3SanGaZahU0DT/r5LyVGPSbfK0OlwN7jhWdKeLz1EQQOkpou7BkIONErLn8z+nT1z/Pl8k3Ax4azESLHYkxFXcofDunO9qN4P0U4podetcM7JjWeHG7Ne70hFk+eahHj/t9T3Mrp5i4lZRhkuq5UOgnqe7QXEmB+nHDrz0Kx2v7GyYV6wlQozUoUq3oPKJK0mxCsYHdpke6+t+xNMFqZyP5yO1vllGglDGdZI28qO7AqZOmzqXNq0c164iWRijrnVl1p8H94gIWpiOQ6Zdw7XCFfzQu6mUbXxcNp53rJcY2q1u41GkTOaLIR0e29W0sjqITfxUEL1WT1856rC9UZlIK/JOIZrom34vxvKpVQFXzlYt+j3X7wklIFG+BNPCpBvgxjxT1tzG1q/9vQdE/PJKm2TK+vKjTLQ5nUnX8W5j9rtGgT7l9Xj3UxhyqM0nRv6l8EKgQWeWwQXMtKvEN8ldvR+ST4F0Tc+5UQVeMooWwuaiR9CRvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(186006)(1800799003)(33964004)(6666004)(6486002)(6512007)(86362001)(31696002)(6506007)(26005)(2616005)(36756003)(53546011)(83380400001)(38100700002)(5660300002)(41300700001)(8676002)(8936002)(31686004)(4326008)(2906002)(66556008)(66476007)(66946007)(316002)(7416002)(478600001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmp6RW5EWkg4ZkNZeGtSY2RkYXZ4OE5xQ0psV0wxaUZGNzZKVTVLVTN6UDFp?=
 =?utf-8?B?S28weFNZbE5ZN2VXYk9Vc1JvY0I1UVdNeG1meWFiSWd4L0tvN1ZPK29QSDZB?=
 =?utf-8?B?c1RrSURhWFdNcGxORXRodVUzZXdKaGJXeExUS0ZJNmdCNFp6czQ5czhJNktz?=
 =?utf-8?B?M3YwbkdjT1lGMS9wci9wSnFGdDdrNHcxRXpGV2xzMEJQV2RHQ0JUQUJvTk5x?=
 =?utf-8?B?UWV4VEpFMlBOSHNKZmVEeDRPQk1IT1NNVHZHKzJoRkd0a1dBazRuTTQwYlVv?=
 =?utf-8?B?WHJqRXRXQ3ByNDRKMGNzbWptMVdUSjlFZlVXdnVLeUxoV3BibmFvVnYwc1pE?=
 =?utf-8?B?eEFlNFF2eEtUM09kckZTLzJMVm5XOGF4NEttS0pIM09LNjNCMUJhMXJmaFFE?=
 =?utf-8?B?WDJySkxEeGNiM1ZRTjNGNDJkQXhzbWphK1Z4M0ZuMmJlcGRUalZjY0I0NGhn?=
 =?utf-8?B?RUdIWnNsVzJ4Tm5GVmFZV1QxWFFheDJuR0M4TkZOVUVRaEsyY2tSbkdINU1Q?=
 =?utf-8?B?Zy9oUXFKbDJYM3ZWWTd6VHdTUmc0RVluaFM5REhDb0FSUzB3b01EWm01NERI?=
 =?utf-8?B?TEwxSVlkMy9vNk1ibkhEeko1WElZREtHTk1vVk5NZDlUcVEzM2toTTl2dzNm?=
 =?utf-8?B?NWVYdWVaeGx3Z2NrSWIxOVk5dXJCblU4RkFqMFAzUTlKOGFJY3lpOEU1V3NR?=
 =?utf-8?B?cWIvNytDU044YzhqRXlEZmVzSGZzTmp4UVN5SHpRY0V0QW9ORkgvUC83Z0p1?=
 =?utf-8?B?VWNEenFTSWFSS09tSzBmZWNsSjJVRzBrVDZLb0dPR3prOWdTQ0NoNm5MU2VH?=
 =?utf-8?B?QjZKcDlBY3dnU3VMdlVReU9zNldMV1NVelpucUpaK0ZxZmJacFVqZkczN3Nx?=
 =?utf-8?B?S1pDTEZJVVBOTlB3WU4vVGlFa2NwU1VGZFMrUWpLbTdJSURrRkxMZURIUFk4?=
 =?utf-8?B?b2gwc0FSNTVqL2JYWUFGMUJ1aGl3RzZFblZCV2ZpZytiNk82WnJYVU5Sc2V4?=
 =?utf-8?B?d2RNUWFVUUZZK2lhRE51VkpUY3c5bmdpV2xoNE1pejFsQTQvcFd0eDdKM0Uv?=
 =?utf-8?B?QVNyS0tteUh0aDZpdzBVamZZZjYybi9GNEtMMG4yV21hS1RjYjBadVhMdG84?=
 =?utf-8?B?QVZoQllFdGFWbGhVUjcrVFE5WHZxdUQyR3M4clJLTFo4TTNwL0YzTlU5TzJW?=
 =?utf-8?B?N0dHbFRKcmMrRWswdUdBWktBQXFrWFBwSldVYkw3VXRZbW5tNXVhU01BQzZw?=
 =?utf-8?B?UXhTK1FSTDdsbEllcXBCUFZNanlKcEFqb1Y2SS92Q3VzZk4wZE5LbVNhNGtJ?=
 =?utf-8?B?UFg0bUNmWlMyOFliSVhJUVFaSEtBdURTOGdWV283OVQ4UmNnVW5qdERYVXdr?=
 =?utf-8?B?cU9Ca1dXejBObk1ZV3NEMTBuSjgwTkgvdk9wYXRDS1ZmUU4vK0hNYW9wNk91?=
 =?utf-8?B?RkdHelFhbWRoMlZnVjZWUzU5eWtDQ0hYTDJmbmcvekNNdWM3MENMR3R5UlRL?=
 =?utf-8?B?WVRTR1hNQTF3ZlVldm9HdXUwbThHR0xISEZiS3ptRWx3L1MvM2lwU25TUW9y?=
 =?utf-8?B?aDFoWkR0VDBSSTNDeGt2ZlJzWG41SHQ5MFZVbzBNSFVLY2huOWNObnZqb2M0?=
 =?utf-8?B?Z09mblp0Mmo4MVZrVkpiQjdKR0tRUUpKdi9qRlV0bC8wRUFycWN4VWZzTnJ4?=
 =?utf-8?B?U2cxVGMyb2lGZFBPUFhuTmR3ZjhoQ3JrR014RDlwalJQOUQ5M1lRVkE3SnFB?=
 =?utf-8?B?dDhCU1hGcEUzb29HSEI3SkJQQ01OaG1xT1dFZzNaODlWNUhrdytvanhNdUFF?=
 =?utf-8?B?eXEzVHcrZnFvWFhzMXp6eCt3Y2hneG52YVppZlBDUXNyUUhTT2hsTzFzNFp1?=
 =?utf-8?B?dEIveklNUm1FSWN0UnJPeTNnbm54T3U4MkR5blFTellhYytISWIvSk5sN3p4?=
 =?utf-8?B?c0RNV1BxN1oxY3djazFwVDlVZ0taQ2NIMW80allSM3E1Y3VuV2xEaEtkc01o?=
 =?utf-8?B?K2RiVmZwRFFJallQZFVUSzJKZHlIVzBWd2dFRldOall6dUVQQnVwYzdsT2xq?=
 =?utf-8?B?RE9ZWS8yVjhtMjEwNWV2WjRZQ3dCbWtGUUpxenV0OCtwcFgyQ0ZYclhoaW05?=
 =?utf-8?Q?Ss5Rz+t5C/U2NwhQ8JKXqOOCz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1T3c4zlX61FxNiQlcQcIVl2XPp0LPDVc5NXbMbqjxV3K5sdPsOu4D+QTz89hwVjPqObvgJsA3S22KpNdS8aIxYBpxCxW7KA5/6+QfloMfFsvoodFvdf/qyqktrGx11jMa5euLGY3+EqX19/wHyK4ROPPxIXcnlO+oNxDrO+GBfI1k8DqEJUSatTEIKzVeelmZG+D7zXJsf+Tu4sM0Zm5CJK6YpHftRFdPf28CL2ifIj0uAYmMopgAEL6lnw83lhJcv2XUXYqGHAnNMA/Wzrgn79vIN8r89LreSeMVfGn5OjkCu3nYUsb8ioOlPwrGvCU+nBwS0mHhNCWYKGagQ7tPUF+jsZylzBYdPdA54idp5nL87xM029xjqIH1Mg7BcdF9FJ8UaGJ+9dAXsr6nLEOcz4GsPmuE82AzZBVyr5gsJqE6CNgVPaGkjcX15m9DfzgcD28wUV+1wdyryGXVMhJtv+L8d6VzD4TGxOoQm5xL80I0bEwIxcaJgqX8krzlW0nwVpGG/9cMnmPIMlJaBKOsESQTvBmZb2X08d9pJV+7D7nysbIzwr83Ek2RC165soIzHSGiztG4L73WEnJwBz3En3lKk9AfP3PMd1djpuk/D4LO8URtzA5hpGCkIBeyIs+X5xyTIxRVeRPEZIvbsvyhaAB1cOUpDOi0bBolVvR1dyiV04sTS0hG/OYW2UrP6UZz2s/vwZOW9nu7oSNHP8S5V9ZYU76K0Z/tIXh1TJA0zVBzIYNG+0Nf7pq/wC6qxl3uUXkVpfIgk2NVpnvYwEx1CH+H68GpmjmLN7mEs46XVhV7IpY17Szn7V6LlLV6N6gmZj9x+eG2gpl6Jy6WmFCnr6KC9/bUcy/BTkxsECLrsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad51692-d5de-496a-1795-08db94f5851d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:17:22.5718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMCRyWXhgY7BPPKnRlAj1Z7sf6jdy7pG4OPQzRsfGyR6wdUJIinhpN372Wz0DoB7lJVD7rCDZmCkldvk8X8gFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040127
X-Proofpoint-GUID: AlOgfryeibGVYhdKM9CQ86wWzR65rsAl
X-Proofpoint-ORIG-GUID: AlOgfryeibGVYhdKM9CQ86wWzR65rsAl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------VxpIPt04SKE3nwGM6KRjyEG4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/3/23 12:40, Manos Pitsidianakis wrote:
> On Thu, 03 Aug 2023 17:54, Jonah Palmer <jonah.palmer@oracle.com> wrote:
>> -VirtioInfoList *qmp_x_query_virtio(Error **errp)
>> +static int query_dev_child(Object *child, void *opaque)
>> {
>> -    VirtioInfoList *list = NULL;
>> -    VirtioInfo *node;
>> -    VirtIODevice *vdev;
>> +    VirtioInfoList **vdevs = opaque;
>> +    Object *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
>> +    if (dev != NULL && DEVICE(dev)->realized) {
>> +        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +
>> +        VirtioInfo *info = g_new(VirtioInfo, 1);
>> +
>> +        /* Get canonical path of device */
>> +        gchar *path = object_get_canonical_path(dev);
>
> (You can use g_autofree char * here)
>
Got it, thanks. I'll use this and remove the g_free() call
as well.

>> +
>> +        info->path = g_strdup(path);
>> +        info->name = g_strdup(vdev->name);
>> +        QAPI_LIST_PREPEND(*vdevs, info);
>>
>> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>> -        DeviceState *dev = DEVICE(vdev);
>> -        Error *err = NULL;
>> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", 
>> &err);
>> -
>> -        if (err == NULL) {
>> -            GString *is_realized = qobject_to_json_pretty(obj, true);
>> -            /* virtio device is NOT realized, remove it from list */
>> -            if (!strncmp(is_realized->str, "false", 4)) {
>> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>> -            } else {
>> -                node = g_new(VirtioInfo, 1);
>> -                node->path = g_strdup(dev->canonical_path);
>> -                node->name = g_strdup(vdev->name);
>> -                QAPI_LIST_PREPEND(list, node);
>> -            }
>> -           g_string_free(is_realized, true);
>> -        }
>> -        qobject_unref(obj);
>> +        g_free(path);
>> +    } else {
>> +        object_unref(dev);
>>     }
>
> The object_unref should not happen only in the else branch, no? Though 
> it's not clear to me where the ref count was previously incremented.
>
There is no reference count being incremented, my apologies.
Therefore, there's no need to have this object_unref being
called.

I'll remove this and the one in the qmp_find_virtio_device
function below. Thanks for pointing this out.

>> + object_child_foreach_recursive(object_get_root(), query_dev_child, 
>> &vdevs);
>> +    if (vdevs == NULL) {
>> +        error_setg(errp, "No virtio devices found");
>> +        return NULL;
>
> (No need for early return here)
>
Good catch. Will remove. Thanks!

>>     }
>> -    return NULL;
>> +    return vdevs;
>> +}
>> +
>> +VirtIODevice *qmp_find_virtio_device(const char *path)
>> +{
>> +    /* Verify the canonical path is a realized virtio device */
>> +    Object *dev = object_dynamic_cast(object_resolve_path(path, NULL),
>> +                                      TYPE_VIRTIO_DEVICE);
>> +    if (!dev || !DEVICE(dev)->realized) {
>> +        object_unref(dev);
>
> Same as before with object refs
--------------VxpIPt04SKE3nwGM6KRjyEG4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace"><br>
      </font></p>
    <div class="moz-cite-prefix"><font face="monospace">On 8/3/23 12:40,
        Manos Pitsidianakis wrote:<br>
      </font></div>
    <blockquote type="cite" cite="mid:ytsdr.hu96pu2zioj@linaro.org"><font face="monospace">On Thu, 03 Aug 2023 17:54, Jonah Palmer
        <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a> wrote:
        <br>
      </font>
      <blockquote type="cite"><font face="monospace">-VirtioInfoList
          *qmp_x_query_virtio(Error **errp)
          <br>
          +static int query_dev_child(Object *child, void *opaque)
          <br>
          {
          <br>
          -&nbsp;&nbsp;&nbsp; VirtioInfoList *list = NULL;
          <br>
          -&nbsp;&nbsp;&nbsp; VirtioInfo *node;
          <br>
          -&nbsp;&nbsp;&nbsp; VirtIODevice *vdev;
          <br>
          +&nbsp;&nbsp;&nbsp; VirtioInfoList **vdevs = opaque;
          <br>
          +&nbsp;&nbsp;&nbsp; Object *dev = object_dynamic_cast(child,
          TYPE_VIRTIO_DEVICE);
          <br>
          +&nbsp;&nbsp;&nbsp; if (dev != NULL &amp;&amp; DEVICE(dev)-&gt;realized) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VirtIODevice *vdev = VIRTIO_DEVICE(dev);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VirtioInfo *info = g_new(VirtioInfo, 1);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get canonical path of device */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gchar *path = object_get_canonical_path(dev);
          <br>
        </font></blockquote>
      <font face="monospace">
        <br>
        (You can use g_autofree char * here)
        <br>
        <br>
      </font></blockquote>
    <pre>Got it, thanks. I'll use this and remove the g_free() call
as well.
</pre>
    <blockquote type="cite" cite="mid:ytsdr.hu96pu2zioj@linaro.org">
      <blockquote type="cite"><font face="monospace">+
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;path = g_strdup(path);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;name = g_strdup(vdev-&gt;name);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAPI_LIST_PREPEND(*vdevs, info);
          <br>
        </font>
        <font face="monospace"><br>
          -&nbsp;&nbsp;&nbsp; QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DeviceState *dev = DEVICE(vdev);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error *err = NULL;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QObject *obj = qmp_qom_get(dev-&gt;canonical_path,
          &quot;realized&quot;, &amp;err);
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err == NULL) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GString *is_realized =
          qobject_to_json_pretty(obj, true);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* virtio device is NOT realized, remove it from
          list */
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node = g_new(VirtioInfo, 1);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;path =
          g_strdup(dev-&gt;canonical_path);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;name = g_strdup(vdev-&gt;name);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAPI_LIST_PREPEND(list, node);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_string_free(is_realized, true);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qobject_unref(obj);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(path);
          <br>
          +&nbsp;&nbsp;&nbsp; } else {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_unref(dev);
          <br>
          &nbsp;&nbsp;&nbsp; }
          <br>
        </font></blockquote>
      <font face="monospace">
        <br>
        The object_unref should not happen only in the else branch, no?
        Though it's not clear to me where the ref count was previously
        incremented.
        <br>
        <br>
      </font></blockquote>
    <pre>There is no reference count being incremented, my apologies.
Therefore, there's no need to have this object_unref being
called.

I'll remove this and the one in the qmp_find_virtio_device
function below. Thanks for pointing this out.
</pre>
    <blockquote type="cite" cite="mid:ytsdr.hu96pu2zioj@linaro.org">
      <blockquote type="cite"><font face="monospace">+&nbsp;&nbsp;&nbsp;
          object_child_foreach_recursive(object_get_root(),
          query_dev_child, &amp;vdevs);
          <br>
          +&nbsp;&nbsp;&nbsp; if (vdevs == NULL) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;No virtio devices found&quot;);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
          <br>
        </font></blockquote>
      <font face="monospace">
        <br>
        (No need for early return here)
        <br>
        <br>
      </font></blockquote>
    <pre>Good catch. Will remove. Thanks!
</pre>
    <blockquote type="cite" cite="mid:ytsdr.hu96pu2zioj@linaro.org">
      <blockquote type="cite"><font face="monospace">&nbsp;&nbsp;&nbsp; }
          <br>
          -&nbsp;&nbsp;&nbsp; return NULL;
          <br>
          +&nbsp;&nbsp;&nbsp; return vdevs;
          <br>
          +}
          <br>
          +
          <br>
          +VirtIODevice *qmp_find_virtio_device(const char *path)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; /* Verify the canonical path is a realized virtio device
          */
          <br>
          +&nbsp;&nbsp;&nbsp; Object *dev =
          object_dynamic_cast(object_resolve_path(path, NULL),
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_VIRTIO_DEVICE);
          <br>
          +&nbsp;&nbsp;&nbsp; if (!dev || !DEVICE(dev)-&gt;realized) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_unref(dev);
          <br>
        </font></blockquote>
      <font face="monospace">
        <br>
        Same as before with object refs
      </font><br>
    </blockquote>
  </body>
</html>

--------------VxpIPt04SKE3nwGM6KRjyEG4--

