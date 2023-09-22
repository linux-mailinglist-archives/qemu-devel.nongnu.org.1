Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D87AACD3
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 10:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjbeo-00073Y-VI; Fri, 22 Sep 2023 04:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qjbem-000735-1Q
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:37:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qjbej-0000Pc-Bz
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:36:59 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38M7CCLZ018727; Fri, 22 Sep 2023 08:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ewG5P4noVB0b1K6oGQGhuqvdqSqBk1gsStIuynvhKfs=;
 b=RxB8nGvnEoBHZNlcJ73g4zkGENhDT9bMq+eX7Gzz+q9nwNqcseMimRVD8zCVj4rDgN9V
 yU6rMST5IRa9hrlvrei6392jdeyy0tjZdO/T7LVJ5iJtp7CMZe0Dyd0ZBScfnQr2B9y6
 OmwnwVZeFN1By1/QkF0Yhp+ErXht1c7Fyz7mV7qBrZP3QU5DsZ7KNC9qPhX/727O7UYb
 CHmY8q7zxSpfpYJpF7RCXhUEVpXBtbolzNDRmbbZ+pJ8AnfKJuHSgSiJAtLzbQDyjTH9
 6VuknZewk5TWIwqOnKYH3A2GtqNqp8Z7MdKdTU0qKk3X2fYvCkBLv/aKHLtpWe4NHQWS gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt01bxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 08:36:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38M7w9Wb029859; Fri, 22 Sep 2023 08:36:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8uhcf28n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 08:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNldKlyRfWDwmsWDOwou0SI+dREjpwP+6N0o9o0V52VkXil6eJTsdp9EoT6rPBIv3QQKyF1Z0Wfh/PtqlTZPtPIdaEiB2WhCFbY3gNAmEu4Gk/BXIQG4+gng0UHVLZS/hafv52bZkPPGEAWMxwxD3fJDCmx2nw6ty27qw9azG4S/HFG85VcBABvqK6i9KeUF8R8Xlw7nlhysmUl7Pm1It7w03V/JRxNnbO6NDomxV5Xj/QSLnjhgJx3sgp2Bmxuhdw1XSd98/lRq0lkEaa08h9sl5mTVrKROMQmgQMrxkd2X6A4vY3PQn2QEH5KftsWWy+HGxIvWRkfwLLmkNAwvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewG5P4noVB0b1K6oGQGhuqvdqSqBk1gsStIuynvhKfs=;
 b=oPM332/2xYV9z2Ff29eUaeOGmIbeqwg718BduzSUNoJNLdOPl1tU0E0dndEgMy/aynmuoB+QZHS52l4CZtrow50nHHbOewGamG60hCjV9sQdm6HneAW9JFTMmivO2GHDwJnHT5wwlpfBbKPl0ph6H+8q54DAaFXWEIySVqM6NeJEcMbIIgLkfZE3DvXIKsaRYo8neZLTAey2PtRLXq6cZPzuHPQm3OTflXh+K2yek1hMEHKP8x6H6aARlrwIP3LBw7xVDQJwgE9aMHy6WDxLX/fNSyxFHNMWlEkGbXug8DkpOeMRq4OtaI45lBoPyRBm8NXJRvnrRUp6wSa6I2VvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewG5P4noVB0b1K6oGQGhuqvdqSqBk1gsStIuynvhKfs=;
 b=OVbwGgUUOeZxGQuJ9M1jeLaRYhHxp90gyBYBT+wq7wYY8gRU2YpzNdLr4+FybZR731ZZlCgSthSmoXN9CQwU2pEnHSrF1sCUQPliLgDXRZJAdfm2+iVR2IRc02BaT7NoH4NydjyU7uLRlcrdpJZTPSOrKlJKKBkCo6+ay+gaNK8=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by LV8PR10MB7992.namprd10.prod.outlook.com (2603:10b6:408:1fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 08:36:46 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 08:36:46 +0000
Message-ID: <bd6f1942-4f6e-a353-8929-77fdc30bf06e@oracle.com>
Date: Fri, 22 Sep 2023 10:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: William Roche <william.roche@oracle.com>
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, babu.moger@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
 <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
 <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
 <39a471b1-9ef6-47e9-97a8-b315f63b4917@amd.com>
Content-Language: en-US, fr
In-Reply-To: <39a471b1-9ef6-47e9-97a8-b315f63b4917@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0219.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::13) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|LV8PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: f100992f-089d-4ad2-b4a9-08dbbb470e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2CQq/YFVB2GRjd7xjKFCty88PIo7FAy1V3Dod/GEq8l7UErG1N8o9KmFHQLxULq66VG5cJTLd18ITjm/sVy5huumyxqLwbJYCbG4odwFyJvzzyXQUZ7b2+N2z10wxQbfJwvUXNlY/Nsc0atlHW6mEszRuh6mL54C2jgPQpOV1e3iic3SpMU5Ul4upeMVON1kH4UvC58n8ZH9rrztyOUuDtI3O9yguzacSSKJKfkYsi6r+V0HnahYj0MM+YQtJDAPUxQS7ngZtQtIGY3zlLne2HK8aCA9YGg3YtYRq5aTaZfmSYRF7z/9hF9hQnndwC6Cth0eQOi0K17CWkR5dl0AgWvkNMyOob8rZnZ9hnI//pVnSFfR6w3JkJ4DsmYuSxSvJdrkTCrOwU2eiZehk0hZ6FjsKRxKIcLFulC//AZV/z7Y4tMcEwLfdFCoEq9mAgxdV+8I5hLXv5ajxKxXUhzLoBh/x30US9LDtbTTHJxX/HMU4SjD16JQ15rGgq9M5byfScqqj/rjwBX1nkQkQekMpGL6ZgKlSpHPD8bQRtWom/5jHi6FzcmEwmglFdXT59tPljXl4nlMsTra1D4HnZlHiQ5Vo4gO6CE+wKsAhHkOkA/jAlmRrqS5vBIpb9YjE2l2WISywBEd8tzpf70G9cplw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199024)(186009)(1800799009)(31686004)(66899024)(6486002)(6666004)(53546011)(6506007)(2906002)(36756003)(38100700002)(86362001)(31696002)(26005)(2616005)(6512007)(478600001)(8676002)(83380400001)(4326008)(66556008)(8936002)(5660300002)(110136005)(44832011)(66946007)(41300700001)(66476007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09rSjJtZTllSDVjckNHY3UrWldKMmU5WVhockgrbGNFdm8zMnVUOGoxZmc4?=
 =?utf-8?B?U01RU2piMGRIa3JrNnFxT2tWN3p6MzZ4QUxDRzRPWVBGekV0bm1Ud0dZZWxT?=
 =?utf-8?B?N1kwM0FVVktteXVvVHlmdWVPdkRvT25LN0MwNm5iVUlLR0N0VGVSdjlBODVH?=
 =?utf-8?B?V0krK3NLcVJrcFVQa0xwb1RNN1RjOUdnRlN1UjNPdjVPR0VsU2tIS2ZYRmg0?=
 =?utf-8?B?eURhaUE0dkhEdFhaZVE2SE5qUXVRek92VVRpV3oyZjU4WUZNbWJZY3Q2c3cy?=
 =?utf-8?B?U2FNR2lkT2ZwdVMxZU54Skc4ZDhjb1pSV01rR2xsVjJEdXduaURyMWtyS2NS?=
 =?utf-8?B?bVpRaEFxVFFLSktvNjZxL2QzT1JGT1hsVkpJUnlWbkU1V05DUkVrWjRKOXZi?=
 =?utf-8?B?dlh2VjdtZjJmN3NVTjU4ck13ZXhVUlQ3R3VZUThZU0ZZcDBLcU1nYzJQalJ6?=
 =?utf-8?B?WUNtSCtJMFBnTzNOekd3RDRkaGxTMjlvV1cwakVySGlIUHFwcHFhN0dMdC9w?=
 =?utf-8?B?T1ZML1RlM25PZjd5SXhnQjJEMnVWeWlwbWVDeEh6RUFHUXNBRnhXeEVyS3VB?=
 =?utf-8?B?em1WUmFZM2RQZEQ2YVUxSUpud2U5TWh3L2FwUTlJdnU3Nmw1aHRuS1BiOEFK?=
 =?utf-8?B?Q25iNUFmcjc1QzE1ZDd4b3dlbHg2UVprS2hsTkF3N0JSSmc2T3QzZE5PT0Uy?=
 =?utf-8?B?RzJWN1NVMmovRFVkZTJhYkY0ckRKbGdhaUR5RXNrLzFkZHlsWXJxcmNMN1A5?=
 =?utf-8?B?V2hiTTNLMmoyWnFsV2NPZ0NpSkdZZURySldsSnFYREFWZ2VtUkh2MGthSU5s?=
 =?utf-8?B?VzQzaFBxdzFNY0tFSk5CWWIvWndLSFlML0VWZWNhbHltNXZnUng5MTloVjRJ?=
 =?utf-8?B?TE1RZVV5RDZJVUpvbHNiZE9SZm16Mk16THlBUUJWOWhxNXZsdmUxS0RsMStm?=
 =?utf-8?B?cGxyc3VYUE9Jc0twMFpQOTdwYStKRmJaT2FjbE1iVnNIK1dSY1ArMkFUc25i?=
 =?utf-8?B?T096YTdWSEJ3OXliNlRkbjM4ZndnUnowVTY1RW1iRDF2Y3h5VXNSSnNtU0xk?=
 =?utf-8?B?aEFSZWN0N1hiYzlpdHNoYkx5NE1yVXVRWTNaVkQ0VVBuTjZsbWRqbmk0YnlU?=
 =?utf-8?B?cWVaZ3pKMVlkbEc1WittTDdmNnhIS3B0TW8rZ1BzTlFncTdRNForSDFkSlFH?=
 =?utf-8?B?bUQ4RmN1dEVDbFprVE5lMm1xYVVod0RDNUFENTlVT25tMHRnQ0pVaGYrbEJy?=
 =?utf-8?B?dEJRVzI3eWUxQjRtcmxhWGlha2dzaEkyYmlPYzZyWW1mYlJEWWg5dXovV1lR?=
 =?utf-8?B?Mk1zc2ttbWxWRWtURFdEaEZyakljUXJvR0I1VGdkaWZtQTN1TzZqeVdGNEtJ?=
 =?utf-8?B?dXdOd3h4YklsRGZjUnpBemtBSndLN2grTUcyODJPWFFvN1NaRitpS0JuZFNO?=
 =?utf-8?B?Rm5GRnY1cEZnU0RsN0syTnZxaDFqbVNTb3RnU1FpeXRKUlgyclhSWXB5Tkhp?=
 =?utf-8?B?NzlJNVZKR2FVVlNXTWplczBsTE1BQlJwQ3d6N0IzQnFrWWNPeStmeEp5QXZ0?=
 =?utf-8?B?UWhVUTlIMkxNTEpxRXFiWVdLS2tEQWpiN3JJcCsyZ2Y1THYvaW9TZ1k0WU5K?=
 =?utf-8?B?QXo2eUVzSGdJM0RXc2NTOXBNVk5WcGprdnFQNWJlTm5HYWd2YlNQQ3BydkdW?=
 =?utf-8?B?QVJESFJ4RllpMThJUmpYaTBHdVU5MUhGT3hHNEQvMjlRYWZWMkcwR2NFMEtL?=
 =?utf-8?B?eEVhOXRtN1R3TTI0ckthbFZsTndUYnFBNzZUQ00xZVFaTEZnNDVWamtsQ0FW?=
 =?utf-8?B?bG1xdiswb3IrOWsxVEU2bTFoMC9wekpJQ1R6bmxkNFl2MkRFNXRIdFgvSmxx?=
 =?utf-8?B?LzBLOVNrdXV1enFiTXRkNG1oeGRpVWtaazhNMzRaTGJ6S0phY2dkVVdUdDdP?=
 =?utf-8?B?T1ljYU9PN3QvaGY4eXEvN0dGMXJDblc0VFJiTjg5QW9oVFdJSGtTQ1ZIb2Q1?=
 =?utf-8?B?amE4cWw5QVNiRDN5aHAyaGlzY1V4eGpRMG5aS0ZsTTZVUUlDUStFUHQ3dEdp?=
 =?utf-8?B?TUlvRUEvVzBFTGpXYjkxQWtoenZMb1c1WXcxWCswUlB2eDlzR2tucUJ2OXZJ?=
 =?utf-8?B?WjNtSzhtOThzdzdNQTlxMUxuTnk5eWdtWUxWdkVmTDkwc0swYy9hdk5wa0N2?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jMhjK+hhkEpGxwpv9C3Ju1Ci5yXs2IQCjZ4ULIO0QL1E5N8ZY/c3xHBkTvVifuZODA2McfRhyL28HGXL4XHW8MqDwyFT4JMMdxLvkCCnK87STtB34kYeXYcDUta7u/ulodJYgrtSLb4mrG4HFRFQX+m6cc7dnV0EI02nZGKCt6X57T6RU3EkOXH51o8PkzUNvG7Qt+6a/k0yS4yNbXMMazYTouTzXZ2mxROzJg4v1M29rU9Z3K/eut6faFZYMz0mvyLvNR0tHZkhSEWNlGluk+pSBEreRCu2ij8E+fI6CLxNS7V+1kLBFn9RTAmlnhzRnOpYTNbyYTgGPT2ydqfiRGaN3bSPhjmbY8F6NnQIt6BXf17Y8MT3hwmaIJc1UD1vA9zGwyW9PvgAsr9h3O1Rm+8qfoWZGvaMZ+hhha0MXxvau/rR0JtjpuHR76+YS9nh90TKslVwH8LPSFcZwqGheRa/IfJkawaeWMJ+/HylzbgT+X9eYQZHxJfQNcJw5H0RTcwAKNfDb4giHiFuFaJW2HWCtfRtsdd/5VXhOS2YCzo5Fa261zuMrkaZo1r4E8uARWBLEuK5FORN/lHAcvSoNEOPo3cuHNk8CkI/hFO5bl17Hf2bU5ZUGaeQiCgczFooKprhse62MfSis35BSzYNx6oXFFDky+C29retIqWbIuy9YhOPaXd64NFzttnXR00jLvPA7+lujMBB8RaN4P+wpss7dOvbhTZtQZZiqk4dR6MK7PUk5Sbw4KW6pNtghrfDmpSrP2wbU6gN4wFT9X4wGCmq0Wb0YdyZvHCGAhV7sA7TM3BuYCYa27hnDyOfB+EWVtthxmKRGyUV9l+tybFk2mkvmdfapV4DRF7NHjPrkEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f100992f-089d-4ad2-b4a9-08dbbb470e8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 08:36:46.5401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUdA9F/O1Cjr+cUV1MBgw8eSxGPOtGwRLyZmT8ALZmZ0VK0JFLLVvg5myL2Sy3b0Alz+2BtC2lEA9wb90fHZti0h9rq+cO+LbL1avjrotTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220070
X-Proofpoint-GUID: AdqPnMfYH-SHH112JdOObHPrQfhGaISk
X-Proofpoint-ORIG-GUID: AdqPnMfYH-SHH112JdOObHPrQfhGaISk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/21/23 19:41, Yazen Ghannam wrote:
> On 9/20/23 7:13 AM, Joao Martins wrote:
>> On 18/09/2023 23:00, William Roche wrote:
>>> [...]
>>> So it looks like the mechanism works fine... unless the VM has migrated
>>> between the SRAO error and the first time it really touches the poisoned
>>> page to get an SRAR error !  In this case, its new address space
>>> (created on the migration destination) will have a zero-page where we
>>> had a poisoned page, and the AMD VM Kernel (that never dealt with the
>>> SRAO) doesn't know about the poisoned page and will access the page
>>> finding only zeros...  We have a memory corruption !
> 
> I don't understand this. Why would the page be zero? Even so, why would
> that affect poison?

The migration of a VM moves the memory content from a source platform to
a destination. This is mainly the qemu processes reading the data and
replicating it on the destination. The source qemu where a memory page
is poisoned is(will be[*]) able to skip the poisoned pages it knows
about to indicate to the destination machine to populate the associated
page(s) with zeros as there is no "poison destination page" mechanism in
place for this migration transfer.

> 
> Also, during page migration, does the data flow through the CPU core?
> Sorry for the basic question. I haven't done a lot with virtualization.

Yes, in most cases (with the exception of RDMA) the data flow through
the CPU cores because the migration verifies if the area to transfer has
some empty pages.

> 
> Please note that current AMD systems use an internal poison marker on
> memory. This cannot be cleared through normal memory operations. The
> only exception, I think, is to use the CLZERO instruction. This will
> completely wipe a cacheline including metadata like poison, etc.
> 
> So the hardware should not (by design) loose track of poisoned data.

This would be better, but virtualization migration currently looses
track of this.
Which is not a problem for VMs where the kernel took note of the poison
and keeps track of it. Because this kernel will handle the poison
locations it knows about, signaling when these poisoned locations are
touched.

> 
>>>
>>> It is a very rare window, but in order to fix it the most reasonable
>>> course of action would be to make the AMD emulation deal with SRAO
>>> errors, instead of ignoring them.
>>>
>>> Do you agree with my analysis ?
>>
>> Under the case that SRAO aren't handled well in the kernel today[*] for AMD, we
>> could always add a migration blocker when we hit AO sigbus, in case ignoring
>> is our only option. But this would be less than ideal to propagating the
>> SRAO into the guest.
>>
>> [*] Meaning knowing that handling the SRAO would generate a crash in the guest
>>
>> Perhaps as an improvement, perhaps allow qemu to choose to propagate should this
>> limitation be lifted via a new -action value and allow it to ignore/propagate or
>> not e.g.
>>
>>   -action mce=none # default on Intel to propagate all MCE events to the guest
>>   -action mce=ignore-optional # Ignore SRAO

Yes we may need to create something like that, but missing SRAO has
technical consequences too.

>>
>> I suppose the second is also useful for ARM64 considering they currently ignore
>> SRAO events too.
>>
>>> Would an AMD platform generate SRAO signal to a process
>>> (SIGBUS/BUS_MCEERR_AO) in case of a real hardware error ?
>>>
>> This would be useful to confirm.
>>
> 
> There is no SRAO signal on AMD. The closest equivalent may be a
> "Deferred" error interrupt. This is an x86 APIC LVT interrupt, and it's
> sent when a deferred (uncorrectable non-urgent) error is detected by a
> memory controller.
> 
> In this case, the CPU will get the interrupt and log the error (in the
> host).
> 
> An enhancement will be to take the MCA error information collected
> during the interrupt and extract useful data. For example, we'll need to
> translate the reported address to a system physical address that can be
> mapped to a page.

This would be great, as it would mean that a kernel running in a VM can
get notified too.

> 
> Once we have the page, then we can decide how we want to signal the
> process(es). We could get a deferred/AO error in the host, and signal the
> guest with an AR. So the guest handling could be the same in both cases. >
> Would this be okay? Or is it important that the guest can distinguish
> between the A0/AR cases?


SIGBUS/BUS_MCEERR_AO and BUS_MCEERR_AR are not interchangeable, it is
important to distinguish them.
AO is an asynchronous signal that is only generated when the process
asked for it -- indicating that an error has been detected in its
address space but hasn't been touched yet.
Most of the processes don't care about that (and don't get notified),
they just continue to run, if the poisoned area is not touched, great.
Otherwise a BUS_MCEERR_AR signal is generated when the area is touched,
indicating that the execution thread can't access the location.


> IOW, will guests have their own policies on
> when to take action? Or is it more about allowing the guest to handle
> the error less urgently?

Yes to both questions. Any process can indicate if it is interested to
be "early killed on MCE" or not. See proc(5) man page about
/proc/sys/vm/memory_failure_early_kill, and prctl(2) about
PR_MCE_KILL/PR_MCE_KILL_GET. Such a process could take actions before
it's too late and it would need the poisoned data.

Now if an AMD system doesn't warn a process when a Deferred errors
occurs, and only generates SIGBUS/BUS_MCEERR_AR errors when the poison
is touched, it means that its processes don't benefit from an "early
kill" and can't take actions to anticipate a synchronous error.

In such case, ignoring BUS_MCEERR_AO would just help qemu not to crash
in case of "fake/software/injected" signals. And the case of reading the
entire memory (like a migration) would need to be extra careful with a
more probable SIGBUS/BUS_MCEERR_AR signal, which makes the mechanism
more complicated, but would make more sense for AMD and ARM64 too.
(Note that there are still cases where a BUS_MCEERR_AO capable system
can miss an error that is revealed when reading the entire memory, in
this case we currently crash)


[*] See my patch proposal for:
  "Qemu crashes on VM migration after an handled memory error"

In other words, having the AMD kernel to generate SIGBUS/BUS_MCEERR_AO
signals and making AMD qemu able to relay them to the VM kernel would
make things better for AMD platforms ;)

HTH,
William.

