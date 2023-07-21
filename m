Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15B75CBAC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMs1H-0001iw-Is; Fri, 21 Jul 2023 11:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMs1A-0001h7-P8
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMs0q-00054u-IO
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689953147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGx9g2WbnmmD/yg6QBkr7zJhNAx/4MK5y8Z3OemuKTc=;
 b=QpNdQ9fr63zIQzhvByBzoKRFn7YDbX3vCozO6CTq518XjXs7gAJTzqNi/+PZo/IekTsyz2
 TyUoxskeVgDCiEIdMfXxF0KMVqqXyXQsuTAE9TBkfMhuNAu2zwCdwrq/Qw4loEG6zbYhcw
 NAq0YTzBmcyNxo1RyxirX4EWcps1Its=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-RDECoqH1OimCom154ML7IQ-1; Fri, 21 Jul 2023 11:25:45 -0400
X-MC-Unique: RDECoqH1OimCom154ML7IQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d00afc8c0efso1312271276.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689953145; x=1690557945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGx9g2WbnmmD/yg6QBkr7zJhNAx/4MK5y8Z3OemuKTc=;
 b=N9z91S2ifObnc3iKIcQv6+//c4LI6yKog2xWZcjPh7cx/a4IlemryEp11iCmOqGk0u
 mR+cO3LAgIHP6aGNLX/pp9IKWyX1gXSnN56sla3GYSvquToOT7KxlgRiSn1h5KXwwBUI
 hH/e2X+aD+z8TQSa/AL4FIDNfHWVqct2TlegjcnCRgLm4n1df3iy2NL58X/pwIphN84h
 1bUZufYwRrXECUtP8Gp1d+OUeln+pG4pe659G7tFtuA7Z1xEkx/63ulQSW0lrtPMs6TN
 UqhpmXfS+eu9lzpMPyVgV0a3SbMng3HesJkk5xKKo5+2wwyWrAwEwHE+DURTnH8dgUMk
 XOOg==
X-Gm-Message-State: ABy/qLafZ7Ko8bhrHRmRdHu3BhPWV4E2Eo5apr+4qCL5erc99qloYXvP
 ckGgDJh+kYaOLJUiWNUS9U46zty+c1nUGDZcO+JDqcEPtAtzUwNUQU90OvLhoBq3ObUVYUd8Lfc
 2R4LrkR9/rpJjFvp4fn+mvtoYXeZY6aU=
X-Received: by 2002:a25:6941:0:b0:cca:1ecd:544 with SMTP id
 e62-20020a256941000000b00cca1ecd0544mr2128011ybc.17.1689953144967; 
 Fri, 21 Jul 2023 08:25:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+5b4ymF8NssoH5TIZt4XCbpHdlaM9PenW1l1MQy93BtApSQW47HW7mV5tQalVt1tyhxnntmXTZV4fClEYcT0=
X-Received: by 2002:a25:6941:0:b0:cca:1ecd:544 with SMTP id
 e62-20020a256941000000b00cca1ecd0544mr2127994ybc.17.1689953144628; Fri, 21
 Jul 2023 08:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
In-Reply-To: <20230711155230.64277-4-hreitz@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 21 Jul 2023 17:25:08 +0200
Message-ID: <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 11, 2023 at 5:52=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> Move the `suspended` field from vhost_vdpa into the global vhost_dev
> struct, so vhost_dev_stop() can check whether the back-end has been
> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
> there is no need to reset it; the reset is just a fall-back to stop
> device operations for back-ends that do not support suspend.
>
> Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
> when the device is re-started, we still have to do the reset to have it
> un-suspend.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost-vdpa.h |  2 --
>  include/hw/virtio/vhost.h      |  8 ++++++++
>  hw/virtio/vhost-vdpa.c         | 11 +++++++----
>  hw/virtio/vhost.c              |  8 +++++++-
>  4 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index e64bfc7f98..72c3686b7f 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
>      bool shadow_vqs_enabled;
>      /* Vdpa must send shadow addresses as IOTLB key for data queues, not=
 GPA */
>      bool shadow_data;
> -    /* Device suspended successfully */
> -    bool suspended;
>      /* IOVA mapping used by the Shadow Virtqueue */
>      VhostIOVATree *iova_tree;
>      GPtrArray *shadow_vqs;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 6a173cb9fa..69bf59d630 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -120,6 +120,14 @@ struct vhost_dev {
>      uint64_t backend_cap;
>      /* @started: is the vhost device started? */
>      bool started;
> +    /**
> +     * @suspended: Whether the vhost device is currently suspended.  Set
> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), which
> +     * are supposed to automatically suspend/resume in their
> +     * vhost_dev_start handlers as required.  Must also be cleared when
> +     * the device is reset.
> +     */
> +    bool suspended;
>      bool log_enabled;
>      uint64_t log_size;
>      Error *migration_blocker;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7b7dee468e..f7fd19a203 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost_de=
v *dev,
>
>  static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>  {
> -    struct vhost_vdpa *v =3D dev->opaque;
>      int ret;
>      uint8_t status =3D 0;
>
>      ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>      trace_vhost_vdpa_reset_device(dev);
> -    v->suspended =3D false;
> +    dev->suspended =3D false;
>      return ret;
>  }
>
> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *de=
v)
>          if (unlikely(r)) {
>              error_report("Cannot suspend: %s(%d)", g_strerror(errno), er=
rno);
>          } else {
> -            v->suspended =3D true;
> +            dev->suspended =3D true;
>              return;
>          }
>      }
> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *=
dev, bool started)
>              return -1;
>          }
>          vhost_vdpa_set_vring_ready(dev);
> +        if (dev->suspended) {
> +            /* TODO: When RESUME is available, use it instead of resetti=
ng */
> +            vhost_vdpa_reset_status(dev);

How is that we reset the status at each vhost_vdpa_dev_start? That
will clean all the vqs configured, features negotiated, etc. in the
vDPA device. Or am I missing something?

I'm totally ok with the move of "suspended" member.

Thanks!


> +        }
>      } else {
>          vhost_vdpa_suspend(dev);
>          vhost_vdpa_svqs_stop(dev);
> @@ -1400,7 +1403,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>          return 0;
>      }
>
> -    if (!v->suspended) {
> +    if (!dev->suspended) {
>          /*
>           * Cannot trust in value returned by device, let vhost recover u=
sed
>           * idx from guest.
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index abf0d03c8d..2e28e58da7 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2059,7 +2059,13 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIO=
Device *vdev, bool vrings)
>                               hdev->vqs + i,
>                               hdev->vq_index + i);
>      }
> -    if (hdev->vhost_ops->vhost_reset_status) {
> +
> +    /*
> +     * If we failed to successfully stop the device via SUSPEND (should =
have
> +     * been attempted by `vhost_dev_start(hdev, false)`), reset it to st=
op it.
> +     * Stateful devices where this would be problematic must implement S=
USPEND.
> +     */
> +    if (!hdev->suspended && hdev->vhost_ops->vhost_reset_status) {
>          hdev->vhost_ops->vhost_reset_status(hdev);
>      }
>
> --
> 2.41.0
>


