Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8197384E9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:24:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxou-00077h-K8; Wed, 21 Jun 2023 09:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBxoe-00071v-L1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBxod-0006Dn-44
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687353846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DPwyAXNmi3MEja1toua8BoXk0AoccCIrxZnHaf3WO18=;
 b=iUSBdt/766Ro4q3eiMI+a+IoZgERB09cWKi314PKZ962+z8ik7rMCAPcdRjC0qQMCKWYeH
 UZ501aoMVwgbOhGSZag5twA/XnzADS7bxTtdfp6lTTlHvRDhUFIbF3+azKoE6ZrLO+DACD
 Dna2/s7UryE06wdpR+61e4bZVUhA3Vw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-LD3SeoIpPZSyfkj3H4aFqQ-1; Wed, 21 Jun 2023 09:24:04 -0400
X-MC-Unique: LD3SeoIpPZSyfkj3H4aFqQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7623c0f2856so85801685a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687353844; x=1689945844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPwyAXNmi3MEja1toua8BoXk0AoccCIrxZnHaf3WO18=;
 b=CuZ92ZMZ2POKXK0A1GsgJfe5r+q0bIwx1gmTRvOpMx+rhfLiG0VcX0ePmKCEgT24/f
 Y/VBQp/v8NJBw0FP6fJ13zQGCz+AwpGQ/0JggKOuP0MjuaKcPvFp/fNApZU85gGiwPQj
 tEIC64qG59pfH5bqu71FWVTmJkJfhHJyapeEGaN0zHzRjEWCQMhUku9OXx91qmFQjc4t
 oYeHe3Qa8CBuer0AVcfzo1b4rrJkvq3UJ9//VTHSlonZirpsM9k9jqnPMWMCDkHkOk6x
 UvRfuv2jlGchdw7C6ikQrc5Z96DNEclgomJLTWiowsV9M3FX2Md0OpQRxE0Y2HUKL+mJ
 fDjw==
X-Gm-Message-State: AC+VfDw4ub3a/NugjIVr0z5zNkxKdQOLIFcYNZsbWE96nN74gp4YEFEG
 JgewykjlrDHfqR9QVvYITBjoT/Awf9hDjG8yWs9UdRH4lTg/Nnlc5QQJxUchWYDKZA3HcHtqo8V
 YS0xaXd/k4KxnY1Y=
X-Received: by 2002:a05:620a:8fcc:b0:763:a95d:b578 with SMTP id
 rj12-20020a05620a8fcc00b00763a95db578mr5102095qkn.3.1687353844206; 
 Wed, 21 Jun 2023 06:24:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IM9AJPFIspQPpTCBFN1faL5dRfr28bz0SVGeBI9Hi0MPo0ugMedBJpaXywiBTKGiJ5JnThQ==
X-Received: by 2002:a05:620a:8fcc:b0:763:a95d:b578 with SMTP id
 rj12-20020a05620a8fcc00b00763a95db578mr5102081qkn.3.1687353843934; 
 Wed, 21 Jun 2023 06:24:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u4-20020ae9c004000000b007620864d547sm2187623qkk.120.2023.06.21.06.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 06:24:03 -0700 (PDT)
Date: Wed, 21 Jun 2023 09:24:02 -0400
From: Peter Xu <peterx@redhat.com>
To: z00619469 <zhangjianguo18@huawei.com>
Cc: qemu-devel@nongnu.org, chenyuhui5@huawei.com, xuyinghua3@huawei.com,
 liheng.liheng@huawei.com, renxuming@huawei.com,
 pengyi.pengyi@huawei.com, yubihong@huawei.com,
 zhengchuan@huawei.com, huhao33@huawei.com,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migrate/multifd: fix coredump when the multifd thread
 cleanup
Message-ID: <ZJL58kjyJxuYqwdc@x1n>
References: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Jun 21, 2023 at 04:18:26PM +0800, z00619469 via wrote:
> From: c00454449 <chenyuhui5@huawei.com>
> 
> There is a coredump while trying to destroy mutex when
> p->running is false but p->mutex is not unlock.
> Make sure all mutexes has been released before destroy them.

It'll be nice to add a backtrace of the coredump here, and also copy
maintainer (Juan Quintela, copied now).

> 
> Signed-off-by: c00454449 <chenyuhui5@huawei.com>
> ---
>  migration/multifd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b7ad7002e0..7dcdb2d3a0 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -523,9 +523,7 @@ void multifd_save_cleanup(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        if (p->running) {
> -            qemu_thread_join(&p->thread);
> -        }
> +        qemu_thread_join(&p->thread);

I'm not sure whether this will always work, e.g. when migration fails early
before creating multifd threads?

>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> @@ -1040,8 +1038,8 @@ int multifd_load_cleanup(Error **errp)
>               * however try to wakeup it without harm in cleanup phase.
>               */
>              qemu_sem_post(&p->sem_sync);
> -            qemu_thread_join(&p->thread);
>          }
> +        qemu_thread_join(&p->thread);
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> -- 
> 2.21.0.windows.1
> 
> 

-- 
Peter Xu


