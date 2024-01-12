Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E982C275
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:05:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ5Y-0008C6-5I; Fri, 12 Jan 2024 10:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rOJ5I-000844-Ai
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:04:40 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rOJ5D-0002Hk-5w
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:04:36 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28beb1d946fso5510807a91.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1705071746; x=1705676546;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8viXKnKDVDcnr0Q3Tc+iCw/PhufFvsBD3JQ1GCrMJrc=;
 b=Mmsnpaofm7huaO7e2/uAOku/zhfM5u3y7CBhobwndahpzzIBAEv5nffWRRfLBl2dHf
 18vw38bcNelrFlCA43ojhdp6HyTKBZ0SUqIdcTppVBpGvBkfW70w6ebTEhmxxA8Eesm+
 ddG4SUEGvH4M4s1KqQyOJWBlwgu3GW4m2bdj2vqm3LkDWYH4ZY6arCLQPmSAfsidkkbW
 k8TD21SpbevCjmzuACzsBJqU3JICyrgaRlJLP6RTibrl8p8rsnzIEExnwkt3ls3OzYI/
 1NGRhyOse+Tv7s88x/SI7kuZISsp9VSrPbcLF6SQv5cZRLgw92NXcm+L1NJL5wvlMv4S
 OVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705071746; x=1705676546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8viXKnKDVDcnr0Q3Tc+iCw/PhufFvsBD3JQ1GCrMJrc=;
 b=vTvI1E/vf3AhtoO6iJGkIRsvSwnuHFEcZZ4hNDuEdnuBBu5DmHpIJjWBp1USDkhMyj
 LQz+Yiawz/Z8Zg52KeRFVZgSVxEr8acOWP/+u+00UOoCrEXW1H7VIqsHciQY8JlL1Jj9
 M7ij0ELJJK3NIjz+JKQh4nYciioJSESVlWNKVj2O1xCEybj7CTbv8URWIc3nhvFmlmPQ
 /5T0N3JLK8Hp3SsQ9HqupiIlW2FOBlhSa7y9iMBrccb4BmK/PdSpVPqhuFiSE18XZR9d
 RP8ozAqqQvrCEzXQZVYvS53fZsmrEj4XmM4jBnRc0/xiCHwVDAcPmeZGYksMvPgzotJw
 4hTg==
X-Gm-Message-State: AOJu0YwQFDXG3kjlFgSHd04CaFotIuV/v2wbMhUbBsjpCWxJnGZAuiLu
 nGUX++2ixbfS2+KpiH5pfVubja2klUP7UuW6WK+ziBypYLwisA==
X-Google-Smtp-Source: AGHT+IGiqJaWr8767JjDeZ9ov6TgsavFb1vXhHIhqSK89h7uw1E2JNh7DuJREh1JqOuWgrde8TwbCwZkziOnPhA/Iu8=
X-Received: by 2002:a17:90b:1007:b0:28d:2d5:ffec with SMTP id
 gm7-20020a17090b100700b0028d02d5ffecmr1316018pjb.93.1705071744429; Fri, 12
 Jan 2024 07:02:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1704382761.git.yong.huang@smartx.com>
 <5a4bda9178716939cb641d40f9e628dc44209576.1704382761.git.yong.huang@smartx.com>
 <87edemod6i.fsf@pond.sub.org>
In-Reply-To: <87edemod6i.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 12 Jan 2024 23:02:06 +0800
Message-ID: <CAK9dgmbO2ciY4iOwqXAHOKrFi-E2_6hCK3D3stYS3oDMK2sd1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] qapi/virtio: Keep feature and status bits in the
 QMP output
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a4c1b3060ec0f389"
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102f.google.com
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

--000000000000a4c1b3060ec0f389
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:10=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > Maintain the feature and status bits in the x-query-virtio-status
> > output and, as usual, add human-readable output only in HMP.
> >
> > Applications may find it useful to compare features and status
> > information directly. An upper application, for example, could
> > use the QMP command x-query-virtio-status to retrieve vhost-user
> > net device features and the "ovs-vsctl list interface" command to
> > retrieve interface features (in number format) in order to verify
> > the correctness of the virtio negotiation between guest, QEMU,
> > and OVS-DPDK. The application could then compare the two features
> > directly, without the need for additional feature encoding.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>
> A bit terse.  Here's my try:
>
>     qmp: Switch x-query-virtio-status back to numeric encoding
>
>     x-query-virtio-status returns several sets of virtio feature and
>     status flags.  It goes back to v7.2.0.
>
>     In the initial commit 90c066cd682 (qmp: add QMP command
>     x-query-virtio-status), we returned them as numbers, using virtio's
>     well-known binary encoding.
>
>     The next commit f3034ad71fc (qmp: decode feature & status bits in
>     virtio-status) replaced the numbers by objects.  The objects represen=
t
>     bits QEMU knows symbolically, and any unknown bits numerically just
> like
>     before.
>
>     Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP comman=
d
>     "info virtio" (and a few more, which aren't relevant here).
>
>     The symbolic representation uses lists of strings.  The string format
> is
>     undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readab=
le
>     explanation".
>
>     This symbolic representation is nice for humans.  Machines it can sav=
e
>     the trouble of decoding virtio's well-known binary encoding.
>
>     However, we sometimes want to compare features and status bits withou=
t
>     caring for their exact meaning.  Say we want to verify the correctnes=
s
>     of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can
> use
>     QMP command x-query-virtio-status to retrieve vhost-user net device
>     features, and the "ovs-vsctl list interface" command to retrieve
>     interface features.  Without commit f3034ad71fc, we could then simply
>     compare the numbers.  With this commit, we first have to map from the
>     strings back to the numeric encoding.
>
>     Revert the decoding for QMP, but keep it for HMP.
>
>     This makes the QMP command easier to use for use cases where we
>     don't need to decode, like the comparison above.  For use cases
>     where we need to decode, we replace parsing undocumented strings by
>     decoding virtio's well-known binary encoding.
>
>     Incompatible change; acceptable because x-query-virtio-status does
>     comes without a stability promise.
>

Thanks for the refining, I'll post this commit message in the next version.


>
> > ---
> >  hw/virtio/virtio-hmp-cmds.c |  29 ++++--
> >  hw/virtio/virtio-qmp.c      |  23 ++---
> >  qapi/virtio.json            | 192 ++++--------------------------------
> >  3 files changed, 48 insertions(+), 196 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> > index 477c97dea2..4fabba4f9c 100644
> > --- a/hw/virtio/virtio-hmp-cmds.c
> > +++ b/hw/virtio/virtio-hmp-cmds.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "virtio-qmp.h"
> >  #include "monitor/hmp.h"
> >  #include "monitor/monitor.h"
> >  #include "qapi/qapi-commands-virtio.h"
> > @@ -13,8 +14,10 @@
> >
> >
> >  static void hmp_virtio_dump_protocols(Monitor *mon,
> > -                                      VhostDeviceProtocols *pcol)
> > +                                      uint64_t bitmap)
> >  {
> > +    VhostDeviceProtocols *pcol =3D qmp_decode_protocols(bitmap);
> > +
> >      strList *pcol_list =3D pcol->protocols;
> >      while (pcol_list) {
> >          monitor_printf(mon, "\t%s", pcol_list->value);
> > @@ -31,8 +34,10 @@ static void hmp_virtio_dump_protocols(Monitor *mon,
> >  }
> >
> >  static void hmp_virtio_dump_status(Monitor *mon,
> > -                                   VirtioDeviceStatus *status)
> > +                                   uint64_t bitmap)
> >  {
> > +    VirtioDeviceStatus *status =3D qmp_decode_status(bitmap);
> > +
> >      strList *status_list =3D status->statuses;
> >      while (status_list) {
> >          monitor_printf(mon, "\t%s", status_list->value);
> > @@ -49,8 +54,12 @@ static void hmp_virtio_dump_status(Monitor *mon,
> >  }
> >
> >  static void hmp_virtio_dump_features(Monitor *mon,
> > -                                     VirtioDeviceFeatures *features)
> > +                                     uint16_t device_id,
> > +                                     uint64_t bitmap)
> >  {
> > +    VirtioDeviceFeatures *features =3D
> > +        qmp_decode_features(device_id, bitmap);
> > +
> >      strList *transport_list =3D features->transports;
> >      while (transport_list) {
> >          monitor_printf(mon, "\t%s", transport_list->value);
> > @@ -147,11 +156,11 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >      monitor_printf(mon, "  status:\n");
> >      hmp_virtio_dump_status(mon, s->status);
> >      monitor_printf(mon, "  Guest features:\n");
> > -    hmp_virtio_dump_features(mon, s->guest_features);
> > +    hmp_virtio_dump_features(mon, s->device_id, s->guest_features);
> >      monitor_printf(mon, "  Host features:\n");
> > -    hmp_virtio_dump_features(mon, s->host_features);
> > +    hmp_virtio_dump_features(mon, s->device_id, s->host_features);
> >      monitor_printf(mon, "  Backend features:\n");
> > -    hmp_virtio_dump_features(mon, s->backend_features);
> > +    hmp_virtio_dump_features(mon, s->device_id, s->backend_features);
> >
> >      if (s->vhost_dev) {
> >          monitor_printf(mon, "  VHost:\n");
> > @@ -172,11 +181,13 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >          monitor_printf(mon, "    log_size:       %"PRId64"\n",
> >                         s->vhost_dev->log_size);
> >          monitor_printf(mon, "    Features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> > +        hmp_virtio_dump_features(mon, s->device_id,
> s->vhost_dev->features);
> >          monitor_printf(mon, "    Acked features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> > +        hmp_virtio_dump_features(mon,
> > +                s->device_id, s->vhost_dev->acked_features);
> >          monitor_printf(mon, "    Backend features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
> > +        hmp_virtio_dump_features(mon,
> > +                s->device_id, s->vhost_dev->backend_features);
> >          monitor_printf(mon, "    Protocol features:\n");
> >          hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features=
);
> >      }
> > diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> > index 1dd96ed20f..1660c17653 100644
> > --- a/hw/virtio/virtio-qmp.c
> > +++ b/hw/virtio/virtio-qmp.c
> > @@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >      status->name =3D g_strdup(vdev->name);
> >      status->device_id =3D vdev->device_id;
> >      status->vhost_started =3D vdev->vhost_started;
> > -    status->guest_features =3D qmp_decode_features(vdev->device_id,
> > -                                                 vdev->guest_features)=
;
> > -    status->host_features =3D qmp_decode_features(vdev->device_id,
> > -                                                vdev->host_features);
> > -    status->backend_features =3D qmp_decode_features(vdev->device_id,
> > -
>  vdev->backend_features);
> > +    status->guest_features =3D vdev->guest_features;
> > +    status->host_features =3D vdev->host_features;
> > +    status->backend_features =3D vdev->backend_features;
> >
> >      switch (vdev->device_endian) {
> >      case VIRTIO_DEVICE_ENDIAN_LITTLE:
> > @@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >      }
> >
> >      status->num_vqs =3D virtio_get_num_queues(vdev);
> > -    status->status =3D qmp_decode_status(vdev->status);
> > +    status->status =3D vdev->status;
> >      status->isr =3D vdev->isr;
> >      status->queue_sel =3D vdev->queue_sel;
> >      status->vm_running =3D vdev->vm_running;
> > @@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r
> *path, Error **errp)
> >          status->vhost_dev->n_tmp_sections =3D hdev->n_tmp_sections;
> >          status->vhost_dev->nvqs =3D hdev->nvqs;
> >          status->vhost_dev->vq_index =3D hdev->vq_index;
> > -        status->vhost_dev->features =3D
> > -            qmp_decode_features(vdev->device_id, hdev->features);
> > -        status->vhost_dev->acked_features =3D
> > -            qmp_decode_features(vdev->device_id, hdev->acked_features)=
;
> > -        status->vhost_dev->backend_features =3D
> > -            qmp_decode_features(vdev->device_id,
> hdev->backend_features);
> > -        status->vhost_dev->protocol_features =3D
> > -            qmp_decode_protocols(hdev->protocol_features);
> > +        status->vhost_dev->features =3D hdev->features;
> > +        status->vhost_dev->acked_features =3D hdev->acked_features;
> > +        status->vhost_dev->backend_features =3D hdev->backend_features=
;
> > +        status->vhost_dev->protocol_features =3D hdev->protocol_featur=
es;
> >          status->vhost_dev->max_queues =3D hdev->max_queues;
> >          status->vhost_dev->backend_cap =3D hdev->backend_cap;
> >          status->vhost_dev->log_enabled =3D hdev->log_enabled;
> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> > index 19c7c36e36..26516fb29c 100644
> > --- a/qapi/virtio.json
> > +++ b/qapi/virtio.json
> > @@ -102,10 +102,10 @@
> >              'n-tmp-sections': 'int',
> >              'nvqs': 'uint32',
> >              'vq-index': 'int',
> > -            'features': 'VirtioDeviceFeatures',
> > -            'acked-features': 'VirtioDeviceFeatures',
> > -            'backend-features': 'VirtioDeviceFeatures',
> > -            'protocol-features': 'VhostDeviceProtocols',
> > +            'features': 'uint64',
> > +            'acked-features': 'uint64',
> > +            'backend-features': 'uint64',
> > +            'protocol-features': 'uint64',
> >              'max-queues': 'uint64',
> >              'backend-cap': 'uint64',
> >              'log-enabled': 'bool',
> > @@ -170,11 +170,11 @@
> >              'device-id': 'uint16',
> >              'vhost-started': 'bool',
> >              'device-endian': 'str',
> > -            'guest-features': 'VirtioDeviceFeatures',
> > -            'host-features': 'VirtioDeviceFeatures',
> > -            'backend-features': 'VirtioDeviceFeatures',
> > +            'guest-features': 'uint64',
> > +            'host-features': 'uint64',
> > +            'backend-features': 'uint64',
> >              'num-vqs': 'int',
> > -            'status': 'VirtioDeviceStatus',
> > +            'status': 'uint8',
> >              'isr': 'uint8',
> >              'queue-sel': 'uint16',
> >              'vm-running': 'bool',
> > @@ -217,41 +217,14 @@
> >  #          "name": "virtio-crypto",
> >  #          "started": true,
> >  #          "device-id": 20,
> > -#          "backend-features": {
> > -#              "transports": [],
> > -#              "dev-features": []
> > -#          },
> > +#          "backend-features": 0,
> >  #          "start-on-kick": false,
> >  #          "isr": 1,
> >  #          "broken": false,
> > -#          "status": {
> > -#              "statuses": [
> > -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device
> found",
> > -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with
> device",
> > -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
> > -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> > -#              ]
> > -#          },
> > +#          "status": 15,
> >  #          "num-vqs": 2,
> > -#          "guest-features": {
> > -#              "dev-features": [],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)"
> > -#              ]
> > -#          },
> > -#          "host-features": {
> > -#              "unknown-dev-features": 1073741824,
> > -#              "dev-features": [],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)",
> > -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc=
.
> layouts",
> > -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> > -#              ]
> > -#          },
> > +#          "guest-features": 5100273664,
> > +#          "host-features": 6325010432,
> >  #          "use-guest-notifier-mask": true,
> >  #          "vm-running": true,
> >  #          "queue-sel": 1,
> > @@ -279,147 +252,22 @@
> >  #              "max-queues": 1,
> >  #              "backend-cap": 2,
> >  #              "log-size": 0,
> > -#              "backend-features": {
> > -#                  "dev-features": [],
> > -#                  "transports": []
> > -#              },
> > +#              "backend-features": 0,
> >  #              "nvqs": 2,
> > -#              "protocol-features": {
> > -#                  "protocols": []
> > -#              },
> > +#              "protocol-features": 0,
> >  #              "vq-index": 0,
> >  #              "log-enabled": false,
> > -#              "acked-features": {
> > -#                  "dev-features": [
> > -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge
> receive buffers"
> > -#                  ],
> > -#                  "transports": [
> > -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event
> fields enabled",
> > -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect
> descriptors supported",
> > -#                      "VIRTIO_F_VERSION_1: Device compliant for v1
> spec (legacy)"
> > -#                  ]
> > -#              },
> > -#              "features": {
> > -#                  "dev-features": [
> > -#                      "VHOST_F_LOG_ALL: Logging write descriptors
> supported",
> > -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge
> receive buffers"
> > -#                  ],
> > -#                  "transports": [
> > -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event
> fields enabled",
> > -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect
> descriptors supported",
> > -#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on
> IOMMU platform",
> > -#                      "VIRTIO_F_VERSION_1: Device compliant for v1
> spec (legacy)",
> > -#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary
> desc. layouts",
> > -#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device
> runs out of avail. descs. on VQ"
> > -#                  ]
> > -#              }
> > -#          },
> > -#          "backend-features": {
> > -#              "dev-features": [
> > -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protoco=
l
> features negotiation supported",
> > -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set throug=
h
> control channel",
> > -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending
> gratuitous packets supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN
> filtering supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> > -#                  "VIRTIO_NET_F_STATUS: Configuration status field
> available",
> > -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive
> buffers",
> > -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> > -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with
> ECN",
> > -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> > -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> > -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> > -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO wit=
h
> ECN",
> > -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"=
,
> > -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"=
,
> > -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> > -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel
> offloading reconfig. supported",
> > -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets
> with partial checksum supported",
> > -#                  "VIRTIO_NET_F_CSUM: Device handling packets with
> partial checksum supported"
> > -#              ],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)",
> > -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc=
.
> layouts",
> > -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> > -#              ]
> > +#              "acked-features": 5100306432,
> > +#              "features": 13908344832,
> >  #          },
> > +#          "backend-features": 6337593319,
> >  #          "start-on-kick": false,
> >  #          "isr": 1,
> >  #          "broken": false,
> > -#          "status": {
> > -#              "statuses": [
> > -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device
> found",
> > -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with
> device",
> > -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
> > -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> > -#              ]
> > -#          },
> > +#          "status": 15,
> >  #          "num-vqs": 3,
> > -#          "guest-features": {
> > -#              "dev-features": [
> > -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set throug=
h
> control channel",
> > -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending
> gratuitous packets supported",
> > -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN
> filtering supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> > -#                  "VIRTIO_NET_F_STATUS: Configuration status field
> available",
> > -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive
> buffers",
> > -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> > -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with
> ECN",
> > -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> > -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> > -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> > -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO wit=
h
> ECN",
> > -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"=
,
> > -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"=
,
> > -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> > -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel
> offloading reconfig. supported",
> > -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets
> with partial checksum supported",
> > -#                  "VIRTIO_NET_F_CSUM: Device handling packets with
> partial checksum supported"
> > -#              ],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)"
> > -#             ]
> > -#          },
> > -#          "host-features": {
> > -#              "dev-features": [
> > -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protoco=
l
> features negotiation supported",
> > -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set throug=
h
> control channel",
> > -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending
> gratuitous packets supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN
> filtering supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> > -#                  "VIRTIO_NET_F_STATUS: Configuration status field
> available",
> > -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive
> buffers",
> > -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> > -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with
> ECN",
> > -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> > -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> > -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> > -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO wit=
h
> ECN",
> > -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"=
,
> > -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"=
,
> > -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> > -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel
> offloading reconfig. supported",
> > -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets
> with partial checksum supported",
> > -#                  "VIRTIO_NET_F_CSUM: Device handling packets with
> partial checksum supported"
> > -#              ],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)",
> > -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc=
.
> layouts",
> > -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> > -#             ]
> > -#          },
> > +#          "guest-features": 5111807911,
> > +#          "host-features": 6337593319,
> >  #          "use-guest-notifier-mask": true,
> >  #          "vm-running": true,
> >  #          "queue-sel": 2,
>
> qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()
> are now only used in virtio-hmp-cmds.c.  Please move them there, and
> replace the qmp_ prefix by hmp_ or simply drop it.
>
> VhostDeviceProtocols and VirtioDeviceFeatures are then only used in
> virtio-hmp-cmds.c.  Please define them as plain C types there, and drop
> them from the QAPI schema.
>
> You may want to do this as a separate cleanup commit.  Use your
> judgement.
>
Get it, I'll try in the next version.

>


Thanks for the comment.
Yong

--=20
Best regards

--000000000000a4c1b3060ec0f389
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 12, 20=
24 at 10:10=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Hua=
ng &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huan=
g@smartx.com</a>&gt; writes:<br>
<br>
&gt; Maintain the feature and status bits in the x-query-virtio-status<br>
&gt; output and, as usual, add human-readable output only in HMP.<br>
&gt;<br>
&gt; Applications may find it useful to compare features and status<br>
&gt; information directly. An upper application, for example, could<br>
&gt; use the QMP command x-query-virtio-status to retrieve vhost-user<br>
&gt; net device features and the &quot;ovs-vsctl list interface&quot; comma=
nd to<br>
&gt; retrieve interface features (in number format) in order to verify<br>
&gt; the correctness of the virtio negotiation between guest, QEMU,<br>
&gt; and OVS-DPDK. The application could then compare the two features<br>
&gt; directly, without the need for additional feature encoding.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
A bit terse.=C2=A0 Here&#39;s my try:<br>
<br>
=C2=A0 =C2=A0 qmp: Switch x-query-virtio-status back to numeric encoding<br=
>
<br>
=C2=A0 =C2=A0 x-query-virtio-status returns several sets of virtio feature =
and<br>
=C2=A0 =C2=A0 status flags.=C2=A0 It goes back to v7.2.0.<br>
<br>
=C2=A0 =C2=A0 In the initial commit 90c066cd682 (qmp: add QMP command<br>
=C2=A0 =C2=A0 x-query-virtio-status), we returned them as numbers, using vi=
rtio&#39;s<br>
=C2=A0 =C2=A0 well-known binary encoding.<br>
<br>
=C2=A0 =C2=A0 The next commit f3034ad71fc (qmp: decode feature &amp; status=
 bits in<br>
=C2=A0 =C2=A0 virtio-status) replaced the numbers by objects.=C2=A0 The obj=
ects represent<br>
=C2=A0 =C2=A0 bits QEMU knows symbolically, and any unknown bits numericall=
y just like<br>
=C2=A0 =C2=A0 before.<br>
<br>
=C2=A0 =C2=A0 Commit 8a8287981d1 (hmp: add virtio commands) the matching HM=
P command<br>
=C2=A0 =C2=A0 &quot;info virtio&quot; (and a few more, which aren&#39;t rel=
evant here).<br>
<br>
=C2=A0 =C2=A0 The symbolic representation uses lists of strings.=C2=A0 The =
string format is<br>
=C2=A0 =C2=A0 undocumented.=C2=A0 The strings look like &quot;WELL_KNOWN_SY=
MBOL: human readable<br>
=C2=A0 =C2=A0 explanation&quot;.<br>
<br>
=C2=A0 =C2=A0 This symbolic representation is nice for humans.=C2=A0 Machin=
es it can save<br>
=C2=A0 =C2=A0 the trouble of decoding virtio&#39;s well-known binary encodi=
ng.<br>
<br>
=C2=A0 =C2=A0 However, we sometimes want to compare features and status bit=
s without<br>
=C2=A0 =C2=A0 caring for their exact meaning.=C2=A0 Say we want to verify t=
he correctness<br>
=C2=A0 =C2=A0 of the virtio negotiation between guest, QEMU, and OVS-DPDK.=
=C2=A0 We can use<br>
=C2=A0 =C2=A0 QMP command x-query-virtio-status to retrieve vhost-user net =
device<br>
=C2=A0 =C2=A0 features, and the &quot;ovs-vsctl list interface&quot; comman=
d to retrieve<br>
=C2=A0 =C2=A0 interface features.=C2=A0 Without commit f3034ad71fc, we coul=
d then simply<br>
=C2=A0 =C2=A0 compare the numbers.=C2=A0 With this commit, we first have to=
 map from the<br>
=C2=A0 =C2=A0 strings back to the numeric encoding.<br>
<br>
=C2=A0 =C2=A0 Revert the decoding for QMP, but keep it for HMP.<br>
<br>
=C2=A0 =C2=A0 This makes the QMP command easier to use for use cases where =
we<br>
=C2=A0 =C2=A0 don&#39;t need to decode, like the comparison above.=C2=A0 Fo=
r use cases<br>
=C2=A0 =C2=A0 where we need to decode, we replace parsing undocumented stri=
ngs by<br>
=C2=A0 =C2=A0 decoding virtio&#39;s well-known binary encoding.<br>
<br>
=C2=A0 =C2=A0 Incompatible change; acceptable because x-query-virtio-status=
 does<br>
=C2=A0 =C2=A0 comes without a stability promise.<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif">Thanks for the refining, I&#39;ll post this commit m=
essage in the next version.</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio-hmp-cmds.c |=C2=A0 29 ++++--<br>
&gt;=C2=A0 hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++---<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 192 =
++++--------------------------------<br>
&gt;=C2=A0 3 files changed, 48 insertions(+), 196 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c=
<br>
&gt; index 477c97dea2..4fabba4f9c 100644<br>
&gt; --- a/hw/virtio/virtio-hmp-cmds.c<br>
&gt; +++ b/hw/virtio/virtio-hmp-cmds.c<br>
&gt; @@ -6,6 +6,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;virtio-qmp.h&quot;<br>
&gt;=C2=A0 #include &quot;monitor/hmp.h&quot;<br>
&gt;=C2=A0 #include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qapi-commands-virtio.h&quot;<br>
&gt; @@ -13,8 +14,10 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void hmp_virtio_dump_protocols(Monitor *mon,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostDevice=
Protocols *pcol)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t bi=
tmap)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 VhostDeviceProtocols *pcol =3D qmp_decode_protocols(bit=
map);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 strList *pcol_list =3D pcol-&gt;protocols;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 while (pcol_list) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;\t%s&quot;=
, pcol_list-&gt;value);<br>
&gt; @@ -31,8 +34,10 @@ static void hmp_virtio_dump_protocols(Monitor *mon,=
<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void hmp_virtio_dump_status(Monitor *mon,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VirtioDeviceStatus =
*status)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t bitmap)<br=
>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 VirtioDeviceStatus *status =3D qmp_decode_status(bitmap=
);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 strList *status_list =3D status-&gt;statuses;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 while (status_list) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;\t%s&quot;=
, status_list-&gt;value);<br>
&gt; @@ -49,8 +54,12 @@ static void hmp_virtio_dump_status(Monitor *mon,<br=
>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void hmp_virtio_dump_features(Monitor *mon,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VirtioDevice=
Features *features)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t dev=
ice_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t bit=
map)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 VirtioDeviceFeatures *features =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(device_id, bitmap);<b=
r>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 strList *transport_list =3D features-&gt;transport=
s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 while (transport_list) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;\t%s&quot;=
, transport_list-&gt;value);<br>
&gt; @@ -147,11 +156,11 @@ void hmp_virtio_status(Monitor *mon, const QDict=
 *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 status:\n&quot;);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_status(mon, s-&gt;status);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 Guest features:\n=
&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;guest_features);<br=
>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;device_id, s-&gt;gu=
est_features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 Host features:\n&=
quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;host_features);<br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;device_id, s-&gt;ho=
st_features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 Backend features:=
\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;backend_features);<=
br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;device_id, s-&gt;ba=
ckend_features);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (s-&gt;vhost_dev) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 VHo=
st:\n&quot;);<br>
&gt; @@ -172,11 +181,13 @@ void hmp_virtio_status(Monitor *mon, const QDict=
 *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 log_size:=C2=A0 =C2=A0 =C2=A0 =C2=A0%&quot;PRId64&quot;\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;vhost_dev-&gt;log_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;devic=
e_id, s-&gt;vhost_dev-&gt;features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Acked features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;acked_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;device_=
id, s-&gt;vhost_dev-&gt;acked_features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Backend features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;backend_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;device_=
id, s-&gt;vhost_dev-&gt;backend_features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Protocol features:\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_protocols(mon, s-&gt=
;vhost_dev-&gt;protocol_features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c<br>
&gt; index 1dd96ed20f..1660c17653 100644<br>
&gt; --- a/hw/virtio/virtio-qmp.c<br>
&gt; +++ b/hw/virtio/virtio-qmp.c<br>
&gt; @@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;name =3D g_strdup(vdev-&gt;name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;device_id =3D vdev-&gt;device_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_started =3D vdev-&gt;vhost_starte=
d;<br>
&gt; -=C2=A0 =C2=A0 status-&gt;guest_features =3D qmp_decode_features(vdev-=
&gt;device_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;guest_features);<br>
&gt; -=C2=A0 =C2=A0 status-&gt;host_features =3D qmp_decode_features(vdev-&=
gt;device_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vdev-&gt;host_features);<br>
&gt; -=C2=A0 =C2=A0 status-&gt;backend_features =3D qmp_decode_features(vde=
v-&gt;device_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;backend_features);<br>
&gt; +=C2=A0 =C2=A0 status-&gt;guest_features =3D vdev-&gt;guest_features;<=
br>
&gt; +=C2=A0 =C2=A0 status-&gt;host_features =3D vdev-&gt;host_features;<br=
>
&gt; +=C2=A0 =C2=A0 status-&gt;backend_features =3D vdev-&gt;backend_featur=
es;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (vdev-&gt;device_endian) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case VIRTIO_DEVICE_ENDIAN_LITTLE:<br>
&gt; @@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char=
 *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;num_vqs =3D virtio_get_num_queues(vdev)=
;<br>
&gt; -=C2=A0 =C2=A0 status-&gt;status =3D qmp_decode_status(vdev-&gt;status=
);<br>
&gt; +=C2=A0 =C2=A0 status-&gt;status =3D vdev-&gt;status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;isr =3D vdev-&gt;isr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;queue_sel =3D vdev-&gt;queue_sel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;vm_running =3D vdev-&gt;vm_running;<br>
&gt; @@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const ch=
ar *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;n_tmp_secti=
ons =3D hdev-&gt;n_tmp_sections;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;nvqs =3D hd=
ev-&gt;nvqs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;vq_index =
=3D hdev-&gt;vq_index;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;features =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vdev-&g=
t;device_id, hdev-&gt;features);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;acked_features =
=3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vdev-&g=
t;device_id, hdev-&gt;acked_features);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;backend_features=
 =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vdev-&g=
t;device_id, hdev-&gt;backend_features);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;protocol_feature=
s =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_protocols(hdev-&=
gt;protocol_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;features =3D hde=
v-&gt;features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;acked_features =
=3D hdev-&gt;acked_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;backend_features=
 =3D hdev-&gt;backend_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;protocol_feature=
s =3D hdev-&gt;protocol_features;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;max_queues =
=3D hdev-&gt;max_queues;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;backend_cap=
 =3D hdev-&gt;backend_cap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;log_enabled=
 =3D hdev-&gt;log_enabled;<br>
&gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt; index 19c7c36e36..26516fb29c 100644<br>
&gt; --- a/qapi/virtio.json<br>
&gt; +++ b/qapi/virtio.json<br>
&gt; @@ -102,10 +102,10 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;n-tmp-sections&#3=
9;: &#39;int&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;nvqs&#39;: &#39;u=
int32&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vq-index&#39;: &#=
39;int&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#39;Vi=
rtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acked-features&#39;: &=
#39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;protocol-features&#39;=
: &#39;VhostDeviceProtocols&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#39;ui=
nt64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acked-features&#39;: &=
#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;protocol-features&#39;=
: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;max-queues&#39;: =
&#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-cap&#39;:=
 &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;log-enabled&#39;:=
 &#39;bool&#39;,<br>
&gt; @@ -170,11 +170,11 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;device-id&#39;: &=
#39;uint16&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vhost-started&#39=
;: &#39;bool&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;device-endian&#39=
;: &#39;str&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-features&#39;: &=
#39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;host-features&#39;: &#=
39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-features&#39;: &=
#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;host-features&#39;: &#=
39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;num-vqs&#39;: &#3=
9;int&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39;Virt=
ioDeviceStatus&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39;uint=
8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;isr&#39;: &#39;ui=
nt8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;queue-sel&#39;: &=
#39;uint16&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vm-running&#39;: =
&#39;bool&#39;,<br>
&gt; @@ -217,41 +217,14 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;virt=
io-crypto&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;started&quot;: true,<b=
r>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device-id&quot;: 20,<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: {<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: []<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: 0,<=
br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;start-on-kick&quot;: f=
alse,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;isr&quot;: 1,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;broken&quot;: false,<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;statuses&quot=
;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: 15,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num-vqs&quot;: 2,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;unknown-dev-f=
eatures&quot;: 1073741824,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on =
VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: 51002=
73664,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: 632501=
0432,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-guest-notifier-mas=
k&quot;: true,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vm-running&quot;: true=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue-sel&quot;: 1,<br=
>
&gt; @@ -279,147 +252,22 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max-queu=
es&quot;: 1,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-=
cap&quot;: 2,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;log-size=
&quot;: 0,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-featu=
res&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;dev-features&quot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;transports&quot;: []<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-featu=
res&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvqs&quo=
t;: 2,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;protocol-feat=
ures&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;protocols&quot;: []<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;protocol-feat=
ures&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vq-index=
&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;log-enab=
led&quot;: false,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acked-feature=
s&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;dev-features&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&q=
uot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;transports&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields en=
abled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supporte=
d&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&=
quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;features&quot=
;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;dev-features&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VHOST_F_LOG_ALL: Logging write descriptors supported&quot;=
,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&q=
uot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;transports&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields en=
abled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supporte=
d&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platf=
orm&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&=
quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layout=
s&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of a=
vail. descs. on VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: {<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation s=
upported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GSO: Handling GSO-type packets supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel&quot;,=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported&q=
uot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported&quot;,<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VQ: Control channel available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_STATUS: Configuration status field available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_UFO: Device can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MAC: Device has given MAC address&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported=
&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on =
VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acked-feature=
s&quot;: 5100306432,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;features&quot=
;: 13908344832,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: 633=
7593319,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;start-on-kick&quot;: f=
alse,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;isr&quot;: 1,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;broken&quot;: false,<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;statuses&quot=
;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: 15,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num-vqs&quot;: 3,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel&quot;,=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported&q=
uot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported&quot;,<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VQ: Control channel available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_STATUS: Configuration status field available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_UFO: Device can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MAC: Device has given MAC address&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported=
&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation s=
upported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GSO: Handling GSO-type packets supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel&quot;,=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported&q=
uot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported&quot;,<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VQ: Control channel available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_STATUS: Configuration status field available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_UFO: Device can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MAC: Device has given MAC address&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported=
&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on =
VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: 51118=
07911,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: 633759=
3319,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-guest-notifier-mas=
k&quot;: true,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vm-running&quot;: true=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue-sel&quot;: 2,<br=
>
<br>
qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()<br>
are now only used in virtio-hmp-cmds.c.=C2=A0 Please move them there, and<b=
r>
replace the qmp_ prefix by hmp_ or simply drop it.<br>
<br>
VhostDeviceProtocols and VirtioDeviceFeatures are then only used in<br>
virtio-hmp-cmds.c.=C2=A0 Please define them as plain C types there, and dro=
p<br>
them from the QAPI schema.<br>
<br>
You may want to do this as a separate cleanup commit.=C2=A0 Use your<br>
judgement.<br></blockquote><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif">Get it, I&#39;ll try in the next ve=
rsion.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif"></span>=C2=A0</blockquote></div><br clear=3D"all"><div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">Thanks for the comment.</div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif"></div><div class=3D"gmail_=
default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</d=
iv></div><div><br></div><span class=3D"gmail_signature_prefix">-- </span><b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D=
"comic sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000a4c1b3060ec0f389--

