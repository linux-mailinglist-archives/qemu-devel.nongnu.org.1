Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E49DB5F3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Nov 2024 11:47:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0f-0002xU-5E; Thu, 28 Nov 2024 05:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbza-00022g-5j
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzU-0000Ts-Ma
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:25 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-382378f359dso519809f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790599; x=1733395399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7qNHcv2xsM6B0IoBDGG37yuVzj27RgfOCxf0ou+qD0=;
 b=LMIPGlVdDWoFBG6QZMacsGQdlb42uojfU+Eizt+z0ffF5jC5sa1e6OZNAFRFyTjta7
 bVE1eLJckYdHPEFfd5yO9LAtChbkXLp3g7N9WUypeL4D5Xl0iTA7Hw0XOCGWijogSg3a
 nK8Ry6x8EcLOcOgjtqsjmPGOg9HAgf9PGa7trkNijiv5k3B8rVazK7kqqioAXR6O7O4C
 0n65dKaOyN44uZRakTkihcGrDef7sQvPUtRcuNf+bYuAFpbb2jUDQb+WrHGpGlmbLCP1
 KLvv/J/xJitKpUr2hwRZii+wHf665dh79ItiWf1VIccq3CBME0fUtszENfcR4TUoeLWA
 ZxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790599; x=1733395399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7qNHcv2xsM6B0IoBDGG37yuVzj27RgfOCxf0ou+qD0=;
 b=s8sEkwBZvBfyZr6slD9jz3CCQPtbB90jE9wVstawQziDGIiyD7NNdpYQIWrrSqBpur
 VbtWEN5RA1ywj1yV1nJ30di4DNDIFBO7WG+atocCukkcmkZt2+LQYdC/WgmWIoo6MMpe
 S2mSY3WWxz/ATz6aTeOcmfaeP2TmqXtNjfFfi3BQoqbAlEvvq/ic9GZaHXHZDm0ghYvV
 be3mhEg0t5hllafLg8wVZ2ndbniGYsIbI1IZyR7OKvTXSdnMrhZ+nQ9pYmfbQn1YF79P
 zLtS5ZwekVFZ3Ht5/Y8ozt+kKNbHPSLjsGwU6w0bqEMrwAqNGi01jsB1gQO56SsWGnZG
 hftg==
X-Gm-Message-State: AOJu0YxgRflVtZeT6cle/3POebfS8ulYdECqhQKASsVOQi+x9X91Iyef
 oF0un0wJbJ3mCbqtUWiwthIjzeqd+YwlBMkLA4FkhVIVweAbvvRRfQ+YrIB9i3aLVdU1l/BO3T3
 Z
X-Gm-Gg: ASbGncu6g73QcqNR+WBxyc0welQO3TA9MRfaLSkiGycr6+zOaCTf6dPywhCEA11Z7lK
 27HNeZ9pcG/oG+ivNbCdg8xOwC2Y2l9kTina0X8I8NsmirPC0BpiE5QsWdrydbJTZvpLKgGroKS
 rsXbsSxrbuuoiZNlu6ZXiLb5/lJZZpVMVaA7Hyxd6VUEYlTDqEd8rMBaw6ErbQwISzD/1k4xMJs
 fQiBjQBJYxMrFKLYEIEzYjPIGh9w4n9myXCVVYHeySqB3y+OyUaJV0=
X-Google-Smtp-Source: AGHT+IHySTOT4575kp/JGABI+mh2igzLQZ8XO2gvE//i7mGU/JyqYH/xnk9v4vZ460bseG5dsGZH0g==
X-Received: by 2002:a5d:64e7:0:b0:382:49b7:cbc0 with SMTP id
 ffacd0b85a97d-385c6edc520mr5316469f8f.52.1732790599203; 
 Thu, 28 Nov 2024 02:43:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 07/25] target/ppc: Set FloatInfZeroNaNRule explicitly
Date: Thu, 28 Nov 2024 10:42:52 +0000
Message-Id: <20241128104310.3452934-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Set the FloatInfZeroNaNRule explicitly for the PPC target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/ppc/cpu_init.c          | 7 +++++++
 fpu/softfloat-specialize.c.inc | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c25..f18908a643a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7270,6 +7270,13 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
+    /*
+     * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
+     * to return an input NaN if we have one (ie c) rather than generating
+     * a default NaN
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->vec_status);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index db914ddbb1c..2023b2bd632 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -503,18 +503,13 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
              */
             rule = float_infzeronan_dnan_never;
         }
-#elif defined(TARGET_PPC) || defined(TARGET_SPARC) || \
+#elif defined(TARGET_SPARC) || \
     defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
          */
-        /*
-         * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
-         * to return an input NaN if we have one (ie c) rather than generating
-         * a default NaN
-         */
         rule = float_infzeronan_dnan_never;
 #endif
     }
-- 
2.34.1


