Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784EC717742
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:56:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4FkQ-0006NA-T1; Wed, 31 May 2023 02:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q4Fk3-0006Kl-Qh
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:55:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q4Fjy-0007QO-Ni
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:55:30 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VjwWFGL_1685516118; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0VjwWFGL_1685516118) by smtp.aliyun-inc.com;
 Wed, 31 May 2023 14:55:19 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] fpu: Add conversions between bfloat16 and [u]int8
Date: Wed, 31 May 2023 14:54:57 +0800
Message-Id: <20230531065458.2082-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

We missed these functions when upstreaming the bfloat16 support.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 fpu/softfloat.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h | 12 +++++++++
 2 files changed, 70 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 108f9cb224..576b026f4e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3113,6 +3113,15 @@ int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
     return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
+int8_t bfloat16_to_int8_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
+                               float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    return parts_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
+}
+
 int16_t bfloat16_to_int16_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
                                  float_status *s)
 {
@@ -3379,6 +3388,11 @@ int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *s)
     return floatx80_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+int8_t bfloat16_to_int8(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int8_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
 int16_t bfloat16_to_int16(bfloat16 a, float_status *s)
 {
     return bfloat16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
@@ -3394,6 +3408,11 @@ int64_t bfloat16_to_int64(bfloat16 a, float_status *s)
     return bfloat16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
 }
 
+int8_t bfloat16_to_int8_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int8_scalbn(a, float_round_to_zero, 0, s);
+}
+
 int16_t bfloat16_to_int16_round_to_zero(bfloat16 a, float_status *s)
 {
     return bfloat16_to_int16_scalbn(a, float_round_to_zero, 0, s);
@@ -3503,6 +3522,15 @@ uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
     return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
+uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode rmode,
+                                 int scale, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    return parts_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
+}
+
 uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode rmode,
                                    int scale, float_status *s)
 {
@@ -3728,6 +3756,11 @@ Int128 float128_to_uint128_round_to_zero(float128 a, float_status *s)
     return float128_to_uint128_scalbn(a, float_round_to_zero, 0, s);
 }
 
+uint8_t bfloat16_to_uint8(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint8_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
 uint16_t bfloat16_to_uint16(bfloat16 a, float_status *s)
 {
     return bfloat16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
@@ -3743,6 +3776,11 @@ uint64_t bfloat16_to_uint64(bfloat16 a, float_status *s)
     return bfloat16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
 }
 
+uint8_t bfloat16_to_uint8_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint8_scalbn(a, float_round_to_zero, 0, s);
+}
+
 uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *s)
 {
     return bfloat16_to_uint16_scalbn(a, float_round_to_zero, 0, s);
@@ -3898,6 +3936,11 @@ bfloat16 int16_to_bfloat16_scalbn(int16_t a, int scale, float_status *status)
     return int64_to_bfloat16_scalbn(a, scale, status);
 }
 
+bfloat16 int8_to_bfloat16_scalbn(int8_t a, int scale, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, scale, status);
+}
+
 bfloat16 int64_to_bfloat16(int64_t a, float_status *status)
 {
     return int64_to_bfloat16_scalbn(a, 0, status);
@@ -3913,6 +3956,11 @@ bfloat16 int16_to_bfloat16(int16_t a, float_status *status)
     return int64_to_bfloat16_scalbn(a, 0, status);
 }
 
+bfloat16 int8_to_bfloat16(int8_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
+
 float128 int128_to_float128(Int128 a, float_status *status)
 {
     FloatParts128 p = { };
@@ -4108,6 +4156,11 @@ bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int scale, float_status *status)
     return uint64_to_bfloat16_scalbn(a, scale, status);
 }
 
+bfloat16 uint8_to_bfloat16_scalbn(uint8_t a, int scale, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, scale, status);
+}
+
 bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status)
 {
     return uint64_to_bfloat16_scalbn(a, 0, status);
@@ -4123,6 +4176,11 @@ bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status)
     return uint64_to_bfloat16_scalbn(a, 0, status);
 }
 
+bfloat16 uint8_to_bfloat16(uint8_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
 float128 uint64_to_float128(uint64_t a, float_status *status)
 {
     FloatParts128 p;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3dcf20e3a2..6d02f619d0 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -366,6 +366,8 @@ float32 bfloat16_to_float32(bfloat16, float_status *status);
 bfloat16 float64_to_bfloat16(float64 a, float_status *status);
 float64 bfloat16_to_float64(bfloat16 a, float_status *status);
 
+int8_t bfloat16_to_int8_scalbn(bfloat16, FloatRoundMode,
+                               int, float_status *status);
 int16_t bfloat16_to_int16_scalbn(bfloat16, FloatRoundMode,
                                  int, float_status *status);
 int32_t bfloat16_to_int32_scalbn(bfloat16, FloatRoundMode,
@@ -373,14 +375,18 @@ int32_t bfloat16_to_int32_scalbn(bfloat16, FloatRoundMode,
 int64_t bfloat16_to_int64_scalbn(bfloat16, FloatRoundMode,
                                  int, float_status *status);
 
+int8_t bfloat16_to_int8(bfloat16, float_status *status);
 int16_t bfloat16_to_int16(bfloat16, float_status *status);
 int32_t bfloat16_to_int32(bfloat16, float_status *status);
 int64_t bfloat16_to_int64(bfloat16, float_status *status);
 
+int8_t bfloat16_to_int8_round_to_zero(bfloat16, float_status *status);
 int16_t bfloat16_to_int16_round_to_zero(bfloat16, float_status *status);
 int32_t bfloat16_to_int32_round_to_zero(bfloat16, float_status *status);
 int64_t bfloat16_to_int64_round_to_zero(bfloat16, float_status *status);
 
+uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode,
+                                 int, float_status *status);
 uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode,
                                    int, float_status *status);
 uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode,
@@ -388,24 +394,30 @@ uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode,
 uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode,
                                    int, float_status *status);
 
+uint8_t bfloat16_to_uint8(bfloat16 a, float_status *status);
 uint16_t bfloat16_to_uint16(bfloat16 a, float_status *status);
 uint32_t bfloat16_to_uint32(bfloat16 a, float_status *status);
 uint64_t bfloat16_to_uint64(bfloat16 a, float_status *status);
 
+uint8_t bfloat16_to_uint8_round_to_zero(bfloat16 a, float_status *status);
 uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *status);
 uint32_t bfloat16_to_uint32_round_to_zero(bfloat16 a, float_status *status);
 uint64_t bfloat16_to_uint64_round_to_zero(bfloat16 a, float_status *status);
 
+bfloat16 int8_to_bfloat16_scalbn(int8_t a, int, float_status *status);
 bfloat16 int16_to_bfloat16_scalbn(int16_t a, int, float_status *status);
 bfloat16 int32_to_bfloat16_scalbn(int32_t a, int, float_status *status);
 bfloat16 int64_to_bfloat16_scalbn(int64_t a, int, float_status *status);
+bfloat16 uint8_to_bfloat16_scalbn(uint8_t a, int, float_status *status);
 bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int, float_status *status);
 bfloat16 uint32_to_bfloat16_scalbn(uint32_t a, int, float_status *status);
 bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int, float_status *status);
 
+bfloat16 int8_to_bfloat16(int8_t a, float_status *status);
 bfloat16 int16_to_bfloat16(int16_t a, float_status *status);
 bfloat16 int32_to_bfloat16(int32_t a, float_status *status);
 bfloat16 int64_to_bfloat16(int64_t a, float_status *status);
+bfloat16 uint8_to_bfloat16(uint8_t a, float_status *status);
 bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status);
 bfloat16 uint32_to_bfloat16(uint32_t a, float_status *status);
 bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status);
-- 
2.17.1


