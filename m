Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F47BCD67
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPbc-0004YX-8q; Sun, 08 Oct 2023 04:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPba-0004Xn-BB
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPbY-0006fo-S7
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696755460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Mu7PdLTN2j9QwmW/jFUOzpfdKpbAmPu+aYxts/n3nU=;
 b=af+aadmPzGJE/o2iNVu0XeUPA2p3ut55NBQGj6t/VKYFhisK7NGK7x5cRuYRJciwvOPC/6
 NgNDiJwJ5KgIWWQrWazItfiTgl6x+t4fkGKn4yGaL5ZzYG7mc41LY0B6oaiRpG2XoyOYa3
 fmxqcbBHmOh/QfN4l0GihL+JdDOGm1s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-bF2IDLJSPMe8KVHUBZ_IJA-1; Sun, 08 Oct 2023 04:57:38 -0400
X-MC-Unique: bF2IDLJSPMe8KVHUBZ_IJA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a1cf3e6c04so293797066b.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696755457; x=1697360257;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Mu7PdLTN2j9QwmW/jFUOzpfdKpbAmPu+aYxts/n3nU=;
 b=h/E3K2l+uGQdnA55nFPnAz9CPrjduxDHsM0bjGPnU0+1bQfAFQ/g2l4kRRkO4q8A0b
 ICiLFUH6oxz+Szzd+Gqx6narZCC5w+U6BUTbdFTQD29fQut09ixCP1v5HZMlnZ3wqqb3
 mxEM9rn7l82PHD1erGcxu0/gtBFG54LNygLqp/9dhVvsUT+YgewD0tySiMqcyV0YrglM
 c4NaTNQqRbsFcU1kRs/LgMPbEk1feWDANJvpSYFM09JENZQquec0WHPwN/OiNG9EpoAU
 kPzV0+F5oGiRud2vz1PIqrWDAQWKKLQ2QYzrR4snx9e9amdDJ7VheP9DIcigi3vOsmmV
 rqAA==
X-Gm-Message-State: AOJu0YwjWWyeHYhiU/VO9gaCqfdiJYeBpHBkhIrYl9rwEjC8gMLoP4h5
 T6IMYYR3CfVRM8GRCptPu9/+YvLIcz0uTB+QmlRhqzW0pmhr6IJuzZ1Tb2jiRksMvEURY2rTpme
 Bltitc5A0FH7kIcw=
X-Received: by 2002:a17:906:310f:b0:9a1:aea2:d18d with SMTP id
 15-20020a170906310f00b009a1aea2d18dmr10749232ejx.48.1696755457090; 
 Sun, 08 Oct 2023 01:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7RilOXRRP+OP5GXL6d8CSuXBJzy4XqQucpSA0Gk6JrNIVt7fxTMZxpffQze9mInvEGfql4g==
X-Received: by 2002:a17:906:310f:b0:9a1:aea2:d18d with SMTP id
 15-20020a170906310f00b009a1aea2d18dmr10749227ejx.48.1696755456811; 
 Sun, 08 Oct 2023 01:57:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 ca9-20020a170906a3c900b009ae587ce128sm5280642ejb.216.2023.10.08.01.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 01:57:36 -0700 (PDT)
Date: Sun, 8 Oct 2023 04:57:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] hw/virtio/virtio-gpu: Fix compiler warning when
 compiling with -Wshadow
Message-ID: <20231008045425-mutt-send-email-mst@kernel.org>
References: <20231006164508.536406-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231006164508.536406-1-thuth@redhat.com>
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

On Fri, Oct 06, 2023 at 06:45:08PM +0200, Thomas Huth wrote:
> Avoid using trivial variable names in macros, otherwise we get
> the following compiler warning when compiling with -Wshadow=local:
> 
> In file included from ../../qemu/hw/display/virtio-gpu-virgl.c:19:
> ../../home/thuth/devel/qemu/hw/display/virtio-gpu-virgl.c:
>  In function ‘virgl_cmd_submit_3d’:
> ../../qemu/include/hw/virtio/virtio-gpu.h:228:16: error: declaration of ‘s’
>  shadows a previous local [-Werror=shadow=compatible-local]
>   228 |         size_t s;
>       |                ^
> ../../qemu/hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro
>  ‘VIRTIO_GPU_FILL_CMD’
>   215 |     VIRTIO_GPU_FILL_CMD(cs);
>       |     ^~~~~~~~~~~~~~~~~~~
> ../../qemu/hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration
>  is here
>   213 |     size_t s;
>       |            ^
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 390c4642b8..8b7e3faf01 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -225,13 +225,13 @@ struct VhostUserGPU {
>  };
>  
>  #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
> -        size_t s;                                                       \
> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
> +        size_t s_;                                                      \
> +        s_ = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,         \
>                         &out, sizeof(out));                              \
> -        if (s != sizeof(out)) {                                         \
> +        if (s_ != sizeof(out)) {                                        \
>              qemu_log_mask(LOG_GUEST_ERROR,                              \
>                            "%s: command size incorrect %zu vs %zu\n",    \
> -                          __func__, s, sizeof(out));                    \
> +                          __func__, s_, sizeof(out));                   \
>              return;                                                     \
>          }                                                               \
>      } while (0)

This is not really enough I think. Someone might
use another macro as parameter to this macro and we'll get
a mess. We want something that's specific to this macro.
How about VIRTIO_GPU_FILL_CMD_s ?


> -- 
> 2.41.0


