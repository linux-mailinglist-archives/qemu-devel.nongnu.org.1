Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043107241D4
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VY7-0000x6-TS; Tue, 06 Jun 2023 08:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6VY4-0000wt-Q0
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:12:28 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6VY2-00028M-1c
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtLD9p25rU87gAatwi2boSe8YRSbBc9bHo4ojd/oAwBAoCRZZm4av4Xy1y7uTM4DBrivjVDsfLQ7q+aKLrAUZ+R89LWZlcMpkjJC5NVYBG17sPf2AAfpkIrcqp9944lFQlC8TPvgWJfNFMUYfQpJtPWKXvPCfnqzqZ5nQnNE2gmK47e/o1NOpZciGANlt61SoTeqB+l+2wgeKKwnJNQ/RNxf3NKETOBP2ZFHMrx6ND8Pz9W4FyHf1+bd1nPGUxulKIk1MTjhqrcKtNp72faAo0HdCIQ5OMGtZWMIthQK6qwHCZCzsOow16xvf2fNS9rvTA/OyB4/6gH+/nLk10u/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7JXLLEZRiYumAOEQG+0EBsOxRTIpwzKVSj++OGo9Jg=;
 b=SGDSLOXjfiUdkKWIxU+JTq7nn/xP7NJlUzTOkGFKFlOLHj+Pv7zz8hQa7WsJcGc43WFGm/dMEuDG7Ua1kqyYtPaZ3ImyNXxZTljLZ7vRqmQR5VnCXTYNbp+Cb8FIC74B9A9z1mRBV64GxYgwvBJfs7cNypvnxItOleB8P+P9KJkjwyxb+pJY9A8omMOMNW5lywwt2BM2A2BjUgnLOlyTiTibrAZpAFdcorUlGbfor/6gmwi8KFmTYT2K7vhyd3ggrHlRaWQ2oKOeaXkHkn80pccU+nRGiHibqzTLlFxAMwK9sz/DtPZaYL84FCyFgJQSZITWzcj7v3Fguc6/R9ZELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7JXLLEZRiYumAOEQG+0EBsOxRTIpwzKVSj++OGo9Jg=;
 b=ZzmQZGhDGke0C9TInRZfvUVGZxlmjD03c2FaTVIzT04tPAEvccFHSTlGQGHmXDmlDVLhATR4iOcbv+3LS2c2+X35Dnx0JjqGU8pVnksdfK2pIXxP65hzQDBSjE5jyPYF3WNIuAcYFBHyn0WZ6IwsL7akOsqst0SbRZhuQ6UJLSqTWPeM7GcQiWzVIykd8dvGBo/eXpmTBR5us26ZQbtExrFn56C31dfpV5ez7FRuneKuT2SXbUjCDnSydegNp1H7RXEpuFUnnRdcB7JHGBRA541yLJ2pxXl0Ea82iH0/e21kGrPIT1Ef1fjlfjgUZ9/GQkylygxohKHc5ri1arBTsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 12:12:19 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 12:12:19 +0000
Message-ID: <2377a8be-9c60-8455-b735-bed18f0ba238@nvidia.com>
Date: Tue, 6 Jun 2023 15:12:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 2/9] migration: Implement switchover ack logic
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-3-avihaih@nvidia.com>
 <20230605160600.7df0993e.alex.williamson@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230605160600.7df0993e.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 1324a735-66ec-4e6f-6ea2-08db6687466b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+BxoeMcHZ7OTRwsyUO7n7DNpcEgtbS1D625f65NJ9SQaBOHApQz4B1ZicLV39cOZh5mY4nHMCyyYJpx3lzVEtdiQ+ibXcQLTAhSjRJ+ao/rHOtJnwG/MTCHpVsV9zfQ01kqXNxTMABh2CtQRWgYyxOQE1nBGzB8uNpoBjXIhsYYz3Zo0EY0oyeurYGYhnctX+nLmrIJxBcPdkruMD0DpHUoLKTUPxbnref+MFiFwdNaq5RikM+vmrPsTtoIKcLeFHOYgsbbbQPK7n8Ghjx8eWsoxOJ+bfqiFyAXc3qiMW1C0DVCev/YjUBEgnUVr8R891hPsXF3A6aF/PHDzxVJQYAffA9VCFO3o5mbEgEwYJHi1426KtG+quQ6odacdl7NwU/GznDmcRlauPdHmMCgnf+zhx4m00t3nrvCSfDtxi0vRrTjj3+g1S7PJOLLiMGwDEs4Td9PiAGtgQ3HM9TYc4NAFQp0icIgnuK5M/kiHLGUG+1ggzNvwIoITLs2Qt4AiZmKW2Wz4FKNxPJKJpOV2lNoVfliwZuWrUjbwo/efFUiv6zM7dogVCKwcokc/LdUEH42i9x1Jd/xYIv63EZGJu/SE/VsWsgLAP2+PD00h6UmSWOPL3sllNd/YTDB/5akSdT1DTS7wDFiVVGuWz42wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(54906003)(478600001)(6916009)(8936002)(8676002)(7416002)(30864003)(2906002)(36756003)(31696002)(86362001)(5660300002)(4326008)(66556008)(66476007)(316002)(66946007)(6506007)(38100700002)(2616005)(41300700001)(53546011)(6512007)(26005)(83380400001)(186003)(6486002)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjUwZ2J5UVVJTCt2cklVcm03bzB3SlV5OURFT05YUnREbU1vWWpISzZPclJ6?=
 =?utf-8?B?dUQrRFR0bTdEOUIvejl6aDRjZlhiNkJWOG9UZlNsbUxyR3hmejR4cHdrMEZS?=
 =?utf-8?B?UGpzc2lKdERRdUdsb0p6Yis2bldsVVpWVm8zaWd4NklIbCtZR2RSczl3NFhl?=
 =?utf-8?B?a1FJRGhtaks2dE1xSkhUSkVOWEJsTzl1OUhDNHIwSkFyRE55MFNnS1I0Q2xl?=
 =?utf-8?B?aDJ1RFBCN1Y5alhPbUhvMDFPUWRjN2poemxLZ1NhMmkzZ3B3MVJQM1lnWUx6?=
 =?utf-8?B?MUl5VHZLSVdLZlZiSVJJaGtQTWJJc2NqMnpSTFdMTU5jVTdzUi96UmV3Wm5m?=
 =?utf-8?B?aUdHSkdBZ2IydDByeVNqNVV6UE5KZzR6ZXhMUGVoTG5jdE1OR3pTclR1WGcz?=
 =?utf-8?B?N2lSbG1CR2YxUytjUndjYkYwWnZOVWV0RE9Bd1hXN2l4cXc5c29GQWRuWjVs?=
 =?utf-8?B?YXk1dUVhdEdadkhDeHVvV05yZDArd3VsdnVCaVBiTyt1NWFsUlRucUFLaDNz?=
 =?utf-8?B?ZWlFcG8xVzFXSThQbFFEcGZCQU5VUlc2cXAvMzloNWk5REFleS9ueVQveWtB?=
 =?utf-8?B?ZFFObTdvR0crTUxKczI4YkMrZ09GcHBETWp2eTdnNEVBRE80d2tkNnNvM1Rw?=
 =?utf-8?B?ejBqYzdwRDhuYUJReDd0UXM1MFF0cDJGOE15MlBFNzVRVGoxeGMxem9MRG1B?=
 =?utf-8?B?T1VzN0NXQ0RXYmtlaDZBVVV3ano5REdqMTEzSHpWKzlXM1NzRTJQV2RjTFk3?=
 =?utf-8?B?YnBnbzFOc2M0UEVreGlnUFcrR3dUQVlia2k3eEgxL1FMc3NOVFd5MVQvUko5?=
 =?utf-8?B?V2VEU3M0RUdoT0NpQk91ZEUxaHMvREZ3ejVudE5Rbm95ZkRvbnI2aEJtcnFM?=
 =?utf-8?B?Q0xSdTRIdWlKZzVWZWZnNkgrTFlvV0ZoWmtIMUkzbFVlanVSUjRLRHJ2RzRS?=
 =?utf-8?B?dVBsZ0ZZWUM0cjZWdHZPZWhNekN5ZXNCV3dRbXpOQjhmbnUxaU0wdCtKT2kv?=
 =?utf-8?B?TWJ1MlUwb3R4Njg5TXNUUmtYU1ZYOXdSMWZkT29jRXE4eHpYU1c5Uk5uWTN2?=
 =?utf-8?B?ZWVaeEdOTnppdzlWdG1XYTJta2hVNk1tTjFMZ1o4bldPZlAwMlJFbENOZFFK?=
 =?utf-8?B?QkVGR2pxMWliaWk3ZTAyRUVJQXRNU1Q0WTZsWEZ3UGJ0V1F4T1lPRVpDZ291?=
 =?utf-8?B?cmJzU2lIdjNSV3lEM2Z4QUJDWkY2U0VvWlR0WGt0NnZSK01jWGd0Z05hOHdj?=
 =?utf-8?B?OTV6OHh4K0FEb2czZjkvWEJVZGphQnhVTmVVVjJ5QURXbElENnhHQ042WHJF?=
 =?utf-8?B?MHhFTnpQWXkwQThkVmRkNlFtemRLWElSbitRbGZraGdDTnkrV0xhYlg2YmdN?=
 =?utf-8?B?ZXhlc1ovanRGK0Z6bXBuTnRMQjl3LzExUW80WSswVVNPSEt1T0NrK2tjVFZi?=
 =?utf-8?B?dTdwbFRQWU9ZNTg0TlR4TzVKVnpkK2FQV1FCRFY5MUl2Y2lqQ2Y3cWdBYjZV?=
 =?utf-8?B?N0RXMGxaUjhKL0pBdU1pTDdzRnljVHVkTStQZGZOQkx1UHppb2hzaG5XaHo0?=
 =?utf-8?B?R3ZXMnVaRXl2R2JEcUNHOEpNakowT0lxQVV3d2Fnei85VlIybWJOeElZVTJM?=
 =?utf-8?B?VnprVTkwek5PWDFYRDViaCtzMjl3MzZhYmJMTWpMMGd5U2pqM0praG9JcUJV?=
 =?utf-8?B?NDU3alY1OUlsNW5oM1krVzhtZFAvaVB6bnFXVzdGRm1YT0tFN0FpN0lXNmYr?=
 =?utf-8?B?SGIyR2NNbEhoS256ZGE4QXMrVmpsRndiMGM2ckg0SlU4NlpNVTN4cmFsWHBq?=
 =?utf-8?B?S243TWVhMjV5NjVZMlhxdktNRjRKL3djcXU0SkkySmo0RUU1aDk0Rk1xL0E0?=
 =?utf-8?B?amQ5WFhLR3FTc24zUExwb2I0ZVc3eXBmVEhjUGtuMjQwcXJyVXFRcnZBU0Fx?=
 =?utf-8?B?ck92TS9LcGpMMEp4TU1GMWFPVzN0eFNqbUxSelFORHdvL1V4YTlnTHB2ZHVz?=
 =?utf-8?B?dUh6eXQvSFV4NkpydnVaaVBrSmJUZXNXTXF2d1JoQzlRT1Y5N0ljeVNYaGti?=
 =?utf-8?B?WlQyK1VtZlF1bDAzbXJBKzhoWEpOb1JHdUVYTjRiQmhJRVRHdVNqKy9wM1ZN?=
 =?utf-8?Q?yRQDuOpgomu/hsaUpBMfd0Iv+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1324a735-66ec-4e6f-6ea2-08db6687466b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:12:19.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFjbWWdZhW78gb5XLuWADP9q+oHafVl9OG0YUlzabiDMlSbtyumiWScGoBubjpa0Zm8k4zBtxLa7i5UlrjaOag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 06/06/2023 1:06, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 30 May 2023 17:48:14 +0300
> Avihai Horon <avihaih@nvidia.com> wrote:
>
>> Implement switchover ack logic. This prevents the source from stopping
>> the VM and completing the migration until an ACK is received from the
>> destination that it's OK to do so.
>>
>> To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
>> and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.
>>
>> The switchover_ack_needed() handler is called during migration setup in
>> the destination to check if switchover ack is used by the migrated
>> device.
>>
>> When switchover is approved by all migrated devices in the destination
>> that support this capability, the MIG_RP_MSG_SWITCHOVER_ACK return path
>> message is sent to the source to notify it that it's OK to do
>> switchover.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   include/migration/register.h |  2 ++
>>   migration/migration.h        | 14 ++++++++++
>>   migration/savevm.h           |  1 +
>>   migration/migration.c        | 32 +++++++++++++++++++--
>>   migration/savevm.c           | 54 ++++++++++++++++++++++++++++++++++++
>>   migration/trace-events       |  3 ++
>>   6 files changed, 104 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index a8dfd8fefd..90914f32f5 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -71,6 +71,8 @@ typedef struct SaveVMHandlers {
>>       int (*load_cleanup)(void *opaque);
>>       /* Called when postcopy migration wants to resume from failure */
>>       int (*resume_prepare)(MigrationState *s, void *opaque);
>> +    /* Checks if switchover ack should be used. Called only in dest */
>> +    bool (*switchover_ack_needed)(void *opaque);
>>   } SaveVMHandlers;
>>
>>   int register_savevm_live(const char *idstr,
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 48a46123a0..1e92ba7b1d 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -209,6 +209,13 @@ struct MigrationIncomingState {
>>        * contains valid information.
>>        */
>>       QemuMutex page_request_mutex;
>> +
>> +    /*
>> +     * Number of devices that have yet to approve switchover. When this reaches
>> +     * zero an ACK that it's OK to do switchover is sent to the source. No lock
>> +     * is needed as this field is updated serially.
>> +     */
>> +    unsigned int switchover_ack_pending_num;
>>   };
>>
>>   MigrationIncomingState *migration_incoming_get_current(void);
>> @@ -437,6 +444,12 @@ struct MigrationState {
>>
>>       /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>>       JSONWriter *vmdesc;
>> +
>> +    /*
>> +     * Indicates whether an ACK from the destination that it's OK to do
>> +     * switchover has been received.
>> +     */
>> +    bool switchover_acked;
>>   };
>>
>>   void migrate_set_state(int *state, int old_state, int new_state);
>> @@ -477,6 +490,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>>   void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>                                    char *block_name);
>>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>> +int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
>>
>>   void dirty_bitmap_mig_before_vm_start(void);
>>   void dirty_bitmap_mig_cancel_outgoing(void);
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index fb636735f0..e894bbc143 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -65,6 +65,7 @@ int qemu_loadvm_state(QEMUFile *f);
>>   void qemu_loadvm_state_cleanup(void);
>>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>>   int qemu_load_device_state(QEMUFile *f);
>> +int qemu_loadvm_approve_switchover(void);
>>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>           bool in_postcopy, bool inactivate_disks);
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5de7f734b9..c73261118c 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -78,6 +78,7 @@ enum mig_rp_message_type {
>>       MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
>>       MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>>       MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
>> +    MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
>>
>>       MIG_RP_MSG_MAX
>>   };
>> @@ -760,6 +761,11 @@ bool migration_has_all_channels(void)
>>       return true;
>>   }
>>
>> +int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
>> +{
>> +    return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
>> +}
>> +
>>   /*
>>    * Send a 'SHUT' message on the return channel with the given value
>>    * to indicate that we've finished with the RP.  Non-0 value indicates
>> @@ -1405,6 +1411,7 @@ void migrate_init(MigrationState *s)
>>       s->vm_was_running = false;
>>       s->iteration_initial_bytes = 0;
>>       s->threshold_size = 0;
>> +    s->switchover_acked = false;
>>   }
>>
>>   int migrate_add_blocker_internal(Error *reason, Error **errp)
>> @@ -1721,6 +1728,7 @@ static struct rp_cmd_args {
>>       [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
>>       [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>>       [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
>> +    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
>>       [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>>   };
>>
>> @@ -1959,6 +1967,11 @@ retry:
>>               }
>>               break;
>>
>> +        case MIG_RP_MSG_SWITCHOVER_ACK:
>> +            ms->switchover_acked = true;
>> +            trace_source_return_path_thread_switchover_acked();
>> +            break;
>> +
>>           default:
>>               break;
>>           }
>> @@ -2700,6 +2713,20 @@ static void migration_update_counters(MigrationState *s,
>>                                 bandwidth, s->threshold_size);
>>   }
>>
>> +static bool migration_can_switchover(MigrationState *s)
>> +{
>> +    if (!migrate_switchover_ack()) {
>> +        return true;
>> +    }
>> +
>> +    /* No reason to wait for switchover ACK if VM is stopped */
>> +    if (!runstate_is_running()) {
>> +        return true;
>> +    }
> Is it possible for QEMU to force the migration to continue regardless
> of receiving an ack from the target and is this the check that would
> allow that?

Yes. If you stop the source VM then migration will not wait for an ACK 
to do the switchover.

>
> It seems that we don't know the downtime allowed for the VM in any of
> this, nor do we know how much time the target device will require to
> generate an ack, but we could certainly have conditions where the
> priority is moving the VM from the source host regardless of the
> resulting downtime.

In such cases you can keep the switchover-ack capability off.

>
> Also does the return path requirement preclude offline migration or
> does the above again take care of that if we pause the VM for an
> offline migration (ex. save to and restore from file)?

I suppose that by offline migration you mean migration where you stop 
the source VM first and then do migration?
If so, offline migration should work and in that case we don't care 
about the ACK as downtime is not a concern.

However, migrating to a file doesn't work with return-path, as you don't 
have the destination side responding to the source via the return path.
For this reason, using return-path when migrating to a file doesn't make 
sense.

Thanks.

>> +
>> +    return s->switchover_acked;
>> +}
>> +
>>   /* Migration thread iteration status */
>>   typedef enum {
>>       MIG_ITERATE_RESUME,         /* Resume current iteration */
>> @@ -2715,6 +2742,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>   {
>>       uint64_t must_precopy, can_postcopy;
>>       bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
>> +    bool can_switchover = migration_can_switchover(s);
>>
>>       qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>>       uint64_t pending_size = must_precopy + can_postcopy;
>> @@ -2727,14 +2755,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>           trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>>       }
>>
>> -    if (!pending_size || pending_size < s->threshold_size) {
>> +    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
>>           trace_migration_thread_low_pending(pending_size);
>>           migration_completion(s);
>>           return MIG_ITERATE_BREAK;
>>       }
>>
>>       /* Still a significant amount to transfer */
>> -    if (!in_postcopy && must_precopy <= s->threshold_size &&
>> +    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
>>           qatomic_read(&s->start_postcopy)) {
>>           if (postcopy_start(s)) {
>>               error_report("%s: postcopy failed to start", __func__);
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 03795ce8dc..285b814726 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2360,6 +2360,21 @@ static int loadvm_process_command(QEMUFile *f)
>>               error_report("CMD_OPEN_RETURN_PATH failed");
>>               return -1;
>>           }
>> +
>> +        /*
>> +         * Switchover ack is enabled but no device uses it, so send an ACK to
>> +         * source that it's OK to switchover. Do it here, after return path has
>> +         * been created.
>> +         */
>> +        if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
>> +            int ret = migrate_send_rp_switchover_ack(mis);
>> +            if (ret) {
>> +                error_report(
>> +                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
>> +                    strerror(-ret));
>> +                return ret;
>> +            }
>> +        }
>>           break;
>>
>>       case MIG_CMD_PING:
>> @@ -2586,6 +2601,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>>       return 0;
>>   }
>>
>> +static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
>> +{
>> +    SaveStateEntry *se;
>> +
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (!se->ops || !se->ops->switchover_ack_needed) {
>> +            continue;
>> +        }
>> +
>> +        if (se->ops->switchover_ack_needed(se->opaque)) {
>> +            mis->switchover_ack_pending_num++;
>> +        }
>> +    }
>> +
>> +    trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
>> +}
>> +
>>   static int qemu_loadvm_state_setup(QEMUFile *f)
>>   {
>>       SaveStateEntry *se;
>> @@ -2789,6 +2821,10 @@ int qemu_loadvm_state(QEMUFile *f)
>>           return -EINVAL;
>>       }
>>
>> +    if (migrate_switchover_ack()) {
>> +        qemu_loadvm_state_switchover_ack_needed(mis);
>> +    }
>> +
>>       cpu_synchronize_all_pre_loadvm();
>>
>>       ret = qemu_loadvm_state_main(f, mis);
>> @@ -2862,6 +2898,24 @@ int qemu_load_device_state(QEMUFile *f)
>>       return 0;
>>   }
>>
>> +int qemu_loadvm_approve_switchover(void)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    if (!mis->switchover_ack_pending_num) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    mis->switchover_ack_pending_num--;
>> +    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
>> +
>> +    if (mis->switchover_ack_pending_num) {
>> +        return 0;
>> +    }
>> +
>> +    return migrate_send_rp_switchover_ack(mis);
>> +}
>> +
>>   bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>>                     bool has_devices, strList *devices, Error **errp)
>>   {
>> diff --git a/migration/trace-events b/migration/trace-events
>> index cdaef7a1ea..5259c1044b 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>>   qemu_loadvm_state_post_main(int ret) "%d"
>>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>>   qemu_savevm_send_packaged(void) ""
>> +loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>>   loadvm_state_setup(void) ""
>>   loadvm_state_cleanup(void) ""
>>   loadvm_handle_cmd_packaged(unsigned int length) "%u"
>> @@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
>>   loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
>>   loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>>   loadvm_process_command_ping(uint32_t val) "0x%x"
>> +loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>>   postcopy_ram_listen_thread_exit(void) ""
>>   postcopy_ram_listen_thread_start(void) ""
>>   qemu_savevm_send_postcopy_advise(void) ""
>> @@ -180,6 +182,7 @@ source_return_path_thread_loop_top(void) ""
>>   source_return_path_thread_pong(uint32_t val) "0x%x"
>>   source_return_path_thread_shut(uint32_t val) "0x%x"
>>   source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>> +source_return_path_thread_switchover_acked(void) ""
>>   migration_thread_low_pending(uint64_t pending) "%" PRIu64
>>   migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>>   process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"

