Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF5710CF4
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AcO-0006m2-2e; Thu, 25 May 2023 09:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2AcK-0006gT-B5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2AcI-0006GA-Pz
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685019773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Fu6o5t8wb43yw9p+EuL5teDEcgI/rv0eYWbd9B3H2g=;
 b=JwLXmo98BajFTB+AzirR6B0bWmLdh8yoxJnv89vWfMlvZyg3hYlonpTZiZwMehg+W6sBre
 VgRe+SJQxihlchFPYEhazeHkhGaoC9N/4PeALIBYDFEp2+5XfZhT8trR2f6VFExUepl1g7
 UNKL/hP+AlZMBeomAcEH5fk4+WUD5jQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-oa965K2wOaKQJWGKS4s2rA-1; Thu, 25 May 2023 09:02:51 -0400
X-MC-Unique: oa965K2wOaKQJWGKS4s2rA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-623b86d929dso2685016d6.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019770; x=1687611770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fu6o5t8wb43yw9p+EuL5teDEcgI/rv0eYWbd9B3H2g=;
 b=jIBTyfCkLf+6hbA7RO4faGOsuAHhy8B8TZhepuCAEHD7MT5HQjLfEK9W8I4TvXhXRg
 2y9VDyRai9lGAwaztVd9Bj/epEzaEV0RcKP0RcQx8ES0ZRhYzmY8bd3BI+zWsoGKR/6R
 S2mwiTwpO8iIaYd9k+Qd0OmYFet4XaVVeB4p7jZpTy8IfI5xMudxHaZodYKtA62BQIQv
 i9R2rid52TUa3VvdwSLf9AjpHpm5G3b5csCV8IGDbDcciH0LRSTy5BFYjfa/dHZVjArh
 VOY7wBc7hkAx3IHHnPLZ894Td0HSfA1rEKtB9bA9pM+e5Gk+WKYcDxHyTEVk4DJXla3F
 dTig==
X-Gm-Message-State: AC+VfDzYZF6OhdwUbrve/5BNP6ORiHkZ1mS1w1nnWE6S+JhAim7oTzI1
 QfXo8aLqsn/ckzjECYlREBsWGdTNNP7t0KpekQlIC+kg29BdsBhK598bsV1Lb+fMxVcWAUqmGAb
 IKe1jZ0/N0dWzO+U=
X-Received: by 2002:a05:6214:300f:b0:621:65de:f60c with SMTP id
 ke15-20020a056214300f00b0062165def60cmr28957039qvb.3.1685019769803; 
 Thu, 25 May 2023 06:02:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Fg1JtOSFNVu8h0SvyjVNR7ILq77SRyJq3FDuWi1m+713YLszqAueDIPf/WyGpPx0EPajtOQ==
X-Received: by 2002:a05:6214:300f:b0:621:65de:f60c with SMTP id
 ke15-20020a056214300f00b0062165def60cmr28957006qvb.3.1685019769436; 
 Thu, 25 May 2023 06:02:49 -0700 (PDT)
Received: from x1n ([70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 w7-20020a0cc247000000b0060f5a75b750sm378715qvh.99.2023.05.25.06.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:02:48 -0700 (PDT)
Date: Thu, 25 May 2023 09:02:43 -0400
From: Peter Xu <peterx@redhat.com>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: release memory objects in error path
Message-ID: <ZG9cc0yEAJ06N0XY@x1n>
References: <20230522181021.403585-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522181021.403585-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Hi, Prasad,

On Mon, May 22, 2023 at 11:40:21PM +0530, P J P wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> vhost_dev_start function does not release memory objects in case
> of an error. This may crash the guest with:
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
>   ===
> 
> Release memory_listener and virtqueue objects in the error path.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

From the patch change itself it looks all right here.

IIRC this bug used to only reproduce on rt kernels, is it still the case?

Here besides doing correct unregister, does it also mean that even if
event_notifier_init() failed there's totally no error message anywhere?
Should we dump something when it fails?  And did you check why that failed?

Thanks,

> ---
>  hw/virtio/vhost.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 23da579ce2..e261ae7c49 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1942,7 +1942,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>      r = event_notifier_init(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier, 0);
>      if (r < 0) {
> -        return r;
> +        goto fail_vq;
>      }
>      event_notifier_test_and_clear(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
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
> 

-- 
Peter Xu


