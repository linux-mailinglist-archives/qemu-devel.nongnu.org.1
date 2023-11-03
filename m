Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA77E07AA
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8z-0005UD-2P; Fri, 03 Nov 2023 13:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8e-0005J3-Hh
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8K-0003av-LL
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso20804425ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033137; x=1699637937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVsbIeWHMF2HBCXqKDb/t306b+v4n8a0ChABNQQ+H1I=;
 b=P9uUVUNPf41b5DVONc7w7VAB93IVUk9PZS5yGQPFxizu9yUGPjo6tsXoImsT+7VEVV
 IL/u9ah5Hz7dxKruk0HltoL4AbCb6q9Iwd4ETzTc0BTB4O8HJ88sN7ktiuFe7Lnm9KF0
 Xnssav9GkMtL/kc6+dOx8S1bWz0mp5MPNyhGHAx9UU70dxLP1iUW20ONGbUdc4imiLQJ
 qzyfqumuWOdSXuZ/2f7ZNZYa4qkQPH6y0Dm78DwvALUx/qGYVMYYilRqqoojK0j5IiFz
 7A2Nso61zbrYUZXL5TYzl5aP/vM2yRqtZlkVHsUO3ccyVeCpqMF4itI9xSpOh5nb9xLf
 R7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033137; x=1699637937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVsbIeWHMF2HBCXqKDb/t306b+v4n8a0ChABNQQ+H1I=;
 b=CDM7aigk/Y1/jAO3X2gxyXUGynvLNWVzhunGDwpD171L+FnMogVOAzg6521gf7iR/v
 IaGikAPlsptlI23MeKQ98rk6bTEmknhFUNzG3vftRw5rsK5A4gesbyB+OvgKahIugAJW
 dEEP6cLm6jcSUvU/VdQzalBYKdk85t4PPdVi3TWCK2XpjgyzXjbFgI0qPFO0Ez97jfg6
 Eo8fEht3v6t44Tlk0UTMqPp9UI8KgWUlgJ/1USoSb+41FUXjcCmehyNF0FfHDFadGrp+
 gbyj0zwaQ5te9DigVPB5/z47747rBY6uQV80FaAlUvDm2C/bQKY0ROq+3yGqxGaJ/m51
 0Pxw==
X-Gm-Message-State: AOJu0YzamX7gSZl/R28xAGPbvXB49eMUNDG+YvGiMSIBKn1rxWu8+QYr
 T7aQLxPBnElmsSKtzZZ1VteDKZK0FJmpf+VTbyU=
X-Google-Smtp-Source: AGHT+IHTrhPV7iSWRzryvuFkDlrUtEWUH0Wxt7AT0tadxsgMT13/TnCmJxuo4qax2SdsAidk+fDI8A==
X-Received: by 2002:a17:902:f394:b0:1c9:b2c1:139c with SMTP id
 f20-20020a170902f39400b001c9b2c1139cmr18179316ple.62.1699033137224; 
 Fri, 03 Nov 2023 10:38:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 18/22] target/sparc: Merge check_ieee_exceptions with FPop
 helpers
Date: Fri,  3 Nov 2023 10:38:37 -0700
Message-Id: <20231103173841.33651-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

If an exception is to be raised, the destination fp register
should be unmodified.  The current implementation is incorrect,
in that double results will be written back before calling
gen_helper_check_ieee_exceptions, despite the placement of
gen_store_fpr_D, since gen_dest_fpr_D returns cpu_fpr[].

We can simplify the entire implementation by having each
FPOp helper call check_ieee_exceptions.  For the moment this
requires that all FPop helpers write to the TCG global cpu_fsr,
so remove TCG_CALL_NO_WG from the DEF_HELPER_FLAGS_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 119 +++++++++++----------
 target/sparc/fop_helper.c | 215 ++++++++++++++++++++++++++++----------
 target/sparc/translate.c  |  14 ---
 3 files changed, 219 insertions(+), 129 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index cc8db50d75..7c688edd62 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -35,81 +35,80 @@ DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
 DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
-DEF_HELPER_FLAGS_1(check_ieee_exceptions, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
 DEF_HELPER_FLAGS_2(set_fsr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_RWG, f32, env, f32)
-DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_RWG, f64, env, f64)
-DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_RWG, i128, env, i128)
-DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_2(fsqrts, 0, f32, env, f32)
+DEF_HELPER_FLAGS_2(fsqrtd, 0, f64, env, f64)
+DEF_HELPER_FLAGS_2(fsqrtq, 0, i128, env, i128)
+DEF_HELPER_FLAGS_3(fcmps, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpd, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpes, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmped, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpq, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq, 0, tl, env, i128, i128)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmps_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpd_fcc1, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpd_fcc2, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpd_fcc3, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpes_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpes_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc1, TCG_CALL_NO_WG, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmps_fcc1, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmps_fcc2, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmps_fcc3, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpd_fcc1, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpd_fcc2, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpd_fcc3, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpes_fcc1, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpes_fcc2, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpes_fcc3, 0, tl, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmped_fcc1, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmped_fcc2, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmped_fcc3, 0, tl, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpq_fcc1, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc2, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc3, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc1, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc2, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc3, 0, tl, env, i128, i128)
 #endif
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
-DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_RWG, f64, env, f64, f64)
-DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_RWG, f64, env, f64, f64)
-DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_RWG, f64, env, f64, f64)
-DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_RWG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(faddd, 0, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fsubd, 0, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fmuld, 0, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fdivd, 0, f64, env, f64, f64)
 
-DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_RWG, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_RWG, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(fmulq, TCG_CALL_NO_RWG, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(fdivq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(faddq, 0, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fsubq, 0, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fmulq, 0, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fdivq, 0, i128, env, i128, i128)
 
-DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_RWG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_RWG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_RWG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_RWG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fadds, 0, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fsubs, 0, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fmuls, 0, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fdivs, 0, f32, env, f32, f32)
 
-DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, i128, env, f64, f64)
+DEF_HELPER_FLAGS_3(fsmuld, 0, f64, env, f32, f32)
+DEF_HELPER_FLAGS_3(fdmulq, 0, i128, env, f64, f64)
 
-DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
-DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, i128, env, s32)
+DEF_HELPER_FLAGS_2(fitod, 0, f64, env, s32)
+DEF_HELPER_FLAGS_2(fitoq, 0, i128, env, s32)
 
-DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
+DEF_HELPER_FLAGS_2(fitos, 0, f32, env, s32)
 
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_RWG, f32, env, s64)
-DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_RWG, f64, env, s64)
-DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, i128, env, s64)
+DEF_HELPER_FLAGS_2(fxtos, 0, f32, env, s64)
+DEF_HELPER_FLAGS_2(fxtod, 0, f64, env, s64)
+DEF_HELPER_FLAGS_2(fxtoq, 0, i128, env, s64)
 #endif
-DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
-DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
-DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
-DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, i128, env, f32)
-DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
-DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, i128, env, f64)
-DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
-DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
-DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
+DEF_HELPER_FLAGS_2(fdtos, 0, f32, env, f64)
+DEF_HELPER_FLAGS_2(fstod, 0, f64, env, f32)
+DEF_HELPER_FLAGS_2(fqtos, 0, f32, env, i128)
+DEF_HELPER_FLAGS_2(fstoq, 0, i128, env, f32)
+DEF_HELPER_FLAGS_2(fqtod, 0, f64, env, i128)
+DEF_HELPER_FLAGS_2(fdtoq, 0, i128, env, f64)
+DEF_HELPER_FLAGS_2(fstoi, 0, s32, env, f32)
+DEF_HELPER_FLAGS_2(fdtoi, 0, s32, env, f64)
+DEF_HELPER_FLAGS_2(fqtoi, 0, s32, env, i128)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_RWG, s64, env, f32)
-DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
-DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_RWG, s64, env, i128)
+DEF_HELPER_FLAGS_2(fstox, 0, s64, env, f32)
+DEF_HELPER_FLAGS_2(fdtox, 0, s64, env, f64)
+DEF_HELPER_FLAGS_2(fqtox, 0, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 64f20e78f1..755117ea08 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -45,7 +45,7 @@ static inline Int128 f128_ret(float128 f)
     return u.i;
 }
 
-static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
+static void check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
 {
     target_ulong status = get_float_exception_flags(&env->fp_status);
     target_ulong fsr = env->fsr;
@@ -89,162 +89,265 @@ static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
         }
     }
 
-    return fsr;
+    env->fsr = fsr;
 }
 
-target_ulong helper_check_ieee_exceptions(CPUSPARCState *env)
+float32 helper_fadds(CPUSPARCState *env, float32 src1, float32 src2)
 {
-    return do_check_ieee_exceptions(env, GETPC());
+    float32 ret = float32_add(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
-#define F_BINOP(name)                                                \
-    float32 helper_f ## name ## s (CPUSPARCState *env, float32 src1, \
-                                   float32 src2)                     \
-    {                                                                \
-        return float32_ ## name (src1, src2, &env->fp_status);       \
-    }                                                                \
-    float64 helper_f ## name ## d (CPUSPARCState * env, float64 src1,\
-                                   float64 src2)                     \
-    {                                                                \
-        return float64_ ## name (src1, src2, &env->fp_status);       \
-    }                                                                \
-    Int128 helper_f ## name ## q(CPUSPARCState * env, Int128 src1,   \
-                                 Int128 src2)                        \
-    {                                                                \
-        return f128_ret(float128_ ## name (f128_in(src1), f128_in(src2), \
-                                           &env->fp_status));        \
-    }
+float32 helper_fsubs(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float32 ret = float32_sub(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
 
-F_BINOP(add);
-F_BINOP(sub);
-F_BINOP(mul);
-F_BINOP(div);
-#undef F_BINOP
+float32 helper_fmuls(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float32 ret = float32_mul(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float32 helper_fdivs(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float32 ret = float32_div(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_faddd(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_add(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fsubd(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_sub(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fmuld(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_mul(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fdivd(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_div(src1, src2, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+Int128 helper_faddq(CPUSPARCState *env, Int128 src1, Int128 src2)
+{
+    float128 ret = float128_add(f128_in(src1), f128_in(src2), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
+}
+
+Int128 helper_fsubq(CPUSPARCState *env, Int128 src1, Int128 src2)
+{
+    float128 ret = float128_sub(f128_in(src1), f128_in(src2), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
+}
+
+Int128 helper_fmulq(CPUSPARCState *env, Int128 src1, Int128 src2)
+{
+    float128 ret = float128_mul(f128_in(src1), f128_in(src2), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
+}
+
+Int128 helper_fdivq(CPUSPARCState *env, Int128 src1, Int128 src2)
+{
+    float128 ret = float128_div(f128_in(src1), f128_in(src2), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
+}
 
 float64 helper_fsmuld(CPUSPARCState *env, float32 src1, float32 src2)
 {
-    return float64_mul(float32_to_float64(src1, &env->fp_status),
-                       float32_to_float64(src2, &env->fp_status),
-                       &env->fp_status);
+    float64 ret = float64_mul(float32_to_float64(src1, &env->fp_status),
+                              float32_to_float64(src2, &env->fp_status),
+                              &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 Int128 helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
 {
-    return f128_ret(float128_mul(float64_to_float128(src1, &env->fp_status),
-                                 float64_to_float128(src2, &env->fp_status),
-                                 &env->fp_status));
+    float128 ret = float128_mul(float64_to_float128(src1, &env->fp_status),
+                                float64_to_float128(src2, &env->fp_status),
+                                &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
 }
 
 /* Integer to float conversion.  */
 float32 helper_fitos(CPUSPARCState *env, int32_t src)
 {
-    return int32_to_float32(src, &env->fp_status);
+    float32 ret = int32_to_float32(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 float64 helper_fitod(CPUSPARCState *env, int32_t src)
 {
-    return int32_to_float64(src, &env->fp_status);
+    float64 ret = int32_to_float64(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 Int128 helper_fitoq(CPUSPARCState *env, int32_t src)
 {
-    return f128_ret(int32_to_float128(src, &env->fp_status));
+    float128 ret = int32_to_float128(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
 }
 
 #ifdef TARGET_SPARC64
 float32 helper_fxtos(CPUSPARCState *env, int64_t src)
 {
-    return int64_to_float32(src, &env->fp_status);
+    float32 ret = int64_to_float32(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 float64 helper_fxtod(CPUSPARCState *env, int64_t src)
 {
-    return int64_to_float64(src, &env->fp_status);
+    float64 ret = int64_to_float64(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 Int128 helper_fxtoq(CPUSPARCState *env, int64_t src)
 {
-    return f128_ret(int64_to_float128(src, &env->fp_status));
+    float128 ret = int64_to_float128(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
 }
 #endif
 
 /* floating point conversion */
 float32 helper_fdtos(CPUSPARCState *env, float64 src)
 {
-    return float64_to_float32(src, &env->fp_status);
+    float32 ret = float64_to_float32(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 float64 helper_fstod(CPUSPARCState *env, float32 src)
 {
-    return float32_to_float64(src, &env->fp_status);
+    float64 ret = float32_to_float64(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 float32 helper_fqtos(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_float32(f128_in(src), &env->fp_status);
+    float32 ret = float128_to_float32(f128_in(src), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 Int128 helper_fstoq(CPUSPARCState *env, float32 src)
 {
-    return f128_ret(float32_to_float128(src, &env->fp_status));
+    float128 ret = float32_to_float128(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
 }
 
 float64 helper_fqtod(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_float64(f128_in(src), &env->fp_status);
+    float64 ret = float128_to_float64(f128_in(src), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 Int128 helper_fdtoq(CPUSPARCState *env, float64 src)
 {
-    return f128_ret(float64_to_float128(src, &env->fp_status));
+    float128 ret = float64_to_float128(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
 }
 
 /* Float to integer conversion.  */
 int32_t helper_fstoi(CPUSPARCState *env, float32 src)
 {
-    return float32_to_int32_round_to_zero(src, &env->fp_status);
+    int32_t ret = float32_to_int32_round_to_zero(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 int32_t helper_fdtoi(CPUSPARCState *env, float64 src)
 {
-    return float64_to_int32_round_to_zero(src, &env->fp_status);
+    int32_t ret = float64_to_int32_round_to_zero(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 int32_t helper_fqtoi(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_int32_round_to_zero(f128_in(src), &env->fp_status);
+    int32_t ret = float128_to_int32_round_to_zero(f128_in(src),
+                                                  &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 #ifdef TARGET_SPARC64
 int64_t helper_fstox(CPUSPARCState *env, float32 src)
 {
-    return float32_to_int64_round_to_zero(src, &env->fp_status);
+    int64_t ret = float32_to_int64_round_to_zero(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 int64_t helper_fdtox(CPUSPARCState *env, float64 src)
 {
-    return float64_to_int64_round_to_zero(src, &env->fp_status);
+    int64_t ret = float64_to_int64_round_to_zero(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 int64_t helper_fqtox(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_int64_round_to_zero(f128_in(src), &env->fp_status);
+    int64_t ret = float128_to_int64_round_to_zero(f128_in(src),
+                                                  &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 #endif
 
 float32 helper_fsqrts(CPUSPARCState *env, float32 src)
 {
-    return float32_sqrt(src, &env->fp_status);
+    float32 ret = float32_sqrt(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 float64 helper_fsqrtd(CPUSPARCState *env, float64 src)
 {
-    return float64_sqrt(src, &env->fp_status);
+    float64 ret = float64_sqrt(src, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
 }
 
 Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
 {
-    return f128_ret(float128_sqrt(f128_in(src), &env->fp_status));
+    float128 ret = float128_sqrt(f128_in(src), &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return f128_ret(ret);
 }
 
 #define GEN_FCMP(name, size, FS, E)                                     \
@@ -261,7 +364,8 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
             ret = glue(size, _compare_quiet)(reg1, reg2,                \
                                              &env->fp_status);          \
         }                                                               \
-        fsr = do_check_ieee_exceptions(env, GETPC());                   \
+        check_ieee_exceptions(env, GETPC());                            \
+        fsr = env->fsr;                                                 \
         switch (ret) {                                                  \
         case float_relation_unordered:                                  \
             fsr |= (FSR_FCC1 | FSR_FCC0) << FS;                         \
@@ -292,7 +396,8 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
             ret = glue(size, _compare_quiet)(src1, src2,                \
                                              &env->fp_status);          \
         }                                                               \
-        fsr = do_check_ieee_exceptions(env, GETPC());                   \
+        check_ieee_exceptions(env, GETPC());                            \
+        fsr = env->fsr;                                                 \
         switch (ret) {                                                  \
         case float_relation_unordered:                                  \
             fsr |= (FSR_FCC1 | FSR_FCC0) << FS;                         \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 11d025f4ea..8787cb3bfe 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4526,7 +4526,6 @@ static bool do_env_ff(DisasContext *dc, arg_r_r *a,
 
     tmp = gen_load_fpr_F(dc, a->rs);
     func(tmp, tcg_env, tmp);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, tmp);
     return advance_pc(dc);
 }
@@ -4548,7 +4547,6 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
     dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4591,7 +4589,6 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
     dst = gen_dest_fpr_D(dc, a->rd);
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4613,7 +4610,6 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
     dst = gen_dest_fpr_D(dc, a->rd);
     src = gen_load_fpr_F(dc, a->rs);
     func(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4659,7 +4655,6 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 
     t = gen_load_fpr_Q(dc, a->rs);
     func(t, tcg_env, t);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
@@ -4682,7 +4677,6 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
     src = gen_load_fpr_Q(dc, a->rs);
     dst = tcg_temp_new_i32();
     func(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4706,7 +4700,6 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     src = gen_load_fpr_Q(dc, a->rs);
     dst = gen_dest_fpr_D(dc, a->rd);
     func(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4727,7 +4720,6 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_F(dc, a->rs);
     dst = tcg_temp_new_i128();
     func(dst, tcg_env, src);
@@ -4751,7 +4743,6 @@ static bool do_env_qd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_D(dc, a->rs);
     dst = tcg_temp_new_i128();
     func(dst, tcg_env, src);
@@ -4803,7 +4794,6 @@ static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     func(src1, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, src1);
     return advance_pc(dc);
 }
@@ -4898,7 +4888,6 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4924,7 +4913,6 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     gen_helper_fsmuld(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -4964,7 +4952,6 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
     src1 = gen_load_fpr_Q(dc, a->rs1);
     src2 = gen_load_fpr_Q(dc, a->rs2);
     func(src1, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_Q(dc, a->rd, src1);
     return advance_pc(dc);
 }
@@ -4990,7 +4977,6 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
     src2 = gen_load_fpr_D(dc, a->rs2);
     dst = tcg_temp_new_i128();
     gen_helper_fdmulq(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_Q(dc, a->rd, dst);
     return advance_pc(dc);
 }
-- 
2.34.1


