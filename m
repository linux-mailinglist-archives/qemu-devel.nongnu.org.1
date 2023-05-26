Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76E71269D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WZU-0006vp-Dv; Fri, 26 May 2023 08:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2WZS-0006uh-KH
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2WZR-0001nS-3Z
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685104164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vU9SCW7hgl1DoVNNHBTqtsYgLzO24nyXmoQyeN0/iK8=;
 b=EZms0a8r51fRZgVxxyeIfENU65NRLtka2EW/XRNbNwTDGb49CBkSnBjQk9bB1Yaa0/ZOS9
 Buh+4dMI9SGTexFNmvh0whluTuHX8irmNTO2z6+xZDlV68Ayo8JnWYhG3uUIDeC4adUmPf
 c9zoZGbO1gZHmsFAiGC1FPXkgFmUccs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-XFTau5tJNpSMWdh_r7VfWA-1; Fri, 26 May 2023 08:29:22 -0400
X-MC-Unique: XFTau5tJNpSMWdh_r7VfWA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96f6fee8123so68288766b.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685104162; x=1687696162;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vU9SCW7hgl1DoVNNHBTqtsYgLzO24nyXmoQyeN0/iK8=;
 b=HwkZIxAsZlGsEDs6YUdZFiaE3kvj9ZeMxPAiLS8V9KFn97GFfnbrC76UvkZxitNyzd
 neYDUwSErbbw1SaJZiZrtQzUv+jIcd5rnYADODkAcI7UMLTwPE7a0J+BE7ku2QSP1k2A
 WNURhy7EDIgq3u9HrL3CQtnYEckvhjkRzLPRAoYmxT+TQxA+ES0zCEN7iJzjLmrE3h27
 sbH+C8ZBvs5iBf+LOwtHmAw07MAhBD1unjvc8TYBma/Xo8zfSMLtQLgXpx3rVV7N0xpj
 Va7S+J6K9WPoHf2FymqdZonQsH+YI+LHYPoifX2oLkYqeYdBcXjUeKo2SxeR26GrfvNz
 d/HQ==
X-Gm-Message-State: AC+VfDzpeHAAsbx3mWaxn3X/LJJ3EjdZfUa7YhE1azmxDTnIktbrauAw
 /QZnkYwqUbEPrnM23fk4yMaFvvBvHnPwmicAKv+A6nrhAtjNMjQz9PFJC1fzTQkrR/gC72jHYGI
 evU0EBYUG1UHnNEg=
X-Received: by 2002:a17:907:9413:b0:967:5c5f:e45c with SMTP id
 dk19-20020a170907941300b009675c5fe45cmr1910717ejc.0.1685104161882; 
 Fri, 26 May 2023 05:29:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52oxCIM0jeLOfWru/Q3WRhzOYb+n3oPEcpFasm/N5nSPhzNk+jxM0hAcDcZhtR1e6L90yUyw==
X-Received: by 2002:a17:907:9413:b0:967:5c5f:e45c with SMTP id
 dk19-20020a170907941300b009675c5fe45cmr1910681ejc.0.1685104161602; 
 Fri, 26 May 2023 05:29:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 a8-20020a1709062b0800b00970f0e2dab2sm2069094ejg.112.2023.05.26.05.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:29:20 -0700 (PDT)
Date: Fri, 26 May 2023 14:29:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 07/10] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Message-ID: <ikk6mlowrgajmsqsplaezv3lja6ymdqtrqlvlcegoujox3crpz@xd4pvtpvw7jj>
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524093744.88442-8-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Wed, May 24, 2023 at 11:37:41AM +0200, Philippe Mathieu-Daudé wrote:
>Instead of having "virtio/virtio-bus.h" implicitly included,
>explicitly include it, to avoid when rearranging headers:
>
>  hw/virtio/vhost-vsock-common.c: In function ‘vhost_vsock_common_start’:
>  hw/virtio/vhost-vsock-common.c:51:5: error: unknown type name ‘VirtioBusClass’; did you mean ‘VirtioDeviceClass’?
>     51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>        |     ^~~~~~~~~~~~~~
>        |     VirtioDeviceClass
>  hw/virtio/vhost-vsock-common.c:51:25: error: implicit declaration of function ‘VIRTIO_BUS_GET_CLASS’; did you mean ‘VIRTIO_DEVICE_CLASS’? [-Werror=implicit-function-declaration]
>     51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>        |                         ^~~~~~~~~~~~~~~~~~~~
>        |                         VIRTIO_DEVICE_CLASS
>
>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Reviewed-by: Thomas Huth <thuth@redhat.com>
>---
> hw/virtio/vhost-vsock-common.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


