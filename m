Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF87B6B6B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngKu-0001UQ-Pu; Tue, 03 Oct 2023 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qngKs-0001Tx-Ev
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qngKq-0006CL-Jl
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696343115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iLYEOufg0rMJKY4ORopDkSeyLLXJRO5ranNibHnwPe0=;
 b=V6GKSvCprtOOb072eoZhzg5gwEkziDH90Aw+mjmUqhjABD/84uFEp5dpArfNG28tmKfwYT
 OkDD4p1rztc9dc4tyqufqx5fMir8c1bD6W+prj6k8yRn5TcDe9U3Q7MizTms9O25XP8FrT
 IDiXCoAWczGmkZyXhSrJHZ7UpZn8+v8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-007I_9zoN3-No1TkvlzQBA-1; Tue, 03 Oct 2023 10:25:13 -0400
X-MC-Unique: 007I_9zoN3-No1TkvlzQBA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405629826ccso7475155e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696343112; x=1696947912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLYEOufg0rMJKY4ORopDkSeyLLXJRO5ranNibHnwPe0=;
 b=ah1XKLY+3Cnnd6+Y4lqx3SwRUj/tozMVA3vrLy8z2grc8hCi0EtpcEMUUpQN1Cljox
 CS9FtRfzPSA8bOHQLjHDskpLNlAj5ZWWuoWoxlP3o/iMvo993QtS24D4vf7MkgXfDaOP
 ol0L/UM+8btM+LdbgF6Ilr5PEvAtJCbwhQOD0QTC2uk/IZMSqYJxjGeQLK6vbnGyvKxp
 Yz8hKNiWyCxHEwPz4L2DcImTfz9q6I/P19q7EFss/nMhIiYCUWqe3Y6dFEDS8oIU3NdH
 R6SnreqhdN03k4Po/js1BH67iQ++jAxJMisQ4iZ2Th3E9YibSbx7RX+qPJaogY7TSHV6
 lEWA==
X-Gm-Message-State: AOJu0YwFQCyqwDIbmuOWiNx4wjWXa1Y4LWhw5uFQY0xr+jD7HP1Wcv0e
 eb5nk3uFP9Wkd6Y/81kAfLhI6FNeRhaLU7FeUOoxM3vuPdXL8o0nuRyujfgFsD6wYJQir1XyjhX
 PTV1iFlISUyjq2tU=
X-Received: by 2002:a7b:cd0e:0:b0:3f9:b244:c294 with SMTP id
 f14-20020a7bcd0e000000b003f9b244c294mr12944842wmj.35.1696343112392; 
 Tue, 03 Oct 2023 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET8cMFW5lHeth9WN6FroFf8TQ36RX/iy1+uRAMfnLQv24zJiXo79wzlvSyyuoFObHwqmRLZA==
X-Received: by 2002:a7b:cd0e:0:b0:3f9:b244:c294 with SMTP id
 f14-20020a7bcd0e000000b003f9b244c294mr12944782wmj.35.1696343111132; 
 Tue, 03 Oct 2023 07:25:11 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003fc06169ab3sm9578817wmb.20.2023.10.03.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:25:10 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:25:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231003102338-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
 <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
 <20231002183627-mutt-send-email-mst@kernel.org>
 <CAJSP0QWTRc6Ai+bM9_UwrpgXXmgvN=rMD248nqoGv0PiOd_2Sg@mail.gmail.com>
 <037ac5f2-8c19-e1ff-fc96-3cda8755924f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037ac5f2-8c19-e1ff-fc96-3cda8755924f@redhat.com>
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

On Tue, Oct 03, 2023 at 03:23:24PM +0200, Laszlo Ersek wrote:
> On 10/3/23 15:08, Stefan Hajnoczi wrote:
> > On Tue, 3 Oct 2023 at 08:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Mon, Oct 02, 2023 at 05:13:26PM -0400, Stefan Hajnoczi wrote:
> >>> One more question:
> >>>
> >>> Why is the disabled state not needed by regular (non-vhost) virtio-net devices?
> >>
> >> Tap does the same - it purges queued packets:
> >>
> >> int tap_disable(NetClientState *nc)
> >> {
> >>     TAPState *s = DO_UPCAST(TAPState, nc, nc);
> >>     int ret;
> >>
> >>     if (s->enabled == 0) {
> >>         return 0;
> >>     } else {
> >>         ret = tap_fd_disable(s->fd);
> >>         if (ret == 0) {
> >>             qemu_purge_queued_packets(nc);
> >>             s->enabled = false;
> >>             tap_update_fd_handler(s);
> >>         }
> >>         return ret;
> >>     }
> >> }
> > 
> > tap_disable() is not equivalent to the vhost-user "started but
> > disabled" ring state. tap_disable() is a synchronous one-time action,
> > while "started but disabled" is a continuous state.
> > 
> > The "started but disabled" ring state isn't needed to achieve this.
> > The back-end can just drop tx buffers upon receiving
> > VHOST_USER_SET_VRING_ENABLE .num=0.
> > 
> > The history of the spec is curious. VHOST_USER_SET_VRING_ENABLE was
> > introduced before the the "started but disabled" state was defined,
> > and it explicitly mentions tap attach/detach:
> > 
> > commit 7263a0ad7899994b719ebed736a1119cc2e08110
> > Author: Changchun Ouyang <changchun.ouyang@intel.com>
> > Date:   Wed Sep 23 12:20:01 2015 +0800
> > 
> >     vhost-user: add a new message to disable/enable a specific virt queue.
> > 
> >     Add a new message, VHOST_USER_SET_VRING_ENABLE, to enable or disable
> >     a specific virt queue, which is similar to attach/detach queue for
> >     tap device.
> > 
> > and then later:
> > 
> > commit c61f09ed855b5009f816242ce281fd01586d4646
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Mon Nov 23 12:48:52 2015 +0200
> > 
> >     vhost-user: clarify start and enable
> > 
> >>
> >> what about non tap backends? I suspect they just aren't
> >> used widely with multiqueue so no one noticed.
> > 
> > I still don't understand why "started but disabled" is needed instead
> > of just two ring states: enabled and disabled.
> > 
> > It seems like the cleanest path going forward is to keep the "ignore
> > rx, discard tx" semantics for virtio-net devices but to clarify in the
> > spec that other device types do not process the ring:
> > 
> > "
> > * started but disabled: the back-end must not process the ring. For legacy
> >   reasons there is an exception for the networking device, where the
> >   back-end must process and discard any TX packets and not process
> >   other rings.
> > "
> > 
> > What do you think?
> 
> ... from a vhost-user backend perspective, won't this create a need for
> all "ring processor" (~ virtio event loop) implementations to support
> both methods? IIUC, the "virtio pop" is usually independent of the
> particular device to which the requests are ultimately delivered. So the
> event loop would have to grow a new parameter regarding "what to do in
> the started-but-disabled state", the network device would have to pass
> in one value (-> pop & drop), and all other devices would have to pass
> in the other value (stop popping).
> 
> ... I figure in rust-vmm/vhost it would affect the "handle_event"
> function in "crates/vhost-user-backend/src/event_loop.rs".
> 
> Do I understand right? (Not disagreeing, just pondering the impact on
> backends.)
> 
> Laszlo

Already the case I guess - RX ring is not processed, TX is. Right?

-- 
MST


