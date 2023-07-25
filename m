Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B05760AD7
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 08:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOBqC-0006do-RB; Tue, 25 Jul 2023 02:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBq5-0006Vj-JX
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBq2-0007BR-Jc
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690267685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AT5aUzXy7OxU+36j+nu9S6SC9Qad2AZyteYIz2r/VS0=;
 b=c/R66pMq0PNalWwn2D+0IGIdrJLJAwno6D9LmFpjpdbJN9uG4TNImW2afssl2GjtIgkZap
 4lAqVtMwbJIyYSWTUau8QfxHCIzprtf2mwIaFMba7+NLwEcl8tU2/rJEElIOlVWEu9xU62
 qH+bzib4dCPcrasTShr9SQZZSy2o17s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-lDXOykGQPla4uA7qRjQ_bg-1; Tue, 25 Jul 2023 02:48:03 -0400
X-MC-Unique: lDXOykGQPla4uA7qRjQ_bg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b93f4c300bso43980911fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 23:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690267682; x=1690872482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AT5aUzXy7OxU+36j+nu9S6SC9Qad2AZyteYIz2r/VS0=;
 b=Kum12d9hKaqqJ40grwrC8yXE/sIrdXrv0UlVC+Nw41J5FnWOoFUbbZ70uRv8jGZv3H
 qJz8N8vb6S8AuioRVqbhvsavLdpR1eT5Ts/6iOsn6t9ETSsfGtVgm+8aGbosJ0nJaE+3
 opZby8kzbiPzqAgVNRDeOV8ykrpNtkqQaI29CYNpiIjK/ldYJpfbmfU9/1zvqSebGZeL
 GkpnWpQynOUTebVKe4IQ9bh9czXM3TUhjuLG6kyyqLTYhhSIv12DyllySi+FglpcPMFd
 4EifUVhG2eXRJjfd9159Wj38NTXHf/K+qNTZejYaTXAJ7m4y96XKjVvgofW2OzUKCMl+
 aa9w==
X-Gm-Message-State: ABy/qLafJLh4oBBRcxnFGtizM9CWbF9PB7Jwy8zeK+unVFz+GSojtD88
 IXw9lskbQLNrc3RgadqHOoVNM2bxkqpCFN3GXjPMzVb/CTRjT+pJjCfOT9T5ct1oedXGRbP+YYO
 Y10y/YcylsuRn6jqtVFaK94kHRI10CeY=
X-Received: by 2002:a2e:8245:0:b0:2b9:6810:b333 with SMTP id
 j5-20020a2e8245000000b002b96810b333mr6859407ljh.14.1690267682320; 
 Mon, 24 Jul 2023 23:48:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEo4hrdMNcO1lAMsZJEtrDe7POlvg0X9mehHyleSQJiv358KBCcjeZJBIDf0Vx+/d/b0yC0jELglcU/OpPUXng=
X-Received: by 2002:a2e:8245:0:b0:2b9:6810:b333 with SMTP id
 j5-20020a2e8245000000b002b96810b333mr6859401ljh.14.1690267682110; Mon, 24 Jul
 2023 23:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <38dc63102a42c31c72fd293d0e6e2828fd54c86e.1690100802.git.yin31149@gmail.com>
In-Reply-To: <38dc63102a42c31c72fd293d0e6e2828fd54c86e.1690100802.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 14:47:51 +0800
Message-ID: <CACGkMEsz3QQnLoTp=oUMpGMvUA-rW5BsUwV0zdC1bK34gz2S7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jul 23, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Enable SVQ with VIRTIO_NET_F_CTRL_VLAN feature.
>
> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 347241796d..73e9063fa0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -111,6 +111,7 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_STATUS) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> +    BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
>      BIT_ULL(VIRTIO_NET_F_MQ) |
>      BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
> --
> 2.25.1
>


