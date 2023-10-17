Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17E7CC5A0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskmA-0001ym-W9; Tue, 17 Oct 2023 10:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qsklv-0001v0-82
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qskls-0002ap-Og
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697551806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yg0BxQP4watQNuZfbrry/wq+uD8hwmdMyjWMzuKiOIw=;
 b=FKwl+l+TK3tESq44b0q4evW07RwSta6l9oCsMoebLRTUH0Ua4v2EmRoKj0DUl/nviVncO/
 nmLU2/32zWAWzBrR06c3D6aaAEs2Hd5QFzN1O6WltfrIlp5hHkml34f60TORI7O7SOX4PL
 GX1THoM6YY0PNLLfyD76BQ8a9CImXgU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-LeCYszrINiGHRhJC3rwGcg-1; Tue, 17 Oct 2023 10:09:49 -0400
X-MC-Unique: LeCYszrINiGHRhJC3rwGcg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402cd372b8bso46115615e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551788; x=1698156588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yg0BxQP4watQNuZfbrry/wq+uD8hwmdMyjWMzuKiOIw=;
 b=a0nSYBFaLth6QaFcRcvL3CLLbiG2mGH9JRcdUo+8pXhEqPiqJKNTm1PiT9ibWUFZmL
 k0KogmsgxH0VDpu90rASqSFeYHCFHLht1+qgSEzUenIKSCSNtfmoykIAmYXL8/jznvIU
 QoL2gYmKuwTlA5LbuXeANTxud0nohvtz8Jf05YlNLNvqi3PLgCNz/orRloqwKu4C8JTb
 m47VaPFg3+9qy54Vy+ADa8tC6FfC35FXMeU4Z4PpVbEDFxeCkeadbzVQxuV2YW4a+Hoq
 006WLzh+w2j00KDArZ7m4YtA0x6zTI95D29zPpQx1rrDU/bkl9KrkR6ijmzXf0dEL8Dg
 vO6w==
X-Gm-Message-State: AOJu0Yw7+cMCMalQbdJKjaagWH3SPPZ0b5gvuQ/8UB3IS0Z2qV4j5wN8
 xVjyir/LtClycjyOohDENI9mg8pJrvHRCmVsCJT0zjOuZlOz4+G2ebZMVdUQb7z/22zPRIegnBi
 k9wQgksIERANd/MU=
X-Received: by 2002:adf:ce8b:0:b0:32d:a3c5:ea80 with SMTP id
 r11-20020adfce8b000000b0032da3c5ea80mr1928010wrn.51.1697551788281; 
 Tue, 17 Oct 2023 07:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqv0TvM8DNZrRmJX9n309H7sjtQefVcjv5lF75bXkaKTZC+JRxjAkqHd45epi+0HxbJwGo2A==
X-Received: by 2002:adf:ce8b:0:b0:32d:a3c5:ea80 with SMTP id
 r11-20020adfce8b000000b0032da3c5ea80mr1927985wrn.51.1697551787911; 
 Tue, 17 Oct 2023 07:09:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d27-20020adf9b9b000000b0031c52e81490sm1767110wrc.72.2023.10.17.07.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:09:47 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:09:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/7] hw: Few more QOM/QDev cleanups
Message-ID: <20231017100928-mutt-send-email-mst@kernel.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
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

On Tue, Oct 17, 2023 at 04:01:43PM +0200, Philippe Mathieu-Daudé wrote:
> - Remove a pointless check,
> - Use QOM cast macros,
> - Declare QDev links statically using DEFINE_PROP_LINK()

virtio things
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> Philippe Mathieu-Daudé (7):
>   hw/virtio/virtio-pmem: Replace impossible check by assertion
>   hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE() macros
>   hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
>   hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
>   hw/dma: Declare link using static DEFINE_PROP_LINK() macro
>   hw/net: Declare link using static DEFINE_PROP_LINK() macro
>   hw/usb: Declare link using static DEFINE_PROP_LINK() macro
> 
>  hw/block/vhost-user-blk.c |  4 ++--
>  hw/display/virtio-gpu.c   |  2 +-
>  hw/dma/xilinx_axidma.c    |  6 ++----
>  hw/dma/xlnx-zdma.c        |  7 ++-----
>  hw/dma/xlnx_csu_dma.c     | 13 ++++---------
>  hw/net/cadence_gem.c      |  7 ++-----
>  hw/scsi/virtio-scsi.c     |  2 +-
>  hw/usb/hcd-xhci-sysbus.c  |  4 ----
>  hw/usb/hcd-xhci.c         |  2 ++
>  hw/virtio/virtio-pmem.c   |  5 +----
>  10 files changed, 17 insertions(+), 35 deletions(-)
> 
> -- 
> 2.41.0


