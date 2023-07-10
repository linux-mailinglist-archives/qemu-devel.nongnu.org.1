Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0674CAD7
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 05:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIhrQ-0001Cj-IX; Sun, 09 Jul 2023 23:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhrP-0001Cb-Ey
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhrN-0004YA-Vk
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688960807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9N+efbssWQ2cfV4BsF5F+HDelVrLpstTII9fxSi3hI=;
 b=dSiO3MvYkuEKeKe7RhGk3j1TxtgYXRn4Q67l1Giow2D3DBkCKbb4mA7gw1Z1CPCbRVKQPm
 Hfbl1nc57CE7tNlzAI/OqvskiH0Sjf92ERcXCMFvQo2Cf6Qdu7+rjAUL6nmRDUE5f1Mmzn
 TNPv+BMJX1jDMVuyKiZvGjdnedhQOKE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-k8nTzjKmNgK8sbQZAa0KHg-1; Sun, 09 Jul 2023 23:46:46 -0400
X-MC-Unique: k8nTzjKmNgK8sbQZAa0KHg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b708d79112so34083561fa.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 20:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688960804; x=1691552804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9N+efbssWQ2cfV4BsF5F+HDelVrLpstTII9fxSi3hI=;
 b=WyOtZCy1aZjTrqEU9BkHXNMm6Z2sxVjsqrX4oV2Sb3OzgYGyPEfsLuAhjUgN4+kErR
 MyKcA6IQ4+ICUXnQJvWYCNANXVwXNfwvxuDHnUYqgT2ooTYjGg5yKpiUSU5UOZ9mxl/2
 d1qk7dISU6VFsc9J6qphfLBH5za070J7xFmTDFQFdEOne+5oy3kq60o5s3A+bBGxsnhL
 lWVY6L7UTgQhnQrC59u60XTtvesR52q8CUdV21ndHTLZeYx1hBtFC7ZZTzHVS66yZSgy
 OiKxcVXZLRbAsOYjXqjqkntFY4aiaZ+4hXWeQrOcc6PNuVtDPFLSo0XlHOJVXHcWUEc4
 1wPg==
X-Gm-Message-State: ABy/qLYsDWFV+cyj++zqQLw3/anMypeTIUrE+PJVEr+S/JBRTgkgFU3G
 K4M1fwfKq0cFlZrNDSgl3QJWkpDHxTtI4qJlu8536PIw5XDzaNqwj4FzSTnnkiqipSjzKl+q4yC
 oMnKwfVgFpEDc2XH2HL+Jy1NOoWOxi08=
X-Received: by 2002:a2e:9844:0:b0:2b6:de6d:9e22 with SMTP id
 e4-20020a2e9844000000b002b6de6d9e22mr8074636ljj.40.1688960804635; 
 Sun, 09 Jul 2023 20:46:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFUqfJFlrxTXXcrAEoXy0woEdUV+STNhqDnY2NyOYYNjOCq5mtALJdgzHErAHHWR+V4iKDTMFsXNZpnNY4bOCc=
X-Received: by 2002:a2e:9844:0:b0:2b6:de6d:9e22 with SMTP id
 e4-20020a2e9844000000b002b6de6d9e22mr8074624ljj.40.1688960804369; Sun, 09 Jul
 2023 20:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-3-eperezma@redhat.com>
In-Reply-To: <20230706191227.835526-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:46:33 +0800
Message-ID: <CACGkMEsuDikKkh2KuZM+PTi3E5vK4j-8sRq3-XmQo=ADoqzhfg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] vdpa: add should_enable op
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> To restore the device at the destination of a live migration we send the
> commands through control virtqueue.  For a device to read CVQ it must
> have received the DRIVER_OK status bit.
>
> However this opens a window where the device could start receiving
> packets in rx queue 0 before it receives the RSS configuration.

I think this can also happen in the case of automatic steering.

> To
> avoid that, we will not send vring_enable until all configuration is
> used by the device.
>
> As a first step, enable a new vitio ops per vhost_vdpa device to know if
> we should enable a virtqueue or not.  This srtuct can be reused in the

typo.

Thanks

> future to add more actions to vhost_vdpa that depend on the virtIO kind
> of device.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  include/hw/virtio/vhost-vdpa.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 5407d54fd7..3d330d439a 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -30,6 +30,13 @@ typedef struct VhostVDPAHostNotifier {
>      void *addr;
>  } VhostVDPAHostNotifier;
>
> +struct vhost_vdpa;
> +typedef bool (*vhost_vdpa_virtio_should_enable_op)(const struct vhost_vd=
pa *v);
> +
> +typedef struct VhostVDPAVirtIOOps {
> +    vhost_vdpa_virtio_should_enable_op should_enable;
> +} VhostVDPAVirtIOOps;
> +
>  typedef struct vhost_vdpa {
>      int device_fd;
>      int index;
> @@ -48,6 +55,7 @@ typedef struct vhost_vdpa {
>      VhostIOVATree *iova_tree;
>      GPtrArray *shadow_vqs;
>      const VhostShadowVirtqueueOps *shadow_vq_ops;
> +    const VhostVDPAVirtIOOps *virtio_ops;
>      void *shadow_vq_ops_opaque;
>      struct vhost_dev *dev;
>      Error *migration_blocker;
> --
> 2.39.3
>


