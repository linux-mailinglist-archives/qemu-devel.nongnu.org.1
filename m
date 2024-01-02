Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C4821C0D
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 13:51:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKeDl-0000ai-J1; Tue, 02 Jan 2024 07:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKeDh-0000aZ-VB
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:50:10 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKeDf-0002cn-Lg
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:50:09 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dbdb5e37f93so6279366276.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 04:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704199806; x=1704804606; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2n8zDne58pWS6ImjvSfvSCaO/MXEURGtI1qmUk0clk=;
 b=jZeRB/SJZAEBgLHsQlWjxBVtfvOeD7XHrPrvMOxwWNl8Osfax8tZAQwIEFr8pTxjhL
 VgErj9Q4uNe7mDjLsUjqIvxx5i1DkFY0ulhaOHDtKxF9yR1tFW2Z8QB7iUuMUImJ3ljC
 R0jnKL1mZxWVoMNidwqh0d+1gQMf6ppuxhWdZntOHOK9ZkTW8QPu5NBJ46wS0TDYeqBC
 7go8Df/iK0IIiH13/jKRYy5GyKxntJVjXzW75he1PVgf2CIqhl2STfcVniair3NhJIWL
 5E0HNbs2t1v50AbRkoLy6y2E6Q6BAPvT6tXTjf3nOatCESc1+kjxdnj2oFEQJW96iI9k
 PBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704199806; x=1704804606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2n8zDne58pWS6ImjvSfvSCaO/MXEURGtI1qmUk0clk=;
 b=fNTkE8gZKzahJLXbO3K5gHecKrIG1ATEgew9zjYN4zQeqev/suZr4X9l08ZhpFlS7B
 ypEFVW+6087Del0RFx+u1PoRdK3zbDQo8hjfyh7RbKqXiZCkYINV0G4yMolXzILp/lxQ
 PLKBOVSMTaupYGDBbCMpCAkyS0ubjn1C4u+4BAcjDif+dN3M7bvIntWtt3VauasI9zZg
 JopML2C5o4J30zrYHcQoN/WpMgchFXiUQaZRNzBMUKSxM3ImOSYBuJ4naZEtwJKdswFC
 1AXtw+H8Mkz0UlaadL3QR8pq+pr2kxsqqog0Je3XomicdD3WVdwe1OhucVW85NGtD1O/
 CDoA==
X-Gm-Message-State: AOJu0YyK3yzwzZjM/1Fgb0b/KqEcj+K2QEK4RVPXCdpWlNke+SxMkcTQ
 ahxLkeMuLTzYQI7+uChsK4dk7CsQ8kzQ3bc0nRo=
X-Google-Smtp-Source: AGHT+IGruFL6BYIztHmU1iipd9OJgk6z0yZHPlM2cQkgHMbKfbO0tj+ETwzjB0qD11EM0Q/JOHpeuTPJjvigPCccB7U=
X-Received: by 2002:a25:f823:0:b0:dbd:cf36:1e66 with SMTP id
 u35-20020a25f823000000b00dbdcf361e66mr9752503ybd.88.1704199806416; Tue, 02
 Jan 2024 04:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-9-ray.huang@amd.com>
In-Reply-To: <20231219075320.165227-9-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 16:49:54 +0400
Message-ID: <CAJ+F1C+NbeFkiGkN=JRifbs6QU2zyiMKUfQxA9KdonfFrL1CUg@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] virtio-gpu: Resource UUID
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Tue, Dec 19, 2023 at 11:55=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrot=
e:
>
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
> Enable resource UUID feature and implement command resource assign UUID.
> This is done by introducing a hash table to map resource IDs to their
> UUIDs.

I agree with Akihiko, what about putting QemuUUID in struct
virtio_gpu_simple_resource?

(I also doubt about the hash table usefulness, but I don't know
how/why the UUID is used)

>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> Changes in v6:
> - Set resource uuid as option.
> - Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state
>   or virtio live migration.
> - Use g_int_hash/g_int_equal instead of the default.
> - Move virtio_vgpu_simple_resource initialization in the earlier new patc=
h
>   "virtio-gpu: Introduce virgl_gpu_resource structure"
>
>  hw/display/trace-events        |   1 +
>  hw/display/virtio-gpu-base.c   |   4 ++
>  hw/display/virtio-gpu-virgl.c  |   3 +
>  hw/display/virtio-gpu.c        | 119 +++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-gpu.h |   7 ++
>  5 files changed, 134 insertions(+)
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
> index 37af256219..6bcee3882f 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -236,6 +236,10 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uin=
t64_t features,
>          features |=3D (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>      }
>
> +    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
> +        features |=3D (1 << VIRTIO_GPU_F_RESOURCE_UUID);
> +    }
> +
>      return features;
>  }
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 5a3a292f79..be9da6e780 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -777,6 +777,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
> index 8189c392dc..466debb256 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -958,6 +958,37 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
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
> +    uuid =3D g_hash_table_lookup(g->resource_uuids, &assign.resource_id)=
;
> +    if (!uuid) {
> +        uuid =3D g_new(QemuUUID, 1);
> +        qemu_uuid_generate(uuid);
> +        g_hash_table_insert(g->resource_uuids, &assign.resource_id, uuid=
);
> +    }
> +
> +    memcpy(resp.uuid, uuid, sizeof(QemuUUID));
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
>  void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>                                     struct virtio_gpu_ctrl_command *cmd)
>  {
> @@ -1006,6 +1037,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>      case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>          virtio_gpu_resource_detach_backing(g, cmd);
>          break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID:
> +        virtio_gpu_resource_assign_uuid(g, cmd);
> +        break;
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> @@ -1400,6 +1434,57 @@ static int virtio_gpu_blob_load(QEMUFile *f, void =
*opaque, size_t size,
>      return 0;
>  }
>
> +static int virtio_gpu_resource_uuid_save(QEMUFile *f, void *opaque, size=
_t size,
> +                                         const VMStateField *field,
> +                                         JSONWriter *vmdesc)
> +{
> +    VirtIOGPU *g =3D opaque;
> +    struct virtio_gpu_simple_resource *res;
> +    QemuUUID *uuid;
> +
> +    /* in 2d mode we should never find unprocessed commands here */
> +    assert(QTAILQ_EMPTY(&g->cmdq));
> +
> +    QTAILQ_FOREACH(res, &g->reslist, next) {
> +        qemu_put_be32(f, res->resource_id);
> +        uuid =3D g_hash_table_lookup(g->resource_uuids, &res->resource_i=
d);
> +        qemu_put_buffer(f, (void *)uuid, sizeof(QemuUUID));
> +    }
> +    qemu_put_be32(f, 0); /* end of list */
> +
> +    g_hash_table_destroy(g->resource_uuids);
> +
> +    return 0;
> +}
> +
> +static int virtio_gpu_resource_uuid_load(QEMUFile *f, void *opaque, size=
_t size,
> +                                         const VMStateField *field)
> +{
> +    VirtIOGPU *g =3D opaque;
> +    struct virtio_gpu_simple_resource *res;
> +    uint32_t resource_id;
> +    QemuUUID *uuid =3D NULL;
> +
> +    g->resource_uuids =3D g_hash_table_new_full(g_int_hash, g_int_equal,=
 NULL, g_free);
> +    resource_id =3D qemu_get_be32(f);
> +    while (resource_id !=3D 0) {
> +        res =3D virtio_gpu_find_resource(g, resource_id);
> +        if (res) {
> +            return -EINVAL;
> +        }
> +
> +        res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> +        res->resource_id =3D resource_id;
> +
> +        qemu_get_buffer(f, (void *)uuid, sizeof(QemuUUID));
> +        g_hash_table_insert(g->resource_uuids, &res->resource_id, uuid);
> +
> +        resource_id =3D qemu_get_be32(f);
> +    }
> +
> +    return 0;
> +}
> +
>  static int virtio_gpu_post_load(void *opaque, int version_id)
>  {
>      VirtIOGPU *g =3D opaque;
> @@ -1475,12 +1560,15 @@ void virtio_gpu_device_realize(DeviceState *qdev,=
 Error **errp)
>      QTAILQ_INIT(&g->reslist);
>      QTAILQ_INIT(&g->cmdq);
>      QTAILQ_INIT(&g->fenceq);
> +
> +    g->resource_uuids =3D g_hash_table_new_full(g_int_hash, g_int_equal,=
 NULL, g_free);
>  }
>
>  static void virtio_gpu_device_unrealize(DeviceState *qdev)
>  {
>      VirtIOGPU *g =3D VIRTIO_GPU(qdev);
>
> +    g_hash_table_destroy(g->resource_uuids);

better:
g_clear_pointer(&g->resource_uuids, g_hash_table_unref);

>      g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
>      g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
>      g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> @@ -1534,6 +1622,8 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>          g_free(cmd);
>      }
>
> +    g_hash_table_remove_all(g->resource_uuids);
> +
>      virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>  }
>
> @@ -1583,6 +1673,32 @@ const VMStateDescription vmstate_virtio_gpu_blob_s=
tate =3D {
>      },
>  };
>
> +static bool virtio_gpu_resource_uuid_state_needed(void *opaque)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(opaque);
> +
> +    return virtio_gpu_resource_uuid_enabled(g->parent_obj.conf);
> +}
> +
> +const VMStateDescription vmstate_virtio_gpu_resource_uuid_state =3D {
> +    .name =3D "virtio-gpu/resource_uuid",
> +    .minimum_version_id =3D VIRTIO_GPU_VM_VERSION,
> +    .version_id =3D VIRTIO_GPU_VM_VERSION,
> +    .needed =3D virtio_gpu_resource_uuid_state_needed,
> +    .fields =3D (const VMStateField[]){
> +        {
> +            .name =3D "virtio-gpu/resource_uuid",
> +            .info =3D &(const VMStateInfo) {
> +                .name =3D "resource_uuid",
> +                .get =3D virtio_gpu_resource_uuid_load,
> +                .put =3D virtio_gpu_resource_uuid_save,
> +            },
> +            .flags =3D VMS_SINGLE,
> +        } /* device */,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  /*
>   * For historical reasons virtio_gpu does not adhere to virtio migration
>   * scheme as described in doc/virtio-migration.txt, in a sense that no
> @@ -1610,6 +1726,7 @@ static const VMStateDescription vmstate_virtio_gpu =
=3D {
>      },
>      .subsections =3D (const VMStateDescription * []) {
>          &vmstate_virtio_gpu_blob_state,
> +        &vmstate_virtio_gpu_resource_uuid_state,
>          NULL
>      },
>      .post_load =3D virtio_gpu_post_load,
> @@ -1622,6 +1739,8 @@ static Property virtio_gpu_properties[] =3D {
>      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +    DEFINE_PROP_BIT("resource_uuid", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED, false),

why not enable it by default? (and set it to false for machine < 9.0

>  #ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
>      DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, true),
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 584ba2ed73..76b410fe91 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -98,6 +98,7 @@ enum virtio_gpu_base_conf_flags {
>      VIRTIO_GPU_FLAG_BLOB_ENABLED,
>      VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>      VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
> +    VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
>  };
>
>  #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -114,6 +115,8 @@ enum virtio_gpu_base_conf_flags {
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
>  #define virtio_gpu_rutabaga_enabled(_cfg) \
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> +#define virtio_gpu_resource_uuid_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED))
>  #define virtio_gpu_hostmem_enabled(_cfg) \
>      (_cfg.hostmem > 0)
>
> @@ -209,6 +212,8 @@ struct VirtIOGPU {
>          QTAILQ_HEAD(, VGPUDMABuf) bufs;
>          VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
>      } dmabuf;
> +
> +    GHashTable *resource_uuids;
>  };
>
>  struct VirtIOGPUClass {
> @@ -307,6 +312,8 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
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
> 2.25.1
>


--=20
Marc-Andr=C3=A9 Lureau

