Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE80F829D77
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 16:22:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNaOj-0004X8-PO; Wed, 10 Jan 2024 10:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1rNaOe-0004WX-N8; Wed, 10 Jan 2024 10:21:36 -0500
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1rNaOc-00061b-V5; Wed, 10 Jan 2024 10:21:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnFhl8CLt6EnwLankSfeH34y/GIiuAThKNb0UoZNS2BTaC6O8VIQYNKHXQkYprBRcmK+3qSVFeD8szKLjd17H2UgSj7OBIhehghWWL5uczjH0EnKdeeyerQUI4BvXwQNRU4KtVLV1+Q6q2p1VNIAFenyfliB1fXfQsQEjeE2v7B8kwNNeL3bSPJK2DTNSqUr4c+Xs2Gbkrco/Z9bMKih24VqVFEwRyLVQJR4/tE6TEZkkDZUhUDmjLlbbgKQv/ysyRCTgPLFvt9LWySESJ2UqHuD0FaqWp+54PEymhjVWE7nxNUcpKtIZ95NgFix2W/TOkFoNaflpkiYY8WaHrgd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK5ExxdgXGntOhJmPpaa5hfYnfOZgW8sYQ6yDgWqjhc=;
 b=X5x8MRVC7QAPVdcVsRJ1AqJ26R7/Pr9wzjbYYHQpSpbITqekYVhCEEIBZaN5lYgvlyOtBauEr+uGvvv+2V4jPrXSGA1Ojmm6oMDRGHUzHXfSp7htBY2kh4wXp+6zqLbqcbP5+KkVwBQVxOgdLiRoM37T3KsCEcYUEWK3+icddzFrP2Guh3Zhtu0wuhelQfAiLd5Tw5dm8vA4Kra+RYOlRrbBeXeXdjWd/4FZezRseZ83lYxrynklhywPCXMwPaEEDgSj8lvXT1PW8wdk5pblCJQcTWZP0JQbKj6Ij1WTzDGukedwdGmbiQgzdCCRg2ba89BVPIiMj6Tnww4DVag1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK5ExxdgXGntOhJmPpaa5hfYnfOZgW8sYQ6yDgWqjhc=;
 b=O9ddJElDiLnhJbjGvv30hDdGdi53xFOKPEDXZkfkPUPwpHgmKbwlKZnquyzYe47E+wwtGJXn+HRXaxb7mraPQU+CBxzYP/gbqwCwOI2evn8tLXJbIMM4zIBh5OkoKq9PQaNvOzjr1sTxynGKMrTf9e9aDugHwFVH322MvUP3gR0/rUz1hGXDs0RuWNYlQGKPEpNtOfLHuJXoMGgYRsyFGnSyHHfbo+6qNNkbDYlpBxvuBZXtCZiUfgvAEcYpprBMVYLxyMFAauuYTkccC19TFzcqSxwqRmjWmTDHQtn7h/Xf8EY+4ZaVJV+KsdCHlPvWsPlI47gyPZD35yVfo/zYgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from DB9PR06MB7818.eurprd06.prod.outlook.com (2603:10a6:10:252::7)
 by AS8PR06MB7365.eurprd06.prod.outlook.com (2603:10a6:20b:33c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:21:30 +0000
Received: from DB9PR06MB7818.eurprd06.prod.outlook.com
 ([fe80::9e26:58bf:b2c5:4bb5]) by DB9PR06MB7818.eurprd06.prod.outlook.com
 ([fe80::9e26:58bf:b2c5:4bb5%6]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 15:21:30 +0000
Message-ID: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
Date: Wed, 10 Jan 2024 17:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block/blklogwrites: Fix a bug when logging "write zeroes"
 operations.
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com
References: <20240109184646.1128475-1-megari@gmx.com>
 <ZZ6eB32kR-Np1BQR@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
In-Reply-To: <ZZ6eB32kR-Np1BQR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0132.eurprd04.prod.outlook.com
 (2603:10a6:208:55::37) To DB9PR06MB7818.eurprd06.prod.outlook.com
 (2603:10a6:10:252::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR06MB7818:EE_|AS8PR06MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f22dcbe-dc98-4775-c3f7-08dc11efd233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVngcCQNisQox6ih1IFdUTmJy6vVT0y0s1EjY5rkDt1yU+P6FvWVBRa7YS2G54Fr32N5U8Vz2xwP5TEL+rlKShAygjau6xWc2L+seupLHv6WfxnenYsj8INN00GRen8RsxKkysrkkuz+S+Sa+ngTykyL7LqzIQy2zcpYTq2qOBHGmM09DmBauKxkkg6VVE978z9yRvk3mFwpRByzgfaOiRbPeiUPxmKFewL0drLB0iUrtbmXCfYTWEcJK5uBYiTlzdmdEMhTRApGbGa+8n/AIqkU/43QeTvCp8AfvgoiH33h8Epo5f6HFzZF0IkETCh0IFlhWhtrWisjV4FlSzB9qHiG+OUtqWJuOemfaM1dxqFPl7KUYD4xlNNi846rxxOIpkWrITRjSFg7Yt1TAZYpWpDxJzeWKkvvwAj0QfQFGEyuM2kSII9GOe/F8YyC2UI/SHit8a4eVyO+LWxh6VL0Jd7lLXm5cz+/Sa6C3XF1DINS+m4T70Co+vgAilzr3dCOgUAi5XaiNoA9qppRWxghkohNgQ2zu3salzTa/5Wo1ee+Mkjg6FbxrEyNtA+JpUnL3LiAmES6L6ix4hHINb1biNIhFCoe4AKr99o96Cj9GvHA2VaMeUi1RxhNqnrQE17vjHVAMhmJO3WC4lqbQOVgUN1CEx5og2KgkLwqUa/fqwIHzDakfVM0ILk1CSQwg7uW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7818.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39840400004)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(53546011)(6506007)(2906002)(478600001)(66556008)(66946007)(6512007)(8676002)(8936002)(6916009)(316002)(4326008)(66476007)(5660300002)(6486002)(41300700001)(2616005)(26005)(83380400001)(31686004)(86362001)(31696002)(36756003)(518174003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFdHUHRSRWMzcDk4NWM1bm9NVEoxUFpiVVUyZlN3aHhmR2wyN09KVHJhVjlC?=
 =?utf-8?B?bmNreUgvdkxrNXdDTURqUFlNcERwcVZLZXNmN3EwUmRpQlR4ak12OFhROWww?=
 =?utf-8?B?SFVVOGl1N1lha1VYandibVF1L3ZURi9rZGRiWlFmRDZJLzE3eXRuM2ozRStp?=
 =?utf-8?B?VmtCMHNGQ0xFWkZLTEJ6clBhTUU0dWFIRkdpUjV6bEJDejlEbmthanYrUk4r?=
 =?utf-8?B?ajlDU0t4Smg1V0I3cGRzNVI4N3U3SVVwMGJZaEJpZlhaR3hGUXlrUVJER2I0?=
 =?utf-8?B?MmxBblMzbTlrUDBmUHNGSHpaT01uMzZGMWQxNWJxL1h3WElHeEtTYWZGbkp1?=
 =?utf-8?B?NzZ5MkM1bVZmWndRMmFVVlFRUWJHM3NDdUxYZXlQV0pWY0VCdkV2MlVaQ1Vr?=
 =?utf-8?B?b3JjWEVGemtOaFFkRURjOFYzTm1iek5TSTJ0QStGdVNjUTdUaCtYV1pnVWVl?=
 =?utf-8?B?ZlhhcU5MQ1BEODE1UHVCQjFsTnZCcEpnWlNOc3ZINStGMUVxVzd2NE9NckNt?=
 =?utf-8?B?TXF1NmpJaUVPNU9LbXhiNG93aUZSZmlvckNtdDNudTUwTDlmbDVucWJPL3hj?=
 =?utf-8?B?ZkxVK0R1Qi9Iam5zL0xGNzAvVjJ6NGlLd1pBRENzWTB2WFJTTUJvL2xjSE1B?=
 =?utf-8?B?alRnVVlDaE9NQWczK3QrbXV3WURDKzhKZzFhKytKTHZ4cWJ3WGhTK3BvU2tn?=
 =?utf-8?B?cURGVDYvang3bm8yNTlPRlVYWnFrVlhrSVFOemJHREU4bndVWlhndEhoMjZR?=
 =?utf-8?B?ZUZ1dlplRDlvTWo5eW1xeHJ4T1k3dFl4M2hHRGpIako1THVpRlhUVkVVUkNM?=
 =?utf-8?B?MkFhZC9uSWV0TGk4c3dzQ3laMHpjNVhWNVJXOUoxUTlsZDVBMXdldFJhekxz?=
 =?utf-8?B?UFVxNkdYVWxoWG16YUVZZnVhSG9tSTNKaWJ2NTVXUDVXcFhybXAwMzZScHZl?=
 =?utf-8?B?MUMyUTU2YkRvdXRKckFSZUIrS0JCREkwanFETjF0MUU2azNGYUxnM0M3K3U1?=
 =?utf-8?B?c0wxM3ROM1lDaHMySFplbGRIallnRFo3VWF2ZE4wQVhzdklKckpUSDMxdmVv?=
 =?utf-8?B?VEtNTmYvRjgrOVBjaTdRZnlSNEVLT3BZN2VoMFJwQ1VxeGpLYVhqWlB0K2g0?=
 =?utf-8?B?cE1ZTDlBaUx1dWVpanNQT2cvRTBmWUlwLzNmNXVjRndlbXlIVCtZMTlveFlH?=
 =?utf-8?B?QXlqVDFHc2x6QVpHWEZEZTZFT3o1d1FBT1hNOTgydFZwRHVZZ1dwSGdnUmRI?=
 =?utf-8?B?UHhZa1NMck1BbnpnYWNNUHloN05yUHhENWg4alV4Qm5JOWVWQ0h3d3Q4REpT?=
 =?utf-8?B?MCtpY1lqRE1pa1l2Q2lzVzdLMUlVZUM0VDZCOXVxUHJwY1FFREpaakF6MjF1?=
 =?utf-8?B?bnNhRFk3Wk1CMWlaU21NTno0aSsrMVlYQ0NlS1NFOE9iTFJNUm5qa1NUU3F6?=
 =?utf-8?B?M3ZXZURmYnFMbGJHNXdvL1NDUTBYa0xobGxQL1dvaTNNRGpOU0VVY1k3WDFn?=
 =?utf-8?B?cUppOWFLL3FibnFodUdrTU90Y3Y4aFVvV2wzRUw0bnFjTS8zV21ySkx3bFgy?=
 =?utf-8?B?cVlzL2JLbGdINTZMZUMveVVLZTBKTFFzR09CdCtoTlJyL291QVF0UWxKQkc5?=
 =?utf-8?B?cDFONGQxd2p1Y0MrZnNRckxMVGlzK0VSNTExb3crbjZNUVZ2Zzh4Nm9pY0Rm?=
 =?utf-8?B?S0JJT0hxMFhEWm9hT25pSFk2VTM0ZytFemFkanV6NW1OZVdnSFAxZDJ2THpa?=
 =?utf-8?B?NkhHQ3lSZC91bk9jaHg0bW1Vd1dmY3BLYlp2QjBMQUUyM0dQVjA1R1p0MDhM?=
 =?utf-8?B?aWoxbGVna21rZjl2SFJiSWpiUjJjeXFPY2dqUHoyMHhaRktRZkdDNkZ3Wmti?=
 =?utf-8?B?a21vcWVDZ0FxWHJPeEc5Zm9aT2JlRFNKU3lxUmppclVSU2swUXhNU3V5MUhl?=
 =?utf-8?B?Vzg4ZjBHRFR4V3YrVUV4WWNSYmE2UktqS0dlZTVNRmp6RnRXZ2U0dXlKSjJU?=
 =?utf-8?B?d2NMVVBtNUVDcEkyaVZxQU1RdExMQlozYzA3bVBXbk9NRFlhRFl4ZVkzd2RP?=
 =?utf-8?B?WFJob09jWHUwT0tSMlUvSU0wREZ5YUNHZUlmaUFSRFVpcVlxUml2TFBHei9v?=
 =?utf-8?Q?lAmM=3D?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f22dcbe-dc98-4775-c3f7-08dc11efd233
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7818.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:21:30.2334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfEoU/2wQAUSpde5o6+GZpO0uSDHRtx6Fbc0mku6MezcVNkX6otOnpR0G11mR1Zu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7365
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=ari@tuxera.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.07,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi, Kevin!

On 1/10/24 15:39, Kevin Wolf wrote:
> Am 09.01.2024 um 19:46 hat megari@gmx.com geschrieben:
>> From: Ari Sundholm <ari@tuxera.com>
>>
>> There is a bug in the blklogwrites driver pertaining to logging "write
>> zeroes" operations, causing log corruption. This can be easily observed
>> by setting detect-zeroes to something other than "off" for the driver.
>>
>> The issue is caused by a concurrency bug pertaining to the fact that
>> "write zeroes" operations have to be logged in two parts: first the log
>> entry metadata, then the zeroed-out region. While the log entry
>> metadata is being written by bdrv_co_pwritev(), another operation may
>> begin in the meanwhile and modify the state of the blklogwrites driver.
>> This is as intended by the coroutine-driven I/O model in QEMU, of
>> course.
>>
>> Unfortunately, this specific scenario is mishandled. A short example:
>>      1. Initially, in the current operation (#1), the current log sector
>> number in the driver state is only incremented by the number of sectors
>> taken by the log entry metadata, after which the log entry metadata is
>> written. The current operation yields.
>>      2. Another operation (#2) may start while the log entry metadata is
>> being written. It uses the current log position as the start offset for
>> its log entry. This is in the sector right after the operation #1 log
>> entry metadata, which is bad!
>>      3. After bdrv_co_pwritev() returns (#1), the current log sector
>> number is reread from the driver state in order to find out the start
>> offset for bdrv_co_pwrite_zeroes(). This is an obvious blunder, as the
>> offset will be the sector right after the (misplaced) operation #2 log
>> entry, which means that the zeroed-out region begins at the wrong
>> offset.
>>      4. As a result of the above, the log is corrupt.
>>
>> Fix this by only reading the driver metadata once, computing the
>> offsets and sizes in one go (including the optional zeroed-out region)
>> and setting the log sector number to the appropriate value for the next
>> operation in line.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> Cc: qemu-stable@nongnu.org
> 
> Thanks, applied to the block branch.
> 

Thank you.

> Note that while this fixes the single threaded case, it is not thread
> safe and will still break with multiqueue enabled (see the new
> iothread-vq-mapping option added to virtio-blk very recently). Most
> block drivers already take a lock when modifying their global state, and
> it looks like we missed blklogwrites when checking what needs to be
> prepared for the block layer to be thread safe.
> 

I see. Thanks for the heads up. I had missed this new development.

> So I think we'll want another patch to add a QemuMutex that can be taken
> while you do the calculations on s->cur_log_sector. But this patch is
> a good first step because it means that we don't need to keep a lock
> across an I/O request (just for the sake of completeness, this would
> have had to be a CoMutex rather than a QemuMutex).
> 

OK. I guess I have a bit of additional work to do, then. What release 
would these fixes realistically make it to? Just trying to gauge the 
urgency for the fix for the multi-threaded case for prioritization purposes.

And yes, holding a CoMutex while doing I/O would have fixed this issue, 
with the tiny drawback of killing any concurrency in the driver. ;)

Best regards,
Ari Sundholm
ari@tuxera.com

> Kevin
> 


