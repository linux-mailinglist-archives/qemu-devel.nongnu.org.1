Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28E7BDA3C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpohx-0003TL-L2; Mon, 09 Oct 2023 07:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpoht-0003Pb-TX
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpohr-0003i7-3w
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696851947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p5LYjpHy/lcn1IuFH3k5hW/a9mM/RPxNGvmqoT/I6A=;
 b=Tvaxy83lCQcnlg4563Yzl89C176VLfpV7C8dX+J7+K70YYdRxnvxEgm6EnHkkypAf5+qxe
 noWiKtCTNH26to02R2NKKlcXUDWFEk94/IDQPdGTz/AIsZ/f0lMJy+mzU6Df/YcRSPbk0n
 A1drgMmtgAAaa68qWhoxIEpvHyWvKvo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-8epl6VuqNBGPMMQe5VTwEg-1; Mon, 09 Oct 2023 07:45:46 -0400
X-MC-Unique: 8epl6VuqNBGPMMQe5VTwEg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so362733866b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696851945; x=1697456745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3p5LYjpHy/lcn1IuFH3k5hW/a9mM/RPxNGvmqoT/I6A=;
 b=V6CHGhJ9tfufyLwQSE4xveqozrJDwaTtuNbd7eD/qaQj6KGXWZ47kXKEsEjEZeklO5
 VUjObrY5ECmR+MDwOfzTHF4qz3TXscpTXBM+oYNYJ/0yKO6KsZqiR5ELnEUxdLDI5bra
 9dS+ZcRMbplGaIKFGMCIjHXcfxFMD4OxMwA6EB5n3+4koqaqZgpEbyMJTHU3/myw8ZEz
 Jdtf2G/YDAQ2+JmxVn4fnUip15MqZMMb0Ji5kiWzk0NtK44EEZlWrr/6p1XuNTgz1I/0
 s9+hTh6M3iYZZLirhbJQWn6+JGrrYDpOjCRvvwBH2QPyRXaIuR5tIMWyHiDfZBLm5I8H
 /ZfQ==
X-Gm-Message-State: AOJu0YwcKkhE9zhulQC+a69KIovRCjCnC1KvCUbN+aVpOvhyrP2upaC2
 B0+hO7zTXxZCgk1k36E8j1dxrMMn+pugJuQYpVT2MUYyv3V3KMo6iN+ci1FLsGgcfB+gZs9e+CK
 VTY4KHhsGPRuKrbXk50xXsqw=
X-Received: by 2002:a17:906:8a73:b0:9a1:e758:fc73 with SMTP id
 hy19-20020a1709068a7300b009a1e758fc73mr12603230ejc.67.1696851945116; 
 Mon, 09 Oct 2023 04:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCJfgsBjBXo7Tsx3vgAH73kWqyQ3kuB/RZ35xJLHAOrjcWACBYzBbpvRp3j7tPO3e2oa4QFg==
X-Received: by 2002:a17:906:8a73:b0:9a1:e758:fc73 with SMTP id
 hy19-20020a1709068a7300b009a1e758fc73mr12603219ejc.67.1696851944769; 
 Mon, 09 Oct 2023 04:45:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
 by smtp.gmail.com with ESMTPSA id
 gt26-20020a170906f21a00b0099bcf9c2ec6sm6626821ejb.75.2023.10.09.04.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 04:45:43 -0700 (PDT)
Date: Mon, 9 Oct 2023 07:45:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
Message-ID: <20231009074333-mutt-send-email-mst@kernel.org>
References: <20231009083726.30301-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009083726.30301-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 09, 2023 at 10:37:25AM +0200, Thomas Huth wrote:
> Rename some variables to avoid compiler warnings when compiling
> with -Wshadow=local.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Renamed the variable to something more unique
> 
>  contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
> index 509b679f03..654c392fbb 100644
> --- a/contrib/vhost-user-gpu/vugpu.h
> +++ b/contrib/vhost-user-gpu/vugpu.h
> @@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
>  };
>  
>  #define VUGPU_FILL_CMD(out) do {                                \
> -        size_t s;                                               \
> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
> +        size_t vugpufillcmd_s_ =                                \
> +            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
>                         &out, sizeof(out));                      \
> -        if (s != sizeof(out)) {                                 \
> +        if (vugpufillcmd_s_ != sizeof(out)) {                   \
>              g_critical("%s: command size incorrect %zu vs %zu", \
> -                       __func__, s, sizeof(out));               \
> +                       __func__, vugpufillcmd_s_, sizeof(out)); \
>              return;                                             \
>          }                                                       \
>      } while (0)

I think I prefer VUGPU_FILL_CMD_s or VUGPU_FILL_CMD_s_ - makes it clear
it's related to a macro.

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


