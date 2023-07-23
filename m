Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3075E178
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 12:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNWYC-0005eg-Dl; Sun, 23 Jul 2023 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qNWYA-0005eX-5u
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:42:54 -0400
Received: from mail-mw2nam12on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qNWY5-0006QI-9g
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CscnL3LIYEv5rsfrS9PiWMrqsuzVjC4++JCKOFijA0rQJh5XOt/CAf/N8uee2zSSgiFmuLYYvDZFU6XkNMMPaa9eyUDKmLEDlDrealaqNaGzD0zuC35CuskUZDm3ceZhMbJOnvdQLQTxByqgSOXKEc5+xG6z85M6mbxthVYBDDuumD9BpYmlX/FngET8u44YG2GSnbY1OZ9+CzsIIFesz7RpxhoSTNM8sX+4VHNbSnbjTqwUKQssG8fQFuDpI0hc8e5tRkFwVzxL8LX+Zta0RW67uMUpFY1ZpUYL7eMCZkdXiZio6zHT7XDx24tRV2aWw64Nqkv3GsV5tcW62PUalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4YuIR/CjwI0ZUkVRxxUb/JUqb9fIu8jqtAZlc0DUMQ=;
 b=KghWd9XAUDE4WPWBdVilylyJartAYwX06iaTy0YYU2H29gFUpWl8Y4HWKjJbOZBPN/bjmLZUNlTgdhjdgrAGks0I20irlfVaGmvAPXBVLs3OHdpW84eUdC1P++WnS0tfNSzSBwCaM9H4258miD/TKNyNXObfa1AA6GnjWFnNmF/7tJlkHITTxI08/y5P1FZxctW/HiPhjqNuL0qXSvv13EKFrm4VlUAJgua9rQxjhKZre+rL/tsFLPIPRBs2+QUI10OKvN4fLPNZlGPmUAvqKd0bTdiG6G6lWFa4IwS3X3l8Bq5g1aPU7Qiv2zfSj/ueF03kRIk9q32GnYzc3XL82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4YuIR/CjwI0ZUkVRxxUb/JUqb9fIu8jqtAZlc0DUMQ=;
 b=EL1dEmLC1lNuHvzqahWtVAWg2Ja2+PBOgDyL+LFcvaWQjZvkkrGNHZKE0soR1XDQCpvdTQR/50APwQRWuYt2cfPhoDM9cOp8Ldm0lzXAU6okVAU0AdZTkj343uX4waCYEtOG4q5/q5s7rUeYYksamC/30c7usWcx+GG5MyYr2YW+Ee/sqCohix7GZfdWpocJPhjjsbhHjlN+//Jzgp/oReCJRk5mzUxYB5nGLQHtSnnOYoIeH/t4ZHzUXjG6H1dq880ogKTu16t6I4rquj1JquYSujADNqwPqi9awpPXc5jV+KTJC6wAWX7gnAUg9bNltvu2rEhJKbWrYmMqGWPmYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sun, 23 Jul
 2023 10:42:13 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 10:42:13 +0000
Message-ID: <0144b296-cbd3-9233-9593-1930c6154d4f@nvidia.com>
Date: Sun, 23 Jul 2023 13:42:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 6/6] vfio/migration: Allow migration of multiple
 P2P supporting devices
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-7-avihaih@nvidia.com>
 <be007d5b-1679-3389-8d6b-daee5be72c63@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <be007d5b-1679-3389-8d6b-daee5be72c63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 219c245a-7fbe-4222-e1f3-08db8b697963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHpxvmNFbUIczpPh52BiRpjrr5Bkz6oWgLx6CHl0wP6hRYID2AOe0oib9cMWDbrObiTPuEEbF2GDf3d2WJ7ftN69zEMNIoczg4bvObE8rkPdujc4Jh9uMcrugh3O1j/xtJ53hWvnGSD04JTNvDOH8f8xoQ4VKzueHbgf9h5CJ7LoLB5ZCIm7TUC2FWwn2EcVSZBEfm9DIRVq7KK/4z4xDr4Lxzrg7mdZa7fz9JOh7QvrxqqW8oh/m+K3nlqm5IAdKeKPJW9ayeyB12wGvcNNjZKAZcjMtTqS34wByHNIFvWOOS3Y3q/pdP2LhwchwdBOA7FnD597YM7hXZxX8dJlqfqr8yV/deWSNHtOqbyc1p/WCUjRTUF0YqoOW8noQqWHUzH4OQVrCqNFGVhkw2cG3a3O8//Wz7hyUJ+otnchek48dGrBFdOqaftGsJumI+yDbNKwBrZ0owrLsLaIo9oDqyN9Otb4BIFl2x7NrNKQ7K/Ch80iebbLTetNU081N4tJfgBkoqC3G6LUWMSJ+505gjpgtTUYaVqPHHeEgwTpyOehOgQvHSign8HKH8unw+CobH3/r+H5DKAxAhpdLMzGhke5ho2gvZXDr4j1bSbuSfci0XJRVp9EClzxy+c/h4LZ/iAuK2r94NiJXB3JSxxOXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66476007)(8936002)(66574015)(2906002)(36756003)(2616005)(478600001)(8676002)(41300700001)(66556008)(54906003)(4326008)(316002)(66946007)(5660300002)(26005)(6506007)(186003)(53546011)(6512007)(107886003)(6486002)(6666004)(31686004)(31696002)(86362001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdKbkVjbGcySWorL2JyRXFNVzNaRmgxL0hJMVl2YlpGNFlXQUJYZCtKdUFq?=
 =?utf-8?B?MHFMNkxOWGlScGQzQVVXQWxtclhrN09LWTZTL3hnckpkSVhsZUE0aGtNOWdN?=
 =?utf-8?B?RTJYOTBXTHp5OGJnbklNdjNlMmZOU3R0c3V0Sy84bXRHU2t1czdJL0ErcnBX?=
 =?utf-8?B?MitFak45WWZ3U2ZmS3Jpc0JpUTdObDhPN2NDdFhMZ2pTQndmTmd3RVl4a3g4?=
 =?utf-8?B?UmlJc1RNYmFEK1ErUHpnNVJ3Y2NUY3R1bXlzdTZ6cGJoU1lya0xMTlZia0cz?=
 =?utf-8?B?QXlYYXFDUnc5QnhnWkprUlUzbE5OS3RlR0pqTHNkcUxMQkpBd20rUDA1QWRX?=
 =?utf-8?B?bVd6a1NLK3oxcjI3UVBSN2s5WkJEZXVQeTMxT3IxaC9iSnJuU1hteXliWHlD?=
 =?utf-8?B?ZFFDR1lUaGdyMEs4dlFKUkhOUWl6MlBJYmszWXcrcnpERmNiRStMRVVVeXNT?=
 =?utf-8?B?OCtNdXh2WGU2bVlTSkNxRkkrbDZ6REhlcERNaklGNHdEUjNmRUpjanovU0xk?=
 =?utf-8?B?YU0zYkZzaGRTc2VZQWlodWtCd25jR0ZuU2g4VlVHNjI0ZkpIdElqSTFwUUJY?=
 =?utf-8?B?Q0ZBb2h4Vm9qVHViOUo4U05UU05tMENFTjFTOHExdjVsRjc1MkM1YTM3VG5U?=
 =?utf-8?B?ZUlhck5BQzQ3RFpXYlR0NmJvL2tkSWxiLzIxSDZEenNjRVROK1cya002eXg0?=
 =?utf-8?B?OUh4TCs2TFk5Y05tZEJJMVFTRmV0RFJYazhDNURRT3hQeUlNcHZzditSdHRW?=
 =?utf-8?B?akxJK0Fpc3lYaG54bnBSaHhKL1ZVcnRaVnpBUHh6UkhaZ0JLY09TZTJZT2lD?=
 =?utf-8?B?aVhXNXJhYjBocGI3ZDloTDRHSWJ1TWIycFFUNWVZWXBlcTBsalB2cFhLYTNX?=
 =?utf-8?B?M0dvZDlKTFFCVXlMY2FpQlg5bGpyZ3dhU0FTVlM1RVRtQ2JpYW1FWVJVY0Vq?=
 =?utf-8?B?L09PNEJOeFo2MmhJNmZ5eDh5NWNWaW56UC95WXBQT09rd1hXT1c1NmF4MXRB?=
 =?utf-8?B?cnYxQVhqU3JvOFFaeUxkQnpFM1FGdi9LZWU1eWsxbm41WlBxRU9DLzRra2ZT?=
 =?utf-8?B?Wm5GZWR6a0NUak1ZalF6Zm5iYnN4UENRU3VqUDJ3WTBrUHB0dWkzdURyOTJZ?=
 =?utf-8?B?cXcwamh3V1ZxMlpIVm5rbURQRGN4SWRPMWgwbEFiUnlqMEZWcVZNakxBb21V?=
 =?utf-8?B?Z1QyRW9Td0FQdGw4UW9RbTVST3JHNENOR2l6Um1FVndwWUNiTlAra2hmVzc2?=
 =?utf-8?B?UWtIcE0yZ0p6c29CSnROYTlhUEgvaHoxU3VENER4UEs5OTlTTVp2Z3VQOXB4?=
 =?utf-8?B?QzBHOFJFdGx2bml2N3dkOGlWbG5nRE1uZlF4SFR3RnZNOGVjZWFuUmdZYjlQ?=
 =?utf-8?B?enRkOWxJNW5tRENOYmk2cHFudllwODNUNk85cmU2Zm5jK09WQVRCOGoyWjNr?=
 =?utf-8?B?dDZmditNNVc4TFE3NExUSFA2dzl0c0xlSzlVeW5QMEZnV3lZMlRuT3BGcGFT?=
 =?utf-8?B?U05CaHBHWXFHdmFVZWVkTXI1Qm5VU2JEZVVad3gvSXdHZUZ6T0RIVkZTdlF1?=
 =?utf-8?B?a1BZSmkrajh6eVIxVTBmTFlvUDlFNXRNZDI4ZG1WWjdMMFd6V0JmeXpHRXJp?=
 =?utf-8?B?MHhYT0NHWnlJeW9UY04ySGs2ZThTZldxblhOc3pPVHlYTUZDc1B5L0tzR3Fx?=
 =?utf-8?B?K2tkdmpKNGNJRXBaTDRXMHJpb3BQT2F2anY3WWdVckY4T1VlNDd5WGlsVDl0?=
 =?utf-8?B?YTZPRCtlbGRBcEg5cUR0ajdwQjZyNnpSWXo1RE45dmJkZVhLM1JpMTA0cWt4?=
 =?utf-8?B?NjM1SUhmY3B0M04xc0VZSUVpUXpxemU0b05aRmdRUllBZTcvOTU2K21ubUxn?=
 =?utf-8?B?S1Y4L3IyM1ZPN2dSZzJFMXFOR3R6bDluYTZ5K1k2cHIwVUJRazR0UFptVmU0?=
 =?utf-8?B?dXpYTkJWejFMTUxobEhlVm0yQjdMQ3dXV010WDU3RWhrYnNZS3Nnekg0U0w0?=
 =?utf-8?B?TC9CMTY3WjJGY1lTVEdid0Q0M0t4TWE3WG8xQXZzbVl1ZVc2d2pJZFFRcDJV?=
 =?utf-8?B?S25maTRJQzIrQ1VyaUpLZ0xFRGhXeU8rdWtlb200Qm1mRVo4b256MnNKbXBq?=
 =?utf-8?Q?FsgvrHUjLTMwJB66yZ0F8NsmS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219c245a-7fbe-4222-e1f3-08db8b697963
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 10:42:13.0033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyZAEQWtsAZD5KlGBrbSSHMBeXRtqCcrxFiwSRPEuibwTesiZ951nLQc5lAOLHC1kMoOYnAa/pJmnR9LASAIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::61c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.024, NICE_REPLY_A=-0.093, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 21/07/2023 15:09, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/16/23 10:15, Avihai Horon wrote:
>> Now that P2P support has been added to VFIO migration, allow migration
>> of multiple devices if all of them support P2P migration.
>>
>> Single device migration is allowed regardless of P2P migration support.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c | 26 ++++++++++++++++++--------
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7c3d636025..753b320739 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -363,21 +363,31 @@ bool vfio_mig_active(void)
>>
>>   static Error *multiple_devices_migration_blocker;
>>
>> -static unsigned int vfio_migratable_device_num(void)
>> +/*
>> + * Multiple devices migration is allowed only if all devices support 
>> P2P
>> + * migration. Single device migration is allowed regardless of P2P 
>> migration
>> + * support.
>> + */
>> +static bool vfio_should_block_multiple_devices_migration(void)
>
> Could we revert the logic and call the routine :
>
>   vfio_multiple_devices_migration_is_supported()
>
> I think it would be clearer in the callers.  This is minor.
>
Yes, of course, I will change that.

Thanks!

>
>>   {
>>       VFIOGroup *group;
>>       VFIODevice *vbasedev;
>>       unsigned int device_num = 0;
>> +    bool all_support_p2p = true;
>>
>>       QLIST_FOREACH(group, &vfio_group_list, next) {
>>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>               if (vbasedev->migration) {
>>                   device_num++;
>> +
>> +                if (!(vbasedev->migration->mig_flags & 
>> VFIO_MIGRATION_P2P)) {
>> +                    all_support_p2p = false;
>> +                }
>>               }
>>           }
>>       }
>>
>> -    return device_num;
>> +    return !all_support_p2p && device_num > 1;
>>   }
>>
>>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, 
>> Error **errp)
>> @@ -385,19 +395,19 @@ int 
>> vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error 
>> **errp)
>>       int ret;
>>
>>       if (multiple_devices_migration_blocker ||
>> -        vfio_migratable_device_num() <= 1) {
>> +        !vfio_should_block_multiple_devices_migration()) {
>>           return 0;
>>       }
>>
>>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>> -        error_setg(errp, "Migration is currently not supported with 
>> multiple "
>> -                         "VFIO devices");
>> +        error_setg(errp, "Multiple VFIO devices migration is 
>> supported only if "
>> +                         "all of them support P2P migration");
>>           return -EINVAL;
>>       }
>>
>>       error_setg(&multiple_devices_migration_blocker,
>> -               "Migration is currently not supported with multiple "
>> -               "VFIO devices");
>> +               "Multiple VFIO devices migration is supported only if 
>> all of "
>> +               "them support P2P migration");
>>       ret = migrate_add_blocker(multiple_devices_migration_blocker, 
>> errp);
>>       if (ret < 0) {
>>           error_free(multiple_devices_migration_blocker);
>> @@ -410,7 +420,7 @@ int 
>> vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error 
>> **errp)
>>   void vfio_unblock_multiple_devices_migration(void)
>>   {
>>       if (!multiple_devices_migration_blocker ||
>> -        vfio_migratable_device_num() > 1) {
>> +        vfio_should_block_multiple_devices_migration()) {
>>           return;
>>       }
>>
>

