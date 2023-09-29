Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA8B7B2ECD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Ms-000235-G7; Fri, 29 Sep 2023 05:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Mh-0001qg-Ht
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MO-0008Bw-D4
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+dpUECFCMcZ38HJNY0Gx8doEP4arUzG5jpycPf5+yc=;
 b=Qi09158uMOp04OfGjik2uwtl3JUALlPl6tOZsOJUFV6HYlX2X0pMePUgP0gkhRnuXQVrdb
 jav5pQdVPO0SGvJrJ9kOtE2OI7z28hPc20RGlu6CfSFUhtBg58WJPgPxgYnIWhIAgbuVko
 /rEtz6yDgPG+iQuVGv3T1U1loN7gj2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-SxpB8XR9OESt43ESgH-RpA-1; Fri, 29 Sep 2023 05:00:27 -0400
X-MC-Unique: SxpB8XR9OESt43ESgH-RpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C2DB1019C99;
 Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DB37176EA;
 Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE86621E689F; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 42/56] hw/arm/smmuv3-internal.h: Don't use locals in statement
 macros
Date: Fri, 29 Sep 2023 10:50:39 +0200
Message-ID: <20230929085053.2789105-43-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Peter Maydell <peter.maydell@linaro.org>

The STE_CTXPTR() and STE_S2TTB() macros both extract two halves
of an address from fields in the STE and combine them into a
single value to return. The current code for this uses a GCC
statement expression. There are two problems with this:

(1) The type chosen for the variable in the statement expr
is 'unsigned long', which might not be 64 bits

(2) the name chosen for the variable causes -Wshadow warnings
because it's the same as a variable in use at the callsite:

In file included from ../../hw/arm/smmuv3.c:34:
../../hw/arm/smmuv3.c: In function ‘smmu_get_cd’:
../../hw/arm/smmuv3-internal.h:538:23: warning: declaration of ‘addr’ shadows a previous local [-Wshadow=compatible-local]
  538 |         unsigned long addr;                                     \
      |                       ^~~~
../../hw/arm/smmuv3.c:339:23: note: in expansion of macro ‘STE_CTXPTR’
  339 |     dma_addr_t addr = STE_CTXPTR(ste);
      |                       ^~~~~~~~~~
../../hw/arm/smmuv3.c:339:16: note: shadowed declaration is here
  339 |     dma_addr_t addr = STE_CTXPTR(ste);
      |                ^~~~

Sidestep both of these problems by just using a single
expression rather than a statement expr.

For CMD_ADDR, we got the type of the variable right but still
run into -Wshadow problems:

In file included from ../../hw/arm/smmuv3.c:34:
../../hw/arm/smmuv3.c: In function ‘smmuv3_range_inval’:
../../hw/arm/smmuv3-internal.h:334:22: warning: declaration of ‘addr’ shadows a previous local [-Wshadow=compatible-local]
  334 |             uint64_t addr = high << 32 | (low << 12);         \
      |                      ^~~~
../../hw/arm/smmuv3.c:1104:28: note: in expansion of macro ‘CMD_ADDR’
 1104 |     dma_addr_t end, addr = CMD_ADDR(cmd);
      |                            ^~~~~~~~
../../hw/arm/smmuv3.c:1104:21: note: shadowed declaration is here
 1104 |     dma_addr_t end, addr = CMD_ADDR(cmd);
      |                     ^~~~

so convert it too.

CD_TTB has neither problem, but it is the only other macro in
the file that uses this pattern, so we convert it also for
consistency's sake.

We use extract64() rather than extract32() to avoid having
to explicitly cast the result to uint64_t.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20230922152944.3583438-5-peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/smmuv3-internal.h | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 6d1c1edab7..648c2e37a2 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -328,12 +328,9 @@ enum { /* Command completion notification */
 #define CMD_TTL(x)          extract32((x)->word[2], 8 , 2)
 #define CMD_TG(x)           extract32((x)->word[2], 10, 2)
 #define CMD_STE_RANGE(x)    extract32((x)->word[2], 0 , 5)
-#define CMD_ADDR(x) ({                                        \
-            uint64_t high = (uint64_t)(x)->word[3];           \
-            uint64_t low = extract32((x)->word[2], 12, 20);    \
-            uint64_t addr = high << 32 | (low << 12);         \
-            addr;                                             \
-        })
+#define CMD_ADDR(x)                             \
+    (((uint64_t)((x)->word[3]) << 32) |         \
+     ((extract64((x)->word[2], 12, 20)) << 12))
 
 #define SMMU_FEATURE_2LVL_STE (1 << 0)
 
@@ -533,21 +530,13 @@ typedef struct CD {
 #define STE_S2S(x)         extract32((x)->word[5], 25, 1)
 #define STE_S2R(x)         extract32((x)->word[5], 26, 1)
 
-#define STE_CTXPTR(x)                                           \
-    ({                                                          \
-        unsigned long addr;                                     \
-        addr = (uint64_t)extract32((x)->word[1], 0, 16) << 32;  \
-        addr |= (uint64_t)((x)->word[0] & 0xffffffc0);          \
-        addr;                                                   \
-    })
+#define STE_CTXPTR(x)                                   \
+    ((extract64((x)->word[1], 0, 16) << 32) |           \
+     ((x)->word[0] & 0xffffffc0))
 
-#define STE_S2TTB(x)                                            \
-    ({                                                          \
-        unsigned long addr;                                     \
-        addr = (uint64_t)extract32((x)->word[7], 0, 16) << 32;  \
-        addr |= (uint64_t)((x)->word[6] & 0xfffffff0);          \
-        addr;                                                   \
-    })
+#define STE_S2TTB(x)                                    \
+    ((extract64((x)->word[7], 0, 16) << 32) |           \
+     ((x)->word[6] & 0xfffffff0))
 
 static inline int oas2bits(int oas_field)
 {
@@ -585,14 +574,10 @@ static inline int pa_range(STE *ste)
 
 #define CD_VALID(x)   extract32((x)->word[0], 31, 1)
 #define CD_ASID(x)    extract32((x)->word[1], 16, 16)
-#define CD_TTB(x, sel)                                      \
-    ({                                                      \
-        uint64_t hi, lo;                                    \
-        hi = extract32((x)->word[(sel) * 2 + 3], 0, 19);    \
-        hi <<= 32;                                          \
-        lo = (x)->word[(sel) * 2 + 2] & ~0xfULL;            \
-        hi | lo;                                            \
-    })
+#define CD_TTB(x, sel)                                          \
+    ((extract64((x)->word[(sel) * 2 + 3], 0, 19) << 32) |       \
+     ((x)->word[(sel) * 2 + 2] & ~0xfULL))
+
 #define CD_HAD(x, sel)   extract32((x)->word[(sel) * 2 + 2], 1, 1)
 
 #define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
-- 
2.41.0


