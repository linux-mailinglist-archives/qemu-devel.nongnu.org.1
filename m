Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D870312E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZr2-00026R-4y; Mon, 15 May 2023 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyZqz-00025L-Mo
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyZqy-0006dQ-Bf
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684163471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EANE680KCQPcbbJzoMDcabCOGmn3aOXht0lVvwmHAQU=;
 b=P28y8KPej5VwM19KXf7FSRGwHAramXYY208bnjY2+xXgXNJlttAEJLQNMyaYa0N4Ze7pV2
 tx1MUJCKtNK54Hg6LbAz2DyOtlp5KyAWPq7ZTSz0uoR66dhjw8arWUKgGoS/PtwpaN/rgC
 2WDyVZkfGXuZIPb0UERRq+0fbOI22nA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-0Gdtwye0PEyNjdAKD8Wjwg-1; Mon, 15 May 2023 11:11:06 -0400
X-MC-Unique: 0Gdtwye0PEyNjdAKD8Wjwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C97280B2BB;
 Mon, 15 May 2023 15:11:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77EC4492B00;
 Mon, 15 May 2023 15:11:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8ADE021E6806; Mon, 15 May 2023 17:11:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub@jermar.eu>,
 qemu-stable@nongnu.org
Subject: [PATCH] Revert "hw/sparc64/niagara: Use blk_name() instead of
 open-coding it"
Date: Mon, 15 May 2023 17:11:04 +0200
Message-Id: <20230515151104.1350155-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This reverts commit 1881f336a33a8a99cb17ab1c57ed953682e8e107.

This commit breaks "-drive if=pflash,readonly=on,file=image.iso".  It
claims to merely replace an open-coded version of blk_name() by a
call, but that's not the case.  Sorry for the inconvenience!

Reported-by: Jakub Jermář <jakub@jermar.eu>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/sparc64/niagara.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 6725cc61fd..ab3c4ec346 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/block_int-common.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "hw/boards.h"
@@ -143,9 +144,10 @@ static void niagara_init(MachineState *machine)
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram);
             dinfo->is_default = 1;
-            rom_add_file_fixed(blk_name(blk), NIAGARA_VDISK_BASE, -1);
+            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, -1);
         } else {
-            error_report("could not load ram disk '%s'", blk_name(blk));
+            error_report("could not load ram disk '%s'",
+                         blk_bs(blk)->filename);
             exit(1);
         }
     }
-- 
2.39.2


