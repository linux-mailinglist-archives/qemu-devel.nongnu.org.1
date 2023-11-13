Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A88F7EA1EE
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:34:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao1-0001VE-PS; Mon, 13 Nov 2023 12:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anw-0001U6-Pg
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:57 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anh-0000ut-90
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc5b7057d5so41935085ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896759; x=1700501559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yoygu1nJdDoN9VfRDXSQCv3IzXcMHrs0/BGmVO3uAho=;
 b=lQZWHnXD4fjnMThyUPuadmajPT6owqMrDoUL0ZBImhXgbJuOjoF4Cv2eZp8rsMONus
 yNJhZpOecotuRoooRY20xkSex449/Wwc3zwogeGCMgfruI97Ed7i+ctKp9rASEGSNVfm
 YDONCPKQhOwFazfaq+gg3ZVi+2ZyWSdFoeLG8ze4WgJcuYga9eZjO4FDE3InlGAAL20i
 1f9pBQF4m/0iQ64jrEzbGdpbTM8XrYhXfBISg2JjJ6JNuO50SQqdkf10+Zic5rmFgfZZ
 zaG2TBvJKyvjzP7zI/yY1Nte20Ba0bCkTG9ViULw0Kj9LWC/ixUSQgZ3hCGssq3twC3r
 2c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896759; x=1700501559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yoygu1nJdDoN9VfRDXSQCv3IzXcMHrs0/BGmVO3uAho=;
 b=adOV2FkelIccCdFLKsX2eGKpicsXKRRGloHRop0/J9OAHbEyO0sk+Gar6seF02wtvt
 H9paUikCl076cJF8byk4Xro5YemZ22nFxc73PI6lXUrKK7bWIU7XqxJG6k0k+AVIaN9m
 N514R2xgOI01KLfR+S2uQNI6UBq2uwk8K6xTbs6HOrn/y0/N81R+800fPH71TbKjkWrA
 +hJPrdvFwOnf/s46pTnnecF/p6xasX/BH+x7cLBc/9fmr3m8hzEYWYmRuOrJ/DNWZkBi
 Nwkv2JmagU9QdFpRtV4JRs3yfCAIRG/TgSAgUbmCR0HxY4lIJZ61KvPCRwG92+XBuem3
 zuqA==
X-Gm-Message-State: AOJu0YwQ5jaGDC1Uv21clohJNIP3P1D4H6b1kqB9QIqnF677g+fMPqCG
 x3tvXlZxb/wO15pC1fc6AHEKt7lI9mbMMHPHjms=
X-Google-Smtp-Source: AGHT+IH38BpCJM9tHf2gGl370+fKqL4gskHh+8U5ST8ljeengiY43zy39MXIvMRpJJJf4KaerSAyXw==
X-Received: by 2002:a17:902:8f83:b0:1ca:b26a:9729 with SMTP id
 z3-20020a1709028f8300b001cab26a9729mr252227plo.38.1699896759618; 
 Mon, 13 Nov 2023 09:32:39 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 01/12] target/hppa: Mask reserved PSW bits in expand_sm_imm
Date: Mon, 13 Nov 2023 09:32:26 -0800
Message-Id: <20231113173237.48233-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The system mask is a restricted subset of the psw, with only
a couple of reserved bits.  It is better to handle this up
front in the translator than require helper_swap_system_mask
to use cpu_hppa_get_psw and cpu_hppa_put_psw.

Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Handle this in expand_sm_imm not helper_swap_system_mask.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index bcce65d587..f3b17ba16d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -77,11 +77,14 @@ typedef struct DisasContext {
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
 static int expand_sm_imm(DisasContext *ctx, int val)
 {
-    if (val & PSW_SM_E) {
-        val = (val & ~PSW_SM_E) | PSW_E;
-    }
-    if (val & PSW_SM_W) {
-        val = (val & ~PSW_SM_W) | PSW_W;
+    /* Keep unimplemented bits disabled -- see cpu_hppa_put_psw. */
+    if (ctx->is_pa20) {
+        if (val & PSW_SM_W) {
+            val |= PSW_W;
+        }
+        val &= ~(PSW_SM_W | PSW_SM_E | PSW_G);
+    } else {
+        val &= ~(PSW_SM_W | PSW_SM_E | PSW_O);
     }
     return val;
 }
-- 
2.34.1


