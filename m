Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B87699DD
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQU6F-0002VD-H0; Mon, 31 Jul 2023 10:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qQU6D-0002UT-0s; Mon, 31 Jul 2023 10:42:17 -0400
Received: from mail-db5eur01on072c.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::72c]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qQU6A-0004MU-Uq; Mon, 31 Jul 2023 10:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYwnsAP9op7rEG2H/MtjZc9zU/i7kdcIBmLZelUqU8qKgV0KHqnOW/cuqKyhbrcJejlUmPQLQFDI4KfC8RWKDyIMGPngxUflul5C/Cxov9Uc++zUO5sjKycKtiAdxFH4ZN/PWhY3pS/nKCVOA+k8Uab9G7D8EsLoBjJVudzv7sq6wBGZ6sUdfn7MlcjAbUDngxyb8uxd57N2y60/3iJPKNp/VfTJNDo5GyQ3YbJtskquG4iuHziL4+JXUUjMaZXgAHSSAclWtMj2HWj9wQWDhELpUzcVpGkt0LF4u3K7DNWkfnFQHIGFmDkqN0oArXEknq9CJJ7UOi6p1BhyZm2FAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPQ9hCcZrWLk8wGuwjUEHwpS8DgpYSji8q4PWVWzfuU=;
 b=OuFOT1cGIh3VIa8UFYERn9DpbA9vf8JcjEER/3msL8GGoehUSL2TEgpSQ2CGArm3M76st0tEarr8Iis+/KJjnA1KCi0kqw7CRHkbwPA95LtIoRhVGkPO75jFzjzXkt/j6r5VCe7FwynMuNrsiVm1iMXycq4/JQr6RRhYY4koX8gUui7V6ZIeVxGbqJLDgPbcyNGN3Q7IUp5E9kHCfmDd/hEzkDerr3FWn86lLUbUuqGaqmcXOXwtqQjsBRiVtUwxllM4mRHf9HKl/2CV3oobt5j1BS3MbXOQihACmGn7C3jsQVqP4veZsuQ2Bvsy7mLJ0AgJevxqwQkFd2A/r7IWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPQ9hCcZrWLk8wGuwjUEHwpS8DgpYSji8q4PWVWzfuU=;
 b=YK0mCADuHxDi+WescCSp1kFER/ogiIxwOcCbD6Z5LmtNA+vMy+wgaHO2HwgHEABi1ggxCZQ2L76poiO2Zx/yKCQoqET/iUXQhNwYfOlEfxLzxtrdT8ESZ/2OTrgtiSs4qGoKEDGOUcaHaiOpCWxbT5dRRZfnhRYg7WAMRO4Z49DpFs/l90m+4Y8kFVZp2D0IFEH0URh/aJSOSdf7Flei02m6OiDC9JsEcV1lKcO+JFjJKePEWHjqVqUJJwRv3lDB+MQVB9yWgjdor/EHLL6v9uACAVKhM5PZh+Z3M5XCkvihb8eJi6vrZtywdcmm7hLBneIPBNq8hDelHGLlffl2KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAVPR08MB8920.eurprd08.prod.outlook.com (2603:10a6:102:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 14:42:07 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 14:42:07 +0000
Message-ID: <962e464a-cb94-d1a0-5a74-52de34d25557@virtuozzo.com>
Date: Mon, 31 Jul 2023 17:43:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] qemu-img: rebase: add compression support
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mjt@tls.msk.ru, vsementsov@yandex-team.ru, "Denis V. Lunev"
 <den@virtuozzo.com>
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
 <8c93905f-2c51-354f-e08a-e9670d3f5cfc@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <8c93905f-2c51-354f-e08a-e9670d3f5cfc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAVPR08MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8642ea-9885-486d-f9c7-08db91d450b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5r+P2h7L9nQnWaoLXg3LdVmG2ygq3j14M7gxNdNmpEs+p4y/nOiUtMTZPQwNNLhUYfRNNoZbNwAw9//X6tZ+NRPVJbJ/Is1/EjGTCKgG49MNgSZE0GiDGnIw/1nABNviWcxsfyssV9eyZuIbuRDo224EMN8TrAXJTyMR5qY62USeg1ZMe2dqaLMOcZ4nn1Uo725xirp6qB6aLYYsmHgBTdJ+kg8D4k7lQ41Biktiv/wgwiBpsnjjmn7qAIkfB2YBXeBDUQT5L3ZwCAUaxa7yn3izeatTDaQ0pfIs9uGUdxU5y6zVXp19MhBT0+IxznadTypjxWOuKvXfdEM+BV0YcikDhy5tnmG1705jtd5Pl0Lv0152OGbSjNmRvqlkbyBxzVHJiIsurWbvPISaqTnM7XvtxSroxjERBstlw0vM9N2X7qOt63Sk8npiIKG/EgBhz3iek9SKUFk4xqiKIQO1+fp0bo4XlOSIZbFlVuDKc+/G8CC0UBvUhNIIb5wz/VUgJ5beFCFOZlkmcMfymWb/WOsS0ZVVW1H5TKnwedONSTXb6g4iXgUgxc5XyKTPfVEW59Ut7cOU9o2GxL5vIrgkuapVwUJEWM0KMZ+bLPhbV4Du7E2ar99AHZJ5vUol27RByb+BytPFOuYZcDL677xYrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(39850400004)(136003)(376002)(451199021)(38100700002)(31696002)(86362001)(36756003)(6512007)(478600001)(6486002)(6666004)(2616005)(53546011)(107886003)(186003)(26005)(8676002)(8936002)(6506007)(44832011)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(6916009)(41300700001)(31686004)(316002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21GbGlGUzZ6RVovYi81c1VHdTBWZHg4aDZKbnU5M1FSTWtCZVQrd3l6MVo3?=
 =?utf-8?B?ZXZHc085aFduVzRuRTdMZnFhZ2VVdEYyVEpZWFFIMmFGMnd3Njh0NFdXUWV4?=
 =?utf-8?B?OXp6K3pSQU9FRTR3aHBZV0NBVHJPa0xuNkVrS3IzNEl4RkZrZDVhTDJmb0E4?=
 =?utf-8?B?YWhwbmhveGk5WkJCK3BBNTJ3VzVicWVrcnpRaDFuUytybHNQRVJFQkZ1alFZ?=
 =?utf-8?B?TE5MNXVESHhYRlRQaHdqZVRwTHhBRGJaeWJaK1lpdmxobzdkR2N6cUdYM2Ft?=
 =?utf-8?B?am9wNUtRMDQ2K0dyc3VLQnVLTGE1Ny9JVlZNYWZMTzc3UGhnWTQyei9XeWNl?=
 =?utf-8?B?Z0xEVWdEL0hJVFQ2RzQ2Y3BDZUxmUm01aUFMVlNLYlkxNTFSNDNYMUZQWm42?=
 =?utf-8?B?ZHFndGEzWDdBWHpKZURLQjJiQUMzTDBCQm8wTlVEOGREVVhteWNaOWl0emtM?=
 =?utf-8?B?VTZsQkh4TVAxdVdNK2Q0T1lrdDlmQnVtSzdva0RQZDZpalFnYTJ6TWh1Tkd2?=
 =?utf-8?B?bHdpNFB4SWFVa3I3MWFhUXluZVcrZ2tDakFuRlJ3ZytOcE1OOG9aTG16VkpE?=
 =?utf-8?B?LzMweTFIMkVKaUxOdDZLOVdOYlJOdTBINWFyMmNUWVVEc1poYWNKVVhOL1g4?=
 =?utf-8?B?MTJqaVVYZm1CVlYweEdYQ0JxNUpxcjVOVjl2azVMaXdESEd5akJxa0pGY0RT?=
 =?utf-8?B?Smh1dnlwRk5ZbjZGa0tVNWpJR2pubC8xc1dMYWJUc3ZhTFBwL3l0eGVnc05W?=
 =?utf-8?B?cXY0ZUVrOUJwTzMxR1gxdGpRWU93T2lLN21Cb2I2R3ExVFdKN0cxOFloQnp3?=
 =?utf-8?B?anpIMmxJZnNkbnZucU5PVzNqZ09VMStqKzVuTnpFanZpOUkrNDM1WVVvWFl4?=
 =?utf-8?B?YzQrSDllM0Y0U3drekhZSG1rd3BERVB3SmZWU0g4a2t5UVY2Y1pOWDNRanI4?=
 =?utf-8?B?SUVlcVIycXpsRE4yb0NsMENYMDFqTERjTkJiVWtremNzcWlwR0FsdU1yblJZ?=
 =?utf-8?B?QU9UVm1yNHhyYWtMZWpqUjhFVEpBZWpRV2xMSWtoYjNKZXdxUEIzcVhzWnAr?=
 =?utf-8?B?amI5ZWNuT1pTaCtkU0YzcXhoZXZDNDBDUDJwMXhjd1B3d1BWRWxuUC9yZ1dH?=
 =?utf-8?B?TmhBRGkzMUVPVFM4OTdRbEpvZWxqdEZrbUw1aUNjMWlySjljUHdaQ216M0pz?=
 =?utf-8?B?ejJiWENnVXVhY0UrRGpoWkEyM3lFMWR4UkIxWkVpUWE1cHhyZmg4ODRzbXNq?=
 =?utf-8?B?QythWTM4cTNWazdxTThvKzg0QWpkYXFGNlJsY1Jhb1FKWnFhNVBqckJ0M05F?=
 =?utf-8?B?Y0hBN25lV1VsL2g1MVl6QzY2dnIvb3FybitIS3pMWVJtcU1nSzkwdzV6b0xn?=
 =?utf-8?B?ZVNlUHVqVktPTEJzNlpNa1E2ajJQK1NBeGxjWG1SRjZvTkpqVEMwWnkySnVY?=
 =?utf-8?B?THZESm9OcEZjWTNKMFNyb3VhcjVET1djc2ttM3ppejc1aDREKzN0dEREdFpm?=
 =?utf-8?B?cGVpQVNyajhqWHIyRVhVMG42dTN2UC8wOTlJTXMzdEdtUUpWOEFGWmFJWkZ2?=
 =?utf-8?B?aGpqTmtvVm90K0pNeGtVWnovWlQ3ZUN0cXk0Vm1kN0ozM0grYkpPVTZMOGpz?=
 =?utf-8?B?WGNOMnVna2JSbkZ4R2lYc2FCNEIrUTVCNk1PZnJpZGRyMmhoVnVndUplYnNF?=
 =?utf-8?B?QU5EQlZPVnJXdlZLMnhqQkVndmdMV3NONi94aC9DOUEzazZvaENXY1g5OGJW?=
 =?utf-8?B?QjR2cVhFYUtQRFNsQkRqTDc5YXllaDdlNzlYRkhnTFBUMTRhNlkrbGs4bHVM?=
 =?utf-8?B?WkZFNFJ3NmNKTENlVFhSU3hwSVZ6WXZGUmxoWVdPWCtqZExSRWgyN25Kb0lv?=
 =?utf-8?B?TjFyQmd5VVJEZDF3ZXRnVkN6NmNUUS91dW00YTNxbGxxMDhPSFgwQW9HQnh1?=
 =?utf-8?B?cHcxU1JFVkZHZVV0UjRWZEJSc2d5QUd1SlNnbVlnRm9URThmUElibmpGU1cw?=
 =?utf-8?B?V0hneENIYTNwL2RoWThIOTZrUkpsQUp1VXAxNmh4SzZrSk1taURiYkRJT0Fp?=
 =?utf-8?B?T3cyV0JoSGZTV1lOaTBaVG1hVkxVNWhJNnJSOEo5YXlBTlV6eGZXY1pkdmtl?=
 =?utf-8?B?WkZDUm0rMTBKSFNPNTdyY3J6TS9Hb3A0MDdaUHVNem5FZjdmdHhOVnFKdDI0?=
 =?utf-8?Q?aYbaZF4k6YmqPMTuPXKBA2c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8642ea-9885-486d-f9c7-08db91d450b1
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:42:07.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GqH68WVOFvDxUIzc3W+FIMwBHT5ValvaIpAZX0pyUq+WBzy4hWTiBycWYR+Rtp8+Oy8FPXAfz+y0/A29hdjozrqjWQ18DZWAaqAHhLHhvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8920
Received-SPF: pass client-ip=2a01:111:f400:fe02::72c;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
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

On 7/24/23 16:11, Andrey Drobyshev wrote:
> On 6/30/23 13:54, Denis V. Lunev wrote:
>> On 6/1/23 21:28, Andrey Drobyshev wrote:
>>> This series is adding [-c | --compress] option to "qemu-img rebase"
>>> command, which might prove useful for saving some disk space when, for
>>> instance, manipulating chains of backup images.  Along the way I had to
>>> make a couple of minor improvements.
>>>
>>> The first 2 patches are a bug fix + corresponding test case.
>>> Patch 3 merely fixes wrong args used in allocation.
>>> Patch 4 makes write requests during rebase operation
>>> cluster_size-aligned,
>>> which seems to be beneficial for both non-compressed and compressed mode.
>>> The last 2 patches are the actual feature implementation + tests.
>>>
>>> Andrey Drobyshev (6):
>>>    qemu-img: rebase: stop when reaching EOF of old backing file
>>>    qemu-iotests: 024: add rebasing test case for overlay_size >
>>>      backing_size
>>>    qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>>>    qemu-img: rebase: avoid unnecessary COW operations
>>>    qemu-img: add compression option to rebase subcommand
>>>    iotests: add test 314 for "qemu-img rebase" with compression
>>>
>>>   docs/tools/qemu-img.rst    |   6 +-
>>>   qemu-img-cmds.hx           |   4 +-
>>>   qemu-img.c                 | 106 ++++++++++++++++++------
>>>   tests/qemu-iotests/024     |  57 +++++++++++++
>>>   tests/qemu-iotests/024.out |  30 +++++++
>>>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>>>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>>>   7 files changed, 415 insertions(+), 28 deletions(-)
>>>   create mode 100755 tests/qemu-iotests/314
>>>   create mode 100644 tests/qemu-iotests/314.out
>>>
>> ping
> 
> Friendly ping after 7 weeks

Yet another ping

