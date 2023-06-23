Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225973B038
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 07:45:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZaK-0006HT-FB; Fri, 23 Jun 2023 01:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZaH-0006Fm-K4
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZaD-0006Mt-Es
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687498995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3sjvVm6YGVywfUDQ2Mh4VN1gWws+XRnUbwZtM4I4sS8=;
 b=elpeEFU4J3tkvc+z/zDfN6oWjICrkSfiPceguFAsI7A43YoVPdHpvucZk74kFo8Dw2QOl0
 HSfZXb4WfNTdLPacNQnv0cTwTjwNwjobImgkuFV2Oy3zMfT/YRluCg6mV48uCzHRuwvqUu
 0fYIIsCW4qeCHAMEBaStphzT0VfzEDQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-cy2OX_A_Nj2PKD5a0QcpEQ-1; Fri, 23 Jun 2023 01:43:13 -0400
X-MC-Unique: cy2OX_A_Nj2PKD5a0QcpEQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3129750e403so157668f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687498991; x=1690090991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sjvVm6YGVywfUDQ2Mh4VN1gWws+XRnUbwZtM4I4sS8=;
 b=Ek20E/hgaCSltpL/9qQg2RBS+a8nkebLkqGLVzs734yQzZ9wN+BWA6hNNzydSvhxhJ
 w1D8YvT/t+YxqlOjVkonXBKZznTeErhIpj/VhnMKgN2syau8GmV9B/Az2LHmPwDeQ9aJ
 L/mYLOW5xlwIjhUfEdnle7ZlSs8gZ9S1gXQkEx6reqxjCwRWCzvaBrk1Vgnn4g923aFU
 7PXkSVG9awflgMwHs+ge/Et/0l2cpvIW5tPbyXzV3uj5WsAlwf80+EutfgGB8Rq6hS9T
 mxwqohRw+xUNJmisu1g5aopA8UUuws6Ayd44HlTyYO4ucfgoJbHNCJpow0l8xB6vXwa4
 y07A==
X-Gm-Message-State: AC+VfDzbO53aLNimEzKLaFNp525iXzgBjw8CSfUdU0St1SCxbyOqQDnn
 vn2lCIILoyT6vw1OPGpVj3OtvPSdYnlrIoeDenLDo9AEWqr43Aa5E6oCSmOUMXdHSqRmeH4JOBf
 tNW6WOSCQJcGArApYH7RUU6U=
X-Received: by 2002:adf:d0c8:0:b0:2ee:f77f:3d02 with SMTP id
 z8-20020adfd0c8000000b002eef77f3d02mr15129681wrh.0.1687498991424; 
 Thu, 22 Jun 2023 22:43:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WQbBsCkxuFFOfKmXbYxtv+6ZJgkIJp1SL1B92uNTuA68Ao3/Y3x+qn0O75oYL6O/CD2UkmA==
X-Received: by 2002:adf:d0c8:0:b0:2ee:f77f:3d02 with SMTP id
 z8-20020adfd0c8000000b002eef77f3d02mr15129666wrh.0.1687498991091; 
 Thu, 22 Jun 2023 22:43:11 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 o11-20020a5d4a8b000000b0030fb828511csm8537755wrq.100.2023.06.22.22.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 22:43:10 -0700 (PDT)
Date: Fri, 23 Jun 2023 01:43:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 2/2] qmp: update virtio feature maps, vhost-user-gpio
 instrospection
Message-ID: <20230623013300-mutt-send-email-mst@kernel.org>
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-3-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609132040.2180710-3-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 09, 2023 at 09:20:40AM -0400, Jonah Palmer wrote:
> Add new virtio transport feature to transport feature map:
>  - VIRTIO_F_RING_RESET
> 
> Add new vhost-user protocol feature to vhost-user protocol feature map
> and enumeration:
>  - VHOST_USER_PROTOCOL_F_STATUS
> 
> Add new virtio device features for several virtio devices to their
> respective feature mappings:
> 
> virtio-blk:
>  - VIRTIO_BLK_F_SECURE_ERASE
> 
> virtio-net:
>  - VIRTIO_NET_F_NOTF_COAL
>  - VIRTIO_NET_F_GUEST_USO4
>  - VIRTIO_NET_F_GUEST_USO6
>  - VIRTIO_NET_F_HOST_USO
> 
> virtio/vhost-user-gpio:
>  - VIRTIO_GPIO_F_IRQ
>  - VHOST_F_LOG_ALL
>  - VHOST_USER_F_PROTOCOL_FEATURES
> 
> virtio-bt:
>  - VIRTIO_BT_F_VND_HCI
>  - VIRTIO_BT_F_MSFT_EXT
>  - VIRTIO_BT_F_AOSP_EXT
>  - VIRTIO_BT_F_CONFIG_V2
> 
> virtio-scmi:
>  - VIRTIO_SCMI_F_P2A_CHANNELS
>  - VIRTIO_SCMI_F_SHARED_MEMORY
> 
> Add support for introspection on vhost-user-gpio devices.
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Thanks for the patch! Some comments:


> ---
>  hw/virtio/vhost-user-gpio.c |  7 ++++
>  hw/virtio/virtio-qmp.c      | 79 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
> index d6927b610a..e88ca5370f 100644
> --- a/hw/virtio/vhost-user-gpio.c
> +++ b/hw/virtio/vhost-user-gpio.c
> @@ -205,6 +205,12 @@ static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
>      vhost_virtqueue_mask(&gpio->vhost_dev, vdev, idx, mask);
>  }
>  
> +static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
> +{
> +    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> +    return &gpio->vhost_dev;
> +}
> +
>  static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
>  {
>      virtio_delete_queue(gpio->command_vq);
> @@ -413,6 +419,7 @@ static void vu_gpio_class_init(ObjectClass *klass, void *data)
>      vdc->get_config = vu_gpio_get_config;
>      vdc->set_status = vu_gpio_set_status;
>      vdc->guest_notifier_mask = vu_gpio_guest_notifier_mask;
> +    vdc->get_vhost = vu_gpio_get_vhost;
>  }
>  
>  static const TypeInfo vu_gpio_info = {
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index e936cc8ce5..140c420d87 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
>      VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
> +    VHOST_USER_PROTOCOL_F_STATUS = 16,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>

OMG I just realized that by now we have accumulated each value
in 4 places! This is really badly asking to be moved
to a header. Not sure what to do about the document yet
but that will at least get us down to two.
  
> @@ -79,6 +80,8 @@ static const qmp_virtio_feature_map_t virtio_transport_map[] = {
>              "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
>      FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
>              "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
> +    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
> +            "VIRTIO_F_RING_RESET: Driver can reset individual VQs"),
>      /* Virtio ring transport features */
>      FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
>              "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
> @@ -134,6 +137,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
>              "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
>              "memory slots supported"),
> +    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
> +            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
> +            "device statuses supported"),

status - there's only one per device

>      { -1, "" }
>  };
>  
> @@ -176,6 +182,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
>              "VIRTIO_BLK_F_DISCARD: Discard command supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
>              "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
> +    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
> +            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
>              "VIRTIO_BLK_F_ZONED: Zoned block devices"),
>  #ifndef VIRTIO_BLK_NO_LEGACY

> @@ -299,6 +307,14 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
>              "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
>              "channel"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
> +            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
> +            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
> +            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
> +            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
>              "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
> @@ -469,6 +485,48 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
>  };
>  #endif
>  
> +/* virtio/vhost-gpio features mapping */
> +#ifdef CONFIG_VIRTIO_GPIO

Where's this coming from?

> +static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
> +    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
> +            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
> +    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> +            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> +            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "negotiation supported"),
> +    { -1, "" }
> +};
> +#endif
> +
> +/* virtio-bluetooth features mapping */
> +#ifdef CONFIG_VIRTIO_BT

Where's this coming from?


> +static const qmp_virtio_feature_map_t virtio_bt_feature_map[] = {
> +    FEATURE_ENTRY(VIRTIO_BT_F_VND_HCI, \
> +            "VIRTIO_BT_F_VND_HCI: Vendor command supported"),
> +    FEATURE_ENTRY(VIRTIO_BT_F_MSFT_EXT, \
> +            "VIRTIO_BT_F_MSFT_EXT: MSFT vendor supported"),
> +    FEATURE_ENTRY(VIRTIO_BT_F_AOSP_EXT, \
> +            "VIRTIO_BT_F_AOSP_EXT: AOSP vendor supported"),
> +    FEATURE_ENTRY(VIRTIO_BT_F_CONFIG_V2, \
> +            "VIRTIO_BT_F_CONFIG_V2: Using v2 configuration"),
> +    { -1, "" }
> +};
> +#endif
> +
> +/* virtio-scmi features mapping */
> +#ifdef CONFIG_VIRTIO_SCMI

Where's this coming from?

> +static const qmp_virtio_feature_map_t virtio_scmi_feature_map[] = {
> +    FEATURE_ENTRY(VIRTIO_SCMI_F_P2A_CHANNELS, \
> +            "VIRTIO_SCMI_F_P2A_CHANNELS: SCMI notifications or delayed "
> +            "responses implemented"),
> +    FEATURE_ENTRY(VIRTIO_SCMI_F_SHARED_MEMORY, \
> +            "VIRTIO_SCMI_F_SHARED_MEMORY: SCMI shared memory region statistics "
> +            "implemented"),
> +    { -1, "" }
> +};
> +#endif
> +
>  #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
>      ({                                                   \
>          type *list = NULL;                               \
> @@ -625,6 +683,24 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>          features->dev_features =
>              CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
>          break;
> +#endif
> +#ifdef CONFIG_VIRTIO_GPIO
> +    case VIRTIO_ID_GPIO:
> +        features->dev_features =
> +            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
> +        break;
> +#endif
> +#ifdef CONFIG_VIRTIO_BT
> +    case VIRTIO_ID_BT:
> +        features->dev_features =
> +            CONVERT_FEATURES(strList, virtio_bt_feature_map, 0, bitmap);
> +        break;
> +#endif
> +#ifdef CONFIG_VIRTIO_SCMI
> +    case VIRTIO_ID_SCMI:
> +        features->dev_features =
> +            CONVERT_FEATURES(strList, virtio_scmi_feature_map, 0, bitmap);
> +        break;
>  #endif
>      /* No features */
>      case VIRTIO_ID_9P:
> @@ -640,18 +716,15 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>      case VIRTIO_ID_SIGNAL_DIST:
>      case VIRTIO_ID_PSTORE:
>      case VIRTIO_ID_SOUND:
> -    case VIRTIO_ID_BT:
>      case VIRTIO_ID_RPMB:
>      case VIRTIO_ID_VIDEO_ENCODER:
>      case VIRTIO_ID_VIDEO_DECODER:
> -    case VIRTIO_ID_SCMI:
>      case VIRTIO_ID_NITRO_SEC_MOD:
>      case VIRTIO_ID_WATCHDOG:
>      case VIRTIO_ID_CAN:
>      case VIRTIO_ID_DMABUF:
>      case VIRTIO_ID_PARAM_SERV:
>      case VIRTIO_ID_AUDIO_POLICY:
> -    case VIRTIO_ID_GPIO:
>          break;
>      default:
>          g_assert_not_reached();
> -- 
> 2.39.3


