Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C07D8F44
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGyF-0008D3-Al; Fri, 27 Oct 2023 03:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwGy0-0008BM-SE
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwGxx-0006DM-JS
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698390547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWwzYbs3UqDuln5EGSKSWBSrKSMW4LJ3igYnAopZuwE=;
 b=E65VALw2KW2rmUy99cald0Dze+VT6YxDcOx8ZeDttTt/SiVnbblLEnnUiNlrTRfL+ag0zD
 z63bNP8OAyy+z7atcVXunKlj4Rx5Sdu76Q/dg1H9h2rijDqWhqax0AQBm70gH23rd3ldgO
 UPEceM9eyWkvR52HarvHeNUnl0aFTv8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-gIs1_N7YN3uKAuIyQZSBTg-1; Fri, 27 Oct 2023 03:09:04 -0400
X-MC-Unique: gIs1_N7YN3uKAuIyQZSBTg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5079fe7cc7cso2121162e87.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698390543; x=1698995343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWwzYbs3UqDuln5EGSKSWBSrKSMW4LJ3igYnAopZuwE=;
 b=q6yeNknsXO8uzfrdecPfdMpTHxI1zHTlh5fzIfktEkQ820kSKo7EIGZjRGsqtjTHT7
 KJULDEKu9s+eqdF+Q5AlnWblg09inWUE8eXq2RlS+vhvpIL0JXI4gcLQgfwSQeu+mCgp
 tbjj2kJsYPhyDZV9vSVyG9JTn6brcBG8GiRa1bgpnx+UZgkFpu0RKtmHmvGCbDLy3aUe
 fCH6QOcKr3G+WczHd9Pb7lkHOX6OEVAEhCbDc7YqE2Hh5cRp91PBPT3z38HMx71QUzID
 4aU6mCkCMTXe1Geb8505YCsqld8Yz85rpTL1xE7ll3BicJXrsTyRL0kDWh0ip12GoJP/
 MagQ==
X-Gm-Message-State: AOJu0Yy4RFNgyqqFTfZ8jk7feTiDwtRTyJWhm2yjaXh4L1+W2bVeLRu6
 2/S2tk5MLj+G85jPqMCYCR1PHeo+YAipW8phwDyB0Wi+IGzzyAkIWezgPQrEf2NANNeUp8RnzSY
 9BRX8wme54NN9VRG0FGeWC/UxSOWIiAU=
X-Received: by 2002:a19:550b:0:b0:507:cb04:59d4 with SMTP id
 n11-20020a19550b000000b00507cb0459d4mr1016898lfe.8.1698390543382; 
 Fri, 27 Oct 2023 00:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOYYrytXNqweJ/RJH3JJqtKnsWztc95LQZJUNfrovABnKy+Y/zxM+g7rnByupg7kQ56wtafc3O73gRezR0fk4=
X-Received: by 2002:a19:550b:0:b0:507:cb04:59d4 with SMTP id
 n11-20020a19550b000000b00507cb0459d4mr1016882lfe.8.1698390543060; Fri, 27 Oct
 2023 00:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-13-akihiko.odaki@daynix.com>
In-Reply-To: <20231017040932.62997-13-akihiko.odaki@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 15:08:51 +0800
Message-ID: <CACGkMEsKUnB8JhvCzsJ67==Jq=+S=xCFttXoaZsOd++4sBc-Uw@mail.gmail.com>
Subject: Re: [PATCH v5 12/21] virtio-net: Always set populate_hash
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Tue, Oct 17, 2023 at 12:10=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> The member is not cleared during reset so may have a stale value.

Nit: I guess it should be "always unset populate_hash"?

Thanks

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 20feb20bb1..6eb206f297 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -643,6 +643,7 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, =
int mergeable_rx_bufs,
>          n->guest_hdr_len =3D n->mergeable_rx_bufs ?
>              sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>              sizeof(struct virtio_net_hdr);
> +        n->rss_data.populate_hash =3D false;
>      }
>
>      for (i =3D 0; i < n->max_queue_pairs; i++) {
> --
> 2.42.0
>


