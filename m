Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9978C98A
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1TA-00078L-6Z; Tue, 29 Aug 2023 12:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qb1Sk-000774-IS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:21:11 -0400
Received: from mail-bn8nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::614]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qb1Se-0005bX-EZ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmfqPFfEctSnFoLymY3SgDuJJ6uB47h+SCW9DhiwGSlUwLtikIyI5SxsD/5St0E9U8EqtvkBniARwYD+0pOJWDseUEpG+YCqYnqUfGKOQ0s5ci+m6mKHaHpJ5kHKWsQCy3M3NqFjLrcyIq2KM4lA5hHy6YPccxZdrCaUoi4H56wxCizis/JfO3Nei00ekCHOp3SfQ81bDr03mNY5/jHyskq4ctcd7616jxxr5+1tbYCabwTuKF7pYWeW3WHd/LYao+AdxRdnRb53kanxMCK+ZdmXKh4hdnIklo7hLAArWefePb0OjO5PdOeY1H/EPwmzMINWY0QaFsqR61+tA+543w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A+imjilwE1Zxm2tOFle+4Y5kW5nD3WwyXHzRzMxspg=;
 b=cYlxgxCk/rtK1wIOixurSNU6jWbRQALr2eTo6LN2evi1cPy9nn+7R8KrtqYmruyUuHVuRpVPtNXIzA55fJT4gPGBIUESEhZaB248VVH3mdptjy4mUcnzRdqOWptePmXfQ6QGc7L0NQ6hVOTJN7M7N8ySfIMJfT+eig8MG+lSqPGoAvHMKCLEa34XDJHk9OTQbh6nP9JlOWOxTXCeSm14ke9Vc0JYJGlJUKfTbJOoVrAkj/YoKIxFIFegXBWlDEj5TgzPTdWCzmfT+WExVv2UK5iKV4nWTpqE4MGQuHho4KbmkUkNxLfZx2J31C7eHcueabaSuZYS7YjkhGHB0j6FZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A+imjilwE1Zxm2tOFle+4Y5kW5nD3WwyXHzRzMxspg=;
 b=rgNdypNHDBoGQIgQHuTh6zA2PqptOB+Zk7eigk0YpnUREnSn+jCafkuqfGJA+YiXfYIvM6x0K/nUZ8WZtmhhnTWU6YjQicfASgzTY6b5Xxh4+pefg5f+blETeLtnFeXR+zskxhdOn5QfiOxWlESnWiWOLJRs6QYcs+0DjNOV0+gRGAPhavgAASMCchHN3/1mzDINhgNoH2/AffYTFZ3nWdjAQU3/5cZUcTyA/yIuA8jFu3sDgK7aq1ey+gkePQIjUKId1kHp/pB6Mv8JVGMl7AxjbKAl4zHDxVu9UXdhGlwOTMHwXwqTv+CuEJ7CjOwVJSrubJ0quKIN9dgYeM24hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:20:55 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:20:55 +0000
Message-ID: <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com>
Date: Tue, 29 Aug 2023 19:20:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZO4GTnuqSORbvePL@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0048.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::37) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 695170de-0c84-4c04-d46b-08dba8abec08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ww6ld+xv87AFSYOGscgYhKRUolYfQdby52mAotnClA40HM/Xp0d6G2IA4ZcuFlLSZtKGzbJLCkIm8fe8w+/Ui5lfDNKHTK8qnOljII0tof4xrW/WAvrzvgjnZga1orz7RPawxrluvSIYvSrej1VyPu6ObpL7PRky2syjf6r15YUwG4jgWkOpDZ7ZozC5V1+sYQwwvx5oKRSGIYWNlx3jrhGH15XARHGrKmb68Q4BiwgCVgsN16gJ5RAKXI7gfp7jcmkR+FPbhKL297VWy5wXZULP7N+yf5x7HDVyxw5mg0qfOCxgPR0dZWy16RHEp9Lg29sqZRGEg78+SKD9gHbSlCfWRAcTuthfG2mRjpvK5l3jH12+IvV3JE1PqDkqhO8ut43jV60aKD2IcEeVSjR2YeLU2L+5cEeFuEFgbAqkFfDUbv0grUzYYLeAgddRFLEvsbZ0UFTJvqAC/M8r5IM0qn1tYxWdK/rbhSngXt/1I1DnnIQKBZxM5bv1EW0VYPw3p4t1oPpEk5S8ogxto1D2j7k8AfaagnWRWB85CYXI63QARbVuvZ3kjgYa4SyFDs+STrn17s0hPwp49++5MDFZdmajayKYgRwPGTY4C6lX/XuoemQ4Acbxq4K0dPc0B/B2Ox02N97oDolbrP3xfRzTNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(186009)(451199024)(1800799009)(6512007)(6486002)(6506007)(6666004)(53546011)(478600001)(83380400001)(2906002)(26005)(54906003)(2616005)(6916009)(316002)(66476007)(8936002)(66946007)(41300700001)(66556008)(5660300002)(8676002)(4326008)(86362001)(36756003)(38100700002)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFBQU1RWWNYZVVXMkgzSzhOaysxV09VU3FRdmY0c3ZvRGw5VWlWMTdldnNk?=
 =?utf-8?B?a0UxNUMyQTl5SUxGdkVIamFoTisyTDMxekJxUDcrTzhMNDlWYUZsTFVvS25Z?=
 =?utf-8?B?VW45QzdreFh1RFRrNXQ4djA4SUhmU1FqdUpuUDVYV2lPTnpqNlVITUg2c1ZX?=
 =?utf-8?B?ekJpekhHOGt1dnloajVTNmpNQjNXRHJKK3p4SFdMMjZWTmp1T1BlOThZNTNu?=
 =?utf-8?B?NTZ6b1A4SmpVZGw5Wlp2NWtOTmVHN05TOS9ya3JwL0RHYzBvWFJCMUR2WXBy?=
 =?utf-8?B?RjA1djZrcWVnSHVXRDZ6aElOdEVuSUZFdnpvem15cy9Cbmg1d1I0TzFnOVZp?=
 =?utf-8?B?cFlrbnFWYW5OTlk2LzhvYWpTRWZONzJTT3VvL2pXUXc4MzBNNG5RSk1hSWR3?=
 =?utf-8?B?UzNKU3FaRzljNUV6bytadWl2emxOa24wNkZjTXo3bFRvbzlWeHY2SklsL2Y0?=
 =?utf-8?B?R3d0Y0RwR1RDVnNuZWsySWtYWDJYbkZheCtHRWJ6TFhKUDE1UWIzU0NWcnRl?=
 =?utf-8?B?YTU1NmFZVDVTWW40S3ljendqSzY0dnV0MHRUK2M0U3NlL2hlMW1oNXcvUlZx?=
 =?utf-8?B?cmZuaGtUZkVDakxFUkNqNXhzNTUzblFjK0Jkb2p6OTZ5ZVZIeXdTRHVuSVY5?=
 =?utf-8?B?N1BOQkJhUmFIWVFEbnFUbEw5RjdUbWN6SGtMVVg5NHQvWjhzWmZsc3hIOVV3?=
 =?utf-8?B?dDRwdkV3OUk0TmVkSEwvNGhmSXFjL1Fnekwyd2EwaWJFWjF2M2EzbkJkQUIy?=
 =?utf-8?B?RmI1ajNNUm5lSG1uVzQ1dzMxNWVKV1plY0VwN3lTN0ZOd0JHRjZKRFZRbDcz?=
 =?utf-8?B?VmN0OG5GQkdySzYwbWh1SjZiRy81VklJd0hQWGd4V2dzckZZT2k3a0ttMTVZ?=
 =?utf-8?B?OU4vT3R0TW1VY1IwQUpBZVdYVnBFV0htUEF1cmFmREQ0N0k2ZE9MVThMcXRa?=
 =?utf-8?B?bGRWNHRLeDBCTGZHQWlmMUErZzNZNTBWYXNTRTROZGM3Z2ZOcjgzdWhSVjU1?=
 =?utf-8?B?ZHdmbHI1TkVjeGJkcHdHSTZrNnZzZlNLMGhwV0tzQlcrUUNaVkF0SFgyZUtL?=
 =?utf-8?B?ZHhnV2ZrTzZXdWhvYkJZOHJlRUxTazNNWVlKdmt1MmxsQnUzSitKdkFpUlY2?=
 =?utf-8?B?TDdvRjBySDYzRWtobVJMNE1VNWovNUNUZ255akI5bE5hMXlXR1cwaUdkZ0xp?=
 =?utf-8?B?UGdtQmpFME9zaTk0b1FJaVBUbFczUmM3cEx2ZjNvNXlNa1lYQVE3UXVwbTMx?=
 =?utf-8?B?ZklhRDAwTWVvTWtINjZZRmFWdDRrZkFzRFIyWW84bld4N0JBSVY3MWlPay8w?=
 =?utf-8?B?Z2hrdTJUZkVwWEdzMW9Kak5mNkRSeXZpeXdUK2dKL3BMS09PQWJYRVhXRmht?=
 =?utf-8?B?Zmp6WlZMQ24yZk5lU2V3NlQwVkNTcjJSMStMZEgrRG9nN0hhL1lKMDFRNSs3?=
 =?utf-8?B?cElJWVlvQm9yRFVjbC9PdTVQTmMwT01mc0lLZ1dtWCtsWkZJeW56bjc5alhC?=
 =?utf-8?B?WEd3dG1YS3JIMkZwMi9LV05xazlYNHpJTWwvNU1ja1N2M1l0dGlxWTF4NlNB?=
 =?utf-8?B?NFl0WDJLeVp4ZHEzWXFyZnI5ZWx2SHk3N0wzTE9rUTB0OG85WHdpQ0xqSkZm?=
 =?utf-8?B?Q2ZSZncveVIwd2o4SWRPYS96TlE4ZGRrRURuYVEvTW9aOHM2RUlmbUlqNGJG?=
 =?utf-8?B?R2ZyR0xZVkdtZ1dpSEx6SjJXNExGMmxBa09vYmlVam9BNllLQk1sZ0o4WHRQ?=
 =?utf-8?B?SzZGQU8reU40VklxbWVadTVwZnF3eGZWQUVFdktzT0hVYTZLK25sS1h1aGVN?=
 =?utf-8?B?NmhkaWJxZWVhb1dUYnp3K2doZXRBWEtobmpNVVdya1VoYTVkUk55Zlg5UGI3?=
 =?utf-8?B?RThZOXpNSnYycnZwSnZhQ3daaFA2LzE1K2hVM1ZLMWJGQVNNaU12R1MvU1Rm?=
 =?utf-8?B?cnNhSlpuUVRYTVZXNUo4dzROcGJ1aTliKy9rUzBET0U0ZUZGYTJ6bU9xbHBh?=
 =?utf-8?B?c0loMzNERCsrejEwYnNvS0dUUThTRko4T3haNmFFUFdBSVRYTE0rNi9ZVW5U?=
 =?utf-8?B?eUp3UEpPOEYyLyt1VzlKT0ZQUldQZXhyU2dTKzlteExHWm40akdtRGZSUjJp?=
 =?utf-8?Q?pcauuX6T3f11Nd1UJafleqCmG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695170de-0c84-4c04-d46b-08dba8abec08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:20:55.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+a4yl/+PYFOISPQFVwNWCgsRBf97foQhfOBZmyeElFmJQFDU2LNViSMumEsuoVAQtfD3sucLv7OeSZD67XT+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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


On 29/08/2023 17:53, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>> diff --git a/migration/options.c b/migration/options.c
>> index 1d1e1321b0..e201053563 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>               error_setg(errp, "Postcopy is not yet compatible with multifd");
>>               return false;
>>           }
>> +
>> +        if (migration_vfio_mig_active()) {
>> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
>> +            return false;
>> +        }
> Hmm.. this will add yet another vfio hard-coded line into migration/..
>
> What will happen if the vfio device is hot plugged after enabling
> postcopy-ram here?

In that case a migration blocker will be added.

>
> Is it possible to do it in a generic way?

What comes to my mind is to let devices register a handler for a "caps 
change" notification and allow them to object.
But maybe that's a bit of an overkill.

>
> I was thinking the only unified place to do such check is when migration
> starts, as long as we switch to SETUP all caps are locked and doesn't allow
> any change until it finishes or fails.
>
> So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
> to fail the whole migration early?  For example, maybe we should have an
> Error** passed in, then if it fails it calls migrate_set_error, so
> reflected in query-migrate later too.

Yes, I think this could work and it will simplify things because we 
could also drop the VFIO migration blockers code.
The downside is that the user will know migration is blocked only when 
he tries to migrate, and migrate_caps_check() will not block setting 
postcopy when a VFIO device is already attached.
I don't have a strong opinion here, so if it's fine by you and everyone 
else, I could change that to what you suggested.

Thanks.


