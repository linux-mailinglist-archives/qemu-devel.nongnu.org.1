Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 110667E9B4B
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:39:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2VH5-0004Rx-Q2; Mon, 13 Nov 2023 06:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1r2VH4-0004Ro-1E
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1r2VH2-0006yc-2f
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699875514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixPP+OhDi/7NavAaXlSA9pT/wGYUq+SCqVDTTRoUeJc=;
 b=Qw98fjEfiqILaw5c7Ppm9+S88xxbHNQ5Jw7MeCDG1wgAzGnpybHxZhV6FgbEIN5+3GaklK
 SJF0cBtAfllPrcX79eqweZ6RyDqxRu10BA7yLmxrVYtyLYKy517C5NPcEPkEmnRI/N6f6A
 vY+pGfxx6yTYKje0KAOFiRI+TpssrE4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-lyeML0LZOA6hPIbu1Rp-jQ-1; Mon, 13 Nov 2023 06:38:33 -0500
X-MC-Unique: lyeML0LZOA6hPIbu1Rp-jQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9d358c03077so43025566b.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 03:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699875512; x=1700480312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixPP+OhDi/7NavAaXlSA9pT/wGYUq+SCqVDTTRoUeJc=;
 b=uU8VuA/kIbx7PtUSBntBNdBJrBrHbxMwmiPRu3nTyV/np6KSRelYgDe/+ixUnAzD3o
 p9hqTP2F07wxwP1woYU3ifQ8S3ZCfSA77kv/r4Q3tLi33KaacrI7M42kz3FXQ8WcLeJ0
 SIzCg4qWxYa0TFSEI1tG+d2kT/Y0ZWHhzPJiSjB3R7j/xcqtiKIkYVJKqBotehh9YXZQ
 6UhoaY3c2p0zD3/sO3lqsDEnsmrshZ2s7toEwZYwSa83/UN03CH6pjerq6VRl6LPvBBm
 UDR+IpbFwAqpzNzc2pznLXwdJRfYLqTtNrh2GstPQVrpJM1w/OaM3DTwXFbZSsiiRdIa
 XZlw==
X-Gm-Message-State: AOJu0YyaU+QqnXrFkTTud44eHQgrJY8uXgWeM4uxtq/W1TrCq1C5m/JG
 dhiAEXAh2mQR4cl6eDjki4ZZmJ2yan/LU9DfRwcie+P5oDiCxZZc2HtrggmNDfi+5ssxH+CI5OE
 NJkuZ3EHVQSiAFL/qmTp3LmazNS337bI=
X-Received: by 2002:a17:906:1059:b0:9c7:5db4:8080 with SMTP id
 j25-20020a170906105900b009c75db48080mr3875583ejj.7.1699875511962; 
 Mon, 13 Nov 2023 03:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuVFQuNJY5Z2d1DxPQtwHwAMpkcQZx3EZct+bz7bfVvpbnMPjRAiNJj1kIv7bDWuD2Qtlvhx1MrAfqTGg90WQ=
X-Received: by 2002:a17:906:1059:b0:9c7:5db4:8080 with SMTP id
 j25-20020a170906105900b009c75db48080mr3875576ejj.7.1699875511710; Mon, 13 Nov
 2023 03:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20231111004920.148348-1-stefanha@redhat.com>
In-Reply-To: <20231111004920.148348-1-stefanha@redhat.com>
From: German Maglione <gmaglione@redhat.com>
Date: Mon, 13 Nov 2023 12:37:55 +0100
Message-ID: <CAJh=p+6NYno-KXBPvMQ3BEb8-9SDRY5=o+fVvmGAJN5it+hUBQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update virtio-fs mailing list address
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vivek Goyal <vgoyal@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Nov 11, 2023 at 1:49=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> The old virtio-fs mailing list address is no longer in use. Switch to
> the new mailing list address.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73a3ff544..c52df9f76c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2241,7 +2241,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
>  S: Supported
>  F: hw/virtio/vhost-user-fs*
>  F: include/hw/virtio/vhost-user-fs.h
> -L: virtio-fs@redhat.com
> +L: virtio-fs@lists.linux.dev
>
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>
> --
> 2.41.0
>

Reviewed-by: German Maglione <gmaglione@redhat.com>

--
German


