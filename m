Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F197717469
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 05:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4CZf-00057a-T5; Tue, 30 May 2023 23:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4CZb-00051B-3Y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4CZY-0001Io-AS
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685503947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQHsQox2ZOr2KWzB83WmaLtLAUdobSn7afMA2f/10sw=;
 b=Jqc17cEbdiZ889NnCXQTOywgzSoc89mq40j6kibR4tSu/FRIUrUjFVhcIMQMSegKFvHgEc
 OaTr+V6WvUQ/JZzRq9aFi3i8nlody2g+Nv42YP06pb1yuCPocazOodQky3CWIUzUC0ROAU
 pVS3upA5P1pluZFGomoRNR4beKZ19wk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-5nDwo32-Mz-Q5THGpW8s-Q-1; Tue, 30 May 2023 23:32:24 -0400
X-MC-Unique: 5nDwo32-Mz-Q5THGpW8s-Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af2cff231cso25101821fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 20:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685503943; x=1688095943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQHsQox2ZOr2KWzB83WmaLtLAUdobSn7afMA2f/10sw=;
 b=dDw49FEAeI+La+1iAe4joD9zRU/W8TVOnriP4p4YjPjCZFwgc3HDX02hol13Bnf/Yd
 vLGcQ748BqzMMq8jsgk5wQgCVjbKLL2XRmjdpM0D0EvNuC7ahhXIPv8PxEx7bi+qi9p6
 y+iTlEguuRxJLb0i+h7PwNacq1kXlnClyjV3gL9QkLbmAOOneuMBhNRgOhLTJEPZPP0W
 81ZYJ/OSVM4OZdXBw3+EOXDfMm/XnSqDqRdso8F7NthNvA9lO6Nx946ibrmdHlA2yYbP
 Heppxa6EGJh3I5s+LsGvbJ9t17oDbv6rVHeUxmuD0fMcxouRokt7jURfAZFGosiGgbwc
 /FBA==
X-Gm-Message-State: AC+VfDzq4BOOomAixoQXo6LYDBnpb3hyhin2yvLHj/Vyacm+1Nbp9hCx
 IFCD3ItgSIkCAmLXLpnD12nNIKi6SoyU72JWoeEav8MQ2ucJjYvTiVwU/wT+SueqXGBE698I2xC
 YhyEuaGGmW8LivGwdV9UOpmiqbDQDi/U=
X-Received: by 2002:a05:651c:10b:b0:2af:5dd:53 with SMTP id
 a11-20020a05651c010b00b002af05dd0053mr1567135ljb.5.1685503943473; 
 Tue, 30 May 2023 20:32:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/8vJjsniupDrip3Lep3rP63Hu3lQcx39iFa4L8GuKQMMrXKXqMiTyOdubrovZG/L/X/KZr1dTkxxwBVDwxPc=
X-Received: by 2002:a05:651c:10b:b0:2af:5dd:53 with SMTP id
 a11-20020a05651c010b00b002af05dd0053mr1567130ljb.5.1685503943160; Tue, 30 May
 2023 20:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230531031645.44335-1-jon@nutanix.com>
In-Reply-To: <20230531031645.44335-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 11:32:08 +0800
Message-ID: <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
Subject: Re: [PATCH] tap: introduce IFF_NAPI
To: Jon Kohler <jon@nutanix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Wed, May 31, 2023 at 11:17=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote=
:
>
> If kernel supports IFF_NAPI, lets use it, which is especially useful
> on kernels containing fb3f903769e8 ("tun: support NAPI for packets
> received from batched XDP buffs"), as IFF_NAPI allows the
> vhost_tx_batch path to use NAPI on XDP buffs.
>
> Benchmark w/ iperf -c (remote srv) -P (thread count) -l (stream size)
> from a guest running kernel 5.10.105 to remote bare metal running
> patched code on kernel 5.10.139. Guests were configured 1x virtio-net
> device with 4x queues, resulting in 4x vhost-worker threads. Hosts are
> identical with Intel ICX 4314 @ 2.4 GHz with Mellanox CX5 25GbE NIC ->
> Arista 25GbE switch. vhost-worker threads largely maxed out on CPU on
> "Before" and around ~50-60% utilization "After".
>
> Single Stream: iperf -P 1
> iperf -l size | Before          | After          | Increase
> 64B           | 593 Mbits/sec   | 712 Mbits/sec  | ~20%
> 128B          | 1.00 Gbits/sec  | 1.18 Gbits/sec | ~18%
> 4KB           | 17.6 Gbits/sec  | 22.7 Gbits/sec | ~29%
>
> Multiple Stream: iperf -P 12
> iperf -l size | Before          | After          | Increase
> 64B           | 6.35 Gbits/sec  | 7.78 Gbits/sec | ~23%
> 128B          | 10.8 Gbits/sec  | 14.2 Gbits/sec | ~31%
> 4KB           | 23.6 Gbits/sec  | 23.6 Gbits/sec | (line speed)
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Great, but I would suggest having an option.

So we can:

1) ease the debug and compare
2) enable this by default only for 8.1, disable it for pre 8.1

Thanks

Thanks

> ---
>  net/tap-linux.c | 4 ++++
>  net/tap-linux.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index f54f308d359..fd94df166e0 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -62,6 +62,10 @@ int tap_open(char *ifname, int ifname_size, int *vnet_=
hdr,
>          ifr.ifr_flags |=3D IFF_ONE_QUEUE;
>      }
>
> +    if (features & IFF_NAPI) {
> +        ifr.ifr_flags |=3D IFF_NAPI;
> +    }
> +
>      if (*vnet_hdr) {
>          if (features & IFF_VNET_HDR) {
>              *vnet_hdr =3D 1;
> diff --git a/net/tap-linux.h b/net/tap-linux.h
> index bbbb62c2a75..f4d8e55270b 100644
> --- a/net/tap-linux.h
> +++ b/net/tap-linux.h
> @@ -37,6 +37,7 @@
>
>  /* TUNSETIFF ifr flags */
>  #define IFF_TAP          0x0002
> +#define IFF_NAPI         0x0010
>  #define IFF_NO_PI        0x1000
>  #define IFF_ONE_QUEUE    0x2000
>  #define IFF_VNET_HDR     0x4000
> --
> 2.30.1 (Apple Git-130)
>


