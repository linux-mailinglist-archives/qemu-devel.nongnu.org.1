Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CEF7699F1
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQU7l-0003VO-Dk; Mon, 31 Jul 2023 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qQU7j-0003V9-Dg; Mon, 31 Jul 2023 10:43:51 -0400
Received: from mail-db5eur01on0721.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::721]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qQU7h-0004e7-TA; Mon, 31 Jul 2023 10:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg4NLILjacXaP6Ub6/x46vZyVYw4AVLpDccqKdqnMxp5ieEiw6aNsrmBiLE4a4IqQj1+01K3VzDPLfCckEWvZ1uxUO3scgwF2RIusdNofi/svhsQd6C46w0+WFgbV2HmxnZRGxN4fgrXyojx/dpy0jfOSr1MZklXkysX1fNnPX4WjyeAWWLZaifUp1WzmAOBi5x9HSZaIAdgNpA81RHw2sTyrGAdFJK9EdwhGFl0Y+Um1cMLkpCRAuYEmdVcApk0nDiyRhSXXrZsVvjRyqTEDdPrNpcUyVPdiXbEn4zpFuC29e/WTSjFW5/YC0qe/94BmfqCglPEVMAg1qq5SywqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB3eJYl1F3HZ7ifIi4AGIu5AUb9nUHu3EkruFA+rJjA=;
 b=Bmom89SHOT/Y+o6IurmEIcnxA1YC2Wd2PbYJx0fZskofkQAcZ9P1n2A0M9h86OO+m902JsYlPcnSSh9ItM0PUp95Eyfz2nOUi+fxnsBA9C2SKbXTFV7fFTSfCslnaKLVoqGJ2yPcRxUzW7s4wps8tADKAryLgnYC1iJaLaGckKZjrLNM/4Wlib9q+mKAjJzB7NGzHlXYGGg+mexZiXK5WmkLXGzn19RjN46000AMKkrMpI1qXe35Enzm7LhUxuM1hSfFGcJLBDDAIKzDBg2mKe3shyOtnunv8J2dlsA//ogC8SA+p98p4PSsB57KhizpYrjvDQkba2mo7JhnMZLIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB3eJYl1F3HZ7ifIi4AGIu5AUb9nUHu3EkruFA+rJjA=;
 b=JNhVgmi7d0qlxe7Ddq+6DlFQlYOqj/AYsUfqMwl8GQWwJTgcM8dD3jZ1+KaYW/1NDfZa4CldVDs/zg2L86tpLzfOJWw3co3dYrvPOKQwi0BkA3G4qZnqR7Bj+UFw3j3XV8UhWZNn2leiq5ozuGe2x6d0CJobnb0WEfq7fDTd+1BjMQPuukOv0tYCXyDRoHf5vIdqIlrC1/uvzhzvpzn9kjREuwHDtSUlVP+hXvNMfV76IEN5ySHu4Jp+Ax4vNXv3UVjRIximaAbQKSgcloSgUyKPtEEty0c7bydMxhyFDYoHLpu+wxfQVXSJsC03FSKaJkmn0jBNzf+rV1XhWn2bTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAVPR08MB8920.eurprd08.prod.outlook.com (2603:10a6:102:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 14:43:46 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 14:43:46 +0000
Message-ID: <b847bd77-d23d-c0e4-dbb5-e69dba0d2db8@virtuozzo.com>
Date: Mon, 31 Jul 2023 17:45:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] qemu-img: map: implement support for compressed
 clusters
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <8c0bc7da-175d-a367-3d7d-32f570953e7c@virtuozzo.com>
In-Reply-To: <8c0bc7da-175d-a367-3d7d-32f570953e7c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAVPR08MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 559249a2-4572-48c1-1a88-08db91d48bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ArkiObXtCi7U1VTlX9sf28bwkwoFFM/ffVLeT6jeFALHtd5iU1ejbsyNVTVLKWAiSIEVdgI9BFA3UVHhNhtAFJYxt8e3GEWLvdhpr2SkqYr3dglZhlBJlmUZb/tm+WxleswldCcJfLG8TOIaIbdrsMHo4RJtoymHeqwvFTym56FnnfTyTkiFL69t5liNaV8e/3srHUFQpDqMVLTzKyX/5ie33G9wpx8d4lAHpm8CGIFdqvah0xM5POUW0zoXnJ/aH9q2dqdb9YWp3XYuKBGKMQYmZR8CnJpUmMnRY32y4eDfX8MFZ/4UxDnwkevZmFrQECMPDlDWdXjlAShr11nuVm3ISJw4JX1XvZfo3shgagYJDMeyiWiiG5kh1/Bi9LSU5UUaeCeieQlGvppEJ80NI5rAqaJwZDz4yPRYbbV4tmY3d92embWSCdqoNB4Oru8fzpEZpcy9Tmuq2JRnfQ8wh5yxvTuO243EcSzL1hC3sIl112hx2LcvTI07X3Vhrim7b00bWnpExk1r3js5NpufAY4KIkRvKyzOQ40WPyUu5rP4VHRPG1Xvp8sUO6E8DE/CkT8sakDSmj79vkV3hzgw8v79wg3CyafeW0j/FTjzhmGaSl53ZnOCK6bD9XtS9sR9YfBxYUOejn4FcPkrcDpmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39840400004)(346002)(366004)(136003)(376002)(451199021)(38100700002)(31696002)(86362001)(36756003)(6512007)(966005)(478600001)(6486002)(6666004)(2616005)(53546011)(107886003)(186003)(26005)(8676002)(8936002)(6506007)(44832011)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(6916009)(41300700001)(31686004)(316002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzN4aU9KdTE3eHBYaWFDelBrR1lodmtTVW9XbFlwT3R2eGFMcU50Qkhaakd1?=
 =?utf-8?B?T0UzUmlyZ014L3RzWjBjUTM0QnUzN0dTOVdxZ0wxQVZhbTV2b2tUc2hnbUJD?=
 =?utf-8?B?cHZIckI1RW1KNUt5NlA1dERkRWM2SzQvamhsVnVSV2hFdkdVdkRNejVHVHli?=
 =?utf-8?B?QlZlcGcwaGJYdzhLTi83eE03VXIwV0RWSTlPS25tWTgrZzNEV1BTVm9kdko4?=
 =?utf-8?B?VkhGVFU1UTBOd09OQWRQakw1YndQa2RqM21kQnhTUGMwbGVRTDNvaWZhMnkw?=
 =?utf-8?B?M2gvdkZkbDZBYnZLRmVnUjZJNVAzQ004RWh6eWduaHRQdHdqSmE1ME1aUnJO?=
 =?utf-8?B?bW5SN09DQ0ZBM00veFBoMklVTUNxNE1uK0Vqc1ptVWQyVlp2NkREVldIaFlI?=
 =?utf-8?B?TEZtWHJzazNrdGFROWNMYUdLYWhtTDgwb1dlMUVISDc4M0Q5Rlg1dnBmeCtF?=
 =?utf-8?B?ajNKSmVTTzRGVndiVkkwMmdzL1poQWxmaHcyUDhJU3NiRXdpU3o0c1MxU0ZD?=
 =?utf-8?B?ckVMQjA3QlNzWVc0Q3ZSMEZ5b1Z1cllGb04vZ2tpenNud1RsMFpmbis2SlBB?=
 =?utf-8?B?TzEwUys3SVJRb1luU21ZZU5PbXFiTk51dnd1RCt1djBPZ29lVk5xSy9aeGRF?=
 =?utf-8?B?Tm1NTkk4VG0rZERIMlZ3eGloK0tPWGlKSnZhUWxjRDZKUDlFcjV0VnZ4S3JK?=
 =?utf-8?B?QjZUUy95UVgvTG9jVXoxZkE2VWcvKzRGOHFyMG1pNTFDN1Y2cmdhNTladXh2?=
 =?utf-8?B?NGhGWW1OejZNRWUyTDBRMTJNSkZJb0Yva1FtQVFLM1hpZjV3WmNUNlJWM1Jn?=
 =?utf-8?B?WTdkOVQ3SFB3eG9vQXBLYU50TnZTVnlRZWZFSEhuU0FpUG84ekM5bEU3R2lh?=
 =?utf-8?B?YjNhRXhaL3ZLTE1IdzdnM1pnTWtvaDhEVnBhbk9xWTRGdms2QWpUTUp0WnVy?=
 =?utf-8?B?SjFqaCtzYkt2ckNaRU9UNTBHZmNwU3dBTVFRZ1FIQ1V2SlNTaEx2aUcvSTAx?=
 =?utf-8?B?MkdtWHg0cGpwUDdoUlYzNnNGakFMYVdnL3BXcFZGS1NuMkZKazZBOFAyQ3d6?=
 =?utf-8?B?MElDR2FTdUNNN0VrRU5yY2kxbzBKa1RjejUxMEtkaWExdkltVEFrVnFiSlpz?=
 =?utf-8?B?TVhjcEJoZDhOdk1xdUJzY3dFOG1MMERtSVhuNUlHYXBrVFhpWjNCcFZrcFVh?=
 =?utf-8?B?NFVlcFZrSE1RY0lkWjZFb0JtUjVVdkgzanNacmVMRjRkRHZ1TU9BbG82aS9q?=
 =?utf-8?B?dnp0MFNFMU0rdXJpY0tuZTJoY1ppVHBoNmdhb3ovQURTS0xCT285Y2FWbVpk?=
 =?utf-8?B?dHVOYzVxWHV0YnlZNzkrZEZ4VFpteXlXNUk2andkZ2VlT1NMczlOQzNjN0FJ?=
 =?utf-8?B?OGdabHhVTVgvdElwOGFpYXpjNEdnMWpGVmw1RmI5cWVkaVVIOXJuQUNvWXNV?=
 =?utf-8?B?WFVJVFlxRXNWLzFUaGhzd1A1UnAycjRuTm5ZZTZRYUducitYWHZQVXkzUjVq?=
 =?utf-8?B?aDJzR2c5eThFN21lTzk4TFNjZlVaTHhpSU1xYklCNFlCOHl3b21xVzRrakV1?=
 =?utf-8?B?VDhvU0V4K0ZFTEVQc1U1S2hwVlpTZW9QRDliUFFzcFlURVZ4VmNDeEhqcm9q?=
 =?utf-8?B?cWhFaE1iSVpEYXFGMnh6dTRtV1R3eExUc3oyTGJnMFhJM0tkb3I4aEtlVnJk?=
 =?utf-8?B?VXdiLzlGQ0NPWEluOGp1aU1MelhYMlk2dHpDeWVpOWs5d1VZcDBNNjVUTURX?=
 =?utf-8?B?MWVzN0k1eDhMYzVKSGtqTkpibjJiZ0J6Y1dpRy9MTmtOeU8yY2FvcUdPNGxH?=
 =?utf-8?B?RWQ1S0swT0ZXczJ4VXhvcHpuWWFaeFVzS1l3ZjB2ZmR2UE1SUHBqaXRUeWMx?=
 =?utf-8?B?L2N6L2tDb3grYk1ldnl0V1djMGcxT2tBeitBWXllMk5uakJxV2tRSHk5NU5P?=
 =?utf-8?B?T1ViNU9tTHFPc2FiMDR6RWxtU0pGNm1vdlRvTG1EYXpNZUdTU3VoNFFSWHZK?=
 =?utf-8?B?T1lrL2ptQnowbk96MXhiYXd0c2tQOUdWbVRwQ3RJRkYzSEpoZmc1U3psM2g4?=
 =?utf-8?B?NFlxMWUwUXFKMlgxcWRmVy9Zdnc2bTRvOFIxZDdEVENCa1k1Uk9tM3hSNUsy?=
 =?utf-8?B?ZEt2VGNzYmxJZ1RlNmt6OG9NcXdIclRJTFN3ZXEyZGtBL0FNYmFFRFBjU3Bs?=
 =?utf-8?Q?0PSM6yKGL1f5oToh0oZDYV0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559249a2-4572-48c1-1a88-08db91d48bc6
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:43:46.8328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0d/AsYBnOKrTR8qGI9FLJB0imfPHTBCvN/AZuhNoE0QthVXg2znGjWEWfhUPpfaewnewNVmqF3Ai2XUoCif8/X60PS1+HngAaubKtF524w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8920
Received-SPF: pass client-ip=2a01:111:f400:fe02::721;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
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

On 7/24/23 16:10, Andrey Drobyshev wrote:
> On 7/6/23 19:30, Andrey Drobyshev wrote:
>> v1 --> v2:
>>   * Add vmdk format to the 1st commit.  Tweak commit message accordingly;
>>   * Make "compressed" field in MapEntry optional.
>>
>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00184.html
>>
>> Andrey Drobyshev (3):
>>   block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
>>   qemu-img: map: report compressed data blocks
>>   qemu-iotests: update expected tests output to contain "compressed"
>>     field
>>
>>  block/qcow.c                                  |   5 +-
>>  block/qcow2.c                                 |   3 +
>>  block/vmdk.c                                  |   2 +
>>  include/block/block-common.h                  |   3 +
>>  qapi/block-core.json                          |   7 +-
>>  qemu-img.c                                    |  16 +-
>>  tests/qemu-iotests/122.out                    |  84 ++++----
>>  tests/qemu-iotests/154.out                    | 194 +++++++++---------
>>  tests/qemu-iotests/179.out                    | 178 ++++++++--------
>>  tests/qemu-iotests/244.out                    |  24 +--
>>  tests/qemu-iotests/252.out                    |  10 +-
>>  tests/qemu-iotests/274.out                    |  48 ++---
>>  .../tests/nbd-qemu-allocation.out             |   6 +-
>>  13 files changed, 302 insertions(+), 278 deletions(-)
>>
> 
> Ping

Yet another ping

