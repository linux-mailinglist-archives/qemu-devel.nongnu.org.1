Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC3749DAB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHP3W-0006QP-Rw; Thu, 06 Jul 2023 09:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qHP3D-0006FB-1i
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:29:40 -0400
Received: from mail-dm6nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60d] helo=outbound.mail.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qHP39-0002KL-BP
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7QUWDSRKKD6gnGeVWSEk+AKcstQjgGlZwzsG1HhnfPTFKmM7eHqCb0weR2HAzMLLYuGu5P6az4PVsgu4uYn6teCHYwfqyV+ozHYFLAcIqcG/ykz6gIlY02ytMHAbF+Md/cUzQSgKgvUZnFVphIK8kSzIPaw5gO24L3iOFWVa2A+jJOYyjc/X8J+QrajJ5tIDEDA1geoK8itoQxaAkMV2ZXy9QacWz6S+LOeetD5DMe5bEYnAoDgYqvAUvaa2n33fITyLXYiUBCsaTJlYOXooE606OUHtOO+aei/oZ/sgHf89G9MwTbhsxqxIM2vr94lw8REWXWkcOdF+OFIbVvHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gvc8qKMNp3trFzdPbQE1Y1WF67syDeQesRbpIxyGTQ=;
 b=Tb/TnAI2zeswwaCL03j/iZED4U7rCJ1dhDi9A/HBFIiWuRDE+/wypECu/vBlT75zf1kYfniZtD71TJECMdPjypXUIBARW9u3owN67OLvLXzq7DVENGSh+K9kdxDmLaX4PJg7IBYd7uLkedEzJj2MxLLFVwSnjyxr7/9ZdRA8/U4urvUxjAt9b78Z+kqrFV7WcqJPY3znedyvy+9/tK0IKZzY7KkzlkwKbGDJca2fefZmM5w9ZppKhDP6vxdEq/f86FeLjGpZG8GBIhDs9JLLTRS8AwITUlYkSxkDXecQZD2dZpW8SC/AgHI3mpxIz+iaY4cU9w7HjxTTD5rWpV65bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gvc8qKMNp3trFzdPbQE1Y1WF67syDeQesRbpIxyGTQ=;
 b=pfo1D8s6F4gdgePzsN+O9/k+/VTlCZYOWqb9kH9Ar2Yr00r66sJ+Ns3aGRlo7k4cRPe0f4YHkA/PASu5Miv3gyfUfFPl/5NZ+OYzo9ua6PO2jsVaB5YWDier5oi+qpsTXTZu4Pn8Gey/QuiBB69x+agGXWjj1ZLM4bkpMKaUPMLr5M7WVB/l+yXo7iHK2E58XJj321MXhZQFjZrp0cGZY8OHPwGOdXIY6bodUDU9Qk3sNn4tXC8g95CB8lAHwTyPnDh3BlYdYAg+X1ApmXgVkdqvH2MrndHjpEylKwMSKHTZ9Tg8JAmjWr/7CSL2SuA/sX7SMg4uMwUCpYBSgGw2/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:29:30 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:29:30 +0000
Message-ID: <7bdfed14-0c32-901c-612c-3e66a79aa35e@nvidia.com>
Date: Thu, 6 Jul 2023 16:29:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/2] migration: switchover-hold parameter
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230706124331.377939-1-peterx@redhat.com>
 <20230706124331.377939-2-peterx@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230706124331.377939-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d143587-cbc9-464c-7927-08db7e2506ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d+IX/qhB53KCwYdsYwzgj1D8Qb71+AC5qklpg/IyeHmG/NXieYBpzzQG0vLaycaQLu2vXO4cf1jJSTG4PRidXZx6rxEv9qBEp5Fbm5aI+ufPA/icRWy1JQaAohGkbi13duVMLoFHDlM6SJkuw2cXo+Kx8P6OmnCzISRFUjGO3eI51SwJ7IDF4Kk7gnkLPwtvrnJCBeNwyn1J0hvFItTxymev4ZZ5EqcIxbP0G+RPQ+9LEHXwuhiyAdCNv0/zWApXuq22CfCbMbMQ635q5XUVuf9C8AMPYKlIs5JuP4JlwJtxWxoQmg0imxKGo46cDxMJeXyF4qxk/oc6+/xSCHOE0P7TnsUTf21eRMFoFs0VDxjPxGf5R67Ok1rKdm3lTrciI+gPyNhhuMuzFX//Vv6xNFgatGw8RV3pFqDm8HP4ZG3gp+9YVA7j+rYic0rUKcRC9q+CsOONLCRYAKjD1T9TCn0hGnjErinE64CY9fcaaJhgxXuUntwZ0qrrF+RkNKRGNntCoIQ4M8Ru90OVlhSyhFH9U5cWvBoTcF/J3Sej9mCwaY9drA8pXVXWdyz1nCIFPcnGkEF9yHTGKR9S/6g5xNKqREAij0rdHDesxH/NIxHEbtcqi7O7ZEPrwag5XuupCDkrFKYFytbkkbxAGHzug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(478600001)(6486002)(6666004)(54906003)(53546011)(26005)(6506007)(186003)(6512007)(66946007)(30864003)(2906002)(41300700001)(66556008)(316002)(66476007)(4326008)(7416002)(5660300002)(8936002)(8676002)(38100700002)(31696002)(86362001)(36756003)(2616005)(83380400001)(31686004)(66899021)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzc4OEkveEIvSDZ1dzg4cy9FbS9keTB2V1ZtWEhXY1RZNkhabUlHTFY5VnVE?=
 =?utf-8?B?UDBpSnZKenN5V0xmTkpPMmp6cWdleC9oeWZXRWQyMUFKelhwMHhMVjdlLzFG?=
 =?utf-8?B?Z0lMV3NqTUE2QUxlaGtpaWlNMlF4L2pRRDFDTG5ZanNMeDN4SW5KRFRiQ29i?=
 =?utf-8?B?VE5MK1o1a3RucktCYWs3WFl5ZXNZUzRVVFZOQTJRdzBzNE1ZL1U1SzExMzNV?=
 =?utf-8?B?bXVHaUtlRUxqVTVjNmpqNThhcVhEZ2ZyQ1o2THRFMitYR0diOG1NeEJEWFdJ?=
 =?utf-8?B?NTdzeFcyVDZ0Ti9BcnlnL3BQZnZRUkJSWDYvRGxucTM4dmptVzZWOWFDSUMw?=
 =?utf-8?B?NzRVM1hUWlJYb2FnQXo2cFBlYWVYZ3FpUEJ5Y1dDMmQ5VW1TVWdkaCtUamwy?=
 =?utf-8?B?VXFDT0RkK3hPVEljd2RlZW1hcnhGQy9rM1ZUcmNzZlBwS0xLSXNKWm16Mzdy?=
 =?utf-8?B?VXhoWDJDdlYyV2FxOEVZNE9Lbk1tdFdERjdCSTJWL0VEalVPNWJXOHpCc2R6?=
 =?utf-8?B?cWtYUTdaYUsrWUJ2c2dSajNJYStCTk1GZm1mSkpZTVUwT2N3TlZNM0RkS285?=
 =?utf-8?B?c0YySGRic2x6c3BXNHJuT2REUkRQZEdCZXRRL2YzSktxSnNMSEcvV0s5MkJp?=
 =?utf-8?B?OHErWHlRSWdlVTVGdFpIc3NQOHFBbElQMTBDa1JzbTJXbFY5c1A5Y0N2LzRq?=
 =?utf-8?B?dGVGS1A5OUZQTkR0M21uOEYrdk9weGFkenVDaWV1c21tY3hoeVpLR1BMaDNq?=
 =?utf-8?B?dzc5eWlCTGRHWDJIeEp5b0VMRDdlRStIOUc0c0l0bzZWMlJzdW5CUGgvbDJO?=
 =?utf-8?B?N2Q1UWZBRWsxL0JoM0tiRHJMVU9nakRGT0p3dmRaT2hid1ZlRlRMZ1ZySjVs?=
 =?utf-8?B?eDc1dXpJVmNxYWl0Q2VYOC9NY0F0NWtRdGpXcjh6dHNsZ0RxSEI1TDkyZ2t0?=
 =?utf-8?B?NHZxK1J4blYrZWUweGV1QW9Cd1RoR1MydWk4YVE2UDIrTWNLYmloSHk2TFBj?=
 =?utf-8?B?Z1N4cmIzbmxXQTNMU01tdFNUS2MzYjJpRzNkVjZ3MFZBaUZicldPSHBTNEt0?=
 =?utf-8?B?RTI4cGE4SklON1ExSGhFRjVPbjdrYU1jWTFTN28yanYzWnI3eFNaTXVPK1RL?=
 =?utf-8?B?NHQ1TVUxYzBZS1ZOYml1M1p0bTRyTmlPZ2syMWFWN295bVowTlpTbEFVTWdl?=
 =?utf-8?B?eGFCZTlOUGQyVXgwTVp3SkN1KzNYbkFxQ1ZDeHFMaWVlNlpuMW8yUzRlVDg4?=
 =?utf-8?B?NStpM0lwNUhGb3NqbGMyUGwySXc5RFFLVWZGUzBFVUJoWFc4eVgvZXJqVDRt?=
 =?utf-8?B?R0Ntc2RtUUJUdTA4TDI5Y3g2NWlkeDhOMXJqdE9pL2hBNU5IMnFOdktjTTFj?=
 =?utf-8?B?aGNoUnA5ZEtpVTBFUERsMDlQUXlkdWlzSVFHWHJ1VEZNTlQ4QmVqTThyUXFp?=
 =?utf-8?B?dHpFc2h5dzh0SEduS1FIaW9nd2NUUGsxd1c3d0oyeWM2YTR5Z282Y3E4TDFY?=
 =?utf-8?B?NFZGM2oyN1ZEemJOeWpNcitVMlYxeDE0dlA3NTRVanVWUmw3NFRoYzVTdFVa?=
 =?utf-8?B?MHdBNHlzZUlqRGVPeGs3VHVQajhkVDdsUkxISmRwNlhuQVB3WVgvQ0Jodndz?=
 =?utf-8?B?RFhNLzYxWGhBZ2tRM3VDamNKSkxWS0FhRVEvRDlKNldPTVE2Q3lxb0krMkZ6?=
 =?utf-8?B?QVdpSXQvTHpBTlJlUzlOOFo2NlhnMk9hZGQ5YzNJMTVLTk8rNGNlQVV5VkVn?=
 =?utf-8?B?Ti9ocWxXeDNZaDl6M2pFcXB5TUxhTk5wS2QvYmc1SlY3dDBaZEtnM0xaeEJG?=
 =?utf-8?B?dU9MSEtGNzVZd3FxaUlDa2VxN1B5UVFiOFljUlNJT3h1d1RPNkFiQy9zb0xR?=
 =?utf-8?B?dm03STZjV243M29pc1o5KzdxR3piYWNqK2V4dDVUUExuRkRTYW0xK3dtQ1Qw?=
 =?utf-8?B?eUlMc3VjS2VJWTRSTC9NMUJacjBKcGhxSDBCSG9KV3ZLMG1ZZ3grVjFsZUpQ?=
 =?utf-8?B?MzRhSDJjL1AzRmZHbDNtK1ExcU9CcFcwL0psNzliektQZmF2cldrTW5Vcm95?=
 =?utf-8?B?YXRkOUxvWUdHMkhMa2czWXBoWE16VDd4azBObklod3dYWFRnTkd4NzhzUEho?=
 =?utf-8?Q?fiWCaOzsIVvpmz2p/tSILPiWE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d143587-cbc9-464c-7927-08db7e2506ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:29:30.0614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tll9vrHDympBlTuygx+2qOQ2xmHuonpDRmghUt/zE48UzeG0F4DlKC18dQpz3LonjVwm/Wpg5diUkPpmkhV74g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60d;
 envelope-from=avihaih@nvidia.com; helo=outbound.mail.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 06/07/2023 15:43, Peter Xu wrote:
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
>   migration/migration-hmp-cmds.c |  7 ++++
>   migration/migration.c          | 69 ++++++++++++++++++++++++++++++++--
>   migration/options.c            | 17 +++++++++
>   5 files changed, 128 insertions(+), 7 deletions(-)
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
> index 9885d7c9f7..c3b3860f00 100644
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
> @@ -616,6 +619,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>           p->has_announce_step = true;
>           visit_type_size(v, param, &p->announce_step, &err);
>           break;
> +    case MIGRATION_PARAMETER_SWITCHOVER_HOLD:
> +        p->has_switchover_hold = true;
> +        visit_type_bool(v, param, &p->switchover_hold, &err);

Should this sem post switchover_hold_sem like in the QMP case?

Thanks.

> +        break;
>       case MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING:
>           error_setg(&err, "The block-bitmap-mapping parameter can only be set "
>                      "through QMP");
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
>
>       if (params->has_block_bitmap_mapping) {
>           qapi_free_BitmapMigrationNodeAliasList(
> --
> 2.41.0
>

