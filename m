Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61249788F4A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZcgA-0002VA-8k; Fri, 25 Aug 2023 15:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qZcg7-0002UM-GR; Fri, 25 Aug 2023 15:41:07 -0400
Received: from mail-am6eur05on20729.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::729]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qZcg2-0002ku-OM; Fri, 25 Aug 2023 15:41:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6WWimc92Yzi17CsH6sSrrSqZcAooP/AKlJoHKziO9llXc6pauEajdi7QW7Si2bHz3tv0Ldjc3A7KiA/MUpso+oCChrPnTDEiUE/GGGUMVA9G5qzGNIP8i0r5xKHWMP0z5jx8Av5/Vnw3z0H+oO5MKPdfZQJiPLC+j6KFzvlcRFOzODFFcv/bE2p3R6lxaUf7jq7t9YdlNQOivuYSZ2vDRGxyGHgeTKwn6afTFBvkljB09x+bnIFA12FLaCwRLbz/Z25/wv2KVpyWXCtitSGxHIDgnvPZFG38F58M2GGL/Hj6rznDsUrwIpu+IUrU8mPT9J6gvBlOMhaDywt0+8HnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/IIVmv3GZtcY0oc8+jw7A02KAuVze6lucf4hqYB4ck=;
 b=A0jK8oc6Phcxu9r+Y0sYT8en4CoUBv3GTz4MJt3bpWM7Fzo9+ZW9sW3aa68wUFtBOvfq8f+eEov+cTboRyXy615g+Iszo1ijmWAfiJ5bAd9VRXo1xXmfpfv+6YGhSrh4ooX+LEe+9n2/K+qz3qZRAbmZOI/OHhENyNKoeFHMPf1GuY0lpKlqC+B8ZwktT70eEH7I0CYwsAwO/AJ73Ckys8upu3XhbotT1Ihqkn6p8bp7pUTYd2Rv13gesute65Ahrsx/xdz5qpi4DkSwtn7YNxZ4LfgOo1vrR3/EkP7GfA5REEdN/XMAx6XVTfROOWxhcmTZm8xiR9Gn4o4KJusXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/IIVmv3GZtcY0oc8+jw7A02KAuVze6lucf4hqYB4ck=;
 b=z9w01Xclyv46mrlJScVPSalUH0kkqW+M1pjHidHz0QYzOtjCkkLtm1omXoX7Qn7KiO3EY50wN/ZrPftwNLmAbNkJMtUaEtmNE2eI4CcaqYYtkTyoQixAr4A3WR7mIdqO3UAD+lWRQGa8JFsKSEFysI+iXUzjrNp5bxmQCmIHV+L2hYh56TGuOP61pgiScAXsJnfYDnWLIPZKRhHo4nxrHUrdrTkhJFrRhNl2yCm4eOJi2C5NC99f/nmkHOwaZVPdCycLv/b4jZDSZX7Zr5RT3rYCN/9kRnhryR+kW/V48CpAvDzVoz14gBdK//L4K3khXupQ0Iy1Jkhm0NqTFq98+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PA4PR08MB7641.eurprd08.prod.outlook.com (2603:10a6:102:273::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:40:57 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6699.034; Fri, 25 Aug 2023
 19:40:51 +0000
Message-ID: <a6b5cd5b-3dc3-8c14-6454-b3e46ef4415e@virtuozzo.com>
Date: Fri, 25 Aug 2023 21:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] qemu-nbd: Restore "qemu-nbd -v --fork" output
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230824200311.636589-2-eblake@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230824200311.636589-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PA4PR08MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d135652-3a8c-4a6d-0560-08dba5a33072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK7a5dVimvB2K1Y6wY98Q1UazfqH6ZqyK5vxIjT5N9sN42u+OjAl29qSJqTw8Zc4bUoixIF46pDn2To3i8vDgHOH7120OQgfVU4tMyMnwsmS22NxvsTYicNVaDJm77iSj1aCKT3lMpiBo5wFqM3kkUo5bKUC86GRp/IiRj2nDCbTn7zStKpENppjxLveE0iGgVScMpMapeHGeJxLSn5ErNdsZBiZsGDQMRHqSjptY8u36kbc4gm++ppBqVQLWmgB4pSbsnDEOsT2fM9HEXWQBTtNELigBnYf65Wl7ExSZ+NweSPlpQ9Xbhd0tnsShcQsnOtFFFxUd94FVrFAGtv83pP9CbfR/9xletJ4xLyfP1n+OzNOY/5lw2jV7ghLn/L19Nr7sOUvERts2EKlo7etlNjo0X9RuF4VqvPY/lMYCNsPecAjqqVP244HD/iB1HZGMUKnGnzsc3OGgPRQ849jZTji7n08cY2AmBkBDp86TJQL3TCEaQAc02I7LgWN0MEnNxU7yCEYrwLnqVFJRjLTQxAV8hQY0pIDnaNEs66hlSmhzha1HfkQdyYflQbTKa2UsMRObm98Za8YMy+4sGGQ0GSEiIvIFGn+x4KLo9G6TTcWFjntnYEBAjps/jUsBn48qJEW9Nvrd1mKJllBP9AsyqilCHfr7Iq9Qq3jZZub47Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39850400004)(366004)(346002)(136003)(1800799009)(186009)(451199024)(2616005)(8936002)(8676002)(83380400001)(5660300002)(4326008)(36756003)(26005)(6666004)(38100700002)(66556008)(66946007)(54906003)(66476007)(316002)(478600001)(966005)(31686004)(41300700001)(31696002)(2906002)(6506007)(6486002)(86362001)(6512007)(53546011)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhmK2V5M2ZhOXNHaGpPcjBqU2cvRWhoSjR3TWxPNWFLL3B5ckdHUExKTVBB?=
 =?utf-8?B?cUloU1RJdUNLVzR1Y1pmaEpwL2s1a1pQNFU2bUJVSEQ3MG4xNUZ2am40UnlN?=
 =?utf-8?B?QmpGV08zVHppazVMUHVDY3VyVFhzb0Z0VjlySlAzSzRQODA0SlJhR0NBdTQ2?=
 =?utf-8?B?a2QyazJQaUk1dDdqYkZnUjBBZTZKMTBmWU16bjBxTFRONDdadUFoNW5qdFA1?=
 =?utf-8?B?OGJLc043K29ZSTRkY2ZHWS8weFFqS2QzYnhXZWdJa3N6aTlRVTZmN0ZiMElh?=
 =?utf-8?B?eTc3bklCVS9FbUU5ZDBCZDV6ZXFnN0loVzU3bGFyb0kyMEFqaEQ3ZzIrZSs3?=
 =?utf-8?B?NUNxclBKbTl0dno2eWhNUlczclRGSEJqNEZiaFc4Q1JDMWprRWFCVXRMNHNh?=
 =?utf-8?B?MEMrYmR2alBlRWRoNk5oenVQd3JqNkhSUzcrVmNsZ2NGd2wxY0tyMnJtSjVS?=
 =?utf-8?B?eUdWM1lDTTFmaXgrcGlYRUtxeDlOUEhtSEZwMGNUUDZHTlVSeWxraitIVkJo?=
 =?utf-8?B?ODN6NGwwalNreU91RWE4NFNXQUl3ZDZmd25vb0h4VThxUitFWlovaE04dEgz?=
 =?utf-8?B?VlZPSmI0M1diV0taRnNLaHYxUFhmQzd6eGgxb05RbFBHanZ5bVQ1U2h1L1hZ?=
 =?utf-8?B?VHZ2Tko4Mzg4RE8zTC90WFludHoyVHVpNEhpUTdNaWhmcWFBQno3TEdEeERB?=
 =?utf-8?B?dDNZM0tkLysySkhTN2hxRW9HemFTVUJPODNmQnF5bitTT201VGRpeWJjNEtt?=
 =?utf-8?B?TjlkRGZ2Nzh1UmJDR1RpejNiMnU0Z2N1UC9rTjVta3NFZHBjNmExTWdyeUR0?=
 =?utf-8?B?a2h4N2VsSCtEZXByZERzVnBjOGZ3OUFFNm1PNG50N2g1RC9iN3JHSDVhOWJ3?=
 =?utf-8?B?M2t1OHZja0xYU2ltUHJ0SWtxb291bzBiNHBUSDdVcmpMWDVNTXdzSmVoUE5S?=
 =?utf-8?B?clYxNlZXcExDelpBVzJnMkdDL3plRVRlRUJVZW5heWc0Z0hESHZNR2hjbjdi?=
 =?utf-8?B?aGsyRWZhRk11L2UzU2FqaEtaN1JyN3BQbWtzU3RhOHpiUDdLM2hNR2pCbFpQ?=
 =?utf-8?B?R29OVnR2SVZmZWpWeWkvanhFNnFLK3NDS3lsTFEzVTNRZEVOemxiZ01Bek1R?=
 =?utf-8?B?SXJSbkJFaThDVDE4UmZNbjNNV3lRRVFLejlwZFk4c0VTNVAvV3lzTDAreURz?=
 =?utf-8?B?NjRHL3I1aXcyNDZhQ2pTOW9naEliR2NKSDBMUlhHUkM5SkV6MmppbXhYYW8v?=
 =?utf-8?B?cG94YWJYV0JIK2FuZGFYS1V2RUJWV3hvSThVdmg4bWo0RE5SRk40N2FhVVJo?=
 =?utf-8?B?ckJtVTJ4VzhXQm4zU1lJWjl1MnpmRlFmQnZFMlgwRUxmLyt0VGc2ZWFBQmNi?=
 =?utf-8?B?eDdyTHROWDlka3RJemRwVjk4RmVKY21PRzFTN0cyZEVnV1hBZTIrWnNIcTl2?=
 =?utf-8?B?U0cxeE8wUHBaTEFPNjBwbUIwRGZ3NUlRcHg5SElCMjlvY2pNQXpYa1Y2V0I4?=
 =?utf-8?B?RXhXaHhHeVlMSWdsRTR4b09FREI4bGN0akZoZEVFcXVTRW5laXRxNVlQUVBL?=
 =?utf-8?B?cTliNk5CQ3g3dGtxc0dhdnQ3T2k1azBHbnVXVE9Wek9zM0g2MllYQzByWDVC?=
 =?utf-8?B?OG5saXJxQ0VtS0pkMkZnc2pEZC81ZTlhYUY3V3ArZnE5dStSVWdnM3J5UHhY?=
 =?utf-8?B?eG1RcUJpVGtON0YvRzUwdllGakRRRFEzQ1o0Z1dLckFSS3E5L1E3SGIxS3ZB?=
 =?utf-8?B?bm04ZDRTMC8rdkN3VWhJM2pmZm1LeTFGVHExWGdzaGU5L1ZnYzdmVmFERndj?=
 =?utf-8?B?ZEt3dnpIWkNDRW0rZmNxNGhMM3JiS2JpcWtqa3pTbk9HQmZvM3VRekFiTTUy?=
 =?utf-8?B?b0MwK3lUOE1CbVZyTnQybTJDNVdxbWhRcGZ1OUFtN1haRzU5UEVhTENkRWZM?=
 =?utf-8?B?RzJwUHQzV2FxRTkrRjAwM1ZqakFvSkx6b1d1bHRxOWs1SS9BUEFaendGVjlJ?=
 =?utf-8?B?U3FRaXBLcmozSVdNN0RIa1R2d21tQXZDYlFLa0Vibno4QmFvYXlGZFNSRXhU?=
 =?utf-8?B?bCtadVNndWlPd294eEExV3dXTXZnQ3BNRVl0bXkrcWI2QXdKY2FKVms0VSty?=
 =?utf-8?Q?1qk/qVXYAPQat1me70Jwyn7vJ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d135652-3a8c-4a6d-0560-08dba5a33072
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:40:51.5744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZyNXYFwD6JNGYkTmLrlAP0caWQJIzDCp1nK8v2pN+4cORnYxJyANhJueo+4QT3MgxYBW0hI/1wn+GpKuZIUSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7641
Received-SPF: pass client-ip=2a01:111:f400:7e1b::729;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/24/23 22:03, Eric Blake wrote:
> Closing stderr earlier is good for daemonized qemu-nbd under ssh
> earlier, but breaks the case where -v is being used to track what is
> happening in the server, as in iotest 233.
>
> When we know we are verbose, we do NOT want qemu_daemon to close
> stderr.  For management purposes, we still need to temporarily
> override the daemon child's stderr with the pipe to the parent until
> after the pid file is created; but since qemu_daemon would normally
> set stdout to /dev/null had we not been verbose, we can use stdout as
> a place to stash our original stderr.  Thus, whether normal or vebose,
> when the management handoff is complete, copying stdout back to stderr
> does the right thing for the rest of the life of the daemon child.
>
> Note that while the error messages expected by iotest 233 are now
> restored, the change in file descriptors means they now show up
> earlier in the testsuite output.
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> CC: Denis V. Lunev <den@openvz.org>
> CC: qemu-stable@nongnu.org
> Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qemu-nbd.c                 | 21 ++++++++++++++++++++-
>   tests/qemu-iotests/233.out | 20 ++++++++++----------
>   2 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index aaccaa33184..a105094fb17 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -944,9 +944,24 @@ int main(int argc, char **argv)
>
>               close(stderr_fd[0]);
>
> -            ret = qemu_daemon(1, 0);
> +            ret = qemu_daemon(1, verbose);
>               saved_errno = errno;    /* dup2 will overwrite error below */
>
> +            if (verbose) {
> +                /* We want stdin at /dev/null when qemu_daemon didn't do it */
> +                stdin = freopen("/dev/null", "r", stdin);
> +                if (stdin == NULL) {
> +                    error_report("Failed to redirect stdin: %s",
> +                                 strerror(errno));
> +                    exit(EXIT_FAILURE);
> +                }
> +                /* To keep the parent's stderr alive, copy it to stdout */
> +                if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
> +                    error_report("Failed to redirect stdout: %s",
> +                                 strerror(errno));
> +                    exit(EXIT_FAILURE);
> +                }
> +            }
>               /* Temporarily redirect stderr to the parent's pipe...  */
>               if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {
>                   char str[256];
> @@ -1180,6 +1195,10 @@ int main(int argc, char **argv)
>       }
>
>       if (fork_process) {
> +        /*
> +         * See above. If verbose is false, stdout is /dev/null (thanks
> +         * to qemu_daemon); otherwise, stdout is the parent's stderr.
> +         */
>           if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
>               error_report("Could not set stderr to /dev/null: %s",
>                            strerror(errno));
> diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
> index 237c82767ea..b09a197020a 100644
> --- a/tests/qemu-iotests/233.out
> +++ b/tests/qemu-iotests/233.out
> @@ -41,8 +41,10 @@ exports available: 1
>     min block: 1
>
>   == check TLS fail over TCP with mismatched hostname ==
> +qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
>   qemu-img: Could not open 'driver=nbd,host=localhost,port=PORT,tls-creds=tls0': Certificate does not match the hostname localhost
>   qemu-nbd: Certificate does not match the hostname localhost
> +qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
>
>   == check TLS works over TCP with mismatched hostname and override ==
>   image: nbd://localhost:PORT
> @@ -55,7 +57,9 @@ exports available: 1
>     min block: 1
>
>   == check TLS with different CA fails ==
> +qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
>   qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
> +qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
>   qemu-nbd: The certificate hasn't got a known issuer
>
>   == perform I/O over TLS ==
> @@ -67,11 +71,15 @@ read 1048576/1048576 bytes at offset 1048576
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>
>   == check TLS with authorization ==
> +qemu-nbd: option negotiation failed: TLS x509 authz check for C=South Pacific,L=R'lyeh,O=Cthulhu Dark Lord Enterprises client1,CN=localhost is denied
>   qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
> +qemu-nbd: option negotiation failed: TLS x509 authz check for C=South Pacific,L=R'lyeh,O=Cthulhu Dark Lord Enterprises client3,CN=localhost is denied
>   qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
>
>   == check TLS fail over UNIX with no hostname ==
> +qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
>   qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': No hostname for certificate validation
> +qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
>   qemu-nbd: No hostname for certificate validation
>
>   == check TLS works over UNIX with hostname override ==
> @@ -95,18 +103,10 @@ exports available: 1
>     min block: 1
>
>   == check TLS fails over UNIX with mismatch PSK ==
> +qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
>   qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': TLS handshake failed: The TLS connection was non-properly terminated.
> +qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
>   qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.
>
>   == final server log ==
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
> -qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
> -qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
> -qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
>   *** done
May be alternative approach would be better.
I have tried to send it as a reply here but failed.

https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04597.html

Thank you in advance,
     Den

