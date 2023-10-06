Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F397BB380
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogX9-0003cz-UG; Fri, 06 Oct 2023 04:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qogX8-0003cr-F6
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qogX5-0004hH-JZ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696582202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+v4NSN0IfKwbnu3ebS9uuykAQPQfdnVh1A/Obwlrp0o=;
 b=V9YYV7Ch0I54rmUYXM9DZQeFdVdRTDJnHYxOgL2yLgrG92UxV9ZAmFjilQz3YVX39AiG08
 a3s+Gz2GNBVGNUeEXJJ4lD5wNPoNvJNnX8bBgh/HDWBvhuUTFmP9KTuL4x0BibfPN2MLXq
 MJJ+lO9lkGhp0gNjT/C9LLedxLsNBp4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-GEhvDtGoPJqJukY5qSOVrA-1; Fri, 06 Oct 2023 04:49:46 -0400
X-MC-Unique: GEhvDtGoPJqJukY5qSOVrA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4054743df06so13361065e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696582185; x=1697186985;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+v4NSN0IfKwbnu3ebS9uuykAQPQfdnVh1A/Obwlrp0o=;
 b=OFozH1thuXwmTtwUVUmvQXmV7/9FdGbQRXOGfc9XBy2eOpJSIJHQtnW3XPmlZvxIAu
 DAZ3cxxV0swBJAoRSQAJqnnZEO9+0pp/qxZ1qsOMlGVO4xvEPTncBDK8dHWWpCD9z/si
 paAt8NzXN/1+62cVqqfk1oVyGZ1NfWjHyzsLCUYcUV2aEPSES8Q8vhIXzMku+QF8UsCB
 Io2LqckCWtTl4UCNugHN5E4g4sYpnoyAuvpHYx2qsMMDxJRl/4uCJT9ssixkGR//Fid3
 fwzvEIvkHsBh91Lf3QaRbAbZC/E9RGsXfn0ypCweLvVW/P5+Bg2r+nEk19OH65YntieW
 fNqg==
X-Gm-Message-State: AOJu0YxGq7KdbLjiXeOVhUH+kmOvSS9hxGWw3CFeHfvgndNrWGkdXpOH
 LDsr/J6N0otXceAYf26NOxhk5CoNGh/1PswPVrvFmAb9Bto/IcAV4QA4uXKtTbSvTfB7ekG8Ilc
 X2yQygCnMfyCbbjo=
X-Received: by 2002:a1c:7419:0:b0:405:7b92:453e with SMTP id
 p25-20020a1c7419000000b004057b92453emr6844429wmc.37.1696582185251; 
 Fri, 06 Oct 2023 01:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBmhuBjOD8nFrokOAWAn4P+OZhAJGEVnDWh7nGa1IPrtvVRZVcddHKcPD+rq5pzv2NL1QWFA==
X-Received: by 2002:a1c:7419:0:b0:405:7b92:453e with SMTP id
 p25-20020a1c7419000000b004057b92453emr6844408wmc.37.1696582184814; 
 Fri, 06 Oct 2023 01:49:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:170:ca0a:84b4:d350:99ea:3666])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a7bc84b000000b0040648217f4fsm5503088wml.39.2023.10.06.01.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 01:49:44 -0700 (PDT)
Date: Fri, 6 Oct 2023 04:49:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [Virtio-fs] [PATCH v4 2/8] vhost-user.rst: Improve
 [GS]ET_VRING_BASE doc
Message-ID: <20231006044753-mutt-send-email-mst@kernel.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-3-hreitz@redhat.com>
 <20231005173859.GC1342722@fedora>
 <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
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

On Fri, Oct 06, 2023 at 09:53:53AM +0200, Hanna Czenczek wrote:
> On 05.10.23 19:38, Stefan Hajnoczi wrote:
> > On Wed, Oct 04, 2023 at 02:58:58PM +0200, Hanna Czenczek wrote:
> > > GET_VRING_BASE does not mention that it stops the respective ring.  Fix
> > > that.
> > > 
> > > Furthermore, it is not fully clear what the "base offset" these
> > > commands' documentation refers to is; an offset could be many things.
> > > Be more precise and verbose about it, especially given that these
> > > commands use different payload structures depending on whether the vring
> > > is split or packed.
> > > 
> > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > ---
> > >   docs/interop/vhost-user.rst | 66 ++++++++++++++++++++++++++++++++++---
> > >   1 file changed, 62 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > index 2f68e67a1a..50f5acebe5 100644
> > > --- a/docs/interop/vhost-user.rst
> > > +++ b/docs/interop/vhost-user.rst
> > > @@ -108,6 +108,37 @@ A vring state description
> > >   :num: a 32-bit number
> > > +A vring descriptor index for split virtqueues
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > ++-------------+---------------------+
> > > +| vring index | index in avail ring |
> > > ++-------------+---------------------+
> > > +
> > > +:vring index: 32-bit index of the respective virtqueue
> > > +
> > > +:index in avail ring: 32-bit value, of which currently only the lower 16
> > > +  bits are used:
> > > +
> > > +  - Bits 0–15: Next descriptor index in the *Available Ring*
> > I think we need to say more to make this implementable just by reading
> > the spec:
> > 
> >    Index of the next *Available Ring* descriptor that the back-end will
> >    process. This is a free-running index that is not wrapped by the ring
> >    size.
> 
> Sure, thanks.
> 
> > Feel free to rephrase.
> > 
> > > +  - Bits 16–31: Reserved (set to zero)
> > > +
> > > +Vring descriptor indices for packed virtqueues
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > ++-------------+--------------------+
> > > +| vring index | descriptor indices |
> > > ++-------------+--------------------+
> > > +
> > > +:vring index: 32-bit index of the respective virtqueue
> > > +
> > > +:descriptor indices: 32-bit value:
> > > +
> > > +  - Bits 0–14: Index in the *Available Ring*
> > Same here.
> > 
> > > +  - Bit 15: Driver (Available) Ring Wrap Counter
> > > +  - Bits 16–30: Index in the *Used Ring*
> > Same here.
> > 
> > > +  - Bit 31: Device (Used) Ring Wrap Counter
> > > +
> > >   A vring address description
> > >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > @@ -1031,18 +1062,45 @@ Front-end message types
> > >   ``VHOST_USER_SET_VRING_BASE``
> > >     :id: 10
> > >     :equivalent ioctl: ``VHOST_SET_VRING_BASE``
> > > -  :request payload: vring state description
> > > +  :request payload: vring descriptor index/indices
> > >     :reply payload: N/A
> > > -  Sets the base offset in the available vring.
> > > +  Sets the next index to use for descriptors in this vring:
> > > +
> > > +  * For a split virtqueue, sets only the next descriptor index in the
> > > +    *Available Ring*.  The device is supposed to read the next index in
> > > +    the *Used Ring* from the respective vring structure in guest memory.
> > > +
> > > +  * For a packed virtqueue, both indices are supplied, as they are not
> > > +    explicitly available in memory.
> > > +
> > > +  Consequently, the payload type is specific to the type of virt queue
> > > +  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
> > > +  indices for packed virtqueues*).
> > >   ``VHOST_USER_GET_VRING_BASE``
> > >     :id: 11
> > >     :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
> > >     :request payload: vring state description
> > > -  :reply payload: vring state description
> > > +  :reply payload: vring descriptor index/indices
> > > +
> > > +  Stops the vring and returns the current descriptor index or indices:
> > > +
> > > +    * For a split virtqueue, returns only the 16-bit next descriptor
> > > +      index in the *Available Ring*.  The index in the *Used Ring* is
> > > +      controlled by the guest driver and can be read from the vring
> > I find "is controlled by the guest driver" confusing. The device writes
> > the Used Ring index. The driver only reads it. The device is the active
> > party here.
> 
> Er, good point.  That breaks the whole reasoning.  Then I don’t understand
> why we do get/set the available ring index and not the used ring index.  Do
> you know why?

It's simple. used ring index in memory is controlled by the device and
reflects device state. device can just read it back to restore.
available ring index in memory is controlled by driver and does
not reflect device state.

> > The sentence can be shortened to omit the "controlled by the guest
> > driver" part.
> 
> I don’t want to shorten it, because I would like to know why we don’t
> get/set both indices for split virtqueues, too.
> 
> Hanna
> 
> > > +      structure in memory, so is not covered.
> > > +
> > > +    * For a packed virtqueue, neither index is explicitly available to
> > > +      read from memory, so both indices (as maintained by the device) are
> > > +      returned.
> > > +
> > > +  Consequently, the payload type is specific to the type of virt queue
> > > +  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
> > > +  indices for packed virtqueues*).
> > > -  Get the available vring base offset.
> > > +  The request payload’s *num* field is currently reserved and must be
> > > +  set to 0.
> > >   ``VHOST_USER_SET_VRING_KICK``
> > >     :id: 12
> > > -- 
> > > 2.41.0
> > > 
> > > 
> > > _______________________________________________
> > > Virtio-fs mailing list
> > > Virtio-fs@redhat.com
> > > https://listman.redhat.com/mailman/listinfo/virtio-fs


