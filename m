Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401D7A31B3
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 19:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhZKa-0004j8-2a; Sat, 16 Sep 2023 13:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhZKQ-0004hu-Uy; Sat, 16 Sep 2023 13:43:36 -0400
Received: from mail-db5eur01on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::712]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhZKO-0006vO-2U; Sat, 16 Sep 2023 13:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE/GubyPYOqU66P56HcgIQJYUd9dwcLoaBWIw6qsoqh87XMYdtXwlAhrFD7jcmWGwpuQdNYBzbd76RVO6iFpWU6lNI1ROjgbY8LPbucN0lMMHbIkKsx6PyxpOo4Cire0Y/vm+jbu3VDWunA5CKk7nMBYDUBAtqiKEvDReSG471T+DRe+oXGNeAfRUTasySkyB1I0LypKuMIWZEh3aMfmISB7pa8GWL0FtHsdBanS6ZYmHrs/CNdWoAUlN8zWyf6OXfUWrpZsGGHbgA60UHuvPJKgyeZ2VyASgrOicJzxCzmtWDSQ98oAIATGPFWmtUY/appXHi9DEr823dxafl5fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i5n+suwwoC2S4kjmvDzbPNOt7pbIXhd2VUc1KXVsDA=;
 b=nQhI8nYePRbN/3eYUDpTuNSMCNe2QlfNxLYy8JviWI7FZEpnomF8oBouv+1AXFrGdn9zZLNT4/shu8GLGb5WKtt8mi/hBgKQEVh2cJ0e07YeW2v6DpYev3MPm60JrxfhHaGO1z+P6e8HzVBlntmFz+/xJAlxCWftWemRiMy3rTmMjwU9BuW70D1H1RaoweQA9ysV/yKWnQDknQ8UbBAXE2PGBZyfO+M1v9gJCGH3yNvrefBHgrbpx4riebvuESDPb7lxFU5yxRdiJKhf5Bxm3uTL59BCQtp7HCR+zuKjTKyIWiwNsbbdRiD1Mvx1B3MuD+sC6zWmO/DOmBWGPuKKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i5n+suwwoC2S4kjmvDzbPNOt7pbIXhd2VUc1KXVsDA=;
 b=UvUodl+FpGChMJ0BYFYfV6YG6JWCqX3caFnfus9VqkvjKM5gfLJ/OwoqR3bbVLuZHcZOwRlKJsCyFUTY5/G8IAzQAVYNSBjeT36YJvMPzwrXBaJRjsevfk8e6rdFVAJBxHcHv9cTE7oJuRSxV0iJVr/W1ld2avU7zTvs556gVemsAaR82LLoduNPYrvmAZvPvEKvu/H659q5NWvcnPw18niq4k2qTnMv0oVrOopNgcjcKYph3qisELKpE2uEWWNtm0O2NOhlQio/Kw3oYXoLARBtFsya+WrdON72LxxclHm0Zi5BnL0wi1HPJTn+9aerLT4IWgY5tdRBVicwdKnizg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by DB9PR08MB9756.eurprd08.prod.outlook.com (2603:10a6:10:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Sat, 16 Sep
 2023 17:43:24 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6792.024; Sat, 16 Sep
 2023 17:43:24 +0000
Message-ID: <10638362-0c62-4264-a5fa-e1e8f00dcebc@virtuozzo.com>
Date: Sat, 16 Sep 2023 20:45:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] qemu-img: rebase: avoid unnecessary COW operations
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-6-andrey.drobyshev@virtuozzo.com>
 <sqlvvsdvth4t5igud2t6gzoia2fzqxsq3dx5eacckkjtfzlb4z@f74rjuaafvzo>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <sqlvvsdvth4t5igud2t6gzoia2fzqxsq3dx5eacckkjtfzlb4z@f74rjuaafvzo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|DB9PR08MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 575f9686-ff07-411f-62de-08dbb6dc6c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Yi4HMKr7wo1h6QY4ELP13tuBnBLEKOILQxh+kk+ot75hPtv7AeHSSDdNZruUdbXXhIZyKExgGWvQlGw22hbGnrbl4WQGGAtKAhN4hwfrkpjaqJLSt4DV6Z6bkPC61q/fmfhbuXPWwDdJ3VaWtjIqutTQWhDdLNkXICa1ZId+ObV7zouY26k2GbOaClXGRLCyPD0B1H+Jt+LcTSTkK/Cc7ysF9Gw9Vi7PW8vOv+lHzSC9txCfX4V3lKa8WEeRSDSDTYd8KK82z8E27k9ytaeGvyY5K6hhyWqK1yXptKif5EpaKRL8TNFHlqhRb19ns/E2/Y/6oI9oyuE0TnDWTqRNmEuOy9PipOcjCaouYAwZ9Q8kfjND3n5btA0svwsw7PM9DyIJOJ6+lnp/trMD0cpKvfeawgCtU4+dGBV6u1brqEPE+ch9i1oc4Ixr5dMWSNvSRCaDLeGNVjg+hShqOkOp1rUM/qrWv2fxEI2UzpEq/w84zS4Fv/9F8ALPdBuZgsGUOXv/mbzK7ypplnqG+9aoxV7sWC7/PIGGfJykoIANdUUqKTqTmn/3bMVYrrQRei4/j3ODiNfSx+zskZpB7BKuI1yE/fXuH31iEN0F/EhSyT6nobkaB4lyLr7ko9tcTlpxuwyHSA7FkybizrKlW8PsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39850400004)(1800799009)(186009)(451199024)(66946007)(53546011)(6486002)(66476007)(26005)(83380400001)(107886003)(316002)(2616005)(41300700001)(6916009)(478600001)(66556008)(44832011)(5660300002)(8936002)(30864003)(2906002)(6666004)(4326008)(6512007)(8676002)(6506007)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWVzWTBKTkNraUo4SFNSU0gzeEozN2t6bVJ5VFRDbFZSR2krSzFycHRUWmp4?=
 =?utf-8?B?dnJGVFVmRnUvcHJ3ZWtkUGpEN3llVzQvQ2lteWFoZW1Ga2ZsUk5EQmdvZDho?=
 =?utf-8?B?S2VjT3BEQWh0V0xZMUhGZHZrVWdJZmZ2Q0lKWkNMMlY3RDYyMzB6ZWxXYXNL?=
 =?utf-8?B?U09PWFRxN1R0L2lwMDhJVlc4djZVTFpFZEJBbzlxODFFVUgyWEhNYURlNmxZ?=
 =?utf-8?B?MnVVTnFPV1lwYVZEdGNjM3NnbmVoZmlFMGFBcTIyaklqbmNRUTVwbmxVU1Zs?=
 =?utf-8?B?U1g3UWVnd1FhVzhuOXBRNVdZZ1AyTmlhY0NkRFpOMUdNT25UT0pBQWRvS0NP?=
 =?utf-8?B?Mi9TalVadW4wUEZPK2diS05YaGtkSEJxUVYzelpreWU2RlZ5WkVIL2pyQmlI?=
 =?utf-8?B?d2crN2N4ZWQyOFFaalNMeUYrV3VZOGhLWGRIeHpPdlU4MGg5bERDbzlxUDFH?=
 =?utf-8?B?SUFOMlQ3Y0dXUHF6UkgxS3FuTFR2QS9oQkRXaHZjR2NOWXFFQVdMbGVSbEZE?=
 =?utf-8?B?cjU4U1ByNUkrZlJRTkxlK1ZvRzljRWFkRlFBdXVyeCtGSDBwZ3RFL1JsSTRw?=
 =?utf-8?B?S3Z4MFhHbVVUTmxERitnU3dBSms0eEdhM1NDM1dyQWEyMTVRdTVTbUJFaXQ2?=
 =?utf-8?B?SGxCaGQzcE5JNWNQOVpySmgzSFJiUUZ6dm5qVTU5a3FCcFJUWnlhZ1h6RnFh?=
 =?utf-8?B?OWpTa1FRcUwyV2dsY28zRitqY3ZyNzBrQTlYTW8xY0V2bTdxVnN1MVBlSnRL?=
 =?utf-8?B?ZFZyQ0ZWMDgvR0I1T2hFREtaaTRWWlJ3K0ZBd3hnVUlMUlkwWEIyMmVlb202?=
 =?utf-8?B?TkU0TTBlWU9Ba1FjZ3BOS1JCRm5qTXNEMmVJbGJuVG9VeHdZZmozd0twdWdh?=
 =?utf-8?B?aCt0akFpQlVsL3MxUHhBREFRQXFxcTNXcW8veC85eko3d0xFNTE2Vy9kQ3U1?=
 =?utf-8?B?UUVEMG9uYllaVnArZUN3QTBxTnVlTVJsVmt6Q0Z1blpPQ1dzdlJVZ29Rcnl3?=
 =?utf-8?B?N3B3N1lCVGRudVlQeVFmaXMyaStMT2tSMXlJY05yTDlMamc0UThsMmZYRCsx?=
 =?utf-8?B?ZzJ3SVQzbXJiQVhVNW82RDE1dE90OHJkekpXclcxREJaYmU1ZkVDS3NsZjJr?=
 =?utf-8?B?NG5HUzc0K1dLRmtlUk1yYnVXeWd4SmhzRC8vSWhMbWxZdXJMQmZXTmNaYUZK?=
 =?utf-8?B?L2JOa1IvcklyYnNFZGtCcVptSGsvNGxLMTJDU2NXTHROQmZBb2VzT1hNMSti?=
 =?utf-8?B?V21BM3NKUXQyNTE5dUd4c1NWQXhQeEc5aU9YM1J0L1pja2pEdmk2UGxhUTZP?=
 =?utf-8?B?c0E2Zys0d3MvTnQxbFo2ak1haFNVOGJWSGJ2dUIwQUpZS1MwLzFVK2JYakpl?=
 =?utf-8?B?dTZEL0dLckxHT3hIWm92M3BrbGVBYkRZUlJFY0kwekZzVUtJdlQvZjJZS3Ax?=
 =?utf-8?B?L3M1c0Fab0ZUQ2lhWFNYMUdGRC9NRFVsdzg1dmcxMTZnQW53RVp5SjdwM01x?=
 =?utf-8?B?ZlNzWjhjYmVsWHhHcXo2dlJiVU9sV3lMNXNGaDJpbVhFUjJTazJkQ3VxZ0d4?=
 =?utf-8?B?c3dHcjZzekJrUnpzV29mQnlacWswSUlLQmgvU1ZnVGgzdThCRXBERmlTWDB5?=
 =?utf-8?B?eU96MUViVWZjOWFvNVRGQ0ttQ1Y0Qm0vODIrVE92dE0yQlNGNEVlZWZSbjgv?=
 =?utf-8?B?clZOVEQ2OEdJMTNzWXkwaUlWeGdsK2FVaFdxVnFMbUVqVEZhcCsxK2hEUCt4?=
 =?utf-8?B?TUtVOE9uOXNjTXBFS0NLcEFiWlYrWnRMYVovN3dDeEN2UGp4R1czNnNRRUxv?=
 =?utf-8?B?SGs2UWdrckllakNETU1Va0lQcmZ1LzBBZ1Z0alpydXViOUxQTGp1VFZMWVp5?=
 =?utf-8?B?azRkVEVURDlwcXM1azhndGVVYzJtdGpVWDRrYVRpNThKd3o2ZkZ1TnFHOW5u?=
 =?utf-8?B?YkxPSlBJVExDV3MwRXJRWllLMkQzdHpGbzN2VXQxeEFVUlZJVWNCaEt4ZzVT?=
 =?utf-8?B?TXVRUXBoUlZMeTJSTkQ4YnNYWjhmL1JraEhnemUvNitkMEc1SXBralJwdDh4?=
 =?utf-8?B?dy8zT2NJYWp1My9wbTl5UDRoMVJoaTBGNWdVT053SmxuaitBd05UZThWNkdU?=
 =?utf-8?B?RHBPNmJ5Nmd6UEwvc0RjSXNZcWFBZG5MUWRTdDBZZmNXRW8zMUNoMHRxbWFP?=
 =?utf-8?Q?sv4ti4xZVB+mN0NTGqS6Nws=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575f9686-ff07-411f-62de-08dbb6dc6c8b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 17:43:23.5427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSFCHZzQxu5w+yNx5/eV+a25Hq4+ZPyQ57a+hpD2QgT6TiZ+J+h2og8T/umOobZ2wtRA8puMkcw02LGUGlIJuUhsXkJNAJ7ozDKEwo+iebA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9756
Received-SPF: pass client-ip=2a01:111:f400:fe02::712;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/16/23 00:52, Eric Blake wrote:
> On Fri, Sep 15, 2023 at 07:20:13PM +0300, Andrey Drobyshev wrote:
>> When rebasing an image from one backing file to another, we need to
>> compare data from old and new backings.  If the diff between that data
>> happens to be unaligned to the target cluster size, we might end up
>> doing partial writes, which would lead to copy-on-write and additional IO.
>>
>> Consider the following simple case (virtual_size == cluster_size == 64K):
>>
>> base <-- inc1 <-- inc2
>>
>> qemu-io -c "write -P 0xaa 0 32K" base.qcow2
>> qemu-io -c "write -P 0xcc 32K 32K" base.qcow2
>> qemu-io -c "write -P 0xbb 0 32K" inc1.qcow2
>> qemu-io -c "write -P 0xcc 32K 32K" inc1.qcow2
>> qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2
>>
>> While doing rebase, we'll write a half of the cluster to inc2, and block
>> layer will have to read the 2nd half of the same cluster from the base image
>> inc1 while doing this write operation, although the whole cluster is already
>> read earlier to perform data comparison.
>>
>> In order to avoid these unnecessary IO cycles, let's make sure every
>> write request is aligned to the overlay subcluster boundaries.  Using
>> subcluster size is universal as for the images which don't have them
>> this size equals to the cluster size, so in any case we end up aligning
>> to the smallest unit of allocation.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qemu-img.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 56 insertions(+), 20 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index fcd31d7b5b..83950af42b 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3523,6 +3523,7 @@ static int img_rebase(int argc, char **argv)
>>      uint8_t *buf_new = NULL;
>>      BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
>>      BlockDriverState *unfiltered_bs;
>> +    BlockDriverInfo bdi = {0};
>>      char *filename;
>>      const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>>      int c, flags, src_flags, ret;
>> @@ -3533,6 +3534,7 @@ static int img_rebase(int argc, char **argv)
>>      bool quiet = false;
>>      Error *local_err = NULL;
>>      bool image_opts = false;
>> +    int64_t write_align;
>>  
>>      /* Parse commandline parameters */
>>      fmt = NULL;
>> @@ -3656,6 +3658,20 @@ static int img_rebase(int argc, char **argv)
>>          }
>>      }
>>  
>> +    /*
>> +     * We need overlay subcluster size to make sure write requests are
>> +     * aligned.
>> +     */
>> +    ret = bdrv_get_info(unfiltered_bs, &bdi);
>> +    if (ret < 0) {
>> +        error_report("could not get block driver info");
>> +        goto out;
>> +    } else if (bdi.subcluster_size == 0) {
>> +        bdi.subcluster_size = 1;
>> +    }
>> +
>> +    write_align = bdi.subcluster_size;
>> +
>>      /* For safe rebasing we need to compare old and new backing file */
>>      if (!unsafe) {
>>          QDict *options = NULL;
>> @@ -3753,7 +3769,7 @@ static int img_rebase(int argc, char **argv)
>>          int64_t old_backing_size = 0;
>>          int64_t new_backing_size = 0;
>>          uint64_t offset;
>> -        int64_t n;
>> +        int64_t n, n_old = 0, n_new = 0;
>>          float local_progress = 0;
>>  
>>          if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
>> @@ -3799,7 +3815,8 @@ static int img_rebase(int argc, char **argv)
>>          }
>>  
>>          for (offset = 0; offset < size; offset += n) {
>> -            bool buf_old_is_zero = false;
>> +            bool old_backing_eof = false;
>> +            int64_t n_alloc;
>>  
>>              /* How many bytes can we handle with the next read? */
>>              n = MIN(IO_BUF_SIZE, size - offset);
>> @@ -3844,33 +3861,48 @@ static int img_rebase(int argc, char **argv)
>>                  }
>>              }
>>  
>> +            /*
>> +             * At this point we know that the region [offset; offset + n)
>> +             * is unallocated within the target image.  This region might be
>> +             * unaligned to the target image's (sub)cluster boundaries, as
>> +             * old backing may have smaller clusters (or have subclusters).
>> +             * We extend it to the aligned boundaries to avoid CoW on
>> +             * partial writes in blk_pwrite(),
>> +             */
>> +            n += offset - QEMU_ALIGN_DOWN(offset, write_align);
>> +            offset = QEMU_ALIGN_DOWN(offset, write_align);
> 
> If we are always aligning to write_align on each iteration of this
> loop, won't this round down always be a no-op?
> 

No, it's not always the case.  Bear in mind that when the call to
bdrv_is_allocated() operates on the target's granularity, the call to
bdrv_is_allocated_above() would make n aligned to the old backing's
granularity.  Consider the following case (it was brought by Hanna under
v1 and is now covered in tests by commit "iotests/{024, 271}: add
testcases for qemu-img rebase"):

qemu-img create -f qcow2 base.qcow2 1M
qemu-img create -f qcow2 -b base.qcow2 -F qcow2 mid.qcow2 1M
qemu-img create -f qcow2 -o cluster_size=1M -b mid.qcow2 -F qcow2
top.qcow2 1M

qemu-io -c 'write 64k 64k' mid.qcow2
qemu-img rebase -b base.qcow2 -F qcow2 top.qcow2


Base: |-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|    64K
Mid:  |-|*|-|-|-|-|-|-|-|-|-|-|-|-|-|-|    64K
Top:  |- - - - - - - - - - - - - - - -|    1M


Then we'll have (without rounding down):

offset == 0, n == 1M

1st iteration:
bdrv_is_allocated() == 0 --> n == 1M
bdrv_is_allocated_above() == 0 --> n == 64K

offset == 64K, n == 960K

2nd iteration:
bdrv_is_allocated() == 0 --> n == 960K
bdrv_is_allocated_above() == 1 --> n == 64K

And then we'll proceed writing 64K w/o rounding up or 960K w/ rounding up.

So the whole point of expanding the unaligned region to its natural
borders is to write (sub)cluster aligned chunks.  I agree that in this
particular case we don't win anything in terms of CoW since in either
case we'll end up writing exactly 1M.  However, respecting cluster
boundaries will matter when we'll do compressed writes.

If you want to make things more orderly, I can move the rounding down
part to the commit ("qemu-img: add compression option to rebase
subcommand").


>> +            n += QEMU_ALIGN_UP(offset + n, write_align) - (offset + n);
>> +            n = MIN(n, size - offset);
> 
> However, I can see how this round up can matter.
> 
>> +            assert(!bdrv_is_allocated(unfiltered_bs, offset, n, &n_alloc) &&
>> +                   n_alloc == n);
> 
> This assertion feels a bit heavyweight.  I see what you're trying to
> say: if we found a (partial) unallocated region in the destination,
> then since write_align is the minimum alignment of such allocation,
> our rounding up to alignment boundaries should not change the fact
> that we still have an unallocated region in the destination.  But we
> already checked the data from the original offset through the original
> n, and I argue that the original offset was unchanged; so really, all
> the more you'd need to assert (if the assertion is even necessary)
> could be something like
> 
> assert(new_offset == orig_offset);
> tail = new_n - orig_n;
> assert(!bdrv_is_allocated(unfiltered_bs, orig_offset+orig_n, tail, &n_alloc) && n_alloc == tail);
>

Since the original offset may in fact change as we've established above,
I still think that checking the whole expanded region for being
unallocated makes more sense, than checking just the tail.

>> +
>> +            /*
>> +             * Much like the with the target image, we'll try to read as much
>> +             * of the old and new backings as we can.
>> +             */
>> +            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
>> +            if (blk_new_backing) {
>> +                n_new = MIN(n, MAX(0, new_backing_size - (int64_t) offset));
>> +            }
>> +
>>              /*
>>               * Read old and new backing file and take into consideration that
>>               * backing files may be smaller than the COW image.
>>               */
>> -            if (offset >= old_backing_size) {
>> -                memset(buf_old, 0, n);
>> -                buf_old_is_zero = true;
>> +            memset(buf_old + n_old, 0, n - n_old);
>> +            if (!n_old) {
>> +                old_backing_eof = true;
>>              } else {
>> -                if (offset + n > old_backing_size) {
>> -                    n = old_backing_size - offset;
>> -                }
>> -
>> -                ret = blk_pread(blk_old_backing, offset, n, buf_old, 0);
>> +                ret = blk_pread(blk_old_backing, offset, n_old, buf_old, 0);
> 
> Here's a more fundamental question.  Why are we reading from the old
> backing file?  At this point in time, isn't unfiltered_bs (the target
> image) still chained to the old backing file?  Why not just do a
> blk_pread() from the destination?  It will cause the block layer to
> read through the backing layers on our behalf, but the block layer
> will then take care of any needed zeroing without us having to do a
> memset here.
> 
> Then, once we have the contents of the disk (as seen through the
> destination backed by the old image), we can compare to what the new
> image would read, to see if we still need to write into the
> destination or can just let the destination rely on backing from the
> new image.
> 

Hmm, that's actually a great question.  At first glance there're indeed
no obstacles to entirely get rid of blk_old_backing.  The only drawback
in your scheme above is that we wouldn't keep track of the old backing
size thus lacking the possibility of calling blk_pwrite_zeroes()
directly right after we've reached the end of the old backing.  But I
suppose we can still keep that size in mind while reading from the
target as you've described.

This optimization hasn't crossed my mind as I was mainly focused on the
alignments here, but I suppose we can try it in one of the upcoming
series (unless someone'll point to some other drawbacks of reading
directly from target).

>>                  if (ret < 0) {
>>                      error_report("error while reading from old backing file");
>>                      goto out;
>>                  }
>>              }
>>  
>> -            if (offset >= new_backing_size || !blk_new_backing) {
>> -                memset(buf_new, 0, n);
>> -            } else {
>> -                if (offset + n > new_backing_size) {
>> -                    n = new_backing_size - offset;
>> -                }
>> -
>> -                ret = blk_pread(blk_new_backing, offset, n, buf_new, 0);
>> +            memset(buf_new + n_new, 0, n - n_new);
>> +            if (blk_new_backing && n_new) {
>> +                ret = blk_pread(blk_new_backing, offset, n_new, buf_new, 0);
>>                  if (ret < 0) {
>>                      error_report("error while reading from new backing file");
>>                      goto out;
>> @@ -3884,11 +3916,12 @@ static int img_rebase(int argc, char **argv)
>>                  int64_t pnum;
>>  
>>                  if (compare_buffers(buf_old + written, buf_new + written,
>> -                                    n - written, 0, &pnum))
>> +                                    n - written, write_align, &pnum))
>>                  {
>> -                    if (buf_old_is_zero) {
>> +                    if (old_backing_eof) {
>>                          ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
> 
> Deciding whether to write zeroes (which can be more efficient) is
> possible for more than just when the old backing file has already
> reached EOF.
> 

Sure, as you can see I haven't changed the logic here, simply renamed
the flag to indicate the condition more accurately.  But if we end up
reading directly from the target as you've suggested, the only way I can
think of to know for sure whether we should write zeroes is iteratively
compare portions of the read buffer to a predefined zero buffer.  That's
because at this point we know for sure that the region is unallocated in
the target, and we can't query bdrv_block_status() to know that it's
reading as zeroes.

>>                      } else {
>> +                        assert(written + pnum <= IO_BUF_SIZE);
>>                          ret = blk_pwrite(blk, offset + written, pnum,
>>                                           buf_old + written, 0);
>>                      }
>> @@ -3900,6 +3933,9 @@ static int img_rebase(int argc, char **argv)
>>                  }
>>  
>>                  written += pnum;
>> +                if (offset + written >= old_backing_size) {
>> +                    old_backing_eof = true;
>> +                }
>>              }
>>              qemu_progress_print(local_progress, 100);
>>          }
>> -- 
>> 2.39.3
>>
> 
> The idea behind this patch makes sense, but the function is already so
> long and complicated and you are adding more complexity.  I'll
> continue reviewing the rest of the series, but I'll be interested in
> seeing if any other block maintainers has an opinion on this patch.
> 

Sure, with the optimization comes complexity.  Due to the fact that we
send fewer read requests and avoid redundant CoW during rebase, the
speed improves significantly.  E.g. that's the numbers I get rebasing
the topmost image in the backup chain of the VM I have at hand:

base.qcow2 <-- delta.qcow2

# qemu-img info delta.qcow2 | grep size
virtual size: 64 GiB (68719476736 bytes)
disk size: 1.6 GiB
cluster_size: 65536

# qemu-img check delta.qcow2
No errors were found on the image.
34266/1048576 = 3.27% allocated, 99.76% fragmented, 99.47% compressed
clusters
Image end offset: 1722548224

# qemu-img info base.qcow2 | grep size
virtual size: 64 GiB (68719476736 bytes)
disk size: 4.06 GiB
cluster_size: 65536

# qemu-img check base.qcow2
No errors were found on the image.
133839/1048576 = 12.76% allocated, 87.92% fragmented, 76.32% compressed
clusters
Image end offset: 4391895040

vanilla:

# time qemu-img rebase -f qcow2 -b '' delta.qcow2.vanilla

real    0m49.192s
user    0m27.253s
sys     0m11.894s

patched:

# time qemu-img rebase -f qcow2 -b '' delta.qcow2.patched

real    0m33.071s
user    0m15.475s
sys     0m8.446s

#

# diff <(qemu-img map --output=json delta.qcow2.patched) <(qemu-img map
--output=json delta.qcow2.vanilla) && echo $?
0

# du --block-size=1 delta.qcow2.patched delta.qcow2.vanilla
10409897984     delta.qcow2.patched
10409897984     delta.qcow2.vanilla

# qemu-img compare delta.qcow2.vanilla delta.qcow2.patched
Images are identical.

