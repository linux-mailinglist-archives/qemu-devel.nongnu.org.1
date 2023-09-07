Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A446797E8A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeN6g-0002De-Ac; Thu, 07 Sep 2023 18:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeN6c-0002Bj-Uf; Thu, 07 Sep 2023 18:04:06 -0400
Received: from mail-am6eur05on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71d]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeN6Z-0000CF-B6; Thu, 07 Sep 2023 18:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb/hdcAEi+wn+FCvdOMHIvxUSrptwdkZdgdrp6o+i0VkH8faZ1VrHeFgZH0jT7XRVZVY+QmxBr8Se2rftMtbIVYQa5IWAonlEVPruPVPC373/xA+oLEnhOdL99jdQJF6WzBZT4Y+DezO5Ds8de3gOKfVL0kg7uyoj0xMmo8MJgIyu3vj1IEAwIXu3DfK5J30Z760ZLfxwWq40jqwbEyvssj9qT+7WW4c1Nxf/rNz3nArYBW4W6DbmHoIQHGdBVJ1EHRbsbTB4J3U5Fok+aR/X5ycZut9DK5FcaxEU+rB5BBvj2P50naqez1lnCZjbcgAFL4YOQ/mFQaebmMBP9By/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCNyse75KztQYvu2BX1TetRkN3KEXe1z+8HnkryBpnM=;
 b=Kt5JF/ey42QlPl1PcNDxPYhjYmO9Z1PbZ5+QSSPD8JIDRVqC2ZkGlyd141D+PAd3dfCpEqdlU/79Gom/H87bK4nBL/WciNupa1KFVz3KA7Rdhp73j/VGHVMi001uwGXT2F/7fc0akAR4KxwWhxGzDzdIZaj8o2ma2Dc9J7UwhJLWPhRueQiNRPWks4EihC9Urocry++TSCDY7LxzaLGxTDEij1Ybw6Afuj7+plI9DfnzMQwJylX3byF9eA2aaUwtcu2Er3YzURHf1MPzA5PpRJPyouYMMQPlrK+sMhZ8RJpfZq8nEd9HNNAaaT/ck89vMeI8WE09P5aBwNbIlEBy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCNyse75KztQYvu2BX1TetRkN3KEXe1z+8HnkryBpnM=;
 b=muQL7IERkdpavPTRx5Gd64+lu8BUWpz4hYf7dXcftS0yjIx8DO3dVW1EvWnfWF47PzytK/pLjP3QTrce7vrBYhcNth4RwjX9igqpOHLJTPt196Mckyosb6DCdxbx5Q1DJJQ8dWmYqTxcyniTyU9rvnXqBXrLKEYiUA15UN8IZRYMrWtMbS2Hqn//zQpcHHIICNSN4D+Q0PvkiqtARToTjb7X7CWlHEBylqwSTmow/M15iztDeXXrtpJKDANsBSOC2GiydGu2uQP3ZZGQfKRajZrVttw6c1T3JeG8BplOFLwR587sPci2jmgrgwZ0V39dOa+7FVFVWq9hQ/qK7mP2QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS4PR08MB8093.eurprd08.prod.outlook.com (2603:10a6:20b:588::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 22:03:56 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 22:03:56 +0000
Message-ID: <d794e7ff-535e-9355-17d2-385f36ca9db5@virtuozzo.com>
Date: Fri, 8 Sep 2023 00:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 7/8] qemu-nbd: document -v behavior in respect to --fork
 in man
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20230906093210.339585-1-den@openvz.org>
 <20230906093210.339585-8-den@openvz.org>
 <425v5322enzl7b3uccmxp7ugqvbtl6siqiiyqbe5zv57rc7pe5@jccxt37pj2fw>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <425v5322enzl7b3uccmxp7ugqvbtl6siqiiyqbe5zv57rc7pe5@jccxt37pj2fw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0121.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::19) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS4PR08MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a34d19-fd9c-4a7a-1036-08dbafee5505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+lfo9e5x7f/BdbxFjsxj9Zp2iqdw4TqgaIvkKahwDTuRxpzYpuQ4nhYgF6VVOHB1sNr17GedVVR5FnUMlHyx1K/KjGIrFae/5FDNsbJu0pHQIgDF1P1Sv4EcViaU4vYBJD23JwFJ9iS0MZlE4TvVF1ExswYR5C4bVK7qAz7u3KsHljwaF/+Wq9YbX+Qu7q8em1vk7zZafYQpfBJT3TbyDd6Y4vdIhLM+ah/uO4ZP/VQNNXgO7geD0Z7sWCpvHBEOKv749ZoDOtw3Rcx/3GgOhk9pK/WsYMOol9JmtbqSxPFwLNtogahFRtJ36Nk9dW/YCK0axVqzAhRcEmABGYBocWogJY4LzfWuWF9ppNy2MeQEX8HAC/v/aXSjjuAfGYmBF3XkKA5P4vb5ck1ZKFy4z5jPWeqAdjW45T8/uELWTjgdckS9GPLdxMd3ehZFxXzrIlq9lvP46Q21XKz16oWQJm4qOzjpzrNQdn3TXHKJB6XlhgrH0nVYI7PBApTT+IwWNzibhfzi4H1AvAzipdWaVJOt3ckVOmvt1Cjvf3+PPdhm0DGm9PJoiDZM535/fVkhr5Rx1vVp4NP9wQeSAWIF0FjB1vi6pUroz0uioo0B5eUooYABq5Vw3LnHMe3AxiOpLuFtEOOBB3efMBXFFMKGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39850400004)(186009)(1800799009)(451199024)(31686004)(53546011)(6506007)(6486002)(31696002)(86362001)(36756003)(38100700002)(2616005)(26005)(41300700001)(6512007)(83380400001)(478600001)(110136005)(8676002)(8936002)(5660300002)(4326008)(2906002)(66556008)(316002)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3d0d2FKRklEakk0L3IyaEh4VVpVeW5MdGJBQTFneHU4V1p0UXF2S2hvekR1?=
 =?utf-8?B?N2R1ZmJTZ09VK3hDUDgzMUs1VlVuSDFHRzA5NlJMaEU0a054TDVVZ2FyWEV3?=
 =?utf-8?B?d1hPZGNId0tMT3pMZlBMQ09ycTJqNU9nM3ErRnZ0bVRlc3R6ZlhTSG1zalVL?=
 =?utf-8?B?RTVwSjVKNkRoMGZhV1hGOWV6b0x1VWZBR25pZHZObGswR3FjTW5lM0hFRDhZ?=
 =?utf-8?B?VVNCazQwQkJscWJoSU5IbDdYSC9sQ3lTQyt2b1hNRXFycGdWdjRjN3gzN04v?=
 =?utf-8?B?WWJRWUxmcktHRmNNQXIvaitVTUR5YWJNdktmSU1hOU1JWjJudVNra3gxT3cw?=
 =?utf-8?B?aFZLL2V5cThtQ290QnVMcGdHNEphQVhkT2JyNkhmZEZ0SmkxWFB3Q3Vsbjh1?=
 =?utf-8?B?emdRUHA0VkRSYlBiTEMxSkJUTFVhRlZDd1JKUncxUGhrVDNIVGx3QXAvUEhQ?=
 =?utf-8?B?a0l4Uzhwa09SVlFVUnJQYUtSd2pRTTZmckNCSHhaTm8xbUlBcVI4aTBzbkVk?=
 =?utf-8?B?eHVSeFNWQVVqMWhXTWlpTmVsVG0zajc1QWRGK0pPQ0FqLytERDA1QkhZYXNP?=
 =?utf-8?B?eEMrdUFuS3JEOUdXUjlyVDFpNVlQS3N6d05OWFVIUFV5NUpac1h3TzMrR0R1?=
 =?utf-8?B?d2o0U3p1OVVLR2FhbTViRmxjQVFsZHZnKzlUeXg2cUx2RTFkZFFESFpUM1lB?=
 =?utf-8?B?NTNybVl4RGx5aHlCOEhxZ2oyQy8ySE1SdzRtQ1RVYTJFTnRSdUZqTVZBZ1Ni?=
 =?utf-8?B?TXJHSDBSeTRBRHh6bmNYNUh4bXJWdHN3QzJMdWtIVXNYRGk0cU5ReW5YNlFI?=
 =?utf-8?B?UEk4T3lVeEsyRDBtK1pwNHdrdXZ5d1JsMlBYMW1seHg5ajRETXRhcVBhUzdB?=
 =?utf-8?B?aVRzQStpZndQM3R2QytYejBiTmk2bzVaM0t4QkIyYkFmNHU2N2ZPQ3kwRUho?=
 =?utf-8?B?RXZybkcxQWRQN3Y5ZURxSXdMdUx3U3pJZGlSVy9rcDVSMnRaK0o1aWR6dTBN?=
 =?utf-8?B?SE8zVExnL0gzYWFOQ0thS0o0RkJxREVrdy9KN3dUVEhpRlV5QTFoQ2xZdjZK?=
 =?utf-8?B?ZUlOWGRoeU9UREgrZjh2YktWMTc0bzhHcUxrcEVEYVdxbURtdnBJOG9hRkZ6?=
 =?utf-8?B?WlR2SisvaDh1ZFg4YUE1ejNQUldVelY2eC9rMUN6bDFSNG5PUmUyaXhmWEJY?=
 =?utf-8?B?UFNVaTZqYVlMbTJnaGszc2JZVVFsdFNvLy85T2Uvam8yM1EzNm5VS09ZTnFw?=
 =?utf-8?B?cnh0bmNVWGFsRUVobnE4eTJpYm1ibkhQaFhCeHJRVEpNRFdOSlhTd1RNMk1F?=
 =?utf-8?B?NjI3OWVUbU85YWlWa3JMY3RWS2FQWUtQT0pZUHJWSHpua3R5VWJpT0E2RnAx?=
 =?utf-8?B?QW1RdERkWGxIVUQyeUpLZ0ZYVktEU1p4VzBUeS84QnZLaWh4SHN2c296emt1?=
 =?utf-8?B?c2JLbWtzNDVLRU1lbVh4L3ptRC9PMktNeXZqWFJYM25IMDVTSHllK2REVnhL?=
 =?utf-8?B?cENQdklzYUYvNnQrZXdVZktJcVdkTFc0bTAzV0o3a2VvZHE4c0hjOGp2N1dZ?=
 =?utf-8?B?ZHhzYzBvQkRPbHZPWWtaUmo4dlJSYVZONGEwU2JldkF0d3E3SnAxczh2QW5X?=
 =?utf-8?B?UkxlaEJXQzVaUVpsMERDRTNlUUk5V2J4cDJxTU50RFhYTmhsT0lqc2xPWWtu?=
 =?utf-8?B?dVg1UTBOTmRsK1NLdk1iS0xXWFpxUi96Qkp3ZEhuWTFmOEN3UlExczVBWTdK?=
 =?utf-8?B?WWN2ZTdpZzc4VHova2RDc0pUMGFlNVlXLzNIU1crT2ZkU0JKZk5VdmdFdGF2?=
 =?utf-8?B?MTFkTGkzNGJuWXlXdklkVFg5OEVBTnVhY2RqekN2K1VoWXhaNmJrZjNRTndr?=
 =?utf-8?B?UTNrdjBEaThCcmZYd20zd3dJbERlemtNWnBRQ25VNVhuWmpCdUFRVnhRUmlI?=
 =?utf-8?B?MUMzZUZpcE81WlI4MDl1YVgyYk1iMjUrOGdoU2R4SFlkbFRlbE5uTHdHYjM1?=
 =?utf-8?B?SGZuSXRqbmEvbTE2eTRCZU1hWFJVTnRKTm5ncDVRT2xlb004NXhzUGZ4WmtI?=
 =?utf-8?B?Mm1tMW5ERnIvY05uWmZ6RXhRNUFEK2lzTmJTdjQycEZ4U1BLeDRFSHdIRm92?=
 =?utf-8?Q?quHPqiaoHb1beA109ezaAZbJR?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a34d19-fd9c-4a7a-1036-08dbafee5505
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 22:03:56.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB6T7+nMR801qoJhtvX9rndQjzvNZGDifdfoWcdGR/VHMEd2KAyzKmjb893cpzAAzwJjLfrO+1Ie760Rb2sPFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8093
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71d;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 9/8/23 00:01, Eric Blake wrote:
> On Wed, Sep 06, 2023 at 11:32:09AM +0200, Denis V. Lunev wrote:
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   docs/tools/qemu-nbd.rst | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
>> index faf6349ea5..5c48ee7345 100644
>> --- a/docs/tools/qemu-nbd.rst
>> +++ b/docs/tools/qemu-nbd.rst
>> @@ -197,7 +197,9 @@ driver options if :option:`--image-opts` is specified.
>>   
>>   .. option:: -v, --verbose
>>   
>> -  Display extra debugging information.
>> +  Display extra debugging information. This option also keeps opened original
>> +  *STDERR* stream if ``qemu-nbd`` process is daemonized due to other options
>> +  like :option:`--fork` or :option:`-c`.
> As a native speaker, I find the following a bit easier to parse:
>
> This option also keeps the original *STDERR* stream open if ...
>
> I can make that touchup as part of queuing the series.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
That would be great, thanks!

