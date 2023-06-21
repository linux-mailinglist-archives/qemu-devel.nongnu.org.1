Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A39D738C7B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1B9-0004Uf-7A; Wed, 21 Jun 2023 12:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC1B7-0004UT-FF; Wed, 21 Jun 2023 12:59:33 -0400
Received: from mail-am7eur03on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:7eaf::72e]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC1B5-0004r2-PD; Wed, 21 Jun 2023 12:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGB/BwbOleJsZzZNz18/Kr+cisME3/MGDAcsixOm8DSRj4eLxrPAx9sK9d4VFHY9Tfg4QGqwGWFzfxeRan+3IwS7WVrZilfFa1aLeaFjrSrVPuJKj9DMP+u/3DtHZCBDmS79OSBtzZvPmRYx8g24i2727YMhceKitrDqNmShOhPHFxsIYELENWuD73O+S2EwnqhJsnRuN8i3V7zK+QWRI1scLpCaK+HddlwhGzBPzSFnKN6wQV15tBv53uLK5gXYoz/a1n8kQj2ShHHRGlyEyYGlpyF6aVAWExjuelFoPAdsT+9996Ny7uCuXWoujaZkYdFvpTKiKFS67LHcIPWooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O83usSY06h4DSZfKonGiOUI0gRBVPhWS39TNeF1NmJg=;
 b=PpSqmnFk4LzHHznqkT69WeFeWgBxcYOXoJXehBQK3Iz/4UlGuWOJ6NzAxjHOSc/iWRRY4b6MucYlj5/LHkTKbOPvsO6M5gFmsOkZVRAwAzLJpACFQg9329TwWcem6h2TLbpSWkOivc/WpyjL84t88PGlLTlrKHl0TJ7dPCUN/MgWWn4f28qU4zZvOeUNMtuyzar9Fl1hhN036TnK6albBOo7h6zhYnK5G+ausTKPIS/kO1iWFPXvvSekVM76R266/hL4RZKwrS++FZrIUS2tJbr2GbkeUEo3C1l1RGwtXRA4VYXbFhtDfc9Z7utxoabovrQ0A1cbiahKMObZtsgQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O83usSY06h4DSZfKonGiOUI0gRBVPhWS39TNeF1NmJg=;
 b=zO3bKN413XMVxyG00riJ5weJG+rwYPzGYEv5ChKyT3XGiiloWt0QN+wrVBOLJ9AKQ4OiHh68QBUW4+8z2hD11kW+3qr1s+SVpyYWXLWxKQcTp75qrsUsUzW/t63CqjqZDDtXaT7eWtVIMbRsgtSOx2s1swFm4Yt4y3iNz+Q1oKZEoomXBoc8CYZ0Wo1BggfDq/CwOQ7wTAhY2GHJrNmNDHC3RySZ+QEtMaqq4h4ny/plJA/OSKd4//REoDr26nJ1MwFnVxfn55HqY69FxR2mqFaSuwRWu07LIFdcLOkboDaT19EXi6SvNSF7IQ+AsFtXT5Hm8fwW6FpcZxPvbdWb9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB9968.eurprd08.prod.outlook.com (2603:10a6:102:35b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 16:59:29 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 16:59:29 +0000
Message-ID: <3dc36e1d-92ec-3466-523b-bf19ccd04f83@virtuozzo.com>
Date: Wed, 21 Jun 2023 18:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/5] parallels: Add duplication check, repair at open, 
 fix bugs
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2b29c3-3129-432a-8264-08db7278e05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KQgi4XJ+C6bWlKb5dka3ROxuaXmgOOqe+pU/gTfyYEWNDAtsTjrxjCefyMgtarcmT9/BCoI/X87S0Ms9hnZlhJfkUvgE66mH2UCRiJPj+gUYZUaADbNXLi8FTyWHz/1uSK4Iz0G+phD09qS4VlN+VwhZVpl+7U0rFOEUSAiTduDxHEZ0xF/+CMFUkLI7frzgzBkSOyXpzyIWtI6J9GXT1PB/2yMnXZMIEEF1OxiM6zFzLruGwhq5ksIhyqfJcUpKrJNkgMVK00og19TPeqElnALJbk0pgaJXAhgCqFZOJyScXRIJ5T+sWJMN/xy2w9tcpu8rl3PMxQwH7+BuMb29tZW3DpQik1tS5u9jXpOx8eBPzZmSAH7DCjYccLiu6lbRD1stRjf3WEnJ4UjyruUjXSC0PVVP5g3S39XBBf4MLYWl5946eCtGqTqhud7zyTYeFJhHudarGPf4ooBGi5d2JHOaJ1xOq37BLWv4y3k4vO89tsUmvvSCv6MP659WJAzyiFClHLxiHe3O/3145m6bosPWulfdji2GIGT03P1ClfGov8mdDUkVRK4ET1uBGFkSdrzYT3CsVWtCMOO/aKwQ2N4ANqY1/+Lyg902nPSP29qhxnxKFQlknlR47Aio6CrpHpXEKs6zC6M6A45Q+HTeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39850400004)(346002)(451199021)(26005)(2906002)(6512007)(6506007)(53546011)(186003)(66946007)(41300700001)(66556008)(316002)(4326008)(2616005)(6486002)(83380400001)(478600001)(5660300002)(8676002)(38100700002)(66476007)(36756003)(86362001)(31696002)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09LZVpHWWxGVnIvUXlGSHBSMElKSkZvNnVnbHZ1SVhXaW80T01PZ1p0clNF?=
 =?utf-8?B?VFp2RGdYSDFRMGhHR2ovSGw1UGxmUFVrcVJWU0RTazh3R2doT3N4cDNaelp5?=
 =?utf-8?B?Wmw1R0szZzRlc3oySW1GTXhlNDZqbkNQY3dyb3FTbW50OW5IcmMwTEhLSitX?=
 =?utf-8?B?N05hcllHOThtVWJJM3R2c2Y2Uk9VQmpzRlJRK3QzWklMOEF1MnNhL3A4UUVE?=
 =?utf-8?B?Q2Q2a0JjYm9OWW1JVjZRd1h6bEM3RlVMdlMvbFZzRUFTa080ZUJQM1I3ZFlM?=
 =?utf-8?B?NlV3dnRQbnk3Nk5zRXpSRDk0VEl3emlEUGM4TmwxRlFoU0ZlaXpiQ3BOR1Aw?=
 =?utf-8?B?UWpwL0U5SVFBUG8vc1JWN3FudkJtSjVJd0V5eTZZRHIyaTQxRGZ6WkRUTUs5?=
 =?utf-8?B?cjJRZjdnQ0ZrUVdqREE0LzM3VmpUb0hFUktXNXJ6NlZaSDgwL0JETTJQNnZJ?=
 =?utf-8?B?NWk3M2JrNElScVF3VGsrZ0xpOHlyRy9sQUllT0ZWUzZZNXJFcEZweDNNc282?=
 =?utf-8?B?T0l3M2Y2Wkt2azBKM0NEYzh6Z1Y1SnBad0htMmFLU0kyak5TTnoxa25GejNN?=
 =?utf-8?B?d0gvYXZGcXIydWpWUk95emc4eGZwYitMYUh4b2tlV1dTc1crQWQ5WGdyajJL?=
 =?utf-8?B?bXlWc0FrNlkwT1VPNTczaGx5SzFpTnF0L0VnTHRGaDJ1bFVPaWFRZlZPVGVT?=
 =?utf-8?B?c2M1blRsQkJ2RXFEdVFJNDRRZDhvYUpRck9pL0N3b0p1UkRza0RwVlNjNmpl?=
 =?utf-8?B?akI5dTJNUEdDMDdtbVR5RkRPNk5OMlhwWlB5Yk9pMzF4Z2JUTDFobHN3UGZj?=
 =?utf-8?B?M2phWDdGb2gzMXdldnBVaVdnTHNaWm1mZndOcU9QVUgwNDZhbjNlVG8rREFn?=
 =?utf-8?B?SXpWWStwZitqRUMxaWQ4Zml6c2t6Q3Z2QnkyVDQwRFF4aklZUXpoUmdNY2RZ?=
 =?utf-8?B?cUJ1dlRQYWxCNEwyKzEvdVZMd216UTc4MzZIdkFPb3c5WFdZcjhlbnBxUjQv?=
 =?utf-8?B?Q292b0lvdERJNk0vT2tpYkdUNmRUcjNuZXZIUkZVWEdwd0ZMTENXTXZMNXNZ?=
 =?utf-8?B?anVNZnJPQTJyNmlrNklCU0RBQnVEVEMvQ2dQRDF6bzZ1RSsxaVNKTnBJME0x?=
 =?utf-8?B?bTNwcUQwZlFMOFdROFJQUXIzZmJGTHNKczdDMUJ1Q3Iwb0dvcDRUbTFsNnRU?=
 =?utf-8?B?clo0elVlRDM0MWxadVgwRDJTOHh5cGpkYTNSZGJ3aVliOWcxM0lLczVMaGRF?=
 =?utf-8?B?VThGTmNsTHNoVFpoNEVWS2NiV2ZxMlAvVlorZWo5aEpqc2FkTU0wQlFoU096?=
 =?utf-8?B?WlhHeEpmb1Rsb0lFNkFPbnYzNHpGWVVDRFJwWHJ1MjByK085WXlEVUxGTFU5?=
 =?utf-8?B?NFVwVU56WEJWZ2xodE5CbUJjTms4ekFsT3BqYS9NUnZ3SWxIa3EzVmcwMXcx?=
 =?utf-8?B?Z1F1Sk8zN0VXbHpUUEVRVDZEZDVCOGJkTks5VWhJSVlMSDlxTm13UVYvSk5h?=
 =?utf-8?B?NkUzek9CcU10Nmt6Nmo1eVhwNldScU5SVE1vUTNBbmtDS1VkRW5EKzljaXlZ?=
 =?utf-8?B?UnAvWHpwN3lDSTF5dFpWdzVxQU9ZNHFkbFBpT3JqOTUzTTAwdU83NkNKVFNN?=
 =?utf-8?B?UVlZRDVXcEdCUXd5akc1YXhFTmdwRTVUWWVSS2tpUWZ3dVJKeWErTVdUUG5u?=
 =?utf-8?B?ZFcvblpwSE00WFBzOXcyRGN4Q2tjVlJwMW9CZkxudXYzN241Q0RyaEJ2NUND?=
 =?utf-8?B?NEx1UFczcitVTkFtNk5HK0tVa3BmQTZDRTVPUjlKaExNY2pPK1YrRm9pL2Ez?=
 =?utf-8?B?YWthSjF1Y1NRbC9TbldBdzdlYkE0Y3pLWnJsWXJ5MkphM1FyMzBpd2F6dUxs?=
 =?utf-8?B?aTA4YmlYUXB2RHMyRWpyQmV5Z0QyTUZKVTR4YVdQOWs3dHJzSXlUUjBpVUFV?=
 =?utf-8?B?b0l5ZVROaGcwbW41TEVDTFVaTHo5K0FMMUtHQnM5d2NQRDFmT1J3eVcwTUJH?=
 =?utf-8?B?YVJmN1Ywd2ZiZTJReVdOWmFYUWZ5bEszM09XalZ0Wno5WHVHY3cvZEhpQjlT?=
 =?utf-8?B?NktvcmVrVXgxclJYRUdKcUJVdldiR0Q2bklQOTl1WVJnb2Z4MU02VC9OK04z?=
 =?utf-8?Q?0O7i/cOrqmjwBEn2yxb0uiZVa?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2b29c3-3129-432a-8264-08db7278e05c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:59:29.0068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffgt2dLAJW0weQThcP+/bFBE2Q8/PBUswhEXtJnpLKw8n940xBRQ/WoZTxPR1BnhyG4yljjBDO9wnQrrrIGT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9968
Received-SPF: pass client-ip=2a01:111:f400:7eaf::72e;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

On 6/21/23 10:20, Alexander Ivanov wrote:
> Fix incorrect data end calculation in parallels_open().
>
> Check if data_end greater than the file size.
>
> Add change_info argument to parallels_check_leak().
>
> Add checking and repairing duplicate offsets in BAT
>
> Image repairing in parallels_open().
>
> v6:
> 2: Different patch. Refused to split image leak handling. Instead there is a
>     patch with a data_end check.
> 3: Different patch. There is a patch with change_info argument.
> 4: Removed changing fprintf by qemu_log from this patchset. Previously 3rd
>     patch became 4th. Replaced qemu_memalign() by qemu_blockalign(). Got
>     rid of iovecs, replaced bdrv_co_pwritev() by bdrv_co_pwrite(). Added
>     assert(cluster_index < bitmap_size). Now BAT changes are reverted if
>     there was an error in the cluster copying process. Simplified a sector
>     calculation.
> 5: Moved header magic check to the appropriate place. Added a
>     migrate_del_blocker() call and s->bat_dirty_bmap freeing on error.
>
> v5:
> 3: Fixed a byteorder bug, fixed zero-length image handling and fixed uint32
>     truncation.
>
> v4:
> 2,5: Rebased.
>
> v3:
> 2: Added (size >= res->image_end_offset) assert and changed the comment in
>     parallels_get_leak_size(). Changed error printing and leaks fixing order.
> 3: Removed highest_offset() helper, instead image_end_offset field is used.
> 5: Moved highest_offset() code to parallels_open() - now it is used only in
>     this function. Fixed data_end update condition. Fixed a leak of
>     s->migration_blocker.
>
> v2:
> 2: Moved outsude parallels_check_leak() 2 helpers:
>     parallels_get_leak_size() and parallels_fix_leak().
>     
> 3: Used highest_offset() helper in parallels_check_leak(). Fixed a typo.
>     Added comments. Replaced g_malloc() call by qemu_memalign(). Replaced
>     bdrv_pread() call by bdrv_co_pread(). Got rid of keeping bytes and
>     sectors in the same variable. Added setting the bitmap of the used
>     clusters for a new allocated cluster if it isn't out of the bitmap.
>     Moved the leak fix to the end of all the checks. Removed a dependence
>     on image format for the duplicate check.
>     
> 4 (old): Merged this patch to the previous.
> 4 (former 5): Fixed formatting.
> 5 (former 6): Fixed comments. Added O_INACTIVE check in the condition.
>                Replaced inuse detection by header_unclean checking.
>                Replaced playing with corutines by bdrv_check() usage.
>
> Alexander Ivanov (5):
>    parallels: Incorrect data end calculation in parallels_open()
>    parallels: Check if data_end greater than the file size
>    parallels: Add change_info argument to parallels_check_leak()
>    parallels: Add checking and repairing duplicate offsets in BAT
>    parallels: Image repairing in parallels_open()
>
>   block/parallels.c | 228 +++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 195 insertions(+), 33 deletions(-)
>
could you pls also include tests for this functionality for the next 
iteration?

We have had this series some time ago but it was lost

