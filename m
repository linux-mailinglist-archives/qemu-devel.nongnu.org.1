Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4B71093E
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:52:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27dg-0002iN-Jn; Thu, 25 May 2023 05:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q27de-0002i6-AR
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:52:06 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q27dY-0000kh-1e
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:52:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjqpZ4BQexDkkJtxyROFQdx2gQPbatcsI6LYJhEQHaqvu08IyNKKQqgJM5EDq/aVjBlaM12yNaUayrm8wVHb3H8cqq+YGMCYHZx5v0OJ6Hp72fl9DCJsWYMag2W4LVWljmhCq+L/MExBt7qbL3a+rKbVD0gJzpm6SOdeGL7TYsFGY/tw+pH9kqN5oH1MnhgKOFvUSiTW0SYCM8caw+L4VoPq0ENlrPn7nEfBGxxijAMB5LmHl5J5NqbYi7DZQuZhAABfK59mT55ikBildmXD//zexJ630RgMdA5rnT/oTKQDa5I/0lygIuo2dzRuyFW2prBc9f9aNCQjMwLfuLldbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcxcImIbCL/AGgqLGwvw3lUZvvJ9lfUaiOlocvkzDxc=;
 b=V/pah7ZaW3qi0RS00svxDPngX2EpQVyN6V4VTNQDL+YWrzkuVDEj38Zx20NovgxtVudw+WDpDbU/Z57XQgcarP1wakzKmJRUpG59Z86QKHUztiZd1ugk/KFakD5ygIxioRVXLoJWX2npf/8nCa3ED+Snu55KmPdF+TtKjDs0u4H0NFa7646+4AhpVabhG4MQNY0FosB/QgC/ydOUE7ubHTA9neHnzDcqznUx3tI9FCQYJLGxTQTNThvVlEnng3NXxVa+iGG+ebCZPvNOLfh/i4QpW9sCoGne5nIgJPUDNBGNM2LrPh4e+/1+PsZKXeC/TaKlb62FAQZuUCzwuGoJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcxcImIbCL/AGgqLGwvw3lUZvvJ9lfUaiOlocvkzDxc=;
 b=TWzbnAerUz8vhD+dffsO0lZXOiCd2JF2O+MvCSmydmt8j1xXqIk221IFs9bpAZsyAeL6FL74xATgAJayDEUqbtxcFg7Yjth2BtKHgq1lHwlcsXyttD5XAAYIy0xLTGK34P1c+yzo/BuoYhDIF7ehRKApaWz1ZF4K8hbp3G6l49AA+4dvrTm3hR2OZ5PqN4PYOvahvHNsE5/AdLct/7vuqiTik45KJCseA9p3z9uia46sqeOdgsZ2CRQUJ6aIlA6EAUEIVdWriNFBxDvROxn7p7HiDyx9/dsK9rCIBUgvdLxHPtfs6oHCV5TlXWU3lyUv1LMYOgdsi7h/4XhdA2mS9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 09:51:56 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 09:51:56 +0000
Message-ID: <541dc36f-618e-a2c5-a27f-51db65abecbd@nvidia.com>
Date: Thu, 25 May 2023 12:51:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] migration: Implement switchover ack logic
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
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-3-avihaih@nvidia.com> <ZG5mOKlGtQEyywyQ@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZG5mOKlGtQEyywyQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0357.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::22) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 16671132-4e89-400a-bef7-08db5d05ac88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQ9c2FoGdXh5uueQiVJO/OAQe0MIv+90maAkR4YH4tQv6Oz7piczxWrE3pG1/DMR81Pi46lsaIOuRjp2nMrNsM0mV6oE0rw7IIRMS7u9bsAag+klk5F3/VWFBQgQc5C3c01PGYVYn5EJnl05rH/Ze1L+EcJrsphLT/66wz4SfWx1aET8ya83/iCbzYII72UShJI5TZ4J2qSbJp0+kCkE1o9QjZpIJYLDUCxgHGhw91FRyAfWFHXtw/h8aaqKITEUCMb2ii9imJYpxUNKnZc60FCicYbrlnpYhFKjwI90V0uhYY6GmCEOa4y6ogEGwpUIHJvD8pNoWBgG7wL+elesShFW8qsDiNH+fw35USYv5pjIjemlQ57HOlaUV2hbmKT4W5gCF1BOw7kQLZMppFcvaUi9UAJ0d90hjmcg2cjasmZwE1zP7DbsurP9294QwsnIXHfrcnWzs8VTxi+ZEX3V3syj2SGWNKDkVd6jDSAJfRwipl1FMPgv2R6pAVU+Az9b2eQq/Ly06tCrT653d/NRE6YvDeuoOtVEyZwLk7hfPPiyTr2556Ay67u9tfQIHmYZVSZEwUwkYJVIQvK6JjrstWN6H6Y1hDPeBPSXUBnRq+0JxrptdaP4NTxoAwTAYnNhgyj+SAf8av4WwyWIYBlaRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(41300700001)(4326008)(6916009)(31686004)(66946007)(66556008)(8676002)(8936002)(66476007)(36756003)(54906003)(31696002)(6666004)(478600001)(86362001)(6486002)(316002)(5660300002)(7416002)(2906002)(30864003)(186003)(53546011)(38100700002)(2616005)(83380400001)(6512007)(6506007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJNZTBrL0JMZk1sQlpOMEdqa2U2QWtJQTlxdnl0SnpXTndkMXREVmx4c0Y2?=
 =?utf-8?B?MkYrUFh3Sy9OVTdaUTloNEFwUDJJdHJhTm5YT2taNkFSdnN3enI5a2VnSVZG?=
 =?utf-8?B?V3JQdDVsUU1lajZpazZsU0ZmUCtPUTNpN09ab0VFREt5cGxzY0diUUYzYlZT?=
 =?utf-8?B?WXlJZDM3djJqYzRhc3JwQURoYW16eCswM0RFbnBWRXlscXNDN0Znc2FQK05n?=
 =?utf-8?B?Y2tQL2NPRXFZZG1weDgwN2hFVGlBN3p0OXhiTGZzSkRSeWlCRTRQQnFNbGFh?=
 =?utf-8?B?V3BuWmhhd0ljVkJqRnJSNzFna0h0dkFhZGpNQlZrRVBHekdkMVFGMWxVcGFS?=
 =?utf-8?B?d0hsUTJvR09WdXBXNnR0a0JRaitOa1UxektUcGxQckZVWWRFekxxTFdldzNK?=
 =?utf-8?B?ejlsVUZQSW5VMHFJVTZhUThpQ2tYT1hzUjdXS09sQUh5elpsOU1UTWE3cTVE?=
 =?utf-8?B?ak5ObDZpRG9QSGRMOStyUGxFa1N0Q3Z3MzRyQW5TZGtYai9CblFYMWlET3RY?=
 =?utf-8?B?eWxuRzRmT0Ezd0ozRlBGVEtHOURISERPTTJsU1Vob3VabkpyWndodlZ3b3pB?=
 =?utf-8?B?cXdsRWVDQ0NHR3RLS25qa3VTS2REN1A0QWhFMUlRYkFaVk1BQWpyblZzU2l0?=
 =?utf-8?B?RWlQaTlMTS9xNjhUckFlQ1QxTXljRklkbUg2L3RnZ2pINU9IOURXY0tITlpM?=
 =?utf-8?B?T2VJcHU0TnJSZGpyNUhMT21XQ0hLaDhoYnMwb3JIRUs3UTRjOGFtYnhuSWlM?=
 =?utf-8?B?UDhoWlB2eVd0OGFReHJPTmtoK3BzTS9KMjE1MGFPbk9FQy8vK0VJbGt4WjFQ?=
 =?utf-8?B?WjN2WEZqWG1RK3o1M1V4Q3RTaGtYUXRiT3E0UG9kbTN5VUhpWmhyQkErdGNz?=
 =?utf-8?B?Y2FPZk9VVVBpUW1BNENNaDRLUUtMR09GbmNpWVVtTWJzUVBTVXArQ0l5TXk3?=
 =?utf-8?B?a3VlcGtMNGZSTWFJaEJNc0NQSnEzNSsybVV3eVJtL3lodCtyWnkxMk5nMmR1?=
 =?utf-8?B?VjRoK1laTmNXbzRXMTE2NWpDd2pEZXFPUmFvKzhId0VCczVRdk1NWStqWTQv?=
 =?utf-8?B?NlNBU2szVmhBNXVyS2tDbTQ5SWdlQW9Ia0dlUmxJZy9VbWZtWDVtQXp6NFZJ?=
 =?utf-8?B?clUyb1E2WnpnVnpwcGJ5VzlRSjRDRk5ONkJxemRIcTgxTkwxWE9xRC9wVlZ6?=
 =?utf-8?B?THhOVFBFbi9WOFRrTkhPeHhGUGFyN2ttajFyQmg3bmNYWEZuMmpvZENwdWQx?=
 =?utf-8?B?QjNiZWpwc3ZvS2pQT0phL0h4SU96TlM2NzcxaWcvaU51Q1VVWFl0Z0RpNWpC?=
 =?utf-8?B?Tm5pUE1SVzhqSkxMMDNEOEl5TUxaQllqdEZnWnlWM1VseE5kQmV3RlpDZ1VZ?=
 =?utf-8?B?Zktjak9pWVluOHQrcnpuMjhVeGMrdlFteUNoM3MvU2pGOG8wRE45SmtSZkNw?=
 =?utf-8?B?K2hFa0lYTmRvUUpXdkMvZkFUbzl3Q2RnNzg0SjVwcGpSS1IyZGdlL1dhOWRI?=
 =?utf-8?B?VFlFRWlTTitMOExtOXBxbk5lVnJsV2hwTTdnZENsZmhYUmordE5DVEsrMU9w?=
 =?utf-8?B?cVVZcE9rUTlkcjdtRmdVUTdXakJUSWNMckxuNnBNM1ZCR0YzQVdEMng3ZFYz?=
 =?utf-8?B?bWcxalY0aWJnVXhrT3hoVHVLUDRKNERQWWdlclFBL1JoRWptL29rRkZMWmRo?=
 =?utf-8?B?bk9PbFpxSFNSMFZHWFZtN1pCVTBaVFlTMG1nd2s1SGpqZEdGZ0ZsYVM4L1FE?=
 =?utf-8?B?c2kvK0dteUxERWluYld1VzR2eHB6cDhDckJqTVYzN3dqeS8yaTlONkRTYUVo?=
 =?utf-8?B?anYyM2tNdkZxR3FiVXUxUitYRHNEVDhzbHE2QnFjWWhMNWZpZWt2MVZGdFJj?=
 =?utf-8?B?bXkyT2lvbmZ0dGhxaFAvMm5nLy9XeUhZc2J0bFZWNnVUV3h6YjZnOTg0Rksw?=
 =?utf-8?B?OHQxdkRyTVowTytmM0Zwa3lnTjBCSllsSFNzb1dGK3ZvSlQvNzA1Q1EyYzV1?=
 =?utf-8?B?TmlkRGZUaGNDWnh4a2MxaXl3M01aN1YwaDA1LzVBTGhBZWZ2RzJuVk0xSTFU?=
 =?utf-8?B?alVUUnI4aFVMTTBqNHpWT2NVdlowdzR3b3FQdE1ZMnRUUWVCSUpmOGVCQ1dz?=
 =?utf-8?Q?700PPlefRlWdtKVrcVQB9Bte8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16671132-4e89-400a-bef7-08db5d05ac88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 09:51:55.6898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeCV8CCA7XzQwee5L+X/zDeHMQURjatOEAQwBmLCwI+xTdpX9yCliYviDGOgk6ioLntwIZXALYPKL1Qez+esuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, NICE_REPLY_A=-0.107, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


On 24/05/2023 22:32, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, May 21, 2023 at 06:18:03PM +0300, Avihai Horon wrote:
>> Implement switchover ack logic. This prevents the source from stopping
>> the VM and completing the migration until an ACK is received from the
>> destination that it's OK to do so.
>>
>> To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
>> and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.
>>
>> The switchover_ack_needed() handler is called during migration setup
>> both in the source and the destination to check if switchover ack is
>> used by the migrated device.
>>
>> When switchover is approved by all migrated devices in the destination
>> that support this capability, the MIG_RP_MSG_INITIAL_DATA_LOADED_ACK
> s/MIG_RP_MSG_INITIAL_DATA_LOADED_ACK/MIG_RP_MSG_SWITCHOVER_ACK/

Will change.

>
>> return path message is sent to the source to notify it that it's OK to
>> do switchover.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/migration/register.h |  3 ++
>>   migration/migration.h        | 16 +++++++++++
>>   migration/savevm.h           |  2 ++
>>   migration/migration.c        | 42 +++++++++++++++++++++++++--
>>   migration/savevm.c           | 56 ++++++++++++++++++++++++++++++++++++
>>   migration/trace-events       |  4 +++
>>   6 files changed, 121 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index a8dfd8fefd..cda36d377b 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -71,6 +71,9 @@ typedef struct SaveVMHandlers {
>>       int (*load_cleanup)(void *opaque);
>>       /* Called when postcopy migration wants to resume from failure */
>>       int (*resume_prepare)(MigrationState *s, void *opaque);
>> +
>> +    /* Checks if switchover ack should be used. Called both in src and dest */
>> +    bool (*switchover_ack_needed)(void *opaque);
> Sorry if I'm going to suggest something that overwrites what I
> suggested.. :( Luckily, not so much.
>
> When I read the new series I just noticed maybe it's still better to only
> use this on dst, and always do the ACK.
>
> The problem is based on your patch 1 description, the RP ACK message will
> be sent if the switchover-ack cap is set, but actually it's conditionally
> in the current impl just to handle num==0 case, so either the impl needs
> change or the desc needs change.
>
> It turns out it'll be even cleaner to always send it.  If so..
>
>>   } SaveVMHandlers;
>>
>>   int register_savevm_live(const char *idstr,
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 48a46123a0..e209860cce 100644
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
>> @@ -437,6 +444,14 @@ struct MigrationState {
>>
>>       /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>>       JSONWriter *vmdesc;
>> +
>> +    /* Number of devices that use switchover ack capability */
>> +    unsigned int switchover_ack_user_num;
> ... we save this field, then...
>
>> +    /*
>> +     * Indicates whether an ACK from the destination that it's OK to do
>> +     * switchover has been received.
>> +     */
>> +    bool switchover_acked;
>>   };
>>
>>   void migrate_set_state(int *state, int old_state, int new_state);
>> @@ -477,6 +492,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>>   void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>                                    char *block_name);
>>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>> +int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
>>
>>   void dirty_bitmap_mig_before_vm_start(void);
>>   void dirty_bitmap_mig_cancel_outgoing(void);
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index fb636735f0..5c3e1a026b 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -32,6 +32,7 @@
>>   bool qemu_savevm_state_blocked(Error **errp);
>>   void qemu_savevm_non_migratable_list(strList **reasons);
>>   void qemu_savevm_state_setup(QEMUFile *f);
>> +void qemu_savevm_state_switchover_ack_needed(MigrationState *ms);
>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>   void qemu_savevm_state_header(QEMUFile *f);
>> @@ -65,6 +66,7 @@ int qemu_loadvm_state(QEMUFile *f);
>>   void qemu_loadvm_state_cleanup(void);
>>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>>   int qemu_load_device_state(QEMUFile *f);
>> +int qemu_loadvm_approve_switchover(void);
>>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>           bool in_postcopy, bool inactivate_disks);
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5de7f734b9..87423ec30c 100644
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
>> @@ -1405,6 +1411,8 @@ void migrate_init(MigrationState *s)
>>       s->vm_was_running = false;
>>       s->iteration_initial_bytes = 0;
>>       s->threshold_size = 0;
>> +    s->switchover_ack_user_num = 0;
>> +    s->switchover_acked = false;
>>   }
>>
>>   int migrate_add_blocker_internal(Error *reason, Error **errp)
>> @@ -1721,6 +1729,7 @@ static struct rp_cmd_args {
>>       [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
>>       [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>>       [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
>> +    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
>>       [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>>   };
>>
>> @@ -1959,6 +1968,11 @@ retry:
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
>> @@ -2700,6 +2714,25 @@ static void migration_update_counters(MigrationState *s,
>>                                 bandwidth, s->threshold_size);
>>   }
>>
>> +static bool migration_can_switchover(MigrationState *s)
>> +{
>> +    if (!migrate_switchover_ack()) {
>> +        return true;
>> +    }
>> +
>> +    /* Switchover ack was enabled but no device uses it */
>> +    if (!s->switchover_ack_user_num) {
>> +        return true;
>> +    }
> ... we drop this, then...
>
>> +
>> +    /* No reason to wait for switchover ACK if VM is stopped */
>> +    if (!runstate_is_running()) {
>> +        return true;
>> +    }
>> +
>> +    return s->switchover_acked;
>> +}
>> +
>>   /* Migration thread iteration status */
>>   typedef enum {
>>       MIG_ITERATE_RESUME,         /* Resume current iteration */
>> @@ -2715,6 +2748,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>   {
>>       uint64_t must_precopy, can_postcopy;
>>       bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
>> +    bool can_switchover = migration_can_switchover(s);
>>
>>       qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>>       uint64_t pending_size = must_precopy + can_postcopy;
>> @@ -2727,14 +2761,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
>> @@ -2959,6 +2993,10 @@ static void *migration_thread(void *opaque)
>>
>>       qemu_savevm_state_setup(s->to_dst_file);
>>
>> +    if (migrate_switchover_ack()) {
>> +        qemu_savevm_state_switchover_ack_needed(s);
>> +    }
> ... we also drop this, then...
>
>> +
>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                  MIGRATION_STATUS_ACTIVE);
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 03795ce8dc..9482b1ff27 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1233,6 +1233,23 @@ bool qemu_savevm_state_guest_unplug_pending(void)
>>       return false;
>>   }
>>
>> +void qemu_savevm_state_switchover_ack_needed(MigrationState *ms)
>> +{
>> +    SaveStateEntry *se;
>> +
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (!se->ops || !se->ops->switchover_ack_needed) {
>> +            continue;
>> +        }
>> +
>> +        if (se->ops->switchover_ack_needed(se->opaque)) {
>> +            ms->switchover_ack_user_num++;
>> +        }
>> +    }
>> +
>> +    trace_savevm_state_switchover_ack_needed(ms->switchover_ack_user_num);
>> +}
> ... we also drop this, then...
>
>> +
>>   void qemu_savevm_state_setup(QEMUFile *f)
>>   {
>>       MigrationState *ms = migrate_get_current();
>> @@ -2586,6 +2603,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
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
>> @@ -2789,6 +2823,10 @@ int qemu_loadvm_state(QEMUFile *f)
>>           return -EINVAL;
>>       }
>>
>> +    if (migrate_switchover_ack()) {
>> +        qemu_loadvm_state_switchover_ack_needed(mis);

[1]

> ... here, we send ACK msg if num==0.
>
> So we (1) make the wire protocol clearer (ACK must be there if cap set),
> then (2) drop a bunch of code too.  Actually we also make the code clearer
> too on src.
>
> What do you think?

I really like this idea! It simplifies things even more.

However, there is one issue -- we can't send the ACK up here [1], as at 
that point the return path has not been created yet.
A possible solution is to check for mis->switchover_ack_pending_num == 0 
when we create the return path and send the ACK there.
It's not as clean as checking the number of users and ACKing here in the 
same place, but it works.

Do you think it's OK? or do you have another idea?

Thanks!

>
> Other than that this looks very good to me.
>
>> +    }
>> +
>>       cpu_synchronize_all_pre_loadvm();
>>
>>       ret = qemu_loadvm_state_main(f, mis);
>> @@ -2862,6 +2900,24 @@ int qemu_load_device_state(QEMUFile *f)
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
>> index cdaef7a1ea..c52b429b28 100644
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
>> @@ -39,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
>>   savevm_send_colo_enable(void) ""
>>   savevm_send_recv_bitmap(char *name) "%s"
>>   savevm_state_setup(void) ""
>> +savevm_state_switchover_ack_needed(unsigned int switchover_ack_user_num) "Switchover ack user num=%u"
>>   savevm_state_resume_prepare(void) ""
>>   savevm_state_header(void) ""
>>   savevm_state_iterate(void) ""
>> @@ -180,6 +183,7 @@ source_return_path_thread_loop_top(void) ""
>>   source_return_path_thread_pong(uint32_t val) "0x%x"
>>   source_return_path_thread_shut(uint32_t val) "0x%x"
>>   source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>> +source_return_path_thread_switchover_acked(void) ""
>>   migration_thread_low_pending(uint64_t pending) "%" PRIu64
>>   migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>>   process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>> --
>> 2.26.3
>>
> --
> Peter Xu
>

