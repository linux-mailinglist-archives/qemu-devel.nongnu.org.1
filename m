Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4380FB12A4F
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Jul 2025 13:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufdSs-00055u-5T; Sat, 26 Jul 2025 07:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufdSm-0003GI-90
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 07:53:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufdSi-00069P-Sh
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 07:53:15 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56QBqjvJ069943
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 26 Jul 2025 20:52:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Rpt/lnrq9ghMYZon4PdKAPNFuzlcm6YeYY9ZEfhuJxc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753530765; v=1;
 b=K1T5BZQ3rEDz6l8nBD+66I5Loel4Xw3oqahiKDUe+weJOKOuURUEnz0r32KEmJJ2
 whecShmNC2D0pkGt+jL1r84VfY+kNm1VXR8JdIfDVI/4Xd0FbZURB0Fr4BqqUgjk
 Twu8Dq9Bv6bd9iEIj38S764xcZV+ljZMOGt4ZJSx2XLqjP1f7v8DdMebrGekYA07
 ZkO1aV82JgY0XYaRuRBin2NZENr2dsTo42tVhiqas4OAewEpOgCbWChQt0tg1PWb
 z+TiWNRiCiq3DO7go5WFfsm0dvROFhBSSKfyP3/4Aeexjmx2LU+zj2Fs2Niwuewh
 YW3yt3SYK5eFWB4A+FymRQ==
Message-ID: <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 26 Jul 2025 20:52:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/14] virtio-pci: implement support for extended
 features
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1753297661.git.pabeni@redhat.com>
 <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/24 4:31, Paolo Abeni wrote:
> Extend the features configuration space to 128 bits. If the virtio
> device supports any extended features, allow the common read/write
> operation to access all of it, otherwise keep exposing only the
> lower 64 bits.
> 
> On migration, save the 128 bit version of the features only if the
> upper bits are non zero. Relay on reset to clear all the feature
> space before load.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>    - use new virtio_features macro names
>    - move the build bug before vmstate_virtio_pci_modern_state_sub
> 
> v2 -> v3:
>    - drop the pre_load/post_load trickery and relay on reset zeroing
>      the features instead.
>    - avoid union usage, just increase guest_features size and use
>      SUB_ARRAY.
>    - drop unneeded '!!'
>    - _array -> _ex
> 
> v1 -> v2:
>    - use separate VMStateDescription and pre/post load to avoid breaking
>      migration
>    - clear proxy features on device reset
> ---
>   hw/virtio/virtio-pci.c         | 69 +++++++++++++++++++++++++++++-----
>   include/hw/virtio/virtio-pci.h |  2 +-
>   2 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795..bcc4d48c2c 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -109,6 +109,29 @@ static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
>       }
>   };
>   
> +static bool virtio_pci_modern_state_features128_needed(void *opaque)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    uint32_t features = 0;
> +    int i;
> +
> +    for (i = 2; i < ARRAY_SIZE(proxy->guest_features); ++i) {
> +        features |= proxy->guest_features[i];
> +    }
> +    return features;
> +}
> +
> +static const VMStateDescription vmstate_virtio_pci_modern_state_features128 = {
> +    .name = "virtio_pci/modern_state/features128",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = &virtio_pci_modern_state_features128_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 2, 2),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool virtio_pci_modern_state_needed(void *opaque)
>   {
>       VirtIOPCIProxy *proxy = opaque;
> @@ -116,6 +139,11 @@ static bool virtio_pci_modern_state_needed(void *opaque)
>       return virtio_pci_modern(proxy);
>   }
>   
> +/*
> + * Avoid silently breaking migration should the feature space increase
> + * even more in the (far away) future
> + */
> +QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_NU32S != 4);

Another nitpick: there is a blank line after QEMU_BUILD_BUG_ON() in 
"[RFC PATCH v4 05/14] virtio: serialize extended features state" but 
this patch doesn't have a corresponding one. Please keep them consistent.

>   static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>       .name = "virtio_pci/modern_state",
>       .version_id = 1,
> @@ -124,11 +152,15 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
>           VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
> -        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
> +        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 0, 2),
>           VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
>                                vmstate_virtio_pci_modern_queue_state,
>                                VirtIOPCIQueue),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_virtio_pci_modern_state_features128,
> +        NULL
>       }
>   };
>   
> @@ -1477,6 +1509,13 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>       return virtio_pci_add_mem_cap(proxy, &cap.cap);
>   }
>   
> +static int virtio_pci_select_max(const VirtIODevice *vdev)
> +{
> +    return virtio_features_use_ex(vdev->host_features_ex) ?
> +           VIRTIO_FEATURES_NU32S :
> +           2;

This function could be simplified by replacing VIRTIO_FEATURES_NU32S 
without any functional difference:

1. For writes: virtio_set_features_ex() already ignores extended 
features when !virtio_features_use_ex(vdev->host_features_ex)
2. For reads: When !virtio_features_use_ex(vdev->host_features_ex), the 
upper bits of host_features_ex are zero, and guest_features upper bits 
remain zero (since they can't be set per point 1)

So the conditional logic is redundant here.

> +}
> +
>   static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>                                          unsigned size)
>   {
> @@ -1494,18 +1533,21 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>           val = proxy->dfselect;
>           break;
>       case VIRTIO_PCI_COMMON_DF:
> -        if (proxy->dfselect <= 1) {
> +        if (proxy->dfselect < virtio_pci_select_max(vdev)) {
>               VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>   
> -            val = (vdev->host_features & ~vdc->legacy_features) >>
> -                (32 * proxy->dfselect);
> +            val = vdev->host_features_ex[proxy->dfselect >> 1] >>
> +                  (32 * (proxy->dfselect & 1));
> +            if (proxy->dfselect <= 1) {
> +                val &= (~vdc->legacy_features) >> (32 * proxy->dfselect);
> +            }
>           }
>           break;
>       case VIRTIO_PCI_COMMON_GFSELECT:
>           val = proxy->gfselect;
>           break;
>       case VIRTIO_PCI_COMMON_GF:
> -        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
> +        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
>               val = proxy->guest_features[proxy->gfselect];
>           }
>           break;
> @@ -1588,11 +1630,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>           proxy->gfselect = val;
>           break;
>       case VIRTIO_PCI_COMMON_GF:
> -        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
> +        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
> +            uint64_t features[VIRTIO_FEATURES_NU64S];
> +            int i;
> +
>               proxy->guest_features[proxy->gfselect] = val;
> -            virtio_set_features(vdev,
> -                                (((uint64_t)proxy->guest_features[1]) << 32) |
> -                                proxy->guest_features[0]);
> +            virtio_features_clear(features);
> +            for (i = 0; i < ARRAY_SIZE(proxy->guest_features); ++i) {
> +                uint64_t cur = proxy->guest_features[i];
> +
> +                features[i >> 1] |= cur << ((i & 1) * 32);
> +            }
> +            virtio_set_features_ex(vdev, features);
>           }
>           break;
>       case VIRTIO_PCI_COMMON_MSIX:
> @@ -2311,6 +2360,8 @@ static void virtio_pci_reset(DeviceState *qdev)
>       virtio_bus_reset(bus);
>       msix_unuse_all_vectors(&proxy->pci_dev);
>   
> +    memset(proxy->guest_features, 0, sizeof(proxy->guest_features));
> +
>       for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>           proxy->vqs[i].enabled = 0;
>           proxy->vqs[i].reset = 0;
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index eab5394898..639752977e 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -158,7 +158,7 @@ struct VirtIOPCIProxy {
>       uint32_t nvectors;
>       uint32_t dfselect;
>       uint32_t gfselect;
> -    uint32_t guest_features[2];
> +    uint32_t guest_features[VIRTIO_FEATURES_NU32S];
>       VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
>   
>       VirtIOIRQFD *vector_irqfd;


