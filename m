Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571182F08B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:32:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkSw-0007XN-4x; Tue, 16 Jan 2024 09:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkSr-0007Ww-GB; Tue, 16 Jan 2024 09:30:53 -0500
Received: from mail-vi1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::713]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkSp-0000vr-TN; Tue, 16 Jan 2024 09:30:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0qopdwLGfTWnKa50ygauuZTHmNtFoizg+gZQAxsggadaQQ1i1mV53Y1cTyA2dnwGJ/VrbodCqQEjw3CaNpAKH2wkvEvyGxeoMeVVsfmiPh8k4iwL8fRMRPVIWGFX+dXKxl3+YB4QZEDfB6mWGI3qjMt4sDyvgj7Y+PApPszKQLQtzSIWAIw2wrApEDYFXOpxrVHA0vRlBv9ZWgMI4EGfi5r0b92W2f6XfUOovb5ZVjhP895A3DovW2HKP6MmBGqGBvnUE+QRk9WlpnY47hxoGjobD6Og7k4LNrWfood6A0tT/yZBDP1M4Ai8szybXsdRqIfOzveNrx6Jb1j5+09Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlyt6cyijRHCeQptUbcdNGe3ChdsEgHR5z5F4zaTBso=;
 b=ctp76crMgjIVAE3X9UPvKsH1/KGV6uQW6TSkkgfpEezcKMRW4ru3Uqkms1kiXqmdcFRVNTbY9Zy8QiOotDb1JjPdVq8x151qEfmeGjXTRU//YJO3t+7ZcE25UItbE/1yQu78JmgV0ivNhGOeafFxuGQZVx0pQB8BYxOnIWtqBtQvUZW0/0KGlTKnVVqYU0fAtVnxroqRWUjvDI9mKcpNz5M8mwxQpvbYllxSqbc7UA0FD4M8XOLa0aT3JbzMhJR0uSfBHBbGzWa9m9Lp5g46/oZYnuRtqBNfxY2FJZQH1ciaaLp6zMlpzTcz8oYL27TeyrocV7D1viqkswwKqBo+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlyt6cyijRHCeQptUbcdNGe3ChdsEgHR5z5F4zaTBso=;
 b=XiLrFxUprAcqlseHZiltBiCljZmQDGztlF7Kq9cMNreg0CBDXvmpwjw8X5egErtC+iWvWHQo0fXuKpGKwL1SJPPnegq+IHTtrQwaQhnavgfhHfmWjdwXadEmLCHyvEf03CiEAlszRQSw+xPsV+1KvjcXYPJQCZXJN3ATHPCc8Tc8ZmMtq4uKWL8jIpDeXCGongSIZzpopIf0wWGA7+mfBiNEA0WIPHWlm/V8uluAgvgra4UoLDRLdrQL50v6S2m5ZAiUuoIqyQq0H+bC16+reDgxGTZ2sKBF9go5tDBfvZPvi23plDsWDs2CZEVX0wdWhWaL3ABXfDCxY3IS1Zs7Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB3PR08MB8916.eurprd08.prod.outlook.com (2603:10a6:10:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 14:30:47 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:30:47 +0000
Message-ID: <442411f5-ea2b-421f-8bb6-cfd5311649ad@virtuozzo.com>
Date: Tue, 16 Jan 2024 15:30:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/21] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-10-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-10-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB3PR08MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: e426ca37-b747-4f01-6cb0-08dc169fbabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VrsywAlJWeWtyeqtMW2193bm11PQWvSBepMkOi3TRu4tNZM96h6V96l2GkaEmnHwCfYzMpJOXk9eVtQwuJ36jpma8Mg2WWY5wHQgHJG66OxOR+afIoad9lWpDIsV4uXhp+FcsqSSuM8g3A3IqMUWT4Jc/WP+itiFZDJeEvUUJ4K6TE/YBGAwZu72In7Hczx730YjrCATkNjNUzjxBmk38R64KXDASLhGKpy9j5Oy886xg2Tp/PoEeZWkC4yLDW5AeriN+EIDN2VfYIjSgtzcot6NkFAfyBUzLwvc8fFqtoOFxMpwQcncliS6foyL7I+46XhbD6QtsLZZqQQ8AhXwpLxA1OO1QJvo1wiXfJr5IQZzjJ8lqBtD0I/TUsOSMZK8KRST9ZvAykm3pZImIs8kd4cc8UJp/6IlDnkgoWT0vezBCXWndb1Rs+mzyz5JosW/tQH9QN2GAkswQzWUelBhyoU4r9h2erOJHUMFltD8o4Ha/U2OG7j5l4nklGRVpAsHw/OV6PYVYmEBL4tdYg8z56UqVKM38oGeGpU3yxzIGKq69qsIXBoW7xQ/wy+zyMNDq4y4kZ/FLi3OgVOMJL//aQfu3KLIuf0ZkJ74NmkoLUOMX16QWXq04X3KCzxDsBWvdPPXAp1YGbU6Pt6EWqVeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8936002)(8676002)(2906002)(4326008)(31686004)(66476007)(66946007)(66556008)(316002)(6512007)(53546011)(6506007)(478600001)(83380400001)(2616005)(26005)(41300700001)(38100700002)(31696002)(86362001)(6486002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xsK0hOd1loMDJVV0NqWW56czc2YXdVekxIeExEME9FckNEVHcxWVhsS2dM?=
 =?utf-8?B?eXNlWDVHY3BzOW1MQWNheXhmSFVPdE4vbDgvc25QOGh6bFdydy81OXB6VDV5?=
 =?utf-8?B?d1JUMkhPVzNvTnZOdEhzclZxZ0o0d2NMSENWbEpNQ0dOZjJVdEp2Q3RnYlUr?=
 =?utf-8?B?QmxmNzdwYlA2NlJjN3c3MnZNN0NhT1JOdm1xQmVCa0RuUUltVVdwVFVKMmJF?=
 =?utf-8?B?b1dGdElTcUtGZkl2RSsxRzRDekMyVzFPR0YvQWFpK3h3a0pJZ2tERGNyaXBD?=
 =?utf-8?B?VWJacWxjWDRQdzhUUlYvMnFVb3BDK1NqWmoxOUdKU2cyT1Vtb0RoUFlPRUU5?=
 =?utf-8?B?SUkzWlVNYXk3Nk4yZE5SNStmY0ZuWFpyUG42ZWtKcGthNGxYNTJOOHVudlZy?=
 =?utf-8?B?N0lYYVp4YVoreUdRTEZjVjJIeFVUTm95bkFQb3IvOXN1Z0pqcjFUaDVrNnFl?=
 =?utf-8?B?SEFKOENuUkZyd2QrR0VuRlZMczMxZFV2MVJwcUFLYVNua2J1UUpOemlvT0VO?=
 =?utf-8?B?K3VSdWZZNGovVTdPdXhFa2VLbnhlQnhRQkk0ckE5QlF0cW1vL0tkY1ZLY0Fl?=
 =?utf-8?B?am83Tm5nR25uSnNoRFFZNmt6amllYnRWazdWUFNHSmt1S3dMQVFFcWZ1SGRZ?=
 =?utf-8?B?b0pHWFN0QitFV1VjZys0cGh5R3VpSklHNVAzVVR4a1FRWm00bUlQdEorVERI?=
 =?utf-8?B?RVZRUkZwSjQza3p3b0hoL2hWd24xaThJUXVBR3VnbEtQejJ3R09NK1hlVVFI?=
 =?utf-8?B?emdFd0RZek9mbmpHdWc2SjJxYkZoaVl1a3g2bFRJRXVqS0xjZk1sbUQ4cHYx?=
 =?utf-8?B?TGgvcThaM2VSY3ZoQisvTEpSOFAzM3VPQzZWbnk0aUtybElyMk9IOVJrR1o1?=
 =?utf-8?B?eDJJYXRqRnpVWWQvOVBVTDZHK1cwRzk1ZjJycG1QZFppUnVvdDU4cjRMRzZL?=
 =?utf-8?B?T2RDclNSLytRb2t3eGVST0FlVG5EZnR3MmZmK2hsNVBxYTlkK3pXMEtZZTdD?=
 =?utf-8?B?RFA0VTgyNkx5T0l4dUs3am9kUnE2RURVUUpOREJuVWpNbmFSU1MvVEptL2pF?=
 =?utf-8?B?OThsR0ZZVjcvU0NGdFFTWDYwQ28yTGdhZnppSUZPYm1XczFUdUtya3RDcGFj?=
 =?utf-8?B?eEF5VmErL05jOWFkV04xNlRDK1c5WU1QQ2JSYm9VY3R2K2FRa1lEOStMeW82?=
 =?utf-8?B?UzVMVmluRUVHWXlqYzhjRWtTREhxWnRCZldvei93bU9EaFAyY2xEcEl2cmVi?=
 =?utf-8?B?aFZxY1JNcWFzQWtoVVhnZlVIRmR0UjZJSUNqL2p5ZWNDcFAwVUZnOVRiRWFO?=
 =?utf-8?B?RGJWWWNyN0hQUjdDQlRrMzZrTy9EaFdUdC9GU2dic1h6U0N3aWttNGJUOU93?=
 =?utf-8?B?Z2lYL1NJQlVOb21QbWFmNnU0SDhJYm9lam1WTmxGSDBYQ2pVQnlHTWgwNHFk?=
 =?utf-8?B?TExtdDhLYURtb29wMGtQVEtkYlhFWk03bkZjelk3dmFNVWFoQlBPZ0FqZnA3?=
 =?utf-8?B?VWtxdVpBa25HcWZXaVk2ayswVW9YaUM0L0pUREhCTm11V1NsUGdkN2xPQUI1?=
 =?utf-8?B?YXRTSnBza0dnbE9Sbkw5ZlY2RmdqK2xPMWw0b3NtQ0RBOWJUb25Yb0FpVTFp?=
 =?utf-8?B?VnUrZ09VN0prVGFCS2MyY29ST0x2SzR3OEEzUUJZUmlhRG9BVC9ROHorNnhH?=
 =?utf-8?B?MDF2NzU1K3ZLTEJqQkl5NW92T0pGaFJNbG0vYVRpNzZHcHpjZVNqeHdlU0c2?=
 =?utf-8?B?RWhTSWd4T2RDSFhGVHVNMkVGQWIrYzVKdEdwNklucDlPOTdsa0VMZWJFUnds?=
 =?utf-8?B?dVBxaFJreTFTSTRmRjVTZnV6TzAwenJMK1BiK0k3L1VSd05jMWMza29Td1g5?=
 =?utf-8?B?THlmRGVmODNCdmhXRnBSQ1FDcmVQTS9hbDdnZjE3QTVzd0h1Z0huaGlhOXUv?=
 =?utf-8?B?R1F2OWZ6M3N6WGVhTVB4STF3c0wwTzdRQ1dBdHZTdjdnYVhDUUI5TUhYbjZV?=
 =?utf-8?B?L0FyNEZQSGFpYk9hdGg5YVZEdWtsOHV3SGxTMkZkVERCdmQ5ZzVYM0RkajBr?=
 =?utf-8?B?dEpKNEU2dTJBcGtadXhrb25WS0dXaEJFbTQ3TEsxVlc4bWgrdGdSUk8xd2dY?=
 =?utf-8?Q?exn0k6hur5/l9OCjuSem888ul?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e426ca37-b747-4f01-6cb0-08dc169fbabb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:30:46.9445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A8iVrZLMnRttLJpLP9gwy0sqDHid2gw+Cr3wXz8XKTJz4V79ctZvO8nWVu8+8+g1g47oN2PdODfCDM6Mo2DQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8916
Received-SPF: pass client-ip=2a01:111:f400:fe0e::713;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> In parallels_check_duplicate() We use a bitmap for duplication detection.
> This bitmap is not related to used_bmap field in BDRVParallelsState. Add
> a comment about it to avoid confusion.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 04c114f696..0ae06ec0b1 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -837,7 +837,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>       bool fixed = false;
>   
>       /*
> -     * Create a bitmap of used clusters.
> +     * Create a bitmap of used clusters. Please note that this bitmap is not
> +     * related to used_bmap field in BDRVParallelsState and is created only for
> +     * local usage.
> +     *
>        * If a bit is set, there is a BAT entry pointing to this cluster.
>        * Loop through the BAT entries, check bits relevant to an entry offset.
>        * If bit is set, this entry is duplicated. Otherwise set the bit.
Reviewed-by: Denis V. Lunev <den@openvz.org>

