Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88E75FCC0
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:56:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNypA-0001Lu-Kt; Mon, 24 Jul 2023 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyp8-0001KS-Bf
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyos-0006ti-9G
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERUCIYKT5akT18Yn1fxNNKYgel0HSxbNwdqYnk0k/KQ=;
 b=KzSfJ8LH6RwjepP6N8fXaByJ4wvla/oqhw7vD9uv+xyxa0oy/0KZKnSHKW0CcYY/4+Yo4i
 kb3++oG/BWAHkRdmE8+UcPAz9db1VvkOLIsgLkNpy47rBdnNfTaeNwjd1P7nf9ogIstwM1
 9GRB9/L5JjhQfbEUtEPHaJhjnUkYBC4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-zpnVt5EFNKa-_OW-V6GSJQ-1; Mon, 24 Jul 2023 12:53:57 -0400
X-MC-Unique: zpnVt5EFNKa-_OW-V6GSJQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB9B2280BCA6;
 Mon, 24 Jul 2023 16:53:56 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70D1148FB01;
 Mon, 24 Jul 2023 16:53:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/16] target/s390x: Fix CONVERT TO LOGICAL/FIXED with
 out-of-range inputs
Date: Mon, 24 Jul 2023 18:53:36 +0200
Message-Id: <20230724165349.55714-4-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

CONVERT TO LOGICAL/FIXED deviate from IEEE 754 in that they raise an
inexact exception on out-of-range inputs. float_flag_invalid_cvti
aligns nicely with that behavior, so convert it to
S390_IEEE_MASK_INEXACT.

Cc: qemu-stable@nongnu.org
Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/fpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 4b7fa58af3..3d941ed2d2 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -52,7 +52,8 @@ uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
     s390_exc |= (exc & float_flag_divbyzero) ? S390_IEEE_MASK_DIVBYZERO : 0;
     s390_exc |= (exc & float_flag_overflow) ? S390_IEEE_MASK_OVERFLOW : 0;
     s390_exc |= (exc & float_flag_underflow) ? S390_IEEE_MASK_UNDERFLOW : 0;
-    s390_exc |= (exc & float_flag_inexact) ? S390_IEEE_MASK_INEXACT : 0;
+    s390_exc |= (exc & (float_flag_inexact | float_flag_invalid_cvti)) ?
+                S390_IEEE_MASK_INEXACT : 0;
 
     return s390_exc;
 }
-- 
2.39.3


