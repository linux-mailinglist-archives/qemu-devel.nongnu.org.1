Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C999A1E7C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 11:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Msq-0003JN-8r; Thu, 17 Oct 2024 05:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Mso-0003Il-IH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Msm-0006O4-NU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729157602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvqpccjRYLS/iTjVBI4Oy4N+qvc0IHSczp83xzva1TM=;
 b=SEJBMtvtetJirpymY7P+tuF1JRGl8NeM3VMBvqCjrYLUOy1SkdcqrFY0pUG6jw97TJv5L+
 /oWfvh5mbAWAUHAwBLuQXzpwyVvONzrIPLJFRWGh/3K8jbHZWkCDtkxw3vqr3gmEzv8hUX
 up+MGOg6mE0GUw+4KnHAkvHJC1lE6w4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-BRXlZfLmNYm-sNTum8iNVQ-1; Thu,
 17 Oct 2024 05:33:21 -0400
X-MC-Unique: BRXlZfLmNYm-sNTum8iNVQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 764271955E9F
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:33:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35A85300019D; Thu, 17 Oct 2024 09:33:17 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:33:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
Message-ID: <ZxDZ2r1xnG32CWAw@redhat.com>
References: <20241016090606.2358056-1-aesteve@redhat.com>
 <ZxDOZjIixsfvGuQT@redhat.com>
 <CADSE00+ae2kQSM-d=m=ach=KOyH5ffKWRLcpCuyb0s35SED=vg@mail.gmail.com>
 <ZxDWQWpKfp7wJ_Nh@redhat.com>
 <CADSE00J32yA+A_tzp6eJxMoioUuQNEZvbyDoVCdqRErhORxFQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00J32yA+A_tzp6eJxMoioUuQNEZvbyDoVCdqRErhORxFQg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 17, 2024 at 11:28:56AM +0200, Albert Esteve wrote:
> On Thu, Oct 17, 2024 at 11:18 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 11:12:32AM +0200, Albert Esteve wrote:
> > > On Thu, Oct 17, 2024 at 10:44 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
> > > > > VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
> > > > > VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
> > > > > in the spec that they return 0 for successful
> > > > > operations, non-zero otherwise. However,
> > > > > implementation relies on the return types
> > > > > of the virtio-dmabuf library, with opposite
> > > > > semantics (true if everything is correct,
> > > > > false otherwise). Therefore, current implementaion
> > > > > violates the specification.
> > > > >
> > > > > Revert the logic so that the implementation
> > > > > of the vhost-user handling methods matches
> > > > > the specification.
> > > > >
> > > > > Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
> > > > > Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> > > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > > ---
> > > > >  hw/virtio/vhost-user.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > index 00561daa06..90917352a4 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
> > > > >      QemuUUID uuid;
> > > > >
> > > > >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > > > > -    return virtio_add_vhost_device(&uuid, dev);
> > > > > +    return !virtio_add_vhost_device(&uuid, dev);
> > > > >  }
> > > >
> > > > This virtio_add_vhost_device() method returns a bool, but this
> > > > vhost_user_backend_handle_shared_object_add() method returns
> > > > an int, but fills that int with an inverted bool value. The
> > > > caller then assigns the return value to an int, but then
> > > > interprets the int as a bool, and assigns that bool result
> > > > to an u64.
> > > >
> > > > This call chain is madness :-(
> > >
> > > TBF most of the madness is part of the already existing
> > > handling infrastructure.
> > > vhost_user_backend_handle_shared_object_add()
> > > returns an int to be consistent with other handling
> > > functions.
> > >
> > > >
> > > > Change vhost_user_backend_handle_shared_object_add to return
> > > > a bool to reduce the madness IMHO.
> > >
> > > Changing it to bool would make it inconsistent
> > > wrt other handlers, and the casting would happen nonetheless
> > > on assignment. Not sure if that is an improvement.
> >
> > Well when the caller does
> >
> >         payload.u64 = !!ret;
> >
> > it is saying that it only cares about the values
> > being 0 or 1. So how about just making these
> > methods return 0 or 1 then.
> 
> Ah, I see your point. I introduced negative error
> values just because I saw other handlers doing
> it (e.g., vhost_user_backend_handle_vring_host_notifier()).
> 
> > > > >  static int
> > > > > @@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
> > > > >          struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
> > > > >          if (dev != owner) {
> > > > >              /* Not allowed to remove non-owned entries */
> > > > > -            return 0;
> > > > > +            return -EPERM;
> 
> So you are suggesting here it could be `return 1;` instead?
> It does not look clear enough that it is an error value.

Add API documentation comments to these methods

 "Returns: 0 on success, 1 on error"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


