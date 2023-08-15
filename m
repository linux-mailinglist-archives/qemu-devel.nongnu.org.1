Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13AC77CC70
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 14:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVt0B-0003dA-7O; Tue, 15 Aug 2023 08:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qVszr-0003bM-2E; Tue, 15 Aug 2023 08:18:04 -0400
Received: from mail-vi1eur04on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72d]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qVszl-0006lu-5S; Tue, 15 Aug 2023 08:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhnwtrCFaRWuP0PoLzfdCbqiWe8Uz8N0SYnz5hPv3FbYMKxzrObWaRaAKPhSnBHdH6rzeGhTbxpIjEafs7+DChV0bxkCrvg4EqrfwcL+4x8l8IJNGwTYgxM0UCR6kq306bUigWyL1xkoVho1QPgy4X+q8QseyMtJ1ZIJU19Q7EM+/30074ylWDMXOFmN0Hi2wjZAW5cGH4pNKFnbbgTUjJEq1QXaM1pmUrFo6sck/bUwZsKd7B0EWzlssJlXh9bwt3U8cdz2y7TO6fbhSdV1fMXmt2O6oAy6jz6frPnXThKEGAlWEigx4uMqtH3J0wh0xGlV8E7KqzhZEMuf9ipvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmpvsJi0L0dwYrPg1inz8iNPQUSzLNKsImSVVhPoNaA=;
 b=JsiXXZd9LeE8eqyay4egIyXq6j/VjD07RxqfSTz6YMhwVy3vOptSF0wmeKkD/9R5/r926rLEfyTrJjG74koUSUZktpUWpFli6q47EQGSi9awrFFRp8BA6fah8TqzAoQH3EYC+JgAkJ5w6BUSg3NVT63gepiTg+Mee/mZl5Bwj1mNGdJPy7t3HkfeSvbXfAhwcggvSg/yde9EmU18HmcT/+RBDcqPilsCeqXh/3k6G6qy5eeDBUuVbeo2WqROoD7FdYdHPJHIgcsKDtjB0/2UntyJHH/mflNYTKmia3w5CV0C2sPbzZfiNmRByTBxHBa58gNKmSukn8x1BcXx3SW2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmpvsJi0L0dwYrPg1inz8iNPQUSzLNKsImSVVhPoNaA=;
 b=LOmNFBZnpvOJ2z/lSpbnymjc7YjfEmNtaO+ZZzv9KsuS8J8ZsX9NCbBzlYNik1kjJlj+gJiF3MBMnaHU4o+aJ7+N8Px5cO0R958jLLnX2i/pmRH8wI2K64E/Z3MiuR953wHiA2J7sILEusEE+xR+V/HY1sKaaKYFZtBaPhLT6gjDK/0UurDTmvITcNp4Ows4WbRqtuQhYPyGRIqec5PyTT85RbIuj6cgkhKOmAs2nV5N3Kt/XXH236OzzrW38fYc0qwTDFYEztw96ViBAqD4OT0mFea5ROULLqLinrCXV14/K/swuLekc7vJP4bhiv5RvhXinvcSaH70FUxy8LPlQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PA4PR08MB6189.eurprd08.prod.outlook.com (2603:10a6:102:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 12:17:09 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 12:17:09 +0000
Message-ID: <f382936f-31f6-db4b-5d14-308820537b31@virtuozzo.com>
Date: Tue, 15 Aug 2023 14:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org> <ZNo20bIZCRjypsIN@redhat.com>
 <df0b3034-e289-61c4-ed11-f3dd53fe66c6@virtuozzo.com>
In-Reply-To: <df0b3034-e289-61c4-ed11-f3dd53fe66c6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0221.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::42) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PA4PR08MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 91889668-19eb-4cb9-d57d-08db9d898c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQFHlp2yQh+H+qGeRbJkYDEbesn9+wd6PWYD9XneT/XvdsR4lL/GB+BJSu8U1ImdYQsQ6B4JcNS+EUmLKuOkLwz/Ts/RJCG/2LJTzPxOJgGyC2ghgIxhLf/zAFfP9KG8pZ3jsWY6HfwqDSCRU+9WYs8GjCITXNL2kSL3gnX4zb2DZJdSO3WLVqW/nhyB53NCmmdy08tiF23ADkpnrfbn7pwNgh4RftDrfIQqucNbw+sOSbS14QeyVbpd8QhFuEtGfEZ7ITAw85dhkMJwVbyi89QtA4iWKT+S049mzTh+gxMAlckrOYhQNL63r4Z/l+elynRBtZQOGKQ5DaVBjlp0H7vofmV5xXG5GNmZ+ALusrmD99PNKDNrUR3PN+0/qZegj65CsSWJjxKyZW/NOKw5QTCcu+sQ4gxBScuQNJu4Zw0nY+EVHljgbxY5BK21sfBbg3Pcul9De28FWQhaLTg6+21zpZwVqQnXtem2MbG5xXmLDC6DowDniI9tPLTuy1kUUU2IZYdzh/LquAZ+C6U1gxL6vnfjrl/n+cHl0f4Kxdoio5tpUJQxZRtLWp88fBUwFHa5puX5jq+KbtvtmsXZN2FvW8O2B2xL1+Pf35rPFJ44p/DmXKfVR6an3jVdZHCxdnu3XJ39616lMrup/UWMvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199024)(1800799009)(186009)(86362001)(4326008)(41300700001)(31686004)(2906002)(316002)(478600001)(5660300002)(2616005)(38100700002)(83380400001)(66556008)(53546011)(26005)(8936002)(6666004)(6506007)(8676002)(6512007)(6486002)(54906003)(36756003)(110136005)(66946007)(31696002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejE3OW1BTHdrWGtSZ0QxNjBPWTB2dHpRT2pCY3NIVmtaZC8wcnNWRXNNQlc5?=
 =?utf-8?B?MkVlc0xvNmgwVjFKS3ZoSFNEOWVOTDZxMnJoTzdwMkxhU0pNRmFXSWRoWndL?=
 =?utf-8?B?anpEZzEweCtsQXEydXdiTGh0MkZOZVJOdGc4K0s1MVBiOEg3emJlZ09zRDNO?=
 =?utf-8?B?RnRJT0UvR1hyTFZrcWxzK2Zhb3M0NExUVnBmMWNyd0dPZG5aME1wejhnOEJC?=
 =?utf-8?B?Y1BITGR1aHl2ZHdkYXZLeGRUb3ZaZWphcFF4UDNkUkhTalU2ejRkeW1XQVpC?=
 =?utf-8?B?MXBJM2VZOU9aQWNRMG5wRmVwd2l6MHhhTjk1L3pPMEhvNVY5TUNTNzBVdzBk?=
 =?utf-8?B?dHdmRmRBQXV4S3lTYllLeEE3QmhLZ0h5QnZ1OTMzSExvVURJMVQ2WGZ4QW1O?=
 =?utf-8?B?d0hnQ0NFQkpla3M0YVJheWVkdWd4eGVGcUhnMWRqdU1VQ1d6amJmUXdmVlJa?=
 =?utf-8?B?L1pDUC96QmlEWG9ZTzRkMC8yVWl2b0Y1aXlpWXkvL3ZjOHJsenM0T1UrRUxo?=
 =?utf-8?B?b1VBZEZBSnl6bGg4RWtXMDhSQURPYUJwQlU4YkhXZERSTmZsRU55VVRtazZQ?=
 =?utf-8?B?ZnBFQWdWVnIzYTJiRzhveGU3MHY1dTJOeGFQOVo3eS9oWG5iTzZMMzF6R2d2?=
 =?utf-8?B?VjFSQmo5MFRhb1lWejdSWWwrSU9PTkNnYUdmMEtBYmNBd3d2Q2ZyVmlvYXVD?=
 =?utf-8?B?ZGM4SnVEQ0lCRkpUQkN3eWYwY2orMHVIRG8rT0RyM3J5ZXpldkJRUWp4azdV?=
 =?utf-8?B?amJTZXl4Uzg5eW9MZkMveElvemh5NUcybUFvN3M2Z25lelZyMzAxamRGZGVK?=
 =?utf-8?B?UHlGS3EyVFpZVlN5bnlsL3VPSklJeW9IVGlmVE51OWNMSmNkMDdxc0ppcit1?=
 =?utf-8?B?N2VTZU9aY1NPbjZGWFdZTE9KS2hTWWpKS2FyeFlpQ0NMYlE4L0R5NFBJcVZp?=
 =?utf-8?B?cXV1WmFaTHNPQlk5RjhMQzU3SGZ0OG5zaWxhOUUzSXQ3cm5UMnBNT3lCVDM2?=
 =?utf-8?B?VGNlZ2ZTdzF0VndDYmVSRU5ZVWhrL2tiUjZSUDh1eUtheCtjZVVDS1FTa0tR?=
 =?utf-8?B?elh5cDFGcGhFdXNKNVlxQnZ1Rk5nbXdSQndWQURhTVpXNUhIY2krNG43SDho?=
 =?utf-8?B?UFZmM1JFNlRkZzdDRVp6RC95NUQ0R0M4Nk0xZ0gxS0lLWityQUNRWEJPc040?=
 =?utf-8?B?dmlqMnBXaEhSd1hjRDk3MHpXN1FWRVBIc252aWVrblNjWU83d0l2TUIvdjdB?=
 =?utf-8?B?bVpsRlNTcTdPc084Vmpwc1YwczM2ejBmUXhZT29GMUpNM01pUXptcjYrNUVJ?=
 =?utf-8?B?akR4WnpCZHRqeEUzanhYbmZENHRaWExBOTlYVFBqVjhFU1l6TERSbkZKMW9O?=
 =?utf-8?B?d0NnaTVrRzhzSzdSYmwyckVLa0EzWURLR0Zpd0ZlRDBGdjlXQ3BlSk54WW0w?=
 =?utf-8?B?ODdWcVZiNm94all0a1oxS21NZ1R4RWN5WS9zdkQwZUN4TEhqRHFOQjFZeWUz?=
 =?utf-8?B?dENzeC9qanc2TEkzVzJiMytUQTNORzdJTnZDWjZzOTFQYnV3aEVZUTNGL1R5?=
 =?utf-8?B?SFdYb1BYZjBuSHJHWGljSktibW1ZWmtyclZIRjQwZS9aZUN5Vmx0U3pkcElV?=
 =?utf-8?B?UFZqSlhoUGgrVytLTno5UGRzWGxLRGNYQ1pXMUY0QlJUN0h4Z2pDRlR0ZVB1?=
 =?utf-8?B?Q0VhaTZ1SncyZzBpYUFpRFpZRzVXV3d5Tmt1Tlg1TlpKQWpNREViSkpjbFlJ?=
 =?utf-8?B?NW1EOEh1bTFOcTIwbHJPS0REMnhValhlNmh2LzgyMFJObEV0N0hHRThXRlAr?=
 =?utf-8?B?b0FObFJlZ1YyblZBY05WblN0VlNzZDl1VmN4UVRNNkRQS0pJMm9UNloyaHJ0?=
 =?utf-8?B?Wm9GbitXUFlscFZobThCb24yeEE5YTFqc0xMbXAyR1lOR0ZPVnhEOEpNT2lP?=
 =?utf-8?B?dnVZaXd1dGxucHpzZk4rMUVVY1JFNys1aUJDN2VoaUZUL044aGZvckFLNTlE?=
 =?utf-8?B?blhoNXNYSmR2WnZVcVE2d2xRTXAvUTJhVnVqNGlTeVZhM2MwdnhrTGcrZGpw?=
 =?utf-8?B?aXU5QjdNbnczWEZTa2YySERycWkzUlBXdEZpYm5ZUGZvVFhOcDllakNIOUp1?=
 =?utf-8?Q?pJ6hL1tkeE6B8pra5HpdjHJ7c?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91889668-19eb-4cb9-d57d-08db9d898c37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 12:17:09.3020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G635m4oG3QEu8nWPTs4DAv/i/UMc5VImk18hxNpxMT62PB39+0nvvFYIRjOPaQMt7c2vyucYpHEntTrM4tijpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6189
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72d;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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

On 8/15/23 12:40, Denis V. Lunev wrote:
> On 8/14/23 16:14, Kevin Wolf wrote:
>> Am 17.07.2023 um 16:55 hat Denis V. Lunev geschrieben:
>>> Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
>>>      Author: Hanna Reitz <hreitz@redhat.com>
>>>      Date:   Wed May 8 23:18:18 2019 +0200
>>>      qemu-nbd: Do not close stderr
>>> has introduced an interesting regression. Original behavior of
>>>      ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
>>> was the following:
>>>   * qemu-nbd was started as a daemon
>>>   * the command execution is done and ssh exited with success
>>>
>>> The patch has changed this behavior and 'ssh' command now hangs 
>>> forever.
>>>
>>> According to the normal specification of the daemon() call, we should
>>> endup with STDERR pointing to /dev/null. That should be done at the
>>> very end of the successful startup sequence when the pipe to the
>>> bootstrap process (used for diagnostics) is no longer needed.
>>>
>>> This could be achived in the same way as done for 'qemu-nbd -c' case.
>>> That was commit 0eaf453e, also fixing up e6df58a5. STDOUT copying to
>>> STDERR does the trick.
>>>
>>> This also leads to proper 'ssh' connection closing which fixes my
>>> original problem.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Eric Blake <eblake@redhat.com>
>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> CC: Hanna Reitz <hreitz@redhat.com>
>>> CC: <qemu-stable@nongnu.org>
>> This broke qemu-iotests 233 (Eric, please make sure to run the full
>> qemu-iotests suite before sending block related pull requests):
>>
>> --- /home/kwolf/source/qemu/tests/qemu-iotests/233.out
>> +++ /home/kwolf/source/qemu/build-clang/scratch/raw-file-233/233.out.bad
>> @@ -99,14 +99,4 @@
>>   qemu-nbd: TLS handshake failed: The TLS connection was non-properly 
>> terminated.
>>
>>   == final server log ==
>> -qemu-nbd: option negotiation failed: Failed to read opts magic: 
>> Cannot read from TLS channel: Software caused connection abort
>> -qemu-nbd: option negotiation failed: Failed to read opts magic: 
>> Cannot read from TLS channel: Software caused connection abort
>> -qemu-nbd: option negotiation failed: Verify failed: No certificate 
>> was found.
>> -qemu-nbd: option negotiation failed: Verify failed: No certificate 
>> was found.
>> -qemu-nbd: option negotiation failed: TLS x509 authz check for 
>> DISTINGUISHED-NAME is denied
>> -qemu-nbd: option negotiation failed: TLS x509 authz check for 
>> DISTINGUISHED-NAME is denied
>> -qemu-nbd: option negotiation failed: Failed to read opts magic: 
>> Cannot read from TLS channel: Software caused connection abort
>> -qemu-nbd: option negotiation failed: Failed to read opts magic: 
>> Cannot read from TLS channel: Software caused connection abort
>> -qemu-nbd: option negotiation failed: TLS handshake failed: An 
>> illegal parameter has been received.
>> -qemu-nbd: option negotiation failed: TLS handshake failed: An 
>> illegal parameter has been received.
>>   *** done
>>
>> Do we really want to lose these error messages? This looks wrong to me.
>>
>> Kevin
>>
> In that case likely we need to extend -v option behavior
> and translate these messages in that case.
>
> I'll take a look.
>
> Thank you for the patience,
>     Den

Hi!

Small side note.

I am 100% sure that I have run this set of tests and
there was no fault. I have re-run them and once
again has not get the fault :-)

The reason for that is quite interesting:
* the test does not start due to the absence of the
   'certool' utility from gnutls

This brings the very important question.

Should we *FAIL* when important utility is missed
or skip? I believe that our goal is to fail to avoid such
cases.

What do you think?

Den

