Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3649B0BD9C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 09:25:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udksc-0003yP-Es; Mon, 21 Jul 2025 03:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udksF-0003if-IL
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:23:50 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udksA-0000a1-5N
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:23:46 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56L7NEkb069466
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 16:23:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VkgIQhYzEhYlUvxS7jgliaX0xs6EFNAjVVHG1tFdZE8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753082595; v=1;
 b=AymbckMad/FWOQCRSASvQ7ujJre4MQO9v6rbGzl9mkhvCu98Nagg0F0XD8EH1Wzi
 cSZmopdOfsAc7c1ApE5v2I9cjV1wDP5EYoi4pgl0iBZPPz5wsT0sG9kiMO/jvNOC
 FIR17jzzKcSwACzIHRIXZ1iKDa+h3qWq6GAk5SSmh33jo0NTFPVUi+LNNyTRXFUM
 mFvzzpBCeFXvpvsz9cMgXteN+oUO/rkp/TSPGvTjLGrcttz9epr2LPmgtdTlUUWa
 j55k2upcsd/pTJwSlgHg7F/3kyYaX1LP5pQxMCR9UFAsn55NvBF4UYOZy2j+YsE7
 lpF/0d0Lpea2rqUlgepuRw==
Message-ID: <e17fdd28-b8a7-42cf-a4c0-bc04ffeb3eea@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 16:23:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
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
References: <cover.1752828082.git.pabeni@redhat.com>
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/18 17:52, Paolo Abeni wrote:
> Extend the VirtioDeviceFeatures struct with an additional u64
> to track unknown features in the 64-127 bit range and decode
> the full virtio features spaces for vhost and virtio devices.
> 
> Also add entries for the soon-to-be-supported virtio net GSO over
> UDP features.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>    - unknown-dev-features-dword2 -> unknown-dev-features2
>    - _array -> _ex
>    - fixed typos in entries description
> 
> v1 -> v2:
>    - uint128_t -> uint64_t[]
> ---
>   hw/virtio/virtio-hmp-cmds.c |  3 +-
>   hw/virtio/virtio-qmp.c      | 89 ++++++++++++++++++++++++++-----------
>   hw/virtio/virtio-qmp.h      |  3 +-
>   qapi/virtio.json            |  8 +++-
>   4 files changed, 73 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 7d8677bcf0..1daae482d3 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
>       }
>   
>       if (features->has_unknown_dev_features) {
> -        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
> +        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
> +                       features->unknown_dev_features2,
>                          features->unknown_dev_features);
>       }
>   }
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 3b6377cf0d..03c6163cf4 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>       FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>               "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>               "negotiation supported"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> +            "UDP tunnel packets"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> +            "UDP tunnel packets requiring checksum offload for the outer "
> +            "header"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
> +            "UDP tunnel packets"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
> +            "UDP tunnel packets requiring checksum offload for the outer "
> +            "header"),
>       { -1, "" }
>   };
>   #endif
> @@ -510,6 +524,24 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
>           list;                                            \
>       })
>   
> +#define CONVERT_FEATURES_EX(type, map, bitmap)           \
> +    ({                                                   \
> +        type *list = NULL;                               \
> +        type *node;                                      \
> +        for (i = 0; map[i].virtio_bit != -1; i++) {      \
> +            bit = map[i].virtio_bit;                     \
> +            if (!virtio_has_feature_ex(bitmap, bit)) {   \
> +                continue;                                \
> +            }                                            \
> +            node = g_new0(type, 1);                      \
> +            node->value = g_strdup(map[i].feature_desc); \
> +            node->next = list;                           \
> +            list = node;                                 \
> +            virtio_clear_feature_ex(bitmap, bit);        \
> +        }                                                \
> +        list;                                            \
> +    })
> +
>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap)
>   {
>       VirtioDeviceStatus *status;
> @@ -545,109 +577,112 @@ VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
>       return vhu_protocols;
>   }
>   
> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
> +                                          const uint64_t *bmap)
>   {
> +    uint64_t bitmap[VIRTIO_FEATURES_DWORDS];
>       VirtioDeviceFeatures *features;
>       uint64_t bit;
>       int i;
>   
> +    virtio_features_copy(bitmap, bmap);
>       features = g_new0(VirtioDeviceFeatures, 1);
>       features->has_dev_features = true;
>   
>       /* transport features */
> -    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
> -                                            bitmap);
> +    features->transports = CONVERT_FEATURES_EX(strList, virtio_transport_map,
> +                                               bitmap);
>   
>       /* device features */
>       switch (device_id) {
>   #ifdef CONFIG_VIRTIO_SERIAL
>       case VIRTIO_ID_CONSOLE:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_BLK
>       case VIRTIO_ID_BLOCK:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_GPU
>       case VIRTIO_ID_GPU:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_NET
>       case VIRTIO_ID_NET:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_SCSI
>       case VIRTIO_ID_SCSI:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_BALLOON
>       case VIRTIO_ID_BALLOON:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_IOMMU
>       case VIRTIO_ID_IOMMU:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_INPUT
>       case VIRTIO_ID_INPUT:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VHOST_USER_FS
>       case VIRTIO_ID_FS:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VHOST_VSOCK
>       case VIRTIO_ID_VSOCK:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_CRYPTO
>       case VIRTIO_ID_CRYPTO:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_MEM
>       case VIRTIO_ID_MEM:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_I2C_ADAPTER
>       case VIRTIO_ID_I2C_ADAPTER:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VIRTIO_RNG
>       case VIRTIO_ID_RNG:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
>           break;
>   #endif
>   #ifdef CONFIG_VHOST_USER_GPIO
>       case VIRTIO_ID_GPIO:
>           features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
>           break;
>   #endif
>       /* No features */
> @@ -680,9 +715,10 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>           g_assert_not_reached();
>       }
>   
> -    features->has_unknown_dev_features = bitmap != 0;
> +    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
>       if (features->has_unknown_dev_features) {
> -        features->unknown_dev_features = bitmap;
> +        features->unknown_dev_features = bitmap[0];
> +        features->unknown_dev_features2 = bitmap[1];
>       }
>   
>       return features;
> @@ -743,11 +779,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>       status->device_id = vdev->device_id;
>       status->vhost_started = vdev->vhost_started;
>       status->guest_features = qmp_decode_features(vdev->device_id,
> -                                                 vdev->guest_features);
> +                                                 vdev->guest_features_ex);
>       status->host_features = qmp_decode_features(vdev->device_id,
> -                                                vdev->host_features);
> +                                                vdev->host_features_ex);
>       status->backend_features = qmp_decode_features(vdev->device_id,
> -                                                   vdev->backend_features);
> +                                                 vdev->backend_features_ex);
>   
>       switch (vdev->device_endian) {
>       case VIRTIO_DEVICE_ENDIAN_LITTLE:
> @@ -785,11 +821,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>           status->vhost_dev->nvqs = hdev->nvqs;
>           status->vhost_dev->vq_index = hdev->vq_index;
>           status->vhost_dev->features =
> -            qmp_decode_features(vdev->device_id, hdev->features);
> +            qmp_decode_features(vdev->device_id, hdev->features_ex);
>           status->vhost_dev->acked_features =
> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
> +            qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
>           status->vhost_dev->backend_features =
> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
> +            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
> +
>           status->vhost_dev->protocol_features =
>               qmp_decode_protocols(hdev->protocol_features);
>           status->vhost_dev->max_queues = hdev->max_queues;
> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
> index 245a446a56..e0a1e49035 100644
> --- a/hw/virtio/virtio-qmp.h
> +++ b/hw/virtio/virtio-qmp.h
> @@ -18,6 +18,7 @@
>   VirtIODevice *qmp_find_virtio_device(const char *path);
>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>   VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
> +                                          const uint64_t *bitmap);
>   
>   #endif
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..f2e2dd6e97 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -490,14 +490,18 @@
>   #     unique features)
>   #
>   # @unknown-dev-features: Virtio device features bitmap that have not
> -#     been decoded
> +#     been decoded (bits 0-63)
> +#
> +# @unknown-dev-features2: Virtio device features bitmap that have not
> +#     been decoded (bits 64-127)

This documentation should contain "(since 10.1)" as described in:
docs/devel/qapi-code-gen.rst

>   #
>   # Since: 7.2
>   ##
>   { 'struct': 'VirtioDeviceFeatures',
>     'data': { 'transports': [ 'str' ],
>               '*dev-features': [ 'str' ],
> -            '*unknown-dev-features': 'uint64' } }
> +            '*unknown-dev-features': 'uint64',
> +            '*unknown-dev-features2': 'uint64' } }
>   
>   ##
>   # @VirtQueueStatus:


