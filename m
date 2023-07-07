Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED874AB10
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 08:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHeqv-0001BF-Aj; Fri, 07 Jul 2023 02:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHeqs-0001AR-UC
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 02:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHeqr-0006AC-3r
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 02:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688710915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nE8XpTjS3N1TlBB25qFWxi1qN0XGEwLfff9ZuZGceIA=;
 b=c7cy8/D1EUADYWd2TlEzaFc0Jbt1zUOGdrJWxf0mGlkNS77uFAn/qPU/vj9ZZC93hJpNTF
 fjpovMQzJAlem7yfRrQSrCDTIHRM4rQxCR0jxetYJVJXdx6uJRwNhcEW+JLbCb9+Gr8psl
 lQhaAAwo9MX3iFZRJkdamyZnoH2IKi4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-wu5D1qCCMG-NnMRpYknkWg-1; Fri, 07 Jul 2023 02:21:54 -0400
X-MC-Unique: wu5D1qCCMG-NnMRpYknkWg-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-c4e77129acfso1791837276.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 23:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688710914; x=1691302914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nE8XpTjS3N1TlBB25qFWxi1qN0XGEwLfff9ZuZGceIA=;
 b=j93E1Uymns1OsXeBGBGK8fmllCeICJ0cBHGj5G8Oilb3fVnsGqnkG/yBir2yFN7aP4
 fmYI5b4sfdwZHrOqMIZNo3cjWDhbsc3qTnjSSMQuRo7P7/Egi8wNqVYnjYOGSCqdpDAT
 d0YKL2cg3TaaHgSeIamnAN85NPnOy/ryYavlOw/32RA/MRJA5nqRXHtDo+7VElMeuXmC
 yIqX2JClHuKyEJFdgjv30PhpgzRh80hH632N3Ji6f41KZhn1tat3dALqv9ZyHFSVlohM
 o/V007RFHa4IsfnyT2nR/SKXC94AGG+X3sOGl/auzOh5PJfSwwPZguh9/i3Yzc8b6qN8
 z0mg==
X-Gm-Message-State: ABy/qLbHqW03vCvGPx12FTn+QWiELEYkNveA+sKp7eTiNo/EcpI1eHHx
 IaMU6jktl2u6RWM+cBYbPJMD4Jx2ofLQi3TTnu1JcktWFKMI++uZnK0kygMtyewlkLFF0vdwFyQ
 hr3flFmD3IqslW7nvrnDeWXGL6jhbw70=
X-Received: by 2002:a25:1856:0:b0:c63:a7fe:6dda with SMTP id
 83-20020a251856000000b00c63a7fe6ddamr4922242yby.23.1688710913837; 
 Thu, 06 Jul 2023 23:21:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHniyTev2vb+YMj2sgVBiGEf4d/TwEOHz0GCuSUTnMRjqZBZjOWGQetEPXCCm1uFa4+ZLoZNsOZ6b4MJjH8TRY=
X-Received: by 2002:a25:1856:0:b0:c63:a7fe:6dda with SMTP id
 83-20020a251856000000b00c63a7fe6ddamr4922235yby.23.1688710913602; Thu, 06 Jul
 2023 23:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706160139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706160139-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 7 Jul 2023 08:21:17 +0200
Message-ID: <CAJaqyWdj6idaXo-Yg9nYj_aV-kzoPqPzAEkv68RMcfNS8dH63Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Enable vdpa net migration with features depending
 on CVQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>, 
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>, 
 Shannon Nelson <snelson@pensando.io>, Gautam Dawar <gdawar@xilinx.com>, 
 Jason Wang <jasowang@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>, 
 Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 6, 2023 at 10:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 06, 2023 at 09:12:21PM +0200, Eugenio P=C3=A9rez wrote:
> > At this moment the migration of net features that depends on CVQ is not
> > possible, as there is no reliable way to restore the device state like =
mac
> > address, number of enabled queues, etc to the destination.  This is mai=
nly
> > caused because the device must only read CVQ, and process all the comma=
nds
> > before resuming the dataplane.
> >
> > This RFC lift that requirement, sending the VHOST_VDPA_SET_VRING_ENABLE=
 ioctl
> > for dataplane vqs only after the device has processed all commands.  If=
 this
> > method is valid or not, or if it must be signalled by the parent driver
> > somehow, is still under discussion.  In case it is valid, this code all=
ows
> > testing the vDPA device for it.
>
> And you plan to add the reset trick too in a future version?
>

I'll try to come with a version today.

At the current state of vDPA devices, it will just serve to enable
vp_vdpa to be the destination of a migration. But vp_vdpa cannot
migrate the guest again, so it is a dead end. I can try to add
_F_RING_RESET to vdpa_sim if that makes sense.

Anyway, as HW implement _F_RING_RESET, there should be no need to make
more changes to qemu, so we should be good.

> > Eugenio P=C3=A9rez (6):
> >   vdpa: export vhost_vdpa_set_vring_ready
> >   vdpa: add should_enable op
> >   vdpa: use virtio_ops->should_enable at vhost_vdpa_set_vrings_ready
> >   vdpa: add stub vhost_vdpa_should_enable
> >   vdpa: delay enable of data vqs
> >   vdpa: remove net cvq migration blocker
> >
> >  include/hw/virtio/vhost-vdpa.h |  9 +++++++
> >  hw/virtio/vhost-vdpa.c         | 33 +++++++++++++++++++------
> >  net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++---------
> >  hw/virtio/trace-events         |  2 +-
> >  4 files changed, 68 insertions(+), 21 deletions(-)
> >
> > --
> > 2.39.3
> >
>


