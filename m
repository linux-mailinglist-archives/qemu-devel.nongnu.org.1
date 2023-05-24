Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA370F6FE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1o0r-00088s-TI; Wed, 24 May 2023 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q1o0q-00088Z-8I
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:54:44 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q1o0k-0000lW-N0
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFLwlRu2O+9vkK+ovK4zN52uTPE3Q7YzpgKozit6jXclZjw67WPToPuaM3Z5ipgtI8aTY1oOUEoxGw4RjJRuj75HpVBzD6UtS/g/qj+mwm7NcBKYJB0OoCwD9s0hPRrdHFD4i2Kr8RGmJsRfd6Qpaw59w5UxFY+d3pwmMRdRV9GP9cOIBdZrloFF8TqvIr6lCPQLS6DXgdygWSCUppquULIKix5ZFF+SrSn2gl5a8zBVBSSp0nyGVahxQU1G9LUYxZEPHiFuIhEsxnWtgWNCigVLU5kXPm4ZuXB1wRFU8F0EHYxGopP+nUcDyckouH2At31d0hKpJvqZTEd25SD5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVr44IYWlifwvDl2mBP+ObrT6QykrrWjH/bMdRa7M4w=;
 b=k1AkJBtU0iLUtZ6+MiNR4qxPEqmcshS5KLsZ6TNtdRXutOxyywqcdPmxklTF8WvdBW+FsSROOBIf41CijpGCAvnqSE19julfFmpOC5wSkrejCXmdDdtNM4GkRcyUwclJ97qfjajfvptasZwv9ot5etYqDcyyKuqR1ZuhtTRvxxlTANums4WTdDGgZ2q037T9zL+u3RDkfJcbdqxd1zUtacldQt+KfXPkMhScBYsw+pjzxEP8tzBmags/ljyTkyHkgx7d7yu8yMwoo0Ne9re1ljo6SLV4tpvwaNJV2jElLftjpFmB8ZLG18L8OEk9KaHn4HdVKGFEefVhHCvvr1KzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVr44IYWlifwvDl2mBP+ObrT6QykrrWjH/bMdRa7M4w=;
 b=XPESlKhbX9gQ5z4COeE6HFa1dOt8v6EpnoL0C8bbv8aTo+HlVR3CrABuOT4rFBaErAHd96sYY99Ov04794B4TG5Up6SxDuuVULNlYR24hofqpBNKc51OVoTigVMtTdlqboTP8cUz8LHWamkyR/dZF2JsuLy1vbpKdZ3kiVKuj6LXOScA1V+wwsQ5fX0mOU8l1wTzFuHmg6HP4Gtnx5Hn7dbDbVSjVS0FcN6K9U7Q6+hUIBQkO4WWXztE67vDesSr6eKKa3KjWMOdIJIHGrkRXP7ieLDhlayxCrnWWyaPMKb0ww+3Iab+6kPkdiDKKbUWgMetY/qGRc678edXw1pBxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Wed, 24 May
 2023 12:49:28 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 12:49:28 +0000
Message-ID: <1c3dc84d-c7f3-8ec5-93ec-f5781bcd16af@nvidia.com>
Date: Wed, 24 May 2023 15:49:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/7] vfio/migration: Add VFIO migration pre-copy support
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
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
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-7-avihaih@nvidia.com>
 <6958827d-e9ec-4617-324c-7c9a070fad9b@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <6958827d-e9ec-4617-324c-7c9a070fad9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::23) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2b15d2-07de-4447-595b-08db5c554f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWh1u3SNZIsLXwXlVqdxuvjCP8LXSlTe4AglobZDZLvwEJXwKvxY/Q/amn17IDlg5f2g9ya2XK9sKqypybBsp99VN4wDHN9Ynp18NUyogi4cXh6mx/ooW8IhU5M+2hUJAnPWnV02wX6hHRjyi0XcsLiNkquDMioLGmqqx1YVYlfYlGGssGpiIfyhtVL+WoZf2ZdB2AW87iLwg0pWRjzPZNd42vcA6fu7AmADUeyu6+6T7OhKqOx24tMErn4vihTiY4O8PHwAj7j4ZdBeexsbIAkMX9Ur7C31KQ2MVgkgeRfPp35H9tjbzUFR+7HuqpejwVwqsuqkiEl5jc38BUBOl/L2q59tEChZkvDYZo71n2FORZvzo1KPKtXqXaLZ/2xMkrt/7Wj6r9ZOhPAHGxOzb+AC+OXs2ZwEqSt/lyRppm9/2X/MI5Sn1U6OYKlCs3aiE9Bz3LZ2zFpkdcZiZ6KT2l+FrUKNOI7MWpnstn+DhQCKkWuFY3R5+Buft6+kOpv7dmC/bEPeku8FxepBbXNUFPbicr598XKl7Fa3VWUeYFDWcZELkQevC0gPW7EzyO/eaoLjKQ+C7T0AUDmFRzQp70NGgRZzbs5vFYX/XANDAxNW00BdIWm89boQuY1Ngf32fjUMMOhLFBOGsEm5O8Imoj56JbDmTrVwVBYMOFvrTcvDAmJQnAJlzuaK/4CFgDib
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(31686004)(2906002)(54906003)(30864003)(7416002)(5660300002)(66574015)(8936002)(8676002)(41300700001)(6666004)(66556008)(66946007)(66476007)(4326008)(478600001)(36756003)(316002)(6486002)(966005)(26005)(6506007)(6512007)(38100700002)(2616005)(86362001)(31696002)(53546011)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVpU2w0bFpZK3MvcE11KzN5R2NxT1JOSytQSUEydDZFaXJOVUY5Rm9qaFRw?=
 =?utf-8?B?dy80K2UrVWFESnU3bUJMdGhIQUFhS0RhYTVqeVV1dXc5Q21vcE45b29pVWYx?=
 =?utf-8?B?UjFRM1duNDVSQmpYaHZNOXVZZll1VmtwVnlSVUtDUFgwMDd4OThNS3RlTU45?=
 =?utf-8?B?YmcwZXV6WjUrZHcrVUw3cEZxTW11aWlwYld3SmMvaXlyUG1Xc1ZWczZpTTFm?=
 =?utf-8?B?WVk5UHBQNzVrZExpT3lHaWU4WFUrSVNyNndUZ1E4Ui9OQVRaaG9vNTFVbk5E?=
 =?utf-8?B?bmtIdE11aXNlT2ErR3hGbmJFUU0vRnZCTWVXMWZFbmFpUmc1SktBMVBDdzlj?=
 =?utf-8?B?d3lvam8rM0pScmpLR0NDVSt1S2VSdUNIRytTSWRVZ1VDWWRRcnI1SDVWRDEz?=
 =?utf-8?B?T0ZHTjd4aE5HMWN6aXJFMkp0OC9pdHhRdmhEc2hPT3dra1phN0U2WkdzcTJZ?=
 =?utf-8?B?SUh2dS9vU2k3TnEzV2hPSkVYeEhwcG96SVBOYnVpdU43d09zZCtiYnY0Sm80?=
 =?utf-8?B?WWxXLzhqOXc5SWtpZmFVeGtvYmUydXFLOUgraE1uWGIrMUJNTW5wYU9SeUNW?=
 =?utf-8?B?WW1jUUNJSjZWUFFYOVVvY2U2NFNMU3dFaTMrODFPMVY5RXhxeFJ6UmxKVjVY?=
 =?utf-8?B?Z2h6NEp4UHBOT2NmTjZzTjJpZEg3ZFJHbTM3OHdDeXVibFJyRkFSb0U0N085?=
 =?utf-8?B?enpTVXlUTUFOM1hDNmNZdStYT2J6Smcvd2dtOWNRNTl0ZmFhQmFaeEJGTXhY?=
 =?utf-8?B?NFFEQy9WcmJhL29NcmZHY1lPK3NJZ1g2emU0WlZTbHhVQ3k0L1I5RU5uOHlP?=
 =?utf-8?B?YTAwb3lTa21GNTJQQlZHVHVvQnJ2RmdURmQxUU5UekZrRmdXeHRka0VPRE1G?=
 =?utf-8?B?RUh0NkJKZXRrWFZhWU90SG5zL2JnRkp5UGFlRmZrSWJlaFpOVXNUTGc3MjZm?=
 =?utf-8?B?cDNSelNoWHlTVm55U2tybUhIdzRTSHpFcHNqeVJMdjVrcHQyaHB4clV0c2pt?=
 =?utf-8?B?VzlLa0daYlczL3lXUEFQc3QyR294eUo5TjJ3Yk02amhuek15U29PMGxwSXFw?=
 =?utf-8?B?TVlpQ0diUWdTYTRxUHE1ZXdkL201K0ozeVdxckp6SEtocGgxWVErYWFMS1hC?=
 =?utf-8?B?SXc0QnVRdnJIZUl3RFpMYUtyV2VEajRoNFVHVGFVNk5vZ3RYS2w5VEZ0Mkto?=
 =?utf-8?B?c29OY3JhaFI3eHpUTytqZTVkYzlqTVVHVUVoS0s1SjMvN0hzc1RpUFFDTDZX?=
 =?utf-8?B?NGFVMlRBeWRlL2pwMUJkdjcxQmlzbVJndHJaUWZQTDRBL1U0M0JmdVRZdjhr?=
 =?utf-8?B?VjJsSzczZ05GT2RPNUNtK3Radk4yQXNsNU5xRTFpU1FIcnpReXg2cnVyK1VC?=
 =?utf-8?B?OVV0NHcrZHp2dGQrZHVUWnhFVm5pbURDRnJUYWx2V29UMXRvajlibjBZVDBr?=
 =?utf-8?B?Z29kY2NuemJjeExzUlJhdDg5S2xjWStMZkZEL0MyM1JzMzJqNEtTUlNRZ2Ew?=
 =?utf-8?B?ZDBQOVdwZzFaVHRWU29McUJnb1ZnQ1MzQmFwajg1QlBuUU1qQW1BZGgrVVdo?=
 =?utf-8?B?YStNdEpLR2pVT25FSFNIQWNSVWZ2QzJybnZhRm1oaFRUTDdZblNpb0daNmlB?=
 =?utf-8?B?QlVyVERxYlVEZDhzWFZsajN1eDd3L0JUUVVHYlA4Vk9mWjExQU1NcXFqSk9q?=
 =?utf-8?B?QkVTbzFzUDgreXUza0tpN3RpNGlLRU40eTVEWFViMmlneVJKdzhIWGVhT25R?=
 =?utf-8?B?WHIvaVV6N2hxeE1IT252Rkl1R0ZrbXN3UVBuTWZQMTBUSW9iSGI3ZWxKYTlY?=
 =?utf-8?B?N014TjNWMkgxL0hzNkU1U1cwZ2FyTnY4Q0J2OVFpc0FvSUVMeWdncExLc3c3?=
 =?utf-8?B?SkNmbTZNZ1ZHVjA2NXlUS0p3am1wWFlmZEVzdUkrT0VUbnkzeWdhVjNmZDh2?=
 =?utf-8?B?elorR21RQ3pVMXFnM1dIdkpsRDh1SmZHWHFiRDZ1NlJJT2xia0V2ZS9LRFIw?=
 =?utf-8?B?aEFRZGV6eEhMdHRlQjROaUZYdzRJU0JaYzNyVDUrWlZCTEppaVZzL3ZkTzFr?=
 =?utf-8?B?b21MWlhYUU9WbmlMRHkvOEljenhZNVlJUmxLY2JqNlRZdkVvK3dWZWpGOGdJ?=
 =?utf-8?Q?yWK2PGMC8hQnCeYmj5n7Quer/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2b15d2-07de-4447-595b-08db5c554f72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:49:28.4161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh0VlfFxStk3HXVqNLFQexOcE0DJpzr26S81V+g2+Ac8uKDdx9YJv2wclPPccySNleoNk2zu5+2Sfm5DI5wIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
Received-SPF: softfail client-ip=40.107.94.55; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 23/05/2023 17:56, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 5/21/23 17:18, Avihai Horon wrote:
>> Pre-copy support allows the VFIO device data to be transferred while the
>> VM is running. This helps to accommodate VFIO devices that have a large
>> amount of data that needs to be transferred, and it can reduce migration
>> downtime.
>>
>> Pre-copy support is optional in VFIO migration protocol v2.
>> Implement pre-copy of VFIO migration protocol v2 and use it for devices
>> that support it. Full description of it can be found here [1].
>>
>> In addition, add a new VFIO device property x-allow-pre-copy to keep
>> migration compatibility to/from older QEMU versions that don't have VFIO
>> pre-copy support.
>>
>> [1]
>> https://lore.kernel.org/kvm/20221206083438.37807-3-yishaih@nvidia.com/
>
>
> May be simply reference Linux commit 4db52602a607 ("vfio: Extend the 
> device
> migration protocol with PRE_COPY") instead.

Sure, I will change it.

>
> some comments below,
>
>
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   docs/devel/vfio-migration.rst |  35 +++++---
>>   include/hw/vfio/vfio-common.h |   4 +
>>   hw/core/machine.c             |   1 +
>>   hw/vfio/common.c              |   6 +-
>>   hw/vfio/migration.c           | 163 ++++++++++++++++++++++++++++++++--
>>   hw/vfio/pci.c                 |   2 +
>>   hw/vfio/trace-events          |   4 +-
>>   7 files changed, 193 insertions(+), 22 deletions(-)
>>
>> diff --git a/docs/devel/vfio-migration.rst 
>> b/docs/devel/vfio-migration.rst
>> index 1b68ccf115..e896b2a673 100644
>> --- a/docs/devel/vfio-migration.rst
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -7,12 +7,14 @@ the guest is running on source host and restoring 
>> this saved state on the
>>   destination host. This document details how saving and restoring of 
>> VFIO
>>   devices is done in QEMU.
>>
>> -Migration of VFIO devices currently consists of a single 
>> stop-and-copy phase.
>> -During the stop-and-copy phase the guest is stopped and the entire 
>> VFIO device
>> -data is transferred to the destination.
>> -
>> -The pre-copy phase of migration is currently not supported for VFIO 
>> devices.
>> -Support for VFIO pre-copy will be added later on.
>> +Migration of VFIO devices consists of two phases: the optional 
>> pre-copy phase,
>> +and the stop-and-copy phase. The pre-copy phase is iterative and 
>> allows to
>> +accommodate VFIO devices that have a large amount of data that needs 
>> to be
>> +transferred. The iterative pre-copy phase of migration allows for 
>> the guest to
>> +continue whilst the VFIO device state is transferred to the 
>> destination, this
>> +helps to reduce the total downtime of the VM. VFIO devices opt-in to 
>> pre-copy
>> +support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>> +VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>
>>   Note that currently VFIO migration is supported only for a single 
>> device. This
>>   is due to VFIO migration's lack of P2P support. However, P2P 
>> support is planned
>> @@ -29,10 +31,20 @@ VFIO implements the device hooks for the 
>> iterative approach as follows:
>>   * A ``load_setup`` function that sets the VFIO device on the 
>> destination in
>>     _RESUMING state.
>>
>> +* A ``state_pending_estimate`` function that reports an estimate of the
>> +  remaining pre-copy data that the vendor driver has yet to save for 
>> the VFIO
>> +  device.
>> +
>>   * A ``state_pending_exact`` function that reads pending_bytes from 
>> the vendor
>>     driver, which indicates the amount of data that the vendor driver 
>> has yet to
>>     save for the VFIO device.
>>
>> +* An ``is_active_iterate`` function that indicates 
>> ``save_live_iterate`` is
>> +  active only when the VFIO device is in pre-copy states.
>> +
>> +* A ``save_live_iterate`` function that reads the VFIO device's data 
>> from the
>> +  vendor driver during iterative pre-copy phase.
>> +
>>   * A ``save_state`` function to save the device config space if it 
>> is present.
>>
>>   * A ``save_live_complete_precopy`` function that sets the VFIO 
>> device in
>> @@ -111,8 +123,10 @@ Flow of state changes during Live migration
>>   ===========================================
>>
>>   Below is the flow of state change during live migration.
>> -The values in the brackets represent the VM state, the migration 
>> state, and
>> +The values in the parentheses represent the VM state, the migration 
>> state, and
>>   the VFIO device state, respectively.
>> +The text in the square brackets represents the flow if the VFIO 
>> device supports
>> +pre-copy.
>>
>>   Live migration save path
>>   ------------------------
>> @@ -124,11 +138,12 @@ Live migration save path
>>                                     |
>>                        migrate_init spawns migration_thread
>>                   Migration thread then calls each device's 
>> .save_setup()
>> -                       (RUNNING, _SETUP, _RUNNING)
>> +                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
>>                                     |
>> -                      (RUNNING, _ACTIVE, _RUNNING)
>> -             If device is active, get pending_bytes by 
>> .state_pending_exact()
>> +                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
>> +      If device is active, get pending_bytes by 
>> .state_pending_{estimate,exact}()
>>             If total pending_bytes >= threshold_size, call 
>> .save_live_iterate()
>> +                  [Data of VFIO device for pre-copy phase is copied]
>>           Iterate till total pending bytes converge and are less than 
>> threshold
>>                                     |
>>     On migration completion, vCPU stops and calls 
>> .save_live_complete_precopy for
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index eed244f25f..5ce7a01d56 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -66,6 +66,9 @@ typedef struct VFIOMigration {
>>       int data_fd;
>>       void *data_buffer;
>>       size_t data_buffer_size;
>> +    uint64_t precopy_init_size;
>> +    uint64_t precopy_dirty_size;
>> +    uint64_t mig_flags;
>
> It would have been cleaner to introduce VFIOMigration::mig_flags and its
> update in another patch. This is minor.

Sure, I will split it.

>
>
>>   } VFIOMigration;
>>
>>   typedef struct VFIOAddressSpace {
>> @@ -143,6 +146,7 @@ typedef struct VFIODevice {
>>       VFIOMigration *migration;
>>       Error *migration_blocker;
>>       OnOffAuto pre_copy_dirty_page_tracking;
>> +    bool allow_pre_copy;
>
> same comment for this bool and the associated property, because it would
> ease backports.

Sure.
Just for general knowledge, can you explain how this could ease backports?

>
>
>>       bool dirty_pages_supported;
>>       bool dirty_tracking;
>>   } VFIODevice;
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 07f763eb2e..50439e5cbb 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -41,6 +41,7 @@
>>
>>   GlobalProperty hw_compat_8_0[] = {
>>       { "migration", "multifd-flush-after-each-section", "on"},
>> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>>   };
>>   const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 78358ede27..b73086e17a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -492,7 +492,8 @@ static bool 
>> vfio_devices_all_dirty_tracking(VFIOContainer *container)
>>               }
>>
>>               if (vbasedev->pre_copy_dirty_page_tracking == 
>> ON_OFF_AUTO_OFF &&
>> -                migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
>> +                (migration->device_state == 
>> VFIO_DEVICE_STATE_RUNNING ||
>> +                 migration->device_state == 
>> VFIO_DEVICE_STATE_PRE_COPY)) {
>>                   return false;
>>               }
>>           }
>> @@ -537,7 +538,8 @@ static bool 
>> vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>>                   return false;
>>               }
>>
>> -            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
>> +            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
>> +                migration->device_state == 
>> VFIO_DEVICE_STATE_PRE_COPY) {
>>                   continue;
>>               } else {
>>                   return false;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 235978fd68..418efed019 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -68,6 +68,8 @@ static const char *mig_state_to_str(enum 
>> vfio_device_mig_state state)
>>           return "STOP_COPY";
>>       case VFIO_DEVICE_STATE_RESUMING:
>>           return "RESUMING";
>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>> +        return "PRE_COPY";
>>       default:
>>           return "UNKNOWN STATE";
>>       }
>> @@ -241,6 +243,22 @@ static int vfio_query_stop_copy_size(VFIODevice 
>> *vbasedev,
>>       return 0;
>>   }
>>
>> +static int vfio_query_precopy_size(VFIOMigration *migration)
>> +{
>> +    struct vfio_precopy_info precopy = {
>> +        .argsz = sizeof(precopy),
>> +    };
>
> May be move here  :
>
>         migration->precopy_init_size = 0;
>         migration->precopy_dirty_size = 0;
>
> since the values are reset always before calling vfio_query_precopy_size()

OK.
I will also reset these values in vfio_save_cleanup() so there won't be 
stale values in case migration is cancelled or fails.

>
>
>> +
>> +    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, 
>> &precopy)) {
>> +        return -errno;
>> +    }
>> +
>> +    migration->precopy_init_size = precopy.initial_bytes;
>> +    migration->precopy_dirty_size = precopy.dirty_bytes;
>> +
>> +    return 0;
>> +}
>> +
>>   /* Returns the size of saved data on success and -errno on error */
>>   static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>>   {
>> @@ -249,6 +267,11 @@ static ssize_t vfio_save_block(QEMUFile *f, 
>> VFIOMigration *migration)
>>       data_size = read(migration->data_fd, migration->data_buffer,
>>                        migration->data_buffer_size);
>>       if (data_size < 0) {
>> +        /* Pre-copy emptied all the device state for now */
>> +        if (errno == ENOMSG) {
>
> Could you explain a little more this errno please ? It looks like an 
> API with
> the VFIO PCI variant kernel driver.

Yes, it's explained in the precopy uAPI [1].
Do you want to change the comment to something like the following?
/*
  * ENOMSG indicates that the migration data_fd has reached a temporary
  * "end of stream", i.e. both initial_bytes and dirty_bytes are zero.
  * More data may be available later in future reads.
  */

[1] 
https://elixir.bootlin.com/linux/v6.4-rc1/source/include/uapi/linux/vfio.h#L1084

>
>> +            return 0;
>> +        }
>> +
>>           return -errno;
>>       }
>>       if (data_size == 0) {
>> @@ -265,6 +288,39 @@ static ssize_t vfio_save_block(QEMUFile *f, 
>> VFIOMigration *migration)
>>       return qemu_file_get_error(f) ?: data_size;
>>   }
>>
>> +static void vfio_update_estimated_pending_data(VFIOMigration 
>> *migration,
>> +                                               uint64_t data_size)
>> +{
>> +    if (!data_size) {
>> +        /*
>> +         * Pre-copy emptied all the device state for now, update 
>> estimated sizes
>> +         * accordingly.
>> +         */
>> +        migration->precopy_init_size = 0;
>> +        migration->precopy_dirty_size = 0;
>> +
>> +        return;
>> +    }
>> +
>> +    if (migration->precopy_init_size) {
>> +        uint64_t init_size = MIN(migration->precopy_init_size, 
>> data_size);
>> +
>> +        migration->precopy_init_size -= init_size;
>> +        data_size -= init_size;
>> +    }
>> +
>> +    migration->precopy_dirty_size -= MIN(migration->precopy_dirty_size,
>> +                                         data_size);
>
> Do we have a trace event for all this data values ?
>
>> +}
>> +
>> +static bool vfio_precopy_supported(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return vbasedev->allow_pre_copy &&
>> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>> +}
>> +
>>   /* 
>> ---------------------------------------------------------------------- 
>> */
>>
>>   static int vfio_save_setup(QEMUFile *f, void *opaque)
>> @@ -285,6 +341,31 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>           return -ENOMEM;
>>       }
>>
>> +    if (vfio_precopy_supported(vbasedev)) {
>> +        int ret;
>> +
>> +        migration->precopy_init_size = 0;
>> +        migration->precopy_dirty_size = 0;
>> +
>> +        switch (migration->device_state) {
>> +        case VFIO_DEVICE_STATE_RUNNING:
>> +            ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_PRE_COPY,
>> + VFIO_DEVICE_STATE_RUNNING);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +
>> +            vfio_query_precopy_size(migration);
>> +
>> +            break;
>> +        case VFIO_DEVICE_STATE_STOP:
>> +            /* vfio_save_complete_precopy() will go to STOP_COPY */
>> +            break;
>> +        default:
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>>       trace_vfio_save_setup(vbasedev->name, 
>> migration->data_buffer_size);
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> @@ -303,22 +384,36 @@ static void vfio_save_cleanup(void *opaque)
>>       trace_vfio_save_cleanup(vbasedev->name);
>>   }
>>
>> +static void vfio_state_pending_estimate(void *opaque, uint64_t 
>> *must_precopy,
>> +                                        uint64_t *can_postcopy)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
>> +        return;
>> +    }
>> +
>> +    *must_precopy +=
>> +        migration->precopy_init_size + migration->precopy_dirty_size;
>> +
>> +    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
>> +                                      *can_postcopy,
>> + migration->precopy_init_size,
>> + migration->precopy_dirty_size);
>
>
> ok we have one :) I wonder if we should not update 
> trace_vfio_save_iterate()
> also with some values.

Hmm, yes, I guess it wouldn't hurt.

>
>> +}
>> +
>>   /*
>>    * Migration size of VFIO devices can be as little as a few KBs or 
>> as big as
>>    * many GBs. This value should be big enough to cover the worst case.
>>    */
>>   #define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>>
>> -/*
>> - * Only exact function is implemented and not estimate function. The 
>> reason is
>> - * that during pre-copy phase of migration the estimate function is 
>> called
>> - * repeatedly while pending RAM size is over the threshold, thus 
>> migration
>> - * can't converge and querying the VFIO device pending data size is 
>> useless.
>> - */
>>   static void vfio_state_pending_exact(void *opaque, uint64_t 
>> *must_precopy,
>>                                        uint64_t *can_postcopy)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>>
>>       /*
>> @@ -328,8 +423,49 @@ static void vfio_state_pending_exact(void 
>> *opaque, uint64_t *must_precopy,
>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>       *must_precopy += stop_copy_size;
>>
>> +    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
>> +        migration->precopy_init_size = 0;
>> +        migration->precopy_dirty_size = 0;
>> +        vfio_query_precopy_size(migration);
>> +
>> +        *must_precopy +=
>> +            migration->precopy_init_size + 
>> migration->precopy_dirty_size;
>> +    }
>> +
>>       trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, 
>> *can_postcopy,
>> -                                   stop_copy_size);
>> +                                   stop_copy_size, 
>> migration->precopy_init_size,
>> + migration->precopy_dirty_size);
>> +}
>> +
>> +static bool vfio_is_active_iterate(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
>> +}
>> +
>> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    ssize_t data_size;
>> +
>> +    data_size = vfio_save_block(f, migration);
>> +    if (data_size < 0) {
>> +        return data_size;
>> +    }
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    vfio_update_estimated_pending_data(migration, data_size);
>> +
>> +    trace_vfio_save_iterate(vbasedev->name);
>> +
>> +    /*
>> +     * A VFIO device's pre-copy dirty_bytes is not guaranteed to 
>> reach zero.
>> +     * Return 1 so following handlers will not be potentially blocked.
>
> Can this condition be detected to warn the user ?

I don't think so, it depends on the kernel driver implementation.

Thanks!

>
>
>> +     */
>> +    return 1;
>>   }
>>
>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>> @@ -338,7 +474,7 @@ static int vfio_save_complete_precopy(QEMUFile 
>> *f, void *opaque)
>>       ssize_t data_size;
>>       int ret;
>>
>> -    /* We reach here with device state STOP only */
>> +    /* We reach here with device state STOP or STOP_COPY only */
>>       ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_STOP_COPY,
>>                                      VFIO_DEVICE_STATE_STOP);
>>       if (ret) {
>> @@ -457,7 +593,10 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>   static const SaveVMHandlers savevm_vfio_handlers = {
>>       .save_setup = vfio_save_setup,
>>       .save_cleanup = vfio_save_cleanup,
>> +    .state_pending_estimate = vfio_state_pending_estimate,
>>       .state_pending_exact = vfio_state_pending_exact,
>> +    .is_active_iterate = vfio_is_active_iterate,
>> +    .save_live_iterate = vfio_save_iterate,
>>       .save_live_complete_precopy = vfio_save_complete_precopy,
>>       .save_state = vfio_save_state,
>>       .load_setup = vfio_load_setup,
>> @@ -470,13 +609,18 @@ static const SaveVMHandlers 
>> savevm_vfio_handlers = {
>>   static void vfio_vmstate_change(void *opaque, bool running, 
>> RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       enum vfio_device_mig_state new_state;
>>       int ret;
>>
>>       if (running) {
>>           new_state = VFIO_DEVICE_STATE_RUNNING;
>>       } else {
>> -        new_state = VFIO_DEVICE_STATE_STOP;
>> +        new_state =
>> +            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
>> +             (state == RUN_STATE_FINISH_MIGRATE || state == 
>> RUN_STATE_PAUSED)) ?
>> +                VFIO_DEVICE_STATE_STOP_COPY :
>> +                VFIO_DEVICE_STATE_STOP;
>>       }
>>
>>       /*
>> @@ -603,6 +747,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>       migration->vbasedev = vbasedev;
>>       migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>>       migration->data_fd = -1;
>> +    migration->mig_flags = mig_flags;
>>
>>       vbasedev->dirty_pages_supported = 
>> vfio_dma_logging_supported(vbasedev);
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index bf27a39905..72f30ce09f 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", 
>> VFIOPCIDevice,
>> vbasedev.pre_copy_dirty_page_tracking,
>>                               ON_OFF_AUTO_ON),
>> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
>> +                     vbasedev.allow_pre_copy, true),
>>       DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>                               display, ON_OFF_AUTO_OFF),
>>       DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 646e42fd27..fd6893cb43 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -162,6 +162,8 @@ vfio_save_block(const char *name, int data_size) 
>> " (%s) data_size %d"
>>   vfio_save_cleanup(const char *name) " (%s)"
>>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>>   vfio_save_device_config_state(const char *name) " (%s)"
>> +vfio_save_iterate(const char *name) " (%s)"
>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) 
>> data buffer size 0x%"PRIx64
>> -vfio_state_pending_exact(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t stopcopy_size) " (%s) precopy 0x%"PRIx64" 
>> postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64
>> +vfio_state_pending_estimate(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t precopy_init_size, uint64_t 
>> precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" 
>> precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>> +vfio_state_pending_exact(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t stopcopy_size, uint64_t 
>> precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 
>> 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy 
>> initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>   vfio_vmstate_change(const char *name, int running, const char 
>> *reason, const char *dev_state) " (%s) running %d reason %s device 
>> state %s"
>

