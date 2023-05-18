Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3C708ADF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 23:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzldR-0005z6-EN; Thu, 18 May 2023 17:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <talumbau@google.com>)
 id 1pzldP-0005yv-LF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:58:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <talumbau@google.com>)
 id 1pzldM-0002Wg-2E
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:58:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3078fa679a7so2490898f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684447082; x=1687039082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLKUQgqC2vDlUp1nW3GYozMQzhlnkk5x0mwP+eeEsMw=;
 b=7iovdKSRrbFUbtVlhrkeQ4sRB7IvEVTUp3yGjuvsZZUZHci3TUXaG6+dnhLfAEyUCZ
 SjotLJZ1ze3j2o3eMTNLAc8E7lzzAmqdeWYPSJBfuQoIM8wwn6alO4Ey4p7gIA1moSrw
 nFbVOX4xzTjXa99WbekNAYP3ne+0E54TXb2GlfUjCnhxwvf2afV4SyC8FQK3jsxjNx5R
 M7MhSgCndM2DW142+lvx3zC1TGkAJd48HwQedvvcmuu57U61qg7N+JZaILA9/Z/bbIik
 vPdfd1zecOR6dnV0pCdLKAMb2vNyr7pbTz1Rx6Gc8W5D4r78/wTa2qvmIoXWIEOLn/p0
 VIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684447082; x=1687039082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLKUQgqC2vDlUp1nW3GYozMQzhlnkk5x0mwP+eeEsMw=;
 b=aBc8VJikqPfBWAFW2sbSdvxkaw9WJRWgNIPl1O7X4x9sTODd3bJv5S2oXe27mIaUke
 46A7qVIKxYrLSQRbziJQESLx0wujMZfXPdD4yN9pWMPA7VQUn9/pIHgddK0CkFoVsoYg
 Nsqkz/GMe8EFtquGZL7TanTR2UlP8oMdI+xR3S40ahrpZkg+IyiXZZuwCWnTR03FvbGZ
 fXLjdH3TL8kxhEtTDHGZjff0+72EvwHbk/5Fz9ZNWpaSL9oBUN5dTGjoS01FR2pPhorP
 6hVvTxgqVOM38R9ePFYRYJUMg6owP9zKpv8Vu6Vy/QPTgzWedIV4LUssuYNE2RSH7QF8
 9JQQ==
X-Gm-Message-State: AC+VfDwe2FsYq7W9fNh86boDjMDEKJOWlpIF5FHlSl/VHsl5BlqUw6yP
 lMCFcERAdEWwfRccuqZZErA75BKVKYwbpetswykM4Q==
X-Google-Smtp-Source: ACHHUZ4QwrGcmZPHV1MSpYRtpM+W76E4b/ci2YtoF/VXit6Y0W/R0XJItSdEaFLObWNIgvdK+JtOxbLoUZu6Vegh9hM=
X-Received: by 2002:adf:fe89:0:b0:309:45cc:577a with SMTP id
 l9-20020adffe89000000b0030945cc577amr152420wrr.13.1684447081525; Thu, 18 May
 2023 14:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230510143856.964541-1-talumbau@google.com>
 <20230510143856.964541-2-talumbau@google.com>
 <ZGNi9Bfy1SuLxqtA@gallifrey>
In-Reply-To: <ZGNi9Bfy1SuLxqtA@gallifrey>
From: "T.J. Alumbaugh" <talumbau@google.com>
Date: Thu, 18 May 2023 15:57:25 -0600
Message-ID: <CABmGT5ERcROSHwBPe5uMk-z=RBKUOa_XtVGxoEy2gkCK1Kjz3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] virtio-balloon: Add Working Set Reporting feature
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Yuanchu Xie <yuanchu@google.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=talumbau@google.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, May 16, 2023 at 5:03=E2=80=AFAM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * T.J. Alumbaugh (talumbau@google.com) wrote:
> >  Working Set Reporting supported in virtio-balloon.
> >  - adds working set reporting and notification vqueues
> >  - QMP API additions:
> >    - guest-ws property on balloon
> >    - generates QMP WS_EVENT when new reports available
> >    - ws_config, ws_request commands
>
> Hi,
>   1st it's probably best to split this patch up into a few
> separate patches; something like:
>     1) Updating the virtio_balloon header
>     2) the main virtio-balloon code
>     3) Adding the qmp code
>     4) Adding the HMP code
>     5) The migration code
>
>     That would make it easier for people to review
> the bits they know.
>
> Also, please make sure migration works between a host
> without this feature and one which does; I suggest
> turning the feature off in older machine types, and
> also just checking that it works.
>

Thanks very much for this feedback. This makes sense to me. I had
originally attempted to split the patch into 2 (all device changes and
all qmp + HMP) but got compilation warnings (that became errors) on
uncalled functions due to the default compiler settings (since some of
the new functions in the device only exist in order to be called by
QMP). It sounds like that's OK for the purposes of review. I'll do as
you suggest and update with a v2 soon.

-T.J.

> See more comments below.
>
> Dave
>
> > Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> > ---
> >  hmp-commands.hx                               |  26 ++
> >  hw/core/machine-hmp-cmds.c                    |  21 ++
> >  hw/virtio/virtio-balloon-pci.c                |   2 +
> >  hw/virtio/virtio-balloon.c                    | 225 +++++++++++++++++-
> >  include/hw/virtio/virtio-balloon.h            |  17 +-
> >  include/monitor/hmp.h                         |   2 +
> >  .../standard-headers/linux/virtio_balloon.h   |  17 ++
> >  include/sysemu/balloon.h                      |   8 +-
> >  monitor/monitor.c                             |   1 +
> >  qapi/machine.json                             |  66 +++++
> >  qapi/misc.json                                |  26 ++
> >  softmmu/balloon.c                             |  32 ++-
> >  12 files changed, 437 insertions(+), 6 deletions(-)
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 9afbb54a51..f3548a148f 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1396,6 +1396,32 @@ SRST
> >    Request VM to change its memory allocation to *value* (in MB).
> >  ERST
> >
> > +    {
> > +        .name       =3D "ws_config",
> > +        .args_type  =3D "i0:i,i1:i,i2:i,refresh:i,report:i",
> > +        .params     =3D "bin intervals 0-2, refresh and report thresho=
lds",
> > +        .help       =3D "Working Set intervals, refresh/report thresho=
lds (ms)",
> > +        .cmd        =3D hmp_ws_config,
> > +    },
> > +
> > +SRST
> > +``ws_config``
> > +  Set the intervals (in ms), refresh, and report thresholds for WS rep=
orting
> > +ERST
> > +
> > +    {
> > +        .name       =3D "ws_request",
> > +        .args_type  =3D "",
> > +        .params     =3D "",
> > +        .help       =3D "Request the Working Set of the guest.",
> > +        .cmd        =3D hmp_ws_request,
> > +    },
> > +
> > +SRST
> > +``wss_request``
>
> Typo 'ws*s*'
>
> Some other comments on that:
>   a) When you've split the hmp stuff out into a separate patch you can
>      give an example of the command (especially ws_config) in the
>      commit message.
>
>   b) Would it make sense to have a query-ws/info ws to display the last r=
eceived
>      working set info?
>
>   c) Some may feel 'ws' is a bit terse and want the unabbreviated
>   version.  (Is it also general, or is it actually virtio balloon
>   specific, ie should the name include virtio or balloon?)
>
>   d) You've got 3 bin intervals; is that '3' set in stone or is it
>   likely to change in the future, in which case perhaps you want the
>   perameters to be more flexible.  I note your migration code
>   transfers a 'number of bins'.
>
> > +  Request the Working Set Size of the guest.
> > +ERST
> > +
> >      {
> >          .name       =3D "set_link",
> >          .args_type  =3D "name:s,up:b",
> > diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> > index c3e55ef9e9..dd11865ddc 100644
> > --- a/hw/core/machine-hmp-cmds.c
> > +++ b/hw/core/machine-hmp-cmds.c
> > @@ -237,6 +237,27 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
> >      hmp_handle_error(mon, err);
> >  }
> >
> > +void hmp_ws_request(Monitor *mon, const QDict *qdict)
> > +{
> > +    Error *err =3D NULL;
> > +
> > +    qmp_ws_request(&err);
> > +    hmp_handle_error(mon, err);
> > +}
> > +
> > +void hmp_ws_config(Monitor *mon, const QDict *qdict)
> > +{
> > +    uint64_t i0 =3D qdict_get_int(qdict, "i0");
> > +    uint64_t i1 =3D qdict_get_int(qdict, "i1");
> > +    uint64_t i2 =3D qdict_get_int(qdict, "i2");
> > +    uint64_t refresh =3D qdict_get_int(qdict, "refresh");
> > +    uint64_t report =3D qdict_get_int(qdict, "report");
> > +    Error *err =3D NULL;
> > +
> > +    qmp_ws_config(i0, i1, i2, refresh, report, &err);
> > +    hmp_handle_error(mon, err);
> > +}
> > +
> >  void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
> >  {
> >      Error *err =3D NULL;
> > diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-=
pci.c
> > index ce2645ba71..92409de924 100644
> > --- a/hw/virtio/virtio-balloon-pci.c
> > +++ b/hw/virtio/virtio-balloon-pci.c
> > @@ -68,6 +68,8 @@ static void virtio_balloon_pci_instance_init(Object *=
obj)
> >      object_property_add_alias(obj, "guest-stats-polling-interval",
> >                                OBJECT(&dev->vdev),
> >                                "guest-stats-polling-interval");
> > +    object_property_add_alias(obj, "guest-ws", OBJECT(&dev->vdev),
> > +                              "guest-ws");
> >  }
> >
> >  static const VirtioPCIDeviceTypeInfo virtio_balloon_pci_info =3D {
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index d004cf29d2..31b18435c8 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -27,6 +27,7 @@
> >  #include "exec/address-spaces.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-events-machine.h"
> > +#include "qapi/qapi-visit-misc.h"
> >  #include "qapi/visitor.h"
> >  #include "trace.h"
> >  #include "qemu/error-report.h"
> > @@ -169,6 +170,116 @@ static void balloon_deflate_page(VirtIOBalloon *b=
alloon,
> >      }
> >  }
> >
> > +/*
> > + * reset_working_set - Mark all items in the array as unset
> > + *
> > + * This function needs to be called at device initialization and
> > + * whenever a new Working Set config is specified.
> > + */
> > +static inline void reset_working_set(VirtIOBalloon *dev)
> > +{
> > +    int i;
> > +    for (i =3D 0; i < VIRTIO_BALLOON_WS_NR_BINS; i++) {
> > +        dev->ws[i].idle_age =3D 0;
> > +        if (dev->ws[i].memory_size_bytes) {
> > +            dev->ws[i].memory_size_bytes->anon =3D 0;
> > +            dev->ws[i].memory_size_bytes->file =3D 0;
> > +        } else {
> > +            dev->ws[i].memory_size_bytes =3D g_malloc0(sizeof(MemoryBi=
n));
> > +        }
> > +    }
> > +}
> > +
> > +static void virtio_balloon_receive_working_set(VirtIODevice *vdev, Vir=
tQueue *vq)
> > +{
> > +    VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
> > +    VirtQueueElement *elem;
> > +    VirtIOBalloonWS ws;
> > +    size_t offset =3D 0;
> > +    int count =3D 0;
> > +
> > +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +    if (!elem) {
> > +        return;
> > +    }
> > +
> > +    if (s->ws_vq_elem !=3D NULL) {
> > +        /* This should never happen if the driver follows the spec. */
> > +        virtqueue_push(vq, s->ws_vq_elem, 0);
> > +        virtio_notify(vdev, vq);
> > +        g_free(s->ws_vq_elem);
> > +    }
> > +
> > +    s->ws_vq_elem =3D elem;
> > +
> > +    /* Initialize the Working Set to get rid of any stale values. */
> > +    reset_working_set(s);
> > +
> > +    while (iov_to_buf(elem->out_sg, elem->out_num, offset, &ws, sizeof=
(ws)) =3D=3D sizeof(ws)) {
> > +        uint64_t idle_age_ms =3D virtio_tswap64(vdev, ws.idle_age_ms);
> > +        uint64_t bytes_anon =3D virtio_tswap64(vdev, ws.memory_size_by=
tes[0]);
> > +        uint64_t bytes_file =3D virtio_tswap64(vdev, ws.memory_size_by=
tes[1]);
> > +        s->ws[count].idle_age =3D idle_age_ms;
> > +        s->ws[count].memory_size_bytes->anon =3D bytes_anon;
> > +        s->ws[count].memory_size_bytes->file =3D bytes_file;
> > +        offset +=3D sizeof(ws);
> > +        count++;
> > +    }
> > +    qapi_event_send_ws_event();
> > +}
> > +
> > +static void virtio_balloon_send_ws_request(VirtIODevice *vdev, VirtQue=
ue *vq)
> > +{
> > +    VirtQueueElement *elem;
> > +    size_t sz =3D 0;
> > +    uint16_t tag =3D 0;
> > +
> > +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +    if (!elem) {
> > +        return;
> > +    }
> > +    tag =3D WS_REQUEST;
> > +    sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0, &tag, sizeof(tag=
));
> > +    assert(sz =3D=3D sizeof(tag));
> > +    virtqueue_push(vq, elem, sz);
> > +    virtio_notify(vdev, vq);
> > +    g_free(elem);
> > +}
> > +
> > +static void virtio_balloon_send_ws_config(VirtIODevice *vdev, VirtQueu=
e *vq,
> > +                                          uint64_t i0, uint64_t i1, ui=
nt64_t i2,
> > +                                          uint64_t refresh, uint64_t r=
eport)
> > +{
> > +    VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
> > +    VirtQueueElement *elem;
> > +    uint16_t tag =3D 0;
> > +    size_t sz =3D 0;
> > +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +    if (!elem) {
> > +        return;
> > +    }
> > +
> > +    tag =3D WS_CONFIG;
> > +    s->ws_intervals[0] =3D i0;
> > +    s->ws_intervals[1] =3D i1;
> > +    s->ws_intervals[2] =3D i2;
> > +    s->ws_refresh_threshold =3D refresh;
> > +    s->ws_report_threshold =3D report;
> > +
> > +    sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0, &tag, sizeof(tag=
));
> > +    assert(sz =3D=3D sizeof(uint16_t));
> > +    sz +=3D iov_from_buf(elem->in_sg, elem->in_num, sz, s->ws_interval=
s,
> > +                       (VIRTIO_BALLOON_WS_NR_BINS - 1) * \
> > +                       sizeof(s->ws_intervals[0]));
> > +    sz +=3D iov_from_buf(elem->in_sg, elem->in_num, sz, &s->ws_refresh=
_threshold,
> > +                       sizeof(uint64_t));
> > +    sz +=3D iov_from_buf(elem->in_sg, elem->in_num, sz, &s->ws_report_=
threshold,
> > +                       sizeof(uint64_t));
> > +    virtqueue_push(vq, elem, sz);
> > +    virtio_notify(vdev, vq);
> > +    g_free(elem);
> > +}
> > +
> >  static const char *balloon_stat_names[] =3D {
> >     [VIRTIO_BALLOON_S_SWAP_IN] =3D "stat-swap-in",
> >     [VIRTIO_BALLOON_S_SWAP_OUT] =3D "stat-swap-out",
> > @@ -237,6 +348,43 @@ static void balloon_stats_poll_cb(void *opaque)
> >      virtio_notify(vdev, s->svq);
> >      g_free(s->stats_vq_elem);
> >      s->stats_vq_elem =3D NULL;
> > +
> > +}
> > +
> > +static void balloon_ws_get_all(Object *obj, Visitor *v, const char *na=
me,
> > +                               void *opaque, Error **errp)
> > +{
> > +    Error *err =3D NULL;
> > +    VirtIOBalloon *s =3D VIRTIO_BALLOON(obj);
> > +    char ws_buf[4];
> > +    WorkingSetInfo *wsinfo;
> > +    int i;
> > +
> > +    if (!visit_start_struct(v, name, NULL, 0, &err)) {
> > +        goto out;
> > +    }
> > +
> > +    if (!visit_start_struct(v, "ws", NULL, 0, &err)) {
> > +        goto out_end;
> > +    }
> > +    for (i =3D 0; i < VIRTIO_BALLOON_WS_NR_BINS; i++) {
> > +        wsinfo =3D s->ws + i;
> > +        sprintf(ws_buf, "ws%d", i);
> > +        if (!visit_type_WorkingSetInfo(v, ws_buf, &wsinfo, &err)) {
> > +            goto out_nested;
> > +        }
> > +    }
> > +    visit_check_struct(v, &err);
> > +out_nested:
> > +    visit_end_struct(v, NULL);
> > +
> > +    if (!err) {
> > +        visit_check_struct(v, &err);
> > +    }
> > +out_end:
> > +    visit_end_struct(v, NULL);
> > +out:
> > +    error_propagate(errp, err);
> >  }
> >
> >  static void balloon_stats_get_all(Object *obj, Visitor *v, const char =
*name,
> > @@ -697,8 +845,11 @@ static size_t virtio_balloon_config_size(VirtIOBal=
loon *s)
> >      if (s->qemu_4_0_config_size) {
> >          return sizeof(struct virtio_balloon_config);
> >      }
> > +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_WS_REPORTING)) {
> > +        return sizeof(struct virtio_balloon_config);
> > +    }
> >      if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> > -        return sizeof(struct virtio_balloon_config);
> > +        return offsetof(struct virtio_balloon_config, ws_num_bins);
> >      }
> >      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT))=
 {
> >          return offsetof(struct virtio_balloon_config, poison_val);
> > @@ -714,6 +865,7 @@ static void virtio_balloon_get_config(VirtIODevice =
*vdev, uint8_t *config_data)
> >      config.num_pages =3D cpu_to_le32(dev->num_pages);
> >      config.actual =3D cpu_to_le32(dev->actual);
> >      config.poison_val =3D cpu_to_le32(dev->poison_val);
> > +    config.ws_num_bins =3D cpu_to_le32(VIRTIO_BALLOON_WS_NR_BINS);
> >
> >      if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_REQUESTED) =
{
> >          config.free_page_hint_cmd_id =3D
> > @@ -748,6 +900,14 @@ static bool virtio_balloon_page_poison_support(voi=
d *opaque)
> >      return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)=
;
> >  }
> >
> > +static bool virtio_balloon_ws_reporting_support(void *opaque)
> > +{
> > +    VirtIOBalloon *s =3D opaque;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> > +
> > +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_WS_REPORTING=
);
> > +}
> > +
> >  static void virtio_balloon_set_config(VirtIODevice *vdev,
> >                                        const uint8_t *config_data)
> >  {
> > @@ -766,6 +926,10 @@ static void virtio_balloon_set_config(VirtIODevice=
 *vdev,
> >      if (virtio_balloon_page_poison_support(dev)) {
> >          dev->poison_val =3D le32_to_cpu(config.poison_val);
> >      }
> > +    dev->ws_num_bins =3D 0;
> > +    if (virtio_balloon_ws_reporting_support(dev)) {
> > +        dev->ws_num_bins =3D le32_to_cpu(config.ws_num_bins);
> > +    }
> >      trace_virtio_balloon_set_config(dev->actual, oldactual);
> >  }
> >
> > @@ -775,6 +939,7 @@ static uint64_t virtio_balloon_get_features(VirtIOD=
evice *vdev, uint64_t f,
> >      VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
> >      f |=3D dev->host_features;
> >      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> > +    virtio_add_feature(&f, VIRTIO_BALLOON_F_WS_REPORTING);
> >
> >      return f;
> >  }
> > @@ -786,6 +951,24 @@ static void virtio_balloon_stat(void *opaque, Ball=
oonInfo *info)
> >                                               VIRTIO_BALLOON_PFN_SHIFT)=
;
> >  }
> >
> > +static void virtio_balloon_ws_request(void *opaque)
> > +{
> > +    VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +
> > +    virtio_balloon_send_ws_request(vdev, dev->cvq);
> > +}
> > +
> > +static void virtio_balloon_ws_config(void *opaque, uint64_t i0, uint64=
_t i1,
> > +                                      uint64_t i2, uint64_t refresh, u=
int64_t report)
> > +{
> > +    VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +
> > +    printf("VIRTIO-BALLOON: ws config");
>
> Left over debug! Turn it into a trace_
>
> > +    virtio_balloon_send_ws_config(vdev, dev->cvq, i0, i1, i2, refresh,=
 report);
> > +}
> > +
> >  static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
> >  {
> >      VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> > @@ -835,6 +1018,17 @@ static const VMStateDescription vmstate_virtio_ba=
lloon_page_poison =3D {
> >      }
> >  };
> >
> > +static const VMStateDescription vmstate_virtio_balloon_ws_reporting =
=3D {
> > +    .name =3D "virtio-balloon-device/working-set-report",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D virtio_balloon_ws_reporting_support,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(ws_num_bins, VirtIOBalloon),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const VMStateDescription vmstate_virtio_balloon_device =3D {
> >      .name =3D "virtio-balloon-device",
> >      .version_id =3D 1,
> > @@ -848,6 +1042,7 @@ static const VMStateDescription vmstate_virtio_bal=
loon_device =3D {
> >      .subsections =3D (const VMStateDescription * []) {
> >          &vmstate_virtio_balloon_free_page_hint,
> >          &vmstate_virtio_balloon_page_poison,
> > +        &vmstate_virtio_balloon_ws_reporting,
> >          NULL
> >      }
> >  };
> > @@ -861,7 +1056,9 @@ static void virtio_balloon_device_realize(DeviceSt=
ate *dev, Error **errp)
> >      virtio_init(vdev, VIRTIO_ID_BALLOON, virtio_balloon_config_size(s)=
);
> >
> >      ret =3D qemu_add_balloon_handler(virtio_balloon_to_target,
> > -                                   virtio_balloon_stat, s);
> > +                                   virtio_balloon_stat,
> > +                                   virtio_balloon_ws_request,
> > +                                   virtio_balloon_ws_config, s);
> >
> >      if (ret < 0) {
> >          error_setg(errp, "Only one balloon device is supported");
> > @@ -896,7 +1093,11 @@ static void virtio_balloon_device_realize(DeviceS=
tate *dev, Error **errp)
> >                                             virtio_balloon_handle_repor=
t);
> >      }
> >
> > +    s->wvq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_work=
ing_set);
> > +    s->cvq =3D virtio_add_queue(vdev, 128, NULL);
> > +
> >      reset_stats(s);
> > +    reset_working_set(s);
> >  }
> >
> >  static void virtio_balloon_device_unrealize(DeviceState *dev)
> > @@ -922,6 +1123,8 @@ static void virtio_balloon_device_unrealize(Device=
State *dev)
> >      if (s->reporting_vq) {
> >          virtio_delete_queue(s->reporting_vq);
> >      }
> > +    virtio_delete_queue(s->wvq);
> > +    virtio_delete_queue(s->cvq);
> >      virtio_cleanup(vdev);
> >  }
> >
> > @@ -939,6 +1142,12 @@ static void virtio_balloon_device_reset(VirtIODev=
ice *vdev)
> >          s->stats_vq_elem =3D NULL;
> >      }
> >
> > +    if (s->ws_vq_elem !=3D NULL) {
> > +        virtqueue_unpop(s->wvq, s->ws_vq_elem, 0);
> > +        g_free(s->ws_vq_elem);
> > +        s->ws_vq_elem =3D NULL;
> > +    }
> > +
> >      s->poison_val =3D 0;
> >  }
> >
> > @@ -953,6 +1162,13 @@ static void virtio_balloon_set_status(VirtIODevic=
e *vdev, uint8_t status)
> >          virtio_balloon_receive_stats(vdev, s->svq);
> >      }
> >
> > +    if (!s->ws_vq_elem && vdev->vm_running &&
> > +        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->wv=
q, 1)) {
> > +        /* poll ws queue for the element we have discarded when the VM
> > +         * was stopped */
> > +        virtio_balloon_receive_working_set(vdev, s->wvq);
> > +    }
> > +
> >      if (virtio_balloon_free_page_support(s)) {
> >          /*
> >           * The VM is woken up and the iothread was blocked, so signal =
it to
> > @@ -983,6 +1199,9 @@ static void virtio_balloon_instance_init(Object *o=
bj)
> >      s->free_page_hint_cmd_id =3D VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_=
MIN;
> >      s->free_page_hint_notify.notify =3D virtio_balloon_free_page_hint_=
notify;
> >
> > +    object_property_add(obj, "guest-ws", "guest working set",
> > +                        balloon_ws_get_all, NULL, NULL, NULL);
> > +
> >      object_property_add(obj, "guest-stats", "guest statistics",
> >                          balloon_stats_get_all, NULL, NULL, NULL);
> >
> > @@ -1011,6 +1230,8 @@ static Property virtio_balloon_properties[] =3D {
> >                      VIRTIO_BALLOON_F_PAGE_POISON, true),
> >      DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_feature=
s,
> >                      VIRTIO_BALLOON_F_REPORTING, false),
> > +    DEFINE_PROP_BIT("working-set", VirtIOBalloon, host_features,
> > +                    VIRTIO_BALLOON_F_WS_REPORTING, true),
> >      /* QEMU 4.0 accidentally changed the config size even when free-pa=
ge-hint
> >       * is disabled, resulting in QEMU 3.1 migration incompatibility.  =
This
> >       * property retains this quirk for QEMU 4.1 machine types.
> > diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
> > index 5139cf8ab6..99a1a5ca85 100644
> > --- a/include/hw/virtio/virtio-balloon.h
> > +++ b/include/hw/virtio/virtio-balloon.h
> > @@ -17,6 +17,7 @@
> >
> >  #include "standard-headers/linux/virtio_balloon.h"
> >  #include "hw/virtio/virtio.h"
> > +#include "qapi/qapi-types-misc.h"
> >  #include "sysemu/iothread.h"
> >  #include "qom/object.h"
> >
> > @@ -25,7 +26,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBalloon, VIRTIO_BAL=
LOON)
> >
> >  #define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
> >
> > +#define VIRTIO_BALLOON_WS_NR_BINS    4  /* Number of bins in WS report=
 */
> > +
> >  typedef struct virtio_balloon_stat VirtIOBalloonStat;
> > +typedef struct virtio_balloon_ws VirtIOBalloonWS;
> >
> >  typedef struct virtio_balloon_stat_modern {
> >         uint16_t tag;
> > @@ -40,15 +44,25 @@ enum virtio_balloon_free_page_hint_status {
> >      FREE_PAGE_HINT_S_DONE =3D 3,
> >  };
> >
> > +enum virtio_balloon_ws_operation {
> > +    WS_REQUEST =3D 1,
> > +    WS_CONFIG =3D 2,
> > +};
> > +
> >  struct VirtIOBalloon {
> >      VirtIODevice parent_obj;
> > -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
> > +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq, *wvq, *c=
vq;
> >      uint32_t free_page_hint_status;
> >      uint32_t num_pages;
> >      uint32_t actual;
> >      uint32_t free_page_hint_cmd_id;
> >      uint64_t stats[VIRTIO_BALLOON_S_NR];
> > +    WorkingSetInfo ws[VIRTIO_BALLOON_WS_NR_BINS];
> > +    uint64_t ws_intervals[VIRTIO_BALLOON_WS_NR_BINS-1];
> > +    uint64_t ws_refresh_threshold;
> > +    uint64_t ws_report_threshold;
> >      VirtQueueElement *stats_vq_elem;
> > +    VirtQueueElement *ws_vq_elem;
> >      size_t stats_vq_offset;
> >      QEMUTimer *stats_timer;
> >      IOThread *iothread;
> > @@ -71,6 +85,7 @@ struct VirtIOBalloon {
> >
> >      bool qemu_4_0_config_size;
> >      uint32_t poison_val;
> > +    uint32_t ws_num_bins;
> >  };
> >
> >  #endif
> > diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> > index 13f9a2dedb..ad3184112f 100644
> > --- a/include/monitor/hmp.h
> > +++ b/include/monitor/hmp.h
> > @@ -59,6 +59,8 @@ void hmp_nmi(Monitor *mon, const QDict *qdict);
> >  void hmp_info_network(Monitor *mon, const QDict *qdict);
> >  void hmp_set_link(Monitor *mon, const QDict *qdict);
> >  void hmp_balloon(Monitor *mon, const QDict *qdict);
> > +void hmp_ws_config(Monitor *mon, const QDict *qdict);
> > +void hmp_ws_request(Monitor *mon, const QDict *qdict);
> >  void hmp_loadvm(Monitor *mon, const QDict *qdict);
> >  void hmp_savevm(Monitor *mon, const QDict *qdict);
> >  void hmp_delvm(Monitor *mon, const QDict *qdict);
> > diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/=
standard-headers/linux/virtio_balloon.h
> > index f343bfefd8..8d489a2ebd 100644
> > --- a/include/standard-headers/linux/virtio_balloon.h
> > +++ b/include/standard-headers/linux/virtio_balloon.h
> > @@ -37,6 +37,7 @@
> >  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT      3 /* VQ to report free pa=
ges */
> >  #define VIRTIO_BALLOON_F_PAGE_POISON 4 /* Guest is using page poisonin=
g */
> >  #define VIRTIO_BALLOON_F_REPORTING   5 /* Page reporting virtqueue */
> > +#define VIRTIO_BALLOON_F_WS_REPORTING        6 /* Working set report v=
irtqueues */
> >
> >  /* Size of a PFN in the balloon interface. */
> >  #define VIRTIO_BALLOON_PFN_SHIFT 12
> > @@ -59,6 +60,8 @@ struct virtio_balloon_config {
> >       };
> >       /* Stores PAGE_POISON if page poisoning is in use */
> >       uint32_t poison_val;
> > +     /* Stores the number of histogram bins if WS reporting in use */
> > +     uint32_t ws_num_bins;
> >  };
> >
> >  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in *=
/
> > @@ -116,4 +119,18 @@ struct virtio_balloon_stat {
> >       __virtio64 val;
> >  } QEMU_PACKED;
> >
> > +enum virtio_balloon_ws_op {
> > +    VIRTIO_BALLOON_WS_REQUEST =3D 1, // a Working Set request from the=
 host
> > +    VIRTIO_BALLOON_WS_CONFIG =3D 2,  // a WS config update from the ho=
st
> > +};
> > +
> > +struct virtio_balloon_ws {
> > +        __virtio16 tag;
> > +        __virtio16 node_id;
> > +        uint8_t reserved[4];
> > +     __virtio64 idle_age_ms;
> > +     // Track separately for ANON_AND_FILE.
> > +     __virtio64 memory_size_bytes[2];
> > +} QEMU_PACKED;
> > +
> >  #endif /* _LINUX_VIRTIO_BALLOON_H */
> > diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
> > index 867687b73a..fb1de215d9 100644
> > --- a/include/sysemu/balloon.h
> > +++ b/include/sysemu/balloon.h
> > @@ -18,10 +18,16 @@
> >  #include "qapi/qapi-types-machine.h"
> >
> >  typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
> > +typedef void (QEMUBalloonWSRequest)(void *opaque);
> >  typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
> > +typedef void (QEMUBalloonWSConfig)(void *opaque, uint64_t i0, uint64_t=
 i1,
> > +                                   uint64_t i2, uint64_t refresh,
> > +                                   uint64_t report);
> >
> >  int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
> > -                             QEMUBalloonStatus *stat_func, void *opaqu=
e);
> > +                             QEMUBalloonStatus *stat_func,
> > +                             QEMUBalloonWSRequest *wss_func,
> > +                             QEMUBalloonWSConfig *config_func, void *o=
paque);
> >  void qemu_remove_balloon_handler(void *opaque);
> >
> >  #endif
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 602535696c..52ac7c4599 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -329,6 +329,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf=
[QAPI_EVENT__MAX] =3D {
> >      [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
> >      [QAPI_EVENT_WATCHDOG]          =3D { 1000 * SCALE_MS },
> >      [QAPI_EVENT_BALLOON_CHANGE]    =3D { 1000 * SCALE_MS },
> > +    [QAPI_EVENT_WS_EVENT]          =3D { 1000 * SCALE_MS },
> >      [QAPI_EVENT_QUORUM_REPORT_BAD] =3D { 1000 * SCALE_MS },
> >      [QAPI_EVENT_QUORUM_FAILURE]    =3D { 1000 * SCALE_MS },
> >      [QAPI_EVENT_VSERPORT_CHANGE]   =3D { 1000 * SCALE_MS },
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index fcd69965e5..5810f7c3fa 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1048,6 +1048,57 @@
> >  ##
> >  { 'command': 'balloon', 'data': {'value': 'int'} }
> >
> > +##
> > +# @ws-config:
> > +#
> > +# Specify the config parameters for Working Set reporting.
> > +#
> > +# @i0: the endpoint of the first interval (in ms)
> > +#
> > +# @i1: the endpoint of the second interval (in ms)
> > +#
> > +# @i2: the endpoint of the third interval (in ms)
> > +#
> > +# @refresh: the refresh threshold (in ms) for Working Set reporting
> > +#
> > +# @report: the report threshold (in ms) for Working Set reporting
> > +#
> > +# Returns: - Nothing on success
> > +#          - If no balloon device is present, DeviceNotActive
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "ws-config",
> > +#                 "arguments": { "i0": 100,
> > +#                                "i1": 500,
> > +#                                "i2": 2000,
> > +#                                "refresh": 750,
> > +#                                "report": 1000 } }
> > +# <- { "return": {} }
> > +#
> > +##
> > +{ 'command': 'ws-config', 'data': {'i0': 'uint64',
> > +                                       'i1': 'uint64',
> > +                                       'i2': 'uint64',
> > +                                       'refresh': 'uint64',
> > +                                       'report': 'uint64'} }
> > +##
> > +# @ws-request:
> > +#
> > +# Request the Working Set report from the guest.
> > +#
> > +# Returns: - Nothing on success
> > +#          - If no balloon device is present, DeviceNotActive
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "ws-request", "arguments": {} }
> > +# <- { "return": {} }
> > +#
> > +##
> > +{ 'command': 'ws-request', 'data': {} }
> > +
> > +
> >  ##
> >  # @BalloonInfo:
> >  #
> > @@ -1106,6 +1157,21 @@
> >  { 'event': 'BALLOON_CHANGE',
> >    'data': { 'actual': 'int' } }
> >
> > +##
> > +# @WS_EVENT:
> > +#
> > +# Emitted when the guest sends a new Working Set report.
> > +#
> > +# Note: this event is rate-limited.
> > +#
> > +# Example:
> > +#
> > +# <- { "event": "WS_EVENT",
> > +#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } =
}
> > +#
> > +##
> > +{ 'event': 'WS_EVENT' }
> > +
> >  ##
> >  # @MemoryInfo:
> >  #
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 4afaee7fe7..b1da595c80 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -523,6 +523,32 @@
> >  { 'struct': 'CommandLineOptionInfo',
> >    'data': { 'option': 'str', 'parameters': ['CommandLineParameterInfo'=
] } }
> >
> > +##
> > +# @MemoryBin:
> > +#
> > +# A bin of memory with a size in bytes. File-backed and
> > +# anonymous memory are tracked separately.
> > +#
> > +# @anon: number of bytes of anonymous memory
> > +# @file: number of bytes of file-backed memory
> > +##
> > +{ 'struct': 'MemoryBin',
> > +  'data': { 'anon': 'uint64',
> > +            'file': 'uint64' } }
> > +
> > +##
> > +# @WorkingSetInfo:
> > +#
> > +# A bin of memory of the given size that has been idle at most `idle-a=
ge` ms
> > +#
> > +# @idle-age: guest-relative time (in milliseconds)
> > +#
> > +# @memory-size-bytes: A MemoryBin with file and anon info.
> > +##
> > +{ 'struct': 'WorkingSetInfo',
> > +  'data': { 'idle-age': 'uint64',
> > +            'memory-size-bytes': 'MemoryBin' } }
> > +
> >  ##
> >  # @query-command-line-options:
> >  #
> > diff --git a/softmmu/balloon.c b/softmmu/balloon.c
> > index e0e8969a4b..8ff30fe43b 100644
> > --- a/softmmu/balloon.c
> > +++ b/softmmu/balloon.c
> > @@ -35,6 +35,8 @@
> >
> >  static QEMUBalloonEvent *balloon_event_fn;
> >  static QEMUBalloonStatus *balloon_stat_fn;
> > +static QEMUBalloonWSRequest *balloon_ws_request_fn;
> > +static QEMUBalloonWSConfig *balloon_ws_config_fn;
> >  static void *balloon_opaque;
> >
> >  static bool have_balloon(Error **errp)
> > @@ -53,9 +55,12 @@ static bool have_balloon(Error **errp)
> >  }
> >
> >  int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
> > -                             QEMUBalloonStatus *stat_func, void *opaqu=
e)
> > +                             QEMUBalloonStatus *stat_func,
> > +                             QEMUBalloonWSRequest *ws_request_func,
> > +                             QEMUBalloonWSConfig *ws_config_func, void=
 *opaque)
> >  {
> > -    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
> > +    if (balloon_event_fn || balloon_stat_fn || balloon_ws_request_fn \
> > +        || balloon_ws_config_fn || balloon_opaque) {
> >          /* We're already registered one balloon handler.  How many can
> >           * a guest really have?
> >           */
> > @@ -63,6 +68,8 @@ int qemu_add_balloon_handler(QEMUBalloonEvent *event_=
func,
> >      }
> >      balloon_event_fn =3D event_func;
> >      balloon_stat_fn =3D stat_func;
> > +    balloon_ws_request_fn =3D ws_request_func;
> > +    balloon_ws_config_fn =3D ws_config_func;
> >      balloon_opaque =3D opaque;
> >      return 0;
> >  }
> > @@ -74,6 +81,8 @@ void qemu_remove_balloon_handler(void *opaque)
> >      }
> >      balloon_event_fn =3D NULL;
> >      balloon_stat_fn =3D NULL;
> > +    balloon_ws_request_fn =3D NULL;
> > +    balloon_ws_config_fn =3D NULL;
> >      balloon_opaque =3D NULL;
> >  }
> >
> > @@ -104,3 +113,22 @@ void qmp_balloon(int64_t target, Error **errp)
> >      trace_balloon_event(balloon_opaque, target);
> >      balloon_event_fn(balloon_opaque, target);
> >  }
> > +
> > +void qmp_ws_request(Error **errp)
> > +{
> > +    if (!have_balloon(errp)) {
> > +        return;
> > +    }
> > +
> > +    balloon_ws_request_fn(balloon_opaque);
> > +}
> > +
> > +void qmp_ws_config(uint64_t i0, uint64_t i1, uint64_t i2, uint64_t ref=
resh,
> > +                       uint64_t report, Error **errp)
> > +{
> > +    if (!have_balloon(errp)) {
> > +        return;
> > +    }
> > +
> > +    balloon_ws_config_fn(balloon_opaque, i0, i1, i2, refresh, report);
> > +}
> > --
> > 2.40.1.521.gf1e218fcd8-goog
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

