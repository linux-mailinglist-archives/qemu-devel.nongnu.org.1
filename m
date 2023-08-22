Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CF784871
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVFi-0005Vj-UQ; Tue, 22 Aug 2023 13:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYVFg-0005VX-T8; Tue, 22 Aug 2023 13:33:12 -0400
Received: from mail-db3eur04on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::72d]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYVFc-0000QZ-41; Tue, 22 Aug 2023 13:33:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgDcdcHkzUQYOM6XS1EbkbqnZrvtP3/L4pxk2t74DynC9986lGeiCemdlE7J4u04Ts1ZE+vLZ+vKGLDmu6NL7JxezEm2K3DrlfCCMYHoz5Mm0eh6zTXDu2f1yRi+j4LKpE/lCnIeXF+4APUt5WZX7q+xeJKOyQg+FR+lAYYSy2ys4Re1W3Fqi1KH0VxT6xRsVl4TRrtSaRrjdzPSYtU9kvRhZGJu0FobOmVotcAkhMIJwkwxAkBu6rKx5VoEurRnFuh1CLVlUZ9zogkawwqliRZRssWtKKEKI8Tr7F7L5vIi/Vxn4zRA088aawKVQ7ijJlMJNdrlm/OP7h4OfwyjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5VMzSlZDhEmI224EZQVIQW9p1JKcnm1TC8tSYaL8fA=;
 b=W5argJWISuLPXWX+mXWcCRUwH0VptvvTUOE1GHtEyA4y7WFrYWrywVMmVvw7u8bzxq/EnLnB1sEbqO4J4gMvK5xYUDlAh8o8RnvrFzEwxE2zkdaMLlus0tb5alfJu4bAhibWUZo2VTFV9deI7b0SJNk1hCMZ08yp8LHVTslQd24mB3IN27NrMCA7mNDezDSvuzqQAT72UsoePjLzKojZ1ZrMK2oSLXs7y92djwY0CLtiGr3TCBCG8r5m++95W4QuJcKk8sExxYz/M6hFtmJQuyCiuUPuleNCit0kxHs9eSS/xMK1g0BLhl7s9RdflZcYsdGbYOhJGMOlGTpwZk6EAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5VMzSlZDhEmI224EZQVIQW9p1JKcnm1TC8tSYaL8fA=;
 b=qXNQXODcBaZTeUR4UT7niJ7tAamm0HU2O/KOUylFXv/L6R22NqRiH7GJZhXtDRCwyKIs2oLCrE9YphpShrgvbqTv8gFM1tng4ohujdBYTVubwedBw9FRIlG0M2ZdmfBCK2Xq2/uZshAobaR6L/72mIE8kgdeV2bWODYCdm3eN06E7WeCeDo0ieMuQLm/TK9S5tKzIsDYnWpxNeO/M8RJz5YQiSdUpiHG38U5don7nrNEn0lM1SaL75cU+hec4SsCvzK4voNe71j/2tWDCZv0zY2HBAXd2I9JeV5ptKuykF6QbZ4cfB25J8XPIJ4KjF6CO0pwzzhiN7UfxGlKrTxwVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DU0PR08MB9004.eurprd08.prod.outlook.com (2603:10a6:10:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 17:33:05 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 17:33:05 +0000
Message-ID: <ee4f0a52-8742-4dcd-9768-59d9192b56cd@virtuozzo.com>
Date: Tue, 22 Aug 2023 20:35:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] qemu-img: rebase: add compression support
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mjt@tls.msk.ru, vsementsov@yandex-team.ru, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, stefanha@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
 <8c93905f-2c51-354f-e08a-e9670d3f5cfc@virtuozzo.com>
 <962e464a-cb94-d1a0-5a74-52de34d25557@virtuozzo.com>
 <b865d41d-97df-4d5c-9e52-4fb2415d0af9@virtuozzo.com>
In-Reply-To: <b865d41d-97df-4d5c-9e52-4fb2415d0af9@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DU0PR08MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6396fd-363a-4316-5c95-08dba335d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOBgsTADA2mWFgT5M+Yd9s1RFKZzLrWE/YoPdNPoRYdfuiICGvjmmuIBeDGEZzYXL/z7FLCvhemrymN4SK8YUlXS3Wy82r1X9UHqoFji2aUC9st7AvqUsOu6saySPZEdEwyvfKvH7J4nTYcaVDW/Ty+H1K+ELxt49bv/NOC5bDrk+aIh0g9zZDtm33GlSSDb9wXcDqyggRn08t1eP2I3I6wPio8zNGBR7A1w3C+flV4o+qL8Is0Er/JLyVDbCKG+nwUrKBscLfJ+o9sJ+iq2X6Ag0/qgAJWRcO2IRvPK136DhNE3jTvtjs2CoFJTi+zjkSUShs6JacBEHYeOWQUwJX++b4QAVztJNhxGUyVUfpGall/X3hXlIN6AtOdjoZNy+09bQSNlsHg8cdHScAO/Ow0F/AGl46uGoGY7tYba2DQ2vbHRV0oN19nYNjAQRYbNY34hQu2bPHLZt07Lp4rjmM9RoGl/DjgF4KP72ASNDvVqJmHFUh281nzPMuuVU9ZSkdhEMeuxEY/0jng7BSSNXWJ1/EJVvdFf757q1mgTM/lhcuqBqE0achFoDbHvn2Me3Xmsf412k4kKYBfGzuXs3mmJAzgYujKvqT0Js1htmLZ8kCtuYYJV19qnFdZnr6XVGbexXTJa7h0s/kBVOQWLfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(44832011)(26005)(31696002)(31686004)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(54906003)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTE3dFlQK2psajRrcmlPbVc0VkFNVHUyRThCZFE5eU4zKzZZNyt0Y3QyMjN6?=
 =?utf-8?B?K1c4V2NxMXQ0eG9CaGtlYU5weW1RZldiRVlNT1ZZQ3NhZTIyZzdIVklvOTIr?=
 =?utf-8?B?eTB4NmMxbVZsdWtUVzN6dnNHdUlXMHk3SlNLbWJXMVJ3MHJCWjM1Wkh2WURB?=
 =?utf-8?B?b0ZVa1ZPREJzaU5LblRaVkIwOWJHSnVrMGovZGlseTNqc2U4T3pib0ZmTmRY?=
 =?utf-8?B?MW5CWWtJZDROclhjNFVnZlE5NTZsZFoyV1FHTXIyMnFIakJvYkhzOU4waU5B?=
 =?utf-8?B?dDU2NFBBeWl4bUNaWk4zT1hiR3J1RUJBNS95bTlFQ1hVRWRjRVI3azMxR2Qr?=
 =?utf-8?B?ZC93b1hJWTBJV09SVUw0c21QbUZkSmRsVFhocnlEZWMxVGVwTkR3N0cvWE5u?=
 =?utf-8?B?dDlZVlVvYVpKMURJL0U2YzlkYWlaSkExTmdOSlNGWGVTSEJxaU1OMVA5bmc0?=
 =?utf-8?B?dHRiNGVKTTZzT0ErUjJ0Vjlsc21QcnplUVZqcUs2MXl0OEkwQzNjU0RnZmNS?=
 =?utf-8?B?RlhwQ0o1WkFKalp5emVoZXpxNXliTllKODdKbE1KcXdSTHUzd2ZvU0JVZmZS?=
 =?utf-8?B?cG5wVDM5SkY0UWtkNng4Zm5OTElSMStUaS9VT2RJSk9TRkhNR3I3U1FMZDAz?=
 =?utf-8?B?c1dMY2dFWG1mcTNKQkpIWkNaR0VKNlRnbUJMTDZ1bU00dVlPdzAvWmVMT3Qw?=
 =?utf-8?B?VTBwZGlPMTVwVkl3cTkya3BpWDJRSVphT2ZOK3pJQ0swVlFkQytQbmNjZjIx?=
 =?utf-8?B?S1FlOUp4b1F6TjFCRDdySjQzRkZTTDBtdERFMlVEdjhHR2wzVnB2M2lialpY?=
 =?utf-8?B?eWlaYmxsZlU4SmM1NUtyREU4NVYzQWoxZUxjVU5XUTJzeXZFTzJHVXF6Q0RY?=
 =?utf-8?B?cmNGRzlOQzVDZG16T1BRQ2RNSXg1SUE5QjV1NzdxeWw1T3czKzVBKzZhampW?=
 =?utf-8?B?NUJsbUFvYXdGMlFHZW9icFpaS0tJS1RVem41ZmZOTkhodWRqYXNaNkhYOXp5?=
 =?utf-8?B?ek9TVVVFcjdibmkxVm51K1Nwc2s3UTluTTVaeGMwSlRlR0UySE82MXR0b2sr?=
 =?utf-8?B?NkpSbDljVnNoTnZUQVREVlhoYkpjc1Q4S05ybmlwMFRxWXNPQlhCR2lOL1pG?=
 =?utf-8?B?ZWFreTIvNE1PbFVRR0RUczNGSnlwVE00VHo2TzdxanFianZaTHlqK2FkUGkx?=
 =?utf-8?B?eHJkMFJLOGdCUTQ2eGExenFCRm1uQXhhYnlrcGtLVEp1d3pZN1l4SlY0QjRz?=
 =?utf-8?B?azRld0hXeHlRVlJqakVKVTE1aW4xczhPVG4xTit1bWtJNjBPc1pnQkxPZStk?=
 =?utf-8?B?c0YwaSs2NTVNdjM2R3dlVTArSlVXQ0ZPY0RPVHlueGZ4blV5OVdYRW9TLzJQ?=
 =?utf-8?B?SzZYdUJVdjN0aXdFemRHQi93NHphRUhoWUZiSlhadUwrUnAvL0xicGZ1YUJn?=
 =?utf-8?B?ZmV1cmk4ZXRaaVlDT3c2MC9IY3NDTnlMU1BOL29UT3VSYmg1cDBmQ2hrUlNh?=
 =?utf-8?B?bktpNWhFZCsvT3JzWDQ3ZngwYXpna1pTaFFIZHdlUEs0NlZTUVdNZ2pGT2Vp?=
 =?utf-8?B?WWFKMTk1ZitZZ2M1eHRpM2NiVG15NHRJcXM1VGhIeEFzaEJVWmtvVlRRbDJv?=
 =?utf-8?B?YldaaVVFUzBIcHVOQ1FHVXgwUCtYT2x5MDJGT1l6ZXJ6WG9rVGRGSEZtRGFm?=
 =?utf-8?B?S3ptbUVEaGFmdjRYa0VQNHNBb3hWaVBHbjI5RWRvYkJ0WHZ2V0djYm5ZNzhF?=
 =?utf-8?B?SEM1T3c3TnRXSUFkZThpVUdQTnFveUlzK2h5eEUzcEJJYTRSeDJYS21uMlNa?=
 =?utf-8?B?dFZYdnkwWlVYc1lSUVBEZ1BXNzNvU1l2TUFveXZsbi9mdlZxQzdsVGVKcFcv?=
 =?utf-8?B?d2F2RmFMSWpRQ0ZTd3ZrYWZxRVNMQ2FSdWtJUHgydmhNYWhMdko1SHVxZUVH?=
 =?utf-8?B?QlhTVUJ5UnhndndXQ0R5aVoyNkYrY0ZrYUxNbnhreEVkKzMxZHp0eE80TFRS?=
 =?utf-8?B?SzFmYkFlYjZzQWF6bm1pQ2cxZDVrNVlCWnhJOWxWb0QzQnpLK3drcHNpWHVO?=
 =?utf-8?B?OGVxckpVdE8xZjlqQXlnSURSV3ZXTXd2NUMyQy9yVGIvQ3pPblM2aVpSMU1p?=
 =?utf-8?B?UkZJQTUveUZhb2ZDRVg1SElWdDhnT2UzK0ttaW1wMnloYkJETkJuUXRad1dm?=
 =?utf-8?Q?VSZwy7E5Q1YFIr0sO0IVGeM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6396fd-363a-4316-5c95-08dba335d7b4
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:33:05.1549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26Hc7aM9AxK7bS2qlgR7DGs7LvGEfgPXEJTDNsY07DZA7n1LKchkgBFH0WcITIXkWInVNvmaywXwtjQlxpiXX8lF+DkpE/CsYEsFSTS1Z2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9004
Received-SPF: pass client-ip=2a01:111:f400:fe0c::72d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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
> On 7/31/23 17:43, Andrey Drobyshev wrote:
>> On 7/24/23 16:11, Andrey Drobyshev wrote:
>>> On 6/30/23 13:54, Denis V. Lunev wrote:
>>>> On 6/1/23 21:28, Andrey Drobyshev wrote:
>>>>> This series is adding [-c | --compress] option to "qemu-img rebase"
>>>>> command, which might prove useful for saving some disk space when, for
>>>>> instance, manipulating chains of backup images.  Along the way I had to
>>>>> make a couple of minor improvements.
>>>>>
>>>>> The first 2 patches are a bug fix + corresponding test case.
>>>>> Patch 3 merely fixes wrong args used in allocation.
>>>>> Patch 4 makes write requests during rebase operation
>>>>> cluster_size-aligned,
>>>>> which seems to be beneficial for both non-compressed and compressed mode.
>>>>> The last 2 patches are the actual feature implementation + tests.
>>>>>
>>>>> Andrey Drobyshev (6):
>>>>>    qemu-img: rebase: stop when reaching EOF of old backing file
>>>>>    qemu-iotests: 024: add rebasing test case for overlay_size >
>>>>>      backing_size
>>>>>    qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>>>>>    qemu-img: rebase: avoid unnecessary COW operations
>>>>>    qemu-img: add compression option to rebase subcommand
>>>>>    iotests: add test 314 for "qemu-img rebase" with compression
>>>>>
>>>>>   docs/tools/qemu-img.rst    |   6 +-
>>>>>   qemu-img-cmds.hx           |   4 +-
>>>>>   qemu-img.c                 | 106 ++++++++++++++++++------
>>>>>   tests/qemu-iotests/024     |  57 +++++++++++++
>>>>>   tests/qemu-iotests/024.out |  30 +++++++
>>>>>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>>>>>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>>>>>   7 files changed, 415 insertions(+), 28 deletions(-)
>>>>>   create mode 100755 tests/qemu-iotests/314
>>>>>   create mode 100644 tests/qemu-iotests/314.out
>>>>>
>>>> ping
>>>
>>> Friendly ping after 7 weeks
>>
>> Yet another ping
> 
> One more ping after 12 weeks of silence

One more friendly ping

