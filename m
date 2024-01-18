Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5683831AA3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:32:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSUo-0004I1-GI; Thu, 18 Jan 2024 08:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSUi-0004Hl-Dt; Thu, 18 Jan 2024 08:31:44 -0500
Received: from mail-vi1eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::72e]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSUg-0001vN-FM; Thu, 18 Jan 2024 08:31:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilwfzimkyf+855x5eGynGEmBjZ+c9p6tdjhX1rGhvx3z90ge1uiV3vz50iqJl1boEzj1//j2NT9AsOp6qeREXPs6ZkeQuB2GQ3sNxy5b52fmuSBiFvG44QLBqhJoqiXBuBpCFIaCqXsnAd9Cq4GE7rWfNHaV8uzgP4u3IKuR21om7xR2qzrTxFHmio5YxngymMVaytr//DEQiFwBsYvY2OvL3whXqb4eHrnn2OMCOKZazJwWQQDJtOeUf1e7Mj2NOqKJNIc7n0Cy2JieGW3F7sFCIEdb/2vGKfsJmV6uM1rh0enTezHrG1vEUVGoP4NIn/QPV5R6sumRm2GyHD7Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+KBomhVkFjkpYacyopCDUL8apeChpQbqMUujTFlHfw=;
 b=ByBC3wPXyhwXesx8OZXqRSJ59+gEg3vSBOhSy8mEvcrYj34ST0DOIH0/iPCHQXm0cFHaX0PDv59P7qlrF1myLQ37BrWE3qnXk8I9MHH26lNpTfKnmYBCZfrblmookqh59QsqukL+aN0wg2Vl/4nRRjE2lYRLXLZCElEZuyjCJRg+kFdmwtsA6uPOFgeimC2BvdjvhiQp2H+uQEjwozlys1yYAaVYQ203P3BEHlx1rnTBdQsnXVpWEPiLWvrpjOs9N71X0R1mxo4Y2/RYYWOI9QozSV5QiU8IZwsTVQ9dqTBwgQwBHR6sEJkoz4Ri9i6PueUCSvqEIagx7bB0HyYrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+KBomhVkFjkpYacyopCDUL8apeChpQbqMUujTFlHfw=;
 b=nBbT0QBJqpHki+ljFipibApM+Buj4iwBQhvO8AvXu5yts0xBHkejqgNkDXCwm7lcaMo+NPUsESS+gGgz1I//WzD7CcwcVeYkAvKBeXY9PHF1YXp6IMaoyYMZe48HDeM7DZirQfDuxfi3UMYPgwNJYuv7wy7pyG6sKXFIDWabtmbOtF+67BiQpEOnRDQWkyS5woX5fvhIk8Dn9M185Mwv1fppOeYSX86BQXCST9i0GDxUubtHV+BVrxwrSf//cLLmt2oCRLTHMKulOgLzWdE5SivLBUBYzSWHlxbY7Z/WO45V60zVRRILGWFPQ6m9yqcC4kduQqHZ89IuN6fh3dWHFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB4PR08MB9238.eurprd08.prod.outlook.com (2603:10a6:10:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 13:31:38 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:31:38 +0000
Message-ID: <99fd7075-fd25-4ccd-806d-6d2c0f3e33f0@virtuozzo.com>
Date: Thu, 18 Jan 2024 14:31:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] parallels: Let image extensions work in RW mode
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
 <a9791fbd-e07a-4757-bb54-b4283bd7f4ad@virtuozzo.com>
In-Reply-To: <a9791fbd-e07a-4757-bb54-b4283bd7f4ad@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0169.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::26) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB4PR08MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a7f307-b490-4036-98d5-08dc1829cc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GaO6kZlzEL65qAGps59YdDNCUFGvxrFQ/CatFfPFdDP3EoKFh59qgG23v5Op242BtXSeztTldURL2ePtXTuOT1Jpf12AT//111tj+PvNo1FGv8mHMDWVateddUSXd8D0Cqx31ziPBIFDRUd345CsKS69MvEtE3tNzFmrSgf7p2SwmkQSrdpC/ycRktjqFBG6lpc0zZM4PYEKneqhUwyh1R1POV1Pj03Rnj+duQ7qx9PmKnbgTzz1ubN+f/HZBFacGxPpTjMDGrvWvR/+7qEhxwWjC87g2BDaOObnSHGwJQKsKzFyfoq5aZ+N05/1MY8h5375GDdVKMuDq/K8QBfNpWy2G3+/nQy1sErlbOzR6MV3L4nvSZCt6nXsRVFgMnIJ0CpLrNcTZG+Y2D86t/9LFQABYzS7JxIOPZFQ//coEBD80kGdbIOjaluX7g4lm77gSfBAMINM3fMNZ9zxp+qyTCRwH4ni88to5Y17tgijbXiiT477al9n2oc53UlmRnmLFJCIAfs4vX/YRFeDd7YaHcg72s7mUCk+GoH96AQUVAAV21Rw3qO6eyo49XofUjLTlNqu+ZjhHB+7OvYAXLukvd/ntDaWulOBo7RLLMVjl4B2eoVITRUTiP4/coRYzVLVrWN2IFOmLZ6OZO9ebdiqcKcw33Rg7/UEvUQbT9KHsvm784dHuG9ypYp9vjSLUa8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(376002)(396003)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(31686004)(83380400001)(8936002)(478600001)(4326008)(5660300002)(66556008)(316002)(6506007)(8676002)(66476007)(6486002)(53546011)(6512007)(66946007)(26005)(2616005)(2906002)(38100700002)(36756003)(41300700001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZqK1VZb0Q0UHpvOHpjNWRtVENXZm1iWExxa0tGdS8waThDbUZCZS9XcFBV?=
 =?utf-8?B?ZXB6YWFOZU45cXRFUi84ZCtHVGNDR3o2K1RCUENmNWdCbldNVWcvNzg0Y0k5?=
 =?utf-8?B?VWpnZzRKeVBtSms0VXlka0EzTWFsOVU1cytJQUMwRzVvRmdGOVlKSUxQaDBu?=
 =?utf-8?B?QTYweUpPRFV3anpHQWgzSTJmSUVIQjY1TFRNNTZjVHAzTHJHamFEQXpJbVdV?=
 =?utf-8?B?L3RSU2JjeUsrSU1ydTliV3NLbCtzUm9nTUxPUUpHREtRVXdpZkxmMFArNi92?=
 =?utf-8?B?QXcvVytxaXUrNU1iQit6OC91ckRMM0FSU3laU1ZNdEVKUTJLV0ZzSnZNbERY?=
 =?utf-8?B?VVRnZ3hWOGJLdWV6VzhwUHVCc21YK1hxWnFhakFvUmZGS0lhRUxJMDBUaHRj?=
 =?utf-8?B?RklXK1RzbW5SY2U1bzEwTEVrUThremxXV0xWMHNIYXo2QitDMWo5V2pMdVVn?=
 =?utf-8?B?NmllZ09HQmNFMEhLVEtmbXpYdzhiNHJDZmJoeGdHb01OdHZXWlpMTFJudi9B?=
 =?utf-8?B?RU92U212WFRMSVhwTHVxcVNETzdublFEUyszSG11NkFQSkJOZTNXN2VzYlNa?=
 =?utf-8?B?aWxOV2pDcVZPazN1dng0b2pNUmg1TGNOZlZkTE1BblUwcXRWRHQ0cmNMOUhX?=
 =?utf-8?B?YmUvK3F1V2pob2JGZnVUQUNEblB5NDNDQUFTZ2lkZ0VrVHA3SEN2cnJ1dFhn?=
 =?utf-8?B?SEk3aGJpN0F4YnZpcVJXRWh6WkF1NXl0ZnQvb29VV2wzUzN0NmxBWmNVcUQy?=
 =?utf-8?B?N2s2djV2Q1dHcXZlT1RveXBsSWd6TXloa3AyTFFEVTlzS3dKWWpzamFtcW9q?=
 =?utf-8?B?a0xaTnJSaUlqVExiRWlBT2Q2MkNpclExV0E0U2lXR3JVV1lwczhqZXVxMVpY?=
 =?utf-8?B?bmduTUtUc28wbnV2K0QxSTBPK1RIUlVDekR1WWNScWo5WTNPZE9aMGY4SHhn?=
 =?utf-8?B?ZmxjeDBBM1ZPVGpLeHYvZExpMkV3NCtQWG50ekxtK1F4WU9mdWREblFPc28z?=
 =?utf-8?B?RUVjaVVhcGh2NjVCaGQvNExEL2xBckhvQnA2K1o0Z0NWMk9NZjhDSWp4NUtU?=
 =?utf-8?B?WjR3SCtaL2ljU1c1K0VLdXJTL1N6Wng2aFpoekk5QnMwcm9GdGhUazh5Y0hF?=
 =?utf-8?B?ZmxmZHNtcUtXVHl5ZGZuc2dNVGM2VXNDckRTaUdoRUdDMTZsRzl0cDNIZ0Rk?=
 =?utf-8?B?U05xZGpSYjROUFdOb0FJUHIrZWNublFWdlpaS3h6K2RaeG93N0ZCT0VwMW5F?=
 =?utf-8?B?UjVnVnBKZnVmejFmVTFnRDFuOWcwK3pDUGVCNXBpL3NoWXJ4L3RMc3prQkFH?=
 =?utf-8?B?T3hqU3hOdXhkYWRrcndXSW9TRmdpbEgvZ3JSMVA2c0Q0aTNsQjNuT1dMa3B2?=
 =?utf-8?B?QUNjaGljMjZlUFFnamxMakhmU1Q4OTFYVkRyaGFOY1I3WnVQZHh4Wk90YmxJ?=
 =?utf-8?B?Wnp0clA3S3FhWUk3UWU4dDY0RVNkZ0gzaWh5bENyNXp6d2tQS3h1aGM2Z2Jl?=
 =?utf-8?B?bktuZ0hDb0pPTFJMckxyRHlibVVwVE1RN05hNzUwYy9Fck5MaHJTeGRvakxw?=
 =?utf-8?B?ZXNtbmhhNFVxRUJTc0VFNmFRNEJVL0Z6eFk3MnNEVGI1cFVRZThrWVpmUjZZ?=
 =?utf-8?B?RmtVaDY5akx4cjFJYS9CWUtGM1J4WEVGQm8vV3ZmQzEzZEhrOC9sTWMrSGlP?=
 =?utf-8?B?ZkQ2dUxaQ0gzdUJhaFBROUcrMU5jd1d1cDF4Nm1zTEhhWnA5Rm5PSW5YajJG?=
 =?utf-8?B?bzA2eTA0akJtSjBKbE0zSDZCbGhBRUkybnZ5bjk0dVdxUWxYMXM3QXZRNEQr?=
 =?utf-8?B?Ym5XVnNvd0dpNjk5cXgrZll5Mk56VEl1ZnR3bG5TZ3prYmUrTGlEM0VkL0sx?=
 =?utf-8?B?c3RKY1VudG5ZbGdITEtKb0ZaT3grbThTNHdVRzluSm1MUVU3dWxldEN6U1Yv?=
 =?utf-8?B?S3RkMHVsdnJqUkEvNmF2TGNsVjRIS3h4REdvRGlPN2JvUnRTRHdqdER0aXpq?=
 =?utf-8?B?a0ZIR2c1Q1JqYUJBdldEN1hnWHg4eGk3Zy9ERDMxVGxYY1lTaVV1QkhlRTB2?=
 =?utf-8?B?SjdvQ0JTdUxRZGo1Q3lrNFBDQnRtc2pQTjBIMU9BQ2hpSHk2U25GUEJBUlh2?=
 =?utf-8?Q?Tw6mEM97JY9X8pahEhsVGGolt?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7f307-b490-4036-98d5-08dc1829cc49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:31:38.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R8Xkp7k1IdMnPD5+LgXm+VKpPPiRzxJQ5rC8zSnOkL3Ud51/nscXc2WjCBFli+vXZaDyw0PQ0OMAiPdo/BORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9238
Received-SPF: pass client-ip=2a01:111:f400:fe16::72e;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 1/16/24 15:45, Denis V. Lunev wrote:
> On 12/28/23 11:12, Alexander Ivanov wrote:
>> Now we support extensions saving and can let to work with them in
>> read-write mode.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels-ext.c |  4 ----
>>   block/parallels.c     | 17 ++++-------------
>>   2 files changed, 4 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>> index c83d1ea393..195b01b109 100644
>> --- a/block/parallels-ext.c
>> +++ b/block/parallels-ext.c
>> @@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, 
>> uint8_t *data, size_t data_size,
>>           return NULL;
>>       }
>>   -    /* We support format extension only for RO parallels images. */
>> -    assert(!(bs->open_flags & BDRV_O_RDWR));
>> -    bdrv_dirty_bitmap_set_readonly(bitmap, true);
>> -
>>       return bitmap;
>>   }
>>   diff --git a/block/parallels.c b/block/parallels.c
>> index a49922c6a7..d5d87984cf 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState 
>> *bs, QDict *options, int flags,
>>       }
>>         if (ph.ext_off) {
>> -        if (flags & BDRV_O_RDWR) {
>> -            /*
>> -             * It's unsafe to open image RW if there is an extension 
>> (as we
>> -             * don't support it). But parallels driver in QEMU 
>> historically
>> -             * ignores the extension, so print warning and don't care.
>> -             */
>> -            warn_report("Format Extension ignored in RW mode");
>> -        } else {
>> -            ret = parallels_read_format_extension(
>> -                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, 
>> errp);
>> -            if (ret < 0) {
>> -                goto fail;
>> -            }
>> +        ret = parallels_read_format_extension(
>> +                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
>> +        if (ret < 0) {
>> +            goto fail;
>>           }
>>       }
> Reviewed-by: Denis V. Lunev <den@openvz.org>
This patch also deserves a note, what will happen with
format extensions clusters. According to the current
policy, we have only transient extensions, i.e.
CBT. Cluster allocation mechanism will reuse these
clusters as they are not marked as used.
Thus we should either set format extension offset
in the header to 0 or perform any other correct
measures to properly handle this.

It should also be noted, that on any QEMU crash
appropriate format extensions are to be properly
treated. We could not make them RW until this would
not be addressed as we could easily mess up with
trashed metadata.

