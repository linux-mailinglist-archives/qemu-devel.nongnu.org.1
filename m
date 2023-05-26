Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38D711EA4
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 06:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2OkV-000279-Ez; Fri, 26 May 2023 00:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2OkR-00026o-Cg
 for qemu-devel@nongnu.org; Fri, 26 May 2023 00:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2OkO-0008CD-Sf
 for qemu-devel@nongnu.org; Fri, 26 May 2023 00:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685074091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrjd91aASeQ+uyAoZEO6Ta6J507Ti2FSgGDIMTrjYNg=;
 b=gkPm7ErMKZ1ozOtB3HRMWWdrn5iYTRsiYz9MdQT4Fge4neHp8Q+o7EmBxXg4SY1kW4MWt+
 /eTMtpMZXaKCgL8acx8cap2xG16NPT64GTziybjZemEKRX3g0QgldZPaG2IG1/2OVj8ixR
 Kaxd/wkgkWaBnIq1kIw75rOE/+h2z1Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-3v7p2ajaOoKR4VzCTM7MXQ-1; Fri, 26 May 2023 00:08:06 -0400
X-MC-Unique: 3v7p2ajaOoKR4VzCTM7MXQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af25b667d5so1214591fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 21:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685074085; x=1687666085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrjd91aASeQ+uyAoZEO6Ta6J507Ti2FSgGDIMTrjYNg=;
 b=XSZkUAD1fEZ8PG1z/xFGahUh2EZo3dpOEq+5UAYBFH2pDGjLVsBPxX5f6S7lHsj0T/
 7RBkWg1dYSR4zcuUNTfRQgf+gaiQzLEnbBnYkASPOJYQiE146bfqPrIIpVfv6es9hPSy
 1EVSrU0gnbs6600CATIbBsqjPwBOIyK0YKHFycjvsxnOgYFVMLL1suFC6Ot3UECuLlCk
 I03v8ijbQnUTHGKxSIwP7F8bF6QIY8k9Cew36deBnDjUJBeWJ4g1tLTU2cgmdoGvHHlV
 kGX+TW1L3foPeTbOj9gLCxZCcG4dNfeUaR/cU0Erf/cZLGcm7JxHHzXB3HFsCng1Tc8b
 OQxg==
X-Gm-Message-State: AC+VfDxX+HwQUS8+zAUDY7+1AEk7VSS8Re3WeHBfyp5U5gkQCIpCNNz2
 fyPA0NsLacJtT8icZR0ohOLpFJfW00JnOSLEK6bJP40+b58kTgHJORVCY7lfDqR4wRRAfvkePen
 AtViZCHriYsPNCZvcLlXnyoC7pAoAK0k=
X-Received: by 2002:a19:ee01:0:b0:4f4:b3e2:ff54 with SMTP id
 g1-20020a19ee01000000b004f4b3e2ff54mr79850lfb.51.1685074085105; 
 Thu, 25 May 2023 21:08:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VrRbbdQOuGkM2WfSoeLKDl+SbklCTWP88x7C4nD6f0s7Tm3868PpVcNNQYTKbreILhrmz39pm66o5x4dWNNg=
X-Received: by 2002:a19:ee01:0:b0:4f4:b3e2:ff54 with SMTP id
 g1-20020a19ee01000000b004f4b3e2ff54mr79842lfb.51.1685074084743; Thu, 25 May
 2023 21:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230525125742.4190-1-viktor@daynix.com>
 <20230525125742.4190-3-viktor@daynix.com>
In-Reply-To: <20230525125742.4190-3-viktor@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 12:07:53 +0800
Message-ID: <CACGkMEubdZ2=jp8wWJbd1_evqNjH7HWy1EskVgvpPkEeACJF4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] virtio-net: pass Device-TLB enable/disable events
 to vhost
To: Viktor Prutyanov <viktor@daynix.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, 
 yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 25, 2023 at 8:58=E2=80=AFPM Viktor Prutyanov <viktor@daynix.com=
> wrote:
>
> If vhost is enabled for virtio-net, Device-TLB enable/disable events
> must be passed to vhost for proper IOMMU unmap flag selection.
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6df6b7329d..30497c00b5 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3951,6 +3951,7 @@ static void virtio_net_class_init(ObjectClass *klas=
s, void *data)
>      vdc->vmsd =3D &vmstate_virtio_net_device;
>      vdc->primary_unplug_pending =3D primary_unplug_pending;
>      vdc->get_vhost =3D virtio_net_get_vhost;
> +    vdc->toggle_device_iotlb =3D vhost_toggle_device_iotlb;
>  }
>
>  static const TypeInfo virtio_net_info =3D {
> --
> 2.21.0
>


