Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5EC7D3EBA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRJ-00061e-G0; Mon, 23 Oct 2023 14:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRA-0005g0-Kl
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:00 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR7-0008H7-OT
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:00 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5840fe01176so2283012eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084836; x=1698689636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+3c/q3YHMTCq7WXcy5yo10z7tmQCbWln7ShYoiyjhk=;
 b=IZjoJGwIRbcZYnoSriIOCMXL/4gz+pt+htEaHjH5/EQo547t4i0vdtbceSj2KYTV+h
 i++8x904Qo3ArOP8zhJLSxjeULtqWNuE7ajrP/ZzSi711i3bflcwmzEU42gj+77mEDBK
 SMonMEXN207HQtRvdbdVtsfta0bp7IF38vh9xO7bp/g0lO3KeSKne62m+guF36beTk72
 NSdqjlo3fH7/IY2aUJwQXxvEOZY0d0ITLaBA3N+k0umkCluCBmV5K/AK4tboU48rHLEu
 lfhjIzN+80DBAU7Zc9JaYGqiUoA9IQ7mIU9swr3TIGXS6kqbH4bghKo1loqm0yIdHt/F
 M6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084836; x=1698689636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+3c/q3YHMTCq7WXcy5yo10z7tmQCbWln7ShYoiyjhk=;
 b=QlqECqXRprfc8pbK1an8Wx5bLp8Dg3q7sc9tfG0ptUWeolVd4Z3aCG77kcUVb+WPOO
 uZftTlwjZVkye0VnpWFxpsgoz62tAMcpxbTFiN66OfRsiA+e6JoAzJRSGaRmkgzWU00e
 OwQJAkDorQLHMBYIQoJA1xbyit6i4y4DmtFMAw8AmZCK7zQlO3L4A848DcukM89hg5Xv
 Of8qMdNyO/6PxCf/F07OqDPU34eyfO9s0EUKNWS0HDDKsWfF/QB/XsV/ADIJpHWC+Ol1
 UfstV9RjtKdCHf3pGSQlx8+4ZfqH6qV3+wMwf9/2ZvFxjcI2LenPm1Ite9ZyAhMjmIIT
 DqaA==
X-Gm-Message-State: AOJu0Yy9bRgRfG6I3ok9hUzZIrl6Nclmu8edKUmtn2SMi/T+E9/qlTgG
 KXzxP7sPWnelGMObDlINHW8kWvpVdTX/AJo5WdA=
X-Google-Smtp-Source: AGHT+IGZGsesex72tWOxHZmSLV1vK6zxZWHSCRoLZQnljIhS0SqGHGG1WqwiXm7X/encjabcc94PsQ==
X-Received: by 2002:a05:6358:5bc8:b0:168:e469:7530 with SMTP id
 i8-20020a0563585bc800b00168e4697530mr2610905rwf.32.1698084835820; 
 Mon, 23 Oct 2023 11:13:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 28/38] tcg: Add tcg_gen_{ld,st}_i128
Date: Mon, 23 Oct 2023 11:13:19 -0700
Message-Id: <20231023181329.171490-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Do not require the translators to jump through concat and
extract of i64 in order to move values to and from env.

Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  3 +++
 tcg/tcg-op.c                | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2048f92b5e..56d4e9cb9f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -747,6 +747,9 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
 void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
+void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
+void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
+
 static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
 {
     tcg_gen_deposit_i64(ret, lo, hi, 32, 32);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c29355b67b..b4dbb2f2ba 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2880,6 +2880,28 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src)
     }
 }
 
+void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset)
+{
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset);
+        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset + 8);
+    } else {
+        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset);
+        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset + 8);
+    }
+}
+
+void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset)
+{
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset);
+        tcg_gen_st_i64(TCGV128_LOW(val), base, offset + 8);
+    } else {
+        tcg_gen_st_i64(TCGV128_LOW(val), base, offset);
+        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset + 8);
+    }
+}
+
 /* QEMU specific operations.  */
 
 void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
-- 
2.34.1


