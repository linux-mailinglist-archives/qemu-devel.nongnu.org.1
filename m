Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0D8C3BCD
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 09:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Puc-0007Xe-9p; Mon, 13 May 2024 03:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s6PuW-0007Rs-VY
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s6PuO-0003xC-Ae
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715584539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Rks1IZ6sWpiSsyg6FExR7CSGv5QVwsB+M8beTdZ7cQ=;
 b=hb0jZQrOH4aHXmU0ns6dPi0YFud9dtVAgo6HvgjA1ydtN5KXzsF6T2YfxziF99oCWtthJx
 H2YSShhepupDEMncHZ+zdlY0tTtmRIu3Q7YRKKcSIk9P+KMGf+h/qilkK1anQ/9ONWSn2X
 aQuOJNQHlojve9pvQ8x44lFPCdgPMAk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-h4-8Dy8BM6me2wW1bewDtA-1; Mon, 13 May 2024 03:15:36 -0400
X-MC-Unique: h4-8Dy8BM6me2wW1bewDtA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59caea8836so273247466b.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715584535; x=1716189335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Rks1IZ6sWpiSsyg6FExR7CSGv5QVwsB+M8beTdZ7cQ=;
 b=JVPlxxDA/sbUxlcGE5Tlo1vVhfE+DtKU2lhgtdQRKcXP8hLr7DiEGpB5zWla3Vg/jv
 AK+rWvElbGjp02Rc1m+5BjMwBn2RH5ZQpE0SV6jmrojab4pJuryCUqj3/lPFGD8p2H/L
 2TwlDX5TwXO4h48eFuEd/hf1/qSgV+slSnUxS5v+bw2PAkXOXudOzxhpugsUS7fgzhbX
 YKM935DUPlevz4VKzW/eqlMpeRzo8wuX6wyfT5HJ/dH+k3IZrpXIOn4jfoHrc7rgtCSA
 O2ukZ1bN/LRwluIBLbo4dRzrqfx7MpxkyktdMkI0UzSq0dso3BS57dP17auCDmtPr9QM
 dNkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnNBJ3SATMLWwAkyWFtdMTmLlj4kJFCw7+6wQySHCW8YD0iTPFBa9DnAIoDgE8NoQSoE4aaUw10qI0tfVJErYihXozSaU=
X-Gm-Message-State: AOJu0Yy+9osN5vk+AJiGKHx7wXHBqSudeTqh5IaoheBoSq40AP135n/5
 L7BTCedSMq7WUPBqVOjxv6ghjKEuA7XBWPuSE8AYn1QaF7Yk0JvDvFEsHyjbb4QFTsgPyXb03dh
 7LQY31tf5enUN6C3IN/lD9GtOCytaHnjG6zL92BhMOHYwa4VqTFEU
X-Received: by 2002:a17:906:7f8a:b0:a59:b6a8:4d7a with SMTP id
 a640c23a62f3a-a5a2d5d3d22mr584883466b.43.1715584534858; 
 Mon, 13 May 2024 00:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAwGIU01itCC0xJF3mM+lLe5+wGwJ8ydLV18v/7T/+MpUVg9Q3kUhYtEi4wqWEus8e/5cNCg==
X-Received: by 2002:a17:906:7f8a:b0:a59:b6a8:4d7a with SMTP id
 a640c23a62f3a-a5a2d5d3d22mr584881266b.43.1715584534346; 
 Mon, 13 May 2024 00:15:34 -0700 (PDT)
Received: from redhat.com ([31.187.78.170]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d5a4sm553683166b.2.2024.05.13.00.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:15:33 -0700 (PDT)
Date: Mon, 13 May 2024 03:15:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 1/2] Revert "vhost-user: fix lost reconnect"
Message-ID: <20240513031501-mutt-send-email-mst@kernel.org>
References: <20240513071052.129581-1-fengli@smartx.com>
 <20240513071052.129581-2-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513071052.129581-2-fengli@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 13, 2024 at 03:10:47PM +0800, Li Feng wrote:
> This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.
> 


include subject of reverted commit and motivation for the revert pls.


> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/block/vhost-user-blk.c      |  2 +-
>  hw/scsi/vhost-user-scsi.c      |  3 +--
>  hw/virtio/vhost-user-base.c    |  2 +-
>  hw/virtio/vhost-user.c         | 10 ++--------
>  include/hw/virtio/vhost-user.h |  3 +--
>  5 files changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9e6bbc6950..41d1ac3a5a 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &s->chardev, &s->dev,
> -                               vhost_user_blk_disconnect, vhost_user_blk_event);
> +                               vhost_user_blk_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a63b1f4948..48a59e020e 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> -                               vhost_user_scsi_disconnect,
> -                               vhost_user_scsi_event);
> +                               vhost_user_scsi_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index a83167191e..4b54255682 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
> -                               vub_disconnect, vub_event);
> +                               vub_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..c929097e87 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2776,7 +2776,6 @@ typedef struct {
>      DeviceState *dev;
>      CharBackend *cd;
>      struct vhost_dev *vhost;
> -    IOEventHandler *event_cb;
>  } VhostAsyncCallback;
>  
>  static void vhost_user_async_close_bh(void *opaque)
> @@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void *opaque)
>       */
>      if (vhost->vdev) {
>          data->cb(data->dev);
> -    } else if (data->event_cb) {
> -        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
> -                                 NULL, data->dev, NULL, true);
> -   }
> +    }
>  
>      g_free(data);
>  }
> @@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void *opaque)
>   */
>  void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhost,
> -                            vu_async_close_fn cb,
> -                            IOEventHandler *event_cb)
> +                            vu_async_close_fn cb)
>  {
>      if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>          /*
> @@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
>          data->dev = d;
>          data->cd = chardev;
>          data->vhost = vhost;
> -        data->event_cb = event_cb;
>  
>          /* Disable any further notifications on the chardev */
>          qemu_chr_fe_set_handlers(chardev,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index d7c09ffd34..324cd8663a 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
>  
>  void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhost,
> -                            vu_async_close_fn cb,
> -                            IOEventHandler *event_cb);
> +                            vu_async_close_fn cb);
>  
>  #endif
> -- 
> 2.45.0


