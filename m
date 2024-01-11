Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65782AF00
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:55:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuYy-0008LS-Pl; Thu, 11 Jan 2024 07:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rNuYu-0008Kl-Ul; Thu, 11 Jan 2024 07:53:32 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rNuYi-0007Yv-Tc; Thu, 11 Jan 2024 07:53:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCIWF7/rRCEqWbcbMWzg60mPS+P2fWpPF4XZMVxLS/X9IlhEETZdQ+HDNbpSu5HNyy0ISFQoRnxWNKsdKDxfANMY97P63vbfnMTo4mGg6ZTmoRUOghXVXUYoF27TKFyZhdeiiiPIOOfNsG0GwqJa85ds06ba62JSjhu75KgfaBHe+gv2CN6VUbpz4sI/Ouqu34Xulb1MLufQxkzEYcgkTlhvweB6UilguLWSfxpjR6B949jAzwm4p81tL9Qsg7w7OaNq0Qx7idOFmUXYaE7E1cLoH6taOJRhT++JBcJBbny6Chc4DMVDq5/QR0ji/BgyxOQq7vwoXxoT+NICT1BhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOden6J9BppNg3FeEgsJhjwVbyhcxE/C8/znp5JRy+4=;
 b=F9Sm7PbPtz2CmXyOccF/I7WLP1l1c5ZxdR56Mr+anVhDcwYrrDmboqg7qmCtGwQm6W73Kcu/UuwqCDRVPMWjBeGiHQc3ESkJY2ltflSXW51EpymQZftZfNjTeXbXFMdtJatuRsnRajC4vpv0ZZ4YYnvS0EuPvi8/0LJOr1wQq8B/vPVJ/DuK+56eD3iIdsaLQ1s4+iAv3bdL3izkGFiKf3Ls/VMo00gBtZwCSxVZqk7MJII8+GGbX4gsjI0dCC3ierPIHsi58mhd636FPzac/encezHep8ymQF5muUzTbK45KWxLGjHZ1Rclkwb7F07UK8b5zPFbIV7vIWHmuowRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOden6J9BppNg3FeEgsJhjwVbyhcxE/C8/znp5JRy+4=;
 b=Z2Zyz+O0v2Z4MkDEvfne9FmK2wPsFObXFpsYNVhSbIpGSiCNs+lyTqVx+1vxCebqwPgWMyzf/RTZOld6e9j075eRjQ6ZHITS2hWHEzuMI2tITsQ5zUtKD9Y5c+LVBzS/CTwPMy1C16OORWbUdOE5fQk66w5cMy0UXKyzxkiLukc9Cb/o3YpRqvtsH20zGZDMv1wgaRcnB5iyIuU5zdnRs7ID+oZJxPUT7p9XwiVHSn8A0m0Ysbe3bg92kNaKe2nndEPz0YxjDnxYna6YAvMD29rayxZQdfRj8qI7zI4waARbbWAtT+DShRllpWOswCgTlZv5vX5POmPR8nVtTr0ZjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5634.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 12:53:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e27:1464:bac8:f696]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e27:1464:bac8:f696%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 12:53:16 +0000
Message-ID: <78ef37d4-a4de-4481-8630-26ae9bbcdb63@virtuozzo.com>
Date: Thu, 11 Jan 2024 14:53:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: allocate aligned write buffer for 'truncate -m
 full'
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru
References: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
 <c197c97a-e296-45fb-ad8b-5ca5dff81ca8@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <c197c97a-e296-45fb-ad8b-5ca5dff81ca8@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 9997bda7-744b-45c5-cd7c-08dc12a4475e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrZQ1H7T9cYYVnWHwOb2O7p1PMaBIDQ2RlUub82MmhgFj5TO3kVHg01/9i3ru+OY3zyj5BFJkodCY5zWHVOFEQvgybbgvOinqDKP9Lsv+OXXFyCLb+sDxwi74qpUkGYYS960f3++3V9EumI5EHRszPtTM87khEi4sk2Ln+7Tj2iruLyM/fFh3dVTurNUD20bXa9ly7RoslgFyvIf33cGcXfC63Vr0r4d3IyQyTbw6ja6MEdetrx5aN1r1rZa2K8d4VZOowijzo9zRaoHkuqiV8xtq5sSsR6R0Va6IMnDje9a/azC4xw0Q/wr8yjFO73KVhY0jKDBG3IZlz5KhNsGKA0Vsy6AeLSqrydcooRK6KdSzh9/hQWsRZMfhLpb7/FUvtWHVafwVmmKhGjRdmJKPX6LegGUsGvVym+3jG/Cnsoa23gD38ltXNvCt5N15YJ3qlhiFHhp/kPVjpljpaP0KmWhHFeL4mz1eYJcT54LJnM/g5KWC6ZUCFaMGDi17DH1fgyCT0x0IMk4KgfDp25TOVheA5l12g2w+YILmdnboQ1eMKrsc2B4j/8feRFDfAgQkPI/0sO2P/CaYSs4JOTJl9cazb07eczvesrlLeYsHZtAa5VlAMSGktLCs47VPo3XQHQS6ccEoqlx3Onjal6CLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39850400004)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(478600001)(83380400001)(86362001)(316002)(66946007)(66556008)(66476007)(31686004)(6486002)(31696002)(53546011)(6506007)(2616005)(26005)(55236004)(6512007)(4326008)(8676002)(8936002)(5660300002)(44832011)(36756003)(41300700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RHK0U5Ti9lcXhnUGFwejJwc0FRWUpkbHZQYThQeVV6VDRRZnppN3NHTzgr?=
 =?utf-8?B?aFUwbm9OY1BETnRucDg2cUJ4YWxnY0h6NC9tV1djVXM0cTJZZ0xub0dPYXN4?=
 =?utf-8?B?ekIvd2xPMzVHR1VjVHE3T2lsamV2VWdSTHdyenE4S2VOK3dldmxGRGxYZnNt?=
 =?utf-8?B?Nyt3V3Y2d01URXB0bUV5aWRaMENlV3MyQzZVc0p5NDAwcUxTMHZMSlpnR2pZ?=
 =?utf-8?B?S1RHVjdibEU5d1U3TDJIRWxRVVpncEF0eFhwVGc4VkJYc0doVEJQOTE0ci9T?=
 =?utf-8?B?TFRLTldNTUVueWJnUmxoVFQ4N2luMFFNQlM4THhpYUhKcDlFV0p2NDk3RXcy?=
 =?utf-8?B?QjBkK0tweHRTRzE2WXRPNEl0NXZxQmduSm8wK3NZTGVBSHhGK1RKSVdadkMz?=
 =?utf-8?B?cTR0Y3lTa3hFQldCWjlKMXN2cXJHSCtOZkxJWnJ6WXRyeVQreXdncUx0aHE2?=
 =?utf-8?B?dzhLVU5lWFJ5M0RrTFNwQXdwOEYreEZsMWNsSDNFTkNNTHhWK3hrWTRyZkky?=
 =?utf-8?B?UHA0M1JQclZXb0sya3QyYmRraTdCR09aazVBeDhjNU9kOW12WWtQRFVidkJu?=
 =?utf-8?B?ZkxHeks2enRvWGgwdnNiR1p5ZWExdkpnUTBJOTRLYmYvcHdFOHozekhDczRN?=
 =?utf-8?B?Zy9ma1JEVFQrci9iUVlzRTNvelkzSHMxdVdGeVFydFo5TWdhdS9oamtTNU84?=
 =?utf-8?B?YTBKRDRFeGVHTnRUWWp4T2RtaU5jUzN5cXlOSWZQV3A1cGZhL2t6TGhRWjl6?=
 =?utf-8?B?Z3d4QXJvQXM3NEcwajlBQ1JVQ2VBeGNVQVluVGxBN01nQXlJYVVjYStmekdw?=
 =?utf-8?B?TTY3bklTYzhaeTAwSWlLL1BhWUJBTnYySWpRQ1k1WHAvUEcyZlVUTXZiV3Zz?=
 =?utf-8?B?MllNYTEySzlQcmhlaHROTVlVT016Zk55ZUljajFoMzNKTTVOelcwNHdpUlpY?=
 =?utf-8?B?MlFtRG1yMSs3Q29oR1IyRTBaUmdkL1ZlejN4SURCRS9kUXlwRjRidWE4SHFV?=
 =?utf-8?B?RjJXdWc3RlhaaUNTSVEwTGE0UFpvTHd5QzRlM0QrbzVNWG82MHRiRDlVUkdp?=
 =?utf-8?B?T1VuSEdIemtzaEJWSTdKTWdYMy82VlJLdGEvcE9jYk1VaTlsdHowM3F1aDl4?=
 =?utf-8?B?STJvR2p2MmczbXhzWUdZV2xNek5uRWZTQm5Hcm1uKytYN0F6TDZYRHdLNU5z?=
 =?utf-8?B?N0JDQmpWSTVRYkV4ZnE5ZE81LzlaS2h0c3dRRHkrcEhraHlnVFV4QWk2dUMx?=
 =?utf-8?B?ZjJzMS9rc0ZGc2lkNEh1K0k2YUhnbTRNWjcrSytaTDBPa0hTeUpqN3ZZWUxx?=
 =?utf-8?B?dWFDUFBNaERIRlBhNnpLeW8vMmlLWnhQYTBmVDNzeFEvUzM1Nk15ZE9zSnhU?=
 =?utf-8?B?c0dFNnozTzNyaXpyRmM1M1B3SXMwTW9Ec3p3eVFYdjdvWGFkNEdRSXh1Nngy?=
 =?utf-8?B?Z0h1eW10N3phUENrNElaeWlEQWtFS1RNb2xmajUvSWpZV25DMjhaM0V0RnNn?=
 =?utf-8?B?SEs3SlE2WjkrTzZEZ0hweHFQVGJ3dmJvMFRjRGlFMENwQkpRQWlhRzhnazFn?=
 =?utf-8?B?UU1hcjNvdW5FYTZLZDhUSnhkM0paNFFSZXBqNkUxclp4UXVzb3RnZll6Wms1?=
 =?utf-8?B?ZjR2TW16dCtHdFA5Skg4bU1LeGMxN2Zmb1I5Y1oyTHFtT2pMRTk5R3hsekYr?=
 =?utf-8?B?VUlNTUZKMEk4eVZWeU5WS0RsK1k4WTR6VFMyTEhCM2NSYTNpSkZ4REVGME1K?=
 =?utf-8?B?WEpreVp0MWwzbFpSMVYrZ0MyRjhKZ3VBbEc4c1FSc3NENXF5d0xPN3FaVWpG?=
 =?utf-8?B?WFo2bW1hR2JCdWdzWWxsRXZGL0Qyd3g3WC91aGs3dm1QVDZXQytIbDJsa20w?=
 =?utf-8?B?QkNVT0JwTHJNdXRBREEyckZEOXZsdlJ4NklpeUNnVWhBVFQ2QXd4bmZHUmI2?=
 =?utf-8?B?MUVLcDBkQ1dValJBUitKZ3N3a25LOGZzZTA1S3VtdHY3Z3VHL2NnNUgramVN?=
 =?utf-8?B?blY2a2VFT29BSmVNYjAzUGloOUJzbEpXS3ZzeU16dTRhcDBIMjNCS2tSY3I0?=
 =?utf-8?B?UkhxZHVocmpOOFRjS2dZU2U1TjZVWDZkT0VqdUNWZ1FyVzRIV2F1WE1xMUkv?=
 =?utf-8?B?Si9pR3NvTUtBTStXUTBpc1F6VkZleThRbFoxQ2hKN1A1UWxmeE92eHlUWGdE?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9997bda7-744b-45c5-cd7c-08dc12a4475e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:53:16.4861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mULLZBVhwYqI5BDU1f/uwaQQvViu5ioPShrbpu3xTBylO5hbEiS2g9PZyyP1CtDPqxilJfGGMT0c+hhyWNEaadM5ojyeNOlQJjVfYCmc0x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5634
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
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

On 12/11/23 13:27, Denis V. Lunev wrote:
> On 12/11/23 11:55, Andrey Drobyshev wrote:
>> In case we're truncating an image opened with O_DIRECT, we might get
>> -EINVAL on write with unaligned buffer.  In particular, when running
>> iotests/298 with '-nocache' we get:
>>
>> qemu-io: Failed to resize underlying file: Could not write zeros for
>> preallocation: Invalid argument
>>
>> Let's just allocate the buffer using qemu_blockalign0() instead.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/file-posix.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index b862406c71..cee8de510b 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2354,7 +2354,7 @@ static int handle_aiocb_truncate(void *opaque)
>>               goto out;
>>           }
>>   -        buf = g_malloc0(65536);
>> +        buf = qemu_blockalign0(aiocb->bs, 65536);
>>             seek_result = lseek(fd, current_length, SEEK_SET);
>>           if (seek_result < 0) {
>> @@ -2413,7 +2413,7 @@ out:
>>           }
>>       }
>>   -    g_free(buf);
>> +    qemu_vfree(buf);
>>       return result;
>>   }
>>   
> Reviewed-by: Denis V. Lunev <den@openvz.org>

Ping

