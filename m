Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB77B1865
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 12:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qloQ5-0002W5-AJ; Thu, 28 Sep 2023 06:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qloQ0-0002VQ-UP
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 06:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qloPz-0001zn-3m
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 06:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695897528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnK8JkjWMUvMRHT/PwHGDLU6Sic9WQEtiERqJzZ66lw=;
 b=V2sYM1BtLudxV350Tyzbpr1z3M/UI726Sy63mcxI/3ZOy3I8IZ0shOjLSaepN6e2oPtujR
 SM2eUeCh8wnYcmoTJuXIqc/I4SOR85CwXQXB+tHwl3vBrxafivUxg5GQokKca6qRqS4Ogf
 lGcgt+lSQp281KOR1KuKBkvM0x+5kzE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-2jywacshOZ6x7mBOMLfGeg-1; Thu, 28 Sep 2023 06:38:46 -0400
X-MC-Unique: 2jywacshOZ6x7mBOMLfGeg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-59f8040b2ffso166054407b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 03:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695897526; x=1696502326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnK8JkjWMUvMRHT/PwHGDLU6Sic9WQEtiERqJzZ66lw=;
 b=rUi4/szndMW50balWgmYSWuS0Orl5AygWnD7PyzYAYYvsJRzgWZwhSlPibaaaX7QW4
 /OyxJKLCo3/MZwte5gb2mcbiUmbswZ5AW5qykoxD0vJut+QmpcLg/r52HGjIYPsVAZe+
 Wb+Op6rPn0HOhcnPVg57ShokSN7O91ZGjAeMwu7L5wa3ME2Eqk2DGfFXCC3+LW7qCUe5
 pZ+RgFzSqCc7hkyI2U+kVCWjsQ9LEgeXh6uRDqZWqJqPZYch39vw5mpzVfRTh6LCCO4o
 3sBbgPor2uWMyqyLEcLYem9J39HWkqFqjV4a+0++x14V8btqtrRXDGP8UfXqmpmaJpRb
 RBBg==
X-Gm-Message-State: AOJu0Yxx3eDTCqj5E6onjA19EYewemg0jNwcHu29GXKBo1fMc3tQ9Vnw
 aT1AfWsLiJExbhpnkB8Rt83WgyzGvmNMChKPeQCLzOJH2tyIYEgI1X2xoq+MgTor6Crdo0Y4scW
 pd1SJTox0BEBbJL6eqpVgCwXaXETS884=
X-Received: by 2002:a81:8481:0:b0:5a1:d8df:c457 with SMTP id
 u123-20020a818481000000b005a1d8dfc457mr780298ywf.12.1695897526224; 
 Thu, 28 Sep 2023 03:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6dPBJeYfEyhlHhUqcr4/mgtPnbMAVPHRMJo79T09DBQQZI9WHcMAZ0FV2lZ2fiaNalpZOmBlaPgueuklepWM=
X-Received: by 2002:a81:8481:0:b0:5a1:d8df:c457 with SMTP id
 u123-20020a818481000000b005a1d8dfc457mr780284ywf.12.1695897525998; Thu, 28
 Sep 2023 03:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192737.528280-1-stefanha@redhat.com>
In-Reply-To: <20230927192737.528280-1-stefanha@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 28 Sep 2023 12:38:09 +0200
Message-ID: <CAJaqyWfO6YUbif3RA+7YSs2hvqC0+8wsr7-WmzBvho4Qw0anNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost: clean up device reset
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 27, 2023 at 9:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Stateful vhost devices may need to free resources or clear device state u=
pon
> device reset. The vhost-user protocol has a VHOST_USER_RESET_DEVICE messa=
ge for
> this and vDPA has SET_STATUS 0, but only QEMU's vhost-user-scsi device ac=
tually
> implements this today.
>
> This patch series performs device reset across all device types. When
> virtio_reset() is called, the associated vhost_dev's ->vhost_reset_device=
() is
> called. vhost-user-scsi's one-off implementation is obsoleted and removed=
.
>
> This patch affects behavior as follows:
> - vhost-kernel: no change in behavior. No ioctl calls are made.
> - vhost-user: back-ends that negotiate
>   VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
>   VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
>   no change in behavior. DPDK, SPDK, libvhost-user, and the
>   vhost-user-backend crate do not negotiate
>   VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
> - vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.
>
> I have tested this series with vhost-net (kernel), vhost-user-blk, and
> vhost-user-fs (both Rust and legacy C).
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Stefan Hajnoczi (3):
>   vhost-user: do not send RESET_OWNER on device reset
>   vhost-backend: remove vhost_kernel_reset_device()
>   virtio: call ->vhost_reset_device() during reset
>
>  include/hw/virtio/vhost.h |  3 +++
>  hw/scsi/vhost-user-scsi.c | 20 --------------------
>  hw/virtio/vhost-backend.c |  6 ------
>  hw/virtio/vhost-user.c    | 13 +++++++++----
>  hw/virtio/vhost.c         |  9 +++++++++
>  hw/virtio/virtio.c        |  4 ++++
>  6 files changed, 25 insertions(+), 30 deletions(-)
>
> --
> 2.41.0
>


