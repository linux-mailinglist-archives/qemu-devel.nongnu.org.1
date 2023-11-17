Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738347EF5FC
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:17:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41VH-0003Ql-0x; Fri, 17 Nov 2023 11:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r41V4-0003IH-Vl
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:15:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r41Uu-0008PQ-Me
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:15:22 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc2fc281cdso17841805ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700237589; x=1700842389;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qry6gkpt1rHGxuAtPfCdFFSNlg+lPviwm982UGxUT0s=;
 b=M8REnl614lJr/qSqzfGHrjx+u0H/S56caeArtYevpZ763Cec/E2DibMz93ZZxtSWeP
 oZHziuJJjcqsUpgdxnvn3OZ0bKmT8Fwz16IGy1t/yAQgKV+lfapfK882qGHTfkOvfe1x
 anWSuqmJM072pBOotizhCdkHJgx2sSPyDsocoIDnIFm9LY1mjDG1yXK11ACEeyqKKjV9
 KCV0DwYOZFYNWHYKIi3oOK7mxp8Tr+PZWhwG/uS7yoCd/iuz9dJYMdLWPXcTt4boyBYH
 2ZQTx5KGqjD17mnnEY4FLpdIXbHNU3VDPiQl1PFiA6bOqCr5gN56x8WDBQNW3/AyVwu/
 6Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700237589; x=1700842389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qry6gkpt1rHGxuAtPfCdFFSNlg+lPviwm982UGxUT0s=;
 b=kZYixjn4KvUsdm58nYeiqyN4Bg4j8ublBZYMXTPNzyuEKw8AfqGCbUHbe1lnfmUu+G
 3Qm0ucP48oa02Qob6VDSSoArCbB4q9U9Nao6zyXrA86I+7zsdgO6mqHMs7DI7JziV9jj
 il1ZrULfIlHm4AVRZLg02TaIrH61nQtV7TmBJX2e5Ks1aiZCGkPdv+niTqsiAbLJAPNY
 Y5iLruMXmUB2Wupn4HToCGY3PEDdOXDp/PdfuUE4Hh1hELP0jKgGrgTdRawncAdHxY1t
 6rhzpfFDNkShSm45yx5FXQao+oYP1WvqMJbm/7pS8h2fV8KD2e0I20k0bIEhw2i1kFOR
 G5dg==
X-Gm-Message-State: AOJu0YzvA+LCncOv8amLxQkI+j/qKi3az12W0pr/BBd+lXJsrCplgofp
 vE8s3Hq3XF25SnomPI23l6NCaO17xu2fRNA89S+fIQ==
X-Google-Smtp-Source: AGHT+IH2Jwau4+gpPEOk0Wnn0aOhSXC3WMKykSMzWeJhraErkAcK95So6HrIcJF9hlP0bOL2g/umjcM0Gp6oDzV0yvI=
X-Received: by 2002:a17:90b:38d1:b0:280:24c7:509 with SMTP id
 nn17-20020a17090b38d100b0028024c70509mr16614419pjb.46.1700237588600; Fri, 17
 Nov 2023 08:13:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
In-Reply-To: <87h6llep0o.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 18 Nov 2023 00:12:52 +0800
Message-ID: <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000080aecf060a5b699e"
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000080aecf060a5b699e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > This patch allows to display feature and status bits in virtio-status.
> >
> > An optional argument is introduced: show-bits. For example:
> > {"execute": "x-query-virtio-status",
> >  "arguments": {"path":
> "/machine/peripheral-anon/device[1]/virtio-backend",
> >                "show-bits": true}
> >
> > Features and status bits could be helpful for applications to compare
> > directly. For instance, when an upper application aims to ensure the
> > virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it us=
e
> > the "ovs-vsctl list interface" command to retrieve interface features
> > (in number format) and the QMP command x-query-virtio-status to retriev=
e
> > vhost-user net device features. If "show-bits" is added, the applicatio=
n
> > can compare the two features directly; No need to encoding the features
> > returned by the QMP command.
> >
> > This patch also serves as a preparation for the next one, which
> implements
> > a vhost-user test case about acked features of vhost-user protocol.
> >
> > Note that since the matching HMP command is typically used for human,
> > leave it unchanged.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  hw/virtio/virtio-hmp-cmds.c |  2 +-
> >  hw/virtio/virtio-qmp.c      | 21 +++++++++++++++-
> >  qapi/virtio.json            | 49 ++++++++++++++++++++++++++++++++++---
> >  3 files changed, 67 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> > index 477c97dea2..3774f3d4bf 100644
> > --- a/hw/virtio/virtio-hmp-cmds.c
> > +++ b/hw/virtio/virtio-hmp-cmds.c
> > @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >  {
> >      Error *err =3D NULL;
> >      const char *path =3D qdict_get_try_str(qdict, "path");
> > -    VirtioStatus *s =3D qmp_x_query_virtio_status(path, &err);
> > +    VirtioStatus *s =3D qmp_x_query_virtio_status(path, false, false,
> &err);
> >
> >      if (err !=3D NULL) {
> >          hmp_handle_error(mon, err);
> > diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> > index 1dd96ed20f..2e92bf28ac 100644
> > --- a/hw/virtio/virtio-qmp.c
> > +++ b/hw/virtio/virtio-qmp.c
> > @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const char
> *path)
> >      return VIRTIO_DEVICE(dev);
> >  }
> >
> > -VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp=
)
> > +VirtioStatus *qmp_x_query_virtio_status(const char *path,
> > +                                        bool has_show_bits,
> > +                                        bool show_bits,
> > +                                        Error **errp)
> >  {
> >      VirtIODevice *vdev;
> >      VirtioStatus *status;
> > +    bool display_bits =3D
> > +        has_show_bits ? show_bits : false;
>
> Since !has_show_bits implies !show_bits, you can simply use
> if (show_bits).
>
Ok

>
> >
> >      vdev =3D qmp_find_virtio_device(path);
> >      if (vdev =3D=3D NULL) {
> > @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >      status->name =3D g_strdup(vdev->name);
> >      status->device_id =3D vdev->device_id;
> >      status->vhost_started =3D vdev->vhost_started;
> > +    if (display_bits) {
> > +        status->guest_features_bits =3D vdev->guest_features;
> > +        status->host_features_bits =3D vdev->host_features;
> > +        status->backend_features_bits =3D vdev->backend_features;
> > +    }
> >      status->guest_features =3D qmp_decode_features(vdev->device_id,
> >                                                   vdev->guest_features)=
;
> >      status->host_features =3D qmp_decode_features(vdev->device_id,
> > @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >      }
> >
> >      status->num_vqs =3D virtio_get_num_queues(vdev);
> > +    if (display_bits) {
> > +        status->status_bits =3D vdev->status;
> > +    }
> >      status->status =3D qmp_decode_status(vdev->status);
> >      status->isr =3D vdev->isr;
> >      status->queue_sel =3D vdev->queue_sel;
> > @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >          status->vhost_dev->n_tmp_sections =3D hdev->n_tmp_sections;
> >          status->vhost_dev->nvqs =3D hdev->nvqs;
> >          status->vhost_dev->vq_index =3D hdev->vq_index;
> > +        if (display_bits) {
> > +            status->vhost_dev->features_bits =3D hdev->features;
> > +            status->vhost_dev->acked_features_bits =3D
> hdev->acked_features;
> > +            status->vhost_dev->backend_features_bits =3D
> hdev->backend_features;
> > +            status->vhost_dev->protocol_features_bits =3D
> hdev->protocol_features;
> > +        }
> >          status->vhost_dev->features =3D
> >              qmp_decode_features(vdev->device_id, hdev->features);
> >          status->vhost_dev->acked_features =3D
> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> > index e6dcee7b83..608b841a89 100644
> > --- a/qapi/virtio.json
> > +++ b/qapi/virtio.json
> > @@ -79,12 +79,20 @@
> >  #
> >  # @vq-index: vhost_dev vq_index
> >  #
> > +# @features-bits: vhost_dev features in decimal format
>
> Say "encoded as a number".  The number is decimal just because the
> transport is JSON.  We could have another transport some day.  Or
> language bindings wrapping around the JSON transport.
>
> > +#
> >  # @features: vhost_dev features
>
> Double-checking...  @feature-bits provides the exact same information as
> @features, only in another encoding.  Correct?


> Same for all the other new -bits.  Correct?

Yes, all the new fields are only about providing another encoding.

>
> >  #
> > +# @acked-features-bits: vhost_dev acked_features in decimal format
> > +#
> >  # @acked-features: vhost_dev acked_features
> >  #
> > +# @backend-features-bits: vhost_dev backend_features in decimal format
> > +#
> >  # @backend-features: vhost_dev backend_features
> >  #
> > +# @protocol-features-bits: vhost_dev protocol_features in decimal form=
at
> > +#
> >  # @protocol-features: vhost_dev protocol_features
> >  #
> >  # @max-queues: vhost_dev max_queues
> > @@ -102,9 +110,13 @@
> >              'n-tmp-sections': 'int',
> >              'nvqs': 'uint32',
> >              'vq-index': 'int',
> > +            'features-bits': 'uint64',
> >              'features': 'VirtioDeviceFeatures',
> > +            'acked-features-bits': 'uint64',
> >              'acked-features': 'VirtioDeviceFeatures',
> > +            'backend-features-bits': 'uint64',
> >              'backend-features': 'VirtioDeviceFeatures',
> > +            'protocol-features-bits': 'uint64',
> >              'protocol-features': 'VhostDeviceProtocols',
> >              'max-queues': 'uint64',
> >              'backend-cap': 'uint64',
> > @@ -124,10 +136,16 @@
> >  #
> >  # @vhost-started: VirtIODevice vhost_started flag
> >  #
> > +# @guest-features-bits: VirtIODevice guest_features in decimal format
> > +#
> >  # @guest-features: VirtIODevice guest_features
> >  #
> > +# @host-features-bits: VirtIODevice host_features in decimal format
> > +#
> >  # @host-features: VirtIODevice host_features
> >  #
> > +# @backend-features-bits: VirtIODevice backend_features in decimal
> format
> > +#
> >  # @backend-features: VirtIODevice backend_features
> >  #
> >  # @device-endian: VirtIODevice device_endian
> > @@ -135,6 +153,9 @@
> >  # @num-vqs: VirtIODevice virtqueue count.  This is the number of
> >  #     active virtqueues being used by the VirtIODevice.
> >  #
> > +# @status-bits: VirtIODevice configuration status in decimal format
> > +#     (VirtioDeviceStatus)
> > +#
> >  # @status: VirtIODevice configuration status (VirtioDeviceStatus)
> >  #
> >  # @isr: VirtIODevice ISR
> > @@ -170,10 +191,14 @@
> >              'device-id': 'uint16',
> >              'vhost-started': 'bool',
> >              'device-endian': 'str',
> > +            'guest-features-bits': 'uint64',
> >              'guest-features': 'VirtioDeviceFeatures',
> > +            'host-features-bits': 'uint64',
> >              'host-features': 'VirtioDeviceFeatures',
> > +            'backend-features-bits': 'uint64',
> >              'backend-features': 'VirtioDeviceFeatures',
> >              'num-vqs': 'int',
> > +            'status-bits': 'uint8',
> >              'status': 'VirtioDeviceStatus',
> >              'isr': 'uint8',
> >              'queue-sel': 'uint16',
> > @@ -195,6 +220,9 @@
> >  #
> >  # @path: Canonical QOM path of the VirtIODevice
> >  #
> > +# @show-bits: Whether to display the feature & status bits.
> > +#     Default is disabled. (Since 8.2)
>
> This makes the new members opt-in.  Why not include them always?
>

Agree, this makes things simple.

>
> > +#
> >  # Features:
> >  #
> >  # @unstable: This command is meant for debugging.
> > @@ -208,7 +236,8 @@
> >  # 1. Poll for the status of virtio-crypto (no vhost-crypto active)
> >  #
> >  # -> { "execute": "x-query-virtio-status",
> > -#      "arguments": { "path":
> "/machine/peripheral/crypto0/virtio-backend" }
> > +#      "arguments": { "path":
> "/machine/peripheral/crypto0/virtio-backend",
> > +#                     "show-bits": true }
> >  #    }
> >  # <- { "return": {
> >  #          "device-endian": "little",
> > @@ -216,6 +245,7 @@
> >  #          "disable-legacy-check": false,
> >  #          "name": "virtio-crypto",
> >  #          "started": true,
> > +#          "guest-features-bits": 5100273664,
> >  #          "device-id": 20,
> >  #          "backend-features": {
> >  #              "transports": [],
> > @@ -241,6 +271,7 @@
> >  #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)"
> >  #              ]
> >  #          },
> > +#          "host-features-bits": 6325010432,
> >  #          "host-features": {
> >  #              "unknown-dev-features": 1073741824,
> >  #              "dev-features": [],
> > @@ -252,9 +283,11 @@
> >  #                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> >  #              ]
> >  #          },
> > +#          "backend-features-bits": 0,
> >  #          "use-guest-notifier-mask": true,
> >  #          "vm-running": true,
> >  #          "queue-sel": 1,
> > +#          "status-bits": 15,
> >  #          "disabled": false,
> >  #          "vhost-started": false,
> >  #          "use-started": true
> > @@ -264,7 +297,8 @@
> >  # 2. Poll for the status of virtio-net (vhost-net is active)
> >  #
> >  # -> { "execute": "x-query-virtio-status",
> > -#      "arguments": { "path":
> "/machine/peripheral-anon/device[1]/virtio-backend" }
> > +#      "arguments": { "path":
> "/machine/peripheral-anon/device[1]/virtio-backend",
> > +#                     "show-bits": true }
> >  #    }
> >  # <- { "return": {
> >  #          "device-endian": "little",
> > @@ -272,11 +306,13 @@
> >  #          "disabled-legacy-check": false,
> >  #          "name": "virtio-net",
> >  #          "started": true,
> > +#          "guest-features-bits": 5111807911,
> >  #          "device-id": 1,
> >  #          "vhost-dev": {
> >  #              "n-tmp-sections": 4,
> >  #              "n-mem-sections": 4,
> >  #              "max-queues": 1,
> > +#              "features-bits": 13908344832
> >  #              "backend-cap": 2,
> >  #              "log-size": 0,
> >  #              "backend-features": {
> > @@ -284,6 +320,8 @@
> >  #                  "transports": []
> >  #              },
> >  #              "nvqs": 2,
> > +#              "acked-features-bits": 5100306432,
> > +#              "backend-features-bits": 0,
> >  #              "protocol-features": {
> >  #                  "protocols": []
> >  #              },
> > @@ -299,6 +337,7 @@
> >  #                      "VIRTIO_F_VERSION_1: Device compliant for v1
> spec (legacy)"
> >  #                  ]
> >  #              },
> > +#              "protocol-features-bits": 0,
> >  #              "features": {
> >  #                  "dev-features": [
> >  #                      "VHOST_F_LOG_ALL: Logging write descriptors
> supported",
> > @@ -387,6 +426,7 @@
> >  #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)"
> >  #             ]
> >  #          },
> > +#          "host-features-bits": 6337593319,
> >  #          "host-features": {
> >  #              "dev-features": [
> >  #                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protoco=
l
> features negotiation supported",
> > @@ -420,9 +460,11 @@
> >  #                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> >  #             ]
> >  #          },
> > +#          "backend-features-bits": 6337593319,
> >  #          "use-guest-notifier-mask": true,
> >  #          "vm-running": true,
> >  #          "queue-sel": 2,
> > +#          "status-bits": 15,
> >  #          "disabled": false,
> >  #          "vhost-started": true,
> >  #          "use-started": true
> > @@ -430,7 +472,8 @@
> >  #    }
> >  ##
> >  { 'command': 'x-query-virtio-status',
> > -  'data': { 'path': 'str' },
> > +  'data': { 'path': 'str',
> > +            '*show-bits': 'bool'},
> >    'returns': 'VirtioStatus',
> >    'features': [ 'unstable' ] }
>
>
Yong

--=20
Best regards

--00000000000080aecf060a5b699e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 16, 20=
23 at 10:44=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Hua=
ng &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huan=
g@smartx.com</a>&gt; writes:<br>
<br>
&gt; This patch allows to display feature and status bits in virtio-status.=
<br>
&gt;<br>
&gt; An optional argument is introduced: show-bits. For example:<br>
&gt; {&quot;execute&quot;: &quot;x-query-virtio-status&quot;,<br>
&gt;=C2=A0 &quot;arguments&quot;: {&quot;path&quot;: &quot;/machine/periphe=
ral-anon/device[1]/virtio-backend&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;show-bits=
&quot;: true}<br>
&gt;<br>
&gt; Features and status bits could be helpful for applications to compare<=
br>
&gt; directly. For instance, when an upper application aims to ensure the<b=
r>
&gt; virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it u=
se<br>
&gt; the &quot;ovs-vsctl list interface&quot; command to retrieve interface=
 features<br>
&gt; (in number format) and the QMP command x-query-virtio-status to retrie=
ve<br>
&gt; vhost-user net device features. If &quot;show-bits&quot; is added, the=
 application<br>
&gt; can compare the two features directly; No need to encoding the feature=
s<br>
&gt; returned by the QMP command.<br>
&gt;<br>
&gt; This patch also serves as a preparation for the next one, which implem=
ents<br>
&gt; a vhost-user test case about acked features of vhost-user protocol.<br=
>
&gt;<br>
&gt; Note that since the matching HMP command is typically used for human,<=
br>
&gt; leave it unchanged.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio-hmp-cmds.c |=C2=A0 2 +-<br>
&gt;=C2=A0 hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 | 21 +++++++++++++++-=
<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 49 +=
+++++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 3 files changed, 67 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c=
<br>
&gt; index 477c97dea2..3774f3d4bf 100644<br>
&gt; --- a/hw/virtio/virtio-hmp-cmds.c<br>
&gt; +++ b/hw/virtio/virtio-hmp-cmds.c<br>
&gt; @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict *=
qdict)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const char *path =3D qdict_get_try_str(qdict, &quo=
t;path&quot;);<br>
&gt; -=C2=A0 =C2=A0 VirtioStatus *s =3D qmp_x_query_virtio_status(path, &am=
p;err);<br>
&gt; +=C2=A0 =C2=A0 VirtioStatus *s =3D qmp_x_query_virtio_status(path, fal=
se, false, &amp;err);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_handle_error(mon, err);<br>
&gt; diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c<br>
&gt; index 1dd96ed20f..2e92bf28ac 100644<br>
&gt; --- a/hw/virtio/virtio-qmp.c<br>
&gt; +++ b/hw/virtio/virtio-qmp.c<br>
&gt; @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const char =
*path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return VIRTIO_DEVICE(dev);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **err=
p)<br>
&gt; +VirtioStatus *qmp_x_query_virtio_status(const char *path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=
 has_show_bits,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=
 show_bits,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Erro=
r **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtioStatus *status;<br>
&gt; +=C2=A0 =C2=A0 bool display_bits =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_show_bits ? show_bits : false;<br>
<br>
Since !has_show_bits implies !show_bits, you can simply use<br>
if (show_bits).<br></blockquote><div class=3D"gmail_default" style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif">Ok</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdev =3D qmp_find_virtio_device(path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (vdev =3D=3D NULL) {<br>
&gt; @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;name =3D g_strdup(vdev-&gt;name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;device_id =3D vdev-&gt;device_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_started =3D vdev-&gt;vhost_starte=
d;<br>
&gt; +=C2=A0 =C2=A0 if (display_bits) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;guest_features_bits =3D vdev-&=
gt;guest_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;host_features_bits =3D vdev-&g=
t;host_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;backend_features_bits =3D vdev=
-&gt;backend_features;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;guest_features =3D qmp_decode_features(=
vdev-&gt;device_id,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;guest_features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;host_features =3D qmp_decode_features(v=
dev-&gt;device_id,<br>
&gt; @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char=
 *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;num_vqs =3D virtio_get_num_queues(vdev)=
;<br>
&gt; +=C2=A0 =C2=A0 if (display_bits) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;status_bits =3D vdev-&gt;statu=
s;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;status =3D qmp_decode_status(vdev-&gt;s=
tatus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;isr =3D vdev-&gt;isr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;queue_sel =3D vdev-&gt;queue_sel;<br>
&gt; @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;n_tmp_secti=
ons =3D hdev-&gt;n_tmp_sections;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;nvqs =3D hd=
ev-&gt;nvqs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;vq_index =
=3D hdev-&gt;vq_index;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (display_bits) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;fe=
atures_bits =3D hdev-&gt;features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;ac=
ked_features_bits =3D hdev-&gt;acked_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;ba=
ckend_features_bits =3D hdev-&gt;backend_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;pr=
otocol_features_bits =3D hdev-&gt;protocol_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;features =
=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vd=
ev-&gt;device_id, hdev-&gt;features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;acked_featu=
res =3D<br>
&gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt; index e6dcee7b83..608b841a89 100644<br>
&gt; --- a/qapi/virtio.json<br>
&gt; +++ b/qapi/virtio.json<br>
&gt; @@ -79,12 +79,20 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @vq-index: vhost_dev vq_index<br>
&gt;=C2=A0 #<br>
&gt; +# @features-bits: vhost_dev features in decimal format<br>
<br>
Say &quot;encoded as a number&quot;.=C2=A0 The number is decimal just becau=
se the<br>
transport is JSON.=C2=A0 We could have another transport some day.=C2=A0 Or=
<br>
language bindings wrapping around the JSON transport.<br>
<br>
&gt; +#<br>
&gt;=C2=A0 # @features: vhost_dev features<br>
<br>
Double-checking...=C2=A0 @feature-bits provides the exact same information =
as<br>
@features, only in another encoding.=C2=A0 Correct?=C2=A0</blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);paddin=
g-left:1ex">
<br>
Same for all the other new -bits.=C2=A0 Correct?</blockquote><div class=3D"=
gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Y=
es, all the new fields are only about providing another encoding.</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt; +# @acked-features-bits: vhost_dev acked_features in decimal format<br=
>
&gt; +#<br>
&gt;=C2=A0 # @acked-features: vhost_dev acked_features<br>
&gt;=C2=A0 #<br>
&gt; +# @backend-features-bits: vhost_dev backend_features in decimal forma=
t<br>
&gt; +#<br>
&gt;=C2=A0 # @backend-features: vhost_dev backend_features<br>
&gt;=C2=A0 #<br>
&gt; +# @protocol-features-bits: vhost_dev protocol_features in decimal for=
mat<br>
&gt; +#<br>
&gt;=C2=A0 # @protocol-features: vhost_dev protocol_features<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @max-queues: vhost_dev max_queues<br>
&gt; @@ -102,9 +110,13 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;n-tmp-sections&#3=
9;: &#39;int&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;nvqs&#39;: &#39;u=
int32&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vq-index&#39;: &#=
39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features-bits&#39;: &#=
39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#=
39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acked-features-bits&#3=
9;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acked-features&#3=
9;: &#39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features-bits&=
#39;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&=
#39;: &#39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;protocol-features-bits=
&#39;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;protocol-features=
&#39;: &#39;VhostDeviceProtocols&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;max-queues&#39;: =
&#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-cap&#39;:=
 &#39;uint64&#39;,<br>
&gt; @@ -124,10 +136,16 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @vhost-started: VirtIODevice vhost_started flag<br>
&gt;=C2=A0 #<br>
&gt; +# @guest-features-bits: VirtIODevice guest_features in decimal format=
<br>
&gt; +#<br>
&gt;=C2=A0 # @guest-features: VirtIODevice guest_features<br>
&gt;=C2=A0 #<br>
&gt; +# @host-features-bits: VirtIODevice host_features in decimal format<b=
r>
&gt; +#<br>
&gt;=C2=A0 # @host-features: VirtIODevice host_features<br>
&gt;=C2=A0 #<br>
&gt; +# @backend-features-bits: VirtIODevice backend_features in decimal fo=
rmat<br>
&gt; +#<br>
&gt;=C2=A0 # @backend-features: VirtIODevice backend_features<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @device-endian: VirtIODevice device_endian<br>
&gt; @@ -135,6 +153,9 @@<br>
&gt;=C2=A0 # @num-vqs: VirtIODevice virtqueue count.=C2=A0 This is the numb=
er of<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0active virtqueues being used by the VirtIOD=
evice.<br>
&gt;=C2=A0 #<br>
&gt; +# @status-bits: VirtIODevice configuration status in decimal format<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0(VirtioDeviceStatus)<br>
&gt; +#<br>
&gt;=C2=A0 # @status: VirtIODevice configuration status (VirtioDeviceStatus=
)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @isr: VirtIODevice ISR<br>
&gt; @@ -170,10 +191,14 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;device-id&#39;: &=
#39;uint16&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vhost-started&#39=
;: &#39;bool&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;device-endian&#39=
;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-features-bits&#3=
9;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-features&#3=
9;: &#39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;host-features-bits&#39=
;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;host-features&#39=
;: &#39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features-bits&=
#39;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&=
#39;: &#39;VirtioDeviceFeatures&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;num-vqs&#39;: &#3=
9;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status-bits&#39;: &#39=
;uint8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39=
;VirtioDeviceStatus&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;isr&#39;: &#39;ui=
nt8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;queue-sel&#39;: &=
#39;uint16&#39;,<br>
&gt; @@ -195,6 +220,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @path: Canonical QOM path of the VirtIODevice<br>
&gt;=C2=A0 #<br>
&gt; +# @show-bits: Whether to display the feature &amp; status bits.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Default is disabled. (Since 8.2)<br>
<br>
This makes the new members opt-in.=C2=A0 Why not include them always?<br></=
blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif">Agree, this makes things simple.</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; +#<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: This command is meant for debugging.<br>
&gt; @@ -208,7 +236,8 @@<br>
&gt;=C2=A0 # 1. Poll for the status of virtio-crypto (no vhost-crypto activ=
e)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # -&gt; { &quot;execute&quot;: &quot;x-query-virtio-status&quot;=
,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &quot;path&quot;: &quo=
t;/machine/peripheral/crypto0/virtio-backend&quot; }<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &quot;path&quot;: &quo=
t;/machine/peripheral/crypto0/virtio-backend&quot;,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;show-bits&quot;: true }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 # &lt;- { &quot;return&quot;: {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device-endian&quot;: &=
quot;little&quot;,<br>
&gt; @@ -216,6 +245,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;disable-legacy-check&q=
uot;: false,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;virt=
io-crypto&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;started&quot;: true,<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features-bits&quot;: =
5100273664,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device-id&quot;: 20,<b=
r>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;=
: {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transpor=
ts&quot;: [],<br>
&gt; @@ -241,6 +271,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features-bits&quot;: 6=
325010432,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: {=
<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;unknown-=
dev-features&quot;: 1073741824,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-feat=
ures&quot;: [],<br>
&gt; @@ -252,9 +283,11 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs=
. on VQ&quot;<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features-bits&quot;=
: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-guest-notifier-mas=
k&quot;: true,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vm-running&quot;: true=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue-sel&quot;: 1,<br=
>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status-bits&quot;: 15,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;disabled&quot;: false,=
<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vhost-started&quot;: f=
alse,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-started&quot;: tru=
e<br>
&gt; @@ -264,7 +297,8 @@<br>
&gt;=C2=A0 # 2. Poll for the status of virtio-net (vhost-net is active)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # -&gt; { &quot;execute&quot;: &quot;x-query-virtio-status&quot;=
,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &quot;path&quot;: &quo=
t;/machine/peripheral-anon/device[1]/virtio-backend&quot; }<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &quot;path&quot;: &quo=
t;/machine/peripheral-anon/device[1]/virtio-backend&quot;,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;show-bits&quot;: true }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 # &lt;- { &quot;return&quot;: {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device-endian&quot;: &=
quot;little&quot;,<br>
&gt; @@ -272,11 +306,13 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;disabled-legacy-check&=
quot;: false,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;virt=
io-net&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;started&quot;: true,<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features-bits&quot;: =
5111807911,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device-id&quot;: 1,<br=
>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vhost-dev&quot;: {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;n-tmp-se=
ctions&quot;: 4,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;n-mem-se=
ctions&quot;: 4,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max-queu=
es&quot;: 1,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;features-bits=
&quot;: 13908344832<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-=
cap&quot;: 2,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;log-size=
&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-=
features&quot;: {<br>
&gt; @@ -284,6 +320,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;transports&quot;: []<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvqs&quo=
t;: 2,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acked-feature=
s-bits&quot;: 5100306432,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-featu=
res-bits&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;protocol=
-features&quot;: {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;protocols&quot;: []<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -299,6 +337,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legac=
y)&quot;<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;protocol-feat=
ures-bits&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;features=
&quot;: {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;dev-features&quot;: [<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;VHOST_F_LOG_ALL: Logging write descriptors supported&qu=
ot;,<br>
&gt; @@ -387,6 +426,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features-bits&quot;: 6=
337593319,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: {=
<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-feat=
ures&quot;: [<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiat=
ion supported&quot;,<br>
&gt; @@ -420,9 +460,11 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs=
. on VQ&quot;<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features-bits&quot;=
: 6337593319,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-guest-notifier-mas=
k&quot;: true,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vm-running&quot;: true=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue-sel&quot;: 2,<br=
>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status-bits&quot;: 15,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;disabled&quot;: false,=
<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vhost-started&quot;: t=
rue,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-started&quot;: tru=
e<br>
&gt; @@ -430,7 +472,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;x-query-virtio-status&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: { &#39;path&#39;: &#39;str&#39; },<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;path&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*show-bits&#39;: &#39;=
bool&#39;},<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: &#39;VirtioStatus&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;features&#39;: [ &#39;unstable&#39; ] }<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</div><br></div>=
<span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-ser=
if">Best regards</font></div></div></div>

--00000000000080aecf060a5b699e--

