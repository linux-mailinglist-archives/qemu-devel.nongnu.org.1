Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE77A5D3B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:02:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWbA-00021P-PR; Tue, 19 Sep 2023 05:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiWas-00020u-9s
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:00:30 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiWah-0002th-QX
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:00:28 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-414e78cdc11so36133471cf.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695114017; x=1695718817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ljUCYYbuP9GpQhL89E8rsAlwqC0CQjTBtsNR7rOlS4=;
 b=fBCIvB9hdI0hY0tz7eV01n0wmMm4zpNJuK/xXhdF+xE29N2PMeyZRiRC7WH1TBycTb
 1U0InN+CSe+mdehoJBAMbrhYpt4EOFk37AOa3PHTgkkVxF1NCKzvr1MbAU59oVY8Wbse
 03zCptGL0I1EvDX07xcK5Aj4tyjU5lmBT11kmLex0uqnctPycThMQnr4Zb/GCKS4s+2Y
 JxEthQ6eKP+uma+QYOxU60rGKGhjd2aP83J7/vaMcEulZMaWoYzI8shUAaUBA9oKO8v/
 M/aTo+j9JmEthFbr2gDXL7js58RtTlgv4Y2ow8eZ5+pK1C8iWhaci4HwUGw1+QCEouZU
 +p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695114017; x=1695718817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ljUCYYbuP9GpQhL89E8rsAlwqC0CQjTBtsNR7rOlS4=;
 b=kInDnaijlC3zXvDbO14jpxkjy5cZT4jwMxM3UG/NnDZBhpwjGz/7u0UTyhBj9NruXx
 EhXyAtSwB3rBIGfN1S+faI4/6x0L7TPTcoCP3YlIAAA/N9pP4t3PzncLSr+sTTSQ6PTf
 PNowWKYW6OQLU+j2XoIrURp0gMTECrhAgvKyvXvNbO5+lqjSLb4XIksZq73LrDW0T5VA
 wKw05cNLTkpNOdzma43Pk1Cs0ILn/6IKxdggkYNc12d6PXmaaQpvs66ClkdDc8dTQZIw
 PHEgOSfVqoV3d+46QqeQ/UORPQbXS2dE6knBzmMoD2xssJE+Yz653npnRhrKldxGDtHa
 NO/g==
X-Gm-Message-State: AOJu0YzYMvPc+SdxFlsNi8TopvLO83b8i19qzsAKOLlz3qepXNCG0XDI
 PR5j9xwyo+un4m82VNPzwZSk02Y09tbHqQHGPgg=
X-Google-Smtp-Source: AGHT+IEaBC1F65blzpdWd0FLl2Y5hAU4s78EGX/exwZyKoRZhM/z/O5rPWzQCUjCKIZXg6l7uoGlPc0WejaryGV1e4E=
X-Received: by 2002:ac8:5710:0:b0:412:21f4:6f9e with SMTP id
 16-20020ac85710000000b0041221f46f9emr16522087qtw.40.1695114017154; Tue, 19
 Sep 2023 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-11-ray.huang@amd.com>
In-Reply-To: <20230915111130.24064-11-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2023 13:00:05 +0400
Message-ID: <CAJ+F1C+aWM+TeoLxEqYqsMUow53rEBGc_qJwNS2pU2T5D2J+xQ@mail.gmail.com>
Subject: Re: [QEMU PATCH v5 10/13] virtio-gpu: Resource UUID
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, ernunes@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Fri, Sep 15, 2023 at 3:14=E2=80=AFPM Huang Rui <ray.huang@amd.com> wrote=
:
>
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
> Enable resource UUID feature and implement command resource assign UUID.
> This is done by introducing a hash table to map resource IDs to their
> UUIDs.
>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> V4 -> V5:
>     - Add virtio migration handling for uuid (Akihiko)
>     - Adjust sequence to allocate gpu resource before virglrender resourc=
e
>       creation (Akihiko)
>     - Clean up (Akihiko)
>
>  hw/display/trace-events        |  1 +
>  hw/display/virtio-gpu-base.c   |  2 ++
>  hw/display/virtio-gpu-virgl.c  | 21 ++++++++++++
>  hw/display/virtio-gpu.c        | 58 ++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-gpu.h |  6 ++++
>  5 files changed, 88 insertions(+)
>
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 2336a0ca15..54d6894c59 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -41,6 +41,7 @@ virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t s=
ize) "res 0x%x, size %" P
>  virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
>  virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
>  virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
> +virtio_gpu_cmd_res_assign_uuid(uint32_t res) "res 0x%x"
>  virtio_gpu_cmd_res_xfer_toh_2d(uint32_t res) "res 0x%x"
>  virtio_gpu_cmd_res_xfer_toh_3d(uint32_t res) "res 0x%x"
>  virtio_gpu_cmd_res_xfer_fromh_3d(uint32_t res) "res 0x%x"
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 4f2b0ba1f3..f44388715c 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -236,6 +236,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint=
64_t features,
>          features |=3D (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>      }
>
> +    features |=3D (1 << VIRTIO_GPU_F_RESOURCE_UUID);

This changes what is exposed to the guest. We should have an option
for it, and set it to false on older machine types (similar to what is
done for edid).

> +
>      return features;
>  }
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 563a6f2f58..8a017dbeb4 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -36,11 +36,20 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g=
,
>  {
>      struct virtio_gpu_resource_create_2d c2d;
>      struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_simple_resource *res;
>
>      VIRTIO_GPU_FILL_CMD(c2d);
>      trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
>                                         c2d.width, c2d.height);
>
> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {

needless OOM here too

> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +    res->resource_id =3D c2d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +
>      args.handle =3D c2d.resource_id;
>      args.target =3D 2;
>      args.format =3D c2d.format;
> @@ -60,11 +69,20 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g=
,
>  {
>      struct virtio_gpu_resource_create_3d c3d;
>      struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_simple_resource *res;
>
>      VIRTIO_GPU_FILL_CMD(c3d);
>      trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
>                                         c3d.width, c3d.height, c3d.depth)=
;
>
> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {

same

> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +    res->resource_id =3D c3d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +
>      args.handle =3D c3d.resource_id;
>      args.target =3D c3d.target;
>      args.format =3D c3d.format;
> @@ -682,6 +700,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>          /* TODO add security */
>          virgl_cmd_ctx_detach_resource(g, cmd);
>          break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID:
> +        virtio_gpu_resource_assign_uuid(g, cmd);
> +        break;
>      case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>          virgl_cmd_get_capset_info(g, cmd);
>          break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index cc4c1f81bb..44414c1c5e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -966,6 +966,38 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
>      virtio_gpu_cleanup_mapping(g, res);
>  }
>
> +void virtio_gpu_resource_assign_uuid(VirtIOGPU *g,
> +                                     struct virtio_gpu_ctrl_command *cmd=
)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_assign_uuid assign;
> +    struct virtio_gpu_resp_resource_uuid resp;
> +    QemuUUID *uuid;
> +
> +    VIRTIO_GPU_FILL_CMD(assign);
> +    virtio_gpu_bswap_32(&assign, sizeof(assign));
> +    trace_virtio_gpu_cmd_res_assign_uuid(assign.resource_id);
> +
> +    res =3D virtio_gpu_find_check_resource(g, assign.resource_id, false,=
 __func__, &cmd->error);
> +    if (!res) {
> +        return;
> +    }
> +
> +    memset(&resp, 0, sizeof(resp));
> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_RESOURCE_UUID;
> +
> +    uuid =3D g_hash_table_lookup(g->resource_uuids, GUINT_TO_POINTER(ass=
ign.resource_id));
> +    if (!uuid) {
> +        uuid =3D g_new(QemuUUID, 1);
> +        qemu_uuid_generate(uuid);
> +        g_hash_table_insert(g->resource_uuids, GUINT_TO_POINTER(assign.r=
esource_id), uuid);
> +        res->has_uuid =3D true;
> +    }
> +
> +    memcpy(resp.uuid, uuid, sizeof(QemuUUID));
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
>  void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>                                     struct virtio_gpu_ctrl_command *cmd)
>  {
> @@ -1014,6 +1046,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>      case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>          virtio_gpu_resource_detach_backing(g, cmd);
>          break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID:
> +        virtio_gpu_resource_assign_uuid(g, cmd);
> +        break;
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> @@ -1208,6 +1243,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaqu=
e, size_t size,
>      VirtIOGPU *g =3D opaque;
>      struct virtio_gpu_simple_resource *res;
>      int i;
> +    QemuUUID *uuid;
>
>      /* in 2d mode we should never find unprocessed commands here */
>      assert(QTAILQ_EMPTY(&g->cmdq));
> @@ -1224,9 +1260,17 @@ static int virtio_gpu_save(QEMUFile *f, void *opaq=
ue, size_t size,
>          }
>          qemu_put_buffer(f, (void *)pixman_image_get_data(res->image),
>                          pixman_image_get_stride(res->image) * res->heigh=
t);
> +
> +        qemu_put_byte(f, res->has_uuid);
> +        if (res->has_uuid) {
> +            uuid =3D g_hash_table_lookup(g->resource_uuids, GUINT_TO_POI=
NTER(res->resource_id));
> +            qemu_put_buffer(f, (void *)uuid, sizeof(QemuUUID));
> +        }

This is breaking the migration format. It will need to be handled with
an optional subsection instead.

>      }
>      qemu_put_be32(f, 0); /* end of list */
>
> +    g_hash_table_destroy(g->resource_uuids);
> +
>      return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
>  }
>
> @@ -1239,9 +1283,12 @@ static int virtio_gpu_load(QEMUFile *f, void *opaq=
ue, size_t size,
>      uint32_t resource_id, pformat;
>      void *bits =3D NULL;
>      int i;
> +    QemuUUID *uuid =3D NULL;
>
>      g->hostmem =3D 0;
>
> +    g->resource_uuids =3D g_hash_table_new_full(NULL, NULL, NULL, g_free=
);

Since it maps int -> uuid, it should probably use g_int_hash() /
g_int_qual() instead of the default (g_direct_hash()).

> +
>      resource_id =3D qemu_get_be32(f);
>      while (resource_id !=3D 0) {
>          res =3D virtio_gpu_find_resource(g, resource_id);
> @@ -1292,6 +1339,12 @@ static int virtio_gpu_load(QEMUFile *f, void *opaq=
ue, size_t size,
>          qemu_get_buffer(f, (void *)pixman_image_get_data(res->image),
>                          pixman_image_get_stride(res->image) * res->heigh=
t);
>
> +        res->has_uuid =3D qemu_get_byte(f);
> +        if (res->has_uuid) {
> +            qemu_get_buffer(f, (void *)uuid, sizeof(QemuUUID));
> +            g_hash_table_insert(g->resource_uuids, GUINT_TO_POINTER(res-=
>resource_id), uuid);
> +        }
> +
>          /* restore mapping */
>          for (i =3D 0; i < res->iov_cnt; i++) {
>              hwaddr len =3D res->iov[i].iov_len;
> @@ -1393,12 +1446,15 @@ void virtio_gpu_device_realize(DeviceState *qdev,=
 Error **errp)
>      QTAILQ_INIT(&g->reslist);
>      QTAILQ_INIT(&g->cmdq);
>      QTAILQ_INIT(&g->fenceq);
> +
> +    g->resource_uuids =3D g_hash_table_new_full(NULL, NULL, NULL, g_free=
);
>  }
>
>  static void virtio_gpu_device_unrealize(DeviceState *qdev)
>  {
>      VirtIOGPU *g =3D VIRTIO_GPU(qdev);
>
> +    g_hash_table_destroy(g->resource_uuids);
>      g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
>      g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
>      g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> @@ -1452,6 +1508,8 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>          g_free(cmd);
>      }
>
> +    g_hash_table_remove_all(g->resource_uuids);
> +
>      virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>  }
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index b9adc28071..67b39fccec 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -63,6 +63,8 @@ struct virtio_gpu_simple_resource {
>      MemoryRegion *region;
>  #endif
>
> +    bool has_uuid;
> +
>      QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
>  };
>
> @@ -208,6 +210,8 @@ struct VirtIOGPU {
>          QTAILQ_HEAD(, VGPUDMABuf) bufs;
>          VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
>      } dmabuf;
> +
> +    GHashTable *resource_uuids;
>  };
>
>  struct VirtIOGPUClass {
> @@ -285,6 +289,8 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
>                                      struct iovec *iov, uint32_t count);
>  void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>                                  struct virtio_gpu_simple_resource *res);
> +void virtio_gpu_resource_assign_uuid(VirtIOGPU *g,
> +                                     struct virtio_gpu_ctrl_command *cmd=
);
>  void virtio_gpu_process_cmdq(VirtIOGPU *g);
>  void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
>  void virtio_gpu_reset(VirtIODevice *vdev);
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

