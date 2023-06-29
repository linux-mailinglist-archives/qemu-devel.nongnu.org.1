Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC07420D1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElqz-000067-QF; Thu, 29 Jun 2023 03:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qElqx-00005i-IX
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qElqv-0005Fd-26
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688022843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/QEhG9UJj+Amcskzq6x047pLj+1zs8AL+K4iBjKompQ=;
 b=H4JG7eR/ZC3MP5+zUMub61hsnwRB11L6smCzk7gSs/ecw/wXluVmX9W9f60sjsXB/MZr2e
 JyqCuYcSwm7xN9Q3Pn/kP7rmXwOBAYT4k2X9utRvfMhOoLPz0oIzpJE+eCnw1Sm2mFBCB2
 aalU1D6cVxmnW9J7QWkxFj9qxymjtB8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-KnBDFcCjNxubuQJofWIvsA-1; Thu, 29 Jun 2023 03:13:59 -0400
X-MC-Unique: KnBDFcCjNxubuQJofWIvsA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b620465d0eso3192591fa.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688022837; x=1690614837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QEhG9UJj+Amcskzq6x047pLj+1zs8AL+K4iBjKompQ=;
 b=AvGW8VGm3oh7N+OYKaarzil1nmnlniwB0KI1wCeUhVEyXKPBJ4/ELW7T0hmn1k8u2k
 ehs/X1jCN7CjDpx6lB2w0qbjqFKFPFx6XeHttolzAr4o9x8AZIvTB68epqiPmZdRGPmo
 mg8EsXGRXA/I8KhtgmUXIQ5gjttFqJTKQpm6SLNGC7m9rLV3z4nKz5swzsbVSSCLUjks
 f9vD97FGkgYP6mvffAN1/igq/FxF50KKlrxm+g4HwRwC4iD0nW8y+DmR+1tNBr8t2GSz
 28POFqgwJHQYownssVhE8j8wrPctip03zRJJIvf3GjvNHLH2/4fEXi7VmLknvXm+n6St
 7i4Q==
X-Gm-Message-State: AC+VfDzZe1snQnJEp2L3yTp6Sr/y+d+s4LvJHBEuXJvQ69EvsOOlA7uB
 MvdjN4qK7YqjvXNNZgX2HJMBve9WaPW/7BJmrWfBf1lhhhscAWsur1R7Z1BI+Pw52Aw6EjMXXRL
 17FO6c7usFdF353fG/+qRi9k=
X-Received: by 2002:a2e:b163:0:b0:2b6:a08d:e142 with SMTP id
 a3-20020a2eb163000000b002b6a08de142mr7659559ljm.7.1688022837035; 
 Thu, 29 Jun 2023 00:13:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xEso6o2JNpGz71RZP8k2R9XxGe72isPuJunURk9oRMi6nE/svJHFOfWQiylSjxMrOLfc08Q==
X-Received: by 2002:a2e:b163:0:b0:2b6:a08d:e142 with SMTP id
 a3-20020a2eb163000000b002b6a08de142mr7659549ljm.7.1688022836624; 
 Thu, 29 Jun 2023 00:13:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:4322:e639:6002:3388:4c85])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a1cf314000000b003f90b9b2c31sm18903472wmq.28.2023.06.29.00.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 00:13:55 -0700 (PDT)
Date: Thu, 29 Jun 2023 03:13:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Rma Ma <rma.ma@jaguarmicro.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vhost-user: use new thread to loop backend channel.
Message-ID: <20230629030821-mutt-send-email-mst@kernel.org>
References: <20230629065415.8211-1-rma.ma@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629065415.8211-1-rma.ma@jaguarmicro.com>
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

On Thu, Jun 29, 2023 at 02:54:15PM +0800, Rma Ma wrote:
> fix: QEMU deadlock with dpdk-vdpa
> 
> QEMU start vhost-user with modern net and blk, backend use dpdk-vdpa process,
> after live migration, dest QEMU deadlock with dpdk-vdpa
> 
> - QEMU sends VHOST_USER_SET_VRING_KICK to dpdk-vdpa net
> - QEMU does not need to wait for a response to this message
> - QEMU then sends VHOST_USER_SET_MEM_TABLE to dpdk-vdpa blk
> - QEMU needs to wait reply in this message
> - when dpdk-vdpa recv VHOST_USER_SET_VRING_KICK, it will send VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG to QEMU
> - dpdk-vdpa needs to wait for a response to this message
> - since QEMU vhost_user_read and backend channel are synchronous in the same thread
> - QEMU will deadlock with dpdk-vdpa
> 
> Signed-off-by: Rma Ma <rma.ma@jaguarmicro.com>

Hmm this will need some thought. I'm concerned that this
is making what was previously a simple synchronous
code, multithreaded.

Also I feel dpdk needs to fix this too.

Let's document in the doc that when backend is allowed to send messages
(VHOST_USER_PROTOCOL_F_BACKEND_REQ) , neither side is allowed to block
processing incoming messsages while waiting for response.


> ---
>  hw/virtio/vhost-user.c | 67 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c 
> index c4e0cbd702..1f6b3a5a63 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -274,6 +274,17 @@ struct scrub_regions {
>      int fd_idx;
>  };
>  
> +struct backend_thread {
> +    QemuThread thread;
> +    QemuSemaphore init_done_sem;
> +    int thread_id;
> +    GMainContext *ctxt;
> +    GMainLoop *loop;
> +};
> +
> +static struct backend_thread *backend_th;
> +static bool backend_thread_run;
> +
>  static bool ioeventfd_enabled(void)
>  {
>      return !kvm_enabled() || kvm_eventfds_enabled();
> @@ -1696,7 +1707,8 @@ fdcleanup:
>      return rc;
>  }
>  
> -static int vhost_setup_backend_channel(struct vhost_dev *dev)
> +static int vhost_setup_backend_channel(struct vhost_dev *dev,
> +                                       GMainContext *ctxt)
>  {
>      VhostUserMsg msg = {
>          .hdr.request = VHOST_USER_SET_BACKEND_REQ_FD,
> @@ -1728,7 +1740,7 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
>      u->backend_ioc = ioc;
>      u->backend_src = qio_channel_add_watch_source(u->backend_ioc,
>                                                  G_IO_IN | G_IO_HUP,
> -                                                backend_read, dev, NULL, NULL);
> +                                                backend_read, dev, NULL, ctxt);
>  
>      if (reply_supported) {
>          msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> @@ -1981,6 +1993,42 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>      return 0;
>  }
>  
> +static void *vhost_backend_channel_worker(void *opaque)
> +{
> +    struct backend_thread *backend_th = opaque;
> +
> +    rcu_register_thread();
> +
> +    backend_th->ctxt = g_main_context_new();
> +    backend_th->loop = g_main_loop_new(backend_th->ctxt, false);
> +    backend_th->thread_id = qemu_get_thread_id();
> +
> +    qemu_sem_post(&backend_th->init_done_sem);
> +
> +    g_main_loop_run(backend_th->loop);
> +
> +    g_main_loop_unref(backend_th->loop);
> +    g_main_context_unref(backend_th->ctxt);
> +    g_free(backend_th);
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
> +static void vhost_backend_thread_init(void)
> +{
> +    backend_th = g_malloc0(sizeof(struct backend_thread));
> +    backend_th->thread_id = -1;
> +    qemu_sem_init(&backend_th->init_done_sem, 0);
> +
> +    qemu_thread_create(&backend_th->thread, "backend-channel-worker",
> +                       vhost_backend_channel_worker, backend_th,
> +                       QEMU_THREAD_DETACHED);
> +
> +    while (backend_th->thread_id == -1) {
> +        qemu_sem_wait(&backend_th->init_done_sem);
> +    }
> +}
> +
>  static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>                                     Error **errp)
>  {
> @@ -2108,10 +2156,17 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>      }
>  
>      if (dev->vq_index == 0) {
> -        err = vhost_setup_backend_channel(dev);
> -        if (err < 0) {
> -            error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
> -            return -EPROTO;
> +        if (!backend_thread_run) {
> +            vhost_backend_thread_init();
> +            backend_thread_run = true;
> +        }
> +
> +        if (backend_thread_run && backend_th) {
> +            err = vhost_setup_backend_channel(dev, backend_th->ctxt);
> +            if (err < 0) {
> +                error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
> +                return -EPROTO;
> +            }
>          }
>      }
>  
> -- 
> 2.17.1


