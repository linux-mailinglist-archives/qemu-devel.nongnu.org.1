Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFBF7BCD61
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPYT-0002Zg-Ad; Sun, 08 Oct 2023 04:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPYG-0002ZO-DH
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPYE-0005b3-8Z
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696755253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dRyysCQHZJvEEEGIk1FJhgWh/6p6i34HH7eJafF4VU=;
 b=cQfJWicxP+wWhR9DJlwlimqAP2STgzPr2IZrDokWUVAA4kPoKWZdiN+t0jcRiOElm33tyF
 iHeH9YR6wJ55Vb/979V+phmXSinwc49kiperfdJM4xl9JkfwWTFFln186EmNG3Rpy8pa+0
 Bm5Ouct5ALiPLt+Q4GxT1ZrLljQGuhI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-jGhkjVX4Ouunjxx7mORy2Q-1; Sun, 08 Oct 2023 04:54:11 -0400
X-MC-Unique: jGhkjVX4Ouunjxx7mORy2Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-533c6d0b377so3007443a12.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696755250; x=1697360050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dRyysCQHZJvEEEGIk1FJhgWh/6p6i34HH7eJafF4VU=;
 b=NS3jGsfuJ1dvxmYbdKl0ZAdtNEWrwuSD92L9HSZbOmH+L80wJKte4UBcnB9H1tRJfb
 X6DmQyI7DPTZbTMJF2YawRSwbxuSOAkXBOWd3Vwg+qIPYcHAs1sUPgtA0y4EZYwWGVhN
 TGfNO/LWCVPF30yfzrNn8fJY3+ATcUeyaDyRG2d3jUhb3Cxe2YIosF2Gh22oc08VfUwg
 dNPw8i2nTeEY8ndQdeCiOczAbWxIEW0FJ2RFnNFb4FOaEVB/bJtqjiPWGa8Kibgu2+Ax
 iN9/do0EM3k3zPdje3oMv6162KUHUGLG3/gAEItxclvARVTq4gibFhK9uedfi7gMeeaj
 GrtA==
X-Gm-Message-State: AOJu0Yzt2/RKXeRrzzNVQ4N0O2q5z7vkvPmgORvZCMBMNlUTWXEotkhz
 ipIQ/eVv59O1Z9CAzEx34deNWhaEhUISe7S73ZhLhiYtjPrv5wXGnPC22RgDt6uLRa9WW1XPhYp
 nfEImd4Zh4pE42/c=
X-Received: by 2002:a05:6402:43cf:b0:531:3c4e:98bc with SMTP id
 p15-20020a05640243cf00b005313c4e98bcmr11621662edc.8.1696755250797; 
 Sun, 08 Oct 2023 01:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzqP56wwbdiIKL/lszR5UArypQuTeVsudELgR1E959AcSnBkYjIKD3so9+Mwek4nI/G3iP2g==
X-Received: by 2002:a05:6402:43cf:b0:531:3c4e:98bc with SMTP id
 p15-20020a05640243cf00b005313c4e98bcmr11621653edc.8.1696755250464; 
 Sun, 08 Oct 2023 01:54:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a056402344800b0053537ad3936sm4791980edc.21.2023.10.08.01.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 01:54:09 -0700 (PDT)
Date: Sun, 8 Oct 2023 04:54:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
Message-ID: <20231008045359-mutt-send-email-mst@kernel.org>
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

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


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


