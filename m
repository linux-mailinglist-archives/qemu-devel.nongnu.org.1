Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624592E124
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 09:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoUu-0001Ae-3O; Thu, 11 Jul 2024 03:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRoUp-00019O-7E
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRoUm-0000cP-2k
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720683938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rk3fVNKTT3pWFiTqXrCNPoTezFLibApnDbG/NUASvWY=;
 b=OvgUD1FPMinvQz11TY4/5TsjCmlnUU2+Uz41BZbMrqtCc/9n9/Pm/SBKKUqgSzZSIBE8nV
 hHs4M9iZKiJkqIuk+Ws3q6ft85YUznvr+VqdYUWXST81L7Gaud1WxENysX+POVfojZMLww
 GvzKZbwDrxlTMPzgnJTSmRfOaTRw974=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-aBa8s7MEPKK7WwjsaRimGg-1; Thu,
 11 Jul 2024 03:45:29 -0400
X-MC-Unique: aBa8s7MEPKK7WwjsaRimGg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FE8B19054EF; Thu, 11 Jul 2024 07:45:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA2AC191C66B; Thu, 11 Jul 2024 07:45:12 +0000 (UTC)
Date: Thu, 11 Jul 2024 09:45:10 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 1/5] vhost-user: Add VIRTIO Shared Memory map
 request
Message-ID: <20240711074510.GC563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9wjglkpkhVD+OW6A"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--9wjglkpkhVD+OW6A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:06PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user to
> handle VIRTIO Shared Memory mappings.
>=20
> This request allows backends to dynamically map
> fds into a VIRTIO Shared Memory Region indentified
> by its `shmid`. Then, the fd memory is advertised
> to the driver as a base addres + offset, so it
> can be read/written (depending on the mmap flags
> requested) while its valid.
>=20
> The backend can munmap the memory range
> in a given VIRTIO Shared Memory Region (again,
> identified by its `shmid`), to free it. Upon
> receiving this message, the front-end must
> mmap the regions with PROT_NONE to reserve
> the virtual memory space.
>=20
> The device model needs to create MemoryRegion
> instances for the VIRTIO Shared Memory Regions
> and add them to the `VirtIODevice` instance.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst               |  27 +++++
>  hw/virtio/vhost-user.c                    | 122 ++++++++++++++++++++++
>  hw/virtio/virtio.c                        |  12 +++
>  include/hw/virtio/virtio.h                |   5 +
>  subprojects/libvhost-user/libvhost-user.c |  65 ++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  53 ++++++++++
>  6 files changed, 284 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index d8419fd2f1..d52ba719d5 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1859,6 +1859,33 @@ is sent by the front-end.
>    when the operation is successful, or non-zero otherwise. Note that if =
the
>    operation fails, no fd is sent to the backend.
> =20
> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  This message can be submitted by the backends to advertise a new mappi=
ng
> +  to be made in a given VIRTIO Shared Memory Region. Upon receiving the =
message,
> +  The front-end will mmap the given fd into the VIRTIO Shared Memory Reg=
ion
> +  with the requested ``shmid``. A reply is generated indicating whether =
mapping
> +  succeeded.
> +
> +  Mapping over an already existing map is not allowed and request shall =
fail.
> +  Therefore, the memory range in the request must correspond with a vali=
d,
> +  free region of the VIRTIO Shared Memory Region.
> +
> +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> +  :id: 10
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  This message can be submitted by the backends so that the front-end un=
-mmap
> +  a given range (``offset``, ``len``) in the VIRTIO Shared Memory Region=
 with

s/offset/shm_offset/

> +  the requested ``shmid``.

Please clarify that <offset, len> must correspond to the entirety of a
valid mapped region.

By the way, the VIRTIO 1.3 gives the following behavior for the virtiofs
DAX Window:

  When a FUSE_SETUPMAPPING request perfectly overlaps a previous
  mapping, the previous mapping is replaced. When a mapping partially
  overlaps a previous mapping, the previous mapping is split into one or
  two smaller mappings. When a mapping is partially unmapped it is also
  split into one or two smaller mappings.

  Establishing new mappings or splitting existing mappings consumes
  resources. If the device runs out of resources the FUSE_SETUPMAPPING
  request fails until resources are available again following
  FUSE_REMOVEMAPPING.

I think SETUPMAPPING/REMOVMAPPING can be implemented using
SHMEM_MAP/UNMAP. SHMEM_MAP/UNMAP do not allow atomically replacing
partial ranges, but as far as I know that's not necessary for virtiofs
in practice.

It's worth mentioning that mappings consume resources and that SHMEM_MAP
can fail when there are no resources available. The process-wide limit
is vm.max_map_count on Linux although a vhost-user frontend may reduce
it further to control vhost-user resource usage.

> +  A reply is generated indicating whether unmapping succeeded.
> +
>  .. _reply_ack:
> =20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..7ee8a472c6 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
>      unsigned char uuid[16];
>  } VhostUserShared;
> =20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> +
> +typedef struct {
> +    /* VIRTIO Shared Memory Region ID */
> +    uint8_t shmid;
> +    uint8_t padding[7];
> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the VIRTIO Shared Memory Region */
> +    uint64_t shm_offset;
> +    /* Size of the mapping */
> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> +    uint64_t flags;
> +} VhostUserMMap;
> +
>  typedef struct {
>      VhostUserRequest request;
> =20
> @@ -224,6 +244,7 @@ typedef union {
>          VhostUserInflight inflight;
>          VhostUserShared object;
>          VhostUserTransferDeviceState transfer_state;
> +        VhostUserMMap mmap;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -1748,6 +1769,100 @@ vhost_user_backend_handle_shared_object_lookup(st=
ruct vhost_user *u,
>      return 0;
>  }
> =20
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    VhostUserMMap *vu_mmap,
> +                                    int fd)
> +{
> +    void *addr =3D 0;
> +    MemoryRegion *mr =3D NULL;
> +
> +    if (fd < 0) {
> +        error_report("Bad fd for map");
> +        return -EBADF;
> +    }
> +
> +    if (!dev->vdev->shmem_list ||
> +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> +        error_report("Device only has %d VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d",
> +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if (!mr) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> +
> +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,

Missing check for overlap between range [shm_offset, shm_offset + len)
and existing mappings.

> +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> +
> +    if (addr =3D=3D MAP_FAILED) {
> +        error_report("Failed to mmap mem fd");
> +        return -EFAULT;
> +    }
> +
> +    return 0;
> +}
> +
> +static int
> +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> +                                      VhostUserMMap *vu_mmap)
> +{
> +    void *addr =3D 0;
> +    MemoryRegion *mr =3D NULL;
> +
> +    if (!dev->vdev->shmem_list ||
> +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> +        error_report("Device only has %d VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d",
> +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if (!mr) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> +
> +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,

Missing check for existing mapping with exact range [shm_offset, len)
match.

> +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, =
0);
> +
> +    if (addr =3D=3D MAP_FAILED) {
> +        error_report("Failed to unmap memory");
> +        return -EFAULT;
> +    }
> +
> +    return 0;
> +}
> +
>  static void close_backend_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->backend_src);
> @@ -1816,6 +1931,13 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
>                                                               &hdr, &payl=
oad);
>          break;
> +    case VHOST_USER_BACKEND_SHMEM_MAP:
> +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload.mmap,
> +                                                  fd ? fd[0] : -1);
> +        break;
> +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, &payload.mmap=
);
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret =3D -EINVAL;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..9f2da5b11e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2856,6 +2856,16 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
> =20
> +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
> +{
> +    MemoryRegion *mr =3D g_new0(MemoryRegion, 1);
> +    ++vdev->n_shmem_regions;
> +    vdev->shmem_list =3D g_renew(MemoryRegion, vdev->shmem_list,
> +                               vdev->n_shmem_regions);

Where is shmem_list freed?

The name "list" is misleading since this is an array, not a list.

> +    vdev->shmem_list[vdev->n_shmem_regions - 1] =3D *mr;
> +    return mr;
> +}

This looks weird. The contents of mr are copied into shmem_list[] and
then the pointer to mr is returned? Did you mean for the field's type to
be MemoryRegion **shmem_list and then vdev->shmem_list[...] =3D mr would
stash the pointer?

> +
>  /* A wrapper for use as a VMState .put function */
>  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
>                                const VMStateField *field, JSONWriter *vmd=
esc)
> @@ -3264,6 +3274,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t devic=
e_id, size_t config_size)
>              virtio_vmstate_change, vdev);
>      vdev->device_endian =3D virtio_default_endian();
>      vdev->use_guest_notifier_mask =3D true;
> +    vdev->shmem_list =3D NULL;
> +    vdev->n_shmem_regions =3D 0;
>  }
> =20
>  /*
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..16d598aadc 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -165,6 +165,9 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    /* Shared memory region for vhost-user mappings. */
> +    MemoryRegion *shmem_list;
> +    int n_shmem_regions;
>  };
> =20
>  struct VirtioDeviceClass {
> @@ -280,6 +283,8 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
> =20
>  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> =20
> +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
> +
>  extern const VMStateInfo virtio_vmstate_info;
> =20
>  #define VMSTATE_VIRTIO_DEVICE \
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index a879149fef..28556d183a 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1586,6 +1586,71 @@ vu_rm_shared_object(VuDev *dev, unsigned char uuid=
[UUID_LEN])
>      return vu_send_message(dev, &msg);
>  }
> =20
> +bool
> +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +             uint64_t shm_offset, uint64_t len, uint64_t flags)
> +{
> +    bool result =3D false;
> +    VhostUserMsg msg_reply;
> +    VhostUserMsg vmsg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> +        .size =3D sizeof(vmsg.payload.mmap),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.mmap =3D {
> +            .shmid =3D shmid,
> +            .fd_offset =3D fd_offset,
> +            .shm_offset =3D shm_offset,
> +            .len =3D len,
> +            .flags =3D flags,
> +        },
> +    };
> +
> +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    pthread_mutex_lock(&dev->backend_mutex);
> +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> +        pthread_mutex_unlock(&dev->backend_mutex);
> +        return false;
> +    }
> +
> +    /* Also unlocks the backend_mutex */
> +    return vu_process_message_reply(dev, &vmsg);
> +}
> +
> +bool
> +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +               uint64_t shm_offset, uint64_t len)
> +{
> +    bool result =3D false;
> +    VhostUserMsg msg_reply;
> +    VhostUserMsg vmsg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> +        .size =3D sizeof(vmsg.payload.mmap),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.mmap =3D {
> +            .shmid =3D shmid,
> +            .fd_offset =3D fd_offset,

What is the meaning of this field? I expected it to be set to 0.

> +            .shm_offset =3D shm_offset,
> +            .len =3D len,
> +        },
> +    };
> +
> +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    pthread_mutex_lock(&dev->backend_mutex);
> +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> +        pthread_mutex_unlock(&dev->backend_mutex);
> +        return false;
> +    }
> +
> +    /* Also unlocks the backend_mutex */
> +    return vu_process_message_reply(dev, &vmsg);
> +}
> +
>  static bool
>  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libv=
host-user/libvhost-user.h
> index deb40e77b3..7f6c22cc1a 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -186,6 +188,24 @@ typedef struct VhostUserShared {
>      unsigned char uuid[UUID_LEN];
>  } VhostUserShared;
> =20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> +
> +typedef struct {
> +    /* VIRTIO Shared Memory Region ID */
> +    uint8_t shmid;
> +    uint8_t padding[7];
> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the VIRTIO Shared Memory Region */
> +    uint64_t shm_offset;
> +    /* Size of the mapping */
> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> +    uint64_t flags;
> +} VhostUserMMap;
> +
>  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
> @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
>          VhostUserShared object;
> +        VhostUserMMap mmap;
>      } payload;
> =20
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -597,6 +618,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned char =
uuid[UUID_LEN]);
>   */
>  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> =20
> +/**
> + * vu_shmem_map:
> + * @dev: a VuDev context
> + * @shmid: VIRTIO Shared Memory Region ID
> + * @fd_offset: File offset
> + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> + * @len: Size of the mapping
> + * @flags: Flags for the mmap operation
> + *
> + * Advertises a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +                  uint64_t shm_offset, uint64_t len, uint64_t flags);
> +
> +/**
> + * vu_shmem_map:
> + * @dev: a VuDev context
> + * @shmid: VIRTIO Shared Memory Region ID
> + * @fd_offset: File offset
> + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> + * @len: Size of the mapping
> + *
> + * The front-end un-mmaps a given range in the VIRTIO Shared Memory Regi=
on
> + * with the requested `shmid`.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +                  uint64_t shm_offset, uint64_t len);
> +
>  /**
>   * vu_queue_set_notification:
>   * @dev: a VuDev context
> --=20
> 2.45.2
>=20

--9wjglkpkhVD+OW6A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPjYYACgkQnKSrs4Gr
c8gwjwgAytCOr5WNVK6+09+uyG5/HqUAETq6XZ+MDTkwSIlKzYxDgkUV56dXka/f
HnpETpgzQgjmreCydW9f2xq/JT/XxPAxpQzPNjCrAh8uGA0Xf9gyUT5otDPrjVmB
O8GJUCdptDOvpuIr0uC40e03xZNHkBVlJ31k2UCUT227uK/YTH7XSON0vH7ggSYD
bPPLjKhyMXt/pPUrkSDj8XWOhqXiW2GDsyFEeFSkzR2jpOYlwCkbMSEc9zqJc0O4
YmRA7Zxq/w7JNUri+WmgWVcU9YN5xxfGs+G12oKuByMu+2K5Nqgfps3xILMpcuY9
HIWaGZMs9ZYAt18iez7SEYnatADkdw==
=CdhF
-----END PGP SIGNATURE-----

--9wjglkpkhVD+OW6A--


