Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103375697D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRMQ-0004ZQ-79; Mon, 17 Jul 2023 12:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRML-0004Z1-1J; Mon, 17 Jul 2023 12:46:05 -0400
Received: from mail-vi1eur05on2070a.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::70a]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRMJ-0005PG-2G; Mon, 17 Jul 2023 12:46:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJOHwydwulBN1JkPAxF5FuOpSeLpJyzbDxv6bOGsY1rXOcNe9bBttqebY53L3p/GOo8wl8raE/mb0X914BZ5kW5GwCNyiEFEAc3DJesJbFV3WEDuDDItFXQYuui7HKlTUF/AcMPB4eHVngwpXXXpIj+A4Jyd0TQG+wPMMHrDC6cIgOufUGvDGJCjl10mdI1948oAGDFZGd4qwOYoCz8fFeXG28PyAwFdqt6qp+ng6n4BLX3f+8IFx7o+8hT5ErO/L0SfRE45n0+Nf0kaUOblRB4Q4ySIzDDCv/7WwjKqJ+tmJjzqmoTOQQY02LUtAvJ0GwOkC1xvm1tJWZ2fniRLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOPhapTDpQOHoJQV7u3urQUY+eTOPORoZ7Q43rAG94g=;
 b=MaMTbPxdh39tHd0gYNLM10A8bW0jm37GWDeuSBqwBpQ1zBPC50qhbYMh5vIaaUKaXE15JjHxJ3Ud9x2hJKP5QYtkz9UAQsFLoX04MaClJ/cunXYt0+gMeNS2gpe2EiqCslJxCOdWVDJFF1VzXH28MktPx5YDdhcyU34EaL4wW0/GgWxG1fp8yIC7Ny9OAMMZt6svxzCYXqfo+zwcPWmF6ddIQcgNX0VDPw4HeFQgME6ugvR5U7jS0FQFo8J5Ojm9coUTC85fhtZhb5JdgGGCnspzIFF12weMfl3RaOcMVVRUsaKV9uL0Vygaw6/owLo2icdqjLiP1e+XG6aA/2TBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOPhapTDpQOHoJQV7u3urQUY+eTOPORoZ7Q43rAG94g=;
 b=gssDHTmeHIgQsoVmomNPgmDQXld1FySV63Td7k4NoI+/+MQ4GaFJycDP0kaJLjcDWoARbykINsU5KXhvChOb+SD1kNdENLruhvHl6m6SVAqFFyHsHWEtZh8i7mWqjGRfkVYRQ0QAIgSrCWtL75cGTHO8NH5qKphuCBtVEWoWYJzaXBXyIFo5o8DNlDzcX1fgwwpzPcOSShQji1KVAGkplmxir5cGU+4R3FfrxzGNI0Dw0lzjRo/TY0saYgSRmetThciIcGZ7zB3ghbP4/LjDBbKzZ1Xf/crxy4cysMES7y9t84iRc/fsOE94BEcnppHZMV0QyyRmiTswxjhahPjM+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB10295.eurprd08.prod.outlook.com (2603:10a6:20b:647::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:45:59 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:45:59 +0000
Message-ID: <99f7079d-f0a5-5065-35ce-9b9babb5ca44@virtuozzo.com>
Date: Mon, 17 Jul 2023 18:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 6/8] parallels: Image repairing in parallels_open()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-7-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-7-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::7) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB10295:EE_
X-MS-Office365-Filtering-Correlation-Id: 18861802-b4b6-4b15-d379-08db86e54c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJMVJwb8xNTrCT4ycAElEmueGIPicmxyk5jVxeoTMpSQsB7qocRNXLeGJxFmGDlz6naRDqGtZmToVWjBSvZoNWLLCbB5xIyZsdFdei6w3VK3bhwBI6JZzYPF5jTP4gBf3UOIjWA74v4wNpARDi0iX8o9KFCcUA8pfc/9w5zRaHjfmNM9+5nrzfNS6gNIdvZDrIDyl3X8DMd2CqVnXR3GjATWcG7rvOnyeMHicwfEIpEUHAoVXe7sgIYU4L4i2zBQ+RLCbNm/3R/al/UCf5XrmJdv8rxRssmRotOyyDj2gJKqbIUYlFD+fUUt+DLSDQMZEBZZEnb6OdG/opUunFIdoF0CAORCarECMTKtwBQTP1R8R3Sszt6S/QG6wAEpnZvpkDdLt3r8VkghPKu427mnLPgnN02kHBmEwSzdhdsb4OKWP3UD5k2v1GjvMI8n4UtP3mpbjJTphvDwEcwKqsFm3tYPPypkXQkhWbdcN3gFaQ3k20HwwAzyEA0K8aSICt5vuNRYBazIhBtLPj+hVaNlurVlgswRbc+bwn90Ccpsmdh0L9x7kf2v30IquqJ9M5xes6N9j6rF5x/NoRecEE1jmZTjjM/iQToOlLFp60gKZUdBCkyld8J0T/lC7zBUNjmn5ZBpwhA2AbBzaiJxjtWmeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39850400004)(136003)(396003)(346002)(366004)(451199021)(6512007)(6506007)(53546011)(26005)(66556008)(66476007)(66946007)(36756003)(38100700002)(31696002)(2906002)(316002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(6486002)(86362001)(478600001)(6666004)(31686004)(2616005)(83380400001)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emJ5VExlOUk5RC9BQkI4Yk53K2JqKzZNL3c1OU1ma2g3cFhuN2tMOEZUMFdS?=
 =?utf-8?B?M1Q5QXZZWGxJOTh1Y0IzQ3NpbE9Mekp1WUhnUklPU0pQYmlKNWdONVFyUnlI?=
 =?utf-8?B?anA5Szc5QkhhSytreHQzR2lrKzRmS2hnTnVoeERkSTdEdEJ6S3FRUHphYVIy?=
 =?utf-8?B?UTJKMjM2eCszVG50LzI0Y29BdGxsN09sT0F2YklUcUdSc1lZRmFPL2ZzOXdw?=
 =?utf-8?B?a00yaEVEaVR4aU8xWE0zOUdpSytFVUFrRnZXUGthVHJIUlN1dWcxNWpiYTRN?=
 =?utf-8?B?MTh3RUIrRUM5R29pa1g5RjdpWWxHUENYUE5uZHlHMVJFYnY0UDZCSXc0S3Vv?=
 =?utf-8?B?UThWT0UzNW42TEpTd2MwNXNubEVrQUxaZnROdTRXS2FydEhnRjhqZ0dqZnht?=
 =?utf-8?B?R0JXbXVzL1VXL0RkTGRQZjl3Sno1eTR1bko2REp3cW4xbEYyTkFtbzZpQ2J5?=
 =?utf-8?B?bFpHUmdFNFV0YkxxQ3YySC9OektPSlBrZnRXWU9zZU1SRnhwdCs1ekR0NXky?=
 =?utf-8?B?TDFkYXMrbjdaaUlIYTMxTUhWUm56QmRrNHkwbG92amtRUTNyandhbnlUanp0?=
 =?utf-8?B?Ti9BSmczenIwQW1OU2dDWkQydjlGNFZ2cGlHdDBxSjgrcUh1OUxqcEpDTkpV?=
 =?utf-8?B?Rm9KNFpjdlp1b2FxcWx2YzJoK2JRaTNCemZOVjBzaHcza3lUK2FhUGhoZm9h?=
 =?utf-8?B?eEd5MGlvWjlvZG1OU3MvbGx0QXBOUGcxVFM4ejJUMm5NcEtaZ3owc2ZXdTNE?=
 =?utf-8?B?TTg4SGtLVmYrUVpnRmQxNG1Kb3V6V0pjTHoyL3JEeTJiUnRpMHdIN3pGRGtB?=
 =?utf-8?B?em1vVWRSWGVKOTlyKzlUWjFTM1BMQU1rV3AwVjc5ZVpRTkFSSkh5b0xjVTlX?=
 =?utf-8?B?OXA3TEFKb1YvREJKeXhxbTA5eUZDZW45OVlINjhQdmhHSnVRNWFYRDJYWE91?=
 =?utf-8?B?YnhkL2pRU2VzRlJLT0lBZGI1MmY3ZTBXcEsySFNkdnJOdUx4Wm1ObUphbTZa?=
 =?utf-8?B?NlNZakU3anJHN09DVi9ydnJnNkhFV2FKR0d2ZG9NaGhobEhPQnEvZ0tudWg1?=
 =?utf-8?B?V0g0czZqQXh2Q2R4Vmltb0lGakkvNGJjaytWN2FjeFppUEJ1TTlyeFpWY1Fo?=
 =?utf-8?B?WmhVOEh5ako0Ty9JakdGZnlqSzlOeDVacjhJVWl3bHFMVnlqb0JzRVNaR1hF?=
 =?utf-8?B?TTNFdjVOSDJ5dENkaENlcC9aamptSGVSTjMxd1A1bmp2TG1nOW5YeVUrS2ZB?=
 =?utf-8?B?UnVIQ0RSem5UM0NWVFRHbTh3c1A5UXljam9IV2swQ2didUFMS01SWSs0Znpa?=
 =?utf-8?B?VC90aFJCZzZFbHNkbWJ0Qm4yVjN4OVIrcnRnSXZSY0lnWG9lQmZFd2R5NWFO?=
 =?utf-8?B?RlRrNnRSdG5tU3ZVNENrTmExQXdCL3AxeGtraEx6U2F6YitVdDBZTkFSZ29P?=
 =?utf-8?B?Und2bHFJdTJMcU5JZTBOZkwxZkJucXhud0hYblFodnpjV01rYTVyZjdtNUZn?=
 =?utf-8?B?QWw0VTEraysxbHZWbjdvclU4dEVVQXhsa0xkOEJjMFFZVFZQdTVKNlhMcWNF?=
 =?utf-8?B?WEsvdmE4b1MxM2hZOW1TNlNueU1xZXBXZDRGK0RmVG9neVdQRzQrWjE0Y3ZH?=
 =?utf-8?B?MmNFTGtuWTNqK3JsRVkxd1o2ZW9acjNlT0F3eW9qclpjRTBlOUFtS2h6anZR?=
 =?utf-8?B?WWhVYy9sS2JhdFY1c1RiS1k4WHFDOW5NQTRFN3VBWkJ2VkUzYWVIcTU2RitG?=
 =?utf-8?B?T3ZoalVWRlBGa0o3eFZaeGZ5ZDdIL0M2c2VIdWtvY0pzcmlNWU1yN1RrZmZr?=
 =?utf-8?B?KzF3VFQzWThuZlhHYnRkNU1sT2ZVV2d2Zzg2RDJsZDVjK2t6QkJsVXBzYXdB?=
 =?utf-8?B?TXNTU0F0eWdndHlzTGwreHBDRCtzV2lDRmozc25Kb1E1RWljeVZPbUpqMzNn?=
 =?utf-8?B?eHJGOVV4U3RKT3pBNEtHeGJYNGxidmgzeFpVSVdzaTBaL085M3lKbEcvbTdN?=
 =?utf-8?B?KzIxd0RiZGxUZzBLMCs2V0FOSEhMVGsrS3FjNTllRDlCb1hhamlhdUV3elpw?=
 =?utf-8?B?S2RWSGc3R0ZnZGdQWGdvdjZjbjRwbVRiQlZSR096eVhtR3Z2SE1TTmtNYnJ3?=
 =?utf-8?Q?/qBqVoVE6Dv65hPparjEnVzUP?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18861802-b4b6-4b15-d379-08db86e54c70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:45:59.2111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe7Cp9SbDmwv2omNQJpHuKMK+QMsqMmT88AJ4Es4P+CMdibjFdh2lQIMYBJmEuFzTlkML4zatpupJ1bwYNGdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10295
Received-SPF: pass client-ip=2a01:111:f400:7d00::70a;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 7/1/23 12:07, Alexander Ivanov wrote:
> Repair an image at opening if the image is unclean or out-of-image
> corruption was detected.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 70 +++++++++++++++++++++++++----------------------
>   1 file changed, 38 insertions(+), 32 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 0f207c4b32..51fd8ddf5a 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -947,7 +947,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       BDRVParallelsState *s = bs->opaque;
>       ParallelsHeader ph;
>       int ret, size, i;
> -    int64_t file_nb_sectors;
> +    int64_t file_nb_sectors, sector;
>       QemuOpts *opts = NULL;
>       Error *local_err = NULL;
>       char *buf;
> @@ -1018,11 +1018,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>              and actual data. We can't avoid read-modify-write... */
>           s->header_size = size;
>       }
> -    if (s->data_end > file_nb_sectors) {
> -        error_setg(errp, "Invalid image: incorrect data_off field");
> -        ret = -EINVAL;
> -        goto fail;
> -    }
>   
>       ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
>       if (ret < 0) {
> @@ -1030,33 +1025,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>       s->bat_bitmap = (uint32_t *)(s->header + 1);
>   
> -    for (i = 0; i < s->bat_size; i++) {
> -        int64_t off = bat2sect(s, i);
> -        if (off >= file_nb_sectors) {
> -            if (flags & BDRV_O_CHECK) {
> -                continue;
> -            }
> -            error_setg(errp, "parallels: Offset %" PRIi64 " in BAT[%d] entry "
> -                       "is larger than file size (%" PRIi64 ")",
> -                       off << BDRV_SECTOR_BITS, i,
> -                       file_nb_sectors << BDRV_SECTOR_BITS);
> -            ret = -EINVAL;
> -            goto fail;
> -        }
> -        if (off >= s->data_end) {
> -            s->data_end = off + s->tracks;
> -        }
> -    }
> -
>       if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
> -        /* Image was not closed correctly. The check is mandatory */
>           s->header_unclean = true;
> -        if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_CHECK)) {
> -            error_setg(errp, "parallels: Image was not closed correctly; "
> -                       "cannot be opened read/write");
> -            ret = -EACCES;
> -            goto fail;
> -        }
>       }
>   
>       opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> @@ -1117,10 +1087,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>                  bdrv_get_device_or_node_name(bs));
>       ret = migrate_add_blocker(s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        error_setg(errp, "Migration blocker error");
>           goto fail;
>       }
>       qemu_co_mutex_init(&s->lock);
> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        sector = bat2sect(s, i);
> +        if (sector + s->tracks > s->data_end) {
> +            s->data_end = sector + s->tracks;
> +        }
> +    }
> +
> +    /*
> +     * We don't repair the image here if it's opened for checks. Also we don't
> +     * want to change inactive images and can't change readonly images.
> +     */
> +    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & BDRV_O_RDWR)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Repair the image if it's dirty or
> +     * out-of-image corruption was detected.
> +     */
> +    if (s->data_end > file_nb_sectors || s->header_unclean) {
> +        BdrvCheckResult res;
> +        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not repair corrupted image");
> +            migrate_del_blocker(s->migration_blocker);
> +            goto fail;
> +        }
> +    }
> +
>       return 0;
>   
>   fail_format:
> @@ -1128,6 +1128,12 @@ fail_format:
>   fail_options:
>       ret = -EINVAL;
>   fail:
> +    /*
> +     * "s" object was allocated by g_malloc0 so we can safely
> +     * try to free its fields even they were not allocated.
> +     */
> +    error_free(s->migration_blocker);
> +    g_free(s->bat_dirty_bmap);
>       qemu_vfree(s->header);
>       return ret;
>   }
Reviewed-by: Denis V. Lunev <den@openvz.org>

