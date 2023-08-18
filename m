Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737C780EF6
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:19:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1Eg-0001dN-UP; Fri, 18 Aug 2023 11:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qX1Eb-0001cT-Ti
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qX1EZ-0000qZ-Dw
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692371874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YU3tvQdVlHQciX3Nq3RK032672rmTsk7259azx2Vokk=;
 b=blj3S6lg4f8E1rf2n2N2lZSiiCXU2t0N+YseDrGxutCejRDUQh8jESFwDfmJNWAwwD3ASu
 jnH664xgKgeEY19RttuJ+0ON16s7I8qC2e5s3dNnDkxyy5APWBTaAJgKWWMe6RLi2sPLut
 mLqSMg4Wa3duqJyPVaCfzKsDLqO0L8s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-5-27UoemOiOs2Fduap4kdQ-1; Fri, 18 Aug 2023 11:17:51 -0400
X-MC-Unique: 5-27UoemOiOs2Fduap4kdQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E303C0FCB2;
 Fri, 18 Aug 2023 15:17:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B651F492C13;
 Fri, 18 Aug 2023 15:17:48 +0000 (UTC)
Date: Fri, 18 Aug 2023 10:17:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, xen-devel@lists.xenproject.org, 
 Anthony Perard <anthony.perard@citrix.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Julia Suvorova <jusual@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH v2 3/4] virtio: use defer_call() in virtio_irqfd_notify()
Message-ID: <jvjrraxyqppcijrfrrkjycmel6yynie2ovymz6rukgrmppjbnf@l77gohyzccin>
References: <20230817155847.3605115-1-stefanha@redhat.com>
 <20230817155847.3605115-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817155847.3605115-4-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Thu, Aug 17, 2023 at 11:58:46AM -0400, Stefan Hajnoczi wrote:
> virtio-blk and virtio-scsi invoke virtio_irqfd_notify() to send Used
> Buffer Notifications from an IOThread. This involves an eventfd
> write(2) syscall. Calling this repeatedly when completing multiple I/O
> requests in a row is wasteful.
> 
> Use the defer_call() API to batch together virtio_irqfd_notify() calls
> made during thread pool (aio=threads), Linux AIO (aio=native), and
> io_uring (aio=io_uring) completion processing.
> 
> Behavior is unchanged for emulated devices that do not use
> defer_call_begin()/defer_call_end() since defer_call() immediately
> invokes the callback when called outside a
> defer_call_begin()/defer_call_end() region.
> 
> fio rw=randread bs=4k iodepth=64 numjobs=8 IOPS increases by ~9% with a
> single IOThread and 8 vCPUs. iodepth=1 decreases by ~1% but this could
> be noise. Detailed performance data and configuration specifics are
> available here:
> https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd
> 
> This duplicates the BH that virtio-blk uses for batching. The next
> commit will remove it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/io_uring.c   |  6 ++++++
>  block/linux-aio.c  |  4 ++++
>  hw/virtio/virtio.c | 11 ++++++++++-
>  util/thread-pool.c |  5 +++++
>  4 files changed, 25 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


