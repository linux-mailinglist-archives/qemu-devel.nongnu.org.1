Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA5756556
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOWl-0005MC-34; Mon, 17 Jul 2023 09:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLOWc-0005Kp-AU; Mon, 17 Jul 2023 09:44:30 -0400
Received: from mail-vi1eur04on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLOWX-0000tE-F1; Mon, 17 Jul 2023 09:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxnUsLU2TYVAHJL2K3E9JdH9m/OWT7VjX5RhMljy+sWFgQ0LFMCrPkUxAHh1nCd68nP2euyLQbWM7EYDLX0G1kGsIGZxuKfQ5+eVKAckZs43qC4HdSYkFzprjzin8Eu6EFMgQbk2nfrxgu3yhvAHbDFn7+iM9FU6YZEn+9wN/c+kZVO7va3E4lLH5KJv7myI87u2as9FK6nOdBvleT471O5w5NsiAzGPHKcJk3zr7YUfJixolhQ1ENS5QOelj22uNXIOT0pmvpfmyF/2xX/Bp3igygBNDtWbi4UDZFd5xpEo8BlEmJeJ6GXmFTaix5uHoIkEELPAZjlI0oLLqsTsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVcGMRUIacTUnrIiPm2y8ljYKX4xdBn7dM8roAzoM6w=;
 b=HUmd95fSFStAXCNltonNb5s/Ixh0ShxwUAcMnpXeuHyMRmkX0kTZ/Zrk0KCGDj0mrIbAtN0yAxYCODOMwPNUKqooEpWoYyTEPuktGseQJibZ5kNNnxWDJXmwFsJqUjODTX2IGwkcRAdEyR9u9CV0/Z2n0qd58gJLuBN9CcqrW5wfMKG0DBW652AG7z4eEvjDBNW4MfmtecCJdUSuqjp+jZjen6ScOInsVFYJtq2LegeoSMIEiaLB/mjOEtpq1ooSrkNBPSaMOLQCfEJZJGi0Yxldq6xypogOaamnfsuLsG7PKMUEi4M6ZxQEYOFb5SWvwXxnS0d42AEyEFxwhDoJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVcGMRUIacTUnrIiPm2y8ljYKX4xdBn7dM8roAzoM6w=;
 b=dER734LLapDlM8U76FZQRcIa/lI+xPd/4NQSHxDf+RmWkv7aLwJ0xjpGzkNEn5rvqnUQh9lfYpNAz5SjG2eZd/GURigpB5ZDySOs+wk7bFUWKKyDJAdM+x5bIAmsDJu/XyjeIx55jOGqSENj8Zf87cbrkPhFTC8+m+3QzxsoDrtsO1VUkmwiGS9jYQi71Nyu8IFGxvUR9eTyhmJ38PQdsQkJIg8u/H5lfdbRklahMthicDW79K9a8vgXrQanZVtUwrPzoR8hc2bXq9M3i0pUXLk6jnmlWOYIldQ/vyItDAMNuBVm6DaomgNosmY0F/b1Cn0f4YUAvx2u3t/j5h/TpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAVPR08MB9603.eurprd08.prod.outlook.com (2603:10a6:102:31a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 13:44:20 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:44:20 +0000
Message-ID: <84d366a3-490d-0544-e702-60b5816ab198@virtuozzo.com>
Date: Mon, 17 Jul 2023 15:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230706191545.130087-1-den@openvz.org>
 <3prxtqtz6ogmmw4d2jl3rxz6xcv6agbufgbdpoigrbumqwhaaa@glqq44jjen3t>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <3prxtqtz6ogmmw4d2jl3rxz6xcv6agbufgbdpoigrbumqwhaaa@glqq44jjen3t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::14) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAVPR08MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd8cd5d-da6c-46bf-d4b3-08db86cbec48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hp/eEVXQE4fdreikQpHGmiLTwdSf8I2ozUQtqwkougqr/TmuGXzq6m+OgJig1F7v2EhmH0Nob+Q3VZuTuues3Z/SRGc9GZ5phkWNk1kFwAMTCZal11XGQ1PFRjbf422bVgReuOg3MDtqrcBdVK2uwd26Lrrh/1Ix5RcJ4BX2WXwz2ppbKwWC0dk1sM16PSG9qFSPObk1oB2ztypi+Fzffw5t9lwvV/S5h8JHJzRHNBPbmeFRL5llDIBY0F3aknklNAIFErFKsf090lUhYatTfG3qJjwRQWQLD2QyHGnSPr6jZfUGjAfHaPQNSWCZp58YR3pYyyypx6V+GY9RJ0QRPzr3GzyKg+hxl9FlnxEnCq5A0UviKoyA2H/o818UVisylocXDX3r/MVbxUQv9o2E3d96ouoko5ul0w+Iwj4jv1TAb1HBACrkebLV1sDuDq+KLFkLDrEqDR8rOPTdMpGEKmds63dmI1LHUcIGfmfTcihO0g/BzGE2f3/ggPrRJkZWSWI0smF85BmzBg70Uk4CMNgmk7mAU2p8IDcrwU4dE+NlxAyo65J2uPmN+M1BcM3SyhJMlaGhQ3S5hsEGXJ5c0hy3XAN+/3BmronADce5wxBZqsWEgkqmH3S6Ed3IcLGRX5V05N8ZCpPuKqt1AjSDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39850400004)(136003)(376002)(396003)(366004)(451199021)(83380400001)(31686004)(2616005)(54906003)(38100700002)(6916009)(4326008)(2906002)(8936002)(66556008)(5660300002)(41300700001)(316002)(66946007)(66476007)(186003)(86362001)(966005)(478600001)(6486002)(6666004)(8676002)(36756003)(26005)(6506007)(53546011)(6512007)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWE0dUhPZ3A0aGgwbFE3dGNFazVWREZndVlONmY1WjNzR0lxbk1ZNUxUb3Y2?=
 =?utf-8?B?NzVKNlZ3QTRLb0c0QktQYkF2L2VET0VVbmJmREFSdDZBQytweWxZaFdDZzR3?=
 =?utf-8?B?WnJlRUFmdmF5UUl2dW5zRW1yd0EyTDIwV0RvSnFCZmlOWHRHUDZBdlJxb2lK?=
 =?utf-8?B?MzRBTmIwMEx0Rk1MRGJTRVk1RjY0L0xQdWVDUzc3emJCTnRva2hJeUo2VC94?=
 =?utf-8?B?bmplTVdXZ0tNaWdxUVUxN3VETXNnVHE3L0FBa3Y4Nko5YUpkOVdsZEsycmlj?=
 =?utf-8?B?SDVZMUxGVmxtTUpvS2hWU1Fuc0V4ZFhEaE1WZEJ6a1lpbEp1azBKRjA3dGZx?=
 =?utf-8?B?U2hhMjhnZEFlaUlJeFpRbWpiRnhaQXMrRjRReGhsa3kzZEVzWVlSM01MdTh0?=
 =?utf-8?B?eWtjSmZOdVVHM3NCY2dCbVBuQlNkbVRud2JTT3JOMFBUQUNHOHN3UG5hL1o0?=
 =?utf-8?B?R1dvcWUxYmV4RnkzOHdOMklGSUJoNTU0NC9MOHZvZC9USXJNSVlBaWw4WURG?=
 =?utf-8?B?MGdCRmNkMnpzeStHQUxWV1l6THNHT3JuUXFUMUtjaTVycjBMVEk5Z0VFZlcz?=
 =?utf-8?B?L2l6N3V3UVY3VHdoaVlJWlhxOHlZMWJ4RXRERklUQTBxbW5BcXFnNGV1ODNG?=
 =?utf-8?B?NGRBOGJKNHhiTUJDT3pNc1FOV2NDTmx6QlU5VUZkbm5yck9pUjNXZXlBV0dj?=
 =?utf-8?B?VEIxbWRmYmJENkdmdFlmVkxETXBhSkx0TEpGdW52eVJCZ2VCVU9lZk13Z2tq?=
 =?utf-8?B?V0lSR2FpRXMxeEVzUEVpa2NxTXJoY3V4Q2VndXYwc1NyM3E5R2V6azhkdWkz?=
 =?utf-8?B?d090TGw2Nmc1eGZRZVdqNzVCMVBmMlRTdFlod2lSWlBZWE1vekJOcWtoamJv?=
 =?utf-8?B?QXhsNHN0UWRxVzdUeHJCN0Z4a09XNm5NdlpKcEc1WjdCSldTZWdIZFdKWllh?=
 =?utf-8?B?VEJ1SitQLzV2OXp3MVVlZlJKNzlMN3pVQXpvUmZUc1RwQnNPbk81eS9VbzBs?=
 =?utf-8?B?a3JIT0VraGtVSlFqSGtEbkFPWHFxUUM5MFRZdG1mSFVod1RFV1o3NlVRVTg0?=
 =?utf-8?B?blhHNDFzYTdiekFuU3c5dnVMMGczTlpSakp6ZHhjYzBaczdwQmlSQzArTEcz?=
 =?utf-8?B?TVk5SVZLZEJId3E5cmttMGNEVWkvRU1LQm50ZDJBbGNXbTd6ZTVoQWxoeHhE?=
 =?utf-8?B?aUJBZlNlUU5IcG1ubUFZR0FFdWhxbnNtMm5ObFV6SURxWmNWb3pHTHFTam9y?=
 =?utf-8?B?MXZyc2VKaUNYNXZnQkV0anU1clM3bGFqSEhMcHJDaVFmU3ExeWZWbVFha1Qy?=
 =?utf-8?B?U29EOU14QUF1SjVPUDVaVzVtMllVTlMyaUFPb2tESE42R3YyM1VjcDErMHV6?=
 =?utf-8?B?TG9GaHFtUTVmYU5ncllPVEIrNW8vTWNwb3l5c0FnNnl1TFR6WVZmUUpxQW0r?=
 =?utf-8?B?bjJXTmQ5amMrb1Q0T3VSL21ZakhSYVBEOTFWbTgzWFQvVFIzS084akZEYmZl?=
 =?utf-8?B?SXJZNkZGUkpyY2xJTUlMeUVYZS9jR3UwSUFVTXVJRG85aWhUTjRUMUVLS3ZY?=
 =?utf-8?B?VTFnRkJScU12VUk0aXNCOTZyUWNmbEFaTGNUSk1abVpIcGVKREtmR2dsRFdw?=
 =?utf-8?B?UVc4cFpBTHViV3g0ZUhhV3l0ZGtCb2RLeFN0Z1I1TDVWSGpBcnM0L2FHQ2hQ?=
 =?utf-8?B?NkF3R0MxM0ZLTUdoc2x5UVhXdE0rSVJVTzJKU09LdE5QRVhUV2JSM0tFWXFz?=
 =?utf-8?B?aENqR2FvbTBjOTJPS25XMzRLU0FhcmplZG0yemN3elVnc0h4MUZMamVadURP?=
 =?utf-8?B?ZGxrMERmaWJTdUNkb1NrNDRKbC8yQm9xcUdwOXpEdkhQU0N2NmZpZVA4YnB6?=
 =?utf-8?B?UDFpbGJLQVd6bzR1ak55aW5MSzE1K3dkaGR5aXFkcmpDN2t0MnJTQyt2QTMr?=
 =?utf-8?B?SWlUMUFCKzBTQkJKSlFYSXl1TFk5dFF1ZExZWWFQMitCUDIxbElaUk5oODE4?=
 =?utf-8?B?K0cwWkdPWkNTcFpSak9XRG1paGpOWnpCQUpoemRaaW45ZnQ3V01DOTM1Mnpl?=
 =?utf-8?B?M29XMXA4V1RrN2JhaDVuZWdrekpuVGFUd3ZValRDdFU5SHVadmZ4M3d5NmlH?=
 =?utf-8?Q?RxtRJFMbvL1zjs5nC8ChWUW44?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd8cd5d-da6c-46bf-d4b3-08db86cbec48
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:44:20.4808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XRCHkZaO7UijkLDYEZxOeMQ2U0wLSCAVgef9u6kh1pp1OZutgVrDLSFBAlvOmts2FNE7aTecK62B0XiofSZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9603
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72a;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/14/23 17:35, Eric Blake wrote:
> On Thu, Jul 06, 2023 at 09:15:45PM +0200, Denis V. Lunev wrote:
>> Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
>>      Author: Hanna Reitz <hreitz@redhat.com>
>>      Date:   Wed May 8 23:18:18 2019 +0200
>>      qemu-nbd: Do not close stderr
>> has introduced an interesting regression. Original behavior of
>>      ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
>> was the following:
>>   * qemu-nbd was started as a daemon
>>   * the command execution is done and ssh exited with success
>>
>> The patch has changed this behavior and 'ssh' command now hangs forever.
>>
>> According to the normal specification of the daemon() call, we should
>> endup with STDERR pointing to /dev/null. That should be done at the
>> very end of the successful startup sequence when the pipe to the
>> bootstrap process (used for diagnostics) is no longer needed.
>>
>> This could be achived in the same way as done for 'qemu-nbd -c' case.
> That was commit 0eaf453e, also fixing up e6df58a5.
>
>> STDOUT copying to STDERR does the trick.
> It took me a while to see how this worked (the double-negative of
> passing 0 to the 'noclose' parameter of daemon() doesn't make it easy
> to track what is supposed to happen), but I agree that our goal is
> that after daemon()izing, we temporarily set stderr to the inherited
> pipe for passing back any startup error messages, then usually want to
> restore it to /dev/null for the remainder of the process.
>
>> This also leads to proper 'ssh' connection closing which fixes my
>> original problem.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> ---
>>   qemu-nbd.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
> I indeed see how this fixes a regression under 'fork_process'.
> However, the code that calls qemu_daemon() is also reachable under the
> condition 'device && !verbose'.  Does it make sense for either:
>
> qemu-nbd -v -c /dev/nbd0
> qemu-nbd -f -v -c /dev/nbd0
>
> as a way to connect to the kernel device, but explicitly ask to remain
> verbose, as a way to debug issues in connecting to the kernel via
> stderr?
>
> Going back to the emails at the time of Hanna's original commit...
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01872.html
>
> I don't see any consideration about that case; capturing the original
> stderr was done to fix what looked like an easy bug fix to a botched
> implementation of old_stderr in commit ffb31e1d without considering
> the ramifications.
>
> But seeing as how pre-existing code DID want at least 'qemu-nbd -v -c
> /dev/nbd0' to log indefinitely, I think we need to squash in:
>
> diff --git i/qemu-nbd.c w/qemu-nbd.c
> index 4276163564b..4d037798b9b 100644
> --- i/qemu-nbd.c
> +++ w/qemu-nbd.c
> @@ -313,7 +313,7 @@ static void *nbd_client_thread(void *arg)
>       /* update partition table */
>       pthread_create(&show_parts_thread, NULL, show_parts, device);
>
> -    if (verbose) {
> +    if (verbose && !fork_process) {
>           fprintf(stderr, "NBD device %s is now connected to %s\n",
>                   device, srcpath);
>       } else {
>
>
> With that tweak, I'm fine with adding:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Do you agree with my tweak?  If so, I can queue this through my NBD
> tree without needing to see a v2 post.  However...
>
I have started to fix error paths and it is revealed
that this tricks needs additional dances in order
to force the code to compile.

I have done that and will send corrected patch
plus error paths cleanups combined after tests today.

Thank you in advance,
     Den

