Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88D7225F2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69OW-00044I-Gu; Mon, 05 Jun 2023 08:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q69OU-000448-QB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:33:07 -0400
Received: from mail-dm3nam02on2045.outbound.protection.outlook.com
 ([40.107.95.45] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q69OR-00033F-W5
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:33:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFt0mXkcyaG3S2nIEAScqsoENsrtcGrcP49qDJRYw5gupVIuaArk++M2ZubZW3Dusde/lB8GaT4rZgxD7BXKDvX4XtglqQyJGWkbCaG7NiCk0ch8Z5A873fvQlodW1uYd0L4MSDmdXp+XkwriFLaS92v1Sxc589++uXyALEgPHEn8Oc1xR6soLUzeG/Tp26zOPEXsNS6wLWKj1tVhrSxMbYILuwIKBACadZDZlrUgCC24Wq+HHfJCSmpFMQRbmEYm1r8NAOSLoMA9v573CjelSlm3Cg1D8q3Znzpq+B9pZMnoPR5ldCuEs59SubzYPmythMLG+sdHhlzxGLQXt4nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26PhaDgT8TChpUHGNL5caV/v1pqGDfEM3eB5BKmGPpg=;
 b=WhGXYQyGAzyRSfNYZmbYyJ7LM2/cjkVKwdCuIO6uFKUq4qWoSOUwFfM8//vfQyYcUyGuOhaWnya6BqHne0XYdDKGmjTzZVjzTXwhSs5dWOU4CuNzt3Of5FQYQZqG9dA3IkK5dwFtytBT4Ux2T1O3Cg989CUrSREOjhYxtspUJ5PTcMGAelKOI1Q/pNO88Z2iRxk6mgId74/9M8xso4BoXaesnIkPOP11H+dBA6IuOCePKaBTCwxXGIb5O5COPBFynPclRkNbcra4mo7LzDDcfK+hyI+J4wUi56CSVFvxL014kok5WXzyiTkWBuD5mbu/nhWjjUzgoeIO6lln+Kt5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26PhaDgT8TChpUHGNL5caV/v1pqGDfEM3eB5BKmGPpg=;
 b=oU9+c6oB3JiEBT/0YTSEjv5phbKOQ/uw6KKQeTvTUaA4m6Tk8I1ibpEFSvJcFWWQhtOLEDoL/ryveQ/CUr5Z1PFkn6BGeU0eXKn9IbDtu1oh42tuTJt4ogPvQEoVW/PSzAOGnTqzPd3OlOa47SiZESn8a0yP3eAJf+JoN714s32t8VGecAxoZc7wUBqzgYHSXDoT1965xX5YsXdDz5k+baK44asQZQatIzmoPKDNvMHWz9p9vV2q6Y1Ot3exXIAHCCOxZlTbJKpJFrpf5eg3oZHHeuVS+u1Saev1erTkZcRgXjT3esr6aoR4QLwdE3DXgEvs4RX7+NhFXRc9/CNcbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Mon, 5 Jun
 2023 12:27:58 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 12:27:58 +0000
Message-ID: <0c459f0c-1a04-f460-2b51-e8c3f997370d@nvidia.com>
Date: Mon, 5 Jun 2023 15:27:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] migration: switchover-hold parameter
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
References: <20230602144715.249002-1-peterx@redhat.com>
 <20230602144715.249002-2-peterx@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230602144715.249002-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d65aa89-4aa5-4a7b-30e3-08db65c04b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bwU1bIdvMzWgGR0LRGc7u//r2IuJCXbtwZGmeQqVSUISqnMvDeSOZRle+t8kA5SRXH7kkwjJIfB+Qx0WQeiQZbWcpiNCmV82CPZinF5yKrMIR9Y9LUrOEaxt8LOk++Jis6KwDc0x+GUHgB335wAqvrs1EkF0nX0Jn3yXc6Pn91kqB4CORRcmkIt5DrvtLoHp5jXgkr5AvrCuq//ZXPaSdo7IVjc4XG9Z+cg9yXP8/lXh+e5nVbD5OD0yUc8W90re6gDhDmtgAhijMn+lxy7L92ZybuiUmBqA+/dWe0nfwJP1bnxn/GUgu8zawNG64OGsP6mcyvkH/O9wCe/z/L+FEDKiQdLjb2MjlEOCC6hjp4ke+xm7OMoAgSVqn55Y79MmiYRQ8RiEQbTXuwl4yEIAVCbTO9FbdZHvOCjedC8OXITLkJfa1ggFO3c6/i4pbCasTcIbh0CfYbz+AHICbcMy7AnJFMp5klTy2p01nLRoAC+Tb9YaafeOMjoMY+/BCVKWEzEu9ZZinRmlLWW0qp4oMqRDfC69ilrjUiSgRIVXY3yUGoFXGkXMd7qoWOi5mUtvG33QCG6Uw3ok/3OK/DGLTG3nLYizXEn4Dr2goseyuBd3wYB2YM4EViwO0/13U4P1Go4UOLM9S8ChWHO/d8sgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(316002)(5660300002)(41300700001)(66899021)(4326008)(66946007)(66476007)(66556008)(2906002)(8676002)(31686004)(30864003)(8936002)(478600001)(54906003)(31696002)(6666004)(36756003)(6486002)(6512007)(2616005)(86362001)(83380400001)(6506007)(38100700002)(53546011)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJPUWtIbWJQbXJ5ZFNJcERKKzNLckpIZUJqV3k3ejZ2RHVRRUMrY2phcHhi?=
 =?utf-8?B?KzdRVzNIb3hIK0hvRVMzeXJ3cnR5UnZNb24zaGt5dExmT1E1Wk1wSmFqbXUw?=
 =?utf-8?B?UndGdHN0d2g0Szdyb2k2Mzh5VEZjMkNCb3hSdmlFV3JKamdIR2dtdVVoTjVy?=
 =?utf-8?B?RkQ5Uzg2VTdSdlJoM3B3bEI3U2ZxclVmZUk2VkJyd3ZPVWcrczF6L040SVR6?=
 =?utf-8?B?VVNMSk1FaU5zZmZMTXhUL3NHYjVuUERnWlNRZHNBZVVJN3ZUYll0QmJqUVFu?=
 =?utf-8?B?ZklZZ2w4UnRONkQrNThkMFUzVlEyMEttV3ZIOWNvWjAwdFY2S3RqdnRvbkhQ?=
 =?utf-8?B?UE1ERHAzSVNuNUc2VVZqdkRPSTRsNTBEWHd4ZGsxcVdKc3hubjhOenJhM09w?=
 =?utf-8?B?SUI1MXdXd1VrS2RsSU01Ym1xMTVnQ1hSY01KOG41UXZjZDZLZUF0dVpUSXlU?=
 =?utf-8?B?d3FQQzNPQ1crV0U4eUYvOTVYTDlJbnB1VlhScjNSdnhXTm1oOWNpczZxZlpi?=
 =?utf-8?B?ZDErWFoxNVh5QlVDOWcrUXVKVGlINFNSWURTRWtUbTcwVXlpRDE3VTVRT1VG?=
 =?utf-8?B?MnNlaXlyaWdmTVBsNUU1dWtoQ09MdkRyRFVXbjZST0VRVFJIbFNXTEhXSHVw?=
 =?utf-8?B?N0pXY1pSdllKTER4MU9KSWxpOXlxbHJCaXRRMFF6elZWa1ZoVFZQNDdWRUx2?=
 =?utf-8?B?U09uM2cyVlEvb0dWbjkxRmZTbkpLYnJJc3BhaDk5MDVpT21pa25DK0xZQ2ZQ?=
 =?utf-8?B?MmxPZEpYUHRYMVIxTmJzcnc4Q1VFRjZ2TkFpZzA0VWVlWmlEb1lIemk3bzFE?=
 =?utf-8?B?dDdZd2RQRzFveEN2aWZtTW42WVh4Q2t2RHJ5WmFxWWtROTBaYnZWRmNlZ0Rt?=
 =?utf-8?B?SklZdmRrcVZlcnFJVlUxbEk2SGJlanhqeE9tQjRVNS9vMTFNNzFiWXlSb2pR?=
 =?utf-8?B?Y3FJSklRYm00L1crOE4rTk5FUnREd3hVNVhuVmhEUVdRWWR2d05yRG1kb3Vm?=
 =?utf-8?B?aGREaFc3ckdYckwvWk1zdDhGQ2ZCRTZtZlVkdENHT1VkMzVobkhFTGNHQVF2?=
 =?utf-8?B?ekprTVp2UVBGQ0Z4a1hHbi91UURmR2dzb3dOWElrc3U2akExcGg1YXkzWndo?=
 =?utf-8?B?S2Y0bUNBODk1Umd1U0JIZXZyb3V4UVBlajU3MVYrQjJVeXQwclVyMWFtSG1R?=
 =?utf-8?B?KzNpaFNzRXVMdnlIcUdha0Y5SXFwaFkvVThmaFVPd1J3bTR3aEw3OG92YkxZ?=
 =?utf-8?B?ak45UkV0dVF4SFdMQ1NLcVdLOGE5M1JZeVlXbjVaNk43YUZ0U0JvcGdIbmZD?=
 =?utf-8?B?Wm1laXE2d2MyeW9SRDl1NEpWWVFweWlUbjZSTldyb0RJL3k5T0JkejZOYk5T?=
 =?utf-8?B?RCtGZlBuMjREeUZOb1laMVNlZmxXOG5SUzVKbGZsUXlFL2ZXc1FHSWFYdzFW?=
 =?utf-8?B?YmMzTmp5VVkwb3lBVjJWQmhCdHJNWUl6Z1J4ZGEvVkxDUUFGaG1kY2lpQ1ox?=
 =?utf-8?B?UzdDNEw4dG02OG52ZytzOWw3T293UXVkUDliUk1DWTNxSEMzTkdzUGY5TFl6?=
 =?utf-8?B?cEZDZzJlT1FFNmVRSEFOcmp6NFlWZWljMmVyMXQ5UmsvMmY4OU1uUlc1aFRX?=
 =?utf-8?B?WmFVS1ArOE55UFpmWG9QS1RFTzN6OXdzblRpSnNSTnpsTS9YT0o1RmU0UTFY?=
 =?utf-8?B?UUlPR21jdll4Mlh6RmV3Wm8weTlCaHErOS91Z1hVL1lMRUVCRk43bVFScys1?=
 =?utf-8?B?T2lDQzVtUDRKVlVjNmx2NHFKZjJDc21nRnBzMmtrRmU4MUJSSHVlOXZITDJZ?=
 =?utf-8?B?U1NBL3FvZGlWdVNvTlUxcS9OQ3hUalRPL3FYd0F6ODZDQXRjVXo5TTBDamZP?=
 =?utf-8?B?QnFzY0VlWEU4dzBHWjlYdWR1TUp2aDNYMHZrMHhTazFoRzdXckhoZ3l0bzA3?=
 =?utf-8?B?Rm9ONmVLMnBuQ2RlaFcxaUpOUVI2RGpveExYNnZ0bEJQN21SNDUyZHZ6TmtW?=
 =?utf-8?B?dFJsWk1BeUhXdG1UMDZ1cDRZTHhXdmJoWG4vUUk0ZWNxaXhJV2VUMGJDa1F6?=
 =?utf-8?B?Y29TdGYzeSt4dUxYam1RR1JDcjVQTS9KSm9oWWYxaS9ac1JZNzcrejJscmdI?=
 =?utf-8?Q?d0XI80jfxjqSz6l1l5NHN/KWm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d65aa89-4aa5-4a7b-30e3-08db65c04b9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 12:27:58.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT63vTuLorjBCKSOZGMp1FgoUNXxGaZOlGS8sy1WqG13xrrPCj4c6ogB1p8S5MBBUu52pckqWK9R/fdV4lRijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
Received-SPF: softfail client-ip=40.107.95.45; envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

Hi Peter,

On 02/06/2023 17:47, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Add a new migration parameter switchover-hold which can block src qemu
> migration from switching over to dest from running.
>
> One can set this flag to true so src qemu will keep iterating the VM data,
> not switching over to dest even if it can.
>
> It means now live migration works somehow like COLO; we keep syncing data
> from src to dst without stopping.
>
> When the user is ready for the switchover, one can set the parameter from
> true->false.  That'll contain a implicit kick to migration thread to be
> alive and re-evaluate the switchover decision.
>
> This can be used in two cases so far in my mind:
>
>    (1) One can use this parameter to start pre-heating migration (but not
>        really migrating, so a migrate-cancel will cancel the preheat).  When
>        the user wants to really migrate, just clear the flag.  It'll in most
>        cases migrate immediately because most pages are already synced.
>
>    (2) Can also be used as a clean way to do qtest, in many of the precopy
>        tests we have requirement to run after 1 iteration without completing
>        the precopy migration.  Before that we have either set bandwidth to
>        ridiculous low value, or tricks on detecting guest memory change over
>        some adhoc guest memory position.  Now we can simply set this flag
>        then we know precopy won't complete and will just keep going.
>
> Here we leveraged a sem to make sure migration thread won't busy spin on a
> physical cpu, meanwhile provide a timedwait() of 10ms so it can still try
> its best to sync with dest QEMU from time to time.  Note that the sem is
> prone to outdated counts but it's benign, please refer to the comment above
> the semaphore definition for more information.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qapi/migration.json            | 25 +++++++++++++--
>   migration/migration.h          | 16 ++++++++++
>   migration/migration-hmp-cmds.c |  3 ++
>   migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
>   migration/options.c            | 17 +++++++++++
>   5 files changed, 111 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 179af0c4d8..1d0059d125 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -779,6 +779,15 @@
>   #     Nodes are mapped to their block device name if there is one, and
>   #     to their node name otherwise.  (Since 5.2)
>   #
> +# @switchover-hold: Whether we should hold-off precopy switchover from src
> +#     to dest QEMU, even if we can finish migration in the downtime
> +#     specified.  By default off, so precopy migration will complete as
> +#     soon as possible.  One can set it to explicitly keep iterating during
> +#     precopy migration until set the flag to false again to kick off the
> +#     final switchover.  Note, this does not affect postcopy switchover,
> +#     because the user can control that using "migrate-start-postcopy"
> +#     command explicitly. (Since 8.1)
> +#

I think this should wrap at col 70, and need double space before (Since 
8.1).
Also in other places below.

>   # Features:
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -800,7 +809,7 @@
>              'xbzrle-cache-size', 'max-postcopy-bandwidth',
>              'max-cpu-throttle', 'multifd-compression',
>              'multifd-zlib-level' ,'multifd-zstd-level',
> -           'block-bitmap-mapping' ] }
> +           'block-bitmap-mapping', 'switchover-hold' ] }
>
>   ##
>   # @MigrateSetParameters:
> @@ -935,6 +944,10 @@
>   #     Nodes are mapped to their block device name if there is one, and
>   #     to their node name otherwise.  (Since 5.2)
>   #
> +# @switchover-hold: Whether we should hold-off precopy switchover from src
> +#     to dest QEMU.  For more details, please refer to MigrationParameter
> +#     entry of the same field. (Since 8.1)
> +#
>   # Features:
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -972,7 +985,8 @@
>               '*multifd-compression': 'MultiFDCompression',
>               '*multifd-zlib-level': 'uint8',
>               '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>
>   ##
>   # @migrate-set-parameters:
> @@ -1127,6 +1141,10 @@
>   #     Nodes are mapped to their block device name if there is one, and
>   #     to their node name otherwise.  (Since 5.2)
>   #
> +# @switchover-hold: Whether we should hold-off precopy switchover from src
> +#     to dest QEMU.  For more details, please refer to MigrationParameter
> +#     entry of the same field. (Since 8.1)
> +#
>   # Features:
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -1161,7 +1179,8 @@
>               '*multifd-compression': 'MultiFDCompression',
>               '*multifd-zlib-level': 'uint8',
>               '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>
>   ##
>   # @query-migrate-parameters:
> diff --git a/migration/migration.h b/migration/migration.h
> index 30c3e97635..721b1c9473 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -440,6 +440,22 @@ struct MigrationState {
>
>       /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>       JSONWriter *vmdesc;
> +    /*
> +     * Only migration thread will wait on it when switchover_hold==true.
> +     *
> +     * Only qmp set param will kick it when switching switchover_hold from
> +     * true->false.
> +     *
> +     * NOTE: outdated sem count here is benign.  E.g., when this is posted,
> +     * the 1st migration got cancelled, then start the 2nd migration, or
> +     * when someone sets the flag from true->false->true->false.. because
> +     * any outdated sem count will only let the migration thread to run one
> +     * more loop (timedwait() will eat the outdated count) when reaching
> +     * the completion phase, then in the next loop it'll sleep again.  The
> +     * important thing here OTOH is when the migration thread is sleeping
> +     * we can always kick it out of the sleep, which we will always do.
> +     */
> +    QemuSemaphore switchover_hold_sem;
>   };
>
>   void migrate_set_state(int *state, int old_state, int new_state);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 9885d7c9f7..63a2c8a4a3 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>           monitor_printf(mon, "%s: '%s'\n",
>               MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>               params->tls_authz);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
> +            params->switchover_hold ? "on" : "off");
>
>           if (params->has_block_bitmap_mapping) {
>               const BitmapMigrationNodeAliasList *bmnal;
> diff --git a/migration/migration.c b/migration/migration.c
> index dc05c6f6ea..076c9f1372 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2693,6 +2693,55 @@ static void migration_update_counters(MigrationState *s,
>                                 bandwidth, s->threshold_size);
>   }
>
> +static bool
> +migration_should_complete(MigrationState *s, uint64_t pending_size)
> +{
> +    /* We still have large pending data to send? */
> +    if (pending_size && (pending_size >= s->threshold_size)) {

The parenthesis here are redundant.

> +        return false;
> +    }
> +
> +    /* The user doesn't want us to switchover yet */
> +    if (s->parameters.switchover_hold) {

Should we check this only if we are in precopy? I.e., skip this check if 
postcopy is active?

I thought that this parameter is all about precopy switchover, and the 
fact that it prevents stopcopy from reaching migration_completion() is 
just an undesired side effect.
As I see it, if this parameter is set then precopy switchover is hold 
off, and if on top of that a user starts postcopy then this parameter is 
not relevant anymore - we should start postcopy and ignore it for the 
rest of migration.

Does it make sense?

Thanks.

> +        /*
> +         * Note: when reaching here it probably means we've migrated almost
> +         * everything and ready to switchover.  If user asked not to switch
> +         * wait for a short period and respond to kicks immediately.
> +         *
> +         * If we wait too long, there can be a lot of dirty data generated,
> +         * while we could have done something to sync data between src/dst.
> +         *
> +         * If we wait too short, migration thread can eat most/all cpu
> +         * resource looping over switchover_hold.
> +         *
> +         * Make it 10ms which seems to be a good intermediate value.
> +         */
> +        qemu_sem_timedwait(&s->switchover_hold_sem, 10);
> +
> +        /*
> +         * Return false here always even if user changed it, because we'd
> +         * like to re-evaluate everything (e.g. pending_size).
> +         */
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool
> +migration_should_start_postcopy(MigrationState *s, uint64_t must_precopy)
> +{
> +    /* If we're already in postcopy phase, don't bother */
> +    if (migration_in_postcopy()) {
> +        return false;
> +    }
> +    /* We still have lots of thing that must be migrated in precopy */
> +    if (must_precopy > s->threshold_size) {
> +        return false;
> +    }
> +    return qatomic_read(&s->start_postcopy);
> +}
> +
>   /* Migration thread iteration status */
>   typedef enum {
>       MIG_ITERATE_RESUME,         /* Resume current iteration */
> @@ -2720,15 +2769,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>       }
>
> -    if (!pending_size || pending_size < s->threshold_size) {
> +    if (migration_should_complete(s, pending_size)) {
>           trace_migration_thread_low_pending(pending_size);
>           migration_completion(s);
>           return MIG_ITERATE_BREAK;
>       }
>
>       /* Still a significant amount to transfer */
> -    if (!in_postcopy && must_precopy <= s->threshold_size &&
> -        qatomic_read(&s->start_postcopy)) {
> +    if (migration_should_start_postcopy(s, must_precopy)) {
>           if (postcopy_start(s)) {
>               error_report("%s: postcopy failed to start", __func__);
>           }
> @@ -3285,6 +3333,7 @@ static void migration_instance_finalize(Object *obj)
>       qemu_sem_destroy(&ms->rp_state.rp_sem);
>       qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>       qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
> +    qemu_sem_destroy(&ms->switchover_hold_sem);
>       error_free(ms->error);
>   }
>
> @@ -3307,6 +3356,7 @@ static void migration_instance_init(Object *obj)
>       qemu_sem_init(&ms->rate_limit_sem, 0);
>       qemu_sem_init(&ms->wait_unplug_sem, 0);
>       qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
> +    qemu_sem_init(&ms->switchover_hold_sem, 0);
>       qemu_mutex_init(&ms->qemu_file_lock);
>   }
>
> diff --git a/migration/options.c b/migration/options.c
> index b62ab30cd5..2d6b138352 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -163,6 +163,8 @@ Property migration_properties[] = {
>       DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>       DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>       DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
> +    DEFINE_PROP_BOOL("switchover-hold", MigrationState,
> +                     parameters.switchover_hold, false),
>
>       /* Migration capabilities */
>       DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -883,6 +885,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>       params->announce_rounds = s->parameters.announce_rounds;
>       params->has_announce_step = true;
>       params->announce_step = s->parameters.announce_step;
> +    params->has_switchover_hold = true;
> +    params->switchover_hold = s->parameters.switchover_hold;
>
>       if (s->parameters.has_block_bitmap_mapping) {
>           params->has_block_bitmap_mapping = true;
> @@ -923,6 +927,7 @@ void migrate_params_init(MigrationParameters *params)
>       params->has_announce_max = true;
>       params->has_announce_rounds = true;
>       params->has_announce_step = true;
> +    params->has_switchover_hold = true;
>   }
>
>   /*
> @@ -1177,6 +1182,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>       if (params->has_announce_step) {
>           dest->announce_step = params->announce_step;
>       }
> +    if (params->has_switchover_hold) {
> +        dest->switchover_hold = params->switchover_hold;
> +    }
>
>       if (params->has_block_bitmap_mapping) {
>           dest->has_block_bitmap_mapping = true;
> @@ -1290,6 +1298,15 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>       if (params->has_announce_step) {
>           s->parameters.announce_step = params->announce_step;
>       }
> +    if (params->has_switchover_hold) {
> +        bool old = s->parameters.switchover_hold;
> +        bool new = params->switchover_hold;
> +
> +        s->parameters.switchover_hold = params->switchover_hold;
> +        if (old && !new) {
> +            qemu_sem_post(&s->switchover_hold_sem);
> +        }
> +    }
>
>       if (params->has_block_bitmap_mapping) {
>           qapi_free_BitmapMigrationNodeAliasList(
> --
> 2.40.1
>

