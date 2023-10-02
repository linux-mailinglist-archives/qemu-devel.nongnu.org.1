Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC697B5B8B
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 21:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnOuQ-0002Rs-Ld; Mon, 02 Oct 2023 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnOuL-0002RS-Rv
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 15:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnOuG-0002JT-0m
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 15:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696276117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFzmZQqLQUt35caRZP/5pvBiboZC4+c8WT4I98C/NyI=;
 b=Q8xGQ8jAKzcvTXjy3O3ywdSq+BSGRYdeYKMLwxyyN/q7sav6mh4q/vdXebYBrTCKi4HZ7S
 F/8gW5pCr2vpLx8wUKtQ/Go+GvDTxi7QBWyABoVav0hH91WbVB0JcydCHlEyBFdEhWY4IR
 CXyEQbPoNTf8pG6hq/1niraT2cXnnZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-_ophFPhpPCmatQ9IuLcbFQ-1; Mon, 02 Oct 2023 15:48:24 -0400
X-MC-Unique: _ophFPhpPCmatQ9IuLcbFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBC7F8039C8;
 Mon,  2 Oct 2023 19:48:23 +0000 (UTC)
Received: from [10.39.192.119] (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A646110EE6CE;
 Mon,  2 Oct 2023 19:48:21 +0000 (UTC)
Message-ID: <b23a01a6-5505-6966-f9c1-b9cdd258dfc8@redhat.com>
Date: Mon, 2 Oct 2023 21:48:20 +0200
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
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

Thanks again -- I'm picking this up for the whole series.

Laszlo

> 
> BR,
> Albert


