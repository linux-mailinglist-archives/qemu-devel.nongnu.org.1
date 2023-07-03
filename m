Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1539F7459EA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:14:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRd-00032L-BD; Mon, 03 Jul 2023 06:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRP-0002nt-Ew
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRG-0005is-9J
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31438512cafso678684f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378728; x=1690970728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOF0YX3biOvYXBmYgvIyMISz7K/doCgseRX4BopoSYk=;
 b=juAHJCUSKfGNDMLivyUwpPwwjWQ0IdQKBQIFUIloUmLcPcM7lKpA6ZAqZ0tmmkVFyj
 Lu7crKgK2zcimU68DXrW6nFQASGzN8Kg7+JFohDkLnlquMxSRTUXda47SaBlXzg/AJCU
 giL77OoMG0nq1SQD4ooHI8GYRgT7soyuUlfbaCvviJAFSZ+vJ4faUGlIR+/jCaLNFa5h
 Ondb7rV0i0LxR+lO+XR6kBUztc5eqFtZtZMSYMbhvkNR9pYZdNmhQMlBMvJ13kaOCRjG
 /lPCIldL9gce0196hyecJ7xvzP7vpJQMu4YWrqxcGC1rnZnqhB0o3w2fihsJqOJpwoGU
 WFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378728; x=1690970728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOF0YX3biOvYXBmYgvIyMISz7K/doCgseRX4BopoSYk=;
 b=lFkhbEv4xWLBbwHCnyqStcWAtUC6baNZ6ZTllaNz9CnsySZkCm8SnrcidWvsH2dbdK
 sKo0RyiEqdACWUPSexytNbAUFYe6KEvwZ+p0wUfV9Z0TMXurYeyUKcFkP6sssLVIt5Gq
 F82LebpWMYUgM0x2ydccIwyW9ZmUgyC/pT13xUfHu2W/hakRyPDmLItcZMB939y5rHF/
 t62baqH+nJkTD9gbtcv8q8HmnnYMb+57ZwvPb3nUwuvJvjFw9LCNwZWKItJmMPvwwpcH
 PrmLltGMzCjqsCTFPNKgWF36p2f4b3a9obIbFt2kAgovRaG+UcklnZF3forF990uQTBw
 o1+Q==
X-Gm-Message-State: ABy/qLYStnfL5OvH+cCU9sqlTcpnJ+S+wsc4FYaFIUvHuKcSRqopsOWa
 Cse7teN0FCtIJ8sMlx9c0V42KO3pb5yQ1ji8H1eiYA==
X-Google-Smtp-Source: APBJJlGQk5LJjMjT2APrPLV9LHcdpv4XKBp4lvmyJmpJTKId68h3kB/jmLBUyF25RR88xkKzPqazqA==
X-Received: by 2002:a5d:534d:0:b0:314:1fdc:796d with SMTP id
 t13-20020a5d534d000000b003141fdc796dmr7569578wrv.70.1688378728596; 
 Mon, 03 Jul 2023 03:05:28 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 06/37] crypto: Add aesdec_ISB_ISR_AK
Date: Mon,  3 Jul 2023 12:04:49 +0200
Message-Id: <20230703100520.68224-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

Add a primitive for InvSubBytes + InvShiftRows + AddRoundKey.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  4 ++
 include/crypto/aes-round.h                   | 21 +++++++++
 crypto/aes.c                                 | 45 ++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index c5d8066179..c9b9d732f0 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -13,4 +13,8 @@ void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
+void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
+                             const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
 #endif /* GENERIC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index b85db1a30e..dcf098b97b 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -41,4 +41,25 @@ static inline void aesenc_SB_SR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey.
+ */
+
+void aesdec_ISB_ISR_AK_gen(AESState *ret, const AESState *st,
+                           const AESState *rk);
+void aesdec_ISB_ISR_AK_genrev(AESState *ret, const AESState *st,
+                              const AESState *rk);
+
+static inline void aesdec_ISB_ISR_AK(AESState *r, const AESState *st,
+                                     const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_AK_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_AK_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_AK_genrev(r, st, rk);
+    }
+}
+
 #endif /* CRYPTO_AES_ROUND_H */
diff --git a/crypto/aes.c b/crypto/aes.c
index 408d92b81f..90274c3706 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1261,6 +1261,51 @@ void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesenc_SB_SR_AK_swap(r, s, k, true);
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey.
+ */
+static inline void
+aesdec_ISB_ISR_AK_swap(AESState *ret, const AESState *st,
+                       const AESState *rk, bool swap)
+{
+    const int swap_b = swap ? 15 : 0;
+    AESState t;
+
+    t.b[swap_b ^ 0x0] = AES_isbox[st->b[swap_b ^ AES_ISH(0x0)]];
+    t.b[swap_b ^ 0x1] = AES_isbox[st->b[swap_b ^ AES_ISH(0x1)]];
+    t.b[swap_b ^ 0x2] = AES_isbox[st->b[swap_b ^ AES_ISH(0x2)]];
+    t.b[swap_b ^ 0x3] = AES_isbox[st->b[swap_b ^ AES_ISH(0x3)]];
+    t.b[swap_b ^ 0x4] = AES_isbox[st->b[swap_b ^ AES_ISH(0x4)]];
+    t.b[swap_b ^ 0x5] = AES_isbox[st->b[swap_b ^ AES_ISH(0x5)]];
+    t.b[swap_b ^ 0x6] = AES_isbox[st->b[swap_b ^ AES_ISH(0x6)]];
+    t.b[swap_b ^ 0x7] = AES_isbox[st->b[swap_b ^ AES_ISH(0x7)]];
+    t.b[swap_b ^ 0x8] = AES_isbox[st->b[swap_b ^ AES_ISH(0x8)]];
+    t.b[swap_b ^ 0x9] = AES_isbox[st->b[swap_b ^ AES_ISH(0x9)]];
+    t.b[swap_b ^ 0xa] = AES_isbox[st->b[swap_b ^ AES_ISH(0xA)]];
+    t.b[swap_b ^ 0xb] = AES_isbox[st->b[swap_b ^ AES_ISH(0xB)]];
+    t.b[swap_b ^ 0xc] = AES_isbox[st->b[swap_b ^ AES_ISH(0xC)]];
+    t.b[swap_b ^ 0xd] = AES_isbox[st->b[swap_b ^ AES_ISH(0xD)]];
+    t.b[swap_b ^ 0xe] = AES_isbox[st->b[swap_b ^ AES_ISH(0xE)]];
+    t.b[swap_b ^ 0xf] = AES_isbox[st->b[swap_b ^ AES_ISH(0xF)]];
+
+    /*
+     * Perform the AddRoundKey with generic vectors.
+     * This may be expanded to either host integer or host vector code.
+     * The key and output endianness match, so no bswap required.
+     */
+    ret->v = t.v ^ rk->v;
+}
+
+void aesdec_ISB_ISR_AK_gen(AESState *r, const AESState *s, const AESState *k)
+{
+    aesdec_ISB_ISR_AK_swap(r, s, k, false);
+}
+
+void aesdec_ISB_ISR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
+{
+    aesdec_ISB_ISR_AK_swap(r, s, k, true);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


