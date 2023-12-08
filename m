Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08568809E31
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:34:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWIJ-000365-Jw; Fri, 08 Dec 2023 03:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rBWII-00035o-FB
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rBWIG-0001ff-FJ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702024386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dd87OZPSN7U6nOuTgQuwJapuCQxskmXypN9Yc8U+OR4=;
 b=A65Nu0xrSynXRy0bldQa1ONwH23CUMfJvnctz9XroLFVy6FGdnGfiVOHVUazXuHXZh+iyo
 yKTlLqvY/q1Q7/0E/ux5/8ksU8gyp1RA6s7DykWNjvFiPFYlDRk2upVBdjcQvGvTZUKSeb
 rRkymu7d+t1T9WuTS3nIjNrBoQ9srvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-hsEjIwdcMoCOsK9tpliFcw-1; Fri, 08 Dec 2023 03:33:03 -0500
X-MC-Unique: hsEjIwdcMoCOsK9tpliFcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD60185CE46;
 Fri,  8 Dec 2023 08:33:02 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 729E9C0164E;
 Fri,  8 Dec 2023 08:33:00 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:32:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 29/32] virtio-blk: implement BlockDevOps->drained_begin()
Message-ID: <ZXLUuoOawqQpyodD@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
 <20230530163239.576632-30-kwolf@redhat.com>
 <ee6374dc-c644-449f-b5d1-788695e1a83e@proxmox.com>
 <c3e115ff-c143-4d1b-901c-6b386d012eac@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e115ff-c143-4d1b-901c-6b386d012eac@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 07.12.2023 um 16:22 hat Fiona Ebner geschrieben:
> Am 03.11.23 um 14:12 schrieb Fiona Ebner:
> > Hi,
> > 
> > I ran into a strange issue where guest IO would get completely stuck
> > during certain block jobs a while ago and finally managed to find a
> > small reproducer [0]. I'm using a VM with virtio-blk-pci (or
> > virtio-scsi-pci) with an iothread and running
> > 
> > fio --name=file --size=100M --direct=1 --rw=randwrite --bs=4k
> > --ioengine=psync --numjobs=5 --runtime=1200 --time_based
> > 
> > in the guest. Then I'm issuing the QMP command with the reproducer in a
> > loop. Usually, the guest IO will get stuck after about 1-3 minutes,
> > sometimes fio can manage to continue with a lower speed for a while (but
> > trying to Ctrl+C it or doing other IO in the guest will already be
> > broken), which I guess could be a hint that it's an issue with notifiers?
> > 
> > Bisecting (to declare a commit good, I waited 10 minutes) led me to this
> > patch, i.e. commit 1665d9326f ("virtio-blk: implement
> > BlockDevOps->drained_begin()") and for SCSI, I verified that the issue
> > similarly starts happening after 766aa2de0f ("virtio-scsi: implement
> > BlockDevOps->drained_begin()").
> > 
> > Both issues are still present on current master (i.e. 1c98a821a2
> > ("tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device"))
> > 
> > Happy to provide more information and hints about how to debug the issue
> > further.
> > 
> 
> I think I was finally able to get to the bottom of this and have a
> plausible-sounding pet theory now. It involves the VirtIO notifier
> optimization during poll mode.
> 
> Let's step through some debug prints I added. First number is always the
> thread ID (I'm sorry that I used warn_report rather than proper tracing):
> 
> > 247050 nodefd 29 poll_set_started 1
> 
> The iothread starts poll mode for the node with fd 29 which is the
> virtio host notifier.
> 
> > 247050 0x55e515185270 poll begin for vq
> > 247050 0x55e515185270 setting notification for vq 0
> 
> virtio_queue_set_notification is called to disable notification.
> 
> > 247050 nodefd 29 poll_set_started 1 done
> > 247050 0x55e515185270 handle vq suppress_notifications 0 num_reqs 1
> > 247050 0x55e515185270 handle vq suppress_notifications 0 num_reqs 4
> 
> virtio-blk handling some requests, note that suppress_notifications is 0
> because we are in poll mode.
> 
> > 247048 nodefd 29 addr 0x55e51496ed70 marking as deleted
> 
> Main thread marks the node for deletion when beginning drain, i.e.
> detaches the host notifier.
> 
> > 247048 nodefd 29 addr 0x55e513cdcd20 is_new 1 adding node
> 
> Main thread adds a new node when ending drain, i.e. attaches the host
> notifier.
> 
> > 247050 nodefd 29 addr 0x55e51496ed70 remove deleted handler
> 
> The iothread removes the handler marked for removal. In particular from
> the node_poll list: QLIST_SAFE_REMOVE(node, node_poll);
> 
> > 247050 disabling poll mode before fdmon_ops->wait
> 
> This is just before the call to
> poll_set_started(ctx, &ready_list, false)
> 
> Whoops!! Nobody ends poll mode for the node with fd 29, because the old
> node was deleted from the node_poll list already and new node is not
> part of it, i.e. nobody has started poll mode for the new node.
> 
> > 247050 0x55e515185270 handle vq suppress_notifications 0 num_reqs 0
> 
> fdmon_ops->wait() returns one last time (not sure why) but no actual
> requests.
> 
> > 247050 disabling poll mode before fdmon_ops->wait
> 
> After this, the fdmon_ops->wait() (it's fdmon_poll_wait in my case) will
> just wait forever (or until triggering QMP 'stop' and 'cont' which
> restarts the dataplane).
> 
> 
> A minimal workaround seems to be either calling
> event_notifier_set(virtio_queue_get_host_notifier(vq));
> or
> virtio_queue_set_notification(vq, true);
> in drainded_end (for both VirtIO SCSI/block).
> 
> But is this an actual issue with the AIO interface/implementation? Or
> should it rather be considered a bug in the VirtIO SCSI/block drain
> implementation, because of the notification optimization?

I'm not involved in it myself, but the kind of theme reminds me of this
downstream bug that Hanna analysed recently:

https://issues.redhat.com/browse/RHEL-3934

Does it look like the same root cause to you?

Kevin


