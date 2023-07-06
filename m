Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5C749D22
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOk8-0006BH-Ih; Thu, 06 Jul 2023 09:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHOk2-0006AV-Lr; Thu, 06 Jul 2023 09:09:50 -0400
Received: from mail-he1eur01on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::728]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHOjz-0007GW-Be; Thu, 06 Jul 2023 09:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5FzrsUxK/1ZVBNlPgIGJT6nfFbx4NWDqhoDgxybP/5fldbVFlq9FPef0RCIGe3N//tV3gHlZO6uKLp/uhJXsaA3AwEOno/5f1l6H6dRurFZYG3gKBhdPN1coIlqN4pIPF7feWdZ7jLSLCvUZ7j/h4k9369rnJcE78PmCN5LfhKVT14qaPipqR2WFdHL5PJgNKoJpP8Ru4hMnvQmRr2/7ECB07pBE1DPR1LtEjJVE+FUV7poc/HY5soFEw8J+B5tsoVx4jCz3kyqd+JT/Am4iaTzYmRWzPmX0gq+qy73vQnQTaG8/9FSBvGUxdgyZa9yu8DGSyhJwvw0OpT0pt+o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqFkC0Q4w9LtHVwntaAVmRxWPm87VBcXnO+qtuA5OQY=;
 b=TGulzuidF7LT6ZlmdOA55V4do7k/x1JOT+tBNHmyQ45lXxRuGcJ2frnbk8PJvr1F7JselaKWkF8viAYiuxl9hPFpgwCVx55N43uS9FREbE20D1kgh63FDi2hYUvizAYlMK58MiT8uj1g51pCFmZgOd9ftlmmiz77uDmUGWyTicpEPG+xx0MVpC5utMTauC0IX1Ab9eL9TaGdzzJp6oZdCZ4WTGU2zcYp610Shk86NGIfb+i95wULIUgJ/ouTTTT+ewaEttyeYUzCTPXig+MObWb/BIoSLiwfIqj5Tug473dcI0Kt0WkcGF/Iy4NRlA+NLvIrTO2cht2bpR1Zp3Fbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqFkC0Q4w9LtHVwntaAVmRxWPm87VBcXnO+qtuA5OQY=;
 b=GQavHc+1wc/siOu0jixmMWc6TZBnQgHInb33A/nX0ueu+lyOU1RDA0L6zuIwwwKnRDyqfzERYSl3Fpx/dHdr3OxiTHYJH2X6k7ca77bJNxiKWehN2ZFIn2VJKeLdWAy6p0+/pR2SImTvOxnjAu9J9c1ev7qQX+1+2fLtmASgy9F1Xn3rZ1H22td7AIX7biygqaUaqdUmrEZAuWV/449J7bVGFMHF7C9SyfxPMdQ31Vr+SGGz4VGlZLlc2diq/pHTYHsEMQ1cJtZk07MXI/3/uJHmYaGjUyAtg/N1EO+KHexyCu6OPVKn6kjvnPxaKLlc2sL5nxW/RVftr/VSokU9sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DB8PR08MB5403.eurprd08.prod.outlook.com (2603:10a6:10:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:09:38 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:09:38 +0000
Message-ID: <e05d3f08-2d08-ec64-e8ca-882aa6a6378a@virtuozzo.com>
Date: Thu, 6 Jul 2023 16:10:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
 <20230607152627.468786-3-andrey.drobyshev@virtuozzo.com>
 <0398442b-50aa-fe28-0379-3b57ef749564@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <0398442b-50aa-fe28-0379-3b57ef749564@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0178.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::22) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DB8PR08MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c680244-8d81-4fd5-4dd8-08db7e2240cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHhjXM4Ac9pY+ZJo7aPaVeLgt9jAVerLjw+IEhAApb0Lt1q9RiRfTPdUeFJHWrOEnV5IqhflafZ9+649ybShNbTB7TYI0hLEb5qfm3pC75zz4uplKqs5qcbmsrqCDH37ctWGXl+TYvLJOlIfz1woolZad0Ae9HjvRAUNwAh0NwkE+HjC81vVjN4K7bT1iTOBT0Iioj3oT/3/ENJIb3Hl278F4s0EIV/9Xd1bMzZyFObC/RnK0/vpKxn4F8CILrWjPBNh0mMayEfZHpOj2iWOLNCrunzDLRejOiGnQqcEHh3SlRlk2KDZcPWYr0fxb9zloqqckyg4zCIgOvDJIZrr7QNxK4uBf6Rn1EdyO4CAcj0V+Bnu973HglsvSLEA8kAauu9O0j+AJuqanJ3wSsgrxT63O1f4W7czOEOBKkKCaQ2ZK0dn8hqTrkH75I+uSk/hsOnYqsB4I3FpCdAoXpJXhUFfmdLhxO8HRvPxgDtdeGuDzjGKPSiMV13+OP4qBMF/vwLS4VZssmAG1R3wr6sZcDS6+w7jls5myNB1EMwYqOrylStcCsL19XZWRfsngQdEiMBNgb3l9cwKa0nNgz3msfi81oiPeW7kDNBPNCJ2wUtwERZPwKvIYJqNvtF07sU60hhdsAll0aXYgSPXe2xemg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(366004)(136003)(376002)(346002)(396003)(451199021)(41300700001)(66556008)(478600001)(6512007)(86362001)(31696002)(38100700002)(6486002)(66946007)(316002)(4326008)(66476007)(83380400001)(6666004)(36756003)(8936002)(2906002)(2616005)(5660300002)(8676002)(44832011)(186003)(31686004)(6506007)(26005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V09IOVgyc0NFM2dWclBJUmlHSnhFbVFIWVRwbUVIRnMyREM4M1Q2WnBuMGdT?=
 =?utf-8?B?TFYyZ21RSEZyRUZqSWZ6OGpZZEFnOTNPamg4cDlHRTBDM0dKMG5MSTN6b2s0?=
 =?utf-8?B?YWE0Z3VGMmJwVmYxbDZPdVIwMGlzOFF0VkhGZGV4L2dGQTVhZmRTZHRrYy9T?=
 =?utf-8?B?RTZLUE9rT0t2NkZRNEt5SGVieFM5dXYrWTY2Q0tRUEN4M0tDTlkwKzJxbDJF?=
 =?utf-8?B?WU5ub3o1alZpUVh3eWlwcmlIMEl1Z1UyWnpNZWhlYlB0RFJ3d2RpRFVGTmRx?=
 =?utf-8?B?KzdBSXZ1NmV1QmorNDh2MC9yaDBYeVRFUXdEQjJkOEZHL1YxOTA3MG93aVEw?=
 =?utf-8?B?YnpOT2pWaUNhSWtSTWtMbXhKQWY2UFlXd0JrU3FZQ2psenNtRzFVS20ySjF2?=
 =?utf-8?B?NW12bjFNUVlvbVNhNFJHaG5XSjVwTDd1TFV4b3l0eHFDb05TcG1ld0ZNVGZX?=
 =?utf-8?B?S2NnZmdYTWY5bGhSRWVkVVJBTEw0eEV2ZEdYYjVCdVA4cGxaaG14eERqa2xE?=
 =?utf-8?B?dTE4TDFBREpySTI1M3VpdjRVaDBOZm1VeUdVU1I3RGhaaFBxNWtuWWV6c2ZG?=
 =?utf-8?B?QzJERjhUYmMwY2pTaWRFbmhSaC91bzl6UTVOem1rcGZpbDg2cDlRQUxNQklO?=
 =?utf-8?B?Z3FIVmVQMTVOYU9SU3JnaTJQa2hSdHlsTnFrSS8rSGd4MXpPelF5VVN1bWls?=
 =?utf-8?B?d2VBOEZDdkZkSXRlTDZXZE45VjA2ZmQvWWNyT2hJRzhhYjJyN3BQZloyTE0z?=
 =?utf-8?B?akMzbjlhVWh6NERJYm9xV3BhQ0dTQmZqR0JFVnEraTNMWEVJSEtqTWQ2dFFF?=
 =?utf-8?B?VURLcEMzVGtFSTRpNHBzTitxMFVoNXl2bjFkdnl4QldTRUxVaUNJVjkrRDVJ?=
 =?utf-8?B?a3o1L0hmdVptcnlXck1iQXE4STQ5dldZUXFLM0YzalpwTXpDWDMrLzJuSUp1?=
 =?utf-8?B?am1Bblo0NG0zMWRmNTJHQkYrV2NMSHlKOUd4Q0Y1dFRQUTQ0dHVGVFdYN1Zh?=
 =?utf-8?B?L09IQXU1Y0k4S3NaTzVHendvaWpCdGdteTFhN0NLeEIvUCtoeGhlamllby9C?=
 =?utf-8?B?RHdYZXIyMEFRa29oYW9WdVNxS2JFSGRsaDdoUFFSOXFIMFNldkpzNlViYUc1?=
 =?utf-8?B?Mnd2c203c09nK0ZTeW5QbXBkZ1U3TVFVNTlIR1M0bDVCUVNmaUx4WXNRdHhS?=
 =?utf-8?B?aGhmVjRsT1RKenVHeEZZQnBZdEE5c0hrM1ZMZHMvVjViMzhBanpLTFFjSG5k?=
 =?utf-8?B?TGs5ZkxiS0JYQVFyT3Z0Tm9qNDBWVlc2ZTBhSXlnU1NMbGhSQTFsbHRuK080?=
 =?utf-8?B?TDN6eWg0YzRFVjArZHkxRExFelIyL0M3RDFlL3NmYVVEQVhFZm9BbXpFNW9F?=
 =?utf-8?B?LzQvbVJLY3NjMVFLaDd3YnNselc3WWhZWWNOZEt3bkxqVldyZkQ5Z05jcEtn?=
 =?utf-8?B?R2VOb1pPN0dTMGNUS1g3S3JsNlh1U3BnVnJYQXNPdlI4WlJ4SlZOVk9lSklZ?=
 =?utf-8?B?Z2xsNUF6bTVUK0xXY1dLdEVuUk1YNzBCdWFBaDE5MmhkTWRrd2pLRWR5TWFW?=
 =?utf-8?B?WXkzVGQybTBKL3hsaHZEeWc5WWRzNHg1TDZhSUFrVTQvOGRrS3BpbmMvbi9v?=
 =?utf-8?B?T0ZxdGhFbjFjcGNSNUxaTTNpVFZ0V1Rza2tFWnliaUJhNCtPZ1I0Z2ZKWW5L?=
 =?utf-8?B?b21scmd1Ylhlc1MzbFV1V1piODVaZTdEd1BYWXNJZmgza2JpTS9udlN0di9i?=
 =?utf-8?B?cXFid094QTlWVkczbldJOEVVWDFoTXNrdmw4MTZ1RzVxc01sZ2ZtTmxjZmgy?=
 =?utf-8?B?VHZ5NTgvOWFNZ2ZidmJ2enRQejlxNXhUVlh6M0hJM0NaQXhMUHB1UGs2OXpS?=
 =?utf-8?B?YThwRGwrVFRxY2hXbGF3MEpKM1ZZUW9VTnFrMmsvNVVmNHlyRnErOGd0SjJO?=
 =?utf-8?B?YlpidmdHZ0NFbE9DaVdwaUZZSnRySVJEclAwTVdjanJZMVZFazZyMytPZHF6?=
 =?utf-8?B?a09zdHhDZFAwWlNCUG5HbW1FV09GdEhUSGRuZG1NdWFXNjlqbFArbmY5RWYw?=
 =?utf-8?B?THNQWGZ4N2xvQ1VGUWhWYmtUZnlOUVRLRHZYMmUwRkRQYytvKzV4dHprODNL?=
 =?utf-8?B?ZHY3L21OaWJEd2tkc2FURE5PdzVENkJrYXQ0cFMwY1kxejF3OVIwYzR1WnAv?=
 =?utf-8?Q?FRYUnB2fbd6nhyY9wOk3AFQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c680244-8d81-4fd5-4dd8-08db7e2240cc
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:09:38.5982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8YNGNQIIoX6Cx7oNGV37rfCtNbhd5tRg9f7n+qcG+sv+/rXq79ZkWb+5gWrF0I/Col8KDyOHirmVmS36d89QTi0q7v1ArXe2P6iDM8ZOG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5403
Received-SPF: pass client-ip=2a01:111:f400:fe1e::728;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/21/23 21:12, Denis V. Lunev wrote:
> On 6/7/23 17:26, Andrey Drobyshev wrote:
>> Right now "qemu-img map" reports compressed blocks as containing data
>> but having no host offset.  This is not very informative.  Instead,
>> let's add another boolean field named "compressed" in case JSON output
>> mode is specified.  This is achieved by utilizing new allocation status
>> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   qapi/block-core.json |  7 +++++--
>>   qemu-img.c           | 16 +++++++++++++---
>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 5dd5f7e4b0..bc6653e5d6 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -409,6 +409,9 @@
>>   #
>>   # @zero: whether the virtual blocks read as zeroes
>>   #
>> +# @compressed: true indicates that data is stored compressed (the target
>> +#     format must support compression)
>> +#
>>   # @depth: number of layers (0 = top image, 1 = top image's backing
>>   #     file, ..., n - 1 = bottom image (where n is the number of images
>>   #     in the chain)) before reaching one for which the range is
>> @@ -426,8 +429,8 @@
>>   ##
>>   { 'struct': 'MapEntry',
>>     'data': {'start': 'int', 'length': 'int', 'data': 'bool',
>> -           'zero': 'bool', 'depth': 'int', 'present': 'bool',
>> -           '*offset': 'int', '*filename': 'str' } }
>> +           'zero': 'bool', 'compressed': 'bool', 'depth': 'int',
>> +           'present': 'bool', '*offset': 'int', '*filename': 'str' } }
> after some thoughts I would say that for compatibility reasons it
> would be beneficial to have compressed field optional.
>>     ##
>>   # @BlockdevCacheInfo:
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 27f48051b0..9bb69f58f6 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3083,7 +3083,7 @@ static int img_info(int argc, char **argv)
>>   }
>>     static int dump_map_entry(OutputFormat output_format, MapEntry *e,
>> -                          MapEntry *next)
>> +                          MapEntry *next, bool can_compress)
>>   {
>>       switch (output_format) {
>>       case OFORMAT_HUMAN:
>> @@ -3112,6 +3112,9 @@ static int dump_map_entry(OutputFormat
>> output_format, MapEntry *e,
>>                  e->present ? "true" : "false",
>>                  e->zero ? "true" : "false",
>>                  e->data ? "true" : "false");
>> +        if (can_compress) {
>> +            printf(", \"compressed\": %s", e->compressed ? "true" :
>> "false");
> If compressed field is optional, then it would be reasonable to skip
> filling this field for non-compressed clusters. In that case we
> will not need 'can_compress' parameter of the call.
> 
> Ha! More importantly. The field (according to the metadata) is
> mandatory while it is reported conditionally, i.e. the field is
> optional in reality. There is a problem in a this or that way.
> 

Yes, I agree that making this field optional makes sense since we do not
include it for formats which don't support compression.

However, I don't think we should entirely omit it for uncompressed
clusters.  If we keep it present that would be more consistent with the
current logic, as with '"zero": false' field which is always included.

>> +        }
>>           if (e->has_offset) {
>>               printf(", \"offset\": %"PRId64"", e->offset);
>>           }
>> @@ -3172,6 +3175,7 @@ static int get_block_status(BlockDriverState
>> *bs, int64_t offset,
>>           .length = bytes,
>>           .data = !!(ret & BDRV_BLOCK_DATA),
>>           .zero = !!(ret & BDRV_BLOCK_ZERO),
>> +        .compressed = !!(ret & BDRV_BLOCK_COMPRESSED),
>>           .offset = map,
>>           .has_offset = has_offset,
>>           .depth = depth,
>> @@ -3189,6 +3193,7 @@ static inline bool entry_mergeable(const
>> MapEntry *curr, const MapEntry *next)
>>       }
>>       if (curr->zero != next->zero ||
>>           curr->data != next->data ||
>> +        curr->compressed != next->compressed ||
>>           curr->depth != next->depth ||
>>           curr->present != next->present ||
>>           !curr->filename != !next->filename ||
>> @@ -3218,6 +3223,7 @@ static int img_map(int argc, char **argv)
>>       bool force_share = false;
>>       int64_t start_offset = 0;
>>       int64_t max_length = -1;
>> +    bool can_compress = false;
>>         fmt = NULL;
>>       output = NULL;
>> @@ -3313,6 +3319,10 @@ static int img_map(int argc, char **argv)
>>           length = MIN(start_offset + max_length, length);
>>       }
>>   +    if (output_format == OFORMAT_JSON) {
>> +        can_compress = block_driver_can_compress(bs->drv);
>> +    }
>> +
>>       curr.start = start_offset;
>>       while (curr.start + curr.length < length) {
>>           int64_t offset = curr.start + curr.length;
>> @@ -3330,7 +3340,7 @@ static int img_map(int argc, char **argv)
>>           }
>>             if (curr.length > 0) {
>> -            ret = dump_map_entry(output_format, &curr, &next);
>> +            ret = dump_map_entry(output_format, &curr, &next,
>> can_compress);
>>               if (ret < 0) {
>>                   goto out;
>>               }
>> @@ -3338,7 +3348,7 @@ static int img_map(int argc, char **argv)
>>           curr = next;
>>       }
>>   -    ret = dump_map_entry(output_format, &curr, NULL);
>> +    ret = dump_map_entry(output_format, &curr, NULL, can_compress);
>>       if (output_format == OFORMAT_JSON) {
>>           puts("]");
>>       }
> 


