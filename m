Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E773A0C3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJKI-0002J4-8r; Thu, 22 Jun 2023 08:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qCJKF-0002I0-OU
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:22:11 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com
 ([40.107.244.63] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qCJKD-00028z-0I
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:22:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsJ3Bt6VOqvJu0gpRKYeg0JRi2TAkQ5j3zijM4vT2PdYs+7vZWGz6KcvR5IKqb0ErAv28PxiO4rzVGtEFx/5R8IoA3ptFg7P1CKqGFS3Fcy/nd067duyj1c69g9y9QAm9G/ZyXvXNfjGnd0s/LZtSm6cyb7u0Hm1JuTch6/AgsBKYLppbMRiI/2YHfT9tJxawiXvRe+GvrqOemNUSiIpB2QfdbMMngwR3T4FHKImLSHuZp2Uhoy1z2GeLjGd2p/J6dY78dLcksKwlhQr/7vFqFuwBJmd4QvkN5hCSXcFBzK8YXN7A1UDPr1y7jNbBDdWV7n1x3MdcQwn8qkqQr5TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIowk7UuJwBtn/JoHQpKwcDuSy5u+SakZXoJ6NrWve0=;
 b=AZubDpDKapUWC/WxLFQFpieE2zRcsSHq6ef0taWUmq83xOU/028hSZjV+aRddFc237nrzyhgnNnPCk22T+Ys4h9iP7wEFERxnVgzYLrRly3UzYzOKHtY4sTEy4b72sw4tnFhYb567Tm4VK9EOSsDHXABz9EWiOH8zmhIT/ROL02M+P3tzGR8mvxqXRbvG1sEoLzatO31qrOI3v3qJq5nqZXL+hNTUzCLzliJrP7/vhHuCguwmJLq2sLBxLZMda+/mkc3ut7aQRY+qahgzC74dlPzmRpZLZ4Ddk86mQiYP7z7UZSQamqakd0c6TIBz5uFlOw+WSTfYLvO5xcuoFx7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIowk7UuJwBtn/JoHQpKwcDuSy5u+SakZXoJ6NrWve0=;
 b=KWEgrY6X3VcANIYIzdQ5IIFyohnlGsNcbu0wNjEJkSzwJghg4MMFywFSiDqJOS9cgH+qb/BvrybcCdbQvwrLhgjuacNcY3ez7VZAEtM0SOCu/ZZgdBwxLy0O3R7s1uc72BOGyGTERetvCA5wrfhlHa9epEW9vTbqLHYrR9iAanGLV6PIFgPuKkrU2qmS0avMidxLNrX7K2wHYqrGygo9MmECogIRo1VtCixaOQbbJKJ6B2LbSTuV5T1riWYxLctbaC/WUJrKHQT+L9dFzwZCHx47E5PlfBdhAkDahHkGQ1rFfDGS8txqMzko3fJNXdk2MB88HpvWBbxofyCfT0FGbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 12:17:02 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 12:17:02 +0000
Message-ID: <4faf12dc-206d-b104-d94d-0bec2169b2e0@nvidia.com>
Date: Thu, 22 Jun 2023 15:16:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/8] migration: Add switchover ack capability and VFIO
 precopy support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
 <20230621132848.79c9b674.alex.williamson@redhat.com>
 <5f1c5fa6-20a4-a29e-3381-728ea0aa1797@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <5f1c5fa6-20a4-a29e-3381-728ea0aa1797@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0033.eurprd09.prod.outlook.com
 (2603:10a6:802:1::22) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW3PR12MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: a932159a-0673-4a63-da1a-08db731a95a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sdPsMUwdSvJjxPOcEV+hNz6K79sLBVp10nqHAS+XsgXM2EZhJbyMPxX6kNYbz17KvAiuZ+ClDvd2DTdnBx3MGO3hZ7FYWeYpu40xMB40FC18cH8gHtL8GrMCLYOjdRL1zdz0Q8Fur4DXM5bkXlWsjxWDKc733F0T64AMCN9Jfz+Olx8WwgHSthlgnGyH/hpjIRBjbgcnlZQR1NgNajzR/CIDLrXb9DgS2ys90VL8RM7n6oj0eVHH/MThZ5Bqo5sczBkbQJ3tOZ9fPC9pquWedyxJbLA9awJccPeqmL3kuxb5UF79b6Ixl0QQJyaaQ6E3ChjgNLjxwfJSFETn7eRjiwezbWD3R8khlh37UvDdlgMGIKvuwkq1tGPkzrGlsFSh3kfKyOwI9aLiiaspP8xbqgFAn2ZkAeAKNrdvyGnAJFhMdpWfp86NaqS1gSu5PstIJuUOe7cfl9oS87ppwQkL5hKo893PBkQnv13DEdFWgd61qeUYwueyCTWZfg8mNypTH0jG9xtB6RZ2FRIRSoYvrvWo3JiXwOssSIzyrTIEXlaZENJmKikfeSz5HFRvqS6ovOQJvoukBg8mnyKCFv/vwAX32rUSzGo8zDR9TjbNChqmuS+PEFOtSI5NLOCXmgM+b2V/rPKPaXoESIMXB85FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(36756003)(66574015)(4326008)(66556008)(66476007)(6666004)(316002)(54906003)(2616005)(66946007)(5660300002)(83380400001)(6506007)(31696002)(53546011)(86362001)(7416002)(31686004)(2906002)(6486002)(8936002)(8676002)(6512007)(26005)(186003)(41300700001)(478600001)(110136005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjI3MTcyYTREVUxET1FQb2ZKaVVKL1JqRjZEeVZyaFFtK2VnaFZrYkdBYW8v?=
 =?utf-8?B?dU1QOW81ZFpWczAxVDNvYno2cmFpVFdJNDRWT2N2dGlnVFplK0phcUs2RWkr?=
 =?utf-8?B?bWxpbkxSYjNqTmFhU3YyNEhxcHZFOVNIOG1CN21tVHJsa3dxV1pFZFlQTXor?=
 =?utf-8?B?SXZsTDF1Q1VHUkJ5ckVGc2dFZEdWbmxqbEJjMWdmN3U5S3NmQVljRkxKV2Nl?=
 =?utf-8?B?azFEdzhuZFNKZUZVUGhiZkQwakJtalFZMktLVDBwMXZDRWxEQWRXMWV4UzUw?=
 =?utf-8?B?MW1EdlM5dHRKa3FTQ2VjVnRRY0hnMzB2dUkzNHhRVjhGMXNXL3MzazY0UnZT?=
 =?utf-8?B?R0M1RWplZjEvQkxzN3FnY2hXbXZ3S1dsNzkyR1ZMYmNSR01jTXB6SnNtNC9u?=
 =?utf-8?B?aTI3K1RHUTdXaXB1V01LUTFkRVNMZGtqNnFQZFZQbkZHYjd3MzZiWkd0a1lS?=
 =?utf-8?B?bHdFbDFNNkJxM2ZUVW92M0xxSkhrSGRGazVuRTFzcWJOOUk0V0hnaUhYZVow?=
 =?utf-8?B?RHJmRjIyNmFKUzh3R3ZWWDc0WEZpZm1yZzdVT1BiZFJiMmNyRGJwMUVvc1Iv?=
 =?utf-8?B?ZTBCR2owMzlBUGcvbGNhTDZ5ZWcrckFmNlhrNG42ZkE1RGtuSXBDQjN2TnFY?=
 =?utf-8?B?ZWk3cGJxZDQ3VDVmNzFBRmJFbFhVTHVyWUI1bnFoenRNS29CaDE5YXkrSCt5?=
 =?utf-8?B?NlRmT0Q0bkgzTS9EU1JEdmRuUWJzS25ZMTRINDE1b1JIaGdpMjM1YUg0MnBE?=
 =?utf-8?B?ekdFaS9EaysrT1RQdFFRMzhLdGdYNWJpY1haZVFwaUNpOFBVMnkwSWViY3Y2?=
 =?utf-8?B?THJzeVNKbnZwcDFGdWU2KzdxWFpjUGxJRlJtRjFEREJjcytpNDVYMVhidzgx?=
 =?utf-8?B?OUFjVUcvbFByN2pXUmV6L3FBb2J2M0ZPNXQ2OThFQzZ2bzdlZHo3allMYzZR?=
 =?utf-8?B?OU1sOG9nMmFGWUtUbWQ0c3laYStPUFgzZ0UrY0ZyRUc1ZzV4bUR0RUhrOE1i?=
 =?utf-8?B?bUppNHBEaFFFKzlDRjFrUGJLaU9JZzFmM0k4NDZYeWVhVEtKYjMyMnZIN1Jv?=
 =?utf-8?B?MTVrcjZqQUc0ekFzSWV3WVcwTCsyRVpKRUtwVmM1clMwYy8zc1pGZWcwQU9J?=
 =?utf-8?B?NHFwY3MyZGNyeEx4K3BSQS9TNjlWT2FZbTRXdUxxTkRHUjVBTGMveVRkOXhz?=
 =?utf-8?B?eHVlbHovZ0hpcHkwK1NwK0wvR2pGeFdHWFp3NmM3NTlXNytFd3F2N1F0cGtu?=
 =?utf-8?B?ZmFoTjJIU3QxZ0s5MHNlQ1VvUXNIeXJHZHljZ3JWUjNlL3hkNk1nZnNrUStX?=
 =?utf-8?B?OVFUdlQ3V0t0K1RicnVnZ3VuaHdEL3BtNXhnTlNsS1E4VTg2UnJvdG1MTWNy?=
 =?utf-8?B?SDJJQlVpR2xUbTdlQTVZSUNpNHpJOHBLTmk0a0lMTzM4V3g5WUdvS3VZZE9K?=
 =?utf-8?B?TXlQTGpnT0V1OHVuYlhLR2hSUlZhQXdCUzV2Y051TjZoVDV0QkI0NVk2QVIz?=
 =?utf-8?B?Q3NRVXNLOHA3bi9mL2NHanp6OUJZOU5uSC9JY0xzbmEwblFid1pYY3hZUmF1?=
 =?utf-8?B?Rkh5UXBxMUFNQStncGIwM1k3NDRxOGg1UzlrajVUZ1FJMHJuUXJuQVdtQ0Ju?=
 =?utf-8?B?L3puNk5IK3JRMEMreDhJMFpqR0Nuay9Pa3d2cnlob2F0TGtGMjdSTHlXM1ZC?=
 =?utf-8?B?Mk5NTGdZeVdtd2MxOVpWUVVYeCt2WTFZcmMzditxWi9mNlNNWjVuRXQ1LzFO?=
 =?utf-8?B?SisyOW04bFpuck1LQzVaSlRTL3VMS0t1bjUrNXpFQ2UxS0hHTTRTeklSaTM2?=
 =?utf-8?B?ZXJFN0RXZ2NhQkF6N2R4cHROTDREVktIZUhoZlI2bTNoTysxQWlCSEJBZGcy?=
 =?utf-8?B?aHJxRE9JQzNldmN2QndMOURwVHZXU3NmQ0llT21sbzFYQWpIcjVodEc2MnNy?=
 =?utf-8?B?WlF1MWJxbTIrWVNPMlcyZ1ZRZXFHZEplbXRjTTlSNU5wanB4ZFBnUHVWcDBx?=
 =?utf-8?B?eEMrb1A4TGRKZVZ3WWlrdWgwcG93RlpHT2gvVHNzUzR3UGJTRkFWTE9mKzli?=
 =?utf-8?B?a1lZWloxeENYRVlRdm0wdElHV0RXb1ZIaUthTUN1ajhHNWExeGl5VHFNcjgz?=
 =?utf-8?Q?edzETUBar1PS7Uy3prYwYcCYn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a932159a-0673-4a63-da1a-08db731a95a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:17:02.2375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kCdkjvPUjPQEh/XvikQFPS9kXvoRtAyQjCoXx3iOTayd259RNj7zgPxhjnDoIVHjKylactunkBqQwAsJ3BROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
Received-SPF: softfail client-ip=40.107.244.63;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 22/06/2023 14:34, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/21/23 21:28, Alex Williamson wrote:
>> On Wed, 21 Jun 2023 14:11:53 +0300
>> Avihai Horon <avihaih@nvidia.com> wrote:
>>
>>> Hello everyone,
>>>
>>> The latest changes to migration qtest made the tests run non-live by
>>> default. I am posting this v6 to change back the switchover-ack
>>> migration test to run live as it used to (because the source VM 
>>> needs to
>>> be running to consider the switchover ACK when deciding to do the
>>> switchover or not).
>>>
>>> Changes from v5 [7]:
>>> * Rebased on latest master branch.
>>> * Made switchover-ack migration test run live again (I kept the R-bs as
>>>    this was the original behavior when they were given).
>>> * Dropped patch #8 (x-allow-pre-copy property). (Alex)
>>> * Adjusted patch #9 commit message according to drop of patch #8.
>>> * Added R-b to patch #9 and Tested-by tags to the series.
>>
>> I think Cédric is going to handle the pull request for this, so...
>
> Yes. I have a branch ready with this series and a few other fixes. Unless
> Juan want to handle it.
>
>
> Avihai,
>
> QEMU seems ready to allow migration when support is available in the
> kernel now and so, we can set "x-enable-migration" to true by default.
> Are you OK with that ?
>
Yes, sure.
But as per previous off-list discussions, it's not merely changing 
x-enable-migration to true by default, right?
If I recall correctly, Alex wanted to remove the x- prefix, change it to 
ON_OFF_AUTO and some other stuff.

Do you have some patches ready for that? Or you want me to do it?

> There are still some blockers, multiple devices, viommu, these will be
> removed with future changes.

Yes, of course.

Thanks.


