Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6A7D01D3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXmF-0001eS-9R; Thu, 19 Oct 2023 14:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm1-00018s-D4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:34 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXlz-0006zk-Ev
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:33 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5ac88d2cfaaso5057290a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697740169; x=1698344969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11JIGxMs2e2oQJXzv4Rfvtne38mlVuC/a60ICmsrKH4=;
 b=oVs12sli8mIyXLZ79DH4GlDWK9EsjgFmzDjaGl0RAnB5TFJRnt5aaG51no1nmj4rS9
 YQM27Mt4+JXWyPmq8k048PWZ3+y946CVNbDBsofcinvRg/7FXzLyOXbyDi4JQ/3hohFs
 5KBxqVJGOGVkeNdKHTCosAxThDWH+QaIMBxQxhkIyjRNW5ahLzeKAoshXuARFswiu5yo
 V/tifJXXeX59z7ALaI0RGItZNqR+y1GQFe3eOO7EudIcphi/fL+L4k8vXuZIcEPotjkj
 I2IbkTPXUrp4uCtVY5X1CkfwxvLyfDGjHk/sHR8KtPJ0cK5i/QkufKrKD6gZh0rGOLPQ
 Szsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740169; x=1698344969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11JIGxMs2e2oQJXzv4Rfvtne38mlVuC/a60ICmsrKH4=;
 b=e9BJLTREHDGVqaqYQAsOsDsMWLfJUds/MW1TbX+UcLNM/QntsLFmfMO5QQhkQj/0Qa
 CPLt41c+y0bmExFiX3znZ9PFLauSnMaQmBe8ymUEPNVo6Spo/VnpzNOV0rXTp+ypYgXC
 jEK6zl1AwGisstXyYuboMDIfR3mMLTQrcIOuoQSeCkuGsFDZOWDix5HSk80y2fCbIwGw
 9Wpswwj2n28cfw49FdAhatxIAbVCwNlYfY4x+fuwiUyeXsU31/hyaZxQYv0t9KVcfbw+
 A/+yKvWxj4a1aEu/UplR+1pDXM6ORAD75zantxcIu9h0vXms3zm+saNkxR2KX2fvv8+p
 CUcQ==
X-Gm-Message-State: AOJu0YyrPCTO8vZh679YQhTlZSloD/oWXY3YSsnwxPAZYG3CDSRllNc6
 jXYas6gkizexzGWg61S+ri4tU38l93JPIQssSZo=
X-Google-Smtp-Source: AGHT+IGl2XittOsYGLBvX49tuS+I/hTJBwnNQfWoWnwCz/OccYKuJVRi40qPtaujfyVGNgJOZwRe2Q==
X-Received: by 2002:a05:6a21:1444:b0:16b:e46e:1246 with SMTP id
 oc4-20020a056a21144400b0016be46e1246mr2491869pzb.30.1697740169268; 
 Thu, 19 Oct 2023 11:29:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e1-20020a630f01000000b005b856fab5e9sm72216pgl.18.2023.10.19.11.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:29:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
Subject: [PATCH 1/7] tcg: Export tcg_gen_ext_{i32,i64,tl}
Date: Thu, 19 Oct 2023 11:29:15 -0700
Message-Id: <20231019182921.1772928-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019182921.1772928-1-richard.henderson@linaro.org>
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The two concrete type functions already existed, merely needing
a bit of hardening to invalid inputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 ++
 include/tcg/tcg-op.h        |  2 ++
 tcg/tcg-op-ldst.c           | 14 ++++++++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a0bae5df01..677aea6dd1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -361,6 +361,7 @@ void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -564,6 +565,7 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index e81dd7dd9e..a02850583b 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -219,6 +219,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_ext16s_tl tcg_gen_ext16s_i64
 #define tcg_gen_ext32u_tl tcg_gen_ext32u_i64
 #define tcg_gen_ext32s_tl tcg_gen_ext32s_i64
+#define tcg_gen_ext_tl tcg_gen_ext_i64
 #define tcg_gen_bswap16_tl tcg_gen_bswap16_i64
 #define tcg_gen_bswap32_tl tcg_gen_bswap32_i64
 #define tcg_gen_bswap64_tl tcg_gen_bswap64_i64
@@ -338,6 +339,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_ext16s_tl tcg_gen_ext16s_i32
 #define tcg_gen_ext32u_tl tcg_gen_mov_i32
 #define tcg_gen_ext32s_tl tcg_gen_mov_i32
+#define tcg_gen_ext_tl tcg_gen_ext_i32
 #define tcg_gen_bswap16_tl tcg_gen_bswap16_i32
 #define tcg_gen_bswap32_tl(D, S, F) tcg_gen_bswap32_i32(D, S)
 #define tcg_gen_bswap_tl tcg_gen_bswap32_i32
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 2b96687699..e2c55df217 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -714,7 +714,7 @@ void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i128_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
+void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
 {
     switch (opc & MO_SSIZE) {
     case MO_SB:
@@ -729,13 +729,16 @@ static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
     case MO_UW:
         tcg_gen_ext16u_i32(ret, val);
         break;
-    default:
+    case MO_UL:
+    case MO_SL:
         tcg_gen_mov_i32(ret, val);
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
-static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
+void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
 {
     switch (opc & MO_SSIZE) {
     case MO_SB:
@@ -756,9 +759,12 @@ static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
     case MO_UL:
         tcg_gen_ext32u_i64(ret, val);
         break;
-    default:
+    case MO_UQ:
+    case MO_SQ:
         tcg_gen_mov_i64(ret, val);
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
-- 
2.34.1


