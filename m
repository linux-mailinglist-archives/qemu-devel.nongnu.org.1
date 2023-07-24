Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1075F7EC
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:13:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvKd-0000ne-Au; Mon, 24 Jul 2023 09:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qNvKL-00009z-4m; Mon, 24 Jul 2023 09:10:17 -0400
Received: from mail-am6eur05on2071f.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71f]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qNvKG-0003OA-BQ; Mon, 24 Jul 2023 09:10:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1M1CliohS7gfduLia/SN06XTJTbADjh//XV5CTdorcM/7j0hCXUTaRbufsq7xTGo9TMY2BHFcDS9C20QapvERtOl7pglqbs+4JJYLr5kj3IesUOl679kZQ4+VqNtjmhoc082fDulJdTmCv6zUMbknVnNRTqx9JFlGs2uEap81pNsXCJt4snwZhJ84jmw0G1/SiH7EfOdovUrumTMvhFK7pss+aSlL17j7jRELH5/yVh/JUqy+UpWgDi2htiy/J3lO2Ga4ar8grSRNW0jvduJnDKtU0cx9jtu5FKnMt6w+cOlyIBcbTydSu0VBCVCHVPBuCaCcSGFRanvIOP1GXg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy6vWhoOciSE+EJhBVgBHr9PAkocrO77stCH7agrrGg=;
 b=HA7/aI+e8ZiL+xHpFMuPjnMVXwDLW8ZRPZUGiQi40CkTS+u4Ghz5mLxacLMfZkl3/HbvKFyvb7tngMwDNLjxrTsbeWlZukb8J7SMd42sjlU44be/iei1DEQTUfOvv9TSR8HUAfd/+akl0uLEnQmUifgs1WPlbGHfGHLDFzw4LG91BgGa/XQ3UsuKlwhYexP5HngvGa6tJZqIc0m6ij2cm4GVZTbgCDFo5RhVbM3Vw7iuLGDZiOYD2fkQT6YSu1XngaxOLic0AutDQZHfAMqceLRIMnliC2jBEixbeqSdNIvsFapIzoyC9YMGCHZza3SyoMWBpiukObQG0aKF/gtGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy6vWhoOciSE+EJhBVgBHr9PAkocrO77stCH7agrrGg=;
 b=GBJv4dgO1HVEUTxprfcrAph15RjBMCYr2aabPABNxfc3/NG9nqr7fqlGlLUMHDEtUI9WyiR5meOnLEqGNyv9BDDput5TE0Qq6WeffXidRBnti5QpjQ9TWGTv9yvk6VoBt/p8YXu98sswCE1Rxavet4IOxGe3YG0ieA8vXlVo6sZbGD/UW+3KfQAEQS4APLdQduvVAXw7mvE+JQQZtzvNCmqlVIg+O68LtezXAxneaw50Kbm6whj3gG8Q98l2mM3S8PtZ4bqkG1BzeXpWogXVKRpTldII7aF+luPgIhK1zpQr4HIHgIk9CxkK3eWV65yIks1S9wxXdPBniIeTfOXKJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PR3PR08MB5660.eurprd08.prod.outlook.com (2603:10a6:102:8d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:10:08 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681%4]) with mapi id 15.20.6609.025; Mon, 24 Jul 2023
 13:10:08 +0000
Message-ID: <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
Date: Mon, 24 Jul 2023 16:11:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Content-Language: en-US
To: qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PR3PR08MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3a4100-7fa2-47c9-ee16-08db8c474e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgHk9TwnuwGx7x/BAINI+Orv0cQjJcBeF4BiwbUvALLils58vKnVFEwYL9wfu+1EnrY+iWmnr2u6QDZ54fuq/Q9jyNvGR/XJicd2BWaXeJ5baNgYaDkoHNjk8km00a8koNLRp+o+5UairPGq/942YGhTWad5WtPBQ79Z9i8xt8NJMih3qQt43Y+9huN5GbJRtwELS6AOWHPZ6n38JN5g5ln5T0GrGFWJNideCKX09qsYVnXZSnA8kisP86VEvQq7F5fQcY1sIk6CCIJvdjvL2YxEcrWuyA4n2H9COur7T7Q9RcAf7Scc80Tl7rMuON70QbD9G5LvZemqUJcHD9W/mkoyqB9R+2YS1mZedp277pL2NaZuIzjfGaVjRvYVwx2jXGS/0eSXTRKjP2B+3bJXoXrA8N24eLxTEvi3BpRuTq4GRIAZeT262/UZwzZV5rCErnEHZ2Xk0gnnX8bY8Zs8EXnCVdEl9k9+lDMYn+sRz02AwJ7pmTt55lItJavOPFnmiFZ2ez5DdtMhyfXOF4HpLAhgt9D59YQRRL6sGFQF3/X1k4/qsXEGo7bmFkIFBMRQdnkZZtnT39mal5HEihEIo+dCR7xwXU9QF6Og9+ESydqRvMSHtrY/gQDkmH9IYT0j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(451199021)(38100700002)(36756003)(53546011)(2616005)(107886003)(83380400001)(8676002)(8936002)(5660300002)(44832011)(478600001)(4326008)(66556008)(66476007)(316002)(66946007)(41300700001)(26005)(186003)(6506007)(966005)(6512007)(6486002)(6666004)(4744005)(2906002)(31696002)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2RQY1ZJeVY1N0hZVURveEMyUWEyajVjMzZTNDVFaGYrd3FYYkpjWmdMTFdE?=
 =?utf-8?B?dnhiaTdMeW0wRHgrVkVRUUFNVzV6TWg3eTVrQjJYTk5LYmxaUkV6L0loRHFF?=
 =?utf-8?B?eFVORmkyeVNSKytzMjdLTThCc043aktPZ2s0ckhwZk4vL0plN0hxa0d0MUYy?=
 =?utf-8?B?Mm5CRG84dkJ6ZmdodzVDT2MzRmxRdnkwQVVyOXJiZEEzRTVGV3FhUnNiNVFo?=
 =?utf-8?B?YURLWHMrS04rczkweFlyZ05leGJsUFNVclpDZzJYalE2N1NIaUVtZjY4WWpC?=
 =?utf-8?B?UTB3N3JkUWhBR2RuUE1xa3RJbW9YMHNnTXgvWThuZ0dGQk5ib1NzT0Z3WlZk?=
 =?utf-8?B?Yk0ySzdQcmMxWnBLNUk1RnJTTWpJUEJMUEpXTkNXdFE3VTcyQURVMVlUZVVT?=
 =?utf-8?B?NWpEcFVjRWlDZnp2VWN3TjYxYmhOUDMwY1BEUkxRNWJnVkJHRm1SanlLbXJC?=
 =?utf-8?B?SWszTUFrWnh3dk1LYVE4bnk1eEJtYkI1QWx5NzVXRTZSN3F5KzNiQnN1TCtm?=
 =?utf-8?B?SUxJUkcvUUFHK2xHeHFRcDVZbFhOazFpVXgybFlkOHROdms1YVB3TnVoY1Zu?=
 =?utf-8?B?dWdiLy8rSktYNUZDaFArcVBmMURJY0FDdzhmaDQ5Sm1oZDJvSEpCS2xlYWpJ?=
 =?utf-8?B?VGQvM0NXVDZmSFF2RGlYOVo4aGRXRDA0ZVpnRW42V2RZcWJYdHVZR1l6QkN5?=
 =?utf-8?B?S09KUFJ0VmZqUEhRMVMzdk52SDl4QU9palZmUXk1QU40dTZOUmRqVEFuQjkr?=
 =?utf-8?B?bzhsLzIzS3hTVkRsdUhMaWxOQlNVSWZubHhWR1piQzVSQ1hwemtaSnYvanJa?=
 =?utf-8?B?YmhqUkJNd1ZmaHZCMGxld3ZjQWRJZjRxd2IxWXgzWXNLT3JiRGlkU3RkWGxq?=
 =?utf-8?B?eHZ5QWdRSXA2bTZaVmFYUVFJNzBpdk5RL0hudElSS0hmckhIblV2UVU2bXpw?=
 =?utf-8?B?WW1BQkt3RzF3NUVYdWJsRzZHY0JNQ3BmczFCeDRYMWxBVXQrTkcrNUlEdmkv?=
 =?utf-8?B?NjNld1p4UUpNaFlSWk4vem03dU4xeDJKSDZSSEc1WHhzQjFVbVpDbmZUa3Zu?=
 =?utf-8?B?U2xTZ1RYeGgwaVc5RmV1OGhlZThUMmRMWWdOV3hQTDZuSVYwQStFQTgvVytD?=
 =?utf-8?B?SGFQeU0ybHRTbEtOdXZCd2d6OURDaXgwT2pPRE5BNDZJTFNTcFF5eDBVYUhn?=
 =?utf-8?B?L0lxZytTeXUxTDhUOEZiYXF2ZGF2NzFjZVB2ZUFzWjY5SXI2SzBnajdRSGxu?=
 =?utf-8?B?OGdhZ0pWRnZtTVRReWErWWMwTUZ3b2RycHAxaG1NTG1lc0hHTnh3OHoyQUc3?=
 =?utf-8?B?anFPZ1paQ0JjdFNhS0Y4WW93d3hremUwU01OMVNNR0NTUGZtQVpETFVHaDZl?=
 =?utf-8?B?ZzNLOEFxK3pGYmMxSWRFQ1JYSFMvaEpoamorSFBRSFk5UXU1cVZ6b3puUHl1?=
 =?utf-8?B?ejFmWksrR2trcFlWY1ppeXk4a1hwQ01qMDdpNHRhdlFVaU96MU91UU9lemZ4?=
 =?utf-8?B?Q3MxRzhpbU5iRTJyWWV3b2Vpb1hEU1RvK0JlOXBjYlRQRm1LUHJrUllqOEF1?=
 =?utf-8?B?Wm5melB3Q1lWdDhNTGcwUzRZYmx0QTVxSXphRE5hVVZ3Q1Y4SmYzbGt1aFlC?=
 =?utf-8?B?aDdMbCtBRm9qQVRhQmsvL1BkWUM2MjljSWFlU003SE8rNGNEWDVNdFg2R0VX?=
 =?utf-8?B?K0ZmYUdhSjI2WitCL1FWY0pnRXdlS24yM0NqVGQrc0FyR1BacGJUcEtrWHhB?=
 =?utf-8?B?OVZaV0tXY2RkdTduQW95OXNZWFpISlVlenhKaDQ1Rm9ZOFlud0hoZjhBSG1y?=
 =?utf-8?B?RjRPVFhOSjBCMHRlRVhxL3orb3FKTWxIVlVFV0hTV3U3K3JiaXBDUWNEckJ0?=
 =?utf-8?B?ajJOM2QxWDVtMzQ1bTYxVzdvZUJQcWM1SWw4MkhBckhhc1h6THNPb3QzSXBn?=
 =?utf-8?B?c2xrMGhIK2N6WjB3V0pmWUFIeUV0T29WNHkxSnBWc2xJWTFiTVIrMjlFU1No?=
 =?utf-8?B?U1BZQktkbS83Y2xrNUZLbHMvckxUWWFkOHk1dWxrcWJ6T3dVSlp6bytPK3BJ?=
 =?utf-8?B?ZDhveTNzZTZBSDlQNXBDVkpOR3JPcDIxL1pMZWVDSzBUV0MxRWZPKzczNUxE?=
 =?utf-8?B?WFpJbGtzUGt5aFFyV3k5Snd2YTljNG5ZSHZ5NmRHajJsWmZWZkJ1R2dVWkZC?=
 =?utf-8?Q?2SHt/3QHMnB+xb1MQYQ5Xgw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3a4100-7fa2-47c9-ee16-08db8c474e0f
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:10:08.4447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn4Vw/EFmqPFztU3BX5DP6Q9ctvgjxr9A2WXHnq2lxo++/sNrU9sV3PjmXodEOikt3wbXDf4lDGX9OOHVdoCmD6IQVBHhSqZ+VzBsF6/uTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5660
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71f;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 7/11/23 20:25, Andrey Drobyshev wrote:
> v1 --> v2:
>  * Fixed line indentation;
>  * Fixed wording in a comment;
>  * Added R-b.
> 
> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
> 
> Andrey Drobyshev (3):
>   block: add subcluster_size field to BlockDriverInfo
>   block/io: align requests to subcluster_size
>   tests/qemu-iotests/197: add testcase for CoR with subclusters
> 
>  block.c                      |  7 +++++
>  block/io.c                   | 50 ++++++++++++++++++------------------
>  block/mirror.c               |  8 +++---
>  block/qcow2.c                |  1 +
>  include/block/block-common.h |  5 ++++
>  include/block/block-io.h     |  8 +++---
>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>  8 files changed, 99 insertions(+), 33 deletions(-)
> 

Ping

