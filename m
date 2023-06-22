Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD673A2EC
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLAY-0000kh-ME; Thu, 22 Jun 2023 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qCLAW-0000iI-6s
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:20:16 -0400
Received: from mail-co1nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::623]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qCLAU-0004Tl-14
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:20:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+ES15F3IH/UPxron1nGF9KWjsAkdg8KDsCeYeUtM8AaIDWBNmXonPDPf+pJpYK55ip+CKEnXS6B+XNiP5wruVCgE3I65KTf/cs+4yJREwnUnG5VkMwPouuh9zqpRbnx+kDAlgRCGqVKy3SQOfUtHxtunOHhlQBEWi3WvzKirgABhQcQvgjYq/Y4BmXRGXoW+JdYB1qnB6kmJyBWQjxvnWgSGJTHYuFzmiwAinoo0DrufLJFkJi0zb90052E2cQSS8/3Uc4vXfiaJLOxt1H0bREL3XfG5JJHrskJNGg7n6R08xDrUSFuxUDyHc1dmq/iYFgNZ0G5tiqBxEMxcmaL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=825lyiAYM1MDctFM6mlyjyXelZ0FZR+RieztxN0Vuxg=;
 b=eJgGl6ybFmZ3peK5wU3Xrb/NVjocO5Zi3n+/oyvQaedp+03mJHMg+wB+Nybe3k6Hml7PyiCyr/Uhrf+OkgfAImihKWOnMa9T+l/ZmKUowsKh+3Ray2dByF2vZGgi97rqDoq+SZ89X5GJFYqqmvkstUJXr0g8lBMcijyYVAqWvDheo5wkBKN1bJgZXf75oTGWLiBEuXM7tfPNJsf3i7/4Uv4UCfrrk6E+rpWQp5t7Jui9czBVP4B0/zXRm1SBDNooJGdl4uO8LowHb0RjdUbUHNXRjISYBsygvlEMZZxHdsDwpQRMO8e8/txWmRiYrj+mZkJeRHwt86mFr33xcLhUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=825lyiAYM1MDctFM6mlyjyXelZ0FZR+RieztxN0Vuxg=;
 b=LAHsn8ltBA64At2dVe8lJkf/eTgTcR/DqRq88jE0Yiwy9Pteh/dzHEG6/NJcCdRv9+qnrU8KWhCOK3wVKSJ4CB5rnUUw3XWGNkH2oU/HVPHHiDTzdYqaqVVxHSm7No4DefBXcMMq3te3jSbAa24cyapazOcKGMGkjaszD96ZQ24I5wHzxNvOX2Ja/VHoIbcKMOC+p9pRRl93G//Z3DoSLml/NYm8YQ5mQSmRNKbBJuNa+J5Otxl/SiWwSmDEFKY/O/xdU2kbgZoDCbSfKTPlxeD7Q6olVVNM7Qg7MyITk4APNhngaNo+rrtUaNnMCxxQV+rMyr/cp/M9dmQSeIgNdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 14:20:07 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:20:07 +0000
Message-ID: <32090ab4-b426-3601-1830-0cbef99fcbb6@nvidia.com>
Date: Thu, 22 Jun 2023 17:19:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/8] migration: Add switchover ack capability and VFIO
 precopy support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
 <20230621132848.79c9b674.alex.williamson@redhat.com>
 <5f1c5fa6-20a4-a29e-3381-728ea0aa1797@redhat.com>
 <4faf12dc-206d-b104-d94d-0bec2169b2e0@nvidia.com>
 <6f627049-f0ce-bdbc-3dac-f9723efdfd1a@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <6f627049-f0ce-bdbc-3dac-f9723efdfd1a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bee529-b841-4b0c-b2ad-08db732bc754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtQCMLi5/tu6d2qBtYbbUymUDb4LfH4vGj2guaN0fahGBXKN5+zYalGCuriyq33lcgWcMtTV9L6mVEfcPMEvg+tJgu+TSPT3Gjiuw7K2JW+NPM3i2CFN6jfH7ZEdLMRFAqPdW6IJpzX4lgkY27du6HacrbAqFmhzrQO9Wmsgw111LK+sxzrzGatmyNWg/39sQ/ad5BcGCBDUpcFBMfA86CwfBLsQ4/7uCgi2HjRqIlEaQmXCubIr/FTf/61yWGH0JIIqzF4FYeAl2UVZre+L9pJxhjIZqhdt8vACWPx9VQBn15sbeo0jjtQfnoLJoD19axYZYMIdU3UMdiC4S/W2p6xrLWxBogrYOOv5XEHbLYQ8YWCEm3HFtkyOWh0nz1GaVg973flhklisUZn/IEXxnUHlRFFlUyxPO4uRE2MAoFopM9rqaBMAURe1YW5feEtd/5dk85dOhCttGRA+yvw1pWC67eVUBoxyuqjFRzGqLEUSmEzVHbvItP+0VOK8hb0+OlwOtCRiFnfbkSOH/Jz1dHfQwVzYSWvQvy6GsvhnH1/OqLBdqgU6LIcKnEC/2N7r5uuMXgwBYvrHSTneOqQ4fep+RDGNaCb5iXeZs8MyFqydvmbLdY0iGLLCFJVjxbir4VdDmDfJKcrT6ZPF7p2/sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(83380400001)(66574015)(316002)(2906002)(186003)(6512007)(66476007)(66556008)(66946007)(110136005)(4326008)(54906003)(6666004)(5660300002)(26005)(478600001)(6506007)(53546011)(8936002)(6486002)(41300700001)(8676002)(7416002)(2616005)(38100700002)(36756003)(86362001)(31686004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckc1UVRJV0d1bi9ONXFUcDU4eUcwNG9ZZ3hmVVlwcFMyNDgzVm5UWXpuU1ly?=
 =?utf-8?B?citSUlpwL2ZiLzVZUm90bnVIUHlZS2VFMGR2Y1NSalpaTXRFWnlROXA4Tk43?=
 =?utf-8?B?NXhURmpKTWU2a2VrRElMaDhkMFVicEZmYlBYYU1OWnB1b0poc2VtQ255Q3pI?=
 =?utf-8?B?OXlGRFVneGcwV3laUzd4dVV1QzhPK1VpTTdYSjV0UUgwU0w4YzM5SWFwUk1X?=
 =?utf-8?B?U2FNRDlRTmx5dzVFS2hGdGJrMkdaUkVxcGlTOXl0WGhRSTRWWDltb3FjMVZD?=
 =?utf-8?B?d2FxVWFycitFaTRXWVdMQlQyempoSkFLMDJ6NmV5Q095dHBoa0J0WWszM0V0?=
 =?utf-8?B?ZkRyYTNWb3FEK1Vjekd5MGtGdHFFK09ORWJVcXRZQWRmek81bE8wT1dZWDVG?=
 =?utf-8?B?dktObTZOY3JwaGRsZjJlR2gzQmd4RnNiMlVhSXRLMEpsVU5iaXkvYWE4TnRQ?=
 =?utf-8?B?bFVtNlB1dERHblZvbVU5eWZyQ1hQRCt2TEpld1d5bWdRTU1DVFhUVUc0VW0y?=
 =?utf-8?B?eUxoNC9KRldYdmd0cng1US9qMm10NmNwSXBEOHRsWXh0VWlJVjVqbldtTW5T?=
 =?utf-8?B?SW5TQjlCSTAxakM3Y2Q2WDBiTU13SXhtUWpyVUIrenRzM29KVUNtcDlEd2RJ?=
 =?utf-8?B?NnZBYThxRFlGcVJqVnd6OHMvekdMeFF1NUtrcEZHcmhBOVNvME9iRTljamhK?=
 =?utf-8?B?MlBpcVBIcitLVHl6S3NmSk95WDJjR2N4WER0RVNrSXdRZWpxbjdkQ05OUEc3?=
 =?utf-8?B?Nk5Zc1E5aWwvZFVuUEhzdGNLdm1BT2ZqdWQyR2ZyU1ZxcndJTFR2cXFMS0Js?=
 =?utf-8?B?SHRkSm1Na1JzYVc4V2czcXdvUEZuMWN5SW9kOE5NSnhlZWtHenIySWtqTkFO?=
 =?utf-8?B?V1RXbmRCOU9meTJxT1pyVEx3RmVITGRpN3Z5V2s3TnJCRTJXWlJqVnE1NTd1?=
 =?utf-8?B?ZHRFQmZQaTErZnltODZxNDZYb3Y4Qlk2Rk53TWdmc1B6U1lYSC9CYWZJUnBi?=
 =?utf-8?B?Y3cvc0NMb2NDNGxXaTlGbVBpVkRqaEdvUWl3dHdrTkwwWXkwekl3MW1jeWNN?=
 =?utf-8?B?Z3pQc3YrNmZhc3dBWGkxUkxxRE9kdy9JYUROTWZCQzZvOEZXMExpTzU1WGZr?=
 =?utf-8?B?Q2xRWVFocDBPVEtMUGc3RmwwRjVTUm5VSUFPZ3M1a1NpbHhYcHVhYzBmZHRt?=
 =?utf-8?B?UWtpaDVndVF2RmZNeE5pRlVnYk9rM2o4Q3RhSHQxWXFOcVk3ZDJvc2p4SjJI?=
 =?utf-8?B?dTN3OE1wSXVVTmpjekE3TWVsajllVW9nUU1wQmVnMFB1SUZXeHhiNVpYQnBR?=
 =?utf-8?B?T0MxOGhjWmtCSk5OV2JianNaN2N4Y3FLMW83S2YrZVVINmtoVldpRUFjb0xz?=
 =?utf-8?B?QVFPQ2xqaVlodTdLdzZ5ajlaUE1GYjJRbDdkdWhMQkR3SEtYcTVYcmI1MHFR?=
 =?utf-8?B?d3ZRWHRsOXQxM3UrQ3FqZTltZWo0dTVmaEg3SVlHS280WTZOcUJnTkJqZklG?=
 =?utf-8?B?elllVGlmeWx3d3d0U2IyZ3hoak9Nd3ZKbG11b1REaE9vaW1PQ3hGS1dseTAy?=
 =?utf-8?B?bWFKTit4NG1CUmtCeDg4eG4veFh6U3ZZT3ZGbFYrNkIwQmlSWHR5VGpsTGtY?=
 =?utf-8?B?RVdqT0N0enNIWDBQZE9FNlRYUEtXSlVsbUJrdnlqSEFyVEdGVFpiZXNGUEY2?=
 =?utf-8?B?Mkp5Y0Q3N1hpNUVCT2w2cDN1MFhNSWNIYTZaWHRCdjBXOE50Z2tFcVNhcVZj?=
 =?utf-8?B?QmQ0VkVVZDAzS3prTGs5dzNOL0lzUytvRU1md3FJYmhmUVlBM3JVZWZRZW9l?=
 =?utf-8?B?ckJGYnFXa0tYY0xWMzB1ZXk4MGd5ZWVJbHV1T1QwWEtpZ0ZnN3FPM3R3b3FG?=
 =?utf-8?B?WGg4aCtWMnFHTXFzWkZ4ci9DaTAxbGxEaXdYUmtGRE9vOHFEaU00VVlVVjVm?=
 =?utf-8?B?QThaQ3RBY3haV3hYL0x5MnVrZFI4TlBKalVvMkhHSE5HZE5WdnQxc3BqM1Bp?=
 =?utf-8?B?azBadWtNMlZ5Wm0vbTdTNDZOSFpnWEI5TFdBdEJwU0FzdUpEY1kzR25oM1l0?=
 =?utf-8?B?MkRWMzY3SER6TXJKT2lNWGxlbnBjZ3dnL3hUdWxoTzF1akRFS0NiY1MyanVx?=
 =?utf-8?Q?9geDF3356hMO8gVFq+8KjeIXF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bee529-b841-4b0c-b2ad-08db732bc754
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:20:07.0771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNWo5IZNvb7hFurAhrLPs4iTBOhhpYlULjNwBRPvKQRF80rO4yGJpjJDvmkEXEKhgtBW9LF6RhN7K+OmWTG35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
Received-SPF: softfail client-ip=2a01:111:f400:7eab::623;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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


On 22/06/2023 17:02, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/22/23 14:16, Avihai Horon wrote:
>>
>> On 22/06/2023 14:34, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 6/21/23 21:28, Alex Williamson wrote:
>>>> On Wed, 21 Jun 2023 14:11:53 +0300
>>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>>
>>>>> Hello everyone,
>>>>>
>>>>> The latest changes to migration qtest made the tests run non-live by
>>>>> default. I am posting this v6 to change back the switchover-ack
>>>>> migration test to run live as it used to (because the source VM 
>>>>> needs to
>>>>> be running to consider the switchover ACK when deciding to do the
>>>>> switchover or not).
>>>>>
>>>>> Changes from v5 [7]:
>>>>> * Rebased on latest master branch.
>>>>> * Made switchover-ack migration test run live again (I kept the 
>>>>> R-bs as
>>>>>    this was the original behavior when they were given).
>>>>> * Dropped patch #8 (x-allow-pre-copy property). (Alex)
>>>>> * Adjusted patch #9 commit message according to drop of patch #8.
>>>>> * Added R-b to patch #9 and Tested-by tags to the series.
>>>>
>>>> I think Cédric is going to handle the pull request for this, so...
>>>
>>> Yes. I have a branch ready with this series and a few other fixes. 
>>> Unless
>>> Juan want to handle it.
>>>
>>>
>>> Avihai,
>>>
>>> QEMU seems ready to allow migration when support is available in the
>>> kernel now and so, we can set "x-enable-migration" to true by default.
>>> Are you OK with that ?
>>>
>> Yes, sure.
>> But as per previous off-list discussions, it's not merely changing 
>> x-enable-migration to true by default, right?
>> If I recall correctly, Alex wanted to remove the x- prefix,
>
> OK. We have to start one day :)
>
>> change it to ON_OFF_AUTO and some other stuff.
>
> Is it to silently disable migration support if some failure occurs
> at the kernel level when ON_OFF_AUTO_AUTO is set and report an error
> when ON_OFF_AUTO_ON is set ?

Yes, or other errors.
And also to require device dirty tracking with AUTO.

>
>
>> Do you have some patches ready for that?
>
> nope.
>
>> Or you want me to do it?
>
> If you have time, yes please.

Sure, so I will prepare the patches and send them.

Thanks.


