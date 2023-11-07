Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE797E3332
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C99-0008EM-7O; Mon, 06 Nov 2023 21:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C96-0008BH-RP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:52 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C95-0005qf-8d
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:52 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b58d96a3bbso2020582b6e.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325330; x=1699930130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IUHz5LdFJfuVGFZ9kE+P0nwAIXfhY4T9R1W1nItwZn8=;
 b=lrFaU5LR3SIRW81Cy1YTTeGcZf8hi+ixnat+zh2czf4Iq5EWjwA6ey3L3Y35t6XLwP
 DEDs4qwFYvhbSUL43YMpKNamk1t7iNDx+CAkwm7z1k/tAi3B07La5kisP0ekX6hXZM9X
 NdpWCKkuSDPmCS+n0MzW+iQ1EAZ2dn0loDIQqLbus+9FCbKMxmbjVGEL7JL99LApCdQJ
 8gyxnvnLqlx94z4MRyWhVDG/ZG65/wU+VNQMzJbxeaaDtJircCQCM8gX0atLhGtYQZIS
 zwZZXPS+I2n9NPX77ucJmQi3YWkgwzMqOKcwiz20ptwU5VFIPV3cfBTyMR4wro0rhYKS
 IbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325330; x=1699930130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUHz5LdFJfuVGFZ9kE+P0nwAIXfhY4T9R1W1nItwZn8=;
 b=YZfmKa1zaXbqmeo2Zd9UPOiOjpaIMM1sHT/crEcf4cXjEzqtgp18/od/hw9n39L88w
 Rg/0/59LRqDFDKlHByf0k1F4JIVCp4WDUldG0xkWFwAWFTp1vdT6sF9OqI0mgqF8H8tl
 XSrp+5bKVf27hCJOgfyx3puMsJhtCctxVz7BrXh2I0lE3ez8Bc4XnWd1fMVyhQYI5O/f
 Vip6n/x1fovbjFDohaDtS+TQ2k0JfxZ424/YHOpYHLTiU4g60JbjB0+mFV0Z761xrTRo
 uTPdK/W/3H19lqqB2SMAOBkY1idd3aRm9ms1umbdPLPQ0MOBuxK/Yq3SNFhoJgUdQY6Y
 puCg==
X-Gm-Message-State: AOJu0YwtEURs/aHKvbJ/qvxkYWVN6Y+6NYmUji/25d8nq1jldueNIkGn
 DfBlE3lCbZa+u8PfubjG0weOT6ovtrqftZkx51g=
X-Google-Smtp-Source: AGHT+IGc9Kprv3yCCMGuZVGBq4p8j2TdEnT0jKa48jXMxd4+R+AEz6kI9MyFTq+BgZpf/S8qUQu/3w==
X-Received: by 2002:aca:1917:0:b0:3b2:ddc0:ac9c with SMTP id
 l23-20020aca1917000000b003b2ddc0ac9cmr29388440oii.39.1699325330137; 
 Mon, 06 Nov 2023 18:48:50 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/35] accel/tcg: Fix condition for store_atom_insert_al16
Date: Mon,  6 Nov 2023 18:48:15 -0800
Message-Id: <20231107024842.7650-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Store bytes under a mask is fundamentally a cmpxchg, not a straight store.
Use HAVE_CMPXCHG128 instead of HAVE_ATOMIC128_RW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230916220151.526140-8-richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c             |  2 +-
 accel/tcg/ldst_atomicity.c.inc | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 13986820fe..f35c5f359b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2691,7 +2691,7 @@ static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
 
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
-        if (!HAVE_ATOMIC128_RW) {
+        if (!HAVE_CMPXCHG128) {
             cpu_loop_exit_atomic(cpu, ra);
         }
         return store_whole_le16(p->haddr, p->size, val_le);
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index e8f97506fa..33a04dec52 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -825,7 +825,7 @@ static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
     int sh = o * 8;
     Int128 m, v;
 
-    qemu_build_assert(HAVE_ATOMIC128_RW);
+    qemu_build_assert(HAVE_CMPXCHG128);
 
     /* Like MAKE_64BIT_MASK(0, sz), but larger. */
     if (sz <= 64) {
@@ -887,7 +887,7 @@ static void store_atom_2(CPUState *cpu, uintptr_t ra,
             return;
         }
     } else if ((pi & 15) == 7) {
-        if (HAVE_ATOMIC128_RW) {
+        if (HAVE_CMPXCHG128) {
             Int128 v = int128_lshift(int128_make64(val), 56);
             Int128 m = int128_lshift(int128_make64(0xffff), 56);
             store_atom_insert_al16(pv - 7, v, m);
@@ -956,7 +956,7 @@ static void store_atom_4(CPUState *cpu, uintptr_t ra,
                 return;
             }
         } else {
-            if (HAVE_ATOMIC128_RW) {
+            if (HAVE_CMPXCHG128) {
                 store_whole_le16(pv, 4, int128_make64(cpu_to_le32(val)));
                 return;
             }
@@ -1021,7 +1021,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
         }
         break;
     case MO_64:
-        if (HAVE_ATOMIC128_RW) {
+        if (HAVE_CMPXCHG128) {
             store_whole_le16(pv, 8, int128_make64(cpu_to_le64(val)));
             return;
         }
@@ -1076,7 +1076,7 @@ static void store_atom_16(CPUState *cpu, uintptr_t ra,
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


