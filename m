Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A377460FC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMmd-0002ZW-Cy; Mon, 03 Jul 2023 12:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGMmb-0002Z2-Gi
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGMmZ-0002Jo-KU
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688403130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aMPL2LI/U95JBGO4UAu+6Rj+z8HO64593+XgFIGYJN0=;
 b=EHsxDhLl2wfQPUx5bfBKRLMGVzTiVuFmCS4Ij7V+z8wNuGmLlLh1eZlEbOtD+Wqh+sG9/F
 KHvxfOGHoikovQeiIYfyubPISJsPMHBPbIToesewu/x2le2/NX7XPZVRBqI/Wo/K18UrYs
 xvWsT7faeV1pRutd0HBWulDMeasusQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-RBQEkhv1PnG-YMYTK5FDtw-1; Mon, 03 Jul 2023 12:52:09 -0400
X-MC-Unique: RBQEkhv1PnG-YMYTK5FDtw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fb8284465aso32747675e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688403128; x=1690995128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMPL2LI/U95JBGO4UAu+6Rj+z8HO64593+XgFIGYJN0=;
 b=cD5ClUVCFGHpE/KWu1vtvuDmj/loyfKghB0fuY+T4uDL+XHsMAZIASZiRt9sMBrNGL
 CAOdzVJ5/TSl0cN4giOlNKxpKQhFN/JmMMuW+Kk9hqwQCGdbWmKlNft5iKWLlvCOl1JE
 GNMdOtdyzyoaLq4kmwlosv7V1Ls69gLNQRtbMLBjVCsobdyAjTgvuJfTGYJ4/VIgv65g
 /K+NnBbs3MeKsSb4W1gIZOM8mDDoqIkb1v+hWaaS62D8qxljDrYmgR8UA7KERkmwWXqC
 Ahxz2sZ1vFWgrHS7E0CT7k1VL47VNQOsEhObTkFRsysM8SVTG9wv4c5Y6W4f1dgaqavh
 A+iQ==
X-Gm-Message-State: AC+VfDwjQqXNxZOO3NixE+R1mu/b6jNxKQSp92I5spRd8eKC+jRyKTGc
 wMsDHRGIM2T0qPuldfM2l8YmHxXMutVmJ2Aix+9VzvgPnlN5J4Nkm6EOH7PX+kksEIkIPQTD9GG
 OWbNaiNW9/lnLvY8Cy1VpYbc=
X-Received: by 2002:a7b:ce94:0:b0:3fb:a266:3a34 with SMTP id
 q20-20020a7bce94000000b003fba2663a34mr10308641wmj.12.1688403127900; 
 Mon, 03 Jul 2023 09:52:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LGgsha7n/Erl9W4k9+UzOcSyQLIl+k5Z2ppgld+PfzDIlnE7+4ptRb30FjB+PCm82vWu6Eg==
X-Received: by 2002:a7b:ce94:0:b0:3fb:a266:3a34 with SMTP id
 q20-20020a7bce94000000b003fba2663a34mr10308628wmj.12.1688403127618; 
 Mon, 03 Jul 2023 09:52:07 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 p8-20020a7bcc88000000b003fbdf8292a7sm97529wma.46.2023.07.03.09.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 09:52:06 -0700 (PDT)
Date: Mon, 3 Jul 2023 12:52:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 18801353760@163.com
Subject: Re: [PATCH RFC 1/1] vdpa: Return -EINVAL if device's ack is
 VIRTIO_NET_ERR
Message-ID: <20230703125134-mutt-send-email-mst@kernel.org>
References: <cover.1686746406.git.yin31149@gmail.com>
 <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 14, 2023 at 09:01:47PM +0800, Hawkins Jiawei wrote:
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
> `*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
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
> Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
> Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 37cdc84562..630c9bf71e 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -651,8 +651,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
>          if (unlikely(dev_written < 0)) {
>              return dev_written;
>          }
> -
> -        return *s->status != VIRTIO_NET_OK;
> +        if (*s->status != VIRTIO_NET_OK) {
> +            return -EINVAL;
> +        }
>      }
>  
>      return 0;
> @@ -676,8 +677,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
>      }
> +    if (*s->status != VIRTIO_NET_OK) {
> +        return -EINVAL;
> +    }
>  
> -    return *s->status != VIRTIO_NET_OK;
> +    return 0;
>  }

I think EIO would be better, we have too many EINVAL cases,
making things hard to debug.


>  
>  static int vhost_vdpa_net_load(NetClientState *nc)
> -- 
> 2.25.1


