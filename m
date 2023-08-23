Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD25785711
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJT-0001XY-LB; Wed, 23 Aug 2023 07:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJJ-0001UW-Vl
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJF-0001S7-IC
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wnhh4a3kG3JL9XAwRzomI8TrtI7tvty0j3sbL7SKKWo=;
 b=DnchnfF/7P6P/NNSBo9LA99KJFvVjeYdNEZRythGB7zQDD+mROkDZWuTl7gS7KzRdB6p8W
 BsyDkxxthoDrYWbLjIaXLCbaTfG+CI9QUn1GDKbaDNMDNCb6MJJHVJc/wmN7vHGX90I3Cl
 0creS6Hhq5AJLoqi7o7HmNsS1GhE/pc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1--9Dk0TaJM2SJdM3z023C6Q-1; Wed, 23 Aug 2023 07:45:56 -0400
X-MC-Unique: -9Dk0TaJM2SJdM3z023C6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66D68D40A4;
 Wed, 23 Aug 2023 11:45:55 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2861C15BB8;
 Wed, 23 Aug 2023 11:45:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 06/12] target/s390x: Use a 16-bit immediate in VREP
Date: Wed, 23 Aug 2023 13:45:38 +0200
Message-Id: <20230823114544.216520-7-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Unlike most other instructions that contain an immediate element index,
VREP's one is 16-bit, and not 4-bit. The code uses only 8 bits, so
using, e.g., 0x101 does not lead to a specification exception.

Fix by checking all 16 bits.

Cc: qemu-stable@nongnu.org
Fixes: 28d08731b1d8 ("s390x/tcg: Implement VECTOR REPLICATE")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230807163459.849766-1-iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate_vx.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index b5d07d5ec5..ec94d39df0 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -57,7 +57,7 @@
 #define FPF_LONG        3
 #define FPF_EXT         4
 
-static inline bool valid_vec_element(uint8_t enr, MemOp es)
+static inline bool valid_vec_element(uint16_t enr, MemOp es)
 {
     return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
 }
@@ -964,7 +964,7 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
 {
-    const uint8_t enr = get_field(s, i2);
+    const uint16_t enr = get_field(s, i2);
     const uint8_t es = get_field(s, m4);
 
     if (es > ES_64 || !valid_vec_element(enr, es)) {
-- 
2.39.3


