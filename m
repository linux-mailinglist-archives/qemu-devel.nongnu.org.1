Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A0808BE3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:32:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGL4-0003BI-Pw; Thu, 07 Dec 2023 10:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBGKk-00034h-Db
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBGKe-0003EI-9D
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701963031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVrOxeLDKFc3gfO25CxdaGPwx9CaLGtOdmT9XpTOG4s=;
 b=YsyNiB2sE8KGIT8LzlmIc2tmTS+JSnucYvPilxnetH+XqPj+WUIv+2lc73+570tU3MDr0h
 5YSF3n5Ckg8Tt+ovmX9eT22NrHQ5CkMWsBGBjkQEXz45TIZ+6nLV4aG4CN5gLCgmsfHLSU
 fnlXLz4+2mqT22rdPMj4E/Swv4IltJs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-l5J4Q1lBMrmwqQ_YBLTqUA-1; Thu, 07 Dec 2023 10:30:29 -0500
X-MC-Unique: l5J4Q1lBMrmwqQ_YBLTqUA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28867e91e37so1005949a91.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963028; x=1702567828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uVrOxeLDKFc3gfO25CxdaGPwx9CaLGtOdmT9XpTOG4s=;
 b=gdGHYYLt69drvZ/IpA6u/mpEyzl6QQNHrxhllhs0itSJNnJDwfs0uGdiB9K8cXu3Ge
 HNsqsaOol8a+QWXzgnyL2zIf77jTlhja9Jrqz8bCxJvlJ+ihMORS3ypoyp/7UzVL/POz
 U1tttds6+2jCBFwI/p+GX2/7v8+d9HWvJiGXj7NhbV0PkeX863bDrXRe8sbdMYQ7aoMa
 jaR1uxHNqYBrwMkJ7EU7kUn7qKtoqx/A9p9Nh8/1FYCQuS0UUGdNfYyCjZUDiLp3+BX4
 Z4argr2XEQH4uCyUtgtZlJFAp2q/ZTulyX1pDfW1w761+q9CKeHo+52HxWpUGQDnA6ww
 fABQ==
X-Gm-Message-State: AOJu0YzZCY73qpv98mcmKj0Q0NPYSALKGoJRuVnhT9YEhOiB5wElkPpP
 dBhgHMW2WrOH8AwDMZf7sWOLd7Q3OuV3DaJJ+u3ClCoin4W/yFSGIvok2KwojL6oY11f1lsnZ8F
 24ooqVU+ipn5ikFpDBBY9+1MG0Nv8P9tKW//L/+w=
X-Received: by 2002:a17:90b:3901:b0:286:c0e2:83f1 with SMTP id
 ob1-20020a17090b390100b00286c0e283f1mr2433923pjb.32.1701963027803; 
 Thu, 07 Dec 2023 07:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIMcHI1xTpYfrvtEVyzXwTQfaD875jLJ43Q0V4PjmjtHR2VFpPKK877vrIpDwCWu+GfpiiZO7Gkr11ANkryRU=
X-Received: by 2002:a17:90b:3901:b0:286:c0e2:83f1 with SMTP id
 ob1-20020a17090b390100b00286c0e283f1mr2433904pjb.32.1701963027319; Thu, 07
 Dec 2023 07:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20231207145545.783877-1-aesteve@redhat.com>
 <20231207145545.783877-4-aesteve@redhat.com>
In-Reply-To: <20231207145545.783877-4-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 Dec 2023 16:30:16 +0100
Message-ID: <CADSE00KGZ3Sz3P0anT5UE2GLktMQ42s0k445dH0tvSvoOWevig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/virtio: rename virtio dmabuf API
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com
Content-Type: multipart/alternative; boundary="000000000000aa1ed2060bed2565"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000aa1ed2060bed2565
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 3:55=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:

> Functions in the virtio-dmabuf module
> start with 'virtio_*', which is too
> generic and may not correctly identify
> them as part of the virtio dmabuf API.
>
> Rename all functions to 'virtio_dmabuf_*'
> instead to avoid confusion.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/display/virtio-dmabuf.c        | 14 +++++-----
>  hw/virtio/vhost-user.c            | 14 +++++-----
>  include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------
>  tests/unit/test-virtio-dmabuf.c   | 44 +++++++++++++++----------------
>  4 files changed, 53 insertions(+), 52 deletions(-)
>
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 6688809777..42495f87ec 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -48,7 +48,7 @@ static bool virtio_add_resource(QemuUUID *uuid,
> VirtioSharedObject *value)
>      return result;
>  }
>
> -bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
> +bool virtio_dmabuf_add(QemuUUID *uuid, int udmabuf_fd)
>  {
>      bool result;
>      VirtioSharedObject *vso;
> @@ -66,7 +66,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
>      return result;
>  }
>
> -bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
> +bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *de=
v)
>  {
>      bool result;
>      VirtioSharedObject *vso;
> @@ -84,7 +84,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct
> vhost_dev *dev)
>      return result;
>  }
>
> -bool virtio_remove_resource(const QemuUUID *uuid)
> +bool virtio_dmabuf_remove_resource(const QemuUUID *uuid)
>  {
>      bool result;
>      g_mutex_lock(&lock);
> @@ -107,7 +107,7 @@ static VirtioSharedObject *get_shared_object(const
> QemuUUID *uuid)
>      return (VirtioSharedObject *) lookup_res;
>  }
>
> -int virtio_lookup_dmabuf(const QemuUUID *uuid)
> +int virtio_dmabuf_lookup(const QemuUUID *uuid)
>  {
>      VirtioSharedObject *vso =3D get_shared_object(uuid);
>      if (vso =3D=3D NULL) {
> @@ -117,7 +117,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)
>      return GPOINTER_TO_INT(vso->value);
>  }
>
> -struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
> +struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid=
)
>  {
>      VirtioSharedObject *vso =3D get_shared_object(uuid);
>      if (vso =3D=3D NULL) {
> @@ -127,7 +127,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const
> QemuUUID *uuid)
>      return (struct vhost_dev *) vso->value;
>  }
>
> -SharedObjectType virtio_object_type(const QemuUUID *uuid)
> +SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid)
>  {
>      VirtioSharedObject *vso =3D get_shared_object(uuid);
>      if (vso =3D=3D NULL) {
> @@ -158,7 +158,7 @@ int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev=
)
>      return num_removed;
>  }
>
> -void virtio_free_resources(void)
> +void virtio_dmabuf_free_resources(void)
>  {
>      g_mutex_lock(&lock);
>      g_hash_table_destroy(resource_uuids);
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 1c3f2357be..2ab9e13f9e 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct
> vhost_dev *dev,
>      QemuUUID uuid;
>
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> -    return virtio_add_vhost_device(&uuid, dev);
> +    return virtio_dmabuf_add_vhost_device(&uuid, dev);
>  }
>
>  static int
> @@ -1617,10 +1617,10 @@
> vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
>      QemuUUID uuid;
>
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> -    switch (virtio_object_type(&uuid)) {
> +    switch (virtio_dmabuf_object_type(&uuid)) {
>      case TYPE_VHOST_DEV:
>      {
> -        struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> +        struct vhost_dev *owner =3D
> virtio_dmabuf_lookup_vhost_device(&uuid);
>          if (owner =3D=3D NULL || dev !=3D owner) {
>              /* Not allowed to remove non-owned entries */
>              return 0;
> @@ -1632,7 +1632,7 @@
> vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
>          return 0;
>      }
>
> -    return virtio_remove_resource(&uuid);
> +    return virtio_dmabuf_remove_resource(&uuid);
>  }
>
>  static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> @@ -1710,13 +1710,13 @@
> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>      memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid)=
);
>
>      payload->u64 =3D 0;
> -    switch (virtio_object_type(&uuid)) {
> +    switch (virtio_dmabuf_object_type(&uuid)) {
>      case TYPE_DMABUF:
> -        dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> +        dmabuf_fd =3D virtio_dmabuf_lookup(&uuid);
>          break;
>      case TYPE_VHOST_DEV:
>      {
> -        struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uuid);
> +        struct vhost_dev *dev =3D virtio_dmabuf_lookup_vhost_device(&uui=
d);
>          if (dev =3D=3D NULL) {
>              payload->u64 =3D -EINVAL;
>              break;
> diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> index 73f70fb482..186a18a33b 100644
> --- a/include/hw/virtio/virtio-dmabuf.h
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -28,7 +28,7 @@ typedef struct VirtioSharedObject {
>  } VirtioSharedObject;
>
>  /**
> - * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
> + * virtio_dmabuf_add() - Add a new dma-buf resource to the lookup table
>   * @uuid: new resource's UUID
>   * @dmabuf_fd: the dma-buf descriptor that will be stored and shared wit=
h
>   *             other virtio devices. The caller retains ownership over t=
he
> @@ -41,11 +41,11 @@ typedef struct VirtioSharedObject {
>   * Note that if it finds a repeated UUID, the resource is not inserted i=
n
>   * the lookup table.
>   */
> -bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
> +bool virtio_dmabuf_add(QemuUUID *uuid, int dmabuf_fd);
>
>  /**
> - * virtio_add_vhost_device() - Add a new exporter vhost device that hold=
s
> the
> - * resource with the associated UUID
> + * virtio_dmabuf_add_vhost_device() - Add a new exporter vhost device th=
at
> + * holds the resource with the associated UUID
>   * @uuid: new resource's UUID
>   * @dev: the pointer to the vhost device that holds the resource. The
> caller
>   *       retains ownership over the device struct and its lifecycle.
> @@ -55,41 +55,42 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd)=
;
>   * Note that if it finds a repeated UUID, the resource is not inserted i=
n
>   * the lookup table.
>   */
> -bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
> +bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev
> *dev);
>
>  /**
> - * virtio_remove_resource() - Removes a resource from the lookup table
> + * virtio_dmabuf_remove_resource() - Removes a resource from the lookup
> table
>   * @uuid: resource's UUID
>   *
>   * Return: true if the UUID has been found and removed from the lookup
> table.
>   */
> -bool virtio_remove_resource(const QemuUUID *uuid);
> +bool virtio_dmabuf_remove_resource(const QemuUUID *uuid);
>
>  /**
> - * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup
> table
> + * virtio_dmabuf_lookup() - Looks for a dma-buf resource in the lookup
> table
>   * @uuid: resource's UUID
>   *
>   * Return: the dma-buf file descriptor integer, or -1 if the key is not
> found.
>   */
> -int virtio_lookup_dmabuf(const QemuUUID *uuid);
> +int virtio_dmabuf_lookup(const QemuUUID *uuid);
>
>  /**
> - * virtio_lookup_vhost_device() - Looks for an exporter vhost device in
> the
> - * lookup table
> + * virtio_dmabuf_lookup_vhost_device() - Looks for an exporter vhost
> device
> + * in the lookup table
>   * @uuid: resource's UUID
>   *
>   * Return: pointer to the vhost_dev struct, or NULL if the key is not
> found.
>   */
> -struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
> +struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid=
);
>
>  /**
> - * virtio_object_type() - Looks for the type of resource in the lookup
> table
> + * virtio_dmabuf_object_type() - Looks for the type of resource in the
> + * lookup table
>   * @uuid: resource's UUID
>   *
>   * Return: the type of resource associated with the UUID, or TYPE_INVALI=
D
> if
>   * the key is not found.
>   */
> -SharedObjectType virtio_object_type(const QemuUUID *uuid);
> +SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid);
>
>  /**
>   * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
> @@ -102,9 +103,9 @@ SharedObjectType virtio_object_type(const QemuUUID
> *uuid);
>  int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
>
>  /**
> - * virtio_free_resources() - Destroys all keys and values of the shared
> + * virtio_dmabuf_free_resources() - Destroys all keys and values of the
> shared
>   * resources lookup table, and frees them
>   */
> -void virtio_free_resources(void);
> +void virtio_dmabuf_free_resources(void);
>
>  #endif /* VIRTIO_DMABUF_H */
> diff --git a/tests/unit/test-virtio-dmabuf.c
> b/tests/unit/test-virtio-dmabuf.c
> index 1c8123c2d2..7471ed4fbd 100644
> --- a/tests/unit/test-virtio-dmabuf.c
> +++ b/tests/unit/test-virtio-dmabuf.c
> @@ -31,12 +31,12 @@ static void test_add_remove_resources(void)
>          qemu_uuid_generate(&uuid);
>          dmabuf_fd =3D g_random_int_range(3, 500);
>          /* Add a new resource */
> -        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, dmabuf_fd);
> +        g_assert(virtio_dmabuf_add(&uuid, dmabuf_fd));
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), =3D=3D, dmabuf_fd);
>          /* Remove the resource */
> -        g_assert(virtio_remove_resource(&uuid));
> +        g_assert(virtio_dmabuf_remove_resource(&uuid));
>          /* Resource is not found anymore */
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), =3D=3D, -1);
>      }
>  }
>
> @@ -48,13 +48,13 @@ static void test_add_remove_dev(void)
>
>      for (i =3D 0; i < 100; ++i) {
>          qemu_uuid_generate(&uuid);
> -        virtio_add_vhost_device(&uuid, dev);
> +        virtio_dmabuf_add_vhost_device(&uuid, dev);
>          /* vhost device is found */
> -        g_assert(virtio_lookup_vhost_device(&uuid) !=3D NULL);
> +        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) !=3D NULL);
>          /* Remove the vhost device */
> -        g_assert(virtio_remove_resource(&uuid));
> +        g_assert(virtio_dmabuf_remove_resource(&uuid));
>          /* vhost device is not found anymore */
> -        g_assert(virtio_lookup_vhost_device(&uuid) =3D=3D NULL);
> +        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) =3D=3D NULL);
>      }
>      g_free(dev);
>  }
> @@ -66,9 +66,9 @@ static void test_remove_invalid_resource(void)
>
>      for (i =3D 0; i < 20; ++i) {
>          qemu_uuid_generate(&uuid);
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), =3D=3D, -1);
>          /* Removing a resource that does not exist returns false */
> -        g_assert_false(virtio_remove_resource(&uuid));
> +        g_assert_false(virtio_dmabuf_remove_resource(&uuid));
>      }
>  }
>
> @@ -81,25 +81,25 @@ static void test_add_invalid_resource(void)
>      for (i =3D 0; i < 20; ++i) {
>          qemu_uuid_generate(&uuid);
>          /* Add a new resource with invalid (negative) resource fd */
> -        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        g_assert_false(virtio_dmabuf_add(&uuid, dmabuf_fd));
>          /* Resource is not found */
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), =3D=3D, -1);
>          /* Add a new vhost device with invalid (NULL) pointer */
> -        g_assert_false(virtio_add_vhost_device(&uuid, dev));
> +        g_assert_false(virtio_dmabuf_add_vhost_device(&uuid, dev));
>          /* vhost device is not found */
> -        g_assert(virtio_lookup_vhost_device(&uuid) =3D=3D NULL);
> +        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) =3D=3D NULL);
>      }
>
>      for (i =3D 0; i < 20; ++i) {
>          /* Add a valid resource */
>          qemu_uuid_generate(&uuid);
>          dmabuf_fd =3D g_random_int_range(3, 500);
> -        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, dmabuf_fd);
> +        g_assert(virtio_dmabuf_add(&uuid, dmabuf_fd));
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), =3D=3D, dmabuf_fd);
>          /* Add a new resource with repeated uuid returns false */
> -        g_assert_false(virtio_add_dmabuf(&uuid, alt_dmabuf));
> +        g_assert_false(virtio_dmabuf_add(&uuid, alt_dmabuf));
>          /* The value for the uuid key is not replaced */
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, dmabuf_fd);
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), =3D=3D, dmabuf_fd);
>      }
>  }
>
> @@ -143,13 +143,13 @@ static void test_free_resources(void)
>      for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
>          qemu_uuid_generate(&uuids[i]);
>          dmabuf_fd =3D g_random_int_range(3, 500);
> -        g_assert(virtio_add_dmabuf(&uuids[i], dmabuf_fd));
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), =3D=3D, dmabuf_=
fd);
> +        g_assert(virtio_dmabuf_add(&uuids[i], dmabuf_fd));
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), =3D=3D, dmabuf_=
fd);
>      }
> -    virtio_free_resources();
> +    virtio_dmabuf_free_resources();
>      for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
>          /* None of the resources is found after free'd */
> -        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), =3D=3D, -1);
> +        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), =3D=3D, -1);
>      }
>
>  }
> --
> 2.43.0
>
>
Agh I forgot to rename the function in the new test after applying the last
review.
I have it fixed in my local branch and passing the tests. I'll wait for
feedback
on the other commits and push a new version after.

--000000000000aa1ed2060bed2565
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div><br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 7, 2023 at 3:=
55=E2=80=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aeste=
ve@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Functions in the virtio-dmabuf module<br>
start with &#39;virtio_*&#39;, which is too<br>
generic and may not correctly identify<br>
them as part of the virtio dmabuf API.<br>
<br>
Rename all functions to &#39;virtio_dmabuf_*&#39;<br>
instead to avoid confusion.<br>
<br>
Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" targ=
et=3D"_blank">aesteve@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++-----=
<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 =
+++++-----<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 44 +++++++++++++++-----=
-----------<br>
=C2=A04 files changed, 53 insertions(+), 52 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br>
index 6688809777..42495f87ec 100644<br>
--- a/hw/display/virtio-dmabuf.c<br>
+++ b/hw/display/virtio-dmabuf.c<br>
@@ -48,7 +48,7 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSha=
redObject *value)<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
<br>
-bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)<br>
+bool virtio_dmabuf_add(QemuUUID *uuid, int udmabuf_fd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool result;<br>
=C2=A0 =C2=A0 =C2=A0VirtioSharedObject *vso;<br>
@@ -66,7 +66,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)<br=
>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
<br>
-bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)<br>
+bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool result;<br>
=C2=A0 =C2=A0 =C2=A0VirtioSharedObject *vso;<br>
@@ -84,7 +84,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost=
_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
<br>
-bool virtio_remove_resource(const QemuUUID *uuid)<br>
+bool virtio_dmabuf_remove_resource(const QemuUUID *uuid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool result;<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_lock(&amp;lock);<br>
@@ -107,7 +107,7 @@ static VirtioSharedObject *get_shared_object(const Qemu=
UUID *uuid)<br>
=C2=A0 =C2=A0 =C2=A0return (VirtioSharedObject *) lookup_res;<br>
=C2=A0}<br>
<br>
-int virtio_lookup_dmabuf(const QemuUUID *uuid)<br>
+int virtio_dmabuf_lookup(const QemuUUID *uuid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtioSharedObject *vso =3D get_shared_object(uuid);<br=
>
=C2=A0 =C2=A0 =C2=A0if (vso =3D=3D NULL) {<br>
@@ -117,7 +117,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)<br>
=C2=A0 =C2=A0 =C2=A0return GPOINTER_TO_INT(vso-&gt;value);<br>
=C2=A0}<br>
<br>
-struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)<br>
+struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtioSharedObject *vso =3D get_shared_object(uuid);<br=
>
=C2=A0 =C2=A0 =C2=A0if (vso =3D=3D NULL) {<br>
@@ -127,7 +127,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const Qemu=
UUID *uuid)<br>
=C2=A0 =C2=A0 =C2=A0return (struct vhost_dev *) vso-&gt;value;<br>
=C2=A0}<br>
<br>
-SharedObjectType virtio_object_type(const QemuUUID *uuid)<br>
+SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtioSharedObject *vso =3D get_shared_object(uuid);<br=
>
=C2=A0 =C2=A0 =C2=A0if (vso =3D=3D NULL) {<br>
@@ -158,7 +158,7 @@ int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)<=
br>
=C2=A0 =C2=A0 =C2=A0return num_removed;<br>
=C2=A0}<br>
<br>
-void virtio_free_resources(void)<br>
+void virtio_dmabuf_free_resources(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_lock(&amp;lock);<br>
=C2=A0 =C2=A0 =C2=A0g_hash_table_destroy(resource_uuids);<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 1c3f2357be..2ab9e13f9e 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct vh=
ost_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0QemuUUID uuid;<br>
<br>
=C2=A0 =C2=A0 =C2=A0memcpy(uuid.data, object-&gt;uuid, sizeof(object-&gt;uu=
id));<br>
-=C2=A0 =C2=A0 return virtio_add_vhost_device(&amp;uuid, dev);<br>
+=C2=A0 =C2=A0 return virtio_dmabuf_add_vhost_device(&amp;uuid, dev);<br>
=C2=A0}<br>
<br>
=C2=A0static int<br>
@@ -1617,10 +1617,10 @@ vhost_user_backend_handle_shared_object_remove(stru=
ct vhost_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0QemuUUID uuid;<br>
<br>
=C2=A0 =C2=A0 =C2=A0memcpy(uuid.data, object-&gt;uuid, sizeof(object-&gt;uu=
id));<br>
-=C2=A0 =C2=A0 switch (virtio_object_type(&amp;uuid)) {<br>
+=C2=A0 =C2=A0 switch (virtio_dmabuf_object_type(&amp;uuid)) {<br>
=C2=A0 =C2=A0 =C2=A0case TYPE_VHOST_DEV:<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *owner =3D virtio_lookup_vhos=
t_device(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *owner =3D virtio_dmabuf_look=
up_vhost_device(&amp;uuid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (owner =3D=3D NULL || dev !=3D owner) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Not allowed to remove no=
n-owned entries */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -1632,7 +1632,7 @@ vhost_user_backend_handle_shared_object_remove(struct=
 vhost_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);<br>
+=C2=A0 =C2=A0 return virtio_dmabuf_remove_resource(&amp;uuid);<br>
=C2=A0}<br>
<br>
=C2=A0static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hd=
r,<br>
@@ -1710,13 +1710,13 @@ vhost_user_backend_handle_shared_object_lookup(stru=
ct vhost_user *u,<br>
=C2=A0 =C2=A0 =C2=A0memcpy(uuid.data, payload-&gt;object.uuid, sizeof(paylo=
ad-&gt;object.uuid));<br>
<br>
=C2=A0 =C2=A0 =C2=A0payload-&gt;u64 =3D 0;<br>
-=C2=A0 =C2=A0 switch (virtio_object_type(&amp;uuid)) {<br>
+=C2=A0 =C2=A0 switch (virtio_dmabuf_object_type(&amp;uuid)) {<br>
=C2=A0 =C2=A0 =C2=A0case TYPE_DMABUF:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D virtio_lookup_dmabuf(&amp;uuid);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D virtio_dmabuf_lookup(&amp;uuid);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case TYPE_VHOST_DEV:<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *dev =3D virtio_lookup_vhost_=
device(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *dev =3D virtio_dmabuf_lookup=
_vhost_device(&amp;uuid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0payload-&gt;u64 =3D -EINVAL=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-d=
mabuf.h<br>
index 73f70fb482..186a18a33b 100644<br>
--- a/include/hw/virtio/virtio-dmabuf.h<br>
+++ b/include/hw/virtio/virtio-dmabuf.h<br>
@@ -28,7 +28,7 @@ typedef struct VirtioSharedObject {<br>
=C2=A0} VirtioSharedObject;<br>
<br>
=C2=A0/**<br>
- * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table<br=
>
+ * virtio_dmabuf_add() - Add a new dma-buf resource to the lookup table<br=
>
=C2=A0 * @uuid: new resource&#39;s UUID<br>
=C2=A0 * @dmabuf_fd: the dma-buf descriptor that will be stored and shared =
with<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0other virtio device=
s. The caller retains ownership over the<br>
@@ -41,11 +41,11 @@ typedef struct VirtioSharedObject {<br>
=C2=A0 * Note that if it finds a repeated UUID, the resource is not inserte=
d in<br>
=C2=A0 * the lookup table.<br>
=C2=A0 */<br>
-bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);<br>
+bool virtio_dmabuf_add(QemuUUID *uuid, int dmabuf_fd);<br>
<br>
=C2=A0/**<br>
- * virtio_add_vhost_device() - Add a new exporter vhost device that holds =
the<br>
- * resource with the associated UUID<br>
+ * virtio_dmabuf_add_vhost_device() - Add a new exporter vhost device that=
<br>
+ * holds the resource with the associated UUID<br>
=C2=A0 * @uuid: new resource&#39;s UUID<br>
=C2=A0 * @dev: the pointer to the vhost device that holds the resource. The=
 caller<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0retains ownership over the device struct=
 and its lifecycle.<br>
@@ -55,41 +55,42 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);<=
br>
=C2=A0 * Note that if it finds a repeated UUID, the resource is not inserte=
d in<br>
=C2=A0 * the lookup table.<br>
=C2=A0 */<br>
-bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);<br>
+bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)=
;<br>
<br>
=C2=A0/**<br>
- * virtio_remove_resource() - Removes a resource from the lookup table<br>
+ * virtio_dmabuf_remove_resource() - Removes a resource from the lookup ta=
ble<br>
=C2=A0 * @uuid: resource&#39;s UUID<br>
=C2=A0 *<br>
=C2=A0 * Return: true if the UUID has been found and removed from the looku=
p table.<br>
=C2=A0 */<br>
-bool virtio_remove_resource(const QemuUUID *uuid);<br>
+bool virtio_dmabuf_remove_resource(const QemuUUID *uuid);<br>
<br>
=C2=A0/**<br>
- * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup tab=
le<br>
+ * virtio_dmabuf_lookup() - Looks for a dma-buf resource in the lookup tab=
le<br>
=C2=A0 * @uuid: resource&#39;s UUID<br>
=C2=A0 *<br>
=C2=A0 * Return: the dma-buf file descriptor integer, or -1 if the key is n=
ot found.<br>
=C2=A0 */<br>
-int virtio_lookup_dmabuf(const QemuUUID *uuid);<br>
+int virtio_dmabuf_lookup(const QemuUUID *uuid);<br>
<br>
=C2=A0/**<br>
- * virtio_lookup_vhost_device() - Looks for an exporter vhost device in th=
e<br>
- * lookup table<br>
+ * virtio_dmabuf_lookup_vhost_device() - Looks for an exporter vhost devic=
e<br>
+ * in the lookup table<br>
=C2=A0 * @uuid: resource&#39;s UUID<br>
=C2=A0 *<br>
=C2=A0 * Return: pointer to the vhost_dev struct, or NULL if the key is not=
 found.<br>
=C2=A0 */<br>
-struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);<br>
+struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid);=
<br>
<br>
=C2=A0/**<br>
- * virtio_object_type() - Looks for the type of resource in the lookup tab=
le<br>
+ * virtio_dmabuf_object_type() - Looks for the type of resource in the<br>
+ * lookup table<br>
=C2=A0 * @uuid: resource&#39;s UUID<br>
=C2=A0 *<br>
=C2=A0 * Return: the type of resource associated with the UUID, or TYPE_INV=
ALID if<br>
=C2=A0 * the key is not found.<br>
=C2=A0 */<br>
-SharedObjectType virtio_object_type(const QemuUUID *uuid);<br>
+SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid);<br>
<br>
=C2=A0/**<br>
=C2=A0 * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared=
<br>
@@ -102,9 +103,9 @@ SharedObjectType virtio_object_type(const QemuUUID *uui=
d);<br>
=C2=A0int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);<br>
<br>
=C2=A0/**<br>
- * virtio_free_resources() - Destroys all keys and values of the shared<br=
>
+ * virtio_dmabuf_free_resources() - Destroys all keys and values of the sh=
ared<br>
=C2=A0 * resources lookup table, and frees them<br>
=C2=A0 */<br>
-void virtio_free_resources(void);<br>
+void virtio_dmabuf_free_resources(void);<br>
<br>
=C2=A0#endif /* VIRTIO_DMABUF_H */<br>
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabu=
f.c<br>
index 1c8123c2d2..7471ed4fbd 100644<br>
--- a/tests/unit/test-virtio-dmabuf.c<br>
+++ b/tests/unit/test-virtio-dmabuf.c<br>
@@ -31,12 +31,12 @@ static void test_add_remove_resources(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf_fd =3D g_random_int_range(3, 500);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a new resource */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(&amp;uuid, dmabuf_f=
d));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_add(&amp;uuid, dmabuf_f=
d));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Remove the resource */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_remove_resource(&amp;uuid));<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_remove_resource(&amp;uu=
id));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Resource is not found anymore */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
), =3D=3D, -1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -48,13 +48,13 @@ static void test_add_remove_dev(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 100; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_vhost_device(&amp;uuid, dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_dmabuf_add_vhost_device(&amp;uuid, dev)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* vhost device is found */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid)=
 !=3D NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_lookup_vhost_device(&am=
p;uuid) !=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Remove the vhost device */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_remove_resource(&amp;uuid));<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_remove_resource(&amp;uu=
id));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* vhost device is not found anymore */<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid)=
 =3D=3D NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_lookup_vhost_device(&am=
p;uuid) =3D=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_free(dev);<br>
=C2=A0}<br>
@@ -66,9 +66,9 @@ static void test_remove_invalid_resource(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 20; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
), =3D=3D, -1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Removing a resource that does not exis=
t returns false */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_remove_resource(&amp;uui=
d));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_dmabuf_remove_resource(&=
amp;uuid));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -81,25 +81,25 @@ static void test_add_invalid_resource(void)<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 20; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a new resource with invalid (negat=
ive) resource fd */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_dmabuf(&amp;uuid, dm=
abuf_fd));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_dmabuf_add(&amp;uuid, dm=
abuf_fd));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Resource is not found */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
), =3D=3D, -1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a new vhost device with invalid (N=
ULL) pointer */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_vhost_device(&amp;uu=
id, dev));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_dmabuf_add_vhost_device(=
&amp;uuid, dev));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* vhost device is not found */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid)=
 =3D=3D NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_lookup_vhost_device(&am=
p;uuid) =3D=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 20; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a valid resource */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf_fd =3D g_random_int_range(3, 500);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(&amp;uuid, dmabuf_f=
d));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_add(&amp;uuid, dmabuf_f=
d));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a new resource with repeated uuid =
returns false */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_dmabuf(&amp;uuid, al=
t_dmabuf));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_dmabuf_add(&amp;uuid, al=
t_dmabuf));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The value for the uuid key is not repl=
aced */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -143,13 +143,13 @@ static void test_free_resources(void)<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuids[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf_fd =3D g_random_int_range(3, 500);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(&amp;uuids[i], dmab=
uf_fd));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
s[i]), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_dmabuf_add(&amp;uuids[i], dmab=
uf_fd));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
s[i]), =3D=3D, dmabuf_fd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 virtio_free_resources();<br>
+=C2=A0 =C2=A0 virtio_dmabuf_free_resources();<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* None of the resources is found after f=
ree&#39;d */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
s[i]), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_dmabuf_lookup(&amp;uuid=
s[i]), =3D=3D, -1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0}<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Agh I forgot to rename the function in=
 the new test after applying the last review.</div><div>I have it fixed in =
my local branch and passing the tests. I&#39;ll wait for feedback</div><div=
>on the other commits and push a new version after.</div><div>=C2=A0</div><=
/div></div>

--000000000000aa1ed2060bed2565--


