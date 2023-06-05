Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2E722764
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6A1o-0000y6-TE; Mon, 05 Jun 2023 09:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q6A1j-0000xp-3J; Mon, 05 Jun 2023 09:13:39 -0400
Received: from mail-vi1eur04on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72d]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q6A1f-0002Tx-8Z; Mon, 05 Jun 2023 09:13:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKM9n4js6G0dyyjsJkiFLDVse0K0iejUWtk69jRqC90tVbSVlKKT2ZMR9wpYrI0cx55qET5l25897MVwNsTekPNivTOp+aaUs8Kpu2I2Fxk8B8oeHl3pEleOMxvQgJkotg9/BvTWOBIrUhDJyhQUl8/HLeReN+lnt3X5ShjjRiYgSlvC447jTFEtArtAUdVJjGolvrWNaR6oKm9pDrwcaaxmaCH0kXwrLWKMrn/vqxdpvTWO9kX7alIUoXrA9eo2gyOAkgDFpfpr/3LlsoawrIVjD4F9jLvTsF/BMs0E1tEEsJUdIeOn3ZCLX2KwsNpduF30X/9rSZ9TeqZNtZwu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYTpSf1wx+a7rQUihvpkxA/FOilwsbNs1VKA7ROU+mA=;
 b=dsM4In4ayDTHFJs1ganwUbAkmrcT2gXkfx2zuDFHwBX3WTOags1NO5BPKnwgsPhuC1y5asuk3W+DtG5zqjVK0Pz1B8loLo9YJ2DfYMP/9gSWMBBij/SsB3AInraHrD462Edjrx8ty2+YY8V8RlsHBcfRnsvqlH/wlFyNi4sO1yb7ao1dOeQDNyA2d9Q6Fx6fT2/ONKXhmWUtNrXFCEz+3Scdf6G7dJiAMmsonPX/Q4kfmrB5447ajFlemenJi6RR/OZAdoIM7mFZlgfLvYQPnSMFhQnxeAxnWLrd8n0UesigMVMtIgjuzkH7+6Zg4vzbufSRhhobaAi6c3iSR78zuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYTpSf1wx+a7rQUihvpkxA/FOilwsbNs1VKA7ROU+mA=;
 b=gI19RgP27LG0YbqhMtZi2aLZtwl2Vcud2AT0NEnCzOPD9Z3I6KYqefvgT9PMywRg2/XglgzyO//kktzybg8jxpiU7MhPxIcL9qOtc8PzB1wIkOsqAUFhOdXXR2xDaQ2HTqHQsOfFBjDDl1OZcvHLyLKFnfY1tpQCTAI7yQOWX0bKe1lhG73xXE1ewvmKRmrpQdIp5cWXnuBDGf8vxSZ82VgcJwCs+8mM9WnhW5b5wunrg14klfXEddwitchCxzcG/WsGrrTmhcvuvH64wBV17mUxgYutBeDF29w/TLqbwylgTvo/AW9MC6NTp3EPqfbkog+KFPZmv3aTSK3J5tkR8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 13:13:29 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:13:29 +0000
Message-ID: <735a04b7-4bc5-d041-cbd8-c5a510e1cffc@virtuozzo.com>
Date: Mon, 5 Jun 2023 15:13:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/5] parallels: Split image leak handling to separate
 check and fix helpers
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-3-alexander.ivanov@virtuozzo.com>
 <db062a52-3ee2-2f9b-7ef6-8c7e28e4e217@redhat.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <db062a52-3ee2-2f9b-7ef6-8c7e28e4e217@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0229.eurprd07.prod.outlook.com
 (2603:10a6:802:58::32) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AM7PR08MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd562d0-5bb8-4c76-e155-08db65c6a7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWZPeIEP3nCxc3O2hPLka9n73DE8o+eOOG7xGjl/MQQvjQpA5AINw0awBz6ba26FxPXOrOnXruYy0T4CVvHzx3MStQSzdBgc+41pIwdV8tgi0JLM1OHHgvuxZaVobjuxnIOWTCLNBrWfGNF8Yoz+DwElpZhbYFyDkRClwdBHmXdp7Opfpp2I1VBocepdzdikvwE0WvLUMjMESz4LKoM4/43uvC9Qa/2dTReC8OyW7+0qUVhWQGjOlwMO3Q2VQ0OD3LobQdDf9VGNtAcSBh5OxBUkhWCbzJ4bhcwogEGfp/zUOKus0S2PzKyZEoauS4sGsRCIRtUQrNCzKra+AqMIOljR6z5WMQlYnLfBohfoRrZbApEDWaRf4OqcMOw7hnW1MGE/6moRVYm9K8HFbRWp+TktpzeqSvD/Cm8XQ6I/33qcDXPImjmu66i8j3uFeVojgg2iaOFqaTo/rFXaS4Zx7vCZ4r9A/v2uLjd882rdvTfJKeOlRzrgkl1S66bdZM5XDZizIWevXZctgeEn7rAbHKuItTZ6VwdBnYWx8q0hJv1mIYq3LjoTaMclO7l65yVH8JalOsmsK3uwJ6vqHBHfKEhWD0bWH7Tmqddy99eJ132MrQwJ4Kud649Q95k4vvwSEtTbrWRAeN/HvVcKgSusuA/rctDHSEMqUh/OUeYqDwxKtpUm9+1WLM+5grLwoG71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(451199021)(66476007)(66946007)(2906002)(478600001)(31686004)(316002)(4326008)(8936002)(8676002)(41300700001)(44832011)(66556008)(5660300002)(52116002)(6486002)(6512007)(53546011)(6506007)(26005)(38100700002)(2616005)(186003)(83380400001)(36756003)(38350700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFptVTBTd09pelNSVDZZb3pyRDJJQ2UxeEZycjN2bW9icnluVDVNU2Q5VzJZ?=
 =?utf-8?B?eVBvMmh5THdGNWhiMzhlMGhiM0YwL1VHSCs4Z2F0dnJDekNRNk9TL25CWE9i?=
 =?utf-8?B?SnRycHNrVDBtcnU1czczSEpyN2duek4yaTFSckl5TzdUM2krQko4SHo4WFNn?=
 =?utf-8?B?RHBGWEkwUmQzWU1mY3YxOUFFemVOcEw4NVJ3bi9hS1NtMGt6RGxWc0pjNWJh?=
 =?utf-8?B?UGMrS1hhNTR1cVdlaExyU3RNcThYTVpqNzFvNHIveDlkYzBCOUdnOTQveXhy?=
 =?utf-8?B?ZHVDMEhYd2xvM2EvbjhKZkdyNUJQcnNUZGIrelozR2JHTzN1T2w1MEJZWlhL?=
 =?utf-8?B?YWJscVZueCtVQkd5Rlk2ZmN4NzhDZlRuQmNGeWxRZ0NNeUtsbUNhVkwzWnBt?=
 =?utf-8?B?TUxBMmhEVjBOUnV5RDFmaEtleS9xMXd2N2I5aUVwQVExV21sVWR2QVF4ejNG?=
 =?utf-8?B?YWMwRG11UkdKUmVES2h4T3dWUlQyck1qb01xK0k2RHZKYy9xR3hLOExVb0Vq?=
 =?utf-8?B?N204ZVpQTDBUbnd1NGhPZWlpU0g3NkplRFpXT1VTcmhieVZqTHZSSkV1Q3Ix?=
 =?utf-8?B?b3JCb1VId3JmZFR6QVRTQUF2UUEzWEFOSWpkeWtDT0ozTEFDUkNWR2JoOHZ5?=
 =?utf-8?B?emhOSUxxTmtjVlNmL2plUlhPUE9NTkFjeDZPTG9TUmxCMGtxSDY0S3Vab3Bh?=
 =?utf-8?B?KytDaEZ3VmtiN0xXSS9tN3MyTjZNdVhrS25NanIwVmlFdnlzZzZoQVF4a2s2?=
 =?utf-8?B?OERpaWV0ZTU5OGtZQm5tWEthRjNFb0dNOEpYMzQzSDA1dkJzUHp2VC9SK3Fv?=
 =?utf-8?B?N0pPNGU2YXY4M0wzcytXcFFaaUZoTnViN2w0aHorZmd5azBtcEh1MEQzVWpm?=
 =?utf-8?B?TW1oQUlKOVl1N1ZWSG82SGg2RTZ6VUZVcjh1N0Q2eGRtcU1vdk5McmcyVUdW?=
 =?utf-8?B?aUN4ODZWWlBUUGFJQXNvRURGc08xTU1YNGdEOStFUUg4OWQ0NUNtVmJmblFB?=
 =?utf-8?B?MWdIT3F2ODhjeGdhRE1aWm8zdU1lRUJXdEpGR04rN1ZBM2JzMU5EbmVqZnA2?=
 =?utf-8?B?bDUrcytCS01OWHlXWVBhVG5OQkFndmJuT256dW9Ob0pnVksxd01rV2V4dTlW?=
 =?utf-8?B?cGJUVHlUeHVZNzBDZTBuZ01JdWt6RGlIdGQvdU9scllzME5Zdmk5Q1ZTbkl4?=
 =?utf-8?B?dFBKSDNkWVB2VEhuTzBzRFhLSU5kWnZCVmRoZy9YeWFmLzhVeE9rVmxhM1Np?=
 =?utf-8?B?Q0h6aVl1anZ4WjRKOEtUNTB6TmJJOWxGa0c1Z09UTWNiMU5SUkpJVEJxREFG?=
 =?utf-8?B?Szdkb2MyQk5GZXF1STc2cWJIUXdSV251ZmVCSkpMSEc1anluZlNMZ3ZUQW96?=
 =?utf-8?B?YlVrdko0UUltVnpMTVgrdDkzeVVSbWQ1L0RucnZvYnRNZ3lULytHaTRjWG1D?=
 =?utf-8?B?THVWQzFaSi9BSklZUko5MnNHdDZ1Z0svRHIvRlhrNW1iU01vVEppemdjaE5K?=
 =?utf-8?B?VUVBeTlJWUx6VFVBRm1TWld2TE15UmVhWktINkgwQWoyMTlmcHZJOUhYbFdD?=
 =?utf-8?B?dDNXUUVLdVUzU1B5eVgxMWxCUlVoZ08vY051aGRDUWZCeW1tVTYrL1NoZmMw?=
 =?utf-8?B?TkpjM0V4K01Lem5XM0pOQ25DWFFDakxndmpqd3NJemJoNkNuVmZKcE03MjNr?=
 =?utf-8?B?SE1jcy9hTks1MzN4UjRUczltZld0dnphRlJ5WHMzL2dqM25KRVVWMExBRSts?=
 =?utf-8?B?ZmJNNW9BQW50SHl5MGFndkp6Wkp3aVlKdzBxM2dMUm8vdDh2NU1LR2pVa3By?=
 =?utf-8?B?UkFuUFJHdEFFWmpmTmJOWFhLcWdJZXgzeFpBdFlNb3kzN3dzeWE3bTY3V2g5?=
 =?utf-8?B?dUltQW5TWDRvN0NoQXQwMjNGMy9Xd1V3bmpNbFFoU012ek94VVNzVzFTM0Fo?=
 =?utf-8?B?QkhITHloRmRWM3hIZ29OSVpub2Rmc3NtZzBLOTNDalMzMUZSSmFNdldPeW5v?=
 =?utf-8?B?d25zWVczNEkxTHNZUkRrRTNleW9JUFFqWFdsS1Exd0ZZSkJueHh6WDhkL01E?=
 =?utf-8?B?WUw3SnFkUTIxNjIydVFFU2Z5Tk84R2tWNEFyQW9Rd05XWGc4NFpWUVZoSWxL?=
 =?utf-8?B?ZXkyaVo5ejkvQ3RjMGhwL0V3QmZ1WkRKRytBalRvaE9MUmNzbURKZkNQdG9C?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd562d0-5bb8-4c76-e155-08db65c6a7b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:13:29.5483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7QYQ0sFr9CpcD1MAuq3F+DJ2gUnm803G0b8vHRbxwvaR50S9tnf+gB9s0KESxuBjW3wliMQxdAdPPHBMUo6FZI+RN1Ms5Q6wjDM34HJOQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/2/23 16:08, Hanna Czenczek wrote:
> On 29.05.23 17:15, Alexander Ivanov wrote:
>> We need to fix leak after deduplication in the next patch. Move leak
>> fixing to a separate helper parallels_fix_leak() and add
>> parallels_get_leak_size() helper wich used in parallels_fix_leak() and
>> parallels_check_leak().
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 86 +++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 61 insertions(+), 25 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 1ec98c722b..64850b9655 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -482,43 +482,79 @@ parallels_check_outside_image(BlockDriverState 
>> *bs, BdrvCheckResult *res,
>>       return 0;
>>   }
>>   +static int64_t parallels_get_leak_size(BlockDriverState *bs,
>> +                                       BdrvCheckResult *res)
>> +{
>> +    int64_t size;
>> +
>> +    size = bdrv_getlength(bs->file->bs);
>> +    if (size < 0) {
>> +        return size;
>> +    }
>> +
>> +    /*
>> +     * Before any usage of this function, image_end_offset has to be 
>> set to the
>> +     * the highest offset in the BAT, excluding out-of-image offsets.
>> +     */
>> +    assert(size >= res->image_end_offset);
>
> If `high_off == 0` in parallels_check_outside_image(), it will use 
> s->data_end to determine image_end_offset, which is originally read 
> from the image header.  I don’t see any place where we ensure that 
> `s->data_end <= bdrv_getlength(bs->file->bs)`, so can we be certain 
> the assertion holds even in that case?
Will add s->data_end > file_nb_sectors check to parallels_open(). Thank you.
>
>> +
>> +    return size - res->image_end_offset;
>> +}
>> +
>> +static int parallels_fix_leak(BlockDriverState *bs,
>> +                              BdrvCheckResult *res)
>> +{
>> +    Error *local_err = NULL;
>> +    int64_t size;
>> +    int ret;
>> +
>> +    size = parallels_get_leak_size(bs, res);
>> +    if (size <= 0) {
>> +        return size;
>> +    }
>> +
>> +    /*
>> +     * In order to really repair the image, we must shrink it.
>> +     * That means we have to pass exact=true.
>> +     */
>> +    ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
>> +                           PREALLOC_MODE_OFF, 0, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int coroutine_fn GRAPH_RDLOCK
>>   parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>>                        BdrvCheckMode fix)
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>> -    int64_t size;
>> +    int64_t count, leak_size;
>>       int ret;
>>   -    size = bdrv_getlength(bs->file->bs);
>> -    if (size < 0) {
>> +    leak_size = parallels_get_leak_size(bs, res);
>> +    if (leak_size < 0) {
>>           res->check_errors++;
>> -        return size;
>> +        return leak_size;
>> +    }
>> +    if (leak_size == 0) {
>> +        return 0;
>>       }
>>   -    if (size > res->image_end_offset) {
>> -        int64_t count;
>> -        count = DIV_ROUND_UP(size - res->image_end_offset, 
>> s->cluster_size);
>> -        fprintf(stderr, "%s space leaked at the end of the image %" 
>> PRId64 "\n",
>> -                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
>> -                size - res->image_end_offset);
>> -        res->leaks += count;
>> -        if (fix & BDRV_FIX_LEAKS) {
>> -            Error *local_err = NULL;
>> +    count = DIV_ROUND_UP(leak_size, s->cluster_size);
>> +    res->leaks += count;
>> +    fprintf(stderr, "%s space leaked at the end of the image %" 
>> PRId64 "\n",
>> +            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
>>   -            /*
>> -             * In order to really repair the image, we must shrink it.
>> -             * That means we have to pass exact=true.
>> -             */
>> -            ret = bdrv_co_truncate(bs->file, res->image_end_offset, 
>> true,
>> -                                   PREALLOC_MODE_OFF, 0, &local_err);
>> -            if (ret < 0) {
>> -                error_report_err(local_err);
>> -                res->check_errors++;
>> -                return ret;
>> -            }
>> -            res->leaks_fixed += count;
>> +    if (fix & BDRV_FIX_LEAKS) {
>> +        ret = parallels_fix_leak(bs, res);
>> +        if (ret < 0) {
>> +            return ret;
>
> We used to increment res->check_errors here – should we still do that?
>
> Hanna
>
>>           }
>> +        res->leaks_fixed += count;
>>       }
>>         return 0;
>

-- 
Best regards,
Alexander Ivanov


