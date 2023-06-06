Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4294724355
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WEi-0006hB-U1; Tue, 06 Jun 2023 08:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q6WET-0006el-Cd
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q6WER-00060L-Pt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686056174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iR+uVeYKSsTilZF+NPiDLZp7Yohm9WoTfUmCDauuxk=;
 b=iqfZfIYnkQZbYIcIgQeLHIwNHRDc3/5UMGiNH8vV7ZFEtWcRKH3fTY4iwemCPiiWG6zddb
 XGhdMyu7eA3Ck8GhhclEXMve9zKYEpkyUt6VEX5+9s7Fr82dngBEUBxzRp/zZGLQY3VQvt
 Zhqq/yissL6yJ/6+B8SD+NI1ZI4sinU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-0apTS0HbPTGxNe8hmd0epw-1; Tue, 06 Jun 2023 08:56:13 -0400
X-MC-Unique: 0apTS0HbPTGxNe8hmd0epw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30af3835de5so2653174f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686056172; x=1688648172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iR+uVeYKSsTilZF+NPiDLZp7Yohm9WoTfUmCDauuxk=;
 b=ljZbjgGNjJiloY7tolod7zobrD6+J8r2jXTAUajICsDQUbtxEjUOZ4ctucHoOC2A1v
 NUTm6zsIoeazy0J8oXT8gt+8iuj5Sc6kTQhnuTqzIFt8T4FnFr5skf7b77wrA8WJNwUP
 iM/tYv34lnAlFcUQORqqjWMPzwDY2fE96Y19Y70dTjT7qsXjQFGVHnid2/l69wW9y42e
 E/H+C5AvacQV+T5nT6QOzUagOn6qTEFx1pjqNEvGUJw/rEmGTWCsjMmta1NmrKUM1B1A
 66xekFnfmyfRae/QL1VNF4sxS9xiV9f4Bn0rw1PAb1oLdRe+Uabt8Fwru06MwNLjsFNj
 sh2g==
X-Gm-Message-State: AC+VfDzAn4wRFEQavShUopFF+kARIfAgEiwPAXsmLJRop1OvyU8mjdoZ
 hWrez2zIkX0k2CRNPbolBMwt3kxM9OYRPVn+zKStDGyyJn/Elln9MonCRUxeiEW78dhHlvL3FUP
 TDyUlvt1kHnydUU8=
X-Received: by 2002:adf:dd01:0:b0:306:3ad3:94f2 with SMTP id
 a1-20020adfdd01000000b003063ad394f2mr1831212wrm.42.1686056172266; 
 Tue, 06 Jun 2023 05:56:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cjupFS/cUEdFVkFJX419PmxAkd3twYUTWJzySgoX0I5txuoviY/dmK1l7Oa1m1VLVpevkzA==
X-Received: by 2002:adf:dd01:0:b0:306:3ad3:94f2 with SMTP id
 a1-20020adfdd01000000b003063ad394f2mr1831196wrm.42.1686056171944; 
 Tue, 06 Jun 2023 05:56:11 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c00cc00b003f7678a07c4sm7240040wmm.29.2023.06.06.05.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 05:56:11 -0700 (PDT)
Date: Tue, 6 Jun 2023 08:56:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: correctly report maximum tx_queue_size value
Message-ID: <20230606085600-mutt-send-email-mst@kernel.org>
References: <20230605142125.3881859-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605142125.3881859-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Jun 05, 2023 at 04:21:25PM +0200, Laurent Vivier wrote:
> Maximum value for tx_queue_size depends on the backend type.
> 1024 for vDPA/vhost-user, 256 for all the others.
> 
> The value is returned by virtio_net_max_tx_queue_size() to set the
> parameter:
> 
>     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
>                                     n->net_conf.tx_queue_size);
> 
> But the parameter checking uses VIRTQUEUE_MAX_SIZE (1024).
> 
> So the parameter is silently ignored and ethtool reports a different
> value than the one provided by the user.
> 
>    ... -netdev tap,... -device virtio-net,tx_queue_size=1024
> 
>     # ethtool -g enp0s2
>     Ring parameters for enp0s2:
>     Pre-set maximums:
>     RX:		256
>     RX Mini:	n/a
>     RX Jumbo:	n/a
>     TX:		256
>     Current hardware settings:
>     RX:		256
>     RX Mini:	n/a
>     RX Jumbo:	n/a
>     TX:		256
> 
>    ... -netdev vhost-user,... -device virtio-net,tx_queue_size=2048
> 
>     Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024
> 
> With this patch the correct maximum value is checked and displayed.
> 
> For vDPA/vhost-user:
> 
>     Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024
> 
> For all the others:
> 
>     Invalid tx_queue_size (= 512), must be a power of 2 between 256 and 256
> 
> Fixes: 2eef278b9e63 ("virtio-net: fix tx queue size for !vhost-user")
> Cc: mst@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6df6b7329d25..e9905aac83ad 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3630,12 +3630,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
> -        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
> +        n->net_conf.tx_queue_size > virtio_net_max_tx_queue_size(n) ||
>          !is_power_of_2(n->net_conf.tx_queue_size)) {
>          error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
>                     "must be a power of 2 between %d and %d",
>                     n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
> -                   VIRTQUEUE_MAX_SIZE);
> +                   virtio_net_max_tx_queue_size(n));
>          virtio_cleanup(vdev);
>          return;
>      }
> -- 
> 2.39.2


