Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2C72419C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:03:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VLr-00036Q-OY; Tue, 06 Jun 2023 07:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6VLl-0002rv-Qt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:59:46 -0400
Received: from mail-bn8nam12on20611.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::611]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6VLg-0006Hy-KG
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2cOyq5G+bseI4D+tcVzvs50GMwVabw5l59gCTF91658sGqG3HupGDH+eAHzEcY2hNI+ZJinEYarqhxn5ioZNv49phk+TwgRImmFz54mqxU3KvM8LsO3vELNTZDFUXhr2JMmRrBskGSmJzXE4jrcMDWGRCauL1AZVQcEmmUoRFgtegp5Pq+KtNqV0YaAcozm+12vy+oD0A71DZHryyqV6gJWBDBq6pMN/dk5C4qZCBzq4BMGlKW3P27Sl6gizM6s+khr3/ZLLS3f9tdmAHBuyjgJu65SCvmzK5+65qp+1BRTQAUCJI3yOPTdf8Jxg2bXWb/y6S2GZisYOi0z5bCELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecVRP6FIiK4arR92IM1nJqs3RDW8CgaOM9ZplvS6G0g=;
 b=QFcZY1iPk+NscqWIZscxpeTl2tAxa/vE6sI0KasCRATZOB6x7hSeX5c7aVU50GjbZSqJs8ISqcbPaBGjvnEj+Z5sl9ainS9Atu6UvRN0mRGmcQoJO6hYoDcyZIjQoRLqtjNJTGCH720OsYa4aRz/1d8O74tksstb1bvaR+s5ecGxKegndcNCVQmoJ/kNiEtFhY5BBQvLTZdgyWcAU0BnZUXkd1MrN3RL53WVgnOb/AMdvlIz+Gxk4eWGUr2p3TGNunQj19s1wdiy5UZy/FbRF4k3C3Pio7yCK/zqEeXui5ROB/yDI8R+0/znNbZ/LxgqinMJ33NZRn8Z04aYgxmKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecVRP6FIiK4arR92IM1nJqs3RDW8CgaOM9ZplvS6G0g=;
 b=DY4Mw+aeNZzMmZSTX3y+nBPQZx1jEWu0RILv/y80nc9PXLHVuZR78g52atvJDFyM7qGnzxtyzQLDOVEkrWN56zRIb+8BJ6wDboKFhKrlzn8Rm4SyejHt+NpHhRz3bDb2A8ZJyVw0xMq5YgufsRIDK8TQQgwZjgb3n0xstZ0mR5MRx1MzoD9zLSq8YF43ocwTtYUakD967dyfj0/cVYvmnPGyAkwN/3igCjuwH1tWBrpik1brq7SnBwfryNjOrPRAfE4ljiGRBtRIQfCMPFWLuLM5vgOjdHW+SYvqQ9DbJFidGJ5nBeo2LU5supMNYo2azSRSrgdOU5KBM75Wi147xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 11:59:36 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:59:36 +0000
Message-ID: <9bb2d05c-d4e3-1d4a-ec99-2780895ae7c5@nvidia.com>
Date: Tue, 6 Jun 2023 14:59:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
Content-Language: en-US
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
 <c3edcf5c-75c7-df60-8782-8cc9a8a31ccf@nvidia.com>
 <20230605085612.32f4ef95.alex.williamson@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230605085612.32f4ef95.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e5405f-89e7-4545-d938-08db66857f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzdI3qGE8dea1wIQiYot9mN/rxOQObNAnTKTCbb1zHVUJ9mJCuttC5pahUfRnZH7Jh7InxPt3d0E6b6CkAgCJF/CaBlby4YXax+5DdkYmZv3kNRsZFsKD9hMWz5I1l6mDrUcJBZSfJJciDGMYzg0nErRYcfJjWx4DaJqhys43BsV3UKYTlwNGwREyf7QQIc1qRymktZpcwbNq1AfquRyWojoSaNi+mEG6jsl27qF0N1B7f0WhkxLlaeUPsjb/u4iWiNjfw0iGbd8WjWl04W1rJ0Q3+Jf/+lzkMR2boNxlBS9eDZUzxLMyVE1ECk4k46Q2MIC2RAZyFHhkCAfQkOYNMwljew7ZfXBJr9ktofJmgTjs7TjcPd4CBdsj8Zhv6qFhKuc9VFFD5720dikfkDzCjHbs16UZzoyBPyUwQjicSBENp+Obze2ctQct96MZvTTwlS15sDaPqO1mBOb16K3bUwZ9XDZuC/8oB6gTrNyOZ4OCIAqVuMNSc9MdV7b6tooCv8gPIPYaaeAyeQE38hw8lPL63XNmoDyqciNOQ0ccBLTurt7ek7/M9G70VBKvz0weyZDraZHtUX/6OAUuNoS7Q4lAW6giBuH5Nn1dALzd6vwUQQRc1j0NLv7qAYafXUL/dZGPTG4VT2nbuZRWqGMoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(6486002)(36756003)(6916009)(66476007)(66556008)(66946007)(54906003)(4326008)(2906002)(5660300002)(7416002)(31696002)(86362001)(38100700002)(41300700001)(316002)(8676002)(8936002)(6666004)(478600001)(31686004)(186003)(83380400001)(2616005)(66574015)(53546011)(6512007)(6506007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UExyNTJyakFhbXZWdFpwa2krcGxYUFZtbkpleVA1aWtjNjRZbnJVMnBoNU9L?=
 =?utf-8?B?UHlxY2NnbEVYWjZqbXpNdmErbllQSlY0WmdJQ0lzOGQvK3pCMlo4cjdYSHdP?=
 =?utf-8?B?eHdRTkpML1RvemcvTHdwU0x5VU9iQWQvMVFXUmhSMjRKUHd0SFA1VUo3QTVV?=
 =?utf-8?B?RTZFaWNBcnVSRGM3K25ha0FMTXVVK3lsaisya0N0dlRqalhBaEZLYWtqdjNX?=
 =?utf-8?B?SzZwYlhhTGlTMWRKVHFCZTIrYzExRGk3OUlJeWRIcFcrcWxQcllJaG0vWHMx?=
 =?utf-8?B?M24rbmoxSzNlditybDNjMHBpRDMxZWx0UlBlWXpGSmVYWWdMUjFTVWZzUlIw?=
 =?utf-8?B?WC9oMllqWWV1VlpsU3haOXF3b3pseFdhQnhpVGlLazBHQ2hmVGRCcHNodmJt?=
 =?utf-8?B?ck9SV0tzQTROdFg1bDNkLzJvRHV6WWoyWVVjRXpJMWdtWWV2VHVUamJVZTh6?=
 =?utf-8?B?cXdtZVRYWktPR1FONEsxV29wSTVuN0x1VUpGa1VITy81YXFHVGgxNmlLNjdG?=
 =?utf-8?B?eXJYNXIyMTA5QkpUSjdFUEY1aVpsbVE3TmtDSkpxK3crN0pLVm84c1dMTGFR?=
 =?utf-8?B?eUw4VUNrVlluVDRROGNHSVVneUhWOFRBNW9mUzdnc0lrdWZSeWNEQVpENTZi?=
 =?utf-8?B?TUJlM2ZPQzdiOHlWMzZnSUc3VEdhbVR1bnZYeGhXc215YW1SZDdiNG4va2U2?=
 =?utf-8?B?ZjIxV2dHNExvWGk0ckR6Ky94UjlmNmpSNDlGdDFsSHFkaHN5Mlg0L29sbWFk?=
 =?utf-8?B?STBacFZzRjN0VVZzUFN1WFZtd2JEVnRnQmxNcnhueDBmckVDR3MvZ3VEekdp?=
 =?utf-8?B?aERlNlFQd0ZjSUxmMVFTbWVXM3psOU1nNmFIaEcweSsrcTUzd1JST2ZOclRE?=
 =?utf-8?B?OHdCSHV0bUQ1WXg4Qms5bWFvQ1I0VVlicUMvSWUwc2tqdEFTakNCeHdkTGR1?=
 =?utf-8?B?VHR2YXJUWUN3NHg5bkpXT3FpQ0V2eFIyVTZQVDQ3VmdheVViNXdvaGt1eXJt?=
 =?utf-8?B?ajNVUmJ4cjVzdjQ5bUNVQm5mR2p2QlJ6YnptTTJDVm56R1JlazBSR1RMWjNB?=
 =?utf-8?B?ODZubzkwZTl3Y01COXZVZHlDQ1U0MXFXcUJLMHdGRzhtRW5oS0V6aytaUWtK?=
 =?utf-8?B?UVFJQjdJY2lGNFJFcThwWjFqUzNBSURLODRLbGpGTW45bGQ1LzFJOG52NDdN?=
 =?utf-8?B?dDFPeFo0Uno2ZnVwMXZEZXlZQVozclVkUnFUZ2pkc0QzaXZjSDl1VExQQ1hJ?=
 =?utf-8?B?ZTd4bjMzNDM3Mlc2ZWh1S0NzMXBjYWdOUmx2NUhrRW5nV2REN1czK0pSV1BH?=
 =?utf-8?B?emV3Z3d6RHY1SnByN3ZiRHJ2cXJteWVTc3NrTDczaDFmR0VTc2NRcHZaNHNP?=
 =?utf-8?B?MW9ZV1ltZTRib2VTY2JtQXFTai90Qzd3N2ZHVHpkTC9LMDg3aGZsR1puc2xY?=
 =?utf-8?B?THVyTHQ2eHhEOHhLeFZoVlJVRXRsdEZ4NUM2aWlLSjByenNvcUVtYnhZS1Y2?=
 =?utf-8?B?OTZxdmJqUkR0QzYxVWhVM3AvWk1jVGwzdWQ1NnRrLzBueTJTVHZDSGRkc3Vt?=
 =?utf-8?B?QWJYblFUK1BOZDVOYTdmV2lodnk1d1JKbVpFRXZyKytZbytJNElDdDVyOGZ1?=
 =?utf-8?B?S3g2azQvdGo4RXl0ekNnY3RyU0NBMUlVUmduOStnM1pldzZITSs0empKelN6?=
 =?utf-8?B?V2hLTFR4MjRHNlY1TXZGcjNRY0tsbXRBalZUdzVlSDdQeFkyNmt0bHRIdUUr?=
 =?utf-8?B?U1BlL01pR1cvaldPbmx3Z1FsS0xWSmVOa3NSM2xMcDd4eFp2UUNwNExsdy80?=
 =?utf-8?B?Q2NhOU5zY295NXVSNWdldXZCS3A4WGVFZStTYmpyOER1M1ViTnFTQlBCUW02?=
 =?utf-8?B?WFZyZnRqNnhINFRva01qMFFDek1LaUNDOGhFY01uVnNCWXYyaU5vYWNpUEVz?=
 =?utf-8?B?R1ZzM2FXR1hBSEx6WnlVQlVJT0QzZ0YwWWpmdktHeVBaZDlYWkhrZmhUdmhF?=
 =?utf-8?B?TFhtSkZ6aW9oRys3eGtTb21Xbk8zenVnOVdRcnhJVktGWFJuWHhsQ3U0VGhv?=
 =?utf-8?B?SG40eWpPeDlFYUp6MFBpQWlEbXBFSlB3eExaYjYxSjhDNWpmejVjejJDMDV5?=
 =?utf-8?Q?4LdFxtQMsuGhBxLPfkgHMVoDH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e5405f-89e7-4545-d938-08db66857f91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:59:36.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEBjNSfYpqgabyoo1x1VQzunQX7G3NiORwlpK54NttGGwFCF219TV1StlDBVHboXk/udLUcIkO5xS52aLSmFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 05/06/2023 17:56, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, 4 Jun 2023 12:33:43 +0300
> Avihai Horon <avihaih@nvidia.com> wrote:
>
>> On 01/06/2023 23:22, Alex Williamson wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, 30 May 2023 17:48:20 +0300
>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>
>>>> Add a new VFIO device property x-allow-pre-copy to keep migration
>>>> compatibility to/from older QEMU versions that don't have VFIO pre-copy
>>>> support.
>>> This doesn't make sense to me, vfio migration is not currently
>>> supported, it can only be enabled via an experimental flag.  AFAIK we
>>> have no obligation to maintain migration compatibility against
>>> experimental features.  Is there any other reason we need a flag to
>>> disable pre-copy?
>> This could give flexibility to do migration between hosts without
>> matching VFIO device kernel drivers. E.g., source driver doesn't have
>> precopy support and dest driver has or vice versa.
> If these are valid scenarios, the protocol should support negotiation
> without requiring an experimental flag to do so.

Thinking again, the two intree drivers we have support precopy and as 
you said, this is still experimental, so I assume that we can drop this 
patch in v6.

>
>>> OTOH, should this series finally remove the experimental migration
>>> flag?  Do we require Joao's vIOMMU support to finally make it
>>> supportable?  Is there something else?
>> I think that after precopy is accepted we can remove the experimental
>> flag, as we'll have the major parts of VFIO migration upstream.
>> After that we will still need to add Joao's vIOMMU support and P2P support.
>> Do you want me to add a patch to this series that makes VFIO migration
>> non-experimental?
> I'd keep it as a separate patch with a clearly described dependency on
> this series so that we can discuss it separately.

Sure, so I will post it separately.

Thanks.

>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>    include/hw/vfio/vfio-common.h | 1 +
>>>>    hw/core/machine.c             | 1 +
>>>>    hw/vfio/migration.c           | 3 ++-
>>>>    hw/vfio/pci.c                 | 2 ++
>>>>    4 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 1db901c194..a53ecbe2e0 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
>>>>        VFIOMigration *migration;
>>>>        Error *migration_blocker;
>>>>        OnOffAuto pre_copy_dirty_page_tracking;
>>>> +    bool allow_pre_copy;
>>>>        bool dirty_pages_supported;
>>>>        bool dirty_tracking;
>>>>    } VFIODevice;
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 1000406211..64ac3fe38e 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -41,6 +41,7 @@
>>>>
>>>>    GlobalProperty hw_compat_8_0[] = {
>>>>        { "migration", "multifd-flush-after-each-section", "on"},
>>>> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>>>>    };
>>>>    const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index d8f6a22ae1..cb6923ed3f 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>>>    {
>>>>        VFIOMigration *migration = vbasedev->migration;
>>>>
>>>> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>> +    return vbasedev->allow_pre_copy &&
>>>> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>>    }
>>>>
>>>>    /* ---------------------------------------------------------------------- */
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 73874a94de..c69813af7f 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>>>>        DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>>>>                                vbasedev.pre_copy_dirty_page_tracking,
>>>>                                ON_OFF_AUTO_ON),
>>>> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
>>>> +                     vbasedev.allow_pre_copy, true),
>>>>        DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>>>                                display, ON_OFF_AUTO_OFF),
>>>>        DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),

