Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4C73558F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 13:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCpU-0004MA-Q4; Mon, 19 Jun 2023 07:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBCpR-0004Ly-Ny
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 07:13:49 -0400
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::614]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBCpP-0003ha-7U
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 07:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMjL1usOQMzY5yUV0YJyqrJaDruFcYpYA6Dut3qqMulAkoNsFMoqsSYdUlMEmWGMWkt3zIga6ujh2VPr54i6F07IdUPiUZzHUZQ5pM8OAgGbksRyCo+DMudSk/L2JOR1jb27hFksTSAEbwVhQM4gT/t/ORa9TpiooZ9aMPn+tbyBPP42yLTMhuLQn+6wxkZo9A9RbONeV6HRILDL/6/xF2S/SyUq0PKtiJmmfL1wNiNjQBQwdDEVtM6mo4YE0LNPZw3wNTGoFG4siXlTfuKdTF1H2CbQ81WBRnquX/Nrcp5WqbgLcrwE0+wlKDB40NqHMphtnjQCrnxv0tIDNIYdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ueeyPUUMFHk5oIZsj0nM4LoEhMutOxSKFKQ1ajbAfA=;
 b=oAU1Ew6FbY0i6RKvSbnxe1JfAgjW/ye7HkBbIx2zMnu7xDs8vrHgoGMUgXk/iTNdw/lzJDe010M+Pel1WdshZD5yGHyDT225u3zWFwpVx5rS5FdYHbPSO0qd9r8GFOB6sEptLpqxZc5CeVMJ+qIWfM/xz1VnRje4U11A3wt8Z3ay5SziPk/x9lPo1MK7Ulq1Q7SIrSeiquKkTuzf+wJ6mrWV5FTPENyn94zLNEPu2oY0Q37d1XGy0WwgaftASNVFFmsvO7rbrgdnIztIsODTZl9JkdoUrQLUf5nUuGTaB1ZbzMt9XZPBiUaA+gd0sTp6ypODv7GG2bAjW4wiNW4ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ueeyPUUMFHk5oIZsj0nM4LoEhMutOxSKFKQ1ajbAfA=;
 b=ITPX8IfVDuQBhKSg2TK4HBZ4X6byD9SlqtMudGtggl0tPIEeMflo6CMYe/Yxlf6KHUlCuUa77YxhrkC0hR4LyenZOxuzYVgvx6+g4sCDLoYgrGdfOshOaYZ6bhkI8eSUrdeUHKMui1mYAmobZx5X9gKy7s0ciEtNUb7xKy2m7p86QBI5Xl4VeHCFOrXmr5e2yZlbzcZ4Gqsx7HBqxE2G4kh6I3RBNoHjh4ZXRdANBpTn8zt30fd6jlvSdK+h+AxGa0pWPbzhKAqDYfLx+kbEUyHACBCH2VZ9od1mzK8BNWKhigBlZfek2tXIx4+bdLZzsAMPnEtt47oaK3mP55JefQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 11:13:43 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 11:13:43 +0000
Message-ID: <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
Date: Mon, 19 Jun 2023 14:13:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 chao.p.peng@intel.com
References: <20230619084446.399059-1-zhenzhong.duan@intel.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230619084446.399059-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 64773d1b-688f-4ebb-9cf3-08db70b63e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Yson0N7cIa0gbNX056qqFwoIQpPQeCHCXNxnD6SXiTQZfeT0SPFK/QiIPDu4DOWKr0ye9QSOM6fQoFhYv2Csw1LSNlNyW2Y6UL5ehElV+phvew05U3+iG+qzUYJDJ3rHNB1l5MMqL7rcMg2bty5Si9vutkMtWOCTI1UhZlRIKHyAGahnK87AWX0QvVgqiB0psOZwjUSojE60nZMfDqu+PUhVheCzwn+zFDOUp4ffs183dA5Mwgt3Sgb0r7XyNzvWPBrZKFqbVDQ8VjY9J1fUjQmzTZ/PdztaFFUzj7ON0bQ8Y8elwItXEqysb8XTwqmKlyrDJxrIZSkQqcCAHFTpiIkkE6+jZeiEp1osKlSQ0rhMA0i0j+dHiIf8XzWTA5W+L+3GmqkEk0+SlIj0ydPpx4SLhv/KxyeLnUwMgLYCJJiTLaAfUomvT4WWxKP5BEj+DPumdy7u4ir+vOoSFB5rsswDo/ps1N//pB/RF+YrK9wZhuxGk3wKX7O1U43Y53vWCb/oHn7jruD+GCrWWgR0wTXdu4HPF15I6vv9NZCTbqBUH5R/a16tLp+ZrMIA7kcZAYSyuWVsCKBz5G9L3gLt3jNe2SXFNf1N3Ph5mLiQgS21q5M4w7FwcQh8IFL4V2j75wpa9JSD93hd+AQbEWlhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(53546011)(66946007)(8936002)(8676002)(66556008)(66476007)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(31686004)(41300700001)(38100700002)(5660300002)(4326008)(316002)(2616005)(6666004)(6486002)(31696002)(478600001)(2906002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2swNENpRzkrYnhxM0FlN1ZodWVNdUowdmZZR2M0REozeVVrQllYRFduTDJ0?=
 =?utf-8?B?enc5dExvN1lzemlSTnpzUEhUSDNoVmNDMVlzZ3FFbUd1VlNPRUNId1FjSkR5?=
 =?utf-8?B?elUzRkJFb3hJODZmYmlFM3BTVFdlVW5idEY0Nm5QSmVva0pRZ2pYWDlxelB2?=
 =?utf-8?B?c01qaVRyWkFYSEFuOVRSaHhUWVd6OUp0Y3ljK0FPaFhQYUw2K2JjcmoyS2NQ?=
 =?utf-8?B?UXFUUXNQdURqTGhpVUo0OHQyOVVHVFFTVzZLS3F2RlpCT252S1R6NW5hOGdu?=
 =?utf-8?B?cndLazV0cXJEVnBiMGh2L0hBNXdicnZGeGJtSjR2c1I4RUY1bHdFZlFtbGw0?=
 =?utf-8?B?cldoYWwzOFFFU3N2aDFSdlI4aUFxYm03S3NlU3JMSldxUXpNWlR1Qm1sYlIz?=
 =?utf-8?B?SUtUdUdrSWVNbUlSS3JXRldBM3dNb0VWWGRaQUQwYjB2Y2IxQVlJdlVHdHJ1?=
 =?utf-8?B?WmVDYW9tbGIxUEV5K3haNFRZK2V4MVZXWUFIQVVhMkhsYWR3MitVMEE3a3F1?=
 =?utf-8?B?emI0aUIyYmJnQU12anp6MDBhZ3ovNWFZRWV5TXRzQXlSQ2JXQ0pvQlVRZFZK?=
 =?utf-8?B?cTVoREJZM0JacXhlN3VtMEJBRWpqR0d6d2JweWE1a3JJL3MwNWpwUVhBRmo4?=
 =?utf-8?B?T3ovNkJueGpsa29mcERDNTNSb3hJNVFxRUhuL3BxeGlQWjNkVFZLa0gzMWhv?=
 =?utf-8?B?VTlMakJuRnNwc1k4QmhlOExQb1A5cHBQV0FSTHNyaXA1bGVhbjJ2Y2dQV3N6?=
 =?utf-8?B?OGRCaHl1cUFVMkJnZmUrems2UG1DelhOdHJzOU1iNk9hcCtCYUxaNzFrWE5Q?=
 =?utf-8?B?eE8xQ1BLcmlQV201YUJmSjIvODJUTER3eFNmMUQ0bENnSzJSbFBGYzRla1dD?=
 =?utf-8?B?dExlV1pieVRvRmZvbEV6UEVOQXd1aUFNMVByWHBCWXZjc2MxZWFZOHByNHAz?=
 =?utf-8?B?WEpDUkc1b0ovK1NJSlZoQ0tkb1c4cjBkcjUxTUszSnRuMjhoWm9KTnZhMWp5?=
 =?utf-8?B?ak0yb2RRbk9IV3YyR0VVR0dRZFJqOFZNbVRTOHB0ZXFRMVNYOUQzRWNqMThD?=
 =?utf-8?B?bDJGdVJXR0VlZGlYcGpBQTFIS2o5T3FXSnU3aXluSzlKWDh6UWZVV3o1Zi9q?=
 =?utf-8?B?T3lZYzRvN01JbDJyVmxaajFSdWtteTlSOUtNUytsbGMxL2FROGVqeTNpUzVl?=
 =?utf-8?B?M3gxbGF2NmlyQUE5UzlOYWhQdnlaN2xZNDF2UjNYdC9GNFJGNVVDVVJIbm14?=
 =?utf-8?B?bjUyV0dRWEJlbjFybzdtSGt2bkF0cWRSZERtdkdudDFCS2oxUjc2dmJvRFoy?=
 =?utf-8?B?SXJsT2VvbTRrSVh6aGQwL1pyS0hRZHNIRURNNUxwVnpNRHVSbUx6OFJMU0FP?=
 =?utf-8?B?bTJSdGExYTRhOFQvZjV1U1ZGT1V3YnRiVEZYMkdncjRpdlpjR1E2UUdVNVp6?=
 =?utf-8?B?R2pNQzF6V3EyQ3g3a2daTUtvb1FpamVOeTZxVWttQk9xRHd3YWJxbjNLclR3?=
 =?utf-8?B?ek03ZTBWRnpXSHdlTkRoMklucHVJekRVUTZYanlqZnJFTDRxUnBwTzZiOE1Z?=
 =?utf-8?B?K0oxQno3R3BCVHdzT0syeEYyOGpsZDlBekNuclF0L1FaSy9WdkdJSmF5QXZ6?=
 =?utf-8?B?UHpJTUgxNFBUTWpQaGxTYitwSnppWHJUODZucnZtWW13VWxrSEdzQTc4ZXRR?=
 =?utf-8?B?emZweUJ6VVlWa1AxVElxNEh1Q1ZySG4xS0FYOThucGh1ZHB2WTUza1poUlZK?=
 =?utf-8?B?WmZqUzhrc0xaTXIzVjVkRjhwTHdNWWY3aWlkdlkvYlJvSEFKT3E0OVNURUdR?=
 =?utf-8?B?dDZIVUsyTk9yZTNZQnlPSTZvWlRJcEljeEo4QXRqUWZrdHRLdk1DMk5oWVNQ?=
 =?utf-8?B?b3AvMEplUTBsNzVpNzQ4eWFyVzJPdm1CVEhPUVBrWEVoS09GZlFzSFNVZncz?=
 =?utf-8?B?UnZBWHNaY0NrREtRL0FCT3A2QUU5WE1paHJ1YnpONlRXWUZ3S1kydzVEVFRZ?=
 =?utf-8?B?ZXRnakJaSjVkNHltSFZYcHhuMUV0S1k4QytISnlZeXRBVDZPdXlmTHFYbkRH?=
 =?utf-8?B?dExQL2Z5S0k0NlRBN3VGdmVMek9idnBmVk9YRVlEclJBMUJXMVlxK1hnNHVx?=
 =?utf-8?Q?ynnjVufXhw8Fd2H6GgjY9hxUi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64773d1b-688f-4ebb-9cf3-08db70b63e1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 11:13:43.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSFMyQDV3Bb4UyR+NXr6r7tfpUYIQm5L0EdKLCmUKN3uHjv+MC9TnN9uIH79v+z0nnAOJS+dlhxObUlai6iVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
Received-SPF: softfail client-ip=2a01:111:f400:7e88::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Zhenzhong,

On 19/06/2023 11:44, Zhenzhong Duan wrote:
> External email: Use caution opening links or attachments
>
>
> This patch refactors vfio_migration_realize() and its dependend code
> as follows:
>
> 1. Change vfio_block_*_migration() to be only a checker.
> 2. It's redundant in vfio_migration_realize() to registers multiple blockers,
>     refactor it to register one migration blocker per device.
> 3. Remove useless vfio_unblock_*_migration() and *_migration_blocker,
>     remove empty vfio_migration_finalize().
> 4. Change vfio_migration_realize() and dependent vfio_block_*_migration() to
>     return bool type.
> 5. Change to print "Migration disabled" only after adding blocker succeed.
>
> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
> However, the caller of vfio_migration_realize() considers that migration was
> blocked when the latter returned an error. What matters for migration is that
> the blocker is added in core migration, so this cleans up usability such that
> user sees "Migrate disabled" when any of the vfio migration blockers are active.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v2: Based on suggestions from Joao and Cedric, refactored vfio migration
>      blocker related code.
>      Use Joao's words to update description.
>
> Tested vfio hotplug/unplug with vfio migration supported and unsupported cases.
>
>   hw/vfio/common.c              | 66 +++--------------------------------
>   hw/vfio/migration.c           | 36 +++++++++----------
>   hw/vfio/pci.c                 |  6 +---
>   include/hw/vfio/vfio-common.h |  8 ++---
>   4 files changed, 25 insertions(+), 91 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fa8fd949b1cf..606e23a66514 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -361,9 +361,6 @@ bool vfio_mig_active(void)
>       return true;
>   }
>
> -static Error *multiple_devices_migration_blocker;
> -static Error *giommu_migration_blocker;
> -
>   static unsigned int vfio_migratable_device_num(void)
>   {
>       VFIOGroup *group;
> @@ -381,37 +378,9 @@ static unsigned int vfio_migratable_device_num(void)
>       return device_num;
>   }
>
> -int vfio_block_multiple_devices_migration(Error **errp)
> -{
> -    int ret;
> -
> -    if (multiple_devices_migration_blocker ||
> -        vfio_migratable_device_num() <= 1) {
> -        return 0;
> -    }
> -
> -    error_setg(&multiple_devices_migration_blocker,
> -               "Migration is currently not supported with multiple "
> -               "VFIO devices");
> -    ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(multiple_devices_migration_blocker);
> -        multiple_devices_migration_blocker = NULL;
> -    }
> -
> -    return ret;
> -}
> -
> -void vfio_unblock_multiple_devices_migration(void)
> +bool vfio_block_multiple_devices_migration(Error **errp)
>   {
> -    if (!multiple_devices_migration_blocker ||
> -        vfio_migratable_device_num() > 1) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(multiple_devices_migration_blocker);
> -    error_free(multiple_devices_migration_blocker);
> -    multiple_devices_migration_blocker = NULL;
> +    return vfio_migratable_device_num() > 1;
>   }
>
>   static bool vfio_viommu_preset(void)
> @@ -427,36 +396,9 @@ static bool vfio_viommu_preset(void)
>       return false;
>   }
>
> -int vfio_block_giommu_migration(Error **errp)
> +bool vfio_block_giommu_migration(Error **errp)
>   {
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
> -{
> -    if (!giommu_migration_blocker ||
> -        vfio_viommu_preset()) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(giommu_migration_blocker);
> -    error_free(giommu_migration_blocker);
> -    giommu_migration_blocker = NULL;
> +    return vfio_viommu_preset();
>   }
>
>   static void vfio_set_migration_error(int err)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6b58dddb8859..bc51aa765cb8 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -632,42 +632,41 @@ int64_t vfio_mig_bytes_transferred(void)
>       return bytes_transferred;
>   }
>
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret = -ENOTSUP;
> +    int ret;
>
> -    if (!vbasedev->enable_migration) {
> +    if (!vbasedev->enable_migration || vfio_migration_init(vbasedev)) {
> +        error_setg(&vbasedev->migration_blocker,
> +                   "VFIO device doesn't support migration");
>           goto add_blocker;
>       }
>
> -    ret = vfio_migration_init(vbasedev);
> -    if (ret) {
> +    if (vfio_block_multiple_devices_migration(errp)) {
> +        error_setg(&vbasedev->migration_blocker,
> +                   "Migration is currently not supported with multiple "
> +                   "VFIO devices");
>           goto add_blocker;
>       }

Here you are tying the multiple devices blocker to a specific device.
This could be problematic:
If you add vfio device #1 and then device #2 then the blocker will be 
added to device #2. If you then remove device #1, migration will still 
be blocked although it shouldn't.

I think we should keep it as a global blocker and not a per-device blocker.

Thanks.

>
> -    ret = vfio_block_multiple_devices_migration(errp);
> -    if (ret) {
> -        return ret;
> -    }
> -
> -    ret = vfio_block_giommu_migration(errp);
> -    if (ret) {
> -        return ret;
> +    if (vfio_block_giommu_migration(errp)) {
> +        error_setg(&vbasedev->migration_blocker,
> +                   "Migration is currently not supported with vIOMMU enabled");
> +        goto add_blocker;
>       }
>
>       trace_vfio_migration_probe(vbasedev->name);
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
>       }
> -    return ret;
> +    return false;
>   }
>
>   void vfio_migration_exit(VFIODevice *vbasedev)
> @@ -679,7 +678,6 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>           qemu_del_vm_change_state_handler(migration->vm_state);
>           unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>           vfio_migration_free(vbasedev);
> -        vfio_unblock_multiple_devices_migration();
>       }
>
>       if (vbasedev->migration_blocker) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de12..12b82b3667ef 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3207,10 +3207,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       }
>
>       if (!pdev->failover_pair_id) {
> -        ret = vfio_migration_realize(vbasedev, errp);
> -        if (ret) {
> -            error_report("%s: Migration disabled", vbasedev->name);
> -        }
> +        vfio_migration_realize(vbasedev, errp);
>       }
>
>       vfio_register_err_notifier(vdev);
> @@ -3247,7 +3244,6 @@ static void vfio_instance_finalize(Object *obj)
>        */
>       vfio_put_device(vdev);
>       vfio_put_group(group);
> -    vfio_migration_finalize();
>   }
>
>   static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f34..23ba3654acda 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -220,9 +220,8 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   extern VFIOGroupList vfio_group_list;
>
>   bool vfio_mig_active(void);
> -int vfio_block_multiple_devices_migration(Error **errp);
> -void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(Error **errp);
> +bool vfio_block_multiple_devices_migration(Error **errp);
> +bool vfio_block_giommu_migration(Error **errp);
>   int64_t vfio_mig_bytes_transferred(void);
>
>   #ifdef CONFIG_LINUX
> @@ -246,8 +245,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
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
>

