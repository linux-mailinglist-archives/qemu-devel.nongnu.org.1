Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F777DD34
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWCiA-0004Yg-Hr; Wed, 16 Aug 2023 05:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qWChq-0004S6-3n; Wed, 16 Aug 2023 05:20:47 -0400
Received: from mail-db8eur05on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70d]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qWChn-0006gS-MJ; Wed, 16 Aug 2023 05:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGyo7AaVXvjH7lGHjNCMvxy/nWtDE5W2lJvsCAGj21JZlbGQDW9BfI0z9Zfj7TTooXSLSl2ooX9x13ukbJ4oJIOzqRnDEmTs97XRHQjmL/bOSIHZalhmAKLSB7lK8mQ4SAL6WXbF96tPi5IlUCuardD+ZQaMQf/Se8E7IyF5XdXbS1DlWEtOCq7uXwEt8cK9J08vgeVz0186GgoOLgqzzd08z4C3VtRifJfqtPhvXKck3Bnw4LcyamZx2BSOO2Zm6ay9SXAVTDohL73WF0D7goKy7aviJG6bN1/198l7U/dLtvDYUikwwB2Rkl8H5bAgHxtb9IqM/sEVshpmtEaVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J272m//Iil4RxvPiQjMOcVeylE0ZsJRcxWFhdMvchs=;
 b=HiE/jZ8ny/5EyFHYEEH3A78nu/H/UnCc3EVsNp6VAaM/PXGQWxg/imiNqVHh8tEQjNW4MR6lGrJM8SUo7ut2aWOkaxR0jEzylwLqciqy1lVq31we6xRTIT3x+c5UWg9de/2TlNeVl04oVSeZD5l7w9APjUCPGDQyOv5PUSdTS2ZP63D9G/53GGiWlzQ9fZTbaSTmDFGEEYoy/NKdinAKM0eIOdVatS9Y5ote6N6jBzMKojizsRvWAu4Ln/vgzrBXpnhh5gYJBV/HsSoda1IXSRG4sfCrBJVeLfM7iA0DCNx8d4/kNnlBTaKg/l2rb9x3KZrVTfObcrZVbHU0aN/Tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J272m//Iil4RxvPiQjMOcVeylE0ZsJRcxWFhdMvchs=;
 b=rRRq6LgZwQkmqwuxtJrzfSPh0J0gXZNM18zePzIoc2qXUAh/HTfq8Q9Fr5RuJpc246UTA4z/DLJfANBYwPNB4v0/g2KINxhbs7x95vCxfSML0YpFrQxdCx/x49WjreEH7k4QEKnpijS9pNHbs+W8cIK7ARmJG4aLtK/ZHhSBQb3X8CfS0Yxp5M9b6z4LprvodrLqRnoIiPvFRx1NYjoCEL+qbxHwDWgNClp+BLF2Di4XQJMbx7HycPbbTtiludBrlqy4/WrXm/NgE7Juqa2UTqrukKvvPj03jR6e3eJ1OCnAKFt9iXTjjv+Q+mgspU98oG9sMc+cqXTRTTNUpu8nzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by AM8PR08MB6465.eurprd08.prod.outlook.com (2603:10a6:20b:365::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 09:20:40 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 09:20:40 +0000
Message-ID: <bb1e3eca-4517-4ef1-8e34-8895285f503b@virtuozzo.com>
Date: Wed, 16 Aug 2023 12:22:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] qemu-img: map: implement support for compressed
 clusters
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <8c0bc7da-175d-a367-3d7d-32f570953e7c@virtuozzo.com>
 <b847bd77-d23d-c0e4-dbb5-e69dba0d2db8@virtuozzo.com>
In-Reply-To: <b847bd77-d23d-c0e4-dbb5-e69dba0d2db8@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|AM8PR08MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: ef28e2ea-32c6-4ce6-0461-08db9e3a0f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRGxsdvDSR7skVdYJ2RMjUZBjAiKnzEv/sQCyitmnoxoCATVdLV2GOYMRRp5cOLd6FWWtj8vsqEXm6SboaBJ8bFNMgN401tNl9Niu9sfQrrll98XChmBaZ2x61EyUiWHaED98nv1UofK7wgJ42kFUW1GttZQDe/euvbZVrF9oYh6T2MxJIfiBj4SGcyZVunKtjuBpIQncb0Ahc9eo8zLGeIvzAVa7CAztvMj8Z4s5zjpmFgc2Je/yMQUoXKpA1N2iKIUp0nrSWEJPdI06ze9L0zaz381cUiv32L9qEaf5LFnwBkukzNdgeXUVk7Vgc9NGJAuicQZnV+2RLvyQ0b9tZl7u/ql/fCtoDnCtHKC8dU2Bj6ckE/q+GZ3Ty7DxZEApt5SPK9kqWSPdYej/nJcB2e8pa6xPZOhKTztqRI6doh/gBYdF/2dN0M9JsBIQISRwHU62UaMYhPT2uxWQA2PiQwq11eXCHbpfZ/tzitAZFH9lcNuMjr75HDfnJCfvTuutJfsTLAMUbnc6krxJ049M/kVNcT9bjlXBoE2QjgOmEWkSWDjdLYODad5fMvpZnOSR2+WFNtmh6pffemL+IEM/4xUM5KcqHxtO70Vaaj7zK008SNENBxaCG7f8KhI+284ZXX1w/rwIKrQvdbUnyzgwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39850400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(31696002)(36756003)(2616005)(6486002)(6506007)(107886003)(6512007)(53546011)(26005)(966005)(5660300002)(44832011)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNsYWtGelFHMkwzZ0FSU1lHUEhxWi9CNUZrMW5wa25Yc2VMK3VtWTNUZ3dH?=
 =?utf-8?B?anUzeDlXVnZueTdtU3Jxd3h5UXZUWk5YU2VEcGVhR2loSVZxdHpLdU83am1M?=
 =?utf-8?B?V0Q3cEE5U3pnQmY3UEM2V0d1K1NxR1ZRWURPR3o2OFdvUGJ5ckk5VE9kdERK?=
 =?utf-8?B?ZVNJWk40K1FmQUU4RGZzVGE5UkZ5bUNoSTdJci9HL1ZuY2lyanNVczMvaVVG?=
 =?utf-8?B?SGJtM0VCbFZBNFZhQ2lUcUhoMDIxWXUwUmZILy9qVWk2d3p0NXdrMWNMbjlQ?=
 =?utf-8?B?a3pGTldKdHFIZmNFclZnZ3ljc3oyUmZ3alQ3NGVmUmVBKytTdGRSMWxBNWli?=
 =?utf-8?B?aG9MbG5hQ3Bzbjh1MUR2NitpT0Y5MDBxN3JpK0orUlluT0hvODZieC9kZlhz?=
 =?utf-8?B?TkVYeXNmZzZzWTJocjJVckVxOVRDVXBCL3hNUG9SL2g4c2N0MTZTVEVmNlZn?=
 =?utf-8?B?dWV4MG0xdlE0V2ZBb3M5TlVTVmliVWQwYzJKZVhaZTljTlQ2dHhHN2IwNmNB?=
 =?utf-8?B?OUJnbHEyMFc0UFF1b1JlUENyM1dkZzRpT2w2azVtUmZMUXVtU3FabTB2MFkr?=
 =?utf-8?B?aXY3NlJaUS9PLzQzWEN1Z3gzMk9zQWtEd1Y3MmF1V3c0dnBaejhya285SEZv?=
 =?utf-8?B?aTNJblZJVk5tVjB3OFZtM3ZhQ2FkTVJNWkNYVTBzZjRxWnFPVUtZL2hXVUZr?=
 =?utf-8?B?ZkVxenZoRkowWmlGUXQzSll6TWJZU1IrQ1p1YWRKNkROVkkreXBBSFJLeVk5?=
 =?utf-8?B?c1piK2NYUHF4WVRsNTlKVVlMV2diZHp6SWZmbHYwYVdYay9mZkh2cFZRR0E4?=
 =?utf-8?B?WDhkU0s5dEMxUUVqVVljOXNVZFZLcDgzR2xVclpYVFpIc0FNT3NLbkpKUVp1?=
 =?utf-8?B?UE83VnlhOW41OXBoVW84OTRTSm9BSUVQVVgxL3RTT05pcnV0WlhjMk91OXZx?=
 =?utf-8?B?a081a1lmSXlSWUFEY01Xa1pONjFqMnNtKzFkZk9VUDZuRnJqZ29kd1hvcnpx?=
 =?utf-8?B?SnlIdlZ3M1F3MUVYZ1ZtS3FUM05xaGxmYWZoK0lSczNkTkJHaE5oM3FEWEVO?=
 =?utf-8?B?MTdNaURIWTRLbVBhWC9uVVNYVXk1Z2hRVVBlckVNTFRWa3Y2cmEybHZ1Ungy?=
 =?utf-8?B?U1Q4QXlpL1doRUF0bUl0UGRTeGJqMC9UTnVqd1dPdW9SVVRueHlGN0MyMnR4?=
 =?utf-8?B?eWJPYXJVdFpwZjFBcnVFOWhKei9sNmNVWHVSMEJSRWJpYllXN2xpdTBlLzRQ?=
 =?utf-8?B?MW11S3hGejJXZHpxZHNWdGdWK2VEbGQ4MVcwVU9tanlVRWVzZlhLaWhsM1BV?=
 =?utf-8?B?SEs5TDJuQ0s4VHZXdFpUUWxSTUt2b3BzVVM4RFVDQ1liOUVLandOSkZoUTNz?=
 =?utf-8?B?cGVraDdoakcwTDNqTUR5SnpzbXFWUVVDa0RaZ3pzVjdPUnF1Z0VhZi84RmJG?=
 =?utf-8?B?RDZGWkd6TzZMeTNod0lBempJQUV5Ym9jdzZYRVF1cHloWnhiaEFLQXJYYkxo?=
 =?utf-8?B?NFVmb2Q4d2FWUENSZFg3bFhQVko5dTdIV1IvU0hXL3MzNElWZjdoRWE3TXR5?=
 =?utf-8?B?eG1JSHFKOVVLQjdJYTFNV05RdXp2aHVYZWVyUFQ4aGtRRzg3bnRzblpVaE12?=
 =?utf-8?B?dnpFSzBvVXhYbHU1anQwdnhYV2RLRUhEY2REK2tSSFZnN2JsTjdxa2RuQ1dq?=
 =?utf-8?B?eHozZTE2N00yRUJLV3pLOUxQNEhuUER2U0JraUUvMFZpV2wzWTlTN1JpYUl0?=
 =?utf-8?B?TTZ3Z3dwYWR0aHFBRUpLU0dvWFRWYVhyQWdjdzVkN2o4RWtFNGtXc2kySTQw?=
 =?utf-8?B?a0ZWclpFWW1BSHdwN1M0QW1OZlU0elRZTG10QjBFaVRpa3dwd1YraWJ3ZjdX?=
 =?utf-8?B?c3F1empTaDU4Y25SMmgxWGl1NWtFM1VtSHhISmtWS1RHVFZpRTF1UkZTc2c2?=
 =?utf-8?B?cFlFWVV4QjNGK3lzcEVXVC9wK2Y2V1RxN0wyWGZBdTRQSTg5ajZ0dW5Od3hH?=
 =?utf-8?B?MURlV3JxdmRYOHlqTjBRajJEOFJnU0ozc0xuRzE3YjIrNTV4NitsUmpZMlZ0?=
 =?utf-8?B?STNkZlFFZG1acnAxY0xRaGVNNURmVjNyaCt2RXg0VHNjcmpFQjE5MUFBcGRU?=
 =?utf-8?B?RUxIbmt5OGxhMFYreWJmSEJXZXdaUHB0VW1kTnFDanVucEVDT2Y4UUI5bTFQ?=
 =?utf-8?Q?h7OLiEhX9RmldnW7z3Jql9Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef28e2ea-32c6-4ce6-0461-08db9e3a0f03
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:20:40.0911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Wcg3eJQt1U0t7w9yKVZkfgVDYUwKTXCSQODey6e1sU2eEr076pD7Vm7z42ByocIv/5R56aIUsOBto99IqmYciIps4YwlNyrquY3YPGY5DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6465
Received-SPF: pass client-ip=2a01:111:f400:7e1a::70d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 7/31/23 17:45, Andrey Drobyshev wrote:
> On 7/24/23 16:10, Andrey Drobyshev wrote:
>> On 7/6/23 19:30, Andrey Drobyshev wrote:
>>> v1 --> v2:
>>>   * Add vmdk format to the 1st commit.  Tweak commit message accordingly;
>>>   * Make "compressed" field in MapEntry optional.
>>>
>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00184.html
>>>
>>> Andrey Drobyshev (3):
>>>   block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
>>>   qemu-img: map: report compressed data blocks
>>>   qemu-iotests: update expected tests output to contain "compressed"
>>>     field
>>>
>>>  block/qcow.c                                  |   5 +-
>>>  block/qcow2.c                                 |   3 +
>>>  block/vmdk.c                                  |   2 +
>>>  include/block/block-common.h                  |   3 +
>>>  qapi/block-core.json                          |   7 +-
>>>  qemu-img.c                                    |  16 +-
>>>  tests/qemu-iotests/122.out                    |  84 ++++----
>>>  tests/qemu-iotests/154.out                    | 194 +++++++++---------
>>>  tests/qemu-iotests/179.out                    | 178 ++++++++--------
>>>  tests/qemu-iotests/244.out                    |  24 +--
>>>  tests/qemu-iotests/252.out                    |  10 +-
>>>  tests/qemu-iotests/274.out                    |  48 ++---
>>>  .../tests/nbd-qemu-allocation.out             |   6 +-
>>>  13 files changed, 302 insertions(+), 278 deletions(-)
>>>
>>
>> Ping
> 
> Yet another ping

One more ping after 6 weeks

