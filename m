Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2717754008
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 18:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKM54-0000gc-Rd; Fri, 14 Jul 2023 12:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qKM52-0000Xh-4V; Fri, 14 Jul 2023 12:55:44 -0400
Received: from mail-dbaeur03on20718.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::718]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qKM4y-0008UQ-5I; Fri, 14 Jul 2023 12:55:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOD4Rw51qNcdpAGhJSt0t2HEAEeRupkJuj+JCvG4ZmDGkUeJzU67ABOGNlbdn8/QUtVD2TbjFkiRon63mooe+9cVdyewkONvLQEm3sWwNZw2MVH3OGNk9MzEdHv90RMDXg7wOv+M+bWbE5+qBPjAUIWbmx+TnvU92seU/oBOW2sH9GuCD1McJIABLuymffqWZI2mrwic/M8szfYpi8CN0kKARI20Yw/rb4J6fkYZUQc5z7O7FJjY90u7x9fL3i/Uai3a001gDjJLlvqhhmcQvEDcj1jhX4z2Eilg4VHSCgWlRBhzC7RWFyX/YPdXn4nnVolmLE18vrUAoZX9+mycOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaQD9F2pF2890d43iI6i29wfPHzKQlcQzXpbgrKy0KY=;
 b=ZHIjw6f4m0wBupmwYeUimcOe5Y9iWFgmQgw7MGZJyGF4xGEcQGUD6yAeHqZ8pRK/TZYfRfmtc1aNayYXyeKPNjGwpja8McCT28z3Iewq83Y1U1MQfneQY3azU4D47XIF1GMt7ShEJE5AZ6/FIejYzdnShHqdDLIx0jzA9rZSYVyAjyvRMQv6uMX8MFmE7gq7gVD5ag1diFOho+ACfuJVY5Sb6sNO7xZLL7d5qFBs0p1Qa0rttIkPCamVC6O0D8GTrL3nz0gnxVH1CCraXel/5Tr35W2dx8x4kMBL41dPWMJwENqyhPlV5thRi9Ybe6i68t+jdeZB2ttb9D+XimxnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaQD9F2pF2890d43iI6i29wfPHzKQlcQzXpbgrKy0KY=;
 b=PAdLBiVDkWKG4i0g6x5EswPzLRyjfPoF0rec5c62qzP1xPfpJ1ZpYhSnhDoLqvu7oJA+RIP6FIrRJQ5WpgJF85R43gWmow3sQRnvx4Au6yfmDqV1PWdt50JGhz97vce9bvVB/Y4zZA53mfNUqY8YRvUSTmcJwABBozqIXZHEd5LLSygRRsA5YlERZzvMMrU9gg/e3+yOOfFmc/v4Fx57BU2XzVsXXtgtRJodxzYOvJDvt2pPY9Iy8F3CESHH27s2iNaCjBfIsGljS1CjZQ3v38BlAoJ4jLRdtbYsIVL1TmyfezjcT1vAtAVx9q4NQw2ALhjl/HHuS9A/z41ZJkWsdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9269.eurprd08.prod.outlook.com (2603:10a6:20b:59e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 16:55:32 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 16:55:32 +0000
Message-ID: <64c3da79-32b3-150e-b2ac-58c438a9b574@virtuozzo.com>
Date: Fri, 14 Jul 2023 18:55:30 +0200
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:803:64::49) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a88f3f-99f0-4ad7-2e85-08db848b22b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TSyaAryeLc8jsk77yXGbyi3gT6N66Q/DA2bV4pqEG7dMbr9P3DRsU7KhTYNVgbyzsGg3pcIuEtmo8sWYe9kNRlTP7RvK0sA6Z00zewDwhwo6DgMqybVEn6ebCpecXVeFhcYIWPSx5Xx//qLyJEwDlA4ZnLAJLF5pMfk2YTWH8DCLdb2YPurHcoPX/pDB1zJyNvlyancMVHzpPlia/63CfUfnmocyYB2Yvnalc7z0mGFfiFcO9KOW5zLmP82dheqRqsvrP73JT03MmBC/2ama17xZc1EKGU5BhHai1Y3WCqphduxuaSo+bsbCLL6n6QCktNRh7DPCKJwrmIE8lLWnK/bufPKcxc94mH5PrpDRJoe75wZ/6byoKMVFif7CdJvfrn3LeTZrQBP7bB2Z3XAuKl5iRZL374EstuQ1sjj/66pb4NIKazH+vRxzK/Epx1tkojwmSg/KWn+hYnXqx76ajLh+ksnE2rKA8+KyVSkal3Jh+XK+7EKQRyyCCQZdyXZ8k+zsDSoijEwrU5WNZ16mOqFYWMUSoCwI3+mFOhNnyijwkBY3cOUm4GX+H2KJKy4MCvNuIllaY6wtnN3dhswWh/NVq+8z2wzhaB7cKVdpIrF2UB6I8ebwK1gv4A0QNM4Lglh6GKmWcJZaClV4HnS0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(451199021)(2906002)(38100700002)(6512007)(966005)(83380400001)(2616005)(186003)(26005)(53546011)(6506007)(5660300002)(31696002)(86362001)(8676002)(36756003)(8936002)(6486002)(54906003)(478600001)(6916009)(41300700001)(66946007)(316002)(66476007)(66556008)(4326008)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlaSy9pdnNaWWV3dS9BdU5BZkdtQUMxS0M0Q2dQT3JVRlNoNkE4RkVPby9I?=
 =?utf-8?B?d0RLYmk3ZHJDV09kSWVIaWc2c0lZMmFrVk5HeUloNi9Pc1B2Y3R0Sm1HdlUz?=
 =?utf-8?B?eXJ5L1VrTWdwZFZjczhoaExyZUlZb0xkcW9SMk1Pa1FKRm04ZjF3VGFaeFpa?=
 =?utf-8?B?WjdLelVoK09QVWFlcFlnTWRYNGVOby9OZ3c2M2dkbjNLN2U5a0xiOGRTOWtK?=
 =?utf-8?B?NTMwMEdyN3pzY0o5dDNETTlOajFQMnFpMHM3Q1dzVFFqMlp1V3dwL2ZtcEMz?=
 =?utf-8?B?T1dyaFUrWnRsZGFzZGQ5VG5USlgyVCtnTS8yRjBzTDYxam11a2J0dm15MjJr?=
 =?utf-8?B?aW1NVVFpYk5GaFEvMVI2ZUtodzhCQ1k2bnQ3cnRDQXFtVTFQYzZNWU93SjB5?=
 =?utf-8?B?SE0zU1hxd1RnZlROTVhkOElTK1lZQlpMNVlOWVBuOVhJVm5sVHRsdkFuczM0?=
 =?utf-8?B?aWpEUjVLQ3J6eFRIYWpsNElYZEhDMlJrUUNtWTR0aktCL0FVdys4aFN2MlQ0?=
 =?utf-8?B?TW93ZHVIdUpKSWdFQUpRL2Z6ZlFrem1OY2pXMEN4MSs4QzNaSmxWdFZPdTJR?=
 =?utf-8?B?QmNlQmxaOFp1Y1JlOGRncTA5bFlUZzZtSFZlYUN3dEFCeGVqZGUvdDFUQXhh?=
 =?utf-8?B?Q3dTRWs4WWVWMWV1bGpqOUZ6d2o1ZlJrU0phQkhDTUJ5Q3VobDNrRXZsS090?=
 =?utf-8?B?ZFdRYkkzbnJPYUJtcC95ZEs1bGx3dFFVVkE5c1FlZDgrSUdkOFUwVWJmckpJ?=
 =?utf-8?B?anpJTnpIaTFPMDQ4ckx1Q2pXUVRSbW5CcXI3OFFIYWlzUHYxS1diZUhDMWNt?=
 =?utf-8?B?VEJEUHZIcUN2QlM1eTFFd0kzVnBLa1BxZC9kbDBCVDk2WEpXRUFWeEhiOW44?=
 =?utf-8?B?U2NQS01PQXlaZGxjVy8zSVFnWVJ6bWZOSEdLeW5yMlRyV09tUStWM0RSUlZV?=
 =?utf-8?B?eEpGU29DcWJWMHR4Z1lSZEU5RUlocHFLUWtqNlVCRVVlNVJlcXIxUHQvZUg3?=
 =?utf-8?B?UFQ2dm5XYjNlMlhmNk5vWUQzYVVDYjhJVGdyVG1Dazk4YmFXS1JRRDc4Rm5o?=
 =?utf-8?B?QnMvMzhONFJQTDgvV3phclVvQlhOM2s3bFBGMS90WHJRZnhFbHN0bXBwUVN5?=
 =?utf-8?B?dzhqZXcxNEFYOTZTaWt0czRMVENJNjdSLzJ1dGEzSGVLcWRBczBxTittbUNm?=
 =?utf-8?B?a29FWWlhSWxvOUUrQjJoTkVqeUNxbXJEREcvREg2WWJRRW5ROFFSck54dU56?=
 =?utf-8?B?c3VmVVRkZ1Qxai96VzFKMjFHNVg0c2pqQkZpZStNSktIRkZhSk0vTU1TczF1?=
 =?utf-8?B?eXNXNzRleGFTTTJqcFZXMExERmliRTVOZ25LbnJyRjVzVi9jSUROdnRPYlp1?=
 =?utf-8?B?UENPckFmS25RaHlkNWZ0cVZrZXplbFdKb29JMW1vanBVUkU0bytCZ0tuUVBy?=
 =?utf-8?B?ejBFRG9GRG9CYnJDc0FSSDNldmF2ejdHYlRVQ3N6ejhCNGlsd3E4TERBN1FG?=
 =?utf-8?B?d2tlakdYbUcxRFZjUGRyM0M0bzVSRzRhWlE0aDhxaDI1alZUbTNmdTM4ZkhK?=
 =?utf-8?B?TFI5QTcycWovTzBZdjROdk1LcFEyY1c1N1Q1SHd0ak5waitLNFNNZ05DRlRn?=
 =?utf-8?B?Y1U3ZEFwSlMyLy8vMEVTVnplRkJxbGNEOTVyazdQVVdEeHYyRU41VTFXRUVI?=
 =?utf-8?B?b21JWFc0dWx2Tk45dEM2RWJLcWNIelRwOUxvSVIyTnJMVElKZ2h6bzBickV1?=
 =?utf-8?B?czY4ME95L3lYTFhhcDhaSGFsczE4Z0JEUkZhdGh4RmRxclBhUGx5bFd3MUUz?=
 =?utf-8?B?cThUSVAyUjhyY3d2TGZVV2w3ek5MWHAxeEN0WEFkVWt5aWZoT1pnY085OGRE?=
 =?utf-8?B?bHZvKzZFNXI5QUZya3VjYnplZVdTcnlDTjdhS1pRczBZTmpsbDNVTGVsN0tm?=
 =?utf-8?B?VFd0VDhDaVVpbDN3ekxyaDlZblluWFFBWTN4aGlaOUdoOWVoQ0hlV0QzU0Np?=
 =?utf-8?B?bmorb3BDVDhXcStQK1lubjBDVVU2SmpNUEt2SUU1SFZ2OVpndEpVZ25IbU5U?=
 =?utf-8?B?NFdiTVFPZmRSeWhZTTloRlBzYURqTDB1S1BkNlpQSjl2alU1aWNla1Uvcm40?=
 =?utf-8?Q?7HNLiD7JiNsfzlluNB37nIlEh?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a88f3f-99f0-4ad7-2e85-08db848b22b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 16:55:32.1910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDX3N+ju3t6c9eyLna+F0DGuNRkH2e8peKVb34PfsEtLrAX/ilUKetwhsD+Acd0LoOxdViUPg2ZRZkIBzVr5sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9269
Received-SPF: pass client-ip=2a01:111:f400:fe1a::718;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
I like this fix. Thanks for pointing this out.


>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index 4276163564..e9e118dfdb 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -575,7 +575,6 @@ int main(int argc, char **argv)
>>       bool writethrough = false; /* Client will flush as needed. */
>>       bool fork_process = false;
>>       bool list = false;
>> -    int old_stderr = -1;
>>       unsigned socket_activation;
>>       const char *pid_file_name = NULL;
>>       const char *selinux_label = NULL;
>> @@ -930,11 +929,6 @@ int main(int argc, char **argv)
>>           } else if (pid == 0) {
>>               close(stderr_fd[0]);
>>   
>> -            /* Remember parent's stderr if we will be restoring it. */
>> -            if (fork_process) {
>> -                old_stderr = dup(STDERR_FILENO);
>> -            }
>> -
>>               ret = qemu_daemon(1, 0);
>>   
>>               /* Temporarily redirect stderr to the parent's pipe...  */
>> @@ -1152,8 +1146,7 @@ int main(int argc, char **argv)
> Pre-existing, but your patch made me notice nearby (minor corner-case)
> bugs:
>
>              ret = qemu_daemon(1, 0);
>
>              /* Temporarily redirect stderr to the parent's pipe...  */
>              dup2(stderr_fd[1], STDERR_FILENO);
>
> We aren't checking for dup2() failure.  But even if it succeeds (which
> we expect), it could have modified the contents of errno compared to
> what they were after qemu_daemon()...
>
>              if (ret < 0) {
>                  error_report("Failed to daemonize: %s", strerror(errno));
>
> ...so this could be reporting garbage.  I wouldn't mind additional
> patches to make the code more robust against unlikely failure
> scenarios.
>
OK. Will do. Hope that I'll not forget this again.

Den

