Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C373DB79
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDich-0002mg-Px; Mon, 26 Jun 2023 05:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDice-0002kb-7c
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:35:00 -0400
Received: from mail-dm3nam02on20605.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::605]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDica-0002B9-Mf
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:34:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYoTI1UjFiEOjVlMsNfJD814L+dsPmYWDSdcout5z7ZYQS7uwNfXfy5oKdMCoW6BLXMyFbb3usrOgd2DNh45sIfVso9cv1XsuWIqIrFEIEWW4wU0BZy/Og08p0a6ZVo4a3l34bytlncXjj8hG7vUIJO+aQGwVebn+h27+PeNbMt6yon30KH83J8OwNux8I9sRM9GPLu3cbx/iahSsY2hsiKncIUuMBcbJ48W9Sn4RNJOb/tpKj9rkkofBbvRxmCNVkg6/p+vzeKOFZZSft/0s4CQJ5dI84lVmcjoY7LthE45AIkOdDnd3Gd/b8KsDpoIvNXn6/VkuJsyxvfPSDU6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUlY08Zg0uT+N6JmCV9TZ1/Py5k59UJakhLrJ7DFDwg=;
 b=SN5lHVHQj8/70lrcbsMJtnXuTZhx94R1kZiT2l8a9Zc5M1xhrEtJxH9mAy1B5gJP1cUBGZ9aHgqcK9crolHreDdmSmkgxtxfFFd0HAWHXxmuLlVkRBsiNX1334WF5f0jnzP3A4jlNhyJMN5iI4UcpEvt/jQwBTjCMY7nIQD9JfReX5DHAivmeKakALFW4eopk/+IeZBMqW9TgrzU8NumkHfkJ3/+UkRjTNTeH8x7sfBXUw2P4mT7KHIs/d5JC5rg/dG0rMnYroVVDwIvZbBHdQ7AILVHh8WO91xGeypUsaBLyoDaEoFppiF4qiiiQP5B7yLHvrT0cIjcahtvtlqxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUlY08Zg0uT+N6JmCV9TZ1/Py5k59UJakhLrJ7DFDwg=;
 b=R1Qpr3RXFYqSerRBv3hlO4JefTJHR4OKf285qe1/Xne8JNLUKtQhj9R9C22+ROEkmC9X3X6ubfZZT6UJJUYbkC0p5dErwT7XzjfC2LR8oerxWIWFLVRw+B65ZS5QXePEZ5035kajNRl1Kzt392tgumB/v9Wq7aVZRF0geP/ELGZFY+lt2355Rrdw1RAVZBMXx2wk4Cud23JuXPR8dhGAwNZZs+oeeJM5DxlmoAqTq4wDG+lZruWDWttu2fPdpTwbqaR/hoRAfoPCJSIBW/Jr3lkKOGimDpgbNJvl4OG5EmKOOmcozPU0tqifaQOq+tQ5lx/1Pi0Ts3P+zCnbIkCWyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 09:34:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 09:34:52 +0000
Message-ID: <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
Date: Mon, 26 Jun 2023 12:34:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 chao.p.peng@intel.com
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-4-zhenzhong.duan@intel.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230621080204.420723-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9f2849-bd62-4a16-d81a-08db762897d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23rI/YFhwTEnyWxADKHFl7uNJ8JLCw7tsiCj3tRHOue5voeBANJrPN8Kp2y3i7U+iebt/M6adcnmlNg5o83PGZs7IHWuw4MFZieZTYULq9YxELGvxOSuNsihhlu2X8T61Lnl1w9Mv2aRKxo3s0sEu2wE/csFvx/1uwk0+cFyAfIMRtgOkYMs8DZ4lrl3ZFf0cEDvRkQpd39QttUEHuuoBFDfkNxJ5htfRF1ru8XVo5UVBcUGVd2wQXHytZUVliBT21LrvnM1L1822yWp4JznDKgzNLr8dZ48Bx3/bk8AzyWActwNMb1L8fFeP1oaKLJHBHPs9a1q1v17oi/N7v7CS/FQnhh3KvsBWtrM6YZuy5/BmT1HUkQug0s+Cen+86ujjecNCbq6VwWqDjcGd73ftM71o6il4uoe+fAHTkUNojZ6cvC5DQQTeOJxyvJS5dr4UgBc9huN44xCI5kQAl6yXE4UfSvgpXRbSSZ/69veZUZb+CFMsvPdaqdAc6t7QIqdvOxgTq0cWF4mLTeUH91Tv0rfvot6PdNLpLqkqWY6brDmRIOjOBmoYYjz0m8U9ToPKM4KVzZMHbiYpGJO7ap0eu4KQe4Kdt+YyDytlKrr36KpXBNFzXibIHi+T6kU1xN8r8d0bxphwZhrqHAoPrxu6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(478600001)(6666004)(6486002)(2616005)(83380400001)(26005)(186003)(6506007)(53546011)(2906002)(5660300002)(36756003)(38100700002)(4326008)(66946007)(316002)(31696002)(86362001)(8936002)(8676002)(41300700001)(66476007)(66556008)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tLSzBmeHJqZHhJcysyRmk4OGhyTE5Pc0VtRWNjV00zbXdPQ0pyQWlmcFA0?=
 =?utf-8?B?akdGTjdCQnJtbVRYdmVnQi9yT2t2SGttZ0tBK0NjZlQveDRDbk12SldtelNI?=
 =?utf-8?B?TStTZlhBdWhBRUJmMDNDRy9tTGRETGtDSUh3RTVLcjg2K0ZTekl3WTlxUC9s?=
 =?utf-8?B?UERaSncyc25YNG9oa3FhNUp0TW8wYzkxSHdpS1prRVpMTkhwWEpvKzlZQ0R2?=
 =?utf-8?B?UU9XS09NeWJHb2JvUHhnaHBhQXFLVlFYSjFsa0lvMGlpcnJJZVBzcVFrYUhF?=
 =?utf-8?B?Qm1XOGVNcHZUWGhrZGQ0dlZWbWM5ODN4MWVQOXovbVNnKzY4d3pyODVLd1Ja?=
 =?utf-8?B?dERzYmRSSUdhbWtvb3VoYXpJbDZZWHRtckFZWG9CR3h3V3NiQ3pKRm1RZnZv?=
 =?utf-8?B?RlRGT0pCSDhPWGF5QktsTHlsU3VTdTJ0ZVFvTUZwaStxeVEwbmVFU2J0SWE0?=
 =?utf-8?B?dG5NQ01ValhvaERXek4wME82cFducjVkSDhUa0RuMnNtdUZiZC9FRE5rY2Iw?=
 =?utf-8?B?KzFla1o2NGtvQjBjUE4yUGpJTWp6eWhIbEg4Tk1JaS9MdUZoR09QVEs3VEJE?=
 =?utf-8?B?MXJGUHFmUzdVUStlTjhPVWlKQWc4MHg2RW42VzhYdkhVOXJQSk1Xbm9LRzJT?=
 =?utf-8?B?Uk4vbWFpbUVtd0NCemt0bzJTdUlxZVNwc2JCZU0ydjN4bDIyODBoY1J5dk1Z?=
 =?utf-8?B?YzFyOVlSTUw5TnBoNlYvNWZWVHNNdXJVdEpuUHlWVHNOZHVDb2d6ejlQaWtV?=
 =?utf-8?B?WTk2NStpYitQeHF4ZmtldjBaL0ZzSUhpczlGWFAycDJGVFNCc1Ezd0lqOVZK?=
 =?utf-8?B?SU16c2VXakR0N3VaWDNYU1NpWHZ0akM0RjFOR1ROTmJobVJoeXhXQlNIdEk0?=
 =?utf-8?B?OVVoZVRKc0pHYStrWnFvaldrU0xoSS9oVHVQcENtcjhWNHlZK2xBNTRjM1RW?=
 =?utf-8?B?QldZS2YxU3BVWFE2dnZCZm9EQlA4RG9oNGhYY1Bza3AyaTJObDJmekFNci9W?=
 =?utf-8?B?Tk4xdS80d0c2Vi9HUFlxT1kyM2xJR08xTTQwWHI1cHArcnFlUGRTQ2ZsNGFL?=
 =?utf-8?B?WlJrTlU0ZXlHd0RZWEFjT2h0VUZOTmg3VFFrdURkNTFTUklGemdKQTEvRUNK?=
 =?utf-8?B?UGhCVmNnSU9SVmp0dk1VTmhpMVRkMjhNcmg5UGtyVTBMM2xNaXJ4TGdIVS9n?=
 =?utf-8?B?VnNiMkx0S3hWR1RZL1dGcFczNFNMODRHeEo4QXEvRi80RmF3eER4TVZkcGdm?=
 =?utf-8?B?S04vZXBTcGY2em04K3BPRFUySGJOVEVBclIxaUplSllSbmx1ZWVrWGkyWjNy?=
 =?utf-8?B?dnNWaHBTeVJyVXQ3QjN5L20rUFV0amN2RlpxeHRvdVIyWkRNeUFXd2VPekYw?=
 =?utf-8?B?TVd1K3IwMG1HU1hDd2pYSHFuTlFBVmFCYU0xUzFDZ2dqWnRWVnlaNjZsU1ZH?=
 =?utf-8?B?eitENDE0TEw1TmZNWmlMalBqZmhseEpBTXh6WDBUbS9MdUNoNmZPWFJ2bjlh?=
 =?utf-8?B?ZXhyRkRXM0JFRkY2VjYrTGhMRUkxVmpsZmloQVhJVkhDaStzZ2VpZkFsY2xQ?=
 =?utf-8?B?M0NZaHNyTjVwR0xpYU01S0xSSytzTmhKTXBKNm9hNGFoYnA5WThEZU52dmYr?=
 =?utf-8?B?bUFwQVFlT1lVeHpGdHZHWmFLSnpmTW0xdmd1UlY5aGh3OTFTZ0RWaDJFZEkr?=
 =?utf-8?B?bUd5Snl2QkRRU0xhSzhKVlVNT1h1K3VQeExiWWw1ZHRraFp0a0FUalQxWTNi?=
 =?utf-8?B?OWdtT0FuUWlvZW1TUEI4ZGdkcllBTTR2ajZma25VSjJpVzl6MFBmaytvUWhM?=
 =?utf-8?B?a2g2RU82c0lPR1JxMEd2LzN3QnMzRXhpWVJXenBJTHpVeFBMaUxxaHVwVldK?=
 =?utf-8?B?cXN3dENzaFgyOTM2NTFJVGQrWVhyd0l1Z1RGTXd5R3EwbnNhWGxJSHhNL3dB?=
 =?utf-8?B?aU5CMXlEd0gvWU01OVVmYWN0dk5wc1o4b2c0RW93NzlORHNnbUlxZmU2ZlVh?=
 =?utf-8?B?S2ZFNWdseUxlWXJXZzhmRmJNOXJmeEp4djBwYVYwWmd3cDkrN0JhaUlZWkpo?=
 =?utf-8?B?NHRMbmJQSkxENlhGc0F4bC9ENTNmR20zNUg1MzRWbXBjSWYrcTlRTDdoK0tZ?=
 =?utf-8?Q?eysSRuHAQswwKv0xk+Ujj07RM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9f2849-bd62-4a16-d81a-08db762897d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:34:52.3664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isyWBz2xxrTGId+rADBNXA4ukqjlpBjQ4yPwpr9uIci0vtww+DfAiRJGHYO+yny9/UD5g5yj5t3yBal5OaSQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
Received-SPF: softfail client-ip=2a01:111:f400:7e83::605;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 21/06/2023 11:02, Zhenzhong Duan wrote:
> External email: Use caution opening links or attachments
>
>
> This patch refactors vfio_migration_realize() and its dependend code
> as follows:
>
> 1. It's redundant in vfio_migration_realize() to registers multiple blockers,
>     e.g: vIOMMU blocker can be refactored as per device blocker.
> 2. Change vfio_block_giommu_migration() to be only a per device checker.
> 3. Remove global vIOMMU blocker related stuff, e.g:
>     giommu_migration_blocker, vfio_unblock_giommu_migration(),
>     vfio_viommu_preset() and vfio_migration_finalize()
> 4. Change vfio_migration_realize() and dependent vfio_block_*_migration() to
>     return bool type.
> 5. Change to print "Migration disabled" only after adding blocker succeed.
> 6. Add device name to errp so "info migrate" could be more informative.
>
> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
> However, the caller of vfio_migration_realize() considers that migration was
> blocked when the latter returned an error. What matters for migration is that
> the blocker is added in core migration, so this cleans up usability such that
> user sees "Migrate disabled" when any of the vfio migration blockers are active.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/common.c              | 54 +++++------------------------------
>   hw/vfio/migration.c           | 37 +++++++++++-------------
>   hw/vfio/pci.c                 |  4 +--
>   include/hw/vfio/vfio-common.h |  7 ++---
>   4 files changed, 29 insertions(+), 73 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fa8fd949b1cf..cc5f4e805341 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -362,8 +362,6 @@ bool vfio_mig_active(void)
>   }
>
>   static Error *multiple_devices_migration_blocker;
> -static Error *giommu_migration_blocker;
> -
>   static unsigned int vfio_migratable_device_num(void)
>   {
>       VFIOGroup *group;
> @@ -381,13 +379,13 @@ static unsigned int vfio_migratable_device_num(void)
>       return device_num;
>   }
>
> -int vfio_block_multiple_devices_migration(Error **errp)
> +bool vfio_block_multiple_devices_migration(Error **errp)
>   {
>       int ret;
>
>       if (multiple_devices_migration_blocker ||
>           vfio_migratable_device_num() <= 1) {
> -        return 0;
> +        return true;
>       }
>
>       error_setg(&multiple_devices_migration_blocker,
> @@ -397,9 +395,11 @@ int vfio_block_multiple_devices_migration(Error **errp)
>       if (ret < 0) {
>           error_free(multiple_devices_migration_blocker);
>           multiple_devices_migration_blocker = NULL;
> +    } else {
> +        error_report("Migration disabled, not support multiple VFIO devices");
>       }
>
> -    return ret;
> +    return !ret;
>   }
>
>   void vfio_unblock_multiple_devices_migration(void)
> @@ -414,49 +414,9 @@ void vfio_unblock_multiple_devices_migration(void)
>       multiple_devices_migration_blocker = NULL;
>   }
>
> -static bool vfio_viommu_preset(void)
> -{
> -    VFIOAddressSpace *space;
> -
> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> -        if (space->as != &address_space_memory) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -int vfio_block_giommu_migration(Error **errp)
> -{
> -    int ret;
> -
> -    if (giommu_migration_blocker ||
> -        !vfio_viommu_preset()) {
> -        return 0;
> -    }
> -
> -    error_setg(&giommu_migration_blocker,
> -               "Migration is currently not supported with vIOMMU enabled");
> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(giommu_migration_blocker);
> -        giommu_migration_blocker = NULL;
> -    }
> -
> -    return ret;
> -}
> -
> -void vfio_migration_finalize(void)
> +bool vfio_block_giommu_migration(VFIODevice *vbasedev)
>   {
> -    if (!giommu_migration_blocker ||
> -        vfio_viommu_preset()) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(giommu_migration_blocker);
> -    error_free(giommu_migration_blocker);
> -    giommu_migration_blocker = NULL;
> +    return vbasedev->group->container->space->as != &address_space_memory;
>   }

I guess vfio_block_giommu_migration can be moved to migration.c and made 
static?
Although Joao's vIOMMU series will probably change that back later in 
some way.

>
>   static void vfio_set_migration_error(int err)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6b58dddb8859..7621074f156d 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -632,42 +632,39 @@ int64_t vfio_mig_bytes_transferred(void)
>       return bytes_transferred;
>   }
>
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +/* Return true when either migration initialized or blocker registered */
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret = -ENOTSUP;
> +    int ret;
>
> -    if (!vbasedev->enable_migration) {
> +    if (!vbasedev->enable_migration || vfio_migration_init(vbasedev)) {
> +        error_setg(&vbasedev->migration_blocker,
> +                   "VFIO device %s doesn't support migration", vbasedev->name);
>           goto add_blocker;
>       }
>
> -    ret = vfio_migration_init(vbasedev);
> -    if (ret) {
> -        goto add_blocker;
> -    }
> -
> -    ret = vfio_block_multiple_devices_migration(errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_block_multiple_devices_migration(errp)) {
> +        return false;
>       }
>
> -    ret = vfio_block_giommu_migration(errp);
> -    if (ret) {
> -        return ret;
> +    if (vfio_block_giommu_migration(vbasedev)) {
> +        error_setg(&vbasedev->migration_blocker,
> +                   "Migration is currently not supported on %s "
> +                   "with vIOMMU enabled", vbasedev->name);
> +        goto add_blocker;
>       }
>
> -    trace_vfio_migration_probe(vbasedev->name);
> -    return 0;
> +    return true;
>
>   add_blocker:
> -    error_setg(&vbasedev->migration_blocker,
> -               "VFIO device doesn't support migration");
> -
>       ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
>       if (ret < 0) {
>           error_free(vbasedev->migration_blocker);
>           vbasedev->migration_blocker = NULL;
> +    } else {
> +        error_report("%s: Migration disabled", vbasedev->name);

When x-enable-migration=off, "Migration disabled" error will be printed, 
but this is the expected behavior, so we should not print it in this case.

>       }
> -    return ret;
> +    return !ret;
>   }
>
>   void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 82c4cf4f7609..061ca96cbce2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (!pdev->failover_pair_id) {
>           ret = vfio_migration_realize(vbasedev, errp);
>           if (ret) {
> -            error_report("%s: Migration disabled", vbasedev->name);
> +            trace_vfio_migration_probe(vbasedev->name);

While we are here, let's rename trace_vfio_migration_probe() to 
trace_vfio_migration_realize() (I can do it too in my series).

Thanks.

> +        } else {
>               goto out_deregister;
>           }
>       }
> @@ -3250,7 +3251,6 @@ static void vfio_instance_finalize(Object *obj)
>        */
>       vfio_put_device(vdev);
>       vfio_put_group(group);
> -    vfio_migration_finalize();
>   }
>
>   static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f34..a2e2171b1f93 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -220,9 +220,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   extern VFIOGroupList vfio_group_list;
>
>   bool vfio_mig_active(void);
> -int vfio_block_multiple_devices_migration(Error **errp);
> +bool vfio_block_multiple_devices_migration(Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(Error **errp);
> +bool vfio_block_giommu_migration(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>
>   #ifdef CONFIG_LINUX
> @@ -246,8 +246,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>   int vfio_spapr_remove_window(VFIOContainer *container,
>                                hwaddr offset_within_address_space);
>
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
> -void vfio_migration_finalize(void);
>
>   #endif /* HW_VFIO_VFIO_COMMON_H */
> --
> 2.34.1
>

