Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1977CB3B
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 12:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVrTQ-0004KQ-RW; Tue, 15 Aug 2023 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qVrTA-0004Hv-Ds; Tue, 15 Aug 2023 06:40:13 -0400
Received: from mail-am6eur05on20729.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::729]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qVrT7-0002L1-M2; Tue, 15 Aug 2023 06:40:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4BjnbufBTuTyg+opgJmRDdJeNqP5Xe9oWR01+GSAUo7sZ4owRERQJZheRA+ClykUDPOgNVEq+LUVpjfmnbUFlNzYXJ9JMQugRXEmzRm6pVDgnlxlAatIg1hn0CyhnPAlN2GMrUmosDLyBeem8ygc1W/QOlPP2aTw1/UsOP8VtC6PAIhaKyMi2zL+hASESnrGI9xPFdS8vZ6FwGV2xnZx26ifPBV+2rnWtpmlSZBKxUNVdKG3UeBbdtqAKaLyfbnFUNjPoJDXGrgyZaNtCe5CFSIxz4t52kof8ea9X5xm7qkjEpzkH1iFOHABENreA6IA9H2DIwP73hBrNCS23O57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBKiQxVptjMfO71MHrWHweW+TDNgRWR3fn2PQHBmTvw=;
 b=QPzLcZ6eLIkqwIIigThzdlgzibbrSMoi+uLXErAYvalwJQCIUp3nMBm929XYlsknIQ6BCDWK9uMvdM9mt2BBehVjZ2ylly/F3Nt3MNP4eKpfn/cpn8sRniJq+80C9Ec28iK/lGvEICefSA3IelxNuL5Bo+Xezt3qChzXaYZarZzYwK7M0Ka7lgdrCn9wbb58bhqyKEDzWTMwJhoInRzKkuHc86416QLu/c7+CIb+6raZqyigoNnQ8755QkVrEWbG3TJYaG8dOd0ow+F2FBLMIpsan3aF40YpPxsyXUzODF1H22Bh/jJsc/qyFb9yrZVYfkfRKgwAsbQ/lN7BDdnySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBKiQxVptjMfO71MHrWHweW+TDNgRWR3fn2PQHBmTvw=;
 b=B/wLTIJ51Cfthso367PV1CfHJHHOGvdEXZK4w7HNZS9MfvlWrDUqca1NRofbOQn28y3Yh1U3nYfBTdn8JPpdIzyfRCc+qvGIQ0rD5MoBcAsh6/Qe5BvywJ8fxcEyPeDlBDP/0KczSgZXrwjGTfFkfdJ/4WOKBlQF/W5zpnKVInj+SPNxqE4iV0dMmwKuicafAnaxdKb7oOaC2JStx9blfJFiCF55jfPSYbm7LN5Tf4VgR19TNfOTtxs0EBll7iS5MdQVSyapqB2LAJsrtLgC6njQSPZqhu0QQMUJ80XZXrQTC+X7OHOIoyA6xUmq1wCnikcJjSnIP6gqW9BbMs1Mtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM9PR08MB6307.eurprd08.prod.outlook.com (2603:10a6:20b:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:40:03 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 10:40:03 +0000
Message-ID: <df0b3034-e289-61c4-ed11-f3dd53fe66c6@virtuozzo.com>
Date: Tue, 15 Aug 2023 12:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org> <ZNo20bIZCRjypsIN@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ZNo20bIZCRjypsIN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:803:1::20) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM9PR08MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9ca783-3fc1-445b-0f29-08db9d7bfbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+OaT/9QlIMAYbUPtS3HRQ/opfIfxRnAYCjvhav9E5wR4o5KFmM0v/Zz+Qy5axlgf9eGZ9IS0wU3Et6yNLjPspVeGwJLYz++TEi82OgmQvC4ZRuwD1hMpArDViPI6ZQAweAXG40C/xReVpOpj0T8EMlt8b6x/PyS0eTjo06Zc6bbXFYE6nUvfiuL/3gPoJ0nh5iqunwpdSPmo+m8sWksIg4s2Xh7CfxtTVqEYqmNCiAJN5/xRWqbMavmA5tB4eQA2Zdy8Z1ZB02imwxT7fOpHBjMDYQKJ73YuQ25YpwCv43eqI96opn+4q1c7WYTcA+dapZipgFvcNC//4woq3FW++8TIwDp3+9AeUtx00wBqyzn7kli2JVrerg5K6H68y1MHbPe7Z5ya3XRiY7tWLanI80HjVY2MMPFoRk56dSjld3t6Isd3s72wJadGV/acGeTmd61Kh+hk8b//mwTEU7rfbiUzN/sUps7j/Bvbj2t4bMd7ITDkiW/eY8xosEqegOGFz1eiWMEHqo26GmGRJl320KASdHuJ7EB13V3mM+L7FKd3rAR1YAacG8cGGp6qKY+8iDxqRfkcWLuoDUB25D0YiZSgGp3gzQj6UNZuELkHnSIeOgIkD1u/TVUHwUkg7iaP6+C0JHIs9lwah+H0m+nDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(376002)(396003)(39850400004)(136003)(1800799006)(451199021)(186006)(6486002)(6512007)(110136005)(478600001)(2616005)(6506007)(53546011)(26005)(2906002)(316002)(4326008)(54906003)(5660300002)(8936002)(66946007)(66556008)(8676002)(66476007)(41300700001)(86362001)(38100700002)(31696002)(36756003)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBwUWtxUFRBM3pGSUJkeWNyY1pXRVJBVU4zS09Pb2dQc2JzaUp6N1FYVkFy?=
 =?utf-8?B?cnRhUGxqdWVOZmwwLzRldU92QnhWYzdkaGgxd3pFMFFUNGhQU3VQeHdSV09T?=
 =?utf-8?B?SExKZTU4Vm5EZzhRaUpBRkRFcjBIM3V4QnpKa0NwQ21tT2V5L1dFVzRpRDV3?=
 =?utf-8?B?TFROYlZTbU93Ylo1bVBOZWQ3cG9DK3dFc1liTk40bG5OK2sxRU51VTZlVlc3?=
 =?utf-8?B?dWFiaytGbUo5dzY3blRhSUtqMTgxdGlTcjBsWkt6cVhVSzZpUzRZM2UyRHh4?=
 =?utf-8?B?Sno4ejIrSjhrSHRic3dyTnZhbW9Xd2NEY2dDb21lUXRnVFBGZjNvMUw1TWFn?=
 =?utf-8?B?enFwQkZ0RGcxUE9tM3NNaFNHUEN0TVdOTVBnYzduamFoT2loaStDaVhDYTNT?=
 =?utf-8?B?SW5pUWkzZkNrUnczQk9ObVh6V1p6L3NDMkFpa215blVPazN2Vkk0MTlaWG5o?=
 =?utf-8?B?Q3hZMkg1aEx4cUpQdFhnM2VCUnBnTEN2Q09wMDNubjFCV2F5RVJUVWRvd2s2?=
 =?utf-8?B?RTYwT1dYTGphMTlOQnk1RDhXVENQU0VkZGdpdHJqaDhLUCtPWCtJQXR5cVZ3?=
 =?utf-8?B?UFcwWTFaQVdCK0wxNjIzUmhYOWlHY3R2WVJOT05XdXhhOHk3bXcrNkdWRDVP?=
 =?utf-8?B?MUI4Rzhnd0cxUDVhNGZrT2RCUG5lR3A5THQ5bm5FeFQwdnIvZ29LRGpzSDRO?=
 =?utf-8?B?SS82cGxMTWV2YUlUOE5neU51ZHVzbURFMEtLSTVwM25HS2s0ZGtuM1UvbXFH?=
 =?utf-8?B?cGNpdkUxVDNuREs5V2svbDE5UFRVdjVuV3ZXR2gzdWt2b2IyakJUN0F4aGhI?=
 =?utf-8?B?NkgxSDNDRS9TeXJ5QmpTSjA1VmhZaTNycEpVVFV4Z1FScGtTbWdMOSs5clZB?=
 =?utf-8?B?ek5KRXUrL1R0bUtlSk8wVmhlZ2ZobWZ2R3A2QlMxTjRwS0NrSDhFV3JOMWhk?=
 =?utf-8?B?eU02eTVyMzVUalprOHFScmJRNGJTbFg2eXgwaGxCaDI4bmxid0lRcXJOVm9D?=
 =?utf-8?B?WkthM2t0ZFhzdEZOcy9lZnlRNm55TitaWVRBVjF2VC9ITkxNb0FBY201MjZO?=
 =?utf-8?B?UmFjMlRrV0xOZXZJK0JhNTVwNWFmU21LQXk4dVV0ZnlwcnlIbFdHVGFEeWVL?=
 =?utf-8?B?dFlZZzMxMnMrOWxHTWljSXBhQm9jZkswVisvSEZtcmxVaVI3Y0RJOGtSQU5H?=
 =?utf-8?B?U2g0N0dqU2YxSjdRVmgwZHRLNVpTQlBTU1B0ZjNTK0hoZ3NlQXd3U1h3eWJE?=
 =?utf-8?B?bkR1T2VKZXJ4SzdManRaZjduTTlveFM4TUdqaHhJMnRadXhCaTFqZEZqOGVv?=
 =?utf-8?B?NGdRS2tCbFphWG53UzNvSGxEU3Q1TzBZeVJpQm42YXMwNmNVcmdqZ0NyMDBG?=
 =?utf-8?B?cFRNQWdtZ2liaWhZWGlVWkl1eXBQSTZXSjVYTjBmQitBQ3VCZmUwTG8yR281?=
 =?utf-8?B?QkRVdXl6MnhUUEg5cTNIczhFV2hZbm9NTXFBcnlEeTNPS3E2OW9sczNWTkM2?=
 =?utf-8?B?eEt0V2g4amxVVTE2YVlqMlpZZjRWazEzQXpHVWZMdktTejdraUpRZGZTNjhk?=
 =?utf-8?B?N0xPSjQ0RllXMW9oUzNpVnlXQ3Q4ZnM1bUtiMk5PUTNZN0R2MmRWdzAySnBi?=
 =?utf-8?B?SjRBOHpSQXpWRHdHSHA1cGVoSnNtK25iMlFwWW9Jb2t6ZEphVE1nNVpwSURE?=
 =?utf-8?B?aSt6QVRLdTMzU1VQWW1QSmI5RHI1c0FLKy9pODR4Tlh0T2s4bkFrM2Nwbjdw?=
 =?utf-8?B?eUd5THh4eGs2UnY3TDNIVmoyQ0c5ck04S1pWV0dhWEhLWlk1Q2NwNCt2Ylhs?=
 =?utf-8?B?OTNMaGdMTFNxVnBOLzlQSUJXTmdQZ1cvdDdYU25YalNhSGVwYjNWUVBsaGE4?=
 =?utf-8?B?ZHc1cWhXRWFoM0twUnp2NEFXRTEyNTdpd2VwdVFtTmtkVVJEZ1R5Nm5ULzF0?=
 =?utf-8?B?SzdOdlFUTHZCTjFTdTlKRVkrMG5rMEFwVzNzeXRyYnlMNUFxRWNOaGgzTGp0?=
 =?utf-8?B?dnp3V0FyMXNIWkhQeWFIbitGbndUamwvSzVBU1VWeXpzaUhDVjJ1bllCbHhk?=
 =?utf-8?B?NE96bUZGOHdmaXF2SjZrWHhmWFBHZ2VtTjEvSnpxeTJOOTdzeWR1Q2h3VUpq?=
 =?utf-8?Q?nxMOsk4kuwzfj+rz40MGCyfJR?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9ca783-3fc1-445b-0f29-08db9d7bfbc0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:40:03.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFDdrsREBbrXjlBshoxwUAuH0AImiQ29bqREd/dw1IFPFfbFY9FTC+nnNGU4r+DNUNpeshoPBpXD5GIUQpQh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6307
Received-SPF: pass client-ip=2a01:111:f400:7e1b::729;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.265,
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

On 8/14/23 16:14, Kevin Wolf wrote:
> Am 17.07.2023 um 16:55 hat Denis V. Lunev geschrieben:
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
> This broke qemu-iotests 233 (Eric, please make sure to run the full
> qemu-iotests suite before sending block related pull requests):
>
> --- /home/kwolf/source/qemu/tests/qemu-iotests/233.out
> +++ /home/kwolf/source/qemu/build-clang/scratch/raw-file-233/233.out.bad
> @@ -99,14 +99,4 @@
>   qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.
>
>   == final server log ==
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
> -qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
> -qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
> -qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
>   *** done
>
> Do we really want to lose these error messages? This looks wrong to me.
>
> Kevin
>
In that case likely we need to extend -v option behavior
and translate these messages in that case.

I'll take a look.

Thank you for the patience,
     Den

