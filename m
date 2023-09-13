Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3979E950
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPxd-0005qb-1L; Wed, 13 Sep 2023 09:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qgPxa-0005qI-Kd
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qgPxV-0000Tu-Te
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694611867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8em+ckyu93xvOSS/N4/Faz8KQ/soEJdBBJ+ajnYqlA=;
 b=jP6uaVmR9KND1oiO8idPEnPi5+34Q/w2SILJCY2DM1cpJzdcXCcjQdWpCFYyauECrvYtpc
 DsQKdBLultcWdlbdpvSya+0Ln4V7C7k5439aYAgXyekvLagY/MzrqKKe9puEi457txNWwX
 fCH6FHvAmg/ylCYr3dNzavBWgYUI1gA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-AI5ouLHJN4a-Ne_semQIWA-1; Wed, 13 Sep 2023 09:31:06 -0400
X-MC-Unique: AI5ouLHJN4a-Ne_semQIWA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-502d7ccdda3so1430626e87.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 06:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694611865; x=1695216665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8em+ckyu93xvOSS/N4/Faz8KQ/soEJdBBJ+ajnYqlA=;
 b=SkMi+r+ADjOutkG35rYBCJD9fEYcikykt006KIpQVLXTYCAMl7oKfOZQnVSWEAUZFk
 kcNnM2iBD6YrgUiMvI0YT3r/iLVm07SlZde+WK5uxblNgLOEqKb9x30TMbO1Acnzov4J
 wELIFr7bNdMW9mbGzYWBaEGEE1l7eI551VzfRDBpKgWrLHVuE8Z5auugQEyCMfGwp+ZS
 7GAdgSZF3kvSi0t+8h8COXww4rQNBKUr7mZmfXNubNbB3vo3S7ShUbPTK1QGFrWh+R7q
 D+XHEltRDO62yWMzFz6cm/LjrBjk9riOGoK1/mNuRdZvCBj2UuZ6Kd2h65qbfANp2Rkm
 ez9g==
X-Gm-Message-State: AOJu0Yzd6RVCDdXOeVJHHEkYHG01tHhqd4Ks5tSndl0XB6Kpp+w354Wl
 Gg0Sw8pBGXX2mfHimK7e8XddnOCv+E0zEIFnGvOcZcqdO75OnIxlpYeWquOHatU/OkWOFAMrwWX
 FZDnmhzVAcBEd59s=
X-Received: by 2002:a05:6512:2823:b0:502:a63c:113e with SMTP id
 cf35-20020a056512282300b00502a63c113emr2360822lfb.61.1694611864759; 
 Wed, 13 Sep 2023 06:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIHUAbleEtnSJ6IaIDWhrS0uye/y4oKocNfSgOmm/4BgA9BsivEvDKP3rfVSiJogPAGjYNjQ==
X-Received: by 2002:a05:6512:2823:b0:502:a63c:113e with SMTP id
 cf35-20020a056512282300b00502a63c113emr2360799lfb.61.1694611864388; 
 Wed, 13 Sep 2023 06:31:04 -0700 (PDT)
Received: from redhat.com ([2.52.10.100]) by smtp.gmail.com with ESMTPSA id
 y19-20020a17090668d300b0098884f86e41sm8333607ejr.123.2023.09.13.06.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 06:31:03 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:31:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC 0/7] vhost-vdpa: add support for iommufd
Message-ID: <20230913093042-mutt-send-email-mst@kernel.org>
References: <20230503091337.2130631-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503091337.2130631-1-lulu@redhat.com>
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

On Wed, May 03, 2023 at 05:13:30PM +0800, Cindy Lu wrote:
> Hi All
> There is the RFC to support the IOMMUFD in vdpa device
> any comments are welcome
> Thanks
> Cindy

Any plans to work on this or should I consider this abandoned?


> Cindy Lu (7):
>   vhost: introduce new UAPI to support IOMMUFD
>   qapi: support iommufd in vdpa
>   virtio : add a ptr for vdpa_iommufd in VirtIODevice
>   net/vhost-vdpa: Add the check for iommufd
>   vhost-vdpa: Add the iommufd support in the map/unmap function
>   vhost-vdpa: init iommufd function in vhost_vdpa start
>   vhost-vdpa-iommufd: Add iommufd support for vdpa
> 
>  hw/virtio/meson.build          |   2 +-
>  hw/virtio/vhost-vdpa-iommufd.c | 240 +++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-vdpa.c         |  74 +++++++++-
>  include/hw/virtio/vhost-vdpa.h |  47 +++++++
>  include/hw/virtio/virtio.h     |   5 +
>  linux-headers/linux/vhost.h    |  72 ++++++++++
>  net/vhost-vdpa.c               |  31 +++--
>  qapi/net.json                  |   1 +
>  8 files changed, 451 insertions(+), 21 deletions(-)
>  create mode 100644 hw/virtio/vhost-vdpa-iommufd.c
> 
> -- 
> 2.34.3


