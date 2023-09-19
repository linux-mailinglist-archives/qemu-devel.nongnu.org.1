Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E94F87A5DE9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX1v-0008NY-EE; Tue, 19 Sep 2023 05:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiX1r-0008MZ-VT; Tue, 19 Sep 2023 05:28:23 -0400
Received: from mail-dbaeur03on2070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::70b]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiX1n-0002IP-Sz; Tue, 19 Sep 2023 05:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWwx3Fuu//jQ1UvcX12e3/txCnC5xazEQ17Mg637lKaXtQgmbB9Wv6bbaNFwRvPOVYi/0/LO7lUzw3iuoQDWu44uisaJGTDpdW9w8DetknBze1X0HU+ZfvyldnV+44YQKDJgHKt1jfLohklrTV/A3wyIqzYdpJrB8ZgAJvAJSUUlj2w3igVOC13mSFEtrio9MEc+JrOrTtvlh4z29P8glYeeELqKSMjtNBcwVyG9uXUQNQlHAB2ZMTow/3rMaBq7Dh+meKOEeRITZ+CTXjOGSz7kk1Q1nnU7WptH8MxGp7uakfZQw90dx3WiY/UO0Gn/Omh8FQ+mD6Eci2ftRyv0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5kqy7jmA3PjgtR6mJjTiSPiboMCJ4kHCjDu7ulnVo8=;
 b=iDIL++aATfeGt22CblLLZR8n85yrh1c2e2rm5yvTl7B4enzwEKMjYba+l8GTwNzJ5SNcfoSgYdyDdzwXnwz5ItXG0C1iiGALTbkO3IlBModU0xCNWKzjjtJ5ghj1xJN+UMTAYzIVlKszh61rJSWdfe0sqQlP5nKH7yOLqO9h2tKWC9do0SBPT6ComAsZyIHrPestVELaM9Q3tz10kLN/cqIpOKl1NSEplxTckXieQ8mS3TyaKi4ICMabwBLycVuYoQ97/ghgkBAfRO7REcIkN0/UnsFXyhoajADeZJlKD8ci/RUHePKWLAw3c9kPQ+NeNtEBGoOWQo4PKpYj3AVBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5kqy7jmA3PjgtR6mJjTiSPiboMCJ4kHCjDu7ulnVo8=;
 b=DmarEY6u1hd9loYk2IjoGKRDScQNHNKvryVwPMuAAAB7h1FJ8QAcfCL/BCGtZuAefhuAxmQFfR1GJjCj4CmwL0WCG2Hiaq7Y2VeQUVXGOtPxjN34RTuj0ClANV3fsilrJrPnDrCHg2lM4Ykat4ROpWdVG5NPlNWfzJf0gNoXtn1gnOuyCwJZxhEX7lnsNyKLGL36XUC733iJjw0ihA2Kl0BNMafAMN1iKXmzRal/d0w7umHDhWQ8Usx2MGYfhnT4d8iO+2mr0mAwX+y9WE5yVDyDTFxBmRllEQJniJOGj1XQBpFPFw6b01dCreBxhke0ZaLSPh+iF09FYb3NzRnldA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS4PR08MB7854.eurprd08.prod.outlook.com (2603:10a6:20b:51d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 09:28:14 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 09:28:14 +0000
Message-ID: <bd85dfee-68c1-eb2e-1455-2e01282b0771@virtuozzo.com>
Date: Tue, 19 Sep 2023 11:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/22] parallels: fix memory leak in parallels_open()
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230918180100.524843-1-den@openvz.org>
 <20230918180100.524843-4-den@openvz.org>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230918180100.524843-4-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS4PR08MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 861a5b84-ee03-4c1b-d36d-08dbb8f2bfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QzXwM8OC6RlMkUOfXgpOFZ91hWYD0Y369+z/LIv5aUiqzC27gEdWuuqzcqePCX0tbVH8DDCfLY0YLM/m/9i7Dnz0fERGqeEWOhf7fyTE08EYHS4ugX6AfehWH1m2g17UD/9fr0/OQauh0YG/iERKPuGbDqA0g0RovjuYUSA00BPZucYzkQtVBNwBLA5IdUc4aIWPBjgOqplRHrdDeKpJgCjciZDfpR7tPNLNew3NFGgh9wkCCtdQYGADHL137IsTimRWPXUY6FkIz177tbRbwtZJvDqJF7um2L5x38/NML6/ZIzujl7vv7+w+DBw1LTXsvlkj5MDCMFyFXDKDat3boLCdMeqkrHYNnxyspW2p0VssuQN3C3TndqPcuyGH95DREdjLJ5PZMtEifboLwpM1+6lZEW1fIoiKGxHOLFcXtCO5QRvdYIbUyKqqDDReLX0UDN/IONDVw88YTJqOgAyEYr0xI/NTc/NgtUze0ij2QDib8QgovJE2gWiBuFXT/4b6uZ8xezVA1J+02D4TL2Bamg5tp0DxEvyGwh8/iqHAe8/fw+AfBA2QUR/+nPYB3XE7QV55Uw53oXOo2cWCfCAZYk4EA9lfC4XeqeQAuFsCLoAZ48JTFk2Ld810aiA+798n26sDtX3EQ/v4dX9gBwWsHWH8rVpPd45I+p7FHY5fc/NZV+7qflsAv31BW0q78T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(366004)(136003)(376002)(396003)(451199024)(186009)(1800799009)(41300700001)(31686004)(8676002)(8936002)(4326008)(2616005)(38100700002)(38350700002)(66946007)(66556008)(66476007)(316002)(6512007)(83380400001)(478600001)(44832011)(5660300002)(26005)(52116002)(53546011)(6486002)(6506007)(6666004)(2906002)(86362001)(31696002)(4744005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smc1UllvZncxSlY5eVc2LzRIeUFEOEp3QldzYVRQemFGZHpTWDBkeERXTnNt?=
 =?utf-8?B?RVRMMmhSS3BOQlcwRDBKRFh4UEY5WEEvZXRLY0tVVEh4LytydEJzRGVVb1Fw?=
 =?utf-8?B?dEdVZFBHL05xYkJlWmtzY2luUHZyVzZXZVFhNEVtRG04aVNMTzU2Nm9CZ0Q2?=
 =?utf-8?B?bWJQaUV5Y1UydDZsQVJNYWtDMWFWUVQ4Mk1oWXVOUUtmb21sRm5VYzNTTEwz?=
 =?utf-8?B?V29LTzhqSDBhV2tMSS9tbElMazNRTEdmMUdmcGhIWlp2bTBLbmhMcmMyZXk0?=
 =?utf-8?B?SUZmR1lCVitiQlQxZ01jeWpEc0dyTzZTYVFmTlZ5MDNCUjkwb2d5TW90SHdV?=
 =?utf-8?B?QS9WUlZNNHJScHR2Nkp6ckFPL1FPNkplbEh2b2xENmwvR2VNK1NGVXVuVVBz?=
 =?utf-8?B?dzI1NU1jb01wVEtkUHRkUUZlanBiTFQxKyszYk40RzNwMU5aKzRsN3ZhK1ox?=
 =?utf-8?B?eVFCNW00bC9mRlZmK1NuSlN0YnpxM1lDY1BDMXdUaFFCMXFmWTErYXFqb0JP?=
 =?utf-8?B?b0lSb1RRcXJuSkVOZmd4VXkvaWVFejJ1akNidXdXdU9HNHVmN0JzWmE1NFNx?=
 =?utf-8?B?NFlad0ZUQ2ozL3NqQXhsaEdIekQ4V2ZHNzk5N1NIeThXRVNkdHpKWW9VVEMr?=
 =?utf-8?B?WXY4VSs1bGhpUnpvbHhXRlFhYU1ZbXRJYk0yWE5FVDk5VjFwUDVib3Q1dzA1?=
 =?utf-8?B?aTI3YmlTbWVFWElyYXNQVEpjMG0rM015SGJ0K0tXa1JNbVlaTEx5T0UzMUtS?=
 =?utf-8?B?cGpVbE4vWjU0eWVVTkZPQzk3VlcxY2tzRktyVVBzS09KR2d0NzJzeGRxVUg4?=
 =?utf-8?B?MWI4cmpuT1NJRlFDK2VuSWlWbGdrZTc3cjN3UmFwVjlKeFlUZ0Z3NGNCMjll?=
 =?utf-8?B?WXprN1FlVjh4TjlrZ0JjTjQzR3Z5SDlOM1ZNR08xdXQwQkZ4OGhJN20vRTRx?=
 =?utf-8?B?UVY3VFNHWktDUHAzK2lQanRDL1FZUEQwUDV0elNDR01iKzRBTlNVVFJQd0xk?=
 =?utf-8?B?M2RZbmlnbmMraTBtVzNzTWp3V3dYVE12V1JTQUh4U044YVJ4RWtCMDUwS1po?=
 =?utf-8?B?eFRiMkRJc2RXZzkrdG1MekdMUHp4SDErbkJodUpuNE92ZWNWOXluWjZsL0hz?=
 =?utf-8?B?RE1HdWI1WlkxNGxESTJkdjd1UlIrOGpWUXFMOU16VE5Xem9LL29GRnY5dW5R?=
 =?utf-8?B?bWlGUG9xdHpWZ0Y0dmc3RUFRcHhIUTNsUzJ3WFFJc1g2dzZWd1ZTZU14WHZl?=
 =?utf-8?B?TmRnaWdDeG1iK2Uzb1Mva2ZNY0RFMEZCWWVZd0tuSU5aNlJiVEpLNUhld3Zv?=
 =?utf-8?B?MFBtTmpkTm1lZDN0UEp3a2U4N3VvbWZVNEpkd1lvUVNzWGUrcVBXVWpEWVVT?=
 =?utf-8?B?d0FZNDVua3FMcjlpb1l2TytZaHRMTG1UVjVtT2E5eHc4SFB3QzZPS01Jb0xq?=
 =?utf-8?B?Y2gwRlRoZ1hVT2J5ajBJYUNWMmdEbWhyRVFIM0p1T0hRNDYzOERHM2NUTmpL?=
 =?utf-8?B?bGJEdHM0Wi9CYUFTNWtJVUdVdkhKNGVWUkpFS2w4WTdpUjF4OEgyb0ZJWkUx?=
 =?utf-8?B?c2UxMXVZOWZwVkVWbzV2TnJ1QVZFNloxOFhJYmlqa1RqRitCMTkyV3JiYVVE?=
 =?utf-8?B?Mm1sU0xwMFJhb1NHRFozeDREYlBKZjR0MENKaXpuU3pyaHhYN3psUXlNV0k0?=
 =?utf-8?B?VEtNTmJES2JISXk3eCtBSkpkZm1yRnlmeXVIak1yakVNM21uN0tqZVZTaER6?=
 =?utf-8?B?SkU1YzZ0WXMrblhaU3VnZHBOd0VCNE52VVhrQmpFS2loV1BVRGpXVzFjMEZz?=
 =?utf-8?B?bnlXdnhJM2g0ODlRZGlsalZwWVdRV1VUTTNCV2pKcEtUb0dZYmxLVEN3WWIw?=
 =?utf-8?B?NUZFVUoxY2h6TW5rV0ViYzQ4Um9FZXdVa0w2WlAzYnJ2SEg3S24zSXVITVE0?=
 =?utf-8?B?NlpYaVhyaCsxL1Q5bitTdnBJM2RPMDJoSEtuYXMzVUxYN0ZzTTMxTzVNRjZq?=
 =?utf-8?B?b09FUnFZeEZLSzVNQWRaSVRzR1lzOERpVmNBUWk1SXpjVEVRa0s3Z3M3akI5?=
 =?utf-8?B?eWdOMnRxWXNkaE9PU0ZodG92eE1DaW5CaEg2aE1jazlObWJaNlRTYmsySlcw?=
 =?utf-8?B?RFd1QlZpOXlXdVJaeXlpcVE3YWo3cVdPc3M5UlVEMFQ2Y0FibjZ4UEhRVCtx?=
 =?utf-8?Q?td5FCK/uV9QZHRtINVZl7AQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861a5b84-ee03-4c1b-d36d-08dbb8f2bfdd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:28:14.4977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8B7heGZkv6WbyJujVNjHAAJKDr0f6swk85i2ryZCiXSkMDy9sgiWJ2JtBntFSoBu9ld6VNCZNoAfhSzIE5v2Dy57BsCx9XhdKfqwpU0VXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7854
Received-SPF: pass client-ip=2a01:111:f400:fe1a::70b;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/18/23 20:00, Denis V. Lunev wrote:
> We should free opts allocated through qemu_opts_create() at the end.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 428f72de1c..af7be427c9 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1217,6 +1217,7 @@ fail_format:
>   fail_options:
>       ret = -EINVAL;
>   fail:
> +    qemu_opts_del(opts);
>       /*
>        * "s" object was allocated by g_malloc0 so we can safely
>        * try to free its fields even they were not allocated.

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


