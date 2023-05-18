Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1BA708A9D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 23:35:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzlHN-0008AJ-V1; Thu, 18 May 2023 17:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzlHL-00089t-Ug
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzlHK-00070z-Ha
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684445717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSqxFmqZRWPuqIbZqU0R0bF/zcPOPngryUE7pctGGxo=;
 b=JKyUG6jdZIEo++BrTu1j8rY5M7g/qmp2vSIBj6ysqhQr0nhXv4AsTBc8/dYd2UFisSfidy
 I6RB18uYOayUjEnkhv0Y7GXvtU2rFwNclxWa6Qq6TgwiKKCD/EtmlXmTiqMFrHen7uaYcV
 PUzAuwZ5knYYkGSRdMKKUU6+L9KcIFQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Aq30gvt5Mk2FVwuzg2Hc6g-1; Thu, 18 May 2023 17:35:16 -0400
X-MC-Unique: Aq30gvt5Mk2FVwuzg2Hc6g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af207a45bfso3036371fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684445714; x=1687037714;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aSqxFmqZRWPuqIbZqU0R0bF/zcPOPngryUE7pctGGxo=;
 b=MaLsSKEEGhSsEL5H4CbUYUetAWAHXvHTwNZGOnSH7oCXG9JEhGf0Cl/MpCMsLOT+L5
 4K0BJjd0vflWNdN1RZ1wBKAZC6KAp/oXsGIJFt/owJ+G/PsU/3lWMbO0iET4+FwMq3lE
 sDO1UzrB//QNB6Ig/xNUDbqRCicnnwbkQVpVrExEEWHK9vyic7dRccSIuX/6ks91I1z8
 ssPkNdSXHRdK1qG8mN6qJgyt1zvWlIGsRcAQ/F71Wax9N/bGEd4DbgViM5fSqaS2mt28
 tlDFX6LCk/zWPaq+tcZhj1IjNiINxBY2aU4FXdxilz2Z6QHr3DhFLY+dWq59S4D1gRXD
 OVcA==
X-Gm-Message-State: AC+VfDzJsBc5VxVBNQcFbMMTQvOOg/Is9W1yMJbM4UYErbn1MRz9967v
 x5ap563YdHWJiLZT9D9tIpLR8YkWZkJd1kTOybseLHqEaVqMhVYoLVae7SXFDiZj95in5jwc1lb
 Yh2Cb9uMlV0uGCcGbUnOcrqM=
X-Received: by 2002:a2e:6e18:0:b0:2a8:ac95:be75 with SMTP id
 j24-20020a2e6e18000000b002a8ac95be75mr10691230ljc.42.1684445714408; 
 Thu, 18 May 2023 14:35:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50Fs3un9LXWsl7Qj75bxs4MI7ByMQhtNLYqrZAUqXjaKgega5iCo5NXOkD+O5bjckdh03FVw==
X-Received: by 2002:a2e:6e18:0:b0:2a8:ac95:be75 with SMTP id
 j24-20020a2e6e18000000b002a8ac95be75mr10691225ljc.42.1684445714116; 
 Thu, 18 May 2023 14:35:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a05651c010500b002a8e8c776e9sm484712ljb.56.2023.05.18.14.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 14:35:13 -0700 (PDT)
Date: Thu, 18 May 2023 17:35:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH] virtio-gpu: add a FIXME for virtio_gpu_load()
Message-ID: <20230518173438-mutt-send-email-mst@kernel.org>
References: <20230515132518.1025853-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515132518.1025853-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 15, 2023 at 05:25:18PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It looks like the virtio_gpu_load() does not compute and set the offset,
> the same way virtio_gpu_set_scanout() does. This probably results in
> incorrect display until the scanout/framebuffer is updated again, I
> guess we should fix it, although I haven't checked this yet.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

I guess it's a way to ping Gerd ;)
Better to just fix it though, no?

> ---
>  hw/display/virtio-gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 66ac9b6cc5..66cddd94d9 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1289,6 +1289,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>      /* load & apply scanout state */
>      vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
>      for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        /* FIXME: should take scanout.r.{x,y} into account */
>          scanout = &g->parent_obj.scanout[i];
>          if (!scanout->resource_id) {
>              continue;
> -- 
> 2.40.1


