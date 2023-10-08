Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D77BCD68
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPcm-0005YL-So; Sun, 08 Oct 2023 04:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPck-0005W8-Ba
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPci-00072b-SH
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696755532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHVyd12Nw54jf0W+mzgC9eoUaMGMExd9h3jnn071kWI=;
 b=N3gWnbltyJQV3w13cYFLswzSqQqjMhcNy/S3xZd9RK8Rv40TufpeLV8WoPcM7z7yh+T9lm
 p4GRjXRj56lJDybit89Wo0Fs01Q9xUJ/pQiKmcgwhgR5wJPmeWQ+A9kvJrHDtrNPH7VFWN
 xtn6n1b8VOifHT+JSc0vlgppMDEoKHQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-UCOLVaIqPSusQe0AREAIuQ-1; Sun, 08 Oct 2023 04:58:50 -0400
X-MC-Unique: UCOLVaIqPSusQe0AREAIuQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99388334de6so304470766b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696755529; x=1697360329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHVyd12Nw54jf0W+mzgC9eoUaMGMExd9h3jnn071kWI=;
 b=KdyCUAbcMRFlNFo0wt5jUhqKr78tYCI36Y8YJJEQ6jD5377yOI20J3GvC/C6fHY9tJ
 P7t8AyNt9lkfR25Daz+UmHoHMj+SPodjBLbw+YxNyV0QhZ73YlZAF2FhBCMDvxVuBcDw
 rtgJWdJmIrTlUVNCERuv7rlqE316IJqrXzqHQceERPP+ooCwLwLaR3auxO/FjR3sVjAe
 g/bM92kCGiteNS43rc0JIPZSYKkluKwGTbCEbnei32ygl4fue+KCxyZF0JDkcLBzfYAA
 akqJYdP73qYLzzxMAwaqabUAZbtTmfus4ogf5as1blFsU6W7CxCNoRErzqmuhf+48Mqz
 jP0w==
X-Gm-Message-State: AOJu0YzN6ZbsmFRMq2QTrFQJKbnzN0QPAzIRbCUl4OShrA3NHRe6Jgen
 jj6Po1OSxnaCXNNf3XvIr4eMW/t83Li7ixzw0L1jIj77jMVrKub3wy/3irsvBsGQwkvHcP8VOK6
 TiBQYcK8Nmm0lD78=
X-Received: by 2002:a17:906:220b:b0:9ae:704b:6f3e with SMTP id
 s11-20020a170906220b00b009ae704b6f3emr4214084ejs.41.1696755529261; 
 Sun, 08 Oct 2023 01:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESz8dHGkzIhjYaLXzif0eMwE1p5RPkx3YRQ8VwOq5NMmwXj2d7xx3YlAbiJKEI+dPHap6xqg==
X-Received: by 2002:a17:906:220b:b0:9ae:704b:6f3e with SMTP id
 s11-20020a170906220b00b009ae704b6f3emr4214075ejs.41.1696755528988; 
 Sun, 08 Oct 2023 01:58:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a170906a40700b009ae587ce133sm5294745ejz.188.2023.10.08.01.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 01:58:48 -0700 (PDT)
Date: Sun, 8 Oct 2023 04:58:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
Message-ID: <20231008045751-mutt-send-email-mst@kernel.org>
References: <20231006173518.539085-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006173518.539085-1-thuth@redhat.com>
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

On Fri, Oct 06, 2023 at 07:35:18PM +0200, Thomas Huth wrote:
> Rename some variables to avoid compiler warnings when compiling
> with -Wshadow=local.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
> index 509b679f03..5cede45134 100644
> --- a/contrib/vhost-user-gpu/vugpu.h
> +++ b/contrib/vhost-user-gpu/vugpu.h
> @@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
>  };
>  
>  #define VUGPU_FILL_CMD(out) do {                                \
> -        size_t s;                                               \
> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
> +        size_t s_;                                              \
> +        s_ = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0, \
>                         &out, sizeof(out));                      \
> -        if (s != sizeof(out)) {                                 \
> +        if (s_ != sizeof(out)) {                                \
>              g_critical("%s: command size incorrect %zu vs %zu", \
> -                       __func__, s, sizeof(out));               \
> +                       __func__, s_, sizeof(out));              \
>              return;                                             \
>          }                                                       \
>      } while (0)

Oh wait this is the same issue. Fixes it now but can start failing
down the road. Let's use something specific to this macro.
VUGPU_FILL_CMD_s ?


> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
> index aa304475a0..bb41758e34 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -834,7 +834,7 @@ vg_resource_flush(VuGpu *g,
>                  .width = width,
>                  .height = height,
>              };
> -            pixman_image_t *i =
> +            pixman_image_t *img =
>                  pixman_image_create_bits(pixman_image_get_format(res->image),
>                                           msg->payload.update.width,
>                                           msg->payload.update.height,
> @@ -842,11 +842,11 @@ vg_resource_flush(VuGpu *g,
>                                                        payload.update.data),
>                                           width * bpp);
>              pixman_image_composite(PIXMAN_OP_SRC,
> -                                   res->image, NULL, i,
> +                                   res->image, NULL, img,
>                                     extents->x1, extents->y1,
>                                     0, 0, 0, 0,
>                                     width, height);
> -            pixman_image_unref(i);
> +            pixman_image_unref(img);
>              vg_send_msg(g, msg, -1);
>              g_free(msg);
>          }
> -- 
> 2.41.0


