Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 144058309E5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:40:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ800-0008RE-9z; Wed, 17 Jan 2024 10:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rQ7zx-0008R3-DX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:38:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rQ7zv-0002S4-Eq
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:38:37 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HF2DJ9027526; Wed, 17 Jan 2024 15:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vPUg7QzabW4OHLWSgCjsunJHy44EwXgx5Cc7tgROeYs=;
 b=JMzfI21meubrQpsnTRXACvlVLCClECAxTsRRtlX662x4to3OQCf7VGXtKiA3bm6EA6Fo
 kXADZiVAN/l+uit0XPFbsSe66XKrMU/iM/WGRxhMlUD1RlNQgdU1HvcWUVgHPcvh0PK5
 U1RiWDwZcV2v52UgcJ5jrIb0rs65tc1jcaZcGUtdCGOxOS0ZOmjKjuAMhbyCuRJJEsPT
 u53XT+Wdvh2MImt1svclTF6UDQLdN1MWVXWO+xhJcsrIlsvM+fSzj+zLw7oGrqB+bn+9
 9idKR2LtgMCIZIHK5Ve7F/4Rd/9/879iQhiUG8cJQxavTGL5GMU8qTpuMFsCq1m/C6NT KA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjeg7hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:38:29 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40HF4utB009862; Wed, 17 Jan 2024 15:38:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgyagm4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4/WRWaTak+RuSC8cXVgAYk29Jy1J+Ev8nh0yiv2C0LFKcwzBwCg0U5+T69uAyb5iEbCsJqKnHlgpyOYm4x8Lv5rbBPNrOJ2RIv2NhfAJ74AJQLk+giX9ykCHaONbNE5agOekGBFovM/5uIdJL/eHuPgsesMQ9pRq8tgSsEUR265/1PItLmfxl91gEsbGmeTx3lbh7ZRfnfhUruRAt3MeR1LqcpU2JbyTwKpOUlyNYkje5glWkD9m4Aam/jJsg9ixczx+7gL75dQ4qppIZF3h6fkwetHKOXKGkOcBlbDQQnbWGwQDc/0+EO4cpY5EwHs+2nPGJ5MzCZ416cyH11Hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPUg7QzabW4OHLWSgCjsunJHy44EwXgx5Cc7tgROeYs=;
 b=Rv0q7rd44P3xaOs/7m0qF0q0htnl9tTgM5x7zZweaGiyzECTHsCzdAZURRrog9pk9LFec9LBynyzvvXV5XNRCsOnH2wbtw3PQDRY/GL/9ZGCGs31oiTTvaEJN+aaP6+0raviXiRWADVktdLdn8TvNIXZzj2vwvJ7VhS66pamaUyVVQFQKe7Rh2RIvb7eaBmVVMZYCBdEfU8RQyvIwHv/OZkUKin+QaeFq3kh62ugVjIV6WrvupdW/onasntLkY85Xqm7DWC88jAlu5aauucKR0QPVwL6g9JIiM0VEIu7WMdd8V6+CJhxL9/TLT8i8EznTJWPliraiOG3h6pIm6pvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPUg7QzabW4OHLWSgCjsunJHy44EwXgx5Cc7tgROeYs=;
 b=pKCSRDMkF+rJqqw8VTIP68mJA9TPIvz1XeneB3MOHKoFtLGAzZjYAwvgIULpvm0L4d0BqzVbc9OuKZFq00MsGgeOy/F8qIjO4GNwGpG+Sikh6BlZMEUc8Jr2O4a9fZdiH+9tcGttT+NUEZtUpzywCYieKttI1ZJXlhA3BclXSQM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7457.namprd10.prod.outlook.com (2603:10b6:610:159::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 15:38:02 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 15:38:02 +0000
Message-ID: <d6b4c54f-f24d-4e30-9e93-9c126a42e00a@oracle.com>
Date: Wed, 17 Jan 2024 15:37:55 +0000
Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, qemu-devel@nongnu.org
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240115101313.131139-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fc6de1-f481-4b22-e8b3-08dc17724a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0nVSm9uDQ0TqHoDEahLdiW/613SXDVlcZUxCB71ZwMZnRPpM0AaNZRqF/epDVfb7qI7UMVRH4s11mH+w5m4ghjV1yYf/TCOZImP26sm+I+1OOx2N7izloD7pGDR/rsLJoL51LNy8gfzq3cnPxIU4P/+oICrz9GuE3cJ8LkV+qO5G1NecjmD0h4ux0zLpVJGxQ1XY3JZs13qqP9/c0adegG7vIQZIRiuYtEhwYRmOWFy7iCnErU67OjBEnhj86Ti+DhZb1ptsbjzniXDXvPf9aI2jlNvO+Ijmu4+ZOPxxgZCOI3SK+VhyCBXeX2wCzT6fKqVB+CKpC6QC55k/J6F/xeuT9XPTiwEdkBxc7nB2trA5Pl1joDHBxZQ0RFgs0O80y0A5YU39wkG3Vil2QQZNQZML2179b+dtCKkuPSGyTjO+iMZ84HyZ29S0RbhZRi7YYoz+OtmhH355ec3kGyJpnxp3KvAGZXAYTMH4vxg4EnQ/bvnGQjBanL/uXzqlhLypkFN3GDqj508od2Iqt0wBhEfFxmOeqDAy54fdIY5Qn61d2F1T8ZsYOp45OYIpf6/S4y3gFed6tRqkNFCBfdHzKATjhnMUcXDTpk5rurvcIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(41300700001)(36756003)(2906002)(86362001)(31696002)(38100700002)(478600001)(53546011)(8676002)(66946007)(6916009)(316002)(8936002)(6512007)(7416002)(66476007)(6486002)(966005)(6506007)(66556008)(5660300002)(4326008)(2616005)(26005)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JGTWRjd2ZBd2VoK0xtR3R6dExYY0RkcUdVeHQrWU1DRmNFbWcwaFk2MEpP?=
 =?utf-8?B?RzU0OG4zUHJuWldRZU1pd0tiTTFvVVhCNWxwTWxTS2tNS0ZyS0ZDZ1VPb0Uw?=
 =?utf-8?B?NXdPSXdqMG9nRWp2MU5mMzdkWFdJYzJ5MDFPa1N1RHhWSFNLMTlMMHJseEVq?=
 =?utf-8?B?NlorUitteW52dkpENWRPZS9wVkp4Q0d0VU1xZ3lSWXp5aHVQL1F1ckJPUU45?=
 =?utf-8?B?TFRNMXo3cjRUVGxHV1N4Tit2UjR1SWpZM1c4VGsxYXJxdjFzekh6bkZJcXJ0?=
 =?utf-8?B?V1ZSVVFIOXdVUFJteU5oM0Z5Mk1IQy9HRVo1M1JtalI3WG00UnVhL0F3TWhp?=
 =?utf-8?B?alNlZUt0eGdTMWw3UCtqMFc5dnJtRG03VXU3WldaT2ROcERoNGJnMEVIdTdU?=
 =?utf-8?B?c2Y1MnRhTGN2b3ZHdStKSHJIbEJ5WWZVMTJ0L0NuYUxSdnNqeW1QcmcxWkNG?=
 =?utf-8?B?UW4zN09YNTN6SE50c2JhSE80cEltRGpiSlYzTnYzL04ybzF1Zko0TGY3Vjd2?=
 =?utf-8?B?RmVJYWtMN1FZSDM4NWhRVU1DU0Y3RVhGYWxlb29wQURFUUdUU0RSOC9ZcGZC?=
 =?utf-8?B?L1ZQbnVHY2RTdmhkUEtNL1BVV1hHb2FNTk10Nll3ZGx6ZjZrWDV3UVRpQ1V1?=
 =?utf-8?B?Y2lEVVR0MDVoT3d2alpkMHNGMlVYQ2h2VVNTeXUyT0VuTS8vcWtGdXlPK3NC?=
 =?utf-8?B?VzZ5OFZtZkZZMnQxaG1hTXFPZ3VMVllCQ2xBblh3bGpsTWh4MHZUalZKRzcv?=
 =?utf-8?B?OU1BM3UzbGFqTzlZL2ZYcEFFdHlEVmtVZEF5STZFc0hPdzlrL0ZOSzhzN1po?=
 =?utf-8?B?WURFMFJieXArUnNWSXVHUWVDS1NSaDBZT0RXNHkzL0VSTlBmbkN2SmZwelZN?=
 =?utf-8?B?OXlhYnA0dHhYL0xaN3NBRkQwckMwU1VnWmxVZE9yd1dIa05mcnRRNnNUUnNn?=
 =?utf-8?B?TWYxV1YxVEhGOEJyQ0V2UnpkU1A0Y3dINWowM0RXUnhMTHp4a3FCM1JBdk80?=
 =?utf-8?B?MTVRMkFMU2tyTmZlZis4NTM2L1M0eDRYakdZeTRYS3pXQ1RaLzFiK0VzYXBk?=
 =?utf-8?B?YWMrTHNIeVN6ejQ0WklWQUdQL214ejdiUWlJZUpLQnlFanE0KytRZUg3dG1M?=
 =?utf-8?B?YndOMXNYL2dYRENCdjhaYmZyNzhyV2FVck9ySmFkUHlTc3U5TktRaVgrYmNo?=
 =?utf-8?B?OTVQYUNva3kxKytxSUovTXo4eHVyd2NMODEwajdzYkpEM0wyM092MmJQRUtM?=
 =?utf-8?B?aGd4dWhFaCtWMWxlVnFKRU1yNnhjUjNqcitKaUZXaWc0L3U4SUlHejlVcUxD?=
 =?utf-8?B?bEpkay82TUc3NEJ4RXV6MGRxSGpzYy85VVh3ZEFVTXA4Tk1Gd2FRZkY5RWN2?=
 =?utf-8?B?cDh2MW5waW55azhtejRmNHBUczUvQlZRZU14VXNPVTlQSXZVUVo1eUs3TWRH?=
 =?utf-8?B?QlhUMm1NTUJjWEhqUHVvVWZmQWhMNUpwT2k4cFZEL2h2U05KWTcrYXdDeFZi?=
 =?utf-8?B?OE5OK3lGTVN3R0xEbXN1RHRzck8xRXRXck9POUhQV0JRd1BWTU04Z2M0eWFh?=
 =?utf-8?B?ZjVNbjMxRWFWN1NPYThtTEltTXUvcVgyMkZDN0Q2cHA4L0toRnpkclZ4NUNw?=
 =?utf-8?B?WElYbGVlVkhTYXJKZnVKNXhqY1plWDJ1NXBCM1VRdXBZRUtyWThsMjdzaHdZ?=
 =?utf-8?B?NTQ0MVhDNGxYMG5Ec0Z3dDl2ejJPcExDdDhNWEFNc2hVOVQwMm43OXg3elVZ?=
 =?utf-8?B?WjQyNHNNanR1cytTNXJNdE9NUDVlYnhib2hUOEJwQXdWa2toWnF0Ulhub3Bv?=
 =?utf-8?B?dzhtQjRlUndnaStCZWROYnJBUnQ5K0RuQnFyUkpBSW8rSWZCb3E1ZVcyUWFn?=
 =?utf-8?B?djB2dUU2dWk1aS9ET1djTHNsd3lzUHhFRnNndVUrSkV2Zm5GeDM2MU1oWUky?=
 =?utf-8?B?MVM1S09HUmlkQkpkT0hOMW9lNlZJR3BIT3RhS0FWQzJlc3VjbnR3aUoyVVNr?=
 =?utf-8?B?eEk5VUU2dzdMSG96ZGdtVzJkbkQ1R3FLY0lST1hoUlZvWHFHaFVhMXJGSkJx?=
 =?utf-8?B?SFpDUDVJZ1RkcXZTbU5jdzBSOEhiWUxLZURYWlB4T2Y4YWRjbkdhM1hQZkU5?=
 =?utf-8?B?YnFZN28wb1JZVVczcFVWaHJHOHIyaUNMek8yQndWWjZjeGN0anNYV21mRFdm?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rUnGMfnydNwbQM+xYCeskRkrp6NSy1HMpgsZIXjBvXsBA3dw4OWjH9bj7DQsyknwMwB3yCBcE28gjX0CXo0dHCWfxrObrZlCgw6G7Nh0h0NXqWXxlcZmnPQ/58JMcCOVJpweKA4SIbmOewdmCYf03FqKsHhGLldSs5ZLump9OMxgIguf9C9q+CP+8LRTNmnX6iUXUpC4C9a8QcTBu+vpHCAgtzGz1aeXub4wbu0VF2UoOCU4DIUYjhBwelFvlW/ehslk3ZyAcDLar8Qn8eoGYknIGOptcpIXctS9TuNej3do/URF+xAPbVJlNF2y/0AE6m6UixbtV5FcEvYuhmJVQp41CRsATTb77KNdY9sAm+R4hLImeqtr3HcOVdh7ihihm7uEzLMmM8nHzdTYEXWOcWgI/RKL2B5FA7F82MmaRKBqfQBBBULLrMkO8Iq8MvdTKD516+RNd1WPp/CgrTuShKWwyXhTxmlBJsHMw0fqlSnqEyk0NfyBMyAT3bkLJtvf+3UfQUJ45I55uMBWakTwkLAM3+n9mwVeGJ8vGnXVEUzDpBNBXku5yMUKLyVFapelNiRPz3/H5qglK5dJHjrUbb0KK11wR8ISavwolpXYAss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fc6de1-f481-4b22-e8b3-08dc17724a2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:38:02.0701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48sX3INT+G2/IPdoNN1XMx6FZqf5uNjNT+NTJtqqrBSIs5Fjcm2doNYmk5G5bpQGkGVp9UoVKW+YH/wERu5gRzMu9QFq7nGLQ4laELrAD5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_09,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170114
X-Proofpoint-ORIG-GUID: ClS3BYUmVFJhnvbMKFE0w-DPba0DHIkN
X-Proofpoint-GUID: ClS3BYUmVFJhnvbMKFE0w-DPba0DHIkN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 15/01/2024 10:13, Zhenzhong Duan wrote:
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9bfddc1360..cbd035f148 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      VFIOContainerBase *bcontainer;
>      VFIOIOMMUFDContainer *container;
>      VFIOAddressSpace *space;
> +    IOMMUFDDevice *idev = &vbasedev->idev;
>      struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>      int ret, devfd;
>      uint32_t ioas_id;
> @@ -428,6 +429,7 @@ found_container:
>      QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>      QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>  
> +    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid);
>      trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                     vbasedev->num_regions, vbasedev->flags);
>      return 0;

In the dirty tracking series, I'll need to fetch out_capabilities from device
and do a bunch of stuff that is used when allocating hwpt to ask for dirty
tracking. And this means having iommufd_device_init() be called before we call
iommufd_cdev_attach_container().

Here's what it looks based on an earlier version of your patch:

https://github.com/jpemartins/qemu/commit/433f97a05e0cdd8e3b8563aa20e4f22d107219b5

I can move the call earlier in my series, unless there's something specifically
when you call it here?

	Joao

