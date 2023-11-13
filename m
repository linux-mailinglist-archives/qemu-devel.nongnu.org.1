Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B97E96AD
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 07:30:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2QSY-0003oW-TP; Mon, 13 Nov 2023 01:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r2QSO-0003dT-7d
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r2QSM-00009C-Ia
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699856996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Mb0eKL822Fl8fLvSSyGy4Y4Y1gZVm3f4JhO1Q7Bm/U=;
 b=DPxoTiNhM/drZc2K/tEjjYoMMyqQZJ+y5cArXfcIyAssiYTRbBTZ3s/r69q4MPfpmXDM9V
 6Yp4A/FDgtq0Iwi5qi7l0o5Oyi8ApJWC+xEZXjp+if+3cRFLYm/ZYDeAAnmNgYgJcaO8zc
 f8u1Hq/rSx5EL+AoHo0t8RfnoQeYiEE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-4hFUNvnWPiqDmHNPqAPriA-1; Mon, 13 Nov 2023 01:29:54 -0500
X-MC-Unique: 4hFUNvnWPiqDmHNPqAPriA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32f68d3b788so1977285f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 22:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699856993; x=1700461793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Mb0eKL822Fl8fLvSSyGy4Y4Y1gZVm3f4JhO1Q7Bm/U=;
 b=AF/9BSEkZrwCevwwJgN9tPZGtBPi0hLZgUKsP91sgEzOJLdiTl96pGIdDiyYB79GxC
 GJ9PCCs/rB2/W1kODjwewpGERDWOmW6RqMf5YEnXT9bxWQaGxXYYW41uHsrRBa4xjbbg
 d1iBuAPVxP0GdBPNlNAfJfGiI36i03Vt1vRKuqeiiCDhDXFdsTFRtUA8XdtwiGBo1umK
 1Z4iEjopCNjsFztSq86WxUMujW1bDp6VckCf6SjMONZjUuRCzYfBvutOKLuYl9TJcNmb
 c+8iN2s7yb20bzNeRDOjeJdtrfCSW6U7ZsHDTGq/8GMRcwSyUmbroHI7JOO3Vy8bOKfa
 qHKw==
X-Gm-Message-State: AOJu0Yw6htlobJgIpIsQrckgxvCytOUUQbzeypH5d7Ki929tZJkFDlbh
 xNSv0QATN64NGHZrnxokOq0/3RsW63ozz13cnv34hce8ZjffMri9kF80NYIyqb/FWP1tg4d1boT
 9XUHqjTI2DZQNrMs=
X-Received: by 2002:a05:6000:bce:b0:324:8239:2873 with SMTP id
 dm14-20020a0560000bce00b0032482392873mr3398633wrb.37.1699856993501; 
 Sun, 12 Nov 2023 22:29:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhUkmhohzTGUrl2MF7Exhxi0bkmNwfSmBL8KrDW5OPyxDvtu30uO5DiWoj5xQOwsx88BC17Q==
X-Received: by 2002:a05:6000:bce:b0:324:8239:2873 with SMTP id
 dm14-20020a0560000bce00b0032482392873mr3398628wrb.37.1699856993197; 
 Sun, 12 Nov 2023 22:29:53 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f2:e100:f288:9238:4f0d:83ab])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5d4b43000000b0032cc35c2ef7sm4597884wrs.29.2023.11.12.22.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 22:29:52 -0800 (PST)
Date: Mon, 13 Nov 2023 01:29:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v1 0/4] virtio: Refactor vhost input stub
Message-ID: <20231113012849-mutt-send-email-mst@kernel.org>
References: <20231113011642.48176-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113011642.48176-1-leo.yan@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Nov 13, 2023 at 09:16:38AM +0800, Leo Yan wrote:
> This series is to refactor vhost stub vhost-user-input.
> 
> Since vhost input stub requires set_config() callback for communication
> event configurations between the backend and the guest, patch 01 is a
> preparison for support set_config() callback in vhost-user-base.
> 
> The patch 02 is to add documentation for vhost-user-input.
> 
> The patch 03 is to move virtio input stub from the input folder to the
> virtio folder.
> 
> The patch 04 derives vhost-user-input from vhost-user-base.  We reuse
> the common code from vhhost-user-base as possible and the input stub is
> simplized significantly.
> 
> This patch set has been tested with the backend daemon:
> 
>   # ./build/contrib/vhost-user-input/vhost-user-input \
> 		     -p /dev/input/event20 -s /tmp/input.sock
> 
> The series is based on "[PATCH v8 0/7] virtio: cleanup
> vhost-user-generic and reduce c&p" which introduces vhost-user-base.
> Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>


That patchset is deferred until after the release, so this one
will be, too. I have tagged it, to help make sure it's not
lost pls ping me after the release.

> 
> Leo Yan (4):
>   hw/virtio: Support set_config() callback in vhost-user-base
>   docs/system: Add vhost-user-input documentation
>   hw/virtio: Move vhost-user-input into virtio folder
>   hw/virtio: derive vhost-user-input from vhost-user-base
> 
>  docs/system/devices/vhost-user-input.rst |  44 ++++++++
>  docs/system/devices/vhost-user.rst       |   2 +-
>  hw/input/meson.build                     |   1 -
>  hw/input/vhost-user-input.c              | 136 -----------------------
>  hw/virtio/meson.build                    |   4 +-
>  hw/virtio/vhost-user-base.c              |  17 +++
>  hw/virtio/vhost-user-input-pci.c         |   3 -
>  hw/virtio/vhost-user-input.c             |  58 ++++++++++
>  include/hw/virtio/virtio-input.h         |   6 +-
>  9 files changed, 126 insertions(+), 145 deletions(-)
>  create mode 100644 docs/system/devices/vhost-user-input.rst
>  delete mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input.c
> 
> -- 
> 2.34.1


