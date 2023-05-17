Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA83705FD0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzAVK-0005fT-4d; Wed, 17 May 2023 02:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1pzAVE-0005df-8p
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1pzAVC-00063k-KY
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684304349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VG8JmIs+ILdLUsQrOVDjekpEu+90RQso2XEyLg+s4uM=;
 b=VyGR/DNMXJr+VUtK1q3RFJNI4DyMaqxGak3b4I+dOuXw42dOgeTkk/xDaZjS5kEMn0HHJd
 /jLxn5QlllgShtjUYt5X43W49dJtlieQoBmELuiv+K4nIB/wYSVyTwc9z8QV9NtkVZB5SX
 E9WFXPsY3COCU+GtlDGz5WC2nPRuv/I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-RHT6_B_0PeekQeyrEWne-A-1; Wed, 17 May 2023 02:19:07 -0400
X-MC-Unique: RHT6_B_0PeekQeyrEWne-A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-969f12b2818so49248266b.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 23:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684304346; x=1686896346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VG8JmIs+ILdLUsQrOVDjekpEu+90RQso2XEyLg+s4uM=;
 b=SiaVs42vKxri/uUhEms5bF9jcwxr7iM0AEusCMWun8I2lDgxYWeiPuHH3fJa55BLLl
 GVnF0SG69xAi857g7mafz4CEwwzPV+VWmYySTQb0nnBnAMLMdpXyQG021J1x+cjaHFFK
 PQiC8MyLV0HiIgR1gyO+P8BhpBmHxXtQ3az6vD9JExwNEJozgTyCXkGpVce27+6K95CD
 mB2Z5plSkNClxfgJSCQujDDyYJCi3GQqtHHNaB5EwETnPP+7sa1d5V6TSM7nvecuBl8x
 xEHQZB+FHVlPrFQ+rR5VrFyaLWnDGrQ6rdgIY0xlYIVN5MZ0olcEsx0K8Yc2fA6FKn12
 xTRQ==
X-Gm-Message-State: AC+VfDyrCGey/RHoHxKHTYf/YMkmIifxT7S7HutZJziqkkM/V7GWFKXW
 59J/OPBmG7zEaIb6pXHPemdOoZFNee3/9SRaNttS5KRQNGcw7GpviknNgDy5+QF6lygrUryt7cW
 46CYbws7h1ocQfVxhipJiD8KzM6gHT/c=
X-Received: by 2002:a17:907:629b:b0:94e:2db:533e with SMTP id
 nd27-20020a170907629b00b0094e02db533emr36158160ejc.49.1684304346733; 
 Tue, 16 May 2023 23:19:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48SJk8TSu7NBZdyhl//bwE7ibKjuJYNeb9+URtafGjiBwo/5t8fjp6bdpPx21hY/5B0zRSvbkb4HbYWZgNYeY=
X-Received: by 2002:a17:907:629b:b0:94e:2db:533e with SMTP id
 nd27-20020a170907629b00b0094e02db533emr36158128ejc.49.1684304346372; Tue, 16
 May 2023 23:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
In-Reply-To: <20230509154435.1410162-1-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 17 May 2023 14:18:29 +0800
Message-ID: <CAPpAL=wG9pHL92kCaGYXUa2HSyUX0nhVX8yJpjA3KFvOK4EHKw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Move ASID test to vhost-vdpa net initialization
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, longpeng2@huawei.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, alvaro.karsz@solid-run.com, 
 Liuxiangdong <liuxiangdong5@huawei.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Jason Wang <jasowang@redhat.com>, si-wei.liu@oracle.com, 
 Shannon Nelson <snelson@pensando.io>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

QE tested this series with sanity testing on the vdpa_sim device,
everything are works fine and there is no any new regression problems.

Tested-by: Lei Yang <leiyang@redhat.com>



On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> QEMU v8.0 is able to switch dynamically between vhost-vdpa passthrough
> and SVQ mode as long as the net device does not have CVQ.  The net device
> state followed (and migrated) by CVQ requires special care.
>
> A pre-requisite to add CVQ to that framework is to determine if devices w=
ith
> CVQ are migratable or not at initialization time.  The solution to it is =
to
> always shadow only CVQ, and vq groups and ASID are used for that.
>
> However, current qemu version only checks ASID at device start (as "drive=
r set
> DRIVER_OK status bit"), not at device initialization.  A check at
> initialization time is required.  Otherwise, the guest would be able to s=
et
> and remove migration blockers at will [1].
>
> This series is a requisite for migration of vhost-vdpa net devices with C=
VQ.
> However it already makes sense by its own, as it reduces the number of io=
ctls
> at migration time, decreasing the error paths there.
>
> [1] https://lore.kernel.org/qemu-devel/2616f0cd-f9e8-d183-ea78-db1be4825d=
9c@redhat.com/
> ---
> v3:
> * Only record cvq_isolated, true if the device have cvq isolated in both =
!MQ
> * and MQ configurations.
> * Drop the cache of cvq group, it can be done on top
>
> v2:
> * Take out the reset of the device from vhost_vdpa_cvq_is_isolated
>   (reported by Lei Yang).
> * Expand patch messages by Stefano G. questions.
>
> Eugenio P=C3=A9rez (5):
>   vdpa: Remove status in reset tracing
>   vdpa: add vhost_vdpa_reset_status_fd
>   vdpa: add vhost_vdpa_set_dev_features_fd
>   vdpa: return errno in vhost_vdpa_get_vring_group error
>   vdpa: move CVQ isolation check to net_init_vhost_vdpa
>
>  include/hw/virtio/vhost-vdpa.h |   2 +
>  hw/virtio/vhost-vdpa.c         |  78 ++++++++++-----
>  net/vhost-vdpa.c               | 171 ++++++++++++++++++++++++++-------
>  hw/virtio/trace-events         |   2 +-
>  4 files changed, 192 insertions(+), 61 deletions(-)
>
> --
> 2.31.1
>
>


