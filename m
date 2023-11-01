Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C27DE4FB
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 18:05:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyEdO-0006Iz-3f; Wed, 01 Nov 2023 13:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qyEdD-00068d-7b; Wed, 01 Nov 2023 13:03:53 -0400
Received: from mail-db8eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::700]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qyEd8-0004a7-3I; Wed, 01 Nov 2023 13:03:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdbWEG/6xJI09/GdoWMsSRvvpSgWxxhI7MhBKj97lUZebIw+UpCGPCXLwouOXv+9RQId4+xWo+aNJIwqZCljX8giPLw9e4sisO71S3zcBwrpjxTak2auM1eJKiRE8KFQnbnX/wP6FULppvlZNnQSob4Gxntata8o7sUMWqm9xk7IfIID26V+4/DEognjpC5uuNIGk3QLyScaZODz73yMkP6oRxpQVjUZzfkFfdFVoawYgkqS7TEiLildO8Ws9iqhPC9+KPqpl1YJbq0dkSDL6wzBP9sMFU1L6o9qhLLOhQVhV51CsqW32VBxZXkja63Dv2rWkaZj3u9IYTNM43ajTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC34YGS/hPg2KBx/qVzunm3g7F/Sp0hcl2+6BRPfsF8=;
 b=JauS1XVsZp/s8OcMqMaph1V6A91aHdnydW2AkHE0D5RMoo+rWYs4O31F+pzhDDyl6XOegjcu2l6FxLqz1m0PH98ujg3LwXhiFI6h9GlFBg81gZVzhUUdFYjIMXO9is3TJh/knqIDDjmKT1BjurWQ52VQlVD/W6dUjRaTSjg6Bs8AFux5K2cMpmOGKKW+6NGzTG5TqWb//XBvz8kEaYQZSQV+J75aTnGMyTDqDqJRFu/pRLMiNEzAn1/qNmCgZoWaW342Cvt5+1q+Pu53Z8i1suMhBnUBr+r4kS3Z8IYaG+tJiRW3e5hnmR33ZUaAKqRzOqke9WDn3AJGxMuOVzAKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC34YGS/hPg2KBx/qVzunm3g7F/Sp0hcl2+6BRPfsF8=;
 b=JQmrO53oL805kdiYgo6mLtOSvPNSBr1I53yJUhbAn6uXUhmGKGQ2FYlspVdsZxr8ihgFkqNqvrKwFUoe1qyNlGCWB30zJSM9dMeB9sDtGKIzquh2U1Fj8sJSDnWKWLhpkTXMzs1AU7Pkg3qGWfS0avc7TJp7ghcqS7ya+Xn5oyr7MQnYDVpP0Ba8bC7guL468DKemLIoM/zL7EwvXnpdxlQg8IK+xLkEti2HDknuN/8AdZvL+BId+PoHDyv3E41fIC7JKlcQN4ODkg3WyaJU2h9DSY9hf+S5x9+lpzAxGGO6GvaOqp6ZtmbMmYZBFCHxxbLjK+x8ZAvPVHzO6wsd4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB6582.eurprd08.prod.outlook.com (2603:10a6:20b:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 17:03:38 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 17:03:38 +0000
Message-ID: <a222db3e-727d-4bd1-b842-7badd009f843@virtuozzo.com>
Date: Wed, 1 Nov 2023 18:03:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Cc: Mike Maslenkin <mike.maslenkin@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com, den@openvz.org
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
 <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
 <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
 <d29be9a0-3765-10b1-24f1-6aa053e4213f@virtuozzo.com>
 <5f3a8585-18ed-4e05-ac6b-ac21178dfe79@redhat.com>
 <ZUKB9YwvUcNLp7B3@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ZUKB9YwvUcNLp7B3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0124.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::22) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d9f264-442c-4571-b309-08dbdafc7daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOoWeZupxzgy2kfHHhTTr9Wju7MkpWgn43K5Vwheo40qZn54xw54yKEiQLBKnNN+tmgsGNbXAzny9ql1LN8QwPN095iebUYZTNRUxkiW0wRutzk16K/WL4GX55qlYXmk9YyxSrYJ9EaxBQeWCHteBW65k7yzq0RqlqCvsKdZcMJ7i57mVGJu01GsIpgyBkVfX5VqWOOl2JY1nK8ke0qJjM3qJvsPOipsna4H4XwvzSPPkt8q1LklRsNORuk+gj0onpEys7lyN53rw3au3DhjwQqvTJ2HjvE3uEtvBsGFKerGmJrxK/rnYfoIDX2rx3v7xOrtZHLUdmjawDwvi7CrjG5o4n4BZdNQw5tMALiTLPsXr2wduNyW+KMLBaSRvg0FGXKH6XEiBnIHOudKQsOyRnec1hrg/d5rG5nADh6IywU+c2TYaVGgQyTR7TOAJgrJOiBgIGy5+WysgRA10tS74Hsnszu2PsVoDKgH8j9cfnbjdxFX+syQlVFKukzZcQ3z/4CBHKnBXtY7DjktwgG1zuPXljUI1K2usQz2D5zzLO2BjApQy8CCz6hIssHBmmSjyudfSKZvDi8vfZwyVm4ZptXyJ7CX15Tb5KBSLEIwSHCqPsFmMi2VQfJ1CU8e34kpKGaf87VfGR8tM1DhIEgvcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(396003)(39850400004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(26005)(6512007)(2616005)(2906002)(38100700002)(31696002)(86362001)(36756003)(5660300002)(83380400001)(6486002)(53546011)(6506007)(107886003)(478600001)(4326008)(66556008)(316002)(8676002)(66476007)(8936002)(41300700001)(66946007)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpqeGVicmgvWkt5YVFNa01hcjg1YmE0TlZKbUtoUllQOTdid3pLSG55WUhU?=
 =?utf-8?B?U21HMVBGVWJHWnVKNDlWbW91d3VHOTFjRjV5R29vOUFlQ1RRQTVBNVJwdWVq?=
 =?utf-8?B?OVdFOCtWQnVxdDVCUEpRUG5FR3c3VHlUdXh0bmF6S2E1cisxY2NLbDlIUjly?=
 =?utf-8?B?TUlDR3p4b0hDMVZBN1JoclF1alcrQ3lQeUVaeXJaMzkyTEJpa1FZZDBmcnFM?=
 =?utf-8?B?OFNzU210emxXQVY5cU5hR0x4dTZyb3hpdUtmYUpRK0kvYXY5ODVtMURBRVZa?=
 =?utf-8?B?Qm5yMkJpQ2J0OVhOd0srRTZYbDQ0Q2svM3lJTFNsRWVFM0syRUtFS1Y1K0Zi?=
 =?utf-8?B?OUpneTRyVzl5VEp0MkpPV00rcTdReDdta3pxdjJjTmZzMytiTGtoQjAvMkJ5?=
 =?utf-8?B?WERDNEM5cHFLN1RDTEZQdnhqbktJVGlWUTBlbDJlYjRBQ2ZuVjZwS2lBd3dI?=
 =?utf-8?B?TTNGNUlSaWFJQXViSkdCNzkyZCtUL0phYVEzaUJybUtTZkcxVTJYWlA0V3VG?=
 =?utf-8?B?TzNYSUE5Rmk4dlBOTi9MOVZqNFl5WnVISC9JWEV1SGhTMk9qMS9ZK1A1cHBr?=
 =?utf-8?B?ajBpZThyenFUK1V1NEU5SXczSVZwc0ZBelAybmZoY3hvT3hvWnJNWU9CL0VV?=
 =?utf-8?B?TG5YVEczQzZDNllzc0IvQWUzZ1hvUkc0QXkvV1gxN1pxT0NhVU44UFRaYWZz?=
 =?utf-8?B?Yk1xL1pTOGkzNDlKVHpZUmZVUXdXU2hDemxIM09Vb3JNZDJSVEhhUTd5Z1Y3?=
 =?utf-8?B?U3RWZldGSGw3SkVnWFIrQ3J0SzdINmVPc2FhaTFxanRnd0VhbzNCZzNmekw3?=
 =?utf-8?B?R1hZODdCYnBHY3BaY3BKUlUvU3FHTm1ITE0wZWw0M05mNGxsZTRNMUI5cXRq?=
 =?utf-8?B?MDRWOVNsZC9sMEMxVWp3UmFxTjZpRnY4YldrZS96dE1WbXlmc01YV2JtY1hh?=
 =?utf-8?B?bDVUUS9aR1MwUTZOaEl5alVuRkc3OTNRRlB1SUFRWlg5Q3Uvc3FpYlliRy8z?=
 =?utf-8?B?SUJDalQyOUE0OU42ZWEzZkk0ZzJMZjF1ZzJBR3JVZXM4RG1sZllNbnRBNFp0?=
 =?utf-8?B?UERnY0QwTENEMStlVkhlOU5LNGgvU0JTcG5GdVFWdTcvRXViVGFwd1ZPQlJk?=
 =?utf-8?B?OFVSZWVSVno4S0p2MG9ReDdyMTcxbzBPa2ZQdWQydHl5WjNhVVpIRTBqdmx0?=
 =?utf-8?B?TWRXWkR0NUx0UnhlM2cyM2IvL1pMMlAyb2J0dG1nZ0NBejc3UkI2SCtLdSsv?=
 =?utf-8?B?ZlByNXBKMDdOU2xPb2J1VXhHNGlCc3h1bmxzRWM1WkZKckZWL3B5TmI2a3h3?=
 =?utf-8?B?cDFJbnJEaWZ1MEZ1dTlLd0pzWFBJN05WY1Y5b0hFVk1ZTzRhTkFKaitvZ2Na?=
 =?utf-8?B?dzl6UlJDUzBQeWFrQVMrMFZjanlWSHpGRFFGNzhMb0V4b2c5NnB5Y0RhVVVR?=
 =?utf-8?B?NGdLRnI4dkVlSitxaGZuejhRNW1rZmZIMkNTSjJKdEtXV0w0dHFPZE5HM2pH?=
 =?utf-8?B?bWE0NlM3dDVVOEE5bG1qVXFRanVDaWR0K3BGMWNMVGhPRlZlSHpERUYxditL?=
 =?utf-8?B?SGN6ckgyUnRJa0VQb0g4UnpiQXQ2R0dYMXZPSm50eW5ady81Z0FERVR6Rzha?=
 =?utf-8?B?b2M5QVBOMHZITU1CdlVMY0J3YTFRZ25XNGdIUC9SbTc1TTJYN3F6R2EyQVFl?=
 =?utf-8?B?OThEaTcyZGN0M3JYcTh1YkVZU2pSMUNzc3lsWmgrN01JWjZraGhlMThTZGJq?=
 =?utf-8?B?WEQ3dFlMU1NDWTFKQWtJbklCbmVZSWhhSzZ6RFlFdnlyQ0VnTzFTN1FYNFc2?=
 =?utf-8?B?bXVRNmgySDgzWnpVeW8wcmVGZDBiSlZqcG0ySU4zaXhpUElkRXBEcGl0N29h?=
 =?utf-8?B?b2NjTkU1a3UvSURNMTFBU2VrQm96SGNSZTMvVzlZTlo1bDNkdnJDRWxGaXFs?=
 =?utf-8?B?dWJFZllPUXlmTm1UTFlscGphSFY4WFNielJMMStCMkZaS1BUSVd2aUlHWFFk?=
 =?utf-8?B?QnJOZmtTcXliUGR1MENxZjluU3laUnkyVjFpeC9QZGFrRytuUTNKZGtnekc1?=
 =?utf-8?B?Y3FUUTVzTTRHMHMzcGZ0eFpBM2tZclhyYzg0Q1NYNkQvdmw3SXcxR3U0QlV5?=
 =?utf-8?Q?smZggYctHyETHGS5BL8EcSwSC?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d9f264-442c-4571-b309-08dbdafc7daf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:03:37.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ+UXHnWA5YyqpdU3UefoorgUre3sZv2BaJgP22n/QH1CZfxR/w9ZAAIsMKYYZsAKaJ004daZrPupwDjGUtBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6582
Received-SPF: pass client-ip=2a01:111:f400:7e1a::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

On 11/1/23 17:51, Daniel P. Berrangé wrote:
> On Tue, Oct 31, 2023 at 03:33:52PM +0100, Hanna Czenczek wrote:
>> On 01.10.23 22:46, Denis V. Lunev wrote:
>>> Can you please not top-post. This makes the discussion complex. This
>>> approach is followed in this mailing list and in other similar lists
>>> like LKML.
>>>
>>> On 10/1/23 19:08, Mike Maslenkin wrote:
>>>> I thought about "conv=notrunc", but my main concern is changed virtual
>>>> disk metadata.
>>>> It depends on how qemu-img used.
>>>> May be I followed to wrong pattern, but pros and cons of adding "conv"
>>>> parameter was not in my mind in scope of the first patch version.
>>>> I see 4 obvious ways of using `qemu-img dd`:
>>>> 1. Copy virtual disk data between images of same format. I think disk
>>>> geometry must be preserved in this case.
>>>> 2. Copy virtual disk data between different formats. It is a valid
>>>> pattern? May be `qemu-img convert` should to be used instead?
>>>> 3. Merge snapshots to specified disk image, i.e read current state and
>>>> write it to new disk image.
>>>> 4. Copy virtual disk data to raw binary file. Actually this patch
>>>> breaks 'dd' behavior for this case when source image is less (in terms
>>>> of logical blocks) than existed raw binary file.
>>>>       May be for this case condition can be improved to smth like
>>>>      if (strcmp(fmt, "raw") || !g_file_test(out.filename,
>>>> G_FILE_TEST_EXISTS)) . And parameter "conv=notrunc" may be implemented
>>>> additionally for this case.
>>> My personal opinion is that qemu dd when you will need to
>>> extract the SOME data from the original image and process
>>> it further. Thus I use it to copy some data into raw binary
>>> file. My next goal here would add ability to put data into
>>> stdout that would be beneficial for. Though this is out of the
>>> equation at the moment.
>>>
>>> Though, speaking about the approach, I would say that the
>>> patch changes current behavior which is not totally buggy
>>> under a matter of this or that taste. It should be noted that
>>> we are here in Linux world, not in the Mac world where we
>>> were in position to avoid options and selections.
>>>
>>> Thus my opinion that original behavior is to be preserved
>>> as somebody is relying on it. The option you are proposing
>>> seems valuable to me also and thus the switch is to be added.
>>> The switch is well-defined in the original 'dd' world thus
>>> either conv= option would be good, either nocreat or notrunc.
>>> For me 'nocreat' seems more natural.
>>>
>>> Anyway, the last word here belongs to either Hanna or Kevin ;)
>> Personally, and honestly, I see no actual use for qemu-img dd at all,
>> because we’re trying to mimic a subset of an interface of a rather complex
>> program that has been designed to do what it does. We can only fail at
>> that.  Personally, whenever I need dd functionality, I use
>> qemu-storage-daemon’s fuse export, and then use the actual dd program on
>> top.  Alternatively, qemu-img convert is our native interface;
>> unfortunately, its feature set is lacking when compared to qemu-img dd, but
>> I think it would be better to improve that rather than working on qemu-img
>> dd.
> Is there a clear view of what gaps exist in 'qemu-img convert', and more
> importantly, how much work is it to close the gaps, such that 'dd' could
> potentially be deprecated & eventually removed ?
>
I am using 'qemu-img dd' as a way to get (some) content
from the image. I have dreamed about getting it to
stdout.

Den

