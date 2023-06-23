Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56C73B00B
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 07:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZJV-000396-H8; Fri, 23 Jun 2023 01:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZJQ-00038s-3N
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZJN-00068u-LZ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687497980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/zs6aKIeDTArWOwk/nyP2xiuTpCNHXs3iqk59HLf9Vs=;
 b=hzH6+aaJ3CJ/KZcuv48mbjmiDFDefWORr0Pm+J5VLqf+EKo18/q3wbCsmimQgfMcjVpoMy
 Ak08HGJXtASltwz7fibgN47dUQqdTvhbguhWUerDa8qAxbMnXXs0jx6tUh33m0ruTm5S5k
 mbcS83J5mt0hNNzlSbyRnMVKFTDMM7o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-LNTmW4wOPsW_8D4ozY5Ucg-1; Fri, 23 Jun 2023 01:26:15 -0400
X-MC-Unique: LNTmW4wOPsW_8D4ozY5Ucg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa7b245a75so1431545e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687497973; x=1690089973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zs6aKIeDTArWOwk/nyP2xiuTpCNHXs3iqk59HLf9Vs=;
 b=Wsq5YxGy8esbSY4Fvn4YzcbUDuEb41Y3msVfzvGH0nnT8Elc7qKCkqp1uaqBzdBwOv
 4T4PSYRNJv3JFbYffHABqYlAQDyQ0JHClKE7487D/DvQe5/dXDAa1QVLGiqaV//tn/jF
 cJNq+Q+ZBEqSzd7u8/iPo/uiFIqsOLrJfJlWDaEDQ/2mextsYCjD8RF2hYtktiGAADv3
 /0tspxRRDtyVfZkU15LhYxnPwcSyt6Q98Zut3QpCXSeM13YajJgsY+nc6piUbRNQkEMy
 YnOCPcyDzzNhBzuHJXLEvejcjG1esf9qwLHMtBLHTqGWBMpX0y9Ir5ZM8EuDYLQO1TAu
 lMcA==
X-Gm-Message-State: AC+VfDxwfkyIcuFPVnYk6qvmN9fzGdJrpZjHtRdFKWjpQ4F1BGcOJ92X
 gQ8VQaZ88WntDXZgPWKXPfwk7wq8fvjQ33vJeZz6BkARJbYECYKyRmBhww9C7DcmC5EWzWQ9KZ1
 mL1J9HpsFoYwd7MHzhU6ePz8=
X-Received: by 2002:a05:600c:4fd2:b0:3f9:b5bb:d762 with SMTP id
 o18-20020a05600c4fd200b003f9b5bbd762mr9936014wmq.9.1687497973608; 
 Thu, 22 Jun 2023 22:26:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fYaHejDAVCLK0dXJEtZNSTRdE6W5q7exYJOjrX9UW4bQ/6y//+eOYwyPWA84EsNadjtq9Mw==
X-Received: by 2002:a05:600c:4fd2:b0:3f9:b5bb:d762 with SMTP id
 o18-20020a05600c4fd200b003f9b5bbd762mr9936003wmq.9.1687497973344; 
 Thu, 22 Jun 2023 22:26:13 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 b14-20020a5d45ce000000b0031118d80246sm8567502wrs.29.2023.06.22.22.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 22:26:12 -0700 (PDT)
Date: Fri, 23 Jun 2023 01:26:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 longpeng2@huawei.com
Subject: Re: [PATCH] vhost: fix vhost_dev_enable_notifiers() error case
Message-ID: <20230623012555-mutt-send-email-mst@kernel.org>
References: <20230602162735.3670785-1-lvivier@redhat.com>
 <89b6ba60-8744-bda5-0dfa-b653d7b3ca62@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89b6ba60-8744-bda5-0dfa-b653d7b3ca62@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 07, 2023 at 12:32:31PM +0300, Michael Tokarev wrote:
> 02.06.2023 19:27, Laurent Vivier wrote:
> > in vhost_dev_enable_notifiers(), if virtio_bus_set_host_notifier(true)
> > fails, we call vhost_dev_disable_notifiers() that executes
> > virtio_bus_set_host_notifier(false) on all queues, even on queues that
> > have failed to be initialized.
> > 
> > This triggers a core dump in memory_region_del_eventfd():
> > 
> >   virtio_bus_set_host_notifier: unable to init event notifier: Too many open files (-24)
> >   vhost VQ 1 notifier binding failed: 24
> >   .../softmmu/memory.c:2611: memory_region_del_eventfd: Assertion `i != mr->ioeventfd_nb' failed.
> > 
> > Fix the problem by providing to vhost_dev_disable_notifiers() the
> > number of queues to disable.
> > 
> > Fixes: 8771589b6f81 ("vhost: simplify vhost_dev_enable_notifiers")
> > Cc: longpeng2@huawei.com
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >   hw/virtio/vhost.c | 65 ++++++++++++++++++++++++++---------------------
> >   1 file changed, 36 insertions(+), 29 deletions(-)
> 
> Is this one a candidate for -stable?
> 
> The diffstat is somewhat large but it is just moving bit of code around.

I'd say so, yes.

> Thanks,
> 
> /mjt


