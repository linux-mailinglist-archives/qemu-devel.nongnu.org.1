Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E7D78D509
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:13:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIC1-0007x0-9g; Wed, 30 Aug 2023 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbIBz-0007wV-F4
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:12:55 -0400
Received: from mail-dm6nam12on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60c]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbIBw-00083O-GI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE4/AjZvBSRpzXmrAJpnr8b6roXSO1bsdLWE64p0coo3y+dPXc0WzIuy7c0RU2hXmw/QaqJQ1qzUzWxed+iIljVmsqwh0T00iuHH4WBPgzSVwHlb5SoW/v+ss6SFJMXH9WKJbRjnOzx1Rw80pnPov4inGKlTteN9KUR/n85O5y7CRJdNiLVLBMWTqp6jrVaiqr4X/jiRK5WhqHCkMXoeoSVyBtQv7Co69VRto0qXZiEVJLqvZtCREjISPH0/U4+OZsNAf32W0gNVP8TOZf6/mH47wWlis+hpbJg1z7C7iJCWbrgqcIBnrqIuG+Hr8rokagX4/f3z2MQZ+STlA1U3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qh4XUm4mho34dMJMbY3SEQXekyIY9NiGPiQuPgUlXc=;
 b=RYl+BmurssmACy1t1AjPnw1iLam/ram0nE6HJyXVwlqn04epSzEsVZ4DI0C1P1FA/r8xFKmsrauFRRYvyoR9SdRH91PMdyrEWr9X9DuHlVBtOXYoY3pmZX+JPl9HZr05HvXBKmeNpi7aNAuYEsBV7sDgdyzjhD5DetAjrmVy/V7kfYhmaIcD+7FAiObxbtzie+BIhHoVz9fSlk6WuIE3DU3uuc7qtCgWN18WJJhdzzu44GBxTh9z50YDtg1v6pOUSULUrbmwyzDvo6pXoi9n/vXe1vYepJk7qDNIm+5ajAkd9SG4Wh+CWoPrIU1QT8S1HjRoLsN9kqDFN1DsffbfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qh4XUm4mho34dMJMbY3SEQXekyIY9NiGPiQuPgUlXc=;
 b=IzOtozmRut5u/Av9aQq3pnSJvVQZXtifb6eRvivuCCzx6YqEcXJBNu8spIHNMB2B8d77Ld4lRpObm34qJg254s9pYX+MQpRg0I6r803aQszYjH+RhtdEuHdR/RLA34Z5wn3Eelo87JKKf3MdTmb4Jmnh8iy22v6aVmvfkGi0jxYk+/dF6f5jdBHZjZL5ahd7Krvy7jSLvzpXwNQNPAVzkpZ4hk42avJ/Qh4ev99exYKlfRVTg9HyzF1toCd9gOrR6cXtHxubjyjkAGOHajzPZGE/UnyxkGc/nnKh0EBkHdyz9chAJwAXscmiws37lp5wLu7MX5Kfm+dV4cIGiRpzKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 10:12:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 10:12:48 +0000
Message-ID: <2ce812f6-3372-fd3d-b0f3-46f12a9dc64c@nvidia.com>
Date: Wed, 30 Aug 2023 13:12:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com> <ZO44klknC6hpd7mf@x1n>
 <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
 <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
 <e3d3b6f8-2877-620e-66eb-6d3a53d65bc6@nvidia.com>
 <d036904b-6106-2cfd-6533-70f0f70fea2f@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <d036904b-6106-2cfd-6533-70f0f70fea2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2a2472-66bb-494d-9b26-08dba941a978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d81brvla+5mXYXhOt+npusSdMRdF/DuG1CH5AxlyjPtH3j5YKfSoID5KeUsHoKhN8sxDFIsDkjAGCTlbI0ciotDDcORMWfssy40z8/9uPz4P9nHwvJR3FwW4Zx0LoXcfN04+TTRppTKOK6QikMI/mgMsvMCSfXa4eiEwwmwxqwNG3tCOZEtCBE5FSETRIS0F2TVGyy78kCCvYCDgaTFJNnM8PlGUwo07Gz/GrCkMZYOFSdvG/DEXtZJ7V+m7N9uP5WLcRhAVn91bV/eEz15laoofhNIzRC4SZttRARSwepY+MTPleSwZWkEo7bj/96g4sH4CRhpiNUAsfGdKG/7NiHTGYWWpWY8pNcdoQfRjS5H32hWGosiCV8W3pn1HTzOEZv5r/EL3WJf0s39PqqeK2LjyT2Yu1Aq5bjxOINoKf6BXF1sNFQ4GPgZ2GskIwYr/2TgWy7srSMHkBXruQ53CPRxfwHZeQ3BlJ4n1sSnzLcrHIQOghpQxTkdIc87i7RtxfNY66z0F2bBUyTSHoua9RAzoy+rYuMSvQCgvLuiSkWENLdsq6IYRUR6nQujK1J0FwPTXS1UGeXVqHGbSlnOR5DYEvuCvivM4/s1TzTH7PeilaJBpCDDkTgHAZ0kwTI0NJD/KaPVTCZGHc5nT4SwIGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(110136005)(53546011)(478600001)(31686004)(66556008)(6506007)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(5660300002)(8676002)(36756003)(83380400001)(2906002)(31696002)(2616005)(86362001)(66574015)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFMNkpZNkFtbVN4ZXFicE5mMEtnVlVrUWlablZpSm11T1YwWjBFZ0gzM28r?=
 =?utf-8?B?MHZCU1RmNjJOOXBiSHdlVTRaMzdTTDNoRGFTR3o4SUQ3ekthK01WajBlRlJY?=
 =?utf-8?B?NjBuaUUwSEFreWs3Mkx2bWVlNW9pTytoRStNS2dzZXVSdlBsbUpibjQ1elJk?=
 =?utf-8?B?VTY1UHowUVJHOWYwNldyYmdsdEFGeUJxYjZYUFl4L3pjb3JNQ1pod0kxd1Bl?=
 =?utf-8?B?QXR1QnhNekNPRmM5Z3VpK0Z6SmgxYjJmbXVFMmdidHpkMGtLdEE4YnVINXMz?=
 =?utf-8?B?REFNNHdTcllXdkE2VlNxeHFYK3FVVHJqYUNXWU1PZFdnclFHWTkrWkJNcWVk?=
 =?utf-8?B?eHFpcWl4QSs5NC9Ld1lMSzAwcHYzUjZzTFBxVEsvTzNBWmRtTWF0OGRud1A4?=
 =?utf-8?B?ajMzZkZ4QkpjWkNieHUzL2NPT2hmN0IyY1lOeURPRjFWUGJHVTFuZ0VnWnI3?=
 =?utf-8?B?VXNLVHdJM2FMd2Z6a1FsNkpkelBiV0hvU3U0aS90Y3ZmejJraW1ucXgzUGFh?=
 =?utf-8?B?SDhYeno4aUV0ajFjMi9sSVVlYkNid1k4VXlHZVkrQytEMVFDR09XblNscFhG?=
 =?utf-8?B?emhnU0JldHM5cVBKUkZGLzNRYjlYWmRTMTIzS1d4amY3RWdTQXlnZi9Ibk1X?=
 =?utf-8?B?NURMWnMyL1ljTTMxTDhBVURDVlQwZFNQTDBUcmFQcVhhSEx1bzIxbGRoMVc0?=
 =?utf-8?B?a0dpUmY0MFdQcndxdloxQ3pyOTgyYTlnMU5WT2Nkbi9jU09CR3R5d01hdXpp?=
 =?utf-8?B?d2tUMVlnbW43bXl2WHFhYzFYNjhZcUFpYm5MQmtpYXI4bmU2SlJBM1dZd2JZ?=
 =?utf-8?B?bkFVQ2F4V2I3aG5xQVpFeFpMRWh0WjBFZnA5TlN6WS9paTVFdkliSTAvaWM1?=
 =?utf-8?B?dURFQ0pVR1ZySEdWSWlGS1c1S0VXdmNaQUJqM0UzSk5PbC92K2xJWFNaUVM4?=
 =?utf-8?B?eG9MNE5OUjUxQllTTUdGWlptYWNpSTBwdDJudmU4cGxKM1RsWWNkSmFDZUV3?=
 =?utf-8?B?cDJsdUc0cEU0OVBvWW03WUgvM0dBckw5Tk5WUytldW5LR09YSTNNaktMeEI0?=
 =?utf-8?B?cVNhMldsTnZ1bE9jcHA5UGVFZFlFRlJWclR4bnI0YVNHdDdpL01zVXp5OS9F?=
 =?utf-8?B?VjBEa3k0Q3ZFb1J0SVMvUVllWHFLZlp4eHpTOUFBWlA5ek5SdkdKdDhpbjBh?=
 =?utf-8?B?THRHVDJoVFNhMVh6WU5yL3YvL3pFWHJybmVIcW9kZDhTOG5JM1lVeVpITjRt?=
 =?utf-8?B?V0krUHZtaUdhS2E2UDQ1TTUzcmhlYW1FSDFmUndmcUlQbWp2OGdpNytmd24x?=
 =?utf-8?B?UTAvQTdWYnBLbWp0RHpVS3dhUVFwTUNQalJiTUk4U01KcFAzeW43dXp6TWNx?=
 =?utf-8?B?Ry9UZWtBV1JZM1pITkdGVkN5Ykl2cThZUEZ3aDEwdElWb25NRHhsamFHbFQ1?=
 =?utf-8?B?ZDYzYy81SkNUZ3IwRC8zZ2J0SDAyUWdLN3VHcXNzMmFsUit6bE55citWbFZr?=
 =?utf-8?B?c01ZOWVXNklYdDQ5cmhrSGdiWkxncnFWazhCdWRKZUVKQmtUcW85THllOFF5?=
 =?utf-8?B?NllEU0pwb1EvTTFuVjBvSUJYMkEyd0c4NVBoRVA3SEpHcDR3NDBDS0E5dTZ0?=
 =?utf-8?B?bWx5ZHlRRmhWelhoLzVaTzdqM3RWcjIxSjFEMktBYVQvNEhOM3JyZzJoajNk?=
 =?utf-8?B?TWNOek55Z29xYVNrMG5OUUUvV1haazhQeDZ0VGdRUVQ4Rmtyd25VcytuZ1Bp?=
 =?utf-8?B?dFU3VnhTTFEzcVFGSlJBcXpPajVDSnY0U0pOYXhjZHdheGdoNGloWUljNE1U?=
 =?utf-8?B?blVvV0lFaUFCNnZvakszblQza3ZDREswZkRQYUFhRjlGSHZKNmdHQTVhVjhU?=
 =?utf-8?B?eDdVeUZsdXB1N1AzSVBpYkZvcUk3YVlTc2MzWWJVN0d4WFNCOEZzbkJOZk5s?=
 =?utf-8?B?QURkMVlSSUJKZXl0Qnlwak00MkhCRkYwUmJHNVEyUzdLR3BpRlFyalh2Y1NU?=
 =?utf-8?B?d3hodDI1cERJNERxWjB1NW4wM2U3alVUVFVXaGE2WmpoVDZUSzdmMHVpMmRI?=
 =?utf-8?B?dTBMMHdXVUVkRkpuakpjTzBmS1VqYWIvUmkxVmhBdWhqd2pXWXh0enpORlBn?=
 =?utf-8?Q?XJLaUzIt7/M1raEQ3uqd5eYFH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2a2472-66bb-494d-9b26-08dba941a978
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:12:48.6083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgIPaH8PvAdK5UxyjrdnYAAUIeqA+1jqcJUNDJ6z9MthmRUG1hZBdnEThvYqABU8TdLFFFhPj8gMG5igv8ECow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
Received-SPF: softfail client-ip=2a01:111:f400:fe59::60c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 30/08/2023 12:53, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/30/23 11:21, Avihai Horon wrote:
>>
>> On 30/08/2023 11:37, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 8/30/23 09:01, Avihai Horon wrote:
>>>>
>>>> On 29/08/2023 21:27, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>>>>>> On 29/08/2023 17:53, Peter Xu wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>>>>> index 1d1e1321b0..e201053563 100644
>>>>>>>> --- a/migration/options.c
>>>>>>>> +++ b/migration/options.c
>>>>>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, 
>>>>>>>> bool *new_caps, Error **errp)
>>>>>>>>                error_setg(errp, "Postcopy is not yet compatible 
>>>>>>>> with multifd");
>>>>>>>>                return false;
>>>>>>>>            }
>>>>>>>> +
>>>>>>>> +        if (migration_vfio_mig_active()) {
>>>>>>>> +            error_setg(errp, "Postcopy is not compatible with 
>>>>>>>> VFIO migration");
>>>>>>>> +            return false;
>>>>>>>> +        }
>>>>>>> Hmm.. this will add yet another vfio hard-coded line into 
>>>>>>> migration/..
>>>>>>>
>>>>>>> What will happen if the vfio device is hot plugged after enabling
>>>>>>> postcopy-ram here?
>>>>>> In that case a migration blocker will be added.
>>>>>>
>>>>>>> Is it possible to do it in a generic way?
>>>>>> What comes to my mind is to let devices register a handler for a 
>>>>>> "caps
>>>>>> change" notification and allow them to object.
>>>>>> But maybe that's a bit of an overkill.
>>>>> This one also sounds better than hard-codes to me.
>>>>>
>>>>>>> I was thinking the only unified place to do such check is when 
>>>>>>> migration
>>>>>>> starts, as long as we switch to SETUP all caps are locked and 
>>>>>>> doesn't allow
>>>>>>> any change until it finishes or fails.
>>>>>>>
>>>>>>> So, can we do this check inside vfio_save_setup(), allow 
>>>>>>> vfio_save_setup()
>>>>>>> to fail the whole migration early?  For example, maybe we should 
>>>>>>> have an
>>>>>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>>>>>> reflected in query-migrate later too.
>>>>>> Yes, I think this could work and it will simplify things because 
>>>>>> we could
>>>>>> also drop the VFIO migration blockers code.
>>>>>> The downside is that the user will know migration is blocked only 
>>>>>> when he
>>>>>> tries to migrate, and migrate_caps_check() will not block setting 
>>>>>> postcopy
>>>>>> when a VFIO device is already attached.
>>>>>> I don't have a strong opinion here, so if it's fine by you and 
>>>>>> everyone
>>>>>> else, I could change that to what you suggested.
>>>>> Failing later would be fine in this case to me; my expectation is 
>>>>> VFIO
>>>>> users should be advanced already anyway (as the whole solution is 
>>>>> still
>>>>> pretty involved comparing to a generic VM migration) and shouldn't 
>>>>> try to
>>>>> trigger that at all in real life.  IOW I'd expect this check will 
>>>>> be there
>>>>> just for sanity, rather than being relied on to let people be 
>>>>> aware of it
>>>>> by the error message.
>>>>
>>>> Yes, I agree with you.
>>>>
>>>>>
>>>>> Meanwhile the blocker + caps check is slightly complicated to me 
>>>>> to guard
>>>>> both sides.  So I'd vote for failing at the QMP command. But we 
>>>>> can wait
>>>>> and see whether there's other votes.
>>>>
>>>> Sure.
>>>> So I will do the checking in vfio_save_setup(), unless someone else 
>>>> has a better idea.
>>>
>>> Just to recap for my understanding,
>>>
>>> vfio_save_setup() would test migrate_postcopy_ram() and update a new
>>> 'Error *err' parameter of the .save_setup() op which would be taken
>>> into account in qemu_savevm_state_setup(). Is that correct ?
>>>
>> Yes.
>> But I wonder if it would be simpler to call migrate_set_error() 
>> directly from vfio_save_setup() instead of adding "Error *err" 
>> argument to .save_setup() and changing all other users.
>> What do you prefer?
>
> Well, with my downstreamer hat, I would prefer a simpler solution for the
> VFIO postcopy limitation first. That said, there is value in adding
> a 'Error *' parameter to the .save_setup() op and letting the top routine
> qemu_savevm_state_setup() propagate. Other SaveVMhandler could start 
> using
> it. even VFIO has multiple error_report() in vfio_save_setup() which 
> could
> be propagated to the top callers.
>
> Let's try that first. I will check your new series on top of 8.0
>
OK, so just making sure, you want to add "Error *err" argument to 
.save_setup() first and see how it goes, right?

Thanks.

