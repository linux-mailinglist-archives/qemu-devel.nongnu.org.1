Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59884AEED
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 08:23:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFms-0002mV-2C; Tue, 06 Feb 2024 02:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFmq-0002lz-26
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:22:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFmo-0006j8-Gh
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707204149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XfaM0gs7jfuDeVMK1r5JqXKKWdX4wFvt5RSGS4N7tBs=;
 b=gOuaojZGTz7pLlnE0+VI0Q5VXg9jZeuP+wGdxZyMM7j3ua6zzJ+2p5ryklQZBARX1g1kL2
 DHCajCs/FirvU+hKQiGalRX1vi6j6YprSNIBDUoBeMIb068s/Qs5f7R3FhnMsDc4gmuGuZ
 xJrliDq41Zl5w8cJSYiMOQHoXG5jfzk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-wgjBjv9rNJqk0aJ7mtecNA-1; Tue, 06 Feb 2024 02:22:27 -0500
X-MC-Unique: wgjBjv9rNJqk0aJ7mtecNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849E884ACA0;
 Tue,  6 Feb 2024 07:22:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F92C1121312;
 Tue,  6 Feb 2024 07:22:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL v3 0/3] Host Memory Backends and Memory devices queue 2024-02-06
Date: Tue,  6 Feb 2024 08:22:22 +0100
Message-ID: <20240206072225.21187-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2024-02-06-v3

for you to fetch changes up to 04accf43df83aa10f06f7dbda3ecf0db97f0c5a6:

  oslib-posix: initialize backend memory objects in parallel (2024-02-06 08:15:22 +0100)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Reintroduce memory region size checks for memory devices; the removal
  lead to some undesired side effects
- Preallocate memory of memory backends in selected configurations
  asynchronously (so we preallocate concurrently), to speed up QEMU
  startup time.

----------------------------------------------------------------
David Hildenbrand (2):
      hv-balloon: use get_min_alignment() to express 32 GiB alignment
      memory-device: reintroduce memory region size check

Mark Kanda (1):
      oslib-posix: initialize backend memory objects in parallel

 backends/hostmem.c     |   7 ++-
 hw/hyperv/hv-balloon.c |  37 +++++++-----
 hw/mem/memory-device.c |  14 +++++
 hw/virtio/virtio-mem.c |   4 +-
 include/hw/qdev-core.h |   5 ++
 include/qemu/osdep.h   |  18 +++++-
 system/vl.c            |   9 +++
 util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
 util/oslib-win32.c     |   8 ++-
 9 files changed, 180 insertions(+), 53 deletions(-)

-- 
2.43.0


