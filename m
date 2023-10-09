Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E817BD6FA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmZ6-00029M-Jz; Mon, 09 Oct 2023 05:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qpmZ1-00024R-EG; Mon, 09 Oct 2023 05:28:35 -0400
Received: from mail-db5eur01on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::726]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qpmYs-0002BG-9a; Mon, 09 Oct 2023 05:28:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/6b2QyZgIAzL5YOm5hARzbCE+N27/rUOPipjfRdAvehWPjujM50V06MM1MJ3sDLuliUtTlrJ8ENH+wEp6YfCfJqFGgOjI4ZCLb4LuvIEmE/ycozqe+qWykkf/VIUCRVWtZNURfq6eKgeN5O7CI2SC1yBEon3Elaq1umH85BQbn0jszb5Maz7pmpKX2LATB+FRsFhDiOL07yTBDjkp8l0KzhtwQ/GZUbji4r0CEX1Di2NLxt7X81zE8rXbVj++xhq1nrmIAUenWmK4SGsS8UZnag2tUiaWibyuJ5TdM4jw1OeC5MV2HwtMdC/sXP3k7YuWPOCh74QZyOiE3W7DLf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oprnf/Sh+ObRg1iQp22J7iJ4kDrvSrLtFSC4uD2p69A=;
 b=cPVVcvmVSmBAxhzu53CE3ONWCpR136SCKFDNlLy/7/38arztjg3Lpll/I0HGWNkr02bmXFQ/tqzjg0gDCKlHO4tRgS9/2Qk2xfvU84kdi5uQsSFXoXLT+lyqm8XA3ngkYfNx2k8196rOeWhHRPJsBiSHEW7BoemUwLfMBgZihpQ7c/yISdt+lnlNEnvtPH9ewhsE8CWJ9lYXNRWHaTrz/Q4iSZtFA22+qUUK5vki7O+m9rqGj38e7V03cVt6EDj0AqZ3Pny6fAlNscgHrytoKalzx+pGNUXi4ngp6cohS1mYlMQzNS/fh8sp36pitIX5gfDe+NO+QSRQq7t1oQhNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oprnf/Sh+ObRg1iQp22J7iJ4kDrvSrLtFSC4uD2p69A=;
 b=cpwVdm9IWyHR1qTHdBgA5DLaUcf/ujMU7fOpBRKKwE/oMh6yPhWRtLVC9xQm+tzvkK3cryHF42rVTiuVXcIwzY0oQWQZ/DHYzztovRVvPodU/9u9ESiVObmG5ZqRJRobvZ5KzKlM5PjEO1A/aE9R7t71kkZfygtNMHevQy5Ss87JwXiMkNHipni5CAFq/lF6E2ITftH0Bmp6qE129Fzdc9T22Dhq9j33iCxwYCOzVr+NDnboZzaD151OKzEEMGpEGX8l7gPgHHizVTgADfNM1Y+W9RVdhjY19Zz8ZWm4Swq8KnMMTeTKSSFH+Y89ZT/u4vlv3EajM2RgWF8Igv4vYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV2PR08MB8416.eurprd08.prod.outlook.com (2603:10a6:150:b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 09:28:15 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d1ec:5324:a321:be0e]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d1ec:5324:a321:be0e%4]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 09:28:15 +0000
Message-ID: <94e17e07-d791-4cfe-970f-cdb9e7ae378b@virtuozzo.com>
Date: Mon, 9 Oct 2023 11:28:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] preallocate: Don't poll during permission updates
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-4-kwolf@redhat.com>
 <969ae041-3c17-475c-919c-5b33cb6d21c5@yandex-team.ru>
 <ZR/LoVGIt3BQ45ek@redhat.com>
 <f210d1fd-5a4e-43a5-b76b-553e74708a5f@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <f210d1fd-5a4e-43a5-b76b-553e74708a5f@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0089.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::42) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV2PR08MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 885799aa-0ec9-4b80-97a0-08dbc8aa10a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hOhwc3vsFm5NzoQxGw1LXSokAP++NbB73mU+MqcuIrbWrCyaitZTffi8k2qJ29/bLZs+BUNRCmxS/WpMFuALcZzdj7beJsEK0vee+/lQ/d2QRRhlt4aPf4bSb9lGk/Q4gRye2O/+xW9UXOSHhZpglfBrTpotpFvlPD8vts+TEiSkAXyew/O5qUhInMdD/vF3aV3mn/ISLi/0GLf6FPLJUqf5EO1PAsqV/NthiE4KTOFuozhv6GDRus7NS+QWahm/yEKTXfmQeEUUd/OsvXMIsVMLdTS8+GthabLB/Z1ZYYj9PDm9v51xoRzE9joYDwLfG3krcW/CInEt4Kt/hwVSYWcy0mh+6oIzSKPoQhS7a7oqtWcqrcMzNo3YcGJZTMihcToEH83a+fRJV6N59LcjJ70Q1/iLjSED1Ya1WsaQ9gbKxk6+3zqD59v8DtIBb143gUj6i/ioymHyKJuKBBOQLHFZljioRSufMaoggox+2fcwPfRYtd0pYlEqe/FiYpOTfSoTPK7AL90mmTT4S4EAj012oone1mkupb6LJ/jOS2d/EelOR+R5/pLyZ5pT/1Qiw5UpLmpBl6G0ZOucVFJhIlSPg7pccQc/GiWCnSLyrwWliUk0pz7mCy+/KtTFpMOr+fYXt/ztT6n0ZcK1MQ3Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39840400004)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(31686004)(6486002)(6506007)(53546011)(478600001)(966005)(6512007)(38100700002)(36756003)(86362001)(31696002)(15650500001)(2906002)(316002)(107886003)(26005)(2616005)(66946007)(110136005)(41300700001)(5660300002)(4326008)(66556008)(66476007)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElDSTFZM1ZiZnBQU25jV2dFRXpBZHI3TkNQWHFOSEd0NkRadHNkNldKcDc1?=
 =?utf-8?B?NGsxeGsrUWJZSzFGeDU1UHZwa1h5T29ONU1FQWZzYXdQVTg4TytXV3NKOEFH?=
 =?utf-8?B?MGNBWnpTT2pzc0I5TGhGbGlacGVTOERxaFE0Qm1pRXJ0cEVKU2NlSGNUUGt6?=
 =?utf-8?B?TFBkcEExaUlMZUhDbUFBVFNDS1NqRWdHTjNZRHFRNDBnTlc3RnhHUHJNT094?=
 =?utf-8?B?VU55K1NHQ1lQSTdUUkQvUExpaEgxNmNSQ3dlUWR1WXRZbnFwY1NyWVhIeHpX?=
 =?utf-8?B?YlJqdExSZU1lU010SzIvTGlvSXgzSko5RXh2VWZRYVk4L1NQNS9wdW8xZHZo?=
 =?utf-8?B?bjl2UUJjMU1LWW1OU3hJakZFbTByL3QrMGlpY0huVTQzblBRSVdUK0k2bzB1?=
 =?utf-8?B?SnRLUlY1VjFXSXFiaHZhRllTYU5jaDI5TFAvdUFsdFN4V0pOMmRQdDN2QXk0?=
 =?utf-8?B?R1RFVG81UUdZSmFsWGJKZnN3NGpZNGFwajlPT1lPbkNOYXowZGlUbEU3SERn?=
 =?utf-8?B?ZjF1MlhOam0zVHcrVnlnUEJHRDhXWWVSb29zSnhhUzlac1NGOWpIbHNuZVpm?=
 =?utf-8?B?Q3lRWnpudlVBZVhQUkRLY2RXN2liT1doZXYzQ05XdjlpTE02TGo4a1NYeUUz?=
 =?utf-8?B?cnAxdGNHWWNCbjVYMVcxNkxKYWgyWHRvUlNDTUNFL1NHS1QyL3JVQnNic1ZZ?=
 =?utf-8?B?ZDJhRHpmeWQ4Z0cxRXRGbXhOcXlWcjZMR1RuaDRpSFQ2NWQ4R2EyaGNPVnhv?=
 =?utf-8?B?UmR1bHA0U0FuRkFmQVJ1UTNRZndlS0gzQy9zOUFrbG9CWDlqM2F2aEpZN0VO?=
 =?utf-8?B?RG1DWFhvUEFJS1JBQ1VvaHJVYUcwVEI0SjdCWHVITXpuUzQreG51VGFFcmFM?=
 =?utf-8?B?UGVQYkJobzNGWkNxR1FtdTFDQlBVODcxbGRnMjJwWXJ4UGJoa2cwSjY0Und0?=
 =?utf-8?B?TUFWb1loaDRsY2VLc1Z4T3lWK2xPWmx6enYxbGQrT0g1RUFIOUcycnFKbWJG?=
 =?utf-8?B?dWdKSDhUUWJvd2k3bmVsc09ubnBoUW9HalQveDg5MjlReEdaS3lBK1BscXJZ?=
 =?utf-8?B?bWtCTkkwbGkveWFXVERiMGtSVVo3REY0Y3BxSkNtamIzdVY2djdKb0JkVHc3?=
 =?utf-8?B?K0loMUpnSUw4bzd6N1l0R1JnMFVGS1ZLRHFscCtncDZUaC9iVm5jTGpCQzRZ?=
 =?utf-8?B?WTFycThLcEJIbDJiTUdwQUtwQUJXbnYvUDdJdVFWdlkyUU9TVUI3WWtDbDlC?=
 =?utf-8?B?dW1sRWhoL3JZZzA5WHJnNXp0bmExdnZlWXVLRGRYam9VV05lRzN4NW1SVkJY?=
 =?utf-8?B?OWJ2a2JVNTk2SW96NTNSb2ZUTTYrZytwSE5rQ2lZUUVTNms4U3ZSV0tIME42?=
 =?utf-8?B?MncyVnBBenJYUkNJbDdCQVBPK3podDZxUVFRYVZZbFJBQVdPQ1dqaFc0YnRT?=
 =?utf-8?B?dTZDSStXY2VGc054TUhkdmtoM0U1SVM4VFI1SWZmaHJybTZZWWpzUU83UGll?=
 =?utf-8?B?RW1TUmpva1VKSUZBbzdROGU0RVJGSVVuV2xrWFg1bWErTEVoR2Y1MnpDVW1q?=
 =?utf-8?B?MWhmYnVUSTlMbjJBYUNEV2IrYUt2NURZRWkzYjVVY1NyVWtzUCsyNmMxZmdo?=
 =?utf-8?B?L0hBdzJpOStwRSsva3dJMnZFNWw1NG9tZXdtNFJUSnZiS25kV3dmbm5HMUhM?=
 =?utf-8?B?WXdpa2hXWDNVelNWbHpRRFUvY29odHBZVVBMOEVzMTUxQmpqVFNCM1VqSUJr?=
 =?utf-8?B?Z0EvQVkreGNDaGVweE91aVNGRXNkczMzaTN2VWJLNy9MMmVTeGU2a0NLWU03?=
 =?utf-8?B?SEhRMldwYStralUrMFByb1VsZkVRRHlxVU0zZlN1dFhETk0xaUxJS2NUWjRy?=
 =?utf-8?B?WmhUZnpIVUp3MWRFOTdyL2EvQ2phWUpqdDhrbkhYNVNzS28rbmFqK1JQb3JI?=
 =?utf-8?B?cHFvUTBhdFM5Rm5oUEJibUxGdmJoNUxTT2dzVHVLdFVFUEZEN1ppN2g3UEZI?=
 =?utf-8?B?OGRnZVBCOVQ0NzZVTnQ3QldQb2l5SGxnd2tFTGVwR3BDTGlVZjZSV2d5MDdy?=
 =?utf-8?B?ZnhMUlhOVngwd3lZbFhtOEt1akpnSHpnUzVwUzNRVDh4TUwreWl0dnNVNW5J?=
 =?utf-8?Q?14ED/F12UFYt1KijlVD2f01hc?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885799aa-0ec9-4b80-97a0-08dbc8aa10a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 09:28:15.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2gyNFVxHNsJfMsFoPl7GUXpap4/pmdjJf+4YoCByGfqS9hYgLFicLNWgJsdgWgOy9ZHhN9Lb2BJHCwah9g3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8416
Received-SPF: pass client-ip=2a01:111:f400:fe02::726;
 envelope-from=den@virtuozzo.com;
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

On 10/6/23 20:10, Vladimir Sementsov-Ogievskiy wrote:
> On 06.10.23 11:56, Kevin Wolf wrote:
>> Am 05.10.2023 um 21:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> On 11.09.23 12:46, Kevin Wolf wrote:
>>>> When the permission related BlockDriver callbacks are called, we 
>>>> are in
>>>> the middle of an operation traversing the block graph. Polling in 
>>>> such a
>>>> place is a very bad idea because the graph could change in unexpected
>>>> ways. In the future, callers will also hold the graph lock, which is
>>>> likely to turn polling into a deadlock.
>>>>
>>>> So we need to get rid of calls to functions like bdrv_getlength() or
>>>> bdrv_truncate() there as these functions poll internally. They are
>>>> currently used so that when no parent has write/resize permissions on
>>>> the image any more, the preallocate filter drops the extra 
>>>> preallocated
>>>> area in the image file and gives up write/resize permissions itself.
>>>>
>>>> In order to achieve this without polling in .bdrv_check_perm, don't
>>>> immediately truncate the image, but only schedule a BH to do so. The
>>>> filter keeps the write/resize permissions a bit longer now until 
>>>> the BH
>>>> has executed.
>>>>
>>>> There is one case in which delaying doesn't work: Reopening the image
>>>> read-only. In this case, bs->file will likely be reopened read-only,
>>>> too, so keeping write permissions a bit longer on it doesn't work. But
>>>> we can already cover this case in preallocate_reopen_prepare() and not
>>>> rely on the permission updates for it.
>>>
>>> Hmm, now I found one more "future" case.
>>>
>>> I now try to rebase my "[PATCH v7 0/7] blockdev-replace"
>>> https://patchew.org/QEMU/20230421114102.884457-1-vsementsov@yandex-team.ru/ 
>>>
>>>
>>> And it breaks after this commit.
>>>
>>> By accident, blockdev-replace series uses exactly "preallocate" filter
>>> to test insertion/removing of filters. And removing is broken now.
>>>
>>> Removing is done as follows:
>>>
>>> 1. We have filter inserted: disk0 -file-> filter -file-> file0
>>>
>>> 2. blockdev-replace, replaces file child of disk0, so we should get 
>>> the picture*: disk0 -file-> file0 <-file- filter
>>>
>>> 3. blockdev-del filter
>>>
>>>
>>> But step [2] fails, as now preallocate filter doesn't drop permissions
>>> during the operation (postponing this for a while) and the picture* is
>>> impossible. Permission check fails.
>>>
>>> Hmmm... Any idea how blockdev-replace and preallocate filter should
>>> work :) ? Maybe, doing truncation in .drain_begin() will help? Will
>>> try
>>
>> Hm... What preallocate tries to do is really tricky...
>>
>> Of course, the error is correct, this is an invalid configuration if
>> preallocate can still resize the image. So it would have to truncate the
>> file earlier, but the first time that preallocate knows of the change is
>> already too late to run requests.
>>
>> Truncating on drain_begin feels more like a hack, but as long as it does
>> the job... Of course, this will have the preallocation truncated away on
>> events that have nothing to do with removing the filter. It's not
>> necessarily a disaster because preallocation is only an optimisation,
>> but it doesn't feel great.
>
> Hmm, yes, that's not good.
>
>>
>> Maybe let's take a step back: Which scenario is the preallocate driver
>> meant for and why do we even need to truncate the image file after
>> removing the filter? I suppose the filter doesn't make sense with raw
>> images because these are fixed size anyway, and pretty much any other
>> image format should be able to tolerate a permanently rounded up file
>> size. As long as you don't write to the preallocated area, it shouldn't
>> take space either on any sane filesystem.
>>
>> Hmm, actually both VHD and VMDK can have footers, better avoid it with
>> those... But if truncating the image file on close is critical, what do
>> you do on crashes? Maybe preallocate should just not be considered
>> compatible with these formats?
>>
>
> Originally preallocate filter was made to be used with qcow2, on some 
> proprietary storage, where:
>
> 1. Allocating of big chunk works a lot fater than allocating several 
> smaller chunks
> 2. Holes are not free and/or file length is not free, so we really 
> want to truncate the file back on close
>
> Den, correct me if I'm wrong.

1. Absolutely correct. This is true when the file attributes
     are stored in a centralized place aka metadata storage
     and requests to it does not scale well.

2. This is at my opinion has different meaning. We have
     tried to make local storage behavior and distributed
     storage behavior to be the same when VM is off, i.e.
     the file should be in the same state (no free blocks
     at the end of the file).

>
> Good thing is that in this scenario we don't need to remove the filter 
> in runtime, so there is no problem.
>
Yes, this filter is not dynamic in that respect. It is either
here or not here.


>
> Now I think that the generic solution is just add a new handler 
> .bdrv_pre_replace, so blockdev-replace may work as follows:
>
> drain_begin
>
> call .bdrv_pre_replace for all affected nodes
>
> do the replace
>
> drain_end
>
> And prellocate filter would do truncation in this .bdrv_pre_replace 
> handler and set some flag, that we have nothing to trunctate (the flag 
> is automatically cleared on .drained_end handler). Then during 
> permission update if we see that nothing-to-truncate flag, we can drop 
> permissions immediately.
>
> But this difficulty may be postponed, and I can just document that 
> preallocate filter doesn't support removing in runtime (and modify the 
> test to use another filter, or just not to remove preallocate filter).
>

Den

