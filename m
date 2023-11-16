Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FD7EE33A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 15:46:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dc5-0001SR-7W; Thu, 16 Nov 2023 09:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3dbw-0001S9-HW
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3dbt-0002pY-Bc
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700145886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bfLBsjQEfyPZDMfHjpeCH3QJItHxdsLnWOg629D6eeM=;
 b=GIRQrV3IjTx8KZJbKMTSTxO0KfxgbVCxuAdiLg87P2tg8REM9I/zr2wJBHzn8X7rmUasLO
 nooSsQxuBNgj8YhoUc+tVZEkRP2gTfSUJb66A1V3EoFU7bSQFGP1Zp21V395XNQDPM4Lem
 xWY8uN7ZV4W/3jF3nYcVI2CqKekkGkc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-xMj2XlmhMT2yZKiEBfk06w-1; Thu,
 16 Nov 2023 09:44:41 -0500
X-MC-Unique: xMj2XlmhMT2yZKiEBfk06w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4406D3827DE2;
 Thu, 16 Nov 2023 14:44:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5DAD492BE0;
 Thu, 16 Nov 2023 14:44:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B09B521E6A1F; Thu, 16 Nov 2023 15:44:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
Date: Thu, 16 Nov 2023 15:44:39 +0100
In-Reply-To: <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Sun, 12 Nov 2023 21:03:19 +0800")
Message-ID: <87h6llep0o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This patch allows to display feature and status bits in virtio-status.
>
> An optional argument is introduced: show-bits. For example:
> {"execute": "x-query-virtio-status",
>  "arguments": {"path": "/machine/peripheral-anon/device[1]/virtio-backend",
>                "show-bits": true}
>
> Features and status bits could be helpful for applications to compare
> directly. For instance, when an upper application aims to ensure the
> virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it use
> the "ovs-vsctl list interface" command to retrieve interface features
> (in number format) and the QMP command x-query-virtio-status to retrieve
> vhost-user net device features. If "show-bits" is added, the application
> can compare the two features directly; No need to encoding the features
> returned by the QMP command.
>
> This patch also serves as a preparation for the next one, which implements
> a vhost-user test case about acked features of vhost-user protocol.
>
> Note that since the matching HMP command is typically used for human,
> leave it unchanged.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  hw/virtio/virtio-hmp-cmds.c |  2 +-
>  hw/virtio/virtio-qmp.c      | 21 +++++++++++++++-
>  qapi/virtio.json            | 49 ++++++++++++++++++++++++++++++++++---
>  3 files changed, 67 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 477c97dea2..3774f3d4bf 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
>      const char *path = qdict_get_try_str(qdict, "path");
> -    VirtioStatus *s = qmp_x_query_virtio_status(path, &err);
> +    VirtioStatus *s = qmp_x_query_virtio_status(path, false, false, &err);
>  
>      if (err != NULL) {
>          hmp_handle_error(mon, err);
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 1dd96ed20f..2e92bf28ac 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const char *path)
>      return VIRTIO_DEVICE(dev);
>  }
>  
> -VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
> +VirtioStatus *qmp_x_query_virtio_status(const char *path,
> +                                        bool has_show_bits,
> +                                        bool show_bits,
> +                                        Error **errp)
>  {
>      VirtIODevice *vdev;
>      VirtioStatus *status;
> +    bool display_bits =
> +        has_show_bits ? show_bits : false;

Since !has_show_bits implies !show_bits, you can simply use
if (show_bits).

>  
>      vdev = qmp_find_virtio_device(path);
>      if (vdev == NULL) {
> @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      status->name = g_strdup(vdev->name);
>      status->device_id = vdev->device_id;
>      status->vhost_started = vdev->vhost_started;
> +    if (display_bits) {
> +        status->guest_features_bits = vdev->guest_features;
> +        status->host_features_bits = vdev->host_features;
> +        status->backend_features_bits = vdev->backend_features;
> +    }
>      status->guest_features = qmp_decode_features(vdev->device_id,
>                                                   vdev->guest_features);
>      status->host_features = qmp_decode_features(vdev->device_id,
> @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      }
>  
>      status->num_vqs = virtio_get_num_queues(vdev);
> +    if (display_bits) {
> +        status->status_bits = vdev->status;
> +    }
>      status->status = qmp_decode_status(vdev->status);
>      status->isr = vdev->isr;
>      status->queue_sel = vdev->queue_sel;
> @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>          status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
>          status->vhost_dev->nvqs = hdev->nvqs;
>          status->vhost_dev->vq_index = hdev->vq_index;
> +        if (display_bits) {
> +            status->vhost_dev->features_bits = hdev->features;
> +            status->vhost_dev->acked_features_bits = hdev->acked_features;
> +            status->vhost_dev->backend_features_bits = hdev->backend_features;
> +            status->vhost_dev->protocol_features_bits = hdev->protocol_features;
> +        }
>          status->vhost_dev->features =
>              qmp_decode_features(vdev->device_id, hdev->features);
>          status->vhost_dev->acked_features =
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index e6dcee7b83..608b841a89 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -79,12 +79,20 @@
>  #
>  # @vq-index: vhost_dev vq_index
>  #
> +# @features-bits: vhost_dev features in decimal format

Say "encoded as a number".  The number is decimal just because the
transport is JSON.  We could have another transport some day.  Or
language bindings wrapping around the JSON transport.

> +#
>  # @features: vhost_dev features

Double-checking...  @feature-bits provides the exact same information as
@features, only in another encoding.  Correct?

Same for all the other new -bits.  Correct?

>  #
> +# @acked-features-bits: vhost_dev acked_features in decimal format
> +#
>  # @acked-features: vhost_dev acked_features
>  #
> +# @backend-features-bits: vhost_dev backend_features in decimal format
> +#
>  # @backend-features: vhost_dev backend_features
>  #
> +# @protocol-features-bits: vhost_dev protocol_features in decimal format
> +#
>  # @protocol-features: vhost_dev protocol_features
>  #
>  # @max-queues: vhost_dev max_queues
> @@ -102,9 +110,13 @@
>              'n-tmp-sections': 'int',
>              'nvqs': 'uint32',
>              'vq-index': 'int',
> +            'features-bits': 'uint64',
>              'features': 'VirtioDeviceFeatures',
> +            'acked-features-bits': 'uint64',
>              'acked-features': 'VirtioDeviceFeatures',
> +            'backend-features-bits': 'uint64',
>              'backend-features': 'VirtioDeviceFeatures',
> +            'protocol-features-bits': 'uint64',
>              'protocol-features': 'VhostDeviceProtocols',
>              'max-queues': 'uint64',
>              'backend-cap': 'uint64',
> @@ -124,10 +136,16 @@
>  #
>  # @vhost-started: VirtIODevice vhost_started flag
>  #
> +# @guest-features-bits: VirtIODevice guest_features in decimal format
> +#
>  # @guest-features: VirtIODevice guest_features
>  #
> +# @host-features-bits: VirtIODevice host_features in decimal format
> +#
>  # @host-features: VirtIODevice host_features
>  #
> +# @backend-features-bits: VirtIODevice backend_features in decimal format
> +#
>  # @backend-features: VirtIODevice backend_features
>  #
>  # @device-endian: VirtIODevice device_endian
> @@ -135,6 +153,9 @@
>  # @num-vqs: VirtIODevice virtqueue count.  This is the number of
>  #     active virtqueues being used by the VirtIODevice.
>  #
> +# @status-bits: VirtIODevice configuration status in decimal format
> +#     (VirtioDeviceStatus)
> +#
>  # @status: VirtIODevice configuration status (VirtioDeviceStatus)
>  #
>  # @isr: VirtIODevice ISR
> @@ -170,10 +191,14 @@
>              'device-id': 'uint16',
>              'vhost-started': 'bool',
>              'device-endian': 'str',
> +            'guest-features-bits': 'uint64',
>              'guest-features': 'VirtioDeviceFeatures',
> +            'host-features-bits': 'uint64',
>              'host-features': 'VirtioDeviceFeatures',
> +            'backend-features-bits': 'uint64',
>              'backend-features': 'VirtioDeviceFeatures',
>              'num-vqs': 'int',
> +            'status-bits': 'uint8',
>              'status': 'VirtioDeviceStatus',
>              'isr': 'uint8',
>              'queue-sel': 'uint16',
> @@ -195,6 +220,9 @@
>  #
>  # @path: Canonical QOM path of the VirtIODevice
>  #
> +# @show-bits: Whether to display the feature & status bits.
> +#     Default is disabled. (Since 8.2)

This makes the new members opt-in.  Why not include them always?

> +#
>  # Features:
>  #
>  # @unstable: This command is meant for debugging.
> @@ -208,7 +236,8 @@
>  # 1. Poll for the status of virtio-crypto (no vhost-crypto active)
>  #
>  # -> { "execute": "x-query-virtio-status",
> -#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
> +#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
> +#                     "show-bits": true }
>  #    }
>  # <- { "return": {
>  #          "device-endian": "little",
> @@ -216,6 +245,7 @@
>  #          "disable-legacy-check": false,
>  #          "name": "virtio-crypto",
>  #          "started": true,
> +#          "guest-features-bits": 5100273664,
>  #          "device-id": 20,
>  #          "backend-features": {
>  #              "transports": [],
> @@ -241,6 +271,7 @@
>  #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
>  #              ]
>  #          },
> +#          "host-features-bits": 6325010432,
>  #          "host-features": {
>  #              "unknown-dev-features": 1073741824,
>  #              "dev-features": [],
> @@ -252,9 +283,11 @@
>  #                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
>  #              ]
>  #          },
> +#          "backend-features-bits": 0,
>  #          "use-guest-notifier-mask": true,
>  #          "vm-running": true,
>  #          "queue-sel": 1,
> +#          "status-bits": 15,
>  #          "disabled": false,
>  #          "vhost-started": false,
>  #          "use-started": true
> @@ -264,7 +297,8 @@
>  # 2. Poll for the status of virtio-net (vhost-net is active)
>  #
>  # -> { "execute": "x-query-virtio-status",
> -#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
> +#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
> +#                     "show-bits": true }
>  #    }
>  # <- { "return": {
>  #          "device-endian": "little",
> @@ -272,11 +306,13 @@
>  #          "disabled-legacy-check": false,
>  #          "name": "virtio-net",
>  #          "started": true,
> +#          "guest-features-bits": 5111807911,
>  #          "device-id": 1,
>  #          "vhost-dev": {
>  #              "n-tmp-sections": 4,
>  #              "n-mem-sections": 4,
>  #              "max-queues": 1,
> +#              "features-bits": 13908344832
>  #              "backend-cap": 2,
>  #              "log-size": 0,
>  #              "backend-features": {
> @@ -284,6 +320,8 @@
>  #                  "transports": []
>  #              },
>  #              "nvqs": 2,
> +#              "acked-features-bits": 5100306432,
> +#              "backend-features-bits": 0,
>  #              "protocol-features": {
>  #                  "protocols": []
>  #              },
> @@ -299,6 +337,7 @@
>  #                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
>  #                  ]
>  #              },
> +#              "protocol-features-bits": 0,
>  #              "features": {
>  #                  "dev-features": [
>  #                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
> @@ -387,6 +426,7 @@
>  #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
>  #             ]
>  #          },
> +#          "host-features-bits": 6337593319,
>  #          "host-features": {
>  #              "dev-features": [
>  #                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
> @@ -420,9 +460,11 @@
>  #                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
>  #             ]
>  #          },
> +#          "backend-features-bits": 6337593319,
>  #          "use-guest-notifier-mask": true,
>  #          "vm-running": true,
>  #          "queue-sel": 2,
> +#          "status-bits": 15,
>  #          "disabled": false,
>  #          "vhost-started": true,
>  #          "use-started": true
> @@ -430,7 +472,8 @@
>  #    }
>  ##
>  { 'command': 'x-query-virtio-status',
> -  'data': { 'path': 'str' },
> +  'data': { 'path': 'str',
> +            '*show-bits': 'bool'},
>    'returns': 'VirtioStatus',
>    'features': [ 'unstable' ] }


