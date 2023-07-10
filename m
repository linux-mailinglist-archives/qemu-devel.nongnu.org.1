Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7774D536
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:20:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoL-0000nC-Dt; Mon, 10 Jul 2023 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo7-0000jV-M7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo4-0003NP-LL
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBnOTau0sM/rczS+SwUa7v/+BiMLL54U3Z+8Vn7Mbxk=;
 b=AWdvWZ4Qqa2D57xn4l49tkMBdzceyALEI6iJ2I2p91kQnv4Pq2xKxA76wV+cNFG0LSji/o
 PkKonOPfCg6o29Z+P75amsT6gDhOQf3lmk1RklHZYZcfE9FFmMqUftl1lm7g6OEzFXBNBL
 IWVCKk2DRkBO7kHCqLvGu2N6BOsXyDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-HBVhL4DhM-KGgmhoRUTTeA-1; Mon, 10 Jul 2023 08:15:50 -0400
X-MC-Unique: HBVhL4DhM-KGgmhoRUTTeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6EF08FD7A0;
 Mon, 10 Jul 2023 12:15:48 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEAE2F66BB;
 Mon, 10 Jul 2023 12:15:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 02/21] linux-user: elfload: Add more initial s390x PSW bits
Date: Mon, 10 Jul 2023 14:15:24 +0200
Message-Id: <20230710121543.197250-3-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Make the PSW look more similar to the real s390x userspace PSW.
Except for being there, the newly added bits should not affect the
userspace code execution.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230704081506.276055-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/elfload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9a2ec568b0..d3d1352c4e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1635,7 +1635,9 @@ const char *elf_hwcap_str(uint32_t bit)
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->psw.addr = infop->entry;
-    regs->psw.mask = PSW_MASK_64 | PSW_MASK_32;
+    regs->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | \
+                     PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 | \
+                     PSW_MASK_32;
     regs->gprs[15] = infop->start_stack;
 }
 
-- 
2.39.3


