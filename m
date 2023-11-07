Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B457E3333
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9C-0008G9-0b; Mon, 06 Nov 2023 21:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C99-0008Es-9L
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:55 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C97-0005rB-LZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:55 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dae7cc31151so87130276.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325332; x=1699930132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=an482H69nlIo6guTD+Xr+Nwjug6G8AV8lg5cypnyOJs=;
 b=tXN2XRCP5v06+fadrdhfnnqKbAlAnsbSugXNAXhMzuUx67m2HXFUXMzzc7wVPX6zGY
 ihKS662+xdZF21L2khxXpLW7xpSyYkrHiPiT8CAvBp/zIL/+zq90qLtKR10fm9gL4O8e
 nENRbCyXJW1wPqJxxc6h6RE9SDPJ2VyCflws3b+IxRGwkWcskB24kszgO2e8ZGXvZD9m
 kvfXIOSeHBuRJrXgwahKFmYgi5adcGYBfvAKfnA7ueWqzibkxBC4cmYA/Zlw4mSGWHj0
 lsHgwkPvt9qxotiE3lHF2hYh2eJb97wUDEjGAjh4JMTOBjCRcr5LO7UepepDk2IqA4+m
 dH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325332; x=1699930132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=an482H69nlIo6guTD+Xr+Nwjug6G8AV8lg5cypnyOJs=;
 b=cJ4SR6mdWE9/nBzwmQHO1IMQwWr7sooVvhULsmDAauaLfdrixfoI4KCP/uvKdrUudQ
 /kho4A8M2Pf4wsNnbh1P023BAMWDvylrhBUAxjlKcRLfDWMJi6WwEUedAUaNIXvSFkSt
 DPUTDvVCY5A5OHcGkydY3D6gkdIz9DZltonfmkkp93emG6qP3/tR5jgUXERYjRtmosKM
 9MHDNT9RB/xmG1DgfYcY4sOyDxfEiMsj01eyBRnJfBtvhFlGfJuY+Td1iiZYSVYKYbaJ
 DgMKHdhfbhBJcqRk9SaFbMPMzLc1ciUXw2/ptIWco3MoWwf5TzUu149CdKGnjqda4nRc
 X3NQ==
X-Gm-Message-State: AOJu0YwbgqabyGcgbtElYvVNwcZ8vsuZxGUMUcB0UGEDVyMj/XFwlXy3
 F0Qzhp75NkkJ6Hpucop4RIdeqMinm0bGMxaT2Hs=
X-Google-Smtp-Source: AGHT+IEOyhY8RiWIN/2ccMHCRor/bZG9ecwDrvh6mVXdOzbJHJF7AZeEnVBmwdgNXRBrDX8Y2Md0rw==
X-Received: by 2002:a25:f828:0:b0:d9a:3d72:bfab with SMTP id
 u40-20020a25f828000000b00d9a3d72bfabmr26939894ybd.40.1699325332497; 
 Mon, 06 Nov 2023 18:48:52 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/35] tcg: Move generic expanders out of line
Date: Mon,  6 Nov 2023 18:48:18 -0800
Message-Id: <20231107024842.7650-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-4-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 19 +++----------------
 tcg/tcg-op.c                | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e093f541a7..2134961a98 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -72,12 +72,7 @@ void tcg_gen_op6ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
 
 /* Generic ops.  */
 
-static inline void gen_set_label(TCGLabel *l)
-{
-    l->present = 1;
-    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
-}
-
+void gen_set_label(TCGLabel *l);
 void tcg_gen_br(TCGLabel *l);
 void tcg_gen_mb(TCGBar);
 
@@ -121,16 +116,8 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
-static inline void tcg_gen_plugin_cb_start(unsigned from, unsigned type,
-                                           unsigned wr)
-{
-    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-}
-
-static inline void tcg_gen_plugin_cb_end(void)
-{
-    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
-}
+void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
+void tcg_gen_plugin_cb_end(void);
 
 /* 32 bit ops */
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6c826b46b0..a8cbad212d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -300,6 +300,12 @@ void DNI tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
 
 /* Generic ops.  */
 
+void gen_set_label(TCGLabel *l)
+{
+    l->present = 1;
+    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
+}
+
 static void add_last_as_label_use(TCGLabel *l)
 {
     TCGLabelUse *u = tcg_malloc(sizeof(TCGLabelUse));
@@ -333,6 +339,16 @@ void tcg_gen_mb(TCGBar mb_type)
     }
 }
 
+void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
+{
+    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
+}
+
+void tcg_gen_plugin_cb_end(void)
+{
+    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-- 
2.34.1


