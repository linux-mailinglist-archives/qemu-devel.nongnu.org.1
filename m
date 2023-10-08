Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1A57BCCA3
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNER-0003Ji-DC; Sun, 08 Oct 2023 02:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpNEO-00032R-JR
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpNEM-0008Ir-1X
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696746332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ISXmeF+35VFO3PjG9dcF/hvSun6X2pxpQXcv2gcWX4=;
 b=MwIK0usOmGH8IyuAjRQeMwkjwftBX+Q9YcvyDtALuVm3LGBcgoqHpVJd7KjfwD6988m6Mi
 qx1rB3lkGrPiOMdzlq5ikUiiSiYvN/pX6X89W07u/5YEGx7s0mqjvGsr1yO9YCSYbLyYED
 OL1tzdJPtQOFZufJHcAKsWh9+9vL5Bk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644--BLL01SoMQmuosaer4N10Q-1; Sun, 08 Oct 2023 02:25:25 -0400
X-MC-Unique: -BLL01SoMQmuosaer4N10Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53342507b7fso2670151a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 23:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696746324; x=1697351124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ISXmeF+35VFO3PjG9dcF/hvSun6X2pxpQXcv2gcWX4=;
 b=RCEOxE21RhfwXe036ygH2he3c7wLGNBhQlfb23N1qTREA6Ok9eY5pSoKGdGOcLDm41
 Uhb9qYQgCOAjV5LXNG7/0G+A9skwEMIW/FAr1S898C4OMetDlIAP9hDJEY4LbGs9Sr8E
 pTMjI0KGYeBcK16XT49WkBdQfgFx6i53sY+Sv0Aff0g/87eCX6CWCWHYlAp8jZ9SabD0
 DjA6gMwwyp9kN1ZQYcUIxwjl8+lf4TSLjleX9ODCCNAk7RVn1fBDAKqMlZo52lGNEO3u
 G17ETn9+RMAl4wI40ZhqyD0jXu3YDNhHJ2YqYaF2lwnHDoJSbUYG3Dh3PDTgKz4gmhW6
 eKLg==
X-Gm-Message-State: AOJu0Yykh75ctY+xW3RavX4unFiNn+k5s1EZLyfrflkOYRgFTxeV28b5
 Sq1rWWsKWsyBnSSrlEj7rHDL+XsnfS9RwF8eZppDXnGu/fDhyrcANwjN/WIQY3LSpl1lR7JOpmI
 Wn2HkvRCFpZdus3w=
X-Received: by 2002:a05:6402:b35:b0:530:7ceb:334 with SMTP id
 bo21-20020a0564020b3500b005307ceb0334mr10495468edb.3.1696746324672; 
 Sat, 07 Oct 2023 23:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSR+yIKVmB2lZqcm2angrWuX/J40utyoNQuGaZ4Ivt/be+V/kjWmnGQcIVUAzG/BDexVp+6A==
X-Received: by 2002:a05:6402:b35:b0:530:7ceb:334 with SMTP id
 bo21-20020a0564020b3500b005307ceb0334mr10495461edb.3.1696746324412; 
 Sat, 07 Oct 2023 23:25:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a056402128a00b0053404772535sm4689922edv.81.2023.10.07.23.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 23:25:23 -0700 (PDT)
Date: Sun, 8 Oct 2023 02:25:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/6] tap: Fix virtio-net header buffer size
Message-ID: <20231008022442-mutt-send-email-mst@kernel.org>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
 <20231008052917.145245-2-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008052917.145245-2-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Sun, Oct 08, 2023 at 02:29:10PM +0900, Akihiko Odaki wrote:
> The largest possible virtio-net header is struct virtio_net_hdr_v1_hash.
> 
> Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

This thread is malformed BTW: cover letter seems to be
missing on list.


> ---
>  net/tap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index c6639d9f20..ea46feeaa8 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
>      TAPState *s = DO_UPCAST(TAPState, nc, nc);
>      const struct iovec *iovp = iov;
>      struct iovec iov_copy[iovcnt + 1];
> -    struct virtio_net_hdr_mrg_rxbuf hdr = { };
> +    struct virtio_net_hdr_v1_hash hdr = { };
>  
>      if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
>          iov_copy[0].iov_base = &hdr;
> @@ -136,7 +136,7 @@ static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t si
>      TAPState *s = DO_UPCAST(TAPState, nc, nc);
>      struct iovec iov[2];
>      int iovcnt = 0;
> -    struct virtio_net_hdr_mrg_rxbuf hdr = { };
> +    struct virtio_net_hdr_v1_hash hdr = { };
>  
>      if (s->host_vnet_hdr_len) {
>          iov[iovcnt].iov_base = &hdr;
> -- 
> 2.42.0
> 
> 


