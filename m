Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A9720D60
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7c-0002BG-LS; Fri, 02 Jun 2023 22:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6S-0000VO-QP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:52 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6H-0004gg-Ra
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-25692ff86cdso2203826a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759681; x=1688351681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zW8uKUqyby77vFb+kcmc/9SNvfH+fH4gy1v+d8423No=;
 b=Mfu4bVkwE8o3O1EzRKhCM4DJV77q1NQnUX2hGjAQ0ud0mCAJ3sZv21DZHwSMHgXcZr
 MPdb/xNsF3zOKwaOmoTB8RK/nm4uyI3G83s1HAu3qWBUgClRbKsc/Cu049UslI8JlOvv
 by0LBWfwjt/7RW2xEY+T5ndMMhGq23lbLwErsY328wpDv5BejTykWs7wQyNoh7GaWA76
 qNFqhGTNbMBdZtUPvmsQCtvMoYiuh2rapfalbWJYKFNrtKJ/TT/6vroQTQzq0evd9DLH
 ApwZfg+rJi1JB5CSflWXlsn2XDjvNrlgw6SRHRBhdUBS9huWUpeLacIS3LK4BqyGO+XF
 Xvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759681; x=1688351681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zW8uKUqyby77vFb+kcmc/9SNvfH+fH4gy1v+d8423No=;
 b=BrcaLDqQftQk+qVC3uCXYC7VqNgTWLJAyVqmNjBOtUe3BG06LZM/MW4D64DOQ2AC6L
 ZdFQswFWg206B+ohIU41AFTDbjfTmBuN0m/sKIOmX7siLfDIbk6gwfLz1T/0KEOnit9c
 +fKZw2R1nIFFf5CMmFReE5ay/cPBKaAmFR0fwxOB57dSeZ/QlyqrBl4vQI2LmDwcYxhz
 7G9FVTEcTK/8dtgcAdlXrEaUfgHzvn1hTVvaCfbE/VstOHgePd2eWkyeriU/cGHqzeBd
 fZLTP6eYszNWM/jb4wmZMDI28J3PviqYgDkzT1FoTf9xrgCMuGz7PGWvX8IfkORrVjWE
 c+jg==
X-Gm-Message-State: AC+VfDyuLnxJi2FHnT9TW5rc1/rjilx2seHhGNWGXQ7EfUCd2458PAlk
 ZP//Uj5Yda2gV0UV/Knm0mvBGwNcA2M7zRljrtw=
X-Google-Smtp-Source: ACHHUZ7npLDvlgzvppv7P0fTxBlcwkgr6etFZLUsib88WVteHTf2YAJKHGMUkf2JWUTFs6+07Uakig==
X-Received: by 2002:a17:90a:aa0c:b0:256:468b:fb50 with SMTP id
 k12-20020a17090aaa0c00b00256468bfb50mr1599783pjq.47.1685759680791; 
 Fri, 02 Jun 2023 19:34:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 15/35] crypto: Add aesenc_MC
Date: Fri,  2 Jun 2023 19:34:06 -0700
Message-Id: <20230603023426.1064431-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Add a primitive for MixColumns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/aes-round.h |  3 ++
 include/crypto/aes-round.h            | 18 +++++++++
 crypto/aes.c                          | 58 +++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
index cb4fed61fe..7c48db24b6 100644
--- a/host/include/generic/host/aes-round.h
+++ b/host/include/generic/host/aes-round.h
@@ -9,6 +9,9 @@
 #define HAVE_AES_ACCEL  false
 #define ATTR_AES_ACCEL
 
+void aesenc_MC_accel(AESState *, const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
 void aesenc_SB_SR_accel(AESState *, const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index ff1914bd63..f25e9572a3 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -38,6 +38,24 @@ static inline void aesenc_SB_SR(AESState *r, const AESState *st, bool be)
     }
 }
 
+/*
+ * Perform MixColumns.
+ */
+
+void aesenc_MC_gen(AESState *ret, const AESState *st);
+void aesenc_MC_genrev(AESState *ret, const AESState *st);
+
+static inline void aesenc_MC(AESState *r, const AESState *st, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesenc_MC_accel(r, st, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesenc_MC_gen(r, st);
+    } else {
+        aesenc_MC_genrev(r, st);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index 937377647f..c7123eddd5 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -28,6 +28,8 @@
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/bitops.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
 
@@ -1298,6 +1300,62 @@ void aesenc_SB_SR_genrev(AESState *r, const AESState *st)
     aesenc_SB_SR_swap(r, st, true);
 }
 
+/* Perform MixColumns. */
+static inline void
+aesenc_MC_swap(AESState *r, const AESState *st, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0x0]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x1]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x2]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x3]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 0] = t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0x4]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x5]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x6]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x7]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 1] = t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0x8]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x9]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xA]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xB]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 2] = t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0xC]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xD]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xE]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xF]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 3] = t;
+}
+
+void aesenc_MC_gen(AESState *r, const AESState *st)
+{
+    aesenc_MC_swap(r, st, false);
+}
+
+void aesenc_MC_genrev(AESState *r, const AESState *st)
+{
+    aesenc_MC_swap(r, st, true);
+}
+
 /* Perform InvSubBytes + InvShiftRows. */
 static inline void
 aesdec_ISB_ISR_swap(AESState *r, const AESState *st, bool swap)
-- 
2.34.1


