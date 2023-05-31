Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D01717317
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AVh-0002y9-VW; Tue, 30 May 2023 21:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AVW-0002xe-4s
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AVT-0004pm-DQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685496004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgqeucMgJ0REvZGpN7GAW8Ac0t991tVbQ0EiqXKXmkg=;
 b=V8NyNjSnUwjWHM8qjrd1dt3pekzKWusxHUOteXmd7f6hXDyLULyV3dWVbMm4563ds8jYjr
 M7TzNdCqIEVm0Qpk1XXrEk3o6B5L4FZeufqpWtn85sopuxW3U92UYOoPNIi09hcWKAP/j2
 L/h6xTgk5z2S44fA1jF58qQ8LO8gcO8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-14Okp1-UMkeuSWnEVNMVrg-1; Tue, 30 May 2023 21:20:02 -0400
X-MC-Unique: 14Okp1-UMkeuSWnEVNMVrg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af1eda690aso26870801fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496001; x=1688088001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgqeucMgJ0REvZGpN7GAW8Ac0t991tVbQ0EiqXKXmkg=;
 b=eNfS0VVesV7bWx7VA+cNuUM3p0xgaonFdChm3QLyjt5Ny0ashT2CFeF5TcuLUdwQei
 UMsUFYeryj7xPgIc5NpkBI6kiHVUMUtrS5/yYug2ffnFLDxAUGpiuXCZQiXPm4d9K0uf
 eV1xQ5ELnU0dc0CwFg924CbyTElr/A7Zck/P1QraTkt7n9gRbbcSYyH+HZsc8g3yAASm
 OyVa8SqaWnHUAybg0LnHmQP7MA5PyeJqGwCg8e8rq6WTAa8+I5dJypixDasEp1Sp7T2d
 W/b+fE1eo3dTyHlSggKBds8h28pzIgwNBPub/5lDgJymKSyWGOCilKp1+ognVN+Vtaac
 /m0w==
X-Gm-Message-State: AC+VfDybWKk8mfXuDnlpqZdEL6qXldlC+sa5hOtQiZhBIJ7HQvhn8wd6
 ih1oBD1vYVVGlClkjf3yfWKyn4L2/FblvsD4dP0laNIODhRqC+o7MIOWrM9qZKBO6IbbTJpF/+b
 RgZh6e7c8HwkhlkqraerxymIbOUSUQZQ=
X-Received: by 2002:a2e:9c4d:0:b0:2a7:adf7:1781 with SMTP id
 t13-20020a2e9c4d000000b002a7adf71781mr1741865ljj.2.1685496001372; 
 Tue, 30 May 2023 18:20:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ebNKJvlIDLAbVZwVG0V1baky5o7X2Wv1l1BxzsqWX2KNzT8KcG9jhgoOv1SEo4Ky3trryO5wm281mkNBz89E=
X-Received: by 2002:a2e:9c4d:0:b0:2a7:adf7:1781 with SMTP id
 t13-20020a2e9c4d000000b002a7adf71781mr1741858ljj.2.1685496000992; Tue, 30 May
 2023 18:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230529114333.31686-1-ppandit@redhat.com>
 <20230529114333.31686-2-ppandit@redhat.com>
In-Reply-To: <20230529114333.31686-2-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:19:50 +0800
Message-ID: <CACGkMEuKDOR10=gviUtrowxtQtY8QVYdbKSo0MBgnPMTG01gLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: release memory_listener object in error path
To: P J P <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 Michael S Tsirkin <mst@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
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

On Mon, May 29, 2023 at 7:41=E2=80=AFPM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad Pandit <pjp@fedoraproject.org>
>
> vhost_dev_start function does not release memory_listener object
> in case of an error. This may crash the guest when vhost is unable
> to set memory table:
>
>   stack trace of thread 125653:
>   Program terminated with signal SIGSEGV, Segmentation fault
>   #0  memory_listener_register (qemu-kvm + 0x6cda0f)
>   #1  vhost_dev_start (qemu-kvm + 0x699301)
>   #2  vhost_net_start (qemu-kvm + 0x45b03f)
>   #3  virtio_net_set_status (qemu-kvm + 0x665672)
>   #4  qmp_set_link (qemu-kvm + 0x548fd5)
>   #5  net_vhost_user_event (qemu-kvm + 0x552c45)
>   #6  tcp_chr_connect (qemu-kvm + 0x88d473)
>   #7  tcp_chr_new_client (qemu-kvm + 0x88cf83)
>   #8  tcp_chr_accept (qemu-kvm + 0x88b429)
>   #9  qio_net_listener_channel_func (qemu-kvm + 0x7ac07c)
>   #10 g_main_context_dispatch (libglib-2.0.so.0 + 0x54e2f)
>
> Release memory_listener objects in the error path.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> v2: split a single patch into two. Mention about vhost set mem table fail=
ure
> resulting in guest crash.
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 23da579ce2..6be4a0626a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2004,6 +2004,9 @@ fail_vq:
>      }
>
>  fail_mem:
> +    if (vhost_dev_has_iommu(hdev)) {
> +        memory_listener_unregister(&hdev->iommu_listener);
> +    }
>  fail_features:
>      vdev->vhost_started =3D false;
>      hdev->started =3D false;
> --
> 2.40.1
>


