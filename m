Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A274B002
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgy-0002AU-FP; Fri, 07 Jul 2023 07:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHjgw-00029H-3Y; Fri, 07 Jul 2023 07:32:02 -0400
Received: from mail-db5eur01on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::71a]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHjgt-0006am-Rk; Fri, 07 Jul 2023 07:32:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGkzbDKGvAHhAHJsv4Rtg/uDlY9els9cuaHNEkXSXZeefqUvakhM4yfQMK8JVK5OGay5UbZ+JUCcPiM6De2yE428bhv4EAk2lOSO39dUA1cN4oc6mVb16bUBBqOE1oDzaRWXpszMh34EGQMPyaCfNzNU43EE0oPW9G9elX1GDzkTs5+LvSwvhJwWhEkCeGCWaMB2oY3Wvoe0i2kD0Iq/m/229E1EzXvN47TrCbYsvyCJEP+ds1dGrmvmnUbG7ohp0hprK7G3Kdxlu/Cidzy8Q9sTKrFkElen3gSvQs0ZSFF1kjUpbhythu6tqOUxpABVPo8WfnjnpUx/J/XRMtzKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b34m3ZC/6ad+ZxzfjKIw/MbOmO7OcKJTnKcjxXDUokw=;
 b=WWmSXv+Nypbo6PleOCRuzFvwppdo8fa4u5lqG9yJa1hoL/SWKd+higqrbtbg6W3iF7tTboD0u2/fVWlmWfpU1RMo45sk/Go/AzjujslhNGdhWilMnuXpzquWaj4yDsNIFNsOzkuGWKxivUoMeh7JdKXWZixcyr9qrZhi4/xljfy5BQXOAfF2lryb5o53nM51Cv2fyOitGWmJ1vN9/8Gs4v36xNaAV4fW6lymU1WoMwLn6R28iGulQCHch87a7uV7Juvh5+0a5qDTu8iuUvcDm1SHAY+KDgAIR6jHn2JCjpliKcfeIjApYkiTnojWwuHmUQbo6ZgziD8BulR/mxyYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b34m3ZC/6ad+ZxzfjKIw/MbOmO7OcKJTnKcjxXDUokw=;
 b=ndqRcJ2BbUY4I96SEauFMck3jrlwOFUO1FB74byCTnO3F/lsL7/OlnOc4R5upu8WlTjq3Qo7vZRczDQzNYIOObfOCYmT24KP5kYBKY2ieMkWeXaenUfWFDDzowV6NGSg1ZvL5XD41KVnCbvGO+ghtJzVzstLrjJmD65TjnQJUe/DN6H7v9ZTlMa7rgP8T1Y1jOP5lLUIHF8I2Quvk0TG3SUU8B2LIAIaDl6KUVS+x0F6BakhhMNFS64hDLDQ1PXwPcO/rbBDmvAvX56BuukKyFOz5dAyQEHsWZVsa3v9P+CjgmH+B25KCMky5jnRexVGRAFm0kYHTy+7w7vZaO3iyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAWPR08MB9966.eurprd08.prod.outlook.com (2603:10a6:102:35e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 11:31:57 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 11:31:57 +0000
Message-ID: <4003a739-76e3-9cf4-6f89-78025a545301@virtuozzo.com>
Date: Fri, 7 Jul 2023 14:33:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/6] qemu-img: rebase: add compression support
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAWPR08MB9966:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9ddbb5-7043-4be3-bb23-08db7eddc581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Fa1jvuQgJSzY0ISrfzRX2/mB2/TESisPIh6EwK+W/v3ldh+vsDDcRLV6cy8KvGCo7860mjfAhAFn0RZdxjDsOxkqFXSNzsRIaFzk9ma5O7JJhu9m44B5z2JMj2oCcUL/egFWxnwoeGAPfh4a5DhbaGVrLaU4Y67MKeaQIaFhlbyEpp6/9qNAcCpG4h9XsvtDmoVvhB093AVchBloDmUyvQ1hnQ9s3V+SV1V37Cm7MrrAFxoZxWIRr29XZSakDvuesn/qIRfGAGo3MBdHbUrKloAdaAIEhoeUqt+K7vSn6g1siZzPmmg1POOKupAnWSKE94vsveCoXfeV+c7WeP0fLQYai0uO8e2W/4xnZ0k1cW7hL31x8zeH90e4WPEb5z6PSSbIGTjvK2yQGR9qKb0Gyc85XNvJhXUEoJW7R6A5G6M3VFEJu9nvM9j/1ro7F9Lb2siSQA7VH2IgTUKvD/Ju2s9jCKdMJqD2dnHwnyw+qYEncEPP5l5SUAbHMy1VgLUqosyroVsJv3GPpUJXt2qnqUzBoqIFNmJsdkKldhkl8OGSW42Ntg8MmV57jFYmLYVUjC/eOf9dtFs7gR6ghfvZ5LzmeY7O0cGyB4bSL5+j8ngNPBtEE6DEA6CGaf6lc26OAWJhkyOvLXQyNOAUzrEqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(451199021)(38100700002)(36756003)(31696002)(86362001)(6512007)(6666004)(6486002)(186003)(6506007)(53546011)(26005)(8936002)(8676002)(316002)(44832011)(5660300002)(31686004)(66946007)(66476007)(41300700001)(4326008)(2906002)(66556008)(478600001)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWMzRjhtcW1mL0VWVDV3Q3prTlh5ZEF5UGxnU2kreUFQZWYrRTY5TmdzMjRP?=
 =?utf-8?B?UUhXM3ZiL1owNU90NzZvN1N2bE4vYzlCZ1pyVUdTWnRwS1FPQzgrWm5mRW53?=
 =?utf-8?B?QTNnaXRrZDlQYjNKYWJ3RVhWNTVFdnkrcDJOTlFRV0FMRzA2eXEvV2dGb2cv?=
 =?utf-8?B?cTJabkxQcjhSVEFVTllQQ0VhV3QxSVhGZ1FEREZZSzRORFJYQnpEaGpQNHc3?=
 =?utf-8?B?aitsWUtxN3ZGenNnVmdCclUwdllSMk9BY0lJbnI5WlNiMEEvNmgrc29nS1V2?=
 =?utf-8?B?K2xtSTFWTzdLYzdpN1JlSUdpOVVRRmdwaFVvTnkvcnBGdHEyRjN6UTFaczF0?=
 =?utf-8?B?Y21TODBQVC83dDRmL3B1NTh3MjdXWUVHSVhJZm05ZjlFYmFTRDJwS09SVEd0?=
 =?utf-8?B?a1F5Mjk5djNVdTB5MkRWb0dwK2JHRDgzWloyYWd4a2RMMDQzVktJZUgxR3M0?=
 =?utf-8?B?TU8xRytmbHJFTzh4ODArdlpyMWQyUzZxOHFnUUZ2c0VWOWJzdy9QWWFkdVlE?=
 =?utf-8?B?MTRxamdQTmtsL2k1UGZNOC9JQWZvQkM2WE1vY0hBbVpnTHIvd09SNWpNWEFp?=
 =?utf-8?B?M1RLUnJlbmVqTk05N245cEM0U0xpZVNGMXBEUSs3VWRQSWkwNmFoYnZNV1hr?=
 =?utf-8?B?aUN4bXQ0cnFHWTRIcThvUU12TitlbkczL3NRbHJGTitvcDNvU1hNakZYNmNC?=
 =?utf-8?B?bUhmZWlSOXRmZmZwcEpvb2lNTy90VUNnZnZPejh1Vjk2UzRyZTJkQ1JLV1p2?=
 =?utf-8?B?OWVuQ2R3SlRwRXdkUHpoc0NWYng1YnhsNktlWnpEY0FLS3dNWm1qM293cTZV?=
 =?utf-8?B?WmxRWU9YUnJiRFhNTzZDdXRXbmdlTUtzWXdqejdyY2NYSXN4WmVtZnlyRkkr?=
 =?utf-8?B?QVBSZXVjSHViTGhSaGdZa1pDMTg1UE4raXZiNElBeCtEM2ZEMGZMQTdSYm9n?=
 =?utf-8?B?Q0trVGJPQ3hFL1I1TjY5blNrcmZTVlpVWmg0TGFvTE9rMDFxVlhQcERKL3Ft?=
 =?utf-8?B?TlFYZkpVclo4UEhxVTRFcjZtL0tvZXc3UjVaKzdkT2QwQlFINzZuQ0JCNGN4?=
 =?utf-8?B?cFVrdUE3cThibURWZnQyRkd5anptSlJidkNzNHhiMW5xaTE0M0lyUUs4KzlS?=
 =?utf-8?B?NU44UGtWRmZyQXBqVHlsOG1tYWR5UTJKTVdZVlNNR3VHbXA2OXpUdXoxWkZI?=
 =?utf-8?B?T2pUT0NHVkFpN2VKWkxySWNyWFJsenpWUC9mU3VldkJwakg1ZWNUR3pteEUx?=
 =?utf-8?B?UVg1QlhYOW11RjU3am9hOS94OWZsN0tOcWFBR2NWUHhsL3doRUpuYnFmd25o?=
 =?utf-8?B?QVUzODZHYnZSSUUrS3NKS3pFd3VGczNJTGNEU2g5VnFmMzdleXlrVFNvUHpY?=
 =?utf-8?B?YTg5b0wzY2x5amI5RmFqNjJJeEdGVTVIZGhZZ1VOWGpJeDA1ZEZmWTFGRzRO?=
 =?utf-8?B?VDI1Qy8rRldEQklraXoxK1h4WTFES29CKzc2eG9xamp6R2p4MkZTOG16aHBG?=
 =?utf-8?B?QjhTaTBSVjVYaElBaitMZ3NiYlVoN2hINFBoUnhUbjF6UjJpbm5LN3BjQlg0?=
 =?utf-8?B?MzBtK2wxM2ZPdXRjVXdnenRibkJ4eVd0NnE3cGd5YUR6Z2lqdjJ6bWkwVE1C?=
 =?utf-8?B?dnJ0UlJ5emo1cFVJbVZoMXdLS3lrcVBmWTAyWXJVTTdNUUN5N1RaMTloa1pw?=
 =?utf-8?B?WmxpMTZ5NEc5L2pCSmZwMzRiWEZtNlIvMzhmbm00dVdxODZ5OVFjVE9WckxO?=
 =?utf-8?B?RU9QOUdqTWxSZ2xiVmJjbS95U1lrOCtjcURvWGdjaTJEMzdQMlY1djgrQ1gx?=
 =?utf-8?B?UncvajFmbUJWNnJDTFpNajJpQnlMZ09JcG5ZME15eXBKNi9UM3RtOXdCVmFl?=
 =?utf-8?B?S2xRVU0rRXlyd3Uycml1MW5ocWNqeXlSejBsVUVCMVhNdWJCWWFDWThqTzRS?=
 =?utf-8?B?YUlaeW11SDdMTXhweDZPb0I1UVJxUzI2WlloUVFtcFhONzQ3a3YvdTc0RTFK?=
 =?utf-8?B?ZGJTTXN6SWNvOXUvSU90YmVyZEFRbThTUXNTQ0ZnTlBwZDFMZEU4dnpwekJt?=
 =?utf-8?B?QjBBcW04dG5xbHBHUzhYb3RuRTBqWmIwWmwveTk0MGpHc3JGaS9iVzE4L2xX?=
 =?utf-8?B?Z0U5WHJia0d0VmlRWUxGNVpTMklVMllkNmd1WUhiMWJLVlRWdXpDNXRMVHZM?=
 =?utf-8?Q?PaCGIzW2k3eILfWaC0QmDu4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9ddbb5-7043-4be3-bb23-08db7eddc581
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:31:57.0333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBwib4B90h9/NK9WxF8P/5zfXPcUayfvyBhFemxNUOrcRPr91b1KMb+l3N0fJF890IInGJ0l9xV492B/Fw9O5C/3rQTGeOYEEVsQzsjQSbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9966
Received-SPF: pass client-ip=2a01:111:f400:fe02::71a;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/30/23 13:54, Denis V. Lunev wrote:
> On 6/1/23 21:28, Andrey Drobyshev wrote:
>> This series is adding [-c | --compress] option to "qemu-img rebase"
>> command, which might prove useful for saving some disk space when, for
>> instance, manipulating chains of backup images.  Along the way I had to
>> make a couple of minor improvements.
>>
>> The first 2 patches are a bug fix + corresponding test case.
>> Patch 3 merely fixes wrong args used in allocation.
>> Patch 4 makes write requests during rebase operation
>> cluster_size-aligned,
>> which seems to be beneficial for both non-compressed and compressed mode.
>> The last 2 patches are the actual feature implementation + tests.
>>
>> Andrey Drobyshev (6):
>>    qemu-img: rebase: stop when reaching EOF of old backing file
>>    qemu-iotests: 024: add rebasing test case for overlay_size >
>>      backing_size
>>    qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>>    qemu-img: rebase: avoid unnecessary COW operations
>>    qemu-img: add compression option to rebase subcommand
>>    iotests: add test 314 for "qemu-img rebase" with compression
>>
>>   docs/tools/qemu-img.rst    |   6 +-
>>   qemu-img-cmds.hx           |   4 +-
>>   qemu-img.c                 | 106 ++++++++++++++++++------
>>   tests/qemu-iotests/024     |  57 +++++++++++++
>>   tests/qemu-iotests/024.out |  30 +++++++
>>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>>   7 files changed, 415 insertions(+), 28 deletions(-)
>>   create mode 100755 tests/qemu-iotests/314
>>   create mode 100644 tests/qemu-iotests/314.out
>>
> ping

Friendly ping

