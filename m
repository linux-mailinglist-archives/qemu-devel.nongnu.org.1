Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD77CBC6D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qseds-0001BR-Ea; Tue, 17 Oct 2023 03:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qsedq-0001Ao-Bj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:37:26 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com
 ([40.107.93.41] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qsedo-0003pR-2M
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb1I0RIH1PV+khsV2AakuY22OXv+qvoiNfT77Zu2qDWeyONoBx1XrAxVKsMSACmlBgMKYKs9D9/rTWVBHoZykukKwegyMhGdwfKp+tl/AjuKUNN/nmSCWoCO65zbWGSFA3BcVmEuKs+5ipGNPksZ+Ans4iJ7+6LefnrOdjvN2CzUwaD401QPn8mmkFwwDDDNUoGOwhpLJ3kgAgDhzdLICibryA6lK7T6q1a6lsfa3GP6K1del6hMzAH3VOkqaU/GTD9n3mWMdTD0pbntvcfS6c7ar4714gvgO1uhPHYLQTsWMMRENC9BsKhUJ9mAMbeND6SOeifCYKbhry9V7tSqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5an55Ia5MdCZMW/q2Quia5KwVgQ7hSPEAbd2In8Lvsg=;
 b=bSSgw3IOKb8HSX52At2Y8m+yo6rR1s5KTu/2dHxvuYrS1VqSHQATkk2TRcbKNhaAPMXYC/d7ojy/OHkD2xjGEXw2ifrN0iJf75YE0VoSSR7n6LfV4KLgmeU7b9DZGxOZo+2s38r1OG0v/OIZIVq2BhDzYrY6wcPF9e5HxYsCRtfJc7saBpxKBISNOuTLpiGgSgbquVu9WDC5ZwdgNVmmkx37+m6IX02rzC0scRpfL1p2YW1SiKbg6F+LonluOXUhE+IqNg1+r1sh57dcPXT0+ECHCkIheHFvPpzVFkUfYmKF0t2Ro3bvUEYOYmZnSg/IzREI/rD5eJd4G7FlQo2HAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5an55Ia5MdCZMW/q2Quia5KwVgQ7hSPEAbd2In8Lvsg=;
 b=rvdQEvLHd3nebM+bDuUJ9qTtFWjyHW4pYuSgoRvAts0ZKiwed7xSJ5ejmRFYA15Ah7Nm/icSqv276Pe7HpTlmB5xpbNrtJ6wUTt6kmJANNjiHXejCF+HEH5U/LeAfXciIozHpofS+4b3KWQiYdcXnS9CJO5HQvDS6obZvUoLFPebD0cBSxsRZkChNd6Y5fL+pcPUs6F2Hyw5P2MzRohb2pzQTi+Xvy9G/K71+TTh2wL9OTFXmY4h14G9XWNawvyAXzQSt6w+de2uVWjrVx1sNR19ohM8P1dXVLNzCa2ToIANxNxFk+aKhycj9zo4+u5t06uH8VWaiEesd4e3GzC+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:32:16 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:32:16 +0000
Message-ID: <6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com>
Date: Tue, 17 Oct 2023 15:32:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/5] virtio-net: Introduce LM early load
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
References: <20230918044932.1433744-1-yajunw@nvidia.com>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <20230918044932.1433744-1-yajunw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: ce593d04-f0c0-4f29-bc8c-08dbcee33004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1U0MmN/mVbZWCnlchQqexTiMXIfg3COBgXlo/+W+0DlSLFmNEZFePG+Yo4pU3pfx8wBVY5MwBFMmWG8hyygmrBB5AlKAmIe4YthQQefIAokwZikYQ5fhtRaJ5UH3ez2RaFInK7iqB4UUqhOy/8hLloBND0/R+b2bzJ3TuggCAQHSDdn63C3YNZKGu26yirKJbU9cMMvQ7Pok6FBJzszrqj0xKNCWzFGPSZS0eRbMX5IZvZLeDtv7/48HKIP3QVyIFuBEUWnweJ9cE6odXBw9XGW9wUjJDRkoddJTIOT8L7DSBTbmMesFEBFxtG3MMydQUDJ9NIYWyki9WHy7f4i5oEx+xxyQDuqwjhOsuDEcLp1M/fU2gx5alRT1vT2fVrNCwPrSgEEeRGMJb6pTACxbr0yZHp6mGgaYct5jFoTACmAYIIroq8Oksri0D8nHDVhbhNzxzumkvvLm5y7hInTQLb7n9lp7iOrqqTmf70sp6qS5hFmAuITFGTdhWvrg5kMfixcZ+ZAtSEHz8bKoG7WslpR9XgKNw+TsAtduBSdOqBCza6o1d2Pmfo2rnUmc/kZeYuAF8A91KVBDsoxLyDZH0cwadNm1fkk0HkbVGKg0yufScaZyOAWNnQbonvZy5j94l98uUMabTtxZCLuM/80PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(8936002)(2616005)(6512007)(83380400001)(110136005)(8676002)(66556008)(66476007)(66946007)(6666004)(41300700001)(53546011)(6506007)(966005)(5660300002)(2906002)(478600001)(6486002)(38100700002)(86362001)(31696002)(36756003)(26005)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3kxaDNxR3U1TGh3MnpGQ1BMRkFZRUlES2o2RWxnSGF3TFFpdVJ1SFJZb04x?=
 =?utf-8?B?YzV0eWFYY2RpakI2dkkxM2czQkMyMFNHQTdIbGZPcmw1cDZlYXUvbThvM2Z1?=
 =?utf-8?B?ZjdDc05qWmIvWmNHQ2VVdHdBa2RlMm53MUdhVXhTaG1OSDNuR3lacU1IK1pE?=
 =?utf-8?B?QkRjeUpITW5tSFpUa1daUWYvb2p1b2VZV0xwUU9IVFVaUU5XWmg2YVdqQm54?=
 =?utf-8?B?WE9uNzlVc1dwckJLMHdmYXROUWhBSndpQ1h6TC9BSXl0MUdMTkxBeFl2WVRh?=
 =?utf-8?B?SVNydEFkazEvRlZ2OFJPdGZBZno1ZDNPcWVtNGhRUWZmQ1BESjY4YTRLRlpa?=
 =?utf-8?B?c3ZwYkNSREhZYUw3OE1iYmt4Nms0OFJWVVpOMUJJQXh6SkJiQXo3ODZqYkZv?=
 =?utf-8?B?SER3d0l5eUw0OVRFUjFEZ1ZvRHowOHd2N2tNZUJQcC9lNXU0bENKS1VvK3g2?=
 =?utf-8?B?UENGY1lpMEdXNXRTelRhOUttQ1ptMm1sYmRRWHRjQkZwazdGcFdIUy8xeUV0?=
 =?utf-8?B?VnkxaEtCNC9UYkwwZ1Buam1ERlpyNW9BeVhwLzdDeEVSOGFiTlV6a3BHd0Nu?=
 =?utf-8?B?d0JKQjZlRUlyaFJCcFFvMEFBWG03ZXBBMmxJNFZpK01kQjRGYmlhZ2tKeklv?=
 =?utf-8?B?RlFHWWtlWVBRbHJTNWJJbFNFaEtlUGVYRDZjUjdmbTJqSDUwbWRxdC8vK1VX?=
 =?utf-8?B?SkdXazI5ZGRNRmZIOVY5b05vMTVTQkk4WUdaZi9EaUNncUtSWDkyQkFoSmhD?=
 =?utf-8?B?eXJCOTQzOVNUTHY5WG03bzRvVm9SMEV0TlRiK3BjUy8wNVNVdVdDR2ZiSEJm?=
 =?utf-8?B?L2hZZklMZlpHMzJOZ0xyTndXZHVNRS9NbEd1bmpXOFZTd1hSc2MzSC9wbEZ5?=
 =?utf-8?B?c0xDQmZZZTJ4bXIvejN2UFZnRkdWbHRuMkFXQ0JERmQxRHZhbU8vR2ZPVEhB?=
 =?utf-8?B?Wi9KWVN3ZWdFMTArQVBOV2R6SGNGVE54UDhCR2k2aXo3WVRaTUlUZVZIbUMw?=
 =?utf-8?B?RUs4Snp1RUVkWlYyVW5iU0RCVUZRa3lHMkEzRG05ZDZySC9vVlB1TE5VQVp4?=
 =?utf-8?B?YnZZdzBaa1N1cmFnVTVWd3ZRNjJBK1AvVEFVdVNXNkdQWHMyY3NwYmhleWkz?=
 =?utf-8?B?UWgzclZ2ZEdWb3ZSZ0d3VXdPVHRxV0tBcmxVWFlDTVlFbEh5ZGpKVU1SSGo1?=
 =?utf-8?B?WEk5N2diU2d6R1VlU0VzbURBYU9rOVlmUFBhSGlLM1M2ajhxNGRQKzdTQ0x6?=
 =?utf-8?B?S3I0eDRuUjg0KzM3SlNSWG1GYi9KeE42dGZoV09OWDREY3kvN2VHSVFXbTN1?=
 =?utf-8?B?cTBqblBVVFdacUk2ZkF1WmNzL084d1NWNy9ETElYUHRTTFlNbXVwcTh0akxU?=
 =?utf-8?B?TVhmd2ljdDZrMmNpbVJOYWF6c2ZxdkVvWlhlZXBENml4V1pHMW9vaXJna2tD?=
 =?utf-8?B?cHFuVXZRa212Wm4xTWVGNWllNW5oOEJ5QTNCaDNxZTM2ZWJScXRsb000cG8y?=
 =?utf-8?B?RXlUZUMwQlEyL2tBSnZJOGFDWHNiQ2JDL3Z2RUhTVjVsRDBKaDlMKzdGQWJW?=
 =?utf-8?B?d0lJcUdsa2ZEVFJocjZ3TTI4djBQdStrM1lSbWRyRHdLVTJFVGovK21LY1ZN?=
 =?utf-8?B?SHVJOWRjSzVyMk5aSWxrL3NnRzZRcFMvOUVkanFISGxCdTVtQk5pWEJZV3lk?=
 =?utf-8?B?TVQrS1k4bStKdTFEUDA5S2NUNjExZkZuRGZjclBlWTE2RldhQllZa00wMUhj?=
 =?utf-8?B?MUtON1U2VU9uakpDZWtsb1dWR1pQOXN3K0poeHRiMDJaVHhwNU5jSmJZNVN1?=
 =?utf-8?B?OUh3SzZNZVZEcjdTSHo3ZmI1SmtlSml2TGpZL2tDcUNySHB6dWlVL3o2TDVN?=
 =?utf-8?B?T3l6WlJqcEcrV2E4TWhXSWxlZlpOaFR4dWl3dVZYaVBPcXRNNGpERFgyQlZa?=
 =?utf-8?B?YWtjalZtQXI0Q1d5WnJnekc4eDRYNHFhWUNSdmNGZFRGaTl0eEhPSGVnL1Ex?=
 =?utf-8?B?YjNaZHVvQ2llV2h1ODBhQjcwcSs0Y2w0WGdWc3A5a01yUW5OVUkzNGRIMlBx?=
 =?utf-8?B?aW1SMm4xbjBsQjBmTFV3MWswemgyais2RVdzdmN4Ull1VElRSXJ0Z3JNZGJw?=
 =?utf-8?Q?ztbWkWimGx0pFRqhkpOc+o2V6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce593d04-f0c0-4f29-bc8c-08dbcee33004
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:32:16.4788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glWtIfAgz7jiCLrgtQiBZqBT5jGZlWivOqWfLAHcUvhfuIT5BN7h7eC5QphaVGCMYXo7dhAZkJIq0r/Vf7k1Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
Received-SPF: softfail client-ip=40.107.93.41; envelope-from=yajunw@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Ping.

On 9/18/2023 12:49 PM, Yajun Wu wrote:
> This series of patches aims to minimize the downtime during live migration of a
> virtio-net device with a vhost-user backend. In the case of hardware virtual
> Data Path Acceleration (vDPA) implementation, the hardware configuration, which
> includes tasks like VQ creation and RSS setting, may take above 200ms. This
> significantly increases the downtime of the VM, particularly in terms of
> networking.
>
> To reduce the VM downtime, the proposed approach involves capturing the basic
> device state/configuration during the VM's running stage and performing the
> initial device configuration(presetup). During the normal configuration process
> when the VM is in a stopped state, the second configuration is compared to the
> first one, and only the differences are applied to reduce downtime. Ideally,
> only the vring available index needs to be changed within VM stop.
>
> This feature is disabled by default, because backend like dpdk also needs
> adding support for vhost new message. New device property "x-early-migration"
> can enable this feature.
>
> 1. Register a new vmstate for virtio-net with an early_setup flag to send the
>     device state during migration setup.
> 2. After device state load on destination VM, need to send device status to
>     vhost backend in a new way. Introduce new vhost-user message:
>     VHOST_USER_PRESETUP, to notify backend of presetup.
> 3. Let virtio-net, vhost-net, vhost-dev support presetup. Main flow:
>     a. vhost-dev sending presetup start.
>     b. virtio-net setting mtu.
>     c. vhost-dev sending vring configuration and setting dummy call/kick fd.
>     d. vhost-net sending vring enable.
>     e. vhost-dev sending presetup end.
>
>
> TODOs:
> ======
>    - No vhost-vdpa/kernel support. Need to discuss/design new kernel interface
>      if there's same requirement for vhost-vdpa.
>
>    - No vIOMMU support so far. If there is a need for vIOMMU support, it is
>      planned to be addressed in a follow-up patchset.
>
>
> Test:
> =====
>    - Live migration VM with 2 virtio-net devices, ping can recover.
>      Together with DPDK patch [1].
>    - The time consumption of DPDK function dev_conf is reduced from 191.4 ms
>      to 6.6 ms.
>
>
> References:
> ===========
>
> [1] https://github.com/Mellanox/dpdk-vhost-vfe/pull/37
>
> Any comments or feedback are highly appreciated.
>
> Thanks,
> Yajun
>
>
> Yajun Wu (5):
>    vhost-user: Add presetup protocol feature and op
>    vhost: Add support for presetup
>    vhost-net: Add support for presetup
>    virtio: Add VMState for early load
>    virtio-net: Introduce LM early load
>
>   docs/interop/vhost-user.rst       |  10 ++
>   hw/net/trace-events               |   1 +
>   hw/net/vhost_net.c                |  40 +++++++
>   hw/net/virtio-net.c               | 100 ++++++++++++++++++
>   hw/virtio/vhost-user.c            |  30 ++++++
>   hw/virtio/vhost.c                 | 166 +++++++++++++++++++++++++-----
>   hw/virtio/virtio.c                | 152 ++++++++++++++++-----------
>   include/hw/virtio/vhost-backend.h |   3 +
>   include/hw/virtio/vhost.h         |  12 +++
>   include/hw/virtio/virtio-net.h    |   1 +
>   include/hw/virtio/virtio.h        |  10 +-
>   include/net/vhost_net.h           |   3 +
>   12 files changed, 443 insertions(+), 85 deletions(-)
>

