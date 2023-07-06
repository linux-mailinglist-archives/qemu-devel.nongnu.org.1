Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B437497A9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:46:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKc9-0006ln-5Y; Thu, 06 Jul 2023 04:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qHKc5-0006lE-Nd
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:45:23 -0400
Received: from mail-dm6nam04on2071.outbound.protection.outlook.com
 ([40.107.102.71] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qHKc2-0006OB-AA
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/jagnGsy2yNrX/SgkDdaakIiHcgnEBvGmLoIkfkbx19ib33TBr0kOaFYB0C1wy2d03enHA1Sb5MiHtW1g7AZEwcBoKr+b7+oKVWUcOJbNlYY/fnWn5DMONnzI7N+EIdp2N/X05Jj2DgZ3NmchOq6NoS8gxAGFY6Fh2yRYVTJDktNHxxMMzALk/p8MkAvE86+d1Le3CHUuE9A6JyXxRtFj5KIG7YSj9ORDcMzTMBSgZDxs8UYyPO9UEmpomGymni+inpuQJnhJyK+S8tzrr+D+mLft27cvXTrRyClOHCw1jiXasDBjOZYViHcWziSug4s2yQ9MGE0WuD8Q4qVYzA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbyL7OfpYwdvcNYbyBaWmXSNXgvGpCV27+cF3cBHvlM=;
 b=OcvUCVD8XQdsVo91tGOMD6Uof/lR0S4OSzqZv0NtrhmUIpNdRIceL/vbOzYLicT3SUFqHAZ5aNRVPIZzadeoazLchr3F3oBRBrfCMEz4xPRkK0FO7dC/+udVrmCLmDzSey7lC9uXygk5Fg0+NR/Q1c8BP4vXmxE8YKyE8S4+cEgXCLW+YKU7jbcVCc1kUzf+VuFsgosl/pO2A9pKLuyOddArCtchduSU74HfyS57a0xD4MeDe5O514Skt9vXEUuOBwdMeJKDpdechDM/ZMmgY08GsgCLJLafCDhWLlKc4II2jmxvb+cQlav9Tcot6ZzJ/4ZiRtfWFcyyFebINXjTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbyL7OfpYwdvcNYbyBaWmXSNXgvGpCV27+cF3cBHvlM=;
 b=A4Euzt+ktk90/aG9kt+U0Gqs2X0CB8M4TEDe1kY1YhONJp5sOFc+HkgX7fEK5sXcTp7YEHM1nd61gFS+czAxNNKJotPC46prNbV6chmlZYteXY3vpyWoQhgpdFjkl9/S3WfGC49j8jcz78AklJhLoZe2fzBF349TeORmTwM7WYVIqL9OZGeTbLoejCJljGN0/Qeq+ueYVBYn1FjBiYEOAEK+By9c/T6FivENF7rO+BeF1Qn49ZnZvfRvUrR17yB8lpE3HaIOS5ohBWaEc20pploqADjCoa8pUThHTYtixbFIbsBk3YQHODxrO8GiLZJ8KJdBjYzOTMJKQFO2hE+G9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:40:11 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:40:11 +0000
Message-ID: <0ed812a4-3fb9-3bb6-6153-c1a1fc6e72d4@nvidia.com>
Date: Thu, 6 Jul 2023 11:40:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/2] migration: switchover-hold parameter
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230705163132.329501-1-peterx@redhat.com>
 <20230705163132.329501-2-peterx@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230705163132.329501-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: c6aea411-d6dd-43de-343f-08db7dfc9c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2Q7YB0mY5VNGexWWXc3knUIloPgJBVX9o1s+vs0d+Pd61TvrKEmKJYq5g7iPFBGWrSh4sTgXxh1JsbiZyeGe6uoMq6HUOtJcvW5WZSTL60LnyNCw5z4Cs0oDkaxny8B8oxjzJnNeI+b/dNqmxGgo+15aH8AJUN6YpLA4Tq+C3pr83MyokzjBYBTYzgToNJiOCHcrxZLXrpRQ4s2sPttpISe48F93KqraVnwXRDx9CjarQrHw/eXgD4bDuOF72TPP7zGDk4dTJDL97lxYfMdCLTF/oKo0tmXULAz4B+3clV3Uc4kMJdv4+GFziJP7nsavjJQyzD4kViegtDQGLZntc4eH3+dmKBuU5gN9mmqEPopH10tOduKEDXdpJYjjwjV5pINp+f5YDjFKRmqFfCYsUJJgM2KO+goiMd7O1hNDospyyVZaMnP833+jdIEjj3fRZ8yfESqHBNB8Hg8FJg83mpyMOWZvGmJM3q9eTuilnxT32wBEOskjzdIHJAhM0UR0fiPCakdlcltEuiYlrRSRRuA+aICw3kM2+mdBU856jEThwZnBWi8/FeKsdIxxNBS74cQ1rGmyak+4GtqUf5DXLzMp2/u5EaBdB7sujBqFpr8kWRg1lOZXZ0vAEuc44J/AHAr5Atqg9/aAp2jiQucbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(53546011)(5660300002)(2616005)(8676002)(31696002)(86362001)(8936002)(54906003)(83380400001)(38100700002)(41300700001)(316002)(66556008)(66476007)(36756003)(4326008)(66946007)(6512007)(30864003)(186003)(6486002)(6666004)(478600001)(26005)(6506007)(2906002)(31686004)(7416002)(66899021)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzQ3VGx2SlhjeEpvT1VvRGFjeTF5OWVrMzJVM0lkaVhvUCtXSkdtSlVpcGVn?=
 =?utf-8?B?ZFJjMFUwQzZSeXdySy9vKzRLTzJmSmhYbm5MZnNsK2J1MUZKUWVJYnNaN0tm?=
 =?utf-8?B?YWhjR1ZISmdPVHBacVAvcDFDanN5SWMzN1JlY2xZR2pOa3JYa25JUGY5RWhU?=
 =?utf-8?B?MVQwR0EzT1lqbXoyamp5cWxuMHdrTjV2YUFwU2pyOXZxY3pveVBBM0JId1pl?=
 =?utf-8?B?bnYyb0tjbDFMREVwbi9nWjBRY3A4bWRKOFBDbXl2U2hrY0x0MGlxM1lybmRQ?=
 =?utf-8?B?K29WdCtGNXdlcXovaWdtcVkxdktnd3JaNnVXNjh0RWpMRU53dlVzd3RHdWJQ?=
 =?utf-8?B?K2tKY1pTc25ML25uL0pybExQME4xS2VDVFAra3FRbW1tMXJMWHFScjFtTVpE?=
 =?utf-8?B?NFdYYkNiNDFLaFRLS3hZQU4xcndqT1hwdngyK1AwMHp3ZlFSR3E1TVJ6WlZ3?=
 =?utf-8?B?TkRSS0IzdVRxRTg3SUdLSlhBREJDbm9aOGNkRmFHYk9OTThrdFpjQUR2eGtR?=
 =?utf-8?B?d3RzVXA3S2ZOUEJqSjM0VE9ldUZFZUh4ZmpyYU1OL0l1dWhMUEpRME52UEMr?=
 =?utf-8?B?VlNqN3pUcWYxMEFrTmZCUDZLUFR4dmt5dTA0K1hBRWNIaXFoV3ArUDFRa1Ur?=
 =?utf-8?B?TXJzcE1KaVcrMW52SVE3UWNyZzdOUUxxWk1mN2FDOGJLZTliYmllSFdpQzVa?=
 =?utf-8?B?M2xUSzhQaUIrN28wMkhORFNhekM5V1EvREU4RmJxU1JzZUNPSzNmTjBiWVc2?=
 =?utf-8?B?dDZRQlc2STkvVmVFQjVNM0ZQT3BRaWd3Y3YxWWFQNTNQZWU5cnAvbGFkbjZK?=
 =?utf-8?B?TGJuWjV5V2MxSGJreEMzdDlrOW5GSzlvOVRWUS8yZTJESGliK0pkVC9JUk5E?=
 =?utf-8?B?UEtYRENEUDF0MWFuUG0yRzhKdkVVcURwTWJ2NkFzcmlxeGc4RU5DckxjN1VS?=
 =?utf-8?B?UWtiRVRFcHlaSldqUy9JVldUOXZTT3JtbHIrR3gwWXdFUmpVanByQ29hNEhI?=
 =?utf-8?B?U1pNeHFuTktOTmI0Z25WcGNxemRNRW1FT1hDOWVXYzlKczJWN3p4bDZZS0lx?=
 =?utf-8?B?WG91ZFhmOW9WYXZKcktDeG1jY1NSNlZqVWd0SGVycnlyNVRVVHl3OXpROGpz?=
 =?utf-8?B?UC9nQWpmMlMraTBUUUlFaU9rM0pnZWFmY2hVbmpsYXhOaFlSY2pVR25tQWkw?=
 =?utf-8?B?QU9uTDFFT2tIM3BpbHo2TjJLRXZidzViK0N4R2J6VmQ1ZjI1S20vbkQzNzEr?=
 =?utf-8?B?OWdjNlVxQSsvTzJ6ZHpEc2lyTUoxM2s5QW8xcHVxL3U1Nmt6UHl2d2RRWmhi?=
 =?utf-8?B?VmhGYWl1M2FtOGhiWjdIRzJBK1pNVFlYb1p4WGh2eTFwTUM5RXJrNnliRVNN?=
 =?utf-8?B?bGhlSnJVSUFrdi9FaWR3aHczZUh1SnU0MEJCTWYzcXloTmRDYm1Mc3VOQzBG?=
 =?utf-8?B?SlRNS1V3WjhFdWQwcjFyYjRXSEYyL2g0Q2J0VWd4L25DQVlEa05qcE1xakdp?=
 =?utf-8?B?c1VHZ3BuTEN6QkovTUdJVVhXZ2xORFgySFhQZmJkaFREaEl2V3FROHN3c2E4?=
 =?utf-8?B?ZWRLQjl5TDBIYmtoUnY2YlVLU2ppSW9qbVlGcllLMHphWnlYQllMWUFZK2ZV?=
 =?utf-8?B?R1ZSTXFidGFpLzJKNlRLeGp1ZmhPQm8rVzhGSW5zNHhNTS9rZDBON0RDWjk0?=
 =?utf-8?B?RzNESVNjWWtzdDJ2ZWlObEd2VmRzcTJkdzlzWTM2VS9TU2JFRVprbmh0SzhF?=
 =?utf-8?B?T2VKS24wa2NzOWc5ejBDQm96NXNQeDdtVXFBWnp1bFJTK3FjUkxQMW5DS2o2?=
 =?utf-8?B?RDJNdy9DeFBpS0x3Sm44djhWaUhFNFB0aEFwajRwcVNKMnNic0lrZVhnMmQ1?=
 =?utf-8?B?NkdvVmtZdVBocjNWZS9abE9GOC9ieUlEWThLOGY5cmVPcEdDNUc2SFFaUW9F?=
 =?utf-8?B?UEtxNWhXS0ZocEcxM1hVczM5cDBjUE44NFV6L21laHNXZVBEYnVnK1V5ZWhi?=
 =?utf-8?B?VWZEWHFqRXVFY21UaVBSTUVOYXV1eEU4eTFJSVI1MHpjbDJBK3BJY2wvQ2FJ?=
 =?utf-8?B?MzhkTk50R3VneE1EMVdJUTVDbmNTVmVDUUVBb0ZKZjZSbGlxTGQwdkRHdENB?=
 =?utf-8?Q?FPVbdeM/w6sQ8zQDmDSs1Znzb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aea411-d6dd-43de-343f-08db7dfc9c35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:40:11.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZOWIg2DWhuIkteW5J2QLth6Y221NqK9jMcUkSaX4z4Oc8xLVR+sT5lHE0spi7FlZB2qwQklmNbBC+PcNe2h/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
Received-SPF: softfail client-ip=40.107.102.71;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 05/07/2023 19:31, Peter Xu wrote:
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
>   qapi/migration.json            | 25 ++++++++++--
>   migration/migration.h          | 17 +++++++++
>   migration/migration-hmp-cmds.c |  3 ++
>   migration/migration.c          | 69 ++++++++++++++++++++++++++++++++--
>   migration/options.c            | 17 +++++++++
>   5 files changed, 124 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 47dfef0278..c050081555 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -789,6 +789,15 @@
>   #     Nodes are mapped to their block device name if there is one, and
>   #     to their node name otherwise.  (Since 5.2)
>   #
> +# @switchover-hold: Whether we should hold-off precopy switchover from
> +#     src to dest QEMU, even if we can finish migration in the
> +#     downtime specified.  By default off, so precopy migration will
> +#     complete as soon as possible.  One can set it to explicitly keep
> +#     iterating during precopy migration until set the flag to false
> +#     again to kick off the final switchover.  Note, this does not
> +#     affect postcopy switchover, because the user can control that
> +#     using "migrate-start-postcopy" command explicitly.  (Since 8.1)
> +#
>   # Features:
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -810,7 +819,7 @@
>              'xbzrle-cache-size', 'max-postcopy-bandwidth',
>              'max-cpu-throttle', 'multifd-compression',
>              'multifd-zlib-level' ,'multifd-zstd-level',
> -           'block-bitmap-mapping' ] }
> +           'block-bitmap-mapping', 'switchover-hold' ] }
>
>   ##
>   # @MigrateSetParameters:
> @@ -945,6 +954,10 @@
>   #     Nodes are mapped to their block device name if there is one, and
>   #     to their node name otherwise.  (Since 5.2)
>   #
> +# @switchover-hold: Whether we should hold-off precopy switchover from
> +#     src to dest QEMU.  For more details, please refer to
> +#     MigrationParameter entry of the same field.  (Since 8.1)
> +#
>   # Features:
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -982,7 +995,8 @@
>               '*multifd-compression': 'MultiFDCompression',
>               '*multifd-zlib-level': 'uint8',
>               '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>
>   ##
>   # @migrate-set-parameters:
> @@ -1137,6 +1151,10 @@
>   #     Nodes are mapped to their block device name if there is one, and
>   #     to their node name otherwise.  (Since 5.2)
>   #
> +# @switchover-hold: Whether we should hold-off precopy switchover from
> +#     src to dest QEMU.  For more details, please refer to
> +#     MigrationParameter entry of the same field.  (Since 8.1)
> +#
>   # Features:
>   #
>   # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -1171,7 +1189,8 @@
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
> index a80b22b703..6b31a4b371 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -453,6 +453,23 @@ struct MigrationState {
>        * switchover has been received.
>        */
>       bool switchover_acked;
> +
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
> index 096e8191d1..d75c2bd63c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2721,6 +2721,67 @@ static bool migration_can_switchover(MigrationState *s)
>       return s->switchover_acked;
>   }
>
> +static bool
> +migration_should_complete(MigrationState *s, uint64_t pending_size)
> +{
> +    /* Need an explicit ACK from dst? */
> +    if (!migration_can_switchover(s)) {
> +        return false;
> +    }
> +
> +    /* We still have large pending data to send? */
> +    if (pending_size && (pending_size >= s->threshold_size)) {
> +        return false;
> +    }
> +
> +    /* The user doesn't want us to switchover yet for precopy */
> +    if (!migration_in_postcopy() && s->parameters.switchover_hold) {
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
> +
> +    /* Need an explicit ACK from dst? */
> +    if (!migration_can_switchover(s)) {
> +        return false;
> +    }
> +
> +    /* We still have lots of thing that must be migrated in precopy */
> +    if (must_precopy > s->threshold_size) {
> +        return false;
> +    }
> +
> +    return qatomic_read(&s->start_postcopy);
> +}
> +
>   /* Migration thread iteration status */
>   typedef enum {
>       MIG_ITERATE_RESUME,         /* Resume current iteration */
> @@ -2736,7 +2797,6 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>   {
>       uint64_t must_precopy, can_postcopy;
>       bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> -    bool can_switchover = migration_can_switchover(s);
>
>       qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>       uint64_t pending_size = must_precopy + can_postcopy;
> @@ -2749,15 +2809,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>       }
>
> -    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
> +    if (migration_should_complete(s, pending_size)) {
>           trace_migration_thread_low_pending(pending_size);
>           migration_completion(s);
>           return MIG_ITERATE_BREAK;
>       }
>
>       /* Still a significant amount to transfer */
> -    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
> -        qatomic_read(&s->start_postcopy)) {
> +    if (migration_should_start_postcopy(s, must_precopy)) {
>           if (postcopy_start(s)) {
>               error_report("%s: postcopy failed to start", __func__);
>           }
> @@ -3314,6 +3373,7 @@ static void migration_instance_finalize(Object *obj)
>       qemu_sem_destroy(&ms->rp_state.rp_sem);
>       qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>       qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
> +    qemu_sem_destroy(&ms->switchover_hold_sem);
>       error_free(ms->error);
>   }
>
> @@ -3336,6 +3396,7 @@ static void migration_instance_init(Object *obj)
>       qemu_sem_init(&ms->rate_limit_sem, 0);
>       qemu_sem_init(&ms->wait_unplug_sem, 0);
>       qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
> +    qemu_sem_init(&ms->switchover_hold_sem, 0);
>       qemu_mutex_init(&ms->qemu_file_lock);
>   }
>
> diff --git a/migration/options.c b/migration/options.c
> index 5a9505adf7..aac658fb2d 100644
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
> @@ -900,6 +902,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>       params->announce_rounds = s->parameters.announce_rounds;
>       params->has_announce_step = true;
>       params->announce_step = s->parameters.announce_step;
> +    params->has_switchover_hold = true;
> +    params->switchover_hold = s->parameters.switchover_hold;
>
>       if (s->parameters.has_block_bitmap_mapping) {
>           params->has_block_bitmap_mapping = true;
> @@ -940,6 +944,7 @@ void migrate_params_init(MigrationParameters *params)
>       params->has_announce_max = true;
>       params->has_announce_rounds = true;
>       params->has_announce_step = true;
> +    params->has_switchover_hold = true;
>   }
>
>   /*
> @@ -1194,6 +1199,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>       if (params->has_announce_step) {
>           dest->announce_step = params->announce_step;
>       }
> +    if (params->has_switchover_hold) {
> +        dest->switchover_hold = params->switchover_hold;
> +    }
>
>       if (params->has_block_bitmap_mapping) {
>           dest->has_block_bitmap_mapping = true;
> @@ -1307,6 +1315,15 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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

This only handles the QMP case, but we forgot to handle the HMP case.
I was testing it and got the following assert:

   (qemu) migrate_set_parameter switchover-hold on
   qemu-system-x86_64: ../migration/migration-hmp-cmds.c:627: 
hmp_migrate_set_parameter: Assertion `0' failed.
   Aborted (core dumped)

Thanks.

>
>       if (params->has_block_bitmap_mapping) {
>           qapi_free_BitmapMigrationNodeAliasList(
> --
> 2.41.0
>

