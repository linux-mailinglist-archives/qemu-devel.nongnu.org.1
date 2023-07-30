Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6893C768435
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 09:36:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ0GW-0007uP-Fi; Sun, 30 Jul 2023 02:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQ0GS-0007uG-1j
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:50:52 -0400
Received: from mail-mw2nam12on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQ0GP-0001cs-At
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:50:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWTCMupwNNY6sZS0HdHKW16YDeb5FyaYGE8bIQAMherVP1xrPgp9D9Z8SSYzt2tLDuBbXi02ykKIKYlVWVWo2rlBbTPCVntmv0R8bJ/aSORvDdkqIPcx9I/mLFWVP8bbB3yzWTwa8hmQEHKutIyDmwpAswAaM4Zn4Ccvky8I1cS4bObK8PBgPhcRybqNygkCFhXQiooda+bfcz7mXNQBI41OESnWsq2FtNPl7d60W3dhiNLOTF6avlFtAtJsVjN/eRUPJVCLQdhWvNPS7b7ds/2Qw7KFNFR560teI/9Y+EzutScchq693Qozrx69tr9A1tzOpTkprybrkL6Q2bJvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU6hTjXxSThRVsL6Sl3vTH84c9mnpy98BYv8v159Vjk=;
 b=JRpxAeQ806KDT70SqYu9B3ToxVKrEbYqsDSuZfW/XHwr0uapC9+r4o1D6q5cJAc24Z5zAlnRTFr0Txi9/+ytZ2K4gN1w42wI4su3uIYgXQFFVGKWvVjA+xlUGm8j2TUrwVtlrYEP1Eu8yeS1AK3TCgvd8wmQS/ZDJOiHcP2EXJqloZNDIbeVR4tO/qMQWdvX0xT1Om6ZqIeuD2bqBaKM8WKUz6cNxH/GoIllau50VGUC/YZDL9rmLUnFVvXQT0vkxssuGUuoFi2k7eX8uWeVEx21bkgRhK9a/tp8k+K9CGbSgrO/yK+eJ5SZxfJUsN9xfAKv0pKkfxavSjKDxjgU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU6hTjXxSThRVsL6Sl3vTH84c9mnpy98BYv8v159Vjk=;
 b=aEkOJpXeACfy+tcso9KMygdgzj55D8cOesU0NJzWU1Reauw+nUq1sNqyZJnAO6x9vpn1+Mc7HkSy75TBwQ/WEjhWBmXnSjdiJj3w2vfVKO1s7TwzqRDDH5FWAzIAbH0ls0RnjJpF1UrYXOycrrJxKkMJFF6l+RO91f66Gxib6ulHgkTYB8GD/OnLnT2haWrbSK7EYqPLhQCb09r0nILJj45q6qjtxTqFgFFdiEOnJleCNoXWwiRFzEQWzwipXjWnmAhDjvd8hNcLyZbYdIbIcmzHao3d13dM+vBiDT/9Q/pR4XOIaYnty3VSLYOZSbR26LoOxDLwoMaGa8vbPapWNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sun, 30 Jul
 2023 06:50:44 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 06:50:44 +0000
Message-ID: <9d36af6e-01fd-f33d-d124-4850b479be6b@nvidia.com>
Date: Sun, 30 Jul 2023 09:50:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/6] vfio/migration: Add P2P support for VFIO
 migration
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <ZLazufgTjVliQ9mJ@nvidia.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZLazufgTjVliQ9mJ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0179.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::36) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d55379f-5c8a-49fa-13b1-08db90c94be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlofQJGOz1u6z4QFv70vsIIMOyorLHxNfpuIeo21eSxfMwicXc4GYfRESsx3GwyIP86NUPeosbewjJKVhvIGPu8x0hIOAl8/Eulji3xq7dQAQyVPm3qQqij0X6jhb94lo29dQywQdIjhdY+i2sKFNpOTo41Sk4FQoTmUERK9BYYZoLXr1TlTFI2m5425MOJcE4wDe0hB5Y9ltN+ZD8CFWMRBCC+1ImJqFD2LFXnZNuFvAUz0+cbahBDFpVM2fMk3RZw7ha7T+yS6NCWRPj6qCKiLQ8ExoEbndCe7M1weoaIteo1Ts11UpfU7HtFohhodv2pXAubB/TBBkvZVvpdibUWUR2pkOsWhHqMz5Z9tmiEcjmuhyvKBK9JDwGq8VDZtKNcdYIvBvoijo234IQmvYNUPZdKt9FUJer/6TszEqEVk0hrxVDOYgJfF1i9NohY//wZohL028Roh2Nta2o5BeEctemF0I8H9d0MrK0uwy8M16mKBhoLbwxsiiJ8ZJ3xdvfpsN9tx7SRCDIEOM3efm6nvvbOw/pSam/IsyxoN+ipd8OxWW3xERug5xGGtaBAYS5HslJIx6OOCQjDvmi6KVW3ZNuDpTC+5wM27c+SmU0apy7knMSrhr+vKcU1hTTUS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(4326008)(6512007)(66476007)(966005)(6486002)(478600001)(6666004)(37006003)(38100700002)(54906003)(5660300002)(2616005)(6862004)(66556008)(6636002)(8936002)(8676002)(41300700001)(66946007)(186003)(107886003)(316002)(26005)(6506007)(53546011)(86362001)(31696002)(2906002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXY0L1VKd2w4NkJRQXhSWmY2b21XVnZuMG5jRkpGL3YwTjNiSUhMZG5EZmVp?=
 =?utf-8?B?dXRkVmJYOFg3eTJNNHM3V2JVa1U3Szh5Zk9aZlljL3oweEo4bFRMQVJoVEFY?=
 =?utf-8?B?MDVuampoSFhScGJFNzdsSmZTbVRmb2w4bi9sWmxGSHI2N0tXRTRqemtNYlMv?=
 =?utf-8?B?Rm5CMTQvSnJoSmkwN2JTaTJ3a0tGaUsxK2dIbjRFWmZja1lheWxiRFpoR3lJ?=
 =?utf-8?B?K0ZZME1hSG43eXdyODBhT0F2aGx5ZENDQmpVTGIrMTcxTFZHdFNxK0J2SDZV?=
 =?utf-8?B?Y3BUdEJKMUE3c28zMW1ETkY1K3J0SEdpaFEzUWMweXlhTlhFa210Z2dsOXht?=
 =?utf-8?B?dVlPZmllOXhickFtWS9YTm12MjBoVkwrVmxzblBjT3oyaWNmUW44OVBwbnZU?=
 =?utf-8?B?VEhpamlERHd5WG9ub1dRZkhMUU1pVUNGVGV0RTN4L09yTTRkaVkyWktvTWFk?=
 =?utf-8?B?Z1dkbklPMElWeHJjdDRmWkZmT1ZFZzBqWVdhWVZkR21zNGJ1ZkQ5Vy9rdEN4?=
 =?utf-8?B?cGNNTnNwL2xEaEZXa3RBZmRZWFh3T01Db0tWVnIwKzU2eWVEK1QvRDI4V3A1?=
 =?utf-8?B?SDB6WDlzR3RuZDJIOUNxQXVHTkU4VEVoYVBKbHRleitESHlUbXNWcndOeWFm?=
 =?utf-8?B?dE1iRVN3aHlNNE9UTm80aWRwQTU3SE9rVUhoa3VrOFNmQmNkcmVFM0xnUkJV?=
 =?utf-8?B?YXl4cnJtcC9lbjc2RFkzY3BLbWFMd1Vma0FyOGt2ZWprM2xwZ241TFNVTTFh?=
 =?utf-8?B?UnJSQ2NLSS9qZVlYMFc4K2V5bTUwYXVVVlhmUSt1Uy9pTHd0cVc0enZabmc3?=
 =?utf-8?B?WjhCcEhmdDBZUENIMzJ0dVBxYjhqM293RCtGeXYvUHVPK0lDMGRISTFQckpJ?=
 =?utf-8?B?dEwwWmNNT2V3UmJkdk9UL0FKbGxKdXdZdDZrRVVxdjRBWUI0M3N4aWV3MTY5?=
 =?utf-8?B?bHNQRDZWUjVJRmZudHNmVGVFWFdEUWhIMkVVZmhVU2VjaitpMHpRajkwMHBv?=
 =?utf-8?B?Y1Nld1dUL3ZxLzZxcGhXMVpTQlZpZmJ3Mk5sVkFLTzhKTnJXLzMyQ1MzblJT?=
 =?utf-8?B?cWQrb1RSeEFwVHRsTGx2Y1NDK0ZVbkc3bjBrQS9sNFdZdHBpc21jUjhUK25E?=
 =?utf-8?B?eG9TZTJoVVZVVUNMa2d4RjM4SXJiQnlHQXpDZHdPWXU3M1dTanM5RGNxTFRH?=
 =?utf-8?B?NG5ZUXNGK3h1bThYZ1JKUG9KUjRlN1lzTDdyaThWWWlXaDZJWGpJa2Jab3dF?=
 =?utf-8?B?UFZSZVZzS3lTbE84NHRNOGNrdmJ3d3p1cXZ4ZkpzOFNjT2pUNnI4Ni90QXNS?=
 =?utf-8?B?T25LdExMSTZRbE8rY1BwZk9jRE9GbSt3WmZodEJqMDFpM3hJaDBrOXZmUm03?=
 =?utf-8?B?TGR6SEg0YlBxZTRJeHZUZ2xSSUJFVVFtTEpsK09uNERraVA0d2syZ2xKdzBK?=
 =?utf-8?B?L1FmcUxFa2VTQW96RXM4aXcrakVGLzJjbzBjd1hWcTAyV0NYUHZPVWhZNHk3?=
 =?utf-8?B?YTlZamllRkNZanBBTktRNjhYTU1Rei9DcVVLRmVXd1Jja3YyNkNPRkNvTWZh?=
 =?utf-8?B?dkU4cXdiWW9DKzNabVBTV1dFU1lIR1ZOVEtlQkdDdVpIY0VpYzVBZXhLOE8v?=
 =?utf-8?B?T1dsYlFHemN3dGpodzFvUitRQTZrclVLSk0vMkEvUnJWODJMWWF2M0xzMmhR?=
 =?utf-8?B?OEZXODE4dTVDbDQ1dDdIdmFXckdETkJhb2FZVnB4RGg0N0EvekNINkxGSXVK?=
 =?utf-8?B?QUUva3pFejJoNXJUSWNwMjFnaW1ULy80bk1LZytEQ25GVXpvUDlHeGFnU0Qy?=
 =?utf-8?B?R0xCckJWYXRFOXNtcXdBNjA4Qk1PSURKbjlBclY1Q2FrcEpJZHlZQitOTUkz?=
 =?utf-8?B?RW1GelZTd29td1BRblM2M1k5VDFNRTRFbWd4Ny9tMUhRQ29LWHk2NU1zYkJH?=
 =?utf-8?B?Rm5FaWYyQXV0MTFodVlYa1FPNHozZlZhWWV2ejNOdnhrQmVZWnJYYmNiamdP?=
 =?utf-8?B?M01hd21GTVlFUzRDWXZrbnhyTll2Sjh5VFd4M1R3d1k0bWlmeVR6L2tQS0pW?=
 =?utf-8?B?TllOWmlqSUc3Rlh6ZFp2ZGpObHZ3dldXcnVBeXlpTDFYM0NXaGR4WFZFdk1T?=
 =?utf-8?Q?RpNImNKcO/zmVoq1MPpm8rZEY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d55379f-5c8a-49fa-13b1-08db90c94be5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 06:50:44.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFNJ103Y2iCGtnyCJAXu04VeqRD93tRxySQuZJPKGnv0yV4OQ/xmpJMbu2k2yH27fcWJ44cNw2wA7Ph+zO5zFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::60d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 18/07/2023 18:46, Jason Gunthorpe wrote:
> On Sun, Jul 16, 2023 at 11:15:35AM +0300, Avihai Horon wrote:
>> Hi all,
>>
>> The first patch in this series adds a small optimization to VFIO
>> migration by moving the STOP_COPY->STOP transition to
>> vfio_save_cleanup(). Testing with a ConnectX-7 VFIO device showed that
>> this can reduce downtime by up to 6%.
>>
>> The rest of the series adds P2P support for VFIO migration.
>>
>> VFIO migration uAPI defines an optional intermediate P2P quiescent
>> state. While in the P2P quiescent state, P2P DMA transactions cannot be
>> initiated by the device, but the device can respond to incoming ones.
>> Additionally, all outstanding P2P transactions are guaranteed to have
>> been completed by the time the device enters this state.
> For clarity it is "all outstanding DMA transactions are guarenteed to
> have been completed" - the device has no idea if something is P2P or
> not.

The uAPI states that [1]: "If the device can identify P2P 
transactionsthen it can stop only P2P DMA, otherwise it must stop all DMA.".

So I will stick to the uAPI definition.

[1] 
https://elixir.bootlin.com/linux/v6.5-rc1/source/include/uapi/linux/vfio.h#L1032

>
>> The purpose of this state is to support migration of multiple devices
>> that are doing P2P transactions between themselves.
> s/are/might/

Sure, will change it.

Thanks!


