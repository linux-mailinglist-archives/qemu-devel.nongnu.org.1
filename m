Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811FF802C96
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:01:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3st-0006C9-Ek; Mon, 04 Dec 2023 03:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3sk-000658-B5
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:00:51 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3sg-0002MR-Np
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:00:45 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b8bb35cbc3so649132b6e.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 00:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701676841; x=1702281641; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12qqqG0Oq3osef1ezTd6XszFmNR9P6BhWFieWguk13s=;
 b=E02wkxmhRHVIwagsTa+vFzy111XHsx3NKDu4Fkwr9EmnfwSDjKK54DsMHgLCAtJ0pY
 F/yZXkP6jp2VRpuwPcMskK/vFgR7NyuY001PuzGkJ2jDqFah3y2u0Fs2G946R/ARSnal
 rm5+MX53TabAXUNz75xxo75MmuG0akBwNXBqGMtnYp3ICB3EuYpoIGxacx+iDFimMjeF
 0ZTNpNUJrqb4XlsSB/taakKkPmxbCL/3JqY8Dq1F03saWaN3jpzbo6o/Cvn+PUr22WtO
 SC5HDCyhbR5OfWIYedzBXl76eQLR9u9SS11a5f6BoASHYQogyMYu25h7TvhInlzcpvnc
 VtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701676841; x=1702281641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12qqqG0Oq3osef1ezTd6XszFmNR9P6BhWFieWguk13s=;
 b=wpG2seiXfleoZ6lWgE1mTP9LZqDYy4AkUXxNgXQNi49Gtdw2YRfhxfypb4/tLvsfuI
 n2bIV5LRiAhLO0D9ey/ax6wQncPLRudfTlm/zcDiTYAN0B2dJRY0Dz4QYLVwl81d4KFF
 1Z8w0w8yRR/TpZG73Kbw9vq7bINGWSowNuor9Bp8oOLjFSvkKGAKxLtuSNSp/yY34xuO
 xJJHaQ1kKUMEHBrK4pUiBpp67ppc3m6uId7nu7FMbBUlZImNTWe7scSNmFrX7B/QUnch
 73hkqg8DjEzvebfhPKpx2G3TJPXT6At7qt0dEo5pOh51hVwDi3gaaMyCfjVh/3aSznYP
 hAPA==
X-Gm-Message-State: AOJu0Yx3moM/R/KfY7YyYBL0W+rg6cFKP0VbVa4nqZOqY9j5pHDyj703
 lXut7WYCHwXrPrkvbunw86FKiAOSctAn9CMJf+c=
X-Google-Smtp-Source: AGHT+IG2jr99y1GcKqnQG8v/iupQnXCo4npGrOS6YEgSAkyaJ33YsnENZS15vRP0bv/E+fAdQBpyrRIBJ84x+EcaKXk=
X-Received: by 2002:a05:6808:10c2:b0:3b8:b063:a1b9 with SMTP id
 s2-20020a05680810c200b003b8b063a1b9mr5256002ois.67.1701676841159; Mon, 04 Dec
 2023 00:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20231107093744.388099-1-aesteve@redhat.com>
 <20231107093744.388099-3-aesteve@redhat.com>
In-Reply-To: <20231107093744.388099-3-aesteve@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Dec 2023 12:00:30 +0400
Message-ID: <CAJ+F1C+2WXmKFCYJxNuz0mWW92JM9RxfizgU5uFtpOPEagxPFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/virtio: cleanup shared resources
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, stefanha@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x230.google.com
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

On Tue, Nov 7, 2023 at 1:37=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> Ensure that we cleanup all virtio shared
> resources when the vhost devices is cleaned
> up (after a hot unplug, or a crash).
>
> To track all owned uuids of a device, add
> a GSList to the vhost_dev struct. This way
> we can avoid traversing the full table
> for every cleanup, whether they actually
> own any shared resource or not.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c    | 2 ++
>  hw/virtio/vhost.c         | 4 ++++
>  include/hw/virtio/vhost.h | 6 ++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 5fdff0241f..04848d1fa0 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1598,6 +1598,7 @@ vhost_user_backend_handle_shared_object_add(struct =
vhost_dev *dev,
>      QemuUUID uuid;
>
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +    dev->shared_uuids =3D g_slist_append(dev->shared_uuids, &uuid);

This will point to the stack variable.

>      return virtio_add_vhost_device(&uuid, dev);
>  }
>
> @@ -1623,6 +1624,7 @@ vhost_user_backend_handle_shared_object_remove(stru=
ct vhost_dev *dev,
>      }
>
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +    dev->shared_uuids =3D g_slist_remove_all(dev->shared_uuids, &uuid);
>      return virtio_remove_resource(&uuid);
>  }
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9c9ae7109e..3aff94664b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/virtio-dmabuf.h"
>  #include "qemu/atomic.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
> @@ -1599,6 +1600,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>      migrate_del_blocker(&hdev->migration_blocker);
>      g_free(hdev->mem);
>      g_free(hdev->mem_sections);
> +    /* free virtio shared objects */
> +    g_slist_foreach(hdev->shared_uuids, (GFunc)virtio_remove_resource, N=
ULL);
> +    g_slist_free_full(g_steal_pointer(&hdev->shared_uuids), g_free);

(and will crash here)

Imho, you should just traverse the hashtable, instead of introducing
another list.

>      if (hdev->vhost_ops) {
>          hdev->vhost_ops->vhost_backend_cleanup(hdev);
>      }
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 5e8183f64a..376bc8446d 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -118,6 +118,12 @@ struct vhost_dev {
>       */
>      uint64_t protocol_features;
>
> +    /**
> +     * @shared_uuids: contains the UUIDs of all the exported
> +     * virtio objects owned by the vhost device.
> +     */
> +    GSList *shared_uuids;
> +
>      uint64_t max_queues;
>      uint64_t backend_cap;
>      /* @started: is the vhost device started? */
> --
> 2.41.0
>


--=20
Marc-Andr=C3=A9 Lureau

