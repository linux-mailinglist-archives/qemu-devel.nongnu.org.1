Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA970AB07
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 22:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0TbL-0007mD-3e; Sat, 20 May 2023 16:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0TbI-0007lo-L1; Sat, 20 May 2023 16:54:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0TbG-0004t3-9t; Sat, 20 May 2023 16:54:52 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 876887462DB;
 Sat, 20 May 2023 22:54:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 887287457E7; Sat, 20 May 2023 22:54:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] bitops.h: Compile out asserts without --enable-debug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-Id: <20230520205444.887287457E7@zero.eik.bme.hu>
Date: Sat, 20 May 2023 22:54:44 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The low level extract and deposit funtions provided by bitops.h are
used in performance critical places. It crept into target/ppc via
FIELD_EX64 and also used by softfloat so PPC code using a lot of FPU
where hardfloat is also disabled is doubly affected.

Normally asserts should be compiled out from release builds with
-DNDEBUG but that cannot be used in QEMU because some places still
rely on asserts instead of proper error checking. To resolve this,
compile out asserts from deposit/extract functions in optimised builds
which improves performance for target/ppc and possibly others too.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/qemu/bitops.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index cb3526d1f4..5a1d81297e 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -335,7 +335,9 @@ static inline uint64_t wswap64(uint64_t h)
  */
 static inline uint32_t extract32(uint32_t value, int start, int length)
 {
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 32 - start);
+#endif
     return (value >> start) & (~0U >> (32 - length));
 }
 
@@ -354,7 +356,9 @@ static inline uint32_t extract32(uint32_t value, int start, int length)
  */
 static inline uint8_t extract8(uint8_t value, int start, int length)
 {
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 8 - start);
+#endif
     return extract32(value, start, length);
 }
 
@@ -373,7 +377,9 @@ static inline uint8_t extract8(uint8_t value, int start, int length)
  */
 static inline uint16_t extract16(uint16_t value, int start, int length)
 {
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 16 - start);
+#endif
     return extract32(value, start, length);
 }
 
@@ -392,7 +398,9 @@ static inline uint16_t extract16(uint16_t value, int start, int length)
  */
 static inline uint64_t extract64(uint64_t value, int start, int length)
 {
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 64 - start);
+#endif
     return (value >> start) & (~0ULL >> (64 - length));
 }
 
@@ -414,7 +422,9 @@ static inline uint64_t extract64(uint64_t value, int start, int length)
  */
 static inline int32_t sextract32(uint32_t value, int start, int length)
 {
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 32 - start);
+#endif
     /* Note that this implementation relies on right shift of signed
      * integers being an arithmetic shift.
      */
@@ -439,7 +449,9 @@ static inline int32_t sextract32(uint32_t value, int start, int length)
  */
 static inline int64_t sextract64(uint64_t value, int start, int length)
 {
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 64 - start);
+#endif
     /* Note that this implementation relies on right shift of signed
      * integers being an arithmetic shift.
      */
@@ -467,7 +479,9 @@ static inline uint32_t deposit32(uint32_t value, int start, int length,
                                  uint32_t fieldval)
 {
     uint32_t mask;
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 32 - start);
+#endif
     mask = (~0U >> (32 - length)) << start;
     return (value & ~mask) | ((fieldval << start) & mask);
 }
@@ -493,7 +507,9 @@ static inline uint64_t deposit64(uint64_t value, int start, int length,
                                  uint64_t fieldval)
 {
     uint64_t mask;
+#ifndef __OPTIMIZE__
     assert(start >= 0 && length > 0 && length <= 64 - start);
+#endif
     mask = (~0ULL >> (64 - length)) << start;
     return (value & ~mask) | ((fieldval << start) & mask);
 }
-- 
2.30.9


