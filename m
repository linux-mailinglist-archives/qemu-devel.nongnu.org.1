Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E1714CAF
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eSC-0001Lk-Af; Mon, 29 May 2023 11:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eS9-0001LL-O9
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eS8-00011F-3a
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685372790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHBm6rVXIe7IRn5Baf4rKIeAKpS4VBmTf/VhGK8VnSc=;
 b=NYEgIKqeZtxQTbrLfePs9faPAw8eXJdRw+QGoXwVD7wZ2Oaoqk2YZ36ZYdhC4ziUcf3YI4
 IrWk9lUf6+VNYhIhQJBcwcSKcVzozh4zRHksxzQjRVR/DrtZjpKvRdO+52Y8M1GJEWlSr6
 QtBKExk6uzjD5GnUskAzbSwfvZF/ISs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-eLl2MzHBMK-e3xcKuLuarg-1; Mon, 29 May 2023 11:06:29 -0400
X-MC-Unique: eLl2MzHBMK-e3xcKuLuarg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f830918d47so298731cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 08:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685372788; x=1687964788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHBm6rVXIe7IRn5Baf4rKIeAKpS4VBmTf/VhGK8VnSc=;
 b=GeKkZCc2YivzUvwR3fCNcY5fxGpjRokAcCGmYUvSkUqQdwcJQnPnhJl28mWJjt8lSm
 VovINJJauOesDKL0sQuWggJ0uXcG/5/xEnRSLFsszKP9Ru1nP9oxXB2Y09XldnNF79GO
 XtC6rQn7NYAlkszFY9fJWKsD4Y5J9yezMQqjwEoxKqk05iQmMDUpyI7vdx84Z9BaD4XV
 FL15kp2k7Sd2PBnPPDGVRxVcvWVICZeJ7t+dyjOcsLxdjQuxbxxNTKgG0xdosJp4SOhX
 +goa8iCyeHnfwaJe/qc/0VNkKRIbqyqb2IZjVa1ub4eNc0/unnmBRKIbXPQem5LxVSF7
 HSLg==
X-Gm-Message-State: AC+VfDx9j4c8c9v0RXQed32LxRjKNBAljXXRKXmfFR+I14bwd8Bh1WnU
 FBZTiueN1uS39jPQsBeUbVdSiwizJJ5JYAYXzwu01kqUtQpDsmS7Eb1EeRA4aNvnoS/GyhmXk0D
 Q4dhXW71UTmXSSXA=
X-Received: by 2002:a05:622a:1a2a:b0:3f7:fab0:6308 with SMTP id
 f42-20020a05622a1a2a00b003f7fab06308mr12101124qtb.6.1685372788682; 
 Mon, 29 May 2023 08:06:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oAvA0PgWUcxDXJdPivlgMROenrfqEDtzfRe4SyssTTH8GSX3cKt98XLTHIfcCg4sIQorxfA==
X-Received: by 2002:a05:622a:1a2a:b0:3f7:fab0:6308 with SMTP id
 f42-20020a05622a1a2a00b003f7fab06308mr12101100qtb.6.1685372788454; 
 Mon, 29 May 2023 08:06:28 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 u9-20020a05622a198900b003e8160cf93asm3880861qtc.80.2023.05.29.08.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 08:06:27 -0700 (PDT)
Date: Mon, 29 May 2023 11:06:26 -0400
From: Peter Xu <peterx@redhat.com>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael S Tsirkin <mst@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 1/2] vhost: release memory_listener object in error path
Message-ID: <ZHS/cp/wDBQPMkwb@x1n>
References: <20230529114333.31686-1-ppandit@redhat.com>
 <20230529114333.31686-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529114333.31686-2-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

On Mon, May 29, 2023 at 05:13:32PM +0530, P J P wrote:
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

Reviewed-by: Peter Xu <peterx@redhat.com>

Maybe worthwhile too with:

Fixes: c471ad0e9b ("vhost_net: device IOTLB support")

> ---
>  hw/virtio/vhost.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> v2: split a single patch into two. Mention about vhost set mem table failure
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
>      vdev->vhost_started = false;
>      hdev->started = false;
> --
> 2.40.1
> 

-- 
Peter Xu


