Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABF7128C1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ydv-0000p4-NH; Fri, 26 May 2023 10:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2Ydt-0000oa-Bs
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2Ydr-0002Un-S4
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685112126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieigWw+knjd+bDImnDjGfHT/hiK2SjnWXaTgRtJjXXo=;
 b=XYjdmhT2O0JBWs9COdU/ojtr7nVxBSWVoUaWwmYzY/DaO0adyUYojYiHonoUsaOmqfynnA
 Ut0o6LXzDCO8rpSRTQeAHpJ9s1kSVMmDcepUG1nMxfDPidSJ7D88zo5mv3vNoeAcRPDlWb
 680KstSJldS/uS51H+nGpJscZKMCNfU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-2Y0Gxy8uNcC0o-125hAyTQ-1; Fri, 26 May 2023 10:42:05 -0400
X-MC-Unique: 2Y0Gxy8uNcC0o-125hAyTQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b147a2548so19378085a.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 07:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685112124; x=1687704124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieigWw+knjd+bDImnDjGfHT/hiK2SjnWXaTgRtJjXXo=;
 b=DGaRsw5+v2kGBOD8UirU1/F+4xs3bcGlPzn4JtpP7beClc4KitIrDp6+v9rTr53yDV
 0CwrlEUoIxY7x20z09K4TLFWEJdhmEEcmcW6Q6aVjjdBJUv6qkgEDrsX8gvjpENO+jLX
 juWu1zTYZELreOCOQGJeGSGIbN563dONSxqhSWP2gTnSuK0hFzo3DZofsNwsKkSjI3ns
 Afy8FrkLOIns7Fkl5l7pIANTkFW6DTPsp7aGXXbQU2BBjOC+TYpZ+5sh4Kw6+m5NKa97
 lyC8iXDGSNnuh/LCG+g9ej61PRG0RFZKUJe7xEHQQv1lYCD1AHorjy+CU0Zz1nsCB3N6
 neSg==
X-Gm-Message-State: AC+VfDz7Vjgz+ZMW4NIFFY/XB+L5CPx02ERJlHhy1SJf9IKJX8bSkBj4
 eHIhqZlf1miJEqfZflWBb+C63IJZwZdHRXNa3xW/3uhnc5wbdhBfASFm2mt0oFizs4GvkuwSznB
 /tWkDKLk4J4pOhiQ=
X-Received: by 2002:a05:620a:4387:b0:75b:23a1:69ec with SMTP id
 a7-20020a05620a438700b0075b23a169ecmr2028247qkp.3.1685112124816; 
 Fri, 26 May 2023 07:42:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5puqUq9j2q+LuB1st2iU9MS7VysNFBnh3HrbEF0YuVg4NaOGQtnIfUHBvAoXs9ITG3119tGw==
X-Received: by 2002:a05:620a:4387:b0:75b:23a1:69ec with SMTP id
 a7-20020a05620a438700b0075b23a169ecmr2028224qkp.3.1685112124507; 
 Fri, 26 May 2023 07:42:04 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 y15-20020a37e30f000000b00759273c10eesm1209069qki.33.2023.05.26.07.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 07:41:48 -0700 (PDT)
Date: Fri, 26 May 2023 10:41:32 -0400
From: Peter Xu <peterx@redhat.com>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1] vhost: release memory objects in error path
Message-ID: <ZHDFHMYIbwiVHgJ4@x1n>
References: <20230526074051.22122-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526074051.22122-1-ppandit@redhat.com>
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

On Fri, May 26, 2023 at 01:10:51PM +0530, P J P wrote:
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
> 
> Release memory_listener and virtqueue objects in the error path.

IMHO it'll still good to mention that it's not event_notifier_init() that
failed but vhost_set_mem_table(), since that is probably not crystal clear.
The event_notifier_init() change is just something to fix altogether (or
with a separate patch, but this is fine by me).

Please also consider adding a "Bugzilla:" link to the original bug report.

> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu


