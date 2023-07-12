Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5A74FFF6
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJU4g-0006cz-Db; Wed, 12 Jul 2023 03:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJU4A-0006KJ-IC; Wed, 12 Jul 2023 03:15:15 -0400
Received: from mail-vi1eur03on2070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe1b::70f]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJU43-0003Jt-VW; Wed, 12 Jul 2023 03:15:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUuk6iFdMqyJSj+S9MeZw8mkPMCOpcaPqqmk3zQFi0OkAAHRsBc5nLhXCeXhDm5ciTc6CdZoSo6zYQngzVv73R8krksRlVF0xMUHx7DW/1qTsd3BlbAuoAcpneCLbMwvOfM09mcIkSX5CU5/sgB/1RLbvtEjFet/RnoMhcGEwzyA7EFhRI2ZJevPFLpyq0SaBY+nLCZjSrhbKAg9eBRlToVLJsTvS6jwo78WIiW1NaDjlZnDTo63h9oV6VoqM+KRu+Lz5wQJUavSHlN/eBSKcKzJEZDK8dQqb10Npg7RXpzCrk0jmH0wj8PMPzw/1cZnhicw0ukpcrQmCIrMq5H+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqbXeLPp1HMzgxVQNeLYKIvFg3JuWhLfOyuAOMB1kRU=;
 b=SYSZXDs2cWCKr62O2tjqsKS9Ol/7fy22c/t3fhKQK/l9nSAAcb5b73wrOqN70s/MsRd2NOxxh9wiPU9yTGRkc4HNFxsJGAA5Jp+rTF6yfbMfqCdIQUQBr1Ng5CcOZhW+bqtAca07zA4X9AhF53K7nPYhiAgp1PpBVaEpJqkvFcP/rud6pdFDOdotmy31CekdB1wRJxzpyllXOsp2h3nGK+bGNHbYYC+pdY8g5m80+n1Z3MSh9IbQAHoZRiA0qjYo7+eNs7T9IrpvSTzcLzd8bpAU08fO2yWZrupKIV3ejmC0pp4CdH4vXsh1lezfsQCL1FCT6CO8Z/PyFPtjcW2OKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqbXeLPp1HMzgxVQNeLYKIvFg3JuWhLfOyuAOMB1kRU=;
 b=ZXhoVPeWDUKS45SinXgKMmdRFJeOFhBIDU8N31xiLRNx7IVMti5yjGSHpaRlRZDbQL8t7XwOrv6M8kPeg8TznNzLYve46SqCt1nwKOVCAtaIntujCzOg4nYU6sVZ9ljvLk/GNjzv0Nye5222Kq0schBRzBHaEnJJwK7/7dkfGA15jprNo4Z3ezLSyrTmt6xLeW4tqNF4/onKv1gceg1BbMOwjIetGvEGtPqwuVBVzDQmLZmpLNI+sIEUez+6MhOTP8JQdELCYQaIMcTjAp2etU4gxjebi8ZfaR6oQNhxCRJPf0/euqK2VXMExgLI1tFKG5mujXybrNgwF+ywdpRKNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB9119.eurprd08.prod.outlook.com (2603:10a6:20b:5b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 07:15:01 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 07:15:01 +0000
Message-ID: <2801998a-afc5-b48f-8913-7b08b86db60d@virtuozzo.com>
Date: Wed, 12 Jul 2023 09:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] qemu-iotests: update expected tests output to
 contain "compressed" field
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-4-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230706163047.128999-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fb4d3e-e9d0-480d-e7a4-08db82a7b4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuECtfeOWgWZrgZr3ikvyENtDI6WnVTu5BIUirH31Prp8c6IU7ZH5ox9RZIpBQOknVK/IvIMGR50+i020BqLsesFoflzX07MmKeyt1B5y//3t91cR3SyzjXY4Ihnlfao/MW8S0bdHgC39AIsVQfusfeLEkshKnRjGv2/fahhjiiqm5sCjqeGwuIiY8QYIvtZ66s/JxrYtOeLjwTGchuawGd63mhan6tZFIhIE11f/8H1l9SCyrWyG7t2tjXogtUCQ05qcju716oZ9Vo0D5SP+H+zOBHCWustlFRJYgn0Jp7YQknAvZ2Frn9YybxZ2CLWmosAvQvH5KTqKAsTfJpgVWJTUMjn2Lygme29bYvuDr0HmqZohsxJccmRXShJgpTiKnyfeRkPU4u3ZyUrIBlPJG66Y1a4+BcZgzqKqSlFeyjvicltG2a9lDwQHhbwWuUxsXL/GG62BDoRlh3WO84wjDxMX9LoxX1HZp4RD7EYeZVTtkJ5uLqc7/CSg75nlT86Hs6Hi/b6RlVEXaT3bG1/dUHvDNqESdIDO+0OQeUy2vDICkz5o3dKZhddKsuYWpUCkAeqJgLJIeYQfFATi2ax/lfjBf90rWAbUkowGqdtn5cJ+Y8ZSqC4gQGyNlkm4iAXtXZe6AhI2pE0imCTSlztyKNH1OqyJ0S4zkZ55AjEETM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(451199021)(31686004)(6486002)(478600001)(83380400001)(36756003)(86362001)(31696002)(2616005)(30864003)(2906002)(6506007)(26005)(186003)(66946007)(6512007)(53546011)(8676002)(8936002)(38100700002)(5660300002)(66476007)(316002)(66556008)(41300700001)(4326008)(21314003)(43740500002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0JPYkpXcURGRFFXd3UvYzRxMlhpQzdDMXlLQmdROXNiQzEzb2FvZ0pvY0RX?=
 =?utf-8?B?K2VSZko4NDhBR3NKVTJDSkgvQkhlYkJMZlowN0pMTjBxeTRqWS9GNkFYSVVZ?=
 =?utf-8?B?TzMyOTQ3bEN5NEZ2MkZDZXFrTTNFT25sZ2t2SVRNbkFDekg2VjBDTTBsTSs2?=
 =?utf-8?B?Ti9lRjVMbHJpOWdNeUU5MDBZejFmMEduQ21oUXRtcll3R2ZpQlRCUlNSKzVa?=
 =?utf-8?B?U2Zjd3ZNV1Yyekpva3kwNTNRVVZZY3Erd1E0RDRiUjBocGk0Z1NEa3NIUXl4?=
 =?utf-8?B?UmNCZmZ4b2lGQUlrbUhraDBkOWpuQlFZdW1iRlN4Q2RvTjBmMGYzK1NZQ0tY?=
 =?utf-8?B?Y2N5cExiTFEwWHFTNnVya2NnQm9LaVhrRTFkaUpTVUkxMnJmY2xENi9UeitP?=
 =?utf-8?B?RFUrNGk2WjFRWml5S0FhM3VEdkZ2ZjU5VEFBbG9iNVpodVA1WWU1ampFQndN?=
 =?utf-8?B?UGVpL1VXUURjUGVaOHc4OUtveGMzWDJzMXdFZkh1QnJzeDZsODZkMG9nYU1i?=
 =?utf-8?B?S3NFNDZDM0ZGVjZaS2hHdFE2OTNZem1pbDc1a0luamh2eXd6UmI0aFhPN25G?=
 =?utf-8?B?QlJ5RUlLcTQyVUdmTjQ1S29ZRllIK3NlVmc0SFcxWDB3Q3ZtZ0haeHczUXdS?=
 =?utf-8?B?Z2o4eWZjaDI5aEZoUmoyaEgvUDg2WjR3NW0walVDaXdmdkk2ZURTSGN6MWpy?=
 =?utf-8?B?KzFkdUdHc3QvRzdacmtXQ1U5VVNpRi92VDN0cTJnMXBIUVV6eXp4OFpPVVpz?=
 =?utf-8?B?bnljUGtVd2d5M3EwbDh1MGluQkxqTnQ4S3ZHQTlLY3lMWFVobXVXT0hRNnNC?=
 =?utf-8?B?a0R2c2crRDk3NGN3bzlveVphTlVyUTlXU1F4N2pXVS9NNytwQTcwVEI1MERw?=
 =?utf-8?B?cnZPU29XTG1VVEROTzZFS2kzWUE5aG9PUmduQnZ3WW1LOXFYVTJCdmxtSHQv?=
 =?utf-8?B?b2VxTDJXTVdlcy9Ueng3dkJlOCttVkE3MHBIRTYzWE9QdkFNbDlJU29RbnJa?=
 =?utf-8?B?dkdvemoyNUpacFhiV2FJc0xzNHVZUTFGcFlQS3VlZHJueDI0cktwSUVIcS85?=
 =?utf-8?B?czd0cXM1NGlRVnN0RWhreWFIM0RUMDNjQzY4amZDMjNGRVdlT2lkeWlrSFZB?=
 =?utf-8?B?WDBHUkhzZkU1ZURyZUI5SHdPc3ZCNDcxM21BY3krSTlYU3ZteGxIYjFqREYw?=
 =?utf-8?B?ZUd1N3k3QU85SGN5RUZ5ZGRBVEhHVFBBZkJiaTBmOUFGTVoyRGFtSUd2K0dh?=
 =?utf-8?B?aFB4eTFJQm12azdIYlN5UXE3anYzeGF1ZTJRT25FT3hzMzQrVk9FNnM5WEgz?=
 =?utf-8?B?QXI0clVjR2N6VVFhelN1bGg4bmZ6cWxUS0ZqVzBXd0ltNGhNS2VpcW1Nbmkr?=
 =?utf-8?B?Lzhod0tScDRUa3o4WHA0RS9BWlZRNklsc0NVbTVTNmdpWlR4ZkVVMHptWXJC?=
 =?utf-8?B?Z21OZEFUeEFwbVZwamFvYVp0YWJjMXQySWcvaEluOHFuZDRGeDl6RllLTHVo?=
 =?utf-8?B?ZmNkbnlOeVljRGtnU3J2aDNhWFlFdC90WGVWRDJuM3p5eGNuMmw0QnA1MUJ0?=
 =?utf-8?B?R1hjazdDbkRRYmtMc3NsY1hjVy9tODBZazc1cHkyWnpTejdkeVdmU1ZEYTRw?=
 =?utf-8?B?aHJ2OXZkY2ZqRGpvUEtINFp1UWxYRC9xck1PVEFtTjVGWXZFVjlkRTB0N0lE?=
 =?utf-8?B?TWtVYzBsMnJ3V3orWVBweG1WeGtHRTVnT3A0WTh4QjRDM2g4dkVXczlMZWIv?=
 =?utf-8?B?ZTFPaHJWWjl0LzhqOEV4R2JwZ3FwbFE1dkpCcXhRQWpheXdBQk9nZ2FsS0NY?=
 =?utf-8?B?Q1JFN054R2RhY0FlZVNtQ3paeUlUUHhaWVMxRmJhSGlid3c3TFBvT1hkekNH?=
 =?utf-8?B?UWtRVlNGeVN3NXRaNkc2cjRLaG1oYnNBcUt2Yjczc014SHNPMkNleTUrQ2RL?=
 =?utf-8?B?QmZ1eUwvT1hYUHFXQVkyRXZlRmxURUYyR1hrcGJVM3lvaUE5S2pKNG1RakRm?=
 =?utf-8?B?Q3c1K1JCV3IyRWRiVXBwbWZkY2QzWk9OMkJIR0pNclVmWmhpNUpZb1RrV1dU?=
 =?utf-8?B?UHJnK3FkQnloT3UwNzZkUVVkZ3E3QnlTdmFaS2xsYXNqYmhJbHpPNlB0SUo1?=
 =?utf-8?Q?3LWWbf24GSAJOnqBPOfHYmA+w?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb4d3e-e9d0-480d-e7a4-08db82a7b4e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:15:01.0550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pPG1OGn/JB0dhzDSnG0jp7KLsxao0aPrR6Bg7nr2D724MqLxsx6+CcxBLqlxoT0MeA5UkJwNB8tAewGRpVVNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9119
Received-SPF: pass client-ip=2a01:111:f400:fe1b::70f;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/6/23 18:30, Andrey Drobyshev wrote:
> The previous commit adds "compressed" boolean field to JSON output of
> "qemu-img map" command.  Let's tweak expected tests output accordingly.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/122.out                    |  84 ++++----
>   tests/qemu-iotests/154.out                    | 194 +++++++++---------
>   tests/qemu-iotests/179.out                    | 178 ++++++++--------
>   tests/qemu-iotests/244.out                    |  24 +--
>   tests/qemu-iotests/252.out                    |  10 +-
>   tests/qemu-iotests/274.out                    |  48 ++---
>   .../tests/nbd-qemu-allocation.out             |   6 +-
>   7 files changed, 272 insertions(+), 272 deletions(-)
>
> diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
> index e18766e167..6a1aa3fe2b 100644
> --- a/tests/qemu-iotests/122.out
> +++ b/tests/qemu-iotests/122.out
> @@ -67,12 +67,12 @@ read 65536/65536 bytes at offset 4194304
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 65536/65536 bytes at offset 8388608
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 65536, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 4194304, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 4259840, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 8388608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 8454144, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 65536, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 4259840, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 8454144, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   read 65536/65536 bytes at offset 0
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 65536/65536 bytes at offset 4194304
> @@ -94,12 +94,12 @@ wrote 1024/1024 bytes at offset 1046528
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 1024/1024 bytes at offset 0
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 65536, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 131072, "length": 196608, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 327680, "length": 655360, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 1048576, "length": 1046528, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 65536, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 131072, "length": 196608, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 327680, "length": 655360, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 1048576, "length": 1046528, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   read 16384/16384 bytes at offset 0
>   16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 16384/16384 bytes at offset 16384
> @@ -130,14 +130,14 @@ read 3145728/3145728 bytes at offset 0
>   3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 63963136/63963136 bytes at offset 3145728
>   61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>   
>   convert -c -S 0:
>   read 3145728/3145728 bytes at offset 0
>   3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 63963136/63963136 bytes at offset 3145728
>   61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
>   wrote 33554432/33554432 bytes at offset 0
>   32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -152,7 +152,7 @@ read 30408704/30408704 bytes at offset 3145728
>   29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 33554432/33554432 bytes at offset 33554432
>   32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>   
>   convert -c -S 0 with source backing file:
>   read 3145728/3145728 bytes at offset 0
> @@ -161,7 +161,7 @@ read 30408704/30408704 bytes at offset 3145728
>   29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 33554432/33554432 bytes at offset 33554432
>   32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
>   
>   convert -S 0 -B ...
>   read 3145728/3145728 bytes at offset 0
> @@ -170,7 +170,7 @@ read 30408704/30408704 bytes at offset 3145728
>   29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 33554432/33554432 bytes at offset 33554432
>   32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>   
>   convert -c -S 0 -B ...
>   read 3145728/3145728 bytes at offset 0
> @@ -179,7 +179,7 @@ read 30408704/30408704 bytes at offset 3145728
>   29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 33554432/33554432 bytes at offset 33554432
>   32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
>   
>   === Non-zero -S ===
>   
> @@ -196,32 +196,32 @@ wrote 1024/1024 bytes at offset 66560
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   
>   convert -S 4k
> -[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 4096, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 12288, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 20480, "length": 67088384, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 4096, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 12288, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 20480, "length": 67088384, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   convert -c -S 4k
> -[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   convert -S 8k
> -[{ "start": 0, "length": 24576, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 24576, "length": 67084288, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 24576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 24576, "length": 67084288, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   convert -c -S 8k
> -[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
> -{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
> +{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   === -n to a non-zero image ===
>   
> @@ -235,18 +235,18 @@ Images are identical.
>   
>   Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   === -n to an empty image with a backing file ===
>   
>   Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> -[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
> +[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
>   
>   === -n -B to an image without a backing file ===
>   
> diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
> index 1fa7ffc475..0199269add 100644
> --- a/tests/qemu-iotests/154.out
> +++ b/tests/qemu-iotests/154.out
> @@ -11,14 +11,14 @@ wrote 2048/2048 bytes at offset 17408
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2048/2048 bytes at offset 27648
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4096, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 12288, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 20480, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 24576, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4096, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 12288, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 20480, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 24576, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == backing file contains non-zero data before write_zeroes ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -41,11 +41,11 @@ read 1024/1024 bytes at offset 65536
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 2048/2048 bytes at offset 67584
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 36864, "length": 28672, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 69632, "length": 134148096, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 36864, "length": 28672, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 69632, "length": 134148096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == backing file contains non-zero data after write_zeroes ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -68,11 +68,11 @@ read 1024/1024 bytes at offset 44032
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 3072/3072 bytes at offset 40960
>   3 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 36864, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 40960, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 45056, "length": 134172672, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 36864, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 40960, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 45056, "length": 134172672, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == write_zeroes covers non-zero data ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -101,15 +101,15 @@ wrote 2048/2048 bytes at offset 29696
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 4096/4096 bytes at offset 28672
>   4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 4096, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 8192, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 12288, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 16384, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 20480, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 24576, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 28672, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 4096, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8192, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 12288, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 16384, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 20480, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 24576, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 28672, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning two clusters, non-zero before request ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -142,16 +142,16 @@ read 1024/1024 bytes at offset 67584
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 5120/5120 bytes at offset 68608
>   5 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning two clusters, non-zero after request ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -184,16 +184,16 @@ read 7168/7168 bytes at offset 65536
>   7 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 1024/1024 bytes at offset 72704
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning two clusters, partially overwriting backing file ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -212,8 +212,8 @@ read 1024/1024 bytes at offset 5120
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 2048/2048 bytes at offset 6144
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 8192, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 8192, "length": 134209536, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 8192, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 8192, "length": 134209536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning multiple clusters, non-zero in first cluster ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -226,10 +226,10 @@ read 2048/2048 bytes at offset 65536
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 10240/10240 bytes at offset 67584
>   10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 69632, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 69632, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning multiple clusters, non-zero in intermediate cluster ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -240,9 +240,9 @@ wrote 7168/7168 bytes at offset 67584
>   7 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 12288/12288 bytes at offset 65536
>   12 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 12288, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 12288, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning multiple clusters, non-zero in final cluster ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -255,10 +255,10 @@ read 10240/10240 bytes at offset 65536
>   10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 2048/2048 bytes at offset 75776
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == spanning multiple clusters, partially overwriting backing file ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> @@ -277,88 +277,88 @@ read 2048/2048 bytes at offset 74752
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 1024/1024 bytes at offset 76800
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   == unaligned image tail cluster, no allocation needed ==
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
>   wrote 512/512 bytes at offset 134217728
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
>   wrote 512/512 bytes at offset 134219264
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
>   wrote 1024/1024 bytes at offset 134218240
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
>   wrote 2048/2048 bytes at offset 134217728
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 512/512 bytes at offset 134217728
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 512/512 bytes at offset 134219264
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 1024/1024 bytes at offset 134218240
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 2048/2048 bytes at offset 134217728
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   wrote 512/512 bytes at offset 134217728
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 512/512 bytes at offset 134217728
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 512/512 bytes at offset 134219264
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 1024/1024 bytes at offset 134218240
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 2048/2048 bytes at offset 134217728
>   2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134218752
>   wrote 1024/1024 bytes at offset 134217728
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -369,15 +369,15 @@ read 512/512 bytes at offset 134217728
>   read 512/512 bytes at offset 134218240
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   1024/1024 bytes allocated at offset 128 MiB
> -[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
> +[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>   wrote 1024/1024 bytes at offset 134217728
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   1024/1024 bytes allocated at offset 128 MiB
>   read 1024/1024 bytes at offset 134217728
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
>   
>   == unaligned image tail cluster, allocation required ==
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
> @@ -390,8 +390,8 @@ read 512/512 bytes at offset 134217728
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 1536/1536 bytes at offset 134218240
>   1.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>   wrote 512/512 bytes at offset 134218240
> @@ -412,6 +412,6 @@ read 512/512 bytes at offset 134218240
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 1024/1024 bytes at offset 134218752
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
> +[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>   *** done
> diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
> index 7cf22cd75f..65b909ebc2 100644
> --- a/tests/qemu-iotests/179.out
> +++ b/tests/qemu-iotests/179.out
> @@ -13,11 +13,11 @@ wrote 2097152/2097152 bytes at offset 6291456
>   2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
>   2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
>   56 MiB (0x3800000) bytes not allocated at offset 8 MiB (0x800000)
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 8388608, "length": 58720256, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 58720256, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   wrote 2097150/2097150 bytes at offset 10485761
>   2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2097150/2097150 bytes at offset 14680065
> @@ -31,15 +31,15 @@ wrote 2097150/2097150 bytes at offset 14680065
>   2 MiB (0x200000) bytes not allocated at offset 12 MiB (0xc00000)
>   2 MiB (0x200000) bytes     allocated at offset 14 MiB (0xe00000)
>   48 MiB (0x3000000) bytes not allocated at offset 16 MiB (0x1000000)
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 16777216, "length": 50331648, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 16777216, "length": 50331648, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   wrote 14680064/14680064 bytes at offset 18874368
>   14 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2097152/2097152 bytes at offset 20971520
> @@ -57,21 +57,21 @@ wrote 6291456/6291456 bytes at offset 25165824
>   2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
>   14 MiB (0xe00000) bytes     allocated at offset 18 MiB (0x1200000)
>   32 MiB (0x2000000) bytes not allocated at offset 32 MiB (0x2000000)
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 25165824, "length": 6291456, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 25165824, "length": 6291456, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   wrote 2097152/2097152 bytes at offset 27262976
>   2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2097152/2097152 bytes at offset 29360128
> @@ -87,23 +87,23 @@ wrote 2097152/2097152 bytes at offset 29360128
>   2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
>   14 MiB (0xe00000) bytes     allocated at offset 18 MiB (0x1200000)
>   32 MiB (0x2000000) bytes not allocated at offset 32 MiB (0x2000000)
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   wrote 8388608/8388608 bytes at offset 33554432
>   8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2097152/2097152 bytes at offset 35651584
> @@ -121,24 +121,24 @@ wrote 2097152/2097152 bytes at offset 37748736
>   2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
>   22 MiB (0x1600000) bytes     allocated at offset 18 MiB (0x1200000)
>   24 MiB (0x1800000) bytes not allocated at offset 40 MiB (0x2800000)
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 33554432, "length": 8388608, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 41943040, "length": 25165824, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 33554432, "length": 8388608, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 41943040, "length": 25165824, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   wrote 8388608/8388608 bytes at offset 41943040
>   8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 8388608/8388608 bytes at offset 50331648
> @@ -162,31 +162,31 @@ wrote 2097152/2097152 bytes at offset 62914560
>   4 MiB (0x400000) bytes not allocated at offset 54 MiB (0x3600000)
>   4 MiB (0x400000) bytes     allocated at offset 58 MiB (0x3a00000)
>   2 MiB (0x200000) bytes not allocated at offset 62 MiB (0x3e00000)
> -[{ "start": 0, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 2097152, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 6291456, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 8388608, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 10485760, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 12582912, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 14680064, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 16777216, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 18874368, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 20971520, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 23068672, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 25165824, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 27262976, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 29360128, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "offset": OFFSET},
> -{ "start": 31457280, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 33554432, "length": 10485760, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 44040192, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 48234496, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
> -{ "start": 50331648, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 52428800, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 56623104, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 58720256, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 60817408, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 65011712, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 10485760, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 12582912, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 14680064, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 16777216, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 18874368, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 20971520, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 23068672, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 25165824, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 27262976, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 29360128, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
> +{ "start": 31457280, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 33554432, "length": 10485760, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 44040192, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 48234496, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 50331648, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 52428800, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 56623104, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 58720256, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 60817408, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 65011712, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   No errors were found on the image.
>   No errors were found on the image.
>   
> diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
> index 5e03add054..38ffbd7e1e 100644
> --- a/tests/qemu-iotests/244.out
> +++ b/tests/qemu-iotests/244.out
> @@ -57,12 +57,12 @@ wrote 3145728/3145728 bytes at offset 3145728
>   3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   No errors were found on the image.
>   
> -[{ "start": 0, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false},
> -{ "start": 1048576, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "offset": 1048576},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "offset": 4194304},
> -{ "start": 5242880, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 6291456, "length": 60817408, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 1048576, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 1048576},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 4194304},
> +{ "start": 5242880, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 6291456, "length": 60817408, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   read 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -94,10 +94,10 @@ wrote 3145728/3145728 bytes at offset 3145728
>   3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   No errors were found on the image.
>   
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": 0},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": 4194304},
> -{ "start": 6291456, "length": 60817408, "depth": 0, "present": true, "zero": false, "data": true, "offset": 6291456}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 4194304},
> +{ "start": 6291456, "length": 60817408, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 6291456}]
>   
>   read 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -123,8 +123,8 @@ read 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Offset          Length          Mapped to       File
>   0               0x100000        0               TEST_DIR/t.qcow2.data
> -[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "offset": 0},
> -{ "start": 1048576, "length": 66060288, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0},
> +{ "start": 1048576, "length": 66060288, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   === Copy offloading ===
>   
> diff --git a/tests/qemu-iotests/252.out b/tests/qemu-iotests/252.out
> index c578129c25..b1aa94cb05 100644
> --- a/tests/qemu-iotests/252.out
> +++ b/tests/qemu-iotests/252.out
> @@ -23,8 +23,8 @@ read 131072/131072 bytes at offset 131072
>   read 131072/131072 bytes at offset 262144
>   128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   
> -[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 262144, "length": 131072, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 262144, "length": 131072, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   read 131072/131072 bytes at offset 0
>   128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -33,7 +33,7 @@ read 131072/131072 bytes at offset 131072
>   read 131072/131072 bytes at offset 262144
>   128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   
> -[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
> -{ "start": 262144, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false},
> -{ "start": 327680, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 262144, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
> +{ "start": 327680, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   *** done
> diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
> index acd8b166a6..c2967335ca 100644
> --- a/tests/qemu-iotests/274.out
> +++ b/tests/qemu-iotests/274.out
> @@ -20,18 +20,18 @@ read 1048576/1048576 bytes at offset 1048576
>   0/1048576 bytes allocated at offset 1 MiB
>   
>   === Checking map ===
> -[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
>   
>   Offset          Length          Mapped to       File
>   0               0x200000        0x50000         TEST_DIR/PID-base
>   
> -[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "offset": 327680}]
> +[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
>   
>   Offset          Length          Mapped to       File
>   0               0x100000        0x50000         TEST_DIR/PID-base
>   
> -[{ "start": 0, "length": 1048576, "depth": 2, "present": true, "zero": false, "data": true, "offset": 327680},
> -{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1048576, "depth": 2, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
> +{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
>   
>   Offset          Length          Mapped to       File
>   0               0x100000        0x50000         TEST_DIR/PID-base
> @@ -186,8 +186,8 @@ read 65536/65536 bytes at offset 5368709120
>   1 GiB (0x40000000) bytes not allocated at offset 0 bytes (0x0)
>   7 GiB (0x1c0000000) bytes     allocated at offset 1 GiB (0x40000000)
>   
> -[{ "start": 0, "length": 1073741824, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 1073741824, "length": 7516192768, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1073741824, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 1073741824, "length": 7516192768, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   
>   === preallocation=metadata ===
>   wrote 65536/65536 bytes at offset 33285996544
> @@ -201,13 +201,13 @@ read 65536/65536 bytes at offset 33285996544
>   30 GiB (0x780000000) bytes not allocated at offset 0 bytes (0x0)
>   3 GiB (0xc0000000) bytes     allocated at offset 30 GiB (0x780000000)
>   
> -[{ "start": 0, "length": 32212254720, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 32212254720, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 327680},
> -{ "start": 32749125632, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 537264128},
> -{ "start": 33285996544, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 1074200576},
> -{ "start": 33822867456, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 1611137024},
> -{ "start": 34359738368, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 2148139008},
> -{ "start": 34896609280, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 2685075456}]
> +[{ "start": 0, "length": 32212254720, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 32212254720, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 327680},
> +{ "start": 32749125632, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 537264128},
> +{ "start": 33285996544, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 1074200576},
> +{ "start": 33822867456, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 1611137024},
> +{ "start": 34359738368, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 2148139008},
> +{ "start": 34896609280, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 2685075456}]
>   
>   === preallocation=falloc ===
>   wrote 65536/65536 bytes at offset 9437184
> @@ -221,8 +221,8 @@ read 65536/65536 bytes at offset 9437184
>   5 MiB (0x500000) bytes not allocated at offset 0 bytes (0x0)
>   10 MiB (0xa00000) bytes     allocated at offset 5 MiB (0x500000)
>   
> -[{ "start": 0, "length": 5242880, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 5242880, "length": 10485760, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
> +[{ "start": 0, "length": 5242880, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 5242880, "length": 10485760, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
>   
>   === preallocation=full ===
>   wrote 65536/65536 bytes at offset 11534336
> @@ -236,8 +236,8 @@ read 65536/65536 bytes at offset 11534336
>   8 MiB (0x800000) bytes not allocated at offset 0 bytes (0x0)
>   4 MiB (0x400000) bytes     allocated at offset 8 MiB (0x800000)
>   
> -[{ "start": 0, "length": 8388608, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 8388608, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
> +[{ "start": 0, "length": 8388608, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 8388608, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
>   
>   === preallocation=off ===
>   wrote 65536/65536 bytes at offset 259072
> @@ -251,9 +251,9 @@ read 65536/65536 bytes at offset 259072
>   192 KiB (0x30000) bytes not allocated at offset 0 bytes (0x0)
>   320 KiB (0x50000) bytes     allocated at offset 192 KiB (0x30000)
>   
> -[{ "start": 0, "length": 196608, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 196608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680},
> -{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 196608, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 196608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
> +{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   
>   === preallocation=off ===
>   wrote 65536/65536 bytes at offset 344064
> @@ -267,8 +267,8 @@ read 65536/65536 bytes at offset 344064
>   256 KiB (0x40000) bytes not allocated at offset 0 bytes (0x0)
>   256 KiB (0x40000) bytes     allocated at offset 256 KiB (0x40000)
>   
> -[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   
>   === preallocation=off ===
>   wrote 65536/65536 bytes at offset 446464
> @@ -282,6 +282,6 @@ read 65536/65536 bytes at offset 446464
>   256 KiB (0x40000) bytes not allocated at offset 0 bytes (0x0)
>   244 KiB (0x3d000) bytes     allocated at offset 256 KiB (0x40000)
>   
> -[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false},
> -{ "start": 262144, "length": 249856, "depth": 0, "present": true, "zero": true, "data": false}]
> +[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
> +{ "start": 262144, "length": 249856, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
>   
> diff --git a/tests/qemu-iotests/tests/nbd-qemu-allocation.out b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
> index 9d938db24e..c1e60277f2 100644
> --- a/tests/qemu-iotests/tests/nbd-qemu-allocation.out
> +++ b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
> @@ -11,9 +11,9 @@ wrote 2097152/2097152 bytes at offset 1048576
>   
>   === Check allocation over NBD ===
>   
> -[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "offset": 327680},
> -{ "start": 1048576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680},
> -{ "start": 3145728, "length": 1048576, "depth": 1, "present": false, "zero": true, "data": false}]
> +[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
> +{ "start": 1048576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
> +{ "start": 3145728, "length": 1048576, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
>   exports available: 1
>    export: ''
>     size:  4194304
Reviewed-by: Denis V. Lunev <den@openvz.org>

