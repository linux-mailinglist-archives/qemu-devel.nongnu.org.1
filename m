Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFBEA97F85
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 08:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ts8-0000CT-Iq; Wed, 23 Apr 2025 02:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1u7Ts1-0000BE-IM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:46:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1u7Trw-00059M-45
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:46:09 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2243803b776so93821805ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1745390761; x=1745995561;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z32GP3rREqqCdF7BdueLvquJzZLQr0ZHUUjrBlAWBM0=;
 b=EVDL4TnsES3pAh/XtOLbq25QhqbnnZyHFUBqqvLW7Fb+WXS3NG1f30HLTxXoGzIx76
 wu7a7n8YtZeg2vNIvrKBTEq2Y0JaiZ/c32opR/Tftpupx9A+kRj39xPjVTOUjC+l/J8f
 1scbqpnnHBAabHj2S6TIXSIsWLeo72hDJtLrYFz+wgEZkZu3nhL1EeepE54QM7BZ+pJp
 1QCNILhFNBvXcjWHQrFo9vCP6FdZR8Zqj5AeWx+fYZUzzhe02H5TjSAZ0fc72oN7PFyp
 jWou39i6qwiW3C8P6jzhOTDEiKjaiiFM6GhV3GilxG8RxWe95hW8PHc9E2R7VOZ/FtuI
 lthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745390761; x=1745995561;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z32GP3rREqqCdF7BdueLvquJzZLQr0ZHUUjrBlAWBM0=;
 b=oHzR7p37VJlFiik9+tk6RLV9pP+pBU0enSERXWgzC+ud+I+P1DzidmMUOB+4rgCVjW
 2HqGZK6OZngYT2hAwObD1yOEWuQFNA0l1kc9+K2ZNGlid4/KwK2/bXkU72FpPW5PrkEF
 bYtxOWOfSWtwNN67leaKwAdPWZvbbb7/h+LnvlbqcMebHXqfkZBUJdjR2WvCE1Lw3cQi
 +vFTa0QS3lsBSkNX9DM7fLRCb7hTfJHnBipb2Fo7PaIqfSUpZe957vd6VZOLMu3lhxHL
 El3Q14T+mbk3A7QfnSy21Ax01nzewckclxXCTpoELBdcURiRJ4mBXJbDhoxNE8OKL4fq
 Hb4A==
X-Gm-Message-State: AOJu0YznD3ODXeU/7mz3AiGworMnqyhra6z8PNTVlbPtTVCLcOdQHa4N
 fHq+uDJC22s6smOsQr81dOep5zfIwh0wKiJMFE3BMe5atqqWoH2z6rgc4hZbKhGNJsOBT2lKAln
 LP2EHkA==
X-Gm-Gg: ASbGncvaJY0QatUxeAJjnKTU5ujHXAd1ZaQRVGjANabBEmjZ/C49vzFYfmbPy2D+GjM
 3O7HZvMNUVhqtAUag48bgMMKGE8QewgxnkHEcGWqIhmdJL/cl3fGdtdDJv/3u4ZVHUaa+Ef4lGj
 rGi6bXohqn23zEUVZ6Hv45M+6sBapL6aXVVRMh/EalH6aXj95z0YVdqhfPWGwrwl371fWCL4GRF
 zTQ0JUwFWfGTOYK9ksbhMEqN9Hpaa9dvulUGAEkpScmTW8giabYSHsZzR0roxAbEIgTF1iqWjq3
 d/Uq+ygdvgtSKvMq56WQDLHMO715MDVlResDHjZd5DX7Dfmn1XYVKku1OAGZTIYVleC4oiT+J/u
 u3QvqjcsN9FBUh8DYz7XGxKffVndLDTeAJHHSDlJ83A==
X-Google-Smtp-Source: AGHT+IGnv4LXEcuJSPduWTvzNf5zCJ/THoT4xJHnq2jy+EY97rkONLMJE1UixOgGdwNrj/hs94S9Yg==
X-Received: by 2002:a17:902:d548:b0:21f:dbb:20a6 with SMTP id
 d9443c01a7336-22c53618abamr257881925ad.33.1745390760621; 
 Tue, 22 Apr 2025 23:46:00 -0700 (PDT)
Received: from smtpclient.apple (awork062091.netvigator.com. [203.198.28.91])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdaaf2sm96542345ad.13.2025.04.22.23.45.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Apr 2025 23:46:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v5 3/3] vhost-user: return failure if backend crash when
 live migration
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <20250416024729.3289157-4-haoqian.he@smartx.com>
Date: Wed, 23 Apr 2025 14:45:42 +0800
Cc: Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:virtiofs" <virtio-fs@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <998122CC-C357-4499-831D-DC739E42A520@smartx.com>
References: <20250401151819.1526461-1-haoqian.he@smartx.com>
 <20250416024729.3289157-1-haoqian.he@smartx.com>
 <20250416024729.3289157-4-haoqian.he@smartx.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 10:47=EF=BC=8CHaoqian He =
<haoqian.he@smartx.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Live migration should be terminated if the vhost-user backend crashes
> before the migration completes.
>=20
> Specifically, since the vhost device will be stopped when VM is =
stopped
> before the end of the live migration, in current implementation if the
> backend crashes, vhost-user device set_status() won't return failure,
> live migration won't perceive the disconnection between QEMU and the
> backend.
>=20
> When the VM is migrated to the destination, the inflight IO will be
> resubmitted, and if the IO was completed out of order before, it will
> cause IO error.
>=20
> To fix this issue:
> 1. Add the return value to set_status() for VirtioDeviceClass.
>  a. For the vhost-user device, return failure when the backend =
crashes.
>  b. For other virtio devices, always return 0.
> 2. Return failure if vhost_dev_stop() failed for vhost-user device.
>=20
> If QEMU loses connection with the vhost-user backend, virtio =
set_status()
> can return failure to the upper layer, migration_completion() can =
handle
> the error, terminate the live migration, and restore the VM, so that
> inflight IO can be completed normally.
>=20
> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
> ---
> backends/vhost-user.c                  | 20 +++++++++----------
> hw/block/vhost-user-blk.c              | 27 ++++++++++++++------------
> hw/block/virtio-blk.c                  |  5 +++--
> hw/char/virtio-serial-bus.c            |  3 ++-
> hw/display/vhost-user-gpu.c            | 12 +++++++++---
> hw/input/virtio-input.c                |  3 ++-
> hw/net/virtio-net.c                    |  3 ++-
> hw/scsi/vhost-scsi-common.c            | 13 +++++++------
> hw/scsi/vhost-scsi.c                   |  5 +++--
> hw/scsi/vhost-user-scsi.c              | 18 ++++++++++-------
> hw/virtio/vdpa-dev.c                   |  5 +++--
> hw/virtio/vhost-user-base.c            | 23 +++++++++++++---------
> hw/virtio/vhost-user-fs.c              | 23 +++++++++++++---------
> hw/virtio/vhost-user-scmi.c            | 27 +++++++++++++++-----------
> hw/virtio/vhost-user-vsock.c           | 15 +++++++++-----
> hw/virtio/vhost-vsock-common.c         | 12 ++++++------
> hw/virtio/vhost-vsock.c                | 11 ++++++-----
> hw/virtio/virtio-balloon.c             |  3 ++-
> hw/virtio/virtio-crypto.c              |  3 ++-
> hw/virtio/virtio-iommu.c               |  3 ++-
> hw/virtio/virtio-rng.c                 |  5 +++--
> hw/virtio/virtio.c                     | 22 ++++++++++++++-------
> include/hw/virtio/vhost-scsi-common.h  |  2 +-
> include/hw/virtio/vhost-vsock-common.h |  2 +-
> include/hw/virtio/virtio.h             |  2 +-
> include/system/vhost-user-backend.h    |  2 +-
> 26 files changed, 160 insertions(+), 109 deletions(-)
>=20
> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index d0e4d71a63..956063cd18 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -97,30 +97,28 @@ err_host_notifiers:
>     vhost_dev_disable_notifiers(&b->dev, b->vdev);
> }
>=20
> -void
> +int
> vhost_user_backend_stop(VhostUserBackend *b)
> {
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
>     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> -    int ret =3D 0;
> +    int ret;
>=20
>     if (!b->started) {
> -        return;
> +        return 0;
>     }
>=20
> -    vhost_dev_stop(&b->dev, b->vdev, true);
> +    ret =3D vhost_dev_stop(&b->dev, b->vdev, true);
>=20
> -    if (k->set_guest_notifiers) {
> -        ret =3D k->set_guest_notifiers(qbus->parent,
> -                                     b->dev.nvqs, false);
> -        if (ret < 0) {
> -            error_report("vhost guest notifier cleanup failed: %d", =
ret);
> -        }
> +    if (k->set_guest_notifiers &&
> +        k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false) < 0) =
{
> +        error_report("vhost guest notifier cleanup failed: %d", ret);
> +        return -1;
>     }
> -    assert(ret >=3D 0);
>=20
>     vhost_dev_disable_notifiers(&b->dev, b->vdev);
>     b->started =3D false;
> +    return ret;
> }
>=20
> static void set_chardev(Object *obj, const char *value, Error **errp)
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index ae42327cf8..f355459123 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -204,7 +204,7 @@ err_host_notifiers:
>     return ret;
> }
>=20
> -static void vhost_user_blk_stop(VirtIODevice *vdev)
> +static int vhost_user_blk_stop(VirtIODevice *vdev)
> {
>     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> @@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice =
*vdev)
>     int ret;
>=20
>     if (!s->started_vu) {
> -        return;
> +        return 0;
>     }
>     s->started_vu =3D false;
>=20
>     if (!k->set_guest_notifiers) {
> -        return;
> +        return 0;
>     }
>=20
> -    vhost_dev_stop(&s->dev, vdev, true);
> +    ret =3D vhost_dev_stop(&s->dev, vdev, true);
>=20
> -    ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> -    if (ret < 0) {
> +    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) =
{
>         error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> +        return -1;
>     }
>=20
>     vhost_dev_disable_notifiers(&s->dev, vdev);
> +    return ret;
> }
>=20
> -static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
> @@ -239,11 +239,11 @@ static void =
vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>     int ret;
>=20
>     if (!s->connected) {
> -        return;
> +        return -1;
>     }
>=20
>     if (vhost_dev_is_started(&s->dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
> @@ -253,9 +253,12 @@ static void =
vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>             qemu_chr_fe_disconnect(&s->chardev);
>         }
>     } else {
> -        vhost_user_blk_stop(vdev);
> +        ret =3D vhost_user_blk_stop(vdev);
> +        if (ret < 0) {
> +            return ret;
> +        }
>     }
> -
> +    return 0;
> }
>=20
> static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 458871ea2b..caf8042cd5 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1270,7 +1270,7 @@ static uint64_t =
virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
>     return features;
> }
>=20
> -static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
> +static int virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VirtIOBlock *s =3D VIRTIO_BLK(vdev);
>=20
> @@ -1279,7 +1279,7 @@ static void virtio_blk_set_status(VirtIODevice =
*vdev, uint8_t status)
>     }
>=20
>     if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -        return;
> +        return 0;
>     }
>=20
>     /* A guest that supports VIRTIO_BLK_F_CONFIG_WCE must be able to =
send
> @@ -1302,6 +1302,7 @@ static void virtio_blk_set_status(VirtIODevice =
*vdev, uint8_t status)
>                                    virtio_vdev_has_feature(vdev,
>                                                            =
VIRTIO_BLK_F_WCE));
>     }
> +    return 0;
> }
>=20
> static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index b6d2743a9c..22accfd8e4 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -622,7 +622,7 @@ static void guest_reset(VirtIOSerial *vser)
>     }
> }
>=20
> -static void set_status(VirtIODevice *vdev, uint8_t status)
> +static int set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VirtIOSerial *vser;
>     VirtIOSerialPort *port;
> @@ -650,6 +650,7 @@ static void set_status(VirtIODevice *vdev, uint8_t =
status)
>             vsc->enable_backend(port, vdev->vm_running);
>         }
>     }
> +    return 0;
> }
>=20
> static void vser_reset(VirtIODevice *vdev)
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 2aed6243f6..d7d159ecd9 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -513,7 +513,7 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
>     }
> }
>=20
> -static void
> +static int
> vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
> {
>     VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
> @@ -522,18 +522,24 @@ vhost_user_gpu_set_status(VirtIODevice *vdev, =
uint8_t val)
>     if (val & VIRTIO_CONFIG_S_DRIVER_OK && vdev->vm_running) {
>         if (!vhost_user_gpu_do_set_socket(g, &err)) {
>             error_report_err(err);
> -            return;
> +            return 0;
>         }
>         vhost_user_backend_start(g->vhost);
>     } else {
> +        int ret;
> +
>         /* unblock any wait and stop processing */
>         if (g->vhost_gpu_fd !=3D -1) {
>             vhost_user_gpu_update_blocked(g, true);
>             qemu_chr_fe_deinit(&g->vhost_chr, true);
>             g->vhost_gpu_fd =3D -1;
>         }
> -        vhost_user_backend_stop(g->vhost);
> +        ret =3D vhost_user_backend_stop(g->vhost);
> +        if (ret < 0) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> static bool
> diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
> index 1394d99c6b..7ce53b7449 100644
> --- a/hw/input/virtio-input.c
> +++ b/hw/input/virtio-input.c
> @@ -189,7 +189,7 @@ static uint64_t =
virtio_input_get_features(VirtIODevice *vdev, uint64_t f,
>     return f;
> }
>=20
> -static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
> +static int virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
> {
>     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(vdev);
>     VirtIOInput *vinput =3D VIRTIO_INPUT(vdev);
> @@ -202,6 +202,7 @@ static void virtio_input_set_status(VirtIODevice =
*vdev, uint8_t val)
>             }
>         }
>     }
> +    return 0;
> }
>=20
> static void virtio_input_reset(VirtIODevice *vdev)
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index bd37651dab..98d9e54370 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -382,7 +382,7 @@ static void =
virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
>     }
> }
>=20
> -static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t =
status)
> +static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t =
status)
> {
>     VirtIONet *n =3D VIRTIO_NET(vdev);
>     VirtIONetQueue *q;
> @@ -437,6 +437,7 @@ static void virtio_net_set_status(struct =
VirtIODevice *vdev, uint8_t status)
>             }
>         }
>     }
> +    return 0;
> }
>=20
> static void virtio_net_set_link_status(NetClientState *nc)
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index 4c8637045d..43525ba46d 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -101,24 +101,25 @@ err_host_notifiers:
>     return ret;
> }
>=20
> -void vhost_scsi_common_stop(VHostSCSICommon *vsc)
> +int vhost_scsi_common_stop(VHostSCSICommon *vsc)
> {
>     VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>     int ret =3D 0;
>=20
> -    vhost_dev_stop(&vsc->dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vsc->dev, vdev, true);
>=20
>     if (k->set_guest_notifiers) {
> -        ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, =
false);
> -        if (ret < 0) {
> -                error_report("vhost guest notifier cleanup failed: =
%d", ret);
> +        int r =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, =
false);
> +        if (r < 0) {
> +            error_report("vhost guest notifier cleanup failed: %d", =
ret);
> +            return r;
>         }
>     }
> -    assert(ret >=3D 0);
>=20
>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> +    return ret;
> }
>=20
> uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t =
features,
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 8039d13fd9..19d5261019 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -114,7 +114,7 @@ static void vhost_scsi_stop(VHostSCSI *s)
>     vhost_scsi_common_stop(vsc);
> }
>=20
> -static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
> +static int vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
> {
>     VHostSCSI *s =3D VHOST_SCSI(vdev);
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> @@ -125,7 +125,7 @@ static void vhost_scsi_set_status(VirtIODevice =
*vdev, uint8_t val)
>     }
>=20
>     if (vhost_dev_is_started(&vsc->dev) =3D=3D start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (start) {
> @@ -139,6 +139,7 @@ static void vhost_scsi_set_status(VirtIODevice =
*vdev, uint8_t val)
>     } else {
>         vhost_scsi_stop(s);
>     }
> +    return 0;
> }
>=20
> static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index adb41b9816..aba9fb82d2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI *s, =
Error **errp)
>     return ret;
> }
>=20
> -static void vhost_user_scsi_stop(VHostUserSCSI *s)
> +static int vhost_user_scsi_stop(VHostUserSCSI *s)
> {
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>=20
>     if (!s->started_vu) {
> -        return;
> +        return 0;
>     }
>     s->started_vu =3D false;
>=20
> -    vhost_scsi_common_stop(vsc);
> +    return vhost_scsi_common_stop(vsc);
> }
>=20
> -static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>     DeviceState *dev =3D DEVICE(vdev);
> @@ -75,11 +75,11 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>     int ret;
>=20
>     if (!s->connected) {
> -        return;
> +        return -1;
>     }
>=20
>     if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
> @@ -91,8 +91,12 @@ static void vhost_user_scsi_set_status(VirtIODevice =
*vdev, uint8_t status)
>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
>     } else {
> -        vhost_user_scsi_stop(s);
> +        ret =3D vhost_user_scsi_stop(s);
> +        if (ret) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> static void vhost_user_scsi_handle_output(VirtIODevice *vdev, =
VirtQueue *vq)
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index a7e73b1c99..d80d46baed 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -312,7 +312,7 @@ static void vhost_vdpa_device_stop(VirtIODevice =
*vdev)
>     vhost_dev_disable_notifiers(&s->dev, vdev);
> }
>=20
> -static void vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     VhostVdpaDevice *s =3D VHOST_VDPA_DEVICE(vdev);
>     bool should_start =3D virtio_device_started(vdev, status);
> @@ -324,7 +324,7 @@ static void =
vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
>     }
>=20
>     if (s->started =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
> @@ -335,6 +335,7 @@ static void =
vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
>     } else {
>         vhost_vdpa_device_stop(vdev);
>     }
> +    return 0;
> }
>=20
> static const Property vhost_vdpa_device_properties[] =3D {
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 2bc3423326..37718653bd 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -66,7 +66,7 @@ err_host_notifiers:
>     vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
> }
>=20
> -static void vub_stop(VirtIODevice *vdev)
> +static int vub_stop(VirtIODevice *vdev)
> {
>     VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> @@ -74,34 +74,39 @@ static void vub_stop(VirtIODevice *vdev)
>     int ret;
>=20
>     if (!k->set_guest_notifiers) {
> -        return;
> +        return 0;
>     }
>=20
> -    vhost_dev_stop(&vub->vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vub->vhost_dev, vdev, true);
>=20
> -    ret =3D k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, =
false);
> -    if (ret < 0) {
> +    if (k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, =
false) < 0) {
>         error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> +        return -1;
>     }
>=20
>     vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
> +    return ret;
> }
>=20
> -static void vub_set_status(VirtIODevice *vdev, uint8_t status)
> +static int vub_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
>=20
>     if (vhost_dev_is_started(&vub->vhost_dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
>         vub_start(vdev);
>     } else {
> -        vub_stop(vdev);
> +        int ret;
> +        ret =3D vub_stop(vdev);
> +        if (ret < 0) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> /*
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 3f00d79ed0..266c179671 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -100,7 +100,7 @@ err_host_notifiers:
>     vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> }
>=20
> -static void vuf_stop(VirtIODevice *vdev)
> +static int vuf_stop(VirtIODevice *vdev)
> {
>     VHostUserFS *fs =3D VHOST_USER_FS(vdev);
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> @@ -108,34 +108,39 @@ static void vuf_stop(VirtIODevice *vdev)
>     int ret;
>=20
>     if (!k->set_guest_notifiers) {
> -        return;
> +        return 0;
>     }
>=20
> -    vhost_dev_stop(&fs->vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(&fs->vhost_dev, vdev, true);
>=20
> -    ret =3D k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, =
false);
> -    if (ret < 0) {
> +    if (k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, =
false) < 0) {
>         error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> +        return -1;
>     }
>=20
>     vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> +    return ret;
> }
>=20
> -static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
> +static int vuf_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostUserFS *fs =3D VHOST_USER_FS(vdev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
>=20
>     if (vhost_dev_is_started(&fs->vhost_dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
>         vuf_start(vdev);
>     } else {
> -        vuf_stop(vdev);
> +        int ret;
> +        ret =3D vuf_stop(vdev);
> +        if (ret < 0) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> static uint64_t vuf_get_features(VirtIODevice *vdev,
> diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
> index 410a936ca7..a9778f1f4b 100644
> --- a/hw/virtio/vhost-user-scmi.c
> +++ b/hw/virtio/vhost-user-scmi.c
> @@ -83,7 +83,7 @@ err_host_notifiers:
>     return ret;
> }
>=20
> -static void vu_scmi_stop(VirtIODevice *vdev)
> +static int vu_scmi_stop(VirtIODevice *vdev)
> {
>     VHostUserSCMI *scmi =3D VHOST_USER_SCMI(vdev);
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> @@ -93,41 +93,46 @@ static void vu_scmi_stop(VirtIODevice *vdev)
>=20
>     /* vhost_dev_is_started() check in the callers is not fully =
reliable. */
>     if (!scmi->started_vu) {
> -        return;
> +        return 0;
>     }
>     scmi->started_vu =3D false;
>=20
>     if (!k->set_guest_notifiers) {
> -        return;
> +        return 0;
>     }
>=20
> -    vhost_dev_stop(vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(vhost_dev, vdev, true);
>=20
> -    ret =3D k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, =
false);
> -    if (ret < 0) {
> +    if (k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false) =
< 0) {
>         error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> +        return -1;
>     }
>     vhost_dev_disable_notifiers(vhost_dev, vdev);
> +    return ret;
> }
>=20
> -static void vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
> +static int vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostUserSCMI *scmi =3D VHOST_USER_SCMI(vdev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
>=20
>     if (!scmi->connected) {
> -        return;
> +        return -1;
>     }
>     if (vhost_dev_is_started(&scmi->vhost_dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
>         vu_scmi_start(vdev);
>     } else {
> -        vu_scmi_stop(vdev);
> +        int ret;
> +        ret =3D vu_scmi_stop(vdev);
> +        if (ret < 0) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> static uint64_t vu_scmi_get_features(VirtIODevice *vdev, uint64_t =
features,
> diff --git a/hw/virtio/vhost-user-vsock.c =
b/hw/virtio/vhost-user-vsock.c
> index 293273080b..7a4aec7bf4 100644
> --- a/hw/virtio/vhost-user-vsock.c
> +++ b/hw/virtio/vhost-user-vsock.c
> @@ -54,23 +54,28 @@ const VhostDevConfigOps vsock_ops =3D {
>     .vhost_dev_config_notifier =3D vuv_handle_config_change,
> };
>=20
> -static void vuv_set_status(VirtIODevice *vdev, uint8_t status)
> +static int vuv_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostVSockCommon *vvc =3D VHOST_VSOCK_COMMON(vdev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
> +    int ret;
>=20
>     if (vhost_dev_is_started(&vvc->vhost_dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
> -        int ret =3D vhost_vsock_common_start(vdev);
> +        ret =3D vhost_vsock_common_start(vdev);
>         if (ret < 0) {
> -            return;
> +            return ret;
>         }
>     } else {
> -        vhost_vsock_common_stop(vdev);
> +        ret =3D vhost_vsock_common_stop(vdev);
> +        if (ret < 0) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> static uint64_t vuv_get_features(VirtIODevice *vdev,
> diff --git a/hw/virtio/vhost-vsock-common.c =
b/hw/virtio/vhost-vsock-common.c
> index 9ac587d20c..bbfbbdb317 100644
> --- a/hw/virtio/vhost-vsock-common.c
> +++ b/hw/virtio/vhost-vsock-common.c
> @@ -95,7 +95,7 @@ err_host_notifiers:
>     return ret;
> }
>=20
> -void vhost_vsock_common_stop(VirtIODevice *vdev)
> +int vhost_vsock_common_stop(VirtIODevice *vdev)
> {
>     VHostVSockCommon *vvc =3D VHOST_VSOCK_COMMON(vdev);
>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> @@ -103,18 +103,18 @@ void vhost_vsock_common_stop(VirtIODevice *vdev)
>     int ret;
>=20
>     if (!k->set_guest_notifiers) {
> -        return;
> +        return 0;
>     }
>=20
> -    vhost_dev_stop(&vvc->vhost_dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vvc->vhost_dev, vdev, true);
>=20
> -    ret =3D k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, =
false);
> -    if (ret < 0) {
> +    if (k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, =
false) < 0) {
>         error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> +        return -1;
>     }
>=20
>     vhost_dev_disable_notifiers(&vvc->vhost_dev, vdev);
> +    return ret;
> }
>=20
>=20
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 940b30fa27..62b36b28f5 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -67,37 +67,38 @@ static int vhost_vsock_set_running(VirtIODevice =
*vdev, int start)
> }
>=20
>=20
> -static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostVSockCommon *vvc =3D VHOST_VSOCK_COMMON(vdev);
>     bool should_start =3D virtio_device_should_start(vdev, status);
>     int ret;
>=20
>     if (vhost_dev_is_started(&vvc->vhost_dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>     }
>=20
>     if (should_start) {
>         ret =3D vhost_vsock_common_start(vdev);
>         if (ret < 0) {
> -            return;
> +            return 0;
>         }
>=20
>         ret =3D vhost_vsock_set_running(vdev, 1);
>         if (ret < 0) {
>             vhost_vsock_common_stop(vdev);
>             error_report("Error starting vhost vsock: %d", -ret);
> -            return;
> +            return 0;
>         }
>     } else {
>         ret =3D vhost_vsock_set_running(vdev, 0);
>         if (ret < 0) {
>             error_report("vhost vsock set running failed: %d", ret);
> -            return;
> +            return 0;
>         }
>=20
>         vhost_vsock_common_stop(vdev);
>     }
> +    return 0;
> }
>=20
> static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 2eb5a14fa2..e719c078aa 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -958,7 +958,7 @@ static void =
virtio_balloon_device_reset(VirtIODevice *vdev)
>     s->poison_val =3D 0;
> }
>=20
> -static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int virtio_balloon_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
>=20
> @@ -988,6 +988,7 @@ static void virtio_balloon_set_status(VirtIODevice =
*vdev, uint8_t status)
>             qemu_mutex_unlock(&s->free_page_lock);
>         }
>     }
> +    return 0;
> }
>=20
> static ResettableState *virtio_balloon_get_reset_state(Object *obj)
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index a1b3c90618..626279dc5b 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -1197,11 +1197,12 @@ static void =
virtio_crypto_vhost_status(VirtIOCrypto *c, uint8_t status)
>     }
> }
>=20
> -static void virtio_crypto_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int virtio_crypto_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     VirtIOCrypto *vcrypto =3D VIRTIO_CRYPTO(vdev);
>=20
>     virtio_crypto_vhost_status(vcrypto, status);
> +    return 0;
> }
>=20
> static void virtio_crypto_guest_notifier_mask(VirtIODevice *vdev, int =
idx,
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index b6e7e01ef7..63ec12014f 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1522,9 +1522,10 @@ static void =
virtio_iommu_device_reset_exit(Object *obj, ResetType type)
>                                    NULL, NULL, =
virtio_iommu_put_endpoint);
> }
>=20
> -static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t =
status)
> +static int virtio_iommu_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     trace_virtio_iommu_device_status(status);
> +    return 0;
> }
>=20
> static void virtio_iommu_instance_init(Object *obj)
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index a515fc5cd9..4748d039f9 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -159,17 +159,18 @@ static void check_rate_limit(void *opaque)
>     vrng->activate_timer =3D true;
> }
>=20
> -static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
> +static int virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VirtIORNG *vrng =3D VIRTIO_RNG(vdev);
>=20
>     if (!vdev->vm_running) {
> -        return;
> +        return 0;
>     }
>     vdev->status =3D status;
>=20
>     /* Something changed, try to process buffers */
>     virtio_rng_process(vrng);
> +    return 0;
> }
>=20
> static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 202a052053..d52808ea67 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, =
uint8_t val)
> {
>     VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>     trace_virtio_set_status(vdev, val);
> +    int ret =3D 0;
>=20
>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>             val & VIRTIO_CONFIG_S_FEATURES_OK) {
> -            int ret =3D virtio_validate_features(vdev);
> -
> +            ret =3D virtio_validate_features(vdev);
>             if (ret) {
>                 return ret;
>             }
> @@ -2239,11 +2239,15 @@ int virtio_set_status(VirtIODevice *vdev, =
uint8_t val)
>     }
>=20
>     if (k->set_status) {
> -        k->set_status(vdev, val);
> +        ret =3D k->set_status(vdev, val);
> +        if (ret) {
> +            qemu_log("set %s status to %d failed, old status: %d\n",
> +                     vdev->name, val, vdev->status);
> +        }
>     }
>     vdev->status =3D val;
>=20
> -    return 0;
> +    return ret;
> }
>=20
> static enum virtio_device_endian virtio_default_endian(void)
> @@ -3419,7 +3423,7 @@ void virtio_cleanup(VirtIODevice *vdev)
>     qemu_del_vm_change_state_handler(vdev->vmstate);
> }
>=20
> -static void virtio_vmstate_change(void *opaque, bool running, =
RunState state)
> +static int virtio_vmstate_change(void *opaque, bool running, RunState =
state)
> {
>     VirtIODevice *vdev =3D opaque;
>     BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> @@ -3436,8 +3440,12 @@ static void virtio_vmstate_change(void *opaque, =
bool running, RunState state)
>     }
>=20
>     if (!backend_run) {
> -        virtio_set_status(vdev, vdev->status);
> +        int ret =3D virtio_set_status(vdev, vdev->status);
> +        if (ret) {
> +            return ret;
> +        }
>     }
> +    return 0;
> }
>=20
> void virtio_instance_init_common(Object *proxy_obj, void *data,
> @@ -3489,7 +3497,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t =
device_id, size_t config_size)
>         vdev->config =3D NULL;
>     }
>     vdev->vmstate =3D qdev_add_vm_change_state_handler(DEVICE(vdev),
> -            virtio_vmstate_change, NULL, vdev);
> +            NULL, virtio_vmstate_change, vdev);
>     vdev->device_endian =3D virtio_default_endian();
>     vdev->use_guest_notifier_mask =3D true;
> }
> diff --git a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h
> index c5d2c09455..d54d9c916f 100644
> --- a/include/hw/virtio/vhost-scsi-common.h
> +++ b/include/hw/virtio/vhost-scsi-common.h
> @@ -40,7 +40,7 @@ struct VHostSCSICommon {
> };
>=20
> int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
> -void vhost_scsi_common_stop(VHostSCSICommon *vsc);
> +int vhost_scsi_common_stop(VHostSCSICommon *vsc);
> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState =
*bus,
>                                         DeviceState *dev);
> void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t =
*config);
> diff --git a/include/hw/virtio/vhost-vsock-common.h =
b/include/hw/virtio/vhost-vsock-common.h
> index 75a74e8a99..01bf6062af 100644
> --- a/include/hw/virtio/vhost-vsock-common.h
> +++ b/include/hw/virtio/vhost-vsock-common.h
> @@ -42,7 +42,7 @@ struct VHostVSockCommon {
> };
>=20
> int vhost_vsock_common_start(VirtIODevice *vdev);
> -void vhost_vsock_common_stop(VirtIODevice *vdev);
> +int vhost_vsock_common_stop(VirtIODevice *vdev);
> int vhost_vsock_common_pre_save(void *opaque);
> int vhost_vsock_common_post_load(void *opaque, int version_id);
> void vhost_vsock_common_realize(VirtIODevice *vdev);
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 6386910280..a7ee9bec75 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -186,7 +186,7 @@ struct VirtioDeviceClass {
>     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
>     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>     void (*reset)(VirtIODevice *vdev);
> -    void (*set_status)(VirtIODevice *vdev, uint8_t val);
> +    int (*set_status)(VirtIODevice *vdev, uint8_t val);
>     /* Device must validate queue_index.  */
>     void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
>     /* Device must validate queue_index.  */
> diff --git a/include/system/vhost-user-backend.h =
b/include/system/vhost-user-backend.h
> index 327b0b84f1..87765a1218 100644
> --- a/include/system/vhost-user-backend.h
> +++ b/include/system/vhost-user-backend.h
> @@ -43,6 +43,6 @@ struct VhostUserBackend {
> int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice =
*vdev,
>                                 unsigned nvqs, Error **errp);
> void vhost_user_backend_start(VhostUserBackend *b);
> -void vhost_user_backend_stop(VhostUserBackend *b);
> +int vhost_user_backend_stop(VhostUserBackend *b);
>=20
> #endif
> --=20
> 2.44.0
>=20

Gently ping. Looking forward to the review of these patches.=

