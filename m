Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D159C7CD49C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:41:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt0F1-00030F-So; Wed, 18 Oct 2023 02:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qt0Ez-0002ns-Fz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:41:13 -0400
Received: from mail-bn1nam02on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::61d]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qt0Ew-0002P3-NW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFbEyLvbXdI8mu9mb+SJcBLfC0lyoTnb4ZjTALP/N9i1GwfTWL0bL++qXm1ntvQJtXdpfHhePhqV2m5tuDMIOe1wSmIp3+zX5QIqWb9iSeI0ZVQHMwDQ79EsPfvDZrBGDOU7RkexRCYAOT0ZjDweczUvkLMwo597DV843vmzZOl/N4akxHPEZdQjMTEs7bksVz9UbwdzmRBuh+YBzvK/GTG6QsMeecxAR/lHc23jCCOBvoQ6EDKkuJ/cIbzFK550z/NnN/ixdMeNXuo9ftrmSO94lq44d31P7JMwChO389RV+S3C/fg6QblTShovEeoVaBr++ocOx4MqTPncMeDJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ATC3yBhYSnZfnjE9y0D1uUVU0FE9e3SkWVhU21BX3Y=;
 b=N9SyF/dWjm2TFf9auBpYCPLpGUFxLQH6f4lF+whA3xeLQeQoG8fZgJJcSjjtmsJ1ZYQcY3wJa4SZlMaiHK6lI+Q6jd24q0AFqU0aleQR11IF/eCInvnBipjYF0bEwXblVKyHAIAdUs6Ijhc2P/KSKYFthH2fhIDlSbUKfNoK/wHhyH/BvdkW6UC7qPV7fPAzQrCfcvOVd+0dEn40OKJLC0jZkg5H8UOsK9uNpAKa9C2/qpD/IaRYjORsR8rW9a1wDL5pfCXeDNbZhag8mAZG8/ritYJY2cpHBOcSTKbrnjRWRi8SWxX+Iit0l2pyRrj/S5eS0+kZLjpTD6PblCMgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ATC3yBhYSnZfnjE9y0D1uUVU0FE9e3SkWVhU21BX3Y=;
 b=AjT84x44WvEoHqwfZTVvpWpKmQY7nc57Jx79XkTD6+s3vkKLFb9SRzKehsBK0XjezxxoO/sKpXDYcpBg0lyaSWWltpCTnxJukVij4TaqwoJUfgm2nu344tzdWbbZ6VufwKlfnFY9bEbMqwCQs85QLVTvjU4YvNp5gqXlns4hg4OquEDIwdgj6//bbTuIeJBB2SJ59F6snLzn/IbZf45J1dB2qbA+sKqDaDNlxqJuCK0PoeGgQbfjc1CxAPYD7JgO+HQf+EbYxIQQ1zi4PrV6fv5ETU7OEhJMwWl11x2U0G/OTWMUq3PZVfplMqh1MVwFhaGDwjnK3qA2Q8tlZf0Eyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 06:41:05 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 06:41:05 +0000
Message-ID: <6d9b034f-fe16-7ed8-6156-9c404a860489@nvidia.com>
Date: Wed, 18 Oct 2023 14:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/5] virtio-net: Introduce LM early load
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, parav@nvidia.com, jiri@nvidia.com
References: <20230918044932.1433744-1-yajunw@nvidia.com>
 <CAJaqyWfuXDY7jBSQsS=0Ws7mpZLcsed6bpQbM+eZGLU5AzCw1Q@mail.gmail.com>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <CAJaqyWfuXDY7jBSQsS=0Ws7mpZLcsed6bpQbM+eZGLU5AzCw1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:820:c::12) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 48662754-037f-4fc4-a6a5-08dbcfa533d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BM+CsaznwMVJWYYA36KE7XKPjffxsV8pEqLzzEk3wab5X5+x/IiOWdNjQrmIECAg2Z5iT9ENyM2lbf5ZGggcefCfX9iiPFgu7wv46+XKBde4/G8XTQRWb88FWcvNYKGTkMb1A3KZKinFUesKBeHD+s0iikw5fR8FMtvxIfwW2mZH3FU+pYPKp+ea6dOTx9jr56O37HTqhz+HDNRPpPbgsXuqpmUo5IHAzgUPZafvvUzgaGtLhMXVWfwoDx2t9b93aEcOhHaQA891rzccm6dKcakXf+tA9vNiv5flOl4Xe97ACBiMdYI+YH9+0LRURT5GMOAps9++cojp/M5wWfk1YCtDuC4KTvwXreYZebOfMrPI6/S4iqYtsilDMv61J/3Y7QFIhNVzFiQxPy6lWBmhYCcWDHq4WapJXA/WZKTuS9FHhyhl3MWexBhVhj0qm1vVJi1UBkh875n87joEbqCQasB1YM4MesMs//TOZge8q0zLsa6gQYDK7/bXJ1mNIFNGi0P6801biVOxgvso+OYV2KzERSlLzfOmU/dbGXv6zqTRh1ajdYFThwQg7vRuhmnicX3SErkfVjn/iqcHpFz9eM67OJdDDYEZLBJENCC+ZPoEK1nrVE5AJOikFxAdfgdQfaqGFAhntdhqVMM4lYhqrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(31686004)(66899024)(36756003)(66946007)(66476007)(66556008)(316002)(6916009)(54906003)(31696002)(2616005)(38100700002)(86362001)(83380400001)(53546011)(26005)(6666004)(8936002)(6506007)(966005)(107886003)(6486002)(2906002)(8676002)(478600001)(41300700001)(4326008)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNVRlI3Ly9obk1uTklCTW1JQWxYcm01RE9RSFd6MnVVSEZwZkFlUEhoUkpR?=
 =?utf-8?B?d3NYN3hDSURad1g1YlFuUktGVW5Wd0t0eUFYcDI2RnJTaTFrNDFtSG9sN1Fw?=
 =?utf-8?B?VlhBY1pzd3ZheitySWI2b3hyY0hTY1M2Z2FCVTZyaUVuUzJra21LVGF0K3RK?=
 =?utf-8?B?ZXlwOXUycmN0Z0lQQXc1UXNqSEd2cmlMc3ZidytTNkFRa2tVMVdyZGtqYU9K?=
 =?utf-8?B?RlNDZFhFTjg1QUZMcmVCbkltMHVDNjBOenhjV2tpZVIvVUwycGlUODJLQ1d5?=
 =?utf-8?B?dzZSZTYrMmR3OHBJUzRQZEZlenVmQTJCVkVlcDB0eWpOMWM3alBJQXNjdWYw?=
 =?utf-8?B?NmRCYWJLNURxRDQ4QUdTekZwWUovK21BbTFTbXNGbk5jZFJYT3U1Y2doQW1o?=
 =?utf-8?B?YjBSdHh1QU9mNzJacVVYc2hEcXFxSjc0MXplcmg1SCtBbHFaazFwTnNCdi83?=
 =?utf-8?B?VjgyMTFKTEFQdWtDK3l2WlBBOStidEIvOGxwai9Kb0kzbzR6VjZGUTUvUnAz?=
 =?utf-8?B?TWd1cmhGaDZmRURKRXpqMGluNlBnblNxNGRwaXp1Y3VXYXA5djNOUmtNbnRl?=
 =?utf-8?B?WGVpNnM5SC8rYm55NUlKYTVlVXcrMWFLVTRhRitIT0pXUDZrZkRzdE1WSFhK?=
 =?utf-8?B?TXo0d3VlckFBc0FNR2svQzJybU1La2pLT2lBOWNIakVHK0tzZCtkU3ByUDY2?=
 =?utf-8?B?YkdCTW1IbVd0ZEpxdzBFdnIzcnRlRU9rUUY2WE1Ic3U3dllaY0pKUWdSb3Z2?=
 =?utf-8?B?QUUrNWJWUDR5dGhTL0R4QmNiWGxSS09vbGZBVmVPbFFUOGU3aE5tbEhYZGo1?=
 =?utf-8?B?Q09aYjM2c1VLMjNWc0Y4cU0rdmZHNExtSTl3OHBVb1VML3lzRjhIZ2YwRDhk?=
 =?utf-8?B?OEQxTHF2REhQU1Z1ekxvcnZZQWtHdGNFcW5OMU9rOWFucjRxeFI5azBoVlR0?=
 =?utf-8?B?RXlWT0pwYU1tMHV0TUNRa1NxeERaQ2VFcjl6SkNEcXI5WVROaTQ5cWJaMmNT?=
 =?utf-8?B?QnJSRGVlcWl2NXc4RCtoWkQraXlObTlRZEVLc05FTWR3VGU5blRPc05mMDdv?=
 =?utf-8?B?a3dJUDJ3NHhDRU5lTnJ4SkRxc3hxNUhjc2RhUTZFUkNhMkxhUE1yVmxhclhE?=
 =?utf-8?B?aFkxM0JacElDbVJJay9pVXdQOXVXMTNPb1NQclY0Yk0rM0ZDZlRXckk1MFpo?=
 =?utf-8?B?NXhVKzRhRWN6eDg0K3EydzZWaVd4L056VW0vSnVvbHFRZnNLSVNBdTZsallI?=
 =?utf-8?B?WElwNHk1S09tWmM3Q3FHUkNOU2Y4OVdEUHlsL1E0MHUrajZPQk1meWFsV1B4?=
 =?utf-8?B?MTlVRWFnN0I3YTZQVGR5NFc0d28yOVordG9jNGxIVTNpRTdTNEFjYmsxK2hJ?=
 =?utf-8?B?VmdiSHE4em9Bbk1DN3c0VFAvR0NqTDEwMXhqazdBZ3FzaG9GK2g2aTlPK0ZG?=
 =?utf-8?B?cnkzbjY0NDRYQWVUbTZHbGxRZzkvaEJER00wb3J5SHdXZFRzVWpldjFlUkxy?=
 =?utf-8?B?alVtMEVGUTYyazFLTG92aDUwY1k0Wko2aDRldVF0NmQ0SUlzSDdWeUI0NWpn?=
 =?utf-8?B?dTk4Mi9Sd1BxbkFjazIrcWdGMTRxZWpYRGZFUk14YmtCSEZ6TnF2b1JIdjRG?=
 =?utf-8?B?ZzR1d24zSW5IeXMwQkhWK0FPOEo4Z0tGOHhHZ3cwWHNXNThHZkVYcFp3NWlq?=
 =?utf-8?B?cnZwYUN2dDRVb2NnSll2aEc5dG9sNm1ja3JhV2dpa0dEeG54bmJPTzU2UHVa?=
 =?utf-8?B?VjR0NTAyekphcm5CNnZiZnNZQmZPandXYVVIYlVwUThUd0JiSU9RR2dKclRk?=
 =?utf-8?B?REpubmcvdmZkb2Q1TGZqWjNCU2hzQlpxY2trc0laT3U2RDNoaVZEclZFNEdn?=
 =?utf-8?B?ekFoSTFJNkVTbzR3N2doUWEwdnlhVEdpS0ZJZDUzUUE4N21iUjVKNGlkRzNi?=
 =?utf-8?B?S2xYYVhYeFYvTXhHRjlpbzJaR1RwalgvQktnVTJXaFpXOW92S0VCQzJDaS8r?=
 =?utf-8?B?MmZHbDA0NUtmalNveXBZNk1QZjkySjFWSHBKdTJKUnRQNUs3eFBvUjFSZG1T?=
 =?utf-8?B?Y0dXSjdvNHdXUGdYTFpFMGFDbi8xdXRqRmhybWxNclpSM082S09RVURWYmxJ?=
 =?utf-8?Q?OOOz+Aj1DP/gBMwNhVh5RhyMs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48662754-037f-4fc4-a6a5-08dbcfa533d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:41:05.2788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU8VVQYWA6jjJ3L64vweNA2sz60WxzT+aDlQCFlRQNEYaOpwVsdISbuwYu+TpElF4AXCFGYdh8T3YgWlekLEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::61d;
 envelope-from=yajunw@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, SPF_HELO_PASS=-0.001,
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


On 10/18/2023 12:47 AM, Eugenio Perez Martin wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Sep 18, 2023 at 6:51 AM Yajun Wu <yajunw@nvidia.com> wrote:
>> This series of patches aims to minimize the downtime during live migration of a
>> virtio-net device with a vhost-user backend. In the case of hardware virtual
>> Data Path Acceleration (vDPA) implementation, the hardware configuration, which
>> includes tasks like VQ creation and RSS setting, may take above 200ms. This
>> significantly increases the downtime of the VM, particularly in terms of
>> networking.
>>
> Hi!
>
> Sorry I totally missed this email. Please CC me in next versions.
>
> Just for completion, there is an ongoing plan to reduce the downtime
> in vhost-vdpa. You can find more details at [1].
>
> To send the state periodically is in the roadmap, but some
> benchmarking detected that memory pinning and unpinning affects more
> to downtime. I'll send a RFC soon with this. The plan was to continue
> with iterative state restoring, so I'm happy to know more people are
> looking into it!
>
> In the case of vhost-vdpa it already restores the state by not
> enabling dataplane until migration completes. All the load is
> performed using CVQ, as you can see in
> net/vhost-vdpa.c:vhost_vdpa_net_load. After that, all dataplane is
> started again.
>
> My idea is to start vhost-vdpa (by calling vhost_vdpa_dev_start) at
> the destination at the same moment the migration starts, as it will
> not have dataplane enabled. After that, the source should send the
> virtio-net vmstate every time it changes. vhost-vdpa net is able to
> send and receive through CVQ, so it should be able to modify net
> device configuration as many times as needed. I guess that could be
> done by calling something in the line of your
> vhost_user_set_presetup_state.
This is very good approach. How do you know when virtio-net vmstate 
change? vhost-user and vhost-vdpa should share same code of virtio-net 
vmstate early sync.
>
> This can be improved in vhost-vdpa by being able to send only the new state.
>
> When all the migration is completed, vhost-vdpa net dataplane should
> start as it does now.
>
> If you are interested in saving changes to vhost-user protocol, maybe
> qemu could just disable the dataplane too with
> VHOST_USER_SET_VRING_ENABLE? If not, I think both approaches have a
> lot in common, so I'm sure we can develop one backend on top of
> another.
>
> Thanks!
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg00659.html

I'm afraid just like DRIVER_OK as a hint for vhost-user vDPA to apply 
all the configuration to HW. Vhost-user also needs same hint as the end 
of each round vmstate sync to apply configuration to HW. That's why I 
need define new protocol message.

Because of MQ can also change, VQ enable is a valid parameter to HW. HW 
will create only enabled queue, number of enabled queues affects RSS 
setting.


>
>> To reduce the VM downtime, the proposed approach involves capturing the basic
>> device state/configuration during the VM's running stage and performing the
>> initial device configuration(presetup). During the normal configuration process
>> when the VM is in a stopped state, the second configuration is compared to the
>> first one, and only the differences are applied to reduce downtime. Ideally,
>> only the vring available index needs to be changed within VM stop.
>>
>> This feature is disabled by default, because backend like dpdk also needs
>> adding support for vhost new message. New device property "x-early-migration"
>> can enable this feature.
>>
>> 1. Register a new vmstate for virtio-net with an early_setup flag to send the
>>     device state during migration setup.
>> 2. After device state load on destination VM, need to send device status to
>>     vhost backend in a new way. Introduce new vhost-user message:
>>     VHOST_USER_PRESETUP, to notify backend of presetup.
>> 3. Let virtio-net, vhost-net, vhost-dev support presetup. Main flow:
>>     a. vhost-dev sending presetup start.
>>     b. virtio-net setting mtu.
>>     c. vhost-dev sending vring configuration and setting dummy call/kick fd.
>>     d. vhost-net sending vring enable.
>>     e. vhost-dev sending presetup end.
>>
>>
>> TODOs:
>> ======
>>    - No vhost-vdpa/kernel support. Need to discuss/design new kernel interface
>>      if there's same requirement for vhost-vdpa.
>>
>>    - No vIOMMU support so far. If there is a need for vIOMMU support, it is
>>      planned to be addressed in a follow-up patchset.
>>
>>
>> Test:
>> =====
>>    - Live migration VM with 2 virtio-net devices, ping can recover.
>>      Together with DPDK patch [1].
>>    - The time consumption of DPDK function dev_conf is reduced from 191.4 ms
>>      to 6.6 ms.
>>
>>
>> References:
>> ===========
>>
>> [1] https://github.com/Mellanox/dpdk-vhost-vfe/pull/37
>>
>> Any comments or feedback are highly appreciated.
>>
>> Thanks,
>> Yajun
>>
>>
>> Yajun Wu (5):
>>    vhost-user: Add presetup protocol feature and op
>>    vhost: Add support for presetup
>>    vhost-net: Add support for presetup
>>    virtio: Add VMState for early load
>>    virtio-net: Introduce LM early load
>>
>>   docs/interop/vhost-user.rst       |  10 ++
>>   hw/net/trace-events               |   1 +
>>   hw/net/vhost_net.c                |  40 +++++++
>>   hw/net/virtio-net.c               | 100 ++++++++++++++++++
>>   hw/virtio/vhost-user.c            |  30 ++++++
>>   hw/virtio/vhost.c                 | 166 +++++++++++++++++++++++++-----
>>   hw/virtio/virtio.c                | 152 ++++++++++++++++-----------
>>   include/hw/virtio/vhost-backend.h |   3 +
>>   include/hw/virtio/vhost.h         |  12 +++
>>   include/hw/virtio/virtio-net.h    |   1 +
>>   include/hw/virtio/virtio.h        |  10 +-
>>   include/net/vhost_net.h           |   3 +
>>   12 files changed, 443 insertions(+), 85 deletions(-)
>>
>> --
>> 2.27.0
>>
>>

