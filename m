Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7429F9962A7
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Oct 2024 10:30:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS59-0005TP-Ba; Wed, 09 Oct 2024 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS56-0005Ss-7z
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS52-0008TI-PZ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XY8WLAyt0GXUVzQv2IFoTNv6tSwcGxjOqmof9Lst9/E=;
 b=XT1A4TtfbCX+L/6GnjEvVPLx6TA0t0jBkkPbv+7Dh4VLCj9O3MYR2UBPiJ9V+aMBFlpJBa
 NiI3fjFfgkuGzjPsk95e0yChMm4PDuXWHcIgl91SrM7J24I7qXtg//xpJLFapdTaH3NvO2
 TFRIYlsQZgd7d8f5Ny/k+7ONCbzLhrI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-basPnnCzN0y66y8_xnIxMA-1; Wed, 09 Oct 2024 04:29:58 -0400
X-MC-Unique: basPnnCzN0y66y8_xnIxMA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e291d608feso1046506a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462597; x=1729067397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XY8WLAyt0GXUVzQv2IFoTNv6tSwcGxjOqmof9Lst9/E=;
 b=HF8GswnNdehvxI7sWEQwbSwVE6++ZwZgITn68TcouVPfkVWtRUZlRy3ogkeZ/9kMtw
 8dg9bEaMLDRKX7lhd9AYChJEelVGD45gyvtErcndmAoN7k2qGokpWtUaauKDvlObyCxg
 NZeg3B3V+yIuOfgyiRIptz2DtQcuqLGxZ1nuadIk1swCFpITlxdNaW7hAD881bWhSUiz
 CKY2gNvcTuBDlOC/y5KbXSv0vejw19VVvfbh+eHlvODZntuvfPbj101jWvgnVF8rqfSO
 0q+GoEwjpnkfKMt5EFVKwNUAddJbWKU4W1a3hFbJNxXYJB5z3/AJ1UgYbgy4zTavGBMA
 gc6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWDESDxsAqHtILii0z3kGuYinbYsmbCskob4ZGx2C0iYAdSqUAsbaek1bUVV0ciOGBrC21zGGDwgV/@nongnu.org
X-Gm-Message-State: AOJu0YyIWIzucj2igDJiccsbY6/zljcNAeC3a0MoorHGiD7bmV+J9kq+
 udj2UTu4OZUfMs6Ei0CWVObZqSK+qd6BI88tLSvTdqfrk8iOF40+L7z7ycA+tmzW1Or3bzOB2UU
 uNNAFdABumiSANAgVUpgU02Tf03TE7bJtoyJ6iHf95JSZf4dp0V1Sclh1n5I7fj9N19Hb0kIDA8
 nyOgc/0LVXDt9VZ8w7hjk26DpqF0ggXBllK43m3Q==
X-Received: by 2002:a17:90a:f0d1:b0:2e2:abab:c450 with SMTP id
 98e67ed59e1d1-2e2ababc590mr1362710a91.11.1728462597259; 
 Wed, 09 Oct 2024 01:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJac4AVbqU2sbU3z0QEVeND/ku7QvQnkus/jiSAdnS4m5KedZMaPFDFh9S85XuwT57Dwxka4MA3YJXPQjHxYc=
X-Received: by 2002:a17:90a:f0d1:b0:2e2:abab:c450 with SMTP id
 98e67ed59e1d1-2e2ababc590mr1362689a91.11.1728462596737; Wed, 09 Oct 2024
 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240929160045.2133423-1-lulu@redhat.com>
 <20240929160045.2133423-3-lulu@redhat.com>
In-Reply-To: <20240929160045.2133423-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:29:45 +0800
Message-ID: <CACGkMEttbUdfPweKghNuo7TJuxbTg3Zuh_HZPCX7ZoTrY4OqSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add the 2rd acceptable situation for
 Mac setup.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, the following situations are
> also acceptable: the hardware MAC address is not 0,
> and the MAC address in the QEMU command line is 0.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7aa7308244..5c610d8078 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3607,6 +3607,18 @@ static bool virtio_net_check_vdpa_mac(NetClientSta=
te *nc, VirtIONet *n,
>          if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0))=
 {
>              return true;
>          }
> +        /*
> +         * 2.The hardware MAC address is not 0,
> +         *  and the MAC address in the QEMU command line is 0.
> +         *  In this situation, the hardware MAC address will overwrite
> +         *  the QEMU command line address.

Please explain how such overwrite works. For example, "Function X and
Y will let the hardware mac address overwrite the cli mac"

Thanks

> +         */
> +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0) {
> +            /* overwrite the mac address with hardware address*/
> +            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> +            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> +            return true;
> +        }
>      }
>
>      error_setg(errp,
> --
> 2.45.0
>


