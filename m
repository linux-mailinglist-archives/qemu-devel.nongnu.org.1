Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6578C8FE
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb16h-00004t-B7; Tue, 29 Aug 2023 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qb16Q-0008T9-R3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:58:03 -0400
Received: from mail-bn8nam04on2051.outbound.protection.outlook.com
 ([40.107.100.51] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qb16N-0000r3-O4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7o+fnJxPZJMTLJB2GQAf2gShJG/MB1+RT59EOcCAN1Vh4aJPZkCmHU/4E+Km+8lwwUGkLlE0bZFF+kBKNT8iSJ4WuELcTAs1UK79CxtApQTlfBC8BKEwC3JnvGmybjPI2gFG5uXoTOBqb0YNpukew09tEIbtg99gBW80puzYYoxEUr+m4cCmLX7k/K38w4EN/b75NQ9qMb2FMzLzVxpZlfK6jqRcsmjTipH0+OXg3nYbVKjeqr5vwrdDx5vjPLLWeoO/6aR2MReUeJW3t0MPB9K5pFG/Gw8Chtf6a8xia/o+qjbFdYNPEWYorwnhz9Z2H/RbDl6IotFFrFk0VCMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6mmNE2le6LhFSlXZGnZ5ZFNeLS1G/ky0XIWj+W8WVA=;
 b=Z7e/CRwrlvvWyz385EY8TQ9Afi2mXv40ArvYLRmqJzf8z4KPvUtIrsxe1B2opXSM3C8U8U7OXOSLfVd31DyCRXgGWDyjVmkmCwTeqY20BEFGCkjs6ayZnbd8RFXjSVkvY9/gWh9dt4aWOIAQYz+mck1e+zkHnscsjn+hYgmOQy4Wak1E2KNAl9JK4hx5sn5bqbHroNGu0pNiwDzmD/ck40Ud/6fMHLpbQUjXE29VH2Vo4kVD2GUE/2rOb32N11hZzg7ZLmGhxEMK4WPiC3PixObjuZ6QbZYsMh1XCSd45i16s9yeggLdk9j4Y6PozegbEIty4m10tfiMRIursg2tEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6mmNE2le6LhFSlXZGnZ5ZFNeLS1G/ky0XIWj+W8WVA=;
 b=It8g5TpX4d+vIZ9smySr7XgquVhgs6qYALMc6R6tzwfuy+wE/dsv2s2CEpC9TerX7vqPbZ3lGYyY4wSuBgG3aY7IKk06ipsIHiKxw1xDLGb7Gi0I9m+cqf33yBhC+m1xoAFaBryhR8GimTgtku+JBBDaJ0IUDAZGYx0m+O6qJ5ckp1OL1eGslESzngPpp7bawuLXKFAw711meazkTlTcztADwpszYAHVzfqlPMEgnqox4qzu3U6B2dEmRXNn/KNRlNkR+wblDwOxAgVgwDaiPxpF3ldzTK3lgl59G+fa/PHsB7C/r33Ep4N84B/IhAiIxA41pm2MsoO6X/Gesm6gGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 15:52:54 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 15:52:53 +0000
Message-ID: <87b9a4ad-b002-6e4a-cc53-c0c29261ae50@nvidia.com>
Date: Tue, 29 Aug 2023 18:52:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com>
 <ae76d3dc-9027-f52d-a3d4-196624750c63@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ae76d3dc-9027-f52d-a3d4-196624750c63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0154.eurprd07.prod.outlook.com
 (2603:10a6:802:16::41) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dd95dd-2dcb-49ae-4662-08dba8a80171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35qqh3aONTbggeTikn6pn5aHkA5Q9kbrB0YKxOPtGKFZW8jznQXeNyZGT5xepXernUWJjFRRDgTu14ZihUMhob2ytWmVI00UA/HfL5vRrggTNLPYGM7wXUcnst2c8WIPFqu+y3YDkphXoVzGBisJCSZrhLeNliHHlafMgzGtQBUUqJ1KwkAYwLKpc2JLTp5OtrL1xAAeVd/RrmSUa0AZYtCekEtuftu4SOTJi1lxz/1QdFxsfXx2QbXpjV0EbbYyyEdkppOCG42AydzpRiTyjlkGIjlBV3SHDLkAv0tX4GqGdExZ5vOQTl1X4yljTu48LyGM+ADMDKokrHOXbmo3NoGDlXrsYjH/yYnrEDMpPyTBu0mAxz53OcPrCdZPPrI0EVmFCAJevpqgYuc+v6IfFs9ULdNSJ/LOp6ym5+g1izjzUpkA6Cu8a7mak4kb2oZLSlzfQ05C1cOfSUpTfDwjtjCUx67PK7zniH0iF6wCeqdFRDGhhvBbssm0A4yDZYpm4ZJbo67oOpV0ohwRgw6OIkfICvznXaKeIK1d202xHJBUJ+5LQdbkLcnQhVaRiOC4JVum+uZuroHL8+1JJypsJUU48JElxjjObJZmu0JyjscpAQCk0BASYVCg4Gr6D1S8bt9etdf6Zxgdai3Z0FFyYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(36756003)(54906003)(66476007)(66946007)(66556008)(316002)(5660300002)(2906002)(31686004)(41300700001)(6506007)(6486002)(53546011)(26005)(6512007)(38100700002)(2616005)(478600001)(83380400001)(31696002)(6666004)(86362001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFGUDRyOXMrYzBUeC9lYUN1V1NIcHRYUXZrMC9UZWd2eUZNN2t4YkJtWXZP?=
 =?utf-8?B?Q2F5c0o1ZXJneWhQYlAzc3gyU3ZnbzlpWStmc2tzaThHR1phLzdnWGNYa0g0?=
 =?utf-8?B?Y0g0ZjVIMnZQbjZDYnU3bkY1OXovT2J5NFNmTXpzSTFOQlBuZTBmNHN2WTJh?=
 =?utf-8?B?bHY4S0VHa1I0RHl4K2xlZ3EvT1RuZ3dicmRQOW5EaG9jQ3lDM01WMG9EVnZw?=
 =?utf-8?B?TGpOeUVDMzlHMXV5OFRLUDNDcG9pZ25BY3RPTllwWUZTeG5ZaE9SYkxFME9N?=
 =?utf-8?B?Z0dXQVdGbjFyUndsSHRCMUNrdUdKRStKWVppMXo4bFNFS2ZlblFnZkNqdC9V?=
 =?utf-8?B?MHY1Q3FtV081eXFPRU42K2VpYzBzWDJHNjIreWMzWDRYVVNmOUtUc2R0WUZ5?=
 =?utf-8?B?Mjhma2VKQ1B1bDVseVFZZm5JMFU0YjYvN2VpY2FJMmdsblVUK2ZHbGFEWllO?=
 =?utf-8?B?dkZDQ1hGMGxQNU1yeXBiQjd5dHBFN0JBQTY4ZG1EZWlnQjhxTExmc05aZ0ov?=
 =?utf-8?B?aEMwaXh0OFZiMDk2S3ByK01NWi9sMnpvSzVpTERhTTVwUmVLRmNsQXo3NFBT?=
 =?utf-8?B?VFRBbytTRllUTjFpejJab2d6ZGxMK0laU1BjTGZBV3NaTmVad3dmTUFaMlJ0?=
 =?utf-8?B?TjdsVmxGUnRoUGVSWGJKZThBNzVuNDhvT3pGQ3E3ejR1dWZ4WXRZZjNmY3RZ?=
 =?utf-8?B?b2VEOVJKRHlYc2NpcEtBOUU3Z0lHMXpJSXlycWF1cWpBc3pjazRrbDNmWW9x?=
 =?utf-8?B?S3VlV1pnUUgzN0lHd2gzRzY3YnJTUEd4WmJjM1lvSGI3RDJuMGFRR3V6VGdR?=
 =?utf-8?B?S0VYcThmVnpZNWZOc3Fsa1Jib3Z3OU5TUHJJeWFnUWYvL1VldzZFV3M5bUIr?=
 =?utf-8?B?UG85QWhqYWo1bkp4VnBtdWZicndZU2R4WVBzVGRkVHNDWThSQzQrVGlkQ2k4?=
 =?utf-8?B?ZzhmejJXT0k3Y1FveHhQZTZDczFpM0doUzBEM24yS2NML1RmZkFyNSttbTZ2?=
 =?utf-8?B?UVNXWFFyMFRSU2ZpVVNZVWpkbG5Fc3A1N0QzNkRwemN2d3JURlBQdktuS3pW?=
 =?utf-8?B?YkwxQ2RtcmlNYjM1bEtrRkNoZ1JvSVF6aGd2LzMxMGlHU2syditra1BTK2Jk?=
 =?utf-8?B?cEZHVGpvQm1mWXN2bTRpU3hXaEZzUE16YjhxZzFiamlNSVo3RFErS0ZlOGls?=
 =?utf-8?B?YUMzUHpPSms2SlM0b1QzOE54SjdOdEVpWVhGNDI4MU5YQ3RqajFkNnZCZnBl?=
 =?utf-8?B?SGc0VXo3dVQ0VkJ6Ymh2eVlqTk5oTFYyRS8yOTBQQk1vQ2xwR0d2Y1R4QmUw?=
 =?utf-8?B?WHprc3ZWT0dueEh0Y0lOM2tYR2lVczBKOVUyWFdwaTZDc0lsR1ZQVjQydlpl?=
 =?utf-8?B?U1dNNGNoSDNCYk4vUUU3V0R1UFZNZFRObDFQaHp0YzNTU3o2U0YzaFdBSVZM?=
 =?utf-8?B?Q1RmVmdBa2ROcW9uVjhwMFNjUU5wZ3NUZWFGYU5ib3BoS05RWmxYRlVmakVG?=
 =?utf-8?B?NFQ3bW12UUNSYnh0RFhuclh2cG5SaDRwTkkxakIyekJJUDExeFExLzV1UWlk?=
 =?utf-8?B?eTlTZWtwVG1MRVM5US9VSnJqV0JLd1UwN1lLeVlqc25TWkhTc3FuOHZCdG50?=
 =?utf-8?B?NjV5VkZjc2tuWUZhaThRM0ZCU2FObHJwUVRrbU00VGFrS0I2eVFFOEx3TkdI?=
 =?utf-8?B?cVd4eDZZSzRTMU53STBaVEVkdTNxUnpxMGRsekdJQllzaTF1UjZmM2lOSnNP?=
 =?utf-8?B?ZjJ2eHM4dC94OHlFNzZPaHAxK1RjUXZoOTh3eER5RTNMd2RJNmxqcTJ0NzhM?=
 =?utf-8?B?SEZucDQ4a21GWThRWnJmN2luYlhYa090aXQ4YnNIZ0dlRzlMY0VjSEE3alFK?=
 =?utf-8?B?a0VHZml2Z0N5N3Y0VzdZRkE3ZCtUYTNpNHo0MWJWUmlQQTBuTUI3Wk4yZ2J2?=
 =?utf-8?B?akZPeERoOGJlUWtyOEcvSTJneWRKM0JuU3VPV3VZSmhnYWJoaDBhTVB1elFI?=
 =?utf-8?B?bUZ5SDVKWnlCL1JCWU9HeWN0a3FLM2Z4VStCTmlxeWY0TXQ0Y3FBRDZ5TGFw?=
 =?utf-8?B?cEF0K1pUaTRDR1lURjMwUDI4VWNUem5lc0hIV2NBRSs0S1ZIemxaZXhQUHZ4?=
 =?utf-8?Q?hy7E+v92DFqO765ZaYhC+bju1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd95dd-2dcb-49ae-4662-08dba8a80171
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 15:52:53.7981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBx0ti2XVKZM3JhMkyoDMiQPYkRZjqyWFt9ugytQQfoo2VrR+Xqsolg+ryjz9vOVE3bIMBDdVGN35HbZeeZ7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
Received-SPF: softfail client-ip=40.107.100.51;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 29/08/2023 16:24, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/28/23 17:18, Avihai Horon wrote:
>> VFIO migration is not compatible with postcopy migration. A VFIO device
>> in the destination can't handle page faults for pages that have not been
>> sent yet.
>>
>> Doing such migration will cause the VM to crash in the destination:
>>
>> qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
>> qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 
>> 0x7f1b11a00000) = -14 (Bad address)
>> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>>
>> To prevent this and to be explicit about supported features, block VFIO
>> migration with postcopy migration: Fail setting postcopy capability if a
>> VFIO device is present, and add a migration blocker if a VFIO device is
>> added when postcopy capability is on.
>>
>> Reported-by: Yanghang Liu <yanghliu@redhat.com>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   migration/migration.h         |  2 ++
>>   hw/vfio/common.c              | 43 +++++++++++++++++++++++++++++++++++
>>   hw/vfio/migration.c           |  6 +++++
>>   migration/options.c           | 19 ++++++++++++++++
>>   migration/target.c            | 19 ++++++++++++++++
>>   6 files changed, 91 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index e9b8954595..c0b58f2bb7 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -227,6 +227,8 @@ extern VFIOGroupList vfio_group_list;
>>   bool vfio_mig_active(void);
>>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, 
>> Error **errp);
>>   void vfio_unblock_multiple_devices_migration(void);
>> +int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp);
>> +void vfio_unblock_postcopy_migration(void);
>>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>>   int64_t vfio_mig_bytes_transferred(void);
>>   void vfio_reset_bytes_transferred(void);
>> diff --git a/migration/migration.h b/migration/migration.h
>> index c5695de214..21a6423408 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -514,6 +514,8 @@ void migration_cancel(const Error *error);
>>
>>   void migration_populate_vfio_info(MigrationInfo *info);
>>   void migration_reset_vfio_bytes_transferred(void);
>> +bool migration_vfio_mig_active(void);
>> +void migration_vfio_unblock_postcopy_migration(void);
>>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>>
>>   #endif
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 373f6e5932..7461194b2b 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -40,6 +40,7 @@
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   #include "migration/migration.h"
>> +#include "migration/options.h"
>>   #include "migration/misc.h"
>>   #include "migration/blocker.h"
>>   #include "migration/qemu-file.h"
>> @@ -343,6 +344,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer 
>> *container, uint64_t iova,
>>                                    uint64_t size, ram_addr_t ram_addr);
>>
>>   static Error *multiple_devices_migration_blocker;
>> +static Error *postcopy_migration_blocker;
>>
>>   static unsigned int vfio_migratable_devices_num(void)
>>   {
>> @@ -427,6 +429,47 @@ void vfio_unblock_multiple_devices_migration(void)
>>       multiple_devices_migration_blocker = NULL;
>>   }
>>
>> +int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    int ret;
>> +
>> +    if (!migrate_postcopy_ram()) {
>> +        return 0;
>> +    }
>> +
>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>> +        error_setg(errp,
>> +                   "VFIO migration is not compatible with postcopy 
>> migration");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (postcopy_migration_blocker) {
>> +        return 0;
>> +    }
>> +
>> +    error_setg(&postcopy_migration_blocker,
>> +               "VFIO migration is not compatible with postcopy 
>> migration");
>> +    ret = migrate_add_blocker(postcopy_migration_blocker, errp);
>> +    if (ret < 0) {
>> +        error_free(postcopy_migration_blocker);
>> +        postcopy_migration_blocker = NULL;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +void vfio_unblock_postcopy_migration(void)
>> +{
>> +    if (!postcopy_migration_blocker ||
>> +        (vfio_migratable_devices_num() && migrate_postcopy_ram())) {
>> +        return;
>> +    }
>> +
>> +    migrate_del_blocker(postcopy_migration_blocker);
>> +    error_free(postcopy_migration_blocker);
>> +    postcopy_migration_blocker = NULL;
>> +}
>> +
>>   bool vfio_mig_active(void)
>>   {
>>       return vfio_migratable_devices_num();
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 71855468fe..76406e9ae9 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -856,6 +856,7 @@ static void vfio_migration_deinit(VFIODevice 
>> *vbasedev)
>>       unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>>       vfio_migration_free(vbasedev);
>>       vfio_unblock_multiple_devices_migration();
>> +    vfio_unblock_postcopy_migration();
>>   }
>>
>>   static int vfio_block_migration(VFIODevice *vbasedev, Error *err, 
>> Error **errp)
>> @@ -939,6 +940,11 @@ bool vfio_migration_realize(VFIODevice 
>> *vbasedev, Error **errp)
>>           goto out_deinit;
>>       }
>>
>> +    ret = vfio_block_postcopy_migration(vbasedev, errp);
>> +    if (ret) {
>> +        goto out_deinit;
>> +    }
>> +
>>       if (vfio_viommu_preset(vbasedev)) {
>>           error_setg(&err, "%s: Migration is currently not supported "
>>                      "with vIOMMU enabled", vbasedev->name);
>> diff --git a/migration/options.c b/migration/options.c
>> index 1d1e1321b0..e201053563 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool 
>> *new_caps, Error **errp)
>>               error_setg(errp, "Postcopy is not yet compatible with 
>> multifd");
>>               return false;
>>           }
>> +
>> +        if (migration_vfio_mig_active()) {
>> +            error_setg(errp, "Postcopy is not compatible with VFIO 
>> migration");
>> +            return false;
>> +        }
>>       }
>>
>>       if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
>> @@ -612,6 +617,16 @@ bool migrate_caps_check(bool *old_caps, bool 
>> *new_caps, Error **errp)
>>       return true;
>>   }
>>
>> +/*
>> + * Devices might have added migration blockers based on migration 
>> capabilities
>> + * values when those devices were added. Remove such blockers 
>> according to new
>> + * changes in migration capabilities.
>> + */
>> +static void migration_caps_remove_blockers(void)
>> +{
>> +    migration_vfio_unblock_postcopy_migration();
>> +}
>> +
>>   bool migrate_cap_set(int cap, bool value, Error **errp)
>>   {
>>       MigrationState *s = migrate_get_current();
>> @@ -629,6 +644,8 @@ bool migrate_cap_set(int cap, bool value, Error 
>> **errp)
>>           return false;
>>       }
>>       s->capabilities[cap] = value;
>> +    migration_caps_remove_blockers();
>> +
>>       return true;
>>   }
>>
>> @@ -678,6 +695,8 @@ void 
>> qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>>       for (cap = params; cap; cap = cap->next) {
>>           s->capabilities[cap->value->capability] = cap->value->state;
>>       }
>> +
>> +    migration_caps_remove_blockers();
>>   }
>>
>>   /* parameters */
>> diff --git a/migration/target.c b/migration/target.c
>> index a6ffa9a5ce..690ecb4dd5 100644
>> --- a/migration/target.c
>> +++ b/migration/target.c
>> @@ -27,6 +27,16 @@ void migration_reset_vfio_bytes_transferred(void)
>>   {
>>       vfio_reset_bytes_transferred();
>>   }
>> +
>> +bool migration_vfio_mig_active(void)
>> +{
>> +    return vfio_mig_active();
>> +}
>> +
>> +void migration_vfio_unblock_postcopy_migration(void)
>> +{
>> +    vfio_unblock_postcopy_migration();
>> +}
>>   #else
>>   void migration_populate_vfio_info(MigrationInfo *info)
>>   {
>> @@ -35,4 +45,13 @@ void migration_populate_vfio_info(MigrationInfo 
>> *info)
>>   void migration_reset_vfio_bytes_transferred(void)
>>   {
>>   }
>> +
>> +bool migration_vfio_mig_active(void)
>> +{
>> +    return false;
>> +}
>> +
>> +void migration_vfio_unblock_postcopy_migration()
>
>
> Missing 'void' above.
>
Oh, right. Next time I will also test compilation without VFIO config.

Thanks.


