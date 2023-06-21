Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED0738C71
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC19D-0003jF-BI; Wed, 21 Jun 2023 12:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC19B-0003in-EK; Wed, 21 Jun 2023 12:57:34 -0400
Received: from mail-am7eur03on20730.outbound.protection.outlook.com
 ([2a01:111:f400:7eaf::730]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC199-0004Hw-GB; Wed, 21 Jun 2023 12:57:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXmDlBTJl3WofVC1iMUabFUnmkOBvCFjyUazxpOnSFQfj7lUyc9uYdp3D0R5G02W2ztH31Zkoa/bOSIS+kFCWBIoE5K8vVKLAK+aJTdtfCmujbRS/vns2qHRFQBZZrAlEko2/DWXBShCEjz1XaZlp4z08h936aPX8+lVPBkU3/knpwIGGJC+VKS6pVvb4Xovobpd2hzACVexVhAVymXNPlfaCeIVX+XfXFOzOBOOn7YVJneDNvvR+JV6I9T7OO4KatAYnfsp5v+uCswi5fEAAGieZ6+SVjyO4zJsjweQKi4uhT+4rgMGrKiFPjK3QzdUX3/ypnC8gVdnRxV8+uK/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peHKbQyelbw1/Od90f4TWvlLKdxrvYbUqZloKxte5kE=;
 b=K/Rx+CrZDRByi0jiS7jt57pGc4B+Tc0XYS9wUU4sbNzEqE3KnIV1UDs/Qfu7SbDbKBnZI/pOK+CPSt9nObmvbu/gGFdOaHxpfb1919xNE4QhkgDwC9fep8DdMyLDL1RFi36AqfeL1IQAWz4WKm5usQcgqRbl0x7ZzhZfSu2ADAQl1NhlbFRB7uomKLk/+YbC1HYpVYuSmTgzdDnSpB1An7UN1+ryQUjYF+P74Ge2Pss9erYjT1TVk6ZOkSSmF9rBonTaRl5ySHiuH/n0Ec+fMyldrmF2IZmRVZ5+zQckkLamqVmNa9VbV6PM2PsojtZlqxTd5Ra0wWWJOSOx5BVJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peHKbQyelbw1/Od90f4TWvlLKdxrvYbUqZloKxte5kE=;
 b=GPc7b4Kr/xGBIxrve1x9h+gVgxj8xJMEbo7HZGrpxhXsVqEUD3NlwvzWe9sHSXbQ5dUadZZ2iobtcOPyfZ4zuOfo/D1Em2Bob/xJTnpGoQlVda9oRb4wriq3ZzKWXULt1TwnXs+h1l2b9QrhMHCfShrXKh70RoBCRKtZ7iPznZhenFtrc31sdIq9KOr0Uckmgkre1Ij7H/7zeVsAS7wQ1InbBwbNCrCpqE3b94srgMWCZH+gYI+yleyRisIDDhO8ky0K9HkLq2dVOlCD1/8VImcCKkrxXvEBq/jYY7/Ud9DknJVXJuMU8hXMFyR8N9Jp1Vvl0hkoouUOdWCjaasJlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB9968.eurprd08.prod.outlook.com (2603:10a6:102:35b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 16:57:25 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 16:57:19 +0000
Message-ID: <2611f1ed-b95c-62eb-30f4-83522e4b7e44@virtuozzo.com>
Date: Wed, 21 Jun 2023 18:57:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 5/5] parallels: Image repairing in parallels_open()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
 <20230621082010.139195-6-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230621082010.139195-6-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0083.eurprd09.prod.outlook.com
 (2603:10a6:802:29::27) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: f0626aa3-8ab6-45ca-a996-08db72789321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWPFAixK3WLd8871bkEqXnRgzuIc4ouEjlEEsroJFLo7er47L2skKUZA5idrQf+tzI9nDDBZeZJh3mxFpxenYK4xd8UTONamLBsp578McsOiH7YcE1oc9E10JD1CQZyoBC9Ib6u/YMnAmsLjn9Ndme7bx0eJcB/3ICKLquAO4Yqm1M/jGTi08vNI6RhF0N4aglmFer7HeGq8PC+CQxtaINT4xuSxPRrv2Lg7OAFSD8JrhPU0w1j891/qWsMM1wDn6nqR1mZKGpXI42A3d/m78q7uWZ9TAkSBsrefmG8WiIQf2Kc0FPvwlTgqZ/eDfgAIm6IX7MexZceo4+Lezgq24UnCOeKETs3QJqFc2r0aNRMTqrOHVvk6SFOozeXCSmCLKRiHeQ9WGIl753oQxUlckiw0dmL9WksNgThQz9PNZ44i7w1zLExQ0yDCJ7WVSIZKbK7Ib6AogYniLh8F5pJSMwBUQtrXKS1WGjhrV5lAc5DI7zFcGTVcemWiiD2/GLI7jPmveAU2gytpITjUMczEZCRlHynbrleexEwc7oLh92Xd5s6xb8IAB1it8yOC9igOcg44ucfIZpJr3mcyDettP8zBTixRMaLqD0hsuadyGzPz3ttjZ78yhGw3Se+V4zyBLoBZ8mmb/bmq/12rXNPHXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39850400004)(346002)(451199021)(26005)(2906002)(6512007)(6506007)(53546011)(186003)(66946007)(41300700001)(66556008)(316002)(4326008)(2616005)(6486002)(83380400001)(478600001)(5660300002)(8676002)(38100700002)(66476007)(36756003)(86362001)(31696002)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0s4ZmtxcURsS2NWZ1RmUUtoNytTbXpRR1dnbGRLd2NkbkhXSXVZdXBoUjBr?=
 =?utf-8?B?T0VRd1l5dk5ZdFVnYnhpSVA4MFRPbTJjMTJYYmx2WFlaVkJmcmcwbHlpckRQ?=
 =?utf-8?B?STlnVllZOSt3WmVBczA1aVFSTjVsUHhNOHVRSjNLMWxrUDRwbFBqMVJhbEhm?=
 =?utf-8?B?ZEx1aE9RaUlnNzY4S3VobjUrWG9FUktiTE1DSHd5bHMyMWtLNTI2anY4c1Z3?=
 =?utf-8?B?aXl0dWsxWUltQ2FLT1pHNzRHZ2dsVDJEMk5ua3RHRmsxbldvLytmMDh4WDNz?=
 =?utf-8?B?YmZkZnhqSnNvZjRhVW9rbWdja3l3U0lndmJyZGhlZm9yZnA0d25sMFlCVkNt?=
 =?utf-8?B?YzMvWkVBdFpCNTY3dXZ3Um15VVpzWkk4ZW1HdXFpOTB6ZmdyK3lxWjczR21y?=
 =?utf-8?B?bHI2c2t1Wlg2WjBLWG1HN2xnUTUxaDQxVVd1dXZvYzZqbFJGUmpHeldPd2Uw?=
 =?utf-8?B?MDZZQUZ5dDVsTW4veVVlc2RzQlB5NmNUVENTa1YvV250T0ppcWc1Y3JzZmlZ?=
 =?utf-8?B?TGpsdUJJQkloekFxYzNiWFBZOUF6VTc0eVFHWDlrdm9nSGFhb3Q3amlXK05F?=
 =?utf-8?B?NjZmTnNqcFZtTExIOEk1YXNSQXhVcXZVQjlDVTZEbFFTMVhJcXRid3psWFNt?=
 =?utf-8?B?MmF0Y3Y5K3Z2TTZsN01TTDFydnBnNmI5dmdmOU1CTnVNNUd0bTc0QUgySFRH?=
 =?utf-8?B?S0tpNCsrZ0pVSmlVV0VDT2s5TlpHbExBYlEyTllMZGdkc2hEOGhiK1VhTnBn?=
 =?utf-8?B?NGtxOFU0dTRTc2EvK2VaWDZQSmlYOTNURE9qYXREdnlZU2xsM3l1bkJjaDV6?=
 =?utf-8?B?eHRYU2R4bHNPR3Yrc3pWWGliUGliNVJVQjY5bFRPNlJaZUZoV3RQZDBGNGdX?=
 =?utf-8?B?WE1vZUVWaysxaWJaT09BRVJ2MWNlK2Q5aU52Q1JpeXhDT3krZlduaDg0QUs3?=
 =?utf-8?B?T3IwdFUzSnlXNHB6SFlKUzVocEhZamJCVS9jSkFKR3BBM3RrcTdmN3FGZE1N?=
 =?utf-8?B?Vks2UlRRVWljSXQ4SjdmbVVXbWplNGFkeHRKeUE1bndRb3NtWlRMU2hyeWpa?=
 =?utf-8?B?eUtKVEVQK2JmOFhjZi81Y25qc3hTUlEyYmNWZUVZY0Z5YU5aa0JKK0g0U2N4?=
 =?utf-8?B?bGJNUDYzNXh4NG1yUG5vNzV0b0RjTjR4ZS9mSmNWUm10ZHJYd2RRSmtDN1V5?=
 =?utf-8?B?VldRWlYvZTlDd1JzdmpTbHFVU05zTUhpTWhpbmU0VUxJQk9UNUpveUMrdXhO?=
 =?utf-8?B?Vi9nZ2gyR2FLMVp5V1F5V2pOQXVXem5KV0sxcWswb2VZZ1lLYjVISVEvZlA4?=
 =?utf-8?B?LzdDa0I2VHdQOTNBRmtsY09XbDMxSzRJeWlxU1dXa1BraTZMcE1wY0gzazRW?=
 =?utf-8?B?bXR5Q21TVy9YaGkzMkxjWUFtTGUxMklwbVBCeW4wRzV3TnB4UnZwR0RrMFoy?=
 =?utf-8?B?a0Y1aURHM0JwL3pxenhTRFArMXJZUHdMYjFXRlpKa3haNjdmcEs3MEF5ZVhE?=
 =?utf-8?B?Zm1oWTI1aktsNXdab0tBMkViTU03U0R3V1pKZ2orY2wzajluWHBQMTV1RkQ1?=
 =?utf-8?B?clRUUlcwOFNaNjlXcldGK3R5RmYyUk1SZnFHMVFrM0pTc2FTWTYrSGJsSlhV?=
 =?utf-8?B?NlBTVHhHaEI1NjA2TCtXSHAwcnNVY1Jsb21qNDBnMUZ5Z2Y3ajhqUW1XTExI?=
 =?utf-8?B?QndkTnMzbmR1RUZxVjlkWitqTGZuaE9EMG9YVW91Q1RwWThaQnJtUVlONE9h?=
 =?utf-8?B?TW9MSjJ0RGtOMDhxNjJ2MThBamljTkltS055cC9ybEdZalBTOThBUSt2bFRE?=
 =?utf-8?B?Y0c3d0YwSndBMjgxaVBUYjRMczBtekNnOXVUdVM2UCsvajhiNHJMZFJJQ244?=
 =?utf-8?B?RklDZFVEZnpLeVNDdkdiSUc5K3JRRkg3RzhFemVWZjA0aHlwUFd4Vk1QcktU?=
 =?utf-8?B?dVNOYkFnR1RLNktFb1l6dkE3bUVzQy9nbURlaUl2UUR1VXdVTXNXdEhaRG1N?=
 =?utf-8?B?NGd5czBtQTlvN0g5TVZoalYwb25LSUs4U2lxcVZtd09neEhOaURaUi9OWDl4?=
 =?utf-8?B?K092S0pRd2VtTVV1N3RHSEwyeTUrbmgzWVhjZ0RLR3BhR3dQdnJVeU1SdDRE?=
 =?utf-8?Q?fFTmZEkPxOIz4y70gQAT/2zjZ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0626aa3-8ab6-45ca-a996-08db72789321
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:57:19.4426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzmofH6JwE7mXIpkEyIzYh9ci8DX3XNjZNNzsxzuE6F5/RJe/UtLmJBhx0cEVVbcFL2/2JYXaInBVF6PNjmjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9968
Received-SPF: pass client-ip=2a01:111:f400:7eaf::730;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 10:20, Alexander Ivanov wrote:
> Repair an image at opening if the image is unclean or out-of-image
> corruption was detected.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 65 +++++++++++++++++++++++++++--------------------
>   1 file changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index d507fe7d90..dc7eb6375e 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -944,7 +944,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       BDRVParallelsState *s = bs->opaque;
>       ParallelsHeader ph;
>       int ret, size, i;
> -    int64_t file_nb_sectors;
> +    int64_t file_nb_sectors, sector;
>       QemuOpts *opts = NULL;
>       Error *local_err = NULL;
>       char *buf;
> @@ -1026,33 +1026,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
> @@ -1113,10 +1088,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
> @@ -1124,6 +1129,12 @@ fail_format:
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

