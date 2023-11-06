Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BE7E2594
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:33:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzziV-0005aE-EB; Mon, 06 Nov 2023 08:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziP-0005Zf-4R
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziM-0003fM-K4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bwXoB6XGjoify4VlIQJqF1P7oTKODjmcgNCkWhvzbnQ=;
 b=ColQxJOdx7/YVDMxrnnN7ak1g+Ie6mH7FzVkYkYDb9yY3EIz0uR8TAjO5qRW4vZ/wuWFbV
 a/M8f4f8j6r3LzndG8gawwJPWIPR6ZELWi1eDsSq/+EPV7UakJDoDwjYbeFiknR/A8m5f3
 W/eMtZnwrA9S3+5dxDt6NI+ncFSbReE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-aQDHBnfpPAqBL9GHCiQWWQ-1; Mon,
 06 Nov 2023 08:32:23 -0500
X-MC-Unique: aQDHBnfpPAqBL9GHCiQWWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 255C6380450C
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 13:32:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 180B9502B;
 Mon,  6 Nov 2023 13:32:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/10] Gpu patches
Date: Mon,  6 Nov 2023 17:32:09 +0400
Message-ID: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/gpu-pull-request

for you to fetch changes up to 10b9ddbc83b94986cbdf989e26fb7269fb2e9f72:

  Revert "virtio-gpu: block migration of VMs with blob=true" (2023-11-06 17:30:01 +0400)

----------------------------------------------------------------
GPU pull request

Includes:
- [PATCH] virtio-gpu-rutabaga: Add empty interface to fix arm64 crash
- [PATCH v2 0/4] Misc ati-vga patches
- [PATCH v2 0/5] virtio-gpu: add blob migration support

----------------------------------------------------------------

BALATON Zoltan (4):
  ati-vga: Fix aperture sizes
  ati-vga: Support unaligned access to GPIO DDC registers
  ati-vga: Add 30 bit palette access register
  ati-vga: Implement fallback for pixman routines

Cong Liu (1):
  virtio-gpu-rutabaga: Add empty interface to fix arm64 crash

Marc-André Lureau (5):
  virtio-gpu: block migration of VMs with blob=true
  virtio-gpu: factor out restore mapping
  virtio-gpu: move scanout restoration to post_load
  virtio-gpu: add virtio-gpu/blob vmstate subsection
  Revert "virtio-gpu: block migration of VMs with blob=true"

 hw/display/ati_int.h                 |   2 +
 hw/display/ati_regs.h                |   2 +
 hw/display/ati.c                     |  61 +++++++---
 hw/display/ati_2d.c                  |  75 ++++++++----
 hw/display/ati_dbg.c                 |   2 +
 hw/display/virtio-gpu-pci-rutabaga.c |   1 +
 hw/display/virtio-gpu.c              | 174 ++++++++++++++++++++++-----
 7 files changed, 250 insertions(+), 67 deletions(-)

-- 
2.41.0


