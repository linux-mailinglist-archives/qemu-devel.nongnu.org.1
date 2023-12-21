Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C081B82E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 14:41:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJHt-00045K-M0; Thu, 21 Dec 2023 08:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGJHq-00044l-VL
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGJHp-00069c-EN
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703166028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S67+wgho3C2w6cnZrAoM2joz3JZGArUW/qNfK1nmUVw=;
 b=KayMMSY3MpALYPPOAZhCT8G2IO4ITAK2MG4OzLnuZMqH/0YK+v9wS6xdHJzUNMWKkTjLbH
 h+T3G+szCqoWEodIR50chMtm6BIWX+R6RS9g5OCbckLlDJH4dG7Ts8Ev/l9/7qzHnRiT9s
 oWYk4zN/Kyw6jpSQ/Pw+bKQGGOspJJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-KmwzjT6AP_GwbticxlaD2Q-1; Thu, 21 Dec 2023 08:40:25 -0500
X-MC-Unique: KmwzjT6AP_GwbticxlaD2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9303101A52A;
 Thu, 21 Dec 2023 13:40:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5335B492BC7;
 Thu, 21 Dec 2023 13:40:21 +0000 (UTC)
Date: Thu, 21 Dec 2023 14:40:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <ZYRAQ3izSH-QWuGp@redhat.com>
References: <20231220134755.814917-1-stefanha@redhat.com>
 <20231220134755.814917-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220134755.814917-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 20.12.2023 um 14:47 hat Stefan Hajnoczi geschrieben:
> Add the iothread-vq-mapping parameter to assign virtqueues to IOThreads.
> Store the vq:AioContext mapping in the new struct
> VirtIOBlockDataPlane->vq_aio_context[] field and refactor the code to
> use the per-vq AioContext instead of the BlockDriverState's AioContext.
> 
> Reimplement --device virtio-blk-pci,iothread= and non-IOThread mode by
> assigning all virtqueues to the IOThread and main loop's AioContext in
> vq_aio_context[], respectively.
> 
> The comment in struct VirtIOBlockDataPlane about EventNotifiers is
> stale. Remove it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> @@ -177,19 +238,13 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
>  
>      trace_virtio_blk_data_plane_start(s);
>  
> -    r = blk_set_aio_context(s->conf->conf.blk, s->ctx, &local_err);
> +    r = blk_set_aio_context(s->conf->conf.blk, s->vq_aio_context[0],
> +                            &local_err);
>      if (r < 0) {
>          error_report_err(local_err);
>          goto fail_aio_context;
>      }

This doesn't really have to be an error any more, we'll just submit I/O
from any thread we want no matter what the home AioContext of the
BlockBackend is.

So the only effect the blk_set_aio_context() has is that other users of
the image try to submit their requests from the same iothread as the
first virtqueue in the hope that this performs a bit better (maybe less
lock contention or whatever the idea was?)

> -    /* Kick right away to begin processing requests already in vring */
> -    for (i = 0; i < nvqs; i++) {
> -        VirtQueue *vq = virtio_get_queue(s->vdev, i);
> -
> -        event_notifier_set(virtio_queue_get_host_notifier(vq));
> -    }
> -
>      /*
>       * These fields must be visible to the IOThread when it processes the
>       * virtqueue, otherwise it will think dataplane has not started yet.
> @@ -206,8 +261,12 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
>      if (!blk_in_drain(s->conf->conf.blk)) {
>          for (i = 0; i < nvqs; i++) {
>              VirtQueue *vq = virtio_get_queue(s->vdev, i);
> +            AioContext *ctx = s->vq_aio_context[i];
>  
> -            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> +            /* Kick right away to begin processing requests already in vring */
> +            event_notifier_set(virtio_queue_get_host_notifier(vq));

The old code did this also for blk_in_drain() == true. Why don't we need
it there any more? Should the 'if' move inside the loop just around
attaching the notifier?

> +            virtio_queue_aio_attach_host_notifier(vq, ctx);
>          }
>      }
>      return 0;

Kevin


