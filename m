Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE979F2DC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWSp-00076Z-O6; Wed, 13 Sep 2023 16:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qgWSm-00073B-5Q
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qgWSf-0003tk-94
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694636864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f0+xEXr3h4AvyGXWBv8NYijYIzxjz19rPxVYGqrScHE=;
 b=UqOW0i58dDJLFa9iQ1RTNJCD/oikIpC5FKnrroDNQupL21Yk+VWtFO5ISsZcqZCBO20PiW
 /icimlHl54RkgZIctUuweQ+Dnck+tTFCsXY2Ioh9LN5rb5/iuouskFSw2RuVvVaGDhz59Z
 TCiWrFXtstHCjGqsFBMo9Ecal7ZW0KM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-4CdxyfrLOjuI3p1jJ4hHLQ-1; Wed, 13 Sep 2023 16:27:42 -0400
X-MC-Unique: 4CdxyfrLOjuI3p1jJ4hHLQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9adb6dd9e94so6742566b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 13:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694636861; x=1695241661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0+xEXr3h4AvyGXWBv8NYijYIzxjz19rPxVYGqrScHE=;
 b=v6qqH3OjGugGUK2g5mGm9NCW/1M7pjRS4/O/wlYfyV7b4EuCJ7MEACzqeTv4VnNfDH
 2oLkLnBbQlYNLvL31zTD8gm28ViYdyvt4z2jL4jJSQHmOJB0VyIWMTEbkGcN0YSfTvIv
 YCbe1ZHZAkww2XI83yP2ITND3Ezx5HYOdxyGo9V/vKpFsTv45p/Ewkz11jL2f5wSND36
 ob6aKT78Kor29N2DG3mEgvKrDa305K1UzMRjnGmRzHQqQEEE/5WLsuy/ratOIb+BGUEQ
 Z1ysVLLSimytSIQlu3eWmKq5xVnMrv4Th5OEATaZGDomEjTZNZ5xrRnhsgp2bJYfVwaq
 642g==
X-Gm-Message-State: AOJu0Yy6YpW8Zg2aJP9X7UM3ryIZhvfC+j0rlSe3eyBs+i1jYdDWDb+V
 l5H06ocrrfOlWoKbDgelbl6nEIWiNm4Fh355VMGaqIOc4OQey57ZQ6CU4Z9XI50WFb4VkYlg0a7
 2mGimCH284xUxOl8=
X-Received: by 2002:a17:906:1091:b0:9a1:688f:cf21 with SMTP id
 u17-20020a170906109100b009a1688fcf21mr2861013eju.43.1694636861434; 
 Wed, 13 Sep 2023 13:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJVsnE9rQQA+Orcn2ZNEU5oDNKnI3EEnBZORNMF9srOwP+TK/nObaTCm/lfyfW1RCu/NEDqw==
X-Received: by 2002:a17:906:1091:b0:9a1:688f:cf21 with SMTP id
 u17-20020a170906109100b009a1688fcf21mr2860992eju.43.1694636861066; 
 Wed, 13 Sep 2023 13:27:41 -0700 (PDT)
Received: from redhat.com ([2.52.10.100]) by smtp.gmail.com with ESMTPSA id
 si16-20020a170906ced000b00993470682e5sm8961056ejb.32.2023.09.13.13.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 13:27:40 -0700 (PDT)
Date: Wed, 13 Sep 2023 16:27:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Paul Durrant <paul@xen.org>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio-blk: use blk_io_plug_call() instead of
 notification BH
Message-ID: <20230913162606-mutt-send-email-mst@kernel.org>
References: <20230913200045.1024233-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913200045.1024233-1-stefanha@redhat.com>
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

On Wed, Sep 13, 2023 at 04:00:41PM -0400, Stefan Hajnoczi wrote:
> v3:
> - Add comment pointing to API documentation in .c file [Philippe]
> - Add virtio_notify_irqfd_deferred_fn trace event [Ilya]
> - Remove outdated #include [Ilya]
> v2:
> - Rename blk_io_plug() to defer_call() and move it to util/ so the net
>   subsystem can use it [Ilya]
> - Add defer_call_begin()/end() to thread_pool_completion_bh() to match Linux
>   AIO and io_uring completion batching
> 
> Replace the seldom-used virtio-blk notification BH mechanism with
> blk_io_plug(). This is part of an effort to enable the multi-queue block layer
> in virtio-blk. The notification BH was not multi-queue friendly.
> 
> The blk_io_plug() mechanism improves fio rw=randread bs=4k iodepth=64 numjobs=8
> IOPS by ~9% with a single IOThread and 8 vCPUs (this is not even a multi-queue
> block layer configuration) compared to no completion batching. iodepth=1
> decreases by ~1% but this could be noise. Benchmark details are available here:
> https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd


virtio things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


regression is a bit worrysome if real though - just do a bit
longer testing to make sure?



> Stefan Hajnoczi (4):
>   block: rename blk_io_plug_call() API to defer_call()
>   util/defer-call: move defer_call() to util/
>   virtio: use defer_call() in virtio_irqfd_notify()
>   virtio-blk: remove batch notification BH
> 
>  MAINTAINERS                       |   3 +-
>  include/qemu/defer-call.h         |  16 +++
>  include/sysemu/block-backend-io.h |   4 -
>  block/blkio.c                     |   9 +-
>  block/io_uring.c                  |  11 ++-
>  block/linux-aio.c                 |   9 +-
>  block/nvme.c                      |   5 +-
>  block/plug.c                      | 159 ------------------------------
>  hw/block/dataplane/virtio-blk.c   |  48 +--------
>  hw/block/dataplane/xen-block.c    |  11 ++-
>  hw/block/virtio-blk.c             |   5 +-
>  hw/scsi/virtio-scsi.c             |   7 +-
>  hw/virtio/virtio.c                |  13 ++-
>  util/defer-call.c                 | 156 +++++++++++++++++++++++++++++
>  util/thread-pool.c                |   5 +
>  block/meson.build                 |   1 -
>  hw/virtio/trace-events            |   1 +
>  util/meson.build                  |   1 +
>  18 files changed, 231 insertions(+), 233 deletions(-)
>  create mode 100644 include/qemu/defer-call.h
>  delete mode 100644 block/plug.c
>  create mode 100644 util/defer-call.c
> 
> -- 
> 2.41.0


