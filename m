Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86784818AFE
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:16:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbpU-0006O0-U8; Tue, 19 Dec 2023 10:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFbpM-0006AE-9G
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFbpH-0002B0-Hi
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702998958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5xw7A1XKMUjdmB/9WndsfiguXhlbtnJE7+pJRM9nELs=;
 b=ewyXA1rHqDnQc7eW9eLVTn/xOMtxRostqDyxTMX6GSBpB/2YioJUD0VVpmIIFfyQdpKETp
 U/aRc+enc0WY27QTxWZHY5KVpKi+xw5pBCO4JQ/pZfw1a+gtbM9XCm9B52QPyF3cKanNtT
 TFTBmmAScJO7uP6Kxj4L8Q8AdhRkIJk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-SAUPi0xiNaGf4qdi3wST1w-1; Tue,
 19 Dec 2023 10:15:53 -0500
X-MC-Unique: SAUPi0xiNaGf4qdi3wST1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4481A29AA39A;
 Tue, 19 Dec 2023 15:15:53 +0000 (UTC)
Received: from localhost (unknown [10.39.194.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B93271C060AF;
 Tue, 19 Dec 2023 15:15:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 0/4] virtio-blk: add iothread-vq-mapping parameter
Date: Tue, 19 Dec 2023 10:15:46 -0500
Message-ID: <20231219151550.223303-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

v3:
- Rebased onto Kevin's block branch
- Add StringOutputVisitor "<omitted>" patch to fix "info qtree" crash
- Fix QAPI schema formatting [Markus]
- Eliminate unnecessary local variable in get_iothread_vq_mapping_list() [Markus]

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

Based-on: 81e69329d6a4018f4b37d15b6fc845fbe585a93b (https://repo.or.cz/qemu/kevin.git block)

Stefan Hajnoczi (4):
  qdev-properties: alias all object class properties
  string-output-visitor: show structs as "<omitted>"
  qdev: add IOThreadVirtQueueMappingList property type
  virtio-blk: add iothread-vq-mapping parameter

 qapi/virtio.json                     |  30 ++++++
 hw/block/dataplane/virtio-blk.h      |   3 +
 include/hw/qdev-properties-system.h  |   5 +
 include/hw/virtio/virtio-blk.h       |   2 +
 include/qapi/string-output-visitor.h |   6 +-
 hw/block/dataplane/virtio-blk.c      | 155 ++++++++++++++++++++-------
 hw/block/virtio-blk.c                |  92 +++++++++++++---
 hw/core/qdev-properties-system.c     |  46 ++++++++
 hw/core/qdev-properties.c            |  18 ++--
 qapi/string-output-visitor.c         |  16 +++
 10 files changed, 312 insertions(+), 61 deletions(-)

-- 
2.43.0


