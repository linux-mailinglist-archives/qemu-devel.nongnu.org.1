Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86827720D50
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7A-0001FY-Qg; Fri, 02 Jun 2023 22:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6K-0000NL-KD
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:44 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6D-0004k6-W4
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:44 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6af81142b6dso2604546a34.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759675; x=1688351675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko4mUpXNJpSKRU+jwfwgaI1zE5ZSDmdfftH6D/6Zwyw=;
 b=OYA2c8b9a6S6deJOFUjfiguCyVeRey68yFzwwLgZL7WvscUnp9+3jXWdHbuob0dCVz
 qb3ySFT+oHI7vJx9YJ0iaQ/JJJoSFqpUMDULAoxp4aLAD+QwmIuoN/Quc5lt9FyG7yyO
 piG8L72y5lrwmIvyOf/53WpKP/eF+rgfBCz5WECWlvIgWUWk2pc+Wbw3QSMVVnKlE75S
 XYnO2VeiLVE6VxY4x9IGpMPWOWV5cs7+YVPANMpqMW4oTB6jbChH3XfvEmPVtDXvNPIp
 sVUla6CbwEgqEmgBl2oXFitw0fRoOSLi2rBF+LNj/TKrd76yWiHNE2Qsmmpg3/6ExMrt
 wriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759675; x=1688351675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ko4mUpXNJpSKRU+jwfwgaI1zE5ZSDmdfftH6D/6Zwyw=;
 b=YneL+vzsaNE8UjX2bY1H4rvIYRj8QbH0n4YKz6ix/dKOMgTmpWZzv4BuGVFsYJPeMo
 6Hvp06mLFZpHkG91Fm0k9tySFLDbIttLfEa3qlWacxnZ3FaBYlbwWwP99qk2BEKMfRmH
 tI319gAY/aKL3uLLdatIKK7WEpUGLNmRA5o1uSnl9NPvkIQeEdSwnsw+9hD68wEOsCaN
 AdnGUc9O3IpTkYE/uTvtZB25L6oTeUAJ/UFzIoG2Xwzns/a2NjaTf+W5bDnATbl9XfWG
 xd7FWlcnPyzPgVM0a8vApFLAd0cKAw2PGbxujXIw/qtUcN4glNLwkVntSpzv23LhxP6Q
 hI5g==
X-Gm-Message-State: AC+VfDzx6saPZwU6hpnlTInMV57BCj1YgZvoBheXyAPAeb1xljyxAgWt
 GbEjimeoBnnw39F8w0Y61pZorP6DQY/iHbtZlNs=
X-Google-Smtp-Source: ACHHUZ7rxacPrGgIJ7EVTab9VZp6/Kaln+0jswm7mz4gTlXLfT2yFfyNbIe743+2G6LzWHGxa+YCzA==
X-Received: by 2002:a05:6358:591a:b0:123:39c6:3168 with SMTP id
 g26-20020a056358591a00b0012339c63168mr16556626rwf.24.1685759675003; 
 Fri, 02 Jun 2023 19:34:35 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 08/35] target/ppc: Use aesenc_SB_SR
Date: Fri,  2 Jun 2023 19:33:59 -0700
Message-Id: <20230603023426.1064431-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the VCIPHERLAST instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d97a7f1f28..b49e17685b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -2947,13 +2948,13 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
+    AESState t;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_sbox[a->VsrB(AES_shifts[i])]);
-    }
-    *r = result;
+    aesenc_SB_SR(&t, st, true);
+    ad->v = t.v ^ rk->v;
 }
 
 void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


