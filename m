Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C478A585
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 08:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaVSl-0002WQ-4z; Mon, 28 Aug 2023 02:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qaVSh-0002WG-UH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 02:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qaVSf-0006OH-C0
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 02:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693203051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldUx1O2NtAdhNz06NEBBhCbdJ7u5ihyCRC0rZ1bGbW0=;
 b=MF4kVXWIx/GON7jv423DXHx4Jskjs2DZQLliMKSYvutj1Sfx0KgIWjU5vrXyXr7vxqy7xH
 PaoyYc6R+FPCIheowICcCEY9ZZNFm9YJtqp2HQiEj4PZ+nBonZ/Mwndvouo/IOdnOtvkKI
 1qVKwBxAjIUDDwhHhY5OcZzOfAqC0Ss=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-H0FKMbPUMBa9QbU-steaJA-1; Mon, 28 Aug 2023 02:10:49 -0400
X-MC-Unique: H0FKMbPUMBa9QbU-steaJA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso238305566b.1
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 23:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693203048; x=1693807848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldUx1O2NtAdhNz06NEBBhCbdJ7u5ihyCRC0rZ1bGbW0=;
 b=Yc3AWFsd0YLgjnK/iQqRIsceqyMT9rPF1ovhMP8eSrGe1wm2FJiYXP52+G3jj3WYen
 +MD9tCwuD59zsYvBWtbj+6pL0wiAITHx9Py+/VEi/l9CSGPqV72EzF7jQfBHdVxFi2bZ
 kfHzfaR9f/eBrkuMuhcVRWmfoOfJ8edWpsefbn2YZGWg7lmBVDwAXPcQBjl0RiJgyptP
 coidajXP8yaiR8XojIY1dtXsKuVvN0N9nrbdPFvWaqEty3ypOIyCcjlqwtfmdvgEj8ts
 lbR95hbpcGc6iJAYnYflUUxH+Jeln3i2wNlSLfMJekKYVLG7Kwaupnp9D/zabJU3KC+W
 D8fA==
X-Gm-Message-State: AOJu0Ywk6Gn6oShQ6Pow/H/6yEG3sMmPZfRMDqclEsWBue9FQhgCFKrz
 BMDToJZxhfxeIrcD0mzIr3zemyDVGsKUpdqNhbzw5Vew8M37K+RjNftCSz0YmUux1G87okdvybh
 GnpTHtkpn/OPLMfORovbDLBiWoF/Phxc=
X-Received: by 2002:a05:6402:2051:b0:522:b1cb:e6c with SMTP id
 bc17-20020a056402205100b00522b1cb0e6cmr18127512edb.38.1693203048586; 
 Sun, 27 Aug 2023 23:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSF9dExDIlCmqrK7d5ODqX4iiXGbXp8YsP0CFPVVRLOqK2ZxKveoa5wvbZHYcqo7674bKSJBllDrutHJ72ZCk=
X-Received: by 2002:a05:6402:2051:b0:522:b1cb:e6c with SMTP id
 bc17-20020a056402205100b00522b1cb0e6cmr18127497edb.38.1693203048344; Sun, 27
 Aug 2023 23:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822085330.3978829-1-eperezma@redhat.com>
In-Reply-To: <20230822085330.3978829-1-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 28 Aug 2023 14:10:11 +0800
Message-ID: <CAPpAL=xk0BjVODRoFOm-xebv98X=SD-MbCMGXp_bWbw6XqbeCg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable vdpa net migration with features depending
 on CVQ
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Harpreet Singh Anand <hanand@xilinx.com>, Shannon Nelson <snelson@pensando.io>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Gautam Dawar <gdawar@xilinx.com>, si-wei.liu@oracle.com, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

QE tested this series with MAC and MQ changes, and the guest migrated
successfully with "x-svq=3Doff" or without this parameter.

Tested-by: Lei Yang <leiyang@redhat.com>


On Tue, Aug 22, 2023 at 4:53=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> At this moment the migration of net features that depends on CVQ is not
> possible, as there is no reliable way to restore the device state like ma=
c
> address, number of enabled queues, etc to the destination.  This is mainl=
y
> caused because the device must only read CVQ, and process all the command=
s
> before resuming the dataplane.
>
> This series lift that requirement, sending the VHOST_VDPA_SET_VRING_ENABL=
E
> ioctl for dataplane vqs only after the device has processed all commands.
> ---
> v3:
> * Fix subject typo and expand message of patch ("vdpa: move
>   vhost_vdpa_set_vring_ready to the caller").
>
> v2:
> * Factor out VRING_ENABLE ioctls from vhost_vdpa_dev_start to the caller,
>   instead of providing a callback to know if it must be called or not.
> * at https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg05447.ht=
ml
>
> RFC:
> * Enable vqs early in case CVQ cannot be shadowed.
> * at https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01325.html
>
> Eugenio P=C3=A9rez (5):
>   vdpa: use first queue SVQ state for CVQ default
>   vdpa: export vhost_vdpa_set_vring_ready
>   vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load
>   vdpa: move vhost_vdpa_set_vring_ready to the caller
>   vdpa: remove net cvq migration blocker
>
>  include/hw/virtio/vhost-vdpa.h |  1 +
>  hw/virtio/vdpa-dev.c           |  3 ++
>  hw/virtio/vhost-vdpa.c         | 22 +++++-----
>  net/vhost-vdpa.c               | 75 +++++++++++++++++++---------------
>  hw/virtio/trace-events         |  2 +-
>  5 files changed, 57 insertions(+), 46 deletions(-)
>
> --
> 2.39.3
>
>


