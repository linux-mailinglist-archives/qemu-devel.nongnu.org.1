Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60372B0A7
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 09:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Fr0-0000KQ-AQ; Sun, 11 Jun 2023 03:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q8Fqx-0000KG-RO
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 03:51:11 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q8Fqt-0006Gb-9F
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 03:51:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKqdTsAGOgjdueEmx7ku2+XRhr2JLqXxFyXXTqYqEuLaolNdT07l7WIw4wCNYxg2rkS+YlJMCcP0wa57/IPRobHbK2AUWL+1z3qvfF0MbgbYf6XMIs1/+8bUNcbsVhtTQ3mm7dLNB9l/ePX9kK5i9UU0HThTbFGp05eO5QA036y3kNuIDF703EEanGBrPQfwTgQ7hAY4OvgcQ/bqNmt2VNgzue9WijnfTUhB+DjOe4XHbS261VnVybfIepD0pE1QEvBl97KuM2PaRCC5w1tYAig0nQ8HdjG+ttMRP9rGLwDuNk5+HzKA7E8Dse1CiajIRXGukO7JM64qeCXg1gG17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPRoaP4NiFTkFLoBspHz1O8s7BJ+EZeJ8es4BOCaA50=;
 b=QMGI9uI9m0ER1CusjSnpQXp1+o57KPI1IhrfPBjnvHfa0iuZxSADOXtyIgnn6chO/s6xaYE9iZ9CDzEbua909rIFHVwKeuYfnTgny31Dus7L1/VQVGhawrYjE00QAJNi30iXJO4Y0XLX0TsoO179cQz9flUkjGcQS9F2tWXlCICU2fIZgR0iZvlRoGkFD/WXyNMG+oKJK6eHs9nbRtwVnrvYUH+gn1n/Grhg0nf23x8aB7K6SAv94FT0xKf/I3oeMOuTWbKD1UGn2sM8EpKLJ11BoMnX5YyNp9YNtxhxPg9siNXpVc+l/dIN1SnvQcoOihp5UALuvv16hmEISupr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPRoaP4NiFTkFLoBspHz1O8s7BJ+EZeJ8es4BOCaA50=;
 b=Hy8mZvX0ozzLyYzd+8+s4ZW74asPTfkkXw+lvu4K0ft+98GmfXnZxS8wG4jODQsoyCMc3M0dhstBekTdTv3DTZRA3ZGLjORMG0Nphkk+ihIGd73y47DFbwrDAraHlBcN3hGkwSur626/1XeL6YR+Odjhgz6QU0uqD+tmJjjWlzKVoxoOYdpk1ICDSODme7uHa6fIskVYtFV3ALHTuKyaMAF3uRXagMjW0hpjfT0lFtgrURE7sglX34wzT1aIo42n+GatgEZ784Sbnnp6JGSLnTAjGjXWFm+cc2adQSrLmYTaNTLrTVHxBYGfB5i56vAJ7VEA8m0j+uq1fsF67XJUew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sun, 11 Jun
 2023 07:46:01 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 07:46:01 +0000
Message-ID: <dd406595-25b7-d492-3afa-4bdb336e6fb5@nvidia.com>
Date: Sun, 11 Jun 2023 10:45:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 2/9] migration: Implement switchover ack logic
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
 <20230530144821.1557-3-avihaih@nvidia.com>
 <20230605160600.7df0993e.alex.williamson@redhat.com>
 <2377a8be-9c60-8455-b735-bed18f0ba238@nvidia.com>
 <20230608123238.46e460ab.alex.williamson@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230608123238.46e460ab.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4876189a-fc9f-42aa-e15a-08db6a4fe6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPeSS73gNIuaatkIbazuTygPUwdTBNG+YbNIBciUqGk6HikCtqAkq4YkbxXq14U53wMMIA7CBj5RnIADpUkDT5NXnGRxaTxcuioq4zH2AVbOhrq+MeBSMakJ9j87VzNF7SrOlIF72mT8QRLPY3ktZamjsWPQheFLpQyYpFbHXkgI2cgnKEwfXW5fnzhao9UUy6Up5qW0EQWzGQr+kr41KFqdFt1qOVY1cQ9JWJDxI42J85gmInLSl1/L4OfEvouuDlay9PQa/g1FJTC9vrj0ygV5kdrZrzwuuMw50BD2f3RNfRVdRT9IIDmAuCfyyCmMIh6PdlPWfwepo03zyfkI1D5EKXcRe7LOZretklwr8c/rje4urkcKVSNuhLTyQ9QtkspAFY+JYgy0nWz/eW1kAObocgWA0juuATHR93FR2dgp+asKRyz1DXV94C8jwQghnWadM0Kw0UMFlFJMQUPXAPNJPfTzzxkKCCzyo3q/J78P6WUjPFILvqPEjEps/fqXBRjnkViGT9z+Sa+gL/GurgiB9qrJxqfUS2+xnwF6j+KSeBZTBOwYoFnfNZjgq8jlb00yN0KFrGpd3Su2RnK4i40IBtIW41qg0a70KA13wsc/zN8P2Qo0/vmI+2qYNaBAXDPDqxPFkKoqB5yfOciuvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(5660300002)(7416002)(8936002)(8676002)(2906002)(31686004)(66556008)(66946007)(66476007)(54906003)(6666004)(6486002)(4326008)(26005)(6506007)(6512007)(53546011)(316002)(6916009)(41300700001)(186003)(83380400001)(2616005)(478600001)(36756003)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25lM3F5cnhWR3JDYmF5YkdVOWs0WG4rUkx3aGFwSG82S0JWdHJUekRGc3pu?=
 =?utf-8?B?c3g4ckJXbEg1WW54K2pCUHdkTU1tQTVEcUtWekw1QmRjL2UwTitjR25WazQ3?=
 =?utf-8?B?bFlDN1B1TFpib1NTYWE5bDIzb0p2M1Z1ZHl2VzdaT1R1ZjVRTXRRUGtmeGlK?=
 =?utf-8?B?M2ovWERKQzRlemg1Zzhrc3BZbHRlTmxid0cyeXVFM0o5YzBrYkNyM2dzWjI5?=
 =?utf-8?B?ZkIxUVg1Snp6YlBvdGVCdDBSV01oYjVYaTdicTlaNEdKcldFcnkrYXVHYmxy?=
 =?utf-8?B?YzdhVkdNZm5GbWYwRjNrUHJyRE1VNWtQOUt0ZTdDSzVNZ0VtMzYwS3h0NjRt?=
 =?utf-8?B?eFpsWWFTU3d4cCtNaGdwZUZmVFhsTERCMzVxT0VzamJYank4MTcybzI1SFNs?=
 =?utf-8?B?T3dESWVNVjhqd1UwK1FCRlEzSkwxRUFFMmFpekViODlJMXYrb1p3Q1FzbmxQ?=
 =?utf-8?B?eENtT2tvblZGVlB6V25vUE92allwRnBrUGZpNEIzZW11MXg0SCtuMWxwYWpr?=
 =?utf-8?B?YjI3WW42QnJZRmt5WjhqdmsyejhyMXY5TXhyWVRvTGNyQlcrTllkZTAzUTJB?=
 =?utf-8?B?VkpTd05DRkRhRGNhRnhYcEd1dkdFZEpxTTNGZ0lCK04rTXNpWmdLSWwweW4v?=
 =?utf-8?B?Yy9KL3I3UGJuZURjdDlIZ3NKdk1mbmhGeFp4cWIxVndqK2tpak1pdnB3VHIy?=
 =?utf-8?B?eVNwWEduUzZvd1B0alYxWHUxblBTdDFoNU1ma3FoZWRSSmtNSmVFSTRzMkhi?=
 =?utf-8?B?WndTS0pOdG56VkVKSTJJRHdHYmp5T3VSY2huVVVyYklpTTJua1FhWjZKM3lu?=
 =?utf-8?B?ZTg2VmJ3b1Blcy94YmNYRHY0bVJhOGVhSWNwMlNsQzhodGQzUXFJSHpndVRu?=
 =?utf-8?B?NWN6Q1ZGV3B0azRtblg2YkZWMm8zcHZ3MURvZXlPdHNxYXV4MjZUVjZ5cThU?=
 =?utf-8?B?MExVNzlHNEhjeDNORDQvV0ZzTVhYVEtjRmp6aG9ZbEJvMXkxY1lMZ2I4LzRD?=
 =?utf-8?B?SzcwSmRrUGM4Nm1kZ0l0S3lyRGNKYktNVjE0NWI3TkJab2FJekhFWUJ2M1FP?=
 =?utf-8?B?SDlhTEVrWndwVHlWQnRMZmNnbit0T3p4TGwvSUhFMmNnb3FjUUc3SXorMHZq?=
 =?utf-8?B?TU1YSWNvemYyK3g5VEVSOUc3V2UvcHZGSUxITWt4b1Z5VktBZzJWVGs1Zllh?=
 =?utf-8?B?S04vOVN5N0gwQmZ3QXhRcUlVaDNnVzNNd240blFBMlJJZllkSEpVb2JPWTIz?=
 =?utf-8?B?UG1zQ2txeFdKRFR3ek9UTzBtNURZYVNLeWVqdllPZ0F0NjhXMFkra2xYTnN2?=
 =?utf-8?B?VXFpdlJ3OURQTGdnZkVuM0lRUXJmWUdFeGxOVGtDQ3ROczlHcnM3aE41Ukw1?=
 =?utf-8?B?akVqU3g4eVB3Qk92bkY3dGsvbkh0cDgrUEgyc2NhdCtNQlYwOTZzM09HU0Rq?=
 =?utf-8?B?Ti9EczBiTXpOY3Q2U3dWVWE5MzRRYmZPS2NqVVk1Uy95d1A1Tm5BSFk2eEtD?=
 =?utf-8?B?RStXUkd5TFVwM2RqdUNnMDl6Qno2SHZmd2R6d3d2bjlRNjhSaHNDZTI4c2hT?=
 =?utf-8?B?eHBxRjVqNCttZDNNMVFkSDh0M2U4T0dubVNPTURMTnBWc0VVcHZUb0wrUkRt?=
 =?utf-8?B?WndzRXZKaUY4SkN5ejZLOWtMd2k3UHJwRUYrL1lCYTBkMkl6eEZNSGVENkJL?=
 =?utf-8?B?eHBlb3RSWTdaTGlIU2NzSUJiS3ZvK2p3MVArTXFVMDdpVFIvdzEvSjlLQStI?=
 =?utf-8?B?eUZVdW04T2toeTVyMjFjb0JjSlJBRjFOc05xdWRzRjdqdDczaHJnVEdyT2VM?=
 =?utf-8?B?alpJUEhjMDdGYkQxcWFjazk2VHlMMW9NQ2dQc3pxTERjaWNSVXU2TUpNbDM0?=
 =?utf-8?B?dVo4UDRnT21NVjh3T2R4U203LzJZZU5RbkEwM1pvR3Q3YVJTWnNabG1qcHFq?=
 =?utf-8?B?cGVsQ1pmejk1bkhPaG1SVHRSZlBROVRMNkRwd3Fjd01NY3ZxVEdlV080UDdo?=
 =?utf-8?B?cjFPdExTRWNEZjc0QnZ5d1FmUUJIV2ZoM2Rxb20vaUt1VThDMnRSa3pocS9y?=
 =?utf-8?B?NVhGRE9pOVUrL2VrYUpqVHlOclBYbElwS3FvODQrYjlPR29pVVoyazNmajJ3?=
 =?utf-8?Q?QsJv/HfN+7DZnA7UhKx8hxJxU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4876189a-fc9f-42aa-e15a-08db6a4fe6bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 07:46:01.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6fOaosYmdW/vj2Fjtft8ahJ3OII407W9i+RWXHkrMaOifEBSJasadFXkgd4GisbM8NUMfpMRZoFB1dr+Gka7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
Received-SPF: softfail client-ip=40.107.236.41;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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


On 08/06/2023 21:32, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 6 Jun 2023 15:12:13 +0300
> Avihai Horon <avihaih@nvidia.com> wrote:
>> On 06/06/2023 1:06, Alex Williamson wrote:
>>> On Tue, 30 May 2023 17:48:14 +0300
>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>> @@ -2700,6 +2713,20 @@ static void migration_update_counters(MigrationState *s,
>>>>                                  bandwidth, s->threshold_size);
>>>>    }
>>>>
>>>> +static bool migration_can_switchover(MigrationState *s)
>>>> +{
>>>> +    if (!migrate_switchover_ack()) {
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    /* No reason to wait for switchover ACK if VM is stopped */
>>>> +    if (!runstate_is_running()) {
>>>> +        return true;
>>>> +    }
>>> Is it possible for QEMU to force the migration to continue regardless
>>> of receiving an ack from the target and is this the check that would
>>> allow that?
>> Yes. If you stop the source VM then migration will not wait for an ACK
>> to do the switchover.
>>
>>> It seems that we don't know the downtime allowed for the VM in any of
>>> this, nor do we know how much time the target device will require to
>>> generate an ack, but we could certainly have conditions where the
>>> priority is moving the VM from the source host regardless of the
>>> resulting downtime.
>> In such cases you can keep the switchover-ack capability off.
> How is that accomplished?

You simply don't enable the switchover-ack migration capability (it is 
disabled by default).

>
>>> Also does the return path requirement preclude offline migration or
>>> does the above again take care of that if we pause the VM for an
>>> offline migration (ex. save to and restore from file)?
>> I suppose that by offline migration you mean migration where you stop
>> the source VM first and then do migration?
> Yes.
>
>> If so, offline migration should work and in that case we don't care
>> about the ACK as downtime is not a concern.
>>
>> However, migrating to a file doesn't work with return-path, as you don't
>> have the destination side responding to the source via the return path.
>> For this reason, using return-path when migrating to a file doesn't make
>> sense.
> So we require return-path for switchover-ack, but switchover-ack is
> only required for pre-copy, therefore why do we require return-path for
> an offline migration?

We don't. See below.

>
> If there's a way to turn off switchover-ack capability, is there also a
> way to turn off return-path and therefore enable migration to file?

Yes.

By default, return-path and switchover-ack migration capabilities are 
disabled.

So for an offline migration nothing needs to be done -- you simply run 
migration.

For an online migration, you can choose to use switchover-ack or not.
If you want to use switchover-ack, then you need to enable return-path 
and switchover-ack capabilities first and then run migration.
If you don't want (e.g., you don't have a VFIO device assigned to the 
VM, so there is no reason to), then you keep return-path and 
switchover-ack capabilities disabled.

I hope that's clear now.

Thanks.


