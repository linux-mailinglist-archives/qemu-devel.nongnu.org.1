Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B900273DE7E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDl21-00088H-7a; Mon, 26 Jun 2023 08:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDl1s-00087j-Dw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:09:13 -0400
Received: from mail-dm6nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::614]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDl1p-0006cy-BO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD6mdWPlEHg1bGlHF3nzzEyvlb5JxW+tUyRhaakT9CVNtqsvy2OLgKei3ylxz+ddSl0SW2B+PaxJwWCRb5n0/kl+K+nFjVn+99zxG+XF5gUKO6KxutA+f6ZVZEAZCq2Q3LDZ3p+mRsKTqxhZJ1ikGUL+0+AZbWQ+ZZnOyFqS3xKIdH4ErG83mLyta1t56AIUEgFFeHWRUoul+n5MhLsLCe7SKf7g74Nax3rgCxbuCMiWFdFHe0H7oNKpl+WrrT5dG551xCE0leduRIdKdpn3DYGGz3dJ7m/ONNiGNkvDUDZGLgwwpDSMoZG6pYxxDUUrvz2DPUwrwYlDqbqgBOfa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBjQaA9lj/yI2rdjC1S+eEL3+1iJhjXiusc7uJdzdeQ=;
 b=igChaOfWg5Zehuxf2pcU2t/zALZG5ATPih5bc2yvPJDTT8U7SHkNiXHk1rLjdLIFBSfFsQC3OnQbqn8EbywnxGzmMWRPD2fCNWT1Les0DsmH9VSrsW40OsOpz3WvgwXCVfWVzFdD9RGu9lgXMWt5pUTNa/qs5P0RYAzZol1XuNCX+QGNiLjiOc0xKA8vXsLF2g6YcIBXqQhbN2Dm8sM5zL+yBa43s9hLzTeyVs6/TR+2znlXgXnif6LYNjCASJpl92gXIzsjBpW70Itro2WL4LthrrbviqZ6biU2j6e4x0B+bleU05CHYb21EFAh9/hJ6cUM5EDWQTz1PlPGu3H8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBjQaA9lj/yI2rdjC1S+eEL3+1iJhjXiusc7uJdzdeQ=;
 b=Gbe+TrPqtNr4dWlQ05RS6CnPGziU5nGFr30irb8BeskytHnu32RzruYGJvKgHHSoENbpTAqIO4IaOyIa1yKYptscchshqVz7dXpsIOKRTeE6ijCwLPaDPBt0VbdZNixPXJ1j0WfFqgQ4zH9RLfTIV1Z5vpr7kkxqvpKVKD5l4/N0YMGWkpCMfZsQyg3qME80pHAkdkicm7bwjyp738H+1K1UG0FCn7NjMpvMzh2DLdLcac5djby6ylZSft3PaLapxtNH1KTYX2rE4zOOPJOhOsEHSr9jusJ08aeCNnBC22mRrtkS1tCrnPJ1/IQk4EY+1pzRpa+UAprDOXlt0iXhMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 12:09:03 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:09:03 +0000
Message-ID: <9f9576bf-081d-5a9b-7698-5055c3b6ee28@nvidia.com>
Date: Mon, 26 Jun 2023 15:08:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] vfio/migration: Reset bytes_transferred properly
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-3-avihaih@nvidia.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230626082353.18535-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb43278-9a03-4546-38a1-08db763e21bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQQv6rGwXq2BGC+HHTIaVoLxQdpQw1J5/yjNyxCQxpxklnp4gYgARBrC1V5JDMsfVTobXUFK97pXsjieaWFm+Mm/Zo8bU136AMgJX35XjmmNQ/MoSEWZFoj/9XUVz/ky6FXkZ4w+nwQmMRJjixbQhINEuJe6f4JzHSQtrt2DR+dmrOt7ukRwkZGHglfquoH0kRQZ/toQfmREyQnWCql2wDycqbUcIle1Mbu0/UCE2Rf73hioekFSvTIVa1jZvYHMVoEvIZc47xpUr8uPUfAu7zt5+0mOuiLRNDboKjyt7GBLx1pG1us94edzRsA8KobgWHwtbAETqsmlt30NlkHem/XX3M24oInda3ld5LqrgMRcPVNRDphrxBoUskk8khm2G9O+W46RcAwcp6/e61vuA9/eQhaHDB2a/AkTNowPklbALZ++r5vgo0KwaGsLG7kQ3P+U5QTOBEm3+N6BmVrNEKaQ96/mb0HwRkGoo60nf/i26b2ZkJ5dF0AjwXxHtVbz/aG9l6dan0z4IixpyoPCIqR/b6LBf/s1JN++5xPp4UxrPdf1XHhWIMm0GQlwmcpMTFJM+NncVEy7ilYMZl2yaLVnhjTDkOApapdVhc+5rLBx0ZFo4BCPjT+LiEA9WQ/h/FvVZuNA7z8yFEurS07Qxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(2906002)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6506007)(26005)(53546011)(186003)(31696002)(86362001)(41300700001)(54906003)(478600001)(66556008)(66476007)(6916009)(66946007)(4326008)(316002)(36756003)(8936002)(6512007)(31686004)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5BR21QVlJpcC8xSkFBTlFnMGx0S1NndHNSbVZIbmhOUHJ1NzlwaUt2TjhK?=
 =?utf-8?B?MG11MURlK0ZOTjJrQmhBcm5SV0NpcldXRlJSV2xqSUFJR3dybnpDKzh0WHdx?=
 =?utf-8?B?ODdiMGp2dnMzVklPVnJyN3pXRWI0SUFMKzBOQ0NpQWNERFhaaDFScUJWWHYy?=
 =?utf-8?B?Si9ycndHVTBBbE51dlFVMEtsN0J1SzZldEtMY1BLUFhyN2hLcFRIMEY3SjA1?=
 =?utf-8?B?WkV6aW43RWxqVndMZ2EySk9PMStNN2hpaGVyekVta0hiVGZ2K3MyWWJIcDAv?=
 =?utf-8?B?Q3lWbVdWVjN1MVY2ZDBJdGtxd05xOGlFcGhkaTlLcFY5c2pMMndRRzB0YkNr?=
 =?utf-8?B?VWlKMGptK1kwS2FYaTVWYTZvMVZINGdXR0NYS21JeFFaWE5xN2h5ZjdOMEFU?=
 =?utf-8?B?djZUai9QcEpOYlE3WWRwZ0V4Z2RzWS9XQ3d3Y0M4NmtMN0dYU0ErZWRrS3Rs?=
 =?utf-8?B?aXZ4WEVvSVQwaVloZjBrckVXdFR4WHppRDFwc1djcHhZclhjMis1NHFHUGM4?=
 =?utf-8?B?ZFF5cEhOcXJuMlVhNkZWREdPTlVkbkZlT1g4V1ZDTTQxaVdwdCs4SjM4dW5r?=
 =?utf-8?B?dnV1a3lSMmM3TVZhOVlhMVNCd3dBQ241ZkFNUFlTOHNTOWNPdUZmTWF2YlIw?=
 =?utf-8?B?aTRST3YzYnB5SGFHTlhWdkoxQVBnNnczbzlyYlh0aFZidGE4OWhhOFloZXRx?=
 =?utf-8?B?RnltaHNCcHUwekdjbERQKzZqUndFdlpwNXdkQkQ5eVFQZnVyVnQ3UExVa0Fv?=
 =?utf-8?B?NjNPTmk5M29SdDBsT0RtRmlBOW4yNTlPVDluWHBTZ1dYRGlkZUgrYlFKUS9l?=
 =?utf-8?B?WjExNVpENlN3RlNLVFhWMEw1K01KVEc2VThiVWd1VXBGbFdsdVBzT0J4TkxS?=
 =?utf-8?B?U0N6ak52QS9qendkRkhFMDh2L1hsNTRsOXBia1FIcEVWNDNqYkxtV09XRURW?=
 =?utf-8?B?OHBIaU45ak5KZFFKK1gzaG9nbnN2YlprYXBwYmI4aFUrZVRqTGg2RGlmVEhY?=
 =?utf-8?B?ekI5Q1FTamNKUzhQQnpJSDlPNEVwTVZXUE5ERXMvRnhvdG4vNWtlNW5BYVND?=
 =?utf-8?B?V1Z3Nk1JWWJoQ1M5Y1BkMHpyU3IwSWdrczlIZkpoVHBGOUt4ejcwS2MrMmpv?=
 =?utf-8?B?ZnZlMEd1eE1BZ0swMnVnbGpIMFZNbjRYSW5QakI2LzBuR3dxY0JVZTlPVnc2?=
 =?utf-8?B?b2NLSk5xMzVyb1VOMVBpL1NxbnNvdlorc3Q1aTdlUXRqTUVYT2RmQ2hkLzYr?=
 =?utf-8?B?NjQ1UDk4V1Q4QittdEZrUk5QdlhzeTgwUlBQcnhWb2tMNTd5eU1scEkzeW1L?=
 =?utf-8?B?akN5M3dEUkJwTllHNm5ES3llSTRWenVPVFYrMjljdDEwN3dRZHNQM3FMbXFL?=
 =?utf-8?B?MjlQVUl3amV6ajNzdkdzUWZkbDBTMWtqTW1VUGkvc0owUkxBYUNuU21zMHds?=
 =?utf-8?B?VFk0OUpzZGt5cXovWDRVamZiTmdXNDhPRFhPc01ZOFd3VkFBK2lwMHI3Nisv?=
 =?utf-8?B?MlJrclZTaUdjczNoRTlEeVRsdDZCRE0vbjNyYm0vRm8xVEpGY1NzalJuY1dX?=
 =?utf-8?B?Q0k3cDFwMWFHeUpwT0RYdUNUL2wvRGVtYkxJdFJKYXVwcVdzNFh0MWdhcnp3?=
 =?utf-8?B?MjhYVDVjSldNbjdNTk5PVTllamFETlp1emRnOTkyM0p2VTVnK2EwTENrSFJK?=
 =?utf-8?B?QmYwRElTb1c2azQyS21wNElONStlcUlaWGtGOExSNzNzWUhWckJkS2VMbkhN?=
 =?utf-8?B?Zi9hSmhIQjRVVmJKYVB3M2Z2U2Y1Y2hLVURYNXVueVFwR3dIR1JFTS8yL3Ju?=
 =?utf-8?B?eDBidlgrRXE3amJRU25MMmFEMDNhaGxleDBkTkhrcXAvUTdLaTVrWmF6bmc0?=
 =?utf-8?B?TGZjWkdGcG8vN1ZGUVQ0MW9EblFBWmZiRW9FQzhwVWdicVhSdEk4OFM4djlt?=
 =?utf-8?B?Rk1iZStaMlFvQmIvUjZON21vVTMwckVSdUNhREo3NmdBNTJDVWV1SExsaDh3?=
 =?utf-8?B?TWZNODZqZk53WVM1b2prMUFacU5oakg5QmZDMHFWaE1DOTU4cGZoNGl6Nm9S?=
 =?utf-8?B?aXZlaUk1dUxnOThYeDVGeWtaQ1BlWnBOZlZqZ3pvbmNMMi8zZFNhYzJzZFVJ?=
 =?utf-8?Q?iO0ZlVMUZogXMcaub3+8xcC6n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb43278-9a03-4546-38a1-08db763e21bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:09:03.1697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5KiV8WIaZj2J2NCqlVzmqWUq6y/3Wh39Pm65Tj+6PIiIJDCIQNCoMyyQ1G8aElyLmBK+1yasXJyYIkoqRthXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
Received-SPF: softfail client-ip=2a01:111:f400:fe59::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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


On 26/06/2023 11:23, Avihai Horon wrote:
> Currently, VFIO bytes_transferred is not reset properly:
> 1. bytes_transferred is not reset after a VM snapshot (so a migration
>     following a snapshot will report incorrect value).
> 2. bytes_transferred is a single counter for all VFIO devices, however
>     upon migration failure it is reset multiple times, by each VFIO
>     device.
>
> Fix it by introducing a new function vfio_reset_bytes_transferred() and
> calling it during migration and snapshot start.
>
> Remove existing bytes_transferred reset in VFIO migration state
> notifier, which is not needed anymore.

Forgot fixes tag:

Fixes: 3710586caa5d ("qapi: Add VFIO devices migration stats in 
Migration stats")

> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   migration/migration.h         |  1 +
>   hw/vfio/migration.c           |  6 +++++-
>   migration/migration.c         |  1 +
>   migration/savevm.c            |  1 +
>   migration/target.c            | 17 +++++++++++++++--
>   6 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3dc5f2104c..b4c28f318f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -228,6 +228,7 @@ int vfio_block_multiple_devices_migration(Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
>   int vfio_block_giommu_migration(Error **errp);
>   int64_t vfio_mig_bytes_transferred(void);
> +void vfio_reset_bytes_transferred(void);
>   
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
> diff --git a/migration/migration.h b/migration/migration.h
> index c859a0d35e..a80b22b703 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -514,6 +514,7 @@ bool migration_rate_limit(void);
>   void migration_cancel(const Error *error);
>   
>   void populate_vfio_info(MigrationInfo *info);
> +void reset_vfio_bytes_transferred(void);
>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>   
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a8bfbe4b89..79eb81dfd7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -704,7 +704,6 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       case MIGRATION_STATUS_CANCELLING:
>       case MIGRATION_STATUS_CANCELLED:
>       case MIGRATION_STATUS_FAILED:
> -        bytes_transferred = 0;
>           /*
>            * If setting the device in RUNNING state fails, the device should
>            * be reset. To do so, use ERROR state as a recover state.
> @@ -825,6 +824,11 @@ int64_t vfio_mig_bytes_transferred(void)
>       return bytes_transferred;
>   }
>   
> +void vfio_reset_bytes_transferred(void)
> +{
> +    bytes_transferred = 0;
> +}
> +
>   int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret = -ENOTSUP;
> diff --git a/migration/migration.c b/migration/migration.c
> index 7653787f74..096e8191d1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1628,6 +1628,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>        */
>       memset(&mig_stats, 0, sizeof(mig_stats));
>       memset(&compression_counters, 0, sizeof(compression_counters));
> +    reset_vfio_bytes_transferred();
>   
>       return true;
>   }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index cdf4793924..95c2abf47c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1622,6 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>       migrate_init(ms);
>       memset(&mig_stats, 0, sizeof(mig_stats));
>       memset(&compression_counters, 0, sizeof(compression_counters));
> +    reset_vfio_bytes_transferred();
>       ms->to_dst_file = f;
>   
>       qemu_mutex_unlock_iothread();
> diff --git a/migration/target.c b/migration/target.c
> index 00ca007f97..f39c9a8d88 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -14,12 +14,25 @@
>   #include "hw/vfio/vfio-common.h"
>   #endif
>   
> +#ifdef CONFIG_VFIO
>   void populate_vfio_info(MigrationInfo *info)
>   {
> -#ifdef CONFIG_VFIO
>       if (vfio_mig_active()) {
>           info->vfio = g_malloc0(sizeof(*info->vfio));
>           info->vfio->transferred = vfio_mig_bytes_transferred();
>       }
> -#endif
>   }
> +
> +void reset_vfio_bytes_transferred(void)
> +{
> +    vfio_reset_bytes_transferred();
> +}
> +#else
> +void populate_vfio_info(MigrationInfo *info)
> +{
> +}
> +
> +void reset_vfio_bytes_transferred(void)
> +{
> +}
> +#endif

