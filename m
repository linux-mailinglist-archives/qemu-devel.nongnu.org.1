Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6E740919
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 06:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEMVe-0004sK-PA; Wed, 28 Jun 2023 00:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEMVV-0004s2-KS
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 00:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEMVT-0003m1-Eu
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 00:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687925412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17gvP8LzDNYgCJs9UcC3nA3AzVhmgbyEIcuDq5si6yM=;
 b=gG33JJVS5OP3vNhw2oy2mnqrwuH0WOLKA6+InarPkYwb5R/aKOLP/CaTJr+ufc+LVp3Oa1
 fev+XdIHb8piEYgoK9/OMHbLI9R5So52Vs9j7ImlYhzT6bWeeFUJh1/p5suBdr4N+ujtUn
 cJR7BYoSfFwFZ2BT/76x2WrUtg2CMZU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-Gyg-SBOwNZqXy5RrBLBfjQ-1; Wed, 28 Jun 2023 00:10:10 -0400
X-MC-Unique: Gyg-SBOwNZqXy5RrBLBfjQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb76659cacso2831397e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 21:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687925408; x=1690517408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17gvP8LzDNYgCJs9UcC3nA3AzVhmgbyEIcuDq5si6yM=;
 b=YkLUypSqzc2/Hxb28s1uhFvMLh23w3A4eWbS69OL6LhAwGiJajN/wM0SrrabLZnt3p
 u4NGX7lcIcreLadkhzotfamGJc2/yzVbxqiNZAk7YE1ribL4r6KiAY7Kk3j0U6qpwOr6
 ODXVMRxZdKKhRDk+xPM8fLy5NJg1fupZBdOVTJCZipgIDBmFNOmokGdYjydSp3blxpcr
 NUD02FDr63fNI1olFzM87vVuNS03ZTpQZdYHim8T1x6VdPb1OzkUZbOSYUJlkJ8vsbTp
 ORHpcjeWR6t8XaNO4kFM+QmvRJPBySGnqljZA6UG9MIIl3UWOH8XMXopZpLBp5C3WzXc
 UBWg==
X-Gm-Message-State: AC+VfDxRgOFrEtoNs3UTYsT16NvZ5s569WZ40PuhIugM25nffmX916p7
 YpL+178aXc/E/PfmsxrvsG51wzsSEbOi2Yzl7stHx18Di6t2tYe+HteLe/FQEbPEfALfeGuMZO2
 5GiPhqzqFbMFXbG5AbxAsd0/ahpoUyMs=
X-Received: by 2002:a05:6512:b8b:b0:4fa:ad2d:6c58 with SMTP id
 b11-20020a0565120b8b00b004faad2d6c58mr7784684lfv.61.1687925408586; 
 Tue, 27 Jun 2023 21:10:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gvwRwheyp0WGpnITScgcewgMe3NmyRNSR/aXhh9zdq9YHY/F9HYNICI8vwuTKTWPcSoAYiflKDOAnJtbaxp8=
X-Received: by 2002:a05:6512:b8b:b0:4fa:ad2d:6c58 with SMTP id
 b11-20020a0565120b8b00b004faad2d6c58mr7784674lfv.61.1687925408217; Tue, 27
 Jun 2023 21:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com>
In-Reply-To: <69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 12:09:56 +0800
Message-ID: <CACGkMEv6+W0HJAuUvbPRRn7HqdNXLbQhBE3o5BQd98Wz=r2KBQ@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Return -EINVAL if device ack is VIRTIO_NET_ERR
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-stable@nongnu.org, 
 qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 27, 2023 at 10:36=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> According to VirtIO standard, "The class, command and
> command-specific-data are set by the driver,
> and the device sets the ack byte.
> There is little it can do except issue a diagnostic
> if ack is not VIRTIO_NET_OK."
>
> Therefore, QEMU should stop sending the queued SVQ commands and
> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
>
> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
> `*s->status !=3D VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
> As a result, net->nc->info->load() also returns 1, this makes
> vhost_net_start_one() incorrectly assume the device state is
> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
> goto `fail` label to cancel the device startup, as vhost_net_start_one()
> only cancels the device startup when net->nc->info->load() returns a
> negative value.
>
> This patch fixes this problem by returning -EINVAL when the device's
> ack is not VIRTIO_NET_OK.
>
> Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa=
_net_load")
> Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
> Fixes: 0b58d3686a ("vdpa: Add vhost_vdpa_net_load_offloads()")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v2:
>  - fix the same bug in vhost_vdpa_net_load_offloads()
>
> v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e19ab063fa..6f6a5c6df6 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -646,8 +646,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s,=
 const VirtIONet *n)
>          if (unlikely(dev_written < 0)) {
>              return dev_written;
>          }
> -
> -        return *s->status !=3D VIRTIO_NET_OK;
> +        if (*s->status !=3D VIRTIO_NET_OK) {
> +            return -EINVAL;
> +        }
>      }
>
>      return 0;
> @@ -670,8 +671,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
>      }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return -EINVAL;
> +    }
>
> -    return *s->status !=3D VIRTIO_NET_OK;
> +    return 0;
>  }
>
>  static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
> @@ -708,8 +712,11 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
>      }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return -EINVAL;
> +    }
>
> -    return *s->status !=3D VIRTIO_NET_OK;
> +    return 0;
>  }
>
>  static int vhost_vdpa_net_load(NetClientState *nc)
> --
> 2.25.1
>


