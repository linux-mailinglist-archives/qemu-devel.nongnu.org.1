Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A60272DD03
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 10:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ziM-000185-3O; Tue, 13 Jun 2023 04:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8ziK-00017u-8L
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 04:49:20 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8ziF-0005hk-Vh
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 04:49:20 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b1a66e71f9so63310501fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686646154; x=1689238154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zqQ9llnndUx5jowHNmCopdDIue6x2tURi8yaoxp6s3o=;
 b=EzXxlseyi7xDHnvektgIZ5NTLrlVeul+1K1LFvStuN2IV9CkUojGLSbx2l+MahEcSu
 V8uVekQndE6YqLttkMhRZvlYUbgcQDdGhvACK52dfv65jQZ2Zbkudi4bPEKy/jYeF1Cd
 HkUL8+1VydG7Ypqld4zavQlUiP8yIDaEE7TzJ+nWWpcdaGSYUKwz9x7Ojb+OIBuVzHho
 ZyPg347Y7mj+QP1YZtZ/P5b2j36FNOt1+xQXPx1oAWCKPZmQRA9NPIsl78ceeo7ZGtXH
 V6KMHl29i3hSLuhfRM9lmIaeYXUWQMvXv9JiD1p4Kr38LslXrTP0AUAbyK4kNg00Oxm+
 HNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686646154; x=1689238154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zqQ9llnndUx5jowHNmCopdDIue6x2tURi8yaoxp6s3o=;
 b=VzvD8RyFcwWI8w0IQqxLnvDjIXdaYm6tZGXTX2HpD8kgt+KcWy4LRoh4SJHmeVeY1F
 stdrje/TQyl4xxoivqFF2IUp9J7nl3YBQt32Px96OmA52WHfnNx1enSbggV/7yj5FncB
 /0XPpGeFckmviWZemOgYPCLzdLNG6NP1w8nMNokeltWXcHSYIwZPBaINSPnvX2wKfyOF
 sp8qCDjrnnAnlxQE4DXS0ARzj5bcli3/9WwXdBzRC9HMDlSTdnyH4PjRyVV1sqX+LBj+
 sGCnzAcBxppVFDaGdfDMIX3SCGiS9pMHVVnJ8bRweT5HDtW2B3Y5ahODlygBMumygefy
 z0DA==
X-Gm-Message-State: AC+VfDyVceTzgbTmWeNcvzw1gAeycxUZVXwCZcCv9cubbpuZSSNsudu7
 SE7tJlq6SMSahXgeKVrTW2guoTDvpe0l/r+hZbY=
X-Google-Smtp-Source: ACHHUZ7Quz7TNOy12ESG+3nwrHG6+R3xVmzoxHq6OWvIjti/uKuFLw7eeChFqZDs9+tJ6vcdYdf/DCwL9qbCkK4Wl8o=
X-Received: by 2002:a2e:8091:0:b0:2b1:dc7a:bc4e with SMTP id
 i17-20020a2e8091000000b002b1dc7abc4emr4098433ljg.37.1686646153280; Tue, 13
 Jun 2023 01:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230613080849.2115347-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20230613080849.2115347-1-manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jun 2023 10:48:56 +0200
Message-ID: <CAJ+F1CKK+ETZM+Rf8Kecyu=g5wwDjbS6oixKV_OMGt9PyLkCQA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: fully use new backend/frontend naming
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="000000000000d4061c05fdfee889"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000d4061c05fdfee889
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 10:09=E2=80=AFAM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> Slave/master nomenclature was replaced with backend/frontend in commit
>
> 1fc19b65279a246083fc4d918510aae68586f734
> vhost-user: Adopt new backend naming
>
> This patch replaces all remaining uses of master and slave in the
> codebase.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  block/export/vhost-user-blk-server.c      |  2 +-
>  contrib/vhost-user-blk/vhost-user-blk.c   |  2 +-
>  hw/block/vhost-user-blk.c                 |  2 +-
>  hw/display/vhost-user-gpu.c               |  2 +-
>  hw/input/vhost-user-input.c               |  2 +-
>  hw/net/virtio-net.c                       |  4 +-
>  hw/virtio/vdpa-dev.c                      |  2 +-
>  hw/virtio/vhost-user.c                    | 52 +++++++++++-----------
>  hw/virtio/virtio-qmp.c                    |  2 +-
>  include/hw/virtio/vhost-backend.h         |  2 +-
>  subprojects/libvhost-user/libvhost-user.c | 54 +++++++++++------------
>  subprojects/libvhost-user/libvhost-user.h | 20 +++++----
>  12 files changed, 74 insertions(+), 72 deletions(-)
>
> diff --git a/block/export/vhost-user-blk-server.c
> b/block/export/vhost-user-blk-server.c
> index 81b59761e3..f7b5073605 100644
> --- a/block/export/vhost-user-blk-server.c
> +++ b/block/export/vhost-user-blk-server.c
> @@ -167,7 +167,7 @@ vu_blk_set_config(VuDev *vu_dev, const uint8_t *data,
>      uint8_t wce;
>
>      /* don't support live migration */
> -    if (flags !=3D VHOST_SET_CONFIG_TYPE_MASTER) {
> +    if (flags !=3D VHOST_SET_CONFIG_TYPE_FRONTEND) {
>          return -EINVAL;
>      }
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c
> b/contrib/vhost-user-blk/vhost-user-blk.c
> index 7941694e53..89e5f11a64 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -421,7 +421,7 @@ vub_set_config(VuDev *vu_dev, const uint8_t *data,
>      int fd;
>
>      /* don't support live migration */
> -    if (flags !=3D VHOST_SET_CONFIG_TYPE_MASTER) {
> +    if (flags !=3D VHOST_SET_CONFIG_TYPE_FRONTEND) {
>          return -1;
>      }
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index aff4d2b8cb..eecf3f7a81 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -81,7 +81,7 @@ static void vhost_user_blk_set_config(VirtIODevice
> *vdev, const uint8_t *config)
>      ret =3D vhost_dev_set_config(&s->dev, &blkcfg->wce,
>                                 offsetof(struct virtio_blk_config, wce),
>                                 sizeof(blkcfg->wce),
> -                               VHOST_SET_CONFIG_TYPE_MASTER);
> +                               VHOST_SET_CONFIG_TYPE_FRONTEND);
>      if (ret) {
>          error_report("set device config space failed");
>          return;
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 1386e869e5..15f9d99d09 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -452,7 +452,7 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
>
>      ret =3D vhost_dev_set_config(&g->vhost->dev, config_data,
>                                 0, sizeof(struct virtio_gpu_config),
> -                               VHOST_SET_CONFIG_TYPE_MASTER);
> +                               VHOST_SET_CONFIG_TYPE_FRONTEND);
>      if (ret) {
>          error_report("vhost-user-gpu: set device config space failed");
>          return;
> diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
> index 1352e372ff..4ee3542106 100644
> --- a/hw/input/vhost-user-input.c
> +++ b/hw/input/vhost-user-input.c
> @@ -69,7 +69,7 @@ static void vhost_input_set_config(VirtIODevice *vdev,
>
>      ret =3D vhost_dev_set_config(&vhi->vhost->dev, config_data,
>                                 0, sizeof(virtio_input_config),
> -                               VHOST_SET_CONFIG_TYPE_MASTER);
> +                               VHOST_SET_CONFIG_TYPE_FRONTEND);
>      if (ret) {
>          error_report("vhost-user-input: set device config space failed")=
;
>          return;
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6df6b7329d..75d7b89cd2 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -211,7 +211,7 @@ static void virtio_net_set_config(VirtIODevice *vdev,
> const uint8_t *config)
>      if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_=
VDPA)
> {
>          vhost_net_set_config(get_vhost_net(nc->peer),
>                               (uint8_t *)&netcfg, 0, n->config_size,
> -                             VHOST_SET_CONFIG_TYPE_MASTER);
> +                             VHOST_SET_CONFIG_TYPE_FRONTEND);
>        }
>  }
>
> @@ -3733,7 +3733,7 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
>          struct virtio_net_config netcfg =3D {};
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
> -            (uint8_t *)&netcfg, 0, ETH_ALEN,
> VHOST_SET_CONFIG_TYPE_MASTER);
> +            (uint8_t *)&netcfg, 0, ETH_ALEN,
> VHOST_SET_CONFIG_TYPE_FRONTEND);
>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 01b41eb0f1..cd40fe2de1 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -204,7 +204,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, cons=
t
> uint8_t *config)
>      int ret;
>
>      ret =3D vhost_dev_set_config(&s->dev, s->config, 0, s->config_size,
> -                               VHOST_SET_CONFIG_TYPE_MASTER);
> +                               VHOST_SET_CONFIG_TYPE_FRONTEND);
>      if (ret) {
>          error_report("set device config space failed");
>          return;
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 74a2a28663..55e7b100f3 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -123,13 +123,13 @@ typedef enum VhostUserRequest {
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> -typedef enum VhostUserSlaveRequest {
> +typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_NONE =3D 0,
>      VHOST_USER_BACKEND_IOTLB_MSG =3D 1,
>      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
>      VHOST_USER_BACKEND_MAX
> -}  VhostUserSlaveRequest;
> +}  VhostUserBackendRequest;
>
>  typedef struct VhostUserMemoryRegion {
>      uint64_t guest_phys_addr;
> @@ -233,8 +233,8 @@ struct vhost_user {
>      struct vhost_dev *dev;
>      /* Shared between vhost devs of the same virtio device */
>      VhostUserState *user;
> -    QIOChannel *slave_ioc;
> -    GSource *slave_src;
> +    QIOChannel *backend_ioc;
> +    GSource *backend_src;
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
>      uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOTS];
> @@ -1483,7 +1483,7 @@ static int vhost_user_reset_device(struct vhost_dev
> *dev)
>      return vhost_user_write(dev, &msg, NULL, 0);
>  }
>
> -static int vhost_user_slave_handle_config_change(struct vhost_dev *dev)
> +static int vhost_user_backend_handle_config_change(struct vhost_dev *dev=
)
>  {
>      if (!dev->config_ops || !dev->config_ops->vhost_dev_config_notifier)=
 {
>          return -ENOSYS;
> @@ -1520,7 +1520,7 @@ static VhostUserHostNotifier
> *fetch_or_create_notifier(VhostUserState *u,
>      return n;
>  }
>
> -static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev
> *dev,
> +static int vhost_user_backend_handle_vring_host_notifier(struct vhost_de=
v
> *dev,
>                                                         VhostUserVringAre=
a
> *area,
>                                                         int fd)
>  {
> @@ -1582,16 +1582,16 @@ static int
> vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
>      return 0;
>  }
>
> -static void close_slave_channel(struct vhost_user *u)
> +static void close_backend_channel(struct vhost_user *u)
>  {
> -    g_source_destroy(u->slave_src);
> -    g_source_unref(u->slave_src);
> -    u->slave_src =3D NULL;
> -    object_unref(OBJECT(u->slave_ioc));
> -    u->slave_ioc =3D NULL;
> +    g_source_destroy(u->backend_src);
> +    g_source_unref(u->backend_src);
> +    u->backend_src =3D NULL;
> +    object_unref(OBJECT(u->backend_ioc));
> +    u->backend_ioc =3D NULL;
>  }
>
> -static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
> +static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>                             gpointer opaque)
>  {
>      struct vhost_dev *dev =3D opaque;
> @@ -1633,10 +1633,10 @@ static gboolean slave_read(QIOChannel *ioc,
> GIOCondition condition,
>          ret =3D vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
>          break;
>      case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:
> -        ret =3D vhost_user_slave_handle_config_change(dev);
> +        ret =3D vhost_user_backend_handle_config_change(dev);
>          break;
>      case VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG:
> -        ret =3D vhost_user_slave_handle_vring_host_notifier(dev,
> &payload.area,
> +        ret =3D vhost_user_backend_handle_vring_host_notifier(dev,
> &payload.area,
>                                                            fd ? fd[0] :
> -1);
>          break;
>      default:
> @@ -1672,7 +1672,7 @@ static gboolean slave_read(QIOChannel *ioc,
> GIOCondition condition,
>      goto fdcleanup;
>
>  err:
> -    close_slave_channel(u);
> +    close_backend_channel(u);
>      rc =3D G_SOURCE_REMOVE;
>
>  fdcleanup:
> @@ -1684,7 +1684,7 @@ fdcleanup:
>      return rc;
>  }
>
> -static int vhost_setup_slave_channel(struct vhost_dev *dev)
> +static int vhost_setup_backend_channel(struct vhost_dev *dev)
>  {
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_BACKEND_REQ_FD,
> @@ -1713,10 +1713,10 @@ static int vhost_setup_slave_channel(struct
> vhost_dev *dev)
>          error_report_err(local_err);
>          return -ECONNREFUSED;
>      }
> -    u->slave_ioc =3D ioc;
> -    u->slave_src =3D qio_channel_add_watch_source(u->slave_ioc,
> +    u->backend_ioc =3D ioc;
> +    u->backend_src =3D qio_channel_add_watch_source(u->backend_ioc,
>                                                  G_IO_IN | G_IO_HUP,
> -                                                slave_read, dev, NULL,
> NULL);
> +                                                backend_read, dev, NULL,
> NULL);
>
>      if (reply_supported) {
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> @@ -1734,7 +1734,7 @@ static int vhost_setup_slave_channel(struct
> vhost_dev *dev)
>  out:
>      close(sv[1]);
>      if (ret) {
> -        close_slave_channel(u);
> +        close_backend_channel(u);
>      }
>
>      return ret;
> @@ -2060,7 +2060,7 @@ static int vhost_user_backend_init(struct vhost_dev
> *dev, void *opaque,
>                   virtio_has_feature(dev->protocol_features,
>                      VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
>              error_setg(errp, "IOMMU support requires reply-ack and "
> -                       "slave-req protocol features.");
> +                       "backend-req protocol features.");
>              return -EINVAL;
>          }
>
> @@ -2096,7 +2096,7 @@ static int vhost_user_backend_init(struct vhost_dev
> *dev, void *opaque,
>      }
>
>      if (dev->vq_index =3D=3D 0) {
> -        err =3D vhost_setup_slave_channel(dev);
> +        err =3D vhost_setup_backend_channel(dev);
>          if (err < 0) {
>              error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
>              return -EPROTO;
> @@ -2126,8 +2126,8 @@ static int vhost_user_backend_cleanup(struct
> vhost_dev *dev)
>          close(u->postcopy_fd.fd);
>          u->postcopy_fd.handler =3D NULL;
>      }
> -    if (u->slave_ioc) {
> -        close_slave_channel(u);
> +    if (u->backend_ioc) {
> +        close_backend_channel(u);
>      }
>      g_free(u->region_rb);
>      u->region_rb =3D NULL;
> @@ -2223,7 +2223,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev
> *dev, uint16_t mtu)
>          return ret;
>      }
>
> -    /* If reply_ack supported, slave has to ack specified MTU is valid *=
/
> +    /* If reply_ack supported, backend has to ack specified MTU is valid
> */
>      if (reply_supported) {
>          return process_message_reply(dev, &msg);
>      }
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 3528fc628d..3d32dbec8d 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -117,7 +117,7 @@ static const qmp_virtio_feature_map_t
> vhost_user_protocol_map[] =3D {
>              "VHOST_USER_PROTOCOL_F_CONFIG: Vhost-user messaging for
> virtio "
>              "device configuration space supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \
> -            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Slave fd
> communication "
> +            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Backend fd
> communication "
>              "channel supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \
>              "VHOST_USER_PROTOCOL_F_HOST_NOTIFIER: Host notifiers for
> specified "
> diff --git a/include/hw/virtio/vhost-backend.h
> b/include/hw/virtio/vhost-backend.h
> index ec3fbae58d..31a251a9f5 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -22,7 +22,7 @@ typedef enum VhostBackendType {
>  } VhostBackendType;
>
>  typedef enum VhostSetConfigType {
> -    VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
> +    VHOST_SET_CONFIG_TYPE_FRONTEND =3D 0,
>      VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
>  } VhostSetConfigType;
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c
> b/subprojects/libvhost-user/libvhost-user.c
> index 8fb61e2df2..0469a50101 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -421,8 +421,8 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg
> *vmsg)
>  }
>
>  /*
> - * Processes a reply on the slave channel.
> - * Entered with slave_mutex held and releases it before exit.
> + * Processes a reply on the backend channel.
> + * Entered with backend_mutex held and releases it before exit.
>   * Returns true on success.
>   */
>  static bool
> @@ -436,7 +436,7 @@ vu_process_message_reply(VuDev *dev, const
> VhostUserMsg *vmsg)
>          goto out;
>      }
>
> -    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
> +    if (!vu_message_read_default(dev, dev->backend_fd, &msg_reply)) {
>          goto out;
>      }
>
> @@ -449,7 +449,7 @@ vu_process_message_reply(VuDev *dev, const
> VhostUserMsg *vmsg)
>      result =3D msg_reply.payload.u64 =3D=3D 0;
>
>  out:
> -    pthread_mutex_unlock(&dev->slave_mutex);
> +    pthread_mutex_unlock(&dev->backend_mutex);
>      return result;
>  }
>
> @@ -1393,13 +1393,13 @@ bool vu_set_queue_host_notifier(VuDev *dev,
> VuVirtq *vq, int fd,
>          return false;
>      }
>
> -    pthread_mutex_lock(&dev->slave_mutex);
> -    if (!vu_message_write(dev, dev->slave_fd, &vmsg)) {
> -        pthread_mutex_unlock(&dev->slave_mutex);
> +    pthread_mutex_lock(&dev->backend_mutex);
> +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> +        pthread_mutex_unlock(&dev->backend_mutex);
>          return false;
>      }
>
> -    /* Also unlocks the slave_mutex */
> +    /* Also unlocks the backend_mutex */
>      return vu_process_message_reply(dev, &vmsg);
>  }
>
> @@ -1463,7 +1463,7 @@ vu_get_protocol_features_exec(VuDev *dev,
> VhostUserMsg *vmsg)
>       * a device implementation can return it in its callback
>       * (get_protocol_features) if it wants to use this for
>       * simulation, but it is otherwise not desirable (if even
> -     * implemented by the master.)
> +     * implemented by the frontend.)
>       */
>      uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_MQ |
>                          1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
> @@ -1508,7 +1508,7 @@ vu_set_protocol_features_exec(VuDev *dev,
> VhostUserMsg *vmsg)
>           * of the other features are required.
>           * Theoretically, one could use only kick messages, or do them
> without
>           * having F_REPLY_ACK, but too many (possibly pending) messages
> on the
> -         * socket will eventually cause the master to hang, to avoid thi=
s
> in
> +         * socket will eventually cause the frontend to hang, to avoid
> this in
>           * scenarios where not desired enforce that the settings are in =
a
> way
>           * that actually enables the simulation case.
>           */
> @@ -1550,18 +1550,18 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg
> *vmsg)
>  }
>
>  static bool
> -vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
> +vu_set_backend_req_fd(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      if (vmsg->fd_num !=3D 1) {
> -        vu_panic(dev, "Invalid slave_req_fd message (%d fd's)",
> vmsg->fd_num);
> +        vu_panic(dev, "Invalid backend_req_fd message (%d fd's)",
> vmsg->fd_num);
>          return false;
>      }
>
> -    if (dev->slave_fd !=3D -1) {
> -        close(dev->slave_fd);
> +    if (dev->backend_fd !=3D -1) {
> +        close(dev->backend_fd);
>      }
> -    dev->slave_fd =3D vmsg->fds[0];
> -    DPRINT("Got slave_fd: %d\n", vmsg->fds[0]);
> +    dev->backend_fd =3D vmsg->fds[0];
> +    DPRINT("Got backend_fd: %d\n", vmsg->fds[0]);
>
>      return false;
>  }
> @@ -1577,7 +1577,7 @@ vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
>      }
>
>      if (ret) {
> -        /* resize to zero to indicate an error to master */
> +        /* resize to zero to indicate an error to frontend */
>          vmsg->size =3D 0;
>      }
>
> @@ -1917,7 +1917,7 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>      case VHOST_USER_SET_VRING_ENABLE:
>          return vu_set_vring_enable_exec(dev, vmsg);
>      case VHOST_USER_SET_BACKEND_REQ_FD:
> -        return vu_set_slave_req_fd(dev, vmsg);
> +        return vu_set_backend_req_fd(dev, vmsg);
>      case VHOST_USER_GET_CONFIG:
>          return vu_get_config(dev, vmsg);
>      case VHOST_USER_SET_CONFIG:
> @@ -2038,11 +2038,11 @@ vu_deinit(VuDev *dev)
>      }
>
>      vu_close_log(dev);
> -    if (dev->slave_fd !=3D -1) {
> -        close(dev->slave_fd);
> -        dev->slave_fd =3D -1;
> +    if (dev->backend_fd !=3D -1) {
> +        close(dev->backend_fd);
> +        dev->backend_fd =3D -1;
>      }
> -    pthread_mutex_destroy(&dev->slave_mutex);
> +    pthread_mutex_destroy(&dev->backend_mutex);
>
>      if (dev->sock !=3D -1) {
>          close(dev->sock);
> @@ -2080,8 +2080,8 @@ vu_init(VuDev *dev,
>      dev->remove_watch =3D remove_watch;
>      dev->iface =3D iface;
>      dev->log_call_fd =3D -1;
> -    pthread_mutex_init(&dev->slave_mutex, NULL);
> -    dev->slave_fd =3D -1;
> +    pthread_mutex_init(&dev->backend_mutex, NULL);
> +    dev->backend_fd =3D -1;
>      dev->max_queues =3D max_queues;
>
>      dev->vq =3D malloc(max_queues * sizeof(dev->vq[0]));
> @@ -2439,9 +2439,9 @@ static void _vu_queue_notify(VuDev *dev, VuVirtq
> *vq, bool sync)
>              vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>          }
>
> -        vu_message_write(dev, dev->slave_fd, &vmsg);
> +        vu_message_write(dev, dev->backend_fd, &vmsg);
>          if (ack) {
> -            vu_message_read_default(dev, dev->slave_fd, &vmsg);
> +            vu_message_read_default(dev, dev->backend_fd, &vmsg);
>          }
>          return;
>      }
> @@ -2468,7 +2468,7 @@ void vu_config_change_msg(VuDev *dev)
>          .flags =3D VHOST_USER_VERSION,
>      };
>
> -    vu_message_write(dev, dev->slave_fd, &vmsg);
> +    vu_message_write(dev, dev->backend_fd, &vmsg);
>  }
>
>  static inline void
> diff --git a/subprojects/libvhost-user/libvhost-user.h
> b/subprojects/libvhost-user/libvhost-user.h
> index 49208cceaa..708370c5f5 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -39,7 +39,7 @@
>  #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
>
>  typedef enum VhostSetConfigType {
> -    VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
> +    VHOST_SET_CONFIG_TYPE_FRONTEND =3D 0,
>      VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
>  } VhostSetConfigType;
>
> @@ -112,7 +112,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> -typedef enum VhostUserSlaveRequest {
> +typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_NONE =3D 0,
>      VHOST_USER_BACKEND_IOTLB_MSG =3D 1,
>      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,
> @@ -120,7 +120,7 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_BACKEND_VRING_CALL =3D 4,
>      VHOST_USER_BACKEND_VRING_ERR =3D 5,
>      VHOST_USER_BACKEND_MAX
> -}  VhostUserSlaveRequest;
> +}  VhostUserBackendRequest;
>
>  typedef struct VhostUserMemoryRegion {
>      uint64_t guest_phys_addr;
> @@ -296,8 +296,10 @@ typedef struct VuVirtqInflight {
>       * Zero value indicates a vm reset happened. */
>      uint16_t version;
>
> -    /* The size of VuDescStateSplit array. It's equal to the virtqueue
> -     * size. Slave could get it from queue size field of
> VhostUserInflight. */
> +    /*
> +     * The size of VuDescStateSplit array. It's equal to the virtqueue
> size.
> +     * Backend could get it from queue size field of VhostUserInflight.
> +     */
>      uint16_t desc_num;
>
>      /* The head of list that track the last batch of used descriptors. *=
/
> @@ -384,9 +386,9 @@ struct VuDev {
>      VuVirtq *vq;
>      VuDevInflightInfo inflight_info;
>      int log_call_fd;
> -    /* Must be held while using slave_fd */
> -    pthread_mutex_t slave_mutex;
> -    int slave_fd;
> +    /* Must be held while using backend_fd */
> +    pthread_mutex_t backend_mutex;
> +    int backend_fd;
>      uint64_t log_size;
>      uint8_t *log_table;
>      uint64_t features;
> @@ -445,7 +447,7 @@ typedef struct VuVirtqElement {
>   * vu_init:
>   * @dev: a VuDev context
>   * @max_queues: maximum number of virtqueues
> - * @socket: the socket connected to vhost-user master
> + * @socket: the socket connected to vhost-user frontend
>   * @panic: a panic callback
>   * @set_watch: a set_watch callback
>   * @remove_watch: a remove_watch callback
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d4061c05fdfee889
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 13, 2023 at 10:09=E2=80=
=AFAM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.=
org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Slave/master nomenclature was replaced w=
ith backend/frontend in commit<br>
<br>
1fc19b65279a246083fc4d918510aae68586f734<br>
vhost-user: Adopt new backend naming<br>
<br>
This patch replaces all remaining uses of master and slave in the<br>
codebase.<br>
<br>
Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidia=
nakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<=
br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt=
;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com=
</a>&gt;</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
=C2=A0block/export/vhost-user-blk-server.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-=
<br>
=C2=A0contrib/vhost-user-blk/vhost-user-blk.c=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/block/vhost-user-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/input/vhost-user-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
=C2=A0hw/virtio/vdpa-dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 52 +++++++++++-----------<br>
=C2=A0hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0include/hw/virtio/vhost-backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c | 54 +++++++++++-----------=
-<br>
=C2=A0subprojects/libvhost-user/libvhost-user.h | 20 +++++----<br>
=C2=A012 files changed, 74 insertions(+), 72 deletions(-)<br>
<br>
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user=
-blk-server.c<br>
index 81b59761e3..f7b5073605 100644<br>
--- a/block/export/vhost-user-blk-server.c<br>
+++ b/block/export/vhost-user-blk-server.c<br>
@@ -167,7 +167,7 @@ vu_blk_set_config(VuDev *vu_dev, const uint8_t *data,<b=
r>
=C2=A0 =C2=A0 =C2=A0uint8_t wce;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* don&#39;t support live migration */<br>
-=C2=A0 =C2=A0 if (flags !=3D VHOST_SET_CONFIG_TYPE_MASTER) {<br>
+=C2=A0 =C2=A0 if (flags !=3D VHOST_SET_CONFIG_TYPE_FRONTEND) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-b=
lk/vhost-user-blk.c<br>
index 7941694e53..89e5f11a64 100644<br>
--- a/contrib/vhost-user-blk/vhost-user-blk.c<br>
+++ b/contrib/vhost-user-blk/vhost-user-blk.c<br>
@@ -421,7 +421,7 @@ vub_set_config(VuDev *vu_dev, const uint8_t *data,<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* don&#39;t support live migration */<br>
-=C2=A0 =C2=A0 if (flags !=3D VHOST_SET_CONFIG_TYPE_MASTER) {<br>
+=C2=A0 =C2=A0 if (flags !=3D VHOST_SET_CONFIG_TYPE_FRONTEND) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c<br>
index aff4d2b8cb..eecf3f7a81 100644<br>
--- a/hw/block/vhost-user-blk.c<br>
+++ b/hw/block/vhost-user-blk.c<br>
@@ -81,7 +81,7 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev,=
 const uint8_t *config)<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vhost_dev_set_config(&amp;s-&gt;dev, &amp;blkcf=
g-&gt;wce,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offsetof(struct virtio_blk_config, w=
ce),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(blkcfg-&gt;wce),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MASTER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;set device config spac=
e failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c<br>
index 1386e869e5..15f9d99d09 100644<br>
--- a/hw/display/vhost-user-gpu.c<br>
+++ b/hw/display/vhost-user-gpu.c<br>
@@ -452,7 +452,7 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vhost_dev_set_config(&amp;g-&gt;vhost-&gt;dev, =
config_data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, sizeof(struct virtio_gpu_config),=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MASTER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;vhost-user-gpu: set de=
vice config space failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c<br>
index 1352e372ff..4ee3542106 100644<br>
--- a/hw/input/vhost-user-input.c<br>
+++ b/hw/input/vhost-user-input.c<br>
@@ -69,7 +69,7 @@ static void vhost_input_set_config(VirtIODevice *vdev,<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vhost_dev_set_config(&amp;vhi-&gt;vhost-&gt;dev=
, config_data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, sizeof(virtio_input_config),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MASTER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;vhost-user-input: set =
device config space failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index 6df6b7329d..75d7b89cd2 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -211,7 +211,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, c=
onst uint8_t *config)<br>
=C2=A0 =C2=A0 =C2=A0if (nc-&gt;peer &amp;&amp; nc-&gt;peer-&gt;info-&gt;typ=
e =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_set_config(get_vhost_net(nc-&gt=
;peer),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint8_t *)&amp;netcfg, 0, n-&gt;config_siz=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MASTER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -3733,7 +3733,7 @@ static void virtio_net_device_realize(DeviceState *de=
v, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_net_config netcfg =3D {};<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;netcfg.mac, &amp;n-&gt;nic_co=
nf.macaddr, ETH_ALEN);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_set_config(get_vhost_net(nc-&gt=
;peer),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint8_t *)&amp;netcfg, 0, ETH_A=
LEN, VHOST_SET_CONFIG_TYPE_MASTER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint8_t *)&amp;netcfg, 0, ETH_A=
LEN, VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;n-&gt;rsc_chains);<br>
=C2=A0 =C2=A0 =C2=A0n-&gt;qdev =3D dev;<br>
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c<br>
index 01b41eb0f1..cd40fe2de1 100644<br>
--- a/hw/virtio/vdpa-dev.c<br>
+++ b/hw/virtio/vdpa-dev.c<br>
@@ -204,7 +204,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, const =
uint8_t *config)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vhost_dev_set_config(&amp;s-&gt;dev, s-&gt;conf=
ig, 0, s-&gt;config_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MASTER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;set device config spac=
e failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 74a2a28663..55e7b100f3 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -123,13 +123,13 @@ typedef enum VhostUserRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_MAX<br>
=C2=A0} VhostUserRequest;<br>
<br>
-typedef enum VhostUserSlaveRequest {<br>
+typedef enum VhostUserBackendRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_NONE =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_IOTLB_MSG =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_MAX<br>
-}=C2=A0 VhostUserSlaveRequest;<br>
+}=C2=A0 VhostUserBackendRequest;<br>
<br>
=C2=A0typedef struct VhostUserMemoryRegion {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t guest_phys_addr;<br>
@@ -233,8 +233,8 @@ struct vhost_user {<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_dev *dev;<br>
=C2=A0 =C2=A0 =C2=A0/* Shared between vhost devs of the same virtio device =
*/<br>
=C2=A0 =C2=A0 =C2=A0VhostUserState *user;<br>
-=C2=A0 =C2=A0 QIOChannel *slave_ioc;<br>
-=C2=A0 =C2=A0 GSource *slave_src;<br>
+=C2=A0 =C2=A0 QIOChannel *backend_ioc;<br>
+=C2=A0 =C2=A0 GSource *backend_src;<br>
=C2=A0 =C2=A0 =C2=A0NotifierWithReturn postcopy_notifier;<br>
=C2=A0 =C2=A0 =C2=A0struct PostCopyFD=C2=A0 postcopy_fd;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0postco=
py_client_bases[VHOST_USER_MAX_RAM_SLOTS];<br>
@@ -1483,7 +1483,7 @@ static int vhost_user_reset_device(struct vhost_dev *=
dev)<br>
=C2=A0 =C2=A0 =C2=A0return vhost_user_write(dev, &amp;msg, NULL, 0);<br>
=C2=A0}<br>
<br>
-static int vhost_user_slave_handle_config_change(struct vhost_dev *dev)<br=
>
+static int vhost_user_backend_handle_config_change(struct vhost_dev *dev)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (!dev-&gt;config_ops || !dev-&gt;config_ops-&gt;vhos=
t_dev_config_notifier) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOSYS;<br>
@@ -1520,7 +1520,7 @@ static VhostUserHostNotifier *fetch_or_create_notifie=
r(VhostUserState *u,<br>
=C2=A0 =C2=A0 =C2=A0return n;<br>
=C2=A0}<br>
<br>
-static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *d=
ev,<br>
+static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev =
*dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea *area,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd)<br>
=C2=A0{<br>
@@ -1582,16 +1582,16 @@ static int vhost_user_slave_handle_vring_host_notif=
ier(struct vhost_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void close_slave_channel(struct vhost_user *u)<br>
+static void close_backend_channel(struct vhost_user *u)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_source_destroy(u-&gt;slave_src);<br>
-=C2=A0 =C2=A0 g_source_unref(u-&gt;slave_src);<br>
-=C2=A0 =C2=A0 u-&gt;slave_src =3D NULL;<br>
-=C2=A0 =C2=A0 object_unref(OBJECT(u-&gt;slave_ioc));<br>
-=C2=A0 =C2=A0 u-&gt;slave_ioc =3D NULL;<br>
+=C2=A0 =C2=A0 g_source_destroy(u-&gt;backend_src);<br>
+=C2=A0 =C2=A0 g_source_unref(u-&gt;backend_src);<br>
+=C2=A0 =C2=A0 u-&gt;backend_src =3D NULL;<br>
+=C2=A0 =C2=A0 object_unref(OBJECT(u-&gt;backend_ioc));<br>
+=C2=A0 =C2=A0 u-&gt;backend_ioc =3D NULL;<br>
=C2=A0}<br>
<br>
-static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,<br>
+static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 gpointer opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_dev *dev =3D opaque;<br>
@@ -1633,10 +1633,10 @@ static gboolean slave_read(QIOChannel *ioc, GIOCond=
ition condition,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vhost_backend_handle_iotlb_msg(de=
v, &amp;payload.iotlb);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_slave_handle_config_change(=
dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_config_chang=
e(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_slave_handle_vring_host_not=
ifier(dev, &amp;payload.area,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_vring_host_n=
otifier(dev, &amp;payload.area,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd ? fd[0] : =
-1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
@@ -1672,7 +1672,7 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondit=
ion condition,<br>
=C2=A0 =C2=A0 =C2=A0goto fdcleanup;<br>
<br>
=C2=A0err:<br>
-=C2=A0 =C2=A0 close_slave_channel(u);<br>
+=C2=A0 =C2=A0 close_backend_channel(u);<br>
=C2=A0 =C2=A0 =C2=A0rc =3D G_SOURCE_REMOVE;<br>
<br>
=C2=A0fdcleanup:<br>
@@ -1684,7 +1684,7 @@ fdcleanup:<br>
=C2=A0 =C2=A0 =C2=A0return rc;<br>
=C2=A0}<br>
<br>
-static int vhost_setup_slave_channel(struct vhost_dev *dev)<br>
+static int vhost_setup_backend_channel(struct vhost_dev *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMsg msg =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.hdr.request =3D VHOST_USER_SET_BACKEND_R=
EQ_FD,<br>
@@ -1713,10 +1713,10 @@ static int vhost_setup_slave_channel(struct vhost_d=
ev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report_err(local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ECONNREFUSED;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 u-&gt;slave_ioc =3D ioc;<br>
-=C2=A0 =C2=A0 u-&gt;slave_src =3D qio_channel_add_watch_source(u-&gt;slave=
_ioc,<br>
+=C2=A0 =C2=A0 u-&gt;backend_ioc =3D ioc;<br>
+=C2=A0 =C2=A0 u-&gt;backend_src =3D qio_channel_add_watch_source(u-&gt;bac=
kend_ioc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0G_IO_IN | G_IO_HUP,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 slave_read, dev, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 backend_read, dev, NULL, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (reply_supported) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_=
MASK;<br>
@@ -1734,7 +1734,7 @@ static int vhost_setup_slave_channel(struct vhost_dev=
 *dev)<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0close(sv[1]);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close_slave_channel(u);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close_backend_channel(u);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
@@ -2060,7 +2060,7 @@ static int vhost_user_backend_init(struct vhost_dev *=
dev, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_has_f=
eature(dev-&gt;protocol_features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VHOST_USER_PROTOCOL_F_REPLY_ACK))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;IOMM=
U support requires reply-ack and &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;slave-req protocol features.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;backend-req protocol features.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2096,7 +2096,7 @@ static int vhost_user_backend_init(struct vhost_dev *=
dev, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dev-&gt;vq_index =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D vhost_setup_slave_channel(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D vhost_setup_backend_channel(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, EPRO=
TO, &quot;vhost_backend_init failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPROTO;<br>
@@ -2126,8 +2126,8 @@ static int vhost_user_backend_cleanup(struct vhost_de=
v *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(u-&gt;postcopy_fd.fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u-&gt;postcopy_fd.handler =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (u-&gt;slave_ioc) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close_slave_channel(u);<br>
+=C2=A0 =C2=A0 if (u-&gt;backend_ioc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close_backend_channel(u);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_free(u-&gt;region_rb);<br>
=C2=A0 =C2=A0 =C2=A0u-&gt;region_rb =3D NULL;<br>
@@ -2223,7 +2223,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev *d=
ev, uint16_t mtu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* If reply_ack supported, slave has to ack specified MTU is=
 valid */<br>
+=C2=A0 =C2=A0 /* If reply_ack supported, backend has to ack specified MTU =
is valid */<br>
=C2=A0 =C2=A0 =C2=A0if (reply_supported) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return process_message_reply(dev, &amp;ms=
g);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c<br>
index 3528fc628d..3d32dbec8d 100644<br>
--- a/hw/virtio/virtio-qmp.c<br>
+++ b/hw/virtio/virtio-qmp.c<br>
@@ -117,7 +117,7 @@ static const qmp_virtio_feature_map_t vhost_user_protoc=
ol_map[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;VHOST_USER_PROTOCOL_F=
_CONFIG: Vhost-user messaging for virtio &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;device configuration =
space supported&quot;),<br>
=C2=A0 =C2=A0 =C2=A0FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VHOST_USER_PROTOCOL_F_BACK=
END_SEND_FD: Slave fd communication &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VHOST_USER_PROTOCOL_F_BACK=
END_SEND_FD: Backend fd communication &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;channel supported&quo=
t;),<br>
=C2=A0 =C2=A0 =C2=A0FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;VHOST_USER_PROTOCOL_F=
_HOST_NOTIFIER: Host notifiers for specified &quot;<br>
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-ba=
ckend.h<br>
index ec3fbae58d..31a251a9f5 100644<br>
--- a/include/hw/virtio/vhost-backend.h<br>
+++ b/include/hw/virtio/vhost-backend.h<br>
@@ -22,7 +22,7 @@ typedef enum VhostBackendType {<br>
=C2=A0} VhostBackendType;<br>
<br>
=C2=A0typedef enum VhostSetConfigType {<br>
-=C2=A0 =C2=A0 VHOST_SET_CONFIG_TYPE_MASTER =3D 0,<br>
+=C2=A0 =C2=A0 VHOST_SET_CONFIG_TYPE_FRONTEND =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,<br>
=C2=A0} VhostSetConfigType;<br>
<br>
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvho=
st-user/libvhost-user.c<br>
index 8fb61e2df2..0469a50101 100644<br>
--- a/subprojects/libvhost-user/libvhost-user.c<br>
+++ b/subprojects/libvhost-user/libvhost-user.c<br>
@@ -421,8 +421,8 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vm=
sg)<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
- * Processes a reply on the slave channel.<br>
- * Entered with slave_mutex held and releases it before exit.<br>
+ * Processes a reply on the backend channel.<br>
+ * Entered with backend_mutex held and releases it before exit.<br>
=C2=A0 * Returns true on success.<br>
=C2=A0 */<br>
=C2=A0static bool<br>
@@ -436,7 +436,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg=
 *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!vu_message_read_default(dev, dev-&gt;slave_fd, &amp;msg=
_reply)) {<br>
+=C2=A0 =C2=A0 if (!vu_message_read_default(dev, dev-&gt;backend_fd, &amp;m=
sg_reply)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -449,7 +449,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg=
 *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0result =3D msg_reply.payload.u64 =3D=3D 0;<br>
<br>
=C2=A0out:<br>
-=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;slave_mutex);<br>
+=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;backend_mutex);<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
<br>
@@ -1393,13 +1393,13 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq=
 *vq, int fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;slave_mutex);<br>
-=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;slave_fd, &amp;vmsg)) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;slave_mutex)=
;<br>
+=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;backend_mutex);<br>
+=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;backend_fd, &amp;vmsg)) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;backend_mute=
x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* Also unlocks the slave_mutex */<br>
+=C2=A0 =C2=A0 /* Also unlocks the backend_mutex */<br>
=C2=A0 =C2=A0 =C2=A0return vu_process_message_reply(dev, &amp;vmsg);<br>
=C2=A0}<br>
<br>
@@ -1463,7 +1463,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMs=
g *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0 * a device implementation can return it in its callbac=
k<br>
=C2=A0 =C2=A0 =C2=A0 * (get_protocol_features) if it wants to use this for<=
br>
=C2=A0 =C2=A0 =C2=A0 * simulation, but it is otherwise not desirable (if ev=
en<br>
-=C2=A0 =C2=A0 =C2=A0* implemented by the master.)<br>
+=C2=A0 =C2=A0 =C2=A0* implemented by the frontend.)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t features =3D 1ULL &lt;&lt; VHOST_USER_PROTOCOL=
_F_MQ |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A01ULL &lt;&lt; VHOST_USER_PROTOCOL_F_LOG_SHMFD |<br>
@@ -1508,7 +1508,7 @@ vu_set_protocol_features_exec(VuDev *dev, VhostUserMs=
g *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * of the other features are required.<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Theoretically, one could use only kick=
 messages, or do them without<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * having F_REPLY_ACK, but too many (poss=
ibly pending) messages on the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* socket will eventually cause the maste=
r to hang, to avoid this in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* socket will eventually cause the front=
end to hang, to avoid this in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * scenarios where not desired enforce th=
at the settings are in a way<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * that actually enables the simulation c=
ase.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
@@ -1550,18 +1550,18 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *=
vmsg)<br>
=C2=A0}<br>
<br>
=C2=A0static bool<br>
-vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)<br>
+vu_set_backend_req_fd(VuDev *dev, VhostUserMsg *vmsg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (vmsg-&gt;fd_num !=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Invalid slave_req_fd messa=
ge (%d fd&#39;s)&quot;, vmsg-&gt;fd_num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Invalid backend_req_fd mes=
sage (%d fd&#39;s)&quot;, vmsg-&gt;fd_num);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (dev-&gt;slave_fd !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(dev-&gt;slave_fd);<br>
+=C2=A0 =C2=A0 if (dev-&gt;backend_fd !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(dev-&gt;backend_fd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 dev-&gt;slave_fd =3D vmsg-&gt;fds[0];<br>
-=C2=A0 =C2=A0 DPRINT(&quot;Got slave_fd: %d\n&quot;, vmsg-&gt;fds[0]);<br>
+=C2=A0 =C2=A0 dev-&gt;backend_fd =3D vmsg-&gt;fds[0];<br>
+=C2=A0 =C2=A0 DPRINT(&quot;Got backend_fd: %d\n&quot;, vmsg-&gt;fds[0]);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
@@ -1577,7 +1577,7 @@ vu_get_config(VuDev *dev, VhostUserMsg *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* resize to zero to indicate an error to mast=
er */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* resize to zero to indicate an error to fron=
tend */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsg-&gt;size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1917,7 +1917,7 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)<br=
>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_SET_VRING_ENABLE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vu_set_vring_enable_exec(dev, vmsg=
);<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_SET_BACKEND_REQ_FD:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vu_set_slave_req_fd(dev, vmsg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vu_set_backend_req_fd(dev, vmsg);<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_GET_CONFIG:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vu_get_config(dev, vmsg);<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_SET_CONFIG:<br>
@@ -2038,11 +2038,11 @@ vu_deinit(VuDev *dev)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0vu_close_log(dev);<br>
-=C2=A0 =C2=A0 if (dev-&gt;slave_fd !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(dev-&gt;slave_fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;slave_fd =3D -1;<br>
+=C2=A0 =C2=A0 if (dev-&gt;backend_fd !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(dev-&gt;backend_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;backend_fd =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 pthread_mutex_destroy(&amp;dev-&gt;slave_mutex);<br>
+=C2=A0 =C2=A0 pthread_mutex_destroy(&amp;dev-&gt;backend_mutex);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dev-&gt;sock !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(dev-&gt;sock);<br>
@@ -2080,8 +2080,8 @@ vu_init(VuDev *dev,<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;remove_watch =3D remove_watch;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;iface =3D iface;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;log_call_fd =3D -1;<br>
-=C2=A0 =C2=A0 pthread_mutex_init(&amp;dev-&gt;slave_mutex, NULL);<br>
-=C2=A0 =C2=A0 dev-&gt;slave_fd =3D -1;<br>
+=C2=A0 =C2=A0 pthread_mutex_init(&amp;dev-&gt;backend_mutex, NULL);<br>
+=C2=A0 =C2=A0 dev-&gt;backend_fd =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;max_queues =3D max_queues;<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;vq =3D malloc(max_queues * sizeof(dev-&gt;vq[0]=
));<br>
@@ -2439,9 +2439,9 @@ static void _vu_queue_notify(VuDev *dev, VuVirtq *vq,=
 bool sync)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsg.flags |=3D VHOST_USER_=
NEED_REPLY_MASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_message_write(dev, dev-&gt;slave_fd, &amp;v=
msg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_message_write(dev, dev-&gt;backend_fd, &amp=
;vmsg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ack) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_message_read_default(dev, dev=
-&gt;slave_fd, &amp;vmsg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_message_read_default(dev, dev=
-&gt;backend_fd, &amp;vmsg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -2468,7 +2468,7 @@ void vu_config_change_msg(VuDev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D VHOST_USER_VERSION,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 vu_message_write(dev, dev-&gt;slave_fd, &amp;vmsg);<br>
+=C2=A0 =C2=A0 vu_message_write(dev, dev-&gt;backend_fd, &amp;vmsg);<br>
=C2=A0}<br>
<br>
=C2=A0static inline void<br>
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvho=
st-user/libvhost-user.h<br>
index 49208cceaa..708370c5f5 100644<br>
--- a/subprojects/libvhost-user/libvhost-user.h<br>
+++ b/subprojects/libvhost-user/libvhost-user.h<br>
@@ -39,7 +39,7 @@<br>
=C2=A0#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)<br>
<br>
=C2=A0typedef enum VhostSetConfigType {<br>
-=C2=A0 =C2=A0 VHOST_SET_CONFIG_TYPE_MASTER =3D 0,<br>
+=C2=A0 =C2=A0 VHOST_SET_CONFIG_TYPE_FRONTEND =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,<br>
=C2=A0} VhostSetConfigType;<br>
<br>
@@ -112,7 +112,7 @@ typedef enum VhostUserRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_MAX<br>
=C2=A0} VhostUserRequest;<br>
<br>
-typedef enum VhostUserSlaveRequest {<br>
+typedef enum VhostUserBackendRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_NONE =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_IOTLB_MSG =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,<br>
@@ -120,7 +120,7 @@ typedef enum VhostUserSlaveRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_CALL =3D 4,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_ERR =3D 5,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_MAX<br>
-}=C2=A0 VhostUserSlaveRequest;<br>
+}=C2=A0 VhostUserBackendRequest;<br>
<br>
=C2=A0typedef struct VhostUserMemoryRegion {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t guest_phys_addr;<br>
@@ -296,8 +296,10 @@ typedef struct VuVirtqInflight {<br>
=C2=A0 =C2=A0 =C2=A0 * Zero value indicates a vm reset happened. */<br>
=C2=A0 =C2=A0 =C2=A0uint16_t version;<br>
<br>
-=C2=A0 =C2=A0 /* The size of VuDescStateSplit array. It&#39;s equal to the=
 virtqueue<br>
-=C2=A0 =C2=A0 =C2=A0* size. Slave could get it from queue size field of Vh=
ostUserInflight. */<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The size of VuDescStateSplit array. It&#39;s equal t=
o the virtqueue size.<br>
+=C2=A0 =C2=A0 =C2=A0* Backend could get it from queue size field of VhostU=
serInflight.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0uint16_t desc_num;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The head of list that track the last batch of used d=
escriptors. */<br>
@@ -384,9 +386,9 @@ struct VuDev {<br>
=C2=A0 =C2=A0 =C2=A0VuVirtq *vq;<br>
=C2=A0 =C2=A0 =C2=A0VuDevInflightInfo inflight_info;<br>
=C2=A0 =C2=A0 =C2=A0int log_call_fd;<br>
-=C2=A0 =C2=A0 /* Must be held while using slave_fd */<br>
-=C2=A0 =C2=A0 pthread_mutex_t slave_mutex;<br>
-=C2=A0 =C2=A0 int slave_fd;<br>
+=C2=A0 =C2=A0 /* Must be held while using backend_fd */<br>
+=C2=A0 =C2=A0 pthread_mutex_t backend_mutex;<br>
+=C2=A0 =C2=A0 int backend_fd;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t log_size;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *log_table;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t features;<br>
@@ -445,7 +447,7 @@ typedef struct VuVirtqElement {<br>
=C2=A0 * vu_init:<br>
=C2=A0 * @dev: a VuDev context<br>
=C2=A0 * @max_queues: maximum number of virtqueues<br>
- * @socket: the socket connected to vhost-user master<br>
+ * @socket: the socket connected to vhost-user frontend<br>
=C2=A0 * @panic: a panic callback<br>
=C2=A0 * @set_watch: a set_watch callback<br>
=C2=A0 * @remove_watch: a remove_watch callback<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d4061c05fdfee889--

