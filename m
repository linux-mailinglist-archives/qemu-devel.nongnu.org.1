Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D587DD13E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:10:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrJR-0005N4-QN; Tue, 31 Oct 2023 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxrJQ-0005Me-4C
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxrJO-0000YA-3H
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698768589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NmtecgNkHEkOuim3O1U2WKCrXJxkP4+J705ylKkl8Uc=;
 b=cJHfXEGmkbdElrTEUvhu+ZX7Q7OGFBxourJKQx3PpcPpYBVdyS1ufOMrj1J/jaWqEw/dS/
 PWmh5LtqY22ajqCic/RXjO2z99X79xqpfZfPCJ8U8QujMMgs/R1Dwtre1vZItS5RL3pwlC
 x/DfL/heIeLYk/upr2K6heyY2zYUiL0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-K2e19MGeOEeTSKsd9E5sqA-1; Tue,
 31 Oct 2023 12:09:46 -0400
X-MC-Unique: K2e19MGeOEeTSKsd9E5sqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BAC3C1CC3E;
 Tue, 31 Oct 2023 16:09:29 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0F5E492BE0;
 Tue, 31 Oct 2023 16:09:26 +0000 (UTC)
Date: Tue, 31 Oct 2023 17:09:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio-blk: use blk_io_plug_call() instead of
 notification BH
Message-ID: <ZUEmtRCe0uIQmVRP@redhat.com>
References: <20230913200045.1024233-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913200045.1024233-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Am 13.09.2023 um 22:00 hat Stefan Hajnoczi geschrieben:
> v3:
> - Add comment pointing to API documentation in .c file [Philippe]
> - Add virtio_notify_irqfd_deferred_fn trace event [Ilya]
> - Remove outdated #include [Ilya]
> v2:
> - Rename blk_io_plug() to defer_call() and move it to util/ so the net
>   subsystem can use it [Ilya]
> - Add defer_call_begin()/end() to thread_pool_completion_bh() to match Linux
>   AIO and io_uring completion batching
> 
> Replace the seldom-used virtio-blk notification BH mechanism with
> blk_io_plug(). This is part of an effort to enable the multi-queue block layer
> in virtio-blk. The notification BH was not multi-queue friendly.
> 
> The blk_io_plug() mechanism improves fio rw=randread bs=4k iodepth=64 numjobs=8
> IOPS by ~9% with a single IOThread and 8 vCPUs (this is not even a multi-queue
> block layer configuration) compared to no completion batching. iodepth=1
> decreases by ~1% but this could be noise. Benchmark details are available here:
> https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd

Thanks, applied to the block branch.

Kevin


