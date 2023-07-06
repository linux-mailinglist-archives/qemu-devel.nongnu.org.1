Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344367496E3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJr7-0002Ev-2m; Thu, 06 Jul 2023 03:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJqw-0002DP-OZ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJqv-0007LL-BU
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688630196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h16HNxiSR03X8xgIxWPQqWGSdAkvrqiUaa/O9QkZOOY=;
 b=VIRXx+lduY1q2+00QmoE8jzEnEpH4zfMK3C5ObBFF8EB03bRbgKAO1f6PXiafvb17Fp5Qz
 McDx85A3yFsusD1O5IUBpxhzafdRx/gpBaZwTNZvd8/G76UlGUhDQbMq9Ztg3unj9nA8mX
 dZDV5KaruacLgi5CFEI7t4hOTx+uNao=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-To62wPQyOzWfmr-foSyw4w-1; Thu, 06 Jul 2023 03:56:33 -0400
X-MC-Unique: To62wPQyOzWfmr-foSyw4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E024A3C0F668;
 Thu,  6 Jul 2023 07:56:32 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.193.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28BF518EB4;
 Thu,  6 Jul 2023 07:56:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 0/4] virtio-mem: Support "x-ignore-shared" migration
Date: Thu,  6 Jul 2023 09:56:05 +0200
Message-ID: <20230706075612.67404-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If there is no further feedback, I'll queue this myself shortly.

Stumbling over "x-ignore-shared" migration support for virtio-mem on
my todo list, I remember talking to Dave G. a while ago about how
ram_block_discard_range() in MAP_PIRVATE file mappings is possibly
harmful when the file is used somewhere else -- for example, with VM
templating in multiple VMs.

This series adds a warning to ram_block_discard_range() in that problematic
case and adds "x-ignore-shared" migration support for virtio-mem, which
is pretty straight-forward. The last patch also documents how VM templating
interacts with virtio-mem.

v1 -> v2:
- Pick up tags
- "virtio-mem: Support "x-ignore-shared" migration"
 -> Fix spelling mistake

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Peng Tao <tao.peng@linux.alibaba.com>
Cc: Mario Casquero <mcasquer@redhat.com>

David Hildenbrand (4):
  softmmu/physmem: Warn with ram_block_discard_range() on MAP_PRIVATE
    file mapping
  virtio-mem: Skip most of virtio_mem_unplug_all() without plugged
    memory
  migration/ram: Expose ramblock_is_ignored() as
    migrate_ram_is_ignored()
  virtio-mem: Support "x-ignore-shared" migration

 hw/virtio/virtio-mem.c   | 67 ++++++++++++++++++++++++++++------------
 include/migration/misc.h |  1 +
 migration/postcopy-ram.c |  2 +-
 migration/ram.c          | 14 ++++-----
 migration/ram.h          |  3 +-
 softmmu/physmem.c        | 18 +++++++++++
 6 files changed, 76 insertions(+), 29 deletions(-)

-- 
2.41.0


