Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0C70F6F8
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1nyq-0007Pc-AI; Wed, 24 May 2023 08:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q1nyn-0007PM-R3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:52:38 -0400
Received: from mail-mw2nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::61c]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q1nyl-0000Io-4j
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv6ckXjkjlVQ5SLsXjELDFP3uUN1T2RZE2QQ2vQcV6WJBtwUu2BXwrSz+VeIoc4joKiq+5GYL0Hcgijl72+DPsm+Uz0baFb/LSE/ACNhSvOcHRRJcdBmMMfjE3tA0jUz1mm2eV7EOf8nBCnG7YJF0LUp0jFW8BKdOiek29fjE6mV8/Qie83+tFPRaaxjapDoOLw34pnIqwP28TjHAob3JY1AlmFGtiPrXhz2vge1bbX/c7Ynwi/0e0yCWv0j2e9xzxTKMLk2z8p5bvM5V6nclWWyM6qnoDqHF7hV27rSNhGJTu37jbaZZv7HbVfjTQz2xTRIrOY/dlacnJ4qgSJFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lM9WZKdgTFZ+xiTzVYJKRnQjzX7er1A8WHVG/gr31U=;
 b=TZIZw5pF0QZwIcTRa9bc1YksGOH5VG6VaERS9bCPZeO/rtNwTB4mbLccuHhfYovr2vOfwBgGaYoKx7agW0J6ewXiD1rfP9YW0i1DShYjjcqzAxQ4Y8i4B+0+jI2LkIivZBsDKAvqu+yy23Ku5GwmGfhnFeXmvj0o0CRyazCdB4COmKKgBVDJKYMmO27HhelnxBzEcD0sbcCWk8TDNTLI7hWCkWw4E3Yv5PESii0BNkP7s40lhSjK7WI2sy7fKCw1SITa95bc4efJb6YM5BBKH6QyQGZRIzAyzjimeu5k0DAyENN/Jb/AX3QidDQ/PzwqLxl2S7jzL1hdzMbV7+Oiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lM9WZKdgTFZ+xiTzVYJKRnQjzX7er1A8WHVG/gr31U=;
 b=kRp76MDj9qfDrpc1dG3Zl5cJf/xbAH7rIQzXn6kftdDIihgSP/qRBG65k6T7aaHG5wyuy7mFi+U6PDj8xagutEiLEOBjQRjdKG00vlTdkT0YtxTzdAhL8QIcGSllDwnEyuIG0n7O8CcSTiea9NXES9Of7zDGGOdUmyi9BnBwsJPwpsSHgMgpRLa2WNP+S2XN+gcNnewazKajF7uZV7oCDk0yKNQOXmOIhSfTNn3xbTDODcJC0H8hm75YhPFDQbq9sHkGNICOqJZ3mIN6iwBe00zripRGcjRyrUFj3mhmoLhgleQP9LjAyBpv6B26ni1hmvdR7IEOYO0LQ3EpRVnr2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:52:31 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 12:52:31 +0000
Message-ID: <655ee8f1-406d-b7c9-0044-e42df04167f8@nvidia.com>
Date: Wed, 24 May 2023 15:52:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 7/7] vfio/migration: Add support for switchover ack
 capability
Content-Language: en-US
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
 <20230521151808.24804-8-avihaih@nvidia.com>
 <d5fdbc86-2d73-03ca-23a0-407c01fc206e@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <d5fdbc86-2d73-03ca-23a0-407c01fc206e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0181.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb673bf-532a-43d1-9071-08db5c55bc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5if+XLMxBmnil1Z0c3XCmoCXNO9jgLN/hkoinQvWdd8Uy9yYGwNw2PFdVsKtDNmo7GovgAeteHnSsQknAYOoB+QEZWiIEzub8amLhwh5245QkzXy3cdUyvu6nDJ5Fq7tMk2gO2oaPBSOf46S19XXuAC8OqyRdP+1xLpURnWwSFvWHbOyVskZmzAYbjkyzubXDAjcSsMdOr3U8unV8rboOx4NP+T87Mdrf6cUkKFDBxO2RuO0E1OMs95CcBv/kRgvLfrwjBaF9DeYARdRW9ENWFlO46vic3mvNOD8GImTOIlXwp8MpVUzUWf9meWcQr0n6MhSBUsr55yPuZnQDIRl+yt9di9855jTaJadXjjwIywCDy4i5lcQssNF7oVndaRu7JxHqzmxmo1PFHtqiXMPGyFFxx5+kzl8plsOJsb0I9iIDBHkHMQ459eNXUjmU+GoV62m2v+odTkg4+XtwfHvwEIHBlv88oIS6OJPiy4AJP4ukmjI+ab8KstpTSgw5HWLYs2kU9N7u3PBpJxezDzFlFDqHCX7ZviFviof51NtqNSdZ6jWaLwRA6361hPp83Di+IL1pFKzhakUHO5RA0XMmdcmAJxBY1zKAhCtiliADfFGqjWCFDApp7cVWSqSiaKHJalZ0tsLRUX9Ah5bndZTlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(31686004)(83380400001)(8676002)(4326008)(38100700002)(36756003)(8936002)(316002)(66556008)(41300700001)(66476007)(7416002)(6666004)(26005)(6486002)(66574015)(66946007)(2906002)(478600001)(186003)(86362001)(5660300002)(31696002)(6506007)(6512007)(53546011)(54906003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpsRVhXTTkxZFYvR1NvMFdzRERqM2lVMjE4K0dtRkg0YkpKNVdzdm9VL3VX?=
 =?utf-8?B?bzRYT0RmUko4WG5vbm50VGZsMm9zTFk5d1prc3FzSlFtOURiemtFcldldzdK?=
 =?utf-8?B?UE5LWGdELzl5VlY0UzhwQzZqK0N2djdtL2F4eVRsM3k5c1M4MFJmWlNUcWEx?=
 =?utf-8?B?Y2hCWmZtQkE4TGxxbWhOc1dWR1VtQWV3NlhUNFpsY0NPb3NsWlI0RGo3VUxm?=
 =?utf-8?B?dDNCV0F6UlVUeE5PMFJVYXJrZkxRdzhOU1h5azBxZ2xCTTlYdm1VRXdJSnkv?=
 =?utf-8?B?cEFDVmRiYkN6VmRMMHl5UE1CWU9PVEhld0wwRjQxdzgxZ0RqZzIvNE82VkNz?=
 =?utf-8?B?MUhJcHF5MHE0aWlJdXQrMWJFRjNoRnl2YXFoRlFYYnhoQnFnUFNYWWZEWHlW?=
 =?utf-8?B?UCs3Zk5ZVUd5WFZUc0l3ejRqVFMxSENEV0VNWkpndmZESWNqcjVzbTF4Qzlj?=
 =?utf-8?B?TXZ6MnJlWWhHaVB3OG1ETHUwdHhsS3dka3pTL2ZDSnVFOHlCUkRuL0loeHR0?=
 =?utf-8?B?WmhnVmdLdmZxek1TTDUxbk9PTksvbXJYQXJhaXVUcVZXZXVsd0VvRCs2RHdM?=
 =?utf-8?B?OUw1WStuaTdacU9TcjlWMjJBL0dZSHIzVGNZbks4d2czYzVrc2hLWFRHT1hS?=
 =?utf-8?B?cVdrVW9lVUlYQTllWFZKWllxZWZlVk04ZGtYNmx3MGhRWWc3dngyOUIvZzB4?=
 =?utf-8?B?RUE5R2oyZjZJWitIK3BTN2pmNjRCVjAvWG9Nbk01T1hSYmx0ZHFHdzVXeGxl?=
 =?utf-8?B?WEZsTC85V1BCblVDQmZLRnRheWJOOU1abXZ6bGxxV1dBd0dROERocVo1R2l0?=
 =?utf-8?B?MU1oSC9nMHI0cXhLZ2VYVjBoUnZIbUFtT2EwTE52N2ZCajlsSko2d0F3L3V5?=
 =?utf-8?B?b01pQnZTQkpQVUdhNXAxM2tNRmszZ0hmcU0rVktaWm5VRGMrcnFKSkpJM2dJ?=
 =?utf-8?B?a3JOTjlJL2RZRFRTUHh3cEM3QS9GZFJsT0ZGS0lMcjNZZmdtaDl6bmwwYkQ3?=
 =?utf-8?B?WUtRQ0NWQnpxS0NqTy9mOVZOK2NiQzJ5WWlDTU00UlRUWmkxTjM0NVpROXFr?=
 =?utf-8?B?aUtZYk9odWFIdnZ1QlNYMmRSNXoyekVtNXc2ZjRGbXZReUp5UGZTMk5nRHRG?=
 =?utf-8?B?azM5NnNqOEZwaS8zTXlvUTlpSFFUbXJCVHdWZSt2bnRnTGtrNkRBQmRHSE5x?=
 =?utf-8?B?YjBYQkQvNjl0S2d6eUEzMG16TW43MUJaZmtqODRib2VUbjdMWjdMa3ZSZWlY?=
 =?utf-8?B?OFZ3S29wR2tLakRuSTFyK09EODU2STJaTzNCanllK2FmbGRqME5vUzlnM2hV?=
 =?utf-8?B?bnpXMmNBQXAxdzlBUzg1SGU4RFY3c2hhR2FqbE1kTWpXRkFDSGd4eG9vNHVp?=
 =?utf-8?B?c1dabm1EWXYzN0haZ2VlVTNFZFBMUDZlUWhxbFkyalIvS05xWG42cVBWRWRh?=
 =?utf-8?B?eXZqQmVUM0tQSkpCQnFrcDhtUUxzVHlmTXlaZDVBUnU5bXBIL01DdmJkbTdI?=
 =?utf-8?B?VldKK2FoTUVIQUV1aVlBTHdCcFdHYzdzdEtCYkZ1RWM0UWNPaGthRmhQS1dF?=
 =?utf-8?B?VEhjdytxS0k4VEFRbnN4aVVjYkVnZnNjMUVscGpDVHdXd3IzQU9uRHMzeFh1?=
 =?utf-8?B?eFFEYU0yR3JRdUY2cnNEYkxkT1h0a3UrTXlCamJJUi84eW5ZZmhaQjM1eFBk?=
 =?utf-8?B?VVNFNm1QSElyb0wxcVJ5VFkzYjd3UkUxK3Q0OHJJbmFqYUgxYjFyZC9hbmhi?=
 =?utf-8?B?cVZVTTBBSCtvUFh2WGIrd1RaOTlhNXpwdC9hdTI3em8vVjh6dGM5aFg5b05v?=
 =?utf-8?B?VFBZMVUyRDRQMXZTTXRsb3VZSGp1WU5qLy82T2E1RUNsVzFFRHQ3aUNWUDZY?=
 =?utf-8?B?MWJ0UzcrbVRoZHZDOGZmaFAzZTJMUW5GakpVdkUvWjJIaGlqRGM1YlpsY2Nr?=
 =?utf-8?B?ZHdNc1dqUzQ0am1lc0ZtWXFVaWd3RVN1NHdPdGtmR0s4Y0xjakZYV0RpQ1hF?=
 =?utf-8?B?b1M2SFpFZHo2MGIxZ0ZWb1B3RU5Vam5MdytmSHBKT3VtaDJITHEvQ1BFWGdx?=
 =?utf-8?B?aVJLNzNLeDVtQVk4ZW85a2RvUjNRVXZwZ2dRVGpRalBpWlBjTWtmT2tCNkxV?=
 =?utf-8?Q?3tFzZRwqQPBUh6l8RJ1kq7mNX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb673bf-532a-43d1-9071-08db5c55bc72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:52:30.9667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06Tj2L4OAZ9Wuoo9yOH7fIXpkeBOJaW/ZZ4VU3d3vqYcXVRK8rzsYknVYYXLir1Jl+4dn94Wb1TjNK1SQhbqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
Received-SPF: softfail client-ip=2a01:111:f400:7e89::61c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 23/05/2023 18:09, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/21/23 17:18, Avihai Horon wrote:
>> Loading of a VFIO device's data can take a substantial amount of time as
>> the device may need to allocate resources, prepare internal data
>> structures, etc. This can increase migration downtime, especially for
>> VFIO devices with a lot of resources.
>>
>> To solve this, VFIO migration uAPI defines "initial bytes" as part of
>> its precopy data stream. Initial bytes can be used in various ways to
>> improve VFIO migration performance. For example, it can be used to
>> transfer device metadata to pre-allocate resources in the destination.
>> However, for this to work we need to make sure that all initial bytes
>> are sent and loaded in the destination before the source VM is stopped.
>>
>> Use migration switchover ack capability to make sure a VFIO device's
>> initial bytes are sent and loaded in the destination before the source
>> stops the VM and attempts to complete the migration.
>> This can significantly reduce migration downtime for some devices.
>>
>> As precopy support and precopy initial bytes support come together in
>
>
>
>> VFIO migration, use x-allow-pre-copy device property to control usage of
>> this feature as well.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
>> ---
>>   docs/devel/vfio-migration.rst | 10 +++++++++
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   hw/vfio/migration.c           | 42 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/vfio-migration.rst 
>> b/docs/devel/vfio-migration.rst
>> index e896b2a673..e75793b76a 100644
>> --- a/docs/devel/vfio-migration.rst
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -16,6 +16,13 @@ helps to reduce the total downtime of the VM. VFIO 
>> devices opt-in to pre-copy
>>   support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>   VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>
>> +When pre-copy is supported, it's possible to further reduce downtime by
>> +enabling "switchover-ack" migration capability.
>> +VFIO migration uAPI defines "initial bytes" as part of its pre-copy 
>> data stream
>> +and recommends that the initial bytes are sent and loaded in the 
>> destination
>> +before stopping the source VM. Enabling this migration capability will
>> +guarantee that and thus, can potentially reduce downtime even further.
>> +
>>   Note that currently VFIO migration is supported only for a single 
>> device. This
>>   is due to VFIO migration's lack of P2P support. However, P2P 
>> support is planned
>>   to be added later on.
>> @@ -45,6 +52,9 @@ VFIO implements the device hooks for the iterative 
>> approach as follows:
>>   * A ``save_live_iterate`` function that reads the VFIO device's 
>> data from the
>>     vendor driver during iterative pre-copy phase.
>>
>> +* A ``switchover_ack_needed`` function that checks if the VFIO 
>> device uses
>> +  "switchover-ack" migration capability when this capability is 
>> enabled.
>> +
>>   * A ``save_state`` function to save the device config space if it 
>> is present.
>>
>>   * A ``save_live_complete_precopy`` function that sets the VFIO 
>> device in
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index 5ce7a01d56..b4a7eb0f9a 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -69,6 +69,8 @@ typedef struct VFIOMigration {
>>       uint64_t precopy_init_size;
>>       uint64_t precopy_dirty_size;
>>       uint64_t mig_flags;
>> +    bool switchover_ack_needed;
>> +    bool initial_data_sent;
>>   } VFIOMigration;
>>
>>   typedef struct VFIOAddressSpace {
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 418efed019..09c669c1d8 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -18,6 +18,7 @@
>>   #include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "migration/migration.h"
>> +#include "migration/savevm.h"
>>   #include "migration/vmstate.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/register.h"
>> @@ -45,6 +46,7 @@
>>   #define VFIO_MIG_FLAG_DEV_CONFIG_STATE (0xffffffffef100002ULL)
>>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE (0xffffffffef100003ULL)
>>   #define VFIO_MIG_FLAG_DEV_DATA_STATE (0xffffffffef100004ULL)
>> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>>
>>   /*
>>    * This is an arbitrary size based on migration of mlx5 devices, 
>> where typically
>> @@ -380,6 +382,8 @@ static void vfio_save_cleanup(void *opaque)
>>
>>       g_free(migration->data_buffer);
>>       migration->data_buffer = NULL;
>> +    migration->switchover_ack_needed = false;
>> +    migration->initial_data_sent = false;
>>       vfio_migration_cleanup(vbasedev);
>>       trace_vfio_save_cleanup(vbasedev->name);
>>   }
>> @@ -455,10 +459,17 @@ static int vfio_save_iterate(QEMUFile *f, void 
>> *opaque)
>>       if (data_size < 0) {
>>           return data_size;
>>       }
>> -    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>
>>       vfio_update_estimated_pending_data(migration, data_size);
>>
>> +    if (migration->switchover_ack_needed && 
>> !migration->precopy_init_size &&
>> +        !migration->initial_data_sent) {
>> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>> +        migration->initial_data_sent = true;
>> +    } else {
>> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +    }
>> +
>>       trace_vfio_save_iterate(vbasedev->name);
>>
>>       /*
>> @@ -576,6 +587,24 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>               }
>>               break;
>>           }
>> +        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
>> +        {
>> +            if (!vbasedev->migration->switchover_ack_needed) {
>> +                error_report("%s: Received INIT_DATA_SENT but 
>> switchover ack "
>> +                             "is not needed",
>> +                             vbasedev->name);
>
> This extra line could be avoided. This is minor.

Ah, right, I will remove it in next version.

Thanks!

>
>
>> +                return -EINVAL;
>> +            }
>> +
>> +            ret = qemu_loadvm_approve_switchover();
>> +            if (ret) {
>> +                error_report(
>> +                    "%s: qemu_loadvm_approve_switchover failed, 
>> err=%d (%s)",
>> +                    vbasedev->name, ret, strerror(-ret));
>> +            }
>> +
>> +            return ret;
>> +        }
>>           default:
>>               error_report("%s: Unknown tag 0x%"PRIx64, 
>> vbasedev->name, data);
>>               return -EINVAL;
>> @@ -590,6 +619,16 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>       return ret;
>>   }
>>
>> +static bool vfio_switchover_ack_needed(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    migration->switchover_ack_needed = 
>> vfio_precopy_supported(vbasedev);
>> +
>> +    return migration->switchover_ack_needed;
>> +}
>> +
>>   static const SaveVMHandlers savevm_vfio_handlers = {
>>       .save_setup = vfio_save_setup,
>>       .save_cleanup = vfio_save_cleanup,
>> @@ -602,6 +641,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>>       .load_setup = vfio_load_setup,
>>       .load_cleanup = vfio_load_cleanup,
>>       .load_state = vfio_load_state,
>> +    .switchover_ack_needed = vfio_switchover_ack_needed,
>>   };
>>
>>   /* 
>> ---------------------------------------------------------------------- 
>> */
>

