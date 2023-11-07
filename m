Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8A7E3918
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JJL-0005XY-Sw; Tue, 07 Nov 2023 05:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0JJE-0005UH-Rs
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:27:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0JJC-00061P-OT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMgu1n6wU8I3H7kuJhkfIx98ul3QKm4sC8BFiFUpGgs=;
 b=iDk6LKbhmHd28MiJbOld89tKvFlGKmRpTCCpaqE20bKvxdem65hPQyq7mPV3TRsSBaeZwV
 EJo0AFl/FdWLT93FdcAVOCRQuxP2AgzKMPuj/Toz1VmuF7v7DGKwNgzxpzAEj4i4CH0709
 BVV9EPnToOKna4k99wZlMXBxDefixaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-W8_YcLkUNICyXH6YRrkJWw-1; Tue, 07 Nov 2023 05:27:40 -0500
X-MC-Unique: W8_YcLkUNICyXH6YRrkJWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F580811E7E;
 Tue,  7 Nov 2023 10:27:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 980182166B26;
 Tue,  7 Nov 2023 10:27:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Add some more vmware-related files to the
 corresponding section
Date: Tue,  7 Nov 2023 11:27:38 +0100
Message-ID: <20231107102738.14797-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

These files are obviously related to Vmware emulation, so let's list
them in the corresponding section in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 215d97e58f..becf1c4089 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2362,8 +2362,13 @@ F: hw/net/net_tx_pkt*
 Vmware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
+F: docs/specs/vmw_pvscsi-spec.txt
+F: hw/display/vmware_vga.c
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
+F: pc-bios/efi-vmxnet3.rom
+F: pc-bios/vgabios-vmware.bin
+F: roms/config.vga-vmware
 F: tests/qtest/vmxnet3-test.c
 F: docs/specs/vwm_pvscsi-spec.rst
 
-- 
2.41.0


