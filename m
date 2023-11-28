Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4267FBCE1
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7zEE-0006Bj-II; Tue, 28 Nov 2023 09:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1r7zEB-0006BM-BR
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1r7zE5-0004wt-SY
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701182289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zWCvIJbEv8SvBBaxc17eawBFrr9WK2Y6BLH+VdIVMDk=;
 b=blFUocNUSTZXgAhKf6b2y6BdSmGwih2drDerUtl0EyJy3HrERQMwXIgSS7SLTCYKZln7m6
 XY0pYVGIjDlN4hhXo7BKPQwOVaMTRf8mZ4Ze5WhAgAxi9DXDdpxpBRpQCDhjqLtvblkHEe
 lzwd9EbwYc8JTbP88zQ4uBh6Sz9ByFM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-iEirrLCpP_a5KyBO1fQitg-1; Tue, 28 Nov 2023 09:37:02 -0500
X-MC-Unique: iEirrLCpP_a5KyBO1fQitg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB7218A7A08
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 14:37:01 +0000 (UTC)
Received: from worklaptop.redhat.com (unknown [10.22.32.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80295492BFA;
 Tue, 28 Nov 2023 14:37:01 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Cole Robinson <crobinso@redhat.com>
Subject: [PATCH] pc-bios/optionrom: Fix pvh.img ld build failure on fedora
 rawhide
Date: Tue, 28 Nov 2023 09:36:47 -0500
Message-ID: <20231128143647.847668-1-crobinso@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crobinso@redhat.com;
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

binutils 2.39 shows some warnings when building pvh.img

/usr/bin/ld: warning: pvh.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: pvh.img has a LOAD segment with RWX permissions

The latter of which is fatal on Fedora rawhide for some reason.

Add linker options to suppress the errors

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 pc-bios/optionrom/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index 30d07026c7..f54ed39b54 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -36,7 +36,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds -Wl,--no-warn-rwx-segments -Wl,--no-warn-execstack
 
 pvh.img: pvh.o pvh_main.o
 


