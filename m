Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D47A44CA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9ff-0005xu-S5; Mon, 18 Sep 2023 04:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9fb-0005wy-OF; Mon, 18 Sep 2023 04:31:52 -0400
Received: from mail-he1eur04on0731.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::731]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9fU-00047w-Ok; Mon, 18 Sep 2023 04:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCOWxw6qvJAM3rzRxXhZj6/tZIL25s2yFukM5V5gebA/zF2Q5YZMGa86/uIOhrS0TLofbnG2fzTOciTslmVUyv42QS1Uj60yBqDU93EdI3FNUMZjSXhsGeK247WWbl8Gsbe2riHxn5tYQAFZatbtUID+WPvaR7HZ41op1ktJtAgfNVGwIfvJcHj0QaXAvwMwqOiecSpSETZ2TUnem+fjQAzQgYC7wXhR3TlElrq0Ddhzt4JuKzrIUxmg5+IJkB/uoEsFccenYP+2fapjsURYuDbU+CL7uZEaORKf7iLZ0TwjvyEDfHzoeaEovg1UdlBttisJsUlHfOJ17POEuMZ+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmXTNwLsD424IQAaEGGTa0qbW/or4POxg1ewBM8if0w=;
 b=GgZ/SVmSiPp9ipJrIbFxqgGlQz3T66va5iEeCMRqHgZZ3uZVGrv5GkRe459ySD55x1tk51/PzPCoqorm4h6bX90m7VuPjSGBf7LQEQA8k0kYk0IDHO1WLvPiNJuRXW+YR+RuELxwY13UYVg2s/ZDnDaSCg/7iaRolTc30f86NF7NLJzwKrQMmKosOk+KE6v+iIVH4k4PYdIYgoU5gx8LlmG2Fws7ySwG0zZYjQvyLdl6qaGe+nrHSc0AOt4dMCxmuWcp7KGkDvxCcGvfFUcY/NM/hcmI9RUbGvZ4LsTeqmGeJrRRj9sVQy5SnFldpAjO7mxuqtD1KX1j4N2m347bvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmXTNwLsD424IQAaEGGTa0qbW/or4POxg1ewBM8if0w=;
 b=ECAuUB72gOUI1HXtbCBsw+qBB6gXDQCyZswl/RymgqjTeY6fTpfSJ2z4W/vtUk6+tWJ3hSDI/7nsr4e1NQE1slLQDwTgPNDm2BQBDyM+LMH+qfQkRvPXkGwf46CpU6N+bO02I9TaPWrX7+jUNPyk5sBSJP+6JdBuY0TsVpN0L0s7Mb/0JCf+Q6sYDyUmP7x6cQB2cLWuHAqyGdP1RTGxfJ0bK7yrMNICZe3dk9TFnRj5Yi/esQzl0/UnB8jN6DKaYGIqDbutf32uKMwL2Lst4UPc/cUaoFjMTsue2aJLNXZWf8qidb5liQlLFaLOTPX1G5v4GDCZDhSHvAsCIg4KWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DB9PR08MB9826.eurprd08.prod.outlook.com (2603:10a6:10:45d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:31:39 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:31:39 +0000
Message-ID: <6ce4817b-39d3-bf66-ed74-d85dffca6f2b@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/21] parallels: refactor path when we need to re-check
 image in parallels_open
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-8-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-8-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:803:14::46) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DB9PR08MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: b601bec9-573b-44de-8507-08dbb821adb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Isqi5Zrgj2HtKjttB5cChUSdY6v/hIZGQpGEFblcCJruYOd/ajUR3aJf4Rd2SDShD5mHh9mfxLZa+aPOfsvftVvhnpqhCD3ZZmzqhY9XfzmkTtLnXgmk/R6ZrZejF+rzvcnucum3pvVl/j4JYbkbBQpyEZHRLGXe4wFi2RAPARj66qyUNw4KTUvUDVe72LBtCg4xXOTaUc3w4qLC1sksgY1SJ8RY5x8tsPYucJGyNyrCAxSNWTU2jYL2iQ+jYrmK9cRU/ug3ChET6jI1rixYQsrQz/gEwGvtP98PRaxBR5gcVbsBt5cd/syUBVA69lvd3tnu39yFAQXRGnMusGBmlbB7xBmvln99zBpasx1PJsI5ij/RAZwjZ5qDg6vCBtgTJyifRHOWVmXVByqjUZ+NVr4kAoI6c/Je29RwsrIMRR3RjEAa8Rn4h0BAKZxCmHfEpHwQUNBbwiiuXYEm/c5PKM2hFHRo5S0YbP4tRfgPi9oukiAWYn4wsYZUWQ5/47bZuZDjlNo+5Uq+nmo4HrZv0WcOpXIhQ48dmB4gfjh3nReoM7tWxa+YtacTMwo5cIeD3wz27TPiG3aiRF3vvofbdAkBJD6HYfvsnKBXbyw1VAvIzm2+w3XHp6W9y9NNgD4UPozejTMQo+KiTLXG98W2P/jT2ZocIGdBiuge6BpUWVeWgXxQCSgUr4JRU8eGP+KX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(31686004)(36756003)(38350700002)(86362001)(38100700002)(31696002)(6486002)(6506007)(53546011)(52116002)(478600001)(2906002)(5660300002)(66556008)(66946007)(66476007)(44832011)(8936002)(6666004)(8676002)(4326008)(6512007)(83380400001)(41300700001)(316002)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZHRGJpallWUTZCVE9valNtblpRN0l1czdxbzVUNEhBMHNzNW1SY2JURE00?=
 =?utf-8?B?MzdYNTJrL0YyamlvaDBCYzFZWnR3cG9DTnNTV2hWeGpGa3VrQThnSDc3dTlD?=
 =?utf-8?B?c3ZEd25weVY5Y1FiSWVuY3ZiZ1lpT0pHMjJZeDgzbVBaVUQwanpZeSsvdUpJ?=
 =?utf-8?B?Nm52WkxpdGZOVVl2OFlPZndXNkNFRHJ5RDhSWkwya1pDWHRCcXZGSkRwVWV3?=
 =?utf-8?B?a3BIUXNRekFnZTFSZ2hPblFxRUFZdFV5Q1N3dzRuaXY1azE4RWcxa21qRVQ1?=
 =?utf-8?B?d3dKNlBhUVJNSU5aWXcxaFZlRFQzSWVPWUt3MklCNlVudXMyQTgzRm9GSTBW?=
 =?utf-8?B?UUpPZ1djZ0QvbUd1UjVZWDdEZEV1LzZ5V0Z6S2xjQWFzaFBidi8zWDU0eGhM?=
 =?utf-8?B?OGdKZFFrQ05YSDErODdGSDNKMnNzSHREN2hrTzlubE1ZbU93aEw5T3FmalU5?=
 =?utf-8?B?ZlhNWURYT3h2Qk1xMEdBNlBheEZtUzBvOXQzVWNnRWkyYVhoMVU2cnorV25J?=
 =?utf-8?B?VUd5UFlZTHh4RWtuczU5cjVzR3lxY1FXNzF3ZmFnSjFma3dNZlE2UmQyWk16?=
 =?utf-8?B?UktKRkQ2Z2tYY3R4dHJqUW53MENFQkJLUzF0UHdyZC9leEhKdUJQc3p6dGxH?=
 =?utf-8?B?aGNSaUtYMzNvNytmU1pia1VPSVRQRTFWRWt2ZGQ5bS9WWitESlV3Z0R5V2hO?=
 =?utf-8?B?QzNSSzByaDh0Wm5YK1Ridnlxaks2NU1hdlc1Y3c3aUtTSmpPL0dKemtoYmEy?=
 =?utf-8?B?WU1YdFB0WlV2MlFicUFqS1ZJQXEzWTlIQ0t5MUt1LzlGWHM0cjFyMHJXMW5X?=
 =?utf-8?B?SjZ0QUlKNSs2T2s4aldWeUJ2Z2hQbzl0YjE4NnRFQmx4UGxzOU1oUTVFNUF2?=
 =?utf-8?B?WXQ2NlRDNTNIYTdEcGNPUlV1UE5ZWmtDdmczWXVySEJYbXFmQUpmcHg2VTBD?=
 =?utf-8?B?OEZRLy84ZEpVbW5SMkl2WTRuU2dOZGVTa3hNNjRXZDB3aUk4UzZML0wrR1dZ?=
 =?utf-8?B?eUNJWlFVQ1hzWXZrSGpMNEtIZEdRSGhKWGVROFVPTkFWN01KSE1VanNsWnRq?=
 =?utf-8?B?aG92U1NmdFVlRVA3WWQ1UnA3Wk1QeHkwWDBVdzB3cGNjNUhFZjF0ZW5zdVV6?=
 =?utf-8?B?Z25BUllyT1pRMnAyVE1yM1ZVZE5xbWowVFNEaWN0MHVmYm84N0I5bGhIcHhu?=
 =?utf-8?B?emUvZ0ZuMVVLb1I3Y2ZHekxSSEVmZm1rempXUFp3em5vT1BZNmZpeWRxMkdk?=
 =?utf-8?B?YWVFalZHR2lvMnNkQjdWekszM2V2cFB4amVCWklYbWd2bndYeVNZUE1rTWtN?=
 =?utf-8?B?czMraU84NURaTzU5Ums0T3hnWEpveXFBbEU5TnZuREJUNW9oeUk1WFhFeGU2?=
 =?utf-8?B?M214UHV5QVpIMWZHUUlPaTA5RDVhbk5Obi9PWElLakhKUjZwSVpsczJkNmxm?=
 =?utf-8?B?Z2ZMSHhQeG5CZlFDUllXQmdjWUk2VGQ5UTNrdjA4U3N5azViYkdlMTRoV0VS?=
 =?utf-8?B?Y1UwNHMwRnZRc1R1VW5qNkpPd3hsWmVob2U5UU0welJjVXA0QzRnR1ZFNmIw?=
 =?utf-8?B?NmpJVDM5Z3ZWaHlmQkFmS3lZSGdDbXZCNGdkdnpoVkFuakFVMFJaUEl2MFll?=
 =?utf-8?B?aWtZNWdiZ0dJaWl1b2lXUnA1M0ZMcDFRL2NLOHN0RXZXQmRDT2h1YUxVcWF0?=
 =?utf-8?B?MmNiY2tvMWpzNUhiZmtqTC84dGZvejk1aXBZVmxSQlN5emZjSlNJTnhZMFdj?=
 =?utf-8?B?VEdsRE1WWWR6M1V4cnZTMHhGa2UxanlRQnVLaE1STlVDZUx5WEhWdE9iWUFB?=
 =?utf-8?B?OXRBbEc3c1ZzWDBDV0JuUWpaMFpUREpabTBiUDd1emwzR3JlKzIyR0FKaU9U?=
 =?utf-8?B?enhYOGo5cm5idkFQRFpLVXNUV1JmWmZBaHNRTFlqTzRpRjUvdEppSWREaWdl?=
 =?utf-8?B?Wm9XLy81M0NTUWVDTFNSRFVZTlFKMTNDcHhObE01QzhLWjAzVmErNURPNitD?=
 =?utf-8?B?SXlpN0Ura2pHZGpnVmRVYVlPTHNndzJvZzFUMzg0VkRramYzMUhLQmlueWVL?=
 =?utf-8?B?aVZGdHFrQkZLVDhPM09EU1FaOUV5ZUVWNmhITUk1a05JRFFob2tvdVN5OEcw?=
 =?utf-8?B?cm83L1oxWmpGNUhMMnpTb3RaWndaelM1eVp2dFVYakNFdlJvTEtLS0RwS25E?=
 =?utf-8?Q?qm41nU0RbPdd7DOHNxFbYZA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b601bec9-573b-44de-8507-08dbb821adb4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:31:39.1744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BDuvMgt55zrteXshJh/U2uEivjEc3nUv2Tje+XwXxXEiFq5d2WrShALyAgD+iw19RP2Dn+ZovYtfPYex8G0fO5nEDWK8hu0fccE87q53pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9826
Received-SPF: pass client-ip=2a01:111:f400:fe0d::731;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> More conditions follows thus the check should be more scalable.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 8f223bfd89..aa29df9f77 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1065,7 +1065,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       int ret, size, i;
>       int64_t file_nb_sectors, sector;
>       uint32_t data_start;
> -    bool data_off_is_correct;
> +    bool need_check = false;
>   
>       ret = parallels_opts_prealloc(bs, options, errp);
>       if (ret < 0) {
> @@ -1133,11 +1133,12 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       s->bat_bitmap = (uint32_t *)(s->header + 1);
>   
>       if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
> -        s->header_unclean = true;
> +        need_check = s->header_unclean = true;
>       }
>   
> -    data_off_is_correct = parallels_test_data_off(s, file_nb_sectors,
> -                                                  &data_start);
> +    need_check = need_check ||
> +                 !parallels_test_data_off(s, file_nb_sectors, &data_start);
> +
>       s->data_start = data_start;
>       s->data_end = s->data_start;
>       if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
> @@ -1194,6 +1195,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>               s->data_end = sector + s->tracks;
>           }
>       }
> +    need_check = need_check || s->data_end > file_nb_sectors;
>   
>       /*
>        * We don't repair the image here if it's opened for checks. Also we don't
> @@ -1203,12 +1205,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           return 0;
>       }
>   
> -    /*
> -     * Repair the image if it's dirty or
> -     * out-of-image corruption was detected.
> -     */
> -    if (s->data_end > file_nb_sectors || s->header_unclean
> -        || !data_off_is_correct) {
> +    /* Repair the image if corruption was detected. */
> +    if (need_check) {
>           BdrvCheckResult res;
>           ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
>           if (ret < 0) {
> @@ -1217,7 +1215,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>               goto fail;
>           }
>       }
> -
>       return 0;
>   
>   fail_format:

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

