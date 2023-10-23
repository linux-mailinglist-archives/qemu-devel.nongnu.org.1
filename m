Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51817D3ED5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRG-0005on-QT; Mon, 23 Oct 2023 14:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRB-0005iO-Vo
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:02 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRA-0008Hw-9h
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:01 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-581b6b93bd1so2157722eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084839; x=1698689639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvOyipzTKG60zeb6vbq80oIWpFAQowpjRgOLngWjDDA=;
 b=QiLcaNk4GMT8ig0h/sK+3t5Mqr61JUoSHjahvMuPC0onI6Qat064ujBKDbrmPYcaOj
 TTZsiT8HEQmm2d+8L6hLbt3AQttUaDaDTk7tfBC74vQkFzNrK3GnjXxsagr1H8Rm0+aX
 jOd2t+j4DI+oswv03v0ihXXLkKZkHPnwryAdfDGJWN64ZdoJX3lHa4r52UnfKixBYDLy
 D/6mhNXH3lgwpd60dIrOS5soQbiWisc5aEIALRwyVlLHrQv/fFjXjSJxeEDy6sByquNA
 f5+3/P89oKrQhi9XZF3bEVr83EEwHtyXeLo0sQxGxOBo2OXbigxt0i3Ixw+0sGOese/D
 Jg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084839; x=1698689639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvOyipzTKG60zeb6vbq80oIWpFAQowpjRgOLngWjDDA=;
 b=ds1LWjLXoV13yvM36QJVXoVUkAPZjbVn3O1xemNP6MD5a/y+UivmvOHMOIGE7stAjN
 crtskx+vMndq/JuNedtW9Ec8meGuh2avTHLI0r67hVC/n3rTCJTAyt6KtZRZTpTXpPIJ
 U9iM7fRhslwl4Cui1PBMXnhn8TemfQaKdXyXMZkEANViPwcDUqYBJNWYVIbs/wrPWfRQ
 OaYYxGl/58pi+BcUhH1sQyDavSUr6uOcuERSquKG/JPTlxvFZFltm/4ElqFpsFGHtC+d
 Vto9F7VfXP85maBW9kg8eomtgD8Eph9YB4RTSUfMLORFZSGVZ5Eed/7L7fmPNwfD8o/7
 Aqqg==
X-Gm-Message-State: AOJu0YwlRTVt1nMaUwtsgZktsCSqyBiSf5kMJaDZJeJp+ccgapQ/JkgP
 iUKmkcUi58OJZac1YNL/vn3nXDmXHgM2QFRGCGU=
X-Google-Smtp-Source: AGHT+IF07de9wVhsYkXYJmx3pzOjvBwA4f8I6Pw+e4JT9UVpRMlPaguaSG5KRoERbXHsNnrAovJGPg==
X-Received: by 2002:a05:6358:f0e:b0:168:d3e7:5ee6 with SMTP id
 b14-20020a0563580f0e00b00168d3e75ee6mr5751410rwj.26.1698084838990; 
 Mon, 23 Oct 2023 11:13:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 31/38] tcg: Export tcg_gen_ext_{i32,i64,tl}
Date: Mon, 23 Oct 2023 11:13:22 -0700
Message-Id: <20231023181329.171490-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

The two concrete type functions already existed, merely needing
a bit of hardening to invalid inputs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


