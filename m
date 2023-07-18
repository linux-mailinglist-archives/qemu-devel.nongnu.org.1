Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C717579E2
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:56:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiMa-0003u3-Dr; Tue, 18 Jul 2023 06:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiMY-0003tr-1P; Tue, 18 Jul 2023 06:55:26 -0400
Received: from mail-dbaeur03on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::71d]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiMG-0004hS-CL; Tue, 18 Jul 2023 06:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWe4ejsVd7GNyM1FHKD/Wu8YaYIV3aZWZYt4UOkhJr9U5vcCmYqEeU65riashqr2FS5yWU2hjvHsEWl88PQ+3bqzk73LKGqvcC1P1undlBn07USCDscdbPkLIWpDeUIJ5ssKk0cZt7ophlgZJdsLdT0BXM3NpYbe+1XLd5X1+pgsHF/MRu3i5xvkIvge8cBOxOyee12o1hqWwn912ezEwmtH1AKIJiLco3dhxEOS6EQGe03+QdBiZ3fjkR5YGGtV0d3KnNHGkZFPeezGNd8V2Y6XFVr1IC5C+j+h6uUmBncymAKMWSUqkrF288dVabGgyF+1UKDvaORLGZoDgcoerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5UXDUtFXgjftJuTAg+OuAyXtldatJbJmVI9CUeUy9k=;
 b=RdSDSIiTRGs06GPX8VHx3qy8gVz1z6ZjYZj0GO7RPRtOHlPFO1RvLXBdILxuMxsATh4DsYBA0eON7mhKyitJgP3IEDwXNNYstGuY4ZzNOo6SUSRKMtbLHDDbZPiZUji/p9eBc0VHT661t8/oIb9ofp7GuIgkAwiDp+2L3EKFCytzO+nh5g3rvqiX45+0PoNB1eyYAbGv7YhmYr1R6QI+nGuJnJArJG7ymaKvibAgvK5BbUs+aYcdKFggikIIOCV6titMzMG7+lZesl1MlpR9nxYBwHB959U/0+TeN9P224/8lPQqmbZAy5Hf42R9CYjCSYC5zfIxS51runYrIyqbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5UXDUtFXgjftJuTAg+OuAyXtldatJbJmVI9CUeUy9k=;
 b=gREh8xRxoVoijrU+Hc3rHp0fE9wH4WJzOQ+gX4d9nN+Jl4WeTWqriMr2PtHziK4ZX7B2l2SvWxA+DCVGIq3u13WFuLHdXnmT3kRUgQ7gp9GxQJMN8pQugZHjVwA4C5XWzF2tP18gK/KE6jd/WjBKXzvPS/K/JvpltylfjCMal59iseczCxyVkvozoGGGkpRu8/6/aKDKiDoY7Z6X4hQzFpsuueiSqEooOV+ExxkLVKtevtxVfMjhUdb9dSEeB6VtCelvJdoa5QOk7qSJKe62H2YKuOPzhP5DH+fzUgozWRuu9pe8prPUY/2/6zzH5yyW3EGwq4J4UbOH8hKMFpCOhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DB9PR08MB6665.eurprd08.prod.outlook.com (2603:10a6:10:2ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 10:55:04 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:55:04 +0000
Message-ID: <38ffa0f3-03e7-b412-cc9a-5c86c4b9874a@virtuozzo.com>
Date: Tue, 18 Jul 2023 12:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/7] iotests/parallels: Add new tests and fix old
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
References: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0041.eurprd03.prod.outlook.com
 (2603:10a6:803:118::30) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DB9PR08MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f83c7e-76ac-4144-5bf9-08db877d7102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjhRnJrDlhCaP2R7dUkMFaVd8jJQzegXuxb2F507HQUfVVQz+t33vs0xT9vPas1SLguxi+DpCztgIbJaVOs07oSUOnp+jFyOrlMAzgYZ2WGaX1hxI/BCb1zz/FOEcLI5vKZmxk7pHvnKto6/VoBKi+2QwRcqOv1KFkk+Tl4ZJgVIwvVxCSmi8HV1kA9IPLdBSZ3Gz20WYjn3+yy+QKtZ6pwrF37RQItadS0UsRbo4pHDRN9g3z3+zPEjMpTOp3wSWF0quyMvMeaK6K5czD6ZTierkSpJsqkORXhMcHzWLjF/10CscGA7NH/lzVEyi5tJM/hpyi9A1DX4I/YFhwe1srvWEkpg6vBAk1JTsZtxfg3/bbJM8TCrzRx82wn/Ec8Q8kMKJjaksEaLjkuK2SHEHwVqjc2JWmGGzQ1dv/JdBQABCTXimnPyfRVJ3gsF3iPWbenVWJLKVar7nMPenchyQrhA1RDA/UJgSNfYxpBkpEx17dOB7uFBAcWs7A//sB2M+I3O8U8BDL+yhfdRxQ0qZaLchlc/4KA1wTYkVkqe3sKJLIthv6sUv/AsJ+DfeU7jNC2rP/Ohtq5o7lApfHSuO1uGQ2q/2uq9h3onN7rOYd0FDwqB7LEh9V/2yZwHjweQFwKwR4/+bDVtYR+Pb6KUCMJ/o2s3Yci17vPCDApbgahvTeT9DrM3jI7MLyjJmFGB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(451199021)(31686004)(83380400001)(478600001)(52116002)(186003)(2616005)(31696002)(6486002)(86362001)(6512007)(6506007)(53546011)(66946007)(38350700002)(38100700002)(66556008)(41300700001)(44832011)(2906002)(26005)(36756003)(8676002)(6916009)(5660300002)(4326008)(8936002)(66476007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09XVE1wVzMrMjdWM0hNM3BHQlNpMFRDQW9YUE9zRlZpUDIxZXhjOHFUMkhH?=
 =?utf-8?B?dld4V2M4RDhFYmYvRWFUWXBrS2VqZjErNnNnTm5PSFRFcGV3eDJuKzBicHBz?=
 =?utf-8?B?clpCS3Ntamxmb1JrdzI3S3pVbU5NQi9ENXNFWmRONzFGemI5dzhsZ0NZelJq?=
 =?utf-8?B?bWw0eVBBQWRERjNmaTI1NWR0bm4zd1J2NWRmUHdXdFk5Mi9hd3gzL09MNGNu?=
 =?utf-8?B?R1JtaG9qenZvSVBBWXVCRXBjQ21VMUdrYW4ybUd4MDVrNEJFeGNTdGE5cXVO?=
 =?utf-8?B?U21qQ1U4dFo4SW94NTQrblpaYS9VUjJ0N0J1Zlc0OUFPbm1ic3V2aTVONlJ2?=
 =?utf-8?B?WDd2SjFQK3FmbXlXNVZXYzYyRUllRUZnWXk0YU85Z3YrbldLWFpLNEFJcS8x?=
 =?utf-8?B?Rzl0UHVROVZ6MUIrK0JTclNoLzVBZXRiaXlSSGUrRWJRTUIyazBvNlpLZkl2?=
 =?utf-8?B?cVR5cE1UdGlPVmFnMk0zZFFuUnoxUXltUjFsbXpld0NUcWNQcndnVVJJbmtj?=
 =?utf-8?B?TDhnMjQxclNvMmFEc0FlNXZlQ1V1ZUs0LzdjWHNqRlYxdDljZkZyOGJIczN4?=
 =?utf-8?B?aWl6V3pNODhkWVh5dVdYT0VkaWptWXQ2K0krdmszQTlxODMvQlo3WUdNaWd4?=
 =?utf-8?B?R3NLMndyaDNvcm9nMjRENEIzMnkrS2ZIeEVud2YwdUkvUmg0QzFyL0plUWpN?=
 =?utf-8?B?dUt2MnlqU2VuSkNJMGdPcmZRbENISVlTVlhROEI1VURCMVJMR08zRnVycHdU?=
 =?utf-8?B?RTA0K2J1TzMxb3lNdGsrTkdKNkduVjV2ZmVKb09uTHJhYnhtbzNsSUY1aFF3?=
 =?utf-8?B?QmFHWENlbVRxU2ZpSkVQYVBjVGZVRWQySlNmUzVSUUV5VHMrbzdZVVpaTG5O?=
 =?utf-8?B?ZHVSOEJTMFBqTUMvZmdzUTZWTHdGYWN0cVZ3RzJuc1VnZHNOZ1ZUWks4TGhn?=
 =?utf-8?B?aGRiTm42dlhkSE1sNnIyN1dzNHBPSXpOY29DYXROUWliajEza2gvdW9SZWd2?=
 =?utf-8?B?ZkxjcS9EVS9CN0t2bVlmVitURWRySW1tVmdaQUhIYjJyNzBYeStjUEdwTjhT?=
 =?utf-8?B?aTc4WkJid2JDOVF6cEQ0WHlyWlN5NG1yWXE4a1NGR2lnMmY2b1hqZ29TcVMy?=
 =?utf-8?B?MERqTkkvbFVvd1NpZXNFdGZnM3JWdlAyOE1lNHhHRm8xWVhpeVVCRXUzemxs?=
 =?utf-8?B?aXlseUdSMkdkNmNMa3VHNEg0VUUxN3o0THhnUDdGWkRiYURsYW9vODFDdld3?=
 =?utf-8?B?bkx0ajlCVGJmcVdZN3BZcWZEMnNYeFFWWWJUMFRKSFpxRlAxNTMrSEI0RCtK?=
 =?utf-8?B?OTRrZjVhZGFYTkwwN1o4ZFN2a0s2YlNFYnJWQUV2Y0tSU0U1ODRlNlZOOCs5?=
 =?utf-8?B?c2htRHRKSTI5UFlJNDI0bEdvNFZqRy84bUEwZXFaZFNNVGc2VHk2MVdKRFo4?=
 =?utf-8?B?bTJXR0RVSnJlUkdKRzQwVWd6OUF5ZWErWWQ4Rmh4d241SXZtZmVJQ1dYVmFl?=
 =?utf-8?B?eWRWNkxYaGRRL2xsVkFKNE8vYTZzV05KRHE3cXlKbzZqUDBvb2dhK1ljTkVZ?=
 =?utf-8?B?b0VXOGFyVWJQZGd2cWh6SEpBZzg2OGFRa1dVOExyc2QwZnlmM05sSGF3WGkv?=
 =?utf-8?B?QzVwdnhPQm9WQXRvZUF6cFkyOTdOS0k0ckc1WlhUbVBBek9KY0Q2NXFmK24x?=
 =?utf-8?B?Q1JXSjhId2JZTHozVlp3czFrMzdWODZQVWNadkZBNE8wQUpZeU5YSEZCMXc1?=
 =?utf-8?B?bGcwTDJMVGJrc2xqRlZMY3NQUlpFSnNYc1R1Y29UQllNR05jMU9JdTBFK3Ew?=
 =?utf-8?B?TWdOa2ZlWjRQclpNRHo0WDF3SXdJOXVsWVNkOWdVdDlibVJERmdJMk5aTjh5?=
 =?utf-8?B?bmJNakJWQTU5U09pM0RkSEF0UWdmcEc4VU15SEhSQmJ3NVlOZ1VZSWZqNEkv?=
 =?utf-8?B?dVZza2R6RkEvUVJXOXplb2xNOFp0ZkdzdU0rOUR1SUswUEsxQVZ2Z0J3c0Zk?=
 =?utf-8?B?ODZRUXJmaUNhazMwYk1xZng4ZWdMV3VhRU1JcVhsL0pTcXhCTzZsOTJ1dzUr?=
 =?utf-8?B?VFhORjBST3V1U1gvMDJPem9WYmVxc05Paml0UTgzTDZ0UEdWenVIRk9OWk1U?=
 =?utf-8?B?cG1FeGlpYkYzUHpiY2JYUUZlL2pkWlZkYndNR0JwTFlia1BZcGNtbEgwNzRn?=
 =?utf-8?Q?Zn1AbtjrwDyU38cfewVxne4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f83c7e-76ac-4144-5bf9-08db877d7102
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:55:04.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70Njqg9Tc3ovL2fnG4DPZhp5rjkL/zow+ijDtmHbSMmAVmdQW7WOKxLMidjn05eNhGZfekXoRFSRvcqVeBJU9fh9A9GdpVUKX+gq5LrQZb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6665
Received-SPF: pass client-ip=2a01:111:f400:fe1a::71d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patchset also could be applied upon [PATCH v8 00/10] parallels: Add 
duplication check, repair at open, fix bugs.

On 7/1/23 12:11, Alexander Ivanov wrote:
> This patchset should be applied on top of [PATCH v7 0/8] parallels: Add
> duplication check, repair at open, fix bugs
>
> Add out-of-image, leak and BAT entries duplication checks tests.
>
> Old parallels images check test (131):  Refactor, fix cluster size and fix
> after repairing was added to parallels_open().
>
> v2:
> 5: Fix a typo.
> 7: Add a test for data_off check.
>
> Alexander Ivanov (7):
>    iotests: Add out-of-image check test for parallels format
>    iotests: Add leak check test for parallels format
>    iotests: Add test for BAT entries duplication check
>    iotests: Refactor tests of parallels images checks (131)
>    iotests: Fix cluster size in parallels images tests (131)
>    iotests: Fix test 131 after repair was added to parallels_open()
>    iotests: Add test for data_off check
>
>   tests/qemu-iotests/131                        |  36 +++--
>   tests/qemu-iotests/131.out                    |  59 +++----
>   tests/qemu-iotests/tests/parallels-checks     | 145 ++++++++++++++++++
>   tests/qemu-iotests/tests/parallels-checks.out |  75 +++++++++
>   4 files changed, 264 insertions(+), 51 deletions(-)
>   create mode 100755 tests/qemu-iotests/tests/parallels-checks
>   create mode 100644 tests/qemu-iotests/tests/parallels-checks.out
>

-- 
Best regards,
Alexander Ivanov


