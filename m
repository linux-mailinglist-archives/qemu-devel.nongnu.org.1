Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C773DE02
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkfw-0006nS-NJ; Mon, 26 Jun 2023 07:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDkfu-0006nF-VZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:46:30 -0400
Received: from mail-dm6nam04on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::606]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDkfs-0000dk-9C
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBvp6V23DuZ3wOps+pDBqvKgy5mf4F3aw6prykr3f4VMQnU2H3bLqdYeY2LjPBK1NMYdcIFFp8ANDZPTEBDWpBTzGV1QxQadgy9GL9tK96vP+t9rDa6jeg+5rUfz5CCQjSmdZuLBM5PqBzuQWNCFWMV5BDBmXcFUcqA6fZIfObE6H8MCwzMXIUK+p3TM4WOB62MyBp72p9OGfHsJx5W+FC9KSf4w8SaX20qKxVETIbl/jkv8P9nwqH08xdKwVPGy9pHgAqz40ArJDlI6pJdtvmgsWU+isVguCFHETfzFs5prkHuD49DbAQh9SFq1yc+PqMfZJhTAi7+qIeOQio+qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNA/4T4H/fk3OEc+XOSKQWfXvvAtbjdKgQ/Amwm3S2k=;
 b=hGHVwOF65Cu9JKs8ONUm7btZ8aU2/W8qPtl6SWktetmND3m1la6Rs3hME+bw4wilrzLwkVeZq/TiATm/4Ley47S1AG+lGsDY3JLLuLhBzjBrZavo7Nx2vnjvTf1Bpp64MrrpN8HFJQgvZyej1sEHwbjMAHXwnR/4+e2jtxcYrFCJcc7CLvVRk0OYyhtG6h4wllqBiO0hTtJCaIxxoM2yd5TCWjWVopIg6XOrbg7yf0rPOjxujvpNH3KHAdrTf4fhXK8m2XqNRtlZkdqdkR4Sr5vWsr1963+GzFnoaNqnbpnar0q83ZpNiqCP6T7sHiSYXLGeotGHYyZFs8PWqWzUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNA/4T4H/fk3OEc+XOSKQWfXvvAtbjdKgQ/Amwm3S2k=;
 b=czx3yMEqotc9K0nxsQfx1cF+hOfLZeER8DGq/KT68YeyClh10GdvLZzxGeng5UYh31RRDpNd9aJICB1jJe2vAPejSIFWBKEl9jGTnobN2wCDpRa22+Y1vHr+pFiQz1uekc/zQVm3ygvcnhg7pjE0/ZpDvLmT7E1KJfWrmRF18NDH0DaZFa5TdZxJ37pRB8gVzh6yyTBr6c/PAwo0jBy5wU4fVWLRuy932tFZiskRiCsg/kMlVfI/gVrMzDBctIsIxi//GEY42iiwG5Gfy0qriarWOFv+h6QqJK6rP+0xrKJAoTqIUoSgziGZROpA+RSwL8xNBjYC4JeBXK78HCsdKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:46:22 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 11:46:22 +0000
Message-ID: <f7de4168-e92a-4d24-99a3-b35dea431b19@nvidia.com>
Date: Mon, 26 Jun 2023 14:46:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] vfio/migration: Reset bytes_transferred properly
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-3-avihaih@nvidia.com>
 <2d226d72-36b4-747c-3379-a253dc61cdf2@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <2d226d72-36b4-747c-3379-a253dc61cdf2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: efe387ad-61b1-4ff8-c39a-08db763af6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyHUkwNMTnp50StfBfCicFqHmxjllGbjt0mg3xZmalDeFwPdnPl9m3nzjyh6l6Jc1spfKzbDHQziXYVTxjoGFcz7A5sJ2QVHSoffmsPXCi43R0THhLXuxiNe3L3AqFrtOIGx60ASy6kZriTcdZYaYGFNnC56r71Ro1DxMwEC8hdyovwJtBr8Y6Cw0xehgxFkE83gH/Ih/ogLVmXcbGlSv+hNfioBv/Bp+K+GaaFb+miqsrnFN7Hia0mOCz6ybxw41RjZL8AodpX+0gV57BgmJYpghWuUZs5pAgUIWs4JuJZmQEG9WPfvhDVkZCySGeSiZO5yBBybtED9oqmW1R4oNh71M6CYWW0CY/EM4MzmFuG1gVnps/kktxdERnv0/kd+2WbZiQ9HGbYxfYrpTKEg2v5zY8e8apDCvq3CT64Ls7zLVOYLveFiZWoeVIZ49sMcv5RQYXBb/D6nyfavzQsobOPXzzac3xjDJ2ec5sHlEKgXx7M1R17o8NZIeiDvAcGVvyqvGNxJ79LSCYAy+jajlyCcNMMWOVbFuVZerW9YhWbFq399Hz3mcYXYyhaHP21Yn8w+v7HLUUx083DWh1jwAAm1Uv3qQic0KVy822N2q4KnkrDlERrXnPKWSjfOlFmH4mhZEt+vgCky3h5C+HqR+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(6512007)(31686004)(36756003)(5660300002)(86362001)(8936002)(8676002)(41300700001)(66556008)(66476007)(4326008)(38100700002)(316002)(31696002)(66946007)(66574015)(6506007)(53546011)(186003)(26005)(2906002)(2616005)(478600001)(6666004)(6486002)(54906003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZrc1MzYWRHSXBCeHVVOGdXTVMxTUI3OG9CQ0Vhamc4U05vaGtjZ0NRTkg0?=
 =?utf-8?B?REpnc1VDWCtPVG9DdVBvSjUyV3BOYzBLVFpya2V3TnV0c0tUN1U3Zmd1MzMr?=
 =?utf-8?B?aDI4akpFTkFxZXc3d2toNEV3YzJjbkk0ZlRTb1V1N2xtajZvSExwU29pbUpG?=
 =?utf-8?B?eVVUcE5FcjdRQStjUkZEOGlteDlWQk1MNEVvMXBoNENhSHpuSTdJcEIzbjgx?=
 =?utf-8?B?UGh4d28yUlFEa2ZRbHRlS29lZXV1Uk9mRGszSjJHU3krN2xuT3ZoY3Q3Ymcr?=
 =?utf-8?B?QmdobGQ3d29iWCtzNkdDRmw4UTQzMHgxcGZiZTFCTUpuaUN5WHFRcXp5VUxn?=
 =?utf-8?B?SzdBTWhxR1ZGeEpLZ05DazBEQkpkSzNmbHVCcWRtSG00QkdPK2RzQWVHYjk2?=
 =?utf-8?B?T3NNNTlpa0F1Z0FVYWdTTkdtcXliczliOFR5bFN6MUZXMFlaRnZ4ZDZpMFpQ?=
 =?utf-8?B?WVIreDRzdllWOGJFcU5LWmFQcm9KSnNjRzYxMDVZNUJBV0RDZnZKTmZqak1I?=
 =?utf-8?B?bXBSZE9QY2JTNDI4djJmdmxGNWRqbjZZdHovWllkTjBNUHF3dGFTZDFFcFpH?=
 =?utf-8?B?TS92YUNPSStFUytHWm9IOHZod3NoTkphMHhzR1c4RkF5VEFwMlc4TGxwVVpB?=
 =?utf-8?B?WEpRNE1MNWJsMEdSbmRhVFJzeVQveVliYXhUUS9tS1o1Y3hwUEZCc2xUbTQv?=
 =?utf-8?B?cngycnpteXpWWXdlR0ZrVVBWZFNoWnJxZm90dm9OSkdWMlhaWWx3UVlNYjR0?=
 =?utf-8?B?Qmd4OEtsOEkyZEdKbE9GS2NHOC90TFhiZlNEVWRnTDVKcjBZblZ3VFNRUjZu?=
 =?utf-8?B?OG4zZGJSRGNYZEtOWlg3SWx6SnJiYVN6bXBNUEh2YmxtLzFXVWlRTW0wOWlD?=
 =?utf-8?B?YjhFZFZRKzY4TTBobkYwVWFvZThkZ1dmNDhweEUzelRtRk9jb1FZT0YwbGlv?=
 =?utf-8?B?Nk03QTBtb2Z6VlhaQTZuNGhFM0NZWWNHR3I4OXN2dHZTZzFFVGd3bzEwb01W?=
 =?utf-8?B?WHNhcVIycVJjMG04NmxoVUZISDI0UnhreDVoREFqa3Z3RDVCWkpYdis2Tkg2?=
 =?utf-8?B?YVUwT2tSVVFuaW5XVDEwQU15Y2VGWEFQYW9lL1lUL2RneXAwOWZ5N0Zab2l4?=
 =?utf-8?B?NkkxbStFWW5FbGFNbEtEK0FKblFZQUxsYjAraVhFRStCdHJQa1k2OUZ5cjhM?=
 =?utf-8?B?TU4rYUVyS010dHlZUDlEYUVJTUlXelVvQlgvc2Rwa3crZDIzemJmSDRBL1pa?=
 =?utf-8?B?RHYrMnRhOXdEODBjbEFheU9PRXFCSUhhajN2dk5YTUhlYmVTMGJVbUY5UDdS?=
 =?utf-8?B?UVhBT3A3dE14b29Pc2c5SjNyaGZJaThBZFVUSlhZNEdVbjhBZ01qaStycFFV?=
 =?utf-8?B?c3JJQnJVRzBDdzRzVkp0MXYvNGNCM283M3JhdXlHSDhKbDdyaXMyMDhiOGZC?=
 =?utf-8?B?b2sya0NLWmQ0ZmZOOEZMY0pWNzBNME82OVVXNUNtR252TGtUamtWbW1SK3lW?=
 =?utf-8?B?Wk4xNjQ3VmRmOXpHMndnSTRTYjRLQ25GelhIOVVhL2lOUEt1aVRURDBsZDJB?=
 =?utf-8?B?MTNsOUVOSnRmZHU5RXRjS0s2WEpVZEpwREN0Tzl6TThnTUFMSmpLcHM3TDNy?=
 =?utf-8?B?NmtUVS9lZGZDa2tKcWFyekdUcmk5NmtEbUcwZGVaVGtlL0xyK1hMVFRiMHVM?=
 =?utf-8?B?QVJSRUNlOWhEdS9rSWVGZUhHejVwekdXU1pqd3cvY2kxYkxqMXRKQktqbjFh?=
 =?utf-8?B?RFNZaHNkWkxwWUxYUkJhZGkydlh6cC9XUVFlSVZWREg1eXc4S2ZLWHczV3ph?=
 =?utf-8?B?cWNvWVhmMzlFV1NpR1hsQUpWWDl4MFZEbGYxME84NzhVM3BRY2E0L2J5citK?=
 =?utf-8?B?NE83VFRORm1IOUZqc0lnS2NCVWR4V3ZQMHFYNVhxUW5HTkx4T1duZzdWcURu?=
 =?utf-8?B?Tkd0THR3b1BzS2wvUWtyMjRVdmllZVg5WHVzczNVb1YycytjaFZYYnBOTlBL?=
 =?utf-8?B?TFpieEdFVG8yNFVZYkgxN3pqWC9sRmljb0dMUW9NUTNMYk1iUEFCREFGTW45?=
 =?utf-8?B?cWpBc1BGcS94bXowUDNGQSs3NW9uZW5TRE1qeVRUYTZ0bjF0M293L1RZM0lJ?=
 =?utf-8?Q?/ZxtYKGd5TIhP5VGVDTt+pWuB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe387ad-61b1-4ff8-c39a-08db763af6d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 11:46:22.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g7pgoqbmUzKV+rHSppAvbHMW8AZl8PF+hHUGGTEhchjnnwNjCc7WgQ5LdbQo4XF3T48aNHhHmKFuWXSdjfPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::606;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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


On 26/06/2023 12:52, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 6/26/23 10:23, Avihai Horon wrote:
>> Currently, VFIO bytes_transferred is not reset properly:
>> 1. bytes_transferred is not reset after a VM snapshot (so a migration
>>     following a snapshot will report incorrect value).
>> 2. bytes_transferred is a single counter for all VFIO devices, however
>>     upon migration failure it is reset multiple times, by each VFIO
>>     device.
>>
>> Fix it by introducing a new function vfio_reset_bytes_transferred() and
>> calling it during migration and snapshot start.
>>
>> Remove existing bytes_transferred reset in VFIO migration state
>> notifier, which is not needed anymore.
>
> a Fixes: tag would be useful.

Sure, I will add.

>
>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   migration/migration.h         |  1 +
>>   hw/vfio/migration.c           |  6 +++++-
>>   migration/migration.c         |  1 +
>>   migration/savevm.c            |  1 +
>>   migration/target.c            | 17 +++++++++++++++--
>>   6 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index 3dc5f2104c..b4c28f318f 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -228,6 +228,7 @@ int vfio_block_multiple_devices_migration(Error 
>> **errp);
>>   void vfio_unblock_multiple_devices_migration(void);
>>   int vfio_block_giommu_migration(Error **errp);
>>   int64_t vfio_mig_bytes_transferred(void);
>> +void vfio_reset_bytes_transferred(void);
>>
>>   #ifdef CONFIG_LINUX
>>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
>> diff --git a/migration/migration.h b/migration/migration.h
>> index c859a0d35e..a80b22b703 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -514,6 +514,7 @@ bool migration_rate_limit(void);
>>   void migration_cancel(const Error *error);
>>
>>   void populate_vfio_info(MigrationInfo *info);
>> +void reset_vfio_bytes_transferred(void);
>>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>>
>>   #endif
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index a8bfbe4b89..79eb81dfd7 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -704,7 +704,6 @@ static void 
>> vfio_migration_state_notifier(Notifier *notifier, void *data)
>>       case MIGRATION_STATUS_CANCELLING:
>>       case MIGRATION_STATUS_CANCELLED:
>>       case MIGRATION_STATUS_FAILED:
>> -        bytes_transferred = 0;
>>           /*
>>            * If setting the device in RUNNING state fails, the device 
>> should
>>            * be reset. To do so, use ERROR state as a recover state.
>> @@ -825,6 +824,11 @@ int64_t vfio_mig_bytes_transferred(void)
>>       return bytes_transferred;
>>   }
>>
>> +void vfio_reset_bytes_transferred(void)
>> +{
>> +    bytes_transferred = 0;
>> +}
>> +
>>   int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>   {
>>       int ret = -ENOTSUP;
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 7653787f74..096e8191d1 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1628,6 +1628,7 @@ static bool migrate_prepare(MigrationState *s, 
>> bool blk, bool blk_inc,
>>        */
>>       memset(&mig_stats, 0, sizeof(mig_stats));
>>       memset(&compression_counters, 0, sizeof(compression_counters));
>> +    reset_vfio_bytes_transferred();
>>
>>       return true;
>>   }
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index cdf4793924..95c2abf47c 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1622,6 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error 
>> **errp)
>>       migrate_init(ms);
>>       memset(&mig_stats, 0, sizeof(mig_stats));
>>       memset(&compression_counters, 0, sizeof(compression_counters));
>> +    reset_vfio_bytes_transferred();
>>       ms->to_dst_file = f;
>>
>>       qemu_mutex_unlock_iothread();
>> diff --git a/migration/target.c b/migration/target.c
>> index 00ca007f97..f39c9a8d88 100644
>> --- a/migration/target.c
>> +++ b/migration/target.c
>> @@ -14,12 +14,25 @@
>>   #include "hw/vfio/vfio-common.h"
>>   #endif
>>
>> +#ifdef CONFIG_VFIO
>>   void populate_vfio_info(MigrationInfo *info)
>>   {
>> -#ifdef CONFIG_VFIO
>>       if (vfio_mig_active()) {
>>           info->vfio = g_malloc0(sizeof(*info->vfio));
>>           info->vfio->transferred = vfio_mig_bytes_transferred();
>>       }
>> -#endif
>>   }
>> +
>> +void reset_vfio_bytes_transferred(void)
>> +{
>> +    vfio_reset_bytes_transferred();
>> +}
>> +#else
>> +void populate_vfio_info(MigrationInfo *info)
>> +{
>> +}
>> +
>> +void reset_vfio_bytes_transferred(void)
>> +{
>> +}
>> +#endif
>
> I would simply use static inline in migration.h if !CONFIG_VFIO.

I'm not sure it's possible to use CONFIG_VFIO in migration.h. Got this 
during compilation:
   migration/migration.h:517:8: error: attempt to use poisoned "CONFIG_VFIO"

Plus, see 43bd0bf30fce ("migration: Move populate_vfio_info() into a 
separate file") commit message:

     The CONFIG_VFIO switch only works in target specific code. Since
     migration/migration.c is common code, the #ifdef does not have
     the intended behavior here. Move the related code to a separate
     file now which gets compiled via specific_ss instead.

Or did I misunderstand you?

Thanks.


