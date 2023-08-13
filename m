Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B383E77A509
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 07:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV3qt-0007Qk-FC; Sun, 13 Aug 2023 01:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qV3qq-0007QY-0K
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 01:41:20 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com
 ([40.107.244.78] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qV3qm-00017p-Es
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 01:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG/uaAAapiFkOosJO+d7I2f2nYm7KmDIgBVljGUyFpQ7Pr4doNP0S6rENj48/SNAleJYa9ofJbw9YhJ640pQd0ce/xDcjco4wRv8G5Sp8azQVYrN4i1ljnUXdxpJ2RODFXysoXWSldBaZGAofNtG9yvBC4QqhgQjZTh/9mQ+pX1k6usP6gADWps6AHEZK4YBi/+1Nr/LKgsGcYAFc92TZRSOPaYdzO/i1VyqPCPBwXi5qWBZ0r3NVsXVWqvbakTYXJLwJRPE0SurCxk/17yNitl3pPtFf0u9do5tkCP6Qs8aM7s2WV7uiEI9kC056Rjxaqw8ekI+n+biZpFuUBOp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mIo2NPB0B1pMkid4IULQ8W/hEf4QCB5M+Ftfh7TY9k=;
 b=UUhzMv7QUrRHJmXvCyqb8lrXUNlRt0gjMK+5t4WIv8wYXuop51b6/0tCEsWSrvcPgpagIBufVu0nYNFiSX6Qmzpwgnli/IynMSMtrtY+bx1iNt+6GYURF0/J//USkEoagQS22KA6hTBuDHelUr5axyGPz0K+kW+ccEBt4Iwd3whd2zzmz2lgpImDnRHlGNBE1RsL9/cD0Dji7RYMGx6gt/QQvI+BzhVSR12OebYI2aHipJGL9hO/f2FC7fQoTjnbvcsimUW/fd2m3MQGCqyEUAoeB4Bse3/LcSabZvi9NStCTdWCWRoAG7NIyrKLtSU59u4bck0JUSlMVgjEe49JAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mIo2NPB0B1pMkid4IULQ8W/hEf4QCB5M+Ftfh7TY9k=;
 b=DS6AGIy8+1nlHv4I2RFb5aeYnD/X6LzEEJGlQH1Nn4RJxUxKnDFzreJe1UzM1qE+D3BEN7/5cEKqS7lk3I/dJj0XHa9bvqhoifrspI+oN1XbgrMLD9PEmo6bd3lAefsXVwdTpYYtKRlIFUynaS4SXX6NfyUO1fPztmfj3WmhZPTEP9Pm28uw9yH595FMoEJAXoP7+ARarVR2W2m1oRDsPhJ/TQ/nbb68bmnVxH4C8SYILPgW1qkIsktoyNwotPP2HpVxCY0FRkPn9fosGBy/oCy1X8RaOfb+XbA796FUoaf/CwlUMjzLOqRVq/QgcQOPg9b1t11qb5SWFLWbVTsUFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sun, 13 Aug
 2023 05:36:07 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 05:36:06 +0000
Message-ID: <a3d1fe1d-2b24-327b-ef39-caec159e0d4a@nvidia.com>
Date: Sun, 13 Aug 2023 08:35:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.2 v3 1/6] vfio/migration: Move from STOP_COPY to
 STOP in vfio_save_cleanup()
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-2-avihaih@nvidia.com>
 <cc6d0b1c-036f-00f8-41fb-6ef1c59cafa2@redhat.com>
 <d870e5d4-dd34-6cdc-7586-971928927869@nvidia.com>
 <6a6abfd7-16c0-ff7f-4af4-314be9307c52@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <6a6abfd7-16c0-ff7f-4af4-314be9307c52@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f3ede9-eb10-4253-aef3-08db9bbf30df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pr26BueLG+RyJzFy0P8FIVG9pLBwmexUDy4ntahZD9lu6TTGr7291eV7hLIji0koDDnTIkaVzQKTfLYbcWEQujpzZ9HwHmc2wZziWIic9Cn376J71kKNZ3H3MbCTNhji0Y8JY01u6niUz5bL9Jiw/BoEcveW4NOQ3oER3mI3ngbzYI1LTWXi6cfYVGd2Fho23NwIOfeXnLV0qo/aLI6TAtdPTtzPkL1/iypyhcf05nN64QAgzNO1AM04AHo3emYHZA1xeWOEMTRloRqKeCkUBZXQ7KkvfIy5LQNPR8ibvUEbysIyYlljfQ6z2g6YvZTBKazzBITTBvN+HARbzsW7rbKzjO6TNwmnDN+l7KteHKC3CjjsXWgcgDUojJmswgdtbB4aMC7m0JYQD8utvWvCGKMNGZNUGlGsMK+BvPc5xPJ2zpfaXW4uXfDf2OwRITOe4A5Om8RBMkaRrVxywSHr9DcBLZxEmnEd8Eh8DJrFyy4UUgpEt03hdeql7if2RudVNsITRvvIw2grJHAlO5WOVo5nsG79jWsw13Qf9+PH6lg8QPp2ga0RfXpZYS5+9FhfgeIS7ez+T8154fOtbfAzkkEeEodFa1rxFPY8FDbWeRp476sRXNzJk0e4bMvZqzYu7x+CkLLtQ/XOJ25vnayzbP2XEDdY1w9gVJf0wejet3U+/+UY1YjlisqJRYT5fRNG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799006)(36756003)(2616005)(6666004)(5660300002)(8936002)(8676002)(4326008)(38100700002)(6512007)(31686004)(86362001)(31696002)(66574015)(478600001)(83380400001)(66476007)(66946007)(66556008)(26005)(2906002)(966005)(53546011)(316002)(54906003)(41300700001)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xWY3pnMWZvcDdpUExvRU9HN3Z3aTZibEZ1WkdwZ0xabStLNEpxYklJUmhr?=
 =?utf-8?B?L3JHenNaVmMwYVVEdTh6N3J6d25WK3VGUThFUFFkU2xHWlIvWSs2TjRjZkxm?=
 =?utf-8?B?NW1oanArdGo0VDNkSjQ2RTRBTGRZREhUalBNZitMVlYxQnZDQ21EUmZUQjdh?=
 =?utf-8?B?Rkx5WWpsZFpkbFI1ZkptRUJkTS9UaVR5NFovUGV6c3ZneTlYRnVIb0YrUkg2?=
 =?utf-8?B?VitXRDVNSGJnN1B4WitHVUNzNk9veHpEcEs0ZHBaSW11Z25wWWNxYUpSLzNt?=
 =?utf-8?B?RnYzVWEySjNSSWpycmNWeHVEUktQQm41YTBUaDFER20xWG5aUDlOR3JWT3dO?=
 =?utf-8?B?cjJTZXM5NmZYdjdCNldNM2Ixbk0ydUV2NjVYdCtNUWxLaUMySWxyMzcxbS9M?=
 =?utf-8?B?UVdLalBjOFdFMXlmZWphOTh2OFhOaUtLRnpDMDdURlV3ZmJHOHBETHQwdGxv?=
 =?utf-8?B?WU03Wi9xMXJEQVM0NVU4Y3E4dGV2enlLYWxvNTlPeVlVdXh6dXp2aUZTbUN2?=
 =?utf-8?B?dGx1VFoxTnFwSi9tVkNOYXJiMTRnak1UcFIvNDJJVnkyN0lLNmljcjg0dXdG?=
 =?utf-8?B?R0NPeklKakRyVVd0NWlFbGo2WUw4eEpzOGxJSDVzWGplSlplZDkvbTR2RHlF?=
 =?utf-8?B?azZQVjFjclFiZGtHRnBiV3dqV2d1ZVN0cEhvUFE5TzY3Q0c4ZVFyZkp1cmM3?=
 =?utf-8?B?bTByR0J6T3pieDJJbkRBR2EvWkM1WStEY3dHMHl2RW8rVmlydmdNWUNhMW12?=
 =?utf-8?B?L3RBODB0L25QYy9CSUlvN0RWRzJSZEtRbmhiTWZGNE4xdjZQcEhYL0todnI2?=
 =?utf-8?B?L0tMMFd1UUlGb1BtZFFlRXhmclBJemtsWWVLRnVpQUZLWS9GV2t3UEg0RVNo?=
 =?utf-8?B?RW4rUGJQQy9hOXFJbTBMc1hBaTkrUGpUeEt4c0RJQ1g1bU1RemlnYjVWZito?=
 =?utf-8?B?WU5JcFlVVkRtRGwyN2w0NUJDdDBLMlpDcEtlam9wV2VTeUJmWUhVRXlCMUll?=
 =?utf-8?B?VWUraXBENU1MYitXK3ZOWnJpQlZrVXhYSGlWRG1DbW80WnJpaEZQUkJlZmRq?=
 =?utf-8?B?RUo0dGlnQUIwMUlxQXVUeCtNa0dOSlVZdWFhb2dDQU1HZm1DTzlHSUZTeVN5?=
 =?utf-8?B?d2hOSms2cHM3WSsxMElzY1M0enFuQjVUdWk5c2FpTllWcU9Fek02Vk9jUmVx?=
 =?utf-8?B?M0grcmdVbGVBMHI5cVQ5M0pndlFITGNKRVR0SlJuVDErby96WWppNlA1OUJL?=
 =?utf-8?B?RGlqbTdzZThZNDJvNzRzVjUzLzhFWlBHR2dzRTkwelA4MCt5SExPUzZQK0Fi?=
 =?utf-8?B?cSsvYUlLYlY0S240RE5TUzNEYnhwcjg4Y1AvSHhDLzdZeWJRd1NaRHFibExo?=
 =?utf-8?B?SDJOYlRRNUw5N21TcndSalRaSVlzbndnMldEbEZNeExhUmlpelJncmpmSHRD?=
 =?utf-8?B?R01KdTZQY2hxTS9hM0gyRzYrZzJqUXA3UDNra3dZcEg0Z0FEVnlMQUhIWndp?=
 =?utf-8?B?emR3UnRHK2NnUXF0VDRiUTk5eHNZcm1tM2pZVC9SWHZrOHI2eUtRZWVNbnlo?=
 =?utf-8?B?MHZZa0tvVGErNHE4a0ovK01NSXo1dGFEOHRQdGJqeTlwVnd1NkhSaFpaZ1VF?=
 =?utf-8?B?ZExFS0pXeU5WODMwVWQwMHZCNlhGWms2R1ZkTzcrT2NldzZ1bTViUzdwUGtR?=
 =?utf-8?B?Vng2c084WVFqcnlPYTRLTy9zV3lGa1BWMGtCQ2RsNEJJZlo4WVdISkxPOVZw?=
 =?utf-8?B?NzYwMjBVVHFxZVdTamRUSFVqNFVoZU05OWFodkpXRFpkNVlWVEtvMFpmK2Mv?=
 =?utf-8?B?TkdjVnJ2WXNmbnZhVDdVRENFalhZSTd3SDlSZHBDd2dyRVNncGlqLzdtOFRI?=
 =?utf-8?B?RUxBemVKcW1PRDljQ051OXEvY1ArVGdPQk1XZjJDL1hoSVRxSS9TSnlDKzIy?=
 =?utf-8?B?eC9WTW90Unh4d1JQaGhEZlprS1c2OWtZQVRXZm1kQ3FXMUV0UU83NDdUelNY?=
 =?utf-8?B?T2pRSkxQZEZuTEMxT3RSd05jOFdHNUhienVkVCtDclB6TERITDFrN1REZjhi?=
 =?utf-8?B?aThBL3FyUVA5Wk5CcmhCNkdSdVVTTFBDL2xWOVN0WVlJUWdKTVFiQ2VTTE1r?=
 =?utf-8?Q?UkyF63IpMSME7yL/2Nxr12G2w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f3ede9-eb10-4253-aef3-08db9bbf30df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 05:36:06.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGCBlES1KqN0bGgQIDIYJqvhdcvnNhsrcFJVUIGUNlwckTW0jy/V+ThV6vRCKs1mUUxknv/O6d5jdNDFU3IxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
Received-SPF: softfail client-ip=40.107.244.78;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 11/08/2023 13:29, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/8/23 08:23, Avihai Horon wrote:
>>
>> On 07/08/2023 18:53, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> [ Adding Juan and Peter for their awareness ]
>>>
>>> On 8/2/23 10:14, Avihai Horon wrote:
>>>> Changing the device state from STOP_COPY to STOP can take time as the
>>>> device may need to free resources and do other operations as part 
>>>> of the
>>>> transition. Currently, this is done in vfio_save_complete_precopy() 
>>>> and
>>>> therefore it is counted in the migration downtime.
>>>>
>>>> To avoid this, change the device state from STOP_COPY to STOP in
>>>> vfio_save_cleanup(), which is called after migration has completed and
>>>> thus is not part of migration downtime.
>>>
>>> What bothers me is that this looks like a device specific optimization
>>
>> True, currently it helps mlx5, but this change is based on the 
>> assumption that, in general, VFIO devices are likely to free 
>> resources when transitioning from STOP_COPY to STOP.
>> So I think this is a good change to have in any case.
>>
>>>
>>> and we are loosing the error part.
>>
>> I don't think we lose the error part.
>> AFAIU, the crucial part is transitioning to STOP_COPY and sending the 
>> final data.
>> If that's done successfully, then migration is successful.
>> The STOP_COPY->STOP transition is done as part of the cleanup flow, 
>> after the migration is completed -- i.e., failure in it does not 
>> affect the success of migration.
>> Further more, if there is an error in the STOP_COPY->STOP transition, 
>> then it's reported by vfio_migration_set_state().
>
> It is indeed. I am nit-picking. Pushed on :
>
>   https://github.com/legoater/qemu/tree/vfio-next
>
> It can still be updated before I send a PR. I also provided custom
> rpms to our QE team for extras tests.
>
> Should follow Dynamic MSI-X allocation [1] and Joao's series regarding
> vIOMMU [2] but first I will take some PTO. See you in a couple of weeks !

Thanks, have a pleasant vacation!

>
> Cheers,
>
> C.
>
> [1] 
> https://lore.kernel.org/qemu-devel/20230727072410.135743-1-jing2.liu@intel.com/
> [2] 
> https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>

