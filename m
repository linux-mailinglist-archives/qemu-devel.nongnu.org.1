Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239377CC59
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 14:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVsqP-0000KF-Jp; Tue, 15 Aug 2023 08:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVsqN-0000HP-IB
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVsqL-00053f-9J
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692101292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vJ6oZfoGdjd/8MI8L03eqn4G39VqBn+QC+fNpvcZ1pI=;
 b=DGmxcwa3t45NzQwmmmGRYf+dgLAglpD9kJzXsXCRqACFpVYC8zTBLCNd2xQpfbIXl1nLYi
 g+rVxd1RGxrW+UOZwq+YrgIVy6+yJ8G6uVsCMVJaQEKf1TleU41vAdFXMMGYgh3K0XyTTB
 b54Z68knUDIoCkxMfHu9fqdKMcI3CX0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-o4fnwk_mMJ2TjZAJXgsVMg-1; Tue, 15 Aug 2023 08:08:08 -0400
X-MC-Unique: o4fnwk_mMJ2TjZAJXgsVMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2373B3828891;
 Tue, 15 Aug 2023 12:08:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98C3B492C13;
 Tue, 15 Aug 2023 12:08:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/2] virtio-blk: use blk_io_plug_call() instead of
 notification BH
Date: Tue, 15 Aug 2023 08:08:03 -0400
Message-ID: <20230815120805.3235166-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the seldom-used virtio-blk notification BH mechanism with
blk_io_plug(). This is part of an effort to enable the multi-queue block layer
in virtio-blk. The notification BH was not multi-queue friendly.

The blk_io_plug() mechanism improves fio rw=randread bs=4k iodepth=64 numjobs=8
IOPS by ~9% with a single IOThread and 8 vCPUs (this is not even a multi-queue
block layer configuration) compared to no completion batching. iodepth=1
decreases by ~1% but this could be noise. Benchmark details are available here:
https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd

Stefan Hajnoczi (2):
  virtio: use blk_io_plug_call() in virtio_irqfd_notify()
  virtio-blk: remove batch notification BH

 block/io_uring.c                |  6 +++++
 block/linux-aio.c               |  4 +++
 hw/block/dataplane/virtio-blk.c | 48 +--------------------------------
 hw/virtio/virtio.c              | 10 ++++++-
 4 files changed, 20 insertions(+), 48 deletions(-)

-- 
2.41.0


