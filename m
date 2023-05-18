Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869D5707B50
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 09:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzYKK-0000Ms-EF; Thu, 18 May 2023 03:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzYKG-0000Mg-Mb
 for qemu-devel@nongnu.org; Thu, 18 May 2023 03:45:29 -0400
Received: from mail-mw2nam10on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::613]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzYKC-0003Pz-LU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 03:45:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHH/g8b7eL7HMo5vQ7fUMegNBnMencutKR+FzeUDP24Ok+uT5cNxmBm/MvC6fVOLdtU0nAKNvR+J9ezBmmBXsmTvYCrSjY7rlQbrhp/IJeV2oieZNQyi7DehcSIukjS+TiwJHesn8Z/Q47VpCul+Z7nNRHRrSS3/bfcEDqIOBrfDvATXEJyoRmvGuQ1csXzJacrdRaS3smJSDvqyt6+JSJ9/X8llmtu5WYPAqYsl38/POiO4oZQ+70iNttOnM8xd+d2CAB4B/1BuGAyBP2Bxwqr3ONIIfME0qVAGUX0eySvAPr4TQ8qfMj+NdKawkKX/Z6W7u/Ga9rxD3xaMDE4ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5gqtq8ypfT5phYYGUvPKLRhogxUctROE4fhz3pa0bs=;
 b=JJ54sSDCtwnYuE/14A71hF8NII+2NlmWPZJCtoc+2OBNKd2+X6bWrlXkFk3KxzvRlMnYcxp+AKFhJedZZ5G1jMlyi1a+Bee2uDm8wlQWAqgUKbimln9jCtucspR1Kc0kwPcGL/TPcZkBcJC1gW9fd4PidsXilr/Ybr0iemcfqmfSM5kahJrXofUZD5fMs2grCffna7V0DFEumYJTHWGvNQ565axqevwSZl92c3SBmXCqQ4/7x/7IE9aaM1oGRjn13ZZrRQNAxogtXYBjvRw+UA36p6jo9ukqJiHj4fNACIREBP2QF7DYkHazvW0jcO2BsUx1XXf1MRIAEwxb8QgIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5gqtq8ypfT5phYYGUvPKLRhogxUctROE4fhz3pa0bs=;
 b=astJQasDmwmRkU/166rjaDlWUc/+xj8/6MiuoW8vPZZ47hadLQq2uihSQ+FOrZ8W7tc4wjm13FLLYC4v7DTFQc0bzUZWdyO9AZfI5i89esfteSIzSRwqOHjUp4JxsuUZdCkK83wGuFf1hyybvX8qkvzw4WJ3kIutXrlMBTeohyciQkkEkekEAzZl0YzalpUF2eY9bZs/NqUZvB4AYopf0l3v8vxPe+Kj/ZUpKwJbk80k6y1CC+/rK2gLeNXAwAbAqkNetnfj6grMyl/RFwsQnNbUIVbfGlSwW5+ro8y0hgVC/ceCTinlDLKugM+DpE13KliScaCKNq/n3nlkV9+FVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 07:45:18 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 07:45:18 +0000
Message-ID: <e0c65515-aa87-8380-3741-63ddf584249a@nvidia.com>
Date: Thu, 18 May 2023 10:45:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/7] migration: Implement precopy initial data logic
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
 <20230517155219.10691-3-avihaih@nvidia.com> <ZGUDJKKinA07CCP8@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZGUDJKKinA07CCP8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0256.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8d51f8-4255-4b33-e15e-08db5773d333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMpHWlPJ38rtuDXD/Tk7zBbABO+IPGBRkwUl6toujTATAWDeg/8r8QPN6IsRtyR9Z1CcpAT0HW9cb2XoucNzmVyqYdNM3t8aQVrVJIAMKnkrpqvIYX/GA+veL4QfyUSGGo4pHioYC6/MeP5q50tlPEfPs4tiQB36CUUnxOSQqRX6pzuOiQd21OjVHUhkiwUH28+QiXWQ0TukxEep9uzwa3es7VPbOo5a11tcZU2jF4XKtDBggnyOSiW1uDX4aBRSFYxCA3aRcINxdbkG/iEDh3OoLwO1FY0UhOgzY6x3NCD1p7nTwyN3AJUnoQV4ZZQlr3E2xxbz7xSjcvL8FnJrpK6h9QYdWP5e4e/TjgDLVrpO/AJOJ6DPAUIIeQI/jgZvuZxp1A48xRGWwda2J8mjpZSFBSBeaQxJKt13ckHKdearDgV7tEz/qIbWhjbbtZasSEBzqlWSkHhFn4OSj0qo2TL9A5ke9Lw/s/5X4I/95SLXfoqt0w9KNi5sD3dGzhZFwpGf346ZZTeBFwYe2bmE+Lj77xKHpjfKxl+r1GuTZSXKXmwXO1pZl3l61oC9AlA2NMDV/0C2Uku3NpFlFq/89XOwMoe8NiOko0EUObe4mW4GcebGa86jrtZ0UmxLe0xx3MkUVa43O4paIHSnIY20dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(26005)(6512007)(6506007)(53546011)(36756003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(186003)(6486002)(54906003)(7416002)(478600001)(2906002)(30864003)(316002)(31686004)(6916009)(8936002)(4326008)(8676002)(41300700001)(5660300002)(66476007)(66946007)(66556008)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlXd2R4M3pkbHAxTjhvSnpjTmJqTlp1T3pIZXZvZk10YWlaOXpqTXRNMnRX?=
 =?utf-8?B?RHZ6UUx6azlLZEo4U0N1M2E0eG1HU1pqWjR6SlMyNnF5VGJudXZHR2ZlcGYv?=
 =?utf-8?B?RkVuUkVQbDJ5Rk9VRDFEelllNzQwMmFBeVZUNnNBZFNLWm9SYWNXRlEwSWlD?=
 =?utf-8?B?MUpxYzdQVnlZa243djk0QVFtU1AyT29ucXM2YWQreG9CbjBEY0NpQXpTd2hi?=
 =?utf-8?B?UU5hTEhoYUFsVEQ4SVpGdGY2TkFkcTJrTi91a1hQUlF4RTZaN3pLUDZWOFdB?=
 =?utf-8?B?NnpLQk5KU3N1Mk0zazdpRk1yN3htQVU1b2FteFd0Y21RWkxCMkhKVEl0dlBt?=
 =?utf-8?B?d0FUOU1zUDV5TThWVnB1ajVjTUFLYVdXcStBK0ZDeW1IT0pjTFpzRmI0WVZo?=
 =?utf-8?B?cllKVEY2d2tBdEIrSm5xd3BVYnNSNlQxc2FpVkx1bmtjRitzdzNjb1lRSTcy?=
 =?utf-8?B?Y0RCZitkckpWcDdXVDY3cjJtd3hXM0dxb2hTNENZRC9DeThOZEZVaGQwSU5i?=
 =?utf-8?B?dVFnbFBWY1FNQ05hTGh3R2NObHI4N2FFTDZkMEIxdWd2WHNZRitERm4yMTYz?=
 =?utf-8?B?dTlwZHRJYkdHejNaeGZWdnQwcVplTWxwZnZQMUdneVlEeXNxMDVuY0lWQkxs?=
 =?utf-8?B?aDRIbHN6NTduWTFpampqM1o3QWxzZ0Y4MkdpaXdZa1ZNeWJoNFlIWGdEd0JW?=
 =?utf-8?B?Qnd2eFhtRFVjYlZNSC9RQ2VYSnR4R0VncGlFWStKRktEK05wYXRzeWhxUlBn?=
 =?utf-8?B?bnlmMDc1SmRPTEhVdU9IeUk5VSt0MTkvY0MyWlBsRTB0ZFhYM1B6akJWRzJY?=
 =?utf-8?B?U21qUmEzK25nK3AvTW5UMVlKS29rMnBUdWVaRXp0SmUwcjN4QjVWdW5nbk1H?=
 =?utf-8?B?MnJHYmk1YmowaVBIZG8weEdDYU52dXI4TzBlQ3FwSlNTN0hwSVA1R2thMUcy?=
 =?utf-8?B?RnJ0UGlVaVdvQUQ3Qml5VVlBQVptMkFQa0hENHZYSXVpSThPeVFlTlBNN1Zz?=
 =?utf-8?B?VE94dWQ5aUpVcHZHUDZCT1VCVkN5eWFpaENKdU1aV2duVEpyN1g5OG9CM1lO?=
 =?utf-8?B?K2tjZjFHVEJId00yN1h5cjRISEVUQWp6NWxZOVdKNUtLamU0Z0U3NWo5OVJr?=
 =?utf-8?B?eENWeXgwQzFLZllsTjJ0WEwwSzkwT3dtOHRRTDRpQ2t0NDBzMHkvNWp0S3Nv?=
 =?utf-8?B?cEp4ZGx5akRkWlFwaXJvTmRvMytMQjNHQmZoY2QwSG5sNzY5Y1doczQ3NWI2?=
 =?utf-8?B?alllQzVhZ1RPRDRpU29yUXJ6TFBSZ2kxcjVGVWh2MzkwL0FuUVVSTHVMQlNs?=
 =?utf-8?B?SHhzOE84VFFUR3l6anR0ak5kZ2ZVdmdKMEF3MWFXNXk2VkxjcnFCVU1XWXhs?=
 =?utf-8?B?eEFQck5UMGRHOXpqVFRsM3JwcE5RU1o5VFZOQm5wUW5qck5sTkkwZjJSYng4?=
 =?utf-8?B?YjhpUFVTMUtNVWduOERtZEZzRzlQR0t6ai9KR1ErN0RKZVgydTZlKzRyTjNl?=
 =?utf-8?B?c2pYWmdlL0ZMME9pMGJzYTFJYXBkMDZDWEthWnZmUVR5WU5uQUZTWFF6Qk8x?=
 =?utf-8?B?cVVBVC9HYjk1a2dEVXc4bDduTVIyWW9QdFFjNmdUNUROQm9wdXJ4djVZSFl0?=
 =?utf-8?B?MTVYRVA0UUc2dk5CeC9ZRDI2S1lSR0loM0FVZFZmT2wzOWYxZkJ5cFZ1dUp2?=
 =?utf-8?B?TmhYVjdwOElWdGZEdS9qaDJIZEtYa3ozTmZSaXcxWkMrZStPQS9nSXc4ZEZj?=
 =?utf-8?B?enN0b1hydXFiNitCNngwOFZveTBsWHpscHEvYVh1MDFTLy83bmM3ZngweFhZ?=
 =?utf-8?B?MHcyVHJRMDZLYkozdEo3TDFaOUpJSE9QR1l3eDZ3RWxUR1gvRXN5dWFxTUhH?=
 =?utf-8?B?Mkx6Q0hiaS8waWR1bFI5VTUwZ0NPajBKNEFZVUJOc0hzTHlVNzdtTzVQU2lJ?=
 =?utf-8?B?WHhibU9Vc2hEc2d2bFRZZEkvOTVaV28xNjUrVlBLK2Y2aDV6NWVwenE1ZWpB?=
 =?utf-8?B?MnNOQlhWc2N0L0pYR1N6V0hZb3pEcjZNZEpiVjN6Tmg5dy92L1NXRG5rK280?=
 =?utf-8?B?UVF4OGxrbmYrVnRLQUsrQVNCSVBwUHJzdEJoYWNzODVkd244dTl4TE5RQ21s?=
 =?utf-8?Q?5emsC/yOWgJN18stoeaYJeIbA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8d51f8-4255-4b33-e15e-08db5773d333
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:45:18.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +r5cwncloEUJwSPfiPFSKtg8XAmkG4lOHhAbOt2UYlvO38FVkh7FldkQOLIjdoClMisl+zakWQa6GCqQ6FkolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Received-SPF: softfail client-ip=2a01:111:f400:7e89::613;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 17/05/2023 19:39, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, May 17, 2023 at 06:52:14PM +0300, Avihai Horon wrote:
>> Implement precopy initial data logic. This allows migration users in the
>> source to send precopy initial data and the destination to ACK when this
>> data is loaded. Migration will not attempt to stop the source VM and
>> complete the migration until this ACK is received.
>>
>> To achieve this, a new SaveVMHandlers handler initial_data_advise() and
>> a new return path mesage MIG_RP_MSG_INITIAL_DATA_LOADED_ACK are added.
>>
>> The initial_data_advise() handler is called during migration setup both
>> in the source and the destination to advise the migration user that
>> precopy initial data is used, and its return value indicates whether
>> precopy initial data is supported by it.
>>
>> When precopy initial data of all the migration users is loaded in
>> the destination, the MIG_RP_MSG_INITIAL_DATA_LOADED_ACK return path
>> message is sent to the source to notify it.
> This looks much better and easier to digest, thanks a lot.
>
> It does answer one of my question that I wanted to ask on whether both
> sides would know which device will need this feature enabled.  It seems
> both sides are actually in consensus with it, which is great on reducing
> the changeset.  Then it's less controversial on whether we'll need a more
> generic handshake because we simply don't need the per-dev handshake for
> now.
>
> The name is probably prone to change indeed.  Firstly, it's not really
> always on precopy but also for postcopy.  If vfio will supports postcopy in
> the future this feature will also be needed to make sure low downtime
> during switching to postcopy.  I saw that you even changed postcopy for
> this [1] which is definitely good.  So "precopy" in the cap is not proper
> anymore.
>
> How about "switchover-ack"?

Sounds good to me.
It's shorter than "explicit switchover" and maybe more understandable 
even without context.
Plus, the "switchover" terminology is already used in migration, so 
we're not adding a new term here.

>    Then..
>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/migration/register.h |  6 ++++
>>   migration/migration.h        | 14 ++++++++
>>   migration/savevm.h           |  2 ++
>>   migration/migration.c        | 40 ++++++++++++++++++++--
>>   migration/savevm.c           | 65 ++++++++++++++++++++++++++++++++++++
>>   migration/trace-events       |  4 +++
>>   6 files changed, 129 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index a8dfd8fefd..3ac443a55f 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -71,6 +71,12 @@ typedef struct SaveVMHandlers {
>>       int (*load_cleanup)(void *opaque);
>>       /* Called when postcopy migration wants to resume from failure */
>>       int (*resume_prepare)(MigrationState *s, void *opaque);
>> +
>> +    /*
>> +     * Advises that precopy initial data was requested. Returns true if it's
>> +     * supported or false otherwise. Called both in src and dest.
>> +     */
>> +    bool (*initial_data_advise)(void *opaque);
> .. this can be "switchover_ack_needed()".  Ditto below on most of the name
> of variables.

Sure, will change.

>
>>   } SaveVMHandlers;
>>
>>   int register_savevm_live(const char *idstr,
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 7721c7658b..cc4e817939 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -202,6 +202,13 @@ struct MigrationIncomingState {
>>        * contains valid information.
>>        */
>>       QemuMutex page_request_mutex;
>> +
>> +    /*
>> +     * Number of migration users that are waiting for their initial data to be
>> +     * loaded. When this reaches zero an ACK is sent to source. No lock is
>> +     * needed as this field is updated serially.
>> +     */
>> +    unsigned int initial_data_pending_num;
>>   };
>>
>>   MigrationIncomingState *migration_incoming_get_current(void);
>> @@ -430,6 +437,12 @@ struct MigrationState {
>>
>>       /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>>       JSONWriter *vmdesc;
>> +
>> +    /*
>> +     * Indicates whether an ACK that precopy initial data was loaded in
>> +     * destination has been received.
>> +     */
>> +    bool initial_data_loaded_acked;
>>   };
>>
>>   void migrate_set_state(int *state, int old_state, int new_state);
>> @@ -470,6 +483,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>>   void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>                                    char *block_name);
>>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>> +int migrate_send_rp_initial_data_loaded_ack(MigrationIncomingState *mis);
>>
>>   void dirty_bitmap_mig_before_vm_start(void);
>>   void dirty_bitmap_mig_cancel_outgoing(void);
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index fb636735f0..e1d8a2b3b2 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -32,6 +32,7 @@
>>   bool qemu_savevm_state_blocked(Error **errp);
>>   void qemu_savevm_non_migratable_list(strList **reasons);
>>   void qemu_savevm_state_setup(QEMUFile *f);
>> +void qemu_savevm_state_initial_data_advise(MigrationState *ms);
>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>   void qemu_savevm_state_header(QEMUFile *f);
>> @@ -65,6 +66,7 @@ int qemu_loadvm_state(QEMUFile *f);
>>   void qemu_loadvm_state_cleanup(void);
>>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>>   int qemu_load_device_state(QEMUFile *f);
>> +int qemu_loadvm_notify_initial_data_loaded(void);
>>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>           bool in_postcopy, bool inactivate_disks);
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 00d8ba8da0..fdb8592e64 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -78,6 +78,7 @@ enum mig_rp_message_type {
>>       MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
>>       MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>>       MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
>> +    MIG_RP_MSG_INITIAL_DATA_LOADED_ACK, /* Tell source initial data is loaded */
>>
>>       MIG_RP_MSG_MAX
>>   };
>> @@ -780,6 +781,12 @@ bool migration_has_all_channels(void)
>>       return true;
>>   }
>>
>> +int migrate_send_rp_initial_data_loaded_ack(MigrationIncomingState *mis)
>> +{
>> +    return migrate_send_rp_message(mis, MIG_RP_MSG_INITIAL_DATA_LOADED_ACK, 0,
>> +                                   NULL);
>> +}
>> +
>>   /*
>>    * Send a 'SHUT' message on the return channel with the given value
>>    * to indicate that we've finished with the RP.  Non-0 value indicates
>> @@ -1425,6 +1432,7 @@ void migrate_init(MigrationState *s)
>>       s->vm_was_running = false;
>>       s->iteration_initial_bytes = 0;
>>       s->threshold_size = 0;
>> +    s->initial_data_loaded_acked = false;
>>   }
>>
>>   int migrate_add_blocker_internal(Error *reason, Error **errp)
>> @@ -1741,6 +1749,9 @@ static struct rp_cmd_args {
>>       [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
>>       [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>>       [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
>> +    [MIG_RP_MSG_INITIAL_DATA_LOADED_ACK] = { .len = 0,
>> +                                             .name =
>> +                                                 "INITIAL_DATA_LOADED_ACK" },
> Nit: let's just put it in a single line.  If it'll be SWITCHOVER_ACK it's
> even shorter. :)

Sure.

>
>>       [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>>   };
>>
>> @@ -1979,6 +1990,11 @@ retry:
>>               }
>>               break;
>>
>> +        case MIG_RP_MSG_INITIAL_DATA_LOADED_ACK:
>> +            ms->initial_data_loaded_acked = true;
>> +            trace_source_return_path_thread_initial_data_loaded_ack();
>> +            break;
>> +
>>           default:
>>               break;
>>           }
>> @@ -2727,6 +2743,20 @@ static void migration_update_counters(MigrationState *s,
>>                                 bandwidth, s->threshold_size);
>>   }
>>
>> +static bool initial_data_loaded_acked(MigrationState *s)
>> +{
>> +    if (!migrate_precopy_initial_data()) {
>> +        return true;
>> +    }
>> +
>> +    /* No reason to wait for precopy initial data loaded ACK if VM is stopped */
>> +    if (!runstate_is_running()) {
>> +        return true;
>> +    }
> This check may or may not be a problem, as it can become running right away
> after the check.
>
> But I think I get your point here and I think it's fine; it at least means
> the vm stopped for even a while and the user doesn't strictly care super
> lot about downtime.

Yes, exactly.

>
>> +
>> +    return s->initial_data_loaded_acked;
>> +}
>> +
>>   /* Migration thread iteration status */
>>   typedef enum {
>>       MIG_ITERATE_RESUME,         /* Resume current iteration */
>> @@ -2742,6 +2772,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>   {
>>       uint64_t must_precopy, can_postcopy;
>>       bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
>> +    bool initial_data_loaded = initial_data_loaded_acked(s);
>>
>>       qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>>       uint64_t pending_size = must_precopy + can_postcopy;
>> @@ -2754,7 +2785,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>           trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>>       }
>>
>> -    if (!pending_size || pending_size < s->threshold_size) {
>> +    if ((!pending_size || pending_size < s->threshold_size) &&
>> +        initial_data_loaded) {
>>           trace_migration_thread_low_pending(pending_size);
>>           migration_completion(s);
>>           return MIG_ITERATE_BREAK;
>> @@ -2762,7 +2794,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>
>>       /* Still a significant amount to transfer */
>>       if (!in_postcopy && must_precopy <= s->threshold_size &&
>> -        qatomic_read(&s->start_postcopy)) {
>> +        initial_data_loaded && qatomic_read(&s->start_postcopy)) {
> [1]
>
>>           if (postcopy_start(s)) {
>>               error_report("%s: postcopy failed to start", __func__);
>>           }
>> @@ -2986,6 +3018,10 @@ static void *migration_thread(void *opaque)
>>
>>       qemu_savevm_state_setup(s->to_dst_file);
>>
>> +    if (migrate_precopy_initial_data()) {
>> +        qemu_savevm_state_initial_data_advise(s);
>> +    }
>> +
>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                  MIGRATION_STATUS_ACTIVE);
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index e33788343a..c713ace891 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1233,6 +1233,32 @@ bool qemu_savevm_state_guest_unplug_pending(void)
>>       return false;
>>   }
>>
>> +void qemu_savevm_state_initial_data_advise(MigrationState *ms)
>> +{
>> +    SaveStateEntry *se;
>> +    unsigned int supported_num = 0;
>> +
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (!se->ops || !se->ops->initial_data_advise) {
>> +            continue;
>> +        }
>> +
>> +        if (se->ops->initial_data_advise(se->opaque)) {
>> +            supported_num++;
>> +        }
>> +    }
>> +
>> +    if (!supported_num) {
>> +        /*
>> +         * There are no migration users that support precopy initial data. Set
>> +         * initial data loaded acked to true so migration can be completed.
>> +         */
>> +        ms->initial_data_loaded_acked = true;
>> +    }
> This is fine but slightly hackish (e.g. someone would assume we received a
> msg when this var being true, but in this case we just don't need one).
>
> How about remember this "supported_nums" on src too and just check that in
> initial_data_loaded_acked() above?

I see what you mean.
Yes, I will change it.

>
> PS: we should someday have a common object for both src/dst migration which
> will be suitable for variables like this, so all common vars in
> MigrationState and MigrationIncomingState will go there.  Another story.

Oh, cool!

Thanks!

>
>> +
>> +    trace_savevm_state_initial_data_advise(supported_num);
>> +}
>> +
>>   void qemu_savevm_state_setup(QEMUFile *f)
>>   {
>>       MigrationState *ms = migrate_get_current();
>> @@ -2586,6 +2612,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>>       return 0;
>>   }
>>
>> +static void qemu_loadvm_state_initial_data_advise(MigrationIncomingState *mis)
>> +{
>> +    SaveStateEntry *se;
>> +
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (!se->ops || !se->ops->initial_data_advise) {
>> +            continue;
>> +        }
>> +
>> +        if (se->ops->initial_data_advise(se->opaque)) {
>> +            mis->initial_data_pending_num++;
>> +        }
>> +    }
>> +
>> +    trace_loadvm_state_initial_data_advise(mis->initial_data_pending_num);
>> +}
>> +
>>   static int qemu_loadvm_state_setup(QEMUFile *f)
>>   {
>>       SaveStateEntry *se;
>> @@ -2789,6 +2832,10 @@ int qemu_loadvm_state(QEMUFile *f)
>>           return -EINVAL;
>>       }
>>
>> +    if (migrate_precopy_initial_data()) {
>> +        qemu_loadvm_state_initial_data_advise(mis);
>> +    }
>> +
>>       cpu_synchronize_all_pre_loadvm();
>>
>>       ret = qemu_loadvm_state_main(f, mis);
>> @@ -2862,6 +2909,24 @@ int qemu_load_device_state(QEMUFile *f)
>>       return 0;
>>   }
>>
>> +int qemu_loadvm_notify_initial_data_loaded(void)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    if (!mis->initial_data_pending_num) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    mis->initial_data_pending_num--;
>> +    trace_loadvm_notify_initial_data_loaded(mis->initial_data_pending_num);
>> +
>> +    if (mis->initial_data_pending_num) {
>> +        return 0;
>> +    }
>> +
>> +    return migrate_send_rp_initial_data_loaded_ack(mis);
>> +}
>> +
>>   bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>>                     bool has_devices, strList *devices, Error **errp)
>>   {
>> diff --git a/migration/trace-events b/migration/trace-events
>> index f39818c329..807083c0a1 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>>   qemu_loadvm_state_post_main(int ret) "%d"
>>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>>   qemu_savevm_send_packaged(void) ""
>> +loadvm_state_initial_data_advise(unsigned int initial_data_pending_num) "Initial data pending num=%u"
>>   loadvm_state_setup(void) ""
>>   loadvm_state_cleanup(void) ""
>>   loadvm_handle_cmd_packaged(unsigned int length) "%u"
>> @@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
>>   loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
>>   loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>>   loadvm_process_command_ping(uint32_t val) "0x%x"
>> +loadvm_notify_initial_data_loaded(unsigned int initial_data_pending_num) "Initial data pending num=%u"
>>   postcopy_ram_listen_thread_exit(void) ""
>>   postcopy_ram_listen_thread_start(void) ""
>>   qemu_savevm_send_postcopy_advise(void) ""
>> @@ -39,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
>>   savevm_send_colo_enable(void) ""
>>   savevm_send_recv_bitmap(char *name) "%s"
>>   savevm_state_setup(void) ""
>> +savevm_state_initial_data_advise(unsigned int initial_data_supported_num) "Initial data supported num=%u"
>>   savevm_state_resume_prepare(void) ""
>>   savevm_state_header(void) ""
>>   savevm_state_iterate(void) ""
>> @@ -180,6 +183,7 @@ source_return_path_thread_loop_top(void) ""
>>   source_return_path_thread_pong(uint32_t val) "0x%x"
>>   source_return_path_thread_shut(uint32_t val) "0x%x"
>>   source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>> +source_return_path_thread_initial_data_loaded_ack(void) ""
>>   migration_thread_low_pending(uint64_t pending) "%" PRIu64
>>   migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>>   process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>> --
>> 2.26.3
>>
> Thanks,
>
> --
> Peter Xu
>

