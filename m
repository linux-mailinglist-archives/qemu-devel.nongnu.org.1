Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B477D3ED6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRe-0006OC-NM; Mon, 23 Oct 2023 14:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRF-0005ka-6Y
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:05 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRD-0008It-LK
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso2757649b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084842; x=1698689642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BPLQFLnOkGd2O+DZrp/H9MQMrrZMZjnNrX39kKF71w=;
 b=m4AO2phiy17MMXPImsHN22acalREyGv2TVRwm335D6kI+fgCNyvSWjx84xVBGt6/LJ
 dzkx58ARrdOp5Go5+tnhmsBVGJOaUpVgNZwZQ3BMZgSczmX6ehiLwunYqR5DHZhd5ZD2
 FK/pduj5TvE/47YDwQQeFMgRqYiUxBnkn30EYOaMxKKeiMMZQ3jBAnELQgEWlBM6rACf
 g+yp9/QqNkFVda6lYfgZTvafhAzhbSog25yg9PPAJ52ba1OaceTtC7nMeoxpWyRb92cI
 jhNds9wwquaycq/4NW0QtlZXFuXMoDueeKTPeyWraRm28Xzpn9ItNNjbSVoYs6baw37X
 vBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084842; x=1698689642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BPLQFLnOkGd2O+DZrp/H9MQMrrZMZjnNrX39kKF71w=;
 b=mVrwKHdyQvE6pnSy2mA2fVI14wLnB3TQBCQda5rNonXRiqngal1Ich3xLH8ClOhQf5
 WlRdwSUTLAQaqQAuLtIp0mk3TK3Xz3E465+6XCvVcmohxQuYFHBRrkKGv9oVZNRyMDuf
 E765HmgRilxnGexlUgaFnVIQpKWm3yQd2RbXnnLn9JXX/fJ0qpJwUHK+nUP9ux8UqmY3
 mnd/Uez9SOLwF/MDGSoKrw+yNg85TqXuShFf+24s9vKD7v/x8OjXXyqKolOuHqsoWoRv
 z9S5w0bbX1vmg8I6hEF6TMS2GjBsZo+0zPrlo1JZuJtwftP/6Fr9Ij3rZymt44YZFfcI
 aROw==
X-Gm-Message-State: AOJu0Yyqqf7GeyX82Eg5nfEEaMdHl1wz5j2BywEvI/Mu8eT+A+RbuRTG
 +75dL2wG408IVX457YJTMw5BQErMKsY8gi8CyDY=
X-Google-Smtp-Source: AGHT+IFvEBX8mOOHCvaS+U4VMnRQwHSI/ajw97u/wA1x4dvoFlta9eR4KXZQ0zmQhNBDBjEHS7e6/w==
X-Received: by 2002:a05:6a21:4842:b0:16b:d137:de5a with SMTP id
 au2-20020a056a21484200b0016bd137de5amr345082pzc.28.1698084842377; 
 Mon, 23 Oct 2023 11:14:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:14:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 35/38] target/m68k: Use tcg_gen_ext_i32
Date: Mon, 23 Oct 2023 11:13:26 -0700
Message-Id: <20231023181329.171490-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

We still need to check OS_{BYTE,WORD,LONG},
because m68k includes floating point in OS_*.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4d0110de95..4a0b0b2703 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -520,21 +520,9 @@ static inline void gen_ext(TCGv res, TCGv val, int opsize, int sign)
 {
     switch (opsize) {
     case OS_BYTE:
-        if (sign) {
-            tcg_gen_ext8s_i32(res, val);
-        } else {
-            tcg_gen_ext8u_i32(res, val);
-        }
-        break;
     case OS_WORD:
-        if (sign) {
-            tcg_gen_ext16s_i32(res, val);
-        } else {
-            tcg_gen_ext16u_i32(res, val);
-        }
-        break;
     case OS_LONG:
-        tcg_gen_mov_i32(res, val);
+        tcg_gen_ext_i32(res, val, opsize | (sign ? MO_SIGN : 0));
         break;
     default:
         g_assert_not_reached();
@@ -1072,15 +1060,10 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
             tmp = tcg_temp_new();
             switch (opsize) {
             case OS_BYTE:
-                tcg_gen_ext8s_i32(tmp, reg);
-                gen_helper_exts32(tcg_env, fp, tmp);
-                break;
             case OS_WORD:
-                tcg_gen_ext16s_i32(tmp, reg);
-                gen_helper_exts32(tcg_env, fp, tmp);
-                break;
             case OS_LONG:
-                gen_helper_exts32(tcg_env, fp, reg);
+                tcg_gen_ext_i32(tmp, reg, opsize | MO_SIGN);
+                gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_SINGLE:
                 gen_helper_extf32(tcg_env, fp, reg);
-- 
2.34.1


