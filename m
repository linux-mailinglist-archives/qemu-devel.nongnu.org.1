Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C1F7A4E68
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGvF-0006Cn-Hq; Mon, 18 Sep 2023 12:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiGv0-00068P-76
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiGux-0006su-3V
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695053770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KpYYLThl59dNc7j0moQTB36qPW0YkRPhpSo5IdOK4Eg=;
 b=gIxy8Nf78uZwX4lV+hEx5MZULB64iTGoaeD+e7cYJhbVeaV+3bvd2MIggypgkWirlElTz7
 O4IZZEf5rTyW7SfBQVWAEyaQvtLCkZEZmA4I2zxC6EpUUCsI9TCEKPld01NH6WmFHzFzuy
 ZqKXc11NTJAc8IN8gJ+HLPq1KprPTfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-YVr6b7A7No-7LZbBDvr6zA-1; Mon, 18 Sep 2023 12:16:06 -0400
X-MC-Unique: YVr6b7A7No-7LZbBDvr6zA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E0EF85A5A8;
 Mon, 18 Sep 2023 16:16:06 +0000 (UTC)
Received: from localhost (unknown [10.39.195.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED57F140273C;
 Mon, 18 Sep 2023 16:16:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 <qemu-block@nongnu.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 0/2] virtio-blk: add iothread-vq-mapping parameter
Date: Mon, 18 Sep 2023 12:16:02 -0400
Message-ID: <20230918161604.1400051-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

virtio-blk and virtio-scsi devices need a way to specify the mapping between
IOThreads and virtqueues. At the moment all virtqueues are assigned to a single
IOThread or the main loop. This single thread can be a CPU bottleneck, so it is
necessary to allow finer-grained assignment to spread the load. With this
series applied, "pidstat -t 1" shows that guests with -smp 2 or higher are able
to exploit multiple IOThreads.

This series introduces command-line syntax for the new iothread-vq-mapping
property is as follows:

  --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]},...'

IOThreads are specified by name and virtqueues are specified by 0-based
index.

It will be common to simply assign virtqueues round-robin across a set
of IOThreads. A convenient syntax that does not require specifying
individual virtqueue indices is available:

  --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]},...'

There is no way to reassign virtqueues at runtime and I expect that to be a
very rare requirement.

Note that JSON --device syntax is required for the iothread-vq-mapping
parameter because it's non-scalar.

Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] block-backend: process I/O in the current AioContext")

Stefan Hajnoczi (2):
  qdev: add IOThreadVirtQueueMappingList property type
  virtio-blk: add iothread-vq-mapping parameter

 qapi/virtio.json                    |  30 +++++
 hw/block/dataplane/virtio-blk.h     |   3 +
 include/hw/qdev-properties-system.h |   4 +
 include/hw/virtio/virtio-blk.h      |   2 +
 hw/block/dataplane/virtio-blk.c     | 163 +++++++++++++++++++++-------
 hw/block/virtio-blk.c               |  92 ++++++++++++++--
 hw/core/qdev-properties-system.c    |  47 ++++++++
 7 files changed, 287 insertions(+), 54 deletions(-)

-- 
2.41.0


