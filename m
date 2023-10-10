Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E767BF1C8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 06:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq3vN-000540-8p; Tue, 10 Oct 2023 00:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qq3vI-00051x-U5
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 00:00:46 -0400
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::623]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qq3vF-0001g0-08
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 00:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez3isIo9QD5GirS/4jtkdvNKWnqaP9PL7RZwXlaeUsyKG71+Yv6+ZukgA6iLxs55pZTKbLKP/ZIyPZ7tRLLAtMFo9SravnhP8RVqiHu3UR09pTBSa8B8MCdoiaFuIkq4lsmQAG0t6MfqOnp9tM3OHxE5sZhnRgUCT7mugejkroM5OM5mH2KTuiEVZLntDrxa3Zv/hfW+ceHAOmDIxnswvSOHDL8leeA7GG94cSpHR35eYbnq9HmZe0z7Dit/nMJmZ6TadIHL36kQ+xswyPAGHVS2C+eAQUzGGIUEI8oQz5EwRNxPHMpmVHYUhxPYngJFA1Ng9fRCj0P0p8yh7UaeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8Zra/PXAjHgVIJjRuvANURR7Xa9CdizTuESxTAbytI=;
 b=eOIalo3hhyTjGV+FXtidRTwi/StD95Mxio5ATuj527Sa6qy8eLpvmqffktZRCYC8+e4sBw+nVWOoMYaLKmsCpGRsy10PAYCql4QP1zebZC95nxZbWq+OUrGKulT6asKrjoVrrMGyGhIyjOzXkEPf9897mqjZ7UYgCTd1y583uu2unWLVGQTidS2ZnEVlTe4Psk96whDZt3ScPKj7/tENYtAwbbbADSJpGt4t4+ngmu5vp+0jQgxNhuJ/FPwGcLlUTBAX2DKQCx3HViDsWCVr+IdS8gN1SxH5tNuqs1nKRpuGtOqWDUupkWvG9thkIlbrCiDoU7yDyCdojQy3go0NeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Zra/PXAjHgVIJjRuvANURR7Xa9CdizTuESxTAbytI=;
 b=oP/wT+jjPSTz8+WG+6czvAEOcmnSLSc/NTkgrexcr/9pZKjGo9SqKwf6mYkASKTm0DAwwila+hZj0XsklPGIqDaJxASRFA1JIyCA81ctLzsFnCkGYR6Z0ap5/fLIsXrtG4VTvJ7d7O9GKJ+XUGTYgZOuSGjMHPywEJe8xQizDCJocmhuD+tt85qgBw/4+karb0WwZ/Eg699imnGoO/zsXnXxUSbKJaXLWed/xi+TDt1YSZno4UFYF2niqEeDivxEuDfVbjFyJD6dN4qCszOKGPiHryHHJs8rWcEY79rcDE3X+iSRdPLXr/2m0DCP2g72amBNXhWW3wVdSiRntTiXRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 04:00:34 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:00:34 +0000
Message-ID: <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
Date: Tue, 10 Oct 2023 12:00:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Parav Pandit <parav@nvidia.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
 <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|BL1PR12MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a0c55b-07a1-4d7c-174b-08dbc9457431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SutDlalcP+sKaG/kxiwMFfdluhMnGoNEUn9GsZkvunN2acWg3C4wBq+DI/PP+4+pPegZlIr+TGQOprl06OV9u/B/oAjl1xf6LTdlu8aE9HwY8Czx+92nstZaOfnzPGqeFIDaSvr0krnxyXNO7Cjcgip1sg+2NWF9lthn6A/YaFi95k6Ha+0FDry/PJMgKNw5A49LHbSB7U2YZ+TcQPA7u3Wb3x7dkfVad/uc6iJZCIkfwilgauCV31rK87sZSkt8+EZYODb51JViXUhB8cU3FMWE+/Gw8tXMHGz5g7M/EDWlmJ3l0Pz9lCrtbq262LDs81GBW1maUcztEvGgRXhrxJgkg/2C/sRH7UWz73QkJFvgmLfpkK7P6MmGyL+nIoshIOsV3fQJRyzUVVKqzW9mDLW+VsMDwcQ4Yx8ePie5yV7GhIAtmg2QdDNvab7ul+CfBfkR+YXCuJiGa/0E/HeKlRPZt9w/51hpv/8q53ig/pwHvPQQNsj3L7JPJ5V14+dvaxk2qVEywstiYX2SmfjmO93ibuao1QkLV2jBHUg24ZvI92dzeRAZmJSePTeP6crVQDPWUhtsz1x8q/0rh9M8+EsIx6KIwUIyF9ZTISs+W6WQUfPE0TuZvGoaf3yWptghZjQnzo5ePTfpGxhfXoPuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(86362001)(2616005)(26005)(53546011)(36756003)(31696002)(38100700002)(8676002)(4326008)(2906002)(478600001)(8936002)(6506007)(6666004)(83380400001)(41300700001)(6512007)(6486002)(5660300002)(110136005)(54906003)(66476007)(66556008)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME4zMGk1L0xjNmVNNW9uU0lESkpFNkQyVUZPVmluTDRTQWdSNW9zWmhHQWFN?=
 =?utf-8?B?WnJKWGQvRk14cFVUWnBJMnpjSzE0MmFJcUlDV1hVRlYxVFp6a2hCNFV0LzZT?=
 =?utf-8?B?ZTNZTkZQc0dqOHRGTmYrc0xwSkVydEhwcTg1ZU1VbjE4eWRpZFQyVFZ4c1Jy?=
 =?utf-8?B?ZDVBcHpnWDBZWU1IMm5LK0ZEMVg0d3JEZDA1Z00rdG84THNLTndlelM1RXI2?=
 =?utf-8?B?NG5DMU5YWDBOY3hWU2dtWXorMEtqR21VQy92NVJWamtpSm0xUzY3cEJWK0M4?=
 =?utf-8?B?S2krOTFWYjErV3BiMVhSVmIwRnF2QUNXTStzRUtrTnNXL01vM2NoMGQ4aUJo?=
 =?utf-8?B?SVpRQzdOU0dDTXdYemZrY2RmaGxJaHZOTE4rMFhlODZDUm5oNFc4UEUwZDBo?=
 =?utf-8?B?UTd5clIxN3RYT3ZhVkZlNWVTMWwyazdkbHdmWTRlT3hQRk0rck9CSnF0UW5n?=
 =?utf-8?B?R29BdWNxa3ZTYWE3MFdQY1k4NktoRkRpdWZGcEc1MnVFY2NncGowd2FtQWtW?=
 =?utf-8?B?aHovR2NxM2RGSkJhYXllYnZUT20yU1BLbnUzaVhDL0lHSVFaTThEeXBIRThj?=
 =?utf-8?B?ZFpZcWd4elduRXQ1WGtuYlZuNzNQV0J6TGwxNmFpczFCVkVXY1NRN2lNdlM1?=
 =?utf-8?B?VnlWSHlQNEJWU1FmOFNhcm83RXVwWUVkQXZSMnAxNndXNXB0YkpKaXhvL2NX?=
 =?utf-8?B?TDNYbzc5VVVUcTF5RHJ3b2NyNnpZRHVWWDRCNDJWZS9OQnZaenZucW14Ulh3?=
 =?utf-8?B?MFY5WllnNHNod0pSZ1hydnpqWkg2cy92SEx4eGN2RUNCczZSaWs5bEdBaE1m?=
 =?utf-8?B?VnFDVS9mMG5Ud3RDNDQ0Q05iM0ZFQStmbHVVWTRLVVhTS3pIcW91Y2dBK3ps?=
 =?utf-8?B?LzZjZy91M1BzZ1oxZzlYN1g5VlJIdndtQVNDM2lmQzdLR1FwU1BHZTRneEps?=
 =?utf-8?B?NlcxNmRFQ1VFNUhxV2xiV2wvMVFibkVQdVhhWTh0aGRaUmFNZExtUnFhcmdp?=
 =?utf-8?B?dUptUjFaOElmam8vTW9SMjgvbjJDTTFBeGlHMDNDRkpxY0gyL2Q1T0dwQzJk?=
 =?utf-8?B?VDAxSU0reVd0aEJUYkRaUXNlV3NPZ052SDFqbjNNTmtKYlZkRDBiTzgzMlRU?=
 =?utf-8?B?anRmQ215Nnk2dmlubERNRncxTmJ4ZDRTcnNRalFWWVUxVlJ4SGJyMDZJQ2ho?=
 =?utf-8?B?ckZlN1FqRTJweklZekdiVHdPd3hOd1RuSmIxWXdDMGZ5Vy9ERVNyOEtuRytW?=
 =?utf-8?B?Z0c1YmJmWkY4SXc3TU1XUzBPYnlGZTZ1RXVRT3oyNEZJdEdZbW1TMDcxeFhx?=
 =?utf-8?B?ZjkxQ3kwTnJURXJnNDgxd0RZKzBTeDFuam1zRUF2amkxTHNSMUszRStEaGJx?=
 =?utf-8?B?WXFFby92bDZ4STVuSStYZGYwYi94MFh0WklQZEFtSnk1QVNIRjM3bEVodDF2?=
 =?utf-8?B?UDlFd1VTVkhNUEZwR3dxVmdySnJHWXdDbkdybllEeFgxZElYUVA5YnQ2L2Rl?=
 =?utf-8?B?TElHQnRPc0Fvb1lTMWNsVnhLY3ppNVRvRUQyTHFXRHVFMmlZdkFXekhZZ0hC?=
 =?utf-8?B?SElCRVFzZ0lITG9hR1hOMkUycWQ3c1F1Y2FmRXlOOEdaN2ZtNDREUzB1VlYz?=
 =?utf-8?B?QUJYZXF2SUpzU21ZaHN4K2p6ZDN4Ump3ZXRrLzdPOFRXMWw2L3hLMzhPdThv?=
 =?utf-8?B?WHR0eWlnaHorUTQ2Yk9iL0lhNlh3QWpNbmloY1VwSjdEQlBROSsxM29tUmJw?=
 =?utf-8?B?M3JNb2d5cFpVWThJRDNScTVCa1Rya2R1dnRpWnl0MldHbklyWGJMYzNyOTFB?=
 =?utf-8?B?elZiREs1dDdZVmE2MGtrcW4wMzRVV3JiUy9VcHRIKzljYmpVL2IzMElIOXRL?=
 =?utf-8?B?M1JGR0VrMHJNTlJxZy95WkE0RzNNWE9OU2JtVkJRK2lkQ0JOck8vOVZTU2xi?=
 =?utf-8?B?a3ZKQU5jT2tyRG1lOHJBK0hwaTRLOEJ1THZUaEl4R08xLzJHUklKdC9tbVFH?=
 =?utf-8?B?U2VPUUpIWmRhL2UwWTh0dk9KZGM5aDVwNy9MNUlCVUxkbnVwK0FrdDB3VEpp?=
 =?utf-8?B?UndtdDJNVlU1a2Z3QkVHVHdkRFh5RVhIY3pQdTRLUGpjbktBelNVRDlsRzFa?=
 =?utf-8?Q?u3oK5pHcb2bZzwd7GAyVrsM/m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a0c55b-07a1-4d7c-174b-08dbc9457431
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:00:34.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjtrPPkmpow3eQxSTM75rIsVJWrhYuPpvcxN2O6r360S+t5nmPNbuP7ZGQGSTRFdBd4QFZh4bQbZRPKhnsTX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::623;
 envelope-from=yajunw@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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


On 10/9/2023 5:13 PM, Hanna Czenczek wrote:
> External email: Use caution opening links or attachments
>
>
> On 09.10.23 11:07, Hanna Czenczek wrote:
>> On 09.10.23 10:21, Hanna Czenczek wrote:
>>> On 07.10.23 04:22, Yajun Wu wrote:
>> [...]
>>
>>>> The main motivation of adding VHOST_USER_SET_STATUS is to let
>>>> backend DPDK know
>>>> when DRIVER_OK bit is valid. It's an indication of all VQ
>>>> configuration has sent,
>>>> otherwise DPDK has to rely on first queue pair is ready, then
>>>> receiving/applying
>>>> VQ configuration one by one.
>>>>
>>>> During live migration, configuring VQ one by one is very time
>>>> consuming.
>>> One question I have here is why it wasn’t then introduced in the live
>>> migration code, but in the general VM stop/cont code instead. It does
>>> seem time-consuming to do this every time the VM is paused and resumed.

Yes, VM stop/cont will call vhost_net_stop/vhost_net_start. Maybe 
because there's no device level stop/cont vhost message?

>>>
>>>> For VIRTIO
>>>> net vDPA, HW needs to know how many VQs are enabled to set
>>>> RSS(Receive-Side Scaling).
>>>>
>>>> If you don’t want SET_STATUS message, backend can remove protocol
>>>> feature bit
>>>> VHOST_USER_PROTOCOL_F_STATUS.
>>> The problem isn’t back-ends that don’t want the message, the problem
>>> is that qemu uses the message wrongly, which prevents well-behaving
>>> back-ends from implementing the message.
>>>
>>>> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device
>>>> close/reset.
>>> So the right thing to do for back-ends is to announce STATUS support
>>> and then not implement it correctly?
>>>
>>> GET_VRING_BASE should not reset the close or reset the device, by the
>>> way.  It should stop that one vring, not more.  We have a
>>> RESET_DEVICE command for resetting.
I believe dpdk uses GET_VRING_BASE long before qemu has RESET_DEVICE? 
It's a compatible issue. For new backend implements, we can have better 
solution, right?
>>>> I'm not involved in discussion about adding SET_STATUS in Vhost
>>>> protocol. This feature
>>>> is essential for vDPA(same as vhost-vdpa implements
>>>> VHOST_VDPA_SET_STATUS).
>>> So from what I gather from your response is that there is only a
>>> single use for SET_STATUS, which is the DRIVER_OK bit.  If so,
>>> documenting that all other bits are to be ignored by both back-end
>>> and front-end would be fine by me.
>>>
>>> I’m not fully serious about that suggestion, but I hear the strong
>>> implication that nothing but DRIVER_OK was of any concern, and this
>>> is really important to note when we talk about the status of the
>>> STATUS feature in vhost today.  It seems to me now that it was not
>>> intended to be the virtio-level status byte, but just a DRIVER_OK
>>> signalling path from front-end to back-end.  That makes it a
>>> vhost-level protocol feature to me.
>> On second thought, it just is a pure vhost-level protocol feature, and
>> has nothing to do with the virtio status byte as-is.  The only stated
>> purpose is for the front-end to send DRIVER_OK after migration, but
>> migration is transparent to the guest, so the guest would never change
>> the status byte during migration.  Therefore, if this feature is
>> essential, we will never be able to have a status byte that is
>> transparently shared between guest and back-end device, i.e. the
>> virtio status byte.
> On third thought, scratch that.  The guest wouldn’t set it, but
> naturally, after migration, the front-end will need to restore the
> status byte from the source, so the front-end will always need to set
> it, even if it were otherwise used controlled only by the guest and the
> back-end device.  So technically, this doesn’t prevent such a use case.
> (In practice, it isn’t controlled by the guest right now, but that could
> be fixed.)
I only tested the feature with DPDK(the only backend use it today?). Max 
defined the protocol and added the corresponding code in DPDK before I 
added QEMU support. If other backend or different device type want to 
use this, we can have further discussion?
>> Cc-ing Alex on this mail, because to me, this seems like an important
>> detail when he plans on using the byte in the future. If we need a
>> virtio status byte, I can’t see how we could use the existing F_STATUS
>> for it.
>>
>> Hanna

