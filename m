Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90F79CEF2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg125-0007R8-FS; Tue, 12 Sep 2023 06:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qg123-0007Qo-E1
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qg120-00057d-UR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694516043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYyO7R6f+1P6cWmXipRFq71+IvlSYKMJwwRRjZWkQBU=;
 b=IHNkGAclbbbrtiWjqnF+qAGXga+NkEzWiIBwffXatdSAvcm7KT4VFpRvRkOi6LwNmBFMp8
 oAS2GO5soGM0OBmUGGT9Uiomq0cUgQ4qbrgx0tFnilc6YYNfBbrpE28DCvQ3PsjDTmLq65
 miL7WMurMWy63XEE38sApV/Rzsa8u5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-54Qm21mWMvqRiKZKzS4l8w-1; Tue, 12 Sep 2023 06:54:01 -0400
X-MC-Unique: 54Qm21mWMvqRiKZKzS4l8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6745E85570D
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:54:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 363AB2026D68;
 Tue, 12 Sep 2023 10:54:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ED72718007B7; Tue, 12 Sep 2023 12:53:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 1/3] seabios: update submodule to git snapshot
Date: Tue, 12 Sep 2023 12:53:57 +0200
Message-ID: <20230912105359.563101-2-kraxel@redhat.com>
In-Reply-To: <20230912105359.563101-1-kraxel@redhat.com>
References: <20230912105359.563101-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

git shortlog
------------

Gerd Hoffmann (7):
      disable array bounds warning
      better kvm detection
      detect physical address space size
      move 64bit pci window to end of address space
      be less conservative with the 64bit pci io window
      qemu: log reservations in fw_cfg e820 table
      check for e820 conflict

José Martínez (1):
      Fix high memory zone initialization in CSM mode

Lukas Stockner via SeaBIOS (1):
      virtio-blk: Fix integer overflow for large max IO sizes

Mark Cave-Ayland (3):
      esp-scsi: flush FIFO before sending SCSI command
      esp-scsi: check for INTR_BS/INTR_FC instead of STAT_TC for command completion
      esp-scsi: handle non-DMA SCSI commands with no data phase

Niklas Cassel via SeaBIOS (1):
      ahci: handle TFES irq correctly

Tony Titus via SeaBIOS (1):
      Increase BUILD_MAX_E820 to 128

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/seabios | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios b/roms/seabios
index ea1b7a073390..1e1da7a96300 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit ea1b7a0733906b8425d948ae94fba63c32b1d425
+Subproject commit 1e1da7a963007d03a4e0e9a9e0ff17990bb1608d
-- 
2.41.0


