Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D1706C58
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzIoO-0006hY-Pi; Wed, 17 May 2023 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzIoM-0006hO-LK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzIoJ-00063N-3m
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684336285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1GQKe79CzmWuk4EQf2AU7utlwtlJnXQ12okaLvXUc4=;
 b=QjTnRHX2GqVIMLoRfQr49PoxUm4fYxMzSuqFyGE4SKq3DBRi12CKfZ6hPBUOJH8UOXHphQ
 oWmRdOCvuPkVw4vNpd1d66Yg5kNdRxyUoQnsG/zRSvN2P0fhBNi9jkYpfvJriMovVGN3lH
 F+8wP0yPMnr/B5Olb0jSbXaMAe1a4d4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-VBUxevqWPBCPfUpXeygmzA-1; Wed, 17 May 2023 11:11:23 -0400
X-MC-Unique: VBUxevqWPBCPfUpXeygmzA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-24e3f2bff83so623007a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684336267; x=1686928267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1GQKe79CzmWuk4EQf2AU7utlwtlJnXQ12okaLvXUc4=;
 b=Bbik2f0bgvFg8bZzKhfSskfSGXRCRPXoH37wYZug8lhUZVqyluUiqR/NV3o9NiTI/7
 bi4SkngSrNr2/F5aGKwjYqwCq6P6TNx0XijCTL+7ixx3jTN/2VZ6ueiqrlpYTrH8gOfd
 IcwURWGklmT1D+IV7axpgocd3em4GwGmBlN0sTTe67HAaT2ThkhJvEUNbE0dGBVK7X1L
 Op9DCSueZdApE1Wm1VEov1meu3RFdzYPAdFQRXjAOLQ8/fn7GgCD/F2yfmU/qHt6/oGJ
 tBeu5NaD9u+Tvnls4NkU66PvKXj/7EUwQsqiGXlUoeNhsBMOvU8caqi2kaNdqc03Lc6q
 7NQw==
X-Gm-Message-State: AC+VfDwlpeImy3pYqoaZPZjAvp3AuQ7rk/xxl9O0UKR2WMvPgRf3i7U4
 dnMtqyBILNdRvIX6pxur5ack9zkZYuZMAhwsjoPV9V+lN705UWcy5sI3m6NMeaT5LhFOoa/lD0F
 SA4Juk4q1Dc9v+E9mdIQ64hTDZ3YCEgE=
X-Received: by 2002:a17:902:ab8f:b0:1ae:f37:c1a8 with SMTP id
 f15-20020a170902ab8f00b001ae0f37c1a8mr12621489plr.40.1684336267047; 
 Wed, 17 May 2023 08:11:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61/zE4/teGGOGcB9Ns0HY8iqU17p4HjVr4MgjRNMY0EcgU3hBNLbd3doR66O2ncJg1E+nUYnTgBVFor8bZ1ss=
X-Received: by 2002:a17:902:ab8f:b0:1ae:f37:c1a8 with SMTP id
 f15-20020a170902ab8f00b001ae0f37c1a8mr12621455plr.40.1684336266562; Wed, 17
 May 2023 08:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230503081911.119168-1-aesteve@redhat.com>
 <20230503081911.119168-2-aesteve@redhat.com>
 <CAJ+F1CJhFwU-w6qRFZkJmgghwWy3gkc5NADWSJ+3qOfJqO4T7Q@mail.gmail.com>
 <CADSE00LMD=YZsPAijSiKy_mcBehmEnYms3NAx=P4Sd9ia5VLzg@mail.gmail.com>
 <CAJ+F1CL-Do-wxGvkM1MCYAWtvftPturHoo-U8d=R+WqA21qsng@mail.gmail.com>
In-Reply-To: <CAJ+F1CL-Do-wxGvkM1MCYAWtvftPturHoo-U8d=R+WqA21qsng@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 17 May 2023 17:10:55 +0200
Message-ID: <CADSE00KLO2UtbSEV9WJ8KAa1dNP_HPoTWQCG+h+CA+7Cbh-rbw@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-dmabuf: introduce virtio-dmabuf
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d9e97c05fbe51894"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000d9e97c05fbe51894
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2023 at 2:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau <marcandre.lu=
reau@gmail.com>
wrote:

> Hi
>
> On Tue, May 9, 2023 at 4:53=E2=80=AFPM Albert Esteve <aesteve@redhat.com>=
 wrote:
>
>>
>>
>> On Tue, May 9, 2023 at 12:53=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
>> marcandre.lureau@gmail.com> wrote:
>>
>>> Hi
>>>
>>> On Wed, May 3, 2023 at 12:21=E2=80=AFPM Albert Esteve <aesteve@redhat.c=
om>
>>> wrote:
>>>
>>>> This API manages objects (in this iteration,
>>>> dmabuf fds) that can be shared along different
>>>> virtio devices.
>>>>
>>>> The API allows the different devices to add,
>>>> remove and/or retrieve the objects by simply
>>>> invoking the public functions that reside in the
>>>> virtio-dmabuf file.
>>>>
>>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>>> ---
>>>>  hw/display/meson.build            |   1 +
>>>>  hw/display/virtio-dmabuf.c        |  88 +++++++++++++++++++++++
>>>>  include/hw/virtio/virtio-dmabuf.h |  58 ++++++++++++++++
>>>>  tests/unit/meson.build            |   1 +
>>>>  tests/unit/test-virtio-dmabuf.c   | 112 +++++++++++++++++++++++++++++=
+
>>>>  5 files changed, 260 insertions(+)
>>>>  create mode 100644 hw/display/virtio-dmabuf.c
>>>>  create mode 100644 include/hw/virtio/virtio-dmabuf.h
>>>>  create mode 100644 tests/unit/test-virtio-dmabuf.c
>>>>
>>>> diff --git a/hw/display/meson.build b/hw/display/meson.build
>>>> index 17165bd536..62a27395c0 100644
>>>> --- a/hw/display/meson.build
>>>> +++ b/hw/display/meson.build
>>>> @@ -37,6 +37,7 @@ softmmu_ss.add(when: 'CONFIG_MACFB', if_true:
>>>> files('macfb.c'))
>>>>  softmmu_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
>>>>
>>>>  softmmu_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
>>>> +softmmu_ss.add(when: 'CONFIG_VIRTIO', if_true:
>>>> files('virtio-dmabuf.c'))
>>>>
>>>>  if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
>>>>      config_all_devices.has_key('CONFIG_VGA_PCI') or
>>>> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>>>> new file mode 100644
>>>> index 0000000000..3db939a2e3
>>>> --- /dev/null
>>>> +++ b/hw/display/virtio-dmabuf.c
>>>> @@ -0,0 +1,88 @@
>>>> +/*
>>>> + * Virtio Shared dma-buf
>>>> + *
>>>> + * Copyright Red Hat, Inc. 2023
>>>> + *
>>>> + * Authors:
>>>> + *     Albert Esteve <aesteve@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>>>> later.
>>>> + * See the COPYING file in the top-level directory.
>>>> + */
>>>> +
>>>> +#include "hw/virtio/virtio-dmabuf.h"
>>>> +
>>>> +
>>>> +#define UUID_TO_POINTER(i) \
>>>> +    ((gpointer)
>>>> (g_intern_static_string(qemu_uuid_unparse_strdup((&i)))))
>>>> +
>>>>
>>>
>>> This will leak.
>>>
>>>
>>
>> Where did you spot the issue? The reference operator at `&i`? The cast t=
o
>> gpointer?
>> I tried to mimic GINT_TO_POINTER macro here.
>>
>
> g_intern_static_string() takes a const char *, qemu_uuid_unparse_strdup()
> returns an allocated string which you don't track or free (which you are
> not supposed to with static_string). Anyway, you shouldn't need this API =
if
> you implement hash and equal func for UUID as suggested.
>
>
>>
>>> +
>>>> +static GMutex lock;
>>>> +static GHashTable *resource_uuids;
>>>> +
>>>>
>>>
>>> Rather than having global variables, shouldn't we associate virtio
>>> resources with the virtio bus instead?
>>>
>>>
>>
>> I am sorry but I am not sure how you mean. Wouldn't that mean to create =
a
>> virtio-pci device with
>> the virtio-dmabuf object? AFAIK the virtio-bus conforms the transport
>> layer for connecting to the guest.
>> The goal with virtio-dmabuf is "connecting" different virtio
>> backends, which are already connected to the
>> virtio-bus (and the guest). Strictly speaking not even that, just needs
>> to be accessible from different devices
>> to add and retrieve descriptors (dealing with concurrent accesses).
>>
>> But maybe I am not understanding your point!
>>
>
> All the virtio devices are attached to a virtio bus. Thus I think shared
> resource tracking should be implemented on the bus. Maybe Michael could
> comment on that first.
>

My idea was having the hash table available for all backends that need to
interact with it, hence I was not thinking of it as a virtio device that
needs to be added in the
command line (e.g., -device virtio-dmabuf-pci) to have it available. But I
guess that is what you are proposing?

I am preparing a v2 of this patch addressing all other comments but this
one. I hope that is ok. We can continue the discussion about how to handle
this on the
next version of the patch.

The other comment that I did not address was the one from Cornelia
regarding the location of the new files. Same thing, we can continue the
conversation over the next version. If there is a good point for having it
in another path in the project, I do not have problems moving it.
This is nearly my first patch, so still need to get a bit more familiar
with the project structure :)


>
>>
>>
>>
>>> +
>>>> +static bool virtio_add_resource(QemuUUID uuid, gpointer value)
>>>> +{
>>>> +    gpointer struuid =3D UUID_TO_POINTER(uuid);
>>>> +    if (resource_uuids =3D=3D NULL) {
>>>> +        resource_uuids =3D g_hash_table_new_full(NULL, NULL, NULL,
>>>> g_free);
>>>>
>>>
>>> You create "resource_uuids" implicitly in 2 places, in 2 different ways=
.
>>> Let's not do that, and have an explicit initialization step instead (it
>>> might be with the virtio bus construction, if we move the code there)
>>>
>>>
>> Ok!
>>
>>
>>> +    } else if (g_hash_table_lookup(resource_uuids, struuid) !=3D NULL)=
 {
>>>>
>>>
>>> You could implement a hash_func and key_equal_func for QemuUUID instead=
.
>>>
>>>
>>
>> Sounds like a good idea. I will add an initial, separate commit for that=
.
>>
>>
>>> +        return false;
>>>> +    }
>>>> +
>>>> +    return g_hash_table_insert(resource_uuids, struuid, value);
>>>> +}
>>>> +
>>>> +static gpointer virtio_lookup_resource(QemuUUID uuid)
>>>> +{
>>>> +    if (resource_uuids =3D=3D NULL) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    return g_hash_table_lookup(resource_uuids, UUID_TO_POINTER(uuid))=
;
>>>> +}
>>>> +
>>>> +bool virtio_add_dmabuf(QemuUUID uuid, int udmabuf_fd)
>>>> +{
>>>> +    bool result;
>>>> +    if (udmabuf_fd < 0) {
>>>> +        return false;
>>>> +    }
>>>> +    g_mutex_lock(&lock);
>>>> +    if (resource_uuids =3D=3D NULL) {
>>>> +        resource_uuids =3D g_hash_table_new(NULL, NULL);
>>>> +    }
>>>> +    result =3D virtio_add_resource(uuid, GINT_TO_POINTER(udmabuf_fd))=
;
>>>> +    g_mutex_unlock(&lock);
>>>> +
>>>> +    return result;
>>>> +}
>>>> +
>>>> +bool virtio_remove_resource(QemuUUID uuid)
>>>> +{
>>>> +    bool result;
>>>> +    g_mutex_lock(&lock);
>>>> +    result =3D g_hash_table_remove(resource_uuids,
>>>> UUID_TO_POINTER(uuid));
>>>> +    g_mutex_unlock(&lock);
>>>> +
>>>> +    return result;
>>>> +}
>>>> +
>>>> +int virtio_lookup_dmabuf(QemuUUID uuid)
>>>> +{
>>>> +    g_mutex_lock(&lock);
>>>> +    gpointer lookup_res =3D virtio_lookup_resource(uuid);
>>>> +    g_mutex_unlock(&lock);
>>>> +    if (lookup_res =3D=3D NULL) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    return GPOINTER_TO_INT(lookup_res);
>>>> +}
>>>> +
>>>> +void virtio_free_resources(void)
>>>> +{
>>>> +    g_hash_table_destroy(resource_uuids);
>>>> +    /* Reference count shall be 0 after the implicit unref on destroy
>>>> */
>>>> +    resource_uuids =3D NULL;
>>>> +}
>>>> diff --git a/include/hw/virtio/virtio-dmabuf.h
>>>> b/include/hw/virtio/virtio-dmabuf.h
>>>> new file mode 100644
>>>> index 0000000000..1c1c713128
>>>> --- /dev/null
>>>> +++ b/include/hw/virtio/virtio-dmabuf.h
>>>> @@ -0,0 +1,58 @@
>>>> +/*
>>>> + * Virtio Shared dma-buf
>>>> + *
>>>> + * Copyright Red Hat, Inc. 2023
>>>> + *
>>>> + * Authors:
>>>> + *     Albert Esteve <aesteve@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2.
>>>> + * See the COPYING file in the top-level directory.
>>>> + */
>>>> +
>>>> +#ifndef VIRTIO_DMABUF_H
>>>> +#define VIRTIO_DMABUF_H
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +
>>>> +#include <glib.h>
>>>> +#include "qemu/uuid.h"
>>>> +
>>>> +/**
>>>> + * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup tab=
le
>>>> + * @uuid: new resource's UUID
>>>> + * @dmabuf_fd: the dma-buf descriptor that will be stored and shared
>>>> with
>>>> + *             other virtio devices
>>>>
>>>
>>> The comment should be clear about fd ownership. In this case, it looks
>>> like it's the caller's responsibility to properly handle its lifecycle.
>>>
>>>
>>
>> Sure.
>>
>>
>>> + *
>>>> + * Note: @dmabuf_fd must be a valid (non-negative) file descriptor.
>>>> + *
>>>> + * Return: true if the UUID did not exist and the resource has been
>>>> added,
>>>> + * false if another resource with the same UUID already existed.
>>>> + * Note that if it finds a repeated UUID, the resource is not inserte=
d
>>>> in
>>>> + * the lookup table.
>>>> + */
>>>> +bool virtio_add_dmabuf(QemuUUID uuid, int dmabuf_fd);
>>>> +
>>>> +/**
>>>> + * virtio_remove_resource() - Removes a resource from the lookup tabl=
e
>>>> + * @uuid: resource's UUID
>>>> + *
>>>> + * Return: true if the UUID has been found and removed from the looku=
p
>>>> table.
>>>> + */
>>>> +bool virtio_remove_resource(QemuUUID uuid);
>>>> +
>>>> +/**
>>>> + * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the looku=
p
>>>> table
>>>> + * @uuid: resource's UUID
>>>> + *
>>>> + * Return: the dma-buf file descriptor integer, or -1 if the key is
>>>> not found.
>>>> + */
>>>> +int virtio_lookup_dmabuf(QemuUUID uuid);
>>>> +
>>>> +/**
>>>> + * virtio_free_resources() - Destroys all keys and values of the shar=
ed
>>>> + * resources lookup table, and frees them
>>>> + */
>>>> +void virtio_free_resources(void);
>>>>
>>>
>>> If it's part of the virtio bus, we won't need to have an API for it, it
>>> will be done as part of object destruction.
>>>
>>
>>>
>>>> +
>>>> +#endif /* VIRTIO_DMABUF_H */
>>>> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
>>>> index 3bc78d8660..eb2a1a8872 100644
>>>> --- a/tests/unit/meson.build
>>>> +++ b/tests/unit/meson.build
>>>> @@ -50,6 +50,7 @@ tests =3D {
>>>>    'test-qapi-util': [],
>>>>    'test-interval-tree': [],
>>>>    'test-xs-node': [qom],
>>>> +  'test-virtio-dmabuf': [meson.project_source_root() /
>>>> 'hw/display/virtio-dmabuf.c'],
>>>>  }
>>>>
>>>>  if have_system or have_tools
>>>> diff --git a/tests/unit/test-virtio-dmabuf.c
>>>> b/tests/unit/test-virtio-dmabuf.c
>>>> new file mode 100644
>>>> index 0000000000..063830c91c
>>>> --- /dev/null
>>>> +++ b/tests/unit/test-virtio-dmabuf.c
>>>> @@ -0,0 +1,112 @@
>>>> +/*
>>>> + * QEMU tests for shared dma-buf API
>>>> + *
>>>> + * Copyright (c) 2023 Red Hat, Inc.
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see <
>>>> http://www.gnu.org/licenses/>.
>>>> + *
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/virtio/virtio-dmabuf.h"
>>>> +
>>>> +
>>>> +static void test_add_remove_resources(void)
>>>> +{
>>>> +    QemuUUID uuid;
>>>> +    int i, dmabuf_fd;
>>>> +
>>>> +    for (i =3D 0; i < 100; ++i) {
>>>> +        qemu_uuid_generate(&uuid);
>>>> +        dmabuf_fd =3D g_random_int_range(3, 500);
>>>> +        /* Add a new resource */
>>>> +        g_assert(virtio_add_dmabuf(uuid, dmabuf_fd));
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuid), =3D=3D, dmabuf_fd=
);
>>>> +        /* Remove the resource */
>>>> +        g_assert(virtio_remove_resource(uuid));
>>>> +        /* Resource is not found anymore */
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuid), =3D=3D, -1);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void test_remove_invalid_resource(void)
>>>> +{
>>>> +    QemuUUID uuid;
>>>> +    int i;
>>>> +
>>>> +    for (i =3D 0; i < 20; ++i) {
>>>> +        qemu_uuid_generate(&uuid);
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuid), =3D=3D, -1);
>>>> +        /* Removing a resource that does not exist returns false */
>>>> +        g_assert_false(virtio_remove_resource(uuid));
>>>> +    }
>>>> +}
>>>> +
>>>> +static void test_add_invalid_resource(void)
>>>> +{
>>>> +    QemuUUID uuid;
>>>> +    int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;
>>>> +
>>>> +    for (i =3D 0; i < 20; ++i) {
>>>> +        qemu_uuid_generate(&uuid);
>>>> +        /* Add a new resource with invalid (negative) resource fd */
>>>> +        g_assert_false(virtio_add_dmabuf(uuid, dmabuf_fd));
>>>> +        /* Resource is not found */
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuid), =3D=3D, -1);
>>>> +    }
>>>> +
>>>> +    for (i =3D 0; i < 20; ++i) {
>>>> +        /* Add a valid resource */
>>>> +        qemu_uuid_generate(&uuid);
>>>> +        dmabuf_fd =3D g_random_int_range(3, 500);
>>>> +        g_assert(virtio_add_dmabuf(uuid, dmabuf_fd));
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuid), =3D=3D, dmabuf_fd=
);
>>>> +        /* Add a new resource with repeated uuid returns false */
>>>> +        g_assert_false(virtio_add_dmabuf(uuid, alt_dmabuf));
>>>> +        /* The value for the uuid key is not replaced */
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuid), =3D=3D, dmabuf_fd=
);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void test_free_resources(void)
>>>> +{
>>>> +    QemuUUID uuids[20];
>>>> +    int i, dmabuf_fd;
>>>> +
>>>> +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
>>>> +        qemu_uuid_generate(&uuids[i]);
>>>> +        dmabuf_fd =3D g_random_int_range(3, 500);
>>>> +        g_assert(virtio_add_dmabuf(uuids[i], dmabuf_fd));
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuids[i]), =3D=3D, dmabu=
f_fd);
>>>> +    }
>>>> +    virtio_free_resources();
>>>> +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
>>>> +        /* None of the resources is found after free'd */
>>>> +        g_assert_cmpint(virtio_lookup_dmabuf(uuids[i]), =3D=3D, -1);
>>>> +    }
>>>> +
>>>> +}
>>>> +
>>>> +int main(int argc, char **argv)
>>>> +{
>>>> +    g_test_init(&argc, &argv, NULL);
>>>> +    g_test_add_func("/virtio-dmabuf/add_rm_res",
>>>> test_add_remove_resources);
>>>> +    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
>>>> +                    test_remove_invalid_resource);
>>>> +    g_test_add_func("/virtio-dmabuf/add_invalid_res",
>>>> +                    test_add_invalid_resource);
>>>> +    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
>>>> +
>>>> +    return g_test_run();
>>>> +}
>>>> --
>>>> 2.40.0
>>>>
>>>>
>>>>
>>>
>>> --
>>> Marc-Andr=C3=A9 Lureau
>>>
>>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--000000000000d9e97c05fbe51894
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-family:RedHatTe=
xt,sans-serif;font-size:medium;margin-top:12px"><br></div></div></div></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Tue, May 9, 2023 at 2:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, May 9, 2023 at 4:53=E2=80=AFPM Albe=
rt Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"_blank">aeste=
ve@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div d=
ir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, May 9, 2023 at 12:53=E2=80=AFPM Ma=
rc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com" targ=
et=3D"_blank">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">H=
i<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Wed, May 3, 2023 at 12:21=E2=80=AFPM Albert Esteve &lt;<a href=3D"m=
ailto:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This API mana=
ges objects (in this iteration,<br>
dmabuf fds) that can be shared along different<br>
virtio devices.<br>
<br>
The API allows the different devices to add,<br>
remove and/or retrieve the objects by simply<br>
invoking the public functions that reside in the<br>
virtio-dmabuf file.<br>
<br>
Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" targ=
et=3D"_blank">aesteve@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +<br>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 88 ++++=
+++++++++++++++++++<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h |=C2=A0 58 ++++++++++++++++<br>
=C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 112 +++++++++++++++++++=
+++++++++++<br>
=C2=A05 files changed, 260 insertions(+)<br>
=C2=A0create mode 100644 hw/display/virtio-dmabuf.c<br>
=C2=A0create mode 100644 include/hw/virtio/virtio-dmabuf.h<br>
=C2=A0create mode 100644 tests/unit/test-virtio-dmabuf.c<br>
<br>
diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
index 17165bd536..62a27395c0 100644<br>
--- a/hw/display/meson.build<br>
+++ b/hw/display/meson.build<br>
@@ -37,6 +37,7 @@ softmmu_ss.add(when: &#39;CONFIG_MACFB&#39;, if_true: fil=
es(&#39;macfb.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_NEXTCUBE&#39;, if_true: files(&#39;n=
ext-fb.c&#39;))<br>
<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_VGA&#39;, if_true: files(&#39;vga.c&=
#39;))<br>
+softmmu_ss.add(when: &#39;CONFIG_VIRTIO&#39;, if_true: files(&#39;virtio-d=
mabuf.c&#39;))<br>
<br>
=C2=A0if (config_all_devices.has_key(&#39;CONFIG_VGA_CIRRUS&#39;) or<br>
=C2=A0 =C2=A0 =C2=A0config_all_devices.has_key(&#39;CONFIG_VGA_PCI&#39;) or=
<br>
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br>
new file mode 100644<br>
index 0000000000..3db939a2e3<br>
--- /dev/null<br>
+++ b/hw/display/virtio-dmabuf.c<br>
@@ -0,0 +1,88 @@<br>
+/*<br>
+ * Virtio Shared dma-buf<br>
+ *<br>
+ * Copyright Red Hat, Inc. 2023<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 =C2=A0 =C2=A0Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.c=
om" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
+<br>
+<br>
+#define UUID_TO_POINTER(i) \<br>
+=C2=A0 =C2=A0 ((gpointer) (g_intern_static_string(qemu_uuid_unparse_strdup=
((&amp;i)))))<br>
+<br></blockquote><div><br></div><div>This will leak.</div><div>=C2=A0<br><=
/div></div></div></blockquote><div><br></div><div>Where did you spot the is=
sue? The reference operator at `&amp;i`? The cast to gpointer?</div><div>I =
tried to mimic GINT_TO_POINTER macro here.</div></div></div></blockquote><d=
iv><br></div><div>g_intern_static_string() takes a const char *, qemu_uuid_=
unparse_strdup() returns an allocated string which you don&#39;t track or f=
ree (which you are not supposed to with static_string). Anyway, you shouldn=
&#39;t need this API if you implement hash and equal func for UUID as sugge=
sted.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_quote"><div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+static GMutex lock;<br>
+static GHashTable *resource_uuids;<br>
+<br></blockquote><div><br></div><div>Rather than having global variables, =
shouldn&#39;t we associate virtio resources with the virtio bus instead?</d=
iv><div>=C2=A0<br></div></div></div></blockquote><div><br></div><div>I am s=
orry but I am not sure how you mean. Wouldn&#39;t that mean to create a vir=
tio-pci device with</div><div>the virtio-dmabuf object? AFAIK the virtio-bu=
s conforms the transport layer for connecting to the guest.</div><div>The g=
oal with virtio-dmabuf is &quot;connecting&quot; different virtio backends,=
=C2=A0which are already connected to the</div><div>virtio-bus (and the gues=
t). Strictly speaking not even that, just needs to be accessible from diffe=
rent devices</div><div>to add and retrieve descriptors (dealing with concur=
rent accesses).</div><div><br></div><div>But maybe I am not understanding y=
our point!</div></div></div></blockquote><div><br></div><div>All the virtio=
 devices are attached to a virtio bus. Thus I think shared resource trackin=
g should be implemented on the bus. Maybe Michael could comment on that fir=
st.<br></div></div></div></blockquote><div><br></div><div>My idea was havin=
g the hash table available for all backends that need to interact with it, =
hence I was not thinking of it as a virtio device that needs to be added in=
 the</div><div>command line (e.g., -device virtio-dmabuf-pci) to have it av=
ailable. But I guess that=C2=A0is what you are proposing?</div><div>=C2=A0<=
/div><div>I am preparing a v2 of this patch addressing all other comments b=
ut this one. I hope that is ok. We can continue the discussion about how to=
 handle this on the</div><div>next version of the patch.</div><div><br></di=
v><div>The other comment that I did not address was the one from Cornelia r=
egarding the location of the new files. Same thing, we can continue the</di=
v><div>conversation over the next version. If there is a good point for hav=
ing it in another path in the project, I do not have problems moving it.</d=
iv><div>This is nearly my first patch, so still need to get a bit more fami=
liar with the project structure :)<br></div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_quote"><div></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+<br>
+static bool virtio_add_resource(QemuUUID uuid, gpointer value)<br>
+{<br>
+=C2=A0 =C2=A0 gpointer struuid =3D UUID_TO_POINTER(uuid);<br>
+=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_table_new_full(NULL,=
 NULL, NULL, g_free);<br></blockquote><div><br></div><div>You create &quot;=
resource_uuids&quot; implicitly in 2 places, in 2 different ways. Let&#39;s=
 not do that, and have an explicit initialization step instead (it might be=
 with the virtio bus construction, if we move the code there)<br></div><div=
><br></div></div></div></blockquote><div><br></div><div>Ok!</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
+=C2=A0 =C2=A0 } else if (g_hash_table_lookup(resource_uuids, struuid) !=3D=
 NULL) {<br></blockquote><div><br></div><div>You could implement a hash_fun=
c and key_equal_func for QemuUUID instead.</div><div>=C2=A0<br></div></div>=
</div></blockquote><div><br></div><div>Sounds like a good idea. I will add =
an initial, separate commit for that.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quo=
te"><div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return g_hash_table_insert(resource_uuids, struuid, value);<=
br>
+}<br>
+<br>
+static gpointer virtio_lookup_resource(QemuUUID uuid)<br>
+{<br>
+=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return g_hash_table_lookup(resource_uuids, UUID_TO_POINTER(u=
uid));<br>
+}<br>
+<br>
+bool virtio_add_dmabuf(QemuUUID uuid, int udmabuf_fd)<br>
+{<br>
+=C2=A0 =C2=A0 bool result;<br>
+=C2=A0 =C2=A0 if (udmabuf_fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_table_new(NULL, NULL=
);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 result =3D virtio_add_resource(uuid, GINT_TO_POINTER(udmabuf=
_fd));<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+bool virtio_remove_resource(QemuUUID uuid)<br>
+{<br>
+=C2=A0 =C2=A0 bool result;<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 result =3D g_hash_table_remove(resource_uuids, UUID_TO_POINT=
ER(uuid));<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+int virtio_lookup_dmabuf(QemuUUID uuid)<br>
+{<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 gpointer lookup_res =3D virtio_lookup_resource(uuid);<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+=C2=A0 =C2=A0 if (lookup_res =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return GPOINTER_TO_INT(lookup_res);<br>
+}<br>
+<br>
+void virtio_free_resources(void)<br>
+{<br>
+=C2=A0 =C2=A0 g_hash_table_destroy(resource_uuids);<br>
+=C2=A0 =C2=A0 /* Reference count shall be 0 after the implicit unref on de=
stroy */<br>
+=C2=A0 =C2=A0 resource_uuids =3D NULL;<br>
+}<br>
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-d=
mabuf.h<br>
new file mode 100644<br>
index 0000000000..1c1c713128<br>
--- /dev/null<br>
+++ b/include/hw/virtio/virtio-dmabuf.h<br>
@@ -0,0 +1,58 @@<br>
+/*<br>
+ * Virtio Shared dma-buf<br>
+ *<br>
+ * Copyright Red Hat, Inc. 2023<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 =C2=A0 =C2=A0Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.c=
om" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#ifndef VIRTIO_DMABUF_H<br>
+#define VIRTIO_DMABUF_H<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+<br>
+#include &lt;glib.h&gt;<br>
+#include &quot;qemu/uuid.h&quot;<br>
+<br>
+/**<br>
+ * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table<br=
>
+ * @uuid: new resource&#39;s UUID<br>
+ * @dmabuf_fd: the dma-buf descriptor that will be stored and shared with<=
br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0other virtio devices<br>=
</blockquote><div><br></div><div>The comment should be clear about fd owner=
ship. In this case, it looks like it&#39;s the caller&#39;s responsibility =
to properly handle its lifecycle.<br></div><div>=C2=A0<br></div></div></div=
></blockquote><div><br></div><div>Sure.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_q=
uote"><div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+ *<br>
+ * Note: @dmabuf_fd must be a valid (non-negative) file descriptor.<br>
+ *<br>
+ * Return: true if the UUID did not exist and the resource has been added,=
<br>
+ * false if another resource with the same UUID already existed.<br>
+ * Note that if it finds a repeated UUID, the resource is not inserted in<=
br>
+ * the lookup table.<br>
+ */<br>
+bool virtio_add_dmabuf(QemuUUID uuid, int dmabuf_fd);<br>
+<br>
+/**<br>
+ * virtio_remove_resource() - Removes a resource from the lookup table<br>
+ * @uuid: resource&#39;s UUID<br>
+ *<br>
+ * Return: true if the UUID has been found and removed from the lookup tab=
le.<br>
+ */<br>
+bool virtio_remove_resource(QemuUUID uuid);<br>
+<br>
+/**<br>
+ * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup tab=
le<br>
+ * @uuid: resource&#39;s UUID<br>
+ *<br>
+ * Return: the dma-buf file descriptor integer, or -1 if the key is not fo=
und.<br>
+ */<br>
+int virtio_lookup_dmabuf(QemuUUID uuid);<br>
+<br>
+/**<br>
+ * virtio_free_resources() - Destroys all keys and values of the shared<br=
>
+ * resources lookup table, and frees them<br>
+ */<br>
+void virtio_free_resources(void);<br></blockquote><div><br></div><div>If i=
t&#39;s part of the virtio bus, we won&#39;t need to have an API for it, it=
 will be done as part of object destruction.</div></div></div></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_quote"><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+<br>
+#endif /* VIRTIO_DMABUF_H */<br>
diff --git a/tests/unit/meson.build b/tests/unit/meson.build<br>
index 3bc78d8660..eb2a1a8872 100644<br>
--- a/tests/unit/meson.build<br>
+++ b/tests/unit/meson.build<br>
@@ -50,6 +50,7 @@ tests =3D {<br>
=C2=A0 =C2=A0&#39;test-qapi-util&#39;: [],<br>
=C2=A0 =C2=A0&#39;test-interval-tree&#39;: [],<br>
=C2=A0 =C2=A0&#39;test-xs-node&#39;: [qom],<br>
+=C2=A0 &#39;test-virtio-dmabuf&#39;: [meson.project_source_root() / &#39;h=
w/display/virtio-dmabuf.c&#39;],<br>
=C2=A0}<br>
<br>
=C2=A0if have_system or have_tools<br>
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabu=
f.c<br>
new file mode 100644<br>
index 0000000000..063830c91c<br>
--- /dev/null<br>
+++ b/tests/unit/test-virtio-dmabuf.c<br>
@@ -0,0 +1,112 @@<br>
+/*<br>
+ * QEMU tests for shared dma-buf API<br>
+ *<br>
+ * Copyright (c) 2023 Red Hat, Inc.<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see &lt;<a href=3D"http://www.=
gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/=
licenses/</a>&gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
+<br>
+<br>
+static void test_add_remove_resources(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 int i, dmabuf_fd;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 100; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D g_random_int_range(3, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new resource */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(uuid, dmabuf_fd));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuid), =
=3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Remove the resource */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_remove_resource(uuid));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Resource is not found anymore */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuid), =
=3D=3D, -1);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_remove_invalid_resource(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 20; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuid), =
=3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Removing a resource that does not exist ret=
urns false */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_remove_resource(uuid));<=
br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_add_invalid_resource(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 20; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new resource with invalid (negative) =
resource fd */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_dmabuf(uuid, dmabuf_=
fd));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Resource is not found */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuid), =
=3D=3D, -1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 20; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a valid resource */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D g_random_int_range(3, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(uuid, dmabuf_fd));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuid), =
=3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new resource with repeated uuid retur=
ns false */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_dmabuf(uuid, alt_dma=
buf));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The value for the uuid key is not replaced =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuid), =
=3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_free_resources(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuids[20];<br>
+=C2=A0 =C2=A0 int i, dmabuf_fd;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuids[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D g_random_int_range(3, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(uuids[i], dmabuf_fd=
));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuids[i])=
, =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 virtio_free_resources();<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* None of the resources is found after free&#=
39;d */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(uuids[i])=
, =3D=3D, -1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+=C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_rm_res&quot;, test_=
add_remove_resources);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/rm_invalid_res&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_remove_invalid_resource);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_invalid_res&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_add_invalid_resource);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/free_res&quot;, test_fr=
ee_resources);<br>
+<br>
+=C2=A0 =C2=A0 return g_test_run();<br>
+}<br>
-- <br>
2.40.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span>-- </span><br><div dir=3D"lt=
r">Marc-Andr=C3=A9 Lureau<br></div></div>
</blockquote></div></div>
</blockquote></div><br clear=3D"all"><br><span>-- </span><br><div dir=3D"lt=
r">Marc-Andr=C3=A9 Lureau<br></div></div>
</blockquote></div></div>

--000000000000d9e97c05fbe51894--


