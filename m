Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34777A3329
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMc-0006Jp-NZ; Sat, 16 Sep 2023 18:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMX-0006Ig-Oa
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:02:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMW-000489-1a
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:02:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c3cbfa40d6so30138165ad.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901719; x=1695506519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eViiNfbcR2Apwmf5vG4n86TRv+yRmlz4znqJM2rMWs=;
 b=YZR2A/ugYMTD2f5V6X8pyCLDfiM2ZdjxdVCy9p5jAMxLj1gg0jd7ZYHF7hSECx1K9g
 vd5qcuVScxSE3NKBDvf/QtghsNkbgZbUZz5llUAU+UDd7Gmf62QDkFj/B+cQS/Dypcuh
 65ij/cOkJHrhU+58MApRlNgU+BoQVT8s8NqjoyVPjH+lyfVnK5rfxttkwkEBFDPxX4cX
 Hhv6mSeBy1HP5qP5YworixXF/CTz46/HR8sEhpgqDvITCey6++vstHZx7oyE+GcsGcQy
 N4s4yM0OkabmHTg4u3FL4oOtkK9WEc9LJa8vyXBmtSBrIBqHOBLFB+XC3/NW9nUdA9dw
 FVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901719; x=1695506519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eViiNfbcR2Apwmf5vG4n86TRv+yRmlz4znqJM2rMWs=;
 b=XyF8O7dzbS07gy741o8/LNiojUP8AAApxDyZFQvjlIiPaaizBaiXUeYspixdXryvM8
 CMlElekOHZYWsRHJBQk5DfmSke+442ygmpEQ+fPb4K8b8ucxFcVDkQGAhEbxx5b3Tept
 FV5LoH4FZsYqDKcJg40UN7ir1aXIruWNczgLZ9lKvw+vx+lImtC7ZYLIULXYrroG/fdK
 OLHRwliMGLXkEKw1Yho5N3JC9OcCiqTKbF28FYbL/AW69s4GT8OxGjg8f+zhreSI36d2
 lRO+bQptyJ+doJ1BKWZzdmSPugY7iaSoUGS2vIX5QQXVf44IXe3oT6PCMJZar3qvyNH/
 FDEA==
X-Gm-Message-State: AOJu0YyS4QrAKYXv+LHgx4fxCbFFzaqMuWI83CWLAzK8kpIN+JqKdh83
 hH/wMs/bcPsuqdhxZI0FIs4fGv1Y1CHnEQYxKQE=
X-Google-Smtp-Source: AGHT+IEYQ3RMXr7Ry5/U/xA9cG0LlBfw8K6/KKMKYKRgIYYK3YGKK9g84sCm/BXy0UP78Me8i1gDgA==
X-Received: by 2002:a17:902:c949:b0:1c0:b17a:7576 with SMTP id
 i9-20020a170902c94900b001c0b17a7576mr7407282pla.42.1694901718917; 
 Sat, 16 Sep 2023 15:01:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 7/7] accel/tcg: Fix condition for store_atom_insert_al16
Date: Sat, 16 Sep 2023 15:01:51 -0700
Message-Id: <20230916220151.526140-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Store bytes under a mask is fundamentally a cmpxchg, not a straight store.
Use HAVE_CMPXCHG128 instead of HAVE_ATOMIC128_RW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c             |  2 +-
 accel/tcg/ldst_atomicity.c.inc | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3270f65c20..3b76626666 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2849,7 +2849,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
 
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
-        if (!HAVE_ATOMIC128_RW) {
+        if (!HAVE_CMPXCHG128) {
             cpu_loop_exit_atomic(env_cpu(env), ra);
         }
         return store_whole_le16(p->haddr, p->size, val_le);
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 23d43f62a2..5c6e116cfe 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -825,7 +825,7 @@ static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
     int sh = o * 8;
     Int128 m, v;
 
-    qemu_build_assert(HAVE_ATOMIC128_RW);
+    qemu_build_assert(HAVE_CMPXCHG128);
 
     /* Like MAKE_64BIT_MASK(0, sz), but larger. */
     if (sz <= 64) {
@@ -887,7 +887,7 @@ static void store_atom_2(CPUArchState *env, uintptr_t ra,
             return;
         }
     } else if ((pi & 15) == 7) {
-        if (HAVE_ATOMIC128_RW) {
+        if (HAVE_CMPXCHG128) {
             Int128 v = int128_lshift(int128_make64(val), 56);
             Int128 m = int128_lshift(int128_make64(0xffff), 56);
             store_atom_insert_al16(pv - 7, v, m);
@@ -956,7 +956,7 @@ static void store_atom_4(CPUArchState *env, uintptr_t ra,
                 return;
             }
         } else {
-            if (HAVE_ATOMIC128_RW) {
+            if (HAVE_CMPXCHG128) {
                 store_whole_le16(pv, 4, int128_make64(cpu_to_le32(val)));
                 return;
             }
@@ -1021,7 +1021,7 @@ static void store_atom_8(CPUArchState *env, uintptr_t ra,
         }
         break;
     case MO_64:
-        if (HAVE_ATOMIC128_RW) {
+        if (HAVE_CMPXCHG128) {
             store_whole_le16(pv, 8, int128_make64(cpu_to_le64(val)));
             return;
         }
@@ -1076,7 +1076,7 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
         }
         break;
     case -MO_64:
-        if (HAVE_ATOMIC128_RW) {
+        if (HAVE_CMPXCHG128) {
             uint64_t val_le;
             int s2 = pi & 15;
             int s1 = 16 - s2;
-- 
2.34.1


