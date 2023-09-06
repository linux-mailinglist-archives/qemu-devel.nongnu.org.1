Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 377727937C6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoXy-0007Ee-Hv; Wed, 06 Sep 2023 05:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qdoXr-0007D2-Pt
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qdoXp-0003ux-6d
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693991381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF+SQN72Pjp8JgdvgSXa+5sZftxISo7gA3fnpKO9ZAs=;
 b=XJwQf0gYp9epl9oYqGjSR+k/HuaD73HAfwushWvVWKl7dLlpinvcJJdNd1joZyuCzxsTB5
 z77cGZo36NenyWa9KHj+u+kxyO23O+Ik4NLkmHYAklkBQhrHWaP3RAdgN3RFjkRwUI2Acr
 YTsGyH8U1dYLO0S2YO9HMaJD0Pk1RPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-pzsnbhGnNPaleFT8Vdb48w-1; Wed, 06 Sep 2023 05:09:38 -0400
X-MC-Unique: pzsnbhGnNPaleFT8Vdb48w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2C3B803470;
 Wed,  6 Sep 2023 09:09:37 +0000 (UTC)
Received: from [10.39.193.110] (unknown [10.39.193.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3341121314;
 Wed,  6 Sep 2023 09:09:36 +0000 (UTC)
Message-ID: <64c3ff9a-12d4-c33e-c2a9-5602e4cd060a@redhat.com>
Date: Wed, 6 Sep 2023 11:09:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] vhost-user: strip superfluous whitespace
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-2-lersek@redhat.com>
 <ce2b4c96-8a6b-247c-14eb-b3a6c81973f0@redhat.com>
 <CADSE00+9s4etckQFqGbxc3xB281tffTRPs5CAO5b7J9PeQsyrA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CADSE00+9s4etckQFqGbxc3xB281tffTRPs5CAO5b7J9PeQsyrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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

On 9/6/23 09:12, Albert Esteve wrote:
> 
> 
> On Thu, Aug 31, 2023 at 9:14 AM Laszlo Ersek <lersek@redhat.com
> <mailto:lersek@redhat.com>> wrote:
> 
>     On 8/30/23 15:40, Laszlo Ersek wrote:
>     > Cc: "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>>
>     (supporter:vhost)
>     > Cc: Eugenio Perez Martin <eperezma@redhat.com
>     <mailto:eperezma@redhat.com>>
>     > Cc: German Maglione <gmaglione@redhat.com
>     <mailto:gmaglione@redhat.com>>
>     > Cc: Liu Jiang <gerry@linux.alibaba.com
>     <mailto:gerry@linux.alibaba.com>>
>     > Cc: Sergio Lopez Pascual <slp@redhat.com <mailto:slp@redhat.com>>
>     > Cc: Stefano Garzarella <sgarzare@redhat.com
>     <mailto:sgarzare@redhat.com>>
>     > Signed-off-by: Laszlo Ersek <lersek@redhat.com
>     <mailto:lersek@redhat.com>>
>     > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com
>     <mailto:sgarzare@redhat.com>>
>     > ---
>     >
>     > Notes:
>     >     v2:
>     >     
>     >     - pick up Stefano's R-b
>     >
>     >  hw/virtio/vhost-user.c | 2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     This has been
> 
>     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
> 
>     under the (identical) v1 posting:
> 
>     http://mid.mail-archive.com/cd0604a1-6826-ac6c-6c47-dcb6def64b28@linaro.org <http://mid.mail-archive.com/cd0604a1-6826-ac6c-6c47-dcb6def64b28@linaro.org>
> 
>     Thanks, Phil! (and sorry that I posted v2 too quickly -- I forgot that
>     sometimes reviewers split a review over multiple days.)
> 
>     Laszlo
> 
>     >
>     > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>     > index 8dcf049d422b..b4b677c1ce66 100644
>     > --- a/hw/virtio/vhost-user.c
>     > +++ b/hw/virtio/vhost-user.c
>     > @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev
>     *dev, VhostUserMsg *msg,
>     >       * operations such as configuring device memory mappings or
>     issuing device
>     >       * resets, which affect the whole device instead of
>     individual VQs,
>     >       * vhost-user messages should only be sent once.
>     > -     *
>     > +     *
>     >       * Devices with multiple vhost_devs are given an associated
>     dev->vq_index
>     >       * so per_device requests are only sent if vq_index is 0.
>     >       */
>     >
> 
> 
> Thanks for the series!
> I had a timeout problem with a virtio device I am developing, and I was
> not sure yet what was going on.
> Your description of the problem seemed to fit mine, in my case the
> driver sent a command through the data plane
> right after the feature negotiation that reached the backend too soon.
> Adding delays alleviated the issue, so it
> already hinted me to a race condition.
> 
> I tested using this patch series and according to my experiments, it
> really lowers the chances to get the deadlock.
> Sadly, I do still get the issue sometimes, though (not frequently)...
> However, I think probably the solution comes not
> from the Qemu side, but from the rust-vmm vhost-user-backend crate. I am
> looking for that solution on my side.
> 
> But that does not invalidate this patch, which I think is a necessary
> improvement, and in my tests it really
> helps a lot with the described issue. Therefore:
> 
> Tested-by: Albert Esteve <aesteve@redhat.com <mailto:aesteve@redhat.com>>

Thank you for the testing and the feedback!

My problem with relegating the fix to rust-vmm/vhost -- i.e. with
calling the hang a bug inside rust-vmm/vhost -- is that rust-vmm/vhost
is *unfixable* as long as the vhost-user specification says what it
says. As soon as the guest is permitted to issue a data plane operation,
without forcing it to await completion of an earlier control plane
operation, the cat is out of the bag. Those operations travel through
independent channels, and the vhost-user spec currently requires the
backend to listen to both channels at the same time. There's no way to
restore the original order after both operations have been submitted
effectively in parallel from the guest side.

The guest cannot limit itself, the virtio operations it needs to do (on
the control plane) are described in the virtio spec, in "driver
requirements" sections, and most of those steps are inherently
treated/specified as synchronous. The guest already thinks those steps
are synchronous.

So it really is a spec problem. I see the big problem in the switch from
vhost-net to the generic vhost-user protocol. My understanding from the
virtio-networking series in the RH Developer Blog is that vhost-net was
entirely ioctl() based, and consequently totally synchronous. That was
lost when the protocol was rebased to unix domain sockets, without
upholding the explicit request-response pattern in all operations.

I'm worried we can't get this unstuck until Michael answers Stefan's
question, concerning the spec.

Laszlo


