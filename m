Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A97CA1B2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJ23-0000nb-Ck; Mon, 16 Oct 2023 04:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qsJ1x-0000mP-Jq; Mon, 16 Oct 2023 04:32:53 -0400
Received: from mail-vi1eur05on20710.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::710]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qsJ1u-000789-1r; Mon, 16 Oct 2023 04:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd8gbfy4ydIcptdymlWWJY+Iic4BN1tJQllpagFzRkDvQMjHkhDB/g4Or6Qe5+kOMxr6vGKx2G/yNMBGL9OrU0JhrXvOC9PUds84W/84OCfhRwO+iLpUJSuZ+mZtpTi5Rj7eSxA4/tCsiKQibblaURa+FDDqGTPLPYdRRDh0+Dt2QQXUTfrCwzkWXbdtsXneDsXN+jNnEJGn42yOi4tCbV+0dpy2oW+Y/2gEipa/NZaEowVl6BRZtfl0wKgck9QmtGDlm8+TWur6Fc+No3z7TvxfpJUKYDBRI26aZ6RjGRuD7d9AofIT2/NA+uLTWqVyb+mWu+HC3AkQIcrDmHdmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fklOHuMU1BW5k5Rm0l7Dd/AM0kVpf3KEMJMBSV8JUm0=;
 b=EyUoKxWhLo1zLe73ZQsKBPiTWDxLkYkdQmLuOR0zpVbL8/Bb3UDxhwmdpIo0CrcPs2IAg3E3crciJi8lUEgVo71267ZbF5iH2v0cdzNKFiOoCVm/VojGfEuMe9jDtR70A0PWVRyRTU/Fq5LgliIO4UvJasjLUVncVCF+C4fhyBsXyjWt9o3Wb+IoB4j1BsgWvACqvqox2MG5FUZBMHIx1qBNRo1s5vkFmR2F7FFbU1avFhSPtlbhzQk1LO9X1JI7BA1ixrf7ZbFYUJzkv2AajbqAkY8oNmOwDKujY81/uo/vOvB0M0IO2t1JsTBXpQ9E3KpzHogJF/ZwhlsScuZLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fklOHuMU1BW5k5Rm0l7Dd/AM0kVpf3KEMJMBSV8JUm0=;
 b=EAuzuayIxkrQDKigy8mGDunP0QIZzMkGPJSJUY26JqeNaIP7C6P8OpqrBhFNL+bCWY8PWYcl3ff8UEEix5ifx3LAGKxKr/I96l5Ff/8cURQq37/L0I+T07TUUqLuJZXX31THaY2fwY8EsZG4zUZ6KkqEMAYiBgc4WuCR6blWnGDv6iKu4vAXqmWB7V8z5C6wy3q+UmMQ3POhhpcCU4EyLOPtOIL5344QcDeUAO1dQjJR/qr1BvQzCcZkgoU8ntTcfK68D8JYzGZVkbVF2t5/NNo1eu1c2VD801CeeghjUymtlgH9EoC6up39jy57sMEH4Bp5mjEvADvd5YszHrWlaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by DB9PR08MB9492.eurprd08.prod.outlook.com (2603:10a6:10:459::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:32:42 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6886.034; Mon, 16 Oct
 2023 08:32:41 +0000
Message-ID: <241c742e-4fc4-4005-984f-d5bdf6c38033@virtuozzo.com>
Date: Mon, 16 Oct 2023 11:34:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] qemu-img: rebase: add compression support
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
 <fd716469-6aed-49de-a736-452e713eb1cd@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <fd716469-6aed-49de-a736-452e713eb1cd@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|DB9PR08MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a39c240-4e96-455a-28f0-08dbce2275b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1axf7xFhIy9kC18+I3EElxi9NZ/hHoseKB2TQT/+GfeExvifS//61Mp3Cyd7x89NYsygeiUldr+AdDus2Bi6xIzOlOEn8em3sFayq9wgPPl4QiaENhWs1QwtN6nYzlhU9iFQYEyijDOt+7UXglTRuN3ZkRYRFSO4SaOATzbmea3MkA/7plc/k+tkczmZqW9II8pUYSStEcj8Kd+uVMmzf/HgtSVKrrXtblUU9EI95vrTT+03q5pC4c04PtI0bybWmmgz9+I2N5Ten7zL+SblGRm6u+PqAESFSZ9WBBJl/UkJTB5DC5IITJx3nDbQXoiOpfw21PfMo24e68sYVlpfywpj2Fr8/31IuHXKiUU5/5JQUeIGgFduV0JitD/ivonAPftEU7/HswkcLIn3LCOBmVDDrtH9LbEkc8LLuwh0KzDL3x8QfDu8VaxlJUkxiMhAvYhQRsxocAwjOZ5sy3/GX43z6AZZGXzhnlY01sWWzvGV410YP/yOaqRx9oO/TVAx6N6vEm2kLur+tswviyzYIEswulje/83Z7en+eSh4F44+UmwY2kpcWcuwcm/1+cMOszbSLoX+UWe7atmPMjANPGA5Zy0eATVI/nH1ph9hEhXihc3RFBYZ7UqIb+Q5UNTgRZSdsTL0Ofa8qrCCyE99w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39840400004)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(966005)(6486002)(478600001)(6916009)(316002)(66556008)(41300700001)(31686004)(8676002)(8936002)(4326008)(66946007)(66476007)(44832011)(5660300002)(6506007)(53546011)(31696002)(38100700002)(86362001)(6512007)(107886003)(2616005)(26005)(36756003)(83380400001)(6666004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhHaENla2xmQ3hxejRFaGp0dDM2cy9UMHQ3TWRPdCtIdEVVd05VWHRLeWtN?=
 =?utf-8?B?ekt5MDFTSWk4eUVIa0M0NGR1Yzg0Mnlvb3ErQlVVZjNQTjNEY2lQZUIrRmNM?=
 =?utf-8?B?eFFkeTBsQWlKR0tYMWpkL0gyMGNyTFROTmtjTDF2Wnl3UExSTjRxL0JoUXVH?=
 =?utf-8?B?VlVpU0EydkUvdmtNUk1Wazl1SDNkUTNzT1QzQnBydVcvNlpGUXRNUWMvZm9F?=
 =?utf-8?B?VG1DRkpNY05vTmVVWkVOYWhIZEFhQ0hDcGhGbVBEeklSZWdzM3dNSDRSbVo4?=
 =?utf-8?B?VmdibEkzK1krR2g2YmJnc21od2s4UWIyR0xUK1NBbEZJQUFxLzBxWmJ1dVRo?=
 =?utf-8?B?RlRvSkQxYWhUOFJRZVE4cktQM3NMRUFDaXhTbXMxVFU5ODZzNDNKM0VUU1I3?=
 =?utf-8?B?U0V5dUZYUmwwdmRkSHkxQUtYMVhPQVVtR1V6Zm9uRTBtV3kzcm9IVVoxdDBa?=
 =?utf-8?B?a2VTa3JYM0Y3TEhaNWpIdkJKYnZtUXJlUHFhTkFLM2RnTWQ1Qi9wWHVTZFFF?=
 =?utf-8?B?NG40OFUwMzhLSTZ2U3NmdGV5V05OendSY2s5Ym9oRkNYYlZjQ090UTZwL3Vq?=
 =?utf-8?B?VGJCQk1MRXZJVVp0UFFNYnFrMkE5NVh3VjJrdDFaQTFWMkhYdkFJb2FkU0RY?=
 =?utf-8?B?NWk5WStBbzZQRzZQMXpSMVJDYkpCOEV1SmFpamk4UFlobEN2bTBxa2ZsVXZz?=
 =?utf-8?B?dS9JRVpCayt3d1ZSRTJZR1lMVEUrMW1CaEo5WjhMdkRTVzJKWUpBQnRRT2k5?=
 =?utf-8?B?MEdvUTZKWVVpZVU4T3FhdDJwbFpRaFY0Rm9URVk0TXRBTUFaRkpIU3FxSFlH?=
 =?utf-8?B?Tk15Q1lmKzdVWmhHRTNoUG5rUklYVUhVNXhycFA3WXJ6clV2UzA3Q3NqSWZk?=
 =?utf-8?B?cVQ1bnpRQ0NrMXlMbGpxS0MrZWxIRTczYzVpdzI2WmorU0FmTXMyWjFhQkVL?=
 =?utf-8?B?YjdvcUsra0ZvTGJsQmRzY2haVlowOUxVMkVvaDV2OTZhYWh4MklON243Qmd0?=
 =?utf-8?B?SEZzb1VJM2E4d3FkZ0xtdnpPZ1doSXJzY1ZtUlVGemNZbHAvakxZdjhLMWl6?=
 =?utf-8?B?Sm13UUcwOUFzaGZTTjFGOWVqOTdDTTFaUE5KMU5ia2gxcWRiVS92ZG9uQXZi?=
 =?utf-8?B?Y1IwSWFKRGYwYVFMQ05ObWUvd0UwcDZ2YmFtTHJPVmlyVDYvMGdzbXQ0aUQw?=
 =?utf-8?B?Q2JhdURVMEFEbG1BOFo0ZnJBUlRsZnR6MXcrczdpUXRUN0hqQ00yY2ZSSCtU?=
 =?utf-8?B?MTdlTnNkOUZ2RHJaUlpXOTY3SS9xUmNmS0F4QVpCNzE1NlhiZzNldG9UbGVj?=
 =?utf-8?B?dEFlWjV2b1JWcWFmQnQ1ZkgxQ1N5WitpS1VsWGVYb08vU0w5czh6ZEtDbmJS?=
 =?utf-8?B?anVEZkJXVU5PaHF2QnBYWWkwWk1Cbi9sbE54dFVJNzJpTXE2TDdsQ01KK0NG?=
 =?utf-8?B?d0ZRSG8rSldjSDNLR2F5Q2FtUitiWkZEUUtpOWx0N3ZuNHVpVEVjd1pOY1Zi?=
 =?utf-8?B?TFBqNjc2ZUE3aURqWkVwZG9qa0E2ZUtEckx5NUpPVGdDeklseEc3MDBsM0tk?=
 =?utf-8?B?M1h5OWhsdlJOV21jVFVJVGVKWHNtZW1xQTVCazdGaVE2cWppY0ZqVVVtWFlu?=
 =?utf-8?B?MzZDaitqYjNBK2hWaFVpbmJzS2h4a3p1VzVodFI5TWd6YU8zRVZFei9ydlpz?=
 =?utf-8?B?cmxJKzM4Q09WOVdUaUhTa3ppNHJaZ0RKbjFGWWJURzZkc2duK0YwS0dBc0o1?=
 =?utf-8?B?UnJVMDJIMVFHTmE3WWFEZlg2QU03bUVTTS9heU5JaEgxNkdwdmk2UTVpMjhW?=
 =?utf-8?B?eHVJY0dScnloMVlKb1RJa3hobUZaM0o0STFBVG9DeXI5TXRzb1BsNTgybmg2?=
 =?utf-8?B?c2g3T1hESGxHMFRLMjljeEVqVTR2c1N6VkFxeUdQZEFDcXdnTllmOFprTzRL?=
 =?utf-8?B?RUkzQnhGSUhBUzk2NVFyRURTL0VQSWlzN0xqaGZtVnNsTjNUcTBDZ1lXZ0tt?=
 =?utf-8?B?ODF0ODA2QzNmcVFSZW1NY1dMamF0cHY4Z2hTaXVuNmliNjVscFNqeHJBdEdl?=
 =?utf-8?B?alh6bEFmam5jYWJxSmZmZGpmV0VjdHNxOVpNaS9LdlU1WUFSU2djb0w0RzNN?=
 =?utf-8?B?S2VqNlR6ajNLQ2JKQzVIT3ZLRGZRbzM3b1NubGlsdVYwWkZaVXVtakFaMXRq?=
 =?utf-8?Q?Z54Kbgx1XSlS1Q2FoWfUk3s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a39c240-4e96-455a-28f0-08dbce2275b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 08:32:41.3206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2uNZcoX5tVOmIjLAR7bbZAOZk87mrhi/WATy8BpgyjRtndKH2iNtHXM3OEP9rXTB5Eyfr19OmAbhie9Dqfb8I1VAhR0pY79V1BinEwbbaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9492
Received-SPF: pass client-ip=2a01:111:f400:7d00::710;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 10/2/23 09:35, Andrey Drobyshev wrote:
> On 9/19/23 20:57, Andrey Drobyshev wrote:
>> v2 --> v3:
>>  * Patch 3/8: fixed logic in the if statement, so that we align on blk
>>    when blk_old_backing == NULL;
>>  * Patch 4/8: comment fix;
>>  * Patch 5/8: comment fix; dropped redundant "if (blk_new_backing)"
>>    statements.
>>
>> v2: https://lists.nongnu.org/archive/html/qemu-block/2023-09/msg00448.html
>>
>> Andrey Drobyshev (8):
>>   qemu-img: rebase: stop when reaching EOF of old backing file
>>   qemu-iotests: 024: add rebasing test case for overlay_size >
>>     backing_size
>>   qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>>   qemu-img: add chunk size parameter to compare_buffers()
>>   qemu-img: rebase: avoid unnecessary COW operations
>>   iotests/{024, 271}: add testcases for qemu-img rebase
>>   qemu-img: add compression option to rebase subcommand
>>   iotests: add tests for "qemu-img rebase" with compression
>>
>>  docs/tools/qemu-img.rst    |   6 +-
>>  qemu-img-cmds.hx           |   4 +-
>>  qemu-img.c                 | 136 ++++++++++++++++++++++--------
>>  tests/qemu-iotests/024     | 117 ++++++++++++++++++++++++++
>>  tests/qemu-iotests/024.out |  73 ++++++++++++++++
>>  tests/qemu-iotests/271     | 131 +++++++++++++++++++++++++++++
>>  tests/qemu-iotests/271.out |  82 ++++++++++++++++++
>>  tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/314.out |  75 +++++++++++++++++
>>  9 files changed, 752 insertions(+), 37 deletions(-)
>>  create mode 100755 tests/qemu-iotests/314
>>  create mode 100644 tests/qemu-iotests/314.out
>>
> 
> Ping

Friendly ping

