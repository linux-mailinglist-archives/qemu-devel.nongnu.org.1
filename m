Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3B7215DD
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 11:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5kCe-0002xv-6R; Sun, 04 Jun 2023 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q5kCV-0002sr-Lt
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 05:39:05 -0400
Received: from mail-mw2nam04on2089.outbound.protection.outlook.com
 ([40.107.101.89] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q5kCS-00037L-Ps
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 05:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoNGO8R9/T4NZ7uGiv2RWRwc6Gvb9G4Yn2nmDhscFhgdSgUYtfyVzrpS3SI8iWV2SqpPhFonueCweEk9gYY2xqGaZjBH/mvPGqa0GluSAfIJhpPjHo1clg9pviQ5tT8CiGl/sowsNApk5r//z69UWQ2WZKLh4bnPVq6wuDW3sDRMJ+nuX8L/iw7mdWgcdry3aXUI15QZYychpKHJjGcdijeNR7+LCs6iJQqxIZRRWkpHSXrf53NNmZLp5kk44aXjj5SESUy4HxaW0U9VgowTF2R6MRWPn46Ifk3zzFKA7RBAU1sMXKxtsdlnyJqJOaKezmhQNbdaLd5ZODCV6Z1RtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qh/BGW6wWc29Y6bjkMDRDH9pJg/jrTMVpVBOwbT8qM=;
 b=JnWxGrUQ7W01RGD0RfUVQODINdqPlULpRN9KHOHEZNdtUQnEiIJ+E2v5+lC9W70o+OJnuKFTYvhiDjjb9BqRwuPnGcAdPEtIsFC4cT4ubye9nksNIBQtSqk0q44V5lW9Dnd9cpX/yCR7mLC2wjMZJbuQMbToPMxO+c4KApzpW0NNUGmDidH5Pz6zS9CzkLPeMOnPTHxG0IfoRLT1JqP4wK8aTHWxfV+vrsLXHvnP8kTAdqoBPK2R1PWhlcfausZPgk+EFvzxKY4g3OSTHIOdUMW3HPFmIQCT5k8/1CZm79sDanSVYA+TKN7wy4OddcDmWx2xY6kDzHg4cdiwOW+ISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qh/BGW6wWc29Y6bjkMDRDH9pJg/jrTMVpVBOwbT8qM=;
 b=oAQ25+kZD+R5BrCmsVP17aawSlYrx2OkMPV9HZ3aVLGea5U6y2jnwJv0s3pfhlnVVdgM/jWQlfuyFbo5EseOqezuRP57qGTLMFaLm2RTiBh9JsQ7iljszNbt0VxBoX1mErtHcMrMMZ5dvtbhmv7lwmtuvvnjILGpnzWb4Cw15+nKnEp3fV4nwpda1CrvNj3nCGatqEtgjm4BqOLj3I0yuZ7EhZl/LiqUkm0dFGPG8Kpo53Rn8UK8QL9fkMDvJPUGMNThTyA35JPSo9KZ6auuXi0AAwOJuPWQwUB/qAl8f4S4hPw71RY0R/tvfRPKyfL0EMu3xUrg8yMhiZ2xpHpSvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 09:33:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 09:33:52 +0000
Message-ID: <c3edcf5c-75c7-df60-8782-8cc9a8a31ccf@nvidia.com>
Date: Sun, 4 Jun 2023 12:33:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
 <20230530144821.1557-9-avihaih@nvidia.com>
 <20230601142231.78b15326.alex.williamson@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230601142231.78b15326.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3995e9-b18c-42e3-a9f0-08db64dece6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VXRuOqugUI/h97iFaZL1jSmIzUPtWg22y+6nd5ywOLyP6ADvyGVWWmJaWMMHRQPflIa0NGqXwN0Qa95JH0s7K+hxd1HmEKpVKCcbtGufv3YYXuhXkGt68Ebz3GLmdES2AfSuol/Ys6a1cRlOYCcApa8SZ8efts9Oam3U1PHoqWjWLkBUZDnKh4PSQRgwqr8M49hK7czkrX4kkrJoA26sncHzsevZNsrUWecx7ar0MQFUNvszf8G7gx+QY01DuuN6lLGp5GAfYkZUYp2tjdJr/JGJdD/PaE9ClP5qQQ68Kux2S2MrD67OR8pmFoidiYOOiNIQBip0t8E2ptB9rcvURtfWQztNlRqyFVBl9+8UJGo6bTM5zfg90lfVcKvhAiZqfw1hye2I9qKmowBNLTkGFf5La0dPvBLApAnTJzQt/pz+PRHLK1TmC+t8Fe1DV3gwNE6w8d6CBLEc2li7t1HFfG6qmzUWBlx/ISMFpUC64OvjTJQYutqKJzBfwF7aE824LVYr6BONjGz5I1W56AqeZ/oilpHaRWdcEFMY+jQk4SFJWogCICR19KaNlYXamBuaaQAOvEUHGzZjLv65/i007+wcqNLJKu+O47BTOBLW2urQDNAOnpQzaQ7n8ad/GyyoxxEvLxjS8nUN9Lj14wVAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(478600001)(36756003)(2616005)(83380400001)(66574015)(186003)(53546011)(6512007)(6506007)(26005)(6666004)(6486002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(7416002)(6916009)(86362001)(31696002)(2906002)(5660300002)(31686004)(8936002)(8676002)(54906003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdFbnFUYkx3ZlFuN1JXWmtHZytDRFJBMTJWdEdra2M4dUhIQmpYUGVDM080?=
 =?utf-8?B?dk1vQ0FQRy9haHhnZ1JmODFnUXYyYXlBdENEdGtsNnRocjhDaTJIWHk1SURi?=
 =?utf-8?B?RmQxd1dtRENKSnBsSzFSRURrSWl5OHNpZXNRaEZJdWUvcHEzOHFCVXNkTEN0?=
 =?utf-8?B?MUcyWDEyUFZqVSt3YjlyUkYrL1RDUjRoR0JXMWtHU2hkRjVJKytvNDRqemtB?=
 =?utf-8?B?Q0pndndnbnBTakNQSnZuM1R2VCtiSXcrRGk1K3RaS2V6NCtWaGgraCt6RnNk?=
 =?utf-8?B?MmFrZ0kzSUNLK25BUFpFbGVCSUVqRWpnam9pclJiSWViYTBmMlNBL2VMdTR4?=
 =?utf-8?B?Z3NHZ2p3dTRvWjNLbWFHb2loczU1QlZienBEU3RpcHl3SUJaM1hkQ3VNTGVF?=
 =?utf-8?B?QW05TWNQZXVjMDhTZmFmTnZrMFJsdG53YlJ1RVpKTmQ5ZHg5L2VxZlkvWHlh?=
 =?utf-8?B?THZDNFdEOE1TekNIVjhlK01hTWllU25Yb1ZqK0ZydHNnTFJUenhUWU1rUVVW?=
 =?utf-8?B?NmZZbDZ2c1E2WVNZMUZxalpTTXFFQTFXSDBhQUNwUlRZdkJyYktZMERDcXJY?=
 =?utf-8?B?a2tnLzAzenJiRDdBNVI4Tlo3WmdHOEFkejBRVzVFU0JUM3lQcGZDNFROSi9T?=
 =?utf-8?B?K0EwSGFyNXd2OEJsWUxtdmZLMUpjcVU2K2NHK081aU82VlZqN080UnAySExx?=
 =?utf-8?B?UVd0YkdXZTl1UjdFNXdvYkxhVGZrYk1XU3d0SlFsN2pGM3VDVDJxa05HeDFV?=
 =?utf-8?B?NHN2Y3IvWXdwNk9sYy9VV1dKbGc3TjRaeDg0QjU5aDJvQk9iZW5RcUNJbnZq?=
 =?utf-8?B?ekVSTjA3d1llWmlQWi9ubzE1YjA2NCtjeG1vbVlUdjlVMUc0ZVkvMEVlQ0dN?=
 =?utf-8?B?WTNIRVNLRFg4T1FPT2hKcDZjQnJUTkFDcFNlTW1qS2hWR0gxSlVWY1VGZVkz?=
 =?utf-8?B?dmY1ZG9qZHJJSkNlSFhsem11Ykc5NXBtTHNhQnZ1b3lRMG9QWGlzK1VwWnNB?=
 =?utf-8?B?TnNCUEpRb2k2NzZaY1RzSXNBekxWWWN3VENNTkg5a1NwZmUrVFhONDMrOHJi?=
 =?utf-8?B?Q24zcFpOT05ib0JoV1NPdEt6bjN6cWNhYmtSZXNGUmY3ZFVuR3ErZUFHbjZN?=
 =?utf-8?B?OVlSWUZxdmJjcFpoRWU0TDlGSHp0d1R6L3ptTHAwaFVoV0FkdHVKWS9XU0po?=
 =?utf-8?B?TFFWN0NORGNoUjRuaWFVQ3VFdlpnWG44N25nLzFYcE9TS29vMzhBcm5iWUZ5?=
 =?utf-8?B?eWU4VE5tVFcwZW9qOWQraFhMRk9kSUY5WTlvbVJxdDE3MzYxTFJhQjlDTnQ4?=
 =?utf-8?B?cHJhaFpvTXYxTWplRDNqZHdsUnoxdjBlcWFicDNuNnozZE1MTHROT0Q4Ky9j?=
 =?utf-8?B?Z2kwUHp2bGYydlVLZkpkeXQzWldXMWhJU0tnMG1zODE4UEJiSklwNURTU3BO?=
 =?utf-8?B?OHNEUFJhYVpscWxINis2OWYxbTZRMUFteTRGNFpNS094ZXhiak4wY29DcHI4?=
 =?utf-8?B?dm1VNEhWYUltYTUySTJxaExqYnlGSGMvemNTOFlzZUN5MnV6QmVzVUhXNVJa?=
 =?utf-8?B?ZXdIcFM5SW9tU2VHZXpyclhpZ0M5Ti9iZk5sTXppaGpqc0VIbFB4WG1rRVQx?=
 =?utf-8?B?T2tPUldaV0V1VXp3ZkVjYmF5L3gwZkloYitMd21NK1pQMFVmMzh3ZytqVW5q?=
 =?utf-8?B?anpCdnQ1NzJ3bzl2ODhOOW5uNGJnK09uUEFiaGg0SFYvN2h6OU5ERllLNkww?=
 =?utf-8?B?TTF1UGlJdlpOa21mMEFqWkZXZ0VabDFsVENsVlhBSnpLT2hkWWpIcWprNDZK?=
 =?utf-8?B?TlNQTXF4ZVV2Z29rcFFZeTV4N2dxbGVJZlpmTS9zbngxcnNzbHdXZzZ0amlz?=
 =?utf-8?B?SU85MXdPaGNpMWJ3dndHSnlhV3d5K01BMnJuemovUmRYVUhUWUc5bHE5anAx?=
 =?utf-8?B?MitpSXp3aXQ2ME5HVVYyVEd3ZXNUZzRiak05cTRmcEZ1UlIrYUFsVXNJMDBy?=
 =?utf-8?B?VkxrMzBvTGc3Qk5ueW4yd3IzVm9IcGFtYWlxaHRpRWJweTVkU3pLZHNBbE13?=
 =?utf-8?B?Rk9sM2hQL2dEaHo3M1AwZTlJTVI0aW10dy9zMGdPeUdxUFZuWHZpS2NDLzZz?=
 =?utf-8?Q?gDda/BBwBTG8zZ81cInaDWR0y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3995e9-b18c-42e3-a9f0-08db64dece6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 09:33:51.5379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/SjqG0j9Hl9WTPG3rxa+SQepNMLHhBjgPOgMHCEIRmQ61cWvX4ejcW4VHrCXhUF4AaxcN4NaI9XOKFlEI8qZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
Received-SPF: softfail client-ip=40.107.101.89;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.157,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 01/06/2023 23:22, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 30 May 2023 17:48:20 +0300
> Avihai Horon <avihaih@nvidia.com> wrote:
>
>> Add a new VFIO device property x-allow-pre-copy to keep migration
>> compatibility to/from older QEMU versions that don't have VFIO pre-copy
>> support.
> This doesn't make sense to me, vfio migration is not currently
> supported, it can only be enabled via an experimental flag.  AFAIK we
> have no obligation to maintain migration compatibility against
> experimental features.  Is there any other reason we need a flag to
> disable pre-copy?

This could give flexibility to do migration between hosts without 
matching VFIO device kernel drivers. E.g., source driver doesn't have 
precopy support and dest driver has or vice versa.

>
> OTOH, should this series finally remove the experimental migration
> flag?  Do we require Joao's vIOMMU support to finally make it
> supportable?  Is there something else?

I think that after precopy is accepted we can remove the experimental 
flag, as we'll have the major parts of VFIO migration upstream.
After that we will still need to add Joao's vIOMMU support and P2P support.
Do you want me to add a patch to this series that makes VFIO migration 
non-experimental?

Thanks.

>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/vfio/vfio-common.h | 1 +
>>   hw/core/machine.c             | 1 +
>>   hw/vfio/migration.c           | 3 ++-
>>   hw/vfio/pci.c                 | 2 ++
>>   4 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1db901c194..a53ecbe2e0 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
>>       VFIOMigration *migration;
>>       Error *migration_blocker;
>>       OnOffAuto pre_copy_dirty_page_tracking;
>> +    bool allow_pre_copy;
>>       bool dirty_pages_supported;
>>       bool dirty_tracking;
>>   } VFIODevice;
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 1000406211..64ac3fe38e 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -41,6 +41,7 @@
>>
>>   GlobalProperty hw_compat_8_0[] = {
>>       { "migration", "multifd-flush-after-each-section", "on"},
>> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>>   };
>>   const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index d8f6a22ae1..cb6923ed3f 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>> +    return vbasedev->allow_pre_copy &&
>> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>   }
>>
>>   /* ---------------------------------------------------------------------- */
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 73874a94de..c69813af7f 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>>                               vbasedev.pre_copy_dirty_page_tracking,
>>                               ON_OFF_AUTO_ON),
>> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
>> +                     vbasedev.allow_pre_copy, true),
>>       DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>                               display, ON_OFF_AUTO_OFF),
>>       DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),

