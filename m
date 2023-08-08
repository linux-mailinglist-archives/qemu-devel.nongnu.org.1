Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779877382B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTGCl-0004sX-B0; Tue, 08 Aug 2023 02:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qTGCi-0004s1-Pt
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:28:28 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com
 ([40.107.243.77] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qTGCg-0007D6-9K
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:28:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McKXpEs96TXxwXOrfH8gMxMKTE9dGQa3hkSoRHs0Bw4uj+evzJosBOUEAiUWJ/3HJs4U7wg/7qvs10QYu5x7vvURIULscotWAvR7nZBx+Jrr5J9f3gzPmXiwQa6vxq7nXcgORCrygIafV9ZO1+Bn540klIsF9qrCehvsipIzuheXM1XEBZX2LCB7s82eNZkTJQyxxmXY2ZUizl1S7cyBxojWEI3zwvOZ/OouSHDzwxzlYsoXuqjdSoadxA2DtGSPGchY1RHYibPxHY8X+1DYPfaBFp5hgIEzwYiOw66XnrwBDoABkyT6ynbuK0jS9+/1a9w/9PfAAaBcz7VgmluP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idc4xstbIA56R3RWt0Kx90PwpnE3SKe/58g3329umyk=;
 b=Gz+5Us9P063jxi7Ci/dX5LnxpLQYuogLDuE9BxFCo1VAV2Ytj34l4xhzi0CkajpOjTicukzCjJ5dmuBRLxITOt12P9BzZhYJ8P+ID+DzKFEHfgzHw9/EbbYJS239Y6zcYWbO17N6t4/jEk6v/A/QA98x3lAeaDnvxW498E/gg/LXw7lgLPsJb7/MOp6gCRnixeYOhPWFR2NN2AoNoXo92t1ruVqxyz9WW4LvTNW8QNx9mASElqWBVZAw76sblR/w2hai9DLDSCgaLwAvzxQPU3Mpna6Mx43xIGOuVAgDZeWEy3QrZLVy9u7eyE1zRMSzqlSs6bwOp/LuA78yT6IxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idc4xstbIA56R3RWt0Kx90PwpnE3SKe/58g3329umyk=;
 b=q7OKu2j3OUYvZ35hIWj9+QOORTU44rOR4PpZ/HwXygpH2sVxTu19oPH5n5brVYtAxQO4iuX3LNFIRz670WRPYjCeQfc68hp1SGDwXRhL9ORrer/HpBnYtD6e3qgrmMq0LP+f/7oJZ7mHdmeLhq3+Pl92ulcUFQoTfRB873xeD+D8rnTCqbWqyK7Xq+IrbFMC4W6Ki+2Lh67HJYJi0aHWWUIRnv7GzaB9Bg4jmW/ezCFnJyqtOq4hjiUzd9oJE5kzLaEYr0/3JQhaQfsvDjhSYUQKCprf7LWarWsqqSt5fTrjshHCIG+EkUP2jOxJwB9HYLzDC9xUfFtFMPGhBReE8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 06:23:20 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 06:23:20 +0000
Message-ID: <d870e5d4-dd34-6cdc-7586-971928927869@nvidia.com>
Date: Tue, 8 Aug 2023 09:23:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.2 v3 1/6] vfio/migration: Move from STOP_COPY to
 STOP in vfio_save_cleanup()
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-2-avihaih@nvidia.com>
 <cc6d0b1c-036f-00f8-41fb-6ef1c59cafa2@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <cc6d0b1c-036f-00f8-41fb-6ef1c59cafa2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 830eac56-e241-4349-7095-08db97d7f562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gUivihBzKcZOoWCCdKk4gNMIX77Lu87ote6l2q8Wra0wprvC7zzz2xOmZIx8dhc7uuJMYjOZmPELr/+mLB27tiVbpWuYZcY+GF3jO7JIrsj4P+qZ3og+BNisXCYrXsFXMLkwy1B0nBOPoFm/E/az+nMspW+Ae59aGkf8Y40C98dDZYZ/qGIHTa6j5bt4hVNGen/eeWvB50abzeTBkXslUU2EfPOVxxfmZF95cpms2dXT2HKourbEvBEfedqEQmXcKWiTepo9vFhW6JP+PhUeiudfQVpaWvuPxqrfG2dcYnedDRyOBYjfM0/tSF5+uZAa2z/OKtbr8q27dngj20oxvHrPH4Ne1PZBwLHqV15XYtm5Lh7Ma5U1IiPSVkhyFYZHIePpSHzE5W1kQI+PuBXtJj+GPxQO+sLLJOL2CMpZACiAjpgQyOaqDGSFxhzZ0j2Ga+wC4CEsa6uQO3rN2kMMYEJ6DXffHPlk/LZD+iqUn4zeHvqUhAa/HUfn7XB7EvAm+WdYjk/tPDwMvhMsJXO9vtEvCSqpV+5NZX+LdeCEagmaPFUJzM0ox4OiK9R2mX6IUHmE9RceYHx3Uu8dPbaJCw3bBB14W70upo4ABymwA+RI3trcqa80m+TRLQ/iHdIWPE707Spwu5Fdi2qWYDj1opgAIys4ofGjqkaYCnzCq2z35miQ0TqmQxJRrMpmPdo1w6rBeidPbCDgou+43azgbdajJDxIXcX3Qsje1+MhhL3d46TDOBphW9KrB7A+9lkU3aJ9qWcn/TWwhag04AGWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(90021799007)(186006)(1800799003)(90011799007)(2616005)(4326008)(6486002)(6666004)(478600001)(86362001)(6512007)(54906003)(31696002)(26005)(36756003)(6506007)(53546011)(5660300002)(316002)(8936002)(8676002)(38100700002)(41300700001)(2906002)(66556008)(66946007)(66476007)(83380400001)(31686004)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTN1VWdBR2c4b2JYQnhMQktML0ZwcmhyTDFkWFdaVHVQV2o0b3MvYlFOT1V1?=
 =?utf-8?B?T0xoK0dKL1FwM2c3UXVOYit3OFVzYktKQ2s2MlZWTWQ2ZUlmNSt0YUxxMG5N?=
 =?utf-8?B?RVU4RC9EbTFybTlMdU45Vk9ibFlzQnZDUHlLM3hWc3ZtZ3hpczBlS0x6RjVx?=
 =?utf-8?B?dVBCZndtWmRuQkhiYm1rVzAxd2ppdWxKY1ZHdmIvdXptVXN2SXVUajhlNE1a?=
 =?utf-8?B?amJ5WlhIQ2ZtV2FMVGZpU2RUaFBFN0lBRi9oSWxJQTUzT3lINzF4RXRDSCt4?=
 =?utf-8?B?Z21oZTE3LzlXdnBERmlrZ2lEdCtaVFhoWEJuaFkxN1JvSEtUNnIxTVlqZ2k0?=
 =?utf-8?B?R2lqeHdQMDdkbmJyZGxaK1JsQUgvR3JMUkR0bkV1TE5pSEhZbU9yS2tqcU1K?=
 =?utf-8?B?WVdaQmVldnFSMS9qUWdQdmhEM0dQU3AzNXJ3M25ZOG5qVHZadjlJbWdzSjVu?=
 =?utf-8?B?aTNRMmlhVEFSbHhSakZCeGJNbjVtYkJQbWhHeXdRR09ncXU0NW1SRGcxN21Q?=
 =?utf-8?B?SEVYNmZySnZYYW1ablhYOExxQ201R1UxYTYwSzJXNUUzSDdYNmF2RXpZVm9w?=
 =?utf-8?B?bGFKaHA2ckk4a0lWWUJYNEYrN2JTa2hQZjRWYkljSWZZMmlDN0IzUmdRMS9z?=
 =?utf-8?B?UEJvdkZnZGRUWlNZdnpDSDArRmoza3F0R1dyT2REc0tySGlidG5hU3RISitu?=
 =?utf-8?B?RTRmNFExNW5XSjRWWHZ1QU16TzJNNkNxOFY0SERlQUswaE5weFhnQkZMTCtZ?=
 =?utf-8?B?WjZuWWNlTmRVM09XUzFTTGhnbytjUFNQbW8rTmlDajY3aUc2R1RWU1lzZ3RC?=
 =?utf-8?B?WUNYV1Nxblg2N0FsN0Y5NHRuaGl2TzZPYzhHV1lLbmxXWmQvR002MFVyNkx3?=
 =?utf-8?B?bzl0WUVuL0RMSnpaVWxPc2pDWnQvUzZXNDk4VUphMnQ3OHJJcUhOeU1xeE9X?=
 =?utf-8?B?TkxqVjZNTzRoOGkxaHJVRlNRYWFVZGhqVS91V0hkdThzaytPMldRMzNORjN4?=
 =?utf-8?B?d0lMWlNvMzZGdnI0b1NzZEViNFZNZW5iVEVFY1prUTJlaEFKYmgyeVhXWUl1?=
 =?utf-8?B?WUlmRndFLzNPR3FySFBJT1kvSUdXS0RtZEdmY3UyTHVGM3pDZGw2QzVBNkE4?=
 =?utf-8?B?UkNFaHpVTFc3aGl4N0hsU0o1b3VMNlczWm5TMFBHajVtNEp3cEFPNHFRTzdI?=
 =?utf-8?B?Qkw3d29YaXFrOEZJQWpsM3RmYmhaeHBtZUhYL3I3Mm1ZM0JKWXAzenJ3Si9V?=
 =?utf-8?B?aVQ5L3FZUndUN2tvS1NWcTRkVTlNQXVhYTBpdkF2a3Y1SGZBamJBd2FFY1p1?=
 =?utf-8?B?NzcrY1JyOUdwSXRla3NrOUtnRUlFcWtpcVZXZStqaE53Z2tJQndJODNIdDJk?=
 =?utf-8?B?QnByMlF6NlR5STlhVzl1NEFhcElMQXluNXU3NzZ5cE9FeU9ockZISGdGNFlj?=
 =?utf-8?B?ZU1iRWpweTgvUVIyZFJkMllmcWE3emxWbGlVaTYweThCdWFMSytSa0MrWnk1?=
 =?utf-8?B?dGZqQWtNQkpNVGNpcEM5Q2NxNDlkNklhUi9xVFdwdFdIVnVOYUdDc1lQVmQ5?=
 =?utf-8?B?WEo0MXVtN2ZpYzdwQXl3ajdDS2UvUklIK1BYODZscFh4M1lXcTlUdGFaZ2ts?=
 =?utf-8?B?ZmwraDZnNmpIbkNlTk1sakpCUWc4c21FQzF1eHkxZGFIK3hFZVpJRnJ3WU9s?=
 =?utf-8?B?QW53ZWhQZitNc21MUk1hbnh3NWhjcG9GSjRibXdaMkduK0xCL1N5YVdQR3FG?=
 =?utf-8?B?SkZuVHhDOXFJMjIwS2V4bE5lVkJmbG1iYVU0cERxYXZjblJ5MEJBeGhWeDlI?=
 =?utf-8?B?K0NPczU1Y2VXM1kvL04vK0JEYVJ5K0VxQUQwU1BGVWpUd1YrdUVlMXZPa1lT?=
 =?utf-8?B?Z1VaeHVtMzNGRnJ1N2RxTzdhSFM2K1NYWnc3SnhKWTV1bnBIQmEvY3ozMzF2?=
 =?utf-8?B?K05oR3pFazJSSlBoQk9WcEZSamo0cFdpZ2F6TnZBT0dnVGNoekQzd3ZSWnd1?=
 =?utf-8?B?em9uN0dqUXBlOGkxSWlxNXprQW1WaTlBcXREMVdPREJkY2xXUnJMNURkR05X?=
 =?utf-8?B?cmR1S21nTHlDL2VoODlzWFIzbmNrQnZNNW9iVEhHaSttY2hkK2gyZi9xVEVy?=
 =?utf-8?Q?+RhoVQcZL8ziCJ5b+ReZhaUsq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830eac56-e241-4349-7095-08db97d7f562
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 06:23:20.0146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu/DlNu757IlaVU2f7Ut+x7AnbuN/Af2GC4hHseF0hziPhnti8Ml52uOpEzk7iW/58wC8ZxZmE3+10lo9RBo4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Received-SPF: softfail client-ip=40.107.243.77;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 07/08/2023 18:53, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> [ Adding Juan and Peter for their awareness ]
>
> On 8/2/23 10:14, Avihai Horon wrote:
>> Changing the device state from STOP_COPY to STOP can take time as the
>> device may need to free resources and do other operations as part of the
>> transition. Currently, this is done in vfio_save_complete_precopy() and
>> therefore it is counted in the migration downtime.
>>
>> To avoid this, change the device state from STOP_COPY to STOP in
>> vfio_save_cleanup(), which is called after migration has completed and
>> thus is not part of migration downtime.
>
> What bothers me is that this looks like a device specific optimization

True, currently it helps mlx5, but this change is based on the 
assumption that, in general, VFIO devices are likely to free resources 
when transitioning from STOP_COPY to STOP.
So I think this is a good change to have in any case.

>
> and we are loosing the error part.

I don't think we lose the error part.
AFAIU, the crucial part is transitioning to STOP_COPY and sending the 
final data.
If that's done successfully, then migration is successful.
The STOP_COPY->STOP transition is done as part of the cleanup flow, 
after the migration is completed -- i.e., failure in it does not affect 
the success of migration.
Further more, if there is an error in the STOP_COPY->STOP transition, 
then it's reported by vfio_migration_set_state().

>
> I wonder if we could use the PRECOPY_NOTIFY_CLEANUP notifier instead and
> modify qemu_savevm_state_cleanup() to return the error which could then
> be handled by the caller.

qemu_savevm_state_cleanup() is called as part of the cleanup flow, so I 
don't think modifying it to return the error will give us added value.
Unless I missed something?

>
>
> No need to resend the whole series. I think 2-6 are good for merge, I 
> will
> probably push them on vfio-next when -rc3 is out.

Great, thanks!

>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 2674f4bc47..8acd182a8b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -383,6 +383,19 @@ static void vfio_save_cleanup(void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> +    /*
>> +     * Changing device state from STOP_COPY to STOP can take time. 
>> Do it here,
>> +     * after migration has completed, so it won't increase downtime.
>> +     */
>> +    if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> +        /*
>> +         * If setting the device in STOP state fails, the device 
>> should be
>> +         * reset. To do so, use ERROR state as a recover state.
>> +         */
>> +        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> +                                 VFIO_DEVICE_STATE_ERROR);
>> +    }
>> +
>>       g_free(migration->data_buffer);
>>       migration->data_buffer = NULL;
>>       migration->precopy_init_size = 0;
>> @@ -508,12 +521,6 @@ static int vfio_save_complete_precopy(QEMUFile 
>> *f, void *opaque)
>>           return ret;
>>       }
>>
>> -    /*
>> -     * If setting the device in STOP state fails, the device should 
>> be reset.
>> -     * To do so, use ERROR state as a recover state.
>> -     */
>> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> -                                   VFIO_DEVICE_STATE_ERROR);
>>       trace_vfio_save_complete_precopy(vbasedev->name, ret);
>>
>>       return ret;
>

