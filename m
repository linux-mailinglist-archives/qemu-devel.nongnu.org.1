Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027F70486F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqdV-0002d6-EB; Tue, 16 May 2023 05:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyqdO-0002cU-DY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyqdM-0007E4-W1
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684227972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xhfpK7PHMoIgMNdnenMvwmAXC84sSLaszoOeE7+Jn88=;
 b=jOYgUdF2OhsoLS28HyNEEGlmWImihCzM0giI+hxt2QJoA6MuBZ8g4togJxogpFckgR5P+K
 oQBWshWikjBCjWjHzYtvQU44ilCImvp+2X4WvxSox0DQDq/qDkxsQzqcD36vqCfw7xVDXZ
 k+dEBRh2oxVQ/9LtaIveT1cb3j4SEmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-Wv3du_CUPZyWrytRi0BbZQ-1; Tue, 16 May 2023 05:06:09 -0400
X-MC-Unique: Wv3du_CUPZyWrytRi0BbZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68F3189174B;
 Tue, 16 May 2023 09:06:09 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC0CF1410F23;
 Tue, 16 May 2023 09:06:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Bulekov <alxndr@bu.edu>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Darren Kenny <darren.kenny@oracle.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] lsi53c895a: disable reentrancy detection for MMIO region, too
Date: Tue, 16 May 2023 11:05:56 +0200
Message-Id: <20230516090556.553813-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While trying to use a SCSI disk on the LSI controller with an
older version of Fedora (25), I'm getting:

 qemu: warning: Blocked re-entrant IO on MemoryRegion: lsi-mmio at addr: 0x34

and the SCSI controller is not usable. Seems like we have to
disable the reentrancy checker for the MMIO region, too, to
get this working again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/lsi53c895a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index db27872963..048436352b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2307,6 +2307,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
      * re-entrancy guard.
      */
     s->ram_io.disable_reentrancy_guard = true;
+    s->mmio_io.disable_reentrancy_guard = true;
 
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
     qdev_init_gpio_out(d, &s->ext_irq, 1);
-- 
2.31.1


