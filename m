Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D37A5E61
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXGA-0003sf-HW; Tue, 19 Sep 2023 05:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiXG6-0003s3-Q3; Tue, 19 Sep 2023 05:43:07 -0400
Received: from mail-vi1eur02on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::71d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiXG0-0006yn-BT; Tue, 19 Sep 2023 05:43:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpUtOpyiozb9boNybxkdjtInw+EdE6lSJ8xEw2Vwcelv701W4mb62nGPEdxRX+yGjorkldinSjJboE6cIshaQuwoS1HBQBWbWcd+QqdVnQb8XO3LNw7BYhqhYpayb6/fTy9LKE01d+F7tZCR3O8VU0ZxQoZ+xOCxFB9yG4BkojQS0AsyFkN9ujJ86zzzleK8mcBT5Cw8K03VUV0DUci8tIHcQZaXWnPmtBxWsMj3gza3hU4S+c8xs/rnRuxy6agfHYCaJNNvMMSENq2TSKLgcjbyCGKpxp7aRoEtjZnrbDx9ilmRtwgfJHA0QTjKulrM4BnG34kUKtQdFxA8QeuuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYGc+gq1n6DgICn2kI46Mx2AJE4qXqUDBh6yH2vViMg=;
 b=JaVQXcjb37HGbUefbUoNb4whWgAWtZi79mpb/lpxNLBfBm/4SctXFvgeMpEoUikjjionaDkE9pdWDJqQs50/bcrSc8HsJ+9IK5t4HiebXP9/cYHqhVfn9h2FM2h7uvXYTuhVKoA9sskCyuNWQlR1jiyXQhbKv4kyRq53BUfDLUahW9BqAcNoGqejXxT2I/NpFH1hOqKSoHEW2W5+Pz/qsRKkwgF9T9ShPEnmlULIl27Ysro0+GbrInktHhM74ZPpJO/7HjVA9AAQ93CzsFXtUPxF5ZBlZNV401tRn0A3xtpMxJjf0gz7kaiK5V3CXbmAM1Kuy9vPuS0XHkyf5H0WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYGc+gq1n6DgICn2kI46Mx2AJE4qXqUDBh6yH2vViMg=;
 b=ETtBNbJC4pmrwN+c6WHrwxq/hUTl7uRWqfjcZhlhjnRNlbys4OzrzoSh5be5XLCo6a+wid2ngMxL1GVT21RkqT9IilCOZED/wv6XyRC7kisajCXKlbUS4egiJerHBJA+jmoAiL7JDYuLNTGWAN6R/iI5dHFl0vio37pJDvGf5rTccbW2PVTrT7ht/4dmVePgOps8E7OM/Ayr6TYTdvfhQYgCj7me9R+12CJB+81r3W/Ro952kjU77Zh3bVmMViOylY2ALgPEhlUKbF2MjJ+47AeaueDsbWBjI5y4PrxcVn2VZ9kYaqNVLpQnL+MPEpSYXQkTgts9z9Nw4KoeWhZibA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB10209.eurprd08.prod.outlook.com (2603:10a6:102:365::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:42:54 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 09:42:54 +0000
Message-ID: <dc237ec1-7d13-7c71-875d-2bf9a4df96b6@virtuozzo.com>
Date: Tue, 19 Sep 2023 11:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 19/22] parallels: naive implementation of
 parallels_co_pdiscard
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230918180100.524843-1-den@openvz.org>
 <20230918180100.524843-21-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230918180100.524843-21-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0173.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::30) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa314fd-8025-4933-a910-08dbb8f4cc78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewjMNi1gJHAjFEOQry89THlRTI8EKpm3CVBcdZI9DMHFeJCK/bbmUMKfdo8ej0286shssu7R8olfToD15eXt2cBSGsGoKjifQgkPIV6pcfNvtpyUhN7jXSx9CVC9T+QbaM9yvaf4W5efDO2CDiJCJFDqA5h2AatRAhvfxz/5Xhb6e6ETt6tWgFUzZ7QC48/SIIbSAj3b0MI0HVct3bv8TcLsh4OidnWhE9IXHMJOYDCdHHxjtCtw4oo09RKQrPcfdBpGdm7EBH1idyfkZuBnBJa2aMYUiOrG9XU1T0lePsSbuB+0nGDFZAZmGFfNyDaOHRs+lM+LQX08mTBl4KlmEJ2Bjn9oUinfvRWYrC7qL8fGurNac9nnC2wEDnhepgx9jAz3CB3bkHvNz0l+2m0WnQA4MbvcHJs7LcTJUOpx8/z+UilEWkEmWj5WVmzShAJ7yBXi/FGLHgP8QDpdx3LF4298d/gfaBMNHOSh7unCsAU4EjP3fFZUGAttZxK/VuLq7jKuY9UBeUkNUpskXDVe4mMqoZDTv1LgvTe6qcnO5s2Vq/cCwr+rmsuZKhej/U8L8fbZ9JHT/jYJXAyUBWBiLBUPwtO5A828DzUsssw1r60GuoaiMwQt5k7+8FoFJrnRQextyINmdbJBi9JuqOuTvwG2uXhwTGendWhAZG1dz5HXzvjYR9qRoeeVLjzih95o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39850400004)(451199024)(1800799009)(186009)(31686004)(6506007)(6486002)(6666004)(53546011)(52116002)(38100700002)(38350700002)(36756003)(86362001)(31696002)(2616005)(26005)(2906002)(6512007)(83380400001)(478600001)(41300700001)(4326008)(5660300002)(8676002)(8936002)(44832011)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FCeWE2dUpoc0Q5UDAvL3ltTEtrTnZMTjdsVVg1UEl4d1RHSmovcXE0WXRC?=
 =?utf-8?B?bUFjVFJBSEdxUXQyVDF0dkQxaG05Ti9BRHMxbkFRSi9DRVFsdEcxSmpTK1JB?=
 =?utf-8?B?bDQ2YXFwYjBRNUxoRjlXQ3dJR0U2NmV6K2RVSCtOeThaY3pWTENUSkNGVG5y?=
 =?utf-8?B?czFySzV0dnkrOERDalY3Y2pSVW9BMlNpWUF0eGs0QzFaa1hWRlFsMmRiTmJl?=
 =?utf-8?B?RndscXhCOU5NYVhoVGphL0FaUlVaVGJIeStqSHQ3THZHSVgvV1R0dm1HblVJ?=
 =?utf-8?B?NWRJdUk4WlRtRko4aTBOVXZnV1hoMkpuVkVkUWxOMTVtc0taSkRUK2lDWVJK?=
 =?utf-8?B?OERLUnRuNHdTZGViTTBnVUZXcnM4Y3krVDgxdHRZK24zcXF0b2NBaVZYSDFW?=
 =?utf-8?B?VStlaWdXbE1WUC9oV3RpRG1oSkFpemNBYktiMEdHYWRMSjJPQzYvbWt1UzJp?=
 =?utf-8?B?cnBWb0FLR2J3a2QvbWF6U2hDNC9OSnlzSTRLNHRxUW5mYmZBS3orektRZ1gv?=
 =?utf-8?B?WUZNYVN5aEhPNFFXVHl2aEMwenVWUW1vSWlxc0lPV2dTLzJpT2E3dGJpazh2?=
 =?utf-8?B?VVJrRTlzbWhieEhodjkwakZNMjNBN0RlMkRwOVZZT016RUtSRVN4dDBZVTZv?=
 =?utf-8?B?MkNwTEovWEtGaHlFQWpWdjVPbmcwZEtocmc1R1pZc2kwSGtLdm5jZmkrZ2M0?=
 =?utf-8?B?MGhpcUwrem9CYmdTdm13RVk2SGlZR1l3UEIyK1NjODk2S1NrR3kvRTM2UGdK?=
 =?utf-8?B?SXNEaWJuTjljOTRXSDRJaTNsYmZOUXFqdDhOY1EyK250WWVjajJZWWtrNThp?=
 =?utf-8?B?S0VGYzJmKzdjNWoyZGRLU2JLT3hENzArd05xREk3ZXhiZHZmc1k0R09BQTBQ?=
 =?utf-8?B?Zk5aaS92Q2wzTDBHOEgrUVRwaEFPdjFXRThhWWF4TVYxMGZTZXRvdFRLWG5s?=
 =?utf-8?B?cDIxSFlnbzc4eEwwSHRiMERyK3pDdGNNQThnWHU2RVpzcmtUd2xDMTJXTmFm?=
 =?utf-8?B?S1NxNTFpcFRwOHM5Q2E5S3pscVdIcUJPWGlxb2F1bjRyYkk1K2lUc0lrQ3o0?=
 =?utf-8?B?U2tuVWxjdDA4N2xHTHRUWmo4VW1rU0l0MVg3NEErcEpKNm9PTHJVSzNweG1S?=
 =?utf-8?B?c3JNTU9Bd2t5OHZ6NEVqd0piMjR2cXlEUGNHVndXM1VKMGFScDNiaFJxdytI?=
 =?utf-8?B?NHBaU09UZjZxZ3BPbFYwMENPZnpIYzV2RlpsZ3F4ODkvOUxmM2crZVNDOThU?=
 =?utf-8?B?WkdCLzROa2tCbXhoSS9kQVJ6TGdZbS80Z01qV0VOSGoxOVczdmpadzYyL05X?=
 =?utf-8?B?K3h3bTB6TnZNQUFXWFdsUFNESmlUR1FLUFZCRXN5VXo1UWQ2QmlpNmF0M2FX?=
 =?utf-8?B?WHN3bU00VlRSdUV0ZlgvbSswMWI2TjRnWlJjZkp1RHV2Qml5a3EwcVpTaGZr?=
 =?utf-8?B?NFBCWmxqQ3gzRXM1WEpwSmpNQzF5U1RVUTJHRDhERlVBelFreU93VS90aUM2?=
 =?utf-8?B?SzNhYjhJZmkzaVg1RldGb2MyOENYc2JjRnNJKzdBVUNPSC9FSTU1RzQ1cUxu?=
 =?utf-8?B?U0VnRzRXcGVMSlA4MVA3VjlHYkQvZE9IYmVkUzVmYkduMXM3SWxCSFBEVDNl?=
 =?utf-8?B?NmN6dDBkbHJKZ1NmZndaZCszUVlsZzdmWHVHc3lpenNycGxDby8zYTJvdVUw?=
 =?utf-8?B?SXk1UG5MeVZaRXFlUGpXL1VVN3psczZBcWhKUWY2TUdxRXNlSDhvMzgzYWl3?=
 =?utf-8?B?K3RhR0R2OHVsMFNKVFdPdG41aXg0RmdWOFRuLzlyMWdLNzlkcUhvRVlzWVNB?=
 =?utf-8?B?RmwzNXdGeUhhSjByaUF1VjFFVWlSVFZsZEREVm1jT1JxZHRHN0dQNHkwNzBh?=
 =?utf-8?B?SVJKb3RQc0FaTWc3YnFvZGhmV3F2M0FRZmhLQ1g0a3dFV2pjcUtrK0ZhMExW?=
 =?utf-8?B?bGs4Mm9KRTJkUGZLSVpoNjg0aUJtTnR2VU9EL2J5RW1ndjlOcFJ1ZmFKY1Jk?=
 =?utf-8?B?aEtVdWwxZnZicWtEbHpZOWhpU2tUNENGblZ4ZTFrK0NKQ2JSNzRBczBmbWR6?=
 =?utf-8?B?UUlxMUdVcXViNXZzSVB5TUkrRW4vNWVoYUo5RnAreDdzcmVWODZXbDBkNHln?=
 =?utf-8?B?cWN3ZFNoWlg1WmFNSGx2UDNWU291RWV0SXFpS1JGN0Vwek42bGpWNEQ3Y0tu?=
 =?utf-8?Q?xZ4/JdHwIkFK61oJegYxNMY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa314fd-8025-4933-a910-08dbb8f4cc78
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:42:54.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aAQdeKtCtFFracGJOs7g68MzAk6y3S66gAMATLsLZiVWYe9DaqkvBopXzxSBMIHWjhEW0lhfwrlswGqsB8WY/LNSv1QksjDvAjyqz0BJtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10209
Received-SPF: pass client-ip=2a01:111:f400:fe16::71d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/18/23 20:00, Denis V. Lunev wrote:
> * Discarding with backing stores is not supported by the format.
> * There is no buffering/queueing of the discard operation.
> * Only operations aligned to the cluster are supported.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index d9d36c514b..1ef23f6669 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -537,6 +537,51 @@ parallels_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
>       return ret;
>   }
>   
> +
> +static int coroutine_fn
> +parallels_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
> +{
> +    int ret = 0;
> +    uint32_t cluster, count;
> +    BDRVParallelsState *s = bs->opaque;
> +
> +    /*
> +     * The image does not support ZERO mark inside the BAT, which means that
> +     * stale data could be exposed from the backing file.
> +     */
> +    if (bs->backing) {
> +        return -ENOTSUP;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(offset, s->cluster_size)) {
> +        return -ENOTSUP;
> +    } else if (!QEMU_IS_ALIGNED(bytes, s->cluster_size)) {
> +        return -ENOTSUP;
> +    }
> +
> +    cluster = offset / s->cluster_size;
> +    count = bytes / s->cluster_size;
> +
> +    qemu_co_mutex_lock(&s->lock);
> +    for (; count > 0; cluster++, count--) {
> +        int64_t host_off = bat2sect(s, cluster) << BDRV_SECTOR_BITS;
> +        if (host_off == 0) {
> +            continue;
> +        }
> +
> +        ret = bdrv_co_pdiscard(bs->file, host_off, s->cluster_size);
> +        if (ret < 0) {
> +            goto done;
> +        }
> +
> +        parallels_set_bat_entry(s, cluster, 0);
> +        bitmap_clear(s->used_bmap, host_cluster_index(s, host_off), 1);
> +    }
> +done:
> +    qemu_co_mutex_unlock(&s->lock);
> +    return ret;
> +}
> +
>   static void parallels_check_unclean(BlockDriverState *bs,
>                                       BdrvCheckResult *res,
>                                       BdrvCheckMode fix)
> @@ -1417,6 +1462,7 @@ static BlockDriver bdrv_parallels = {
>       .bdrv_co_create             = parallels_co_create,
>       .bdrv_co_create_opts        = parallels_co_create_opts,
>       .bdrv_co_check              = parallels_co_check,
> +    .bdrv_co_pdiscard           = parallels_co_pdiscard,
>   };
>   
>   static void bdrv_parallels_init(void)

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


