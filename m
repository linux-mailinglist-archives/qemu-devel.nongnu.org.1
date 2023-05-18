Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F911708647
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgvn-0008Ls-Kp; Thu, 18 May 2023 12:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzgvl-0008Lj-Ih
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:56:45 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com
 ([40.107.237.81] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzgvj-0005Jp-9T
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDKBnlYpGiCVK5dv4wERLdy4RPcuGM5HhPVeygzit6DMGY0v/DnsQZJ2zcF+sfJ6mm94nrUnBzSq4Cd5wCnTDKCwqTGn12v5e/qONKHVlbfrHWj0fYfch5skTv613Pl0t8BPqfdoeWRFHBOe73kp5YCnEl4MMARIAXrt0ZHiP2ccFxnfbdmp7KacTEJj2H9Ec65EqQDYtxSX2qfoR45l4BwKBIFLE70uLvXyaRELjox6sw4KSQx/7rI4p/ATDjxl43YoYuZOFRdvkitNowTirslf0/qpc0eqqjlsfAcZnHnogGElPF50N4LtUPRuzUj+2PyDZUC6OpJTCQKCe5R9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InybWjrHMSRmhsELMorQ7qOjeKlbndf9TtawwgS7iv8=;
 b=ImxtCPrQdQg/KTxXz4qNVL9Op+LbuaMN2XGncHFMS0boNHyi42AEbxQyUn8IlF2tj6+9y3zRRTbB4ZIfnrQwNpV0FcmZ5LdKBk/uAZSJ1kFve+3JqLY9SIN9eCwQy+Pi09mYSSaMWxkBktMJcjGl4ss7p/ebkBUpyW9eWTzPbPvfuSMDZB8XoxrlpM/fEtk1ivvONjo4iAybT4jTFuJyRYCVJw9KqZQUozCj8SbT/TynzEE6Njf9p28UJjsRvukJYdtP6i6JtdttKKM0Y9XOAwD9fm/jCSHQACWR4rA9OvGO7e2+6DjSH/CURTtRRRc5nLJAdVQqu2EoVTAUB1WJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InybWjrHMSRmhsELMorQ7qOjeKlbndf9TtawwgS7iv8=;
 b=pMtoSxRYy8MvqjKO02u1xbd+o0B/lmkx1oNLOhTo1mmmy+pxYux3o5vYO9CsHHFuoWTcfOGC2seRMnxGynh0WeBslYoggVsc2YE8tKkTnEnaDR1Cp7XGZHbE7Q4BtM3qLoqPZT+Ci34AEWSOlbY5aNNlpmP+Dlrj5nWeoZwZCOsEqZFub2tWhErIcs+zC7MhP5Ksk5uSVJNAq5k5wxhGTmbvJeYvLx1kDMeUiGgnvHuBzV9IHCCatYllUUD6jLlK61eduF4w3IP0fQB0el5o6LJM0ovr4aZAXlwn+gEt3bc/rHG/1dD9tXDAjMtCi9koofTkBTC8uTqr7E78f/X8wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 16:51:36 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 16:51:36 +0000
Message-ID: <fb04f08b-df35-1c49-d03b-5dd69701bfeb@nvidia.com>
Date: Thu, 18 May 2023 19:51:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/7] migration: Enable precopy initial data capability
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
 <20230517155219.10691-4-avihaih@nvidia.com> <ZGT72DLNTevauf9N@x1n>
 <bd2bf4eb-2f3d-83ce-609a-9b48a592d88e@nvidia.com> <ZGYrR6tn0VxNZ/h2@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZGYrR6tn0VxNZ/h2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b925993-a0b7-43f3-b978-08db57c024a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TENEwxTCCFU3Hn59pD1ZHCCAh20l87JBFznDdlRq+u1GlUrLmNHXfhaQz785hvN0Lqz8//ruTWNAzhz069HF+4YFVUa8QcGQM58Z9ZEzuxT+5tLUQyMiCbpE9hdetR4DB/A0Rz4dOk7IujRRlsJMPSeOCiVAtVVySUGk9cRAftKQIsDpcwVmOjuPER5pM0j0AADIUr+SOFyC1wqZM9bpn3/3Ldig+HlEDpTkxjvPqaLyohY0cOP1sgg/6MUX39IqOJ87QKvpLNwNiWwe/GjjxcZ6fEoN5J/Z5WW5hDAOWnlBSg7Qv+ofUEegH9Wy9DKh6NyFx+zDYVkAn+G7Z960vwWKYUrFAnlGMcRsu0mlAM7chbuG5PNKPKduZJm2lJudg9WLx/H5MR5J5avnmW155kg0y84JnD8No2W3Ji7WZlyA3UaYnokcObr2DceFqAVzW2TRceLVbUuYNodTy55+EVAEA6WMDLdOZiO8wlQwBdmALPHMDqXa+zOJDb/KjyPS2zZjudsZ38PCmJR1XnCtB56EVGIM1Tzm/N8ab/PiV8vbZp4TFrFiNidcg6ix9TgID+3s9d3sdt/VpywgSmU+EAqB0lBdAuxnY6fo8OBJDO1aGu5Xi6UkpiO5MzQrqhqUj70nyA8oAexxiZMxoOEkmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(478600001)(36756003)(6666004)(86362001)(31696002)(54906003)(6916009)(4326008)(66556008)(316002)(66946007)(66476007)(8676002)(7416002)(2906002)(8936002)(6486002)(5660300002)(41300700001)(38100700002)(26005)(2616005)(6512007)(6506007)(53546011)(83380400001)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZORkNnQjVVY1VQR0JvWC9tM0o3UTFmbFc0akNTS1dqNlFqTVU0dHFRQUo0?=
 =?utf-8?B?OUN6UXB3QXk0RU02bEFXR2F6M1JBb0E1WlpCdXBSRDB6WVR4dWx1amNUM0Z4?=
 =?utf-8?B?bzJ0em1EZWZQN3NLT0pBS0hreVB1NWVlQVhHd3U3UDJxbmZ4R2N3NlpBYTBO?=
 =?utf-8?B?VXRiT1NacDAzcGlYUzQwenM3VTUwY21HdDZuZ3NhRDhoZ0ExcnNidC9MeWFM?=
 =?utf-8?B?VVhPRDAvaXRkQmFicUlIbUw0cm1UeTI2YlI4aUhjcG9HWW1uVUhaenVzNHBX?=
 =?utf-8?B?N2VxZy96SjloZ0s0b2xFcmhYb2xuNXdtdFo5ZUJSa1dyLy9nM3gwbk1Mbmdj?=
 =?utf-8?B?TGIrbmNTOUlwZnVBTXVOK1JnZ0htcUdJZGg3Yzh2ekRpRnhRcldkQUQza3dr?=
 =?utf-8?B?RFVBZnlQTy9ia0tBV0NzNXI1b1J1b2owZWw2UVFNOVNRdWhna3RLZmxlVlFa?=
 =?utf-8?B?K0xWSGhzQWZ3aU85a2ptWDg4b0dLVU1HZjNhdnUxQXZQWFFYQkVpaTVwblBn?=
 =?utf-8?B?U0liSndpK1FNWlduRHhBN1ZibWN5dWpRT2ZaL2hNNDZiTFhhS2p0Y3F0Vk52?=
 =?utf-8?B?bnBvYzZVWllzQWJpVVZBWmUyVkEydEU5OFRpVlo3WnBCMUlVdDlNNVMxOVdN?=
 =?utf-8?B?R3dxQ2tkSTNDYk5zeXZsTXJWZldhV1pnc1JVbTlWSEpBV1VvQkIwazhBUStJ?=
 =?utf-8?B?U09JNlQ1a3dGUm1La3NRZXRpM0QrTGMvNEVmUFRsOVA3VStSQ1d1ZGdKK3ZV?=
 =?utf-8?B?NlBmVGV4N1U5ZjBoRnY0RFF6S0tUMTN4bVlTTFdVNHNPaEZhUlh3azgzL0E0?=
 =?utf-8?B?dGg5QkZDekZpMlIrSXN6eloxOWE3VVpXRldkelpiMHh5NklKMFVveVpCQmV6?=
 =?utf-8?B?c2ZoYlNlUFBCaWJ4d01jRTdvZysrb25yUlA0VTAzTmg3VVU1TmNGYmNJdjdr?=
 =?utf-8?B?OGxHNTIzTTRCL0JzSW9nbXpLL1o5ZU9GZkViWkRzQ2x0R2JUcDFMN3RKVWM1?=
 =?utf-8?B?dXlXRXRueGlOdmoyaVU3UUhHdGw0blp6UG1DRlIzVTNVc2VhaDkvUStqMHF3?=
 =?utf-8?B?bFZsby9wVDdPNnA3VExaR0ppdHlBZ2RBNFhzTzJZa0dHR1AzWG1NR2F2aWNa?=
 =?utf-8?B?dXdWMVJFcXlaTmRVV3ZZb2JiWEExTnVpNFY2bmhRYTRGZ05zZ3Y0ekxhU0tN?=
 =?utf-8?B?aDNxQ1p2TVNaOUZ5bVFIMEFRYkNxelZidDByRFdhYVJzczNqWFhKbmt1eFFk?=
 =?utf-8?B?MnNkTGZidS9QWGpKcGVxQ1o0VG5xY0VJTTZNRTJhSkx5cFQwZGZnajBCZEcr?=
 =?utf-8?B?Qkd6ZUJySlZLQ09CYTNieDdldEFGem5Ja0I3M3VQdE9qM1ZleXJ2TkRWaXQ2?=
 =?utf-8?B?Uk95NG0zMGk3cituNW55RFMrOWt2SGlxV0RkbHFBOFE0QmF6RWdKV3VMRnI5?=
 =?utf-8?B?b08rU2ovMHNobUE1SUc2Q05pRlNyb2ZPR1dEZXhHUjlnSlFBVWpXeHVNUWxw?=
 =?utf-8?B?bVp5TXdQWVdZNDE4QjZhWWFJckcycmxRYWdhT3cvVUF4NGMrcDE3cEdydk1p?=
 =?utf-8?B?aUV2STV0VTlUT1Z5MDZaVmFHSjBDandES256aDBlVG56OHRaakZGTXQ1RGJa?=
 =?utf-8?B?R2lZN2hlM255NE01SC9aVFNKeXZDc3F2QW5KNmZnbzN5UVllVk5NU2NST0dS?=
 =?utf-8?B?Rk5yVzVkenlQcEdaK29ua0xBQk8xVCttMVVyaUZQZDJyNmNnWThMajB6NjR5?=
 =?utf-8?B?UnBvcmVqaVQ0UUhRNmpudEMreURHMXgzL242WFBMcUt2Q3QzM0lFb0dnNFU3?=
 =?utf-8?B?bzVydWdSTmI0akNock1uc25MUEpHWlhPbjR0a3R6OXpnQ00yMUswUjVZVExE?=
 =?utf-8?B?eXZ6dzcxcWs1UmZNSWpmeUg1d015a0k2U3lNekJQS1pvbkpLenNWV1QwNEow?=
 =?utf-8?B?UHhyYkVJemVqblIva1pQby9sWEU4ZjAyVWhmaEpWa2JGUjJpUk1PVmVmR0Vy?=
 =?utf-8?B?ck5BY3RST3llTms5Y09CNWp2dUN2WWVqTElFajdMckZqT2hJN1R0T3hJcXpV?=
 =?utf-8?B?MVJIc2x4ejdMRitkQzZROHRGampNK2NTUEFiN1RNam4yV2Q1ODZJWFZ1dHM5?=
 =?utf-8?Q?IKxafeD7hPOqzElKb14qxL28C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b925993-a0b7-43f3-b978-08db57c024a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:51:36.6799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4TfgFNzccz9RiXtQReZaEDFZKK4xvspNy0obLgq8wj/Z6livprZ3ubZ3ZG326Q34C2w3Lvv3XRRWwxXEXv8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
Received-SPF: softfail client-ip=40.107.237.81;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 18/05/2023 16:42, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 18, 2023 at 10:26:04AM +0300, Avihai Horon wrote:
>> On 17/05/2023 19:07, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, May 17, 2023 at 06:52:15PM +0300, Avihai Horon wrote:
>>>> Now that precopy initial data logic has been implemented, enable the
>>>> capability.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>    migration/options.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/migration/options.c b/migration/options.c
>>>> index 0a31921a7a..3449ce4f14 100644
>>>> --- a/migration/options.c
>>>> +++ b/migration/options.c
>>>> @@ -561,10 +561,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>>>                                 "capability 'return-path'");
>>>>                return false;
>>>>            }
>>>> -
>>>> -        /* Disable this capability until it's implemented */
>>>> -        error_setg(errp, "'precopy-initial-data' is not implemented yet");
>>>> -        return false;
>>>>        }
>>> I'm always confused why we need this and not having this squashed into
>>> patch 1 (or say, never have these lines).
>>>
>>> The only thing it matters is when someone backports patch 1 but not
>>> backport the rest of the patches.  But that's really, really weird already
>>> as a backporter doing that, and I doubt its happening.
>>>
>>> Neither should we merge patch 1 without merging follow up patches to
>>> master, as we should just always merge the whole feature or just keep
>>> reworking on the list.
>>>
>>> I'd like to know if I missed something else..
>> There are also git bisect considerations.
>> This practice is useful for git bisect for features that are enabled by
>> default, so you won't mistakenly run "half a feature" if you do bisect.
>> But here the capability must be manually enabled, so maybe it's not that
>> useful in this case.
>>
>> I like it for the sake of good order, so this capability can't be enabled
>> before it's fully implemented (even if it's unlikely that someone would do
>> that).
> Right.  I was kind of thinking someone bisecting such feature will always
> make sure to start from the last commit got merged, but I see your point as
> a general concept.
>
> One slightly better way to not add something and remove again is, we can
> introduce migrate_precopy_initial_data() in patch 2, returning constantly
> false, then we can put patch 1 (qapi interface) to be after current patch
> 2, where you allow migrate_precopy_initial_data() to start return true.  It
> saves a few lines to remove, and also one specific patch explicitly
> removing it.  But I think fundamentally it's similar indeed.
>
> In case you'd like to keep this as is, feel free to add:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

I think I will keep it as is, it seems more natural to me.
However, if someone insists then I don't mind changing it.

Thanks!


