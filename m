Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60C7A4465
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9SL-0000Sn-4R; Mon, 18 Sep 2023 04:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qi9SH-0000OY-Ux; Mon, 18 Sep 2023 04:18:06 -0400
Received: from mail-am7eur03on20721.outbound.protection.outlook.com
 ([2a01:111:f400:7eaf::721]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qi9SG-0001eJ-Du; Mon, 18 Sep 2023 04:18:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtEEcLXeNFY0NY1PSA4uHmfnBVAWIgHts0pPsBwr5Bp8CGCGaxuWMi2w6188HnSIvhO8jmMHVCkfHZsvogqy/4IuRcgBmPF5oejgYZHMLrPWduczsSCWQ95WNUmVGYgb1fQ5HG/s39oZAcjYbPV/0W6fRMunidcORtNTnZcWlg9U+IZplaG3oyvfbw1AAJpTvC0NHuPmUpZZ3QEDvPxnuuCOdiUL3mAnvfTECr0fdvJcYee6P5xQMRt/4ewE+YbZRvyHkzt2tEBNPXWkGAHZVTbiwjHEx2LmBzOG+Q0Tf9ORDW6R+TtRpmI0+fCR9NDSZlXtJa52wlcIWU6p6/d8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzFjpFNM1O2PQGUpiB/RmKDZ4UYDlDqaVLcfk//SeuI=;
 b=Pi956Djk6DArEnqkWoiHjQXwSFAOd4eNMyIcnt2o//PZKmuQQp9aUpoWt2WfZz6iY0C5R5a8xKGpE5++u+Wp39eS5MvRWJ3yBQGj3SZqgjEokENinicAeXmGTI9Pw40GmUn4zZb6jHIJHsPwyPW1tk+FJhRmDvk8nYjO80KkvVG3Os6PIgKR3f40HEKmKdB36mhholRzD8dIR2fSlseloNVs+aCdariAt9Tbeld9Z2Ec7euFcYkpmkMp+88vr92TvIyMnSecdN2lLPeyVumzCMDY0Q+oJuHMdRkxnPw8ueEtVWT5HH4uPmmLsbCaUPRhLryBS9CnhH5e4WWka2Eq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzFjpFNM1O2PQGUpiB/RmKDZ4UYDlDqaVLcfk//SeuI=;
 b=yedjheFapq0QTzUYPXX5lyzpcjmEF4Z2ddignyT6Jgy/QgrGOOM9XF3wmuupNnjiySZiyYq6RTc8rQOvsMb2tfqzclaRj/H7sV9uPkU8FRRdRjPO6xWa9gVL2X2hcwT2Wd3QLzEBbEWZzKq2FfJvSlyAIiig0z97w9pIU5wsPn0BTYFcrL5apjVI484gOMnBN1bPIXU5DFaqqwj3BkQNBnUX9e+lvLRia6YhTU/w8aUBynM0OU51yMzBkjM4tqmv/NNE9I67IeFz9peuWmxygWBIMFxNRmBpnpt0hVku91GhStjZ/fci6OcQYSgiBGE8aswztuS0xDrYKxHuIRstdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB9454.eurprd08.prod.outlook.com (2603:10a6:20b:5ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 08:17:59 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:17:59 +0000
Message-ID: <ddbd9721-58a1-038d-0465-148f8ad54112@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/21] parallels: return earler in fail_format branch in
 parallels_open()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-6-den@openvz.org>
 <6e54ed39-bc33-887e-9585-d7fe04a1bbf2@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <6e54ed39-bc33-887e-9585-d7fe04a1bbf2@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0025.eurprd03.prod.outlook.com
 (2603:10a6:803:118::14) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b0d9be-f6b7-48b5-fd83-08dbb81fc549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wG3aZMZ7owYV+SNpxxZxrdpSBWwzAztmoXSP53TWMqR7U9mg743bArIwLZPZn4BZlIguU59cYpS72+Irirxl+J4PLMb9YdRoaXSZ8KmQ2IETSPtst8ayl6BSOnFmF3TSSxlR5d/rELqsGa41CVx3aRBjQmKcQOfPtiM/pWVqpKuwVIWHQvq7C9Qmz7jrVmuin7c+pvgeuKicIoUVXuqaMlTGhU/2l6ECHQFw4wUv/KhuV3M7YUunvvZBzkD+gcWxL5TdMLRZh2dl7vGt80LNi6gZx2JBqilw33n1Fj5M2AJmRxK8wbYj77CcNzvv8EU4PD5qkW/Hb2mF2eD6soWEpPK/uY2HwiGufX3h0EhD6dfbNlpdKKkk4ZxokvWZk9yRBisUEgitHXG6WWI60+rZV+SITbsEyfGiuSucYOp2dLHrvDGSHVLUjQEUWkdueF/IKvI2Dl29z11te7jEN6nweBrKAkkZ38m2/1yrW8EVbRG300uXIpDeil3Ss+1hrXvYstY9H/zdDom9nGc0B9LBY352fyKu/mNX12w0MdFBHFl7J0mJJeqy9aSMpCP88kUfVMUQ1+Cgb5FBEF4zROPrnuRxu7puXM1oO880M/Bl/LMafARZAC5+au3F7R1uOE1xVr52OimvgLzMmQNm93AfrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(39850400004)(376002)(136003)(186009)(451199024)(1800799009)(478600001)(66899024)(4326008)(8676002)(8936002)(316002)(66476007)(110136005)(66946007)(66556008)(36756003)(5660300002)(31686004)(41300700001)(86362001)(31696002)(26005)(2616005)(38100700002)(2906002)(53546011)(6512007)(6506007)(6486002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JoemN3RUpRYWh4K2lZVmpPekZQZU5DSzZiWGNOQ1c0U0E4ZXFIUkNnSlo2?=
 =?utf-8?B?V0RVa3EwOHNZejNWOEwxQ01KYTRaZkczV0UvcHFuTVhNRlBVdEJzVmdJVm1W?=
 =?utf-8?B?akFwY3VvdytzNnlrQVNTZU85ZG8wWTFYZVhEY3dGaW1nVzVPVXZHMFhIeUFU?=
 =?utf-8?B?Lzl1VVVmUFhPMHh0Y2NNbGFmR2krc3hhcmFXNHlkaUJ0K2hoMW1tRHM0amNN?=
 =?utf-8?B?Y0RPSlNvWEpHOTgwUzNXRDdKUExCdllBVFVLOTBoVGxxS1FMSURKb3oyMllX?=
 =?utf-8?B?d2RKZGR3N0tNeGtueE9IY2lSYjZyTHdyeTQwKzR6aFRiK0Jud2prdGtaT0tx?=
 =?utf-8?B?V3hwYUR0LzVURy9UR0E2N3hrZXhYU04wR3gyWFZTRHRNV1JoV3hmdWVpVHNE?=
 =?utf-8?B?MmRua1dHT004Ykt1YmQ1TkxqKy9VRlNLMXdHVi9tT3FvMGd6NjlQNXhBREtV?=
 =?utf-8?B?aldSL0tCZzlUUVNMdXhpR2JsUGRXTnRIb2dKeGhWMHRNOFBjeFZsblBaVmxn?=
 =?utf-8?B?NXRCdlRZVlhrV2g2RTBkclBETnhTQXJmTUdRcERmZ1dhcjNqbEVEeDBsOHZ2?=
 =?utf-8?B?d290MkZsU2h2ckdKNlJoZWs3WnppQ1dGZGRwejA4cktSaGRSZFpFb3B0ZG45?=
 =?utf-8?B?T05HOHJmZUUrWk9YV1FGK09OcEEySjZvSnFINHd2MU13aThkMDZ2SU1DUmtp?=
 =?utf-8?B?SXNGYnU3ZkRjcTdYZDAzZDFtVnRiNXBRVHFPYS85cEhkRmNZUy9UNGpscUFz?=
 =?utf-8?B?aWNJQjFNMHc1eGUvQVJRWTZHUUhIMGRPOEZTQ0tXaGw2Tnd4SWhuVEJQU3hI?=
 =?utf-8?B?THZqVnRPUTBpS1J2dmZNL3F1WVNUOVF2dVRMRkJRclBIY21CbTF3K09jRVgx?=
 =?utf-8?B?T3FxeUwyUVVvbWxoZDNhdzNHUG5lWXdnTWppMFllb1MxN2tlL1lmNndTeDBx?=
 =?utf-8?B?dDI2T0UvQXI1SHNUd3BaSC9DVVZNVUNyZE5WMlBRZG9lN2NwalFOMzFkMjht?=
 =?utf-8?B?ZDgwalN5b2tGbWVOWWh6U0lGR2N0OVM3bEhGOEZkR0ZsVE9PTGszd0dFNm5G?=
 =?utf-8?B?bmpvM0FrTTRucGFOdi9CWkVxbzFnS1E2VDd4RFlib2g2QXA5TWtnSFFLUk1m?=
 =?utf-8?B?YVQ3bFljTHJVbWJma0ZHTkk4NUhHNnBubWVnTjQyMWt0dC9kK1JjNjJLdWl6?=
 =?utf-8?B?OHdtSlpCamV1S09ZOHJQQXNTYzlENjlhZjZxTHgxMUo5MFhPZFM5TUIrUmxZ?=
 =?utf-8?B?YjVTWG5yL0p2QlVDVjRDSzVSNmRTdXc1VkVLcTE4ZHRTS0xJekZtZnd1a0h3?=
 =?utf-8?B?N2xCQW9YL3BpTGtyLzdMR2JXRll5QlYxaWtrNTg1V2ZVSGJVdGVFWWNYazh1?=
 =?utf-8?B?dUxKcXNYcXVtWkk2MTR4Y3d3SytpQU5aYldQdmkzSGs3ZFZnZVhoSGJmVkxs?=
 =?utf-8?B?OXlOVXlQdmN3TTBoNWJHYmRGUGh3VnA2ZSsxMUo3RjZraVFEWTNVcEJrbEZ6?=
 =?utf-8?B?NjdxRDQ4RWtKNEkzVzlZdTJyVVMxUWo2UlhZQjM5dFNRbGRKSWF2UjAzM3RX?=
 =?utf-8?B?RVNnS1h0SWE2WTJ3Vnh3aWc3WUVIaHlLblg4ak80VkxsRTdnN216akFRMkZU?=
 =?utf-8?B?b200d2g3MGZrUHYzT1pKMXlhU25UWVlXd085eThVL3U3TXMwenFnYlU4UWF2?=
 =?utf-8?B?YzR0R1c2aXRiSUxXWFdSb3VFaDdsWkM4SjJJYzYwU0M2MzdSQ1hXTlBTaytw?=
 =?utf-8?B?Q0VHV2FmK2RrY2M4MGxLdG02Mkl6bmdnMTlVY3BpWHpKSXFrc2RhZWd0OS93?=
 =?utf-8?B?K2ZlVVMrNmlkZ0VkRCtQTkdFMUxReE5XNjQ4VUlrK3NITDczYVJBRnVqYnV1?=
 =?utf-8?B?S0pQTlh2eFRoTTdhZ2Yxc1M2cXJwZFpoeGJFblRuaW5nOUNkek1pU1o1dFBt?=
 =?utf-8?B?NHBqanpNWkYvbERtaUNiL0h2RkhXUlJQaG8yVXBjZnhkTlV3ZEVGYlllTmkz?=
 =?utf-8?B?dmZoQ0t2MHdoNERKdUNLOC9NdDR6QmJ2Wi9TaUplSnFFMmp5cGdBT3E4QXFj?=
 =?utf-8?B?MnVCWUJOSURtOUFtME85a0pidy9JdW10eTFSZHIxTFdEMnl4N3ZEYjkxamNx?=
 =?utf-8?Q?SdCHlgvrMemM7bMIpA19GBUpA?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b0d9be-f6b7-48b5-fd83-08dbb81fc549
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:17:59.7472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILKnhBU/MMApQwGNVlpOgUHwJqghgO7YgQZdL9Ggn4FzPIhsM4zS5J0a17grsp66P9+fGyEim0xHBon+NZy71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9454
Received-SPF: pass client-ip=2a01:111:f400:7eaf::721;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/23 10:14, Alexander Ivanov wrote:
> This is not the case with this patch, but it seems that the 5 first 
> "goto fail;" could be
> replaced by returns. The first allocation, freeing at the "fail" 
> label, is at 1127 line.
> The next error handling and all the previous ones can make return 
> instead goto fail.
>
> On 9/15/23 20:41, Denis V. Lunev wrote:
>> We do not need to perform any deallocation/cleanup if wrong format is
>> detected.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 1d5409f2ba..0f127427bf 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1226,7 +1226,8 @@ static int parallels_open(BlockDriverState *bs, 
>> QDict *options, int flags,
>>     fail_format:
>>       error_setg(errp, "Image not in Parallels format");
>> -    ret = -EINVAL;
>> +    return -EINVAL;
>> +
>>   fail:
>>       /*
>>        * "s" object was allocated by g_malloc0 so we can safely
>
see next patch :-)

