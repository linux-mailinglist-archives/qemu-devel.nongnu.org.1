Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB788743A06
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBlv-000305-HZ; Fri, 30 Jun 2023 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qFBlt-0002zP-1w; Fri, 30 Jun 2023 06:54:37 -0400
Received: from mail-vi1eur04on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::71a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qFBlq-0006Lh-Pp; Fri, 30 Jun 2023 06:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+hdHF8F4bkwJsfbuntZKXHR+R/Df0ShK+E8WfW2EyAHyWHsgQ1JEokJqsPkps6YlkfGHPunwIVK6VaCtRazZJi8DxafsL7Q/tv/5VYCmzOqhlBma/vMVJgyrKXDUazTB5QdQtB4R1vmcxEk9xn23UsJAY+EA97xkLKSkZdKCkh+SNgeno32hcVW6XssPVveLQPVOqPAgBEt9/t41BqYT0cWnRU68rm9JwrIger2VJE8c1zWVvlNtRoE3C4FjccY+iNAQv5vut95Kt89DgsYZmX6XRkIhD4kGTo+BZFq0l/topo5XzAgiQt6a2yal8tL64lKV7TcHxk9XV5U2T4nXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmBLDNY5Zh5bm4QOxqtFr7EIBnTiRInyUEDvvjORiPQ=;
 b=ejRO+w4KGRJGSLz8GHb2ZMP6btW3qevIDvAm/OA6VuCuYHmdEb4XJDLlrBJNtT9G980itQTNpAGTXFllgCep921yGgBFm5xU/Drq3DSOOVd5mEUlgbUV5gNeXKVib8OMFQjndFlmjeEN3b7g6gibQPEvoMbgEDGm+TEh43G6kwLjz2pUQYe7rNFTHXP2BiUSo2onWswcNWbk5t33yeqVNXXFC4rBLvmPKJ/EhF+nwVRfM77KoFYK5G4M/DhHDvbKcWxOX1CNH9JCKUKJTa8w8Metr+Yr7vl0tXm0e+MF6E4q1mQ22yJCiB1oh3CL58SunAsPxv2x2QOvRRqk+ABdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmBLDNY5Zh5bm4QOxqtFr7EIBnTiRInyUEDvvjORiPQ=;
 b=XNqBilphl9NZ4kRpnEnDfjbOMzyniI73UJGU0IoSeRAQNtDPfepP1lCmZN8Ol4r9HucS4Thf8TIjS5cozgCXQNlGNvfzThWwAO/rQyDDDv2ZPNDHc7yc+/8OdfF3jqfiKGgqenoa4xc+Q9KdF61HHqVOc9oytMK/yQT04M74YzeDR5z8wY5sY83OmW4/nhzVL4HB0iIxnb7ADW2EVg4YHV+WIDB0Ii1lz2dbiHAnmahZOmbwypxjA/vCuQPmRMIJWJLNX9KwqvwUkvPpZgkjrFHgJXjGlAifbH85LcpLC5BEt8cy8DTRpFmFNWWFfcMnuuKfANVZjL/oQ76nPpg8sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV2PR08MB8510.eurprd08.prod.outlook.com (2603:10a6:150:b1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 10:54:26 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 10:54:26 +0000
Message-ID: <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
Date: Fri, 30 Jun 2023 12:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] qemu-img: rebase: add compression support
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::27) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV2PR08MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4338fa-b120-481e-e1e8-08db79585ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwK1/Bg+zQiD+etFYZSn8kBUopuWlocYZ8ox+Sufe6bTq2khXAUDxtBfLgvtUP9eReK52VSP4oTFMlOlrG6MQY8mRETtK3BTBfL43lBR/Rlbm5d83IsuIJKFctDMFeA9UCvH0tKZxT6xZjjx592qQua+OYqNfdepMTLlijv2FRZZHwA1ooh1b5ZmFa6fFZMKYl/zotaVptIo5RNhtSVc2ZWXc94LGyD/EqIgExxhbsNOmF4C36zJuGNaCcK4NTUPzH9rH2IlPyTl+Q02KM3ULJBBW3pH8R577wT/v83Kv5MKmwpqQUnqtqa67aT7O1W7ClxO9h5I8yVqgXUqCLBzIfBMSnCXLzJq/6cl0rv4nxliJ+0u/XAFJIro5mtcIxGLmgoRmb2aE2LJxvc03VvhHUJTTYMKw0P3lJiintVewltHQTD5wEts36zNvnRZq201usFZJicAbk6uqHuXBzm1kQEXDpbfK5/5FiC/ze4/3um7O+Tq+BTw1wG7i1jDFEtbfTC6URKU9YwlIb/badAr5NwydNIx0dULt0gW9fijIIrcLtS2NQBttLhScTnGf01gK/Y7Bqg1cKMCC4spvXEN/39xCV4CgJHWPNqNDHnzoT/I5gA17US8/SsYBbVS8/8/GYIiAixsY8caHZf6BjP3Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(39850400004)(346002)(396003)(451199021)(31686004)(478600001)(6666004)(4326008)(2616005)(83380400001)(36756003)(31696002)(86362001)(2906002)(186003)(53546011)(6506007)(26005)(6512007)(6486002)(41300700001)(66556008)(66476007)(316002)(38100700002)(8676002)(66946007)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lDLzBoM2lWZlJjbDhZbGRUS2tLZzhONU0wZi8zSFdmWVpFaXJwbXdHNnpz?=
 =?utf-8?B?RlpEUTlNRUVNaW9WOXovd0h5V1hOUzRDM2NzMWJJZFEzWE1jZXFBcWJTZzRq?=
 =?utf-8?B?b3JTdTFyTWh4Zk0wYUN3a1VybFlWa3U5dXR6cjN3eXpqWmhRRXhZNDhiRUcz?=
 =?utf-8?B?b0RrYXd0anVhYWt4RmExYy9vaGZsMmh3QzVFelJGeEcwSDNZSU0yTHhrN29s?=
 =?utf-8?B?ZzNJWkRWTDhLVkpQRU5YdDJyek91ZzRnUlZ6V1ozL1JMRFlEM2NrWEtCTXhR?=
 =?utf-8?B?WGVoV1Y0L0JYNFlrZXNDOWhZZEN6OExTTmQ0UE1XVU5qTFh3Q0RwK3NHYktP?=
 =?utf-8?B?bEEyazkxQnFHeEVZVk9rWnVRb081WTAvNitJdWgzOTRyelg1MnkvcGNFdWRE?=
 =?utf-8?B?djdjNnJPbjkwMllsTnRQam1hMitoMU9IRjRrWksxOXFBZm5IRGw0ellBQjVi?=
 =?utf-8?B?TDJKY0IxUmtXMk5lWStyRU9WbWc2OGx6TjFET3hZUHNheDVpc1grSGtEZmZB?=
 =?utf-8?B?Sm9oZkMvNXpFNmF6L096QjljMDZKNjhpbVI5NzNOSStTZFhqcE80Slh1d3Z3?=
 =?utf-8?B?Ty9hNDV2REovdG1MM0lJOVZWVmtablR5R2srRWJOcUFVb1RQUEVaM0VJV0pQ?=
 =?utf-8?B?dXNyUnlsRlhqZDg0VVFIM0pWZ1M5VXZoTFZNNVJUSTIxMjlzMjNjamllcmhY?=
 =?utf-8?B?TlJLODVCVTZmOGtWMlJvUXc4aW1mVEpSUmJpeER2TGV0MnAraUhCbG9KL1RJ?=
 =?utf-8?B?ZkZXZkxicnpxNnVXOW14ZTF4RWMxRUNtQkJjckwrVHBBeDBpK010b1hDa2VQ?=
 =?utf-8?B?OUdiVk5nMXBjK01uazBBZGlyeXZtV1FoZ3hmUmJiRzZPcjZwQk5zSXBwVHl5?=
 =?utf-8?B?UStTWHVrWG5BeHJjQXd3NUhuMWc1ajJWbFBPQmxyUWlTVE41enhXY0xzVUJv?=
 =?utf-8?B?YkJxVUlFK3J1Wkg2QVZxdGFyQ1lvQVlPK3RXTEozdVB1SDhlMkJiOFJaOEhm?=
 =?utf-8?B?MldUa0VhcHVudGZwa1hRTzZkcVhFdmpOR1VjUjdYMkUzMHBNc2NqbmRDOVd1?=
 =?utf-8?B?SGJzK2hhbEx6SGVxMmtIUzBIQTY5Ukd5bmV2ZEZyUGhYR08wZ0haSS9aWS9J?=
 =?utf-8?B?RTAwSE1sU080ZTdXY0FBTG1ycUFVSDd2NlF1L0hxWmRQbGJlZ2huNUppU0lC?=
 =?utf-8?B?RG9GNFMxTklmUFhCdkRockFhckxMemg2OG5RNGEyQVdQSzViMk9UZ2xxVjZ0?=
 =?utf-8?B?VWJWaEJyRHltL3NBbnlJVkdsYnRHVjg2N1RJOXZRR2syeDdnbHE5TDVhUFg0?=
 =?utf-8?B?V3FpTVRNTUNpc1I5YkIxeE1DdFYremw3TjZ5N3pCU0JJdXRuMmphV0hCWURI?=
 =?utf-8?B?eXEvRHRhR2JUK2R3SHJUSlRQckhteWtTZENRSXk3UVIyTUpDV0M0UmtremZz?=
 =?utf-8?B?MkNxV2VmZlpLSGFWU1ZoY2hTTXpTWXNrZ3BleFVRSW9VbGJzelpGVmxmK0Mv?=
 =?utf-8?B?bGpRQ1lSVzBnWCtIOStzeG9OTGxyQ3F5emZjeGFCbzN6cVhIbVJIMmpDUmNE?=
 =?utf-8?B?eVlnUWd6QmpzdmpBVjFCMDN4Rzkvd0tNYlhqN3VvdS9QMEdHNWlIeDV0MjJ3?=
 =?utf-8?B?R0Y5cnorUCtZTjd3VXliNlVxMmYrckZKSHNybm1VZkFiNCtTVDBLTGo5N3Vq?=
 =?utf-8?B?NW1sMWthZzRPMnhzOEJqaGFMc0FiV015L0l2L0RHV3ZHYUtOTWkwMmZCcmR6?=
 =?utf-8?B?RXNBQnorOU4ySUtES1JSbTVTZjNXUEFGa2VTb2FNWDJvblp0d1FLRitxZjlp?=
 =?utf-8?B?VCs4bWpOSGdKcXkvUDFrQU40U3J6L0FJS2pZK0hZN2hhUTVlMnQrdjBFb1dh?=
 =?utf-8?B?Wk5ub3NjYUEvdFkzWmd4c2J1VGhReE05b1hZYUxwdCtvancrR3dSd3hXWEhh?=
 =?utf-8?B?M0ZjVlYzdW9RWWwxNUZXdmVVSzV6ZFJEbFFBcUlBTjJTdnY2RHhLVzFETHNt?=
 =?utf-8?B?bWQyc09Yd1lJZG9wZVFtbkJqS3hoNFp2Y1FhaXpyN2VrZ21KRzBqc0c1QTB3?=
 =?utf-8?B?MGN0eG9tWXQvc3pHZzdpQ3ltSGJSaXU3N01oYTdqNHl1UWN6UFlIandFOTlW?=
 =?utf-8?Q?pd2uoasenvxtlfmLNFkiQD7hR?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4338fa-b120-481e-e1e8-08db79585ef3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 10:54:26.1737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKvq6lRFxwyqEL3jepeuQKFmaE26KeiaCj5e7703jqBpydpI8hJkRA/DeRjwVLkUjKvWyVLz42ipPA93+vZLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8510
Received-SPF: pass client-ip=2a01:111:f400:fe0e::71a;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> This series is adding [-c | --compress] option to "qemu-img rebase"
> command, which might prove useful for saving some disk space when, for
> instance, manipulating chains of backup images.  Along the way I had to
> make a couple of minor improvements.
>
> The first 2 patches are a bug fix + corresponding test case.
> Patch 3 merely fixes wrong args used in allocation.
> Patch 4 makes write requests during rebase operation cluster_size-aligned,
> which seems to be beneficial for both non-compressed and compressed mode.
> The last 2 patches are the actual feature implementation + tests.
>
> Andrey Drobyshev (6):
>    qemu-img: rebase: stop when reaching EOF of old backing file
>    qemu-iotests: 024: add rebasing test case for overlay_size >
>      backing_size
>    qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>    qemu-img: rebase: avoid unnecessary COW operations
>    qemu-img: add compression option to rebase subcommand
>    iotests: add test 314 for "qemu-img rebase" with compression
>
>   docs/tools/qemu-img.rst    |   6 +-
>   qemu-img-cmds.hx           |   4 +-
>   qemu-img.c                 | 106 ++++++++++++++++++------
>   tests/qemu-iotests/024     |  57 +++++++++++++
>   tests/qemu-iotests/024.out |  30 +++++++
>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>   7 files changed, 415 insertions(+), 28 deletions(-)
>   create mode 100755 tests/qemu-iotests/314
>   create mode 100644 tests/qemu-iotests/314.out
>
ping

