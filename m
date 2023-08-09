Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B47775464
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 09:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTdtD-0007aO-L7; Wed, 09 Aug 2023 03:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qTdtB-0007Zd-AA
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 03:45:53 -0400
Received: from mail-sn1nam02on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::603]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qTdt5-0001LT-PJ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 03:45:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxQX6SthyenLENffJBt76Pf6bz5AMWsNpHDQv2GXA56D/qsOLadfn+xH37/DHakuUXGKjD+pvDEiAQD1sCPytnfrsEXmRdrL+D9Ef6nuxUpqIwTO9hzFztdBEBUEi8O1J6ROcTktbya9J9M4urtCwwh8u5ef5mnYEIrx14uxuMy7fvpUPB0Cwq9ecUKrxGvL/LS1woWt7qFfHokxhibKRqz5FZQsNTr4TbEq+Yu0JVzQI3MxJZbHMUuoqTkxghIjo3Ihcyd+pYmoforynFhlLEwAy5m9+ZYDUnKU15f6FMMOMwF/Oeq6bU+xAFaR4csWuRI/BF8akviHrDfVs3UERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns4NNRTwDocZ6bn4UyviwoWzYXLUVhKEdtklLUgOPd8=;
 b=TYLKdzaIuHz/3cphmIVYctoCH3/wG7++fbV3OYEH3gsDRXsMiWt9fvS6DGBfA9s3WfjtoSuBmx1Ty5A7E9J62VIaPRAqUpp9gwVfOlzzWOL52mxvqZVYR8YmNF8/SqVZFhUE0rcefEVFhZn6Wdlvvf0nmPTxSYtw92qqgLef5b6eoVzZwyGyObGdxJsyiY2+su8oQyGJuAkY8GAQLRI/4kZaxphIVpUteRsU8NgbdFgXTHrQU3RCZZKwAJxnAEWVhwlO8VlvdAG1gKJsoA92yFUiludfPNbZFKo2qX5tkaJdJcNa7EHhlnSPirID6TGjcRnUhiGfTHSfdNnmtGM0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns4NNRTwDocZ6bn4UyviwoWzYXLUVhKEdtklLUgOPd8=;
 b=RhqWxyyQ4p3GjhVCUvuPLGVkeQKbdlGBi0Bt5x4jAZ3CsLhDwHKThtiNDOlIlcaywPk7Bs1IXLqagKSv3P8mOP8diQxcrn3u160NnQVut31KOq+qlI6rMq7bel/VkHY1jv21NDWbHbkgb4Vj1TvO/WZEMK36fBuyo6wMzHRYVvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:45:41 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 07:45:41 +0000
Date: Wed, 9 Aug 2023 15:45:21 +0800
From: Huang Rui <ray.huang@amd.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>,
 "ernunes@redhat.com" <ernunes@redhat.com>
Subject: Re: [PATCH v4 1/9] virtio: Add shared memory capability
Message-ID: <ZNNEEftonCkQDX9F@amd.com>
References: <20230809021108.674-1-gurchetansingh@chromium.org>
 <20230809021108.674-2-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809021108.674-2-gurchetansingh@chromium.org>
X-ClientProxiedBy: TYAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:15::25) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b29c77b-7881-4fae-9d14-08db98aca158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwzUBvv5f1GOWZRyGteClYSFyxaMyxxnqka+tCc/VKpeBJk5rjXRyAoyWv3wg/l9ECvAUbth/RSk01BX5UbuQ4gbP1i2pWhHTYmhkuPX/FYf4rU1ExEcS7Tv1lGD341uZELjqXAh4RJf/zhTPBc15JGXnrZLMcvmcn3hBprYCZscyWiQNBPsQClaNFM2F4XyKvqLoii6+QYFgZw5mvinxJi7nrCOZl1AfwckX6ktOKcoIObDel4Ltr/UkYl670qg3uVTXC/YRwNn3ZJSQYQnaAMJT7uljLY+WVFJuzzaNSNbUTkIif+7xDuobpVb97xrlJNsVt7FJMBobQ8qp+YbAROHz+uyzLUW7tqcCaF75PXMEYOUKJhPuoEPoylqNH+/um4uS1CSIBexuCj2igbnVRMxFN3rDyDDV4KHcerVC3rU9PymR3CIHmaJ30t0ohs6rrkqvfftFfL307Fq5di7uIH7iPZ0MTGIJp41qCdGrwRymCCc04DZOnPtiXMqvMdZf2T0hIfEZDQL9l3q7ly5M+GPjoPinUrx5KhR6m9JGutBRRfEtBYoRyuOeFT3qAkB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(1800799006)(186006)(86362001)(316002)(6916009)(66476007)(4326008)(66556008)(8936002)(8676002)(2906002)(5660300002)(36756003)(41300700001)(66946007)(38100700002)(54906003)(2616005)(6666004)(6506007)(26005)(478600001)(6512007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XX/zQX/luKBbkxkn5c78Rw6Fgnbvyn0EbslHa/mAcZJ9vwNAKwxJrdN48p7w?=
 =?us-ascii?Q?ctzjiU3SSMllh2N8qQrk9VTRbmBBgczYnhbWSAH8FKCg/3tT+jupSiNva8Ib?=
 =?us-ascii?Q?oQkKWLycyyNWJ2iz7JwLYwjsylEBKp90wlaU/kax0arKO0AzQxLtipkOYtLp?=
 =?us-ascii?Q?Y1FYojV43umHvCSvdqwC6vR+bOLLSTBaQhZh4FvCuILODoEOwXjCd3xcMIcj?=
 =?us-ascii?Q?NPZn0IiWIwXZp+O47L1FP5eCooAGVbu53Pa3K0Y15h0971bLpMPc8wtmW5M1?=
 =?us-ascii?Q?3BeSUhnDLSZJJLl2ZS1RGrS7NSc6QADgLrnzqo487LtPIhWUQ6LoBOxxj5u4?=
 =?us-ascii?Q?94H9Zm5YJBebylsRXLXB0vGlhQ9OcAMJO9uf/0e1FhAxVKCAPuU9V3BzhZQ1?=
 =?us-ascii?Q?trgjQbso737kAGNIlzjdkq20hpu4L2VBSD/4tOMQGhJeA5hdkbxoXUEsT6ou?=
 =?us-ascii?Q?Ct/kvleoUnA866SWMAPZxOlhwm45i88pozaqYStIV+PrVH3HDU6usWjMDbXy?=
 =?us-ascii?Q?C3cOsER5PPAEjKLKoE/r3E+ViTYMMHWbJPgCo5Fb92LlEnKH1nO/cWPDsqYt?=
 =?us-ascii?Q?exBULbnaf0xvPS1galtxfeSmCRhKSj+v6v/8HdeKrLUglFERYvhNdHKlvFZ5?=
 =?us-ascii?Q?vam3JFrMfrM2bAEHOybGMitUt2RdCPNAgLFo/YNPAxFThxgkjsarUx60h4ll?=
 =?us-ascii?Q?XVPRLQyurbvIhi52qHoIKQdCMuqGImPbv32t33zxeoeQpf1Fb9neGm/FMPs+?=
 =?us-ascii?Q?cfJCc8zYtYLRtB0RWR35UWTcEszcFpmL+0/x8i3PugnLzfd8HuPIgmxkWcbb?=
 =?us-ascii?Q?GiAKS0oMhsbQST0kgy+Z3lmiDqjzk4Udq3tcBUPnDgdyEEzIMrZ5r5a/NS19?=
 =?us-ascii?Q?dvlpFgxAieaaUTpYcchjJi0lT8HsIqh0VWjx2ZJBXGII1+OY8kALKYD1sFV/?=
 =?us-ascii?Q?UqLrHWYkB8XQN/wnq5Mdb0pcjwmePmIBfonnhQnfjaHwL4N7O45BNIs9C3Sl?=
 =?us-ascii?Q?txhFaaPbQ6dB5kXtg7q4uNXxcgC9RK3NMtb6/VOfcxpIXY1pgv4imVkhswBp?=
 =?us-ascii?Q?VPNi6CRDS6SlI5NaaBu/efguxD+0Z4Yg8Eiiqhx0JNXj7AdRukZQPqVr5xBA?=
 =?us-ascii?Q?vlZ3IddPN5e1cu29y3nKmwPJmYGd5TeH7TMMSEr29xM0GOOF91EHzHYVDJRy?=
 =?us-ascii?Q?AAlk8a5d9FNLUN2H6cgkVQMpFW5tpNWh7ZEavUbYpT7/6WGERG6V/JzyoJoC?=
 =?us-ascii?Q?E1Nlz/6eFSkO4QqURKhcomEzu8EUHfTQWwVI4kjiM5hGrzc0lO9TbGQv2ylG?=
 =?us-ascii?Q?qBF0L5XZK9sGDnqiqzIjdP/TdxULQzFChn6tmQ7FHpQPCCuGSgcHTFUFTVDd?=
 =?us-ascii?Q?GCyxpMbb/5vuKnn/5YWtd/xsBJm+ujqozyO4rsfYarZK6e2TkQXd3JKgRqmR?=
 =?us-ascii?Q?7XU0WnT+b+P9carkcVhnQ8UujgPacT5C9rcA20hGPf+/dER1Sgu6uqs2VUgm?=
 =?us-ascii?Q?WxvxEGVV7n371h6u79FJQP0erCQprxeYh72Q1v6Sx0X16P+6430csY+2aX3h?=
 =?us-ascii?Q?aQoOi2AT9q+PRT6hJYSZNQdiT3WpxtXOmDltea1c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b29c77b-7881-4fae-9d14-08db98aca158
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:45:41.3108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crCm/IbEeXz0sgjqn330ckGptUsPaTR05+1lTBR8Tv8E1fMRy2lf7DhrJw7gPcK0n61UVnIwmqCqMnasjZhJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::603;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Aug 09, 2023 at 10:11:00AM +0800, Gurchetan Singh wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Define a new capability type 'VIRTIO_PCI_CAP_SHARED_MEMORY_CFG' to allow
> defining shared memory regions with sizes and offsets of 2^32 and more.
> Multiple instances of the capability are allowed and distinguished
> by a device-specific 'id'.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-and-Tested-by: Huang Rui <ray.huang@amd.com>

> ---
>  hw/virtio/virtio-pci.c         | 18 ++++++++++++++++++
>  include/hw/virtio/virtio-pci.h |  4 ++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index edbc0daa18..da8c9ea12d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1435,6 +1435,24 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>      return offset;
>  }
>  
> +int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
> +                           uint8_t bar, uint64_t offset, uint64_t length,
> +                           uint8_t id)
> +{
> +    struct virtio_pci_cap64 cap = {
> +        .cap.cap_len = sizeof cap,
> +        .cap.cfg_type = VIRTIO_PCI_CAP_SHARED_MEMORY_CFG,
> +    };
> +
> +    cap.cap.bar = bar;
> +    cap.cap.length = cpu_to_le32(length);
> +    cap.length_hi = cpu_to_le32(length >> 32);
> +    cap.cap.offset = cpu_to_le32(offset);
> +    cap.offset_hi = cpu_to_le32(offset >> 32);
> +    cap.cap.id = id;
> +    return virtio_pci_add_mem_cap(proxy, &cap.cap);
> +}
> +
>  static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>                                         unsigned size)
>  {
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index ab2051b64b..5a3f182f99 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -264,4 +264,8 @@ unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues);
>  void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
>                                                int n, bool assign,
>                                                bool with_irqfd);
> +
> +int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy, uint8_t bar, uint64_t offset,
> +                           uint64_t length, uint8_t id);
> +
>  #endif
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

