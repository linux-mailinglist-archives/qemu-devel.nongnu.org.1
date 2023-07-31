Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC5768C21
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 08:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMav-0002sg-6A; Mon, 31 Jul 2023 02:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQMas-0002sD-Cg
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQMaq-0006jt-Ub
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690785684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqNcy01R5fjJB7XZ1ZripJdQGPMDIkzTskROtnBaoPk=;
 b=VdWMh8/RwYMnLNTDrT8BrkYuSPldZ/mqhbVmVhHqPwQ37sK15TBfvcaxMwoPD/QKjPKZy/
 AFefJYX5tEvm3ruXuGYu+jt9dvLYILOTUGQsqFnkjt7v+Rmq64iyGzkS/CUSoEetvwHsW7
 Kg3AlH7VPJykP4UV/TrEHHG4MNMf7E0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-b76VBNgDPdCdhWTozI46Hw-1; Mon, 31 Jul 2023 02:41:22 -0400
X-MC-Unique: b76VBNgDPdCdhWTozI46Hw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fe2f10381cso714713e87.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690785681; x=1691390481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqNcy01R5fjJB7XZ1ZripJdQGPMDIkzTskROtnBaoPk=;
 b=ep+I3ptGbqM2uHpszvzj6bOVDANOnJ5bkwDuuXKiy1QD5Q8jWguEr4Rmpu4vQw6OFV
 4sRoA/DdFlO7i6nHOlbcnOcogp0PRtSiNBGC/cDGs391Cj5eIaw/Z8UjMtd0WoS2bx4R
 abpZavo/niGVipxqt+hJuHC+/96NTgAHmj6XNY71lTeaPMQyWyx9YiCCnnmjIyV8DSHW
 ieNkDmgLCGqNWnpx2PRU/81mhgNu+KpHH1zerxsADRXDZj8vAuFIYsAffAui1gyINZjm
 6qMcPc6oHuij/TD2afoBqK658B/lS+M81VWJi9TmGDq8zYPcTTlXLQxIVMz30fzHE386
 KgEg==
X-Gm-Message-State: ABy/qLYugFi1vo4/5R2FhzTPhlZ30jP9+xMUD+lgxzMzjvw3aQqt9JPd
 lkZaMxR6s4SW+7tq8xCZ6KWDIMa7L7JqFbpRsJEmFBAJc9WHu9KvxspgA3Eq0P49BdiBKswHHZb
 yvCMgmLx6tC2TCDWxmcyOX1LQLUUSRDw=
X-Received: by 2002:a2e:9812:0:b0:2b9:5b06:b724 with SMTP id
 a18-20020a2e9812000000b002b95b06b724mr5880050ljj.42.1690785680874; 
 Sun, 30 Jul 2023 23:41:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXS7f+tQ5I3UICQqDIolazmr2AfYpG0kvn7/Uq5oTcB4ysMPq6X5RTHNoQ/9P4T2D9iWyz2IqIl/zwbiT0Yco=
X-Received: by 2002:a2e:9812:0:b0:2b9:5b06:b724 with SMTP id
 a18-20020a2e9812000000b002b95b06b724mr5880034ljj.42.1690785680576; Sun, 30
 Jul 2023 23:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230728172028.2074052-1-eperezma@redhat.com>
In-Reply-To: <20230728172028.2074052-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 31 Jul 2023 14:41:09 +0800
Message-ID: <CACGkMEsPRp5ieCXyVDu0z0xynATL8eeY5Dtb8QNPo7f2Gde=ww@mail.gmail.com>
Subject: Re: [PATCH 0/7] Enable vdpa net migration with features depending on
 CVQ
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Shannon Nelson <snelson@pensando.io>, Lei Yang <leiyang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Sat, Jul 29, 2023 at 1:20=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
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

I think it's better to explain (that is what I don't understand) why
we can not simply reorder vhost_net_start_one() in vhost_net_start()?

    for (i =3D 0; i < nvhosts; i++) {
        if (i < data_queue_pairs) {
            peer =3D qemu_get_peer(ncs, i);
        } else {
            peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
        }

        if (peer->vring_enable) {
            /* restore vring enable state */
            r =3D vhost_set_vring_enable(peer, peer->vring_enable);

            if (r < 0) {
                goto err_start;
            }
        }

=3D>      r =3D vhost_net_start_one(get_vhost_net(peer), dev);
        if (r < 0) {
            goto err_start;
        }
    }

Can we simply start cvq first here?

Thanks

> ---
> From FRC:
> * Enable vqs early in case CVQ cannot be shadowed.
>
> Eugenio P=C3=A9rez (7):
>   vdpa: export vhost_vdpa_set_vring_ready
>   vdpa: add should_enable op
>   vdpa: use virtio_ops->should_enable at vhost_vdpa_set_vrings_ready
>   vdpa: add stub vhost_vdpa_should_enable
>   vdpa: delay enable of data vqs
>   vdpa: enable cvq svq if data vq are shadowed
>   vdpa: remove net cvq migration blocker
>
>  include/hw/virtio/vhost-vdpa.h |  9 +++++
>  hw/virtio/vhost-vdpa.c         | 33 ++++++++++++----
>  net/vhost-vdpa.c               | 69 ++++++++++++++++++++++++++--------
>  hw/virtio/trace-events         |  2 +-
>  4 files changed, 89 insertions(+), 24 deletions(-)
>
> --
> 2.39.3
>
>


