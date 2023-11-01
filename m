Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265447DE3EB
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 16:38:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyDHK-0001if-Ci; Wed, 01 Nov 2023 11:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qyDH3-0001ht-NY; Wed, 01 Nov 2023 11:36:53 -0400
Received: from mail-am6eur05on20730.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::730]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qyDH0-0004ce-7F; Wed, 01 Nov 2023 11:36:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jI+vyRaaLaAlP7BfXKHsDNyofXBfM4ivBK6UX9yU25niJK1wDJKBldwx1iA2yONOrb7CNl6KPcPakGVKPltz48iRwlVT/O6yoGxjMhLwk8lv68hGXg55IfvHqfXDL65YhXS3yXbet5v7i8NYlBKrP6oJtmgoUctEhhjidrjPuHAjfm9lv7oUW9WfrJrvKQ3AcCBEQIhbzX03JF66TOZdooCc04epbTzY5QTO5/8BlyuZUg2ihIZma2MPqa5wuiq/1QHi+9FopJx9AztiWO7nO0qV5LuIBd4RH4Falz/zjuO068oveULRxDLuq/N3u7XB3szUx0k7r9C/0ACfp15Olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMDWf2slGdv3Uc0nad79FcG1qLvKK77hbbhX//H5qko=;
 b=Gs4rzT8ZNZyu+JRM1wGVs9szdfhi3X5RvxtzhWEQEFD0KFzEE1vJUNU+bZl/4baObCR4e44HGrMDU7Xznoj+uBvQzf8JQEe6R/EtwF4AH3F3kfCvGh0eruATyXX+2Qa7VJbZ9MD61I0gdu8bJkyv5gBsbVC++7an+50Dw0/L4u7wbiWe0bGf/2olX/RrTbiV7Vetc+TCaIhoERPAfCrOdqrCZ7rMfNP6eZU11sAoc285Qwv2A7gjjUbf9IDtCA9wrX1i1eRfe5FK4PPDiZv75862YtiI0Qsqr8BZjpN7DzGB3i5wVe9kEntFWI1CXAQDIR90JnvuNF7lwLdsKM6I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMDWf2slGdv3Uc0nad79FcG1qLvKK77hbbhX//H5qko=;
 b=Z269K0ZPLWUi9rESSeNv+z9cAJ1rkRP2zGuuGW9fDSjDd/SLq6m9fJbQbd+boZLtseqCypNu60Oxa6lCMlXypBfow2nTDommXNiZaFOYMDGCW6EFy8+E/lAu+hvrtcFGuOa3UAUTnVb72wMdNf7DvaKX0BjymBj184rNuM1mCkjSBxqSABpJuqB81vgkWw6edrmdOC2zsJaH4X4+BOdTcfKJXNi169D9PjY1zV/OVQkDcxzrGdpXD7eWgLWe6RPn1LJkBbQ0Eoz83syEzemkYAP+ZmU4wHqrE3Gy3OOmZHrRIUsi+ckxHqcEsG268GbmH7gcrydc6LJm3uXZJZDjZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9873.eurprd08.prod.outlook.com
 (2603:10a6:10:421::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:36:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 15:36:45 +0000
Message-ID: <676efe0e-0c13-433b-9ca5-18c14920050d@virtuozzo.com>
Date: Wed, 1 Nov 2023 17:38:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
 <20230919165804.439110-2-andrey.drobyshev@virtuozzo.com>
 <b19cfb5c-658f-4bf2-a872-7eaa252d68b4@tls.msk.ru>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <b19cfb5c-658f-4bf2-a872-7eaa252d68b4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6a4ba3-c8c4-4e8b-1b40-08dbdaf05adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ySM/MVmZg2FvnieZUOlM0ilDkN2Wgq99t/lklNcnGYmbcjIz87HqI+y8zGwqH3bIq4+aXpDD1uAXGvNp1kPtGMxfgEmMyOPqnQ2I8elbYzv/FoN+doOB9W2PQqLJ/1OAyCsn1rRJGoL2f5emr93Dr3P97HwUJRUj7woVF0TNJq1er8Z+XZWF5qv+XPGW0cYzHI1U9hZ/GN7TlF6wmTdaTeApupLK+jgTpsxkwYcI8dv2HoWIIUWLbuYMQ4h/+ZdCMLgXg9aI8e9Kj+YC1dqB7QaszrVyOFebOLO5ww9bFpu1pITVFp1r50oqjANyf452OIa1wW7e1zs1hYbTingcLj9qVxTy66+rKl7HnF3XHA2E1cKCbKmvRsj9hXmt1u9lz8qgAfjLATltjXD3LbKWrgClrQ+S/w8Bcbk7/KckT8Dz4inms8vuFH2GZ+vGvl7ELyo6CTXqEzsoDR9dEsgiaFMZneNuHH7nE+tsLR1/lJRPuzMyoCzKl20Odg0o+A96jFqSCi62ovlQ5drnRMxQ+JZh4ozINrr7kg8x65SIxsHJNKlsvgLPRCxi5XD1xrqQIMArCrk+sOoxrbInBopbQCngBzv1rLH/aXiWm4a4dryInnWYBJhQKU3/i3daPdsLj3C02ZygL1/RCEkkHX6Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(8936002)(36756003)(44832011)(8676002)(4326008)(26005)(41300700001)(31686004)(5660300002)(478600001)(316002)(66946007)(6506007)(66556008)(66476007)(2906002)(31696002)(86362001)(2616005)(38100700002)(83380400001)(6512007)(53546011)(55236004)(6486002)(107886003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThLNis1Qkt3VXJtemZwV0ovT3Jyd1pnSmVyTkFKQU01TERjczkvajhBa3Nk?=
 =?utf-8?B?Mm1wMG1kYUdyRlVZUGc5T1dhelQ4SjZKN25KWFdsbmQra0VCZDd6OFpRZVRC?=
 =?utf-8?B?UzczNHROb2NQMi9jVUJVM2Y0L01LYUIzVWNMakx4RFVSQk9BNms3cEo2RlVB?=
 =?utf-8?B?MkZmLzVLTzQ5UzJBWStLZGpzUkplME5aY1Rab1ExMDBIZFZBSWE1dUlTNzJE?=
 =?utf-8?B?OVJDUndpbU05aEltdnFzczV4cUxOdk5ZeklRVzRKWXd1WUMvKzljbHZFeTM2?=
 =?utf-8?B?QS9FMTdJSzZyT2hnTXNNTlhhb0N6NEN1ZDJ4Vmg5VnBqQnVpV1ZvTERSaU9P?=
 =?utf-8?B?TUtqZjM5b2VROXZJOXpDV3JkaWR5d2JmY04rOXR5cTlrdmJFOU83Vk1TSHB1?=
 =?utf-8?B?WmJTY01sR3hwTHQzcWNmbWNLS1RHbm1Db2dSajdrdGNiOHRDc1dnaEhsSDJ3?=
 =?utf-8?B?ZGFZR3hsZXZGSTE0OEtDVlR1c2VNUlJteTllWjFoMWgydWQvTVlNRWlGV2M2?=
 =?utf-8?B?RDZMUTQ0NDRUYXVoNEdpMzd1QjdCSGx6VWFFSklaZldpcnpkemNCT2tlUG5X?=
 =?utf-8?B?RmNmZnFFNG1wM0xTU1lEU0hFTnN2cElrbFREaFJ0UWxVS1NYdytDRUoveWM0?=
 =?utf-8?B?bUNHeUYvL1YwOEVRN0U2emo4N2c1Zk00N3JoQ1F6WEp0VjNRQ3lmOGdSQ2RO?=
 =?utf-8?B?VWNjcXkrSTU1dm5sNkxRekN2NzRXbmdCdk5xVjlOUzIvdUFvNXhiMTR1NlpP?=
 =?utf-8?B?VjBVK1pqaXlHVjFMQUZhSDVEMlltTGU1bUFEbkRRc2w5U2p5b2Z1Z1QrQ0M4?=
 =?utf-8?B?RmUveDdXbkxKWlVMRXN2b1g4VzFYbGhUWjVKWTBGN3h1dlc0aHhBR2NJaE5J?=
 =?utf-8?B?QnRUVmJIQTZObkxzbmV6aG1qaWd3TE9JRjJ4Mjh4Z3VhYzNiVUFSQng1RTcz?=
 =?utf-8?B?aWdLcGs1OUs5NlpUY250a0xBNUVBNTl2SUltckZsOHVITDVSOE0xc3ZXS2xv?=
 =?utf-8?B?OXNWQ1NocE83VStWbVpCQ2RsTm1tK1U1Zm5PQnR6dkR1ckxPanR5R2RZbDFw?=
 =?utf-8?B?ZXNSNFNVa0tuVmNFN3BvcEt3QXd2cFR5ZDQ2bGs4dmk4dkZwQTRwdEdHR01L?=
 =?utf-8?B?V0NtTjVlTmhaRXg4SDlid1h6WEw0aEJxMEN5WTBNTGZJMjUrM2J6NlNwT1RS?=
 =?utf-8?B?N1AzQTBEN2Y3d3B6L2NmSmRqU0xlOUwzWVFYTzFaNHRjU3IxY2J4VG9zQzJv?=
 =?utf-8?B?cXhrVDcwdHhyZ1BkcEJQS2pHalBuUU9JS2txc0M4UnZaMzNzaGxyM0xjd054?=
 =?utf-8?B?eXBQTmZnRGhoeHZ5b1A5RmlJYU9iL0JPYVNrT2pFdjgreHNPN202b3Y3NE1U?=
 =?utf-8?B?ZWtvNzQ4bVAvSHA2NmZJUGw0bHBKZy9GT04xSWM3L0IzZ2FTays0dUZmd0d2?=
 =?utf-8?B?eHd6UnloZDFrbm92T1pNMDhJWFIvNHZVRmgxenFZMm1EQSs1L1R2WjJnL3dj?=
 =?utf-8?B?eTgwRUhncUVENEYyc0x6aVhEU1NyS2hUNWdOZWpiZFJQN3RIQXRsZndlMllD?=
 =?utf-8?B?N003dEZrSWdvRkN6ZXdHUUpSRXUvQ1pBbTlyQmxTR010Q2YvQlIrbWlLWkRY?=
 =?utf-8?B?RDJqbmZtQmdKR2xoaDZPZi9wTStlSnV1dHROaXdHNkQrc2F5L3V6UVlsMitn?=
 =?utf-8?B?eC9SSTZzUFJ4aWFoTmJPZjY1TGZMZG8zSUJsN0hCVGp1UVM3TVN5ekVHbkxK?=
 =?utf-8?B?ZDkyUmtCbUN6TnJzYno2WE51UHB2QWRWc0dzVXZsTmc1MUlDVGt4K3hVUUhR?=
 =?utf-8?B?UWYxcHpSSm1TbjBnM1MybGhSVWg1MmdzUmI5VHBJa1BYNWZPMWRDMUZLSXNO?=
 =?utf-8?B?WHUzQzB0Y084V1E2a2JmSkZncWI1NDdhRGh2QnVtYlVZbTYzTjZ2ZUU5Witi?=
 =?utf-8?B?MEx3bDB6VUlOT2UwTUdyaWVBWFF1KzVoeWxjS2RZUU56Z3dENHVaL1ZUcGRk?=
 =?utf-8?B?OEg4MVEvUnF1aHdkU3hNME5yeWpYTGJzeGE2S2MvWXM4eG5yY1I0Q1N4WXBz?=
 =?utf-8?B?blRtaE9NWXd3VERRdjUzVGgybERLUVJ1L0hBM29lamZ5VUUyczUveStqdGlQ?=
 =?utf-8?B?V0FzZVBFYmdnYTJlczFRc1AxTW5qS1l2VnBuQ0pZd2xqQ25Bc3JySWl0NXRH?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6a4ba3-c8c4-4e8b-1b40-08dbdaf05adb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:36:45.5748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnxWDq3CCyRA+XxsSgvHgHRprjUB9SbCsx8WV7KKfYqku4IHoyr4WcVlxqtULURVlD4wb6NAU7ilyFi9Yj/HSLzaIhZkcRcfGee62W6RUCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9873
Received-SPF: pass client-ip=2a01:111:f400:7e1b::730;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/1/23 11:50, Michael Tokarev wrote:
> 19.09.2023 19:57, Andrey Drobyshev via wrote:
>> In case when we're rebasing within one backing chain, and when target
>> image
>> is larger than old backing file, bdrv_is_allocated_above() ends up
>> setting
>> *pnum = 0.  As a result, target offset isn't getting incremented, and we
>> get stuck in an infinite for loop.  Let's detect this case and proceed
>> further down the loop body, as the offsets beyond the old backing size
>> need
>> to be explicitly zeroed.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Reviewed-by: Denis V. Lunev <den@openvz.org>
>> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> 
> Is this change not for -stable anymore?  First version of this patch has
> been
> Cc'd to stable, this one is not.
> 
> Thanks,
> 
> /mjt

Hi Michael,

Since this series is already merged in master, I'm not sure whether it's
necessary to forward this particular patch to qemu-stable, or it should
rather be cherry-picked to -stable by one of the block maintainers.

Kevin, maybe you can clarify?

Andrey

