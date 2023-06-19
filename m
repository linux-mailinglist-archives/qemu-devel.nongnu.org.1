Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE537350A0
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBBPL-0004Q3-2K; Mon, 19 Jun 2023 05:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBBPF-0004Pm-FK
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:42:44 -0400
Received: from mail-sn1nam02on2081.outbound.protection.outlook.com
 ([40.107.96.81] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBBPD-0007La-0b
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwagopPUMUwUwLmq3BkwNvAo33kaTMxsfASIhk9i71fEkjipfPZ32TZulaciMmhueZkZcYCRMGD5VITkyRLASkns93xlvWgPTYVMpNZJXmZkMiTd0ThJurgF6HaCosModIeTa4i63Spt36O/57jaMIj6o10yYJxaRajJAQ4N9LDEx3kO0CcxyVVpkhV6vbZ5tfck4FIowzx2D/x1vRsd1/GqBSltoSsiqOckejQhTNrrIPqxZJOFyqEC+K5i62vzZMp0CaJGLuSA9noF5SqMdK1cbfF2jxCMfODugD50CNx0j9hTCEa4DnMydnDLQG2ObKD8PBPMOQEPbU/EWctv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSLVmA+AVO0iPXI0A3L5QGwKeVBQNVi/Fziu6nZMWKM=;
 b=FNR/wyOyBAjETcxdzrEHaVRv42ZbgNWnOo4xj2oJEG57lSy1PMEx7nNVAbWM4HTH+3LqHXdtphaM3x7AoNcTDkVho8gAsIuUU2IKC9XW3jWlyoAcoLfHtmDVRWtld7CmwelvqSW7/ScAW/wUc3nXoy8ztpcirnZHXD44qHN8aQ1YGegCh3kha8/fPKGRiF5rJsZxUzhUNyRa2dodr2VEeFKmnLHEGEg7V6qGumq+tYwd0JrxWLyeEOFJsf4BcA5LS3hkgB+nlOY6ez+nErPDcck4kOW9fotcrE5mpd1E9ZW4ys7WA69Y/0s1bp4WtKnEK2A10m/FBaFd+5rie0rvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSLVmA+AVO0iPXI0A3L5QGwKeVBQNVi/Fziu6nZMWKM=;
 b=b5b1Lity0LBvu2wtLLGYloVfBSIsWUmdzYvsB8dsH95d+k9B5GqAfuB0+ynjyDJEi0sVoqEAGTkBTpKPjHq0/HJkgXKd9NLk1J5ZB8WItS72gCzmgvoC3s249vR8Povtm/WSn+VVXXqEYtV6YPQEjkPiFXnocmu5yQM7EyJ1qIiUftd8QG5Nr1uIdOzT53CIxEvtwZ0mXIS5sbhqPV1kpRck3eNrauGsDSgjlmeLmkIjVL/BRaIMsQMcqIEt8Ds596tVxzChLQOjO0OaZNbnWX0ZlF6vgfaCskLMMV+hA8nhLQM5+nIGTB/XR1yR7yyX6Sxq4k4wweDmfeEiJHlG8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 09:37:33 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:37:33 +0000
Message-ID: <4786a4ce-bb1b-ab19-f038-744a32924192@nvidia.com>
Date: Mon, 19 Jun 2023 12:37:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/9] migration: Add switchover ack capability
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
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
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-2-avihaih@nvidia.com>
 <CAGYh1E97X85v+90B2G1q7DUaD=zS+5Jr+BPvLuh6p6PAoYUCLg@mail.gmail.com>
 <9fb7b40c-b6bf-07aa-5605-66b9fa7353cf@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9fb7b40c-b6bf-07aa-5605-66b9fa7353cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: f45d46de-ef7e-4cae-b8be-08db70a8ceb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwCOOMpa4TsLA6Wy/8viQdx7y/WtnCybTrLCl0HXUQnw6LxLaHEhbBoHQSJIymR6qeygZPwtBe8lwloRbzmAgPq8/1qJMmbQYooIGHGA+QtlWcYwoMuMJtDII2WktMdftqEpiS7V+mue/QXdcGbnInRbPka911H7O5BCNIcZbcBP1Qcpwm183JbKesN3PyAyzDH1q6P3Kyb/IgUMwXGXx2iLeiEr47WQPzZBMAa/z0OBIiNokKFPJncqJ5np9deBAedH814cPbAdFBYcwLgBbXxLXO1gYseC20DgSaZoUIVGRnDLWQfs+pFGhevWj3z1R21W2kRHnHiyTaI2AMFSfZOHV+rM0TajxQ3VlED+YKHalaeMzMAHiVIE+Fi3JLHYoZh+lwRVng+M2Z8VLxUQc/EKCGuZw/aZ0mtiM0LLwKerGJrliuAmdzWlvNQLP+l3os8E79tuvFSvwg9g2BvXHJrQuVCFSitA0wctfRDnjoDNf6w/qwsQKkaTUeF9NwfXJiUjyAbWVH+O97H5ytqnzyb+oxMTbntdbPnWzdAcndXnW1o+JsAOkD0kPmUxNZshlV9GjS7uGJNqF0XnP618YUyrnItIvYcuhAUX9zQmxbcFpaispnByoSxH7ccigyhYFEOk0DWzuuhfJxrf2IZjHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(110136005)(186003)(478600001)(6666004)(6486002)(31696002)(86362001)(26005)(6506007)(6512007)(54906003)(53546011)(31686004)(2616005)(38100700002)(316002)(83380400001)(66946007)(66556008)(66476007)(4326008)(66574015)(8676002)(8936002)(5660300002)(7416002)(2906002)(41300700001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRjVXJsVGYwV2ozaGtEZVhjOGV2bHphTkViNlRJRUp2QzZ1S1pGVGZ2RU1H?=
 =?utf-8?B?VHMycXI3UnB6V3o4YkVieHcyTVo3ZE5NUEpBRU1YRUpUNW5hNGxYc2RTTEF0?=
 =?utf-8?B?eXYxTk1IQ3pXTmw5bWMySHN6UXZVL0pXZ0FyZHZGeThWQ2ZaZmNRN281dU0y?=
 =?utf-8?B?WTJsWklCWk1zZlNxT0l5N0RJQWI0LzdsQ2JxL2lxQ0dWL0wvdFByUUhPU0RN?=
 =?utf-8?B?V09yTHpCaUs5bFE4WDJUaWdTZWpqbEk4dGJwU3dwZk9vamkvN04yZHdhaE1N?=
 =?utf-8?B?RE1HWTlXRXYwL1ZGZ1l2ZG9CVEdyRmZMU1FvcEJIdjI2eDJFdzlFTlRQbUNQ?=
 =?utf-8?B?ZEkxYTh4bDVOendxRTM0WjRMOFZNSjZTTmZEWE1NYkxMaEFKMkRJT2ZMVmlk?=
 =?utf-8?B?dEszUXltczQ5dUlDK0k3YnNpdzZHNW5hL0FWZUdXQ1pYdWJzTjVKODMxVDhW?=
 =?utf-8?B?MTBjT2xCVnJDeVRaMUpMNC95ZnQ1YXI5TkpkSGFaVnJ2MnJEa0o4bHp3Rm8z?=
 =?utf-8?B?RUd2cUhhUWVOd0RFQVBsMUtYRURlYkVaWmo5bXd0aUNXQUIwU3RrZjhnRWZz?=
 =?utf-8?B?VlV0SXdrSHF4eGpsMW1DMitNQTFLY0J3YWJqNVVJbnBZWkZrdzk1L1huNEtj?=
 =?utf-8?B?S2hqVS9PbUtZczdReWlHaTVZWVRyYUtRa1FaUnhvanFwUTh1ajF1TW5nUHZQ?=
 =?utf-8?B?QzdubEw2a2NHTGFIRkVsMmVZbFQ4Rkcrd1NKY1RnUE0vYysxa2FUYlNQU0hl?=
 =?utf-8?B?dk9kWjVMdS9iKzBCbE42ZWpIQUVwZEs5QXlQbGdWcGxsaXFwSEdYODRBRzdD?=
 =?utf-8?B?VjZSemNmMDcxb2grcXJmNHN5eGVJSUZRSnlsbDVya1ozVlh1MkJNZU5sTnd6?=
 =?utf-8?B?VzVhalRoeFhzU1NiQjJLWk94VmdmeVBKcDRPckEvUndSOWhFTnYyeVViS1RW?=
 =?utf-8?B?U1RrTFlsRUtWNGVyMENWVDllNXI5N2hxSWl1WE91dEdrRFZTMUJtMDROT2sy?=
 =?utf-8?B?S1Z4NGI3SXB4OXV6cTV3aWx6Tnc3bklzNEVNdGo2akJ3SlQ4UXpqdndMNGVP?=
 =?utf-8?B?aWMwU2pCbVNLQmxpQkMxNjhnYk9JeTJvYUdhNDZGcXAyenArMXV6ZnIwazVP?=
 =?utf-8?B?MXRieVQweitMRjYrZENXdUpGYnFQUy9vYTg5SmZXQm5kOUt1emVzMGxXTFZz?=
 =?utf-8?B?cUJnSEZXWTlTYnZwY2U3R3F3NHBuMkVuN3c5ZE00dmY5bWM0QWEvWkY0TkZS?=
 =?utf-8?B?SkNuczR2ZE1RVkRwNFhBa283NEh2dzhZdGU2VGZEeXc4UWxCZzIrQnVNQWtN?=
 =?utf-8?B?SG0yVlJGVytSM1ErVmpjMmRvbVpMWnVjRVRaOUFPYnlqbUx2dEV0OFpaWDFO?=
 =?utf-8?B?VzB1SXYyWDRkNXR0ZTFIVU9hVGEzaTRkeDlXcXQvUU9jejNsQkV0NVVIbm1z?=
 =?utf-8?B?SkhxRzRVTXpHc2RsYmZsbDQxbkRCRFg3NkYzWVRKdkN5b3VXSzhaSWlmSXU2?=
 =?utf-8?B?SUVWd3lXRlNrb2JzR3k5VmRkMzM2NFEyTThQTUxYY2k1Nkw0U3hUWmRTNVN5?=
 =?utf-8?B?Vy8rb042RXFHLzl6STFVWkxjNWUza2VnUEY2ak8ya1RlNXJ3T3BBL3VNU3I4?=
 =?utf-8?B?WnJPa0xmQXNwaFd1cTBSVXhINFdkQ3pmeTJIN2hiWE1OMUVLRk1oTXhLa2dy?=
 =?utf-8?B?SklWQTJ0ZmN6WHJlUEhhZjYvS2VnKzRLd0ZWVXFnM3FGVzA4U2ZYems4VkE5?=
 =?utf-8?B?YnFSdFZlZG9udThBbzBpM0w0dmIrcS94RFNhTEZKYWdFaW5UUFhyamc0RnBH?=
 =?utf-8?B?Um9hOXpVSmRDclZac0hOVEgyRThXb0Y1WXFIRGlpY2R1TzdvQS8zRkp2dy9r?=
 =?utf-8?B?ZXBFRklIZjFPdFNheTF4NzhmVm5WTDB2ODFDSjc0L2NLL05OeHhOSDMxQ3Ft?=
 =?utf-8?B?R1Z4TTdpMzhnVXkxOGpLc2VLd0dQT1dlN3FvV1BWZ1hWS0xaYUJSbk1VeEhK?=
 =?utf-8?B?M2lwbWUydlBKejNzTWYxLzUyRmhJNWt2c2hPUkpHRHFDSFA1NTRKeTdOZkVa?=
 =?utf-8?B?RVJXTm1ZUi9xR0VqcnNraTRGdXRKZU85SXM3MjE4cWtXN1dwWGFERVRHZW1z?=
 =?utf-8?Q?VyZLTt1Dwe6xexW4vWeIxDsKj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d46de-ef7e-4cae-b8be-08db70a8ceb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:37:33.1204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyfP8BFvoFA750roZxxJ04njj4ySGdCR9oar785p7jeEG4L+MN0sg48f/8IGFg5A7Pb03ACwRZPPQRmF3QgvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
Received-SPF: softfail client-ip=40.107.96.81; envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 15/06/2023 16:49, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/15/23 14:38, YangHang Liu wrote:
>> Test in the following two scenarios:
>>
>> [1]  Test scenario:  Both source VM and target VM (in listening mode)
>> have enabled return-path and switchover-ack capability:
>>
>> Test result : The VFIO migration completed successfully
>>
>> [2]  Test scenario :  The source VM has enabled return-path and
>> switchover-ack capability while the target VM (in listening mode) not
>>
>> Test result : The VFIO migration fails
>>
>> The detailed error thrown by qemu-kvm when VFIO migration fails:
>>      Target VM:
>>            0000:17:00.2: Received INIT_DATA_SENT but switchover ack 
>> is not used
>>            error while loading state section id 
>> 81(0000:00:02.4:00.0/vfio)
>>            load of migration failed: Invalid argument
>>      Source VM:
>>             failed to save SaveStateEntry with id(name): 2(ram): -5
>>             Unable to write to socket: Connection reset by peer
>>             Unable to write to socket: Connection reset by peer
>>
>> Tested-by: YangHang Liu <yanghliu@redhat.com>
>
> Some more info,
>
> Tests were performed with a mainline Linux and a mainline QEMU including
> this series - patch8.
>
> The amount of precopy data for a CX-7 VF is not very large. Any idea how
> to generate some more initial state with such devices ?
>
> I suppose pre-copy will be more important with vGPUs.

In CX-7 the precopy data is not expected to be very large, because it's 
mainly used to pre-allocate resources in the destination.
However, precopy and switchover-ack are very important for CX-7, because 
they allow doing the resource pre-allocation in the destination when the 
source VM is running and reduce downtime significantly (see the example 
I gave in the cover letter).

Thanks.

>
>
>
> YangHang,
>
> Could you please reply with a Tested-by on the cover letter, so that the
> whole series is tagged and not only patch 1.
>
> Thanks,
>
> C.
>
>>
>>
>> On Wed, May 31, 2023 at 1:46 AM Avihai Horon <avihaih@nvidia.com> wrote:
>>>
>>> Migration downtime estimation is calculated based on bandwidth and
>>> remaining migration data. This assumes that loading of migration 
>>> data in
>>> the destination takes a negligible amount of time and that downtime
>>> depends only on network speed.
>>>
>>> While this may be true for RAM, it's not necessarily true for other
>>> migrated devices. For example, loading the data of a VFIO device in the
>>> destination might require from the device to allocate resources, 
>>> prepare
>>> internal data structures and so on. These operations can take a
>>> significant amount of time which can increase migration downtime.
>>>
>>> This patch adds a new capability "switchover ack" that prevents the
>>> source from stopping the VM and completing the migration until an ACK
>>> is received from the destination that it's OK to do so.
>>>
>>> This can be used by migrated devices in various ways to reduce 
>>> downtime.
>>> For example, a device can send initial precopy metadata to pre-allocate
>>> resources in the destination and use this capability to make sure that
>>> the pre-allocation is completed before the source VM is stopped, so it
>>> will have full effect.
>>>
>>> This new capability relies on the return path capability to communicate
>>> from the destination back to the source.
>>>
>>> The actual implementation of the capability will be added in the
>>> following patches.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   qapi/migration.json | 12 +++++++++++-
>>>   migration/options.h |  1 +
>>>   migration/options.c | 21 +++++++++++++++++++++
>>>   3 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 179af0c4d8..061ea512e0 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -487,6 +487,16 @@
>>>   #     and should not affect the correctness of postcopy migration.
>>>   #     (since 7.1)
>>>   #
>>> +# @switchover-ack: If enabled, migration will not stop the source VM
>>> +#     and complete the migration until an ACK is received from the
>>> +#     destination that it's OK to do so.  Exactly when this ACK is
>>> +#     sent depends on the migrated devices that use this feature.
>>> +#     For example, a device can use it to make sure some of its data
>>> +#     is sent and loaded in the destination before doing switchover.
>>> +#     This can reduce downtime if devices that support this capability
>>> +#     are present.  'return-path' capability must be enabled to use
>>> +#     it.  (since 8.1)
>>> +#
>>>   # Features:
>>>   #
>>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>>> @@ -502,7 +512,7 @@
>>>              'dirty-bitmaps', 'postcopy-blocktime', 
>>> 'late-block-activate',
>>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>>              'validate-uuid', 'background-snapshot',
>>> -           'zero-copy-send', 'postcopy-preempt'] }
>>> +           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
>>>
>>>   ##
>>>   # @MigrationCapabilityStatus:
>>> diff --git a/migration/options.h b/migration/options.h
>>> index 45991af3c2..9aaf363322 100644
>>> --- a/migration/options.h
>>> +++ b/migration/options.h
>>> @@ -40,6 +40,7 @@ bool migrate_postcopy_ram(void);
>>>   bool migrate_rdma_pin_all(void);
>>>   bool migrate_release_ram(void);
>>>   bool migrate_return_path(void);
>>> +bool migrate_switchover_ack(void);
>>>   bool migrate_validate_uuid(void);
>>>   bool migrate_xbzrle(void);
>>>   bool migrate_zero_blocks(void);
>>> diff --git a/migration/options.c b/migration/options.c
>>> index b62ab30cd5..16007afca6 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -185,6 +185,8 @@ Property migration_properties[] = {
>>>       DEFINE_PROP_MIG_CAP("x-zero-copy-send",
>>>               MIGRATION_CAPABILITY_ZERO_COPY_SEND),
>>>   #endif
>>> +    DEFINE_PROP_MIG_CAP("x-switchover-ack",
>>> +                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>>>
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>> @@ -308,6 +310,13 @@ bool migrate_return_path(void)
>>>       return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
>>>   }
>>>
>>> +bool migrate_switchover_ack(void)
>>> +{
>>> +    MigrationState *s = migrate_get_current();
>>> +
>>> +    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
>>> +}
>>> +
>>>   bool migrate_validate_uuid(void)
>>>   {
>>>       MigrationState *s = migrate_get_current();
>>> @@ -547,6 +556,18 @@ bool migrate_caps_check(bool *old_caps, bool 
>>> *new_caps, Error **errp)
>>>           }
>>>       }
>>>
>>> +    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK]) {
>>> +        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
>>> +            error_setg(errp, "Capability 'switchover-ack' requires 
>>> capability "
>>> +                             "'return-path'");
>>> +            return false;
>>> +        }
>>> +
>>> +        /* Disable this capability until it's implemented */
>>> +        error_setg(errp, "'switchover-ack' is not implemented yet");
>>> +        return false;
>>> +    }
>>> +
>>>       return true;
>>>   }
>>>
>>> -- 
>>> 2.26.3
>>>
>>>
>>
>

