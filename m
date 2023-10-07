Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033E7BC9EE
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 23:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpEqC-0004A6-KB; Sat, 07 Oct 2023 17:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpEqA-00049u-Kv
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 17:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpEq8-0000jI-RI
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 17:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696714079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PnWIi+5SYj7LjnmTzYMYNJmPLp5u2QULYMo9YNfQdLM=;
 b=HqZuqQM4UXewNeCUl9f+vZRYn1qDLeqg7a51KP8MTPOjwmn4IZqta1qeJEEjSnUfQBtwb3
 G08j0NzkvlSt7t/dK+L6FzwI+gb2BDKl86Y0baWQXuisrfRn7CGUMu2DkAoYAv4Ocut41n
 J5UupUTQ74ZWiJlqudyC2pc9l4fel7A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-XfnqEA9gOHmZ_KoFcSUH2A-1; Sat, 07 Oct 2023 17:27:52 -0400
X-MC-Unique: XfnqEA9gOHmZ_KoFcSUH2A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ae42088b4bso251962866b.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 14:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696714071; x=1697318871;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnWIi+5SYj7LjnmTzYMYNJmPLp5u2QULYMo9YNfQdLM=;
 b=L8hIiR5EToIh11w1C/+iM493EE66Z8SVIstqRqn5unLqmMoyFnPbtsDZ8WjBLweedA
 KCXC1t4nf+sFSCHwtQguzsonIVNzMzyG5YfkaVJuIVt6mWBS0YnkeD3PVYtlVkUt0X7Y
 J3CGE3uINxVT8JfQ9qV7cl07MsMQCxhr/RpH2sg+SEwoz3KeR3JbKv0zu+T31m2ZYb57
 DIPj8S9Ave+QJtJ12VbX0+XjFahM+mybpa8qei75xvmuEIqTcAW5TXrNlaf6KeLU4JwV
 U4ZKNJis/XTo3v+85h3Ke86JLP11XkJbK3ZEtqAwPnWbq3I1IZSlxTubI0fc9yvy/Ph4
 4sKg==
X-Gm-Message-State: AOJu0Yznf3vK3+RNE11U5sTHtOg2NWcbIQt5WCCGUG3vVoMVpuYkq7xv
 ZBxDBICZBk0fSY2UOlEpvEf+E7KKt4mjzLtOvvjPHsn56cd3P5QTskxyS5kPF7BY0YedrSp39tl
 20XJK0ocZ48g7dYY=
X-Received: by 2002:a17:907:2724:b0:9ae:6196:a410 with SMTP id
 d4-20020a170907272400b009ae6196a410mr10359946ejl.43.1696714071221; 
 Sat, 07 Oct 2023 14:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpdp83j5yZyXkz9qjD+ayJiYgJnOho8SBK7YpPf1p7ttVW5m8AGZeKUT1HLG1fi2iwdWbF8Q==
X-Received: by 2002:a17:907:2724:b0:9ae:6196:a410 with SMTP id
 d4-20020a170907272400b009ae6196a410mr10359936ejl.43.1696714070844; 
 Sat, 07 Oct 2023 14:27:50 -0700 (PDT)
Received: from redhat.com ([2.55.10.88]) by smtp.gmail.com with ESMTPSA id
 lu22-20020a170906fad600b009944e955e19sm4728888ejb.30.2023.10.07.14.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:27:50 -0700 (PDT)
Date: Sat, 7 Oct 2023 17:27:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: virtio-fs@redhat.com,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v4 2/8] vhost-user.rst: Improve
 [GS]ET_VRING_BASE doc
Message-ID: <20231007171812-mutt-send-email-mst@kernel.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-3-hreitz@redhat.com>
 <20231005173859.GC1342722@fedora>
 <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
 <20231006044753-mutt-send-email-mst@kernel.org>
 <483bedcf-9c55-6977-f82c-5ce611ca5769@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <483bedcf-9c55-6977-f82c-5ce611ca5769@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 06, 2023 at 03:55:56PM +0200, Hanna Czenczek wrote:
> On 06.10.23 10:49, Michael S. Tsirkin wrote:
> > On Fri, Oct 06, 2023 at 09:53:53AM +0200, Hanna Czenczek wrote:
> > > On 05.10.23 19:38, Stefan Hajnoczi wrote:
> > > > On Wed, Oct 04, 2023 at 02:58:58PM +0200, Hanna Czenczek wrote:
> > > > > GET_VRING_BASE does not mention that it stops the respective ring.  Fix
> > > > > that.
> > > > > 
> > > > > Furthermore, it is not fully clear what the "base offset" these
> > > > > commands' documentation refers to is; an offset could be many things.
> > > > > Be more precise and verbose about it, especially given that these
> > > > > commands use different payload structures depending on whether the vring
> > > > > is split or packed.
> > > > > 
> > > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > > ---
> > > > >    docs/interop/vhost-user.rst | 66 ++++++++++++++++++++++++++++++++++---
> > > > >    1 file changed, 62 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > > > index 2f68e67a1a..50f5acebe5 100644
> > > > > --- a/docs/interop/vhost-user.rst
> > > > > +++ b/docs/interop/vhost-user.rst
> > > > > @@ -108,6 +108,37 @@ A vring state description
> > > > >    :num: a 32-bit number
> > > > > +A vring descriptor index for split virtqueues
> > > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > +
> > > > > ++-------------+---------------------+
> > > > > +| vring index | index in avail ring |
> > > > > ++-------------+---------------------+
> > > > > +
> > > > > +:vring index: 32-bit index of the respective virtqueue
> > > > > +
> > > > > +:index in avail ring: 32-bit value, of which currently only the lower 16
> > > > > +  bits are used:
> > > > > +
> > > > > +  - Bits 0–15: Next descriptor index in the *Available Ring*
> > > > I think we need to say more to make this implementable just by reading
> > > > the spec:
> > > > 
> > > >     Index of the next *Available Ring* descriptor that the back-end will
> > > >     process. This is a free-running index that is not wrapped by the ring
> > > >     size.
> > > Sure, thanks.
> > > 
> > > > Feel free to rephrase.
> > > > 
> > > > > +  - Bits 16–31: Reserved (set to zero)
> > > > > +
> > > > > +Vring descriptor indices for packed virtqueues
> > > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > +
> > > > > ++-------------+--------------------+
> > > > > +| vring index | descriptor indices |
> > > > > ++-------------+--------------------+
> > > > > +
> > > > > +:vring index: 32-bit index of the respective virtqueue
> > > > > +
> > > > > +:descriptor indices: 32-bit value:
> > > > > +
> > > > > +  - Bits 0–14: Index in the *Available Ring*
> > > > Same here.
> > > > 
> > > > > +  - Bit 15: Driver (Available) Ring Wrap Counter
> > > > > +  - Bits 16–30: Index in the *Used Ring*
> > > > Same here.
> > > > 
> > > > > +  - Bit 31: Device (Used) Ring Wrap Counter
> > > > > +
> > > > >    A vring address description
> > > > >    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > @@ -1031,18 +1062,45 @@ Front-end message types
> > > > >    ``VHOST_USER_SET_VRING_BASE``
> > > > >      :id: 10
> > > > >      :equivalent ioctl: ``VHOST_SET_VRING_BASE``
> > > > > -  :request payload: vring state description
> > > > > +  :request payload: vring descriptor index/indices
> > > > >      :reply payload: N/A
> > > > > -  Sets the base offset in the available vring.
> > > > > +  Sets the next index to use for descriptors in this vring:
> > > > > +
> > > > > +  * For a split virtqueue, sets only the next descriptor index in the
> > > > > +    *Available Ring*.  The device is supposed to read the next index in
> > > > > +    the *Used Ring* from the respective vring structure in guest memory.
> > > > > +
> > > > > +  * For a packed virtqueue, both indices are supplied, as they are not
> > > > > +    explicitly available in memory.
> > > > > +
> > > > > +  Consequently, the payload type is specific to the type of virt queue
> > > > > +  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
> > > > > +  indices for packed virtqueues*).
> > > > >    ``VHOST_USER_GET_VRING_BASE``
> > > > >      :id: 11
> > > > >      :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
> > > > >      :request payload: vring state description
> > > > > -  :reply payload: vring state description
> > > > > +  :reply payload: vring descriptor index/indices
> > > > > +
> > > > > +  Stops the vring and returns the current descriptor index or indices:
> > > > > +
> > > > > +    * For a split virtqueue, returns only the 16-bit next descriptor
> > > > > +      index in the *Available Ring*.  The index in the *Used Ring* is
> > > > > +      controlled by the guest driver and can be read from the vring
> > > > I find "is controlled by the guest driver" confusing. The device writes
> > > > the Used Ring index. The driver only reads it. The device is the active
> > > > party here.
> > > Er, good point.  That breaks the whole reasoning.  Then I don’t understand
> > > why we do get/set the available ring index and not the used ring index.  Do
> > > you know why?
> > It's simple. used ring index in memory is controlled by the device and
> > reflects device state.
> 
> Exactly, it’s device state, that’s why I thought the front-end needs to
> ensure its read and restored around the reset we currently have in
> vhost_dev_stop()/start().
> 
> > device can just read it back to restore.
> 
> I find it strange that the device is supposed to read its own state from
> memory.

/me shrugs. It puts it there, why not read it back. Duplicating state
is not usually a good idea - leads to bugs.

> > available ring index in memory is controlled by driver and does
> > not reflect device state.
> 
> Why can’t the device read the available index from memory?  That value is
> put into memory by the driver precisely so the device can read it from
> there.
> 
> Hanna

Consider an example of RX ring for net device. buffers might be
available but device does not use them until packets arrive.  what I
think you could say is that actually just the used index should be
sufficient. So I think main thing GET_BASE does is stop the ring. As for
the value returned, we can if we want to validate that it matches used
ring index.

-- 
MST


