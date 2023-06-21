Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D31738CB3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1JW-0007wk-32; Wed, 21 Jun 2023 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC1JT-0007ov-An; Wed, 21 Jun 2023 13:08:11 -0400
Received: from mail-db8eur05on20723.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::723]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC1JQ-0007Es-ID; Wed, 21 Jun 2023 13:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRTQOsoqXe2ymmGO1DilGDl3w+QKovC+c/R4LA6svixiVbdhP5sVjLhOdhIVs5maejz9uHsuzPVKFIDcODCC1MzUsHaOAuAGanSlBG1Tf4m+cO9yN4xLeutMJZcAKzzGzDoTYTTU2L++lVT6Gnx9MarwPNp/AhBP0PO1ij1A9v/i5sDOQkMADzBEPe3Btugr/O6huODF/z4yqAyjXkZVGcfhCL1nBwn9/3s0cmBjWdjDiowhVjn4eeXnqbnGpaSzJSgRmThUW3Jz2SZJw7ki6uBhO9ke5kKe3jjApRdG2EBGJF8C8F3tRtwUu3X83gsfz6CRBOPXH5GJfCCBPehT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb5I+xFh6lsm7Wi4Qiq99deTeS0A+5g4MGfFkfpV8uw=;
 b=NiQ1e962OfeAUBx+Y88CKYyx5Z6iXoZ8i4vDaYIlNgtY9IQ/ue22LGGdF+JkYZO0L4r7J97RAxe4ji99fs16HzpntkdCPng7NkQ9gr/vEKyNhldLQmfhvVwFIo/HDyzSLhXVjUvqvVCrQYOyIK8khhtUPGR0SaT7wujixjTXP+H7Hdy6w4+Q2dM0UcX2f7BO0HiT0hJ5dwsjOkLvMcG+CeWGCWixamtakKueBOgD35O0gyM8WD03uPCSpTwytGc0zGXFwaA3tbwZa1ClKEvnw7RKoTAip4YzEX8Pn7afLSXFv4pXSkIPaAqhVkElCYglvkfHebx88dQsHFtoZGp4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb5I+xFh6lsm7Wi4Qiq99deTeS0A+5g4MGfFkfpV8uw=;
 b=g+9GfmX5YluRF/MHCBN2Qk2eCKIpYRg+VIFKtdLiVlHe9bgmXi3r9ZOiFrL1P2q53klI5PvBSgtMJifDC+yjedS4yvw7hVVqGo3wss2t1/lsZ5YeXRqVWkfHcc8ThCdXtZuDki5RFbxYArAcTh2+F4vxP/NkrUhXEW/P+BtAgpGWRzoz+74S0tvV4PPDenSqxEuTrRlwz+yRw/3OvbQEvAaN5VzT20w4t3EdL1wVnmaLlNrWdolGBZZajKl3LsMxBJ3NexfnGehKw5+i0pPXyMDLWXXj0CDabFnqN6GILAnzmZhUMkFBP0cxi7HF2qssxd/Ozk/4SRaMAQxFDhQzrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PA4PR08MB7433.eurprd08.prod.outlook.com (2603:10a6:102:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:08:03 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 17:08:03 +0000
Message-ID: <75b5d7aa-fd86-c06a-4633-26567e044b38@virtuozzo.com>
Date: Wed, 21 Jun 2023 19:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
 <20230607152627.468786-2-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230607152627.468786-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PA4PR08MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a424f2-f63c-45ea-dc3e-08db727a12f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SurntUmLk2or2PQtwVuFJ4JMeI9vT9SuTyWocogHKtnNwoXArrwwADaFVIm18TowBGtUONzr+2ACb4PMWKefLExExMETHgq9ay3iuFnDXqo2oi1ntpSKaBBJo/5kxZovZC4vSZhNY11A0lfeCHfPLvvRJ//gLqWpCG3e+N+K45O2l3zmG/Aaj56sYeZ/0asfm+apuBbtgjSpv6XeeAuYrkAK4tAp9nxTMNoQCc6WagW+VCAsu3T+BG+bSiQ3JrPejYRh1WGT9hBCMKPe2U8GdTw629rxm6zC1PNcE8XaHrQUdoo64Pqc8urekXevcP4Nq5+5P/LuY+1kizI/OPtyI6GxQZbAvxSLgcICBYsQtjCsKDeZE24hTvBAN2hOpxZp7mqhFHbFnpgTWWapQTaaLXQxWB6CGUbT4Pwtot9cxd4BU5Tr2/X8yMjMlJDsQVfIqCi/ZM+3/u8MJYAk6KEAYVOvrlmFhvDSoDqTFb6xifW1DQFAowScFMB/O0VXnPRYikmYpdbqA4vJLZSSMvNY1YwWsSPmyyOkNfdcb/GE0O8GprOe0D4lgM2jsZSDW3mCQmIhohp9FSWn5u7thSY+9DfUXWSC2ucth+bBXr0KQPdxWXz8R+z1yBkkEPNl0gP7KY5cLuvQf0jtnyOkYJ5rKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39850400004)(346002)(396003)(366004)(136003)(451199021)(6486002)(6506007)(478600001)(83380400001)(6512007)(186003)(2906002)(26005)(53546011)(2616005)(5660300002)(66556008)(38100700002)(31696002)(8936002)(66476007)(316002)(41300700001)(8676002)(4326008)(36756003)(66946007)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjg5ZTRIZnJYQWhQOVE5eE1xUC85SkNoU2ttbDBEMEJ0Z3RneVlCYXZycXBB?=
 =?utf-8?B?UjVLdWJYMmxXbjcwbXg1dndJc3pQdjFHVmdjQmVPamZEVEFTUU5QOXdoT2JW?=
 =?utf-8?B?RXAyZjVIdS94RXNybXhLanB5aVVsNDZPZUF1YzJrMXhWSmV0NFNESHdnejZi?=
 =?utf-8?B?VytYakxFK3VEYnVNUG0vT3pJRkVqaFdxaC8rdmVYTlZ3c3BDQjRuQ2E1TC9F?=
 =?utf-8?B?bGZxQlUzYWppL1dzNktYaWx3Y1oxSkhVV2czWmxSUmFvOUFRQnY0OGl3Ynpp?=
 =?utf-8?B?c1hST1hWMktOb05xUFZVSWd4Q3UxZ1pVRHo0MUNJb2xicVVWelVhdUdKQXg1?=
 =?utf-8?B?WkNKK0tLZkFOTnNUR0JSUndRM0VQcmdoVGhkMXZheFJ5UjZrMkplb2ErWmVJ?=
 =?utf-8?B?MTBrSlBYeUI3b1dvR0t1WVppbmo3c2lWZTBRdHd2RG8rbWdSWUE0dW5YcTJx?=
 =?utf-8?B?bC9sM1RKTyttVlppZytBeEdvZEhjSGs2d3VrUG9ZVUFkQlhDUWZIZDR3eFcv?=
 =?utf-8?B?UHVJSndQR3hoY0ZNeXNlUmlqUDB5RERyNThpN0xwMUo2dS9PejVBdlM2UUNx?=
 =?utf-8?B?RFlNWndPM1VHSWgvSUZWbHRNYmtBakcrSVVNK2NMWkhvb3o0aVI4V1J0UXli?=
 =?utf-8?B?U2FBbkNPaW9OUDkwZ00rVzNycWwrV2cwNHd4REhaTWNTWkwrWlk4eWlzV2Fu?=
 =?utf-8?B?bUVzaUVPVG40dk9Nc3IwZEsxM1lyWXFNbmgxTTBLc2xnYitxNlFqNWd2ZTdD?=
 =?utf-8?B?N0w5UHo0ejlYOFhVWWJWb3p3Z0lGdzkzeDljRExXdVVIckZBOHhZOVVZS2F5?=
 =?utf-8?B?T2ptdVlEdXYzN2MwUDJBUWZ1NHR4RzA2bFZ0czBoZW5nbWtqYlRkSFdRNnZO?=
 =?utf-8?B?d1JiZUFJUWhoNzJpbEw0RkZLRUlSaDc1S2lmSDNTK2xObEhvZ1QyZnRScU90?=
 =?utf-8?B?TTBzdWZiK0k5ZkhFd05ydVhpU1dPVzg4NlhEOG1TKzVqZW13Unp3N1hPVXVR?=
 =?utf-8?B?a3ROcEl3MFprZFhycGwzZVcyQ216NkY4bldwQWJCdm1aSzhWR2ZaeXNLMzJi?=
 =?utf-8?B?M0tvOWpQT3RKQ1JtNzN0cEZSNHA5c21SWHNqMVh4Nlc5WVBKNUxzL3B0aTlp?=
 =?utf-8?B?WElaVlJ2bkV1b2dMWnRaNlYvdldzYmp5REc5SzNmQjA4Sk52dFVkTWZMWDND?=
 =?utf-8?B?VjhoZ1laaXVhYmJCOTZKR2xWc0xVbEpYaE5HYkFQZEhNeFVmdEsrRHVNZTdC?=
 =?utf-8?B?eDNKekQ5czJOV2E3QzV2QUIwRW9DeHorRWJMdjg2Q3ZkS3lsbTdMTFd1dk00?=
 =?utf-8?B?WUwrQXJIUTFkaUdRNlc0K056SWs4eFJPOEFMOWZPb3JvWSswREcweGE4eFFF?=
 =?utf-8?B?UzA1bzZ2OEpWSkRPdm1DSkI1NDRVNGdjRE5TNE5OM0NXMytwZXhEQmNOcUp2?=
 =?utf-8?B?L2E4bVlJR2d5NzNyNEx5WFYrdHhBT0FxTFJYNEpmUnZ4eENHdnl4WHVZdFEy?=
 =?utf-8?B?SzdTTzlid1F1VmxFMm16MkpXdjNseHpJL3ZoZ29sRkhWNGltQmlxb2FZTVZw?=
 =?utf-8?B?WDNreU9rTGUzQU5ORURCWjM1SFBqZFRwZGlOejdibHdNMmthdnVNTlovMXl6?=
 =?utf-8?B?THUwVzhUTXhKZzNOWlIxVWNTRG1MQjNtajQzd3p1SmNCOXNBY0hkY25tSlJr?=
 =?utf-8?B?bFhEYXZNd3k0N2hJWWl1ZU5ERHBiaVBFL1FBanFDZTV1STlRWm1SZWZSQXVn?=
 =?utf-8?B?YnAxRXdDazgxandFeWkrQWlIMWl2cHp2S1FSQ3ZpaHE3bjIxTGJKM2o3NGhP?=
 =?utf-8?B?d3l2bUJaZHFGOWcvb1luSmlpUU5KcnlRTWltU3RrY1NTdEZZVkx1YzBLWjlP?=
 =?utf-8?B?SlJZdVdicmVUa3JwU0JVVU9Da1QrRHBSd2lidFRwdTRtZ3BCSXhMQ2V4TGFz?=
 =?utf-8?B?cGJlZld4TTJMRTNqTXVpM3Rod2g5VVdqV2l1emZYRlNya0hUL2tJSnNsb3BV?=
 =?utf-8?B?bklYWVFXdEtUNEhnS1Y3ZG9YQkpBaGV4TWZ0dUpnWDFNMDF6dXUvZ3dlSWV5?=
 =?utf-8?B?Skt4SmJwS0llUWRycmdGOWEyZFNuZkRaYzZrU2RNckRiZzdsTFoxc05jbWtS?=
 =?utf-8?Q?5fk0dZiYv48WaHuGoKpb4ylJW?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a424f2-f63c-45ea-dc3e-08db727a12f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:08:03.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a16rdcOYUw2T2eld6ZHd+ypan0uQhYqXO+n71pcme6xpZ5O3qn9l/nlVO8nNLtqebbIluONFcsyOBs1Rh29Gcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7433
Received-SPF: pass client-ip=2a01:111:f400:7e1a::723;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/7/23 17:26, Andrey Drobyshev wrote:
> Functions qcow2_get_host_offset(), get_cluster_offset() explicitly
> report compressed cluster types when data is compressed.  However, this
> information is never passed further.  Let's make use of it by adding new
> BDRV_BLOCK_COMPRESSED flag for bdrv_block_status(), so that caller may
> know that the data range is compressed.  In particular, we're going to
> use this flag to tweak "qemu-img map" output.
>
> This new flag is only being utilized by qcow and qcow2 formats, as only
> these two support compression.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow.c                 | 5 ++++-
>   block/qcow2.c                | 3 +++
>   include/block/block-common.h | 3 +++
>   3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow.c b/block/qcow.c
> index 3644bbf5cb..8416bcc2c3 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -549,7 +549,10 @@ qcow_co_block_status(BlockDriverState *bs, bool want_zero,
>       if (!cluster_offset) {
>           return 0;
>       }
> -    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
> +    if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_COMPRESSED;
> +    }
> +    if (s->crypto) {
>           return BDRV_BLOCK_DATA;
>       }
>       *map = cluster_offset | index_in_cluster;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index e23edd48c2..8e01adc610 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2162,6 +2162,9 @@ qcow2_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
>       {
>           status |= BDRV_BLOCK_RECURSE;
>       }
> +    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
> +        status |= BDRV_BLOCK_COMPRESSED;
> +    }
>       return status;
>   }
>   
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index e15395f2cb..f7a4e7d4db 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -282,6 +282,8 @@ typedef enum {
>    *                       layer rather than any backing, set by block layer
>    * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
>    *                 layer, set by block layer
> + * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only valid for
> + *                        the formats supporting compression: qcow, qcow2
>    *
>    * Internal flags:
>    * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
> @@ -317,6 +319,7 @@ typedef enum {
>   #define BDRV_BLOCK_ALLOCATED    0x10
>   #define BDRV_BLOCK_EOF          0x20
>   #define BDRV_BLOCK_RECURSE      0x40
> +#define BDRV_BLOCK_COMPRESSED   0x80
>   
>   typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

