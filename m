Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EBA08F1F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 12:25:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWD7I-000707-PG; Fri, 10 Jan 2025 06:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tWD7C-0006zs-IV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tWD7A-00056J-Ea
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736508222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=A5q5S8N4/0QnEPs3ei+KDcbWOiUXmdn+H4DINpcL8qk=;
 b=e10B34xT3ylt3X4DP2GClKk0d5Z0/CSnmJl3eC88ptPCqE17HJq9EFoAmpe9rF1slTn9hQ
 HG9mL7qZzXGiKSC8y3FO6bXOz9Lvfm4xBrrGyubnIe5d7srBz0rfHkRNijx2EemegN88OK
 KpQ0L4kCXXadUci+ua/v4EzSIPa09To=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-p6DVnxcoOUCEHKG8ro09BQ-1; Fri,
 10 Jan 2025 06:23:39 -0500
X-MC-Unique: p6DVnxcoOUCEHKG8ro09BQ-1
X-Mimecast-MFC-AGG-ID: p6DVnxcoOUCEHKG8ro09BQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FAB1955DCC; Fri, 10 Jan 2025 11:23:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C0D19560AD; Fri, 10 Jan 2025 11:23:29 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:23:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 4/4] virtio: Convert feature properties to OnOffAuto
Message-ID: <Z4EDLXYf79H02LLS@redhat.com>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jan 08, 2025 at 03:17:53PM +0900, Akihiko Odaki wrote:
> Some features are not always available with vhost. Legacy features are
> not available with vp_vdpa in particular. virtio devices used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
> 
> QEMU already has OnOffAuto type, which includes the "auto" value to let
> it automatically decide the effective value. Convert feature properties
> to OnOffAuto and set them "auto" by default to utilize it. This allows
> QEMU to report an error if they are set "on" and the corresponding
> features are not available.

This change is addressing two distinct problems at the same time.

The first (big) problem is that permitted host features, and user
requested features are both stored in the same field. This is
logically solved by separating the fields to 'host_features' and
'requested_features'.

To maintain the ability to have automagic disablement of unavailable
features out of the box, however, requires more than just a single
bitmask for the requested features.

There are two approaches to this

 * Separate the tracking of "has value" from "value", with
   "not set" implicitly representing "auto". ie two bitmask fields

 * Switch from bool to a tri-state, with the new default
   value being "auto". ie an araray of enums

The second approach there requires user visible input parsing
changes as proposed in the previous patch.

The ability to explicitly set "auto" on input is only required
if the built-in default value could ever NOT be "auto".

If we can assume the built-in default is *always* auto, then
the user can request 'auto' by simply not setting the parameter.

I'm not especially convinced that we need an explicit "auto"
here, and a variant of DEFINE_PROP_BIT64 could work that let
us track 'has value" from "value" would be sufficient.

If we do want an explicit value, then IMHO we need a better
solution than hacking OnOffAuto to secretly parse bools
without this being represented in the QAPI schema.

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>  hw/core/machine.c          |  4 +++-
>  hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>  hw/virtio/virtio.c         |  4 +++-
>  4 files changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 638691028050..b854c2cb1d04 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -113,7 +113,8 @@ struct VirtIODevice
>      uint16_t queue_sel;
>      /**
>       * These fields represent a set of VirtIO features at various
> -     * levels of the stack. @host_features indicates the complete
> +     * levels of the stack. @requested_features indicates the feature
> +     * set the user requested. @host_features indicates the complete
>       * feature set the VirtIO device can offer to the driver.
>       * @guest_features indicates which features the VirtIO driver has
>       * selected by writing to the feature register. Finally
> @@ -121,6 +122,7 @@ struct VirtIODevice
>       * backend (e.g. vhost) and could potentially be a subset of the
>       * total feature set offered by QEMU.
>       */
> +    OnOffAutoBit64 requested_features;
>      uint64_t host_features;
>      uint64_t guest_features;
>      uint64_t backend_features;
> @@ -149,6 +151,7 @@ struct VirtIODevice
>      bool started;
>      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
>      bool disable_legacy_check;
> +    bool force_features_auto;
>      bool vhost_started;
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
> @@ -376,22 +379,23 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
>  typedef struct VirtIORNGConf VirtIORNGConf;
>  
>  #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
> -    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
> -                      VIRTIO_RING_F_INDIRECT_DESC, true), \
> -    DEFINE_PROP_BIT64("event_idx", _state, _field,        \
> -                      VIRTIO_RING_F_EVENT_IDX, true),     \
> -    DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
> -                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
> -    DEFINE_PROP_BIT64("any_layout", _state, _field, \
> -                      VIRTIO_F_ANY_LAYOUT, true), \
> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> -                      VIRTIO_F_IOMMU_PLATFORM, false), \
> -    DEFINE_PROP_BIT64("packed", _state, _field, \
> -                      VIRTIO_F_RING_PACKED, false), \
> -    DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> -                      VIRTIO_F_RING_RESET, true), \
> -    DEFINE_PROP_BIT64("in_order", _state, _field, \
> -                      VIRTIO_F_IN_ORDER, false)
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("indirect_desc", _state, _field, \
> +                                  VIRTIO_RING_F_INDIRECT_DESC, \
> +                                  ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("event_idx", _state, _field, \
> +                                  VIRTIO_RING_F_EVENT_IDX, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("notify_on_empty", _state, _field, \
> +                                  VIRTIO_F_NOTIFY_ON_EMPTY, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("any_layout", _state, _field, \
> +                                  VIRTIO_F_ANY_LAYOUT, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("iommu_platform", _state, _field, \
> +                                  VIRTIO_F_IOMMU_PLATFORM, ON_OFF_AUTO_OFF), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("packed", _state, _field, \
> +                                  VIRTIO_F_RING_PACKED, ON_OFF_AUTO_OFF), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("queue_reset", _state, _field, \
> +                                  VIRTIO_F_RING_RESET, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("in_order", _state, _field, \
> +                                  VIRTIO_F_IN_ORDER, ON_OFF_AUTO_OFF)
>  
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c949af97668d..bff26b95dd74 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_9_2[] = {};
> +GlobalProperty hw_compat_9_2[] = {
> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
> +};
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  
>  GlobalProperty hw_compat_9_1[] = {
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 896feb37a1ca..75d433b252d5 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -50,6 +50,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>      bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>      bool vdev_has_iommu;
>      Error *local_err = NULL;
> +    uint64_t features;
>  
>      DPRINTF("%s: plug device.\n", qbus->name);
>  
> @@ -63,13 +64,22 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>  
>      /* Get the features of the plugged device. */
>      assert(vdc->get_features != NULL);
> -    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
> -                                            &local_err);
> +    features = vdev->host_features | vdev->requested_features.auto_bits |
> +               vdev->requested_features.on_bits;
> +    features = vdc->get_features(vdev, features, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>  
> +    if (!vdev->force_features_auto &&
> +        (features & vdev->requested_features.on_bits) != vdev->requested_features.on_bits) {
> +        error_setg(errp, "A requested feature is not supported by the device");
> +        return;
> +    }
> +
> +    vdev->host_features = features;
> +
>      if (klass->device_plugged != NULL) {
>          klass->device_plugged(qbus->parent, &local_err);
>      }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..83f803fc703d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Object *obj)
>  }
>  
>  static const Property virtio_properties[] = {
> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
>      DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>                       disable_legacy_check, false),
> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
> +                     force_features_auto, false),
>  };
>  
>  static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
> 
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


