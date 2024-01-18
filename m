Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C3831BDF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:56:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQToL-0006Vf-Gx; Thu, 18 Jan 2024 09:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQToJ-0006Uo-8l; Thu, 18 Jan 2024 09:56:03 -0500
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQToH-000217-1S; Thu, 18 Jan 2024 09:56:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPiAwI9CHsLeNvKlpDbask/gTn1qFJp1Gh00gpsCR+BYyl8Sc18U595hMnx8iRX27XwvlFFnCjAGTw55pPmr6RzrXsMD7omZikin5V4sPSeP7idTJ/vP5jq7ttaCiR9nai+7lZ7G17ne3EJGXKXad088gkkc95tkQQKd9zzuXdGYiPMHFXKf8DSDYWFZ+tAN5McHykV1X2CUUUPGf+4XdjDRSUEcX8BMHCCqknxKOxJbpqWU3wpSaqkw07/3v7lBbgqq+RtPTT2qb6ZdAHNazmO1LR3Lu1elyM94cVvX/CFRPVLS4el5O1D01UrWsu0L8+9iYapUvY5IlPHTgRKHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0m1O59lJDLtyVYqJbJB/pvm4ZwMNvwMhz3qiYZTmzg=;
 b=OnX/yrPz54gM6B15LMBQaloy6I34nxRIiXNZuM92Xnox6U03Et5QyOX28n0eMOoLOG62ZZMqjj1eRr4r5RJoBAEjCTNe8EWjir/1bNy+ThtpnmRf5YA6MVaNjAl4aC6paFEaL3YB+AAw4BJB9kNF3ZwFB+G6sxQDAEUZUEg6WwO1TAEfd8dUa65zhtGS/KOwoPohlgXp6Kg2yzSDGgWs1/FLpt0dMMKJqEfysAv/tS0fHhROM1c7PKi26NG9l+ujTWRQuU61SmFK9g/ocz0aH1whOhrqeLSp7wq9liqZsw+7gKwTrn9lWqAXmBQ3hn5a10SvsF586yKpe6wzLDSWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0m1O59lJDLtyVYqJbJB/pvm4ZwMNvwMhz3qiYZTmzg=;
 b=jcPvbBk/hq3YDFdQftztNXTg74Iu1XgKBw0Vb9z2k0zRFvGFmW+X/fECNO8K3BL4WYkXUrpoeXYBbmdlqEtAoIYm21zkR1MUE/O6rZYuBmXkFSocX7a7yD0r3ktzEp6UYdC3moPDLptw84nkEJIHhuvFBDleWON0xLxE7e8uVzHOim8yPLn5j6xphuRIgxRAdtQ0DAaFw7Ea2AJgk1pKWGsMvxgkQ3J6eiC2CFOk3WMnIXWn76OlUlRUqPSisI3IlkZegMxt0ivBqYGd1Aaljl4KO+yPO1gEr9IExCrKsz6m6qmoWmh4qBcyFyTvBhfvnX5cghTyHXDhcOudgW1Yng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB6747.eurprd08.prod.outlook.com (2603:10a6:10:26e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:55:56 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:55:56 +0000
Message-ID: <515e9d22-c6c1-4c7e-a40d-6e03a9e97130@virtuozzo.com>
Date: Thu, 18 Jan 2024 15:55:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/21] parallels: Check unused clusters in
 parallels_check_leak()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-18-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-18-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::15) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c58d466-829f-4ca4-e51f-08dc18359311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHs1PIlNTPVvvuGAJczbFYUJmKkGhjgJ4YDoLFTrcX4JXW7BiWtI1Nfkc4B6vDWwVoClqFXQtqFprtG2Gn3Y1oTXp/mbNR5YAub7AvQMIUxj8L6uKBij0zlI0xUxQDersulgtZZw9DkYhQpV7WJcht0EW6+1acgJAgMKvnvbrQ34FAGunSpmRQCv2oW/rs4sVGkYKTQ1R+G2hePmdmdmeF41+CrEduNzCf4fI8bDwm/A5xUxAx9PEMReC4mcTvrjwHjgntKm+dK0itaLquJmq4Vx7Pp8D46J1x3qymBArPta09TbdypGMIUaO5rnOB3LI1Q+sNsA2eO1BnrVRLTw4+aFl3fEoZqg013Nx0aTsxb7bTE4gKMImpeH3jhAElLmMHfnuyNQs6v1jLuKiUkBzVb3Mjr1f0jykotcT0eeuq2k0ssiZMZCuHSqQD0oX3QV9HiCI7Hq/fBEFjTlAy8jmKZKO+refe4khY6vLWDDe8q3K3xcl7RrjCVT86MAwZjZLqcFzsTO0qw9j5EYyUq55PVGBgeNrtqZ3ziciuxWkxBixm7alpishylgGi3iNhP72L/HeezL83NxEzqQyA1YIZ14sU5PAGsBlAVHZUoJoYsSlWDeLkqawPfLJ4cDlyBfimQnBCOJLXBygQNn7me9bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(38100700002)(83380400001)(36756003)(31696002)(86362001)(66946007)(66476007)(66556008)(4326008)(2906002)(5660300002)(8936002)(2616005)(26005)(316002)(6486002)(478600001)(53546011)(8676002)(6512007)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS8rMHk4VWYzaTIwM0F5MWtVRWdEWVBlTDhWMFpKeGVNTjllMkxTbWo0dFZJ?=
 =?utf-8?B?M3ZpaHNjdm9WbFVQL0pYSGxkc0pNU0VKYllMVk94bzVzclcybUhxRDBWZGJx?=
 =?utf-8?B?elVlVkxZb3hRNzF3d2xlQWp4MUFDWnk4VjY3bmMxcWxHRkNVeitQZHkzOFJj?=
 =?utf-8?B?b1cxbFphOFZwR2ZRNW0yUkd1YXYxNkdkNVJMbUhPNWJEamZIUU1wK1ZTM2Zp?=
 =?utf-8?B?MmthZE5GZG9EK3p2TDluVzN0L01nVkNLdW5HaUVJZ0hGMjZ5QmZBbG5JbTk3?=
 =?utf-8?B?ejdiblhJSS9JaVlUbTdSVGdxZnlQMXg5TUptT3hmVTNvbW55MGRma2pjMVY5?=
 =?utf-8?B?TmlwbXAvb0pac0hWQitmR2ZocStORHYzZlBJbWprdlhlSWNrOUowYi8xM1Nv?=
 =?utf-8?B?b2VjbCtMRU1CRGhKUGkwdm9uQUYrWXp0TzBydHhyS1d0dFJyMnNMcmdheUUy?=
 =?utf-8?B?SHU2d2tNcDVtUVo4blhqQUgyRGZJamNmdmNJeldyejRpWGNYdlg0R3dtV3hY?=
 =?utf-8?B?Q0M0TzlnSmtFZ0JTZDFZRGRWUDA5NllCZnN0L0N1RVFpb3ZkN0FyUUl5ejZV?=
 =?utf-8?B?OFdIVXBKNXM1N2pnWVNKNFhBY29jMmNuWGVTdkd3VFp1dGhRVU41SW9qNm4z?=
 =?utf-8?B?S1RQNFh1Wm90elBoNSsxSlNXUmM2R0l3Y1ZOTzhnMldiVUliaXlaTVVQV2VV?=
 =?utf-8?B?SUQwa1FVeXRoNnlUKzNqYzU1TS9wZ2FsZWlCelc1MzlseFhDNUxvblpLRksx?=
 =?utf-8?B?aHgrUzFRWGtUbE5nSXVqN0VmSGxyYm13S3krb0xIQ2FMTDBsYkFSMXMwZnJ5?=
 =?utf-8?B?R2NZdkFHTlZaQW1mSjkxck93TWlOZGxZL3hVTkNNY1ZPWHhUY2hCWWdsRFNG?=
 =?utf-8?B?MGlSTFBtdmJLM2NMSmM4NHFjeitpSUR2R3I4ZjVzQlpTUDJkRlc2KzNnTkFU?=
 =?utf-8?B?NVF5OWFZSmtTaXhyTktHd1VkM1gwS04vMm9GeXEvcmUwTDFmeUI2Tkx1MVly?=
 =?utf-8?B?VnR2aHMvc3QwMHdEQnhreFJPL25ZNzk4UnBGcHBadEliMktKZ1BjeGIwK2tK?=
 =?utf-8?B?K1RQc0RKM09mZ21NcUFyOVZwcVdnT2xSYkhDWUFyellQWTNsdG45TEVETFlE?=
 =?utf-8?B?V2I2SUU1djRBVDFWcjA1TS84cFVucHBiN1hzVHZBR3ArY1NtNWpoWE94dVpu?=
 =?utf-8?B?QnQyNUpZRTJMUTlPaTJtdWI1MW1FajhFNmpVdjZEbUh4SGZ4bnNYTGdObXVJ?=
 =?utf-8?B?NEpKZFlhL1N4NFR2a1dHUlBXV21UN21GWk9xbDh3cFNJNEQvcDZQOC9iaXI4?=
 =?utf-8?B?bWRtamYvdWphUFRnQ1JhMkRKNlVCRzI1ZGM2TUd0UUlXZjEvVjZMNjQwZkhn?=
 =?utf-8?B?WWRBV2k2NTdHK0QwTUpwbTlxZ284blNUT2k4K3lXUmdkMXAyUVU5T2hPdWFW?=
 =?utf-8?B?U0drRnlLdE1EK2JXMkdONklDTUQrWVE3aThGRVp0SEhVVVk4NHNPS3hGdGcv?=
 =?utf-8?B?enFhakhHTVJRNTQ4MU82RmEzazNZUERabTI3ZmRXdkZkNklST3I5eEpONHZi?=
 =?utf-8?B?YlZyb0FVdWVPc3NTb0EyaVRzREJrME9hVmk2RGRlQVBnVEV2VjJCZjVHYWdn?=
 =?utf-8?B?TkJ3NGFvazVpZXhTa0Q1eEVUcjBBbnZpc3lnajN1VElPeitEdTZScnhEcEND?=
 =?utf-8?B?WE9SdnVmL29CRlNBY3VLWHBsNEJFRGxhQ0VDajJiSFFjSjhaL3RabElBRVNv?=
 =?utf-8?B?ejJIbXh2NjV2SExEYXozaXpvVGlPbWdFVmFjS2dDZXdRbEFCeHlFVGJ3Z1oy?=
 =?utf-8?B?emZzWmQ5UTZ6QWlYdDBNMzJwQkJ5eTQxNEtPY3JuSUVQZHo2MTdqQmtRRzNK?=
 =?utf-8?B?RFNKN1hxczNkSGprTnBBUFJqOGl2cDMxNU1qdmM5Rlo2WkdFMW5xeDR6cDhI?=
 =?utf-8?B?N2FSQjUvSTcwclhNcHZoVy9KeCsyS1ByRjAwVlZXTFA1djNhaFljSzN5UGx2?=
 =?utf-8?B?TER5TE1LSjJsZTVsZHA4bkhhMWRCMllCVGNoSVp3VGk1YWFLN0dLVG1hbndP?=
 =?utf-8?B?RFF6SnlhU1oyWXU4K21GZURUMTJNTHdUbXJvY0plTWJPREx3VUl5RlhsR204?=
 =?utf-8?Q?4g74P5x+li90jVek86wU+l1pW?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c58d466-829f-4ca4-e51f-08dc18359311
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:55:56.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb6xbIPwuhAX5X6SPWHIP3gmhOTI+dX7xalBui9+A0VUBD0NCg/0TgaX5JzlHXmFG1hlE29rvN31yEHidXdmSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6747
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> Since we have used bitmap, leak check is useless. Transform
> parallels_truncate_unused_clusters() to parallels_check_unused_clusters()
> helper and use it in leak check.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 121 +++++++++++++++++++++++++---------------------
>   1 file changed, 67 insertions(+), 54 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 136865d53e..5ed58826bb 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -768,57 +768,87 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>       return 0;
>   }
>   
> +static int64_t GRAPH_RDLOCK
> +parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t leak, file_size, end_off = 0;
> +    int ret;
> +
> +    file_size = bdrv_getlength(bs->file->bs);
> +    if (file_size < 0) {
> +        return file_size;
> +    }
> +
> +    if (s->used_bmap_size > 0) {
> +        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
> +        if (end_off == s->used_bmap_size) {
> +            end_off = 0;
> +        } else {
> +            end_off = (end_off + 1) * s->cluster_size;
> +        }
> +    }
> +
> +    end_off += s->data_start * BDRV_SECTOR_SIZE;
> +    leak = file_size - end_off;
> +    if (leak < 0) {
> +        return -EINVAL;
> +    }
> +    if (!truncate || leak == 0) {
> +        return leak;
> +    }
> +
> +    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    s->data_end = end_off / BDRV_SECTOR_SIZE;
> +
> +    parallels_free_used_bitmap(bs);
> +    ret = parallels_fill_used_bitmap(bs);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return leak;
> +}
> +
>   static int coroutine_fn GRAPH_RDLOCK
>   parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>                        BdrvCheckMode fix, bool explicit)
>   {
>       BDRVParallelsState *s = bs->opaque;
> -    int64_t size, count;
> -    int ret;
> +    int64_t leak, count, size;
> +
> +    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
> +    if (leak < 0) {
> +        res->check_errors++;
> +        return leak;
> +    }
> +    if (leak == 0) {
> +        return 0;
> +    }
>   
>       size = bdrv_co_getlength(bs->file->bs);
>       if (size < 0) {
>           res->check_errors++;
>           return size;
>       }
> -    if (size <= res->image_end_offset) {
> +    res->image_end_offset = size;
> +
> +    if (!explicit) {
>           return 0;
>       }
>   
> -    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
> -    if (explicit) {
> -        fprintf(stderr,
> -                "%s space leaked at the end of the image %" PRId64 "\n",
> -                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
> -                size - res->image_end_offset);
> -        res->leaks += count;
> -    }
> +    count = DIV_ROUND_UP(leak, s->cluster_size);
> +    fprintf(stderr,
> +            "%s space leaked at the end of the image %" PRId64 "\n",
> +            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
> +    res->leaks += count;
> +
>       if (fix & BDRV_FIX_LEAKS) {
> -        Error *local_err = NULL;
> -
> -        /*
> -         * In order to really repair the image, we must shrink it.
> -         * That means we have to pass exact=true.
> -         */
> -        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
> -                               PREALLOC_MODE_OFF, 0, &local_err);
> -        if (ret < 0) {
> -            error_report_err(local_err);
> -            res->check_errors++;
> -            return ret;
> -        }
> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
> -
> -        parallels_free_used_bitmap(bs);
> -        ret = parallels_fill_used_bitmap(bs);
> -        if (ret == -ENOMEM) {
> -            res->check_errors++;
> -            return ret;
> -        }
> -
> -        if (explicit) {
> -            res->leaks_fixed += count;
> -        }
> +        res->leaks_fixed += count;
>       }
>   
>       return 0;
> @@ -1454,23 +1484,6 @@ fail:
>       return ret;
>   }
>   
> -static int GRAPH_RDLOCK parallels_truncate_unused_clusters(BlockDriverState *bs)
> -{
> -    BDRVParallelsState *s = bs->opaque;
> -    uint64_t end_off = 0;
> -    if (s->used_bmap_size > 0) {
> -        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
> -        if (end_off == s->used_bmap_size) {
> -            end_off = 0;
> -        } else {
> -            end_off = (end_off + 1) * s->cluster_size;
> -        }
> -    }
> -    end_off += s->data_start * BDRV_SECTOR_SIZE;
> -    s->data_end = end_off / BDRV_SECTOR_SIZE;
> -    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
> -}
> -
>   static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
>   {
>       BDRVParallelsState *s = bs->opaque;
> @@ -1488,7 +1501,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
>       parallels_update_header(bs);
>   
>       /* errors are ignored, so we might as well pass exact=true */
> -    ret = parallels_truncate_unused_clusters(bs);
> +    ret = parallels_check_unused_clusters(bs, true);
>       if (ret < 0) {
>           error_report("Failed to truncate image: %s", strerror(-ret));
>       }
This particular patch does not look good.

You are deleting the stuff you have just added (in the previous patch)
and you add lengthy operation (recreate used bitmap) on the image close,
which is better to be finished first.

I would say that the concept should be somehow reworked or the
whole patch is to be dropped.

