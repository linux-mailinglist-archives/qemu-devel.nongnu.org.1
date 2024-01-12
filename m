Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D264682C164
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOIF6-0008Tc-Se; Fri, 12 Jan 2024 09:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rOIEx-0008Ix-A4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rOIEm-0001H0-GH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705068618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ivwpOCDAY5dzTFyV0UcMYws4Wcdh4m4tr1QrUejEoVU=;
 b=Bm8u/YSSeR2U8bEbNY9MVm4JhUI5a8xGmX65ekPb5KJfru0E0XW4m5gOpgmE7L31Mfogvi
 dhsnYaiADXZXOhHKMiNMxYMXq9Z/qCWEOE4VJawa0Ittn1gur9oXdWbQqpW/Nr3hm1vceN
 zJNISrE5FvHzClomTzRFKiqbzp+b5vU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-pxJHBxUXMtWbGzw2KfPU2A-1; Fri, 12 Jan 2024 09:10:15 -0500
X-MC-Unique: pxJHBxUXMtWbGzw2KfPU2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A26E585A58B;
 Fri, 12 Jan 2024 14:10:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 489381C0652C;
 Fri, 12 Jan 2024 14:10:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4863F21E6691; Fri, 12 Jan 2024 15:10:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] qapi/virtio: Keep feature and status bits in the
 QMP output
In-Reply-To: <5a4bda9178716939cb641d40f9e628dc44209576.1704382761.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Fri, 5 Jan 2024 00:19:34 +0800")
References: <cover.1704382761.git.yong.huang@smartx.com>
 <5a4bda9178716939cb641d40f9e628dc44209576.1704382761.git.yong.huang@smartx.com>
Date: Fri, 12 Jan 2024 15:10:13 +0100
Message-ID: <87edemod6i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hyman Huang <yong.huang@smartx.com> writes:

> Maintain the feature and status bits in the x-query-virtio-status
> output and, as usual, add human-readable output only in HMP.
>
> Applications may find it useful to compare features and status
> information directly. An upper application, for example, could
> use the QMP command x-query-virtio-status to retrieve vhost-user
> net device features and the "ovs-vsctl list interface" command to
> retrieve interface features (in number format) in order to verify
> the correctness of the virtio negotiation between guest, QEMU,
> and OVS-DPDK. The application could then compare the two features
> directly, without the need for additional feature encoding.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

A bit terse.  Here's my try:

    qmp: Switch x-query-virtio-status back to numeric encoding

    x-query-virtio-status returns several sets of virtio feature and
    status flags.  It goes back to v7.2.0.

    In the initial commit 90c066cd682 (qmp: add QMP command
    x-query-virtio-status), we returned them as numbers, using virtio's
    well-known binary encoding.

    The next commit f3034ad71fc (qmp: decode feature & status bits in
    virtio-status) replaced the numbers by objects.  The objects represent
    bits QEMU knows symbolically, and any unknown bits numerically just like
    before.

    Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command
    "info virtio" (and a few more, which aren't relevant here).

    The symbolic representation uses lists of strings.  The string format is
    undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
    explanation".

    This symbolic representation is nice for humans.  Machines it can save
    the trouble of decoding virtio's well-known binary encoding.

    However, we sometimes want to compare features and status bits without
    caring for their exact meaning.  Say we want to verify the correctness
    of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
    QMP command x-query-virtio-status to retrieve vhost-user net device
    features, and the "ovs-vsctl list interface" command to retrieve
    interface features.  Without commit f3034ad71fc, we could then simply
    compare the numbers.  With this commit, we first have to map from the
    strings back to the numeric encoding.

    Revert the decoding for QMP, but keep it for HMP.

    This makes the QMP command easier to use for use cases where we
    don't need to decode, like the comparison above.  For use cases
    where we need to decode, we replace parsing undocumented strings by
    decoding virtio's well-known binary encoding.

    Incompatible change; acceptable because x-query-virtio-status does
    comes without a stability promise.

> ---
>  hw/virtio/virtio-hmp-cmds.c |  29 ++++--
>  hw/virtio/virtio-qmp.c      |  23 ++---
>  qapi/virtio.json            | 192 ++++--------------------------------
>  3 files changed, 48 insertions(+), 196 deletions(-)
>
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 477c97dea2..4fabba4f9c 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "virtio-qmp.h"
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
>  #include "qapi/qapi-commands-virtio.h"
> @@ -13,8 +14,10 @@
>  
>  
>  static void hmp_virtio_dump_protocols(Monitor *mon,
> -                                      VhostDeviceProtocols *pcol)
> +                                      uint64_t bitmap)
>  {
> +    VhostDeviceProtocols *pcol = qmp_decode_protocols(bitmap);
> +
>      strList *pcol_list = pcol->protocols;
>      while (pcol_list) {
>          monitor_printf(mon, "\t%s", pcol_list->value);
> @@ -31,8 +34,10 @@ static void hmp_virtio_dump_protocols(Monitor *mon,
>  }
>  
>  static void hmp_virtio_dump_status(Monitor *mon,
> -                                   VirtioDeviceStatus *status)
> +                                   uint64_t bitmap)
>  {
> +    VirtioDeviceStatus *status = qmp_decode_status(bitmap);
> +
>      strList *status_list = status->statuses;
>      while (status_list) {
>          monitor_printf(mon, "\t%s", status_list->value);
> @@ -49,8 +54,12 @@ static void hmp_virtio_dump_status(Monitor *mon,
>  }
>  
>  static void hmp_virtio_dump_features(Monitor *mon,
> -                                     VirtioDeviceFeatures *features)
> +                                     uint16_t device_id,
> +                                     uint64_t bitmap)
>  {
> +    VirtioDeviceFeatures *features =
> +        qmp_decode_features(device_id, bitmap);
> +
>      strList *transport_list = features->transports;
>      while (transport_list) {
>          monitor_printf(mon, "\t%s", transport_list->value);
> @@ -147,11 +156,11 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>      monitor_printf(mon, "  status:\n");
>      hmp_virtio_dump_status(mon, s->status);
>      monitor_printf(mon, "  Guest features:\n");
> -    hmp_virtio_dump_features(mon, s->guest_features);
> +    hmp_virtio_dump_features(mon, s->device_id, s->guest_features);
>      monitor_printf(mon, "  Host features:\n");
> -    hmp_virtio_dump_features(mon, s->host_features);
> +    hmp_virtio_dump_features(mon, s->device_id, s->host_features);
>      monitor_printf(mon, "  Backend features:\n");
> -    hmp_virtio_dump_features(mon, s->backend_features);
> +    hmp_virtio_dump_features(mon, s->device_id, s->backend_features);
>  
>      if (s->vhost_dev) {
>          monitor_printf(mon, "  VHost:\n");
> @@ -172,11 +181,13 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "    log_size:       %"PRId64"\n",
>                         s->vhost_dev->log_size);
>          monitor_printf(mon, "    Features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> +        hmp_virtio_dump_features(mon, s->device_id, s->vhost_dev->features);
>          monitor_printf(mon, "    Acked features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> +        hmp_virtio_dump_features(mon,
> +                s->device_id, s->vhost_dev->acked_features);
>          monitor_printf(mon, "    Backend features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
> +        hmp_virtio_dump_features(mon,
> +                s->device_id, s->vhost_dev->backend_features);
>          monitor_printf(mon, "    Protocol features:\n");
>          hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
>      }
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 1dd96ed20f..1660c17653 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      status->name = g_strdup(vdev->name);
>      status->device_id = vdev->device_id;
>      status->vhost_started = vdev->vhost_started;
> -    status->guest_features = qmp_decode_features(vdev->device_id,
> -                                                 vdev->guest_features);
> -    status->host_features = qmp_decode_features(vdev->device_id,
> -                                                vdev->host_features);
> -    status->backend_features = qmp_decode_features(vdev->device_id,
> -                                                   vdev->backend_features);
> +    status->guest_features = vdev->guest_features;
> +    status->host_features = vdev->host_features;
> +    status->backend_features = vdev->backend_features;
>  
>      switch (vdev->device_endian) {
>      case VIRTIO_DEVICE_ENDIAN_LITTLE:
> @@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      }
>  
>      status->num_vqs = virtio_get_num_queues(vdev);
> -    status->status = qmp_decode_status(vdev->status);
> +    status->status = vdev->status;
>      status->isr = vdev->isr;
>      status->queue_sel = vdev->queue_sel;
>      status->vm_running = vdev->vm_running;
> @@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>          status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
>          status->vhost_dev->nvqs = hdev->nvqs;
>          status->vhost_dev->vq_index = hdev->vq_index;
> -        status->vhost_dev->features =
> -            qmp_decode_features(vdev->device_id, hdev->features);
> -        status->vhost_dev->acked_features =
> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
> -        status->vhost_dev->backend_features =
> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
> -        status->vhost_dev->protocol_features =
> -            qmp_decode_protocols(hdev->protocol_features);
> +        status->vhost_dev->features = hdev->features;
> +        status->vhost_dev->acked_features = hdev->acked_features;
> +        status->vhost_dev->backend_features = hdev->backend_features;
> +        status->vhost_dev->protocol_features = hdev->protocol_features;
>          status->vhost_dev->max_queues = hdev->max_queues;
>          status->vhost_dev->backend_cap = hdev->backend_cap;
>          status->vhost_dev->log_enabled = hdev->log_enabled;
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 19c7c36e36..26516fb29c 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -102,10 +102,10 @@
>              'n-tmp-sections': 'int',
>              'nvqs': 'uint32',
>              'vq-index': 'int',
> -            'features': 'VirtioDeviceFeatures',
> -            'acked-features': 'VirtioDeviceFeatures',
> -            'backend-features': 'VirtioDeviceFeatures',
> -            'protocol-features': 'VhostDeviceProtocols',
> +            'features': 'uint64',
> +            'acked-features': 'uint64',
> +            'backend-features': 'uint64',
> +            'protocol-features': 'uint64',
>              'max-queues': 'uint64',
>              'backend-cap': 'uint64',
>              'log-enabled': 'bool',
> @@ -170,11 +170,11 @@
>              'device-id': 'uint16',
>              'vhost-started': 'bool',
>              'device-endian': 'str',
> -            'guest-features': 'VirtioDeviceFeatures',
> -            'host-features': 'VirtioDeviceFeatures',
> -            'backend-features': 'VirtioDeviceFeatures',
> +            'guest-features': 'uint64',
> +            'host-features': 'uint64',
> +            'backend-features': 'uint64',
>              'num-vqs': 'int',
> -            'status': 'VirtioDeviceStatus',
> +            'status': 'uint8',
>              'isr': 'uint8',
>              'queue-sel': 'uint16',
>              'vm-running': 'bool',
> @@ -217,41 +217,14 @@
>  #          "name": "virtio-crypto",
>  #          "started": true,
>  #          "device-id": 20,
> -#          "backend-features": {
> -#              "transports": [],
> -#              "dev-features": []
> -#          },
> +#          "backend-features": 0,
>  #          "start-on-kick": false,
>  #          "isr": 1,
>  #          "broken": false,
> -#          "status": {
> -#              "statuses": [
> -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
> -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
> -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
> -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> -#              ]
> -#          },
> +#          "status": 15,
>  #          "num-vqs": 2,
> -#          "guest-features": {
> -#              "dev-features": [],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
> -#              ]
> -#          },
> -#          "host-features": {
> -#              "unknown-dev-features": 1073741824,
> -#              "dev-features": [],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#              ]
> -#          },
> +#          "guest-features": 5100273664,
> +#          "host-features": 6325010432,
>  #          "use-guest-notifier-mask": true,
>  #          "vm-running": true,
>  #          "queue-sel": 1,
> @@ -279,147 +252,22 @@
>  #              "max-queues": 1,
>  #              "backend-cap": 2,
>  #              "log-size": 0,
> -#              "backend-features": {
> -#                  "dev-features": [],
> -#                  "transports": []
> -#              },
> +#              "backend-features": 0,
>  #              "nvqs": 2,
> -#              "protocol-features": {
> -#                  "protocols": []
> -#              },
> +#              "protocol-features": 0,
>  #              "vq-index": 0,
>  #              "log-enabled": false,
> -#              "acked-features": {
> -#                  "dev-features": [
> -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
> -#                  ],
> -#                  "transports": [
> -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
> -#                  ]
> -#              },
> -#              "features": {
> -#                  "dev-features": [
> -#                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
> -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
> -#                  ],
> -#                  "transports": [
> -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
> -#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#                  ]
> -#              }
> -#          },
> -#          "backend-features": {
> -#              "dev-features": [
> -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
> -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
> -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
> -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
> -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
> -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
> -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
> -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> -#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
> -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
> -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
> -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
> -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
> -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
> -#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
> -#              ],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#              ]
> +#              "acked-features": 5100306432,
> +#              "features": 13908344832,
>  #          },
> +#          "backend-features": 6337593319,
>  #          "start-on-kick": false,
>  #          "isr": 1,
>  #          "broken": false,
> -#          "status": {
> -#              "statuses": [
> -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
> -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
> -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
> -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> -#              ]
> -#          },
> +#          "status": 15,
>  #          "num-vqs": 3,
> -#          "guest-features": {
> -#              "dev-features": [
> -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
> -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
> -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
> -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
> -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> -#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
> -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
> -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
> -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
> -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
> -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
> -#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
> -#              ],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
> -#             ]
> -#          },
> -#          "host-features": {
> -#              "dev-features": [
> -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
> -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
> -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
> -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
> -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
> -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
> -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
> -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> -#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
> -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
> -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
> -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
> -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
> -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
> -#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
> -#              ],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#             ]
> -#          },
> +#          "guest-features": 5111807911,
> +#          "host-features": 6337593319,
>  #          "use-guest-notifier-mask": true,
>  #          "vm-running": true,
>  #          "queue-sel": 2,

qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()
are now only used in virtio-hmp-cmds.c.  Please move them there, and
replace the qmp_ prefix by hmp_ or simply drop it.

VhostDeviceProtocols and VirtioDeviceFeatures are then only used in
virtio-hmp-cmds.c.  Please define them as plain C types there, and drop
them from the QAPI schema.

You may want to do this as a separate cleanup commit.  Use your
judgement.


