Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E03786177
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRf-0005d7-RE; Wed, 23 Aug 2023 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRb-0005Iq-GS
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:11 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRZ-0006D0-SA
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a41035828so2957687b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822428; x=1693427228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HBG3IHysiQqVx1ZdBpPpSQGBsf741KNQQ+W/h6ROz4=;
 b=YMhCEAgWxT/JDtaZydB0+N6BMFszdh+cieQIY8rned3dSUrCquj/+G3aXdK0hGuvVj
 tHN58j7Oz7lJQdzbwAQwZvm3dAd8MLuRHdoHzJQKPJv7KF406JR3EHGleg9Iet4dpWX7
 yiyODdj7AtSuGvTGiPwOwar6ANkzduEpg4flXb6eKDYHepYj8hb0kqUUR1Y50PKzH7ln
 sdrxG0G3Ax0v/x6ZmC9g+QNQHY2n5FyteQvQC1klt2BncEIlg3tG26B0XIlCUsbPX3dC
 HJ9+XLF5e5XI++NENlkaVrBmZRc//DLNiR9OYqqRUKOzW2KdXAo5bzUY4uHs+Y4WfaUm
 10VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822428; x=1693427228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HBG3IHysiQqVx1ZdBpPpSQGBsf741KNQQ+W/h6ROz4=;
 b=cjHB1257V2PJfTqQ6wv4k8fUb+cJZ41uEMDS9lk2+IMKkIOkBwOVZ/7o3IISBpJTxe
 Q6x73VhhnXIywPePUqtCHx+uqMNILqf/rlNT53JNQ4slZ9AXrzYUBJMVaQVTpA4gSIEW
 mK+uge1Zpqx253Z9wcK888Ma8UstLnN4BK5fB7Wvnp60UrNnnPZV76LLGJ1grD6dIogc
 bc8IrcK611L/QaIOpg7DxwBfFogqR0yYEmSsooUkVm3Yls/gFIU9Tsjl2MwJut9DA7Es
 xVUkT98YUm4239hMFpZLdnTA00Vvdk4gmOeOINnI7IVfEEyjmufjwTZ/pNuJxq4hEm9s
 W0bA==
X-Gm-Message-State: AOJu0YzR8PTVRytA9s/KRY2E+xCRE8HSZwJUjTwqRWg9T3ok7g9Euf+4
 3fLWwYnTTqhUbWH2JbaK3JiQ5VrTNq5wikehWaU=
X-Google-Smtp-Source: AGHT+IFb/9aEfwKXo03sCi8+X3ew/ZyrKBDf4Fr7Jj9WbxK+PeVi2EH9r+NPj1E1H5kPJJ0qPayTHA==
X-Received: by 2002:a05:6a00:2303:b0:687:472f:5150 with SMTP id
 h3-20020a056a00230300b00687472f5150mr12409453pfh.8.1692822428408; 
 Wed, 23 Aug 2023 13:27:08 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/48] tcg/tcg-op: Document hswap_i32/64() byte pattern
Date: Wed, 23 Aug 2023 13:23:22 -0700
Message-Id: <20230823202326.1353645-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Document hswap_i32() and hswap_i64(), added in commit
46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823145542.79633-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 22c682c28e..58572526b7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1108,6 +1108,11 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/*
+ * hswap_i32: Swap 16-bit halfwords within a 32-bit value.
+ *
+ * Byte pattern: abcd -> cdab
+ */
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     /* Swapping 2 16-bit elements is a rotate. */
@@ -1921,19 +1926,25 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+/*
+ * hswap_i64: Swap 16-bit halfwords within a 64-bit value.
+ * See also include/qemu/bitops.h, hswap64.
+ *
+ * Byte pattern: abcdefgh -> ghefcdab
+ */
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     uint64_t m = 0x0000ffff0000ffffull;
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
     TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-    /* See include/qemu/bitops.h, hswap64. */
-    tcg_gen_rotli_i64(t1, arg, 32);
-    tcg_gen_andi_i64(t0, t1, m);
-    tcg_gen_shli_i64(t0, t0, 16);
-    tcg_gen_shri_i64(t1, t1, 16);
-    tcg_gen_andi_i64(t1, t1, m);
-    tcg_gen_or_i64(ret, t0, t1);
+                                        /* arg = abcdefgh */
+    tcg_gen_rotli_i64(t1, arg, 32);     /*  t1 = efghabcd */
+    tcg_gen_andi_i64(t0, t1, m);        /*  t0 = ..gh..cd */
+    tcg_gen_shli_i64(t0, t0, 16);       /*  t0 = gh..cd.. */
+    tcg_gen_shri_i64(t1, t1, 16);       /*  t1 = ..efghab */
+    tcg_gen_andi_i64(t1, t1, m);        /*  t1 = ..ef..ab */
+    tcg_gen_or_i64(ret, t0, t1);        /* ret = ghefcdab */
 
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
-- 
2.34.1


