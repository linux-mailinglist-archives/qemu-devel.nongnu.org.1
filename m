Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E9717858
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:34:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GLi-0002kc-Ci; Wed, 31 May 2023 03:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q4GLA-0002gi-Bm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q4GL8-00075D-JV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685518429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jvYQlhKuHyKtL4mNj/znMLADcf3tcavTDhI4smE8dw=;
 b=XsNxPhP/8MBxxQyXBXzhG681qCuVcjMEiE5HzTG4zJ3zQVnHZfq4wr4G3Y5EpRi/4kHdlO
 z8iT9E/Dh9LpWsn2YTjU5Fg54tydZBrvg43qGtE/bk7u5xjhdZSEHYgFa3hrPIMNgv+Akh
 y2byYSKQPMeew0R+A/UJlI9r3ikeq4U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-JAfCi0K0NOyTZtYm2XdOcg-1; Wed, 31 May 2023 03:33:45 -0400
X-MC-Unique: JAfCi0K0NOyTZtYm2XdOcg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af32c170c8so29372121fa.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685518424; x=1688110424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jvYQlhKuHyKtL4mNj/znMLADcf3tcavTDhI4smE8dw=;
 b=Shg3Vk9UfpZo5psPmP3UK1uVKHKwId8pvpc9meZ4sVTCcO4Lj2jgvkJYfb4LohmBS0
 hCcdYS0s8XtUji1A9qqkMIqdglULja+dtOu1j2/U69qW/pfLHwh9J5hLI22f4OZhFLok
 EtYrkFK1PvnNwuUXa6bixkwH7EGOlUDKtuI38IzTzkXKzHtRVE75lGEs6+T9mV3ex1X/
 OFES5giWiLA6MFDFsLQ1v18MiOwDgrF5JYlFNaMXhFZoUg1I5O85FKB39NJAJxxhQXCr
 9FIpKd0Ispemsg9iz1NNsNJgWz7B5d/i7qcbXdoEKESRyI7JQ9CHFb4drE+CNj709SUq
 +sow==
X-Gm-Message-State: AC+VfDxwu5m+ArdQ/ITZi9bExXuU8dfVXQyiVsHv9iV8DUeB/b72agNC
 Q1HGK4aTdHOzAAkiTlWfR0n+QzmEvSvOKLeDKOTvbE2AWKsM0Tc18YoQGBhVQjsnqD2o3vujdZg
 gjKHQ8xwohzOSNNM=
X-Received: by 2002:a2e:9e47:0:b0:2af:a696:3691 with SMTP id
 g7-20020a2e9e47000000b002afa6963691mr2125454ljk.40.1685518424310; 
 Wed, 31 May 2023 00:33:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ551RIeF9bnzkTrz/lia8+/hteNl9cJtKk1XRyhXQesUA8vv9D1oOPKoklfR2VDrpxdBxuWZw==
X-Received: by 2002:a2e:9e47:0:b0:2af:a696:3691 with SMTP id
 g7-20020a2e9e47000000b002afa6963691mr2125438ljk.40.1685518423940; 
 Wed, 31 May 2023 00:33:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 i13-20020a17090685cd00b0096f83b16ab1sm8499433ejy.136.2023.05.31.00.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 00:33:43 -0700 (PDT)
Date: Wed, 31 May 2023 09:33:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 eblake@redhat.com, Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, 
 Julia Suvorova <jusual@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Kevin Wolf <kwolf@redhat.com>, 
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aarushi Mehta <mehta.aaru20@gmail.com>
Subject: Re: [PATCH v3 5/6] block/linux-aio: convert to blk_io_plug_call() API
Message-ID: <olpmomsccllt6s5yuzzznwoaf6mpx3vmcex5bt477uviettgra@owpdleplwg36>
References: <20230530180959.1108766-1-stefanha@redhat.com>
 <20230530180959.1108766-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230530180959.1108766-6-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 30, 2023 at 02:09:58PM -0400, Stefan Hajnoczi wrote:
>Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>submission instead.
>
>Note that a dev_max_batch check is dropped in laio_io_unplug() because
>the semantics of unplug_fn() are different from .bdrv_co_unplug():
>1. unplug_fn() is only called when the last blk_io_unplug() call occurs,
>   not every time blk_io_unplug() is called.
>2. unplug_fn() is per-thread, not per-BlockDriverState, so there is no
>   way to get per-BlockDriverState fields like dev_max_batch.
>
>Therefore this condition cannot be moved to laio_unplug_fn(). It is not
>obvious that this condition affects performance in practice, so I am
>removing it instead of trying to come up with a more complex mechanism
>to preserve the condition.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
> include/block/raw-aio.h |  7 -------
> block/file-posix.c      | 28 ----------------------------
> block/linux-aio.c       | 41 +++++++++++------------------------------
> 3 files changed, 11 insertions(+), 65 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


