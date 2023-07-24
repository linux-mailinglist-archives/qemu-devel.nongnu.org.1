Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C175F7EF
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvKf-00014W-KX; Mon, 24 Jul 2023 09:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qNvKW-0000QI-OI; Mon, 24 Jul 2023 09:10:29 -0400
Received: from mail-db8eur05on20709.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::709]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qNvKP-0003Wa-10; Mon, 24 Jul 2023 09:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZjoBqG3CDflT7as/PkXG5NUEMv90rIU2j+1IyTXp1usg/Mg0Z+IoEJoe2oTfugQ+IqyJ34+/HVhXqRmS4N/891Ekg40PyiKxNAQ9QY30JgklMGtthqq+8ujiSTq1ZPVzpJgM4Uw940ot9SITGo4ERNI5t9pFF0dQVGIzzYaSgNZouz8pMVQSybtPffbkT0HP/tioaCsuFt9UPJVUtfs1hS51qA/F+mKhUtjgQsBTBY2+G1uAeUVxi3G+9xI7vpTlxSbXM92CsyYj7gjU3nj/T9d1JlIF+3tKlJJ9UVRYr1/V4huwLRC8lj/az5FvD/t/eJGibmdK1pL69XXMurjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaMKJluEjLvO6LsDoO3PsE4IQHBXDglq3Jr1aDVudc4=;
 b=RPR8ABBiPDe3DTSPeRzloGyVPEBH51qT+ur2QYmbwhFw1z+nEp8JgYEoJrhyc9gcABZW8MgvaPbtRpGXPu8Zc85/3ZNqMtopl/T4t/4z3ZlmHDuL/AHYeH7PWQ/OLkhBu4Asf6cwBnvE4Ylq/QQC/Mxcj6c47RyWrVYOGj+xZClRgt3V8Tov6b9L2M0rN2mYm5XNpBT8LTxjFCpzcioOZaWAUnAjfpxJ8Nk8THXt2Kcg0rMXyAOqa3+ZvLBEo0qX0RIGOAQZNo9OuSPFOdRWEtsA47qVZTgZIAgLqQtOEQPOQ0K6EcON0JDXCdOxF1BdxKJANRSxx5IRPN/PtNlGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaMKJluEjLvO6LsDoO3PsE4IQHBXDglq3Jr1aDVudc4=;
 b=ildTuFvvyanZ4lyGWrlKZ10zWMyQUgG7xorJ1KpPFbge3fH+YMi/XppAllJsXJpugBbOn3ukKRyh9QQJa0nGhtMdqpbm3RbQKh6RTI2rdJ7gZCu9A2wZtQhuysPxYMgTLWwC6kOsCG5Q3+sJ8CrLjqz3kuPZsFfIdMR9Ln8LbIPWJfVeuVu9zYAGY6q7OfH3qdwVTcKbBGIgV5aJea3BSjD5UQiJc407aUna+FEHw5X32W2SsdA9b7/TQ+xx+oRLHs8hRtGPNsDhKZaSjIkAx0hI2AiyPjeAy46/bbMxc9+7Z7i98E6CnMNpxmxt5w0tyRL/5TBwHaR1XbBHyqZV8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAVPR08MB9436.eurprd08.prod.outlook.com (2603:10a6:102:316::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:10:17 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681%4]) with mapi id 15.20.6609.025; Mon, 24 Jul 2023
 13:10:16 +0000
Message-ID: <8c93905f-2c51-354f-e08a-e9670d3f5cfc@virtuozzo.com>
Date: Mon, 24 Jul 2023 16:11:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] qemu-img: rebase: add compression support
Content-Language: en-US
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mjt@tls.msk.ru, vsementsov@yandex-team.ru, "Denis V. Lunev"
 <den@virtuozzo.com>
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAVPR08MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: c65ce50b-0129-4a53-23ee-08db8c475310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObZb2x4ic39ptkUx1CVDC3rGcOwX5wNDU/+5f9dlS+9KWULcVOuQiw0H1qqYs0kHXx1dI3vyR5MBOES5rItLfsQvCqUSSss2+LWnT2OTYfALVW1B6pCptlWQUlu647H+VONFmKjtq8BTdp53pWI2x6zBMjSX+dhY1hNVaDCur+socXj+IllVyWGyCqOak2WnyDA0m2V8n8mTgdlI6+3DlTzVEJA/r3GZDuQgjkqjiFrxGZanwTDGu3pRDADGQztMKbfsYnx5XAOiopBXzgNfEqGVmZoZEJeAYDUVZFR2fdNc3Nz1cTHyU3qcjPnqDAWwTC501Mu8mXlVmeeGkkk0nch55rys/UNPDboZ/FOvCdTbGc1PALEEwReVseDJdLZ5SkdoBHkEkoJysVuI8Bq8p3EbQMYH57pCNPvr5BBispLiNjETp8QCwOJpHFl9xJ0XwI8umMAGk6WziFEv0Qvpi3UEwafD2K8m/yWl84BbSe9z4T0ONy/+88UYMJSIe84mDaUyK3ZuUYzUTJ7X03ehC0A3SAONRozbCdEGDfN9psMhgjZHS4UsqSY5db5fitpmmfIFozBu2COB4cX2RXDWLiM7F6XseBfr+FXuGTCyYnqKcIGH0uo/oyeP8OsAfLJPDpeI947ETU9jkladhhCiRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(366004)(136003)(376002)(396003)(346002)(451199021)(83380400001)(38100700002)(36756003)(86362001)(31696002)(478600001)(2906002)(186003)(6506007)(26005)(6666004)(6512007)(6486002)(31686004)(5660300002)(44832011)(8936002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(6916009)(4326008)(53546011)(107886003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3NNSWJ4eTNxTm8yQ2xLYzhpaGxhZ1crRmQwUWl6MWhNdEdXbVJDMEprQTRi?=
 =?utf-8?B?ZXBLQXJkYWp0ejVqUVl1NGM1aFk5QnRMV2FCeXRxbmdXRFhFTDhvdytrVVBM?=
 =?utf-8?B?L3pqTjg3bGpjRGNPbTc3UWl3cEowNUhOa2xaOVRnN2VUN1pFMjNNWDZXS3o4?=
 =?utf-8?B?cFIzYU92U0pyZ3I2NlBCRmVOeWpOTlpWSE5WTktKOFpvS1JFaHY5UU1zTTFR?=
 =?utf-8?B?YVd3MjZieE1xS0NheEpCSkVkVm8rOGhKVDJmeXYybGQyWm1jOWQ2ZEtlazZy?=
 =?utf-8?B?anM2d0ZBRDFyeXZsa1RwaXp6OVlNc0pmc1lqN2tob00yKys3MHZhUFlYbnd3?=
 =?utf-8?B?NVJMYkttWGZlRkkxSTIvVVZpbkREeVlodFFqTmxIWkNYRkZCQWtEKytlZE41?=
 =?utf-8?B?N0RjTHJReVEwSU9DU1BnRDdqM1hUcW1OUkdxV25jb3VCTWhPaTVUazdpbjF5?=
 =?utf-8?B?UWpsM0FYbWJWVjVSUlAvYmhpbU5oSFVKU216bEtQbzdsOVBnNWxJaU53VUJ5?=
 =?utf-8?B?Q0J2OU9GNzlZRU9lTnc3ZmpXVUFpTEFYbk5ONXN5MERYRW93dCt3bXd2R3NW?=
 =?utf-8?B?K2d6MmYvRmhGbW9ZUFhkOXI3SmtDN3pyaWtKaGlLd2Y4ME81aDlNc2daMkpN?=
 =?utf-8?B?aTJjSTNsaktPZWl2MENIL2ZMaFUzN2hkZXNGVEZzTUpaYWE2Qk01em1zN3J0?=
 =?utf-8?B?WUhYRDQxRTk2ZCsvcEJjbWFpVHdvRXFZSzJzZyswdDlMcklIY1lQQ2krc0Vt?=
 =?utf-8?B?WWh2ajhIaFZCbHozdmNTWHVFS3Z6OEwyc1kxb3djY25Da0ZCQTMyK1I2bjhn?=
 =?utf-8?B?Y0N0TG9XS2luQ3VHVlE4b09ndzhpQjUzNzhFWWt5elFMc1h5YW9QTExnSmVp?=
 =?utf-8?B?WVVmMXRJK3EyektHanN3akZwbCtrcG5BN0FGRDJrdlY3TmQyZXlNZDNRZ1Jw?=
 =?utf-8?B?YXZ2U3Jaa21yUDlYTGtKZklFeElFbm45azFFL3M4ODVJR1lwK00rS2EyOStl?=
 =?utf-8?B?NzY3d2NXSE90RjF0ZmhiVEpPWEo1YXQvSTlRNnhQUm5BVHc1QWt1dXF0eHVO?=
 =?utf-8?B?R3hGQ3hMM2xST29DV3hpZmRBVjA3Y3J5ZXQ4dFBKZ0ZaWVlSRUphRTJOcFdH?=
 =?utf-8?B?Y3hNY1RhN0oxbm96V1JYOHA2aEtjdlBVQ2ZkM0ZyVExycGZ5d1FoeXNyU2RT?=
 =?utf-8?B?MU9JNkczU2hUUzRTRnJwWHduQlpUN1l0S0pWL0dGUVp2TnNKS1hYSkNKSXE2?=
 =?utf-8?B?akRrUmptRG5HNEtjWmdqVFhTZ09hRUZoRkZrSzlia2ExTkRCbU1hWVBmNUFH?=
 =?utf-8?B?UWgwVmQ5QndwZ1JLczVnREdEU2crT1lPOTAxUmlZRC85R2htQVV3YXZXWmht?=
 =?utf-8?B?QkZpZTRNTmpoOVV3K0NmUllhMGpCdTNXNk1nUXpEb2RIUlhHeDhieVZHb0V5?=
 =?utf-8?B?eURNRHJBaDVyaHZJZmcrdVVqbnA4bHdRNFV0S1pnekIySlB6Rkw3aFl5Y0tP?=
 =?utf-8?B?T2tzV3VZM0c1WWNidUY3akpmVWVkZmY0ZGRFTDMraGEwUFdBbHM1SSsrM2dJ?=
 =?utf-8?B?dUFVaVFhVmU3RnhMMUYvT0IxUVIxcm5vZm5EUzRaMnhIOEVVblpwZlRwQTJ2?=
 =?utf-8?B?aGFtNGlCbGtkQmZ5b05LeTZsSzg4Y1lGd3BvLzJ2c21MTWlFcTl5WGRHUnJT?=
 =?utf-8?B?SHpuL2kxNk04emJkUFVFYUx6NHVPNUxMQjBKR2x6S09RWXBsSFhCZk5UZTBx?=
 =?utf-8?B?UjgyRDl4YzhucURScmhxZ2VjdW1sRTM5eHV4dGdkMzBuOWVrbkU0NGFlYWkv?=
 =?utf-8?B?M2JZRkIvWEl5QjYxRmMvckdzVGZIUXk1cE9ydlErblQySlBRR0E2eDVFZkpj?=
 =?utf-8?B?Z2J5Z25xejcvZnl5YnArd0hYeEJsZzBvSjFXNUZGTDhYeHNleTc3MXVJVm9v?=
 =?utf-8?B?U29nT0UvRzB4V0o3eTRWV2gwcmpCSGNHT3dwYlJLd1ppS2dzZXdRSG5vS3RE?=
 =?utf-8?B?S0U2RzZhWDJYSzdDTncvUUhndkFabWdFNUVHdm5FalREaTgycVkxS0xxOU9V?=
 =?utf-8?B?cGEwblUzNmRXZTN4NWZITityUVN2eDVuaytLOUJ0ZG1sSldhSC9tM0s2blM2?=
 =?utf-8?B?MzRWMFprb2xKTmJzYkduVHdhbjZROXFMWlExK2xISmpBcjBUc1RaZTRFeDg2?=
 =?utf-8?Q?IQeBfQYI0YtU+ybbfn2RrLY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ce50b-0129-4a53-23ee-08db8c475310
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:10:16.8216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmwUW+I/lhHGmWKjaDfELHwXTsjOxWPUrHiC2PEHk5USFvckc50HxASZJ5dY81jCZNeA6TP6s8Pe4kuIGGIXWkZemEGJYb6OuF40oEnzDqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9436
Received-SPF: pass client-ip=2a01:111:f400:7e1a::709;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

Friendly ping after 7 weeks

