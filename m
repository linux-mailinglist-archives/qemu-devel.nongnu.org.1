Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7678571A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJM-0001W9-SG; Wed, 23 Aug 2023 07:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJH-0001Tm-Pg
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJC-0001Pf-Dy
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXnGa8WXrrK20Y0dTFhEeYD/7VY/YJAHG0l7e6CcfZ8=;
 b=EDFDP13ViFgMQuOg7BvSoQkfthDbOsm1EuScBolnImAR21REjqiw0NvU2Ucn7JRPqBCBiC
 0b7gH7MF+m+4bHfyYN6g0Mzq+/vyr6LHuf9YGm0u42RXVsBaPN/GA+zhtzbxLq5v/YJ5J0
 MvIcqoWYxb2TFXqDRHRadpgSvLxuHCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-h7PAfSEPMP2id0bcQoTZ3w-1; Wed, 23 Aug 2023 07:45:53 -0400
X-MC-Unique: h7PAfSEPMP2id0bcQoTZ3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D016101A52E;
 Wed, 23 Aug 2023 11:45:53 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17D9EC15BAE;
 Wed, 23 Aug 2023 11:45:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 04/12] target/s390x: Fix VSTL with a large length
Date: Wed, 23 Aug 2023 13:45:36 +0200
Message-Id: <20230823114544.216520-5-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The length is always truncated to 16 bytes. Do not probe more than
that.

Cc: qemu-stable@nongnu.org
Fixes: 0e0a5b49ad58 ("s390x/tcg: Implement VECTOR STORE WITH LENGTH")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230804235624.263260-1-iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/vec_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 48d86722b2..dafc4c3582 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -193,7 +193,7 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
                   uint64_t bytes)
 {
     /* Probe write access before actually modifying memory */
-    probe_write_access(env, addr, bytes, GETPC());
+    probe_write_access(env, addr, MIN(bytes, 16), GETPC());
 
     if (likely(bytes >= 16)) {
         cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());
-- 
2.39.3


