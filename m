Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E727B6BE5
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngZn-00014t-Qt; Tue, 03 Oct 2023 10:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qngZl-00014Q-TU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qngZk-0000t7-EI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696344038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9FLSZ8A4AlBOxFqQHTueEbXw9iCO1zQ60bmxFGexvg=;
 b=dXEtY1UdAhwQI8qnGwn8VIN7UFWL8daynJFabFRjY8S72oZ6KE+DFDmTk5Np442pUE+pNl
 U9m39RGNnL2atuKAyDsw8uJq3u91LLgflc2die6rMrq9w7r4vWKuxIG7r4qbtby7S9eWkD
 Aqd1ZWJqoLH0S3JzDcIO7/q/FUz+Y4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-vrptLPBtNTKKC5YZ_lZo6Q-1; Tue, 03 Oct 2023 10:40:37 -0400
X-MC-Unique: vrptLPBtNTKKC5YZ_lZo6Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4067f186039so4717355e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696344036; x=1696948836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9FLSZ8A4AlBOxFqQHTueEbXw9iCO1zQ60bmxFGexvg=;
 b=qQYod+xBchvVTTQjUB/ClbGet7693YQ5MskyxarzsjTCgEs/8UaEa0nkChHgYx3+JS
 DVav9gZ2qhEgsOuf8Qa3WgPEodKh7Vx4Z2VNfmJG9DrukBh9UI7W3BYu7Wr0gN0JvSXH
 ZVkHTq8BKLuWgjX4Eu4cL/x0H/9ZxcZuusOusIJsJA0p/4p1sT13JKrdR9qtAW2lSCDx
 4701LDZUnBlTQ3VVxcIrC+vk9h0OHKqaFBqi7SRAiPtx1IcpG3OaOc5kg3in4Z9Zhi8A
 gPNWUYTICWPABO8oYrxnVtOJib6YocAdh/yvabTOP4qWHr72+w9dU96kiOLDEYzrS6qL
 E/iw==
X-Gm-Message-State: AOJu0YxqTljafxfM3Av4P4rmw0lmRr54cRR85BPZszujdlPpCpRKtBPR
 lQy4q893S+Afk+HEq/JmNjKdbp1CSk0Bx/1zUIwu1CTKXQ0hVYA5surfIGsFYpTlpbXtdMYioJU
 6DZzculv5/2bReJQ=
X-Received: by 2002:a5d:5549:0:b0:31f:fc96:9af1 with SMTP id
 g9-20020a5d5549000000b0031ffc969af1mr14327754wrw.59.1696344036337; 
 Tue, 03 Oct 2023 07:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4SODhwHPB6jzzyl32SVCRHGZQFavhWwWLkK3J3ZZ9ZQJfIhUNHfYXoZlYztqqH/5VgFxbuw==
X-Received: by 2002:a5d:5549:0:b0:31f:fc96:9af1 with SMTP id
 g9-20020a5d5549000000b0031ffc969af1mr14327734wrw.59.1696344035921; 
 Tue, 03 Oct 2023 07:40:35 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 q15-20020adfcd8f000000b00327297abe31sm1721221wrj.68.2023.10.03.07.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:40:35 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:40:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231003103143-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
 <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
 <20231002183627-mutt-send-email-mst@kernel.org>
 <CAJSP0QWTRc6Ai+bM9_UwrpgXXmgvN=rMD248nqoGv0PiOd_2Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QWTRc6Ai+bM9_UwrpgXXmgvN=rMD248nqoGv0PiOd_2Sg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 03, 2023 at 09:08:15AM -0400, Stefan Hajnoczi wrote:
> On Tue, 3 Oct 2023 at 08:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 02, 2023 at 05:13:26PM -0400, Stefan Hajnoczi wrote:
> > > One more question:
> > >
> > > Why is the disabled state not needed by regular (non-vhost) virtio-net devices?
> >
> > Tap does the same - it purges queued packets:
> >
> > int tap_disable(NetClientState *nc)
> > {
> >     TAPState *s = DO_UPCAST(TAPState, nc, nc);
> >     int ret;
> >
> >     if (s->enabled == 0) {
> >         return 0;
> >     } else {
> >         ret = tap_fd_disable(s->fd);
> >         if (ret == 0) {
> >             qemu_purge_queued_packets(nc);
> >             s->enabled = false;
> >             tap_update_fd_handler(s);
> >         }
> >         return ret;
> >     }
> > }
> 
> tap_disable() is not equivalent to the vhost-user "started but
> disabled" ring state. tap_disable() is a synchronous one-time action,
> while "started but disabled" is a continuous state.

well, yes. but practically guests do not queue too many buffers
after disabling a queue. I don't know if they reliably don't
or it's racy and we didn't notice it yet - I think it
was mostly dpdk that had this and that's usually
used with vhost-user.

> The "started but disabled" ring state isn't needed to achieve this.
> The back-end can just drop tx buffers upon receiving
> VHOST_USER_SET_VRING_ENABLE .num=0.

yes, maybe that would have been a better way to do this.


> The history of the spec is curious. VHOST_USER_SET_VRING_ENABLE was
> introduced before the the "started but disabled" state was defined,
> and it explicitly mentions tap attach/detach:
> 
> commit 7263a0ad7899994b719ebed736a1119cc2e08110
> Author: Changchun Ouyang <changchun.ouyang@intel.com>
> Date:   Wed Sep 23 12:20:01 2015 +0800
> 
>     vhost-user: add a new message to disable/enable a specific virt queue.
> 
>     Add a new message, VHOST_USER_SET_VRING_ENABLE, to enable or disable
>     a specific virt queue, which is similar to attach/detach queue for
>     tap device.
> 
> and then later:
> 
> commit c61f09ed855b5009f816242ce281fd01586d4646
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Nov 23 12:48:52 2015 +0200
> 
>     vhost-user: clarify start and enable
> 
> >
> > what about non tap backends? I suspect they just aren't
> > used widely with multiqueue so no one noticed.
> 
> I still don't understand why "started but disabled" is needed instead
> of just two ring states: enabled and disabled.

With dropping packets when ring is disabled? Maybe that would
have been enough. I also failed to realize it's specific to
net, seemed generic to me :(

> It seems like the cleanest path going forward is to keep the "ignore
> rx, discard tx" semantics for virtio-net devices but to clarify in the
> spec that other device types do not process the ring:
> 
> "
> * started but disabled: the back-end must not process the ring. For legacy
>   reasons there is an exception for the networking device, where the
>   back-end must process and discard any TX packets and not process
>   other rings.
> "
> 
> What do you think?
> 
> Stefan

Okay... I hope we are not missing any devices which need virtio net
semantics. Care checking them all?

-- 
MST


