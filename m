Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDAB756E31
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 22:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLUoP-0006rq-KZ; Mon, 17 Jul 2023 16:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLUny-0006nd-LQ; Mon, 17 Jul 2023 16:26:51 -0400
Received: from mail-vi1eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::72e]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLUnw-0001cR-DE; Mon, 17 Jul 2023 16:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exKAT4TbRMKJKoUvGD2t3yCiuL4+pNN6jqEcR3E3MXmhJANC8KnvVV87CEX1Kd7dL2LwXN+A46BS2AefJqI/l1Bjr+WD+t9rwEYDOU+NCFJLaI+uAHX9hi/2xG6G3yxlkET/HywDKtEV6VJy6pT2GpP203/ThFnMlbjWZcmA/SanlYAXlFOWG3jzP6mBYB+WD5qLbxKoAJtdo6F9MtSMPxlj7IGu0arydSIqIAvjlwy49vlely5vznItO9UCmrzeYp8qeF3VnDvW0r8mhVjDtESIkPafOidrjUuXpjfahY0BoyEnjPVI4a9kW7pwAKOsWdxnvH6GUhEZRe9SLnU3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klukWMRt01sZBx98afFBwMIqNoUck0nvHEsouQELGcQ=;
 b=gWfWp2XQa5SZINtH2Ui8x29JEgcAPkGEsz2jJABm9U58rdWk2hepY8MFs5aB49QrMIUfxZS3rJ/kyykWlcY1XanI86ZcnG7YePelbK7jp5Rsq7iAXuMPleQealORxQNpskv/r4Fwf+Ya0R5xSghOVtUqr8mHgBW+Fb0utnVhzMqIs85BQ6GWB4ctPkhReweAHszlO9WHncQgrklCK1381eZ8B14q0U5O6A62581h2NqIKq8Xtgm9dRw/U4DY4Fx6vI9QVHeusW/G5VfZChUbieGHN1Zt53VUd73+xo21Za1mvLbrLWXCdgmvkNSsNUx0CGozgHVNbITDOsSbnfq6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klukWMRt01sZBx98afFBwMIqNoUck0nvHEsouQELGcQ=;
 b=cx89hj9GYkU8ymwvu5LmXYStz7fSXNZNBQxsxc3ajX6NysUp+F1ygrek3/eSRJoD4XtrFzPTAfZlJ4dMVQ9XnZNgfIfYua3YUBdy+fNCSALDEnZrN9njYWxhlDc+yvWc2uOh2DbAvF7vV4RZv/r39wUMV1MavpPnf/2TZ2iQrW7nkHIDewQ9S3/egwjwVQwGptu5XZ5hKBopis86Zlg6oGZ0r7J3b90fjJGk2bFle7r/T32ZFK/2HQhS0JbwryvmdXo7ZhpJDdwZq4AmWhFNyUFFqnrtMT2PWsPw8P6SteZ0L+SLUm4eLCvPc9Ygpyv5AsGx2UUoYMtbtZBZHjNanw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 20:26:43 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 20:26:43 +0000
Message-ID: <4bc6658a-7e6c-2f89-118b-c5262193e1d6@virtuozzo.com>
Date: Mon, 17 Jul 2023 22:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org>
 <itps4q6icdu52qtjk46by4mg6syz7lobzzgskefkpln5fkcz6u@renougv655gd>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <itps4q6icdu52qtjk46by4mg6syz7lobzzgskefkpln5fkcz6u@renougv655gd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::28) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM7PR08MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ff811d-e085-44a6-caab-08db870422c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPcCcaUvl3pOmaMSeyQ4cZXKFZclqiDPcOZt4VFZAA/C+sMhaijA2dotSeF5pP6+p1uYdptQPaUDoQ856fBaiNUBZR0HGJuIly14Hf1WCH4jMQ43J65K4+uOwRIC58LKU9yWHNROAeRWZaCTBxFZ3E6FpWQi27Ss1rnTEtd8DOqk+nZ5Yhb9EleSOM4uGHyf/omY2x9GuybCXR6ZU/RT9yAcBlvhGhhE+1EQKZBZ5TWd2pWaDkTqrq8hXrW3jXaXBRhA6irLjNSmbbc4fbtGtCbpC4QQh88425lyaZEZvN1sm5xfn104yMakM+6rwmyvyV9eY0hVzYEZuTIUZl6epJOOVfoZPY8A1HuS9fiyVMWGZbQ+M1w4sQ+WQ3rNjMO+mCa1IY63sdw6C7DmSmlMWUb1uTiV+v74Z+MrsWM4woNu1XP0QaauMNyDUkwWXXsWM8/zNScO4B+pKAmVY0rczIYr9lzNQu5bglfM73Mt2h7HL3npvkyB0mcMzsbqt/r1lPddQTstYFYsN/j9k86PgeHZyZmhyG8840urvbgcvxfempAcefvKDWGfCfg1IF3h+WuZA4JF37obJsHkQx/J+tC7D8c8VNK6Ij8DC2jUkszPVQQUw+ukNtsMRvKPqcv11S+MqnXSC/kNFwklWobRpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39850400004)(451199021)(31696002)(8676002)(316002)(8936002)(5660300002)(66556008)(66946007)(31686004)(6486002)(4326008)(2906002)(478600001)(26005)(6512007)(53546011)(6506007)(54906003)(66476007)(186003)(41300700001)(6916009)(83380400001)(2616005)(38100700002)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNjcGlmeFRHR3BYb2J4UURLcFM1dVNMbU1TWENjSGFPaExiL3RpWk1nRGph?=
 =?utf-8?B?aVJqL0xaNDFOSzVEc05sM3BURTNTTFd5ZW9vQi9wditDUUdMN1dlQzdRVHB6?=
 =?utf-8?B?NWxFVlRqNkJqV0dCUm5xbEZzcnpPZmVFSnYrY1R0Vkw5amhFQXUwM0pHMzNo?=
 =?utf-8?B?c29hVlp4VllKQnhsUG9ic2JUL3dydmRKQk5ROGQvdkpuYkJHdEtEcmdUVkM2?=
 =?utf-8?B?clgwVjFGV0ZwdTBEaUpuNjZ2NXh1aWRWM09aL0pmUms3UUNsUjVoNisxZnMr?=
 =?utf-8?B?WVlhZ3lGYWNrOGdmTWVUMjhucVdFVVBqOEpFV2o3NnAvWE0wb2p4QWVaK3ZM?=
 =?utf-8?B?NVdwUkR2b3RIWkVCSGZzWEJOS1B1OTk0UE9aNmFSMzg4dTB6SWc2ZnNPUlBK?=
 =?utf-8?B?OHdVc3pQQXhNR2R6T2ZvNjJ0RW9QSzB0b0h2ZFNoY2ZPSjhiVlhOVXZ4Vk5m?=
 =?utf-8?B?Zmh5Q2o3MEZ6QXM0MDVQb2V1MUZ1czdmWGxUeERDVGxycE9lbndHdldScjRC?=
 =?utf-8?B?cjQ2NTc3YUM3MERFR2s4UXRvOFR5ZEQ0R2YrYlI3d3VpaVpEbk5LRnlLVndB?=
 =?utf-8?B?TG44bm5xUTlUYzZIM0FwMWpWY2h5TWRmUllzTnFjRmowVzNpZUY1SUVUY1Er?=
 =?utf-8?B?bnVJQURySVJWK3RVUGNkcE9rSVdRbk1DTTFSRWFNN1Robkg0ZGVPK3hsMURL?=
 =?utf-8?B?VXdHVzRybjZYOG04Tkp1NVhOTk04T1loajVPNVVmKzRCTDhFcGdManNoV3lN?=
 =?utf-8?B?SUpIMkdLVFZxZnEvc25Kc1p5TDFaSWplTVQyN3E2alBtTk1mbHduZEVEVHVK?=
 =?utf-8?B?SmR1UzVOL05mMUY5QlZIM2RCc09WRDNkVlNuVTZPMWJsUFVEb0VGTndPeEU4?=
 =?utf-8?B?bmgwWGZtV0lBWlcySlRMNjZLSk0vVmxnWE1Jc2hSbVR3cTlGS0UxaVQ2Ymly?=
 =?utf-8?B?VWFoUnVzMm1sb3MyWVU5NWRiMGNMS0JEOTFFazRtSFJrMHI4YkRnYWJWNk02?=
 =?utf-8?B?TTVrOEhXeFlBUTQrRUU5QzV0cm5GRWMvRFVzaEFGTDBuUjNLRXFPbGNTNWhP?=
 =?utf-8?B?TVpKSHNBMDR4SVRpZS9lL0I5QVNvT1Q2bWx1U1piNU5CWXF5dkhIS2NTd3Zh?=
 =?utf-8?B?c2RLWFVsVXdrdlJWVkgxMjRhZXUvbUVyNXpKU0VhaVZ5bzFUQ00wM3pXN01t?=
 =?utf-8?B?S0Rad1RqVW85cGUxbWFwRHYyczBJQUk2Ry9pQ0JZT2w5QnRMNjJqUUpQeUhS?=
 =?utf-8?B?RTduUmdHanF3TS9qMG02K0VoZW5yLzE5TmV0dzR3RnQ4d3dHa2N5STcwSTRS?=
 =?utf-8?B?SmxRYlhNdWVYdTRka2ZHc2dScmhzaHNrUDB2NVR3TE5iMDl1N0t2V0xObkJv?=
 =?utf-8?B?bTlYcGN5NHhmTVpCMHZtRm54WWZmcWdFaUREeldLKzhUb3BJTi9MQ3FoZWZo?=
 =?utf-8?B?dmF6dmdQU2NXQ2l5WDlrWlU5QnhKR2NiaGlwWmR2WnFqbXdzb0lPUUVDeUlE?=
 =?utf-8?B?emEwYm5jUWtEcndpeFFGOEVtZzlBSk5ONWxhYmhMb1pwcndieG1lSVhtcGdQ?=
 =?utf-8?B?U0g1LzU3VmxaR0NaNG9nQVNjZEhSRXhqUHBUREJ1cDl5NVB0dFpmKzdFYXVK?=
 =?utf-8?B?ajk2VEYwNFNMMlBQN2dCMUh3U2ZsejdUTDl2MVJXazJlUUF5OXBabHgra1E1?=
 =?utf-8?B?ZlNGM0RGVnkweDd1UWVsdVBDTXJ3NEsvL3c2ckQ0d3dvZS8vUmw0U2ZQZkZG?=
 =?utf-8?B?TUdSVG5aK2oydHYrdDFOdUdDZ1pjMFpMaXVWMGZIWEJVSjBRdjhhdWtITk9L?=
 =?utf-8?B?RFNTZ2ZhTTk2RUVkanpwU2pyMVUvbkVWOWlTYytKM21KbGhtV2k5a2w0UzVq?=
 =?utf-8?B?SGxMTEIxUVlXN1hMdHM2RmRqTXUyNDRlRS9xY3ZFZHBaMytkdWZGNGtZUmRW?=
 =?utf-8?B?eHNwbVg1em5xMzBzVnYrTFZwTjJWODFoK0c5MCtlSHY0Z1FXTXZZZXlKYUti?=
 =?utf-8?B?YndYZzVxOGhsUDhKM01IdVJRR1JVclRJUlo4U2VEZkFMUTlka1ZUOEhVd0ZQ?=
 =?utf-8?B?YkQ4VGxqNjlXV3BMNUFZTy95bkxOS2k2L3hIc3BPbC9HSVphMUxNSmlMZkgz?=
 =?utf-8?Q?wrh6qAnWVRDtbpR5cHYBwvomk?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ff811d-e085-44a6-caab-08db870422c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 20:26:43.6572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsjjovRnNHvKSrARjgDF+ntVxZ/Ei7SdeAxrWDaT2Gq64kftrwcwRfKukC6NtPRy9mtKCylqe4LbJCmBwMDm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=2a01:111:f400:fe16::72e;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 7/17/23 21:04, Eric Blake wrote:
> On Mon, Jul 17, 2023 at 04:55:41PM +0200, Denis V. Lunev wrote:
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
>> That was commit 0eaf453e, also fixing up e6df58a5. STDOUT copying to
>> STDERR does the trick.
>>
>> This also leads to proper 'ssh' connection closing which fixes my
>> original problem.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> CC: <qemu-stable@nongnu.org>
>> ---
>>   qemu-nbd.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index 77f98c736b..186ce9474c 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -274,6 +274,7 @@ static void *show_parts(void *arg)
>>   
>>   struct NbdClientOpts {
>>       char *device;
>> +    bool fork_process;
>>   };
>>   
>>   static void *nbd_client_thread(void *arg)
>> @@ -317,7 +318,7 @@ static void *nbd_client_thread(void *arg)
>>       /* update partition table */
>>       pthread_create(&show_parts_thread, NULL, show_parts, opts->device);
>>   
>> -    if (verbose) {
>> +    if (verbose && !opts->fork_process) {
> It seems a bit odd to use the global 'fork' but the local
> 'opts->fork_process' in the same conditional.  Perhaps patch 1/5
> should be modified to also pass verbose through opts?
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
sent to the thread as [PATCH 6/5] for convenience

Den

