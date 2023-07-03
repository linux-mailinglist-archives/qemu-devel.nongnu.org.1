Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F68745FFC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLee-0001Pc-05; Mon, 03 Jul 2023 11:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGLeb-0001Ow-03
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:39:53 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com
 ([40.107.237.41] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGLeY-0007Am-EB
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkqlTvvEk4k4p0lJv/Gx3bvlQLxJAPsUaxmFrFaRHMbNzf77BWBm25NfCj8ARknynqZWgANQzJpb7+gzI5kyBvLqzBLQPiIgKvpiBcBmnWfcw/0uXMXI2bg4/ndh7NtemkEkCZgYVpCqD+bcdRKYh6860QRpFcpe0SjLnecC/maHlhnE6BbVJaVQ7xOP13op60z26QvkoRQcT1NpPgNmQ9xRC0qsQY4w/HZFWkY3/RV62sonJXMvXLfbfogndr5avnAzo1tfMrxeZLbHbqGjdNwkps3wOdkzJq2yvxAluGC2vkzsx8tJfugfDbVUF9/RHQ06wrYGR6YgA6pbF6+jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyMnw1fAciRpc3n1rrwvrcoQYPWG7mHHJBWvAFbS/7s=;
 b=SVoToJZ4xQjQitvJv8FROF5bcUvxBeml9d6PV/W/48mHQ5A2GLfVAtuXZbcPLmboZX25XALZAiMTnBYAxhI/8jsnx5bif2L0/sPV7GljvB+X13d4xaewihKl7VFC2OznTurBj2RN67vIll1yotVlxlE3vGaxYzVVp53GagV4L3Sm3/7UriI5LNJFL+/wTDO/7XUPKmBfbVaJjtXtsamWXojt6BwbFpInMlS5WZgRGMIVnEmyWar2yqVvKmKkOduJhGKwVIMZrZjnKmIVDoTqIW8xa81LWMJNZ0VevRkZYhCqR9g/O1tHiEOno2fTrGsW17x94bF5J5GZ5jFaqVisvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyMnw1fAciRpc3n1rrwvrcoQYPWG7mHHJBWvAFbS/7s=;
 b=gznelBYXutQTXbq8u/nygconmcB1Z4SfF3ofLNGRksik4+iJ7TM9bgiVzA51R25Sq6tybVrImeis9/syQ2ujRDVwYGrkzgEKTwkxK+tKyt5xjIv9srPdhQhNAImBUkQUiq1DSaTl0V/ulqS7t2GCKdsCXAnNWQre6bCnvaO6fc6Rq1qHd9pwy4MDSXE/Gtk6beuN77tAAupbhycRq+SnYDsE+s9RrGMoLuITsezXiYG+lDGZkt/7iL7Dp0kL0IntGFVqRBaM4xjgPgcJIre2o/ojVklIu2si5JtmTCyIPrXhBBBwDQaUj8TdTl6i9DEXwtUDxAJ+V0HdzqBEXGjXfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:34:43 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:34:43 +0000
Message-ID: <b94df333-17d8-81e5-da5e-40d935131396@nvidia.com>
Date: Mon, 3 Jul 2023 18:34:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230703071510.160712-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e30b7f-f869-4bf8-a2bc-08db7bdb0610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR94XO2qaV8MZ2nWpsrOkGHxhKQ58ib5d712nYTyfXfQNZ32vejHEQhgWSFSDN8ku7/7MjJrWUEWI7oREzoA7Mh4dDIhXUiUsPe+1SJEw+xUGMkPRB3AfCEKQpOKVjILMQwGKVsJ2agNFDVcKirUb8Q7m6Sj8we9FUlGyL+cdaYOwGRjOK9HScsbfMFfwpW9MoXyYFrwJoX6SGVyEGGkt8ikC26wvVBoNTSo+PlEiXmqtvTbgegJeCkiVBEYBgSkxZvLjonPjg4qwr3hvJX+NObyaTS7Yge+Y9X12xZirWm8wVGsg7qeps9u1De0PsM8fmN1Dj4Oxf1/9Z1emvkQN5qd7bSAWVKPy2clw/41CSqJdOG9PqzJZR9hzpCTnVEhLl5FfKBeG8+RceBAmzpnGGLpWUjonlsaPRnA9qLCxlP7trSpFC3o/3cSd5gBri6lOklo1HWI2XM6BX6fXThaMZ1SvDmOFbuZX/Spw89zIDlIFLN3B97DiQ1UXptqwlypmciji+jInMb9Uf2kjgA4f6OY2kFjm0FJnog+B43JD+lfVCYHt3ilj2OnYFbs1UojALBscqoATRzGkRs+TyjCrzQJUxL+ZO9snGf3aS3CWLwNz0fP9XLnPdG5QpQoUkrAZJtlC267DMFXUkw/aFFZGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6512007)(6506007)(6666004)(53546011)(6486002)(316002)(4326008)(66556008)(66946007)(66476007)(38100700002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZEaUhNRmtqc1Uya3gvT2Z4S2V3U2JNUUN4UkNZQjNMYmRiU0ozU1UydDVF?=
 =?utf-8?B?QU02VngzdjZWRVc1RFN1WjAwSFFXR1lzZmV5ZVJuU0FYd0J3UkxJTHZnTm1p?=
 =?utf-8?B?aHRwNU9TNEJ2TEdldXIwa1FYdUI2RzR4ZDRQTFZJNVF3Y1ZNT29YNHFWR1hy?=
 =?utf-8?B?ZHBTa0Q5Nm1zTXFtVURhS2hFbzZ1U0w4Q1REekF4c2VFOEYwR3lwc3dyRVJa?=
 =?utf-8?B?ZkZLWk1JYmxHS0hpaGJqUlkra3VnbUVYNnlvM3Fqdk9ZYXhMaWtRMWZ6REJS?=
 =?utf-8?B?TTNrMFIwYlhmS3BXd0xHdWNmUzdWOTVjQlRQdEJuakVZaEtsNmUwNkZwR0h0?=
 =?utf-8?B?T0dnRFlyMUtyZktOdm1NdHJGQklTdEhHUGJsa3pJTUJpY1dmY2RGWVZkV1pj?=
 =?utf-8?B?TzhHK3JuRTEybDVPR1F1bUV3NXJSWmxwQjZDSmkyQ2tIZFBKdVE3bXBZbkFw?=
 =?utf-8?B?eEJJUmRIVkdqWGIrTDNrRy90ZmxXcVc0aHkrM2pRaldwaWZZQkhGL1c3L25h?=
 =?utf-8?B?VTk5YWhtLzh4WEZDTFdHMkxRL2pua1g5c2FVUEFVT0owVDNVcUtOTi9PMi9q?=
 =?utf-8?B?V3FCVVhFY2RVd081TzVYSko3ZXdmclFIQmxVbFVoeGZFbExtUW16eFptU1hW?=
 =?utf-8?B?d3lZNmRRTFZvanA1QVhVcW1vOTNHWEJBbGM3VVhRWFRPQm00cGg4UWtjYTlm?=
 =?utf-8?B?S0xxcXljckZFRFBYTWY2L3BOcmU1blFQNTFqRUZlQUhPckpTMFhnc2dkUWJj?=
 =?utf-8?B?dDhkMUlCQTFNc0RBcVIyUmZGenQ0SHloMVdTbU1xUDB6TW1PTG5Uby9GZWJY?=
 =?utf-8?B?V3l2N0xLOXgxeG0yTWlHNE04NmV3NFlrTFFDOEZ6aXZ0V0M4cnpXaVpsdWxh?=
 =?utf-8?B?Z3JRTUFWWEs3bGpjZ1BYamxaTVR0NkJBL241QXlONjQ4V0E1dVlQNXl2QkN1?=
 =?utf-8?B?NXJoaGNrUGpoK3JlOThuUjg5b2d4MnEzdnEveTdmWUtlUU9pYVNhdHQ3ZTNB?=
 =?utf-8?B?Ry9KRVpDdEhQbXYwTXZ1NUNVWUxYNUdZOXZvRkc3SzlGeEJ4YklVTUo4ZXpq?=
 =?utf-8?B?NDhxamkxSzhMUmYxcjdkNnBrZmdRR2VwQ3o2dkJnd0NmV3Y5RUZPNjBlVG1O?=
 =?utf-8?B?cVAxS3ZQVGhqUkFieG4vMm53azN4T3JiV002Q0NhVXVHSUZnMHNVOEI2cUR6?=
 =?utf-8?B?b0hXV1c4bFFYQkVYUWpjak1qc0lFd1BJR01GZ2hKZU5BN2JLNmFFK0Vibzkx?=
 =?utf-8?B?b1JIOVhodU5mWXlMelRkaDRZdXd4M3JmMTVMSXIwQjRpOUsvSFROOEJwVnFs?=
 =?utf-8?B?cWRFYmdWc1BoaTFhajJqTTJ2Y1FybzFOblQwVk4zbDAxZ2kyc0VNWGQxMDhG?=
 =?utf-8?B?aWgwRnFPZnJkMGVqdGlGZ25oZWs0SUNaaTZlNDRMc0RRTmN3bWdkdzE3WnBo?=
 =?utf-8?B?SGRhRzhiblFURjNqMFcrVjJZVGg5c1d4eXdrMkRJWXNCL3hPMXVIWjBHc0du?=
 =?utf-8?B?MkdzS0JkdGYrdE5QbzNhN3FMYlRKZjIvRG5iVzV6enpDd2FnaXhTbm5wdHQr?=
 =?utf-8?B?QmxBZmZmNFVlS21meXRwT09JbWZOQzY3aVRJR1hyVGR0bGdQU1dsbFkzcFpF?=
 =?utf-8?B?d3RkdFdOems0R0tpbGxlZmh4eUN1WEJOZnRtR3h4VXpTVGN3NDNyQXBoY1dM?=
 =?utf-8?B?N3MyMnhjWHNrdmY3bWUrZElhRnVEVll6Q2thREcwWU9wM2IvRXcwWkR1UEYy?=
 =?utf-8?B?dDg4T2Z2RUJlTjRmcmFBb2lvajhydGpsQldTL1FrWkp1NGVlalBEMzdCUEFl?=
 =?utf-8?B?cGhDMmUxbVBEYWxWbnU4Ull2Zkw1OG52Wk1PeVEvR3gwSDdNZUg3UXVDaTkv?=
 =?utf-8?B?ckVSMGpzbS9aWUhPd3hZS1NXR2VSc0M5dm9pYmQxbjlYSnN5Y2VOUDlUaHdo?=
 =?utf-8?B?dk1NUFU4T1NHTmRnMUx6WWwvM1BHUjBRZCsrcXRQaWpDaDJNdWpLcUhQUlpG?=
 =?utf-8?B?S1JxVFNwcUxDUjd2dEFhbU51RzNQTjV1Y1FYR0tKMm10bHR3Z0NVK2s1YWlG?=
 =?utf-8?B?RzNkUkVFbktwUnpmdnZlcUZNS2srWHZ5RmlhaXFBTTNPamVKclg1MVo2MTJW?=
 =?utf-8?Q?z4It0EN76MulTs+W3kjGlEJA+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e30b7f-f869-4bf8-a2bc-08db7bdb0610
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:34:43.4950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRCxjt85KvsLcxDQG563W/mH+N3L6ste2xIA67FgIAyUo8HTMr0siOEUm4MoFsJMSGg/IOST2LBNdhuQhLjt3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
Received-SPF: softfail client-ip=40.107.237.41;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 03/07/2023 10:15, Zhenzhong Duan wrote:
> External email: Use caution opening links or attachments
>
>
> When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
> to free resources allocated in vfio_realize(); when vfio_realize()
> fails, vfio_exitfn() is never called and we need to free resources
> in vfio_realize().
>
> In the case that vfio_migration_realize() fails,
> e.g: with -only-migratable & enable-migration=off, we see below:
>
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
> 0000:81:11.1: Migration disabled
> Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device
>
> If we hotplug again we should see same log as above, but we see:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
> Error: vfio 0000:81:11.1: device is already attached
>
> That's because some references to VFIO device isn't released.
> For resources allocated in vfio_migration_realize(), free them by
> jumping to out_deinit path with calling a new function
> vfio_migration_deinit(). For resources allocated in vfio_realize(),
> free them by jumping to de-register path in vfio_realize().

Should we add Fixes tag?

Thanks.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/migration.c | 33 +++++++++++++++++++++++----------
>   hw/vfio/pci.c       |  1 +
>   2 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e6e5e85f7580..e3954570c853 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -802,6 +802,17 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       return 0;
>   }
>
> +static void vfio_migration_deinit(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    remove_migration_state_change_notifier(&migration->migration_state);
> +    qemu_del_vm_change_state_handler(migration->vm_state);
> +    unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
> +    vfio_migration_free(vbasedev);
> +    vfio_unblock_multiple_devices_migration();
> +}
> +
>   static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>   {
>       int ret;
> @@ -866,7 +877,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>               error_setg(&err,
>                          "%s: VFIO device doesn't support device dirty tracking",
>                          vbasedev->name);
> -            return vfio_block_migration(vbasedev, err, errp);
> +            goto add_blocker;
>           }
>
>           warn_report("%s: VFIO device doesn't support device dirty tracking",
> @@ -875,29 +886,31 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>
>       ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>       if (ret) {
> -        return ret;
> +        goto out_deinit;
>       }
>
>       if (vfio_viommu_preset(vbasedev)) {
>           error_setg(&err, "%s: Migration is currently not supported "
>                      "with vIOMMU enabled", vbasedev->name);
> -        return vfio_block_migration(vbasedev, err, errp);
> +        goto add_blocker;
>       }
>
>       trace_vfio_migration_realize(vbasedev->name);
>       return 0;
> +
> +add_blocker:
> +    ret = vfio_block_migration(vbasedev, err, errp);
> +out_deinit:
> +    if (ret) {
> +        vfio_migration_deinit(vbasedev);
> +    }
> +    return ret;
>   }
>
>   void vfio_migration_exit(VFIODevice *vbasedev)
>   {
>       if (vbasedev->migration) {
> -        VFIOMigration *migration = vbasedev->migration;
> -
> -        remove_migration_state_change_notifier(&migration->migration_state);
> -        qemu_del_vm_change_state_handler(migration->vm_state);
> -        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
> -        vfio_migration_free(vbasedev);
> -        vfio_unblock_multiple_devices_migration();
> +        vfio_migration_deinit(vbasedev);
>       }
>
>       if (vbasedev->migration_blocker) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c2cf7454ece6..9154dd929d07 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           ret = vfio_migration_realize(vbasedev, errp);
>           if (ret) {
>               error_report("%s: Migration disabled", vbasedev->name);
> +            goto out_deregister;
>           }
>       }
>
> --
> 2.34.1
>

