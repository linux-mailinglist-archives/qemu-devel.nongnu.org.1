Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C678486F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVFb-0005Uv-IQ; Tue, 22 Aug 2023 13:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYVFZ-0005UM-95; Tue, 22 Aug 2023 13:33:05 -0400
Received: from mail-am6eur05on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71d]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYVFV-0000PS-Ch; Tue, 22 Aug 2023 13:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7FOJiTvVyY7NgHRyuEyAs1+peuX8NmnQKQ9K4cMEg9YvN4t6vAnRr4elQ5stHkc1WhHaOxEqjFH4qjgi3KOFpktSEo4zZ77hgoTJPy/rbRNOtk4qF9nNbXKm50b8SLimjfOyEKIwuo2ryI+iPJZxQ13WaMx5oaO+eR7F8g+ZlQpoSpr0Crr7tYwGcNCPPHKYKV//OzVsxwgLWck5OIaEl17ACQF+5/LVL4agiaL1yMYPojvp4qH+tPFYwYB+9JL1MWF04sAVVwiMyC114S4Gz4xChTeUnH0nrtYS48gBK2D8ZsBAUn6S5mUIXy45XLf6rasiMQiULoJTd0tBp3mwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXXW0ll9cZomvPi7SPc55pM3+vv+wMJeRewMnDg1hPY=;
 b=jvTPGSDS+sWhtLIhnF8gEgrYKyFUTEhPMZFDnCyTXbUCj3A6Whuvr5h1nXm6oA/EKSUa2saWwkNsnb+1vaF1m+eggx7oaBnhXlC3VikaqsQrwu1ZNaLYpLsIQgR7gm9yLeeJG8s3USk629FCiMe47WQshl8xzoI5q4suA9OBzSF3iMijuO17U3jmf7ZloiEHzXoQoa4kJfYY5oQT27NMF0T7jB7QYx8CgqJ7bed8/ICwEz5Tn6MiM5b+qEujwzhgnLou6U3LHLprD12fpU3mKHTPmBxvPsIaeTtcClVQm3f1Y7cRzI2WC8ztyVEqSA/oz18ltklx+sKZ7G7y4WNTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXXW0ll9cZomvPi7SPc55pM3+vv+wMJeRewMnDg1hPY=;
 b=J2nSkWYuX9sVABp0sZ0lfX5sVzasSciJvm2acxVlD4OcAMj1z9xQcqwZMJxoauHihQO53llnGaGoAtBp0jVALIvoK/IO/IL6YbBi7N/gYzwiHO0ik1ynDnRfFlPcHTltzg7MUaEXIBqxuCsaOVyw7nvW4MhsRl2a/yKSa0tpUPjUiMp0PG/eSg6+1g2aOArN2H77y8nYpZoS7aFU1uJTn4XX1TseeNBBANf+WzHVa77kJTWGYNr+O4W/AKczzoRP/gb6vG4fiqnCOxRp4M91LWisNHyxiH28mMUfKHX0gxiJv3dG0Zm4hyoRKxx6rXXjR0eH9bzG4JeR5bLOiMl3dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DU0PR08MB9004.eurprd08.prod.outlook.com (2603:10a6:10:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 17:32:59 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 17:32:59 +0000
Message-ID: <0d898888-033f-4395-a8f6-ed1141727c45@virtuozzo.com>
Date: Tue, 22 Aug 2023 20:35:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] qemu-img: map: implement support for compressed
 clusters
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com, stefanha@redhat.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <8c0bc7da-175d-a367-3d7d-32f570953e7c@virtuozzo.com>
 <b847bd77-d23d-c0e4-dbb5-e69dba0d2db8@virtuozzo.com>
 <bb1e3eca-4517-4ef1-8e34-8895285f503b@virtuozzo.com>
In-Reply-To: <bb1e3eca-4517-4ef1-8e34-8895285f503b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DU0PR08MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6596f6-644a-4d93-5a3e-08dba335d455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfStZQN3jLNwHf0wy0vAGOchMhXo6a7bNnzG13t7j5f9ntfCkTf2N5gXXwUGe3Sx9X73QoEDKaB/st5SlOvwoRfw7ZjpVZtzS3DAsYwHrxEDi5faVC6Er52Fn0PCKA0TATXh5pulEU6Uto+GR1H/DpzSyDHky/FwtOY8TmbOmXJGxwYKl6IMZ2Ez9FGl1E1RMOkcVLQeQ3xtPxnWG26+FJR6OpxGp8Q/cXyeyiKA/jmyFeTQ9Q8L9EJIFSnp+dl3OIMV+HOr57Vw5shVO6Uyx5l0mmq09PW4r3o0FHCAo015mhyNe5ZfwaBLWNS15eD6iuYEGStyb40JLm7QPMzvUBB1rKwUvZ0MMXM6RibeYnTOztVeCZ2/KvjN57uipyG6QQwayHyiEKROTFIyYYIz9zvffoKX4j+LL28Ln16h8y7irr/5zjEiXglMv92EBQeZDx5ErGavHBGT8hiVJM4VAJVvBnCHTBtx5tBLeQLGZ/7szAXSlo4ylQMycIyU0j1zRXrV6nIi4rQU5vuxKghteKzvxcv9z3ssJ98hqxVvY8LLYJK7s8vJyvlur1gTecc8PY8pH+Qnq6Jr9yfUgllWDVnvcdUwdT24kzZSIvV1RakZwQ9TKFozRhbqKQ7sGyZvl7m3i7K+hkr57uyoOnpZHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(44832011)(26005)(31696002)(31686004)(86362001)(8676002)(2616005)(8936002)(4326008)(966005)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZjalBjdUZuYng4OUpCYkNRLzcwNGJFOVZ6YkJ3bG43OGpqVHlHUDdCaW5m?=
 =?utf-8?B?SG9PcDJpeW8vaHNIdmg2cUVBWVh5enh0Zm5KMlk2RDAzOXI2OGNnZ1V4VDI3?=
 =?utf-8?B?Ujl4V3AxZ3dLWmNiYUlnOFdPcDhrbTZ1QTBHaXVRWURXOGtzcUJPQ0FFbjVj?=
 =?utf-8?B?NnFsRWRtVlljZjJ1bHRHdFYrbUNUK0lQT1JnZlhxQ1NvVnV0ZG8xWjlCUjdx?=
 =?utf-8?B?eWlSWVYxUUFkRk1WTjk1YU1sVHZTNVJmTW9FOUtpWTVReEpUb00rRFhOVUdL?=
 =?utf-8?B?Vm83eGNheE45T0hxSkx1aHhGZzExdXFWVkJ4eEs0WDRCWW1PeGxDS1YweGQ0?=
 =?utf-8?B?bWhrLzQ0aGpoSUVWMUhzYTEwdFZpR3hzNG9IWk5wZzdWdDkxUkxnUVhaTm1n?=
 =?utf-8?B?MmYvN0NlTnVKTFl4bEQwaWZxZGRqRnM1SThudW94cExpK0lHNVpPSnBvYUR6?=
 =?utf-8?B?cld1VVJkdmpuM2pFelVRRndHaER4azZBNWNJN2NLS1laS3Z0QVR6R3BHT3Zi?=
 =?utf-8?B?RGJEUS9uWEg3dUNlbkVrMlc3MExPSTEvdTVvWHBuTlpXcTZsYzY5eXc3Z1A2?=
 =?utf-8?B?WmV5K2dDWFRRdVJ4NlhrMGxVWlkyc2VYS2Npd3k2dlBZZXhhQlBNWDhqTi9i?=
 =?utf-8?B?WGRCZXZlZGgxZWxMbFJhMzBETzVrblMyUEYyTkhjem14WE5FcUNOTVRzQ0ha?=
 =?utf-8?B?Q0UranhJb1BJaHFvaExqR0pIQjdBRFdVaUQrMGF2NFJTamNRamd4QSsvRDRu?=
 =?utf-8?B?VU1qcmVoN1lnZklFaThuMUpNSzF4RzQ2b2RvbEwyTEpFYVU2UmxZUXpEb0dq?=
 =?utf-8?B?eWY0YWF2RjlxZWltYy9OU0hWNHFBMnd0QmZkNE1qdnRyckF6eFF5ZElLYURr?=
 =?utf-8?B?djRuM0hOR3MxMWJyRk9Bb0J1WTBBUjYyb0RycmJ5N0tDMFZ6RzBRSGx6b1Bu?=
 =?utf-8?B?Z2VDdUhtbFprQS9pRUlDcFR2cVdhckw0cjNPM0V3KzBZTkt0UDNpSm1xUGRv?=
 =?utf-8?B?VmEzbnFyOGdnMDBsNDg5RWVqUFZRelEwdE5CTTI5amkxS1V5OWRqTlJJTGM2?=
 =?utf-8?B?eE5mdkxBL1gzb1FGZmk5ZWpKbHBGYnlVSngwdGg2R3d0dkt6YzVuM3VoRU1v?=
 =?utf-8?B?Q3hkTzQrbXNLVnFBWW5MT0diT214eWM0N3c2cnZ2TUUzdWdjclo1RTNnQmVt?=
 =?utf-8?B?aTVtbTE0eXY4b1F4ZmxtcFgxN0dUTFppY1lHOE9vRTdMcWNVVUlwTWFsV0pt?=
 =?utf-8?B?WTZ4aUJQQW5XN3RJQm4yYTBtTWs2bmxwZjl6V2pUMXRPVW05RTlMVGN0UHhQ?=
 =?utf-8?B?QjlmaTZmSUtRL1htQjBxdG82dkpwMXJESklZdzNLeFEvLzBwbUQ5Qyt2Ukhv?=
 =?utf-8?B?VDkvYTF6dkRtSnlpZHl6dlFDcFhLUFAwUU5nVkRpek9KMHQxb3J1akRCZzZQ?=
 =?utf-8?B?UFlnQzc0LzREYit3TG9PRWtYZGZMRUEwdVJzaXcwaUFWVXBlME5TaTZZdjRk?=
 =?utf-8?B?bDFSbU1kVEtiR292RWU0ak9GWEtSeFdtQW9qUVJHY2h6TkZpcXQxWCtEaDZ0?=
 =?utf-8?B?WVRteTA4VHlBNlhMRkllM3FwcEx2NXFkOXozQVlhZ2pnaEpRNmZGL3NQVHA1?=
 =?utf-8?B?Si9WR2NyQ1I1SzF3d0JQM3lMWUppMjVGZWRwZVJ6TTE5SEJEbXEveU56cXph?=
 =?utf-8?B?Nll6TlVGNDZvRE81dUxwWHp3NEFtQ3VVTUUvTmJjamtsaWg1NmlBTkVoU1Nu?=
 =?utf-8?B?RHNCYTNsOHhnL3QxWVJyUFhmQlZ5d1ZLOEg0QkFQL3grQWl3ZzkxQm9BZmNT?=
 =?utf-8?B?NjJlRmo4QlZWUnoraUJ4Q0lodUdFdWtZNC9yQTg0ZlRNUDV4cE1Lc2FIb3hC?=
 =?utf-8?B?aDJGcDR0M2JkNGtIR0xyZVh1N2grYUZOWkNxMDRXanoydzNOeHpMajVZVGhY?=
 =?utf-8?B?aHJyZTczZGVVYnNSbFBmZndZcGdyMHNxSlhKRzVjbDlOQXhmTVVUNlNhVGds?=
 =?utf-8?B?K3JGZHlIVHkrVVh4U2RsYjNSeDRiek5IdW1jT2VZZEE5b2MycVFoUStCa1VM?=
 =?utf-8?B?Ym13ZWFXaWFSZFRqbU4wNldnYVZ4WFpvNDhEZlRXSmxxZFBPTUMzaU1ROUk5?=
 =?utf-8?B?dDJERFpNbWZhNDNPU1NMYm5DbXRmTHEyaE1FMjVmQ2ZVUTJVWmlsQnBwd2dk?=
 =?utf-8?Q?CKtwbE4/+EegA9pe34zsrR8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6596f6-644a-4d93-5a3e-08dba335d455
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:32:59.4866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbEH41TLOGqwXkfECWwHlTaU055V9B4RhTHYde83EpHNFv07Z6+fMhHUZCp4fUKaJ0HIjA5dk4QzozrVyaj9iom7G0Mih0nOGBKAMEQuK7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9004
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 8/16/23 12:22, Andrey Drobyshev wrote:
> On 7/31/23 17:45, Andrey Drobyshev wrote:
>> On 7/24/23 16:10, Andrey Drobyshev wrote:
>>> On 7/6/23 19:30, Andrey Drobyshev wrote:
>>>> v1 --> v2:
>>>>   * Add vmdk format to the 1st commit.  Tweak commit message accordingly;
>>>>   * Make "compressed" field in MapEntry optional.
>>>>
>>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00184.html
>>>>
>>>> Andrey Drobyshev (3):
>>>>   block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
>>>>   qemu-img: map: report compressed data blocks
>>>>   qemu-iotests: update expected tests output to contain "compressed"
>>>>     field
>>>>
>>>>  block/qcow.c                                  |   5 +-
>>>>  block/qcow2.c                                 |   3 +
>>>>  block/vmdk.c                                  |   2 +
>>>>  include/block/block-common.h                  |   3 +
>>>>  qapi/block-core.json                          |   7 +-
>>>>  qemu-img.c                                    |  16 +-
>>>>  tests/qemu-iotests/122.out                    |  84 ++++----
>>>>  tests/qemu-iotests/154.out                    | 194 +++++++++---------
>>>>  tests/qemu-iotests/179.out                    | 178 ++++++++--------
>>>>  tests/qemu-iotests/244.out                    |  24 +--
>>>>  tests/qemu-iotests/252.out                    |  10 +-
>>>>  tests/qemu-iotests/274.out                    |  48 ++---
>>>>  .../tests/nbd-qemu-allocation.out             |   6 +-
>>>>  13 files changed, 302 insertions(+), 278 deletions(-)
>>>>
>>>
>>> Ping
>>
>> Yet another ping
> 
> One more ping after 6 weeks

One more friendly ping

