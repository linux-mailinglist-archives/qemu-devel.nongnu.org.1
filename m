Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6721E715AD1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3w5W-0001dq-NY; Tue, 30 May 2023 05:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3w5I-0001WP-Pa
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:56:08 -0400
Received: from mail-mw2nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::618]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3w5C-00057X-DN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNNxLToFu67Mp89qGG4lvYyFlmsWgXUBW0djsYXudD/qYhmBX6dPNVXWkISLOH/om0N6pFzdyr83YP34tWPNomdyC4MgLru4WyIqoF93VBKa3qk7mvfrg+n+h4KQUfyfG/bUPzmCqhpR/hiiyHtvPXQlGqGMjBpT6Ji+vVXS+4VjKXU7Gu2x9ECevtwmwYHI+xUSAtUDIA85IdQBOYCnPshXhl49OukRcHxX+PeabeqD/OtxVEHTTIZzvEOw84RjSqRSTXcq0OIlzr37mBSbwGDeo2CGjq4gHivhVbwlA9uNMAL2lm4PUcVxBpSUk8Kk3Dq41wQAJ8rbGVuKZu14iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVKc20+CeNnng97X91OdD393s2tQ1eqJkDcO0M79sSE=;
 b=WE2f9RiN4SNwh76sDI2Z+pFp8EJ6W7TgSGYorDlgAL6UjT8S89LlTpajpQXhu43YGRRjGaui4v8Tzw6ZSvIyu6R5qBT/MPt07VIagWWpRJNuWvUCY1lh06O8ln0acN4mR8OSkIDkRDpUWKzDrx52NXB0HmUoo6gnVhj0093XrKzLC8lCtjrZpisSNXuOYs9+y/OSsgL+Z5uqHsdcz7Dm+XGa5zyatOu7v6l+siQTx2yTgCd8Ejxo3aFVORvxBaSY/2PZHLIZNksdafXgVCx5NpcwCVBF7wS3HZAAyR0vSm7QUkXBKiroikLQxfcecdBG54s8EsmAVON4LxDnunMBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVKc20+CeNnng97X91OdD393s2tQ1eqJkDcO0M79sSE=;
 b=ocMXNO4j9KVkrPkVLQRA9Ie4b4Mpp2jUP/g2dI273P0+d3ueWx+N286a+frKGm7MalcaiHw0zdBEz2+zdsjT4HbV5pJFnGC5Ip5iMYrucfq1x710T26rejfZscpLR/8v0OCsU07x+wgnkQhyiKh8Tm8a1x1QiPIwOzR7mDrvfa7E8vBp3WS3JTm4NpBQ3jqrSF3EpDWGDZkaOxZIAfJsoDcZ+YA76aBiNezc8hiw6ElZVcU2l/lFVkjdmsRpY7/jIf9HQXUbCT0H/AaWUER+b0TFbh7HWHn56MTBQVsxAy1g86P78fuxO611ylCRcYgzkS32M44y8IynGAIQj9gBsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 09:55:55 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:55:54 +0000
Message-ID: <d7826e76-f33c-9635-43e7-8466063f212b@nvidia.com>
Date: Tue, 30 May 2023 12:55:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 7/9] vfio/migration: Add VFIO migration pre-copy support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-8-avihaih@nvidia.com>
 <f18c4598-a1c7-ba45-5885-e14b833f2fde@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <f18c4598-a1c7-ba45-5885-e14b833f2fde@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0074.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b087883-e554-493b-2613-08db60f40f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afkDuseD2n6uapMC5/Vy/d0x5/GoJzhnPMHFUWZCSRN+oW9eiC0wX5j5H4Q6IPXOFlCf8uEt7tEm3sN7aS4/lpKaG0M8RWdi/1Jt+h5eEJXH291mbP7AlRIr26LlFxUU7bAJBKkANhGmHt8qXMA/uAeJ0WjFVPeJ3kMxO9CrzXcQLDXW0LTCJOXC1UxJQuhhzkd8ZzvymOcENAFDXm4Dvzr5DTTAeckS9ImYYozrLPgWEKa386p3Wh/08TTBXgrWCg4VreYSI3fIvN5i7VUKk+oOe4Dt3CSGc2BWHCXPtKdGk9H2CDqJwMHN/WkaM59FsTj/QvanUH07ieygG+6seUvijRiPGHcPm2/+puqRv7yy3ptAxWGeMG2JEZNAE/WrPs8yX3DngWVOORzt4wMmAcCPmqeEbMwIPK8LtGuTu1j+kzBwC1i35HRM958gM7MQyfvsPcU8/gK+W0XQ7ygMckV1ceO8BTNj0c1rMnV4dH74LIFvCFfeMXZHiOO4Rv+YsD4KPme8pM1JxebgYw6gsaoINVIv9tcwP3bB30XL72imYyzVqs8mojugOISO6RYfXX/79H/vE7qJA7bsi0D6QKPrRfhwEGaseoAcD3R0ZwMK3FKkd26zaWjUO1w0hQGm7V5+Uh/wKsUXZqcOJg0+yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(31696002)(6486002)(86362001)(41300700001)(478600001)(4326008)(6666004)(66946007)(316002)(66556008)(66476007)(36756003)(7416002)(5660300002)(186003)(2906002)(30864003)(31686004)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(66574015)(8676002)(54906003)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpvVE9nZ05hclNvYkMwRWJUWnkzWExhWFpiZzJsQ3RLY3lnUUJVRW5lN2pJ?=
 =?utf-8?B?QUJLeXVIeXBVOS94Mm5yeHZaQ3hxN1FNekIyOGg0L0htWjdVbStuaytpaG9z?=
 =?utf-8?B?U0Fjdnp6TEs2dHBIMmlGOEdJdDZ2TmNoak5tc0ZZTjVpSnViR01CT3lqL2xw?=
 =?utf-8?B?bkd4Nk5CS1pPc3VLeW04QnIvejZzcFlodzByTFZ5UUduM0EwdHhlQy9KaXZ2?=
 =?utf-8?B?cVo4ZWxRZ3h4dzBJN0lRQXg4SDVraTdta3ZHcW54bCtJZGNJVW1qSDM0ODZM?=
 =?utf-8?B?Z1MySm9zVUh3NVVYR1RZenVrSXR1anBFSXRRMUsyeU1kRUZLVzNCY1d6QnRB?=
 =?utf-8?B?cHY4YTloeU9hQXlZS1FvMDhnSGhKYnNsMzUyREJabGFUcysvQW9GV242bkdv?=
 =?utf-8?B?S2VyRU8rcEVhYXV0U05rck12bGhscW1VMHpCM1RiYm9PdW1wWmZvTWx4UElD?=
 =?utf-8?B?UEdWV25BUjM3dVJqaHE3M3ErWG5BMnhBZ0JaZjlxanlNMEN4Ry9xTGVNdWR3?=
 =?utf-8?B?bXd1emtNNTFPQ1ROZmE5UFc2MXZYeDJOMjZjSHYwNmFjb0FpMmNUOGgwQkx0?=
 =?utf-8?B?cmNHM28zQm12V1FqMGhGcjVoMnpVVFpFWDRpdG55ODlBL21NcVN2QmVDaGVW?=
 =?utf-8?B?UG5mS1ltTlpocm9ldkE1Y0NMQUU3VHYxRThtZFBsblltTzRWUU5IVkJDU3NO?=
 =?utf-8?B?OHVBdllYVVBvenhiU1Fqdldwc3N5eGJYK2NCUDA0RE56TDNJZW1TczVSZkU5?=
 =?utf-8?B?U3Z5cXdsOUhvZHhpSkZXRW9kUTFVYkF0cVN2QXVKUFpwa2FKNTBOV1RJWkVk?=
 =?utf-8?B?VjBxc3NPYVA0QWw2NGtKaWgzWlNRbnhKT1RoZnljUENCTUZwTXR3Qm9lNitn?=
 =?utf-8?B?Qjl4ZjAwSHorQVlDSUtpSDJDc0wxNUZKekVUMlRrVm04TmZYSzBmRmxZaUxJ?=
 =?utf-8?B?ZndaUy9qbXlTREw4ZVpFWFNINDhKSXNLbnJDNThIV1NoOVU1U3F6dm5yNjEw?=
 =?utf-8?B?ajV2TzA4OWVPWWdneHlVZHQ5K1ZFYWp6bzZldjNIUDJqM20xSDBKK0UxWHhi?=
 =?utf-8?B?N1M2eVR2YnZDY2E1WjV3ZGlzNkZaM3MweU0zT3J6M3FIVXNvOXlBWFdOZXgr?=
 =?utf-8?B?YzMrclNnOTZ1eFVuakJPZDBFN0tML2ZaK1BsaHJiMGNpZTd6RDhQYjFmbysw?=
 =?utf-8?B?N1hYTHovU0srdC8yS3pVUDhKSUVBNkFnY0h2a0x2VmxTOXV5eGRzQndrcmZ2?=
 =?utf-8?B?RUdBNFFpWFNnTnJ1dHY2YXdhNFVVVkRoUVFlTzdSTGNWdFF1U0tIOHRRbXdO?=
 =?utf-8?B?T2s2ZWc2SWM4OGw0SHlXaVZ1emtBODFicjEvT21IRnhCejQwbUpEc20rTERi?=
 =?utf-8?B?empEaCtrMUxEUzJyYUROTW40MWoyR25BL0NBaVR6Y0FNTWl1TjQ2MFpvZ2V5?=
 =?utf-8?B?UGIySU9ENUlFOUl5enNJQTNNU29WeW0vOHVPVkU0eXFLU2VxUVVxcE5OUktH?=
 =?utf-8?B?bTBnWk1RT1lCbTUrdjh3YmZDY1ZBQjJpc3lVdGV2dzlTYlIwVUJLZkF2UUV1?=
 =?utf-8?B?TWFtdFZWdWg2elBIdXNlWU56V1JLQWQrazNjSHFsbnlRWnBpV3pCUlJEdWY1?=
 =?utf-8?B?a1VZTGc4YVFGMWRtejZqL0pmbzRXZmM5T3RPRnJxU3MwcnhvN0lKRHVSanF5?=
 =?utf-8?B?YTFGTHNiMkNzY0JVMVJMcjU2Mlg0Rk9iNWtqd0xRVkMvNXpndjBtRGdFdUJB?=
 =?utf-8?B?REZsU3RvVnJpUTN2U1ZOQmErT1FXa3VsOXRILzZhM2wzNERiQmVxQ2xTTTll?=
 =?utf-8?B?NThSUHVzTmk5ZDRvbGxsNExJa2JsYjJyM0lVUEVTL0hUOVpFQ3VJTkVUMWU0?=
 =?utf-8?B?ekhqblYwb0txREpUK2dIUVZYaStaZDV1UnJEY3ZOS0RBR3hLSkRVZndtNDRM?=
 =?utf-8?B?L1ZXS2VIalZpU1c3bG42VlNjMjFCdmhzSCt2eS9TSHQ3Tm5uV0hRU0Y4cHk4?=
 =?utf-8?B?WTNaelhrYzNuU3Mvdmd1ejNpdG5DU2lUanVwZk8yNDdtek9xK3dXdW92ZUpn?=
 =?utf-8?B?RnVhTGhqRXFMZTJxZERWNjI5dkhUNWd0ZXoyNWt4RGNGLzNHaGZJRG9OQVVB?=
 =?utf-8?Q?4GUVzF0YuIvI0TTwH6EU6rujR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b087883-e554-493b-2613-08db60f40f0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:55:54.7797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aqmbr4oo3FT1WG5bsqtI0PitFIhItn8Zz+OBlgc7+0pFf9iDMybyv8oGqbZFYr9E08aS914qIw+S+8QtNN0jyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
Received-SPF: softfail client-ip=2a01:111:f400:7e89::618;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 30/05/2023 12:28, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/28/23 16:06, Avihai Horon wrote:
>> Pre-copy support allows the VFIO device data to be transferred while the
>> VM is running. This helps to accommodate VFIO devices that have a large
>> amount of data that needs to be transferred, and it can reduce migration
>> downtime.
>>
>> Pre-copy support is optional in VFIO migration protocol v2.
>> Implement pre-copy of VFIO migration protocol v2 and use it for devices
>> that support it. Full description of it can be found in the following
>> Linux commit: 4db52602a607 ("vfio: Extend the device migration protocol
>> with PRE_COPY").
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>
> LGTM,
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> one minor issue below,
>
>> ---
>>   docs/devel/vfio-migration.rst |  35 +++++---
>>   include/hw/vfio/vfio-common.h |   2 +
>>   hw/vfio/common.c              |   6 +-
>>   hw/vfio/migration.c           | 165 ++++++++++++++++++++++++++++++++--
>>   hw/vfio/trace-events          |   4 +-
>>   5 files changed, 190 insertions(+), 22 deletions(-)
>>
>> diff --git a/docs/devel/vfio-migration.rst 
>> b/docs/devel/vfio-migration.rst
>> index 1b68ccf115..e896b2a673 100644
>> --- a/docs/devel/vfio-migration.rst
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -7,12 +7,14 @@ the guest is running on source host and restoring 
>> this saved state on the
>>   destination host. This document details how saving and restoring of 
>> VFIO
>>   devices is done in QEMU.
>>
>> -Migration of VFIO devices currently consists of a single 
>> stop-and-copy phase.
>> -During the stop-and-copy phase the guest is stopped and the entire 
>> VFIO device
>> -data is transferred to the destination.
>> -
>> -The pre-copy phase of migration is currently not supported for VFIO 
>> devices.
>> -Support for VFIO pre-copy will be added later on.
>> +Migration of VFIO devices consists of two phases: the optional 
>> pre-copy phase,
>> +and the stop-and-copy phase. The pre-copy phase is iterative and 
>> allows to
>> +accommodate VFIO devices that have a large amount of data that needs 
>> to be
>> +transferred. The iterative pre-copy phase of migration allows for 
>> the guest to
>> +continue whilst the VFIO device state is transferred to the 
>> destination, this
>> +helps to reduce the total downtime of the VM. VFIO devices opt-in to 
>> pre-copy
>> +support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>> +VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>
>>   Note that currently VFIO migration is supported only for a single 
>> device. This
>>   is due to VFIO migration's lack of P2P support. However, P2P 
>> support is planned
>> @@ -29,10 +31,20 @@ VFIO implements the device hooks for the 
>> iterative approach as follows:
>>   * A ``load_setup`` function that sets the VFIO device on the 
>> destination in
>>     _RESUMING state.
>>
>> +* A ``state_pending_estimate`` function that reports an estimate of the
>> +  remaining pre-copy data that the vendor driver has yet to save for 
>> the VFIO
>> +  device.
>> +
>>   * A ``state_pending_exact`` function that reads pending_bytes from 
>> the vendor
>>     driver, which indicates the amount of data that the vendor driver 
>> has yet to
>>     save for the VFIO device.
>>
>> +* An ``is_active_iterate`` function that indicates 
>> ``save_live_iterate`` is
>> +  active only when the VFIO device is in pre-copy states.
>> +
>> +* A ``save_live_iterate`` function that reads the VFIO device's data 
>> from the
>> +  vendor driver during iterative pre-copy phase.
>> +
>>   * A ``save_state`` function to save the device config space if it 
>> is present.
>>
>>   * A ``save_live_complete_precopy`` function that sets the VFIO 
>> device in
>> @@ -111,8 +123,10 @@ Flow of state changes during Live migration
>>   ===========================================
>>
>>   Below is the flow of state change during live migration.
>> -The values in the brackets represent the VM state, the migration 
>> state, and
>> +The values in the parentheses represent the VM state, the migration 
>> state, and
>>   the VFIO device state, respectively.
>> +The text in the square brackets represents the flow if the VFIO 
>> device supports
>> +pre-copy.
>>
>>   Live migration save path
>>   ------------------------
>> @@ -124,11 +138,12 @@ Live migration save path
>>                                     |
>>                        migrate_init spawns migration_thread
>>                   Migration thread then calls each device's 
>> .save_setup()
>> -                       (RUNNING, _SETUP, _RUNNING)
>> +                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
>>                                     |
>> -                      (RUNNING, _ACTIVE, _RUNNING)
>> -             If device is active, get pending_bytes by 
>> .state_pending_exact()
>> +                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
>> +      If device is active, get pending_bytes by 
>> .state_pending_{estimate,exact}()
>>             If total pending_bytes >= threshold_size, call 
>> .save_live_iterate()
>> +                  [Data of VFIO device for pre-copy phase is copied]
>>           Iterate till total pending bytes converge and are less than 
>> threshold
>>                                     |
>>     On migration completion, vCPU stops and calls 
>> .save_live_complete_precopy for
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index 5f29dab839..1db901c194 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -67,6 +67,8 @@ typedef struct VFIOMigration {
>>       void *data_buffer;
>>       size_t data_buffer_size;
>>       uint64_t mig_flags;
>> +    uint64_t precopy_init_size;
>> +    uint64_t precopy_dirty_size;
>>   } VFIOMigration;
>>
>>   typedef struct VFIOAddressSpace {
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 78358ede27..b73086e17a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -492,7 +492,8 @@ static bool 
>> vfio_devices_all_dirty_tracking(VFIOContainer *container)
>>               }
>>
>>               if (vbasedev->pre_copy_dirty_page_tracking == 
>> ON_OFF_AUTO_OFF &&
>> -                migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
>> +                (migration->device_state == 
>> VFIO_DEVICE_STATE_RUNNING ||
>> +                 migration->device_state == 
>> VFIO_DEVICE_STATE_PRE_COPY)) {
>>                   return false;
>>               }
>>           }
>> @@ -537,7 +538,8 @@ static bool 
>> vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>>                   return false;
>>               }
>>
>> -            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
>> +            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
>> +                migration->device_state == 
>> VFIO_DEVICE_STATE_PRE_COPY) {
>>                   continue;
>>               } else {
>>                   return false;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 8d33414379..d8f6a22ae1 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -68,6 +68,8 @@ static const char *mig_state_to_str(enum 
>> vfio_device_mig_state state)
>>           return "STOP_COPY";
>>       case VFIO_DEVICE_STATE_RESUMING:
>>           return "RESUMING";
>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>> +        return "PRE_COPY";
>>       default:
>>           return "UNKNOWN STATE";
>>       }
>> @@ -241,6 +243,25 @@ static int vfio_query_stop_copy_size(VFIODevice 
>> *vbasedev,
>>       return 0;
>>   }
>>
>> +static int vfio_query_precopy_size(VFIOMigration *migration)
>> +{
>> +    struct vfio_precopy_info precopy = {
>> +        .argsz = sizeof(precopy),
>> +    };
>> +
>> +    migration->precopy_init_size = 0;
>> +    migration->precopy_dirty_size = 0;
>> +
>> +    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, 
>> &precopy)) {
>> +        return -errno;
>> +    }
>> +
>> +    migration->precopy_init_size = precopy.initial_bytes;
>> +    migration->precopy_dirty_size = precopy.dirty_bytes;
>> +
>> +    return 0;
>> +}
>> +
>>   /* Returns the size of saved data on success and -errno on error */
>>   static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>>   {
>> @@ -249,6 +270,14 @@ static ssize_t vfio_save_block(QEMUFile *f, 
>> VFIOMigration *migration)
>>       data_size = read(migration->data_fd, migration->data_buffer,
>>                        migration->data_buffer_size);
>>       if (data_size < 0) {
>> +        /*
>> +         * Pre-copy emptied all the device state for now. For more 
>> information,
>> +         * please refer to the Linux kernel VFIO uAPI.
>> +         */
>> +        if (errno == ENOMSG) {
>> +            return 0;
>> +        }
>> +
>>           return -errno;
>>       }
>>       if (data_size == 0) {
>> @@ -265,6 +294,38 @@ static ssize_t vfio_save_block(QEMUFile *f, 
>> VFIOMigration *migration)
>>       return qemu_file_get_error(f) ?: data_size;
>>   }
>>
>> +static void vfio_update_estimated_pending_data(VFIOMigration 
>> *migration,
>> +                                               uint64_t data_size)
>> +{
>> +    if (!data_size) {
>> +        /*
>> +         * Pre-copy emptied all the device state for now, update 
>> estimated sizes
>> +         * accordingly.
>> +         */
>> +        migration->precopy_init_size = 0;
>> +        migration->precopy_dirty_size = 0;
>> +
>> +        return;
>> +    }
>> +
>> +    if (migration->precopy_init_size) {
>> +        uint64_t init_size = MIN(migration->precopy_init_size, 
>> data_size);
>> +
>> +        migration->precopy_init_size -= init_size;
>> +        data_size -= init_size;
>> +    }
>> +
>> +    migration->precopy_dirty_size -= MIN(migration->precopy_dirty_size,
>> +                                         data_size);
>> +}
>> +
>> +static bool vfio_precopy_supported(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>> +}
>> +
>>   /* 
>> ---------------------------------------------------------------------- 
>> */
>>
>>   static int vfio_save_setup(QEMUFile *f, void *opaque)
>> @@ -285,6 +346,28 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>           return -ENOMEM;
>>       }
>>
>> +    if (vfio_precopy_supported(vbasedev)) {
>> +        int ret;
>> +
>> +        switch (migration->device_state) {
>> +        case VFIO_DEVICE_STATE_RUNNING:
>> +            ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_PRE_COPY,
>> + VFIO_DEVICE_STATE_RUNNING);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +
>> +            vfio_query_precopy_size(migration);
>> +
>> +            break;
>> +        case VFIO_DEVICE_STATE_STOP:
>> +            /* vfio_save_complete_precopy() will go to STOP_COPY */
>> +            break;
>> +        default:
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>>       trace_vfio_save_setup(vbasedev->name, 
>> migration->data_buffer_size);
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> @@ -299,26 +382,42 @@ static void vfio_save_cleanup(void *opaque)
>>
>>       g_free(migration->data_buffer);
>>       migration->data_buffer = NULL;
>> +    migration->precopy_init_size = 0;
>> +    migration->precopy_dirty_size = 0;
>>       vfio_migration_cleanup(vbasedev);
>>       trace_vfio_save_cleanup(vbasedev->name);
>>   }
>>
>> +static void vfio_state_pending_estimate(void *opaque, uint64_t 
>> *must_precopy,
>> +                                        uint64_t *can_postcopy)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
>> +        return;
>> +    }
>> +
>> +    *must_precopy +=
>> +        migration->precopy_init_size + migration->precopy_dirty_size;
>> +
>> +    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
>> +                                      *can_postcopy,
>> + migration->precopy_init_size,
>> + migration->precopy_dirty_size);
>> +}
>> +
>>   /*
>>    * Migration size of VFIO devices can be as little as a few KBs or 
>> as big as
>>    * many GBs. This value should be big enough to cover the worst case.
>>    */
>>   #define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>>
>> -/*
>> - * Only exact function is implemented and not estimate function. The 
>> reason is
>> - * that during pre-copy phase of migration the estimate function is 
>> called
>> - * repeatedly while pending RAM size is over the threshold, thus 
>> migration
>> - * can't converge and querying the VFIO device pending data size is 
>> useless.
>> - */
>>   static void vfio_state_pending_exact(void *opaque, uint64_t 
>> *must_precopy,
>>                                        uint64_t *can_postcopy)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>>
>>       /*
>> @@ -328,8 +427,48 @@ static void vfio_state_pending_exact(void 
>> *opaque, uint64_t *must_precopy,
>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>       *must_precopy += stop_copy_size;
>>
>> +    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
>> +        vfio_query_precopy_size(migration);
>> +
>> +        *must_precopy +=
>> +            migration->precopy_init_size + 
>> migration->precopy_dirty_size;
>> +    }
>> +
>>       trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, 
>> *can_postcopy,
>> -                                   stop_copy_size);
>> +                                   stop_copy_size, 
>> migration->precopy_init_size,
>> + migration->precopy_dirty_size);
>> +}
>> +
>> +static bool vfio_is_active_iterate(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
>> +}
>> +
>> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    ssize_t data_size;
>> +
>> +    data_size = vfio_save_block(f, migration);
>> +    if (data_size < 0) {
>> +        return data_size;
>> +    }
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    vfio_update_estimated_pending_data(migration, data_size);
>> +
>> +    trace_vfio_save_iterate(vbasedev->name, 
>> migration->precopy_init_size,
>> +                            migration->precopy_dirty_size);
>> +
>> +    /*
>> +     * A VFIO device's pre-copy dirty_bytes is not guaranteed to 
>> reach zero.
>> +     * Return 1 so following handlers will not be potentially blocked.
>> +     */
>> +    return 1;
>>   }
>>
>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>> @@ -338,7 +477,7 @@ static int vfio_save_complete_precopy(QEMUFile 
>> *f, void *opaque)
>>       ssize_t data_size;
>>       int ret;
>>
>> -    /* We reach here with device state STOP only */
>> +    /* We reach here with device state STOP or STOP_COPY only */
>>       ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_STOP_COPY,
>>                                      VFIO_DEVICE_STATE_STOP);
>>       if (ret) {
>> @@ -457,7 +596,10 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>   static const SaveVMHandlers savevm_vfio_handlers = {
>>       .save_setup = vfio_save_setup,
>>       .save_cleanup = vfio_save_cleanup,
>> +    .state_pending_estimate = vfio_state_pending_estimate,
>>       .state_pending_exact = vfio_state_pending_exact,
>> +    .is_active_iterate = vfio_is_active_iterate,
>> +    .save_live_iterate = vfio_save_iterate,
>>       .save_live_complete_precopy = vfio_save_complete_precopy,
>>       .save_state = vfio_save_state,
>>       .load_setup = vfio_load_setup,
>> @@ -470,13 +612,18 @@ static const SaveVMHandlers 
>> savevm_vfio_handlers = {
>>   static void vfio_vmstate_change(void *opaque, bool running, 
>> RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       enum vfio_device_mig_state new_state;
>>       int ret;
>>
>>       if (running) {
>>           new_state = VFIO_DEVICE_STATE_RUNNING;
>>       } else {
>> -        new_state = VFIO_DEVICE_STATE_STOP;
>> +        new_state =
>> +            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
>> +             (state == RUN_STATE_FINISH_MIGRATE || state == 
>> RUN_STATE_PAUSED)) ?
>> +                VFIO_DEVICE_STATE_STOP_COPY :
>> +                VFIO_DEVICE_STATE_STOP;
>>       }
>>
>>       /*
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 646e42fd27..548f9488a7 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -162,6 +162,8 @@ vfio_save_block(const char *name, int data_size) 
>> " (%s) data_size %d"
>>   vfio_save_cleanup(const char *name) " (%s)"
>>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>>   vfio_save_device_config_state(const char *name) " (%s)"
>> +vfio_save_iterate(const char *name, uint64_t precopy_init_size, 
>> uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" 
>> precopy dirty size 0x%"PRIx64"
>
> the extra '"' at the end breaks compile. No need to resend just for that.
> It can be fixed.
>
Oh, strange that it doesn't break when I compile it.
Do you have any idea why would  that be?

Thanks!

>
>
>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) 
>> data buffer size 0x%"PRIx64
>> -vfio_state_pending_exact(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t stopcopy_size) " (%s) precopy 0x%"PRIx64" 
>> postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64
>> +vfio_state_pending_estimate(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t precopy_init_size, uint64_t 
>> precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" 
>> precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>> +vfio_state_pending_exact(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t stopcopy_size, uint64_t 
>> precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 
>> 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy 
>> initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>   vfio_vmstate_change(const char *name, int running, const char 
>> *reason, const char *dev_state) " (%s) running %d reason %s device 
>> state %s"
>

