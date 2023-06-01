Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921A719F97
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4j8n-0002aX-Jc; Thu, 01 Jun 2023 10:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j8k-0002aE-4f
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j8i-0006EG-OH
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685629136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sKcoOiH3ZJ7jOQ7rBiPeBZoCXvi3KHvOiRqtlQ1Ck0=;
 b=ZwRsLRtr9eMtvMWovzzHxc67M9xa45l++RzsARhOpRBCIb8rteqrlP9RI6k2HEi52/HJjd
 rxns/geEFAp994w9zlvXK00QpeaTcc6ldtRkiO+iPQpR+KyCFSf2l/ZDr6hey7UnSAuh1e
 q6yKGx4duy4nlP8NbW2/J2VJuu6MxfE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-L27mrOIgNSy9jbYJHb2uCA-1; Thu, 01 Jun 2023 10:18:49 -0400
X-MC-Unique: L27mrOIgNSy9jbYJHb2uCA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6af7f790e8aso833738a34.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685629129; x=1688221129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sKcoOiH3ZJ7jOQ7rBiPeBZoCXvi3KHvOiRqtlQ1Ck0=;
 b=ibSaCaS3gk76I22vaVkWI21fh6PBf1Nod/t9R6TMJGNQP2hMpSiNhd17i+fP7m6E4C
 EtKX7WiId/4qH3IUHOn928Kf5iNLtvoUsFwoLRrDZq3m2U4vqV6addlEUt/Z/nl3O3XK
 Yhf7rA+85JyJVzrf1OGamrRVT1CMxopmLYOQdxLGSA+IibfaglzDvIrfklOxBVpeypt6
 3geDZmO2Ww4deAQTEg0bHHxFm5VYhl12cRTM32qdbRN6/6CSx1qKN3/NvbNHBQhQvXei
 qPxJkAUQnYED7qmcgKrPaNLjrPUPwvFpa7XTRNIsKZOPBDXyDGOGpbFjvxds+kHl8Bkm
 1g4w==
X-Gm-Message-State: AC+VfDyf7BFhBQTA7x9AXNzxUaq96BENpCvZO2HVLUh56TWdyojIvqVr
 pSts1xxTiJVQaYM3CLzU/wvYK1Hv9Oobin9N4E6NB+HHn2zeZD5gjD+hYIgvDeTMojSc2KOV1P2
 K1PNtoj/abwpucmKcSE/usnN1LS71ZIw=
X-Received: by 2002:a05:6830:1202:b0:6a4:2ad5:9aa0 with SMTP id
 r2-20020a056830120200b006a42ad59aa0mr4501293otp.20.1685629129078; 
 Thu, 01 Jun 2023 07:18:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Q0sKStJSzbTvPS/VVt12+JsPlmxdyoHZF0zggdGjYjknB2Ai9sATZeElOYhvV/bUwvu4iZURFlliedOoL08s=
X-Received: by 2002:a05:6830:1202:b0:6a4:2ad5:9aa0 with SMTP id
 r2-20020a056830120200b006a42ad59aa0mr4501285otp.20.1685629128890; Thu, 01 Jun
 2023 07:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <38c7a86e4b1104917d8507b5e6cbe93d682d59ae.1685623090.git.yin31149@gmail.com>
In-Reply-To: <38c7a86e4b1104917d8507b5e6cbe93d682d59ae.1685623090.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:18:12 +0200
Message-ID: <CAJaqyWePt_KpMUpHzB7b3CehTK35iw8x7jiez+dsCdkUiMxWOg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 1, 2023 at 3:50=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 0e647886d1..4cc24a2997 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -85,6 +85,7 @@ const int vdpa_feature_bits[] =3D {
>  static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_CSUM) |
>      BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
> +    BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |
>      BIT_ULL(VIRTIO_NET_F_MTU) |
>      BIT_ULL(VIRTIO_NET_F_MAC) |
>      BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
> --
> 2.25.1
>


