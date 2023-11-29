Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C57FD299
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 10:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Gqa-0005s8-2d; Wed, 29 Nov 2023 04:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1r8GqS-0005rx-GX
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 04:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1r8GqQ-0002uh-7k
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 04:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701250016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2JhdbkDjf4JoDRbM9TAwjTy9WAKNpOXfEVP+u5YXIXc=;
 b=aeAx29ZMC9syAOXavHaql6+E25gaYVj8vJ7xOfw0ytdGILvMkwF1zFfBnjfzNDwR0ne/ry
 CfKmASvL7ARhAJnCH7UM03XvrMPeAVXdaJU4JmDiphgKReO68U2ricKeccHKktDYbwXhYI
 4ZIVXwwA6hQsDvZ/j7x8WckvDOv+8PQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-CiyshQP8Oza1ivfsCYl-aw-1; Wed, 29 Nov 2023 04:26:54 -0500
X-MC-Unique: CiyshQP8Oza1ivfsCYl-aw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407d3e55927so45443685e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 01:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701250013; x=1701854813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JhdbkDjf4JoDRbM9TAwjTy9WAKNpOXfEVP+u5YXIXc=;
 b=rJfUe/HVJ8etmyzvdKOZirgsr+keX5ziTDl7ExEioiNd/JxdJhb09pKHnysgn4InpE
 wT9DwsVEfjUl3wreR78BB/aQROdKMbd7quinMyi/lDbQbbhBAkk9VZMfdG2um+h5fBb3
 rbzltojsyJhofRsFuAHlxyMzLZTQ7yihD91ckm9OoIXhl256FRWkihBGENxj6w34d46R
 k6wJEwb1tN0DDpsiofqmSzg0sBbWyx/NUMyz1PQKTmEU8cFba3uRkT37MHLjVUmvDiDz
 ukHtq+RK7ZXbkfhglErzru2YKfLzroQOyyEzf+1MUoFf1WvUD2ODZPWQqoAfY1h2gkb7
 ZPHg==
X-Gm-Message-State: AOJu0Ywg/RsT6zsmxvkGOvjN2ZGVJGVqGbMPptx7xnkXMpm4gSb5qNfn
 ygoTWRolTHJNsPeFlUl/iF04fXKUo1VHiBAdn4QYpN9xLCk4TycL6+FOeMHaT+egkeL7r6O5TB6
 /lXPwEQ2SEc6sNOM=
X-Received: by 2002:a05:600c:4e8b:b0:40b:4c1a:f5b2 with SMTP id
 f11-20020a05600c4e8b00b0040b4c1af5b2mr3569099wmq.35.1701250013659; 
 Wed, 29 Nov 2023 01:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVSwkKf6VFFzK6oZ6k1/AdiSzFLwCJxmua3KCBUqFBy/lO7dwP8Ky7NOgreTzDVmQ8RG0unQ==
X-Received: by 2002:a05:600c:4e8b:b0:40b:4c1a:f5b2 with SMTP id
 f11-20020a05600c4e8b00b0040b4c1af5b2mr3569086wmq.35.1701250013328; 
 Wed, 29 Nov 2023 01:26:53 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it.
 [79.46.200.199]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040b481222e3sm1497182wmo.41.2023.11.29.01.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 01:26:52 -0800 (PST)
Date: Wed, 29 Nov 2023 10:26:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, 
 mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] vhost: Add worker backend callouts
Message-ID: <o57b224fc2ngmaosulzunhq5pwegh2zz3lqfkchplxwjtkzsdx@5wl4jdfj2mio>
References: <20231127002834.8670-1-michael.christie@oracle.com>
 <20231127002834.8670-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127002834.8670-2-michael.christie@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Nov 26, 2023 at 06:28:33PM -0600, Mike Christie wrote:
>This adds the vhost backend callouts for the worker ioctls added in the
>6.4 linux kernel commit:
>
>c1ecd8e95007 ("vhost: allow userspace to create workers")
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> hw/virtio/vhost-backend.c         | 28 ++++++++++++++++++++++++++++
> include/hw/virtio/vhost-backend.h | 14 ++++++++++++++
> 2 files changed, 42 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
>index 17f3fc6a0823..833804dd40f2 100644
>--- a/hw/virtio/vhost-backend.c
>+++ b/hw/virtio/vhost-backend.c
>@@ -158,6 +158,30 @@ static int vhost_kernel_set_vring_busyloop_timeout(struct vhost_dev *dev,
>     return vhost_kernel_call(dev, VHOST_SET_VRING_BUSYLOOP_TIMEOUT, s);
> }
>
>+static int vhost_kernel_new_worker(struct vhost_dev *dev,
>+                                   struct vhost_worker_state *worker)
>+{
>+    return vhost_kernel_call(dev, VHOST_NEW_WORKER, worker);
>+}
>+
>+static int vhost_kernel_free_worker(struct vhost_dev *dev,
>+                                    struct vhost_worker_state *worker)
>+{
>+    return vhost_kernel_call(dev, VHOST_FREE_WORKER, worker);
>+}
>+
>+static int vhost_kernel_attach_vring_worker(struct vhost_dev *dev,
>+                                            struct vhost_vring_worker *worker)
>+{
>+    return vhost_kernel_call(dev, VHOST_ATTACH_VRING_WORKER, worker);
>+}
>+
>+static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
>+                                         struct vhost_vring_worker *worker)
>+{
>+    return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
>+}
>+
> static int vhost_kernel_set_features(struct vhost_dev *dev,
>                                      uint64_t features)
> {
>@@ -313,6 +337,10 @@ const VhostOps kernel_ops = {
>         .vhost_set_vring_err = vhost_kernel_set_vring_err,
>         .vhost_set_vring_busyloop_timeout =
>                                 vhost_kernel_set_vring_busyloop_timeout,
>+        .vhost_get_vring_worker = vhost_kernel_get_vring_worker,
>+        .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
>+        .vhost_new_worker = vhost_kernel_new_worker,
>+        .vhost_free_worker = vhost_kernel_free_worker,
>         .vhost_set_features = vhost_kernel_set_features,
>         .vhost_get_features = vhost_kernel_get_features,
>         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
>index 96ccc18cd33b..9f16d0884e8f 100644
>--- a/include/hw/virtio/vhost-backend.h
>+++ b/include/hw/virtio/vhost-backend.h
>@@ -33,6 +33,8 @@ struct vhost_memory;
> struct vhost_vring_file;
> struct vhost_vring_state;
> struct vhost_vring_addr;
>+struct vhost_vring_worker;
>+struct vhost_worker_state;
> struct vhost_scsi_target;
> struct vhost_iotlb_msg;
> struct vhost_virtqueue;
>@@ -73,6 +75,14 @@ typedef int (*vhost_set_vring_err_op)(struct vhost_dev *dev,
>                                       struct vhost_vring_file *file);
> typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
>                                                    struct vhost_vring_state *r);
>+typedef int (*vhost_attach_vring_worker_op)(struct vhost_dev *dev,
>+                                            struct vhost_vring_worker *worker);
>+typedef int (*vhost_get_vring_worker_op)(struct vhost_dev *dev,
>+                                         struct vhost_vring_worker *worker);
>+typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
>+                                   struct vhost_worker_state *worker);
>+typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
>+                                    struct vhost_worker_state *worker);
> typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
>                                      uint64_t features);
> typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
>@@ -151,6 +161,10 @@ typedef struct VhostOps {
>     vhost_set_vring_call_op vhost_set_vring_call;
>     vhost_set_vring_err_op vhost_set_vring_err;
>     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
>+    vhost_new_worker_op vhost_new_worker;
>+    vhost_free_worker_op vhost_free_worker;
>+    vhost_get_vring_worker_op vhost_get_vring_worker;
>+    vhost_attach_vring_worker_op vhost_attach_vring_worker;
>     vhost_set_features_op vhost_set_features;
>     vhost_get_features_op vhost_get_features;
>     vhost_set_backend_cap_op vhost_set_backend_cap;
>-- 
>2.34.1
>


